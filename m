Return-Path: <linux-rdma+bounces-11393-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C374ADC526
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 10:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EDA3B148C
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 08:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE4A28FA8D;
	Tue, 17 Jun 2025 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Id7CFIMG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBA428F955
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149386; cv=none; b=HPwb78gPtTNxbEXa4oC8ecpUsDZgneHPO3T+FKQvOqJ+ITZJMpYDLMPJ2HwGdK5s2aVGpdMKGpTaRmSyAa7d9bxq7z+FpcKFiIJdsUDPUii90okg68k7gMsEKs8TIiT15Mvsk1W6qOEQ0ia51qk8yXLZ0LxHPv6QCa2zkUQra8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149386; c=relaxed/simple;
	bh=7WtxQh8w6hHIdIQ//8NRUb1jKQ7v2FDwhrTf7PuGnDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euchZho+mJloVU7k3YZVwD9P7BYlXB+O3haK0GVH3bmUVFEwHWCdarva7ALa2DwPOHJth6HxCD4gtVMt4TIVasbKzRpWEqgamB7xjuy4aZITm3lcW7jCYzJkJKYfZ33yE4Lm43BTU84CPK+1vu0O7x0BXPwp8WCrpArIz56mIz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Id7CFIMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B15C4CEE3;
	Tue, 17 Jun 2025 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750149386;
	bh=7WtxQh8w6hHIdIQ//8NRUb1jKQ7v2FDwhrTf7PuGnDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Id7CFIMGK2GxQko0gugwwzjCcNXXrgKOzIQF1BSD1hCSl5eMJD4jy2tOvgJLCWzZ0
	 y2xBd1vnNC0RSuxgyAda1RIQQrjxGAYN5LefHHtNZ3Rh3C4bfpVe6h7hBZC8YRyCOa
	 0/0wXeaH0nf7zYzWo4wplVmvOD9sU3LB13Ua9+D4HOgwqUNu+iYasZAzbkCUTKWoey
	 GQmDrBRW+kF8vMSCp+OB7OrqpFCh1qZf5xC0Tj/Uk2Bcf1UqCbpi/ZHXQZdB9WfWY+
	 47sSHSZqoA/co3WL0NDSywkDiQLxWZ1+pszEdUkR0KoLAoDlxTIxT6xd262Rrio1RF
	 zp+11Xhtnjgsg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next 7/7] RDMA/nldev: Check CAP_NET_RAW in user namespace for QP modify
Date: Tue, 17 Jun 2025 11:35:51 +0300
Message-ID: <e2792e64c340b1172ab76534c294f2b5d462ca96.1750148509.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750148509.git.leon@kernel.org>
References: <cover.1750148509.git.leon@kernel.org>
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
index a872643e8039..b444a11be076 100644
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


