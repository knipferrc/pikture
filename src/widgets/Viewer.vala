public class Pikture.Viewer : Adw.Bin {
    private Gtk.Picture picture;

    construct {
        this.picture = new Gtk.Picture() {
            margin_bottom = 10,
            margin_top = 10
        };

        this.set_child(picture);
    }

    public void set_displayed_image(string filename) {
        this.picture.set_filename(filename);
    }
}
