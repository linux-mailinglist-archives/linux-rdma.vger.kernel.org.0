Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12402EA2EC
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jan 2021 02:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbhAEBjj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jan 2021 20:39:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10016 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbhAEBjj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jan 2021 20:39:39 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D8w9k4dhqzj3HG;
        Tue,  5 Jan 2021 09:38:02 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 5 Jan 2021 09:38:53 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next] RDMA/hns: Add caps flag for UD inline of userspace
Date:   Tue, 5 Jan 2021 09:36:55 +0800
Message-ID: <1609810615-50515-1-git-send-email-liweihang@huawei.com>
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
 drivers/infiniband/hw/hns/hns_roce_device.h | 1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 3 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 1 +
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 3 +++
 include/uapi/rdma/hns-abi.h                 | 1 +
 5 files changed, 9 insertions(+)

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
index 833e1f2..619e828 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1916,6 +1916,8 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 		caps->gmv_buf_pg_sz = 0;
 		caps->gid_table_len[0] = caps->gmv_bt_num * (HNS_HW_PAGE_SIZE /
 					 caps->gmv_entry_sz);
+		caps->flags |= HNS_ROCE_CAP_FLAG_UD_SQ_INL;
+		caps->max_sq_inline = HNS_ROCE_V2_MAX_SQ_INL_EXT;
 	}
 }
 
@@ -5084,6 +5086,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
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

