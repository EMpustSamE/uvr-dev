#pragma once
#include "stdafx.h"
#include <vector>
#if ((defined(_MSVC_LANG) && _MSVC_LANG >= 201703L) || __cplusplus >= 201703L)
#include <optional>
#endif
#include <stdint.h>
#include <cstring>
#include <tuple>
using namespace std;

#define dllg /* tag */

#if defined(WIN32)
#define dllx extern "C" __declspec(dllexport)
#elif defined(GNUC)
#define dllx extern "C" __attribute__ ((visibility("default"))) 
#else
#define dllx extern "C"
#endif

#ifdef _WINDEF_
typedef HWND GAME_HWND;
#endif

struct gml_buffer {
private:
	uint8_t* _data;
	int32_t _size;
	int32_t _tell;
public:
	gml_buffer() : _data(nullptr), _tell(0), _size(0) {}
	gml_buffer(uint8_t* data, int32_t size, int32_t tell) : _data(data), _size(size), _tell(tell) {}

	inline uint8_t* data() { return _data; }
	inline int32_t tell() { return _tell; }
	inline int32_t size() { return _size; }
};

class gml_istream {
	uint8_t* pos;
	uint8_t* start;
public:
	gml_istream(void* origin) : pos((uint8_t*)origin), start((uint8_t*)origin) {}

	template<class T> T read() {
		static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable to be read");
		T result{};
		std::memcpy(&result, pos, sizeof(T));
		pos += sizeof(T);
		return result;
	}

	char* read_string() {
		char* r = (char*)pos;
		while (*pos != 0) pos++;
		pos++;
		return r;
	}

	template<class T> std::vector<T> read_vector() {
		static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable to be read");
		auto n = read<uint32_t>();
		std::vector<T> vec(n);
		std::memcpy(vec.data(), pos, sizeof(T) * n);
		pos += sizeof(T) * n;
		return vec;
	}

	gml_buffer read_gml_buffer() {
		auto _data = (uint8_t*)read<int64_t>();
		auto _size = read<int32_t>();
		auto _tell = read<int32_t>();
		return gml_buffer(_data, _size, _tell);
	}

	#pragma region Tuples
	#if ((defined(_MSVC_LANG) && _MSVC_LANG >= 201703L) || __cplusplus >= 201703L)
	template<typename... Args>
	std::tuple<Args...> read_tuple() {
		std::tuple<Args...> tup;
		std::apply([this](auto&&... arg) {
			((
				arg = this->read<std::remove_reference_t<decltype(arg)>>()
				), ...);
			}, tup);
		return tup;
	}

	template<class T> optional<T> read_optional() {
		if (read<bool>()) {
			return read<T>;
		} else return {};
	}
	#else
	template<class A, class B> std::tuple<A, B> read_tuple() {
		A a = read<A>();
		B b = read<B>();
		return std::tuple<A, B>(a, b);
	}

	template<class A, class B, class C> std::tuple<A, B, C> read_tuple() {
		A a = read<A>();
		B b = read<B>();
		C c = read<C>();
		return std::tuple<A, B, C>(a, b, c);
	}

	template<class A, class B, class C, class D> std::tuple<A, B, C, D> read_tuple() {
		A a = read<A>();
		B b = read<B>();
		C c = read<C>();
		D d = read<d>();
		return std::tuple<A, B, C, D>(a, b, c, d);
	}
	#endif
};

class gml_ostream {
	uint8_t* pos;
	uint8_t* start;
public:
	gml_ostream(void* origin) : pos((uint8_t*)origin), start((uint8_t*)origin) {}

	template<class T> void write(T val) {
		static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable to be write");
		memcpy(pos, &val, sizeof(T));
		pos += sizeof(T);
	}

	void write_string(const char* s) {
		for (int i = 0; s[i] != 0; i++) write<char>(s[i]);
		write<char>(0);
	}

	template<class T> void write_vector(std::vector<T>& vec) {
		static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable to be write");
		auto n = vec.size();
		write<uint32_t>(n);
		memcpy(pos, vec.data(), n * sizeof(T));
		pos += n * sizeof(T);
	}

	#if ((defined(_MSVC_LANG) && _MSVC_LANG >= 201703L) || __cplusplus >= 201703L)
	template<typename... Args>
	void write_tuple(std::tuple<Args...> tup) {
		std::apply([this](auto&&... arg) {
			(this->write(arg), ...);
			}, tup);
	}

