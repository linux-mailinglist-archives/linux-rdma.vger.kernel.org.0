Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01673AC86B
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhFRKJD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 06:09:03 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8274 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbhFRKJB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 06:09:01 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G5vb31ZdRz1BNw0;
        Fri, 18 Jun 2021 18:01:35 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:06:33 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:06:33 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Yixing Liu <liuyixing1@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v4 for-next 6/8] RDMA/hns: Use new interface to write FRMR fields
Date:   Fri, 18 Jun 2021 18:06:03 +0800
Message-ID: <1624010765-1029-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624010765-1029-1-git-send-email-liweihang@huawei.com>
References: <1624010765-1029-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 29 ++++++++++++++---------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 26 ++++++++++++--------------
 2 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index fe3c4c6..972a4fe 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -105,16 +105,16 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
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
+	hr_reg_write(fseg, FRMR_BIND_EN,
+		     wr->access & IB_ACCESS_MW_BIND ? 1 : 0);
+	hr_reg_write(fseg, FRMR_ATOMIC,
+		     wr->access & IB_ACCESS_REMOTE_ATOMIC ? 1 : 0);
+	hr_reg_write(fseg, FRMR_RR,
+		     wr->access & IB_ACCESS_REMOTE_READ ? 1 : 0);
+	hr_reg_write(fseg, FRMR_RW,
+		     wr->access & IB_ACCESS_REMOTE_WRITE ? 1 : 0);
+	hr_reg_write(fseg, FRMR_LW,
+		     wr->access & IB_ACCESS_LOCAL_WRITE ? 1 : 0);
 
 	/* Data structure reuse may lead to confusion */
 	pbl_ba = mr->pbl_mtr.hem_cfg.root_ba;
@@ -126,11 +126,10 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
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
index 76d946e..4cdeac9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1062,16 +1062,6 @@ struct hns_roce_v2_rc_send_wqe {
 
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
@@ -1090,10 +1080,18 @@ struct hns_roce_wqe_frmr_seg {
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

