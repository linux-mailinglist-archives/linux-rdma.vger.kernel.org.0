Return-Path: <linux-rdma+bounces-17766-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKJNODmZrmnFGgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17766-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:56:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E823F2369CA
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 430A8300B29B
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 09:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ED9387577;
	Mon,  9 Mar 2026 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GCamR8DJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012025.outbound.protection.outlook.com [40.107.200.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216234F48B;
	Mon,  9 Mar 2026 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050154; cv=fail; b=V44ijSR0NmUitDk/6zW/sxed84y6LC13B64m9Zuje5mKkr8OsBg0PHig8wok3wzus1P9Cymr6v0DaWwS1TfmQcSsJjvDg8L5bi8HYQPQDtztfq622ehL2BBC3ZgK8X7J4+HqpLNyz3dX85XVo9cpB0tprUC8d3FZRhXKMuWMlmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050154; c=relaxed/simple;
	bh=0EHrSys2Sgj01EMUKF0Xl0za2jnFVAszv9WmbBvp8eo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZsMqJrOGDwqkqQzwgNx/4VBLGBoFSGYaDutK4LC3won22k7O61+T3N+pGPUpPJlNDDxeL+tm1D6SXjCatBl//EwfyShq32QfCrr57NKbdjwqty0Qh1v4oJhk0pJvVNiaSURCNOO1LdAmxT6Oa7Hxc9RmQIGiukJZo0B+l5wHmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GCamR8DJ; arc=fail smtp.client-ip=40.107.200.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4i5L87lhVp8gqvG1r5VfSqreOKBSaDKkmTXrehLnPplNkHeX+ojmH6mpwx2WP6TnqQ+gjaE2mkhpfg1biCH3dsvuJAX16SugulsHsLeIfSCsJhdrP7W4eUa8Anr73Zuyw43QRPI07rVJRU2mhs61s16+FWo8S39u9zxnF4rB5723gFImB7tSBerpsCyfSpnwVscRmuTMrhzkGInRli1IYZeNljD2wqeHP2pUb0mqbCIzWTnAKZhKhVDqlCDPZEmRlkf4/2hDLlgktIUofiBy8MZnBoYEK0H7V7t9zdaleBV9pYbAEpHxsV7j64+tR3Ta2o8D/P4lGvfmwJFnYkeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPgZrz1pOynu3qVGXOSXDl6gTeSApkPmUp7Ci1xthlI=;
 b=Zzp6imofxVgOu1DxunbqjxVFavtTvL1ew51RJk89udk2ui054dmqfmxoTe7OXt2PgwqSDn9dDdEqc+0BdfZd37nkXSLim/3tsTI2ygAOjE6XG8QH9AMfjHvsoVMGKBM4MHIpr0A3c/3iiy2t+VO2VbhSzUkWdQy4lTEFvKbelQl7++WFaDN6vQp7u1Js6PRymp002xmtkhwnJVS4FBPC/2EynoLbQQV4RZnsKzHJi1Vv6X7cNDHiGmd2tbbE0LAqbl2RpJ42SlCU9onoTW220LSmNFu9n3/Vh6n9nzPUryThnL8ehs3V3KDDxci/K4hx2kFTI8ZbxGAWJX0wXRIN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPgZrz1pOynu3qVGXOSXDl6gTeSApkPmUp7Ci1xthlI=;
 b=GCamR8DJcK7Uov7m0tMNUx5n6dL3WUYlqVUAwbSiKzzkioM0ld7osfzZDgXu6RTVr7sE7Tm9gsO7duknCtkioxusy/jSZEHRgwN34sdBfYliEGyYPhgJ/ipF18e0AUQcou3ZCSiot2B/3c/U9WQ6gdcIyqM2iZ19hisPMTYYLcMHJQ6msUZbTOl/4KMsGm/X/1nTG8Yj2o6kUClPCakb0l8z/7NxCRMy6Tx/g0JivI/4L8bpJO1e1sISi/wcKkgh7AXLBjK5oZkLWTiUO9OKbHxlyGaxVcTLDwrIWEZKdEDiA0kUxQQ8zoenHBtwkLQseu6B7cxOOvUrmXmGEyWAhg==
Received: from BYAPR07CA0095.namprd07.prod.outlook.com (2603:10b6:a03:12b::36)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 09:55:49 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::df) by BYAPR07CA0095.outlook.office365.com
 (2603:10b6:a03:12b::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 09:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 09:55:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:55:37 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:55:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 9 Mar
 2026 02:55:33 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 1/5] net/mlx5e: Report hw_gso_packets and hw_gso_bytes netdev stats
