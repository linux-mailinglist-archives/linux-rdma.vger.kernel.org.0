Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22A72EA6BD
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jan 2021 09:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbhAEItp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jan 2021 03:49:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10023 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbhAEItp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jan 2021 03:49:45 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D95k10JZTzj3pQ;
        Tue,  5 Jan 2021 16:48:09 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Tue, 5 Jan 2021 16:49:01 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 for-next] RDMA/hns: Add caps flag for UD inline of userspace
Date:   Tue, 5 Jan 2021 16:47:03 +0800
Message-ID: <1609836423-40069-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

HIP09 supports UD inline up to size of 1024 Bytes, the caps flag is got
from firmware and passed back to userspace when creating QP.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
Changes since v1:
- Avoid overwriting some fields in set_default_caps().
- Link: https://patchwork.kernel.org/project/linux-rdma/patch/1609810615-50515-1-git-send-email-liweihang@huawei.com/

 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 18 +++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  1 +
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  3 +++
 include/uapi/rdma/hns-abi.h                 |  1 +
 5 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 55d5386..87716da 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -214,6 +214,7 @@ enum {
 	HNS_ROCE_CAP_FLAG_FRMR                  = BIT(8),
 	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
 	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
+	HNS_ROCE_CAP_FLAG_UD_SQ_INL		= BIT(13),
 	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
 	HNS_ROCE_CAP_FLAG_STASH			= BIT(17),
 };
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 833e1f2..1454cd9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1800,7 +1800,6 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->max_sq_sg		= HNS_ROCE_V2_MAX_SQ_SGE_NUM;
 	caps->max_extend_sg	= HNS_ROCE_V2_MAX_EXTEND_SGE_NUM;
 	caps->max_rq_sg		= HNS_ROCE_V2_MAX_RQ_SGE_NUM;
-	caps->max_sq_inline	= HNS_ROCE_V2_MAX_SQ_INLINE;
 	caps->num_uars		= HNS_ROCE_V2_UAR_NUM;
 	caps->phy_num_uars	= HNS_ROCE_V2_PHY_UAR_NUM;
 	caps->num_aeq_vectors	= HNS_ROCE_V2_AEQE_VEC_NUM;
@@ -1817,7 +1816,6 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->max_sq_desc_sz	= HNS_ROCE_V2_MAX_SQ_DESC_SZ;
 	caps->max_rq_desc_sz	= HNS_ROCE_V2_MAX_RQ_DESC_SZ;
 	caps->max_srq_desc_sz	= HNS_ROCE_V2_MAX_SRQ_DESC_SZ;
-	caps->qpc_sz		= HNS_ROCE_V2_QPC_SZ;
 	caps->irrl_entry_sz	= HNS_ROCE_V2_IRRL_ENTRY_SZ;
 	caps->trrl_entry_sz	= HNS_ROCE_V2_EXT_ATOMIC_TRRL_ENTRY_SZ;
 	caps->cqc_entry_sz	= HNS_ROCE_V2_CQC_ENTRY_SZ;
@@ -1825,7 +1823,6 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->mtpt_entry_sz	= HNS_ROCE_V2_MTPT_ENTRY_SZ;
 	caps->mtt_entry_sz	= HNS_ROCE_V2_MTT_ENTRY_SZ;
 	caps->idx_entry_sz	= HNS_ROCE_V2_IDX_ENTRY_SZ;
-	caps->cqe_sz		= HNS_ROCE_V2_CQE_SIZE;
 	caps->page_size_cap	= HNS_ROCE_V2_PAGE_SIZE_SUPPORTED;
 	caps->reserved_lkey	= 0;
 	caps->reserved_pds	= 0;
@@ -1871,11 +1868,8 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 				  HNS_ROCE_CAP_FLAG_SQ_RECORD_DB;
 
 	caps->pkey_table_len[0] = 1;
-	caps->gid_table_len[0]	= HNS_ROCE_V2_GID_INDEX_NUM;
 	caps->ceqe_depth	= HNS_ROCE_V2_COMP_EQE_NUM;
 	caps->aeqe_depth	= HNS_ROCE_V2_ASYNC_EQE_NUM;
