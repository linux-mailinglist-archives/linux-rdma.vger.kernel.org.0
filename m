Return-Path: <linux-rdma+bounces-12416-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CE7B0EC34
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 09:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B303BD6D7
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 07:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D32827814F;
	Wed, 23 Jul 2025 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IDOUypEn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BBE272E45;
	Wed, 23 Jul 2025 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256742; cv=fail; b=dS0GDsmSiJVWV9xFGaaz3HDVcSTuz21ELrMkiZ0P94Iz35bNc75vjpGXJNsodilw4KbiVvv2CDBcmoO7O8blNRn0ewQb61St1lk42RdmS2RAuV9smEON1rr0gxjZeGSVNorI8c1xeOJlPbRfCDBbXX3zNUlwfqzse76r4r91MTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256742; c=relaxed/simple;
	bh=E5lDGbzSfQOgYZ3WNxxL1ywIy4QE4mAx1+ye443XcD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xd6SyoRs/ledJ9x6rKyZ15cqtlrvIR6Au3iHalKq71vOWLYFog+4XqFcfF6inTJRsr74o9be2nhYyomIgc8DDEssQtlKCsikgZMTslNsxEt73hcfoiazsBnw8VRMhBgIqz89ijY1SPicIVX8SO2c/hr2fMP1QiNWwKyrPzUnIgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IDOUypEn; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9IKsEb9yCVs3oX2lEuFmLyEMBVX7lsXqbhF08azmyKhSBjzMg+bB9DFm5ow4j8jznyQqJUBAHwISf1km9fTWe2TnSXUDsFvT3OXI54xVmI9/0SSYH36q2bhlbBQxIkz3FIcWLpnmiu9SEeKu/zlRRwlfm+wwAYoVAkwTAxRZL8NTjRqAmusOJzy2YGKEQqxe0CLw8x6rHZn+xf/z/1364eFIGPXvGqZoJdbUeBw8COQToHaLxlDCSX51ONzxme/6g8DsHJJLlFFfMRo+hcLc0a7dOGacECgjkGmCLbf/7oFJ9wL+ZASZGzsd2j6J28NGK88bAZ501wqgFvTt2RhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwIUa5EpwNYXmORIXMwZijnO4ZWBKpKeVwGprgdSpjY=;
 b=lNDBF9rheP0kTQFO1VIOJmppyXq2aLVE8qPvjwMGYdzklUiDNslYVl+iWjwDEtnNoEYn4JQ6cGONbhQOLqXZKzkd0q/hXH2kDdz0BwV6+GpNurxfztUPCV+tCjzmkKQi7JcSE0j375gwgDuhKAbOfC4v5pkb41LlHwOT83ApRCoCKLDcKtOwoWZJ9NEd4h30ZoGdr1I/ClFXLa7MUHqe31A8s9yifDbQR+B2ZGviEDqDxW65/jODogBwVNYo9L/g2+IlGlcRI/KzVsyC6F/Ny7ifRPSdkoPiwVbEziXl+txvY0yJPsJDsDZqoVgd2vxo8mFpiXV+8ylRjdvlv3hYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwIUa5EpwNYXmORIXMwZijnO4ZWBKpKeVwGprgdSpjY=;
 b=IDOUypEnlA70V7aPMX87IHKoN6vgJbZFcVt5PlcQvJeJmqrzCjbVFxFrVTmx0Kb9zngsMg3ykq0k4eKvCvK7ezin1JluO9Iy0wLWLyLK/OIF6Z7+vujQG0iXaSlYUKTL4Kx/74gPkS3Vy5eBUOqUGycf2+Uvi0d8H/JmPN2Yj4JaLACUwN+6FA39eAslh7HsioyjSJsw9JRgameSArK4oWhK2QVJ96wWcj7X6UHWOIDMZetevHvELT6NXrsXIh5m8e2itEzLu68/Om1FVjYa8gLTx7x52djHzwEikNgCLsR1/F7eF2d1i63OfOiNAUCzRqwftsuE3MK8834zixGIHg==
