Return-Path: <linux-rdma+bounces-11386-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBC8ADC47C
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 10:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E4816374D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 08:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9F328FFE3;
	Tue, 17 Jun 2025 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tyn3fKVB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B46528ECCB;
	Tue, 17 Jun 2025 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750148374; cv=none; b=K3zeqJZF+y1yZSuMsWXgBAs8gRUIF2o+2GKRBRYadckzhHTw4l8ms99OmVvy66J6UWkI7JZ1OXCyYoe7mt2rb3cuHAPIueuSoxWr0yVoF0jOXyYTbjEoVCHjIyd1mwY8Qa5sYXloUj3ruMrSyqKGBIjc7S4YrJEFY4wG1r3lBJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750148374; c=relaxed/simple;
	bh=T77L4n3zswd0kLwliWf/6f51dR7A8oP4n6e1j9mFXmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQKc4JP/ybLIkfaJa1gDDUbN39HHqn1EF3Gc8I0xi12zY7YaYbcQdB/swkLlV1U3YmBsZ9wfuncdPB4HgHAniN5n1oiJrEs64ctfahGka11hxkRr34AyoRg7BF7f0iynT6oWG68kJlbDOI8LVC4srAnqB9enrSyeBd/nrgHSDDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tyn3fKVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06402C4CEE3;
	Tue, 17 Jun 2025 08:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750148373;
	bh=T77L4n3zswd0kLwliWf/6f51dR7A8oP4n6e1j9mFXmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tyn3fKVBLvlr2EDD0PMUfDNZ1JYcy12gH9DZcU6vbJV0BwXlyjSE6rVa85qH1xPy9
	 GWsUS3yJl6ujXJYEsiTjEylLNL1SZyoGXTrWeEXxcan9eF16C3P+p9lBRk+uIwDPfg
	 Qne+U0V/1mBkasLguF9PsFP9xvWA3UydbABYrxXcMCBBL2pcpKUoLYyxNqbWXmUqhy
	 NpzILc2bay0PAS/GEv+HTN1A3dwe1wyzNuX3FJD8yBCvnQx3MNgGA2Y8BX5w/7AyFW
	 chxjrhwwkX7QooepgXt5pbalYgUvx7CGyrVst81epjCgGOPZMVWpVpxUqx/nERk1I/
	 r6umxu5DHVOVQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 1/2] net/mlx5: fs, add multiple prios to RDMA TRANSPORT steering domain
Date: Tue, 17 Jun 2025 11:19:15 +0300
Message-ID: <b299cbb4c8678a33da6e6b6988b5bf6145c54b88.1750148083.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750148083.git.leon@kernel.org>
References: <cover.1750148083.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

RDMA TRANSPORT domains were initially limited to a single priority.
This change allows the domains to have multiple priorities, making
it possible to add several rules and control the order in which
they're evaluated.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 30 ++++++++++++++-----
 include/linux/mlx5/fs.h                       |  2 +-
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 23a7e8e7adfa..63b2aa44084b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3242,34 +3242,48 @@ static int
 init_rdma_transport_rx_root_ns_one(struct mlx5_flow_steering *steering,
 				   int vport_idx)
 {
+	struct mlx5_flow_root_namespace *root_ns;
 	struct fs_prio *prio;
+	int i;
 
 	steering->rdma_transport_rx_root_ns[vport_idx] =
 		create_root_ns(steering, FS_FT_RDMA_TRANSPORT_RX);
 	if (!steering->rdma_transport_rx_root_ns[vport_idx])
 		return -ENOMEM;
 
-	/* create 1 prio*/
-	prio = fs_create_prio(&steering->rdma_transport_rx_root_ns[vport_idx]->ns,
-			      MLX5_RDMA_TRANSPORT_BYPASS_PRIO, 1);
-	return PTR_ERR_OR_ZERO(prio);
+	root_ns = steering->rdma_transport_rx_root_ns[vport_idx];
+
+	for (i = 0; i < MLX5_RDMA_TRANSPORT_BYPASS_PRIO; i++) {
+		prio = fs_create_prio(&root_ns->ns, i, 1);
+		if (IS_ERR(prio))
+			return PTR_ERR(prio);
+	}
+	set_prio_attrs(root_ns);
+	return 0;
 }
 
 static int
 init_rdma_transport_tx_root_ns_one(struct mlx5_flow_steering *steering,
 				   int vport_idx)
 {
+	struct mlx5_flow_root_namespace *root_ns;
 	struct fs_prio *prio;
+	int i;
 
 	steering->rdma_transport_tx_root_ns[vport_idx] =
 		create_root_ns(steering, FS_FT_RDMA_TRANSPORT_TX);
 	if (!steering->rdma_transport_tx_root_ns[vport_idx])
 		return -ENOMEM;
 
-	/* create 1 prio*/
-	prio = fs_create_prio(&steering->rdma_transport_tx_root_ns[vport_idx]->ns,
-			      MLX5_RDMA_TRANSPORT_BYPASS_PRIO, 1);
-	return PTR_ERR_OR_ZERO(prio);
+	root_ns = steering->rdma_transport_tx_root_ns[vport_idx];
+
+	for (i = 0; i < MLX5_RDMA_TRANSPORT_BYPASS_PRIO; i++) {
+		prio = fs_create_prio(&root_ns->ns, i, 1);
+		if (IS_ERR(prio))
+			return PTR_ERR(prio);
+	}
+	set_prio_attrs(root_ns);
+	return 0;
 }
 
 static int init_rdma_transport_rx_root_ns(struct mlx5_flow_steering *steering)
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 939e58c2f386..86055d55836d 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -40,7 +40,7 @@
 
 #define MLX5_SET_CFG(p, f, v) MLX5_SET(create_flow_group_in, p, f, v)
 
-#define MLX5_RDMA_TRANSPORT_BYPASS_PRIO 0
+#define MLX5_RDMA_TRANSPORT_BYPASS_PRIO 16
 #define MLX5_FS_MAX_POOL_SIZE BIT(30)
 
 enum mlx5_flow_destination_type {
-- 
2.49.0


