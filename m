Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73BA4C9DF6
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Mar 2022 07:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbiCBGt0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Mar 2022 01:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239743AbiCBGtZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Mar 2022 01:49:25 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B27B2523
        for <linux-rdma@vger.kernel.org>; Tue,  1 Mar 2022 22:48:41 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K7l2S42tmzbc0q;
        Wed,  2 Mar 2022 14:44:00 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 14:48:40 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 14:48:40 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v3 for-next 2/9] =?UTF-8?q?RDMA/hns:=20Remove=20fixed=20pa?= =?UTF-8?q?rameter=20=E2=80=9Ctimeout=E2=80=9D=20in=20the=20mailbox?=
Date:   Wed, 2 Mar 2022 14:48:23 +0800
Message-ID: <20220302064830.61706-3-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220302064830.61706-1-liangwenpeng@huawei.com>
References: <20220302064830.61706-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

From: Chengchang Tang <tangchengchang@huawei.com>

The value of the function parameter “timeout” is unique. Therefore,
it is unnecessary to specify the parameter “timeout” value each time.
So remove it.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c      | 22 ++++++------
 drivers/infiniband/hw/hns/hns_roce_cmd.h      |  2 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c       |  5 ++-
 drivers/infiniband/hw/hns/hns_roce_device.h   |  3 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 35 +++++++------------
 .../infiniband/hw/hns/hns_roce_hw_v2_dfx.c    |  3 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c       |  9 ++---
 drivers/infiniband/hw/hns/hns_roce_srq.c      |  6 ++--
 8 files changed, 34 insertions(+), 51 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index ab89e70b6f04..3642e9282b42 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -49,7 +49,7 @@ static int hns_roce_cmd_mbox_post_hw(struct hns_roce_dev *hr_dev, u64 in_param,
 /* this should be called with "poll_sem" */
 static int __hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 				    u64 out_param, unsigned long in_modifier,
-				    u16 op, unsigned int timeout)
+				    u16 op)
 {
 	int ret;
 
@@ -62,18 +62,18 @@ static int __hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 		return ret;
 	}
 
-	return hr_dev->hw->poll_mbox_done(hr_dev, timeout);
+	return hr_dev->hw->poll_mbox_done(hr_dev);
 }
 
 static int hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 				  u64 out_param, unsigned long in_modifier,
-				  u16 op, unsigned int timeout)
+				  u16 op)
 {
 	int ret;
 
 	down(&hr_dev->cmd.poll_sem);
 	ret = __hns_roce_cmd_mbox_poll(hr_dev, in_param, out_param, in_modifier,
-				       op, timeout);
+				       op);
 	up(&hr_dev->cmd.poll_sem);
 
 	return ret;
@@ -99,7 +99,7 @@ void hns_roce_cmd_event(struct hns_roce_dev *hr_dev, u16 token, u8 status,
 
 static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 				    u64 out_param, unsigned long in_modifier,
-				    u16 op, unsigned int timeout)
+				    u16 op)
 {
 	struct hns_roce_cmdq *cmd = &hr_dev->cmd;
 	struct hns_roce_cmd_context *context;
@@ -130,7 +130,7 @@ static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 	}
 
 	if (!wait_for_completion_timeout(&context->done,
-					 msecs_to_jiffies(timeout))) {
+				msecs_to_jiffies(HNS_ROCE_CMD_TIMEOUT_MSECS))) {
 		dev_err_ratelimited(dev, "[cmd] token 0x%x mailbox 0x%x timeout.\n",
 				    context->token, op);
 		ret = -EBUSY;
@@ -149,20 +149,20 @@ static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 
 static int hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 				  u64 out_param, unsigned long in_modifier,
-				  u16 op, unsigned int timeout)
+				  u16 op)
 {
 	int ret;
 
 	down(&hr_dev->cmd.event_sem);
 	ret = __hns_roce_cmd_mbox_wait(hr_dev, in_param, out_param, in_modifier,
-				       op, timeout);
+				       op);
 	up(&hr_dev->cmd.event_sem);
 
 	return ret;
 }
 
 int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
