/************************************************************************
Lab 9 Nios Software

Dong Kai Wang, Fall 2017
Christine Chen, Fall 2013

For use with ECE 385 Experiment 9
University of Illinois ECE Department
************************************************************************/

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include "aes.h"

// User-defined Constants
#define MASK 0x000000FF
#define BITS_IN_A_WORD 32
#define ROUND_COUNT 10
#define BITS_IN_A_BYTE 8
#define BYTE_SHIFT 8
#define BYTES_IN_A_WORD 4
#define WORDS_IN_A_KEY 4
#define COL_COUNT 4
#define LIMIT_FOUR 4
#define WSHIFT BITS_IN_A_WORD - BITS_IN_A_BYTE

// User-defined Functions (TODO: CHANGE ORDER)
unsigned int byteSub(unsigned int w);
void stateSub(unsigned int * pos);
void keyAdd(int r, unsigned int * keySched, unsigned int * pos);
void keyExpand(unsigned int * keySched);
void colMix(unsigned char * pos);
void rowShift(unsigned char * pos);
unsigned int wordRotation(unsigned int w);

// Pointer to base address of AES module, make sure it matches Qsys
volatile unsigned int * AES_PTR = (unsigned int *) 0x00000040;

// Execution mode: 0 for testing, 1 for benchmarking
int run_mode = 0;

/** charToHex
 *  Convert a single character to the 4-bit value it represents.
 *  
 *  Input: a character c (e.g. 'A')
 *  Output: converted 4-bit value (e.g. 0xA)
 */
char charToHex(char c)
{
	char hex = c;

	if (hex >= '0' && hex <= '9')
		hex -= '0';
	else if (hex >= 'A' && hex <= 'F')
	{
		hex -= 'A';
		hex += 10;
	}
	else if (hex >= 'a' && hex <= 'f')
	{
		hex -= 'a';
		hex += 10;
	}
	return hex;
}

/** charsToHex
 *  Convert two characters to byte value it represents.
 *  Inputs must be 0-9, A-F, or a-f.
 *  
 *  Input: two characters c1 and c2 (e.g. 'A' and '7')
 *  Output: converted byte value (e.g. 0xA7)
 */
char charsToHex(char c1, char c2)
{
	char hex1 = charToHex(c1);
	char hex2 = charToHex(c2);
	return (hex1 << 4) + hex2;
}

/** encrypt
 *  Perform AES encryption in software.
 *
 *  Input: msg_ascii - Pointer to 32x 8-bit char array that contains the input message in ASCII format
 *         key_ascii - Pointer to 32x 8-bit char array that contains the input key in ASCII format
 *  Output:  msg_enc - Pointer to 4x 32-bit int array that contains the encrypted message
 *               key - Pointer to 4x 32-bit int array that contains the input key
 */
void encrypt(unsigned char * msg_ascii, unsigned char * key_ascii, unsigned int * msg_enc, unsigned int * key) {
	int r, w, i;
	unsigned int x;
	unsigned char t[2];

	for (i = 0; i < LIMIT_FOUR; i++) {
		x = 0x0000;
		x = x | (unsigned char) charsToHex(key_ascii[(BYTE_SHIFT * i) + 6], key_ascii[(BYTE_SHIFT * i) + 7]);
		x <<= BYTE_SHIFT;
		x = x | (unsigned char) charsToHex(key_ascii[(BYTE_SHIFT * i) + 4], key_ascii[(BYTE_SHIFT * i) + 5]);
		x <<= BYTE_SHIFT;
		x = x | (unsigned char) charsToHex(key_ascii[(BYTE_SHIFT * i) + 2], key_ascii[(BYTE_SHIFT * i) + 3]);
		x <<= BYTE_SHIFT;
		x = x | (unsigned char) charsToHex(key_ascii[(BYTE_SHIFT * i) + 0], key_ascii[(BYTE_SHIFT * i) + 1]);
		key[i] = x;
	}

	for (i = 0; i < LIMIT_FOUR; i++) {
		AES_PTR[i] = key[i];
	}

	unsigned int * keySched = malloc(BYTES_IN_A_WORD * WORDS_IN_A_KEY * (ROUND_COUNT + 1));
	memmove((void *) keySched, (void *) key, BYTES_IN_A_WORD * WORDS_IN_A_KEY);
	keyExpand (keySched);

	for (i = 0; i < LIMIT_FOUR; ++i){
		x = 0x0000;
		x = x | (unsigned char) charsToHex(msg_ascii[(BYTE_SHIFT * i) + 6], msg_ascii[(BYTE_SHIFT * i) + 7]);
		x <<= BYTE_SHIFT;
		x = x | (unsigned char) charsToHex(msg_ascii[(BYTE_SHIFT * i) + 4], msg_ascii[(BYTE_SHIFT * i) + 5]);
		x <<= BYTE_SHIFT;
		x = x | (unsigned char) charsToHex(msg_ascii[(BYTE_SHIFT * i) + 2], msg_ascii[(BYTE_SHIFT * i) + 3]);
		x <<= BYTE_SHIFT;
		x = x | (unsigned char) charsToHex(msg_ascii[(BYTE_SHIFT * i) + 0], msg_ascii[(BYTE_SHIFT * i) + 1]);
		msg_enc[i] = x;
	}

	unsigned char * msgBytes = (unsigned char *) msg_enc;
	keyAdd (0, keySched, msg_enc);

	for (r = 1; r < ROUND_COUNT; r++){
		stateSub(msg_enc);
		rowShift((unsigned char *) msg_enc);
		colMix((unsigned char *) msg_enc);
		keyAdd(r, keySched, msg_enc);
	}

	stateSub(msg_enc);
	rowShift((unsigned char *) msg_enc);
	keyAdd(10, keySched, msg_enc);

	for (w = 0; w < LIMIT_FOUR; w++){
		i = 1;
		t[1] = msgBytes[(BYTES_IN_A_WORD * w) + i];
		t[0] = msgBytes[(BYTES_IN_A_WORD * w)];
		msgBytes[(BYTES_IN_A_WORD * w)] = msgBytes[(BYTES_IN_A_WORD * w) + 3];
		msgBytes[(BYTES_IN_A_WORD * w) + i] = msgBytes[(BYTES_IN_A_WORD * w) + 2];
		i++;
		msgBytes[(BYTES_IN_A_WORD * w) + i] = t[1];
		i++;
		msgBytes[(BYTES_IN_A_WORD * w) + i] = t[0];
	}

	free(keySched);
}

