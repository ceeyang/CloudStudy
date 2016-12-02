//
//  CourseDetailModel.swift
//  CloudStudy
//
//  Created by pro on 2016/12/2.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

//========================================================
//MARK: - 课程详情模型 -
//========================================================
class CourseDetailModel: NSObject {
    var id            : String?  /**< id */
    var name          : String?  /**< 课程名称 */
    var cover         : String?  /**< 课程封面 */
    var completed_rate: String?  /**< 课程学习进度 */
    var Description   : String?  /**< 课程描述 */
    var exam_id       : String?  /**< 考试id   : 根据这个exam_id来判断当前课程是否配置了课后考试 */
    var exam_status   : String?  /**< 考试状态  : 0 未通过, 1 通过, 2 待评卷, 3 待考试, 4 不支持APP考试  */
    var register_id   : String?  /**< 课程注册id : 只有报名之后才会返回这个课程注册id*/
    var client_type   : String?  /**< 是否支持app端学习 : 1 PC 端课程, 2 APP 端课程*/
    var apply_status  : String?  /**< 用户状态 : 0 提示无权学习, 1 我要学习, 2 审核中, 3 重新申请, 4 申请通过, 5 申请失败 */
    var is_favourited : String?  /**< 是否已收藏 : 0 未收藏, 1 已收藏 */
    var is_scored     : String?  /**< 是否已评分 : 0 暂未评分, 其他数字代表对应分数 */
    var can_abandon   : String?  /**< 是否允许放弃: 0 不允许, 1 允许 */
    
    var list          : Array<Any> = []
}



//========================================================
//MARK: - 课件模型 -
//========================================================
class CoursewareModel: NSObject {
    var id            : String?
    var name          : String?
    var register_id   : String?
    var scorm_type    : String?  /**< 课件的资源类型 : 1 标准可见, 2 视频, 3 音频, 4 文档, 5 URL */
    var itemlist      : Array<Any> = []
}



//========================================================
// MARK: - 课件章节模型 -
//========================================================
class CourseChapterModel: NSObject {
    var item_id         : String?  /**< 章节id */
    var launch          : String?  /**< 章节url地址 */
    var title           : String?  /**< 章节标题 */
    var course_id       : String?  /**< 课程 id */
    var param_string    : String?  /**< 章节时长 */
    var user_name       : String?
    var control_no      : String?  /**< <#注释#> */
    var item_type       : String?  /**< 章节的资源类型 : sco、asset、video(视频/音频)、file、jsp */
    var lesson_location : String?  /**< 每一节的播放进度 */
    var lesson_status   : String?  /**< 章节的学习状态 : passed：通过, completed:已完成, browsed:浏览, incomplete:非完成, failed:失败, not attempted:未尝试 */
}
