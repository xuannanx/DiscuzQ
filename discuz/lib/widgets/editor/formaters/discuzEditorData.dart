import 'package:flutter/material.dart';

import 'package:discuzq/models/attachmentsModel.dart';
import 'package:discuzq/models/categoryModel.dart';
import 'package:discuzq/models/postModel.dart';
import 'package:discuzq/models/threadModel.dart';

class DiscuzEditorData {
  ///
  /// 类型，默认不用传入
  final String type;

  ///
  /// 关联的数据
  final DiscuzEditorDataRelationships relationships;

  ///
  /// 用户编辑的数据
  final DiscuzEditorDataAttributes attributes;

  DiscuzEditorData(
      {this.type = 'threads',

      /// 默认发帖
      this.relationships,
      this.attributes});

  ///
  /// 更新
  static DiscuzEditorData fromDiscuzEditorData(DiscuzEditorData data,
          {String captchaRandSTR,
          captchaTicket,
          content,
          ThreadModel thread,
          PostModel post,
          @required CategoryModel cat,
          List<AttachmentsModel> attachments = const []}) =>
      DiscuzEditorData(

          /// 发帖，还是评论？
          type: post == null ? 'threads' : 'posts',
          relationships: DiscuzEditorDataRelationships(
              thread: thread,
              category: cat,
              attachments: attachments ?? const []),
          attributes: DiscuzEditorDataAttributes(
              captchaRandSTR: captchaRandSTR ?? '',
              captchaTicket: captchaTicket ?? '',
              replyId: post == null ? 0 : post.id,
              content: content ?? ''));
}

///
/// 提交数据时，编辑器关联的数据
/// 包含附件
/// 视频
/// 图片
class DiscuzEditorDataRelationships {
  ///
  /// 关联的分类
  /// category: {data: {type: "categories", id: "3"}}
  /// data: {type: "categories", id: "3"}
  final CategoryModel category;

  ///
  /// 关联的附件
  /// data: []
  final List<AttachmentsModel> attachments;

  ///
  /// 回复时会关联帖子thread主题的信息
  /// 没有thread则会变成发帖
  final ThreadModel thread;

  const DiscuzEditorDataRelationships(
      {this.category, this.attachments = const [], this.thread});
}

///
/// 用于提交的编辑器数据
class DiscuzEditorDataAttributes {
  ///
  /// 腾讯云验证码随机字符串
  final String captchaRandSTR;

  ///
  /// 验证码票据
  final String captchaTicket;

  ///
  /// 内容
  final String content;

  ///
  /// 类型
  final int type;

  ///
  /// 关联的回复ID
  /// 当回复模式的时候，要提供replyId 即目标Post的ID
  final int replyId;

  const DiscuzEditorDataAttributes(
      {this.captchaRandSTR = '',
      this.captchaTicket = '',
      this.content = '',
      this.replyId = 0,
      this.type = 0});
}
