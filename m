Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D210B30146B
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Jan 2021 11:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbhAWJ6o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 Jan 2021 04:58:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11143 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbhAWJ6P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 23 Jan 2021 04:58:15 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DNBNL3yMPz15w1q;
        Sat, 23 Jan 2021 17:56:18 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Sat, 23 Jan 2021 17:57:24 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next] RDMA/hns: Add support of direct wqe
Date:   Sat, 23 Jan 2021 17:55:17 +0800
Message-ID: <1611395717-11081-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

Direct wqe is a mechanism to fill wqe directly into the hardware. In the
case of light load, the wqe will be filled into pcie bar space of the
hardware, this will reduce one memory access operation and therefore reduce
the latency.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  6 ++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 44 ++++++++++++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 14 +++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index c46b330..6abf7d8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -90,6 +90,7 @@
 #define HNS_ROCE_MAX_PORTS			6
 #define HNS_ROCE_GID_SIZE			16
 #define HNS_ROCE_SGE_SIZE			16
+#define HNS_ROCE_DWQE_SIZE			65536
 
 #define HNS_ROCE_HOP_NUM_0			0xff
 
@@ -644,6 +645,10 @@ struct hns_roce_work {
 	u32 queue_num;
 };
 
+enum {
+	HNS_ROCE_QP_CAP_DIRECT_WQE = BIT(5),
+};
+
 struct hns_roce_qp {
 	struct ib_qp		ibqp;
 	struct hns_roce_wq	rq;
@@ -986,6 +991,7 @@ struct hns_roce_dev {
 	struct mutex            pgdir_mutex;
 	int			irq[HNS_ROCE_MAX_IRQ_NUM];
 	u8 __iomem		*reg_base;
+	void __iomem		*mem_base;
 	struct hns_roce_caps	caps;
 	struct xarray		qp_table_xa;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 4c06889..0d26079 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -503,6 +503,8 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 	if (ret)
 		return ret;
 
+	qp->sl = to_hr_ah(ud_wr(wr)->ah)->av.sl;
+
 	set_extend_sge(qp, wr->sg_list, &curr_idx, valid_num_sge);
 
 	/*
@@ -635,6 +637,8 @@ static inline void update_sq_db(struct hns_roce_dev *hr_dev,
 			       V2_DB_BYTE_4_TAG_S, qp->doorbell_qpn);
 		roce_set_field(sq_db.byte_4, V2_DB_BYTE_4_CMD_M,
 			       V2_DB_BYTE_4_CMD_S, HNS_ROCE_V2_SQ_DB);
+		/* indicates data on new BAR, 0 : SQ doorbell, 1 : DWQE */
+		roce_set_bit(sq_db.byte_4, V2_DB_FLAG_S, 0);
 		roce_set_field(sq_db.parameter, V2_DB_PARAMETER_IDX_M,
 			       V2_DB_PARAMETER_IDX_S, qp->sq.head);
 		roce_set_field(sq_db.parameter, V2_DB_PARAMETER_SL_M,
@@ -644,6 +648,38 @@ static inline void update_sq_db(struct hns_roce_dev *hr_dev,
 	}
 }
 
+static void hns_roce_write512(struct hns_roce_dev *hr_dev, u64 *val,
+			      u64 __iomem *dest)
+{
+#define HNS_ROCE_WRITE_TIMES 8
+	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
+	struct hnae3_handle *handle = priv->handle;
+	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	int i;
+
+	if (!hr_dev->dis_db && !ops->get_hw_reset_stat(handle))
+		for (i = 0; i < HNS_ROCE_WRITE_TIMES; i++)
+			writeq_relaxed(*(val + i), dest + i);
+}
+
+static void write_dwqe(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
+		       void *wqe)
+{
+	struct hns_roce_v2_rc_send_wqe *rc_sq_wqe = wqe;
+
+	/* All kinds of DirectWQE have the same header field layout */
+	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_FLAG_S, 1);
+	roce_set_field(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_DB_SL_L_M,
+		       V2_RC_SEND_WQE_BYTE_4_DB_SL_L_S, qp->sl);
+	roce_set_field(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_DB_SL_H_M,
+		       V2_RC_SEND_WQE_BYTE_4_DB_SL_H_S, qp->sl >> 2);
+	roce_set_field(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_WQE_INDEX_M,
+		       V2_RC_SEND_WQE_BYTE_4_WQE_INDEX_S, qp->sq.head);
+
+	hns_roce_write512(hr_dev, wqe, hr_dev->mem_base +
+			  HNS_ROCE_DWQE_SIZE * qp->ibqp.qp_num);
+}
+
 static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 				 const struct ib_send_wr *wr,
 				 const struct ib_send_wr **bad_wr)
