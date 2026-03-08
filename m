Return-Path: <linux-rdma+bounces-17695-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAmQIi8erWnoyQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17695-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 07:58:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E69022ED56
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 07:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 567313049958
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 06:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC99313E2C;
	Sun,  8 Mar 2026 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WBxRxTwa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013054.outbound.protection.outlook.com [40.93.196.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C0313556;
	Sun,  8 Mar 2026 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772953020; cv=fail; b=tyLdV17vaQJDUAE+/9B62Q4Fb48fH8MgEs744gFKNKbGniVqU91NIyomVfI9mWKAH0bKJe9oqSYtiQ3y/xAQD3JW+z+M7q2eeHpDl0XNw8oD2caG1cq+Yl5ewPEYb6qPjdGiKL5Izq/QnvQ8A2jCa999NXpudJxOiupoKcNjI7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772953020; c=relaxed/simple;
	bh=vlfJoTuMrz/wBXQUk/zy51j2Um4MagaKWw+ZjKc4hLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ll3OzwPo8uaJN1/ySyqri9MjwRBRzrZZ4yDvRISgSI+FjPGP+XWwqHfc/CSfYYqs24Y1tE+tjVEH+CYSTAnpenLk1pTf2dG+falSz+J6hwpS1HgipOv5DCVkhk2D3xtWkLsV/Nj7EoDSKkzfv5q+AmgcRhuRwrDzymmc3Qk1Xu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WBxRxTwa; arc=fail smtp.client-ip=40.93.196.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+4vNOxeX4ZNuxyLtBUPUjgPatChKk1bIymJxoE1oQMOv6k9AwFLK82wE0MxxJc3aIkQ0y85+Lc51Gi2aAe4Zqx3fRVhDc7blpPRcX/UkibhIkVZg4oz//V0vsMmOBQVvaAOWqpoBpODMIL/41Bx8xI9bojYYPFeNKn+zzQHLKtsk+w1yoNXCP66nXDevNfNsafQCAtjC0XFjj21qIhR8M1HCrb90xJEjQ1ijEN9+QzCouqiIY88b8Nm6m05xMOFOaJYn/OU5XDsr57hrBzBS5T2gzY4GIIHL/pXRRirkvP8pAzNdzoV4QCQ/XFScNt0N8lM7VX5KHUXOLv/Q7eIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeT8h4IxrcirmcJ6rTVOm7j29W8WtHvw/Ia90iJdNBI=;
 b=pZugbrBFhRZCoAMduVXBxrbj02fw4cdKrEPTwjbGNIPW4piFxIEcxLCLypPGwK0qOl6dbEleIv9aJS00ndaUnAzKn/Rx0oZ9B3nMl270zOVoKhJzMq7Szk2UBags7iRoRC+JcP81unjM8XR6pv4MWKrMp4v6iNUqZk45TKNjuYvqS+TRZeZlGbOUlR+igQ/cWS70XWar1ALvac66Xn9LdDx6UtOMQavAkGe4a+kSRZJn8OpXl6n/XA7mHKTZ5L2N39F9Gayrq5SZKJ2lPTqVZNVszYJOsasMnvbbxrvzmVdT8GeCqyVdPFWMxsx82qOf7wTFd+aLixqANDtgs9VH3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeT8h4IxrcirmcJ6rTVOm7j29W8WtHvw/Ia90iJdNBI=;
 b=WBxRxTwaBd53dsZKi06BaL23PB2hW+yqMJz122rwwohwXw2bbjKkDUp8rcVAdUKrVKbkC6Nyo1gddEkSnp3E+XbnG3I+uuodmnLR4WhBj6VtEw4Dk71kNmVWEaHS3GOwAvzUMdV5KJAmT1updmdVEcyoAA1k3kYMd8whsQuaxcrNVjKl5XO9a6Lo/ilY0uxMBhVbYE6ggyAl4IgmhbI4F8mUMfXlc5f6ijRvewwElVixFA+1FE5HK1QJnVKp8FuePh0xFBMSgg4xLJ1evlDZ6St6vGKbOx1yCAsYZQr+E7PKrU67carKOAd1gQpyGz4UpnOzuW4sA6x6xiSM50WzmA==
Received: from BL1PR13CA0219.namprd13.prod.outlook.com (2603:10b6:208:2bf::14)
 by SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 06:56:54 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2bf:cafe::87) by BL1PR13CA0219.outlook.office365.com
 (2603:10b6:208:2bf::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Sun,
 8 Mar 2026 06:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sun, 8 Mar 2026 06:56:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 7 Mar
 2026 22:56:48 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 7 Mar 2026 22:56:47 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 7 Mar 2026 22:56:43 -0800
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
Subject: [PATCH mlx5-next 5/8] net/mlx5: E-switch, modify peer miss rule index to vhca_id
Date: Sun, 8 Mar 2026 08:55:56 +0200
Message-ID: <20260308065559.1837449-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|SJ2PR12MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 560807e5-d99d-4ff7-5a4b-08de7cdfe19c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	WL9e7ApsKMDte45wxnQo9/zheeu4rr5I/iUrq1Cb4o3OR0WeZeYRDwb05hK1aN56RbsBCqr432M69yFPmFd6TRnV0Z6VZbdWR3Dbsz6JVDdeDftBylMmmnl9eQPy7swsZnBH3Sfp0OppfuIicif5IatgFpsQGmNjMe//GPVMuYXbXmma78cpZiZ0KuQ4+jkaS0kXF+e/tcbQnQKJRV/Vq5a+dqrY4/HWbqh1XcbdRdAyT+CQciz+NNfjxNu/LWFvjukzYlpgJP7MkItp4llJ8+gkAuYRbZZalArZOwGea4cRleNaNruaimxG9kf/h+VHIub69Hzd0v+UxsFUBJ2UOILWXpBim2r+lOjoXYoE6JTQkRWwr0t3apgfqVHSrZra8Bq+7rcaoHY0Ev8U2YgX9+w3/TKVt08gTnHV/BlFcXXufGqsNKvzy6JUVUAZ9g/ee9fSt2AX+dF2NamCK1hwDU2a6x1T73QyQHcto3/W/dcyaype388dUNmCBkEoQ+pxdgRrkdedqfBFrcO05e3pveHKwIJhrJx6urpvkH+GY80zFveCW3AGj85jjMgNI7GyVi900BorCPydrlrm8N5ostSL13kFu2pt7ndgDOj1Iy2ZhtFjPSJDfE6jCGWtXvLByK6or/XR0vWoTPRSNm7EKNBZR8EUvBc8n6gAHdczabnfBbBux66GgQrMR3CmgQvoqW0wnUh7e0OmiC1nPUVece3+cmxGULT96JibbNh68vrHkGqS7AiYYxuzIzU7MG0PiaB+Qdm4E8oCc95xeLSyfg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m9/UEOULpT5JDlK96zYx8F7+pE0kLmxzqChO8sC3AU9htVjCCLfXy7r4tM0M2oVTIHm1XkF11RPpGOcOrwJ7/qDkJqqKkGche4r+PShF+DbTyilqoyOc+GeKlkUIW0cKYofGv9wgCX5OeKgl7c6Z3luLxXyM6MRTXE378fAKFCC36Bm5KEvhE+T8R6JIN3GqBTbxDEVOXcAxs81Y2GYc6UVPVsc3Qzh75Ho8aWIP25y70TB6VujP70QvlOeqy4fczot4vNSIFb9bt0/a+RGwJ/wSSrVWoFscj1xe/BITtVwIw7geNbWPD3dyOl0qDs8I+k7PRPDEN3yFuvb68LfwM9swEp50b6jDZJHm5dcm5DwfKY2EU+8Z7ih7pK7KGcNw0x9vNqut/j/zD9Kui+n6mD0itoWA030GozoAZegYo31pcP/lMDKnC3vpDwKOGayP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 06:56:53.5978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 560807e5-d99d-4ff7-5a4b-08de7cdfe19c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866
X-Rspamd-Queue-Id: 1E69022ED56
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17695-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

Replace the fixed-size array peer_miss_rules[MLX5_MAX_PORTS], indexed
by physical function index, with an xarray indexed by vhca_id.

This decouples peer_miss_rules from mlx5_get_dev_index(), removing the
dependency on a PF-derived index and the arbitrary MLX5_MAX_PORTS bounds
check. Using vhca_id as the key simplifies insertion/removal logic and
scales better across multi-peer topologies.

Initialize and destroy the xarray alongside the existing esw->paired
xarray in mlx5_esw_offloads_devcom_init/cleanup respectively.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  2 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     | 20 +++++++++----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 6841caef02d1..96309a732d50 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -273,7 +273,7 @@ struct mlx5_eswitch_fdb {
 			struct mlx5_flow_group *send_to_vport_grp;
 			struct mlx5_flow_group *send_to_vport_meta_grp;
 			struct mlx5_flow_group *peer_miss_grp;
-			struct mlx5_flow_handle **peer_miss_rules[MLX5_MAX_PORTS];
+			struct xarray peer_miss_rules;
 			struct mlx5_flow_group *miss_grp;
 			struct mlx5_flow_handle **send_to_vport_meta_rules;
 			struct mlx5_flow_handle *miss_rule_uni;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 1366f6e489bd..90e6f97bdf4a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1190,7 +1190,7 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 	struct mlx5_flow_handle *flow;
 	struct mlx5_vport *peer_vport;
 	struct mlx5_flow_spec *spec;
-	int err, pfindex;
+	int err;
 	unsigned long i;
 	void *misc;
 
@@ -1274,14 +1274,10 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 		}
 	}
 
