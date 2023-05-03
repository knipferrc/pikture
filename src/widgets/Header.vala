[GtkTemplate (ui = "/com/github/mistakenelf/pikture/header.ui")]
public class Pikture.Header : Adw.Bin {
    [GtkChild] private unowned Gtk.Button delete_image;

    public signal void update_displayed_image_signal (string updated_image);
    public signal void delete_displayed_image_signal ();

    public void disable_delete () {
        this.delete_image.sensitive = false;
    }

    public void enable_delete () {
        this.delete_image.sensitive = true;
    }

    [GtkCallback]
    private async void open_button_clicked () {
        var filter = new Gtk.FileFilter ();
        filter.add_mime_type ("image/*");

        var dialog = new Gtk.FileDialog ();
        dialog.set_default_filter (filter);
        dialog.set_title (_("Select a file"));
        dialog.modal = true;

        try {
            var file = yield dialog.open (null, GLib.Cancellable.get_current ());

            if (file != null) {
                this.update_displayed_image_signal (file.get_path ());
            }
        } catch (Error e) {
            print (e.message);
        }
    }

    [GtkCallback]
    private void delete_image_clicked () {
        this.delete_displayed_image_signal ();
    }
}