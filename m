Return-Path: <linux-rdma+bounces-11826-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34C4AF11C4
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 12:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0763B52414B
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 10:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D20F255F2C;
	Wed,  2 Jul 2025 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOFGy3dH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59741255240;
	Wed,  2 Jul 2025 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451860; cv=none; b=OptB1UQusWH34txxuN8VbNkbShIQDcRpuxWjq26vmw3/69JZTErjnzb5a57nE2gajaNk0CNfo/jeL0qAdcATWDA6QiGebIDkECVxxEBbq/IWYM5pcPnxJE7igffMEuf2djYvH8qCMMI+9kXFx6aD6vimecEwAmuv1+vjgEQfO8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451860; c=relaxed/simple;
	bh=QziBTzn9pfoCluMW4XJIMJiTnb+1rnWecveFvbn19AY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBW5FTL8D16tKnOLv2nQ4eMc/zQqO03V1dWYsi/n/RB2ImXonEjlahBrmcEVKw7YrMxNHwdXJ0CBZQMfHOScNJ+daEss1C8YIfcD2QT6UzTxDqkxU/Q9VgVDV36Gpzw+8JfGpsdMSyzkpS5vUx7FrB86xBA/MF8SJ4lmrNDqDYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOFGy3dH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35112C4CEF1;
	Wed,  2 Jul 2025 10:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751451859;
	bh=QziBTzn9pfoCluMW4XJIMJiTnb+1rnWecveFvbn19AY=;
	h=From:To:Cc:Subject:Date:From;
	b=nOFGy3dHA79nFigNV5llUmBLovXv2bjKy5UJmx6GFHbs2FP6CkTuwkL81BZyTLOyI
	 zQjFtONzx/I4lOEZAVL6Qw/loP+REbhMevi2fWJIVel10a2twaDTrxIv9QBmuicWr9
	 /xQOJYHuSBAcN96jwF5znjCowzF+atB1ij12WyZqp6vhW/q0HKNWs8e49ucQner8uQ
	 8UqKKURV/+rd9HR/KlBj6BCimk8DUtfqilT8rHIRu7FG+tyrTmL9zuRnK1RsKUAu0j
	 FZmJXI792zVxWuSJYt9gsS/1RWdz+atq10GLaJflOrMk+jaRNuxPtbHYA31Z+S41lc
	 FPejUJqBw6qMg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next] net/mlx5: fs, fix RDMA TRANSPORT init cleanup flow
Date: Wed,  2 Jul 2025 13:24:04 +0300
Message-ID: <78cf89b5d8452caf1e979350b30ada6904362f66.1751451780.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Failing during the initialization of root_namespace didn't cleanup
the priorities of the namespace on which the failure occurred.

Properly cleanup said priorities on failure.

Fixes: e6746b0c7423 ("net/mlx5: fs, add multiple prios to RDMA TRANSPORT steering domain")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 7f5608081ea0..424a6d168c53 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3247,6 +3247,7 @@ init_rdma_transport_rx_root_ns_one(struct mlx5_flow_steering *steering,
 {
 	struct mlx5_flow_root_namespace *root_ns;
 	struct fs_prio *prio;
+	int ret;
 	int i;
 
 	steering->rdma_transport_rx_root_ns[vport_idx] =
@@ -3258,11 +3259,17 @@ init_rdma_transport_rx_root_ns_one(struct mlx5_flow_steering *steering,
 
 	for (i = 0; i < MLX5_RDMA_TRANSPORT_BYPASS_PRIO; i++) {
 		prio = fs_create_prio(&root_ns->ns, i, 1);
-		if (IS_ERR(prio))
-			return PTR_ERR(prio);
+		if (IS_ERR(prio)) {
+			ret = PTR_ERR(prio);
+			goto err;
+		}
 	}
 	set_prio_attrs(root_ns);
 	return 0;
+
+err:
+	cleanup_root_ns(root_ns);
+	return ret;
 }
 
 static int
@@ -3271,6 +3278,7 @@ init_rdma_transport_tx_root_ns_one(struct mlx5_flow_steering *steering,
 {
 	struct mlx5_flow_root_namespace *root_ns;
 	struct fs_prio *prio;
+	int ret;
 	int i;
 
 	steering->rdma_transport_tx_root_ns[vport_idx] =
@@ -3282,11 +3290,17 @@ init_rdma_transport_tx_root_ns_one(struct mlx5_flow_steering *steering,
 
 	for (i = 0; i < MLX5_RDMA_TRANSPORT_BYPASS_PRIO; i++) {
 		prio = fs_create_prio(&root_ns->ns, i, 1);
-		if (IS_ERR(prio))
-			return PTR_ERR(prio);
+		if (IS_ERR(prio)) {
+			ret = PTR_ERR(prio);
+			goto err;
+		}
 	}
 	set_prio_attrs(root_ns);
 	return 0;
+
+err:
+	cleanup_root_ns(root_ns);
+	return ret;
 }
 
 static int init_rdma_transport_rx_root_ns(struct mlx5_flow_steering *steering)
-- 
2.50.0


