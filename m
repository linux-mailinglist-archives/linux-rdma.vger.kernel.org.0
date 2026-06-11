Return-Path: <linux-rdma+bounces-22114-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uTi8IN2+KmpcwAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22114-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 15:57:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D4D67281D
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 15:57:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Keea4DBR;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22114-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22114-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EDCB33B5774
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD203F4DE0;
	Thu, 11 Jun 2026 13:53:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BB11DEFE8;
	Thu, 11 Jun 2026 13:53:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781186002; cv=fail; b=LsGf+COKukr/+g30R+YIdKVLu4Vy+eezSqdgiAqWI5V2jBJ7Fupww9dqO0uWavgjsSw+LGw3mHl0Tn6EcNDGn+rszSWx7T2g1JtXaTCtf1qqCnQlLz2mR5LjkqiK9QBnbdYd8xGlNwMf3hCrAHaRij5RMFjjtqe2kvDc6p4o1uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781186002; c=relaxed/simple;
	bh=fdizmusWIe3ISCo1/0PtW18g6EU0dZ6Gi73/4MFnghY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oQJ2LgKlUJAjtxXpaOXRGvxOPYyrQsBqWfQo6EXxUsoofOZoWdANWZLOUgPOPp4ajD4qk87Eo+mwTvfozIifcTTGXLFIThlrJPpn0zOm7oCctoCaFWeWXeg5u7y682zw4oK7RE4OT55OnPfjKe9CF76xxxqn2QY6VE4TQRc9C00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Keea4DBR; arc=fail smtp.client-ip=40.107.209.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/2/SMdtN6JpckzATn+S9p2xfxSpKvp0cxh+CqNIaDz3i0dCTQxEEFxG2bVxBmc4iuCIXulAdKB2jy72VVMxjQjm+GLjwU5Eqtf3Nj2aSvdDxIitr5V0dc7QMs+yvv6ITPDt8V2Tl8ETXNojkUiq7fiENAHRh5M3RXn3VIxE/3NMe3LYu2gAdGNFmnp7wCGwul2OEow6sj0YoX05nvqiG+fLkDHHxrYGCq44444Ovzk0DUM27C1PSg4mc5kbIiC6rjInZ7scPqysBB0FCo+FUjt6gBhSgAups3HLltoIevY8oFH/f0dyIapDRAmQVXuISjPT5HB0PMjbAbKE38+N3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTuVyVngoZwwUFKHdu3nScQzda1FwQvUp54l0eg2sVI=;
 b=Z7POEs7xjyoOgyxnsUiVhA8F0Xag3IWyO2wWIQlK3FbZ+Plbhzwh3Ov0Y/2IY1BQMvNit3KViMhbiVM32rm8qK5B6ToWw/dG/vHhnjx/zExIKhRcX3y73AAOXJLXrHYnLGGJPFGUkNpnpcrxLM2uHQLFwFtI5I4EKoW6GKyyY44yN3P2YtnjG9pnbOFqMhUMnrKVSONpTppB4i3xqsNHPJ8jeG95ljlPm8CS6tmsAWqA/e8C2aJwx+jQupUmk2Cd1yDmNd+YG1g5INjsb6IrOfQ/gtNOuH1nsxXPsBRdMjTXREpFSapXVI04uas37WiM7ml9naWk6nSvroshH2BGMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTuVyVngoZwwUFKHdu3nScQzda1FwQvUp54l0eg2sVI=;
 b=Keea4DBRMTnjpvdTwnWxGeCymzN0098rI9REleiXwn7YPRWL3dp3KaHqHFLr1bIBmhGKS1nRNkb47F4Jj0QttYBZ68ctMAzMBrrAJ4CrW9OBLIYAGVPm1KD2zSNMDdO62YwET9G7qt5GAZL9gyB0FgdCMGDuZLqOqhjbB1uoiaXjXAkYQC/XP5/nIN5CXBf6UF0jLykUeGaf2s3f4632WAoPh+zQ1vQAslJi5YaSsQi64RvNEUsEB/36iiNDOGO//x51ZCHLNi088tML9vGYArtD2gHS6n/V7sKmMJUGskhEqvzyLnFSahG4qnWm6bbUqFfki6l0psX1ccSnVxB87A==
