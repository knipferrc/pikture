public class Pikture.Header : Adw.Bin {
    private Adw.ApplicationWindow window;

    public signal void update_displayed_image_signal (string updated_image);
    public signal void delete_displayed_image_signal ();

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

        var delete_image_button = new Gtk.Button.from_icon_name ("user-trash-symbolic");
        delete_image_button.add_css_class ("delete-button");
        delete_image_button.clicked.connect (this.delete_image_clicked);

        header.pack_start (menu_button);
        header.pack_start (open_image_button);
        header.pack_end (delete_image_button);

        return header;
    }

    private async void open_button_clicked () {
        var filter = new Gtk.FileFilter ();
        filter.add_mime_type ("image/*");

        #if GTK_4_10
        var dialog = new Gtk.FileDialog ();
        dialog.set_initial_name (name);
        dialog.set_default_filter (filter);
        dialog.set_title (_("Select a file"));
        try {
            var file = yield dialog.open (this.window, null);

            if (file != null) {
                this.update_displayed_image_signal (file.get_path ());
            }
        } catch (Error e) {
            dialog.dispose ();
        }
        #else
        var chooser = new Gtk.FileChooserNative (null, this.window, Gtk.FileChooserAction.OPEN, null, null);
        chooser.set_current_name (name);
        chooser.set_filter (filter);
        chooser.modal = true;
        chooser.response.connect ((id) => {
            var file = chooser.get_file ();
            if (id == Gtk.ResponseType.ACCEPT && file is File) {
                this.update_displayed_image_signal (file.get_path ());
            }
        });
        chooser.show ();
        #endif
    }

    private void delete_image_clicked () {
        this.delete_displayed_image_signal ();
    }
}