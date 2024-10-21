const std = @import("std");
const g = @cImport(@cInclude("gtk/gtk.h"));

pub fn main() !void {
    const app = g.gtk_application_new("dev.kauemiziara", g.G_APPLICATION_FLAGS_NONE) orelse @panic("null app");
    defer g.g_object_unref(app);

    _ = g.g_signal_connect_data(app, "activate", @as(g.GCallback, @ptrCast(&activate)), null, null, 0);
    _ = g.g_application_run(@ptrCast(app), 0, null);
}

fn activate(app: *g.GtkApplication, data: g.gpointer) callconv(.C) void {
    _ = data;

    const window = g.gtk_application_window_new(app);

    g.gtk_window_set_title(@ptrCast(window), "Caesar Shift");
    g.gtk_window_set_default_size(@ptrCast(window), 800, 600);
    g.gtk_window_present(@ptrCast(window));
}
