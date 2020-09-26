Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6338327984A
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Sep 2020 12:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgIZKUC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Sep 2020 06:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZKUC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 26 Sep 2020 06:20:02 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2342B238E5;
        Sat, 26 Sep 2020 10:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601115601;
        bh=e4eL9b682zXfm7H+m7ux/nNq+FhO4i6kzoFaXg5CC9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1OcHxi4uWrLrR4aI40x0e11NIExLDkxqymkvhg0aF4PUxPJxpvTaRYVf7ejgM0mcY
         MVRytDajFHkMKHEIWJhjIDfo5GoKa3q96C2ISyrHZbC+rwHheElOs/RNGe1ukuVLbp
         mdEcSKukdYiH/Pvhk1bL0gaCuVxRaGz2PqwVfd1s=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v3 2/9] RDMA/counter: Combine allocation and bind logic
Date:   Sat, 26 Sep 2020 13:19:31 +0300
Message-Id: <20200926101938.2964394-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200926101938.2964394-1-leon@kernel.org>
References: <20200926101938.2964394-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

RDMA counters are allocated and bounded to QP immediately after that.
Only after this two step process they are really usable. By combining
the logic, we are ensuring that once counter is returned to the caller,
it will have everything set.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/counters.c | 130 +++++++++++++----------------
 1 file changed, 58 insertions(+), 72 deletions(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index fa1a4a318fd7..e208cc6d3cb0 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -64,8 +64,40 @@ int rdma_counter_set_auto_mode(struct ib_device *dev, u8 port,
 	return ret;
 }
 
-static struct rdma_counter *rdma_counter_alloc(struct ib_device *dev, u8 port,
-					       enum rdma_nl_counter_mode mode)
+static void auto_mode_init_counter(struct rdma_counter *counter,
+				   const struct ib_qp *qp,
+				   enum rdma_nl_counter_mask new_mask)
+{
+	struct auto_mode_param *param = &counter->mode.param;
+
+	counter->mode.mode = RDMA_COUNTER_MODE_AUTO;
+	counter->mode.mask = new_mask;
+
+	if (new_mask & RDMA_COUNTER_MASK_QP_TYPE)
+		param->qp_type = qp->qp_type;
+}
+
+static int __rdma_counter_bind_qp(struct rdma_counter *counter,
+				  struct ib_qp *qp)
+{
+	int ret;
+
+	if (qp->counter)
+		return -EINVAL;
+
+	if (!qp->device->ops.counter_bind_qp)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&counter->lock);
+	ret = qp->device->ops.counter_bind_qp(counter, qp);
+	mutex_unlock(&counter->lock);
+
+	return ret;
+}
+
+static struct rdma_counter *alloc_and_bind(struct ib_device *dev, u8 port,
+					   struct ib_qp *qp,
+					   enum rdma_nl_counter_mode mode)
 {
 	struct rdma_port_counter *port_counter;
 	struct rdma_counter *counter;
@@ -88,11 +120,19 @@ static struct rdma_counter *rdma_counter_alloc(struct ib_device *dev, u8 port,
 
 	port_counter = &dev->port_data[port].port_counter;
 	mutex_lock(&port_counter->lock);
-	if (mode == RDMA_COUNTER_MODE_MANUAL) {
+	switch (mode) {
+	case RDMA_COUNTER_MODE_MANUAL:
 		ret = __counter_set_mode(&port_counter->mode,
 					 RDMA_COUNTER_MODE_MANUAL, 0);
 		if (ret)
 			goto err_mode;
+		break;
+	case RDMA_COUNTER_MODE_AUTO:
+		auto_mode_init_counter(counter, qp, port_counter->mode.mask);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		goto err_mode;
 	}
 
 	port_counter->num_counters++;
@@ -102,6 +142,12 @@ static struct rdma_counter *rdma_counter_alloc(struct ib_device *dev, u8 port,
 	kref_init(&counter->kref);
 	mutex_init(&counter->lock);
 
+	ret = __rdma_counter_bind_qp(counter, qp);
+	if (ret)
+		goto err_mode;
+
+	rdma_restrack_parent_name(&counter->res, &qp->res);
+	rdma_restrack_add(&counter->res);
 	return counter;
 
 err_mode:
@@ -132,19 +178,6 @@ static void rdma_counter_free(struct rdma_counter *counter)
 	kfree(counter);
 }
 
-static void auto_mode_init_counter(struct rdma_counter *counter,
-				   const struct ib_qp *qp,
-				   enum rdma_nl_counter_mask new_mask)
-{
-	struct auto_mode_param *param = &counter->mode.param;
-
-	counter->mode.mode = RDMA_COUNTER_MODE_AUTO;
-	counter->mode.mask = new_mask;
-
-	if (new_mask & RDMA_COUNTER_MASK_QP_TYPE)
-		param->qp_type = qp->qp_type;
-}
-
 static bool auto_mode_match(struct ib_qp *qp, struct rdma_counter *counter,
 			    enum rdma_nl_counter_mask auto_mask)
 {
@@ -161,24 +194,6 @@ static bool auto_mode_match(struct ib_qp *qp, struct rdma_counter *counter,
 	return match;
 }
 
-static int __rdma_counter_bind_qp(struct rdma_counter *counter,
-				  struct ib_qp *qp)
-{
-	int ret;
-
-	if (qp->counter)
-		return -EINVAL;
-
-	if (!qp->device->ops.counter_bind_qp)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&counter->lock);
-	ret = qp->device->ops.counter_bind_qp(counter, qp);
-	mutex_unlock(&counter->lock);
-
-	return ret;
-}
-
 static int __rdma_counter_unbind_qp(struct ib_qp *qp)
 {
 	struct rdma_counter *counter = qp->counter;
@@ -247,13 +262,6 @@ static struct rdma_counter *rdma_get_counter_auto_mode(struct ib_qp *qp,
 	return counter;
 }
 
-static void rdma_counter_res_add(struct rdma_counter *counter,
-				 struct ib_qp *qp)
-{
-	rdma_restrack_parent_name(&counter->res, &qp->res);
-	rdma_restrack_add(&counter->res);
-}
-
 static void counter_release(struct kref *kref)
 {
 	struct rdma_counter *counter;
@@ -293,19 +301,9 @@ int rdma_counter_bind_qp_auto(struct ib_qp *qp, u8 port)
 			return ret;
 		}
 	} else {
-		counter = rdma_counter_alloc(dev, port, RDMA_COUNTER_MODE_AUTO);
+		counter = alloc_and_bind(dev, port, qp, RDMA_COUNTER_MODE_AUTO);
 		if (!counter)
 			return -ENOMEM;
-
-		auto_mode_init_counter(counter, qp, port_counter->mode.mask);
-
-		ret = __rdma_counter_bind_qp(counter, qp);
-		if (ret) {
-			rdma_counter_free(counter);
-			return ret;
-		}
-
-		rdma_counter_res_add(counter, qp);
 	}
 
 	return 0;
@@ -419,15 +417,6 @@ static struct ib_qp *rdma_counter_get_qp(struct ib_device *dev, u32 qp_num)
 	return NULL;
 }
 
-static int rdma_counter_bind_qp_manual(struct rdma_counter *counter,
-				       struct ib_qp *qp)
-{
-	if ((counter->device != qp->device) || (counter->port != qp->port))
-		return -EINVAL;
-
-	return __rdma_counter_bind_qp(counter, qp);
-}
-
 static struct rdma_counter *rdma_get_counter_by_id(struct ib_device *dev,
 						   u32 counter_id)
 {
@@ -475,7 +464,12 @@ int rdma_counter_bind_qpn(struct ib_device *dev, u8 port,
 		goto err_task;
 	}
 
-	ret = rdma_counter_bind_qp_manual(counter, qp);
+	if ((counter->device != qp->device) || (counter->port != qp->port)) {
+		ret = -EINVAL;
+		goto err_task;
+	}
+
+	ret = __rdma_counter_bind_qp(counter, qp);
 	if (ret)
 		goto err_task;
 
@@ -520,26 +514,18 @@ int rdma_counter_bind_qpn_alloc(struct ib_device *dev, u8 port,
 		goto err;
 	}
 
-	counter = rdma_counter_alloc(dev, port, RDMA_COUNTER_MODE_MANUAL);
+	counter = alloc_and_bind(dev, port, qp, RDMA_COUNTER_MODE_MANUAL);
 	if (!counter) {
 		ret = -ENOMEM;
 		goto err;
 	}
 
-	ret = rdma_counter_bind_qp_manual(counter, qp);
-	if (ret)
-		goto err_bind;
-
 	if (counter_id)
 		*counter_id = counter->id;
 
-	rdma_counter_res_add(counter, qp);
-
 	rdma_restrack_put(&qp->res);
-	return ret;
+	return 0;
 
-err_bind:
-	rdma_counter_free(counter);
 err:
 	rdma_restrack_put(&qp->res);
 	return ret;
-- 
2.26.2

