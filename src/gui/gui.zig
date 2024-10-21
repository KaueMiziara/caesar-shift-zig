const g = @cImport(@cInclude("gtk/gtk.h"));

pub fn activate(app: *g.GtkApplication, data: g.gpointer) callconv(.C) void {
    _ = data;

    create_window(app);
}

fn create_window(app: *g.GtkApplication) void {
    const window = g.gtk_application_window_new(app);

    g.gtk_window_set_title(@ptrCast(window), "Caesar Shift");
    g.gtk_window_set_default_size(@ptrCast(window), 800, 600);
    g.gtk_window_present(@ptrCast(window));
}