unsigned int byteSub(unsigned int w){
	int i;
	unsigned int wLookup, wSub, wShift;
	unsigned char bLookup, bSub;
	wSub = w;
	wShift = (BITS_IN_A_WORD - BITS_IN_A_BYTE);

	for (i = 0; i < BYTES_IN_A_WORD; i++){
		wLookup = wSub & MASK;
		bLookup = (unsigned char) wLookup;
		bSub = aes_sbox[bLookup];
		wSub >>= BITS_IN_A_BYTE;
		wSub = wSub | ((unsigned int) bSub) << (wShift);
	}
	return wSub;
}

void stateSub(unsigned int * pos){
	int i;
	for (i = 0; i < BYTES_IN_A_WORD; i++){
		pos[i] = byteSub(pos[i]);
	}
}

void keyAdd(int r, unsigned int * keySched, unsigned int * pos){
	int keyIdx, i;
	keyIdx = WORDS_IN_A_KEY * r;

	for (i = 0; i < WORDS_IN_A_KEY; i++){
		pos[i] = pos[i] ^ keySched[keyIdx + i];
	}
}

void keyExpand(unsigned int * keySched){
	int keyIdx, keySchedIdx, r, i;
	unsigned int keyExpansion;

	for (r = 1; r < (ROUND_COUNT + 1); r++){
		keyIdx = WORDS_IN_A_KEY * r;
		for (i = 0; i < LIMIT_FOUR; i++){
			i--;
			keyExpansion = keySched[keyIdx + i];
			i++;
			if (i == 0){
				keyExpansion = byteSub(wordRotation(keyExpansion)) ^ Rcon[r];
			}
			keySchedIdx = (keyIdx + i - WORDS_IN_A_KEY);
			keySched[keyIdx + i] = keyExpansion ^ keySched[keySchedIdx];
		}
	}
}

void colMix(unsigned char * pos){
	int currCol, colInitial, i;
	unsigned char byteSet[4];

	for (currCol = 0; currCol < COL_COUNT; currCol++){
		i = 0;
		colInitial = BYTES_IN_A_WORD * currCol;

		for (i = 0; i < LIMIT_FOUR; i++) {
			byteSet[i] = pos[colInitial + i];
		}

		i = 1;
		pos[colInitial] = gf_mul[byteSet[0]][0] ^ gf_mul[byteSet[1]][1] ^ byteSet[2] ^ byteSet[3];
		pos[colInitial + i] = byteSet[0] ^ gf_mul[byteSet[1]][0] ^ gf_mul[byteSet[2]][1] ^ byteSet[3];
		i++;
		pos[colInitial + i] = byteSet[0] ^ byteSet[1] ^ gf_mul[byteSet[2]][0] ^ gf_mul[byteSet[3]][1];
		i++;
		pos[colInitial + i] = gf_mul[byteSet[0]][1] ^ byteSet[1] ^ byteSet[2] ^ gf_mul[byteSet[3]][0];
	}
}

