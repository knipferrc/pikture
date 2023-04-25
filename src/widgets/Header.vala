public class Pikture.Header : Adw.Bin {
    private Adw.ApplicationWindow window;

    public signal void update_displayed_image_signal (string updated_image);
    public signal void delete_displayed_image_signal ();

    construct {
        this.build_ui ();
    }

    public Header (Adw.ApplicationWindow window) {
        this.window = window;
    }

    private void build_ui () {
        var header = new Adw.HeaderBar ();

        var menu = new GLib.Menu ();
        menu.append (_("Quit"), "app.quit");
        menu.append (_("About"), "app.about");

        var menu_button = new Gtk.MenuButton () {
            icon_name = "open-menu-symbolic",
            primary = true,
            menu_model = menu,
        };

        var builder = new Gtk.Builder ();
        var open_image_button = new Gtk.Button ();
        open_image_button.add_css_class ("raised");
        open_image_button.add_css_class ("suggested-action");
        var open_button_content = new Adw.ButtonContent () {
            icon_name = "document-open-symbolic",
            label = _("Open"),
        };
        open_image_button.add_child (builder, open_button_content, null);

        open_image_button.clicked.connect (this.open_button_clicked);

        var delete_image_button = new Gtk.Button.from_icon_name ("user-trash-symbolic");
        delete_image_button.add_css_class ("delete-button");
        delete_image_button.clicked.connect (this.delete_image_clicked);

        header.pack_end (menu_button);
        header.pack_end (open_image_button);
        header.pack_end (delete_image_button);

        this.set_child (header);
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