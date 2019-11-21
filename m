Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD2F91047FD
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 02:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfKUBXB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 20:23:01 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7155 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727113AbfKUBXA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Nov 2019 20:23:00 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2A5CBA3166255669410B;
        Thu, 21 Nov 2019 09:22:59 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 21 Nov 2019 09:22:51 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH rdma-core 1/7] libhns: Fix calculation errors with ilog32()
Date:   Thu, 21 Nov 2019 09:19:23 +0800
Message-ID: <1574299169-31457-2-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1574299169-31457-1-git-send-email-liweihang@hisilicon.com>
References: <1574299169-31457-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Current calculation results using ilog32() is larger than expected, which
will lead to driver broken. The following is the log when QP creations
fails:

[   81.294844] hns3 0000:7d:00.0 hns_0: check SQ size error!
[   81.294848] hns3 0000:7d:00.0 hns_0: check SQ size error!
[   81.300225] hns3 0000:7d:00.0 hns_0: Sanity check sq size failed
[   81.300227] hns3 0000:7d:00.0: hns_roce_set_user_sq_size error for create qp
[   81.305602] hns3 0000:7d:00.0 hns_0: Sanity check sq size failed
[   81.305603] hns3 0000:7d:00.0: hns_roce_set_user_sq_size error for create qp
[   81.311589] hns3 0000:7d:00.0 hns_0: Create RC QP 0x000000 failed(-22)
[   81.318603] hns3 0000:7d:00.0 hns_0: Create RC QP 0x000000 failed(-22)

Fixes: b6cd213b276f ("libhns: Refactor for creating qp")
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 providers/hns/hns_roce_u_verbs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/providers/hns/hns_roce_u_verbs.c b/providers/hns/hns_roce_u_verbs.c
index 9d222c0..bd5060d 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -645,7 +645,8 @@ static int hns_roce_calc_qp_buff_size(struct ibv_pd *pd, struct ibv_qp_cap *cap,
 	int page_size = to_hr_dev(pd->context->device)->page_size;
 
 	if (to_hr_dev(pd->context->device)->hw_version == HNS_ROCE_HW_VER1) {
-		qp->rq.wqe_shift = ilog32(sizeof(struct hns_roce_rc_rq_wqe));
+		qp->rq.wqe_shift =
+				ilog32(sizeof(struct hns_roce_rc_rq_wqe)) - 1;
 
 		qp->buf_size = align((qp->sq.wqe_cnt << qp->sq.wqe_shift),
 				     page_size) +
@@ -662,7 +663,7 @@ static int hns_roce_calc_qp_buff_size(struct ibv_pd *pd, struct ibv_qp_cap *cap,
 	} else {
 		unsigned int rqwqe_size = HNS_ROCE_SGE_SIZE * cap->max_recv_sge;
 
-		qp->rq.wqe_shift = ilog32(rqwqe_size);
+		qp->rq.wqe_shift = ilog32(rqwqe_size) - 1;
 
 		if (qp->sq.max_gs > HNS_ROCE_SGE_IN_WQE || type == IBV_QPT_UD)
 			qp->sge.sge_shift = HNS_ROCE_SGE_SHIFT;
@@ -747,8 +748,8 @@ static void hns_roce_set_qp_params(struct ibv_pd *pd,
 		qp->rq.wqe_cnt = roundup_pow_of_two(attr->cap.max_recv_wr);
 	}
 
-	qp->sq.wqe_shift = ilog32(sizeof(struct hns_roce_rc_send_wqe));
-	qp->sq.shift = ilog32(qp->sq.wqe_cnt);
+	qp->sq.wqe_shift = ilog32(sizeof(struct hns_roce_rc_send_wqe)) - 1;
+	qp->sq.shift = ilog32(qp->sq.wqe_cnt) - 1;
 	qp->rq.max_gs = attr->cap.max_recv_sge;
 
 	if (to_hr_dev(pd->context->device)->hw_version == HNS_ROCE_HW_VER1) {
@@ -884,7 +885,7 @@ struct ibv_qp *hns_roce_u_create_qp(struct ibv_pd *pd,
 
 	cmd.buf_addr = (uintptr_t) qp->buf.buf;
 	cmd.log_sq_stride = qp->sq.wqe_shift;
-	cmd.log_sq_bb_count = ilog32(qp->sq.wqe_cnt);
+	cmd.log_sq_bb_count = ilog32(qp->sq.wqe_cnt) - 1;
 
 	pthread_mutex_lock(&context->qp_table_mutex);
 
-- 
2.8.1

