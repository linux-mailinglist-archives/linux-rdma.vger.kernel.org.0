Return-Path: <linux-rdma+bounces-17698-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ7pHoQerWnoyQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17698-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 08:00:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 231EF22ED82
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 08:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 595A6305DBA0
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 06:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF973314D9;
	Sun,  8 Mar 2026 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PI0S+kmw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E301321445;
	Sun,  8 Mar 2026 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772953029; cv=fail; b=KV5cbrEOkF3mRAweyelwdcZj8hbbLbcqT0R4Gn4ROfCKs7JVPmIJFl3YJoCTm0NeGbVbm+n2PzjYoF+UbGRz6rhi1gDAKwPyRhfDnftIBEQIOZ9V7Rrt+UtX9XSlUzbx8E/9TXFtjbuJWWZmWhOU0M35JGAAKX1WK2S186YUsXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772953029; c=relaxed/simple;
	bh=3lVyrFxKsm+hxTAua2yz50dK5RAFGvdof0tFA/bcang=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hP3ewwjkHjCXIQtSCQ39MkvWmx4pH5uc5bE8dSE5wpXcJ7NAPn8OYAdtx8+9NkXjNDt3kugM7QgwwZHELpR91PVmGCADf+fCDuNa4V7ndV9O8aORcCYj+rUd2Ov4ru6yl4tqzRc/jianJw/UYCFAVreAjoX/G5vDemYl9A6kenY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PI0S+kmw; arc=fail smtp.client-ip=52.101.61.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwBEcCZHBu72hyM2DgdTw2K0sHAGCwqj0pxelL0hlp8gWZp6q7vowXepc/o/umCXAbvHzqH45Eqt0uluwuDO04EuTZOVHII10/wz7YUVN/omdpikyvpuiPpuV9jThH8rIUhuPcwp5iu1ty6NipxCGCrra0zBgqkvD2IrzRkvBQeh+uVOaLQg9sjM7RCxe8+pfdLIY+E05d8i6+y8gF4/9usRmedHS7213hA9YbfX5kyCSukIPUO68ArVeCHp1WRE77DAh5odTzTWw1mEcQfT6Wk24tX0LCmJtrdeW/FTXijLWZiATfmRoZPI63E0fcdLlawWa3VLlR+NrKUO9ZxUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26udrvnR/u7mtxYmbvOFMlxEe2+M1aoM4GKQtMry0TU=;
 b=xKJT+ZHSXNs/IUr2lGsiTcKzcyXsE/KxNHXmJithzVEW4LNS5sBib/LzREGk5MpIfBkHLEvGB3V7+Rdc+siqWV4wfnU8AZIQ4BYVDtRizJ5VEj8WoHTa3eIeoeqo/1lltDL1/CqbNaT3A3WM+9jlsMjwYR9Z7pbAJxAq5DY6wbHh82eeJ1ByNPDD8rNnRus3zLoDqUfsnliFj/Q46QFUqI+Q7GA9VoyG8OCqmiyjm1KS8bxrOp+o1e2khmoK/XoqzdQ9fhYQ/gXeb4TuUJmzNE6nzEbye+ZRE+wTgXdpG/Et3Rnj9Oj687f1VXEjKA/6oDHELhG9y3hrF5wySdKpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26udrvnR/u7mtxYmbvOFMlxEe2+M1aoM4GKQtMry0TU=;
 b=PI0S+kmwo/yVSVSzpvGhTIopXvd0mRx1c8lVpQklLyYfh9r6OXN6KAuQh33vq/t/nXliTjoKMM/2/ommjjmmXxgfwkIlLib0WNXWxHANNicnH1eSfN4edo4ZRHvQ9mOVeXpSBTd7egR3yRlbwH+xE/NvyS7BvjvoJxj4d+KkN23lur6kFs+6UlbM6ybybyOO11Tv1LgO1CC2fYF7Ul7cdTw8S7iFf4KKREeMEsQyLgy8z4L09I/dFZeOsf2pl55xRVLHyDrKjYOIcOkAFduVpbSkirP11TftB9RfBTWhDLBusHgdd4WtplD06fX/RfzygGrOgInnwyX8rlsqnaC7JQ==
