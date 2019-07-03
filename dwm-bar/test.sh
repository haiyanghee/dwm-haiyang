#!/bin/sh
func(){
		sed '40q;d' "$HOME/.local/share/weatherreport"
}
ret=$(func)
echo $ret
