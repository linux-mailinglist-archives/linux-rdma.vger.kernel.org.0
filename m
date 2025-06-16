Return-Path: <linux-rdma+bounces-11332-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B74ADAABE
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 10:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F5316AD5A
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 08:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB068270EBC;
	Mon, 16 Jun 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6SRS9CQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B64B26F44D
	for <linux-rdma@vger.kernel.org>; Mon, 16 Jun 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750062389; cv=none; b=X2CGiTncr7W1K/RXPKzW4L2MfzGVg/E+LuE+Y/mvGTch1WLa9g1h3igvpvDYbfuVlnbene5lERJiF98RiqfLKyrMKGSDRusmMO65TyV8GHgSZKHqOwON/N/m0DcJHcOrpuiTVfYMXz+LstRqbBb4V3EngvisaOva1kN9z0Ed7Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750062389; c=relaxed/simple;
	bh=/2ycs/kt7ViSj708PBlrWC/mABInlsiCmPufQUl7MUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d2PRdnEc+3x93Bw+R2s6k2l/xx8wtFvKOxXsPxJsmpycWOtEuX3bJ3TRf916qdneXWFiHRxwA0eazXwZ2OBK+ZRRtDuWkupKw+91s71or0zzbI7yE8eIpzUqD6CLM0cNKtobslQalth9PBUt05Jmrv+hdqEKZWiIjVPjpPXbbf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6SRS9CQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABCDC4CEEA;
	Mon, 16 Jun 2025 08:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750062389;
	bh=/2ycs/kt7ViSj708PBlrWC/mABInlsiCmPufQUl7MUU=;
	h=From:To:Cc:Subject:Date:From;
	b=A6SRS9CQgUGJUE5/sIabW4527SGfJuz+mDO51ZfxlbB1I197ILNEYjXLa13yk0Cmd
	 6WHo9Ebx79WlOgyNzD82TTXSd1YSzzX/8KIAdT4ouOznVVI8YBy2KftL9zfZGiiJ/F
	 cJdcb30AIQqbVVPF4ojBsd4tymoMJsG0rQCSAH2WWR76JPkuAO7rpj1dhqHQ4lS8wt
	 nNKM6+A1nXztGma6U2cZotAaNesqXsVna8gR6qg9sDoQKkWBjT+KZWc4unI9VkjHWP
	 EpcxgXzWMmb6U1MqmrvH+IpSV4KxW8u6/5QIqEPm6xq3oqVnUABfZO0BTT0p7Xhvh3
	 ERJM8AwqdCmEQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/core: Add driver APIs pre_destroy_cq() and post_destroy_cq()
Date: Mon, 16 Jun 2025 11:26:20 +0300
Message-ID: <b5f7ae3d75f44a3e15ff3f4eb2bbdea13e06b97f.1750062328.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

Currently in ib_free_cq, it disables IRQ or cancel the CQ work before
driver destroy_cq. This isn't good as a new IRQ or a CQ work can be
submitted immediately after disabling IRQ or canceling CQ work, which
may run concurrently with destroy_cq and cause crashes.
The right flow should be:
 1. Driver disables CQ to make sure no new CQ event will be submitted;
 2. Disables IRQ or Cancels CQ work in core layer, to make sure no CQ
    polling work is running;
 3. Free all resources to destroy the CQ.

This patch adds 2 driver APIs:
- pre_destroy_cq(): Disable a CQ to prevent it from generating any new
  work completions, but not free any kernel resources;
- post_destroy_cq(): Free all kernel resources.

In ib_free_cq, the IRQ is disabled or CQ work is canceled after
pre_destroy_cq, and before post_destroy_cq.

Fixes: 14d3a3b2498e ("IB: add a proper completion queue abstraction")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cq.c     | 12 ++++++++++--
 drivers/infiniband/core/device.c |  2 ++
 include/rdma/ib_verbs.h          |  9 +++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index a70876a0a231..584537c71545 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -317,13 +317,18 @@ EXPORT_SYMBOL(__ib_alloc_cq_any);
  */
 void ib_free_cq(struct ib_cq *cq)
 {
-	int ret;
+	int ret = 0;
 
 	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
 		return;
 	if (WARN_ON_ONCE(cq->cqe_used))
 		return;
 
+	if (cq->device->ops.pre_destroy_cq) {
+		ret = cq->device->ops.pre_destroy_cq(cq);
+		WARN_ONCE(ret, "Disable of kernel CQ shouldn't fail");
+	}
+
 	switch (cq->poll_ctx) {
 	case IB_POLL_DIRECT:
 		break;
@@ -340,7 +345,10 @@ void ib_free_cq(struct ib_cq *cq)
 
 	rdma_dim_destroy(cq);
 	trace_cq_free(cq);
-	ret = cq->device->ops.destroy_cq(cq, NULL);
+	if (cq->device->ops.post_destroy_cq)
+		cq->device->ops.post_destroy_cq(cq);
+	else
+		ret = cq->device->ops.destroy_cq(cq, NULL);
 	WARN_ONCE(ret, "Destroy of kernel CQ shouldn't fail");
 	rdma_restrack_del(&cq->res);
 	kfree(cq->wc);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index d4263385850a..468ed6bd4722 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2763,8 +2763,10 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, modify_srq);
 	SET_DEVICE_OP(dev_ops, modify_wq);
 	SET_DEVICE_OP(dev_ops, peek_cq);
+	SET_DEVICE_OP(dev_ops, pre_destroy_cq);
 	SET_DEVICE_OP(dev_ops, poll_cq);
 	SET_DEVICE_OP(dev_ops, port_groups);
+	SET_DEVICE_OP(dev_ops, post_destroy_cq);
 	SET_DEVICE_OP(dev_ops, post_recv);
 	SET_DEVICE_OP(dev_ops, post_send);
 	SET_DEVICE_OP(dev_ops, post_srq_recv);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index af43a8d2a74a..38f68d245fa6 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2489,6 +2489,15 @@ struct ib_device_ops {
 	int (*modify_cq)(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 	int (*destroy_cq)(struct ib_cq *cq, struct ib_udata *udata);
 	int (*resize_cq)(struct ib_cq *cq, int cqe, struct ib_udata *udata);
+	/**
+	 * pre_destroy_cq - Prevent a cq from generating any new work
+	 * completions, but not free any kernel resources
+	 */
+	int (*pre_destroy_cq)(struct ib_cq *cq);
+	/**
+	 * post_destroy_cq - Free all kernel resources
+	 */
+	void (*post_destroy_cq)(struct ib_cq *cq);
 	struct ib_mr *(*get_dma_mr)(struct ib_pd *pd, int mr_access_flags);
 	struct ib_mr *(*reg_user_mr)(struct ib_pd *pd, u64 start, u64 length,
 				     u64 virt_addr, int mr_access_flags,
-- 
2.49.0


