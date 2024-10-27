### core concept
绘图机制基于OpenGL

### 2D图形绘制
	- simpleplot 用于显示2D曲线
		 1. plotter类使用DataLog类来储存数据，其数据结构与pandas中的Series的数据结构类似:
```C++
#include <cmath>

#include <pangolin/display/display.h>
#include <pangolin/plot/plotter.h>
#include <pangolin/display/view.h>
#include <pangolin/handler/handler.h>
#include <pangolin/gl/gldraw.h>

#include "spline.h"
#include "b_spline.hpp"
using namespace Helper;
using namespace pangolin;
int main(/*int argc, char* argv[]*/)
{
	// Create OpenGL window in single line
	pangolin::CreateWindowAndBind("Main",640,480);

	// Data logger object
  	pangolin::DataLog log;

  	// OpenGL 'view' of data. We might have many views of the same data.
  	pangolin::Plotter plotter(&log,-2.0f,2.0f,-2.0f, 2.0f,0.01f,0.01f);
  	plotter.SetBounds(0.0, 1.0, 0.0, 1.0);
	plotter.ClearSeries();
	plotter.AddSeries("$0", "$1", DrawingModeLine, Colour::Green(), "interpolate");
  	pangolin::DisplayBase().AddDisplay(plotter);

	// prepare data to test
    PointList Val;
	Val.push_back({-1.75, -1.0});
	Val.push_back({-1.6, -0.5});
	Val.push_back({-1.5, 0.0});
	Val.push_back({-1.25, 0.5});
	Val.push_back({-0.75, 0.75});
	Val.push_back({0.0, 0.5});
	Val.push_back({0.5, 0.0});
	/*
	Bspline bs;
	PointList result;
	result = bs.interpolate(Val, 0.01);
	*/
	std::vector<double> xVal, yVal;
	for(const auto& point : Val){
		//std::cout << point[0] << '\t' << point[1] << std::endl;
		// log.Log(point[0], point[1]);
		xVal.push_back(point[0]);
		yVal.push_back(point[1]);
	}
    tk::spline s(xVal, yVal);
	for(double x = xVal.front(); x < xVal.back(); x += 0.01){
		log.Log(x, s(x));
	}
	
  	// Default hooks for exiting (Esc) and fullscreen (tab).
  	while(!pangolin::ShouldQuit())
  	{
  	    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

  	    // Render graph, Swap frames and Process Events
		pangolin::FinishFrame();
  	}

  	return 0;
}
	 
```