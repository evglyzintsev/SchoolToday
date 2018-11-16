from flask import Blueprint, request, Response, jsonify
import gspread
import json
from oauth2client.service_account import ServiceAccountCredentials
module = Blueprint('schedule', __name__, url_prefix='/api/schedule')


def FromBadToGoodWord(str1):
    return str1.split("'")[1]


@module.route('/get_schedule/<cl>', methods=['GET'])
def GetTimeTable(cl):
    scope = ['https://spreadsheets.google.com/feeds',
             'https://www.googleapis.com/auth/drive']
    credentials = ServiceAccountCredentials.from_json_keyfile_name('1.json', scope)
    gc = gspread.authorize(credentials)
    wks = gc.open_by_url(
        'https://docs.google.com/spreadsheets/d/1yI8crMmfMbCFQMx5PdqBreCjTNK5r-aJeqgU9pWN85c/edit#gid=1539915031')
    g = wks.worksheet('расписание')
    cls = {'5C': 'C', '6C': 'D', '7C': 'E', '7T': 'F', '7L': 'G', '9C': 'H'}
    cell_list = g.range(cls[cl] + '2:' + cls[cl] + '72')
    # print(cell_list)
    ans_list = [[], [], [], [], [], []]
    for i in range(2, 71):
        if i < 14:
            ans_list[0].append(FromBadToGoodWord(str(cell_list[i])))
        if i > 13 and i < 25:
            ans_list[1].append(FromBadToGoodWord(str(cell_list[i])))
        if i > 24 and i < 38:
            ans_list[2].append(FromBadToGoodWord(str(cell_list[i])))
        if i > 37 and i < 49:
            ans_list[3].append(FromBadToGoodWord(str(cell_list[i])))
        if i > 48 and i < 62:
            ans_list[4].append(FromBadToGoodWord(str(cell_list[i])))
        if i > 61:
            ans_list[5].append(FromBadToGoodWord(str(cell_list[i])))
    return json.dumps({'ans': ans_list})

