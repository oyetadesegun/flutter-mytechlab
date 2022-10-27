// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:mytechlab/components/constants/colors.dart';
import 'package:mytechlab/components/constants/constant.dart';
import 'package:video_player/video_player.dart';

import 'widget/best_seller_clipper.dart';
//import 'widget/video_tile.dart';

class DetailsScreen extends StatefulWidget {
  final String courseId;
  final String courseImage;
  final String courseTitle;
  final Map<String, dynamic> videos;
  final int students;
  final num rating;
  final num discount;
  final num price;

  const DetailsScreen({
    Key? key,
    required this.courseId,
    required this.courseImage,
    required this.courseTitle,
    required this.videos,
    required this.students,
    required this.rating,
    required this.discount,
    required this.price,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isDone = true;
  late VideoPlayerController videoController;
  void _playVideo({int index = 0, bool init = false}) {
    if (index < 0 || index >= widget.videos.keys.toList().length) return;
    videoController =
        VideoPlayerController.network(widget.videos.values.toList()[index])
          ..addListener(() => setState(() {}))
          ..setLooping(true)
          ..initialize().then((value) => videoController.play());
  }

  String videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  void initState() {
    _playVideo(init: true);
    super.initState();
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Video player is =>: $videoController');
    final List<String> videoTitles = widget.videos.keys.toList();
    final List<dynamic> videoLink = widget.videos.values.toList();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            image: DecorationImage(
                image: NetworkImage(widget.courseImage),
                alignment: Alignment.topRight)),
        child: Column(
          children: [
            //     ? Screen(widget: widget)

            Container(
                color: Colors.deepPurpleAccent,
                height: 300,
                width: MediaQuery.of(context).size.width,
                child:
                    // videoController.value.isInitialized
                    // ?
                    Column(
                  children: [
                    SizedBox(height: 200, child: VideoPlayer(videoController)),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ValueListenableBuilder(
                            valueListenable: videoController,
                            builder: (context, VideoPlayerValue value, child) {
                              return Text(videoDuration(value.position),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ));
                            }),
                        Expanded(
                            child: SizedBox(
                          height: 20,
                          child: VideoProgressIndicator(videoController,
                              allowScrubbing: true,
                              padding: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 12,
                              )),
                        ))
                      ],
                    )
                  ],
                )
                //  : Screen(widget: widget),
                ),
            const SizedBox(height: 10),
            Expanded(
                child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Course Content', style: kTitleTextStyle),
                        const SizedBox(height: 30),
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: videoTitles.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      _playVideo();
                                      setState(() {
                                        isDone = !isDone;
                                      });
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '0${(videoTitles.indexOf(videoTitles[index]) + 1).toString().substring(0)}',
                                          style: kHeadingextStyle.copyWith(
                                              color:
                                                  kTextColor.withOpacity(.15),
                                              fontSize: 32),
                                        ),
                                        const SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              videoTitles[index],
                                              maxLines: 2,
                                              style:
                                                  kSubtitleTextSyule.copyWith(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 1.5),
                                            ),
                                            Text('5.35 mins',
                                                style: TextStyle(
                                                    color: kTextColor
                                                        .withOpacity(.5),
                                                    fontSize: 18)),
                                          ],
                                        ),
                                        const Spacer(),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 20),
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: kAccent.withOpacity(
                                                  isDone ? .5 : 1)),
                                          child: const Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                                // VideoTile(
                                //   videoTitles: videoTitles,
                                //   name: videoTitles[index],
                                //   videoNumber:
                                //       '0${(videoTitles.indexOf(videoTitles[index]) + 1).toString().substring(0)}',
                                //   duration: '5.35 mins',
                                //   isDone: isDone,
                                //   index: index,
                                //   videoLink: videoLink[index].toString(),
                                // );
                              }),
                        )
                      ],
                    ),
                  ),
                  // Positioned(
                  //   right: 0,
                  //   left: 0,
                  //   bottom: 0,
                  //   child: Container(
                  //     padding: const EdgeInsets.all(20),
                  //     decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(40),
                  //         boxShadow: [
                  //           BoxShadow(
                  //               offset: const Offset(0, 4),
                  //               blurRadius: 50,
                  //               color: kTextColor.withOpacity(.1)),
                  //         ]),
                  //     height: 70,
                  //     width: double.infinity,
                  //     child: Row(children: [
                  //       Container(
                  //         //  padding: const EdgeInsets.all(14),
                  //         height: 56,
                  //         width: 80,
                  //         decoration: BoxDecoration(
                  //             color: const Color(0xFFFFEDEE),
                  //             borderRadius: BorderRadius.circular(40)),
                  //         child: IconButton(
                  //           color: kAccent,
                  //           icon: const Icon(
                  //             Icons.shopping_cart_checkout_outlined,
                  //           ),
                  //           onPressed: () {
                  //             Navigator.pop(context);
                  //           },
                  //         ),
                  //       ),
                  //       const SizedBox(width: 20),
                  //       Expanded(
                  //         child: Container(
                  //           alignment: Alignment.center,
                  //           height: 56,
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(40),
                  //               color: kBlueColor),
                  //           child: Text(
                  //             'Apply Now',
                  //             style: kSubtitleTextSyule.copyWith(
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //         ),
                  //       )
                  //     ]),
                  //   ),
                  //  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class Screen extends StatelessWidget {
  const Screen({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final DetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 50, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white54, shape: BoxShape.circle),
                      height: 40,
                      width: 40,
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 22,
                      ))),
              InkWell(
                  onTap: () {}, // => Navigator.pop(context),
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white54, shape: BoxShape.circle),
                      height: 40,
                      width: 40,
                      child: const Icon(
                        Icons.more_vert,
                        size: 22,
                      ))),
            ],
          ),
          const SizedBox(height: 30),
          ClipPath(
            clipper: BestSellerClipper(),
            child: Container(
              color: kAccent,
              padding:
                  const EdgeInsets.only(left: 10, top: 5, right: 20, bottom: 5),
              child: Text(
                'Beginner'.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                widget.courseTitle,
                style: kHeadingextStyle,
              )),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.person),
              const SizedBox(width: 5),
              Text(widget.students.toString()),
              const SizedBox(width: 20),
              const Icon(Icons.star_rate),
              const SizedBox(width: 5),
              Text(widget.rating.toStringAsFixed(1)),
              const Spacer(),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: widget.discount == 0
                        ? 'FREE'
                        : widget.discount.toStringAsFixed(2),
                    style: kHeadingextStyle.copyWith(fontSize: 32)),
                TextSpan(
                    text: '₦${widget.price.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: kTextColor.withOpacity(.5),
                        decoration: TextDecoration.lineThrough))
              ]))
            ],
          ),
        ],
      ),
    );
  }
}