-		      unsigned long in_modifier, u16 op, unsigned int timeout)
+		      unsigned long in_modifier, u16 op)
 {
 	bool is_busy;
 
@@ -172,10 +172,10 @@ int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
 
 	if (hr_dev->cmd.use_events)
 		return hns_roce_cmd_mbox_wait(hr_dev, in_param, out_param,
-					      in_modifier, op, timeout);
+					      in_modifier, op);
 	else
 		return hns_roce_cmd_mbox_poll(hr_dev, in_param, out_param,
-					      in_modifier, op, timeout);
+					      in_modifier, op);
 }
 
 int hns_roce_cmd_init(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.h b/drivers/infiniband/hw/hns/hns_roce_cmd.h
index 3055996935d5..23937b106aa5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.h
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.h
@@ -140,7 +140,7 @@ enum {
 };
 
 int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
-		      unsigned long in_modifier, u16 op, unsigned int timeout);
+		      unsigned long in_modifier, u16 op);
 
 struct hns_roce_cmd_mailbox *
 hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 6fbfa262e6c7..22bd9e066a38 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -141,7 +141,7 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 
 	/* Send mailbox to hw */
 	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, hr_cq->cqn,
-			HNS_ROCE_CMD_CREATE_CQC, HNS_ROCE_CMD_TIMEOUT_MSECS);
+				HNS_ROCE_CMD_CREATE_CQC);
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 	if (ret) {
 		ibdev_err(ibdev,
@@ -175,8 +175,7 @@ static void free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	int ret;
 
 	ret = hns_roce_cmd_mbox(hr_dev, 0, 0, hr_cq->cqn,
-				HNS_ROCE_CMD_DESTROY_CQC,
-				HNS_ROCE_CMD_TIMEOUT_MSECS);
+				HNS_ROCE_CMD_DESTROY_CQC);
 	if (ret)
 		dev_err(dev, "DESTROY_CQ failed (%d) for CQN %06lx\n", ret,
 			hr_cq->cqn);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 6da996f46cf3..2657f4c513ee 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -854,8 +854,7 @@ struct hns_roce_hw {
 	int (*post_mbox)(struct hns_roce_dev *hr_dev, u64 in_param,
 			 u64 out_param, u32 in_modifier, u16 op,
 			 u16 token, int event);
-	int (*poll_mbox_done)(struct hns_roce_dev *hr_dev,
-			      unsigned int timeout);
+	int (*poll_mbox_done)(struct hns_roce_dev *hr_dev);
 	bool (*chk_mbox_avail)(struct hns_roce_dev *hr_dev, bool *is_busy);
 	int (*set_gid)(struct hns_roce_dev *hr_dev, int gid_index,
 		       const union ib_gid *gid, const struct ib_gid_attr *attr);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c86cf75c4caa..a79ca9d3c62f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1353,8 +1353,7 @@ static int config_hem_ba_to_hw(struct hns_roce_dev *hr_dev, unsigned long obj,
 	if (IS_ERR(mbox))
 		return PTR_ERR(mbox);
 
-	ret = hns_roce_cmd_mbox(hr_dev, base_addr, mbox->dma, obj, op,
-				HNS_ROCE_CMD_TIMEOUT_MSECS);
+	ret = hns_roce_cmd_mbox(hr_dev, base_addr, mbox->dma, obj, op);
 	hns_roce_free_cmd_mailbox(hr_dev, mbox);
 	return ret;
 }
@@ -2874,12 +2873,13 @@ static int v2_post_mbox(struct hns_roce_dev *hr_dev, u64 in_param,
 	return ret;
 }
 
-static int v2_poll_mbox_done(struct hns_roce_dev *hr_dev, unsigned int timeout)
+static int v2_poll_mbox_done(struct hns_roce_dev *hr_dev)
 {
 	u8 status = 0;
 	int ret;
 
-	ret = v2_wait_mbox_complete(hr_dev, timeout, &status);
+	ret = v2_wait_mbox_complete(hr_dev, HNS_ROCE_CMD_TIMEOUT_MSECS,
+				    &status);
 	if (!ret) {
 		if (status != MB_ST_COMPLETE_SUCC)
 			return -EBUSY;
@@ -3992,8 +3992,7 @@ static int hns_roce_v2_clear_hem(struct hns_roce_dev *hr_dev,
 		return PTR_ERR(mailbox);
 
 	/* configure the tag and op */
-	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, obj, op,
-				HNS_ROCE_CMD_TIMEOUT_MSECS);
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, obj, op);
 
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 	return ret;
@@ -4018,8 +4017,7 @@ static int hns_roce_v2_qp_modify(struct hns_roce_dev *hr_dev,
 	memcpy(mailbox->buf + qpc_size, qpc_mask, qpc_size);
 
 	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, hr_qp->qpn,
-				HNS_ROCE_CMD_MODIFY_QPC,
-				HNS_ROCE_CMD_TIMEOUT_MSECS);
+				HNS_ROCE_CMD_MODIFY_QPC);
 
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 
@@ -5093,8 +5091,7 @@ static int hns_roce_v2_query_qpc(struct hns_roce_dev *hr_dev,
 		return PTR_ERR(mailbox);
 
 	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, hr_qp->qpn,
-				HNS_ROCE_CMD_QUERY_QPC,
-				HNS_ROCE_CMD_TIMEOUT_MSECS);
+				HNS_ROCE_CMD_QUERY_QPC);
 	if (ret)
 		goto out;
 
@@ -5461,8 +5458,7 @@ static int hns_roce_v2_modify_srq(struct ib_srq *ibsrq,
 		hr_reg_clear(srqc_mask, SRQC_LIMIT_WL);
 
 		ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, srq->srqn,
-					HNS_ROCE_CMD_MODIFY_SRQC,
-					HNS_ROCE_CMD_TIMEOUT_MSECS);
+					HNS_ROCE_CMD_MODIFY_SRQC);
 		hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 		if (ret) {
 			ibdev_err(&hr_dev->ib_dev,
@@ -5489,8 +5485,7 @@ static int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 
 	srq_context = mailbox->buf;
 	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, srq->srqn,
-				HNS_ROCE_CMD_QUERY_SRQC,
-				HNS_ROCE_CMD_TIMEOUT_MSECS);
+				HNS_ROCE_CMD_QUERY_SRQC);
 	if (ret) {
 		ibdev_err(&hr_dev->ib_dev,
 			  "failed to process cmd of querying SRQ, ret = %d.\n",
@@ -5541,8 +5536,7 @@ static int hns_roce_v2_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
 	hr_reg_clear(cqc_mask, CQC_CQ_PERIOD);
 
 	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, hr_cq->cqn,
-				HNS_ROCE_CMD_MODIFY_CQC,
-				HNS_ROCE_CMD_TIMEOUT_MSECS);
+				HNS_ROCE_CMD_MODIFY_CQC);
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 	if (ret)
 		ibdev_err(&hr_dev->ib_dev,
@@ -5872,12 +5866,10 @@ static void hns_roce_v2_destroy_eqc(struct hns_roce_dev *hr_dev, u32 eqn)
 
 	if (eqn < hr_dev->caps.num_comp_vectors)
 		ret = hns_roce_cmd_mbox(hr_dev, 0, 0, eqn & HNS_ROCE_V2_EQN_M,
-					HNS_ROCE_CMD_DESTROY_CEQC,
-					HNS_ROCE_CMD_TIMEOUT_MSECS);
+					HNS_ROCE_CMD_DESTROY_CEQC);
 	else
 		ret = hns_roce_cmd_mbox(hr_dev, 0, 0, eqn & HNS_ROCE_V2_EQN_M,
-					HNS_ROCE_CMD_DESTROY_AEQC,
-					HNS_ROCE_CMD_TIMEOUT_MSECS);
+					HNS_ROCE_CMD_DESTROY_AEQC);
 	if (ret)
 		dev_err(dev, "[mailbox cmd] destroy eqc(%u) failed.\n", eqn);
 }
