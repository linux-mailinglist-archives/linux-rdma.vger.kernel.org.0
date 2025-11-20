Return-Path: <linux-rdma+bounces-14647-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9654FC74207
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A94582ACB9
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 13:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFEB33DEE9;
	Thu, 20 Nov 2025 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ecuQqadF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DCD33B6EF;
	Thu, 20 Nov 2025 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644479; cv=fail; b=Y7W1MfItMzKOO/umgXZc3CXeRjbvl7XMVTqasL4iZ2sV268cQHpBfETU39mC+IcFiSRX+gZy1Wbmb3sGJNNYCKjK6fqvtkaaEr8M2B0Uouj8TAgtDGdsv7/u32wf+2Fa170p+XubsuW7xz8FLJ81l0G4ahWiTsku7Wd7AW2sGco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644479; c=relaxed/simple;
	bh=WXI4mPHSLY+tAy1zXP51/Q7vhoBiJyspgV9I95XoDtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSz9PdjIDmnyzLYYPFrL/jdMOsBk3CA517+gRxA9IKMDSf/c/OmPI7kYFcHWLwEn++M1n8VVAhstzF5qBnOGlErd84I9lJnlDtjOcExkuZTZLmrPpLAMhPPrutLYStkUX3B20z96DHn4qPoluxp084mcufgImnrWYiJpDuM/LJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ecuQqadF; arc=fail smtp.client-ip=40.107.200.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0ngFEkjLEsLSQAtBCcQeQXM7T7K8b37q0jLP9G2ifqD5XzUGOK4Cl90iNyhFuiIDmEIkF3K8oHBQ5rTYEnjDCASP/C4TZFrGj2woN0vFOgGd+EGF1z5HTarjGVB+jBzsGeQAu5Ib7WgSRPqoI1MxceUSFA029AWf/DBFNbxor7Wi8xG7P6gkbwzVYX+MHq9Qw+qv+ED3mtjqmsEDo8WEjLva2mAk1n4z+b9uc5vl00jsFzlGfZvxhnV1umRe90tIUGYYwGBhCp4beUueenzehBwWhtnhsqoQkJAouM5ID/MokNuaumrVT9jZ300sUHlBfRmoGQcLHPb/3LeLJd7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzoiUfphuvJ+T4Osz72JuZLn5FICLxZtgg522pJbcV8=;
 b=w7P5Qd0rCEp42FRvKH18mO6SNeucI0UhiKwO/vJ42ikK6ZSR1WsM9eOjiqwhjAtF4BynlERyUaUGPCXOVHTX8HJYP0/sTSUjX6/PxBP7ZBaLk6aZRQ6Q71VpmXrLI8zlKsM3SNmLPKj9EZKhgzmkaP/A7GhaHL12BnDkJqyu5HK3bi+Me22B+GDrhDzAG8GZbMN+cm0P5duEWzkOXbEW2s5odf3rRw9PIpUP2oY/VpUvpnQWmQZ/kfq0MxR5118YOx+3EBuccsfJnh5FaABv+pfguftHKI+29DpYi+ZnM0CUwf0Tj9pn/93XHPy9wEh1mFq/4UKOZ35+6qLq0l86fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzoiUfphuvJ+T4Osz72JuZLn5FICLxZtgg522pJbcV8=;
 b=ecuQqadFE00e4aem8ry6zIl1KgOzJFfbfxT1mH1sKLZlWt/gwqdtLYJrWNPKTkI9fL7lEqQVzhjC0P7d/pr2bI2sec4i4rsZCKyu5AkRVgp9ep6gJf4nKHZl9tUFyePYLGaGAx9LK6GNRVBM5BvnKymwSZfHaFB+tDwO+M5McX3Wvi8KTyAg31iWRmlSwRV6nrNhROKbtMBoIdrQv0UN2+xLX4wjExofC8VTBN7au1z4AAGhspf0GVUM2BK4zuKsLXUcBSQtImJ3SnrJZ0wmI/FqUz8ECCWN8fOp/ps3LLx0RbuSizDdi8n5fH1Wc22hZaHYnoTtRl5wk+sCfnZSeQ==
