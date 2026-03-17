Return-Path: <linux-rdma+bounces-18243-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPy+Bx4xuWn4uAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18243-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 11:46:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE0B2A832E
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 11:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 239F0304876A
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 10:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F541368941;
	Tue, 17 Mar 2026 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AwtGNb2i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012029.outbound.protection.outlook.com [40.93.195.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255B35E94E;
	Tue, 17 Mar 2026 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744389; cv=fail; b=kAR/4uFZytQzZco2315Zad5///77tZCF9tKgX8d32K9sGSip/r1IlcObf9AE96X5xsyTZnLA50cXEMm06kjLJwKApo8gO1tuphJNfUSUd+Eurwp4Mdq0mBRUUURgRjy8lciXe4E7aFvp4dIZ2+ca6x8HSPGkG2nwZinRIzh/g+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744389; c=relaxed/simple;
	bh=d0cwHeODRh9tyXiGUrMX1/OI34Uu5YY0N+8lRyNHD+Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n+Lvj0cXNILR4FSz40mjQ8Fmik7/b6XetoJ7xGoDvGpJXNAq1qhywQndWR8iGtaE3eHXq6FBOfBjqZAWvx999Tu0TgQogcxUm3zU6bwuL0dAvorOpgosWl8rlTLuvjXAmyfDqorR/eDizS+wvvkv/qCQeFhVUZ+o4jIRmBAU2e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AwtGNb2i; arc=fail smtp.client-ip=40.93.195.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwPJlj64lcwIhUNuPJv/EQSClqY6ndj0Zmc9+k1SOImovjkcL53lrm7vruvs44euxUDruMBlXth7R91Dty0SIdG5737LnsUAQuen+oT/f/vVIwgyOXpVyHOeGVFsDp9mf4CvL+8uTNU8qHuem08PS8hRmof2GXMXw4zNTetPSF6RuUpa5exTlfztXChzYH9UJ1qFwhl+vKiVHMbM9G0Ru4+yAbmWCK2tANImKy9CZxC29dKH5emDy86EFlWNTDvO6f7umkwamwrr7uDqU7z0A+qTRu8M/vXmsMwQI+DPQ89tPfrWQhJ1yI87DLg25Ji9eAh9gDA/eqhkxkc35+P8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnHvphLfDNDJ6LZ2CeU5n9XE8kOGrmfcwjbaa0uXmtA=;
 b=hHN4acxYXB6D2QQijT+ZXg3V0BwFQPpP2di7LevX5q6KpKje5wl4Zgf5aBue968W2ET6a1jOAjWsL0HLj2VlC8XI7RyBV36DIb7+4Xc3f/8aIiASU3GuPv/INso543g3u6y1J6ap+1GPLiLieFZZtXdtNSzqlWX/BYFao7vB6Hvz8bnSQa2fIV1QnOMlhTp6Y1q9sRMwxmRsT/qZYnBWjy8YMF7kv7cCApZDnkRJVJ5/xdZEbd8zspnPU6Z+cp8hkK93OmTrisKGosRxOlngbjIM7QCQwF/ll5dc29YRSRPPk/ZkZhWMyq35AcbqtfqjL5HK96ZcRh+9YYcVOLJzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnHvphLfDNDJ6LZ2CeU5n9XE8kOGrmfcwjbaa0uXmtA=;
 b=AwtGNb2iPlmOFFXVFIg/tTaBI58M0JZsA000M2F3UaWQJIpVtgHrq8Or9/JOPTZXAXB0tfFqPNbj/cszJPmkjpOnZygtXuzgN1tAsrgsRKRUQirF19FfkIPAiH/dpR5/O8ESCaioBp7QhnISXTSxOaxLAwWsvXMCHUt46KWOPuvg5ag4K4Q9kOfqWNiRN5dioOt0DtGGB4i/DsXMQDAbJLs7efMoJO/9bg8Cxm9lcVO7fHZWTzJoWPMHrxKiaK/quzTNrnuPiDsucYso1nYYlvsL87bojCtPKL+m91iFLn/drdKUlXRdk/I7NNJvLdm12Dw3Zk24Kynlh6lAm2g4Gg==
Received: from SN6PR01CA0005.prod.exchangelabs.com (2603:10b6:805:b6::18) by
 BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 10:46:21 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:805:b6:cafe::8b) by SN6PR01CA0005.outlook.office365.com
 (2603:10b6:805:b6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 10:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 10:46:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 03:46:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 17 Mar 2026 03:46:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 03:46:11 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net-next] net/mlx5e: Remove unused field in mlx5e_flow_steering struct