-	caps->aeqe_size		= HNS_ROCE_AEQE_SIZE;
-	caps->ceqe_size		= HNS_ROCE_CEQE_SIZE;
 	caps->local_ca_ack_delay = 0;
 	caps->max_mtu = IB_MTU_4096;
 
@@ -1897,7 +1891,6 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->cqc_timer_buf_pg_sz = 0;
 	caps->cqc_timer_hop_num   = HNS_ROCE_HOP_NUM_0;
 
-	caps->sccc_sz = HNS_ROCE_V2_SCCC_SZ;
 	caps->sccc_ba_pg_sz	  = 0;
 	caps->sccc_buf_pg_sz	  = 0;
 	caps->sccc_hop_num	  = HNS_ROCE_SCCC_HOP_NUM;
@@ -1916,6 +1909,16 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 		caps->gmv_buf_pg_sz = 0;
 		caps->gid_table_len[0] = caps->gmv_bt_num * (HNS_HW_PAGE_SIZE /
 					 caps->gmv_entry_sz);
+		caps->flags |= HNS_ROCE_CAP_FLAG_UD_SQ_INL;
+		caps->max_sq_inline = HNS_ROCE_V2_MAX_SQ_INL_EXT;
+	} else {
+		caps->aeqe_size = HNS_ROCE_AEQE_SIZE;
+		caps->ceqe_size = HNS_ROCE_CEQE_SIZE;
+		caps->cqe_sz = HNS_ROCE_V2_CQE_SIZE;
+		caps->qpc_sz = HNS_ROCE_V2_QPC_SZ;
+		caps->sccc_sz = HNS_ROCE_V2_SCCC_SZ;
+		caps->gid_table_len[0] = HNS_ROCE_V2_GID_INDEX_NUM;
+		caps->max_sq_inline = HNS_ROCE_V2_MAX_SQ_INLINE;
 	}
 }
 
@@ -5084,6 +5087,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	qp_attr->cur_qp_state = qp_attr->qp_state;
 	qp_attr->cap.max_recv_wr = hr_qp->rq.wqe_cnt;
 	qp_attr->cap.max_recv_sge = hr_qp->rq.max_gs;
+	qp_attr->cap.max_inline_data = hr_qp->max_inline_data;
 
 	if (!ibqp->uobject) {
 		qp_attr->cap.max_send_wr = hr_qp->sq.wqe_cnt;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index bdaccf8..ab685a4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -61,6 +61,7 @@
 #define HNS_ROCE_V2_MAX_SQ_SGE_NUM		64
 #define HNS_ROCE_V2_MAX_EXTEND_SGE_NUM		0x200000
 #define HNS_ROCE_V2_MAX_SQ_INLINE		0x20
+#define HNS_ROCE_V2_MAX_SQ_INL_EXT		0x400
 #define HNS_ROCE_V2_MAX_RC_INL_INN_SZ		32
 #define HNS_ROCE_V2_UAR_NUM			256
 #define HNS_ROCE_V2_PHY_UAR_NUM			1
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index d8e2fe5..b19fcbd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1020,6 +1020,9 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	}
 
 	if (udata) {
+		if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_UD_SQ_INL)
+			resp.cap_flags |= HNS_ROCE_QP_CAP_UD_SQ_INL;
+
 		ret = ib_copy_to_udata(udata, &resp,
 				       min(udata->outlen, sizeof(resp)));
 		if (ret) {
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 90b739d..79dba94 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -77,6 +77,7 @@ enum hns_roce_qp_cap_flags {
 	HNS_ROCE_QP_CAP_RQ_RECORD_DB = 1 << 0,
 	HNS_ROCE_QP_CAP_SQ_RECORD_DB = 1 << 1,
 	HNS_ROCE_QP_CAP_OWNER_DB = 1 << 2,
+	HNS_ROCE_QP_CAP_UD_SQ_INL = 1 << 3,
 };
 
 struct hns_roce_ib_create_qp_resp {
-- 
2.8.1

