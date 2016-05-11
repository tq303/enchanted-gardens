const int LIGHT_COUNT = 8;
const int PIN_OFFSET  = 4;
const int TRANSMIT_ELEMENT_COUNT = 3;

boolean isClear;
boolean isAnimating;

int speed;
int animation;

boolean isRandom;

unsigned char reciever[TRANSMIT_ELEMENT_COUNT];

char aLeftToRight[7][8] = {
	{1,0,0,0,0,0,0},
	{0,1,0,0,0,0,0},
	{0,0,1,0,0,0,0},
	{0,0,0,1,0,0,0},
	{0,0,0,0,1,0,0},
	{0,0,0,0,0,1,0},
	{0,0,0,0,0,0,1}
};

char aRightToLeft[7][8] = {
	{0,0,0,0,0,0,1},
	{0,0,0,0,0,1,0},
	{0,0,0,0,1,0,0},
	{0,0,0,1,0,0,0},
	{0,0,1,0,0,0,0},
	{0,1,0,0,0,0,0},
	{1,0,0,0,0,0,0}
};

char outIn[4][8] = {
	{1,0,0,0,0,0,1},
	{0,1,0,0,0,1,0},
	{0,0,1,0,1,0,0},
	{0,0,0,1,0,0,0},
};

char inOut[4][8] = {
	{0,0,0,1,0,0,0},
	{0,0,1,0,1,0,0},
	{0,1,0,0,0,1,0},
	{1,0,0,0,0,0,1},
};

void setup() {

	isClear = false;
	isAnimating = false;

	speed = 0;
	animation = 0;
	isRandom = false;

	pinMode(4,  OUTPUT);
	pinMode(5,  OUTPUT);
	pinMode(6,  OUTPUT);
	pinMode(7,  OUTPUT);
	pinMode(8,  OUTPUT);
	pinMode(9,  OUTPUT);
	pinMode(10, OUTPUT);
	pinMode(11, OUTPUT);

	Serial.begin(115200);

	clear();
}

void loop() {

	// animate( outIn, ( sizeof(outIn) / sizeof(outIn[0]) ) );
	// animate( aLeftToRight, ( sizeof(aLeftToRight) / sizeof(aLeftToRight[0]) ) );
	// animate( aRightToLeft, ( sizeof(aRightToLeft) / sizeof(aRightToLeft[0]) ) );
	// animate( inOut, ( sizeof(inOut) / sizeof(inOut[0]) ) );
	
	// get data from oF app
    while ( Serial.available() ) {

        Serial.readBytes(reciever, TRANSMIT_ELEMENT_COUNT);

        if ( !isAnimating ) {
	        if ( reciever[0] == 0 && reciever[1] == 1 && reciever[2] == 2 ) {
	        	isAnimating = true;
	        	animate( outIn, ( sizeof(outIn) / sizeof(outIn[0]) ) );
	        	isAnimating = false;
	        }        	
        }
    }
}

/**
 * [ direction, speed, clear ]
 * direction:
 * 		0 = left - right
 * 		1 = right - left
 * 		2 = center out ( moving in effect )
 * 		3 = outer in ( moving out )
 */
void animate( char animation[][8], int length ) {

	isClear = false;

	for ( int i = 0; i < length; i++ ) {
		for ( int j = 0; j < 8; j++ ) {
			
			if ( j == 3 ) {
				// double up pins 3 & 4
				digitalWrite(( j + PIN_OFFSET ),  (animation[i][j] == 1) ? LOW : HIGH);
				digitalWrite(( j + PIN_OFFSET + 1 ),  (animation[i][j] == 1) ? LOW : HIGH);
			} else if ( j > 3 ) {
				// offset by 1
				digitalWrite(( j + PIN_OFFSET + 1 ),  (animation[i][j] == 1) ? LOW : HIGH);
			} else {
				digitalWrite(( j + PIN_OFFSET ),  (animation[i][j] == 1) ? LOW : HIGH);				
			}
			delay(10);
		}
	}
}

void clear() {

	if ( !isClear ) {

		for ( int j = 0; j < 8; j++ ) {
			digitalWrite(( j + PIN_OFFSET ),  HIGH);
		}

		isClear = true;
		speed = 0;
		animation = 0;
		isRandom = false;
	}
}