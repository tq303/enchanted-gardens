const int LIGHT_COUNT = 8;
const int PIN_OFFSET  = 4;

boolean isClear;

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

void setup() {

	isClear = false;

	pinMode(4,  OUTPUT);
	pinMode(5,  OUTPUT);
	pinMode(6,  OUTPUT);
	pinMode(7,  OUTPUT);
	pinMode(8,  OUTPUT);
	pinMode(9,  OUTPUT);
	pinMode(10, OUTPUT);
	pinMode(11, OUTPUT);

	Serial.begin(9600);

	clear();
	// animate( aLeftToRight, ( sizeof(aLeftToRight) / sizeof(aLeftToRight[0]) ) );
}

void loop() {
	// digitalWrite(11, LOW);
	animate( aLeftToRight, ( sizeof(aLeftToRight) / sizeof(aLeftToRight[0]) ) );
	animate( aRightToLeft, ( sizeof(aRightToLeft) / sizeof(aRightToLeft[0]) ) );
	// clear();
}

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
	}
}