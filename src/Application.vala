public class Pikture.App : Adw.Application {
	public App () {
		Object (application_id: "org.mistakenelf.pikture",
		        flags : GLib.ApplicationFlags.FLAGS_NONE
		);
	}

	protected override void activate () {
		var win = this.get_active_window ();
		if (win == null) {
			win = new MainWindow (this);
		}
		win.present ();
	}

	protected override void open (GLib.File[] files, string hint) {}
}

int main (string[] args) {
	var app = new Pikture.App ();
	return app.run (args);
}