public class Pikture.MainWindow : Adw.ApplicationWindow {
	public MainWindow (Gtk.Application app) {
		Object (
		        application: app
		);
	}

	construct {
		var header = new Adw.HeaderBar ();
		var layout_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

		var label = new Gtk.Label ("Hello World");
		label.vexpand = true;
		label.valign = Gtk.Align.CENTER;
		label.hexpand = true;
		label.halign = Gtk.Align.CENTER;

		layout_box.append (header);
		layout_box.append (label);

		this.set_content (layout_box);
	}
}