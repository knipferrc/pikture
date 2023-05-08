[GtkTemplate(ui = "/com/github/mistakenelf/pikture/sidebar.ui")]
public class Pikture.Sidebar : Adw.Bin {
    [GtkChild] private unowned Gtk.Button delete_image_button;

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

    public void disable_delete_button() {
        this.delete_image_button.sensitive = false;
    }

    public void enable_delete_button() {
        this.delete_image_button.sensitive = true;
    }
}