Received: from BN0PR04CA0046.namprd04.prod.outlook.com (2603:10b6:408:e8::21)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 13:14:29 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::fd) by BN0PR04CA0046.outlook.office365.com
 (2603:10b6:408:e8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:14:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:14:14 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:14:13 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 20
 Nov 2025 05:14:07 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 10/14] net/mlx5: Expose a function to clear a vport's parent
Date: Thu, 20 Nov 2025 15:09:22 +0200
Message-ID: <1763644166-1250608-11-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
References: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: daea37b1-0d5f-4191-f750-08de2836bcb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HQhr1agNWxW1e8dmI8DKr6JzHpBz4cPQDVfMpTOFhXtndgp7aOOLaJiAppuK?=
 =?us-ascii?Q?IqaGHKbL5ki8WZfyguszrbf8njuXUM/SYC5VuZ4YIPmiYz8Fk56OhfEpbPKA?=
 =?us-ascii?Q?znGKVF/nGNwIbh0+R1kmrQti00tkdWMQY7UzOYX70A3lKbkgcRTbuu0XLmHl?=
 =?us-ascii?Q?ncU6PbK5XDCD3sqayWx5Aeb/zWDzTkfO/3R6p1XwfTeYBb4rHD4Op2OKQmX3?=
 =?us-ascii?Q?3scb3pRSjdr7WlHciwYMSNRyUUEeKEI5uQYilVXC0M9rh8PfQJgXdEP4dciN?=
 =?us-ascii?Q?VdvhuVB0bCqeabkIX52Wm0C9aNhCB875irgNdaOJhc28CBGlIQsCXDcvmJIx?=
 =?us-ascii?Q?rxfCC6Q3wvrafX14Nn0WShXdWgtavfNC1Q8Rp+JI/dj6K2pffAKVjFLIsw53?=
 =?us-ascii?Q?Qeg4irAo07iKK4f7y6iCN0zL2ORVk4GB72rv4ZwiZEcXUnHdQconbz28bQOG?=
 =?us-ascii?Q?wqe9EU1/AQtVrQ8Ht8O4n6AHzvh4mu4EV4t9MkqqJ+JWhviU40RSctPS1eAa?=
 =?us-ascii?Q?k3GvQn/a0sXc92qBE1SwMI/lULgXGzko1suyQ/dtguTKiUQOg7uj+RZBZtIU?=
 =?us-ascii?Q?rios+rjW3Vg4qEs+GXJGxdo+MdpC1CFr5gZo57GH9LuQozsxnRsy6Su35X+x?=
 =?us-ascii?Q?vgmEvHsiYvCB9093KwqOAA+YJlcY7O9O6DUJrQ3CPSzxyUAHti76yE+Vso9P?=
 =?us-ascii?Q?YqoaPBa4thzSWg/CMY4qAKx26Smu7mkSlyE8/SXx+2WLMsdk6fs2uEVAWh6M?=
 =?us-ascii?Q?NOqrSaQdQy8ehs7MLSG1umu5CFuiWkHMdfZ6mp+XG8+O6LhiBBfHcDux2puE?=
 =?us-ascii?Q?32hzHa2j6w24CYVjOommAkEws9yicJ7g60bEtFZ90uTdawdPPxNdlupGInCn?=
 =?us-ascii?Q?mJoTR0jYYpD6p4NHdSa/+/zilI9t4Rv00/jvQFABt/GkZbmdfCMHNX9+weKb?=
 =?us-ascii?Q?dHPJaNk7VJXo4tJbupaRXTQpFUsVkKw8NcvB2j5RX7y4w7oERp8EzPS5shni?=
 =?us-ascii?Q?4JpnR7Zck9OEEKtJyHZdWuq7EGZPv1epGM4Z9t1IkNcc0gkodiyo2xfy6gYJ?=
 =?us-ascii?Q?Wxv9qWuEv9T+/mo6/pghq8Rr5I4UoSuNbFeRSoFkKU1W8EEGV5G7BHrpPGbN?=
 =?us-ascii?Q?EphYNOFA4I0sXXRWokLGIVlU0bXP8MX3d6gJKlHmbNILVm47Y+ICeo+LbFgM?=
 =?us-ascii?Q?c0ZQUnSA4ZUKLXd3ElJu680aHUromL8OsWcTDd6YsmoQIDU4fyW2ntmLV836?=
 =?us-ascii?Q?l78kjS2u5URi7CFo43IEHP5TNcuF9BpTNeg4GKsXAMzxi2aXqNdj60WYaend?=
 =?us-ascii?Q?o/EJWrp0BsPHaZhaSSfmqtBld5nDQ4HAjpo6T5fpdypFAgvumEd9FRs51S9m?=
 =?us-ascii?Q?df8ClC7BYjlTAyXhg33Ww/owuK0PFeTnqCj0UvXyeTNFkRsWGGmw5pjzK12p?=
 =?us-ascii?Q?3nwx4+AMZYLtEahY2lA7AGx1gbizL9RDVr2udIeSjxaDUZcmf/IcLzBMV8nk?=
 =?us-ascii?Q?SWCzgbadz3PGijJZgbC4nxHvofexbGOx4+dAdQxcnY8ADFZG294DhPsK7iDP?=
 =?us-ascii?Q?CUph/ThL2bAyeni4vU8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:14:29.0365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daea37b1-0d5f-4191-f750-08de2836bcb1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488

