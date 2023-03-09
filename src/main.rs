#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")] // hide console window on Windows in release

use eframe::egui;
use std::fs;

fn main() -> Result<(), eframe::Error> {
    let options = eframe::NativeOptions {
        initial_window_size: Some(egui::vec2(320.0, 240.0)),
        ..Default::default()
    };
    eframe::run_native(
        "Refile",
        options,
        Box::new(|_cc| Box::new(Refile::default())),
    )
}

struct Refile {
    selected_directory: String,
}

impl Default for Refile {
    fn default() -> Self {
        Self {
            selected_directory: ".".to_owned(),
        }
    }
}

impl eframe::App for Refile {
    fn update(&mut self, ctx: &egui::Context, _frame: &mut eframe::Frame) {
        egui::SidePanel::left("my_left_panel").show(ctx, |ui| {
            if ui.button(format!("{}", "Home")).clicked() {
                self.selected_directory = "~".to_string();
            }
            if ui.button(format!("{}", "Root")).clicked() {
                self.selected_directory = "/".to_string();
            }
            if ui.button(format!("{}", "Home")).clicked() {
                self.selected_directory = "~".to_string();
            }
        });
        egui::CentralPanel::default().show(ctx, |ui| {
            ui.horizontal_wrapped(|ui| {
                for file in fs::read_dir(&self.selected_directory).unwrap() {
                    let path = file.unwrap().path().display().to_string();
                    if ui.button(format!("{}", path)).clicked() {
                        self.selected_directory = path;
                    }
                }
            });
        });
    }
}
