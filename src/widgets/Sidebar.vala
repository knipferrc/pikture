[GtkTemplate(ui = "/com/github/mistakenelf/pikture/sidebar.ui")]
public class Pikture.Sidebar : Adw.Bin {
    [GtkChild] private unowned Gtk.Button delete_image_button;
    [GtkChild] private unowned Gtk.ListBox file_info_container;
    [GtkChild] private unowned Adw.ActionRow file_name;
    [GtkChild] private unowned Adw.ActionRow file_size;
    [GtkChild] private unowned Adw.ActionRow date_modified;
    [GtkChild] private unowned Adw.ActionRow width;
    [GtkChild] private unowned Adw.ActionRow height;

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
            this.file_info_container.visible = true;
            this.delete_image_button.visible = true;

            var info = file.query_info("*", FileQueryInfoFlags.NONE);

            var pixbuf = new Gdk.Pixbuf.from_file(file.get_path());
            if (pixbuf == null) {
                this.width.subtitle = "N/A";
                this.height.subtitle = "N/A";
            }

            this.file_name.subtitle = info.get_name();
            this.file_size.subtitle = GLib.format_size(info.get_size());
            this.date_modified.subtitle = info.get_modification_date_time().format("%m/%d/%y %H:%M");
            this.width.subtitle = @"%d %s".printf(pixbuf.width, "Pixels");
            this.height.subtitle = @"%d %s".printf(pixbuf.height, "Pixels");
        } catch (Error error) {
            stderr.printf(@"$(error.message)\n");
        }
    }
}