[GtkTemplate (ui = "/com/github/mistakenelf/pikture/main_window.ui")]
public class Pikture.MainWindow : Adw.ApplicationWindow {
    [GtkChild] private unowned Viewer viewer;
    [GtkChild] private unowned Gtk.Button delete_image;
    [GtkChild] private unowned Adw.Flap adw_flap;
    [GtkChild] private unowned Gtk.Label filename;

    public MainWindow (Adw.Application app) {
        Object (
                application: app
        );
    }

    construct {
        this.handle_signals ();
    }

    public void open (GLib.File file) {
        this.viewer.set_displayed_image (file.get_path ());
    }

    private void handle_signals () {
        this.viewer.notify["filename"].connect (() => {
            if (viewer.filename != "") {
                this.delete_image.sensitive = true;
            } else {
                this.delete_image.sensitive = false;
            }
        });
    }

    [GtkCallback]
    private async void open_button_clicked () {
        var dialog = new Gtk.FileDialog ();
        dialog.set_title (_("Select a file"));
        dialog.modal = true;

        try {
            var file = yield dialog.open (this, null);

            if (file != null) {
                this.viewer.set_displayed_image (file.get_path ());
                this.filename.set_label (file.get_basename ());
            }
        } catch (Error e) {
            print (e.message);
        }
    }

    [GtkCallback]
    private void delete_image_clicked () {
        this.viewer.delete_picture ();
    }

    [GtkCallback]
    private void on_flap_button_toggled () {
        this.adw_flap.set_reveal_flap (!this.adw_flap.get_reveal_flap ());
    }
}