@@ -6002,8 +5994,7 @@ static int hns_roce_v2_create_eq(struct hns_roce_dev *hr_dev,
 	if (ret)
 		goto err_cmd_mbox;
 
-	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, eq->eqn,
-				eq_cmd, HNS_ROCE_CMD_TIMEOUT_MSECS);
+	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, eq->eqn, eq_cmd);
 	if (ret) {
 		dev_err(hr_dev->dev, "[mailbox cmd] create eqc failed.\n");
 		goto err_cmd_mbox;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c
index bce3a67b0b2d..107288150e3f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c
@@ -19,8 +19,7 @@ int hns_roce_v2_query_cqc_info(struct hns_roce_dev *hr_dev, u32 cqn,
 
 	cq_context = mailbox->buf;
 	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, cqn,
-				HNS_ROCE_CMD_QUERY_CQC,
-				HNS_ROCE_CMD_TIMEOUT_MSECS);
+				HNS_ROCE_CMD_QUERY_CQC);
 	if (ret) {
 		dev_err(hr_dev->dev, "QUERY cqc cmd process error\n");
 		goto err_mailbox;
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index e0ec839f2f6f..bf4ea6bfff84 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -52,8 +52,7 @@ static int hns_roce_hw_create_mpt(struct hns_roce_dev *hr_dev,
 				  unsigned long mpt_index)
 {
 	return hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, mpt_index,
-				 HNS_ROCE_CMD_CREATE_MPT,
-				 HNS_ROCE_CMD_TIMEOUT_MSECS);
+				 HNS_ROCE_CMD_CREATE_MPT);
 }
 
 int hns_roce_hw_destroy_mpt(struct hns_roce_dev *hr_dev,
@@ -61,8 +60,7 @@ int hns_roce_hw_destroy_mpt(struct hns_roce_dev *hr_dev,
 			    unsigned long mpt_index)
 {
 	return hns_roce_cmd_mbox(hr_dev, 0, mailbox ? mailbox->dma : 0,
-				 mpt_index, HNS_ROCE_CMD_DESTROY_MPT,
-				 HNS_ROCE_CMD_TIMEOUT_MSECS);
+				 mpt_index, HNS_ROCE_CMD_DESTROY_MPT);
 }
 
 static int alloc_mr_key(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
@@ -304,8 +302,7 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 
 	mtpt_idx = key_to_hw_index(mr->key) & (hr_dev->caps.num_mtpts - 1);
 	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, mtpt_idx,
-				HNS_ROCE_CMD_QUERY_MPT,
-				HNS_ROCE_CMD_TIMEOUT_MSECS);
+				HNS_ROCE_CMD_QUERY_MPT);
 	if (ret)
 		goto free_cmd_mbox;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 525e1eba263a..5bb8ccea95a6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -64,8 +64,7 @@ static int hns_roce_hw_create_srq(struct hns_roce_dev *dev,
 				  unsigned long srq_num)
 {
 	return hns_roce_cmd_mbox(dev, mailbox->dma, 0, srq_num,
-				 HNS_ROCE_CMD_CREATE_SRQ,
-				 HNS_ROCE_CMD_TIMEOUT_MSECS);
+				 HNS_ROCE_CMD_CREATE_SRQ);
 }
 
 static int hns_roce_hw_destroy_srq(struct hns_roce_dev *dev,
@@ -73,8 +72,7 @@ static int hns_roce_hw_destroy_srq(struct hns_roce_dev *dev,
 				   unsigned long srq_num)
 {
 	return hns_roce_cmd_mbox(dev, 0, mailbox ? mailbox->dma : 0, srq_num,
-				 HNS_ROCE_CMD_DESTROY_SRQ,
-				 HNS_ROCE_CMD_TIMEOUT_MSECS);
+				 HNS_ROCE_CMD_DESTROY_SRQ);
 }
 
 static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
-- 
2.33.0