Received: from BY5PR20CA0015.namprd20.prod.outlook.com (2603:10b6:a03:1f4::28)
 by SA1PR12MB8887.namprd12.prod.outlook.com (2603:10b6:806:386::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.7; Sun, 8 Mar
 2026 06:57:02 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::54) by BY5PR20CA0015.outlook.office365.com
 (2603:10b6:a03:1f4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.22 via Frontend Transport; Sun,
 8 Mar 2026 06:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sun, 8 Mar 2026 06:57:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 7 Mar
 2026 22:56:52 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 7 Mar 2026 22:56:51 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 7 Mar 2026 22:56:48 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: [PATCH mlx5-next 6/8] net/mlx5: LAG, replace mlx5_get_dev_index with LAG sequence number
Date: Sun, 8 Mar 2026 08:55:57 +0200
Message-ID: <20260308065559.1837449-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260308065559.1837449-1-tariqt@nvidia.com>
References: <20260308065559.1837449-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|SA1PR12MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: f59f994d-c032-457e-c8d5-08de7cdfe697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	5JXGhwuwj9ZxUy/SlAC4etRgowUEJNIH1j47F1rRben8ljxnGLGahwaKzc4xF+BdqIiAqk6CSXMQQ62BiR5mTnY9wHpkcb0mMZ13GoJjhQfteNv3RJVDYASkSJRzB2cm+mFYPDhiDlWdwYalauOj0OIwArbkDyDaKfy6XQtHPXZFE1Bt8P9dZcffP7x/SB+gG/ARHpjUU9GJlRQygYATDuvEbt6+ZmTvc4GQC6zMc9kI6fE0cXHfvKdigBdOAkQu+37qdr8fqM+acVMVn1YjJTgm9+/qPTwsTElSWHQRz0ZzXbx46gKWnWjd1rtJT24PJGoxQ1ratw8d2aWfDn2X87ENiITcV45VQBUWUx0cOmunrdlY6SLCEpe2r7XNd6tJA2Llle2mz6azXOfuny+H27G3aeU2zYD2bpJ/4Vabo032xeSFzHLR9yMgeXM2wuUP+U8BJ2ZvMYAF0mJRzTOQ81udc3W4YCIbs9dpCW1d0nZHn2JssPCiBWXVNc9opCyRxRJ7sy9OB8A7KHHJoEA8Cio9u7oQMul1KiTbn/jdfmhPOiuuKD+gf8qNmcOL1Q2oXZqqDNGmRTE0yrk1zjQDbntQqQbk7SZSYMIkK1pqFypPb9d4mQza/m/2UWK8dagwEnAADiEdvCbQatKixnogHqWQvxGCmmK68EGT2aNnhUkK1cWS47WjcTfojB1czQOUNSKsMLfkq2PXSnSPtkqj0yy3voPbgDiiGlFVD4+unud0qLTqJh5yJqPtP5UUCwy/MjHjLdIswBnJ0PQbTBMMHQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3JUv3di0mPGhMl6x7Naz5jRsX6675Nc21fVnZy6EE2TtW/+9iaJiP3meRgrRPOw7zkLQC2cUBF6nfRL199ZTy+/UK3ql+PC/GYFVnySc7eCcjSCzjpiq1rwth/7qbi5xqZTnan1GAvX+COu5KMG0NdU2Tyx6KuvhKQHGnVHmOOcHaFs5iJBaudlObM8LdNm5ZmoR/zKOyJjuoA9K4kdx7hyUXEOdHhbPwv82Il2lx7xvezEPhlgGFEhZPKxKC/lVYG3J7pDb5o/fKv883or1bb/qCl1kA9NEXXaKQcXyLtrtVOK49YHoUt54djb20/W2Vx+FMHzDEcan1K+Ht/RLhnAxmqSOJak/2gq/ScAKw4f48xmMQ9KvUAKa3w4kcmiVPH1IdkMhhqokPlItOcoUg7Tu0dt/C8OB6zlfz5DIb5vWUCqBqRn25lrBAPN3KWfx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 06:57:02.1191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f59f994d-c032-457e-c8d5-08de7cdfe697
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8887
X-Rspamd-Queue-Id: 231EF22ED82
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17698-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

Introduce mlx5_lag_get_dev_seq() which returns a device's sequence
number within the LAG: master is always 0, remaining devices numbered
sequentially. This provides a stable index for peer flow tracking and
vport ordering without depending on native_port_num.

Replace mlx5_get_dev_index() usage in en_tc.c (peer flow array
indexing) and ib_rep.c (vport index ordering) with the new API.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/infiniband/hw/mlx5/ib_rep.c           |  4 ++-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  9 ++---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 34 +++++++++++++++++++
 include/linux/mlx5/lag.h                      | 11 ++++++
 4 files changed, 53 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/mlx5/lag.h

diff --git a/drivers/infiniband/hw/mlx5/ib_rep.c b/drivers/infiniband/hw/mlx5/ib_rep.c
index 621834d75205..df8f049c5806 100644
--- a/drivers/infiniband/hw/mlx5/ib_rep.c
+++ b/drivers/infiniband/hw/mlx5/ib_rep.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2018 Mellanox Technologies. All rights reserved.
  */
 
+#include <linux/mlx5/lag.h>
 #include <linux/mlx5/vport.h>
 #include "ib_rep.h"
 #include "srq.h"
@@ -134,7 +135,8 @@ mlx5_ib_vport_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 				/* Only 1 ib port is the representor for all uplinks */
 					peer_n_ports--;
 
-				if (mlx5_get_dev_index(peer_dev) < mlx5_get_dev_index(dev))
+				if (mlx5_lag_get_dev_seq(peer_dev) <
+				    mlx5_lag_get_dev_seq(dev))
 					vport_index += peer_n_ports;
 			}
 		}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 1434b65d4746..397a93584fd6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -35,6 +35,7 @@
 #include <net/sch_generic.h>
 #include <net/pkt_cls.h>
 #include <linux/mlx5/fs.h>
