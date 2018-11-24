
import UIKit
import struct PopcornKit.Subtitle

class ExtendedSubtitleTableViewController: UITableViewController {
    
    var allSubtitles = Dictionary<String, [Subtitle]>()
    var currentSubtitle:Subtitle?
    var delegate:OptionsViewControllerDelegate?
    
    private var previousCell:UITableViewCell?
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Always 2 sections, the selection section and the subtitles section
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentSubtitle != nil ? Array(allSubtitles[currentSubtitle!.language]!).count : 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        
        cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let subtitle = Array(allSubtitles[currentSubtitle?.language ?? "English".localized]!)[indexPath.row]
        cell.detailTextLabel?.text = subtitle.language
        cell.textLabel?.text = subtitle.name
        cell.accessoryType = currentSubtitle?.name == subtitle.name ? .checkmark : .none
        currentSubtitle?.name == subtitle.name ? previousCell = cell : ()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        delegate?.didSelectSubtitle(currentSubtitle)
        self.currentSubtitle = Array(allSubtitles[currentSubtitle!.language]!)[indexPath.row]
        previousCell?.accessoryType = .none
        cell?.accessoryType = .checkmark
        previousCell = cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Subtitles".localized
    }
    
    // MARK: - Navigation
    
    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
