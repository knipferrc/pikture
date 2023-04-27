[GtkTemplate (ui = "/com/github/mistakenelf/pikture/viewer.ui")]
public class Pikture.Viewer : Adw.Bin {
    [GtkChild] private unowned Gtk.Picture picture;

    public void set_displayed_image (string filename) {
        this.picture.set_filename (filename);
    }

    public void delete_picture () {
        try {
            this.picture.get_file ().delete ();
            this.picture.set_filename ("");
        } catch (Error e) {
            print ("Error: %s\n", e.message);
        }
    }
}