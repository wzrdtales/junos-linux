# Junos (Juniper) VPN for GNU/Linux (Debian/Ubuntu...)

This is a helper script to install the commands `junos_start` and `junos_route`
into your System. These are wrappers to establish a connection to a Junos VPN.

The `junos_route` script is a little helper, that helps you if the routes are not
optimal. Most of the time you just want the private network ips to be mapped,
but not the public ones.

The `junos_create` script is a convenience helper, that creates a shortcut
command like `junos_at_home`, which can be used instead of junos_route.

# Examples

To setup an optimal routing via `junos_route` you first need the gateway of
your VPN and of your router. For this first connect to the VPN and call
`ip r` next. You will find them there now. The device you need to enter is the
device which holds the gateway of your router. You might be connected to for
example `eth0` or `wlan0`.

If you want to create a shortcut for one of your connections you're using
regularly, then you need to execute `junos_create`, like in this example:

    junos_create home 10.199.12.98 192.168.0.1 wlan0

This creates a new shortcut `junos_at_home` which you can use from now on.

# Sources

Thanks to the authors of the following articles, which helped me to figure out,
how to run the Junos VPN on linux!

http://makefile.com/.plan/2009/10/juniper-vpn-64-bit-linux-an-unsolved-mystery/

https://github.com/russdill/juniper-vpn-py

# License

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org>
