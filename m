Return-Path: <linux-rdma+bounces-11391-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69255ADC527
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 10:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018E8189564D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 08:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8993628FA91;
	Tue, 17 Jun 2025 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmn1YncN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F6419DF6A
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149378; cv=none; b=NCBEYbAC0z02OCyA5cSoF1CLu81g5nOQHhGWbkLTB8zWVU1AUeeeiqjYCZsfiQ772aWApauLfQuoBSxjDYdzdbR6J8l57PXLBSsRlSfE5p9XDgQ9ij3jIJowI/kAGRSSUFZ3csEscbJtSwygsfDsz8iVSyrzKgfpge8d8GkOKuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149378; c=relaxed/simple;
	bh=ZO3L4SLXcbdZJI5blf2hHuXVlvrEgy0hRSDWWptI7jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmdSSCPO1NlbEt3QWbzSIDuA2pLHbn0tfARYqbwkxWeQJEuXpHjtR1MsMXHkxdYGLi9yGQt1ESwqoowVmdQFhxL63ZlUA/DXoaLuOuXYVLV84G/TSkl18+0GiT/DHNx6R3ZKMritDZZgNh5VA45KkiEkOH9BPvDtfrTH7IAr7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmn1YncN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74266C4CEEE;
	Tue, 17 Jun 2025 08:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750149376;
	bh=ZO3L4SLXcbdZJI5blf2hHuXVlvrEgy0hRSDWWptI7jM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmn1YncNMgpN4UTVf+oQXLHK2Ncs3jIOaYIo/epbc9u6Tgw3XnrseaSw4gLq1o4K0
	 mMJAPgCY6zGE1IK6fSMqbuSqQ4EletARWBIalJy+wuFH8MQZyExEy04/NR4t9kDsAu
	 pWFD1uFNze/KoFG1a2DjytLXgEGMTN4ADbPocr2DdeY3swZKATdOEJ8/Yv2mZrHPPl
	 2NuC/9PlKXvs+G37Xq43XsgwDabgahiEdHSVoVrzFqKaXtPZUI8hybvbptO5/28bJj
	 mAo8jnPsFs171ERoi1iGhZMCGNaOzlelPvzZbWRB4rHoWEKXl1ArgNzcz4pXv4pPLu
	 rKrGW44YnVMNA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next 5/7] RDMA/mlx5: Check CAP_NET_RAW in user namespace for devx create
Date: Tue, 17 Jun 2025 11:35:49 +0300
Message-ID: <4ca59ae31ac6300a9f36009d57d0d7547584508d.1750148509.git.leon@kernel.org>
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
when a process is running using podman, it fails to create
the devx object.

Since the RDMA device is a resource within a network namespace,
use the network namespace associated with the RDMA device to
determine its owning user namespace.

Fixes: a8b92ca1b0e5 ("IB/mlx5: Introduce DEVX")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index b690b58ec91d..3d2e194dcf8c 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -159,7 +159,7 @@ int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user, u64 req_ucaps)
 	uctx = MLX5_ADDR_OF(create_uctx_in, in, uctx);
 	if (is_user &&
 	    (MLX5_CAP_GEN(dev->mdev, uctx_cap) & MLX5_UCTX_CAP_RAW_TX) &&
-	    capable(CAP_NET_RAW))
+	    rdma_dev_has_raw_cap(&dev->ib_dev))
 		cap |= MLX5_UCTX_CAP_RAW_TX;
 	if (is_user &&
 	    (MLX5_CAP_GEN(dev->mdev, uctx_cap) &
-- 
2.49.0


