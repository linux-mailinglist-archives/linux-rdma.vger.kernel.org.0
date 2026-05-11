Return-Path: <linux-rdma+bounces-20405-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO4JIdkZAmognwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20405-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 20:03:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0044B51403A
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 20:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADC3D319F8AC
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 17:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F103946AF32;
	Mon, 11 May 2026 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ctSmugKy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF84611CC;
	Mon, 11 May 2026 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520514; cv=fail; b=h4BREu9BzyjrHblaHH6e9OPTxAyRzOCI+l6HrfSiw3gl+mcz1mePKMt4+0b5J7ngKtjQL2+szIDTwwlywIh5CE0pMuYxKAbK4HRjqkrqw8V02FdxegzyeSHYkfCq174PInn2Jwq4+WILsDGwGEusQJSmiW1EpG+I8GqQcFsJRUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520514; c=relaxed/simple;
	bh=G2TWKyWHa+9FXMlI4yWwjug+BfdXDYuGeoCB/jC4u78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvE/HOlDzmjPQyj/t7aG/Ut7B3EP4PobkEPUTvu9om7uzmftqDUMGeMWAC5bExTDM/480OxGK5QwbEIbSIcwLUnTI/W0fhs0oIuz3RUtVEMFl8YB7ZBXTtVpUWfYgpHMsWZFvSbPSY3lQDRPN/BUpnCbsdqNp957mSr9gDj2zaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ctSmugKy; arc=fail smtp.client-ip=52.101.85.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MC57sF3uSEjVSEmDImQRbpNnB733+BBHfF7Vsw3BAxPio9/5eLAxlIiK0sEOROxwAnmzDbL3v2Wub/ZkgLt5ADaHkzXrMcNBeKSCBErb95k3PKD3AQk9HYuLWpjLKG45G2w6BD7OJLnGh9Rr3hOcbb6c8ZiO3Cg1IyS6nc7diSXvEvKMzYV3K8eGAOiGDwBz/z4rYTkRAOmlcu9LczZ/oTCX2WIPQ3y66pJkb8AR/k7DhOYdplWM7hxepg6EIAr4r/qYhTlo3GzIwA47OrrMhmg6up1C54CWFxk95h7SI8wYe8N3GrsYTZR6CxcnyPzALFabjf1zIWoCMdnct4Gd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DRRCHHoHycljAKAOVLDCjjUFY9jAfMCR+BEMu87C2g=;
 b=lKo1PtQoxHtITpI1BQw67QDkou/0/akR+GnOdbSSW6W1ntiNihffClIVeUbuzGm33CfEiTmkOmKzd46b+kCzOYSnW0KheeYpsxU5p+8dSWk6C4jhraX/4yM3VqFsODwTSh38WrZsjcr6N9tT/kDUbGlyYzTFkWMSmNlLkvrHH4+tcXfqsO375yUb0urwjiUeA2p7PoYpwCokOenJI3LV9RMl7TJaAhspyWOztKjE8fZdduMyOYoNyV64YRhLZvBy8rAEJv7Zq6EHeQayb06RowPK/zAAX1KEOtpPp6ZIr5kwLYRLS9OceaaaX9oneGDzmguIEwfuQ0olF5AK0ISPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DRRCHHoHycljAKAOVLDCjjUFY9jAfMCR+BEMu87C2g=;
 b=ctSmugKyhbn+rJ6ASRfRei9kXvtQ9vsTY/7t+PWy80BTwjE9RwTq4zIiHAmJ9pM6w1T5DbqoBrxiE17E3L1OcAAGvx70qnyIv3Mgsv4zdCfsGMYriuJPnHw9hv+KC+cfwNkV17UwbaBEw7tFdz3BHQNWEkjtih5QhdGQfNaqg1FGN1HRPNXmuadsEfL0Mtk0E8fBYeNmdY7v0n/O94PEjCffCSmK1LeNXYm4XMtDL/anegZzafpvqjHQLULVobfwk1xhEhCTPHXdHAHRkopJBeBSproOQB7u1E7OGci65xCYHBetPfAVj6CoWzRQJOlEUBMH9gcNjN59ANwczD/hcw==
Received: from DM6PR01CA0009.prod.exchangelabs.com (2603:10b6:5:296::14) by
 DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Mon, 11 May 2026 17:28:28 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::28) by DM6PR01CA0009.outlook.office365.com
 (2603:10b6:5:296::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 17:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 17:28:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 10:28:05 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 10:28:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 11
 May 2026 10:28:00 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Simon Horman <horms@kernel.org>, Gal Pressman
	<gal@nvidia.com>, Kees Cook <kees@kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 5/5] net/mlx5e: increase RSS indirection table spread factor
