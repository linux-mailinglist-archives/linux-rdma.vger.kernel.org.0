Return-Path: <linux-rdma+bounces-6750-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3619C9FC9D4
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2024 09:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F491883597
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2024 08:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065361CDA19;
	Thu, 26 Dec 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gKhwonYn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483CD14658B
	for <linux-rdma@vger.kernel.org>; Thu, 26 Dec 2024 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735202835; cv=none; b=IVROmzBfDstZml3QPR8h7kWghJFEauMunErz00YMEVH2RuzK+mpA8+VoR4UgVMk7GAHHNL0ptb9C4t7pIkQCsP9OdsxGZlqx/09pPQHZY/SYW7W7CQGjxnTGZ+v1txU0/wLWtOhK6/miMLJgd8gqh1wENqlBb5NDu2GDuMtayHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735202835; c=relaxed/simple;
	bh=SouPZSVmfC8MpDNHffD/yDxIzw8kgWAU2kI/v78N7wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cr8zom5gQt1Kvbz1BnNLxi4BiqYFH4ZEkGYVwsHVJ+qXD9p0S+i0ABtBTaLV0Ehgz96Bu4eBTvcJ4vFF+uM2hZo7HVbAQKOXG+q/YZd4guAv5V9tx4d8uQPwB8LViWb30zBqYBFUcLvACtl9VMXBcuMZqZZ3+0mIBGNzoOd4pQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gKhwonYn; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735202824; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wRMBo8l3HhqgnAeHdpnl/g/S82q6QLohLknNEUcyJr4=;
	b=gKhwonYnX54lFQhYJ8pt4ppgE/8u3b/IemBa3nJZwC7yvY2EZNInqUWBccu/TXfc0Z3ur0rz/4yVCJoVJ/H8hqF8v1AZFK9nuogzFBq9R3eK6XYncsje5O/nyA0EqRgtN10/qZQpLhqVRjf3Qscu9Qp7CH9P9IYp0OUybSsN+MI=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WMHVs9t_1735202505 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Dec 2024 16:41:45 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: [PATCH for-next 3/4] RDMA/erdma: Support non-sleeping erdma_post_cmd_wait()
Date: Thu, 26 Dec 2024 16:41:10 +0800
Message-ID: <20241226084141.74823-4-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241226084141.74823-1-boshiyu@linux.alibaba.com>
References: <20241226084141.74823-1-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several scenarios require posting commands to the cmdq in a non-sleepable
context. For example, the cm_alloc_msg() might call erdma_create_ah()
while still holding a spinlock. So we add support for non-sleeping
erdma_post_cmd_wait().

Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma.h       |  4 +--
 drivers/infiniband/hw/erdma/erdma_cmdq.c  | 26 +++++++-------
 drivers/infiniband/hw/erdma/erdma_eq.c    |  6 ++--
 drivers/infiniband/hw/erdma/erdma_main.c  |  7 ++--
 drivers/infiniband/hw/erdma/erdma_qp.c    |  8 +++--
 drivers/infiniband/hw/erdma/erdma_verbs.c | 44 ++++++++++++++---------
 6 files changed, 54 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
index 4f840d8e3beb..f7ed1e4cff99 100644
--- a/drivers/infiniband/hw/erdma/erdma.h
+++ b/drivers/infiniband/hw/erdma/erdma.h
@@ -101,8 +101,6 @@ struct erdma_cmdq {
 	struct erdma_comp_wait *wait_pool;
 	spinlock_t lock;
 
-	bool use_event;
-
 	struct erdma_cmdq_sq sq;
 	struct erdma_cmdq_cq cq;
 	struct erdma_eq eq;
@@ -269,7 +267,7 @@ void erdma_cmdq_destroy(struct erdma_dev *dev);
 
 void erdma_cmdq_build_reqhdr(u64 *hdr, u32 mod, u32 op);
 int erdma_post_cmd_wait(struct erdma_cmdq *cmdq, void *req, u32 req_size,
-			u64 *resp0, u64 *resp1);
+			u64 *resp0, u64 *resp1, bool sleepable);
 void erdma_cmdq_completion_handler(struct erdma_cmdq *cmdq);
 
 int erdma_ceqs_init(struct erdma_dev *dev);
diff --git a/drivers/infiniband/hw/erdma/erdma_cmdq.c b/drivers/infiniband/hw/erdma/erdma_cmdq.c
index a3d8922d1ad1..b867aefe83b2 100644
--- a/drivers/infiniband/hw/erdma/erdma_cmdq.c
+++ b/drivers/infiniband/hw/erdma/erdma_cmdq.c
@@ -182,7 +182,6 @@ int erdma_cmdq_init(struct erdma_dev *dev)
 	int err;
 
 	cmdq->max_outstandings = ERDMA_CMDQ_MAX_OUTSTANDING;
