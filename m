Return-Path: <linux-rdma+bounces-17770-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEN0A7CarmmqGgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17770-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 11:02:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C9A236AEF
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 11:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 624893189742
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 09:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B700388E65;
	Mon,  9 Mar 2026 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pVEzR/BK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013056.outbound.protection.outlook.com [40.93.196.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22403876D7;
	Mon,  9 Mar 2026 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050180; cv=fail; b=Vz4ZUI6FLlq/ai7D9ZaEpcAOMXpAVNV6ztYY5Y4bwUFP1Fds0Gw5N56icg9bsqQrcv488+tGHKg9s0LmRNco1u+n3iLU+LU0Y5ZpwOXB5MjobGdwmQASPRW1+mloDSfCGEgQRq8XH8/x1QnZRmNb4F95RUZWm0g0uCKlMB7iPt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050180; c=relaxed/simple;
	bh=8r4F3+HNX5x5BN3eBDy/L0c0BsY8otxUZmNwwL0y4+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZ8OWcL2TlFYYfrs961N00CQ40COLgRvjdRzBnR/PjOrn+cfmXZNgJi+xMYOjq03WHlGgH3Vnt/4WWVgq4/J1mAJEecdrIb2cC+MiYLNRD/cHAIY2d56t+AGQJb3tlRSMgQvO7COb9FOATq0tbO6P8G8r/D3MPNPySyqbkBB1o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pVEzR/BK; arc=fail smtp.client-ip=40.93.196.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2jZWZKUH7Rixmy79ilY+dksyHPXaRtM7UnlDcMat7VyMYAen8KOqG88zN3X32nADy5wWO34eNfndfEtZ8TbTkNuUVdfgiJS8wdhFoEl6oF/7O/4Qb5o9ig2MrBEO2k0We4Hpt9V5H8fV55lnp987HG6GkGkpe012W6Sk/wFEyx1Eh83Opa86lvt165+1Dg/7OQxyUwxEl3DkgMc/Rvc3W5EpbeWR0YEJBp+O7renqaZb5siD5D4H4vvZjgtUkxrra6tg4V6pQ/HZIegEviFJgTHdrOLHFrE6RaDXIkRKK4U+x6f0QcsQJ6c3NsK7qGhUe/UqTs/wxSscgZyDztBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhCTITag6ajj85qUDm4vHAMgJvEx/gqo2IpExRwUW28=;
 b=Gxl+ub8IMAE5kDZku7de9o34CDS2LrlL4+7Om5ipx9shpZM7UqVG+E4dlCqWONhrNlko7rgnE1OBtndRowPHHBHmFyWb6xp0AG6Ybov0js3sYMcQNZBCAPLFRL/U7EkgaqEfx1EiuO9UgfpYwSyaR7fPR6G0YyCJhCNiNFT6zk4lAkfEOpl7ym/RQ0+WgIeZEoQyGbbPjfpeTvPxFDlS8UlSlu7Hiwu+ZRy6tWSsgiX3Lb88XHn4dWfGqZTz9aADTiGadZCmGYSEJdsd6oCcKrhtEnsRvEe2wJmInXRI3q26tpnm8xlq2Ye517XlLhZp+kcxrwIA3M1j9XIeiIukNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhCTITag6ajj85qUDm4vHAMgJvEx/gqo2IpExRwUW28=;
 b=pVEzR/BKhEsquRtsxtDV508eX8ZjU5LrBaFgyvtGJhkXhgig3P0ZGPEPDPxI0S8JGwt5HsCT76R3d2WqfSEmDnBU28FSh7DcbGA82O0Rhgqw1bp6pLrdyqNC2C5NORqaKr7MCfm0UkDODqyylirSYuE7yj9Tn6jZxOT8v2ZcjgG/FbdZlmap/fMdLWsNfFNlLniroWA/BZXwXaxaM13gzaFt/hn3flPZwuFgnVApZCIgyIDCrCClRTcbyOthejrrzOs3SWdeGdbem22JthgommeRgB7FHIsNtD+rwJkS9shbnbpDkGEkqJE+D5AQ4z/SBEDYtiKspXlX1L8n67yjWQ==
Received: from SJ0PR13CA0070.namprd13.prod.outlook.com (2603:10b6:a03:2c4::15)
 by CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 09:56:10 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::da) by SJ0PR13CA0070.outlook.office365.com
 (2603:10b6:a03:2c4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 09:55:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 09:56:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:55:56 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:55:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 9 Mar
 2026 02:55:50 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 5/5] net/mlx5e: Report stop and wake TX queue stats
