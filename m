Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3313D6CBB
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 05:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbhG0Cuw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jul 2021 22:50:52 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12409 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbhG0Cur (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jul 2021 22:50:47 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GYj0g05KszcjWM;
        Tue, 27 Jul 2021 11:27:47 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:07 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:07 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>, Xi Wang <wangxi11@huawei.com>
Subject: [PATCH v3 for-next 06/12] RDMA/hns: Setup the configuration of WQE addressing to QPC
Date:   Tue, 27 Jul 2021 11:27:26 +0800
Message-ID: <1627356452-30564-7-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1627356452-30564-1-git-send-email-liangwenpeng@huawei.com>
References: <1627356452-30564-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Add a new command to update the configuration of WQE buffer addressing to
QPC in DCA mode.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 82 +++++++++++++++++++++++++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  1 +
 2 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index b31b493..7e44128 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2782,6 +2782,17 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 		free_dip_list(hr_dev);
 }
 
+static inline void mbox_desc_init(struct hns_roce_post_mbox *mb, u64 in_param,
+				  u64 out_param, u32 in_modifier,
+				  u8 op_modifier, u16 op)
+{
+	mb->in_param_l = cpu_to_le32(in_param);
+	mb->in_param_h = cpu_to_le32(in_param >> 32);
+	mb->out_param_l = cpu_to_le32(out_param);
+	mb->out_param_h = cpu_to_le32(out_param >> 32);
+	mb->cmd_tag = cpu_to_le32(in_modifier << 8 | op);
+}
+
 static int hns_roce_mbox_post(struct hns_roce_dev *hr_dev, u64 in_param,
 			      u64 out_param, u32 in_modifier, u8 op_modifier,
 			      u16 op, u16 token, int event)
@@ -2790,17 +2801,34 @@ static int hns_roce_mbox_post(struct hns_roce_dev *hr_dev, u64 in_param,
 	struct hns_roce_post_mbox *mb = (struct hns_roce_post_mbox *)desc.data;
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_POST_MB, false);
-
-	mb->in_param_l = cpu_to_le32(in_param);
-	mb->in_param_h = cpu_to_le32(in_param >> 32);
-	mb->out_param_l = cpu_to_le32(out_param);
-	mb->out_param_h = cpu_to_le32(out_param >> 32);
-	mb->cmd_tag = cpu_to_le32(in_modifier << 8 | op);
+	mbox_desc_init(mb, in_param, out_param, in_modifier, op_modifier, op);
 	mb->token_event_en = cpu_to_le32(event << 16 | token);
 
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
 
+static int hns_roce_mbox_send(struct hns_roce_dev *hr_dev, u64 in_param,
+			      u64 out_param, u32 in_modifier, u8 op_modifier,
+			      u16 op)
+{
+	struct hns_roce_cmq_desc desc;
+	struct hns_roce_post_mbox *mb = (struct hns_roce_post_mbox *)desc.data;
+
+	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_SYNC_MB, false);
+
+	mbox_desc_init(mb, in_param, out_param, in_modifier, op_modifier, op);
+
+	/* The hardware doesn't care about the token fields when working in
+	 * sync mode.
+	 */
+	mb->token_event_en = 0;
+
+	/* The cmdq send returns 0 indicates that the hardware has already
+	 * finished the operation defined in this mbox.
+	 */
+	return hns_roce_cmq_send(hr_dev, &desc, 1);
+}
+
 static int v2_wait_mbox_complete(struct hns_roce_dev *hr_dev, u32 timeout,
 				 u8 *complete_status)
 {
@@ -5062,6 +5090,47 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	return ret;
 }
 
+static int hns_roce_v2_set_dca_buf(struct hns_roce_dev *hr_dev,
+				   struct hns_roce_qp *hr_qp)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_v2_qp_context *qpc, *msk;
+	dma_addr_t dma_handle;
+	int qpc_sz;
+	int ret;
+
+	qpc_sz = hr_dev->caps.qpc_sz;
+	WARN_ON(2 * qpc_sz > HNS_ROCE_MAILBOX_SIZE);
+	qpc = dma_pool_alloc(hr_dev->cmd.pool, GFP_NOWAIT, &dma_handle);
+	if (!qpc)
+		return -ENOMEM;
+
+	msk = (struct hns_roce_v2_qp_context *)((void *)qpc + qpc_sz);
+	memset(msk, 0xff, qpc_sz);
+
+	ret = config_qp_rq_buf(hr_dev, hr_qp, qpc, msk);
+	if (ret) {
+		ibdev_err(ibdev, "failed to config rq qpc, ret = %d.\n", ret);
+		goto done;
+	}
+
+	ret = config_qp_sq_buf(hr_dev, hr_qp, qpc, msk);
+	if (ret) {
+		ibdev_err(ibdev, "failed to config sq qpc, ret = %d.\n", ret);
+		goto done;
+	}
+
+	ret = hns_roce_mbox_send(hr_dev, dma_handle, 0, hr_qp->qpn, 0,
+				 HNS_ROCE_CMD_MODIFY_QPC);
+	if (ret)
+		ibdev_err(ibdev, "failed to modify DCA buf, ret = %d.\n", ret);
+
+done:
+	dma_pool_free(hr_dev->cmd.pool, qpc, dma_handle);
+
+	return ret;
+}
+
 static int to_ib_qp_st(enum hns_roce_v2_qp_state state)
 {
 	static const enum ib_qp_state map[] = {
@@ -6239,6 +6308,7 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.write_cqc = hns_roce_v2_write_cqc,
 	.set_hem = hns_roce_v2_set_hem,
 	.clear_hem = hns_roce_v2_clear_hem,
+	.set_dca_buf = hns_roce_v2_set_dca_buf,
 	.modify_qp = hns_roce_v2_modify_qp,
 	.qp_flow_control_init = hns_roce_v2_qp_flow_control_init,
 	.init_eq = hns_roce_v2_init_eq_table,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index b8a09d4..3f758d6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -257,6 +257,7 @@ enum hns_roce_opcode_type {
 	HNS_ROCE_OPC_QUERY_VF_RES			= 0x850e,
 	HNS_ROCE_OPC_CFG_GMV_TBL			= 0x850f,
 	HNS_ROCE_OPC_CFG_GMV_BT				= 0x8510,
+	HNS_ROCE_OPC_SYNC_MB				= 0x8511,
 	HNS_ROCE_OPC_EXT_CFG				= 0x8512,
 	HNS_SWITCH_PARAMETER_CFG			= 0x1033,
 };
-- 
2.8.1

