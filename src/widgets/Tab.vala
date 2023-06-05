[GtkTemplate(ui = "/com/github/mistakenelf/pikture/tab.ui")]
public class Pikture.Tab : Adw.Bin {
    [GtkChild] private unowned Gtk.Label tab_label;

    public string label { get; construct; }
    public signal void close_tab_signal();

    public Tab(string label) {
        Object(
               label: label
        );
    }

    construct {
        this.tab_label.set_label(this.label);
    }

    [GtkCallback]
    private void close_tab_clicked() {
        this.close_tab_signal();
    }
}