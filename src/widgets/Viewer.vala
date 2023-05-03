[GtkTemplate (ui = "/com/github/mistakenelf/pikture/viewer.ui")]
public class Pikture.Viewer : Adw.Bin {
    [GtkChild] private unowned Gtk.Picture picture;

    public string filename { get; set; }

    public void set_displayed_image (string filename) {
        this.picture.set_filename (filename);
        this.filename = filename;
    }

    public void delete_picture () {
        try {
            this.picture.get_file ().delete ();
            this.picture.set_filename ("");
            this.filename = "";
        } catch (Error e) {
            print ("Error: %s\n", e.message);
        }
    }
}