-	cmdq->use_event = false;
 
 	sema_init(&cmdq->credits, cmdq->max_outstandings);
 
@@ -223,8 +222,6 @@ int erdma_cmdq_init(struct erdma_dev *dev)
 
 void erdma_finish_cmdq_init(struct erdma_dev *dev)
 {
-	/* after device init successfully, change cmdq to event mode. */
-	dev->cmdq.use_event = true;
 	arm_cmdq_cq(&dev->cmdq);
 }
 
@@ -312,8 +309,7 @@ static int erdma_poll_single_cmd_completion(struct erdma_cmdq *cmdq)
 	/* Copy 16B comp data after cqe hdr to outer */
 	be32_to_cpu_array(comp_wait->comp_data, cqe + 2, 4);
 
-	if (cmdq->use_event)
-		complete(&comp_wait->wait_event);
+	complete(&comp_wait->wait_event);
 
 	return 0;
 }
@@ -332,9 +328,6 @@ static void erdma_polling_cmd_completions(struct erdma_cmdq *cmdq)
 		if (erdma_poll_single_cmd_completion(cmdq))
 			break;
 
-	if (comp_num && cmdq->use_event)
-		arm_cmdq_cq(cmdq);
-
 	spin_unlock_irqrestore(&cmdq->cq.lock, flags);
 }
 
@@ -342,8 +335,7 @@ void erdma_cmdq_completion_handler(struct erdma_cmdq *cmdq)
 {
 	int got_event = 0;
 
-	if (!test_bit(ERDMA_CMDQ_STATE_OK_BIT, &cmdq->state) ||
-	    !cmdq->use_event)
+	if (!test_bit(ERDMA_CMDQ_STATE_OK_BIT, &cmdq->state))
 		return;
 
 	while (get_next_valid_eqe(&cmdq->eq)) {
@@ -354,6 +346,7 @@ void erdma_cmdq_completion_handler(struct erdma_cmdq *cmdq)
 	if (got_event) {
 		cmdq->cq.cmdsn++;
 		erdma_polling_cmd_completions(cmdq);
+		arm_cmdq_cq(cmdq);
 	}
 
 	notify_eq(&cmdq->eq);
@@ -372,7 +365,7 @@ static int erdma_poll_cmd_completion(struct erdma_comp_wait *comp_ctx,
 		if (time_is_before_jiffies(comp_timeout))
 			return -ETIME;
 
-		msleep(20);
+		udelay(20);
 	}
 
 	return 0;
@@ -403,7 +396,7 @@ void erdma_cmdq_build_reqhdr(u64 *hdr, u32 mod, u32 op)
 }
 
 int erdma_post_cmd_wait(struct erdma_cmdq *cmdq, void *req, u32 req_size,
-			u64 *resp0, u64 *resp1)
+			u64 *resp0, u64 *resp1, bool sleepable)
 {
 	struct erdma_comp_wait *comp_wait;
 	int ret;
@@ -411,7 +404,12 @@ int erdma_post_cmd_wait(struct erdma_cmdq *cmdq, void *req, u32 req_size,
 	if (!test_bit(ERDMA_CMDQ_STATE_OK_BIT, &cmdq->state))
 		return -ENODEV;
 
-	down(&cmdq->credits);
+	if (!sleepable) {
+		while (down_trylock(&cmdq->credits))
+			;
+	} else {
+		down(&cmdq->credits);
+	}
 
 	comp_wait = get_comp_wait(cmdq);
 	if (IS_ERR(comp_wait)) {
@@ -425,7 +423,7 @@ int erdma_post_cmd_wait(struct erdma_cmdq *cmdq, void *req, u32 req_size,
 	push_cmdq_sqe(cmdq, req, req_size, comp_wait);
 	spin_unlock(&cmdq->sq.lock);
 
-	if (cmdq->use_event)
+	if (sleepable)
 		ret = erdma_wait_cmd_completion(comp_wait, cmdq,
 						ERDMA_CMDQ_TIMEOUT_MS);
 	else
diff --git a/drivers/infiniband/hw/erdma/erdma_eq.c b/drivers/infiniband/hw/erdma/erdma_eq.c
index 9a72fec6d5cc..6486234a2360 100644
--- a/drivers/infiniband/hw/erdma/erdma_eq.c
+++ b/drivers/infiniband/hw/erdma/erdma_eq.c
@@ -236,7 +236,8 @@ static int create_eq_cmd(struct erdma_dev *dev, u32 eqn, struct erdma_eq *eq)
 	req.db_dma_addr_l = lower_32_bits(eq->dbrec_dma);
 	req.db_dma_addr_h = upper_32_bits(eq->dbrec_dma);
 
-	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
+				   false);
 }
 
 static int erdma_ceq_init_one(struct erdma_dev *dev, u16 ceqn)
@@ -278,7 +279,8 @@ static void erdma_ceq_uninit_one(struct erdma_dev *dev, u16 ceqn)
 	req.qtype = ERDMA_EQ_TYPE_CEQ;
 	req.vector_idx = ceqn + 1;
 
-	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
+				  false);
 	if (err)
 		return;
 
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 29505bc11168..eef3dca48784 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -392,7 +392,7 @@ static int erdma_dev_attrs_init(struct erdma_dev *dev)
 				CMDQ_OPCODE_QUERY_DEVICE);
 
 	err = erdma_post_cmd_wait(&dev->cmdq, &req_hdr, sizeof(req_hdr), &cap0,
-				  &cap1);
+				  &cap1, true);
 	if (err)
 		return err;
 