	template<class T> void write_optional(optional<T>& val) {
		auto hasValue = val.has_value();
		write<bool>(hasValue);
		if (hasValue) write<T>(val.value());
	}
	#else
	template<class A, class B> void write_tuple(std::tuple<A, B>& tup) {
		write<A>(std::get<0>(tup));
		write<B>(std::get<1>(tup));
	}
	template<class A, class B, class C> void write_tuple(std::tuple<A, B, C>& tup) {
		write<A>(std::get<0>(tup));
		write<B>(std::get<1>(tup));
		write<C>(std::get<2>(tup));
	}
	template<class A, class B, class C, class D> void write_tuple(std::tuple<A, B, C, D>& tup) {
		write<A>(std::get<0>(tup));
		write<B>(std::get<1>(tup));
		write<C>(std::get<2>(tup));
		write<D>(std::get<3>(tup));
	}
	#endif
};
/**
 * @file	HiEasyX.h
 * @brief	HiEasyX 库头文件
 * @note	HiEasyX 是基于 EasyX 的扩展库，支持创建多窗口、透明抗锯齿绘图、系统 UI 组件等等。
 *
 * @version	Ver 0.3.1
 * @envir	VisualStudio 2022 | EasyX_20220901 | Windows 10
 * @site	https://github.com/zouhuidong/HiEasyX
 *
 * @author	huidong
 * @qq		1442701429
 * @email	mailhuid@163.com
 * 
 * @create	2022.07.20
 * @update	2023.01.15
*/

#pragma once

#define __HIEASYX_H__

#include "HiEasyX/HiDef.h"
#include "HiEasyX/HiMacro.h"
#include "HiEasyX/HiFunc.h"
#include "HiEasyX/HiFPS.h"
#include "HiEasyX/HiDrawingProperty.h"
#include "HiEasyX/HiMouseDrag.h"
#include "HiEasyX/HiMusicMCI.h"
#include "HiEasyX/HiGif.h"

// 未选择使用原生 EasyX
#ifndef _NATIVE_EASYX_
#include "HiEasyX/HiWindow.h"
#include "HiEasyX/HiSysGUI/HiSysGUI.h"
#endif /* _NATIVE_EASYX_ */

#include "HiEasyX/HiGdiplus.h"
#include "HiEasyX/HiCanvas.h"
#include "HiEasyX/HiGUI/HiGUI.h"


// HiEasyX 命名空间缩写
namespace hiex = HiEasyX;

// 兼容旧版 EasyWin32 命名空间，请尽量使用 HiEasyX 命名空间
namespace EasyWin32 = HiEasyX;

//{{NO_DEPENDENCIES}}
// Microsoft Visual C++ generated include file.
// Used by MuiltWindow.rc

// Next default values for new objects
// 
#ifdef APSTUDIO_INVOKED
#ifndef APSTUDIO_READONLY_SYMBOLS
#define _APS_NEXT_RESOURCE_VALUE        101
#define _APS_NEXT_COMMAND_VALUE         40001
#define _APS_NEXT_CONTROL_VALUE         1001
#define _APS_NEXT_SYMED_VALUE           101
#endif
#endif
// stdafx.h : include file for standard system include files,
// or project specific include files that are used frequently, but
// are changed infrequently
//

#pragma once

#ifdef _WINDOWS
	#include "targetver.h"
	
	#define WIN32_LEAN_AND_MEAN // Exclude rarely-used stuff from Windows headers
	#include <windows.h>
#endif

#if defined(WIN32)
#define dllx extern "C" __declspec(dllexport)
#elif defined(GNUC)
#define dllx extern "C" __attribute__ ((visibility("default"))) 
#else
#define dllx extern "C"
#endif

#define trace(...) { printf("[MuiltWindow:%d] ", __LINE__); printf(__VA_ARGS__); printf("\n"); fflush(stdout); }

#include "gml_ext.h"

// TODO: reference additional headers your program requires here#pragma once

// Including SDKDDKVer.h defines the highest available Windows platform.

// If you wish to build your application for a previous Windows platform, include WinSDKVer.h and
// set the _WIN32_WINNT macro to the platform you wish to support before including SDKDDKVer.h.

#include <SDKDDKVer.h>
#include "gml_ext.h"
extern int windows_create(const char* title, int windowWidth, int windowHeight);
dllx double windows_create_raw(void* _ptr, const char* _arg_title) {
	gml_istream _in(_ptr);
	int _arg_windowWidth;
	_arg_windowWidth = _in.read<int>();
	int _arg_windowHeight;
	_arg_windowHeight = _in.read<int>();
	return windows_create(_arg_title, _arg_windowWidth, _arg_windowHeight);
}

extern int windows_show(int windowID);
dllx double windows_show_raw(void* _ptr) {
	gml_istream _in(_ptr);
	int _arg_windowID;
	_arg_windowID = _in.read<int>();
	return windows_show(_arg_windowID);
}

