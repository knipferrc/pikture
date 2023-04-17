public class Pikture.MainWindow : Adw.ApplicationWindow {
	public Gtk.Picture current_image;

	construct {
		this.build_ui ();
	}

	public MainWindow (Adw.Application app) {
		Object (
		        application: app
		);
	}

	public void open (GLib.File file) {
		this.current_image.set_filename (file.get_path ());
	}

	private void build_ui () {
		this.set_title (_("Pikture"));
		this.set_default_size (700, 500);

		var layout_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
		var header = new Header (this);

		header.update_current_image.connect ((_, new_image) => {
			this.current_image.set_filename (new_image);
		});

		this.current_image = new Gtk.Picture () {
			margin_bottom = 10,
			margin_top = 10
		};

		layout_box.append (header);
		layout_box.append (this.current_image);

		this.set_content (layout_box);
	}
}
