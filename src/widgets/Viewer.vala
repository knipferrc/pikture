[GtkTemplate (ui = "/com/github/mistakenelf/pikture/viewer.ui")]
public class Pikture.Viewer : Adw.Bin {
    [GtkChild] private unowned Gtk.Picture picture;

    private Gdk.Pixbuf pixbuf;

    public string filename { get; set; }

    public void set_displayed_image (string filename) {
        this.filename = filename;

        try {
            var pixbuf = new Gdk.Pixbuf.from_file (this.filename);
            if (pixbuf == null) {
                this.picture.set_filename (this.filename);
            }

            this.picture.set_pixbuf (pixbuf);
            this.pixbuf = pixbuf;
        } catch (Error error) {
            stderr.printf (@"$(error.message)\n");
        }
    }

    public void rotate_picture (Gdk.PixbufRotation angle) {
        var rotated_picture = this.pixbuf.rotate_simple (angle);
        this.pixbuf = rotated_picture;
        this.picture.set_pixbuf (rotated_picture);
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