Received: from BN9PR03CA0884.namprd03.prod.outlook.com (2603:10b6:408:13c::19)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 13:53:14 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::8b) by BN9PR03CA0884.outlook.office365.com
 (2603:10b6:408:13c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Thu,
 11 Jun 2026 13:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Thu, 11 Jun 2026 13:53:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 06:52:48 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 06:52:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 11
 Jun 2026 06:52:43 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>
Subject: [PATCH net] net/mlx5: Check max_macs devlink param value against max capability
Date: Thu, 11 Jun 2026 16:52:30 +0300
Message-ID: <20260611135230.534513-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 4becaccc-7759-409a-67b1-08dec7c0c84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|18002099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	+ctEDv5tvCxoSD7tJ/Y8dI+iKwzdpNSIamMCeqxrck1ehff+W+ScB6jDnmEPVwOGh61tRMwJ4q4gXYvTw3uADf7cHTT9YDSEybjLoHXT/OLgI/FPi/1x0Pzoon2vhG4vx1Y3jxl0eyuKDGbl2vtucn3kVBtcAlljsdJKpIZDBlvz9SdwFGYR6PPZLW6T6P+4dX8kqt7bjy3bsz755r/mc/CJvOgXJP3NmOO+moFFkGbE/VWbE8VrdwBPYcnrlxmPfmEL7OmAYUWB5/B7F3mJS3wNX2PxJkx1Tv1t/51L3lJzM2wT3ixmCuejV/IuR7bnji5DNZqmq0X/K9BFECIsKYTy0R47dbwSWKlLyw9iTr0pY2mPQcKpLw1bAipN6cstmi0qWAeQq8Vz1Q93muPJX2SwVJCfDdrYF37iaDRCGHmOhhOfA8w20kbcMz+8Smej9zdfH4nYNyVsVs4TvvIfaTP/QosLb/3UgZ6jabdSWusA223ExL6tTSLbkkOMu2ytCb/9GgC1utbQUBnHIj6sjdUfCSvdEK7D5q8kvl7M+SIuWMmjURFQypyhJXeeuDm3apjLQ42+wEmx5UAvBtmroqC+U6WMi9+Z0sg41xxujtW9bdiN3tu2VfOy8NTPvymKz9FaOX5/M6VmbwX59+VmDav8e8K5JYDLpIpjrKOMnS7HcDXj/x4tkM7rPGsyJVpvFeN3pYr3VBFoeEQp+5AmqqULNvCEcPdWi+p4S4YyoSU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(18002099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VlcXeWvOQcwZ84ZHU+HjU8VmW7l2Rg/VZH6/wR7bgj/aUsL+KcN/tKlFswGQ0LvDGtdQFQiM9Qf1CH9o8cK2MFk7qpaUDwbEIWYmUq+9wcXwReqS6cVQIJPdEwsZQoIe1PIexcPHSoQhttvPIYdO6VGSeNA0+zDozP0IGh0Fa+syekb09AmMHVC8jeN0FP6eNbBw4eShGP4eNXENgh1jecKAi2esOZ/Re902EdRozdfih80GOwXDGOzjqbRusgEjMli3jQLolRQ4nCGCeT2VPDhIdI2UPUfhYE4xj40zP5MaWHgJrRqOlJoYBk1/JLooN1ZOIllhSdXqEdJABEwJaTpLWhkkebdmaN/TmWAQEMnSETJJDM3EF0UyzoM40UNLYe/JCXI+/Mu6S59Hz2I3ny6VElHjE/xKUUcNxCf/IOfpLMrKMAitF9USYw+tuWsL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 13:53:13.9480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4becaccc-7759-409a-67b1-08dec7c0c84e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22114-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:shayd@nvidia.com,m:parav@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:ychemla@nvidia.com,m:cjubran@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07D4D67281D

From: Dragos Tatulea <dtatulea@nvidia.com>

The max_macs devlink param is checked against the FW max value only at
param register time (driver load) and inside the validate callback
(devlink param set). The stored DRIVERINIT value persists across FW
resets and devlink reloads without any further checks against the max.

If the FW link type changes from Ethernet to IB and a FW reset happens,
the MAX cap for log_max_current_uc_list will become zero, but the
previously stored max_macs value remains and is unconditionally
programmed into the HCA caps in handle_hca_cap(). FW will then return a
syndrome during SET_HCA_CAP:

 mlx5_cmd_out_err:839:(pid 3831): SET_HCA_CAP(0x109) op_mod(0x0) failed,
 status bad parameter(0x3), syndrome (0x537801), err(-22)
 set_hca_cap:907:(pid 3831): handle_hca_cap failed

This results in a failure to register the RDMA device.

This patch skips programming log_max_current_uc_list when the MAX
capability is 0 (in case of IB).

Fixes: 8680a60fc1fc ("net/mlx5: Let user configure max_macs generic param")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 74827e8ca125..37af619e5e04 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -527,7 +527,6 @@ static int handle_hca_cap(struct mlx5_core_dev *dev, void *set_ctx)
 {
 	struct mlx5_profile *prof = &dev->profile;
 	void *set_hca_cap;
-	int max_uc_list;
 	int err;
 
 	err = mlx5_core_get_caps(dev, MLX5_CAP_GENERAL);
@@ -610,10 +609,13 @@ static int handle_hca_cap(struct mlx5_core_dev *dev, void *set_ctx)
 		MLX5_SET(cmd_hca_cap, set_hca_cap, roce,
 			 mlx5_is_roce_on(dev));
 
-	max_uc_list = max_uc_list_get_devlink_param(dev);
-	if (max_uc_list > 0)
-		MLX5_SET(cmd_hca_cap, set_hca_cap, log_max_current_uc_list,
-			 ilog2(max_uc_list));
+	if (MLX5_CAP_GEN_MAX(dev, log_max_current_uc_list)) {
+		int max_uc_list = max_uc_list_get_devlink_param(dev);
+
+		if (max_uc_list > 0)
+			MLX5_SET(cmd_hca_cap, set_hca_cap,
+				 log_max_current_uc_list, ilog2(max_uc_list));
+	}
 
 	/* enable absolute native port num */
 	if (MLX5_CAP_GEN_MAX(dev, abs_native_port_num))

base-commit: 0068940907d33217ae01217f84910a5cde606c17
-- 
2.44.0