Date: Mon, 9 Mar 2026 11:55:15 +0200
Message-ID: <20260309095519.1854805-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260309095519.1854805-1-tariqt@nvidia.com>
References: <20260309095519.1854805-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 38163111-82bd-445d-0e38-08de7dc20ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	90tiNirGY3CsPSh2AwhAd83DU3NDj7MdQwJ2CkE+m7AMeIc89vGr61tGktZb90zS6hcxxTv8V0ClbBKj7cqb/MB3ChhRCfn+DrEZsPHqU7RilM1WoNxxaF2SLb+khEBIKdjbGTHKptyo8rtoydOayXaLObeSsFdPllZokmkN8DXhKm7Cjvjkhw+fS3lKEUyi06zUxHEzB4+0ZvpDmCig06AaS6FVI4kXRccR2qG3kzM6zdEMtLEwPtEhcaIL+HOmichrJLq+gwFtkGINIcOVWydj6lePU7gDC7Iusxn57vcLjUts0MP+cFEk15VVswWVs0pjwrQlIyB1YaGhwiCMCH+8BMs1T77uJLfbOxZ32XTdrrm7Xd1d41Akjji18CyaKRip56/7vGRte58GdfPaCaN7Gp/oM0BB9sOf3jNHTgKnLJTiszPlfSnS2LkEDyl2e6HR6SsuuXbNpO4yloCkx1m4w48vj6ovXXkgxxDkUE3wx81GPQo3+VTErxsENURvPG0n8Yy3GH7W8Om65mO1ixqdz1VeGLTNDmnSQwpLdctIedt1FccFxjR8T4s/gZcxlCo8it8XlOOTrpT+z9J+Nwchhv+vkbL0mavkxeUg/2tf4j2DDDpkmIGVR+AusoN8o42S+NFrpsvcvxXZcLYHuyJqXHDGTh8bXqwsv0mf8AZck1AjOZmsF+1At6srmGtx3ZTCHVXbN80Q8ldK53QqVyuWcgA7GuPGwNY+OD4SoPG/Otd3DxfrAzGs52TyzuYZKtWWS0dR84Y1XA4NECM0zA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZwnW21MOt2K1JHrooZN0++KuqaR3Y7e87K0+9wo2trIETAHkfN+zwJTE4Znu2b6i/gxdXnm0PdG4QlnVaBRTsfGC0XX5I/5w0dv1op4IHwgP/dbds8SR1lVo+leHdZhmGDysBhIVZfh3aVjBLeli6uGiCuMTghUMABfAsWwV3J8PX29vwvJub0ODFmsZohSX0GEFc5PlYQCOk6mpWX64YPVUsO7O4fXZqV+KGqkMv+F/oRpBooSBLWlJUcz+lVN/4rqopWo0KbLtzc2pV/GMW8UUpfGADJwtz4OxX/elvMdW3WLxxgFjs3JU0Kz8xDMomD8hDWrZhp8/fRYY11r/t2aHGJIqWeVT3MOqOBHxsf0wNRaRikZ3/7imouzXzYJMLEk1Vt7WE0YwfWNwisY6JdOIA4vOoMXsyOsx25THnX2eZwJL0y94czbekOLSZzgF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:55:49.1723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38163111-82bd-445d-0e38-08de7dc20ad6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
X-Rspamd-Queue-Id: E823F2369CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17766-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Gal Pressman <gal@nvidia.com>

Report hardware GSO statistics via the netdev queue stats API by mapping
the existing TSO counters to hw_gso_packets and hw_gso_bytes fields.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f7009da94f0b..3e934e269139 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5479,6 +5479,10 @@ static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
 	sq_stats = priv->txq2sq_stats[i];
 	stats->packets = sq_stats->packets;
 	stats->bytes = sq_stats->bytes;
+
+	stats->hw_gso_packets =
+		sq_stats->tso_packets + sq_stats->tso_inner_packets;
+	stats->hw_gso_bytes = sq_stats->tso_bytes + sq_stats->tso_inner_bytes;
 }
 
 static void mlx5e_get_base_stats(struct net_device *dev,
@@ -5518,6 +5522,8 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 
 	tx->packets = 0;
 	tx->bytes = 0;
+	tx->hw_gso_packets = 0;
+	tx->hw_gso_bytes = 0;
 
 	for (i = 0; i < priv->stats_nch; i++) {
 		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
@@ -5544,6 +5550,10 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 
 			tx->packets += sq_stats->packets;
 			tx->bytes += sq_stats->bytes;
+			tx->hw_gso_packets += sq_stats->tso_packets +
+					      sq_stats->tso_inner_packets;
+			tx->hw_gso_bytes += sq_stats->tso_bytes +
+					    sq_stats->tso_inner_bytes;
 		}
 	}
 
@@ -5562,6 +5572,10 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 
 			tx->packets += sq_stats->packets;
 			tx->bytes   += sq_stats->bytes;
+			tx->hw_gso_packets += sq_stats->tso_packets +
+					      sq_stats->tso_inner_packets;
+			tx->hw_gso_bytes += sq_stats->tso_bytes +
+					    sq_stats->tso_inner_bytes;
 		}
 	}
 }
-- 
2.44.0


