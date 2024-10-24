Return-Path: <linux-rdma+bounces-5504-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115019AE54D
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 14:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 634FBB240C5
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 12:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8A21D6DA1;
	Thu, 24 Oct 2024 12:46:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBBA1D0E06;
	Thu, 24 Oct 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773985; cv=none; b=ovumiFgcYDoNw32NfkbAsKS+TtM/k581hI4+C0pfpYKEFHFlS43o7rKu3EdQDU5JDjjo3Gbg5Ru3GMNXjnQjdBKJAwgFmNjLgPYIVeBIPLc/PZacqIrUudD/rh9S9CXHB2rTqoXjd2r4g4ce6282GbPBPvy6fgbnyOsGPTYWDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773985; c=relaxed/simple;
	bh=KCSF3pqS1j1j3qpR6oOvsDHmOE/iiaihE4/0TDGLTjE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVU4XtMTj69VMiGfdG05Z/kdLjlFsYAjvIS7GzzjVZly8OzKwXEz/2YymFHwzCHuH53eXuxwpOAAbuWdtN4eljLc0IsvLKMLDdnIHqTCNGOCPyZMJLFbG+hMhmS5zDSVmZbkPfLfl7yd/o8LFgqHY1sKuQcVtn06RdB3zeDhxeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XZ5Fq5fzpz1T8wJ;
	Thu, 24 Oct 2024 20:44:15 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id D54F71800A7;
	Thu, 24 Oct 2024 20:46:18 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Oct 2024 20:46:18 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: [PATCH v2 for-rc 5/5] RDMA/hns: Fix cpu stuck caused by printings during reset
Date: Thu, 24 Oct 2024 20:40:00 +0800
Message-ID: <20241024124000.2931869-6-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241024124000.2931869-1-huangjunxian6@hisilicon.com>
References: <20241024124000.2931869-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: wenglianfa <wenglianfa@huawei.com>

During reset, cmd to destroy resources such as qp, cq, and mr may fail,
and error logs will be printed. When a large number of resources are
destroyed, there will be lots of printings, and it may lead to a cpu
stuck.

Delete some unnecessary printings and replace other printing functions
in these paths with the ratelimited version.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Fixes: c7bcb13442e1 ("RDMA/hns: Add SRQ support for hip08 kernel mode")
Fixes: 70f92521584f ("RDMA/hns: Use the reserved loopback QPs to free MR before destroying MPT")
Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")
Signed-off-by: wenglianfa <wenglianfa@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c    |  4 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c   |  4 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 73 ++++++++++------------
 drivers/infiniband/hw/hns/hns_roce_mr.c    |  4 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c   |  4 +-
 5 files changed, 41 insertions(+), 48 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 4ec66611a143..4106423a1b39 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -179,8 +179,8 @@ static void free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	ret = hns_roce_destroy_hw_ctx(hr_dev, HNS_ROCE_CMD_DESTROY_CQC,
 				      hr_cq->cqn);
 	if (ret)
-		dev_err(dev, "DESTROY_CQ failed (%d) for CQN %06lx\n", ret,
-			hr_cq->cqn);
+		dev_err_ratelimited(dev, "DESTROY_CQ failed (%d) for CQN %06lx\n",
+				    ret, hr_cq->cqn);
 
 	xa_erase_irq(&cq_table->array, hr_cq->cqn);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index ee5d2c1bb5ca..f84521be3bea 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -672,8 +672,8 @@ void hns_roce_table_put(struct hns_roce_dev *hr_dev,
 
 	ret = hr_dev->hw->clear_hem(hr_dev, table, obj, HEM_HOP_STEP_DIRECT);
 	if (ret)
-		dev_warn(dev, "failed to clear HEM base address, ret = %d.\n",
-			 ret);
+		dev_warn_ratelimited(dev, "failed to clear HEM base address, ret = %d.\n",
+				     ret);
 
 	hns_roce_free_hem(hr_dev, table->hem[i]);
 	table->hem[i] = NULL;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index aa42c5a9b254..b6a0498a7b03 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -373,19 +373,12 @@ static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 static int check_send_valid(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_qp *hr_qp)
 {
-	struct ib_device *ibdev = &hr_dev->ib_dev;
-
 	if (unlikely(hr_qp->state == IB_QPS_RESET ||
 		     hr_qp->state == IB_QPS_INIT ||
-		     hr_qp->state == IB_QPS_RTR)) {
-		ibdev_err(ibdev, "failed to post WQE, QP state %u!\n",
-			  hr_qp->state);
+		     hr_qp->state == IB_QPS_RTR))
 		return -EINVAL;
-	} else if (unlikely(hr_dev->state >= HNS_ROCE_DEVICE_STATE_RST_DOWN)) {
-		ibdev_err(ibdev, "failed to post WQE, dev state %d!\n",
-			  hr_dev->state);
+	else if (unlikely(hr_dev->state >= HNS_ROCE_DEVICE_STATE_RST_DOWN))
 		return -EIO;
-	}
 
 	return 0;
 }
