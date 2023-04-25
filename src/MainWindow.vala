public class Pikture.MainWindow : Adw.ApplicationWindow {
    private Viewer viewer;

    construct {
        this.build_ui ();
    }

    public MainWindow (Adw.Application app) {
        Object (
                application: app
        );
    }

    public void open (GLib.File file) {
        this.viewer.set_displayed_image (file.get_path ());
    }

    private void build_ui () {
        this.set_title (_("Pikture"));
        this.set_default_size (700, 500);

        var layout_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        var header = new Header (this);
        this.viewer = new Viewer ();

        header.update_displayed_image_signal.connect ((_, new_image) => {
            this.viewer.set_displayed_image (new_image);
        });

        header.delete_displayed_image_signal.connect (() => {
            this.viewer.delete_picture ();
        });

        layout_box.append (header);
        layout_box.append (viewer);

        this.set_content (layout_box);
    }
}