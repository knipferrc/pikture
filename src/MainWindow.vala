[GtkTemplate (ui = "/com/github/mistakenelf/pikture/main_window.ui")]
public class Pikture.MainWindow : Adw.ApplicationWindow {
    [GtkChild] private unowned Viewer viewer;
    [GtkChild] private unowned Gtk.Button delete_image;

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

    public void disable_delete () {
        this.delete_image.sensitive = false;
    }

    public void enable_delete () {
        this.delete_image.sensitive = true;
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
            }
        } catch (Error e) {
            print (e.message);
        }
    }

    [GtkCallback]
    private void delete_image_clicked () {
        this.viewer.delete_picture ();
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
}