Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2A413121E
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2020 13:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgAFMZL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jan 2020 07:25:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8225 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbgAFMZK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jan 2020 07:25:10 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9FB2D77007F40C9931D9;
        Mon,  6 Jan 2020 20:25:09 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 Jan 2020 20:25:00 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 6/7] RDMA/hns: Replace custom macros HNS_ROCE_ALIGN_UP
Date:   Mon, 6 Jan 2020 20:21:15 +0800
Message-ID: <1578313276-29080-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1578313276-29080-1-git-send-email-liweihang@huawei.com>
References: <1578313276-29080-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

HNS_ROCE_ALIGN_UP can be replaced by round_up() which is defined in
kernel.h.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 --
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 44 +++++++++++++----------------
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 19366a5..0a716f5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -45,8 +45,6 @@
 
 #define HNS_ROCE_MAX_MSG_LEN			0x80000000
 
-#define HNS_ROCE_ALIGN_UP(a, b) ((((a) + (b) - 1) / (b)) * (b))
-
 #define HNS_ROCE_IB_MIN_SQ_STRIDE		6
 
 #define HNS_ROCE_BA_SIZE			(32 * 4096)
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index a6565b6..c5b01ec 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -393,40 +393,38 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
 
 	/* Get buf size, SQ and RQ  are aligned to page_szie */
 	if (hr_dev->caps.max_sq_sg <= 2) {
-		hr_qp->buff_size = HNS_ROCE_ALIGN_UP((hr_qp->rq.wqe_cnt <<
+		hr_qp->buff_size = round_up((hr_qp->rq.wqe_cnt <<
 					     hr_qp->rq.wqe_shift), PAGE_SIZE) +
-				   HNS_ROCE_ALIGN_UP((hr_qp->sq.wqe_cnt <<
+				   round_up((hr_qp->sq.wqe_cnt <<
 					     hr_qp->sq.wqe_shift), PAGE_SIZE);
 
 		hr_qp->sq.offset = 0;
-		hr_qp->rq.offset = HNS_ROCE_ALIGN_UP((hr_qp->sq.wqe_cnt <<
+		hr_qp->rq.offset = round_up((hr_qp->sq.wqe_cnt <<
 					     hr_qp->sq.wqe_shift), PAGE_SIZE);
 	} else {
 		page_size = 1 << (hr_dev->caps.mtt_buf_pg_sz + PAGE_SHIFT);
 		hr_qp->sge.sge_cnt = ex_sge_num ?
 		   max(page_size / (1 << hr_qp->sge.sge_shift), ex_sge_num) : 0;
-		hr_qp->buff_size = HNS_ROCE_ALIGN_UP((hr_qp->rq.wqe_cnt <<
+		hr_qp->buff_size = round_up((hr_qp->rq.wqe_cnt <<
 					     hr_qp->rq.wqe_shift), page_size) +
-				   HNS_ROCE_ALIGN_UP((hr_qp->sge.sge_cnt <<
+				   round_up((hr_qp->sge.sge_cnt <<
 					     hr_qp->sge.sge_shift), page_size) +
-				   HNS_ROCE_ALIGN_UP((hr_qp->sq.wqe_cnt <<
+				   round_up((hr_qp->sq.wqe_cnt <<
 					     hr_qp->sq.wqe_shift), page_size);
 
 		hr_qp->sq.offset = 0;
 		if (ex_sge_num) {
-			hr_qp->sge.offset = HNS_ROCE_ALIGN_UP(
-							(hr_qp->sq.wqe_cnt <<
-							hr_qp->sq.wqe_shift),
-							page_size);
+			hr_qp->sge.offset = round_up((hr_qp->sq.wqe_cnt <<
+						      hr_qp->sq.wqe_shift),
+						     page_size);
 			hr_qp->rq.offset = hr_qp->sge.offset +
-					HNS_ROCE_ALIGN_UP((hr_qp->sge.sge_cnt <<
-						hr_qp->sge.sge_shift),
-						page_size);
+					   round_up((hr_qp->sge.sge_cnt <<
+						     hr_qp->sge.sge_shift),
+						    page_size);
 		} else {
-			hr_qp->rq.offset = HNS_ROCE_ALIGN_UP(
-							(hr_qp->sq.wqe_cnt <<
-							hr_qp->sq.wqe_shift),
-							page_size);
+			hr_qp->rq.offset = round_up((hr_qp->sq.wqe_cnt <<
+						     hr_qp->sq.wqe_shift),
+						    page_size);
 		}
 	}
 
@@ -593,20 +591,18 @@ static int hns_roce_set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 	/* Get buf size, SQ and RQ are aligned to PAGE_SIZE */
 	page_size = 1 << (hr_dev->caps.mtt_buf_pg_sz + PAGE_SHIFT);
 	hr_qp->sq.offset = 0;
-	size = HNS_ROCE_ALIGN_UP(hr_qp->sq.wqe_cnt << hr_qp->sq.wqe_shift,
-				 page_size);
+	size = round_up(hr_qp->sq.wqe_cnt << hr_qp->sq.wqe_shift, page_size);
 
 	if (hr_dev->caps.max_sq_sg > 2 && hr_qp->sge.sge_cnt) {
 		hr_qp->sge.sge_cnt = max(page_size/(1 << hr_qp->sge.sge_shift),
-					(u32)hr_qp->sge.sge_cnt);
+					 (u32)hr_qp->sge.sge_cnt);
 		hr_qp->sge.offset = size;
-		size += HNS_ROCE_ALIGN_UP(hr_qp->sge.sge_cnt <<
-					  hr_qp->sge.sge_shift, page_size);
+		size += round_up(hr_qp->sge.sge_cnt << hr_qp->sge.sge_shift,
+				 page_size);
 	}
 
 	hr_qp->rq.offset = size;
-	size += HNS_ROCE_ALIGN_UP((hr_qp->rq.wqe_cnt << hr_qp->rq.wqe_shift),
-				  page_size);
+	size += round_up((hr_qp->rq.wqe_cnt << hr_qp->rq.wqe_shift), page_size);
 	hr_qp->buff_size = size;
 
 	/* Get wr and sge number which send */
-- 
2.8.1

