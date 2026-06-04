Return-Path: <linux-rdma+bounces-21754-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NMqyCjVnIWqIFwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21754-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:53:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E7263F993
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:53:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=cZfr30Iy;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21754-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21754-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 004E3317568B
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF9A4418E4;
	Thu,  4 Jun 2026 11:46:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC2F438FF1;
	Thu,  4 Jun 2026 11:46:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573589; cv=fail; b=F3XPze/D2WrDl2ySgEWERQHyRNdZ4pVEvfZxBi2WizdDM8tzoBF0grc3OQsadnMVSX21DrGPeTaHyuGb2czhWpbLpU0xyCrY8HFtXkRYlu1pGUcXIv0mNxwDQYlThcak6mrwFCUvM6JI+1OkOesDfmDYkAiJNYG4sXY62CHL3Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573589; c=relaxed/simple;
	bh=VgXq6M8XVl205C6as7WC8UDl21sko+5McOSyc8usBpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQpm01Y4sCd3LP6bbLqe1Txk0OsNcrUZ0ol6H3IqSl3gLRNY6KlMox9EacaXZStW/j3rfFBQDAODkquyTDEWmd5Ku+4SV8wSnqClVVagkB53Ez9qS9HzdUi1OomzIx84ZhKvgRa32ByaqBbIItxTmaUoRG7MzeQ4MQ6BZfU4K/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cZfr30Iy; arc=fail smtp.client-ip=40.93.201.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNLX630QM6l+nmvCm4jOUSKl8R0mZKcjS05pom3dXSjtW7tTZT4vtccgbKEQdBD2vpdaEwpZLjCXfYdU/hUUcM8cd7HISEdye8Cn6HthwlztXqiF7Vr8Da7A8oSRl/VSexWrC47dra9XjJAXtsWrzQlXsnoAllB4w9DB2IewDqci/XT/z0X9m0SWh1VstT4D7Bywj6pd/BhFYm+hglcCdDYOwUdyFNid9HCvE6HU/7XFBsnfo87KfcMnFX7cX/csoXzF+AcG3i8ZKLkVok597kGgdzicNctyBAUOKXcW6vdLxO1icRwEtEwuYYqPbgjfm/D7HkRh03Ti8hYkkADgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGLMv4Kby72lGJCau0SwTIznPOYS/SnrAgM7iJx1Dac=;
 b=byvSaB6AWpiJV5V4Xs6JefseRoRvHc69mMEbySliYAbTNTSbg1kPxZ3P0DuDPunAm6rusi+iyS6bgVjKMg7GURo46cWuPFIcK/IBynaaIo4dkPYjDkCm/FtfGHk6vgA1mshK7sbUNCaTNKAvNG2p8pHCs68OOCjtNFzy71Rqkzw0pvFsV+No/b0i3c9PUwpfIYTaoPA69zGeNpVICwxFUTT1ePRqti3evboX3HrZ73GWXkF7/M5lUniHrl9Bvn0lW97NIpPQYoGPPBr5Q2X2W69BvaRfVQZVADrqBwUv2Gr4wRP0wPy7F9k+FM3+XGN7lC6FCpX+HwwG+1jGE46QCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGLMv4Kby72lGJCau0SwTIznPOYS/SnrAgM7iJx1Dac=;
 b=cZfr30IyhS/mW6WFCxW4LB2t+L0Eu+qyH1FHv8NfJrf5OOjDe/qCRc61KEvEoo5Xh/VfDpQfiwLzcrTspKcN5Unmh4zw/98tp0TtjC5aHmREG2XCwvY3FdODPWX5EaD1fjok/1IrdDYhlNeXCAZEvBr1ace+iWUNX6mRx5PSiBGkPfkyvvriXiI0FKAx8dp4VnpkLIZoVfS9I935k0UtcYupImNZBX6DVkYw4pl1BtM0SZAjBcw+AwKczzf4RZhFxugkwBuHWIkg0+P591k4yS/QZHjhljRwYZlgoHBMgqEvcsGIh26Jrn81jwbqLkhF7nkHKVkX8jneQaKgFYhVjw==
