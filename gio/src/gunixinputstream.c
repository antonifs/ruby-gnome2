/* -*- c-file-style: "ruby" -*- */
/*
 * Ruby/GIO: a Ruby binding of gio-2.0.x.
 * Copyright (C) 2008-2009  Ruby-GNOME2 Project Team
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include "gio2.h"

#ifdef HAVE_GIO_UNIX
#include <gio/gunixinputstream.h>

#define _SELF(value) G_UNIX_INPUT_STREAM(RVAL2GOBJ(value))

static VALUE
unixinputstream_initialize(int argc, VALUE *argv, VALUE self)
{
        VALUE fd, close_fd;

        rb_scan_args(argc, argv, "11", &fd, &close_fd);
        G_INITIALIZE(self, g_unix_input_stream_new(RVAL2FD(fd),
                                                   RVAL2CBOOL(close_fd)));

        return Qnil;
}

static VALUE
unixinputstream_set_close_fd(VALUE self, VALUE close_fd)
{
        g_unix_input_stream_set_close_fd(_SELF(self), RVAL2CBOOL(close_fd));

        return self;
}

static VALUE
unixinputstream_get_close_fd(VALUE self)
{
        return CBOOL2RVAL(g_unix_input_stream_get_close_fd(_SELF(self)));
}

static VALUE
unixinputstream_get_fd(VALUE self)
{
        return FD2RVAL(g_unix_input_stream_get_fd(_SELF(self)));
}
#endif

void
Init_gunixinputstream(G_GNUC_UNUSED VALUE glib)
{
#ifdef HAVE_GIO_UNIX
        VALUE unixinputstream = G_DEF_CLASS(G_TYPE_UNIX_INPUT_STREAM, "UnixInputStream", glib);

        rb_define_method(unixinputstream, "initialize", unixinputstream_initialize, -1);
        rb_define_method(unixinputstream, "set_close_fd", unixinputstream_set_close_fd, 1);
        G_DEF_SETTER(unixinputstream, "close_fd");
        rb_define_method(unixinputstream, "close_fd?", unixinputstream_get_close_fd, 0);
        rb_define_method(unixinputstream, "fd", unixinputstream_get_fd, 0);
#endif
}
