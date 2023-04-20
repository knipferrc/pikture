public class Pikture.Header : Adw.Bin {
    private Adw.ApplicationWindow window;

    public signal void update_displayed_image_signal (string updated_image);

    construct {
        this.set_child (this.build_ui ());
    }

    public Header (Adw.ApplicationWindow window) {
        this.window = window;
    }

    private Adw.HeaderBar build_ui () {
        var header = new Adw.HeaderBar ();

        var menu = new GLib.Menu ();
        menu.append (_("Quit"), "app.quit");
        menu.append (_("About"), "app.about");

        var menu_button = new Gtk.MenuButton () {
            icon_name = "open-menu-symbolic",
            menu_model = menu,
        };

        var open_image_button = new Gtk.Button.with_label (_("Open"));
        open_image_button.clicked.connect (this.open_button_clicked);

        header.pack_start (menu_button);
        header.pack_start (open_image_button);

        return header;
    }

    private async void open_button_clicked () {
        var dialog = new Gtk.FileDialog ();
        dialog.set_title (_("Select a file"));

        var filter = new Gtk.FileFilter ();
        filter.add_mime_type ("image/*");
        dialog.set_initial_name (name);
        dialog.set_default_filter (filter);
        try {
            var file = yield dialog.open (this.window, null);

            if (file != null) {
                this.update_displayed_image_signal (file.get_path ());
            }
        } catch (Error e) {
            dialog.dispose ();
        }
    }
}