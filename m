Return-Path: <linux-rdma+bounces-8311-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4EDA4E07B
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 15:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145B61887144
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 14:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8434A2054FF;
	Tue,  4 Mar 2025 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pviij37+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BC4204F79
	for <linux-rdma@vger.kernel.org>; Tue,  4 Mar 2025 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097762; cv=none; b=m3uewQeGtrrHolB5D202UD1OJnFlM/Yq/r0rA2sil1s5+eL9P3Rds0h3WF6ySQyYypiiN6a8S3psSq5BP/erg+Yv4LbG4EkNWb4OpHdoYL9KcUpMgoIbqdGoXS5TR4fqW8XS+7myWS17F34fARU1ym8SRA6aPFyC9RHm+ufXeEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097762; c=relaxed/simple;
	bh=SWEIC7EiNX5inIciHZWEAlcmYHAsZ94otUJW5QwN/UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIFsf74lJcaSq1AVZpim0mOOy3i0Bcoy8B2i0os+lG20thCcx1UEA5DqrNNc7gq6lXeW8roITvnCTbtjhBW24bwxEAc9BGoBa1Wqf4+4OW7ZofxWSIj6V9v0rylHQgUjIGZKVy3hWk9bPumC3rdUgKwOKeJKJgmk2F5ketFau/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pviij37+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F47C4CEE5;
	Tue,  4 Mar 2025 14:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741097762;
	bh=SWEIC7EiNX5inIciHZWEAlcmYHAsZ94otUJW5QwN/UE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pviij37+CF26t8fTv9Sh9luje9+nGlBMcttFqgvGMfhUrGbK83yzzrcJulWQ+3FZB
	 Sz3aBmIJ6/kariXVkWH7iDaocobP4V1YVY3tClMWmDYJ3xfWOpAvcMQuJArGilAIQC
	 WptG2ueQdxutiIxT+doCVvz5Gmc+6/Dt8EJFV5e3VTeS/ka0uLzs5VfAdzRpoc3kyw
	 s2feOZ9j50Jwa7bvlkEruyCBqJhVy5hvSvYt0QG5kcCg3LnYOUlQGJtTk73lsziymR
	 LxFP23doAep4Uaj3D8gvSMEQP+0K//JirZhb1muTPPh8lpVFARCt/s504xPbHvEohn
	 2fbUh6Cyx04MQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next 4/5] RDMA/core: Pass port to counter bind/unbind operations
Date: Tue,  4 Mar 2025 16:15:28 +0200
Message-ID: <bdb4b813a3c2e0db69a0b0cceadb329c289539b6.1741097408.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741097408.git.leonro@nvidia.com>
References: <cover.1741097408.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

This will be useful for the next patches in the series since port number
is needed for optional counters binding and unbinding.

