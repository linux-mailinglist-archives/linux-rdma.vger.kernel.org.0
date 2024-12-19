Return-Path: <linux-rdma+bounces-6654-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EAA9F7B2F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 13:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8748D188571B
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 12:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EC82248B6;
	Thu, 19 Dec 2024 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fc3+KpQ5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AEC2236E0;
	Thu, 19 Dec 2024 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611024; cv=none; b=sGOTHmo3SDew7hWe9MdAhGx1lA+WwHKyJZFTezOuHGcjQ770kLQ6BAKgkngTXC/QAxYdu/7Fcy8/d+v6x+VyRso+DCS+DjE4wY/7mBAZbtUo9spmNVb1SEUof2zRYbWuU00klR/BmWWVSGI6PtqSZJGc8RtbJKo0lCPuVmY1gOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611024; c=relaxed/simple;
	bh=v9SOfhdyGrXUjlehFU2yfEj5/JtSNuel8JEVJBIrnag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VgYu9iieg/2AhtkDghQ4ovXIky3Z8oxvFyk30blZ5HRvxsEJWGvtzVOQmnWXG5zUQ9AwOdOBqzZNgs74fNXZ/a7ihPh67uXTrf6UnQ4ctcf92xCTn8kd9dHEi5lY+s9AcibgYxVLUpfbXUQXvdFWBLVZMVPVueq5bj5dWymna/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fc3+KpQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CEBC4CED0;
	Thu, 19 Dec 2024 12:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734611024;
	bh=v9SOfhdyGrXUjlehFU2yfEj5/JtSNuel8JEVJBIrnag=;
	h=From:To:Cc:Subject:Date:From;
	b=fc3+KpQ5W9L26nG92YFFa/miSM0L+YaG4du6enJpoST/b0vCu01WcRpB8fsEH6ewL
	 RrOXOLnKxrm3RnVjONKfGCBvXPg8wYp6DTKll09Y2ux7tTcb5U1gQ0sBxt22VWkndq
	 C9y/wNt/fY/Zi9cSOE7b6SAhkJBE6bFuwTiT1GX8N8oysTYE+ecUFkaiUeWS+9eYOI
	 dTaoC0Dt9R2RG/KFFEKADL7ITCM3qzC6dtazOO4yJfIgXdBVJ4VTU6eqVwy7DBg8lN
	 BLWmYovQLs8BjEF0uw6x3chJNWJy1El9Waw3PlcQ8NYwO3MjUt+E7eMhfiPSsHmS1M
	 VY3tkzdaC7BAQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	Francesco Poli <invernomuto@paranoici.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next] RDMA/mlx5: Enable multiplane mode only when it is supported
Date: Thu, 19 Dec 2024 14:23:36 +0200
Message-ID: <1ef901acdf564716fcf550453cf5e94f343777ec.1734610916.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

Driver queries vport_cxt.num_plane and enables multiplane when it is
greater then 0, but some old FWs (versions from x.40.1000 till x.42.1000),
report vport_cxt.num_plane = 1 unexpectedly.

Fix it by querying num_plane only when HCA_CAP2.multiplane bit is set.

Fixes: 2a5db20fa532 ("RDMA/mlx5: Add support to multi-plane device and port")
Cc: stable@vger.kernel.org
Reported-by: Francesco Poli <invernomuto@paranoici.org>
Closes: https://lore.kernel.org/all/nvs4i2v7o6vn6zhmtq4sgazy2hu5kiulukxcntdelggmznnl7h@so3oul6uwgbl/
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 include/linux/mlx5/mlx5_ifc.h     | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index c2314797afc9..f5b59d02f4d3 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2839,7 +2839,7 @@ static int mlx5_ib_get_plane_num(struct mlx5_core_dev *mdev, u8 *num_plane)
 	int err;
 
 	*num_plane = 0;
-	if (!MLX5_CAP_GEN(mdev, ib_virt))
+	if (!MLX5_CAP_GEN(mdev, ib_virt) || !MLX5_CAP_GEN_2(mdev, multiplane))
 		return 0;
 
 	err = mlx5_query_hca_vport_context(mdev, 0, 1, 0, &vport_ctx);
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 4fbbcf35498b..48d47181c7cd 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -2119,7 +2119,9 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   migration_in_chunks[0x1];
 	u8	   reserved_at_d1[0x1];
 	u8	   sf_eq_usage[0x1];
-	u8	   reserved_at_d3[0xd];
+	u8	   reserved_at_d3[0x5];
+	u8	   multiplane[0x1];
+	u8	   reserved_at_d9[0x7];
 
 	u8	   cross_vhca_object_to_object_supported[0x20];
 
-- 
2.47.0


