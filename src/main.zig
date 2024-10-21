const std = @import("std");
const g = @cImport(@cInclude("gtk/gtk.h"));

const ui = @import("gui/gui.zig");

pub fn main() !void {
    const app = g.gtk_application_new("dev.kauemiziara", g.G_APPLICATION_FLAGS_NONE) orelse @panic("null app");
    defer g.g_object_unref(app);

    _ = g.g_signal_connect_data(app, "activate", @as(g.GCallback, @ptrCast(&ui.activate)), null, null, 0);
    _ = g.g_application_run(@ptrCast(app), 0, null);
}
