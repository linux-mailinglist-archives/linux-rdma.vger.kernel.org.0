Return-Path: <linux-rdma+bounces-11677-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC85AE9D36
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 14:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DACB3B0C47
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 12:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1605E1BC3F;
	Thu, 26 Jun 2025 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZf/YPRx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB07DE55B
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939608; cv=none; b=cnojprNmWkc/3VBO01jzFw4BLxIcA/mZTDNSanOEYtUBlgjOLffIBiPdrAA4OYrEdZUZDs/W4sJj6On4QwSkE7BWLWfWdGrJVbOjDkOKW3MDlKeLVYG6+YHeMQbBuFy+ssjYkqqDW2ht77KKryHjBE5GBh5WP512XQClWSYkqJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939608; c=relaxed/simple;
	bh=fAIQRvOe6KPuiWCj+MWJSZcKr/QlTbhT+nQTFvOYeaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+MGxMwLKQNhUJmhBS32R8E1jjkgwLAcxay3xnZVNierMwQp1fO8umvujoJlXgT7i6/3jjuN4rfriTj/S+OpQbEzhiHx7X87lDzgSE8bpoME8YVj6HaXqht2/q9hC//XQ4F7OqgNi8itbfiP772fgAAIPb75Hv8DT3FgV4ZTRa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZf/YPRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C68C4CEED;
	Thu, 26 Jun 2025 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750939608;
	bh=fAIQRvOe6KPuiWCj+MWJSZcKr/QlTbhT+nQTFvOYeaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BZf/YPRxrzJMAd4lg8i2cIcZzq8mvYsiAKoPO7SOMkHf1qTPQypgtu8I+GBTRfnNM
	 Xk997EyfmL0AFp4oq4dUBMTrVUiCiuV/hU3KL2AwS+/VZGnrR4OWgWWnK1W/b4+HL1
	 /9fM7PxXGa/5TigOvbxfQexDm9KQsyXFNSECHJiHra87RO9mM5E1y10ulgf8m5MY/X
	 axvcMxRA9vibvMI8d6q0JKZ/feUIhdWSnURgdfBZ4veLnoEeMDOpElgGRrWv2sBciS
	 MrgX78KRagGi6Doi+jNX9AakvdKbXFmy9lYCNsSyEwj3jDntvS5uNKA+wR1hYlrIlo
	 t4UGv5c+3nBhA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next v1 7/7] RDMA/nldev: Check CAP_NET_RAW in user namespace for QP modify
Date: Thu, 26 Jun 2025 15:05:58 +0300
Message-ID: <a21eaf56e3c6194263ff183a332002f54f1eb87b.1750938869.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750938869.git.leon@kernel.org>
References: <cover.1750938869.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parav Pandit <parav@nvidia.com>

Currently, the capability check is done in the default
init_user_ns user namespace. When a process runs in a
non default user namespace, such check fails. Due to this
when a process is running using Podman, it fails to modify
the QP.

Since the RDMA device is a resource within a network namespace,
use the network namespace associated with the RDMA device to
determine its owning user namespace.

Fixes: 0cadb4db79e1 ("RDMA/uverbs: Restrict usage of privileged QKEYs")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/core_priv.h  | 2 +-
 drivers/infiniband/core/nldev.c      | 4 ++--
 drivers/infiniband/core/uverbs_cmd.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 05102769a918..d0fdf168cd6f 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -370,5 +370,5 @@ void rdma_umap_priv_init(struct rdma_umap_priv *priv,
 
 void ib_cq_pool_cleanup(struct ib_device *dev);
 
-bool rdma_nl_get_privileged_qkey(void);
+bool rdma_nl_get_privileged_qkey(const struct ib_device *device);
 #endif /* _CORE_PRIV_H */
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index e9b7a6419291..9e7e41495c59 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -253,9 +253,9 @@ int rdma_nl_put_driver_u64_hex(struct sk_buff *msg, const char *name, u64 value)
 }
 EXPORT_SYMBOL(rdma_nl_put_driver_u64_hex);
 
-bool rdma_nl_get_privileged_qkey(void)
+bool rdma_nl_get_privileged_qkey(const struct ib_device *device)
 {
-	return privileged_qkey || capable(CAP_NET_RAW);
+	return privileged_qkey || rdma_dev_has_raw_cap(device);
 }
 EXPORT_SYMBOL(rdma_nl_get_privileged_qkey);
 
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 84f9bbc781d3..18a67f054a81 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1880,7 +1880,7 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 		attr->path_mig_state = cmd->base.path_mig_state;
 	if (cmd->base.attr_mask & IB_QP_QKEY) {
 		if (cmd->base.qkey & IB_QP_SET_QKEY &&
-		    !rdma_nl_get_privileged_qkey()) {
+		    !rdma_nl_get_privileged_qkey(qp->device)) {
 			ret = -EPERM;
 			goto release_qp;
 		}
-- 
2.49.0


