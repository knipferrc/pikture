[GtkTemplate (ui = "/com/github/mistakenelf/pikture/main_window.ui")]
public class Pikture.MainWindow : Adw.ApplicationWindow {
    [GtkChild] private unowned Viewer viewer;
    [GtkChild] private unowned Adw.Flap adw_flap;
    [GtkChild] private unowned Sidebar sidebar;
    [GtkChild] private unowned Gtk.Button delete_image_button;
    [GtkChild] private unowned Gtk.Button rotate_counterclockwise_button;
    [GtkChild] private unowned Gtk.Button rotate_clockwise_button;
    [GtkChild] private unowned Gtk.Button save_button;

    private DialogService dialog_service;

    public MainWindow (Adw.Application app) {
        Object (
                application: app
        );
    }

    construct {
        this.dialog_service = new DialogService (this);
        this.handle_signals ();
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

    public void open (GLib.File file) {
        this.viewer.set_displayed_image (file.get_path ());
        this.sidebar.set_file_details (file);
    }

    private void handle_signals () {
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
            this.viewer.set_displayed_image (file.get_path ());
            this.sidebar.set_file_details (file);
        });

        this.dialog_service.delete_image_signal.connect (() => {
            this.viewer.delete_picture ();
            this.sidebar.reset_details ();
        });

        this.dialog_service.file_save_signal.connect ((file) => {
            this.viewer.save_picture (file.get_path (), file.get_basename ());
        });
    }
}