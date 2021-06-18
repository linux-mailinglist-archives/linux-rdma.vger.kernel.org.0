Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872E63AC86A
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhFRKJD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 06:09:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11067 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbhFRKJB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 06:09:01 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5vdP1NLyzZgDX;
        Fri, 18 Jun 2021 18:03:37 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:06:34 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:06:33 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v4 for-next 8/8] RDMA/hns: Clean SRQC structure definition
Date:   Fri, 18 Jun 2021 18:06:05 +0800
Message-ID: <1624010765-1029-9-git-send-email-liweihang@huawei.com>
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

From: Xi Wang <wangxi11@huawei.com>

Remove unused members in srq context structure.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 15 ++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 82 +-----------------------------
 2 files changed, 4 insertions(+), 93 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 37661d3..790b7fd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5358,12 +5358,8 @@ static int hns_roce_v2_modify_srq(struct ib_srq *ibsrq,
 
 		memset(srqc_mask, 0xff, sizeof(*srqc_mask));
 
-		roce_set_field(srq_context->byte_8_limit_wl,
-			       SRQC_BYTE_8_SRQ_LIMIT_WL_M,
-			       SRQC_BYTE_8_SRQ_LIMIT_WL_S, srq_attr->srq_limit);
-		roce_set_field(srqc_mask->byte_8_limit_wl,
-			       SRQC_BYTE_8_SRQ_LIMIT_WL_M,
-			       SRQC_BYTE_8_SRQ_LIMIT_WL_S, 0);
+		hr_reg_write(srq_context, SRQC_LIMIT_WL, srq_attr->srq_limit);
+		hr_reg_clear(srqc_mask, SRQC_LIMIT_WL);
 
 		ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, srq->srqn, 0,
 					HNS_ROCE_CMD_MODIFY_SRQC,
@@ -5386,7 +5382,6 @@ static int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 	struct hns_roce_srq *srq = to_hr_srq(ibsrq);
 	struct hns_roce_srq_context *srq_context;
 	struct hns_roce_cmd_mailbox *mailbox;
-	int limit_wl;
 	int ret;
 
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
@@ -5404,11 +5399,7 @@ static int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 		goto out;
 	}
 
