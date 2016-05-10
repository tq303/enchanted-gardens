#pragma once

#include "ofMain.h"

class timeout {
	
	public:
		timeout();

		void set(int milliseconds);
	    void start();

		bool hasEllapsed();

	private:
		bool _hasEllapsed,
			 _isRunning;

		int _frameInterval,
			_startFrame;
};