Note that this change is needed since when the operation is done qp->port
isn't necessarily initialized yet and can't be used.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/counters.c    | 20 ++++++++++----------
 drivers/infiniband/core/verbs.c       |  2 +-
 drivers/infiniband/hw/mlx5/counters.c |  4 ++--
 include/rdma/ib_verbs.h               |  5 +++--
 include/rdma/rdma_counter.h           |  2 +-
 5 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index b270a208214e..e6ec7b7a40af 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -93,7 +93,7 @@ static void auto_mode_init_counter(struct rdma_counter *counter,
 }
 
 static int __rdma_counter_bind_qp(struct rdma_counter *counter,
-				  struct ib_qp *qp)
+				  struct ib_qp *qp, u32 port)
 {
 	int ret;
 
@@ -104,7 +104,7 @@ static int __rdma_counter_bind_qp(struct rdma_counter *counter,
 		return -EOPNOTSUPP;
 
 	mutex_lock(&counter->lock);
-	ret = qp->device->ops.counter_bind_qp(counter, qp);
+	ret = qp->device->ops.counter_bind_qp(counter, qp, port);
 	mutex_unlock(&counter->lock);
 
 	return ret;
@@ -196,7 +196,7 @@ static struct rdma_counter *alloc_and_bind(struct ib_device *dev, u32 port,
 	kref_init(&counter->kref);
 	mutex_init(&counter->lock);
 
-	ret = __rdma_counter_bind_qp(counter, qp);
+	ret = __rdma_counter_bind_qp(counter, qp, port);
 	if (ret)
 		goto err_mode;
 
@@ -247,7 +247,7 @@ static bool auto_mode_match(struct ib_qp *qp, struct rdma_counter *counter,
 	return match;
 }
 
-static int __rdma_counter_unbind_qp(struct ib_qp *qp)
+static int __rdma_counter_unbind_qp(struct ib_qp *qp, u32 port)
 {
 	struct rdma_counter *counter = qp->counter;
 	int ret;
@@ -256,7 +256,7 @@ static int __rdma_counter_unbind_qp(struct ib_qp *qp)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&counter->lock);
-	ret = qp->device->ops.counter_unbind_qp(qp);
+	ret = qp->device->ops.counter_unbind_qp(qp, port);
 	mutex_unlock(&counter->lock);
 
 	return ret;
@@ -348,7 +348,7 @@ int rdma_counter_bind_qp_auto(struct ib_qp *qp, u32 port)
 
 	counter = rdma_get_counter_auto_mode(qp, port);
 	if (counter) {
-		ret = __rdma_counter_bind_qp(counter, qp);
+		ret = __rdma_counter_bind_qp(counter, qp, port);
 		if (ret) {
 			kref_put(&counter->kref, counter_release);
 			return ret;
@@ -368,7 +368,7 @@ int rdma_counter_bind_qp_auto(struct ib_qp *qp, u32 port)
  * @force:
  *   true - Decrease the counter ref-count anyway (e.g., qp destroy)
  */
-int rdma_counter_unbind_qp(struct ib_qp *qp, bool force)
+int rdma_counter_unbind_qp(struct ib_qp *qp, u32 port, bool force)
 {
 	struct rdma_counter *counter = qp->counter;
 	int ret;
@@ -376,7 +376,7 @@ int rdma_counter_unbind_qp(struct ib_qp *qp, bool force)
 	if (!counter)
 		return -EINVAL;
 
-	ret = __rdma_counter_unbind_qp(qp);
+	ret = __rdma_counter_unbind_qp(qp, port);
 	if (ret && !force)
 		return ret;
 
@@ -523,7 +523,7 @@ int rdma_counter_bind_qpn(struct ib_device *dev, u32 port,
 		goto err_task;
 	}
 
-	ret = __rdma_counter_bind_qp(counter, qp);
+	ret = __rdma_counter_bind_qp(counter, qp, port);
 	if (ret)
 		goto err_task;
 
@@ -614,7 +614,7 @@ int rdma_counter_unbind_qpn(struct ib_device *dev, u32 port,
 		goto out;
 	}
 
-	ret = rdma_counter_unbind_qp(qp, false);
+	ret = rdma_counter_unbind_qp(qp, port, false);
 
 out:
 	rdma_restrack_put(&qp->res);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index dc40001072a5..c5e78bbefbd0 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2105,7 +2105,7 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 	if (!qp->uobject)
 		rdma_rw_cleanup_mrs(qp);
 
-	rdma_counter_unbind_qp(qp, true);
+	rdma_counter_unbind_qp(qp, qp->port, true);
 	ret = qp->device->ops.destroy_qp(qp, udata);
 	if (ret) {
 		if (sec)
diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 018bb96bdbf4..d826f03b6ec5 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -562,7 +562,7 @@ static int mlx5_ib_counter_dealloc(struct rdma_counter *counter)
 }
 
 static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
-				   struct ib_qp *qp)
+				   struct ib_qp *qp, u32 port)
 {
 	struct mlx5_ib_dev *dev = to_mdev(qp->device);
 	int err;
@@ -594,7 +594,7 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 	return err;
 }
 
-static int mlx5_ib_counter_unbind_qp(struct ib_qp *qp)
+static int mlx5_ib_counter_unbind_qp(struct ib_qp *qp, u32 port)
 {
 	return mlx5_ib_qp_set_counter(qp, NULL);
 }
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 90e93297d59e..d42eae69d9a8 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2644,12 +2644,13 @@ struct ib_device_ops {
 	 * @counter - The counter to be bound. If counter->id is zero then
 	 *   the driver needs to allocate a new counter and set counter->id
 	 */
-	int (*counter_bind_qp)(struct rdma_counter *counter, struct ib_qp *qp);
+	int (*counter_bind_qp)(struct rdma_counter *counter, struct ib_qp *qp,
+			       u32 port);
 	/**
 	 * counter_unbind_qp - Unbind the qp from the dynamically-allocated
 	 *   counter and bind it onto the default one
 	 */
-	int (*counter_unbind_qp)(struct ib_qp *qp);
+	int (*counter_unbind_qp)(struct ib_qp *qp, u32 port);
 	/**
 	 * counter_dealloc -De-allocate the hw counter
 	 */
diff --git a/include/rdma/rdma_counter.h b/include/rdma/rdma_counter.h
index 74e635409ff7..4204d08a010a 100644
--- a/include/rdma/rdma_counter.h
+++ b/include/rdma/rdma_counter.h
@@ -51,7 +51,7 @@ int rdma_counter_set_auto_mode(struct ib_device *dev, u32 port,
 			       bool bind_opcnt,
 			       struct netlink_ext_ack *extack);
 int rdma_counter_bind_qp_auto(struct ib_qp *qp, u32 port);
-int rdma_counter_unbind_qp(struct ib_qp *qp, bool force);
+int rdma_counter_unbind_qp(struct ib_qp *qp, u32 port, bool force);
 
 int rdma_counter_query_stats(struct rdma_counter *counter);
 u64 rdma_counter_get_hwstat_value(struct ib_device *dev, u32 port, u32 index);
-- 
2.48.1