void rowShift(unsigned char * pos){
	int currRow, i;
	unsigned char byteSet[4];

	for (currRow = 1; currRow < BYTES_IN_A_WORD; currRow++){
		byteSet[0] = pos[currRow];
		for (i = 1; i < LIMIT_FOUR; i++) {
			byteSet[i] = pos[(BYTES_IN_A_WORD * i) + currRow];
		}

		switch (currRow) {
			case 1:
				pos[currRow] = byteSet[1];
				pos[BYTES_IN_A_WORD + currRow] = byteSet[2];
				pos[(BYTES_IN_A_WORD * 2) + currRow] = byteSet[3];
				pos[(BYTES_IN_A_WORD * 3) + currRow] = byteSet[0];
			break;
			case 2:
				pos[currRow] = byteSet[2];
				pos[BYTES_IN_A_WORD + currRow] = byteSet[3];
				pos[(BYTES_IN_A_WORD * 2) + currRow] = byteSet[0];
				pos[(BYTES_IN_A_WORD * 3) + currRow] = byteSet[1];
			break;
			case 3:
				pos[currRow] = byteSet[3];
				pos[BYTES_IN_A_WORD + currRow] = byteSet[0];
				pos[(BYTES_IN_A_WORD * 2) + currRow] = byteSet[1];
				pos[(BYTES_IN_A_WORD * 3) + currRow] = byteSet[2];
		}
	}
}

unsigned int wordRotation(unsigned int w){
	unsigned int wShift, rotatedWord;
	wShift = (BITS_IN_A_WORD - BITS_IN_A_BYTE);
	rotatedWord = (w << wShift) | (w >> BITS_IN_A_BYTE);
	return rotatedWord;
}

/** decrypt
 *  Perform AES decryption in hardware.
 *
 *  Input:  msg_enc - Pointer to 4x 32-bit int array that contains the encrypted message
 *              key - Pointer to 4x 32-bit int array that contains the input key
 *  Output: msg_dec - Pointer to 4x 32-bit int array that contains the decrypted message
 */
void decrypt(unsigned int * msg_enc, unsigned int * msg_dec, unsigned int * key)
{
	// Implement this function
	/*
	 * We were unable to implement the decrypt function
	 */

}

/** main
 *  Allows the user to enter the message, key, and select execution mode
 *
 */
int main()
{
	int assign;
	for (assign = 0; assign < 12; assign++) {
		AES_PTR[assign] = 0;	// Sets AES_PTR values to 0
	}

	// Input Message and Key as 32x 8-bit ASCII Characters ([33] is for NULL terminator)
	unsigned char msg_ascii[33];
	unsigned char key_ascii[33];
	// Key, Encrypted Message, and Decrypted Message in 4x 32-bit Format to facilitate Read/Write to Hardware
	unsigned int key[4];
	unsigned int msg_enc[4];
	unsigned int msg_dec[4];

	printf("Select execution mode: 0 for testing, 1 for benchmarking: ");
	scanf("%d", &run_mode);

	if (run_mode == 0) {
		// Continuously Perform Encryption and Decryption
		while (1) {
			int i = 0;
			printf("\nEnter Message:\n");
			scanf("%s", msg_ascii);
			printf("\n");
			printf("\nEnter Key:\n");
			scanf("%s", key_ascii);
			printf("\n");
			encrypt(msg_ascii, key_ascii, msg_enc, key);
			printf("\nEncrpted message is: \n");
			for(i = 0; i < 4; i++){
				printf("%08x", msg_enc[i]);
			}
			printf("\n");
			decrypt(msg_enc, msg_dec, key);
			printf("\nDecrypted message is: \n");
			for(i = 0; i < 4; i++){
				printf("%08x", msg_dec[i]);
			}

			for (i = 0; i < 4; i++) {
				AES_PTR[i] = key[i];
			}

			printf("\n");
		}
	}
	else {
		// Run the Benchmark
		int i = 0;
		int size_KB = 2;
		// Choose a random Plaintext and Key
		for (i = 0; i < 32; i++) {
			msg_ascii[i] = 'a';
			key_ascii[i] = 'b';
		}
		// Run Encryption
		clock_t begin = clock();
		for (i = 0; i < size_KB * 64; i++)
			encrypt(msg_ascii, key_ascii, msg_enc, key);
		clock_t end = clock();
		double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
		double speed = size_KB / time_spent;
		printf("Software Encryption Speed: %f KB/s \n", speed);
		// Run Decryption
		begin = clock();
		for (i = 0; i < size_KB * 64; i++)
			decrypt(msg_enc, msg_dec, key);
		end = clock();
		time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
		speed = size_KB / time_spent;
		printf("Hardware Encryption Speed: %f KB/s \n", speed);
	}
	return 0;
}
