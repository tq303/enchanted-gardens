/**
 * Very simple timeout function, inspired by Javascript setTimeout
 */

#include "timeout.h"

//--------------------------------------------------------------
timeout::timeout( void ) {
	_frameInterval = 0;
	_isRunning     = false;
	_startFrame    = 0;
	_hasEllapsed   = false;
}

void timeout::set( int frameInterval ) {
	_frameInterval = frameInterval;
};

void timeout::start() {
	_isRunning = true;
	_startFrame = ofGetFrameNum();
};

bool timeout::hasEllapsed() {

	if ( !_isRunning ) {

		return false;

	} else if ( _hasEllapsed ) {

		_hasEllapsed = false;
		return _hasEllapsed;

	} else {

		if ( ( ofGetFrameNum() - _startFrame ) >= _frameInterval ) {

			_hasEllapsed = true;
			_startFrame  = ofGetFrameNum();

		}
		
		return _hasEllapsed;		
	}
};