extern int windows_get_x(int windowID);
dllx double windows_get_x_raw(void* _ptr) {
	gml_istream _in(_ptr);
	int _arg_windowID;
	_arg_windowID = _in.read<int>();
	return windows_get_x(_arg_windowID);
}

extern int windows_get_y(int windowID);
dllx double windows_get_y_raw(void* _ptr) {
	gml_istream _in(_ptr);
	int _arg_windowID;
	_arg_windowID = _in.read<int>();
	return windows_get_y(_arg_windowID);
}

extern int windows_get_width(int windowID);
dllx double windows_get_width_raw(void* _ptr) {
	gml_istream _in(_ptr);
	int _arg_windowID;
	_arg_windowID = _in.read<int>();
	return windows_get_width(_arg_windowID);
}

extern int windows_get_height(int windowID);
dllx double windows_get_height_raw(void* _ptr) {
	gml_istream _in(_ptr);
	int _arg_windowID;
	_arg_windowID = _in.read<int>();
	return windows_get_height(_arg_windowID);
}

extern int windows_set_pos(int windowID, int x, int y);
dllx double windows_set_pos_raw(void* _ptr) {
	gml_istream _in(_ptr);
	int _arg_windowID;
	_arg_windowID = _in.read<int>();
	int _arg_x;
	_arg_x = _in.read<int>();
	int _arg_y;
	_arg_y = _in.read<int>();
	return windows_set_pos(_arg_windowID, _arg_x, _arg_y);
}

extern int windows_set_size(int windowID, int width, int height);
dllx double windows_set_size_raw(void* _ptr) {
	gml_istream _in(_ptr);
	int _arg_windowID;
	_arg_windowID = _in.read<int>();
	int _arg_width;
	_arg_width = _in.read<int>();
	int _arg_height;
	_arg_height = _in.read<int>();
	return windows_set_size(_arg_windowID, _arg_width, _arg_height);
}

extern int windows_set_surface_raw(int windowID, int _pBuffer, int width, int height, int x, int y);
dllx double windows_set_surface_raw_raw(void* _ptr) {
	gml_istream _in(_ptr);
	int _arg_windowID;
	_arg_windowID = _in.read<int>();
	int _arg__pBuffer;
	_arg__pBuffer = _in.read<int>();
	int _arg_width;
	_arg_width = _in.read<int>();
	int _arg_height;
	_arg_height = _in.read<int>();
	int _arg_x;
	_arg_x = _in.read<int>();
	int _arg_y;
	_arg_y = _in.read<int>();
	return windows_set_surface_raw(_arg_windowID, _arg__pBuffer, _arg_width, _arg_height, _arg_x, _arg_y);
}

extern int windows_returnMain();
dllx double windows_returnMain_raw(void* _ptr) {
	gml_istream _in(_ptr);
	return windows_returnMain();
}

extern int windows_get_screen_width();
dllx double windows_get_screen_width_raw(void* _ptr) {
	gml_istream _in(_ptr);
	return windows_get_screen_width();
}

extern int windows_get_screen_height();
dllx double windows_get_screen_height_raw(void* _ptr) {
	gml_istream _in(_ptr);
	return windows_get_screen_height();
}

// dllmain.cpp : Defines the entry point for the DLL application.
#include "stdafx.h"

BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
					 )
{
	switch (ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
	case DLL_PROCESS_DETACH:
		break;
	}
	return TRUE;
}

/// @author Ceyase

#include "stdafx.h"

#include <string>
#include <vector>
#include <atlstr.h>
#include <wincodec.h>
#include <atlimage.h>
#include <sstream>
#include "HiEasyX.h"

using namespace Gdiplus;
using namespace std;

HINSTANCE hInst;
WNDCLASSA wc;
HRESULT hr;

/////////////////////////////
//
//前置函数区
//
/////////////////////////////

BOOL CALLBACK EnumWindowsProc(HWND hwnd, LPARAM lParam)
{
    DWORD dwCurProcessId = *((DWORD*)lParam);
    DWORD dwProcessId = 0;

    GetWindowThreadProcessId(hwnd, &dwProcessId);
    if (dwProcessId == dwCurProcessId && GetParent(hwnd) == NULL)
    {
        *((HWND*)lParam) = hwnd;
        return FALSE;
    }
    return TRUE;
}


HWND GetMainWindow()
{
    DWORD dwCurrentProcessId = GetCurrentProcessId();
    if (!EnumWindows(EnumWindowsProc, (LPARAM)&dwCurrentProcessId))
    {
        return (HWND)dwCurrentProcessId;
    }
    return NULL;
}

