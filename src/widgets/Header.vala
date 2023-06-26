[GtkTemplate (ui = "/com/github/mistakenelf/pikture/header.ui")]
public class Pikture.Header : Adw.Bin {
    [GtkChild] private unowned Gtk.Button delete_image_button;
    [GtkChild] private unowned Gtk.Button rotate_counterclockwise_button;
    [GtkChild] private unowned Gtk.Button rotate_clockwise_button;
    [GtkChild] private unowned Gtk.Button save_button;
    [GtkChild] private unowned Gtk.ToggleButton flap_toggle;
    [GtkChild] private unowned Adw.TabButton tab_button;

    public signal void open_file_signal ();
    public signal void delete_file_signal ();
    public signal void flap_toggled_signal ();
    public signal void rotate_clockwise_signal ();
    public signal void rotate_counter_clockwise_signal ();
    public signal void save_file_signal ();

    public void hide_action_buttons () {
        this.delete_image_button.set_visible (false);
        this.rotate_clockwise_button.set_visible (false);
        this.rotate_counterclockwise_button.set_visible (false);
        this.save_button.set_visible (false);
        this.flap_toggle.set_sensitive (false);
    }

    public void show_action_buttons () {
        this.delete_image_button.set_visible (true);
        this.rotate_clockwise_button.set_visible (true);
        this.rotate_counterclockwise_button.set_visible (true);
        this.save_button.set_visible (true);
        this.flap_toggle.set_sensitive (true);
    }

    public void set_tab_buttton_view (Adw.TabView view) {
        this.tab_button.view = view;
    }

    [GtkCallback]
    private async void on_open_clicked () {
        this.open_file_signal ();
    }

    [GtkCallback]
    private void on_delete_clicked () {
        this.delete_file_signal ();
    }

    [GtkCallback]
    private void on_flap_toggled () {
        this.flap_toggled_signal ();
    }

    [GtkCallback]
    private void on_clockwise_clicked () {
        this.rotate_clockwise_signal ();
    }

    [GtkCallback]
    private void on_counter_clockwise_clicked () {
        this.rotate_counter_clockwise_signal ();
    }

    [GtkCallback]
    private void on_save_clicked () {
        this.save_file_signal ();
    }
}