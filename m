Return-Path: <linux-rdma+bounces-3171-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1790909E59
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 18:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB9628170E
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 16:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55DC1773A;
	Sun, 16 Jun 2024 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLneNkHc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24FF1CA84;
	Sun, 16 Jun 2024 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554139; cv=none; b=DV9o61Xt+31fZj82pQnl2nErg4oduPFHC6BbwOP3AXPfTWaeql5dZpcYWqPRzf+fcWxqnq1I2CM+zfWmZEvJB9m749EpOYDvI/HXV0JBAtpFOecCGLy04t/7OFN1igsdzo91FwQjb0UqSUVT6eJWWfb7d1ln8CUZLTWGazcz81o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554139; c=relaxed/simple;
	bh=BJ3d6xMCOOXWloMi3rpMYglWDRQLRPdU6SAH1ARIgUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kS1iIN0ygiIPiy8jDcoGdB3yv3jfnzNCKQFJDVDrCVEKZTmTdmJ0GZ/EKZps/KhAd1KVFcy8L5N+a4O/12oRW/ZBwwP26pLeMIsKtC9H9JIkUd8grSNUfgNTV0xqfLDTMKACWda/dWvFSmZh8OPSBPpvAPdTngNxEl4hbifT95Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLneNkHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B9AC2BBFC;
	Sun, 16 Jun 2024 16:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718554139;
	bh=BJ3d6xMCOOXWloMi3rpMYglWDRQLRPdU6SAH1ARIgUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rLneNkHc2acFCtsGfzGKbdLntXa8Rgzx2Fq9ddAbBU58Kogg9Lffslx0W8slszXo9
	 8kphe2Ud3IoD8s406r9EjIfGaF5Y9LReXHbEtwlIDdxsXgcbBsYGX+CXbIB4dHw2tP
	 3WAfzIg4Vl5QCVNpFbVJxrZinyw91czTVioh8d5ijBRQZZ+Te8u9pKzVQMYn1DduwQ
	 /R0kthPv2bgVAS1cIaBtz9vqOpqJqYh4GXoU1CTsG9K3b6sXjlugDGfyBbzcMCZdfg
	 4rvD/53OFlctsSpbpLAmjxBoNJ98l8lhPuPvC2LD49zFb5/5IilzUFElJnppT5RVEW
	 66LKIrXF1oRUg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 02/12] net/mlx5: mlx5_ifc update for multi-plane support
Date: Sun, 16 Jun 2024 19:08:34 +0300
Message-ID: <36a74a1b1d2b7b59c99cda4abad1794ddde30230.1718553901.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718553901.git.leon@kernel.org>
References: <cover.1718553901.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

Add new fields to support mlx5 multi-plane feature. Actual support will
be added in following patches.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 09d9d87d62c6..61738990e399 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -793,7 +793,7 @@ struct mlx5_ifc_ads_bits {
 	u8         reserved_at_2[0xe];
 	u8         pkey_index[0x10];
 
-	u8         reserved_at_20[0x8];
+	u8         plane_index[0x8];
 	u8         grh[0x1];
 	u8         mlid[0x7];
 	u8         rlid[0x10];
@@ -1990,7 +1990,8 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   reserved_at_c0[0x8];
 	u8	   migration_multi_load[0x1];
 	u8	   migration_tracking_state[0x1];
-	u8	   reserved_at_ca[0x6];
+	u8	   multiplane_qp_ud[0x1];
+	u8	   reserved_at_cb[0x5];
 	u8	   migration_in_chunks[0x1];
 	u8	   reserved_at_d1[0xf];
 
@@ -4172,7 +4173,8 @@ struct mlx5_ifc_hca_vport_context_bits {
 	u8         has_smi[0x1];
 	u8         has_raw[0x1];
 	u8         grh_required[0x1];
-	u8         reserved_at_104[0xc];
+	u8         reserved_at_104[0x4];
+	u8         num_port_plane[0x8];
 	u8         port_physical_state[0x4];
 	u8         vport_state_policy[0x4];
 	u8         port_state[0x4];
@@ -7692,7 +7694,7 @@ struct mlx5_ifc_mad_ifc_in_bits {
 	u8         op_mod[0x10];
 
 	u8         remote_lid[0x10];
-	u8         reserved_at_50[0x8];
+	u8         plane_index[0x8];
 	u8         port[0x8];
 
 	u8         reserved_at_60[0x20];
@@ -9621,7 +9623,9 @@ struct mlx5_ifc_ptys_reg_bits {
 	u8         an_disable_cap[0x1];
 	u8         reserved_at_3[0x5];
 	u8         local_port[0x8];
-	u8         reserved_at_10[0xd];
+	u8         reserved_at_10[0x8];
+	u8         plane_ind[0x4];
+	u8         reserved_at_1c[0x1];
 	u8         proto_mask[0x3];
 
 	u8         an_status[0x4];
-- 
2.45.2


