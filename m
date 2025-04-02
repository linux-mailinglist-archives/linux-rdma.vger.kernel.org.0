Return-Path: <linux-rdma+bounces-9114-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020B6A78B76
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 11:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D30E3AD1B6
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 09:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB48C2356DC;
	Wed,  2 Apr 2025 09:44:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8031E8837;
	Wed,  2 Apr 2025 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743587040; cv=none; b=BOyTrmTdSmy8UwAY7xFU0CGswg9/TUThM4fFeqClTmKRtv7WEhehRHCvIwavdZ+M0PVjbCO4+ePvJCh2bXXAW+OCTsz40H1+MPdyhHMXMeVuaNSCDK8NXJPNuBIbumlwEtDjk2nnQ4u074o0aaFVDX3FLZ8OtmW4RiD1aEMNnpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743587040; c=relaxed/simple;
	bh=tLnHDvXP/BIczRM9DMQPzPHkFUZUWfwXeFQNa1rWq1M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k579yajYhsWKU+pkdEBbe3NDMA03jm2EqtOvexUdeqF0OlAhr2I6L+b/ht8KmUUnR0nlwIXY4I/SN6EL7PkfLRXUw6GnKHWBz40upRlsiMkLcJySaikD+iK7FnBEOAdslvq7FITkXvRJjYxmZIWyrrRroPZg0cPmiub4t9b6Yow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201609.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202504021743468888;
        Wed, 02 Apr 2025 17:43:46 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Apr 2025 17:43:45 +0800
Received: from locahost.localdomain.com (10.94.17.92) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 2 Apr 2025 17:43:44 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <saeedm@nvidia.com>, <leon@kernel.org>, <tariqt@nvidia.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <markzhang@nvidia.com>,
	<mbloch@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] net/mlx5: fix potential null dereference when enable shared FDB
Date: Wed, 2 Apr 2025 17:43:42 +0800
Message-ID: <20250402094342.3559-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025402174346bccee3f803b545c68e0e4ab65b987d72
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
index a6a8eea5980c..dc58e4c2d786 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2667,6 +2667,11 @@ static int esw_set_slave_root_fdb(struct mlx5_core_dev *master,
 	if (master) {
 		ns = mlx5_get_flow_namespace(master,
 					     MLX5_FLOW_NAMESPACE_FDB);
+		if (!ns) {
+			mlx5_core_warn(master, "Failed to get flow namespace\n");
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
+			mlx5_core_warn(slave, "Failed to get flow namespace\n");
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


