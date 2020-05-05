Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C711C5352
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2020 12:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgEEKa2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 May 2020 06:30:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728238AbgEEKa2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 May 2020 06:30:28 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B4876AB07BAA4742809B;
        Tue,  5 May 2020 18:30:25 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 5 May 2020 18:30:16 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/3] RDMA/hns: Combine enable flags of qp
Date:   Tue, 5 May 2020 18:30:07 +0800
Message-ID: <1588674607-25337-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1588674607-25337-1-git-send-email-liweihang@huawei.com>
References: <1588674607-25337-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

It's easier to understand and maintain enable flags of qp using a single
field in type of unsigned long than defining a field for every flags in
the structure hns_roce_qp, and we can add new flags for features more
conveniently in the future.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  7 +++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 22 +++++++++++-----------
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 6ecdd7dd..b6ee875 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -132,8 +132,8 @@ enum {
 };
 
 enum {
-	HNS_ROCE_SUPPORT_RQ_RECORD_DB = 1 << 0,
-	HNS_ROCE_SUPPORT_SQ_RECORD_DB = 1 << 1,
+	HNS_ROCE_QP_CAP_RQ_RECORD_DB = BIT(0),
+	HNS_ROCE_QP_CAP_SQ_RECORD_DB = BIT(1),
 };
 
 enum {
@@ -677,8 +677,7 @@ struct hns_roce_qp {
 	struct hns_roce_wq	rq;
 	struct hns_roce_db	rdb;
 	struct hns_roce_db	sdb;
-	u8			rdb_en;
-	u8			sdb_en;
+	unsigned long		en_flags;
 	u32			doorbell_qpn;
 	u32			sq_signal_bits;
 	struct hns_roce_wq	sq;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 500b4c3..5d5aedd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3546,7 +3546,7 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 	roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_VLAN_ID_M,
 		       V2_QPC_BYTE_24_VLAN_ID_S, 0xfff);
 
-	if (hr_qp->rdb_en)
+	if (hr_qp->en_flags & HNS_ROCE_QP_CAP_RQ_RECORD_DB)
 		roce_set_bit(context->byte_68_rq_db,
 			     V2_QPC_BYTE_68_RQ_RECORD_EN_S, 1);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index d05d3cb..5b1ef08 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -822,8 +822,8 @@ static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 					  "Failed to map user SQ doorbell\n");
 				goto err_out;
 			}
-			hr_qp->sdb_en = 1;
-			resp->cap_flags |= HNS_ROCE_SUPPORT_SQ_RECORD_DB;
+			hr_qp->en_flags |= HNS_ROCE_QP_CAP_SQ_RECORD_DB;
+			resp->cap_flags |= HNS_ROCE_QP_CAP_SQ_RECORD_DB;
 		}
 
 		if (user_qp_has_rdb(hr_dev, init_attr, udata, resp)) {
@@ -834,8 +834,8 @@ static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 					  "Failed to map user RQ doorbell\n");
 				goto err_sdb;
 			}
-			hr_qp->rdb_en = 1;
-			resp->cap_flags |= HNS_ROCE_SUPPORT_RQ_RECORD_DB;
+			hr_qp->en_flags |= HNS_ROCE_QP_CAP_RQ_RECORD_DB;
+			resp->cap_flags |= HNS_ROCE_QP_CAP_RQ_RECORD_DB;
 		}
 	} else {
 		/* QP doorbell register address */
@@ -852,13 +852,13 @@ static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 				goto err_out;
 			}
 			*hr_qp->rdb.db_record = 0;
-			hr_qp->rdb_en = 1;
+			hr_qp->en_flags |= HNS_ROCE_QP_CAP_RQ_RECORD_DB;
 		}
 	}
 
 	return 0;
 err_sdb:
-	if (udata && hr_qp->sdb_en)
+	if (udata && hr_qp->en_flags & HNS_ROCE_QP_CAP_SQ_RECORD_DB)
 		hns_roce_db_unmap_user(uctx, &hr_qp->sdb);
 err_out:
 	return ret;
@@ -871,12 +871,12 @@ static void free_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		udata, struct hns_roce_ucontext, ibucontext);
 
 	if (udata) {
-		if (hr_qp->rdb_en)
+		if (hr_qp->en_flags & HNS_ROCE_QP_CAP_RQ_RECORD_DB)
 			hns_roce_db_unmap_user(uctx, &hr_qp->rdb);
-		if (hr_qp->sdb_en)
+		if (hr_qp->en_flags & HNS_ROCE_QP_CAP_SQ_RECORD_DB)
 			hns_roce_db_unmap_user(uctx, &hr_qp->sdb);
 	} else {
-		if (hr_qp->rdb_en)
+		if (hr_qp->en_flags & HNS_ROCE_QP_CAP_RQ_RECORD_DB)
 			hns_roce_free_db(hr_dev, &hr_qp->rdb);
 	}
 }
@@ -1249,10 +1249,10 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 	if (ibqp->uobject &&
 	    (attr_mask & IB_QP_STATE) && new_state == IB_QPS_ERR) {
-		if (hr_qp->sdb_en == 1) {
+		if (hr_qp->en_flags & HNS_ROCE_QP_CAP_SQ_RECORD_DB) {
 			hr_qp->sq.head = *(int *)(hr_qp->sdb.virt_addr);
 
-			if (hr_qp->rdb_en == 1)
+			if (hr_qp->en_flags & HNS_ROCE_QP_CAP_RQ_RECORD_DB)
 				hr_qp->rq.head = *(int *)(hr_qp->rdb.virt_addr);
 		} else {
 			ibdev_warn(&hr_dev->ib_dev,
-- 
2.8.1

