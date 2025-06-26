Return-Path: <linux-rdma+bounces-11676-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC1CAE9D40
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 14:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF951C4374A
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 12:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4524117BA1;
	Thu, 26 Jun 2025 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bG7NROi/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EB113AF2
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939603; cv=none; b=Gf8OBWhejNP4W3Ofn8j1gEa1F+a8DvL6sOwJq3c7lkda4jxs7hNF+nsdvbvXId1hg6GJiC8q1EHrg+6IfNWkvu1uI8kG3yDdJjIn897H12DgyTtlSU3IXytXFwX0SOKUyhgv+h8QpfokQDznxvKqm4nI4eHVIuecHvSrsweZjL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939603; c=relaxed/simple;
	bh=cUhPWWozxiG65D9W0GFZpJZ/QTiKHRCwpPSw5RJ2E2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ob3bg9iBJSgmF+zjsHMXvoZyH8kjh0qZGT5vfDtWNL20cld+oSr8cdrI7Oi5Rzvkb3QjZzdHaI+IfjUTgBkBQ1Z0S6u0SNelpvG2w115zmDzHF9ywJ0nxe5E5rqZJSjcT9YvZsInaTEaRl0ENLq8iynRVT+cCC3potbjdMoRtu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bG7NROi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201ECC4CEEB;
	Thu, 26 Jun 2025 12:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750939602;
	bh=cUhPWWozxiG65D9W0GFZpJZ/QTiKHRCwpPSw5RJ2E2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bG7NROi/3oOzK52rPC8baVHsjKVS1l2n2vaTrbwO2dEbSKmbIvEQ8S85cL/UkI5+h
	 ZZ/mHqGGG26+6TxWn1mtnlmf/bllmY77iIwPNN+nzMO0BBx2WcumGJorvfjzU4Luxx
	 KLGmQNvDjujVgT+n164sGrTfIMsdgmPxkyTa4AvPm8yo4fsWbokhFd1HuSWRaH8U8z
	 hJ/n6E7mgr4G4ebJC4SD2pdK8CaIZrD0Z/6n9OemY3ZATotbEkDuG629+ND7E/ZPkL
	 WYRDKmnhRdHU0ksdSHqhdl/48AoHYnrsxZyzJNXv3dDSCwFccdaDkn3x617p9vFhs5
	 RPImx/0UQMIIw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next v1 4/7] RDMA/mlx5: Check CAP_NET_RAW in user namespace for anchor create
Date: Thu, 26 Jun 2025 15:05:55 +0300
Message-ID: <c3a7cf0ba6c0bb778fe5e4585645731dab367005.1750938869.git.leon@kernel.org>
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
when a process is running using podman, it fails to create
the anchor.

Since the RDMA device is a resource within a network namespace,
use the network namespace associated with the RDMA device to
determine its owning user namespace.

Fixes: 0c6ab0ca9a66 ("RDMA/mlx5: Expose steering anchor to userspace")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 774239d9efdc..075d6dacb1cc 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -2989,7 +2989,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_STEERING_ANCHOR_CREATE)(
 	u32 ft_id;
 	int err;
 
-	if (!capable(CAP_NET_RAW))
+	if (!rdma_dev_has_raw_cap(&dev->ib_dev))
 		return -EPERM;
 
 	err = uverbs_get_const(&ib_uapi_ft_type, attrs,
-- 
2.49.0


