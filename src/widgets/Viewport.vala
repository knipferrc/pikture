[GtkTemplate (ui = "/com/github/mistakenelf/pikture/viewport.ui")]
public class Pikture.Viewport : Adw.Bin {
    [GtkChild] private unowned Gtk.Picture picture;

    private Gdk.Pixbuf pixbuf;

    public string filename { get; set; }

    public void set_displayed_image (string filename) {
        this.filename = filename;
        this.picture.set_filename (this.filename);

        try {
            var pixbuf = new Gdk.Pixbuf.from_file (this.filename);
            if (pixbuf == null) {
                this.picture.set_filename (this.filename);
            }

            this.picture.set_pixbuf (pixbuf);
            this.pixbuf = pixbuf;
        } catch (Error error) {
            stderr.printf (error.message);
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
        } catch (Error error) {
            stderr.printf (error.message);
        }
    }

    public string get_current_filename () {
        return this.picture.get_file ().get_basename ();
    }

    public void save_picture (string filepath, string basename) {
        var final_path = this.has_extension (basename) ? filepath : filepath + ".png";

        try {
            FileStream file = FileStream.open (final_path, "w");
            this.pixbuf.save_to_callbackv ((data) => {
                file.write (data);

                return true;
            }, "png", null, null);
        } catch (Error e) {
            stderr.printf ("Error saving image: %s\n", e.message);
        }
    }

    private bool has_extension (string filename) {
        string basename = File.new_for_path (filename).get_basename ();

        if (basename != null) {
            int dotIndex = basename.index_of_char ('.');
            if (dotIndex != -1 && dotIndex < basename.length - 1) {
                return true;
            }
        }

        return false;
    }
}