@@ -2775,8 +2768,8 @@ static int free_mr_modify_rsv_qp(struct hns_roce_dev *hr_dev,
 	ret = hr_dev->hw->modify_qp(&hr_qp->ibqp, attr, mask, IB_QPS_INIT,
 				    IB_QPS_INIT, NULL);
 	if (ret) {
-		ibdev_err(ibdev, "failed to modify qp to init, ret = %d.\n",
-			  ret);
+		ibdev_err_ratelimited(ibdev, "failed to modify qp to init, ret = %d.\n",
+				      ret);
 		return ret;
 	}
 
@@ -3421,8 +3414,8 @@ static int free_mr_post_send_lp_wqe(struct hns_roce_qp *hr_qp)
 
 	ret = hns_roce_v2_post_send(&hr_qp->ibqp, send_wr, &bad_wr);
 	if (ret) {
-		ibdev_err(ibdev, "failed to post wqe for free mr, ret = %d.\n",
-			  ret);
+		ibdev_err_ratelimited(ibdev, "failed to post wqe for free mr, ret = %d.\n",
+				      ret);
 		return ret;
 	}
 
@@ -3461,9 +3454,9 @@ static void free_mr_send_cmd_to_hw(struct hns_roce_dev *hr_dev)
 
 		ret = free_mr_post_send_lp_wqe(hr_qp);
 		if (ret) {
-			ibdev_err(ibdev,
-				  "failed to send wqe (qp:0x%lx) for free mr, ret = %d.\n",
-				  hr_qp->qpn, ret);
+			ibdev_err_ratelimited(ibdev,
+					      "failed to send wqe (qp:0x%lx) for free mr, ret = %d.\n",
+					      hr_qp->qpn, ret);
 			break;
 		}
 
@@ -3474,16 +3467,16 @@ static void free_mr_send_cmd_to_hw(struct hns_roce_dev *hr_dev)
 	while (cqe_cnt) {
 		npolled = hns_roce_v2_poll_cq(&free_mr->rsv_cq->ib_cq, cqe_cnt, wc);
 		if (npolled < 0) {
-			ibdev_err(ibdev,
-				  "failed to poll cqe for free mr, remain %d cqe.\n",
-				  cqe_cnt);
+			ibdev_err_ratelimited(ibdev,
+					      "failed to poll cqe for free mr, remain %d cqe.\n",
+					      cqe_cnt);
 			goto out;
 		}
 
 		if (time_after(jiffies, end)) {
-			ibdev_err(ibdev,
-				  "failed to poll cqe for free mr and timeout, remain %d cqe.\n",
-				  cqe_cnt);
+			ibdev_err_ratelimited(ibdev,
+					      "failed to poll cqe for free mr and timeout, remain %d cqe.\n",
+					      cqe_cnt);
 			goto out;
 		}
 		cqe_cnt -= npolled;
@@ -5061,10 +5054,8 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	int ret = 0;
 
-	if (!check_qp_state(cur_state, new_state)) {
-		ibdev_err(&hr_dev->ib_dev, "Illegal state for QP!\n");
+	if (!check_qp_state(cur_state, new_state))
 		return -EINVAL;
-	}
 
 	if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
 		memset(qpc_mask, 0, hr_dev->caps.qpc_sz);
@@ -5325,7 +5316,7 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	/* SW pass context to HW */
 	ret = hns_roce_v2_qp_modify(hr_dev, context, qpc_mask, hr_qp);
 	if (ret) {
-		ibdev_err(ibdev, "failed to modify QP, ret = %d.\n", ret);
+		ibdev_err_ratelimited(ibdev, "failed to modify QP, ret = %d.\n", ret);
 		goto out;
 	}
 
@@ -5463,7 +5454,9 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 
 	ret = hns_roce_v2_query_qpc(hr_dev, hr_qp->qpn, &context);
 	if (ret) {
-		ibdev_err(ibdev, "failed to query QPC, ret = %d.\n", ret);
+		ibdev_err_ratelimited(ibdev,
+				      "failed to query QPC, ret = %d.\n",
+				      ret);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -5471,7 +5464,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	state = hr_reg_read(&context, QPC_QP_ST);
 	tmp_qp_state = to_ib_qp_st((enum hns_roce_v2_qp_state)state);
 	if (tmp_qp_state == -1) {
-		ibdev_err(ibdev, "Illegal ib_qp_state\n");
+		ibdev_err_ratelimited(ibdev, "Illegal ib_qp_state\n");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -5564,9 +5557,9 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 		ret = hns_roce_v2_modify_qp(&hr_qp->ibqp, NULL, 0,
 					    hr_qp->state, IB_QPS_RESET, udata);
 		if (ret)
-			ibdev_err(ibdev,
-				  "failed to modify QP to RST, ret = %d.\n",
-				  ret);
+			ibdev_err_ratelimited(ibdev,
+					      "failed to modify QP to RST, ret = %d.\n",
+					      ret);
 	}
 
 	send_cq = hr_qp->ibqp.send_cq ? to_hr_cq(hr_qp->ibqp.send_cq) : NULL;
@@ -5609,9 +5602,9 @@ int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 	ret = hns_roce_v2_destroy_qp_common(hr_dev, hr_qp, udata);
 	if (ret)
-		ibdev_err(&hr_dev->ib_dev,
-			  "failed to destroy QP, QPN = 0x%06lx, ret = %d.\n",
-			  hr_qp->qpn, ret);
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "failed to destroy QP, QPN = 0x%06lx, ret = %d.\n",
+				      hr_qp->qpn, ret);
 
 	hns_roce_qp_destroy(hr_dev, hr_qp, udata);
 
@@ -5905,9 +5898,9 @@ static int hns_roce_v2_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
 				HNS_ROCE_CMD_MODIFY_CQC, hr_cq->cqn);
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 	if (ret)
-		ibdev_err(&hr_dev->ib_dev,
-			  "failed to process cmd when modifying CQ, ret = %d.\n",
-			  ret);
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "failed to process cmd when modifying CQ, ret = %d.\n",
+				      ret);
 
 err_out:
 	if (ret)
