// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// import '../../../components/constants/colors.dart';
// import '../../../components/constants/constant.dart';

// class VideoTile extends StatefulWidget {
//   const VideoTile({
//     Key? key,
//     required this.videoLink,
//     required this.videoList,
//     required this.videoNumber,
//     required this.name,
//     required this.duration,
//     required this.isDone,
//     required this.index,
//   }) : super(key: key);

//   final List<String> videoList;
//   final String videoLink;
//   final String videoNumber;
//   final String name;
//   final String duration;
//   final bool isDone;
//   final int index;
//   @override
//   State<VideoTile> createState() => _VideoTileState();
// }

// class _VideoTileState extends State<VideoTile> {
//   late VideoPlayerController videoController;
//   bool isDone = false;

  // void _playVideo(int index, {bool init = false}) {
  //   if (index < 0 || index >= widget.videoList.length) return;
  //   videoController = VideoPlayerController.network(widget.videoLink[index])
  //     ..addListener(() => setState(() {}))
  //     ..setLooping(true)
  //     ..initialize().then((value) => videoController.play());
  // }

  // @override
  // void initState() {
  //   _playVideo(widget.index, init: true);
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   videoController.dispose();
  //   super.dispose();
  // }

  // @override
  // Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.only(bottom: 20),
    //   child: GestureDetector(
    //     onTap: () {
    //       _playVideo(widget.index);
    //       setState(() {
    //         isDone = !isDone;
    //       });
    //     },
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           widget.videoNumber,
    //           style: kHeadingextStyle.copyWith(
    //               color: kTextColor.withOpacity(.15), fontSize: 32),
    //         ),
    //         const SizedBox(width: 20),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               widget.name,
    //               maxLines: 2,
    //               style: kSubtitleTextSyule.copyWith(
    //                   overflow: TextOverflow.ellipsis,
    //                   fontWeight: FontWeight.w600,
    //                   height: 1.5),
    //             ),
    //             Text(widget.duration,
    //                 style: TextStyle(
    //                     color: kTextColor.withOpacity(.5), fontSize: 18)),
    //           ],
    //         ),
    //         const Spacer(),
    //         Container(
    //           margin: const EdgeInsets.only(left: 20),
    //           height: 40,
    //           width: 40,
    //           decoration: BoxDecoration(
    //               shape: BoxShape.circle,
    //               color: kAccent.withOpacity(isDone ? .5 : 1)),
    //           child: const Icon(
    //             Icons.play_arrow,
    //             color: Colors.white,
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  //}
// }