Date: Tue, 17 Mar 2026 12:45:48 +0200
Message-ID: <20260317104548.15697-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|BL1PR12MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc00538-1133-41ea-1c14-08de84126d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	kbrZFFKuA7s/EbtFVxtaWiFt11dfCcNJcECTPsHoyCUJ4yDu2UmdRLO51Bvw2JKAW1MJpj3GexUmDYk9olvnMJpsq1vXocmbazw1K8R/Vs6TAEAqJChlP18wQsyAEGrnqOSeZomuJRz6aIuh1oBux5JRY8jlDEIlucgpWHQvep/GhfPfnzhlgBM/MBdBMJDuWfzyzfE+nTnF/XthTkNSqOftoKnd/6mv8IIVk4/E+Qkl29YbeK1YJ98bWS3c8kRr6qkxu8qAVv+3/uEQkYdlmHC4fSVa84ezeSoYhAU7tKDnkLOzkl+fzvix3FrutXh2tS7Myks6o+0BeiAAsm/WbiWVvVUIodfNPtFJREPcYr7Q3YPVWXseNnePUoLb4OUEla4qfO3X9sK76kZ9Dqii3XA1SOYUuisxkVrhaHckNI78LHqFxgt8cS0+2zLeRMgO/XFFxPz5Z5a6H5vpDDfKyDcJ0J7r9VEQ22IzgLa0CNooVeeHhCubSmvLSE3EkpeK+wt5G8WH/7GYrk+5R3gArPVOzDLfffen6wHhQJ4jDI2avHG9gbUa1Ite/MYLwjBrPmyh14qMCtE/ua/EFErFbLhVR+XMSbf4dCMjYe1ENzQ049KZ3YYiNgJdpu0fQ2hNtRDhXUBJ6L+eA1BCXcecBI3fcP5lG+lP4fmz9TvUjGa8k8PIA1GmKzzzTqBTMTAbkIkWT17ASvdkqPQR+LG/dL6Jjs5kVcdJr8DzdpEKxIZRKMVDvKuQjjmrYbS3p5kUzk4Cma2dYSK94Eo3+3fKuQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zGyRXG6eYiG2wMV0GJyttiQ/wAqwnNTNolq8Q3RWjc8sHEqInAEb/UQpL7HGpJHQ9Xz2b/HxDnTfGgbBzDfPhPHMSPj+qw003QU6Em8jSlWl/eVj7dHPSvIL1iEaQWPQjf8x7LyFqB3Qb//FHrByUjv/PNbJVY4gPzqJKpPzQO45SSvq6cA3LQ14lC0mSlNWQ9QtSXqapODcCQj7KIpdSrq51FH8GEmFiTKu7Bx9MpdLurQmevyZ2Iz18349gqG8/wOkYtmJK+Q4AFJPmEnQE8TTRztS1BGTD6h9Xq+rWWnKPrU9CR54WDM5EFNBEEwide+lZT+RANcQdDg/Y15eXCZuLYGI0zgMOIAUBYrLUb17AqF2MlU6mpshzfBQd/Jsx7UOBP6PfIA/jBjonhzktQdnIX+tu4N3yRVYsxulxuD50XGzNlp5AV04Z/toNzJE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 10:46:21.3094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc00538-1133-41ea-1c14-08de84126d7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5827
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18243-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6FE0B2A832E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Saeed Mahameed <saeedm@nvidia.com>

Not used in mlx5e, clean it up.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 9352e2183312..55255fe6e415 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -47,7 +47,6 @@ struct mlx5e_flow_steering {
 	bool				state_destroy;
 	bool				vlan_strip_disable;
 	struct mlx5_core_dev		*mdev;
-	struct net_device		*netdev;
 	struct mlx5_flow_namespace      *ns;
 	struct mlx5_flow_namespace      *egress_ns;
 #ifdef CONFIG_MLX5_EN_RXNFC

base-commit: 348baefbb635cbb448e154f38c93657d4cf23936
-- 
2.44.0


