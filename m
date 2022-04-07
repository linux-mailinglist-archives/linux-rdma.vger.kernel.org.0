Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201634F8046
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Apr 2022 15:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbiDGNQo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 09:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbiDGNQn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 09:16:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D290166677
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 06:14:42 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KZ1xw4jxdzFpb2;
        Thu,  7 Apr 2022 21:12:20 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
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
Subject: [PATCH for-next 1/2] RDMA/hns: Modify the name of the macro used to map opcodes
Date:   Thu, 7 Apr 2022 21:14:02 +0800
Message-ID: <20220407131403.26040-2-liangwenpeng@huawei.com>
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
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The HNS driver will add private opcodes not defined in ib core. Modify the
macro's name to distinguish between the two types of opcodes.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 62 +++++++++++-----------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 2b0cef17ad45..cf5455cda9c4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -70,22 +70,22 @@ static inline void set_data_seg_v2(struct hns_roce_v2_wqe_data_seg *dseg,
  * defining the mapping, so that the validity can be identified by checking the
  * mapped value is greater than 0.
  */
-#define HR_OPC_MAP(ib_key, hr_key) \
+#define HR_IB_OPC_MAP(ib_key, hr_key) \
 		[IB_WR_ ## ib_key] = 1 + HNS_ROCE_V2_WQE_OP_ ## hr_key
 
 static const u32 hns_roce_op_code[] = {
-	HR_OPC_MAP(RDMA_WRITE,			RDMA_WRITE),
-	HR_OPC_MAP(RDMA_WRITE_WITH_IMM,		RDMA_WRITE_WITH_IMM),
-	HR_OPC_MAP(SEND,			SEND),
-	HR_OPC_MAP(SEND_WITH_IMM,		SEND_WITH_IMM),
-	HR_OPC_MAP(RDMA_READ,			RDMA_READ),
-	HR_OPC_MAP(ATOMIC_CMP_AND_SWP,		ATOM_CMP_AND_SWAP),
-	HR_OPC_MAP(ATOMIC_FETCH_AND_ADD,	ATOM_FETCH_AND_ADD),
-	HR_OPC_MAP(SEND_WITH_INV,		SEND_WITH_INV),
-	HR_OPC_MAP(LOCAL_INV,			LOCAL_INV),
-	HR_OPC_MAP(MASKED_ATOMIC_CMP_AND_SWP,	ATOM_MSK_CMP_AND_SWAP),
-	HR_OPC_MAP(MASKED_ATOMIC_FETCH_AND_ADD,	ATOM_MSK_FETCH_AND_ADD),
-	HR_OPC_MAP(REG_MR,			FAST_REG_PMR),
+	HR_IB_OPC_MAP(RDMA_WRITE, RDMA_WRITE),
+	HR_IB_OPC_MAP(RDMA_WRITE_WITH_IMM, RDMA_WRITE_WITH_IMM),
+	HR_IB_OPC_MAP(SEND, SEND),
+	HR_IB_OPC_MAP(SEND_WITH_IMM, SEND_WITH_IMM),
+	HR_IB_OPC_MAP(RDMA_READ, RDMA_READ),
+	HR_IB_OPC_MAP(ATOMIC_CMP_AND_SWP, ATOM_CMP_AND_SWAP),
+	HR_IB_OPC_MAP(ATOMIC_FETCH_AND_ADD, ATOM_FETCH_AND_ADD),
+	HR_IB_OPC_MAP(SEND_WITH_INV, SEND_WITH_INV),
+	HR_IB_OPC_MAP(LOCAL_INV, LOCAL_INV),
+	HR_IB_OPC_MAP(MASKED_ATOMIC_CMP_AND_SWP, ATOM_MSK_CMP_AND_SWAP),
+	HR_IB_OPC_MAP(MASKED_ATOMIC_FETCH_AND_ADD, ATOM_MSK_FETCH_AND_ADD),
+	HR_IB_OPC_MAP(REG_MR, FAST_REG_PMR),
 };
 
 static u32 to_hr_opcode(u32 ib_opcode)
@@ -3849,23 +3849,23 @@ static int get_cur_qp(struct hns_roce_cq *hr_cq, struct hns_roce_v2_cqe *cqe,
  * value when defining the mapping, so that the validity can be identified by
  * checking whether the mapped value is greater than 0.
  */
-#define HR_WC_OP_MAP(hr_key, ib_key) \
+#define HR_IB_WC_OP_MAP(hr_key, ib_key) \
 		[HNS_ROCE_V2_WQE_OP_ ## hr_key] = 1 + IB_WC_ ## ib_key
 
 static const u32 wc_send_op_map[] = {
-	HR_WC_OP_MAP(SEND,			SEND),
-	HR_WC_OP_MAP(SEND_WITH_INV,		SEND),
-	HR_WC_OP_MAP(SEND_WITH_IMM,		SEND),
-	HR_WC_OP_MAP(RDMA_READ,			RDMA_READ),
-	HR_WC_OP_MAP(RDMA_WRITE,		RDMA_WRITE),
-	HR_WC_OP_MAP(RDMA_WRITE_WITH_IMM,	RDMA_WRITE),
-	HR_WC_OP_MAP(LOCAL_INV,			LOCAL_INV),
-	HR_WC_OP_MAP(ATOM_CMP_AND_SWAP,		COMP_SWAP),
-	HR_WC_OP_MAP(ATOM_FETCH_AND_ADD,	FETCH_ADD),
-	HR_WC_OP_MAP(ATOM_MSK_CMP_AND_SWAP,	MASKED_COMP_SWAP),
-	HR_WC_OP_MAP(ATOM_MSK_FETCH_AND_ADD,	MASKED_FETCH_ADD),
-	HR_WC_OP_MAP(FAST_REG_PMR,		REG_MR),
-	HR_WC_OP_MAP(BIND_MW,			REG_MR),
+	HR_IB_WC_OP_MAP(SEND, SEND),
+	HR_IB_WC_OP_MAP(SEND_WITH_INV, SEND),
+	HR_IB_WC_OP_MAP(SEND_WITH_IMM, SEND),
+	HR_IB_WC_OP_MAP(RDMA_READ, RDMA_READ),
+	HR_IB_WC_OP_MAP(RDMA_WRITE, RDMA_WRITE),
+	HR_IB_WC_OP_MAP(RDMA_WRITE_WITH_IMM, RDMA_WRITE),
+	HR_IB_WC_OP_MAP(LOCAL_INV, LOCAL_INV),
+	HR_IB_WC_OP_MAP(ATOM_CMP_AND_SWAP, COMP_SWAP),
+	HR_IB_WC_OP_MAP(ATOM_FETCH_AND_ADD, FETCH_ADD),
+	HR_IB_WC_OP_MAP(ATOM_MSK_CMP_AND_SWAP, MASKED_COMP_SWAP),
+	HR_IB_WC_OP_MAP(ATOM_MSK_FETCH_AND_ADD, MASKED_FETCH_ADD),
+	HR_IB_WC_OP_MAP(FAST_REG_PMR, REG_MR),
+	HR_IB_WC_OP_MAP(BIND_MW, REG_MR),
 };
 
 static int to_ib_wc_send_op(u32 hr_opcode)
@@ -3878,10 +3878,10 @@ static int to_ib_wc_send_op(u32 hr_opcode)
 }
 
 static const u32 wc_recv_op_map[] = {
-	HR_WC_OP_MAP(RDMA_WRITE_WITH_IMM,		WITH_IMM),
-	HR_WC_OP_MAP(SEND,				RECV),
-	HR_WC_OP_MAP(SEND_WITH_IMM,			WITH_IMM),
-	HR_WC_OP_MAP(SEND_WITH_INV,			RECV),
+	HR_IB_WC_OP_MAP(RDMA_WRITE_WITH_IMM, WITH_IMM),
+	HR_IB_WC_OP_MAP(SEND, RECV),
+	HR_IB_WC_OP_MAP(SEND_WITH_IMM, WITH_IMM),
+	HR_IB_WC_OP_MAP(SEND_WITH_INV, RECV),
 };
 
 static int to_ib_wc_recv_op(u32 hr_opcode)
-- 
2.33.0