@@ -5931,9 +5924,9 @@ static int hns_roce_v2_query_cqc(struct hns_roce_dev *hr_dev, u32 cqn,
 	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma,
 				HNS_ROCE_CMD_QUERY_CQC, cqn);
 	if (ret) {
-		ibdev_err(&hr_dev->ib_dev,
-			  "failed to process cmd when querying CQ, ret = %d.\n",
-			  ret);
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "failed to process cmd when querying CQ, ret = %d.\n",
+				      ret);
 		goto err_mailbox;
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 846da8c78b8b..b3f4327d0e64 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -138,8 +138,8 @@ static void hns_roce_mr_free(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr
 					      key_to_hw_index(mr->key) &
 					      (hr_dev->caps.num_mtpts - 1));
 		if (ret)
-			ibdev_warn(ibdev, "failed to destroy mpt, ret = %d.\n",
-				   ret);
+			ibdev_warn_ratelimited(ibdev, "failed to destroy mpt, ret = %d.\n",
+					       ret);
 	}
 
 	free_mr_pbl(hr_dev, mr);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index c9b8233f4b05..70c06ef65603 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -151,8 +151,8 @@ static void free_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 	ret = hns_roce_destroy_hw_ctx(hr_dev, HNS_ROCE_CMD_DESTROY_SRQ,
 				      srq->srqn);
 	if (ret)
-		dev_err(hr_dev->dev, "DESTROY_SRQ failed (%d) for SRQN %06lx\n",
-			ret, srq->srqn);
+		dev_err_ratelimited(hr_dev->dev, "DESTROY_SRQ failed (%d) for SRQN %06lx\n",
+				    ret, srq->srqn);
 
 	xa_erase_irq(&srq_table->xa, srq->srqn);
 
-- 
2.33.0


