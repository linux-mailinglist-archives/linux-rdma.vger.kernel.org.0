Return-Path: <linux-rdma+bounces-20401-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EfGEI0YAmognwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20401-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 19:57:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A48AC513ECF
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 19:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 418FA3045AB9
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 17:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E3244E040;
	Mon, 11 May 2026 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qXgoG9QS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013044.outbound.protection.outlook.com [40.93.196.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBD144E051;
	Mon, 11 May 2026 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520497; cv=fail; b=XUNYL4nNkCdwPmd2gJSZY24PqLxgjN7DUlYN8U3lbgkv7Y7sn5910C8wYouxE/dP++6n7fC3wzhEAGbGDj5/f/qgNmdkNSqmPofhePHJ0kUeu04lV+vSZS/cxUKvuzFzfcyKW+ptj5fQr5v5X2l/q4scXWPYQtorKo1rhk9SJPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520497; c=relaxed/simple;
	bh=L7PPq85gGNwYN3NbbrkHVJ0HzfH4oU3vlDa47c6RYZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E88UNUMaAb6uaoQ3bU71PatZW1G8UZPG+7L6XWZiJnVriDlD2NBx7zPG4EekHtXR/6L4Dh9Tc2aMVyYB+679yggJ8F7+o80Lbr9h6EKP8rwCfYyqDKdsc1gPbZoyWY1DYYSufqSrLKmXNPvJ6Kx29n0PdsO92dSFwbehYU3qsV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qXgoG9QS; arc=fail smtp.client-ip=40.93.196.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QauO9PnAdYAz8/U2fE/RZhOyVtoacegRpH7Vv4RE0NKmqf1nD/HDz/Cl/Uh6ybBIskdMjeTj+2Gw4TMLbV5iDIkweXoqKeD5aV1yo7Rc8Dm1GM9KRElsBJggoNOgGsPUFW7jkx2O0brdq24UnPBnBD/vpFgjkTPM/GQunc2QpMPCuxGhh7bgflWavqfmllYRcAwLHOvtZuNoOcfr+iYQHr2ioWW9Jdc/gTroXoolwgRWnKYapAtocNighnwSZzFeQx9YyzWPyCk5DVMWv27HHHpRHcRzKPyDDuB25zMfK9j/vzP3yjI0XvKy1HWwjxAY9rAMZDiPQ7V2Cn0qIrI77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTGuO8gm31U7x4ayHiOwEUdBTrDkKTaCy8ohhopqQdA=;
 b=UjKWm7aKGa6S4mzAbAE5lmD53LTX5Ir0z17mu2jnj2vTjS5EAqf2ADc8QFy4o8WuSP6x+PRH6fJFJyVlDUw3ypk/2OtLKQTDafELaYe9FsNSerfpX81MRwTryK3sKVqwPKr/lIOm0PiXSZGfFubTrWXBdvkVi95vHK9itcEEJklkXKqPsipyf60hfc0TRkzyy8bm5bXJ3wpVsmeAgWTRXVY0IwPR1GMLUSP+C74PwXPSM1NFIbC/xp4kXN2gFWby9yLIt4uukZdGa6i0lp1G+PrgsaaDNz+2XlP0NXZ6PEm3pFOx3i8TwIXN9VZZl29nzZtej3wRQjm8/VRNAhYs1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTGuO8gm31U7x4ayHiOwEUdBTrDkKTaCy8ohhopqQdA=;
 b=qXgoG9QSOgLtfdrXzB2CtN3gdrwZ6c3geShQ6NfJnSk1a6Z6bMRktByvun7fDh16XvhPImsAQx1Ck2v6NqNY07AzMKz1q6TzIZHUNErEJIFaSKef40qDVfTote/J4/KYasuA+OahNXcoolCBMsEmYxsgP0QM4YKIpV2U6j6PuRfb/Q9TcNVAr3IrOFzQzRpshqJkUzzC4coM8ESoaK9PTybt7M75uDJjxt4PA6gtMvPW5kEVKL0KXTlgpc9g0xcHY6eSOvyPwvT/4/UEGvoy4x3KrpiHtQXmL7BVLonERobihOLZEr+ZLCcG+oyOK03kQ2rXZI7aej5+8RgME3LDFw==
Received: from SJ0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:33a::14)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 17:28:10 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::f6) by SJ0PR03CA0009.outlook.office365.com
 (2603:10b6:a03:33a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 17:28:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 17:28:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 10:27:49 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 10:27:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 11
 May 2026 10:27:44 -0700
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
Subject: [PATCH net-next 2/5] net/mlx5e: advertise max RSS indirection table size to ethtool
Date: Mon, 11 May 2026 20:27:16 +0300
Message-ID: <20260511172719.330490-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba9ea9c-27b8-428f-bee4-08deaf82ac72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	mW539ee9RctI5IPH4BLYZPvNYgguoy2IjEv4Iv71JTQXeM/ngKpi+fQkgWvEgJ2T91MTyheIV/Nj4tAR8x4uU9a5/O/vTLcmAc1U/l5usQe2v1hI8TDTvaKW/gQMf9NVzzRD2kKPi71Sv/Dfqj9XwRltbokxNzbFT4LVGdADiVM5eKpQXo+sybYB4aTXL8yGlGwpON/dzDj/7bwl1I0SDM7PkYMTIfo2wUoyuRZUiDElZlMs6obylj3j56kYdqBAvRDuAWAKv8ypUKIPL68auS/F7mZOb/9pASQjSde0DvKdF4VHg7Qf4PvQxeWYl6gzbVsP8vDmrFnvCBFJGU5LfDjkBIf/nvt9JJ72qLob2c20UcTvnNmOu1nNg58k6fS2Kdy70bbZfzm3DTLSVz2qBFY2+yyakj2OpmZY+pmuWMRWsz+RXcbsl8/pS9MCUkBpBN73GrxWSbnxnQCVlhGAhXpBhwuT8HKxjG4MjMHpusSdtbQbUsD7fkagKnpxEbNHr0XdZZvD7K+r8umk3cEwwmDUl4IAYJI0954XTLDvtUAi9H9DqNbCcmWRUCmayvKc58nOd1DSwhy9p2B8DSCmMlMYF1anA7XIMzbnJ/CvK/pkmKfoViKyd6YZvnUWt8CJeFMXo6qdrRTq3hgXNid5iszmN3w8968RSWz8MJ0QSzRTASdOePsRJrZEccEtYkpuK4MNgiq9fr6RHV8XeEEnMcsAxBCZeRPNTfnHtRiMgyQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pfqpu3Zt2VZNhSlcntrPW1bPSzpo0xBLFLHV+tORxLvBcGqxzE+BUJTgmLbV/oLsqb/hbtzusgsP5/LWMC0pPLXo4iMV0YZuDB9g7zSRHhStBuVk5m4LQPRxyvdDdjMDnvIJ1stu8jjkQMoReg44CZ6ICIHUP+dDykAFUsa2daGGKCXK1CsrV/vZe8S2GDvqUZwLPR79Eks0/3fUzxVDuMOddUA/yKXgOgH1pPgW/1dHj16ADOyPydfbIkMiKUSqaUHV4Bsm1WfctcURcx8ptybNuu8r0mJfgiyHeoC2qU66OjC1QoyeisQDr9UlegeT6iHNBO+2umiQICNY8IAKZJYsa1h82+VF34Vsmw/rabNevKpmyMTGBtWbiR3cU6dM4BggM6u0faRtvT5VNNU6xNHpBzdJUG8sn2cNtuZItNPFz6pEPLNQTL3XZfkDyLDS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 17:28:10.5669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba9ea9c-27b8-428f-bee4-08deaf82ac72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
X-Rspamd-Queue-Id: A48AC513ECF
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
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20401-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Yael Chemla <ychemla@nvidia.com>

Set rxfh_indir_space to the maximum indirection table size the driver
can support: the next power of two above MLX5E_MAX_NUM_CHANNELS times
MLX5E_UNIFORM_SPREAD_RQT_FACTOR.

Without this, ethtool_rxfh_ctxs_can_resize() returns -EINVAL, blocking
non-default RSS contexts from tracking indirection table size changes
when the channel count changes.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c     | 2 --
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h     | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 5 +++++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
index bcafb4bf9415..a3382f6a6b74 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
@@ -168,8 +168,6 @@ int mlx5e_rqt_init_indir(struct mlx5e_rqt *rqt, struct mlx5_core_dev *mdev,
 	return err;
 }
 
-#define MLX5E_UNIFORM_SPREAD_RQT_FACTOR 2
-
 u32 mlx5e_rqt_size(struct mlx5_core_dev *mdev, unsigned int num_channels)
 {
 	u32 rqt_size = max_t(u32, MLX5E_INDIR_MIN_RQT_SIZE,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
index e0bc30308c77..680700e7437f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 
 #define MLX5E_INDIR_MIN_RQT_SIZE (BIT(8))
+#define MLX5E_UNIFORM_SPREAD_RQT_FACTOR 2
 
 struct mlx5_core_dev;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index a6da0219723c..c483008e33e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -45,6 +45,10 @@
 
 #define LANES_UNKNOWN		 0
 
+#define MLX5E_MAX_INDIR_RQT_SIZE \
+	roundup_pow_of_two(MLX5E_MAX_NUM_CHANNELS * \
+			   MLX5E_UNIFORM_SPREAD_RQT_FACTOR)
+
 void mlx5e_ethtool_get_drvinfo(struct mlx5e_priv *priv,
 			       struct ethtool_drvinfo *drvinfo)
 {
@@ -2692,6 +2696,7 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 	.supported_input_xfrm = RXH_XFRM_SYM_OR_XOR,
 	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT |
 				 ETHTOOL_RING_USE_HDS_THRS,
+	.rxfh_indir_space = MLX5E_MAX_INDIR_RQT_SIZE,
 	.get_drvinfo       = mlx5e_get_drvinfo,
 	.get_link          = ethtool_op_get_link,
 	.get_link_ext_state  = mlx5e_get_link_ext_state,
-- 
2.44.0


