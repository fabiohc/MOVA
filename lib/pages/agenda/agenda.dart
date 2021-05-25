import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:flutter/material.dart';
import 'package:emanuellemepoupe/pages/menu.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:emanuellemepoupe/controller/agenda_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Agenda extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _AgendaState createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  Map<DateTime, List<NeatCleanCalendarEvent>> _events = {};
  final agendaController = AgendaController();

  @override
  initState() {
    super.initState();
    _handleNewDate(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));

    agendaController.obtenhaEventosAgenda().then((list) {
      setState(() {
        _events = list;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: Colors.white,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.white),
            elevation: 0.0,
            brightness: Brightness.dark,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new MenuInicio())),
                  icon: SvgPicture.asset(
                    "assets/icons/Voltar ICon.svg",
                    color: Colors.amber,
                  ),
                ),
                // Your widgets here
              ],
            )),
        body: SafeArea(
          child: Calendar(
            startOnMonday: true,
            weekDays: ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab', 'Dom'],
            events: _events,
            isExpandable: true,
            eventDoneColor: Colors.green,
            selectedColor: Colors.blueAccent,
            todayColor: Colors.blue,
            eventColor: Colors.grey,            
            bottomBarTextStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 15,),
            locale: 'pt_BR',
            todayButtonText: 'Ir para data de hoje',
            expandableDateFormat: 'EEEE, dd. MMMM yyyy',
            dayOfWeekStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 15),                
            eventListBuilder: _eventListBuilder,
            bottomBarArrowColor: Colors.black,
            bottomBarColor: Colors.amberAccent,
            hideArrows: true,
            hideBottomBar: true,
            hideTodayIcon: false,
            isExpanded: true,
            onDateSelected: (date) async {
              _events = await agendaController.obtenhaEventosAgenda(); 
              setState(() {
                _events = _events;
              });

              print("onDateSelected " + date.toString());
            },
            onEventSelected: (evento) {
              print("onEventSelected " + evento.toString());
            },
            onExpandStateChanged: (expand) {
              print("onExpandStateChanged " + expand.toString());
            },
            onMonthChanged: (data) {
              print("onMonthChanged " + data.toString());
            },
            onRangeSelected: (range) {
              print("onRangeSelected " + range.toString());
            },
          ),
        ),
        floatingActionButton: new FloatingActionButton(
            elevation: 10.0,
            child: new Icon(Icons.add),
            backgroundColor: new Color(0xFFE57373),
            onPressed: () {
              Navigator.of(context).pushNamed(RotasNavegacao.CADASTRO_EVENTO);
            }));
  }

  /// This function [_buildEventList] constructs the list of events5 of a selected day. This
  /// list is rendered below the week view or the month view.
  Widget _eventListBuilder(
      BuildContext context, List<NeatCleanCalendarEvent> eventList) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(0.0),
        itemBuilder: (BuildContext context, int index) {
          final NeatCleanCalendarEvent event = eventList[index];
          final String start =
              DateFormat('HH:mm').format(event.startTime).toString();
          final String end =
              DateFormat('HH:mm').format(event.endTime).toString();
          return ListTile(
            contentPadding:
                EdgeInsets.only(left: 2.0, right: 8.0, top: 2.0, bottom: 2.0),
            leading: Container(
              width: 10.0,
              color: event.color,
            ),
            title: Text(event.summary),
            subtitle:
                event.description.isNotEmpty ? Text(event.description) : null,
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(start), Text(end)],
            ),
            onTap: () async {
              print("toque"); 
             var evento =  await agendaController.preparaEditarEvento(event);
              
              Navigator.of(context).pushReplacementNamed(
                  RotasNavegacao.EDITAR_EVENTO,
                  arguments: evento);
            },
          );
        },
        itemCount: eventList.length,
      ),
    );
  }

  void _handleNewDate(date) {
    print('Date selected: $date');
  }
}