-	pfindex = mlx5_get_dev_index(peer_dev);
-	if (pfindex >= MLX5_MAX_PORTS) {
-		esw_warn(esw->dev, "Peer dev index(%d) is over the max num defined(%d)\n",
-			 pfindex, MLX5_MAX_PORTS);
-		err = -EINVAL;
+	err = xa_insert(&esw->fdb_table.offloads.peer_miss_rules,
+			MLX5_CAP_GEN(peer_dev, vhca_id), flows, GFP_KERNEL);
+	if (err)
 		goto add_ec_vf_flow_err;
-	}
-	esw->fdb_table.offloads.peer_miss_rules[pfindex] = flows;
 
 	kvfree(spec);
 	return 0;
@@ -1323,12 +1319,13 @@ static void esw_del_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 					struct mlx5_core_dev *peer_dev)
 {
 	struct mlx5_eswitch *peer_esw = peer_dev->priv.eswitch;
-	u16 peer_index = mlx5_get_dev_index(peer_dev);
+	u16 peer_vhca_id = MLX5_CAP_GEN(peer_dev, vhca_id);
 	struct mlx5_flow_handle **flows;
 	struct mlx5_vport *peer_vport;
 	unsigned long i;
 
-	flows = esw->fdb_table.offloads.peer_miss_rules[peer_index];
+	flows = xa_erase(&esw->fdb_table.offloads.peer_miss_rules,
+			 peer_vhca_id);
 	if (!flows)
 		return;
 
@@ -1353,7 +1350,6 @@ static void esw_del_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 	}
 
 	kvfree(flows);
-	esw->fdb_table.offloads.peer_miss_rules[peer_index] = NULL;
 }
 
 static int esw_add_fdb_miss_rule(struct mlx5_eswitch *esw)
@@ -3250,6 +3246,7 @@ void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw,
 		return;
 
 	xa_init(&esw->paired);
+	xa_init(&esw->fdb_table.offloads.peer_miss_rules);
 	esw->num_peers = 0;
 	esw->devcom = mlx5_devcom_register_component(esw->dev->priv.devc,
 						     MLX5_DEVCOM_ESW_OFFLOADS,
@@ -3277,6 +3274,7 @@ void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw)
 
 	mlx5_devcom_unregister_component(esw->devcom);
 	xa_destroy(&esw->paired);
+	xa_destroy(&esw->fdb_table.offloads.peer_miss_rules);
 	esw->devcom = NULL;
 }
 
-- 
2.44.0


