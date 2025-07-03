Return-Path: <linux-rdma+bounces-11866-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9AFAF72A7
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 13:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568A317208A
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 11:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789602E3380;
	Thu,  3 Jul 2025 11:39:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41DE2E4249
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542758; cv=none; b=HvWFz0GgqktscwWN3c2AvnP8/XiWWtgznq9VE2tBV991EyK8aOkcoMJEUJLtCDPbWurwfAssEb7ZJM/1ZiDveU2X3/6mkagSEbmmOyUoZ/0k3medmliXSezv9lHLa9RH9WV5TuNE37Sp6YQ0QHJ7c0QOz2LOWnorwcGwC7Lj5qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542758; c=relaxed/simple;
	bh=VbKF/x5fE3Zh7dPAJDFqOiNUFcpTwUmnOqd7HADo+ks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4rkrvqnMK4iPwzaHqjbCiju+F0LHlD1O5Xs5wGcDDJyt1Y/7cGtiKvD+Vdybah9nSnr667w+i+4mI4pUSOoAYq3tQpX0RJIlz96Mw3U8cuZ91MOtGYEBIHgw2dylsjRMSHl1sn6uQJqB18RguLFR+m5yMpnnzy4xTAwMJ+5p/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bXvrH3StPz2BcpN;
	Thu,  3 Jul 2025 19:37:19 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id CFACF180042;
	Thu,  3 Jul 2025 19:39:07 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Jul 2025 19:39:07 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 3/6] RDMA/hns: Get message length of ack_req from FW
Date: Thu, 3 Jul 2025 19:39:02 +0800
Message-ID: <20250703113905.3597124-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250703113905.3597124-1-huangjunxian6@hisilicon.com>
References: <20250703113905.3597124-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100018.china.huawei.com (7.202.181.17)

ACK_REQ_FREQ indicates the number of packets (after MTU fragmentation)
HW sends before setting an ACK request. When MTU is greater than or
equal to 1024, the current ACK_REQ_FREQ value causes HW to request an
ACK for every MTU fragment. The processing of a large number of ACKs
severely impacts HW performance when sending large size payloads.

Get message length of ack_req from FW so that we can adjust this
parameter according to different situations. There are several
constraints for ACK_REQ_FREQ:

1. mtu * (2 ^ ACK_REQ_FREQ) should not be too large, otherwise it may
   cause some unexpected retries when sending large payload.

2. ACK_REQ_FREQ should be larger than or equal to LP_PKTN_INI.

3. ACK_REQ_FREQ must be equal to LP_PKTN_INI when using LDCP
   or HC3 congestion control algorithm.

