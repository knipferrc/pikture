[GtkTemplate (ui = "/com/github/mistakenelf/pikture/window.ui")]
public class Pikture.Window : Adw.ApplicationWindow {
    [GtkChild]
    private unowned Viewer viewer;

    [GtkChild]
    private unowned Header header;

    construct {
        header.update_displayed_image_signal.connect ((_, new_image) => {
            this.viewer.set_displayed_image (new_image);
        });

        header.delete_displayed_image_signal.connect (() => {
            this.viewer.delete_picture ();
        });
    }

    public Window (Adw.Application app) {
        Object (
                application: app
        );
    }

    public void open (GLib.File file) {
        this.viewer.set_displayed_image (file.get_path ());
    }
}