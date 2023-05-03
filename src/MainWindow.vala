[GtkTemplate (ui = "/com/github/mistakenelf/pikture/main_window.ui")]
public class Pikture.MainWindow : Adw.ApplicationWindow {
    [GtkChild] private unowned Header header;
    [GtkChild] private unowned Viewer viewer;

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

    private void handle_signals () {
        header.update_displayed_image_signal.connect ((_, new_image) => {
            this.viewer.set_displayed_image (new_image);
        });

        header.delete_displayed_image_signal.connect (() => {
            this.viewer.delete_picture ();
        });

        viewer.notify["filename"].connect (() => {
            if (viewer.filename != "") {
                header.enable_delete ();
            } else {
                header.disable_delete ();
            }
        });
    }
}