Fixes: 56518a603fd2 ("RDMA/hns: Modify the value of long message loopback slice")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 39 +++++++++++++++++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  8 ++++-
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 40dcf77e2d92..25f77b1fa773 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -846,6 +846,7 @@ struct hns_roce_caps {
 	u16		default_ceq_arm_st;
 	u8		cong_cap;
 	enum hns_roce_cong_type default_cong_type;
+	u32             max_ack_req_msg_len;
 };
 
 enum hns_roce_device_state {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 4f2dbc3ffb31..f15eb6204959 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2196,31 +2196,36 @@ static void apply_func_caps(struct hns_roce_dev *hr_dev)
 
 static int hns_roce_query_caps(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_cmq_desc desc[HNS_ROCE_QUERY_PF_CAPS_CMD_NUM];
+	struct hns_roce_cmq_desc desc[HNS_ROCE_QUERY_PF_CAPS_CMD_NUM] = {};
 	struct hns_roce_caps *caps = &hr_dev->caps;
 	struct hns_roce_query_pf_caps_a *resp_a;
 	struct hns_roce_query_pf_caps_b *resp_b;
 	struct hns_roce_query_pf_caps_c *resp_c;
 	struct hns_roce_query_pf_caps_d *resp_d;
 	struct hns_roce_query_pf_caps_e *resp_e;
+	struct hns_roce_query_pf_caps_f *resp_f;
 	enum hns_roce_opcode_type cmd;
 	int ctx_hop_num;
 	int pbl_hop_num;
+	int cmd_num;
 	int ret;
 	int i;
 
 	cmd = hr_dev->is_vf ? HNS_ROCE_OPC_QUERY_VF_CAPS_NUM :
 	      HNS_ROCE_OPC_QUERY_PF_CAPS_NUM;
+	cmd_num = hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08 ?
+		  HNS_ROCE_QUERY_PF_CAPS_CMD_NUM_HIP08 :
+		  HNS_ROCE_QUERY_PF_CAPS_CMD_NUM;
 
-	for (i = 0; i < HNS_ROCE_QUERY_PF_CAPS_CMD_NUM; i++) {
+	for (i = 0; i < cmd_num; i++) {
 		hns_roce_cmq_setup_basic_desc(&desc[i], cmd, true);
-		if (i < (HNS_ROCE_QUERY_PF_CAPS_CMD_NUM - 1))
+		if (i < (cmd_num - 1))
 			desc[i].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
 		else
 			desc[i].flag &= ~cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
 	}
 
-	ret = hns_roce_cmq_send(hr_dev, desc, HNS_ROCE_QUERY_PF_CAPS_CMD_NUM);
+	ret = hns_roce_cmq_send(hr_dev, desc, cmd_num);
 	if (ret)
 		return ret;
 
@@ -2229,6 +2234,7 @@ static int hns_roce_query_caps(struct hns_roce_dev *hr_dev)
 	resp_c = (struct hns_roce_query_pf_caps_c *)desc[2].data;
 	resp_d = (struct hns_roce_query_pf_caps_d *)desc[3].data;
 	resp_e = (struct hns_roce_query_pf_caps_e *)desc[4].data;
+	resp_f = (struct hns_roce_query_pf_caps_f *)desc[5].data;
 
 	caps->local_ca_ack_delay = resp_a->local_ca_ack_delay;
 	caps->max_sq_sg = le16_to_cpu(resp_a->max_sq_sg);
@@ -2293,6 +2299,8 @@ static int hns_roce_query_caps(struct hns_roce_dev *hr_dev)
 	caps->reserved_srqs = hr_reg_read(resp_e, PF_CAPS_E_RSV_SRQS);
 	caps->reserved_lkey = hr_reg_read(resp_e, PF_CAPS_E_RSV_LKEYS);
 
+	caps->max_ack_req_msg_len = le32_to_cpu(resp_f->max_ack_req_msg_len);
+
 	caps->qpc_hop_num = ctx_hop_num;
 	caps->sccc_hop_num = ctx_hop_num;
 	caps->srqc_hop_num = ctx_hop_num;
@@ -4535,7 +4543,9 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	dma_addr_t trrl_ba;
 	dma_addr_t irrl_ba;
 	enum ib_mtu ib_mtu;
+	u8 ack_req_freq;
 	const u8 *smac;
+	int lp_msg_len;
 	u8 lp_pktn_ini;
 	u64 *mtts;
 	u8 *dmac;
@@ -4618,7 +4628,8 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 		return -EINVAL;
 #define MIN_LP_MSG_LEN 1024
 	/* mtu * (2 ^ lp_pktn_ini) should be in the range of 1024 to mtu */
-	lp_pktn_ini = ilog2(max(mtu, MIN_LP_MSG_LEN) / mtu);
+	lp_msg_len = max(mtu, MIN_LP_MSG_LEN);
+	lp_pktn_ini = ilog2(lp_msg_len / mtu);
 
 	if (attr_mask & IB_QP_PATH_MTU) {
 		hr_reg_write(context, QPC_MTU, ib_mtu);
@@ -4628,8 +4639,22 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	hr_reg_write(context, QPC_LP_PKTN_INI, lp_pktn_ini);
 	hr_reg_clear(qpc_mask, QPC_LP_PKTN_INI);
 
-	/* ACK_REQ_FREQ should be larger than or equal to LP_PKTN_INI */
-	hr_reg_write(context, QPC_ACK_REQ_FREQ, lp_pktn_ini);
+	/*
+	 * There are several constraints for ACK_REQ_FREQ:
+	 * 1. mtu * (2 ^ ACK_REQ_FREQ) should not be too large, otherwise
+	 *    it may cause some unexpected retries when sending large
+	 *    payload.
+	 * 2. ACK_REQ_FREQ should be larger than or equal to LP_PKTN_INI.
+	 * 3. ACK_REQ_FREQ must be equal to LP_PKTN_INI when using LDCP
+	 *    or HC3 congestion control algorithm.
+	 */
+	if (hr_qp->cong_type == CONG_TYPE_LDCP ||
+	    hr_qp->cong_type == CONG_TYPE_HC3 ||
+	    hr_dev->caps.max_ack_req_msg_len < lp_msg_len)
+		ack_req_freq = lp_pktn_ini;
+	else
+		ack_req_freq = ilog2(hr_dev->caps.max_ack_req_msg_len / mtu);
+	hr_reg_write(context, QPC_ACK_REQ_FREQ, ack_req_freq);
 	hr_reg_clear(qpc_mask, QPC_ACK_REQ_FREQ);
 
 	hr_reg_clear(qpc_mask, QPC_RX_REQ_PSN_ERR);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index be8ef8ddd422..e64a04d6f85b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1160,7 +1160,8 @@ struct hns_roce_cfg_gmv_tb_b {
 #define GMV_TB_B_SMAC_H GMV_TB_B_FIELD_LOC(47, 32)
 #define GMV_TB_B_SGID_IDX GMV_TB_B_FIELD_LOC(71, 64)
 
-#define HNS_ROCE_QUERY_PF_CAPS_CMD_NUM 5
+#define HNS_ROCE_QUERY_PF_CAPS_CMD_NUM_HIP08 5
+#define HNS_ROCE_QUERY_PF_CAPS_CMD_NUM 6
 struct hns_roce_query_pf_caps_a {
 	u8 number_ports;
 	u8 local_ca_ack_delay;
@@ -1272,6 +1273,11 @@ struct hns_roce_query_pf_caps_e {
 	__le16 aeq_period;
 };
 
+struct hns_roce_query_pf_caps_f {
+	__le32 max_ack_req_msg_len;
+	__le32 rsv[5];
+};
+
 #define PF_CAPS_E_FIELD_LOC(h, l) \
 	FIELD_LOC(struct hns_roce_query_pf_caps_e, h, l)
 
-- 
2.33.0