+#include <linux/mlx5/lag.h>
 #include <linux/mlx5/device.h>
 #include <linux/rhashtable.h>
 #include <linux/refcount.h>
@@ -2131,7 +2132,7 @@ static void mlx5e_tc_del_fdb_peer_flow(struct mlx5e_tc_flow *flow,
 	mutex_unlock(&esw->offloads.peer_mutex);
 
 	list_for_each_entry_safe(peer_flow, tmp, &flow->peer_flows, peer_flows) {
-		if (peer_index != mlx5_get_dev_index(peer_flow->priv->mdev))
+		if (peer_index != mlx5_lag_get_dev_seq(peer_flow->priv->mdev))
 			continue;
 
 		list_del(&peer_flow->peer_flows);
@@ -2154,7 +2155,7 @@ static void mlx5e_tc_del_fdb_peers_flow(struct mlx5e_tc_flow *flow)
 
 	devcom = flow->priv->mdev->priv.eswitch->devcom;
 	mlx5_devcom_for_each_peer_entry(devcom, peer_esw, pos) {
-		i = mlx5_get_dev_index(peer_esw->dev);
+		i = mlx5_lag_get_dev_seq(peer_esw->dev);
 		mlx5e_tc_del_fdb_peer_flow(flow, i);
 	}
 }
@@ -4584,7 +4585,7 @@ static int mlx5e_tc_add_fdb_peer_flow(struct flow_cls_offload *f,
 	struct mlx5_eswitch *esw = priv->mdev->priv.eswitch;
 	struct mlx5_esw_flow_attr *attr = flow->attr->esw_attr;
 	struct mlx5e_tc_flow_parse_attr *parse_attr;
-	int i = mlx5_get_dev_index(peer_esw->dev);
+	int i = mlx5_lag_get_dev_seq(peer_esw->dev);
 	struct mlx5e_rep_priv *peer_urpriv;
 	struct mlx5e_tc_flow *peer_flow;
 	struct mlx5_core_dev *in_mdev;
@@ -5525,7 +5526,7 @@ void mlx5e_tc_clean_fdb_peer_flows(struct mlx5_eswitch *esw)
 	devcom = esw->devcom;
 
 	mlx5_devcom_for_each_peer_entry(devcom, peer_esw, pos) {
-		i = mlx5_get_dev_index(peer_esw->dev);
+		i = mlx5_lag_get_dev_seq(peer_esw->dev);
 		list_for_each_entry_safe(flow, tmp, &esw->offloads.peer_flows[i], peer[i])
 			mlx5e_tc_del_fdb_peers_flow(flow);
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 4beee64c937a..51ec8f61ecbb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -35,6 +35,7 @@
 #include <linux/mlx5/driver.h>
 #include <linux/mlx5/eswitch.h>
 #include <linux/mlx5/vport.h>
+#include <linux/mlx5/lag.h>
 #include "lib/mlx5.h"
 #include "lib/devcom.h"
 #include "mlx5_core.h"
@@ -369,6 +370,39 @@ int mlx5_lag_get_dev_index_by_seq(struct mlx5_lag *ldev, int seq)
 	return -ENOENT;
 }
 
+/* Reverse of mlx5_lag_get_dev_index_by_seq: given a device, return its
+ * sequence number in the LAG. Master is always 0, others numbered
+ * sequentially starting from 1.
+ */
+int mlx5_lag_get_dev_seq(struct mlx5_core_dev *dev)
+{
+	struct mlx5_lag *ldev = mlx5_lag_dev(dev);
+	int master_idx, i, num = 1;
+	struct lag_func *pf;
+
+	if (!ldev)
+		return -ENOENT;
+
+	master_idx = mlx5_lag_get_master_idx(ldev);
+	if (master_idx < 0)
+		return -ENOENT;
+
+	pf = mlx5_lag_pf(ldev, master_idx);
+	if (pf && pf->dev == dev)
+		return 0;
+
+	mlx5_ldev_for_each(i, 0, ldev) {
+		if (i == master_idx)
+			continue;
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->dev == dev)
+			return num;
+		num++;
+	}
+	return -ENOENT;
+}
+EXPORT_SYMBOL(mlx5_lag_get_dev_seq);
+
 /* Devcom events for LAG master marking */
 #define LAG_DEVCOM_PAIR		(0)
 #define LAG_DEVCOM_UNPAIR	(1)
diff --git a/include/linux/mlx5/lag.h b/include/linux/mlx5/lag.h
new file mode 100644
index 000000000000..d370dfd19055
--- /dev/null
+++ b/include/linux/mlx5/lag.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_LAG_API_H__
+#define __MLX5_LAG_API_H__
+
+struct mlx5_core_dev;
+
+int mlx5_lag_get_dev_seq(struct mlx5_core_dev *dev);
+
+#endif /* __MLX5_LAG_API_H__ */
-- 
2.44.0


