[GtkTemplate(ui = "/com/github/mistakenelf/pikture/sidebar.ui")]
public class Pikture.Sidebar : Adw.Bin {
    [GtkChild] private unowned Gtk.Button delete_image_button;
    [GtkChild] private unowned Gtk.ListBox file_info_container;
    [GtkChild] private unowned Adw.ActionRow file_name;
    [GtkChild] private unowned Adw.ActionRow file_size;
    [GtkChild] private unowned Adw.ActionRow date_modified;
    [GtkChild] private unowned Adw.ActionRow width;
    [GtkChild] private unowned Adw.ActionRow height;
    [GtkChild] private unowned Adw.ActionRow image_type;

    public signal void update_displayed_image_signal();
    public signal void delete_displayed_image_signal();

    [GtkCallback]
    private void open_button_clicked() {
        this.update_displayed_image_signal();
    }

    [GtkCallback]
    private void delete_button_clicked() {
        this.delete_displayed_image_signal();
    }

    public void set_file_details(GLib.File file) {
        try {
            this.file_info_container.set_visible(true);
            this.delete_image_button.set_visible(true);

            var info = file.query_info("*", FileQueryInfoFlags.NONE);

            var pixbuf = new Gdk.Pixbuf.from_file(file.get_path());
            if (pixbuf == null) {
                this.width.set_subtitle("N/A");
                this.height.set_subtitle("N/A");
            }

            this.file_name.set_subtitle(info.get_name());
            this.file_size.set_subtitle(GLib.format_size(info.get_size()));
            this.date_modified.set_subtitle(info.get_modification_date_time().format("%m/%d/%y %H:%M"));
            this.width.set_subtitle("%d %s".printf(pixbuf.width, "Pixels"));
            this.height.set_subtitle("%d %s".printf(pixbuf.height, "Pixels"));

            var image_description = GLib.ContentType.get_description(info.get_content_type());
            this.image_type.set_subtitle(image_description);
        } catch (Error error) {
            stderr.printf(@"$(error.message)\n");
        }
    }
}