Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BC63AE47D
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 10:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFUIDf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 04:03:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5415 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFUIDb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 04:03:31 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G7hj55DDHz72ZQ;
        Mon, 21 Jun 2021 15:58:01 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 16:01:14 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 21 Jun 2021 16:01:14 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Yixing Liu <liuyixing1@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v5 for-next 7/9] RDMA/hns: Use new interface to write FRMR fields
Date:   Mon, 21 Jun 2021 16:00:41 +0800
Message-ID: <1624262443-24528-8-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624262443-24528-1-git-send-email-liweihang@huawei.com>
References: <1624262443-24528-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

Use "hr_reg_write" to replace "roce_set_filed".

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 25 ++++++++++---------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 26 ++++++++++++--------------
 2 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 2266f9a..868a902 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -105,16 +105,12 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 	u64 pbl_ba;
 
 	/* use ib_access_flags */
-	roce_set_bit(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_BIND_EN_S,
-		     !!(wr->access & IB_ACCESS_MW_BIND));
-	roce_set_bit(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_ATOMIC_S,
-		     !!(wr->access & IB_ACCESS_REMOTE_ATOMIC));
-	roce_set_bit(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_RR_S,
-		     !!(wr->access & IB_ACCESS_REMOTE_READ));
-	roce_set_bit(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_RW_S,
-		     !!(wr->access & IB_ACCESS_REMOTE_WRITE));
-	roce_set_bit(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_LW_S,
-		     !!(wr->access & IB_ACCESS_LOCAL_WRITE));
+	hr_reg_write_bool(fseg, FRMR_BIND_EN, wr->access & IB_ACCESS_MW_BIND);
+	hr_reg_write_bool(fseg, FRMR_ATOMIC,
+			  wr->access & IB_ACCESS_REMOTE_ATOMIC);
+	hr_reg_write_bool(fseg, FRMR_RR, wr->access & IB_ACCESS_REMOTE_READ);
+	hr_reg_write_bool(fseg, FRMR_RW, wr->access & IB_ACCESS_REMOTE_WRITE);
+	hr_reg_write_bool(fseg, FRMR_LW, wr->access & IB_ACCESS_LOCAL_WRITE);
 
 	/* Data structure reuse may lead to confusion */
 	pbl_ba = mr->pbl_mtr.hem_cfg.root_ba;
@@ -126,11 +122,10 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 	rc_sq_wqe->rkey = cpu_to_le32(wr->key);
 	rc_sq_wqe->va = cpu_to_le64(wr->mr->iova);
 
-	fseg->pbl_size = cpu_to_le32(mr->npages);
-	roce_set_field(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_PBL_BUF_PG_SZ_M,
-		       V2_RC_FRMR_WQE_BYTE_40_PBL_BUF_PG_SZ_S,
-		       to_hr_hw_page_shift(mr->pbl_mtr.hem_cfg.buf_pg_shift));
-	roce_set_bit(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_BLK_MODE_S, 0);
+	hr_reg_write(fseg, FRMR_PBL_SIZE, mr->npages);
+	hr_reg_write(fseg, FRMR_PBL_BUF_PG_SZ,
+		     to_hr_hw_page_shift(mr->pbl_mtr.hem_cfg.buf_pg_shift));
+	hr_reg_clear(fseg, FRMR_BLK_MODE);
 }
 
 static void set_atomic_seg(const struct ib_send_wr *wr,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index d398cf08..e6880a9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1064,16 +1064,6 @@ struct hns_roce_v2_rc_send_wqe {
 
 #define V2_RC_SEND_WQE_BYTE_4_INLINE_S 12
 
-#define V2_RC_FRMR_WQE_BYTE_40_BIND_EN_S 10
-
-#define V2_RC_FRMR_WQE_BYTE_40_ATOMIC_S 11
-
-#define V2_RC_FRMR_WQE_BYTE_40_RR_S 12
-
-#define V2_RC_FRMR_WQE_BYTE_40_RW_S 13
-
-#define V2_RC_FRMR_WQE_BYTE_40_LW_S 14
-
 #define V2_RC_SEND_WQE_BYTE_4_FLAG_S 31
 
 #define	V2_RC_SEND_WQE_BYTE_16_XRC_SRQN_S 0
@@ -1092,10 +1082,18 @@ struct hns_roce_wqe_frmr_seg {
 	__le32	byte_40;
 };
 
-#define V2_RC_FRMR_WQE_BYTE_40_PBL_BUF_PG_SZ_S	4
-#define V2_RC_FRMR_WQE_BYTE_40_PBL_BUF_PG_SZ_M	GENMASK(7, 4)
-
-#define V2_RC_FRMR_WQE_BYTE_40_BLK_MODE_S 8
+#define FRMR_WQE_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_wqe_frmr_seg, h, l)
+
+#define FRMR_PBL_SIZE FRMR_WQE_FIELD_LOC(31, 0)
+#define FRMR_BLOCK_SIZE FRMR_WQE_FIELD_LOC(35, 32)
+#define FRMR_PBL_BUF_PG_SZ FRMR_WQE_FIELD_LOC(39, 36)
+#define FRMR_BLK_MODE FRMR_WQE_FIELD_LOC(40, 40)
+#define FRMR_ZBVA FRMR_WQE_FIELD_LOC(41, 41)
+#define FRMR_BIND_EN FRMR_WQE_FIELD_LOC(42, 42)
+#define FRMR_ATOMIC FRMR_WQE_FIELD_LOC(43, 43)
+#define FRMR_RR FRMR_WQE_FIELD_LOC(44, 44)
+#define FRMR_RW FRMR_WQE_FIELD_LOC(45, 45)
+#define FRMR_LW FRMR_WQE_FIELD_LOC(46, 46)
 
 struct hns_roce_v2_wqe_data_seg {
 	__le32    len;
-- 
2.7.4

