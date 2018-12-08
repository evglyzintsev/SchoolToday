from flask import Blueprint, request, Response, jsonify
import gspread
import threading
import json
from oauth2client.service_account import ServiceAccountCredentials

module = Blueprint('schedule', __name__, url_prefix='/api/schedule')
t = {}

def FromBadToGoodWord(str1):
    return str1.split("'")[1]


def GetTimeTable():
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
                    ans_list[cl][0].append(FromBadToGoodWord(str(cell_list[i])) + FromBadToGoodWord(str(cell_list1[i])))
                if i > 11 and i < 23:
                    ans_list[cl][1].append(FromBadToGoodWord(str(cell_list[i])) + FromBadToGoodWord(str(cell_list1[i])))
                if i > 22 and i < 36:
                    ans_list[cl][2].append(FromBadToGoodWord(str(cell_list[i])) + FromBadToGoodWord(str(cell_list1[i])))
                if i > 35 and i < 47:
                    ans_list[cl][3].append(FromBadToGoodWord(str(cell_list[i])) + FromBadToGoodWord(str(cell_list1[i])))
                if i > 46 and i < 60:
                    ans_list[cl][4].append(FromBadToGoodWord(str(cell_list[i])) + FromBadToGoodWord(str(cell_list1[i])))
                if i > 59:
                    ans_list[cl][5].append(FromBadToGoodWord(str(cell_list[i])) + FromBadToGoodWord(str(cell_list1[i])))
        for i in range(0, 69):
            if i < 12:
                ans_list[cl][0].append(FromBadToGoodWord(str(cell_list[i])))
            if i > 11 and i < 23:
                ans_list[cl][1].append(FromBadToGoodWord(str(cell_list[i])))
            if i > 22 and i < 36:
                ans_list[cl][2].append(FromBadToGoodWord(str(cell_list[i])))
            if i > 35 and i < 47:
                ans_list[cl][3].append(FromBadToGoodWord(str(cell_list[i])))
            if i > 46 and i < 60:
                ans_list[cl][4].append(FromBadToGoodWord(str(cell_list[i])))
            if i > 59:
                ans_list[cl][5].append(FromBadToGoodWord(str(cell_list[i])))
    return ans_list

@module.route('/get_schedule/<cl>', methods=['GET'])
def GetTimeTableOfCertainClass(cl):
    return json.dumps({'ans': t[cl]})
def GetWholeTimeTable():
    while True:
        print("Hey! I'm working")
        t = GetTimeTable()
threading.Timer(1, GetWholeTimeTable).start()

#return json.dumps({'ans': ans_list})