LPCWSTR stringToLPCWSTR(string orig)
{
    size_t origsize = orig.length() + 1;
    const size_t newsize = 100;
    size_t convertedChars = 0;
    wchar_t* wcstring = new wchar_t[sizeof(wchar_t) * (orig.length() - 1)];
    mbstowcs_s(&convertedChars, wcstring, origsize, orig.c_str(), _TRUNCATE);
    return wcstring;
}

LRESULT CALLBACK WndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
    switch (msg)
    {
    case WM_PAINT:
    case WM_USER_REDRAW:
        break;

    case WM_CLOSE:
        DestroyWindow(hWnd);
        break;

    case WM_DESTROY:
        PostQuitMessage(0);
        break;

    default:
        return HIWINDOW_DEFAULT_PROC;
        break;
    }

    return 0;
}
/////////////////////////////
//
//功能区
//
/////////////////////////////
dllg int windows_create(const char* title, int windowWidth, int windowHeight) {
    HWND hwnd = initgraph(windowWidth, windowHeight);
    EnableResizing(hwnd, false);
    hiex::SetWindowTitle(CA2T(title), hwnd);
    hiex::SetWndProcFunc(hwnd,WndProc);
    return (int)hwnd;
}

dllg int windows_show(int windowID) {
    HWND hwnd = (HWND)windowID;
    ShowWindow(hwnd, SW_SHOW);
    return 0;
}

dllg int windows_get_x(int windowID) {
    RECT rect;
    HWND hwnd = (HWND)windowID;
    if (GetWindowRect(hwnd, &rect) == 0) {
        return -1;
    }
    return rect.left;
}

dllg int windows_get_y(int windowID) {
    RECT rect;
    HWND hwnd = (HWND)windowID;
    if (GetWindowRect(hwnd, &rect) == 0) {
        return -1;
    }
    return rect.top;
}

dllg int windows_get_width(int windowID) {
    RECT rect;
    HWND hwnd = (HWND)windowID;
    if (GetWindowRect(hwnd, &rect) == 0) {
        return -1;
    }
    return rect.right - rect.left;
}

dllg int windows_get_height(int windowID) {
    RECT rect;
    HWND hwnd = (HWND)windowID;
    if (GetWindowRect(hwnd, &rect) == 0) {
        return -1;
    }
    return rect.bottom - rect.top;
}

dllg int windows_set_pos(int windowID, int x, int y) {
    RECT rect;
    HWND hwnd = (HWND)windowID;
    if (GetWindowRect(hwnd, &rect) == 0) {
        return -1;
    }
    if (MoveWindow(hwnd, x, y, rect.right - rect.left, rect.bottom - rect.top, TRUE) == 0) {
        return -1;
    }
    return 1;
}

dllg int windows_set_size(int windowID, int width, int height) {
    RECT rect;
    HWND hwnd = (HWND)(int)windowID;
    if (GetWindowRect(hwnd, &rect) == 0) {
        return -1;
    }
    if (MoveWindow(hwnd, rect.left, rect.top, width, height, TRUE) == 0) {
        return -1;
    }
    return 1;
}

dllg int windows_set_surface_raw(int windowID, int _pBuffer, int width, int height, int x, int y) {
    HWND hwnd = (HWND)(int)windowID;
    unsigned char* pBuffer = (unsigned char*)_pBuffer;
    hiex::SetWorkingWindow(hwnd);
    BEGIN_TASK();
    IMAGE img(width, height);
    DWORD* pMem = GetImageBuffer(&img);
    for (int i = 0; i < width * height; i++) {
        pMem[i] = BGR(RGB(pBuffer[i*4], pBuffer[i * 4 +1], pBuffer[i * 4 +2]));
    }
    putimage(x, y, &img);
    END_TASK();
    REDRAW_WINDOW();

    return pBuffer[0];
}

dllg int windows_returnMain() {
    return (int)SetFocus(GetMainWindow());
}

dllg int windows_get_screen_width() {
    HDC hdc = GetDC(NULL); 
    int width = GetDeviceCaps(hdc, HORZRES); 
    ReleaseDC(NULL, hdc);
    return width;
}

dllg int windows_get_screen_height() {
    HDC hdc = GetDC(NULL);
    int height = GetDeviceCaps(hdc, VERTRES);
    ReleaseDC(NULL, hdc);
    return height;
}// stdafx.cpp : source file that includes just the standard includes
// MuiltWindow.pch will be the pre-compiled header
// stdafx.obj will contain the pre-compiled type information

#include "stdafx.h"

// TODO: reference any additional headers you need in STDAFX.H
// and not in this file
