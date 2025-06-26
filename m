Return-Path: <linux-rdma+bounces-11689-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F59AEA5F5
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 20:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CDE81C4452C
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 18:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E11A2EF2B9;
	Thu, 26 Jun 2025 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="of4PFmXH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B252EF294
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964318; cv=none; b=AVvAB2rMkeRzx77fe9N4EwULfCKm8fNRZapf0569/gXggImuau6AjyNIfG66kT56bO1wqlffB7ADqgtAfjfS9QdgNc2bB6w/LttRS06Yf0f5OjmRA1NPwBZp/+t8rOkRrnalEGFMsfnhyDhyQa9OX6BlUoEQsBmNRGnQI5XYU48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964318; c=relaxed/simple;
	bh=+Xt8VwJNv9KEzr6/Px4GaRSE4iXhJlhtk3zxb/nS9rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ejr5ofcXx0nqyi8MIfZSR1ZjatMnALn55G0WNGTUAI8vWS0d5yHMCYBImTT+JnV6WixwxF/Bfs1cImaISmN9iLucz6CjIymrQrBM5yUdhuaMXP1B+NPQPpTG8hQ/HjnvHYJxnKqvHTYk/+Rj1WBSrMUikkMAfXxqnshDw8xQ9iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=of4PFmXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1958C4CEEB;
	Thu, 26 Jun 2025 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750964316;
	bh=+Xt8VwJNv9KEzr6/Px4GaRSE4iXhJlhtk3zxb/nS9rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=of4PFmXHvdEu+jDeU3FdeoYGQH7k7eN38Rk/omCGds1sbs4D5la2pQB5YYqhSA0XG
	 89VPIe9J26l3lEoclEYTqTAtlWegQtIporuemyMrpOcu3Z3wf/JUzlKEp+71veqaSV
	 XeEPZ9O+qDMt79BXWFbE81qluDbmqt2ZM4QpPkYOOJh2gVGkpMl8CWUvYRQiHu7Do/
	 S3ZdwK7eF1KezxOgEncPaJx1AzD8VFPSW2S1FCQI5zW3J2QArEa4C7PvCZ2hZ51724
	 sDTRWLvKXO2JJaHnD0Zsu6nMCfTPi0JEh0mDFIQQwETOhvkwH8kXFS8Mg/HUV7gKiQ
	 rXGmOl0b8Ft5A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next v2 2/9] RDMA/mlx5: Check CAP_NET_RAW in user namespace for flow create
Date: Thu, 26 Jun 2025 21:58:05 +0300
Message-ID: <a4dcd5e3ac6904ef50b19e56942ca6ab0728794c.1750963874.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750963874.git.leon@kernel.org>
References: <cover.1750963874.git.leon@kernel.org>
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
when a process is running using Podman, it fails to create
the flow.

Since the RDMA device is a resource within a network namespace,
use the network namespace associated with the RDMA device to
determine its owning user namespace.

Fixes: 322694412400 ("IB/mlx5: Introduce driver create and destroy flow methods")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index ebcc05f766e1..58e058c067d3 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -2459,7 +2459,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 	struct mlx5_ib_dev *dev;
 	u32 flags;
 
-	if (!capable(CAP_NET_RAW))
+	if (!rdma_uattrs_has_raw_cap(attrs))
 		return -EPERM;
 
 	fs_matcher = uverbs_attr_get_obj(attrs,
-- 
2.49.0