Received: from SJ0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::15)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 07:45:34 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::4e) by SJ0P220CA0007.outlook.office365.com
 (2603:10b6:a03:41b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Wed,
 23 Jul 2025 07:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 07:45:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Jul
 2025 00:45:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 23 Jul
 2025 00:45:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 23
 Jul 2025 00:45:06 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Alexei Lazar
	<alazar@nvidia.com>
Subject: [PATCH net 1/3] net/mlx5e: Clear Read-Only port buffer size in PBMC before update
Date: Wed, 23 Jul 2025 10:44:30 +0300
Message-ID: <1753256672-337784-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1753256672-337784-1-git-send-email-tariqt@nvidia.com>
References: <1753256672-337784-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d130dd3-2218-4da5-5ce8-08ddc9bce84c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ePY94aPSNf4bYR36sBcDE+UZahNfRVjKnkvCMVRxI5WbPmwPLMGvtBvS7rm9?=
 =?us-ascii?Q?vc1HmiFzYxPya7m7ZtablLXY5pCDwWfNnBo0K05SnKlYVqOziUbWF12LFWqv?=
 =?us-ascii?Q?exDRtckjs56luyCbULvDBpeYaHftc6NQDfAqyVXs4lqgz+sSLDJnfOpScoDA?=
 =?us-ascii?Q?b0eLq49Tj6cb+Qw9QTom+DiL5C8LJadWBuwkNgRf5TifB6oScZ96Z3tC0aQQ?=
 =?us-ascii?Q?cfi6sYCO41i3CT5qyWyj2deFeV9VZ0nO47Q186BMvG86BFKeQLBsVcIlxC9v?=
 =?us-ascii?Q?TiEe639kcwe9DM8SRq9nY9a4+dwFIAx2NxbHXGbNdNV0oti87XR1EWhLbBI7?=
 =?us-ascii?Q?9EBYCYN3Ph+PtH7PRjDikbTdB6cr03+pmiCcb5tSIA9tUjzXIHT82+sEF0R3?=
 =?us-ascii?Q?APx0oVEMZNiJ/nuUoeJxtBJM1rv3Jx6HxT7cU2rdnu1v9SNtzkmo+2PjXvKs?=
 =?us-ascii?Q?Q6KpOwfip+ZFY+nIa/Bnj4rnbnNunsMCX6xEZWzGMPUtkC2CnrGZZMPDDl7Q?=
 =?us-ascii?Q?u3SCq2GI154iLyuM4x6aqh6slO0iWZ9DO+gJ1cazLuZQ2iyFDlHCONhK04KF?=
 =?us-ascii?Q?xYjtmCQEe+QHqX3atUcETHpDq06QuIknDr0Q2rzr+/pf7gWlINJL5I4SOwC9?=
 =?us-ascii?Q?v+3IbX/IjIOSEdcWo9GgD5KLtynMDFQBKWH2xswSEC4PP7yGbsZCYW08x0Sy?=
 =?us-ascii?Q?ZF3NLjvwAMCsGsIfmcxxV6zhGLggd4bvER31Mlz1qbKzzL+e7MyyX82clEvI?=
 =?us-ascii?Q?a/J7F7mq1jxwxs/AsS9znqCDj/KGi72a0VivcMm2L3kSbdhY0xpVbPbAwYMd?=
 =?us-ascii?Q?VEZ4RUGFh2d8fm1kqCPj/688CUwdIW7eNnx7rkqjtlt5Elzq55YciaL1Wsbp?=
 =?us-ascii?Q?mur/sARzP0inOXNHlhyXTOIFU19B8dQBvAu77eSfYBOuQn9OCnzTVZSXyPrj?=
 =?us-ascii?Q?kV87gbnvl3XsVyiiUbc3eNr7VcR4rWUmBfPbbawP6bW4yyTKha5Du8bkUjxI?=
 =?us-ascii?Q?NFYVj1EmDym65MwAsDBtCiOrHIq8kotObfQ7clrtGhDqy9mfRnAJqKD0/+rr?=
 =?us-ascii?Q?PLPMmSj6H+W3iCWRDIzP58UGL0hQr2FdgfRV4HlbtzqOgPDfxgs3nZm2bnlg?=
 =?us-ascii?Q?sjnoehEdsNi+j6LRF7JxN2ObbdmLqOY0fgXDA1WpKSNzavxq6+fQ3KSiVmB3?=
 =?us-ascii?Q?ZIxBGM8UW9R+xSNELOzplly+W9Nzg/ThT6fkEkLcsYBNWHUoWq2/JWBh9c8f?=
 =?us-ascii?Q?JMdTkwzXvhzo/yFL34SPj4ojid6E9dJr3kbjBoLck8qiO9DgrETEzxdTUH1d?=
 =?us-ascii?Q?9uHoagUkxfPsK5GV+kUI3YwCh9MNnYgRk0bLfCPTsIzxUKPM3kHoioU37g5m?=
 =?us-ascii?Q?Ub+/1ToCc+nCc0dj4AftGsxGv681SxabduCOzzgMG/+loSKxAElBFNix6Xjf?=
 =?us-ascii?Q?HRyLSmNT+gwy/mlOrxsxhqJqJQsaYdv2gtagaaVd03VnZvMoUhEUFj0faRlt?=
 =?us-ascii?Q?GK8dSFMyn3VRCjZXuKilPq9nPDICV6iiFCaH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 07:45:34.3401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d130dd3-2218-4da5-5ce8-08ddc9bce84c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441

From: Alexei Lazar <alazar@nvidia.com>

When updating the PBMC register, we read its current value,
modify desired fields, then write it back.

The port_buffer_size field within PBMC is Read-Only (RO).
If this RO field contains a non-zero value when read,
attempting to write it back will cause the entire PBMC
register update to fail.

This commit ensures port_buffer_size is explicitly cleared
to zero after reading the PBMC register but before writing
back the modified value.
This allows updates to other fields in the PBMC register to succeed.

Fixes: 0696d60853d5 ("net/mlx5e: Receive buffer configuration")
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
index 8e25f4ef5ccc..5ae787656a7c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@ -331,6 +331,9 @@ static int port_set_buffer(struct mlx5e_priv *priv,
 	if (err)
 		goto out;
 
+	/* RO bits should be set to 0 on write */
+	MLX5_SET(pbmc_reg, in, port_buffer_size, 0);
+
 	err = mlx5e_port_set_pbmc(mdev, in);
 out:
 	kfree(in);
-- 
2.31.1