Received: from BN9PR03CA0841.namprd03.prod.outlook.com (2603:10b6:408:13d::6)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:46:24 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::6c) by BN9PR03CA0841.outlook.office365.com
 (2603:10b6:408:13d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 11:46:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 11:46:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 04:46:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 04:46:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 04:46:08 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 08/15] net/mlx5: E-Switch, notify SD on eswitch disable
Date: Thu, 4 Jun 2026 14:44:48 +0300
Message-ID: <20260604114455.434711-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260604114455.434711-1-tariqt@nvidia.com>
References: <20260604114455.434711-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: 568a2f44-c46f-4c01-feb6-08dec22ee756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	9vwkTFvsK2UCfo4pAd7i54/8W7sSM5WNkN5lDx8lP57Hmh7xw/u9K0ZNiTf8GJr17RHfjIJqFM30q+Q3PP9Zto2hyX6D68JdxKkFg56JcmNkSTWDu4ILSYmW8jRZTapm3c57XoRkdRz/RXvXUR0tIrjCbyd0PDkEDjl4N+830GxsPr6SE3Rgtg8tLTp9CYJaeFzJi7Kg9HAaZGsvFMGU6WVIudGBq1TL5L8ywv/sLBT45si9WGHgTm3BNIeSWrYmHYrSBfsusZgdoK53rL8WrgYPY5d+VIff8mtkEavPjU7d0uIrb2pM+hz3Bb+H+zzYws6Q5ZqMLjKkp8F4H0o4uyY2P8e4aCaGm0p1tza7o1K/B2/gJ4YgmTeKBTHJ4YEFVqFmFwe7kPv5fLLhn6ozkZhA7jXNQlh0tHn0K3Q+sOxvtV55u7ec9uLkbF6inX7m7TxdwqfHzRQdlNBLFWYEFrfgVSX2y4utpUV0GVL2JGhg2/2WGojtrJH+J9ZRZCVXuWxPismr1/3xRvN0VpYDlZyNF799UcojOeUPuCHwnVUyP+5dypL8DB0jEx/XYUMBz1DIE8THd+E4SIahr1gEJ09pRNm/VkSjNJSDA/Yld3NOOX2vYkl6kslOBAgQUUb7GYlPnEnNwF2aYnS45RVzEyZkz70MfKvwrl9c3rlPI4OOcD84IYKk6BnzmPmPPgwNlbIwWfwYzJdmaF1ZUBAXLJODDzr30n6UfUlInCBQFrM=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GyciSi0bsnbm+FHbTauTHeNafyssXmJxzWqfgXAL+L4yEzSynmoPa04SZ/R1PsQDKZxkS1C9YKH6eVDnxF6Bhf9A0/Z1yP5PG4M/dG2cTOtd4q8bcTzenq0ctpSCaeAl3g5qY1t6kh9dSlfW9caNWox4bmdQG6qF2DA0lG2NdmdRZq9HKmOcAFzSCPYP5m8gOpTmg7XHw0XM+qyICKJiF4xqQYn6o4g+aIGEG/huhXAlt19rRrdqwDeoN82/yzbydw2toZQH2GeZ6KXfoKOGlOSxC2A5Zw4irs5RdU4pt73azbSI4rYzGSJRZ4tyYSJl+QNeeWXWZ+tag/a2ZNuOl4TTD8N1jZTtz6OcyLFLtuWQ/1dBEl50Kdg9741mevgau4diXyWFBkVTTmgBnQ3v0MXv/7o1vlGpbCVTK2BgGW4TzaEchkghV65/vruXdBiA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:46:23.6836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 568a2f44-c46f-4c01-feb6-08dec22ee756
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-21754-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82E7263F993

From: Shay Drory <shayd@nvidia.com>

When eswitch is disabled, notify the SD layer so it can clean up
SD-specific resources such as the TX flow table root configuration
on secondary devices.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index f8cfbf76dd6a..93d51f09b17f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2072,6 +2072,7 @@ void mlx5_eswitch_disable(struct mlx5_eswitch *esw)
 	mlx5_esw_reps_unblock(esw);
 
 	esw->mode = MLX5_ESWITCH_LEGACY;
+	mlx5_sd_eswitch_mode_set(esw->dev, MLX5_ESWITCH_LEGACY);
 	mlx5_lag_enable_change(esw->dev);
 }
 
-- 
2.44.0


