[GtkTemplate (ui = "/com/github/mistakenelf/pikture/header.ui")]
public class Pikture.Header : Adw.Bin {
    private Adw.ApplicationWindow window;

    [GtkChild]
    private unowned Gtk.Button open_image;

    [GtkChild]
    private unowned Gtk.Button delete_image;

    public signal void update_displayed_image_signal (string updated_image);
    public signal void delete_displayed_image_signal ();

    construct {
        this.open_image.clicked.connect (this.open_button_clicked);
        this.delete_image.clicked.connect (this.delete_image_clicked);
    }

    public Header (Adw.ApplicationWindow window) {
        this.window = window;
    }

    private async void open_button_clicked () {
        var filter = new Gtk.FileFilter ();
        filter.add_mime_type ("image/*");

        #if GTK_4_10
        var dialog = new Gtk.FileDialog ();
        dialog.set_initial_name (name);
        dialog.set_default_filter (filter);
        dialog.set_title (_("Select a file"));
        dialog.set_parent (this.window);
        try {
            var file = yield dialog.open (this.window, null);

            if (file != null) {
                this.update_displayed_image_signal (file.get_path ());
            }
        } catch (Error e) {
            dialog.dispose ();
        }
        #else
        var chooser = new Gtk.FileChooserNative (null, this.window, Gtk.FileChooserAction.OPEN, null, null);
        chooser.set_current_name (name);
        chooser.set_filter (filter);
        chooser.modal = true;
        chooser.response.connect ((id) => {
            var file = chooser.get_file ();
            if (id == Gtk.ResponseType.ACCEPT && file is File) {
                this.update_displayed_image_signal (file.get_path ());
            }
        });
        chooser.show ();
        #endif
    }

    private void delete_image_clicked () {
        this.delete_displayed_image_signal ();
    }
}