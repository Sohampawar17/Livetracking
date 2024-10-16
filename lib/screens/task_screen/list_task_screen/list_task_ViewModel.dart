import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/model/list_task_model.dart';
import 'package:stacked/stacked.dart';

import '../../../router.router.dart';
import '../../../services/list_task_service.dart';

class TaskListViewModel extends BaseViewModel{
  List<TaskList> taskList = [];
  List<TaskList> filterTaskList = [];



  initialise(BuildContext context) async {
    setBusy(true);
    taskList = await TaskListService().fetchTask();
    filterTaskList=taskList;

    setBusy(false);
  }

  Color getColorForPriority(String status) {
    switch (status) {
      case 'Low':
        return Colors.grey; // Set the color for Draft status
      case 'Medium':
        return Colors.deepOrangeAccent; // Set the color for On Hold status
      case 'High':
        return Colors.red; // Set the color for To Deliver and Bill status
      case 'Urgent':
        return Colors.redAccent.shade400; // Set the color for To Bill status
      // Set the color for Closed status
      default:
        return Colors.grey; // Set a default color for unknown status
    }
  }


  Color getColorForStatus(String status) {
    switch (status) {
      case 'Open':
        return Colors.brown[400] ??
            Colors.brown; // Set the color for Draft status
      case 'Working':
        return Colors.orangeAccent; // Set the color for On Hold status
      case 'Pending Review':
        return Colors.orange; // Set the color for To Deliver and Bill status
      case 'Overdue':
        return Colors.redAccent; // Set the color for To Bill status
      case 'Template':
        return Colors.blue; // Set the color for To Deliver status
      case 'Completed':
        return Colors.green; // Set the color for Completed status
      case 'Cancelled':
        return Colors.grey; // Set the color for Cancelled status
   // Set the color for Closed status
      default:
        return Colors.grey; // Set a default color for unknown status
    }
  }
  Future<void> refresh() async {
    filterTaskList= await TaskListService().fetchTask();
    notifyListeners();
  }
  void onRowClick(BuildContext context, TaskList? farmresList) {
    Navigator.pushNamed(
      context,
      Routes.updateTaskScreen,
      arguments: UpdateTaskScreenArguments(updateTaskId: farmresList?.name ?? ""),
    );
  }
}