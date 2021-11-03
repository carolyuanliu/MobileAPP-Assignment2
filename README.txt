This is a UIAPP of the Juventus Men‘s Team 2020/2021.
Images and data of players are from https://www.juventus.com/
In this APP, there are 7 screens. Brief details are below:

1.The first  screen  is a UITableViewController with subtitle cell
which displays names, images and positions of players. There are three sugues to
other screens.Segue1 is from the Table View Cell to the PlayerViewController screen.
The markedSegue is from file bar button on the left of navigation bar to the
MarkedTableViewController to show the players marked by user. The filterSegue is
from the filter bar button on the right of the navigation bar to the
FilterTableViewController. addSegue is from the add button to the addPlayerView.

2.The PlayerViewController  is a UIViewController which displays details about
the players. For example, name, number, position, date of birth, nationality and
photograph. There are 2 segues of this screen, the editSegue is from the edit
bar button to the addPlayerView, the Segue2 is from the Statistics button to the
ProfileViewController.

3.The addPlayerViewController contains several textfields to input the information.
There are a add/update button to add a new player to the entity or update the
information of existing player, and a clear button to clear the textfields.

4.MarkedTableViewController displays the marked player in the tableview.

5.FilterTableViewController displays players fetched by predicate of position.
When click the position bar button, there will be an UIAlertController allows user
select a position. Players of the selected position will show in the tableview.

6.The PlayerViewController is a UIViewController, in which a Text View displays
the statistics of the player in 2020/2021. Similarly, a button in
screen3 is linked with the last screen by Segue3.

7.The WebViewController is a UIViewController with a WebKit View, which
displays a website of the player.

8.All players are stored in the People entity.The marked players are stored in
the Marked entity.

9.In the LaunchScreen storyboard, an ImageView and two labels display the
logo of Juventus. The icon of this APP is another logo of the club.