@@ -710,7 +746,12 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 		qp->next_sge = sge_idx;
 		/* Memory barrier */
 		wmb();
-		update_sq_db(hr_dev, qp);
+
+		if (nreq == 1 && qp->sq.head == qp->sq.tail + 1 &&
+		    (qp->en_flags & HNS_ROCE_QP_CAP_DIRECT_WQE))
+			write_dwqe(hr_dev, qp, wqe);
+		else
+			update_sq_db(hr_dev, qp);
 	}
 
 	spin_unlock_irqrestore(&qp->sq.lock, flags);
@@ -6286,6 +6327,7 @@ static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
 
 	/* Get info from NIC driver. */
 	hr_dev->reg_base = handle->rinfo.roce_io_base;
+	hr_dev->mem_base = handle->rinfo.roce_mem_base;
 	hr_dev->caps.num_ports = 1;
 	hr_dev->iboe.netdevs[0] = handle->rinfo.netdev;
 	hr_dev->iboe.phy_port[0] = 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index bdaccf8..badc1c9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -97,6 +97,7 @@
 #define HNS_ROCE_V2_PAGE_SIZE_SUPPORTED		0xFFFFF000
 #define HNS_ROCE_V2_MAX_INNER_MTPT_NUM		2
 #define HNS_ROCE_INVALID_LKEY			0x100
+
 #define HNS_ROCE_CMQ_TX_TIMEOUT			30000
 #define HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE	2
 #define HNS_ROCE_V2_RSV_QPS			8
@@ -1059,6 +1060,8 @@ struct hns_roce_v2_mpt_entry {
 #define	V2_DB_BYTE_4_CMD_S 24
 #define V2_DB_BYTE_4_CMD_M GENMASK(27, 24)
 
+#define V2_DB_FLAG_S 31
+
 #define V2_DB_PARAMETER_IDX_S 0
 #define V2_DB_PARAMETER_IDX_M GENMASK(15, 0)
 
@@ -1155,6 +1158,15 @@ struct hns_roce_v2_rc_send_wqe {
 #define	V2_RC_SEND_WQE_BYTE_4_OPCODE_S 0
 #define V2_RC_SEND_WQE_BYTE_4_OPCODE_M GENMASK(4, 0)
 
+#define V2_RC_SEND_WQE_BYTE_4_DB_SL_L_S 5
+#define V2_RC_SEND_WQE_BYTE_4_DB_SL_L_M GENMASK(6, 5)
+
+#define V2_RC_SEND_WQE_BYTE_4_DB_SL_H_S 13
+#define V2_RC_SEND_WQE_BYTE_4_DB_SL_H_M GENMASK(14, 13)
+
+#define V2_RC_SEND_WQE_BYTE_4_WQE_INDEX_S 15
+#define V2_RC_SEND_WQE_BYTE_4_WQE_INDEX_M GENMASK(30, 15)
+
 #define V2_RC_SEND_WQE_BYTE_4_OWNER_S 7
 
 #define V2_RC_SEND_WQE_BYTE_4_CQE_S 8
@@ -1177,6 +1189,8 @@ struct hns_roce_v2_rc_send_wqe {
 
 #define V2_RC_FRMR_WQE_BYTE_4_LW_S 23
 
+#define V2_RC_SEND_WQE_BYTE_4_FLAG_S 31
+
 #define	V2_RC_SEND_WQE_BYTE_16_XRC_SRQN_S 0
 #define V2_RC_SEND_WQE_BYTE_16_XRC_SRQN_M GENMASK(23, 0)
 
-- 
2.8.1

