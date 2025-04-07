Return-Path: <linux-rdma+bounces-9170-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012C3A7D479
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 08:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0EB216B582
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 06:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E051A08BC;
	Mon,  7 Apr 2025 06:48:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE20618FDAF;
	Mon,  7 Apr 2025 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008498; cv=none; b=n09OCIVWcc2iosqvK4Wbqs0vTQoc961sQIOuOQx22iNeyvPe+7GzHRn7EXSSmtykyhuQqrffbooKJYexwP3hYUTPUOvBoPkdXAQYLfKEFul1oUDkCQwrD8ZGtTShr7T3N7014T6miUCgZFpbhPEwkXjUgGvbQ7w94FeXWL+C6jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008498; c=relaxed/simple;
	bh=kha/C7psTA4PR1BaWZuqN+3qr52MiLnUlLjXeCPDKas=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bT8x8A09GiQCgVPOUxKarXYxAT4b5dXu66J/NdF07SbijoZahLRsxeUPCg492IOyBUhATh0jonYtxSKiPsUTscC/d/4OZoJHNoEkE4k1c3/Gwao9l0xbgjzH7AKRBNHKOcXaqHdRfBWpVqhQwU7RezhqaNBBHeyncrJRerWjk+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201606.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202504071447595486;
        Mon, 07 Apr 2025 14:47:59 +0800
Received: from locahost.localdomain.com (10.94.5.217) by
 jtjnmail201606.home.langchao.com (10.100.2.6) with Microsoft SMTP Server id
 15.1.2507.39; Mon, 7 Apr 2025 14:47:59 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <ttoukan.linux@gmail.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<hanchunchao@inspur.com>, <kuba@kernel.org>, <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<markzhang@nvidia.com>, <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>, <saeedm@nvidia.com>,
	<tariqt@nvidia.com>
Subject: [PATCH V2] net/mlx5: fix potential null dereference when enable shared FDB
Date: Mon, 7 Apr 2025 14:47:56 +0800
Message-ID: <20250407064757.4266-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d78fa6dc-5820-46b6-9b7d-0986f9a70da2@gmail.com>
References: <d78fa6dc-5820-46b6-9b7d-0986f9a70da2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20254071447593c415bb46cf06b7f270ce99be5561875
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

mlx5_get_flow_namespace() may return a NULL pointer, dereferencing it
without NULL check may lead to NULL dereference.
Add a NULL check for ns.

Fixes: db202995f503 ("net/mlx5: E-Switch, add logic to enable shared FDB")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 10 ++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c       |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index a6a8eea5980c..5405134e74b6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2667,6 +2667,11 @@ static int esw_set_slave_root_fdb(struct mlx5_core_dev *master,
 	if (master) {
 		ns = mlx5_get_flow_namespace(master,
 					     MLX5_FLOW_NAMESPACE_FDB);
+		if (!ns) {
+			esw_warn(master, "Failed to get flow namespace\n");
+			return -EOPNOTSUPP;
+		}
+
 		root = find_root(&ns->node);
 		mutex_lock(&root->chain_lock);
 		MLX5_SET(set_flow_table_root_in, in,
@@ -2679,6 +2684,11 @@ static int esw_set_slave_root_fdb(struct mlx5_core_dev *master,
 	} else {
 		ns = mlx5_get_flow_namespace(slave,
 					     MLX5_FLOW_NAMESPACE_FDB);
+		if (!ns) {
+			esw_warn(slave, "Failed to get flow namespace\n");
+			return -EOPNOTSUPP;
+		}
+
 		root = find_root(&ns->node);
 		mutex_lock(&root->chain_lock);
 		MLX5_SET(set_flow_table_root_in, in, table_id,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index a47c29571f64..18e59f6a0f2d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -186,6 +186,11 @@ static int mlx5_cmd_set_slave_root_fdb(struct mlx5_core_dev *master,
 	} else {
 		ns = mlx5_get_flow_namespace(slave,
 					     MLX5_FLOW_NAMESPACE_FDB);
+		if (!ns) {
+			mlx5_core_warn(slave, "Failed to get flow namespace\n");
+			return -EOPNOTSUPP;
+		}
+
 		root = find_root(&ns->node);
 		MLX5_SET(set_flow_table_root_in, in, table_id,
 			 root->root_ft->id);
-- 
2.43.0


