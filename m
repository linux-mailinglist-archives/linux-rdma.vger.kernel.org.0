Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EBF609CEC
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 10:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJXIjR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 04:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJXIjP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 04:39:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEF860503
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 01:39:14 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MwpJs187gzmVLl;
        Mon, 24 Oct 2022 16:34:21 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 16:39:10 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 16:39:08 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>, <xuhaoyue1@hisilicon.com>
Subject: [PATCH 1/2] RDMA/hns: Disable local invalidate operation
Date:   Mon, 24 Oct 2022 16:38:13 +0800
Message-ID: <20221024083814.1089722-2-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221024083814.1089722-1-xuhaoyue1@hisilicon.com>
References: <20221024083814.1089722-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

When function reset and local invalidate are mixed, HNS RoCEE may hang.
Before introducing the cause of the problem, two hardware internal
concepts need to be introduced
    1.Execution queue: The queue of hardware execution instructions,
function reset and local invalidate are queued for execution in this queue.
    2.Local queue: A queue that stores local operation instructions.
The instructions in the local queue will be sent to the execution queue
for execution. The instructions in the local queue will not be removed
until the execution is completed.

The reason for the problem is as follows:
1. There is a function reset instruction in the execution queue,
which is currently being executed. A necessary condition for the successful
execution of function reset is: the hardware pipeline needs to empty
the instructions that were not completed before;
2. A local invalidate instruction at the head of the local queue is sent to
the execution queue. Now there are two instructions in the execution queue,
the first is the function reset instruction, and the second is
the local invalidate instruction, which will be executed in sequence;
3. The user has issued many local invalidate operations,
causing the local queue to be filled up.
4. The user still has a new local operation command and is queuing to
enter the local queue. But the local queue is full and cannot receive new
instructions, this instruction is temporarily stored at the hardware
pipeline.
5. The function reset has been waiting for the instruction before the
hardware pipeline stage is drained. The hardware pipeline stage also caches
a local invalidate instruction, so the function reset cannot be completed,
and the instructions after it cannot be executed.

These factors together cause the execution logic deadlock of the hardware,
and the consequence is that RoCEE will not have any response.
Considering that the local operation command may potentially cause RoCEE to
hang, this feature is no longer supported.