Date: Mon, 11 May 2026 20:27:19 +0300
Message-ID: <20260511172719.330490-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260511172719.330490-1-tariqt@nvidia.com>
References: <20260511172719.330490-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: e93986bf-5f88-4282-4d66-08deaf82b72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	SoVJwc5VgTj3Ba3ouOmsZ3lBrys3vBTF6AxqGEXxeGCuMB9l3ZH+jZjiCq1VwvmT5ET/FmJLzoaurolm+Sn/kB5rj4H/xZ69FpJqXbDSkMeXDEZpzUntaotjESb/BsFRZJn+mvYg/iAb1BI1fXFm/dhLqf9yCOJA15LbmYmZbXkdnzj/9ekDIGv1sK7jvoOTkz27+EnJ/saRa/rdQdr0tpImuU2SpZN++nO2P59EGtPG9H/Z/Xst+BufaVl+DkmVAz8181CGeLIOz6Hhyyjj34DukcYFODdDo5EE5QmVkt8RVXK81UOEVDHfKgdoHsmsyD6yFi7EnvqksCLInXTrmZ1wyFGUrjmtzIikEmx89P4VJVwdY/UkWJa1ki76xVDPNOGUFge3psUClC3liDp5msP9XzmQZzkEgowwFMDYRhdFbXs+xMA6FTHPtoawUgYR7BjI4MoGrlpKrV1p3ZPsN5AaYIceEXAMUOu259/jdKy0U7dkI0zSXuU6tkXXLUO1f5bQHO63Y3Y+hRASRQZ6J6xAIoui69Gzj/zI46/FjQ4+gES6QS7lX7xDDqeluMzDzXVBL2Ew1uZEdQvJoHQ/eaBf5yjJsvS1S9uslHXkJGvampJGk5yOGzLld+hqfYcdUPac/9ycI9bNP67RlOzpUXHzpEO6jJvmNuQPm6y419IWtBcA90wCDm8baBxBy3s3cl4AxOCe/AwjfdeddPtTvpheXZex22ECgvnZSCwzKjs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EBeqxH3zRSM9CL8v5xp7qNT5Oqjvro12rMxP05hPRlfYAgRi5yic386YLvglvxYiDv2zL9TDO6bil64tHZoZzDKsOtrlYy2JtmUsj2kk2hXcn+6rIXKCqTi9RbD9CP9a2XhZClrKnNrbTa0I1EJupz7lVaOXbIAmFHPRV88MwuboYQvenOwTG4fZL+zB/kxxy3OxNzaS5cTnkz+K/Rws/2sE9srnk4OyO+/5vP/yRM9SxaDl0egY3xaqSRX3S31+A/9umtly6lfQbEELk8aliaBY/YUvL+XIicjCsCDPB+Uguyca4jKUmsueOug77abdnB117Irzb8FE8QdHCz1MAIpixUaQUR4aGAwBG2Ilm/dRZXp952oo/4/UWIlIk+f43zCPHJCKxnOYri/392CSAg3lNQvjtFQR8OIYrlUWuSipZVz1C/BOkOeDPZfAapNN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 17:28:28.5573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e93986bf-5f88-4282-4d66-08deaf82b72e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
X-Rspamd-Queue-Id: 0044B51403A
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
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20405-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Yael Chemla <ychemla@nvidia.com>

Increase the RQT uniform spread factor from 2 to 4 so that each channel
gets more indirection table entries and traffic is spread more evenly.
For num_channels > 64 imbalance drops from up to ~50% to up to ~25%.
For 64 or fewer channels the 256 entry minimum already provides at least
4x coverage and the table size is unchanged by this commit.

This satisfies the minimum 4x coverage requirement validated by the
generic RSS selftest commit 9e3d4dae9832 ("selftests: drv-net: rss:
validate min RSS table size").

The 4x spread factor is best-effort and the table size is always capped by
the device's log_max_rqt_size capability.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
index 680700e7437f..c6d0a92b132c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
@@ -7,7 +7,7 @@
 #include <linux/kernel.h>
 
 #define MLX5E_INDIR_MIN_RQT_SIZE (BIT(8))
-#define MLX5E_UNIFORM_SPREAD_RQT_FACTOR 2
+#define MLX5E_UNIFORM_SPREAD_RQT_FACTOR 4
 
 struct mlx5_core_dev;
 
-- 
2.44.0


