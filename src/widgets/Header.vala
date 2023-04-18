public class Pikture.Header : Adw.Bin {
    private Adw.ApplicationWindow window;
    private const ActionEntry[] header_action_entries = {
        { "open-image", open_image },
    };

    public signal void update_displayed_image_signal (string updated_image);

    construct {
        var action_group = new SimpleActionGroup ();
        action_group.add_action_entries (header_action_entries, this);
        insert_action_group ("header", action_group);

        this.set_child (this.build_ui ());
    }

    public Header (Adw.ApplicationWindow window) {
        this.window = window;
    }

    private void open_image () {
        this.open_button_clicked.begin ();
    }

    private Adw.HeaderBar build_ui () {
        var header = new Adw.HeaderBar ();

        var menu = new GLib.Menu ();
        menu.append ("Quit", "app.quit");
        menu.append ("About", "app.about");
        menu.append ("Preferences", "app.preferences");
        menu.append ("Open Image", "header.open-image");

        var menu_button = new Gtk.MenuButton () {
            icon_name = "open-menu-symbolic",
            menu_model = menu,
        };

        header.pack_start (menu_button);

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