From: Cosmin Ratiu <cratiu@nvidia.com>

Currently, clearing a vport's parent happens with a call that looks like
this:
	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);

Change that to something nicer that looks like this:
	mlx5_esw_qos_vport_clear_parent(vport);

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c     | 11 +++++++++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h     |  3 +--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 89a58dee50b3..31704ea9cdb4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -202,7 +202,7 @@ void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_vport *vport)
 		return;
 	dl_port = vport->dl_port;
 
-	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
+	mlx5_esw_qos_vport_clear_parent(vport);
 	devl_rate_leaf_destroy(&dl_port->dl_port);
 
 	devl_port_unregister(&dl_port->dl_port);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 4278bcb04c72..8c3a026b8db4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1896,8 +1896,10 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	return 0;
 }
 
-int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
-				     struct netlink_ext_ack *extack)
+static int
+mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
+				 struct mlx5_esw_sched_node *parent,
+				 struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err = 0;
@@ -1922,6 +1924,11 @@ int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_s
 	return err;
 }
 
+void mlx5_esw_qos_vport_clear_parent(struct mlx5_vport *vport)
+{
+	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
+}
+
 int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
 					  struct devlink_rate *parent,
 					  void *priv, void *parent_priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index ad1073f7b79f..20cf9dd542a1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -452,8 +452,7 @@ int mlx5_eswitch_set_vport_trust(struct mlx5_eswitch *esw,
 				 u16 vport_num, bool setting);
 int mlx5_eswitch_set_vport_rate(struct mlx5_eswitch *esw, u16 vport,
 				u32 max_rate, u32 min_rate);
-int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *node,
-				     struct netlink_ext_ack *extack);
+void mlx5_esw_qos_vport_clear_parent(struct mlx5_vport *vport);
 int mlx5_eswitch_set_vepa(struct mlx5_eswitch *esw, u8 setting);
 int mlx5_eswitch_get_vepa(struct mlx5_eswitch *esw, u8 *setting);
 int mlx5_eswitch_get_vport_config(struct mlx5_eswitch *esw,
-- 
2.31.1


