Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9FAEFC21
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 12:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388727AbfKELLr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 06:11:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5719 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388712AbfKELLp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 06:11:45 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6E895C7BA1D905665DCA;
        Tue,  5 Nov 2019 19:11:44 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 19:11:36 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 1/9] RDMA/hns: Delete unnecessary variable max_post
Date:   Tue, 5 Nov 2019 19:07:54 +0800
Message-ID: <1572952082-6681-2-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1572952082-6681-1-git-send-email-liweihang@hisilicon.com>
References: <1572952082-6681-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

There is no need to define max_post in hns_roce_wq, as it does
same thing as wqe_cnt.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 1 -
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index cbd75e4..3ed6b9e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -426,7 +426,6 @@ struct hns_roce_wq {
 	u64		*wrid;     /* Work request ID */
 	spinlock_t	lock;
 	int		wqe_cnt;  /* WQE num */
-	u32		max_post;
 	int		max_gs;
 	int		offset;
 	int		wqe_shift;	/* WQE size */
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index bec48f2..071e9bc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -318,7 +318,7 @@ static int hns_roce_set_rq_size(struct hns_roce_dev *hr_dev,
 					      * hr_qp->rq.max_gs);
 	}
 
-	cap->max_recv_wr = hr_qp->rq.max_post = hr_qp->rq.wqe_cnt;
+	cap->max_recv_wr = hr_qp->rq.wqe_cnt;
 	cap->max_recv_sge = hr_qp->rq.max_gs;
 
 	return 0;
@@ -608,7 +608,7 @@ static int hns_roce_set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 	hr_qp->buff_size = size;
 
 	/* Get wr and sge number which send */
-	cap->max_send_wr = hr_qp->sq.max_post = hr_qp->sq.wqe_cnt;
+	cap->max_send_wr = hr_qp->sq.wqe_cnt;
 	cap->max_send_sge = hr_qp->sq.max_gs;
 
 	/* We don't support inline sends for kernel QPs (yet) */
@@ -1289,7 +1289,7 @@ bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, int nreq,
 	u32 cur;
 
 	cur = hr_wq->head - hr_wq->tail;
-	if (likely(cur + nreq < hr_wq->max_post))
+	if (likely(cur + nreq < hr_wq->wqe_cnt))
 		return false;
 
 	hr_cq = to_hr_cq(ib_cq);
@@ -1297,7 +1297,7 @@ bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, int nreq,
 	cur = hr_wq->head - hr_wq->tail;
 	spin_unlock(&hr_cq->lock);
 
-	return cur + nreq >= hr_wq->max_post;
+	return cur + nreq >= hr_wq->wqe_cnt;
 }
 
 int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev)
-- 
2.8.1

