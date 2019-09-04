Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E92D9A7931
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2019 05:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfIDDSK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Sep 2019 23:18:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727716AbfIDDSK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Sep 2019 23:18:10 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 87A033582503684AEB5C;
        Wed,  4 Sep 2019 11:18:08 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Sep 2019 11:18:00 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 5/5] RDMA/hns: Fix a spelling mistake in a macro
Date:   Wed, 4 Sep 2019 11:14:45 +0800
Message-ID: <1567566885-23088-6-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1567566885-23088-1-git-send-email-liweihang@hisilicon.com>
References: <1567566885-23088-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

HNS_ROCE_ALOGN_UP should be HNS_ROCE_ALIGN_UP, this patch fix it.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index c810898..cbd75e4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -45,7 +45,7 @@
 
 #define HNS_ROCE_MAX_MSG_LEN			0x80000000
 
-#define HNS_ROCE_ALOGN_UP(a, b) ((((a) + (b) - 1) / (b)) * (b))
+#define HNS_ROCE_ALIGN_UP(a, b) ((((a) + (b) - 1) / (b)) * (b))
 
 #define HNS_ROCE_IB_MIN_SQ_STRIDE		6
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 8868172..17d327e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -391,37 +391,37 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
 
 	/* Get buf size, SQ and RQ  are aligned to page_szie */
 	if (hr_dev->caps.max_sq_sg <= 2) {
-		hr_qp->buff_size = HNS_ROCE_ALOGN_UP((hr_qp->rq.wqe_cnt <<
+		hr_qp->buff_size = HNS_ROCE_ALIGN_UP((hr_qp->rq.wqe_cnt <<
 					     hr_qp->rq.wqe_shift), PAGE_SIZE) +
-				   HNS_ROCE_ALOGN_UP((hr_qp->sq.wqe_cnt <<
+				   HNS_ROCE_ALIGN_UP((hr_qp->sq.wqe_cnt <<
 					     hr_qp->sq.wqe_shift), PAGE_SIZE);
 
 		hr_qp->sq.offset = 0;
-		hr_qp->rq.offset = HNS_ROCE_ALOGN_UP((hr_qp->sq.wqe_cnt <<
+		hr_qp->rq.offset = HNS_ROCE_ALIGN_UP((hr_qp->sq.wqe_cnt <<
 					     hr_qp->sq.wqe_shift), PAGE_SIZE);
 	} else {
 		page_size = 1 << (hr_dev->caps.mtt_buf_pg_sz + PAGE_SHIFT);
 		hr_qp->sge.sge_cnt = ex_sge_num ?
 		   max(page_size / (1 << hr_qp->sge.sge_shift), ex_sge_num) : 0;
-		hr_qp->buff_size = HNS_ROCE_ALOGN_UP((hr_qp->rq.wqe_cnt <<
+		hr_qp->buff_size = HNS_ROCE_ALIGN_UP((hr_qp->rq.wqe_cnt <<
 					     hr_qp->rq.wqe_shift), page_size) +
-				   HNS_ROCE_ALOGN_UP((hr_qp->sge.sge_cnt <<
+				   HNS_ROCE_ALIGN_UP((hr_qp->sge.sge_cnt <<
 					     hr_qp->sge.sge_shift), page_size) +
-				   HNS_ROCE_ALOGN_UP((hr_qp->sq.wqe_cnt <<
+				   HNS_ROCE_ALIGN_UP((hr_qp->sq.wqe_cnt <<
 					     hr_qp->sq.wqe_shift), page_size);
 
 		hr_qp->sq.offset = 0;
 		if (ex_sge_num) {
-			hr_qp->sge.offset = HNS_ROCE_ALOGN_UP(
+			hr_qp->sge.offset = HNS_ROCE_ALIGN_UP(
 							(hr_qp->sq.wqe_cnt <<
 							hr_qp->sq.wqe_shift),
 							page_size);
 			hr_qp->rq.offset = hr_qp->sge.offset +
-					HNS_ROCE_ALOGN_UP((hr_qp->sge.sge_cnt <<
+					HNS_ROCE_ALIGN_UP((hr_qp->sge.sge_cnt <<
 						hr_qp->sge.sge_shift),
 						page_size);
 		} else {
-			hr_qp->rq.offset = HNS_ROCE_ALOGN_UP(
+			hr_qp->rq.offset = HNS_ROCE_ALIGN_UP(
 							(hr_qp->sq.wqe_cnt <<
 							hr_qp->sq.wqe_shift),
 							page_size);
@@ -591,19 +591,19 @@ static int hns_roce_set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 	/* Get buf size, SQ and RQ are aligned to PAGE_SIZE */
 	page_size = 1 << (hr_dev->caps.mtt_buf_pg_sz + PAGE_SHIFT);
 	hr_qp->sq.offset = 0;
-	size = HNS_ROCE_ALOGN_UP(hr_qp->sq.wqe_cnt << hr_qp->sq.wqe_shift,
+	size = HNS_ROCE_ALIGN_UP(hr_qp->sq.wqe_cnt << hr_qp->sq.wqe_shift,
 				 page_size);
 
 	if (hr_dev->caps.max_sq_sg > 2 && hr_qp->sge.sge_cnt) {
 		hr_qp->sge.sge_cnt = max(page_size/(1 << hr_qp->sge.sge_shift),
 					(u32)hr_qp->sge.sge_cnt);
 		hr_qp->sge.offset = size;
-		size += HNS_ROCE_ALOGN_UP(hr_qp->sge.sge_cnt <<
+		size += HNS_ROCE_ALIGN_UP(hr_qp->sge.sge_cnt <<
 					  hr_qp->sge.sge_shift, page_size);
 	}
 
 	hr_qp->rq.offset = size;
-	size += HNS_ROCE_ALOGN_UP((hr_qp->rq.wqe_cnt << hr_qp->rq.wqe_shift),
+	size += HNS_ROCE_ALIGN_UP((hr_qp->rq.wqe_cnt << hr_qp->rq.wqe_shift),
 				  page_size);
 	hr_qp->buff_size = size;
 
-- 
2.8.1

