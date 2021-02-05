Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767D0310820
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 10:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhBEJoc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 04:44:32 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12841 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhBEJmi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 04:42:38 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DX9Q96z1Kz7hVm;
        Fri,  5 Feb 2021 17:40:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 17:41:48 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 01/12] RDMA/hns: Avoid filling sgid index when modifying QP to RTR
Date:   Fri, 5 Feb 2021 17:39:23 +0800
Message-ID: <1612517974-31867-2-git-send-email-liweihang@huawei.com>
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

ULP usually set IB(V)_QP_AV when trying to modify QP to RTR if they want
to record sgid index into QPC. For UD QPs, it is useless because it will be
included in WQE. For RC QPs, it will be filled in hns_roce_set_path(). So
sgid index shouldn't be filled by default. Then hns_get_gid_index() is
moved to hns_roce_hw_v1.c because it is only called in it.

Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 16 ++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 11 -----------
 drivers/infiniband/hw/hns/hns_roce_main.c  | 16 ----------------
 3 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 23fe8e9..262ad58 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -43,6 +43,22 @@
 #include "hns_roce_hem.h"
 #include "hns_roce_hw_v1.h"
 
+/**
+ * hns_get_gid_index - Get gid index.
+ * @hr_dev: pointer to structure hns_roce_dev.
+ * @port:  port, value range: 0 ~ MAX
+ * @gid_index:  gid_index, value range: 0 ~ MAX
+ * Description:
+ *    N ports shared gids, allocation method as follow:
+ *		GID[0][0], GID[1][0],.....GID[N - 1][0],
+ *		GID[0][0], GID[1][0],.....GID[N - 1][0],
+ *		And so on
+ */
+u8 hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index)
+{
+	return gid_index * hr_dev->caps.num_ports + port;
+}
+
 static void set_data_seg(struct hns_roce_wqe_data_seg *dseg, struct ib_sge *sg)
 {
 	dseg->lkey = cpu_to_le32(sg->lkey);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c962f26..f0691f4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4308,7 +4308,6 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 				 struct hns_roce_v2_qp_context *context,
 				 struct hns_roce_v2_qp_context *qpc_mask)
 {
-	const struct ib_global_route *grh = rdma_ah_read_grh(&attr->ah_attr);
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
@@ -4316,7 +4315,6 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	dma_addr_t irrl_ba;
 	enum ib_mtu mtu;
 	u8 lp_pktn_ini;
-	u8 port_num;
 	u64 *mtts;
 	u8 *dmac;
 	u8 *smac;
@@ -4397,15 +4395,6 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 			       V2_QPC_BYTE_56_DQPN_M, V2_QPC_BYTE_56_DQPN_S, 0);
 	}
 
-	/* Configure GID index */
-	port_num = rdma_ah_get_port_num(&attr->ah_attr);
-	roce_set_field(context->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_SGID_IDX_M, V2_QPC_BYTE_20_SGID_IDX_S,
-		       hns_get_gid_index(hr_dev, port_num - 1,
-					 grh->sgid_index));
-	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_SGID_IDX_M, V2_QPC_BYTE_20_SGID_IDX_S, 0);
-
 	memcpy(&(context->dmac), dmac, sizeof(u32));
 	roce_set_field(context->byte_52_udpspn_dmac, V2_QPC_BYTE_52_DMAC_M,
 		       V2_QPC_BYTE_52_DMAC_S, *((u16 *)(&dmac[4])));
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 7978220..c29215a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -42,22 +42,6 @@
 #include "hns_roce_device.h"
 #include "hns_roce_hem.h"
 
-/**
- * hns_get_gid_index - Get gid index.
- * @hr_dev: pointer to structure hns_roce_dev.
- * @port:  port, value range: 0 ~ MAX
- * @gid_index:  gid_index, value range: 0 ~ MAX
- * Description:
- *    N ports shared gids, allocation method as follow:
- *		GID[0][0], GID[1][0],.....GID[N - 1][0],
- *		GID[0][0], GID[1][0],.....GID[N - 1][0],
- *		And so on
- */
-u8 hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index)
-{
-	return gid_index * hr_dev->caps.num_ports + port;
-}
-
 static int hns_roce_set_mac(struct hns_roce_dev *hr_dev, u8 port, u8 *addr)
 {
 	u8 phy_port;
-- 
2.8.1