@@ -425,7 +425,7 @@ static int erdma_dev_attrs_init(struct erdma_dev *dev)
 				CMDQ_OPCODE_QUERY_FW_INFO);
 
 	err = erdma_post_cmd_wait(&dev->cmdq, &req_hdr, sizeof(req_hdr), &cap0,
-				  &cap1);
+				  &cap1, true);
 	if (!err)
 		dev->attrs.fw_version =
 			FIELD_GET(ERDMA_CMD_INFO0_FW_VER_MASK, cap0);
@@ -446,7 +446,8 @@ static int erdma_device_config(struct erdma_dev *dev)
 	req.cfg = FIELD_PREP(ERDMA_CMD_CONFIG_DEVICE_PGSHIFT_MASK, PAGE_SHIFT) |
 		  FIELD_PREP(ERDMA_CMD_CONFIG_DEVICE_PS_EN_MASK, 1);
 
-	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
+				   true);
 }
 
 static int erdma_res_cb_init(struct erdma_dev *dev)
diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
index 4dfb4272ad86..7698a141bd90 100644
--- a/drivers/infiniband/hw/erdma/erdma_qp.c
+++ b/drivers/infiniband/hw/erdma/erdma_qp.c
@@ -98,7 +98,8 @@ erdma_modify_qp_state_to_rts(struct erdma_qp *qp,
 		req.send_nxt += MPA_DEFAULT_HDR_LEN + params->pd_len;
 	req.recv_nxt = tp->rcv_nxt;
 
-	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
+				  true);
 	if (ret)
 		return ret;
 
@@ -131,7 +132,8 @@ erdma_modify_qp_state_to_stop(struct erdma_qp *qp,
 	req.cfg = FIELD_PREP(ERDMA_CMD_MODIFY_QP_STATE_MASK, params->state) |
 		  FIELD_PREP(ERDMA_CMD_MODIFY_QP_QPN_MASK, QP_ID(qp));
 
-	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
+				  true);
 	if (ret)
 		return ret;
 
@@ -246,7 +248,7 @@ static int modify_qp_cmd_rocev2(struct erdma_qp *qp,
 	req.attr_mask = attr_mask;
 
 	return erdma_post_cmd_wait(&qp->dev->cmdq, &req, sizeof(req), NULL,
-				   NULL);
+				   NULL, true);
 }
 
 static void erdma_reset_qp(struct erdma_qp *qp)
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 27e03474e348..73ec59dcf43e 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -126,8 +126,8 @@ static int create_qp_cmd(struct erdma_ucontext *uctx, struct erdma_qp *qp)
 		}
 	}
 
-	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), &resp0,
-				  &resp1);
+	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), &resp0, &resp1,
+				  true);
 	if (!err && erdma_device_iwarp(dev))
 		qp->attrs.iwarp.cookie =
 			FIELD_GET(ERDMA_CMDQ_CREATE_QP_RESP_COOKIE_MASK, resp0);
@@ -185,7 +185,8 @@ static int regmr_cmd(struct erdma_dev *dev, struct erdma_mr *mr)
 	}
 
 post_cmd:
-	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
+				   true);
 }
 
 static int create_cq_cmd(struct erdma_ucontext *uctx, struct erdma_cq *cq)
