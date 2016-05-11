#include "Format.h"

Format::Format(void) {

    umbrella  = 0;
    speed     = 0;
    animation = 0;
    red       = 0;
    green     = 0;
    blue      = 0;

}

unsigned char* Format::encode() {

    transmitArray[FORMAT_UMBRELLA_POS]  = umbrella;
    transmitArray[FORMAT_ANIMATION_POS] = animation;
    transmitArray[FORMAT_SPEED_POS]     = speed;
    transmitArray[FORMAT_RED_POS]       = red;
    transmitArray[FORMAT_GREEN_POS]     = green;
    transmitArray[FORMAT_BLUE_POS]      = blue;

    return transmitArray;
}

void Format::decode(unsigned char* receiveArray) {
    umbrella  = receiveArray[FORMAT_UMBRELLA_POS];
    animation = receiveArray[FORMAT_ANIMATION_POS];
    speed     = receiveArray[FORMAT_SPEED_POS];
    red       = receiveArray[FORMAT_RED_POS];
    green     = receiveArray[FORMAT_GREEN_POS];
    blue      = receiveArray[FORMAT_BLUE_POS];
}

void Format::setUmbrella(unsigned char _u) {
    umbrella = _u;
}
void Format::setSpeed(unsigned char _s) {
    speed = _s;
}
void Format::setAnimation(unsigned char _a) {
    animation = _a;
}
void Format::setColour(unsigned char _r, unsigned char _g, unsigned char _b) {
    red   = _r;
    green = _g;
    blue  = _b;
}

unsigned char Format::getUmbrella() {
    return umbrella;
}

unsigned char Format::getAnimation() {
    return animation;
}

unsigned char Format::getSpeed() {
    return speed;
}

unsigned char Format::getRed() {
    return red;
}

unsigned char Format::getGreen() {
    return green;
}

unsigned char Format::getBlue() {
    return blue;
}