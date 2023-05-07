import 'package:dartz/dartz.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';

abstract class IDownloadsRrepo {
  Future<Either<MainFailure, List<Downloads>>> getDownloadImages();
}
