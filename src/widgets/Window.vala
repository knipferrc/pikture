[GtkTemplate (ui = "/com/github/mistakenelf/pikture/window.ui")]
public class Pikture.Window : Adw.ApplicationWindow {
    [GtkChild] private unowned Adw.Flap adw_flap;
    [GtkChild] private unowned Sidebar sidebar;
    [GtkChild] private unowned Gtk.Button delete_image_button;
    [GtkChild] private unowned Gtk.Button rotate_counterclockwise_button;
    [GtkChild] private unowned Gtk.Button rotate_clockwise_button;
    [GtkChild] private unowned Gtk.Button save_button;
    [GtkChild] private unowned Adw.TabView tab_view;
    [GtkChild] private unowned Adw.TabBar tab_bar;

    private DialogService dialog_service;
    private Viewer viewer;

    public Window (Adw.Application app) {
        Object (
                application: app
        );
    }

    construct {
        this.dialog_service = new DialogService (this);
        this.viewer = new Viewer ();
        this.tab_bar.view = this.tab_view;
        this.connect_signals ();
    }

    public void open (GLib.File file) {
        this.viewer.set_displayed_image (file.get_path ());
        this.sidebar.set_file_details (file);
    }

    private void connect_signals () {
        this.viewer.notify["filename"].connect (() => {
            if (viewer.filename != "") {
                this.adw_flap.set_reveal_flap (true);
                this.delete_image_button.set_visible (true);
                this.rotate_clockwise_button.set_visible (true);
                this.rotate_counterclockwise_button.set_visible (true);
                this.save_button.set_visible (true);
            } else {
                this.adw_flap.set_reveal_flap (false);
                this.delete_image_button.set_visible (false);
                this.rotate_clockwise_button.set_visible (false);
                this.rotate_counterclockwise_button.set_visible (false);
                this.save_button.set_visible (false);
            }
        });

        this.dialog_service.file_opened_signal.connect ((file) => {
            this.new_tab (file);
        });

        this.dialog_service.delete_image_signal.connect (() => {
            this.viewer.delete_picture ();
            this.sidebar.reset_details ();
        });

        this.dialog_service.file_save_signal.connect ((file) => {
            this.viewer.save_picture (file.get_path (), file.get_basename ());
        });
    }

    private void new_tab (GLib.File file) {
        var tab = new Viewer ();
        tab.set_displayed_image (file.get_path ());
        this.sidebar.set_file_details (file);

        var page = this.tab_view.add_page (tab, null);
        page.title = file.get_basename ();
        this.tab_view.set_selected_page (page);
    }

    [GtkCallback]
    private async void on_open_clicked () {
        this.dialog_service.open_file_dialog.begin ();
    }

    [GtkCallback]
    private void on_delete_clicked () {
        this.dialog_service.open_delete_image_dialog (this.viewer.get_current_filename ());
    }

    [GtkCallback]
    private void on_flap_toggled () {
        this.adw_flap.set_reveal_flap (!this.adw_flap.get_reveal_flap ());
    }

    [GtkCallback]
    private void on_clockwise_clicked () {
        this.viewer.rotate_picture (Gdk.PixbufRotation.CLOCKWISE);
    }

    [GtkCallback]
    private void on_counter_clockwise_clicked () {
        this.viewer.rotate_picture (Gdk.PixbufRotation.COUNTERCLOCKWISE);
    }

    [GtkCallback]
    private void on_save_clicked () {
        this.dialog_service.save_file_dialog.begin ();
    }
}