Date: Mon, 9 Mar 2026 11:55:19 +0200
Message-ID: <20260309095519.1854805-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|CH0PR12MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc2cc4c-bc64-4a5f-186c-08de7dc21729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	sGreQusgqpbuxhAR0cYs90xW84doJcAbw7q06ZcaQ70J37fFKjSpE20qPNMLMlEPrAHbdhZmZA/GiIJGhDH0MjVdGR7RAnmNbg4LNGQCi0yypMqpAkmjmNzgUm4scg66uxg2DjhbdMrMAiblbJETOEnLdcCcMZTzynWPvD5WZcOHQNL+jLdrFur0pbVT1yULSzcrhnFGx/H85AmeZaktZuJ+CxEqqaUVZ3hs8yalB2ghuYW80OiBgKthn+pJv7Ex1cbDRTWLJiP+wsyqfoEhFx6owvh+9ZCKLaJTxICqoR8vFSDJkslFsJKA6gfed3A71Ef6mDcj4tJJTX/gPGP4jtD/TOfEX/3oZooP6b30LGm7hKyYIpwOivTXXRiaHjXhdqYN/IR+1hxlubtFHbj8i6o6xVxcORqvvl6s87DxeZ4cfMwwvV3xCt92vMQgaNYrWG03fQF/v6dQf3q6uiTt8obpe0oUP9uFG69KuRu1j3L/MkEKQHPTBeNvYw6hFe1l5UZ2lKm9dbA7xosQy+E74ihlCfFkIzLHTuuIjyM8/94seMaTV6UjuLtRfxKZPfdvs+k7jcudKCsAqD2fZfebeH6Umu3wTwnz+01ZY82ppXqSpeuWeQzm6OdZp5if1E49XRNZFF+SbtrOQ+TCu2M6Kt8aVs5ylV9zd0GOBnDmCWM7FZubbHx406QD7OtNis0AGxNkDcGc/JKtvPfMxVwmm3cgcU7630sED9FNOMfjorzuSCEeumYl8e+yakaWuTsnU3hhl9TMvPNzp35E/K+xDA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+RJKUsFPZ3FHmEMC40V3E/ufUFKHInZcE180dPm+yAkE25g4xEZBZkCg2pQ2J8pAoYAJfLiLfnnyOPzGE/8i8Won2ITeuJ1JCNe2KEFuah5lt6ieka0Na68z8kW29p1c+rfc1opqqrVlhXzFB0bd1SC7QpVg2ymmwvYhA/u7nQxL2By9pbOvogaCCs6GoG0YhcFX3l8Fyb5q8CfP4MX1ujmxFgXBfRflP8MZoLwrxYVLRZQxJzJOHWKLkHxCP3wYBKa+R5tXJs37Pklcu4WhtDxnLLPvAVt0R3AQvSa4F5xP1VU7rp2GYgkncZ/NteuSaqSU0fqsmIQurbMsawqxcTxE1rUMxHJFbI8xSBfFPbbOENTXAxAbAM0aJlH3Vz3BRkQWRHGz/HDFnkbBpNpFJaSQPT5mBo7egN5wCnnL479/QiklIXghGgTDTd5zJlsB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:56:09.8614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc2cc4c-bc64-4a5f-186c-08de7dc21729
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529
X-Rspamd-Queue-Id: A0C9A236AEF
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
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17770-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Gal Pressman <gal@nvidia.com>

Report TX queue stop and wake statistics via the netdev queue stats API
by mapping the existing stopped and wake counters to the stop and wake
fields.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a03fbf1cb362..ebab82297231 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5500,6 +5500,9 @@ static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
 	stats->csum_none = sq_stats->csum_none;
 	stats->needs_csum =
 		sq_stats->csum_partial + sq_stats->csum_partial_inner;
+
+	stats->stop = sq_stats->stopped;
+	stats->wake = sq_stats->wake;
 }
 
 static void mlx5e_get_base_stats(struct net_device *dev,
@@ -5563,6 +5566,8 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 	tx->hw_gso_bytes = 0;
 	tx->csum_none = 0;
 	tx->needs_csum = 0;
+	tx->stop = 0;
+	tx->wake = 0;
 
 	for (i = 0; i < priv->stats_nch; i++) {
 		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
@@ -5596,6 +5601,8 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 			tx->csum_none += sq_stats->csum_none;
 			tx->needs_csum += sq_stats->csum_partial +
 					  sq_stats->csum_partial_inner;
+			tx->stop += sq_stats->stopped;
+			tx->wake += sq_stats->wake;
 		}
 	}
 
@@ -5621,6 +5628,8 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 			tx->csum_none += sq_stats->csum_none;
 			tx->needs_csum += sq_stats->csum_partial +
 					  sq_stats->csum_partial_inner;
+			tx->stop += sq_stats->stopped;
+			tx->wake += sq_stats->wake;
 		}
 	}
 }
-- 
2.44.0