-	limit_wl = roce_get_field(srq_context->byte_8_limit_wl,
-				  SRQC_BYTE_8_SRQ_LIMIT_WL_M,
-				  SRQC_BYTE_8_SRQ_LIMIT_WL_S);
-
-	attr->srq_limit = limit_wl;
+	attr->srq_limit = hr_reg_read(srq_context, SRQC_LIMIT_WL);
 	attr->max_wr = srq->wqe_cnt;
 	attr->max_sge = srq->max_gs - srq->rsv_sge;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 974f8c1..bf4f179 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -377,22 +377,7 @@ struct hns_roce_v2_cq_context {
 #define CQC_POE_QID_H_1 CQC_FIELD_LOC(511, 511)
 
 struct hns_roce_srq_context {
-	__le32 byte_4_srqn_srqst;
-	__le32 byte_8_limit_wl;
-	__le32 byte_12_xrcd;
-	__le32 byte_16_pi_ci;
-	__le32 wqe_bt_ba;
-	__le32 byte_24_wqe_bt_ba;
-	__le32 byte_28_rqws_pd;
-	__le32 idx_bt_ba;
-	__le32 rsv_idx_bt_ba;
-	__le32 idx_cur_blk_addr;
-	__le32 byte_44_idxbufpgsz_addr;
-	__le32 idx_nxt_blk_addr;
-	__le32 rsv_idxnxtblkaddr;
-	__le32 byte_56_xrc_cqn;
-	__le32 db_record_addr_record_en;
-	__le32 db_record_addr;
+	__le32 data[16];
 };
 
 #define SRQC_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_srq_context, h, l)
@@ -433,71 +418,6 @@ struct hns_roce_srq_context {
 #define SRQC_DB_RECORD_ADDR_L SRQC_FIELD_LOC(479, 449)
 #define SRQC_DB_RECORD_ADDR_H SRQC_FIELD_LOC(511, 480)
 
-#define SRQC_BYTE_4_SRQ_ST_S 0
-#define SRQC_BYTE_4_SRQ_ST_M GENMASK(1, 0)
-
-#define SRQC_BYTE_4_SRQ_WQE_HOP_NUM_S 2
-#define SRQC_BYTE_4_SRQ_WQE_HOP_NUM_M GENMASK(3, 2)
-
-#define SRQC_BYTE_4_SRQ_SHIFT_S 4
-#define SRQC_BYTE_4_SRQ_SHIFT_M GENMASK(7, 4)
-
-#define SRQC_BYTE_4_SRQN_S 8
-#define SRQC_BYTE_4_SRQN_M GENMASK(31, 8)
-
-#define SRQC_BYTE_8_SRQ_LIMIT_WL_S 0
-#define SRQC_BYTE_8_SRQ_LIMIT_WL_M GENMASK(15, 0)
-
-#define SRQC_BYTE_12_SRQ_XRCD_S 0
-#define SRQC_BYTE_12_SRQ_XRCD_M GENMASK(23, 0)
-
-#define SRQC_BYTE_16_SRQ_PRODUCER_IDX_S 0
-#define SRQC_BYTE_16_SRQ_PRODUCER_IDX_M GENMASK(15, 0)
-
-#define SRQC_BYTE_16_SRQ_CONSUMER_IDX_S 0
-#define SRQC_BYTE_16_SRQ_CONSUMER_IDX_M GENMASK(31, 16)
-
-#define SRQC_BYTE_24_SRQ_WQE_BT_BA_S 0
-#define SRQC_BYTE_24_SRQ_WQE_BT_BA_M GENMASK(28, 0)
-
-#define SRQC_BYTE_28_PD_S 0
-#define SRQC_BYTE_28_PD_M GENMASK(23, 0)
-
-#define SRQC_BYTE_28_RQWS_S 24
-#define SRQC_BYTE_28_RQWS_M GENMASK(27, 24)
-
-#define SRQC_BYTE_36_SRQ_IDX_BT_BA_S 0
-#define SRQC_BYTE_36_SRQ_IDX_BT_BA_M GENMASK(28, 0)
-
-#define SRQC_BYTE_44_SRQ_IDX_CUR_BLK_ADDR_S 0
-#define SRQC_BYTE_44_SRQ_IDX_CUR_BLK_ADDR_M GENMASK(19, 0)
-
-#define SRQC_BYTE_44_SRQ_IDX_HOP_NUM_S 22
-#define SRQC_BYTE_44_SRQ_IDX_HOP_NUM_M GENMASK(23, 22)
-
-#define SRQC_BYTE_44_SRQ_IDX_BA_PG_SZ_S 24
-#define SRQC_BYTE_44_SRQ_IDX_BA_PG_SZ_M GENMASK(27, 24)
-
-#define SRQC_BYTE_44_SRQ_IDX_BUF_PG_SZ_S 28
-#define SRQC_BYTE_44_SRQ_IDX_BUF_PG_SZ_M GENMASK(31, 28)
-
-#define SRQC_BYTE_52_SRQ_IDX_NXT_BLK_ADDR_S 0
-#define SRQC_BYTE_52_SRQ_IDX_NXT_BLK_ADDR_M GENMASK(19, 0)
-
-#define SRQC_BYTE_56_SRQ_XRC_CQN_S 0
-#define SRQC_BYTE_56_SRQ_XRC_CQN_M GENMASK(23, 0)
-
-#define SRQC_BYTE_56_SRQ_WQE_BA_PG_SZ_S 24
-#define SRQC_BYTE_56_SRQ_WQE_BA_PG_SZ_M GENMASK(27, 24)
-
-#define SRQC_BYTE_56_SRQ_WQE_BUF_PG_SZ_S 28
-#define SRQC_BYTE_56_SRQ_WQE_BUF_PG_SZ_M GENMASK(31, 28)
-
-#define SRQC_BYTE_60_SRQ_RECORD_EN_S 0
-
-#define SRQC_BYTE_60_SRQ_DB_RECORD_ADDR_S 1
-#define SRQC_BYTE_60_SRQ_DB_RECORD_ADDR_M GENMASK(31, 1)
-
 enum {
 	V2_MPT_ST_VALID = 0x1,
 	V2_MPT_ST_FREE	= 0x2,
-- 
2.7.4

