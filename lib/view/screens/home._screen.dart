import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_1/constants/routes.dart';
import 'package:task_1/controller/home_controller.dart';
import 'package:task_1/model/item.dart';
import 'package:task_1/shared/app_bar.dart';
import 'package:task_1/shared/bottom_navigation_bar.dart';
import 'package:task_1/shared/drawer.dart';
import 'package:task_1/shared/loading_indicator.dart';
import 'package:task_1/view/widgets/post_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final double height = 10;
  final HomeController hc = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          drawer: buildDrawer(context, ScreenRoutes.homeRoute),
            appBar: BaseAppBar(
          title: Text('Home'),
          appBar: AppBar(),
          widgets: []),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 10),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                Image.asset("assets/images/profile.png").image,
                            radius: 16,
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                  padding: EdgeInsets.all(5.5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      borderRadius: BorderRadius.circular(90.0),
                                      color: Colors.green)))
                        ],
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(ScreenRoutes.createPostRoute);
                            },
                            child: TextFormField(
                              maxLines: null,
                              enabled: false,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                fillColor: Colors.grey[200],
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.0,
                                  horizontal: 16.0,
                                ),
                                hintText: 'What\'s on your mind?',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => hc.items.isEmpty
                        ? const LoadingIndicator()
                        : ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                         //   physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            controller: hc.sc,
                            itemBuilder: (context, index) {
                              if (index < hc.items.length) {
                                Item item = hc.items[index];
                                return PostCard(
                                  item: item,
                                );
                              } else {
                                
                                  return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 40),
                                      child: 
                                      Obx(() =>   hc.isLoadMoreRunning? const Center(
                                          child: LoadingIndicator())
                                          : Text(
                                            "You have fetched all of this content")
                                          )
                                    );
                                
                            
                                // if (!hc.hasNextPage) {
                                //   return Container(
                                //     padding: const EdgeInsets.only(
                                //         top: 30, bottom: 40),
                                //     color: Colors.blue,
                                //     child: const Center(
                                //         child: Text(
                                //             "You have fetched all of this content")),
                                //   );
                                // }
                              }
                            
                              // if (hc.hasNextPage == false)
                              // return  Container(
                              //     padding: const EdgeInsets.only(top: 30, bottom: 40),
                              //     color: Colors.blue,
                              //     child: const Center(
                              //         child: Text(
                              //             "You have fetched all of this content")),
                              //   );
                            },
                            itemCount: hc.items.length + 1,
                          ),
                  ),
                )
                // if (hc.isLoadMoreRunning)
                //   const Padding(
                //     padding: EdgeInsets.only(top: 10, bottom: 40),
                //     child: Center(
                //       child: LoadingIndicator(),
                //     ),
                //   ),
                // if (hc.hasNextPage == false)
                //   Container(
                //     padding: const EdgeInsets.only(top: 30, bottom: 40),
                //     color: Colors.blue,
                //     child: const Center(
                //         child: Text(
                //             "You have fetched all of this content")),
                //   )
              ],
            ),
            bottomNavigationBar: BottomNavBar()));
  }
}
