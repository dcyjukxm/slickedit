=surround_with_new_j2me_midlet import javax.microedition.lcdui.*;
                               import javax.microedition.midlet.*;
                               %\l
                               public class %\m sur_text%
                                   extends MIDlet
                                   implements CommandListener {
                                 private Form mMainForm;
                               %\l
                                 public %\m sur_text%() {
                                   mMainForm = new Form("HelloMIDlet");
                                   mMainForm.append(new StringItem(null, "Hello, %\m sur_text%!"));
                                   mMainForm.addCommand(new Command("Exit", Command.EXIT, 0));
                                   mMainForm.setCommandListener(this);
                                 }
                               %\l
                                 public void startApp() {
                                   Display.getDisplay(this).setCurrent(mMainForm);
                                 }
                               %\l
                                 public void pauseApp() {}
                               %\l
                                 public void destroyApp(boolean unconditional) {}
                               %\l
                                 public void commandAction(Command c, Displayable s) {
                                   notifyDestroyed();
                                 }
                               }

