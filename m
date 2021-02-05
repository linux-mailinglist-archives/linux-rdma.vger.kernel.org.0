Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84CF310837
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 10:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhBEJq5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 04:46:57 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12846 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBEJpE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 04:45:04 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DX9Q95hrQz7hVJ;
        Fri,  5 Feb 2021 17:40:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 17:41:49 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 05/12] RDMA/hns: Adjust definition of FRMR fields
Date:   Fri, 5 Feb 2021 17:39:27 +0800
Message-ID: <1612517974-31867-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
References: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

The position of the FRMR-related fields has changed, change them to fit
the new design.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 26 ++++++++++++--------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 12 ++++++------
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 3ba6783..18a8ac9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -99,16 +99,16 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 	u64 pbl_ba;
 
 	/* use ib_access_flags */
-	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_FRMR_WQE_BYTE_4_BIND_EN_S,
-		     wr->access & IB_ACCESS_MW_BIND ? 1 : 0);
-	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_FRMR_WQE_BYTE_4_ATOMIC_S,
-		     wr->access & IB_ACCESS_REMOTE_ATOMIC ? 1 : 0);
-	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_FRMR_WQE_BYTE_4_RR_S,
-		     wr->access & IB_ACCESS_REMOTE_READ ? 1 : 0);
-	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_FRMR_WQE_BYTE_4_RW_S,
-		     wr->access & IB_ACCESS_REMOTE_WRITE ? 1 : 0);
-	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_FRMR_WQE_BYTE_4_LW_S,
-		     wr->access & IB_ACCESS_LOCAL_WRITE ? 1 : 0);
+	roce_set_bit(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_BIND_EN_S,
+		     !!(wr->access & IB_ACCESS_MW_BIND));
+	roce_set_bit(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_ATOMIC_S,
+		     !!(wr->access & IB_ACCESS_REMOTE_ATOMIC));
+	roce_set_bit(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_RR_S,
+		     !!(wr->access & IB_ACCESS_REMOTE_READ));
+	roce_set_bit(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_RW_S,
+		     !!(wr->access & IB_ACCESS_REMOTE_WRITE));
+	roce_set_bit(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_LW_S,
+		     !!(wr->access & IB_ACCESS_LOCAL_WRITE));
 
 	/* Data structure reuse may lead to confusion */
 	pbl_ba = mr->pbl_mtr.hem_cfg.root_ba;
@@ -121,12 +121,10 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 	rc_sq_wqe->va = cpu_to_le64(wr->mr->iova);
 
 	fseg->pbl_size = cpu_to_le32(mr->npages);
-	roce_set_field(fseg->mode_buf_pg_sz,
-		       V2_RC_FRMR_WQE_BYTE_40_PBL_BUF_PG_SZ_M,
+	roce_set_field(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_PBL_BUF_PG_SZ_M,
 		       V2_RC_FRMR_WQE_BYTE_40_PBL_BUF_PG_SZ_S,
 		       to_hr_hw_page_shift(mr->pbl_mtr.hem_cfg.buf_pg_shift));
-	roce_set_bit(fseg->mode_buf_pg_sz,
-		     V2_RC_FRMR_WQE_BYTE_40_BLK_MODE_S, 0);
+	roce_set_bit(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_BLK_MODE_S, 0);
 }
 
 static void set_atomic_seg(const struct ib_send_wr *wr,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index f29438c..1da980c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1255,15 +1255,15 @@ struct hns_roce_v2_rc_send_wqe {
 
 #define V2_RC_SEND_WQE_BYTE_4_INLINE_S 12
 
-#define V2_RC_FRMR_WQE_BYTE_4_BIND_EN_S 19
+#define V2_RC_FRMR_WQE_BYTE_40_BIND_EN_S 10
 
-#define V2_RC_FRMR_WQE_BYTE_4_ATOMIC_S 20
+#define V2_RC_FRMR_WQE_BYTE_40_ATOMIC_S 11
 
-#define V2_RC_FRMR_WQE_BYTE_4_RR_S 21
+#define V2_RC_FRMR_WQE_BYTE_40_RR_S 12
 
-#define V2_RC_FRMR_WQE_BYTE_4_RW_S 22
+#define V2_RC_FRMR_WQE_BYTE_40_RW_S 13
 
-#define V2_RC_FRMR_WQE_BYTE_4_LW_S 23
+#define V2_RC_FRMR_WQE_BYTE_40_LW_S 14
 
 #define V2_RC_SEND_WQE_BYTE_4_FLAG_S 31
 
@@ -1280,7 +1280,7 @@ struct hns_roce_v2_rc_send_wqe {
 
 struct hns_roce_wqe_frmr_seg {
 	__le32	pbl_size;
-	__le32	mode_buf_pg_sz;
+	__le32	byte_40;
 };
 
 #define V2_RC_FRMR_WQE_BYTE_40_PBL_BUF_PG_SZ_S	4
-- 
2.8.1