@@ -247,7 +248,8 @@ static int create_cq_cmd(struct erdma_ucontext *uctx, struct erdma_cq *cq)
 		}
 	}
 
-	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
+				   true);
 }
 
 static int erdma_alloc_idx(struct erdma_resource_cb *res_cb)
@@ -467,7 +469,8 @@ static void erdma_flush_worker(struct work_struct *work)
 	req.qpn = QP_ID(qp);
 	req.sq_pi = qp->kern_qp.sq_pi;
 	req.rq_pi = qp->kern_qp.rq_pi;
-	erdma_post_cmd_wait(&qp->dev->cmdq, &req, sizeof(req), NULL, NULL);
+	erdma_post_cmd_wait(&qp->dev->cmdq, &req, sizeof(req), NULL, NULL,
+			    true);
 }
 
 static int erdma_qp_validate_cap(struct erdma_dev *dev,
@@ -1265,7 +1268,8 @@ int erdma_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	req.cfg = FIELD_PREP(ERDMA_CMD_MR_MPT_IDX_MASK, ibmr->lkey >> 8) |
 		  FIELD_PREP(ERDMA_CMD_MR_KEY_MASK, ibmr->lkey & 0xFF);
 
-	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
+				  true);
 	if (ret)
 		return ret;
 
@@ -1290,7 +1294,8 @@ int erdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 				CMDQ_OPCODE_DESTROY_CQ);
 	req.cqn = cq->cqn;
 
-	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
+				  true);
 	if (err)
 		return err;
 
@@ -1337,7 +1342,8 @@ int erdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 				CMDQ_OPCODE_DESTROY_QP);
 	req.qpn = QP_ID(qp);
 
-	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
+				  true);
 	if (err)
 		return err;
 
@@ -1435,7 +1441,8 @@ static int alloc_db_resources(struct erdma_dev *dev, struct erdma_ucontext *ctx,
 		  FIELD_PREP(ERDMA_CMD_EXT_DB_RQ_EN_MASK, 1) |
 		  FIELD_PREP(ERDMA_CMD_EXT_DB_SQ_EN_MASK, 1);
 
-	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), &val0, &val1);
+	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), &val0, &val1,
+				  true);
 	if (ret)
 		return ret;
 
@@ -1470,7 +1477,8 @@ static void free_db_resources(struct erdma_dev *dev, struct erdma_ucontext *ctx)
 	req.rdb_off = ctx->ext_db.rdb_off;
 	req.cdb_off = ctx->ext_db.cdb_off;
 
-	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
+				  true);
 	if (ret)
 		ibdev_err_ratelimited(&dev->ibdev,
 				      "free db resources failed %d", ret);
@@ -1834,7 +1842,7 @@ int erdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 		req.qpn = QP_ID(qp);
 
 		ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), &resp0,
-					  &resp1);
+					  &resp1, true);
 		if (ret)
 			return ret;
 
@@ -1997,7 +2005,7 @@ void erdma_set_mtu(struct erdma_dev *dev, u32 mtu)
 				CMDQ_OPCODE_CONF_MTU);
 	req.mtu = mtu;
 
-	erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL, true);
 }
 
 void erdma_port_event(struct erdma_dev *dev, enum ib_event_type reason)
@@ -2067,7 +2075,8 @@ static int erdma_query_hw_stats(struct erdma_dev *dev,
 	req.target_addr = dma_addr;
 	req.target_length = ERDMA_HW_RESP_SIZE;
 
-	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
+				  true);
 	if (err)
 		goto out;
 
@@ -2128,7 +2137,8 @@ static int erdma_set_gid(struct erdma_dev *dev, u8 op, u32 idx,
 
 	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
 				CMDQ_OPCODE_SET_GID);
-	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
+				   true);
 }
 
 int erdma_add_gid(const struct ib_gid_attr *attr, void **context)
@@ -2212,7 +2222,8 @@ int erdma_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	req.ahn = ah->ahn;
 	erdma_set_av_cfg(&req.av_cfg, &ah->av);
 
-	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
+				  true);
 	if (ret) {
 		erdma_free_idx(&dev->res_cb[ERDMA_RES_TYPE_AH], ah->ahn);
 		return ret;
@@ -2235,7 +2246,8 @@ int erdma_destroy_ah(struct ib_ah *ibah, u32 flags)
 	req.pdn = pd->pdn;
 	req.ahn = ah->ahn;
 
-	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
+				  true);
 	if (ret)
 		return ret;
 
-- 
2.46.0


