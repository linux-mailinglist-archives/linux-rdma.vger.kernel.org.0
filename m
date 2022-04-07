Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206994F8044
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Apr 2022 15:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbiDGNQn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 09:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiDGNQm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 09:16:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C47C16665F
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 06:14:42 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KZ1vm69JFzBs6n;
        Thu,  7 Apr 2022 21:10:28 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 21:14:40 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 21:14:40 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 2/2] RDMA/hns: Add NOP operation for sending WR
Date:   Thu, 7 Apr 2022 21:14:03 +0800
Message-ID: <20220407131403.26040-3-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220407131403.26040-1-liangwenpeng@huawei.com>
References: <20220407131403.26040-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

The NOP operation is a no-op, mainly used in scenarios where SQWQE requires
page alignment or WQE size alignment. Each NOP WR consumes one SQWQE, but
the hardware does not operate and directly generates a CQE. The IB
specification does not specify this type of WR.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 9 +++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index cf5455cda9c4..0494e3330be0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -73,6 +73,9 @@ static inline void set_data_seg_v2(struct hns_roce_v2_wqe_data_seg *dseg,
 #define HR_IB_OPC_MAP(ib_key, hr_key) \
 		[IB_WR_ ## ib_key] = 1 + HNS_ROCE_V2_WQE_OP_ ## hr_key
 
+#define HR_PRIV_OPC_MAP(hr_key) \
+		[HNS_ROCE_WR_ ## hr_key] = 1 + HNS_ROCE_V2_WQE_OP_ ## hr_key
+
 static const u32 hns_roce_op_code[] = {
 	HR_IB_OPC_MAP(RDMA_WRITE, RDMA_WRITE),
 	HR_IB_OPC_MAP(RDMA_WRITE_WITH_IMM, RDMA_WRITE_WITH_IMM),
@@ -86,6 +89,7 @@ static const u32 hns_roce_op_code[] = {
 	HR_IB_OPC_MAP(MASKED_ATOMIC_CMP_AND_SWP, ATOM_MSK_CMP_AND_SWAP),
 	HR_IB_OPC_MAP(MASKED_ATOMIC_FETCH_AND_ADD, ATOM_MSK_FETCH_AND_ADD),
 	HR_IB_OPC_MAP(REG_MR, FAST_REG_PMR),
+	HR_PRIV_OPC_MAP(NOP),
 };
 
 static u32 to_hr_opcode(u32 ib_opcode)
@@ -540,6 +544,7 @@ static int set_rc_opcode(struct hns_roce_dev *hr_dev,
 		break;
 	case IB_WR_SEND:
 	case IB_WR_SEND_WITH_IMM:
+	case HNS_ROCE_WR_NOP:
 		break;
 	case IB_WR_ATOMIC_CMP_AND_SWP:
 	case IB_WR_ATOMIC_FETCH_AND_ADD:
@@ -3852,6 +3857,9 @@ static int get_cur_qp(struct hns_roce_cq *hr_cq, struct hns_roce_v2_cqe *cqe,
 #define HR_IB_WC_OP_MAP(hr_key, ib_key) \
 		[HNS_ROCE_V2_WQE_OP_ ## hr_key] = 1 + IB_WC_ ## ib_key
 
+#define HR_PRIV_WC_OP_MAP(hr_key) \
+		[HNS_ROCE_V2_WQE_OP_ ## hr_key] = 1 + HNS_ROCE_WC_ ## hr_key
+
 static const u32 wc_send_op_map[] = {
 	HR_IB_WC_OP_MAP(SEND, SEND),
 	HR_IB_WC_OP_MAP(SEND_WITH_INV, SEND),
@@ -3866,6 +3874,7 @@ static const u32 wc_send_op_map[] = {
 	HR_IB_WC_OP_MAP(ATOM_MSK_FETCH_AND_ADD, MASKED_FETCH_ADD),
 	HR_IB_WC_OP_MAP(FAST_REG_PMR, REG_MR),
 	HR_IB_WC_OP_MAP(BIND_MW, REG_MR),
+	HR_PRIV_WC_OP_MAP(NOP),
 };
 
 static int to_ib_wc_send_op(u32 hr_opcode)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 0d87b627601e..9e7f7148a9ad 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -170,6 +170,14 @@ enum {
 
 #define	GID_LEN_V2				16
 
+enum {
+	HNS_ROCE_WR_NOP = IB_WR_RESERVED4,
+};
+
+enum {
+	HNS_ROCE_WC_NOP = HNS_ROCE_WR_NOP,
+};
+
 enum {
 	HNS_ROCE_V2_WQE_OP_SEND				= 0x0,
 	HNS_ROCE_V2_WQE_OP_SEND_WITH_INV		= 0x1,
@@ -184,6 +192,7 @@ enum {
 	HNS_ROCE_V2_WQE_OP_FAST_REG_PMR			= 0xa,
 	HNS_ROCE_V2_WQE_OP_LOCAL_INV			= 0xb,
 	HNS_ROCE_V2_WQE_OP_BIND_MW			= 0xc,
+	HNS_ROCE_V2_WQE_OP_NOP				= 0x13,
 	HNS_ROCE_V2_WQE_OP_MASK				= 0x1f,
 };
 
-- 
2.33.0

