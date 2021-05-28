#!/usr/bin/python

from time import sleep
from datetime import datetime, time
import os



class Notif(object):

    def __init__(self, time, text, state="Idle", icon=" ", flashing=False):
        # datetime time object, when it is triggered
        self.time = time
        # the contents of the json object to be written to file
        self.text = text
        self.state = state
        self.icon = icon
        # whether to alternate the state, to make it flash
        self.flashing = flashing
        self.flash_toggle = False

    def get_json(self):
        output = '{"text": "%s", "icon": "%s", "state": "%s"}'%(self.text, self.icon, ("Info" if self.flash_toggle else self.state))

        if self.flashing:
            self.flash_toggle = not self.flash_toggle

        return output

    def is_time(self):
        current_time = datetime.now()
        if self.time.hour == current_time.hour and self.time.minute == current_time.minute and (self.time.second >= current_time.second and self.time.second <= current_time.second + 5):
            return True
        else:
            return False

# TODO: add priorities, to determine which shows at the top, weighting priority number first, and using time for equal numbers
default_display = Notif(None, "-")
active_notif_list = []
notif_list = [
        # see my i3status-rust status.toml for what icon is what, as I am overriding unused ones for my purposes
        Notif(time(13, 30), "Have lunch, take tablets", "Warning", "pomodoro", True),
        Notif(time(21, 30), "Take tablets!", "Critical", "pomodoro", True),
        Notif(time(22, 00), "Do teeeth", "Warning", " "),
        Notif(time(22, 30), "no seriously, do teeth", "Warning", " ", True),
        #Notif(datetime.now(), "testing thingy", "Warning", " ", True),
]


directory = "/tmp/"
active_file_path = directory + "alerting_active"

def create_active_file():
    open(active_file_path, "w").close()
    #os.chmod(active_file_path, 0o777)

notif_file_path = directory + "notif.txt"

def write_notif_file(content):
    notif_file = open(notif_file_path, "w")
    notif_file.write(content)
    notif_file.close()

#open(active_file_path, "w").close()
write_notif_file(default_display.get_json())



try:
    while True:
        for notif in notif_list:
            if notif.is_time():
                if active_notif_list.count(notif) == 0:
                    active_notif_list.append(notif)
                    #print(active_notif_list)
    
                if not os.path.isfile(active_file_path):
                    create_active_file()
    
        if (not os.path.isfile(active_file_path)) and len(active_notif_list) > 1:
            active_notif_list.pop(0)
            create_active_file()
        elif (not os.path.isfile(active_file_path)) and len(active_notif_list) == 1:
            active_notif_list.pop(0)
            write_notif_file(default_display.get_json())

        if os.path.isfile(active_file_path):
            write_notif_file(active_notif_list[0].get_json())

        sleep(1)

except Exception as ex:
    print("Error: " + ex.strerror)
    os.remove(active_file_path)
    write_notif_file(default_display.get_json())
