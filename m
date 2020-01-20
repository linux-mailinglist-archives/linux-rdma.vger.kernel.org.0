Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F36401424F2
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 09:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgATIXh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 03:23:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbgATIXg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jan 2020 03:23:36 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E847AEFFC24881C63FA6;
        Mon, 20 Jan 2020 16:23:31 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 Jan 2020 16:23:25 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/7] RDMA/hns: Optimize qp destroy flow
Date:   Mon, 20 Jan 2020 16:19:31 +0800
Message-ID: <1579508377-55818-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1579508377-55818-1-git-send-email-liweihang@huawei.com>
References: <1579508377-55818-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Wrap the duplicate code in hip08 and hip06 qp destruction process as
hns_roce_qp_destroy() to simply the qp destroy flow.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  5 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 19 ++-----------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 39 +--------------------------
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 41 +++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 58 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index a7c4ff9..1f361e6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1248,9 +1248,8 @@ void hns_roce_lock_cqs(struct hns_roce_cq *send_cq,
 void hns_roce_unlock_cqs(struct hns_roce_cq *send_cq,
 			 struct hns_roce_cq *recv_cq);
 void hns_roce_qp_remove(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp);
-void hns_roce_qp_free(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp);
-void hns_roce_release_range_qp(struct hns_roce_dev *hr_dev, int base_qpn,
-			       int cnt);
+void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
+			 struct ib_udata *udata);
 __be32 send_ieth(const struct ib_send_wr *wr);
 int to_hr_qp_type(int qp_type);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index c6e6658..fe37e6f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -3623,26 +3623,11 @@ int hns_roce_v1_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 		if (send_cq && send_cq != recv_cq)
 			__hns_roce_v1_cq_clean(send_cq, hr_qp->qpn, NULL);
 	}
-	hns_roce_unlock_cqs(send_cq, recv_cq);
-
 	hns_roce_qp_remove(hr_dev, hr_qp);
-	hns_roce_qp_free(hr_dev, hr_qp);
-
-	/* RC QP, release QPN */
-	if (hr_qp->ibqp.qp_type == IB_QPT_RC)
-		hns_roce_release_range_qp(hr_dev, hr_qp->qpn, 1);
-
-	hns_roce_mtt_cleanup(hr_dev, &hr_qp->mtt);
-
-	ib_umem_release(hr_qp->umem);
-	if (!udata) {
-		kfree(hr_qp->sq.wrid);
-		kfree(hr_qp->rq.wrid);
+	hns_roce_unlock_cqs(send_cq, recv_cq);
 
-		hns_roce_buf_free(hr_dev, hr_qp->buff_size, &hr_qp->hr_buf);
-	}
+	hns_roce_qp_destroy(hr_dev, hr_qp, udata);
 
-	kfree(hr_qp);
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 12c4cd8..5dbff86 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5032,43 +5032,6 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 	hns_roce_unlock_cqs(send_cq, recv_cq);
 	spin_unlock_irqrestore(&hr_dev->qp_list_lock, flags);
 
-	hns_roce_qp_free(hr_dev, hr_qp);
-
-	/* Not special_QP, free their QPN */
-	if ((hr_qp->ibqp.qp_type == IB_QPT_RC) ||
-	    (hr_qp->ibqp.qp_type == IB_QPT_UC) ||
-	    (hr_qp->ibqp.qp_type == IB_QPT_UD))
-		hns_roce_release_range_qp(hr_dev, hr_qp->qpn, 1);
-
-	hns_roce_mtr_cleanup(hr_dev, &hr_qp->mtr);
-
-	if (udata) {
-		struct hns_roce_ucontext *context =
-			rdma_udata_to_drv_context(
-				udata,
-				struct hns_roce_ucontext,
-				ibucontext);
-
-		if (hr_qp->sq.wqe_cnt && (hr_qp->sdb_en == 1))
-			hns_roce_db_unmap_user(context, &hr_qp->sdb);
-
-		if (hr_qp->rq.wqe_cnt && (hr_qp->rdb_en == 1))
-			hns_roce_db_unmap_user(context, &hr_qp->rdb);
-	} else {
-		kfree(hr_qp->sq.wrid);
-		kfree(hr_qp->rq.wrid);
-		hns_roce_buf_free(hr_dev, hr_qp->buff_size, &hr_qp->hr_buf);
-		if (hr_qp->rq.wqe_cnt)
-			hns_roce_free_db(hr_dev, &hr_qp->rdb);
-	}
-	ib_umem_release(hr_qp->umem);
-
-	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
-	     hr_qp->rq.wqe_cnt) {
-		kfree(hr_qp->rq_inl_buf.wqe_list[0].sg_list);
-		kfree(hr_qp->rq_inl_buf.wqe_list);
-	}
-
 	return ret;
 }
 
@@ -5083,7 +5046,7 @@ static int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 		ibdev_err(&hr_dev->ib_dev, "Destroy qp 0x%06lx failed(%d)\n",
 			  hr_qp->qpn, ret);
 
-	kfree(hr_qp);
+	hns_roce_qp_destroy(hr_dev, hr_qp, udata);
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 7c8de1e..748a867 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1035,6 +1035,47 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
+void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
+			 struct ib_udata *udata)
+{
+	hns_roce_qp_free(hr_dev, hr_qp);
+
+	/* Not special_QP, free their QPN */
+	if (hr_qp->ibqp.qp_type != IB_QPT_GSI)
+		hns_roce_release_range_qp(hr_dev, hr_qp->qpn, 1);
+
+	hns_roce_mtr_cleanup(hr_dev, &hr_qp->mtr);
+
+	if (udata) {
+		struct hns_roce_ucontext *context =
+			rdma_udata_to_drv_context(
+				udata,
+				struct hns_roce_ucontext,
+				ibucontext);
+
+		if (hr_qp->sq.wqe_cnt && (hr_qp->sdb_en == 1))
+			hns_roce_db_unmap_user(context, &hr_qp->sdb);
+
+		if (hr_qp->rq.wqe_cnt && (hr_qp->rdb_en == 1))
+			hns_roce_db_unmap_user(context, &hr_qp->rdb);
+	} else {
+		kfree(hr_qp->sq.wrid);
+		kfree(hr_qp->rq.wrid);
+		hns_roce_buf_free(hr_dev, hr_qp->buff_size, &hr_qp->hr_buf);
+		if (hr_qp->rq.wqe_cnt)
+			hns_roce_free_db(hr_dev, &hr_qp->rdb);
+	}
+	ib_umem_release(hr_qp->umem);
+
+	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
+	     hr_qp->rq.wqe_cnt) {
+		kfree(hr_qp->rq_inl_buf.wqe_list[0].sg_list);
+		kfree(hr_qp->rq_inl_buf.wqe_list);
+	}
+
+	kfree(hr_qp);
+}
+
 struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 				 struct ib_qp_init_attr *init_attr,
 				 struct ib_udata *udata)
-- 
2.8.1