Fixes: e93df0108579 ("RDMA/hns: Support local invalidate for hip08 in kernel space")
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 11 -----------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  2 --
 2 files changed, 13 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 1ead35fb031b..7f5a4769cee0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -118,7 +118,6 @@ static const u32 hns_roce_op_code[] = {
 	HR_OPC_MAP(ATOMIC_CMP_AND_SWP,		ATOM_CMP_AND_SWAP),
 	HR_OPC_MAP(ATOMIC_FETCH_AND_ADD,	ATOM_FETCH_AND_ADD),
 	HR_OPC_MAP(SEND_WITH_INV,		SEND_WITH_INV),
-	HR_OPC_MAP(LOCAL_INV,			LOCAL_INV),
 	HR_OPC_MAP(MASKED_ATOMIC_CMP_AND_SWP,	ATOM_MSK_CMP_AND_SWAP),
 	HR_OPC_MAP(MASKED_ATOMIC_FETCH_AND_ADD,	ATOM_MSK_FETCH_AND_ADD),
 	HR_OPC_MAP(REG_MR,			FAST_REG_PMR),
@@ -559,9 +558,6 @@ static int set_rc_opcode(struct hns_roce_dev *hr_dev,
 		else
 			ret = -EOPNOTSUPP;
 		break;
-	case IB_WR_LOCAL_INV:
-		hr_reg_enable(rc_sq_wqe, RC_SEND_WQE_SO);
-		fallthrough;
 	case IB_WR_SEND_WITH_INV:
 		rc_sq_wqe->inv_key = cpu_to_le32(wr->ex.invalidate_rkey);
 		break;
@@ -3222,7 +3218,6 @@ static int hns_roce_v2_write_mtpt(struct hns_roce_dev *hr_dev,
 
 	hr_reg_write(mpt_entry, MPT_ST, V2_MPT_ST_VALID);
 	hr_reg_write(mpt_entry, MPT_PD, mr->pd);
-	hr_reg_enable(mpt_entry, MPT_L_INV_EN);
 
 	hr_reg_write_bool(mpt_entry, MPT_BIND_EN,
 			  mr->access & IB_ACCESS_MW_BIND);
@@ -3313,7 +3308,6 @@ static int hns_roce_v2_frmr_write_mtpt(struct hns_roce_dev *hr_dev,
 
 	hr_reg_enable(mpt_entry, MPT_RA_EN);
 	hr_reg_enable(mpt_entry, MPT_R_INV_EN);
-	hr_reg_enable(mpt_entry, MPT_L_INV_EN);
 
 	hr_reg_enable(mpt_entry, MPT_FRE);
 	hr_reg_clear(mpt_entry, MPT_MR_MW);
@@ -3345,7 +3339,6 @@ static int hns_roce_v2_mw_write_mtpt(void *mb_buf, struct hns_roce_mw *mw)
 	hr_reg_write(mpt_entry, MPT_PD, mw->pdn);
 
 	hr_reg_enable(mpt_entry, MPT_R_INV_EN);
-	hr_reg_enable(mpt_entry, MPT_L_INV_EN);
 	hr_reg_enable(mpt_entry, MPT_LW_EN);
 
 	hr_reg_enable(mpt_entry, MPT_MR_MW);
@@ -3794,7 +3787,6 @@ static const u32 wc_send_op_map[] = {
 	HR_WC_OP_MAP(RDMA_READ,			RDMA_READ),
 	HR_WC_OP_MAP(RDMA_WRITE,		RDMA_WRITE),
 	HR_WC_OP_MAP(RDMA_WRITE_WITH_IMM,	RDMA_WRITE),
-	HR_WC_OP_MAP(LOCAL_INV,			LOCAL_INV),
 	HR_WC_OP_MAP(ATOM_CMP_AND_SWAP,		COMP_SWAP),
 	HR_WC_OP_MAP(ATOM_FETCH_AND_ADD,	FETCH_ADD),
 	HR_WC_OP_MAP(ATOM_MSK_CMP_AND_SWAP,	MASKED_COMP_SWAP),
@@ -3844,9 +3836,6 @@ static void fill_send_wc(struct ib_wc *wc, struct hns_roce_v2_cqe *cqe)
 	case HNS_ROCE_V2_WQE_OP_RDMA_WRITE_WITH_IMM:
 		wc->wc_flags |= IB_WC_WITH_IMM;
 		break;
-	case HNS_ROCE_V2_WQE_OP_LOCAL_INV:
-		wc->wc_flags |= IB_WC_WITH_INVALIDATE;
-		break;
 	case HNS_ROCE_V2_WQE_OP_ATOM_CMP_AND_SWAP:
 	case HNS_ROCE_V2_WQE_OP_ATOM_FETCH_AND_ADD:
 	case HNS_ROCE_V2_WQE_OP_ATOM_MSK_CMP_AND_SWAP:
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index b11579027e82..c7bf2d52c1cd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -179,7 +179,6 @@ enum {
 	HNS_ROCE_V2_WQE_OP_ATOM_MSK_CMP_AND_SWAP	= 0x8,
 	HNS_ROCE_V2_WQE_OP_ATOM_MSK_FETCH_AND_ADD	= 0x9,
 	HNS_ROCE_V2_WQE_OP_FAST_REG_PMR			= 0xa,
-	HNS_ROCE_V2_WQE_OP_LOCAL_INV			= 0xb,
 	HNS_ROCE_V2_WQE_OP_BIND_MW			= 0xc,
 	HNS_ROCE_V2_WQE_OP_MASK				= 0x1f,
 };
@@ -915,7 +914,6 @@ struct hns_roce_v2_rc_send_wqe {
 #define RC_SEND_WQE_OWNER RC_SEND_WQE_FIELD_LOC(7, 7)
 #define RC_SEND_WQE_CQE RC_SEND_WQE_FIELD_LOC(8, 8)
 #define RC_SEND_WQE_FENCE RC_SEND_WQE_FIELD_LOC(9, 9)
-#define RC_SEND_WQE_SO RC_SEND_WQE_FIELD_LOC(10, 10)
 #define RC_SEND_WQE_SE RC_SEND_WQE_FIELD_LOC(11, 11)
 #define RC_SEND_WQE_INLINE RC_SEND_WQE_FIELD_LOC(12, 12)
 #define RC_SEND_WQE_WQE_INDEX RC_SEND_WQE_FIELD_LOC(30, 15)
-- 
2.30.0

