from flask import Blueprint, request, Response, jsonify
import gspread
import threading
import json
from oauth2client.service_account import ServiceAccountCredentials

module = Blueprint('schedule', __name__, url_prefix='/api/schedule')

class cTimeTable(type):
    _instances = {}
    def __call__(cls, *args, **kwargs):
        if cls not in cls._instances:
            cls._instances[cls] = super(cTimeTable, cls).__call__(*args, **kwargs)
        return cls._instances[cls]

class TimeTable(object, metaclass=cTimeTable):
    def __init__(self):
        self.t = {}

    def FromBadToGoodWord(self, str1):
        return str1.split("'")[1]


    def GetTimeTable(self):
        scope = ['https://spreadsheets.google.com/feeds',
                 'https://www.googleapis.com/auth/drive']
        credentials = ServiceAccountCredentials.from_json_keyfile_name('1.json', scope)
        gc = gspread.authorize(credentials)
        wks = gc.open_by_url(
            'https://docs.google.com/spreadsheets/d/1yI8crMmfMbCFQMx5PdqBreCjTNK5r-aJeqgU9pWN85c/edit#gid=1539915031')
        g = wks.worksheet('расписание')
        cls = {'5C': 'C', '6C': 'D', '7C': 'E', '7T': 'F', '7L': 'G', '9C': 'H'}
        ans_list = {'5C' : [[], [], [], [], [], []], '6C' : [[], [], [], [], [], []], '7C' : [[], [], [], [], [], []], '7T' : [[], [], [], [], [], []], '7L' : [[], [], [], [], [], []], '9C' : [[], [], [], [], [], []]}
        for cl in cls:
            cell_list = g.range(cls[cl] + '2:' + cls[cl] + '72')
            if(cl == '9C'):
                cell_list1 = g.range('I2:I72')
                for i in range(0, 69):
                    if i < 12:
                        ans_list[cl][0].append(self.FromBadToGoodWord(str(cell_list[i])) + self.FromBadToGoodWord(str(cell_list1[i])))
                    if i > 11 and i < 24:
                        ans_list[cl][1].append(self.FromBadToGoodWord(str(cell_list[i])) + self.FromBadToGoodWord(str(cell_list1[i])))
                    if i > 23 and i < 37:
                        ans_list[cl][2].append(self.FromBadToGoodWord(str(cell_list[i])) + self.FromBadToGoodWord(str(cell_list1[i])))
                    if i > 36 and i < 49:
                        ans_list[cl][3].append(self.FromBadToGoodWord(str(cell_list[i])) + self.FromBadToGoodWord(str(cell_list1[i])))
                    if i > 48 and i < 62:
                        ans_list[cl][4].append(self.FromBadToGoodWord(str(cell_list[i])) + self.FromBadToGoodWord(str(cell_list1[i])))
                    if i > 61:
                        ans_list[cl][5].append(self.FromBadToGoodWord(str(cell_list[i])) + self.FromBadToGoodWord(str(cell_list1[i])))
            for i in range(0, 69):
                if i < 12:
                    ans_list[cl][0].append(self.FromBadToGoodWord(str(cell_list[i])))
                if i > 11 and i < 24:
                    ans_list[cl][1].append(self.FromBadToGoodWord(str(cell_list[i])))
                if i > 23 and i < 37:
                    ans_list[cl][2].append(self.FromBadToGoodWord(str(cell_list[i])))
                if i > 36 and i < 49:
                    ans_list[cl][3].append(self.FromBadToGoodWord(str(cell_list[i])))
                if i > 48 and i < 62:
                    ans_list[cl][4].append(self.FromBadToGoodWord(str(cell_list[i])))
                if i > 61:
                    ans_list[cl][5].append(self.FromBadToGoodWord(str(cell_list[i])))
        return ans_list
    
    def GetWholeTimeTable(self):
        print("Hey! I'm working")
        self.t = self.GetTimeTable()


@module.route('/get_schedule/<cl>', methods=['GET'])
def GetTimeTableOfCertainClass(cl):
    ttt = TimeTable()
    return json.dumps({'ans': ttt.t[cl]})

