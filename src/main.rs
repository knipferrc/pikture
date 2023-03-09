#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")] // hide console window on Windows in release

use eframe::egui;
use egui_extras::RetainedImage;
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
    folder_icon: RetainedImage,
    file_icon: RetainedImage,
}

impl Default for Refile {
    fn default() -> Self {
        Self {
            selected_directory: String::from("."),
            folder_icon: RetainedImage::from_image_bytes(
                "folder.png",
                include_bytes!("folder.png"),
            )
            .unwrap(),
            file_icon: RetainedImage::from_image_bytes("file.png", include_bytes!("file.png"))
                .unwrap(),
        }
    }
}

impl eframe::App for Refile {
    fn update(&mut self, ctx: &egui::Context, _frame: &mut eframe::Frame) {
        egui::SidePanel::left("folder_panel").show(ctx, |ui| {
            if ui.button(format!("{}", "Home")).clicked() {
                self.selected_directory = ".".to_string();
            }
            if ui.button(format!("{}", "Root")).clicked() {
                self.selected_directory = "/".to_string();
            }
            if ui.button(format!("{}", "Home")).clicked() {
                self.selected_directory = "/Downloads".to_string();
            }
        });

        egui::CentralPanel::default().show(ctx, |ui| {
            ui.horizontal_wrapped(|ui| {
                for file in fs::read_dir(&self.selected_directory).unwrap() {
                    let file = file.unwrap();
                    let current_path = file.path().display().to_string();
                    if file.path().is_dir() {
                        ui.vertical(|ui| {
                            if ui
                                .add(egui::ImageButton::new(
                                    self.folder_icon.texture_id(ctx),
                                    self.folder_icon.size_vec2(),
                                ))
                                .double_clicked()
                            {
                                self.selected_directory = current_path;
                            }
                            ui.heading("Folder")
                        });
                    } else {
                        ui.vertical(|ui| {
                            ui.add(egui::ImageButton::new(
                                self.file_icon.texture_id(ctx),
                                self.file_icon.size_vec2(),
                            ));
                            ui.heading("File")
                        });
                    }
                }
            });
        });
    }
}
