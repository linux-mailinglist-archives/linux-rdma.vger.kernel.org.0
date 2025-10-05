Return-Path: <linux-rdma+bounces-13779-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B526BB94B0
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Oct 2025 10:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DFEE4E206D
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Oct 2025 08:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6115820296E;
	Sun,  5 Oct 2025 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n6wViu0u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848AF1FF7D7;
	Sun,  5 Oct 2025 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759653064; cv=fail; b=rYrWp6YiqYpp8xb3/8JxTcyaaalqDS500qIzICSsFLreaFYwYKhteXaJj2+AzgX1H9OiUqHd9XycGLtDbkooFWu5TfPlyR5DO/JGiNYGRuFCB2RUfzg/cD19edvckQcqvthK0ywckGkiRBsK3tVCSAmC9Ycmm56RcP9e4ZpjUfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759653064; c=relaxed/simple;
	bh=1d6p+bKpq7aowflts87+tIj6WAetsuZizKVzUP7jm+w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqqJ5vHuAMtehkCZkxGPRbEi/dJfFlJMz7H+2N8H1gkfk4JzgaYA1QKeMxnAHioMrazXYFg2fOmjDXij3rxZqzryx1bpxAJE+mGCLcEyUdKa+YUu/0QDx4UF/pI9izbKPWlz9Yi30fUy5zw4RxZ/f+2Wb+K4wkO5hjCOlYzoYT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n6wViu0u; arc=fail smtp.client-ip=40.107.209.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIq96jIMm3e1myAi2aq4AY0ih9yJuz53/t5AIotGQHTbrGDi+N8d0Jm8gTR+FAe6wVZgF/i2paa4wR6xut7sHZMxDlJum6MvOPvS3ZBCa7SkOBbw5dnpLVix9ku78DXSOJzPnyydVVzxtFkotfzeyYT+RAnlQsuWMZUJsWWPgV6Am0+RZ8K9LSu4+gVcU6P67ir16Abk+My7ykc5otfGh96re3iNBgtvQNfHpqWN6SOaJyEMNLWNXV51I59fBrNsx/ylmyHN5LZvXeJmVHlh6uZ1g2Sr9IqZRDQGYwX7R0CtJ01E+Rd4IkHZm8ZT2PruOAxJBbKjcavVN5gq97KKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOTivTVkUryA1hapXLUgHaR/2hzGmsKeYTbwh7ShYUA=;
 b=alBWDZCdt2UcFFUNJUC3+n8bEc7oc8CSIobU5LRYaePGcXgAUWU9AjWceTBnQBpvxsUz1cIhoIRiv7ih85eFi0kvQODlF8JeC2DAHdVs6nDkRcZdp7XRaL6soJyU6fNIC65smac5H585+XVcREyjn/GtAYnzhxYhg/26bUbx20uXdUsmaIG1z3llNrfKG6PIQabVOBG3uj2IURKbFM6ZPSbmx70y4SLVKlyzyNJXpYnANgF5YsxbGVmZZXGo0Ak3YSNSvYKzqIbzPBVPF7YDBAVZv1w/ZNdAsCPHcNHOBI283HCnswtmeEhX9ytdYPZAX3aGId+EZE3sJtMzg56w4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOTivTVkUryA1hapXLUgHaR/2hzGmsKeYTbwh7ShYUA=;
 b=n6wViu0u8rCfoslZXmOMJjXr/2Wx2dc2OtIaH60dIxk3pno5zOr67/RFCEMxReGKCNMFxHA+PGiFfJiAbR4Zwjh/6tE3EovJRugnUj3oQzYYtY4J2CssJRYNiZFPuK/MFPmFoR12gsTha7fYyfMFhe9f4po2djfo0RI/4HT3W0xfQYqOhH4KNr9xgjyztn/9DEkYTyIkrfCFG53maPEK7Efll0LipAqjo7LiNH/rDBgbhdDunJFDULmIkZ0SRcYb7cr3eNVEylAa6HqoAN3hZG5cSAqsgY5n6zpYFYcWTTb+Rd46jbVY/Y9EqHLu40vs48hCXb2YdCvakKJNOV0Yqw==
Received: from BN9PR03CA0284.namprd03.prod.outlook.com (2603:10b6:408:f5::19)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Sun, 5 Oct
 2025 08:30:53 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::2c) by BN9PR03CA0284.outlook.office365.com
 (2603:10b6:408:f5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Sun,
 5 Oct 2025 08:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Sun, 5 Oct 2025 08:30:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 5 Oct
 2025 01:30:30 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 5 Oct
 2025 01:30:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 5 Oct
 2025 01:30:26 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: [PATCH net 3/3] net/mlx5e: Do not fail PSP init on missing caps
Date: Sun, 5 Oct 2025 11:29:59 +0300
Message-ID: <1759652999-858513-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1759652999-858513-1-git-send-email-tariqt@nvidia.com>
References: <1759652999-858513-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|PH7PR12MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: d61a6d9a-011e-4aea-6382-08de03e97f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3r7Na+YYKGQePhyktuWs1TLe4HJcQEKCZE1gw9dVYxxpqI7rzbt8UEiFS6Ho?=
 =?us-ascii?Q?w9qj7uVVFkdVaAf1+uGpy2K0mS9QUxk9mm9DW1ngdNTwCQJu7QMBauzsrRt0?=
 =?us-ascii?Q?G2ghhMp4tNYr4brxPZiNwtMdZY/fG76JPVeJ2oIgNJpHwbC+AbeF9nAhsXcZ?=
 =?us-ascii?Q?zvlA4DcW/rKbKLI8omjQIEfM8KAbGFhNeASONDUYgvvKqzBpFPZWTisSB+cq?=
 =?us-ascii?Q?3EyukYTEWPU9Ys0Qr5va2zUsspOFyUwwlaymS1lNwTICcFGFfiUAkk+GpCBh?=
 =?us-ascii?Q?yxRBru4kaJYoUVeU0OuOy29PivX8PFmNIy0i3dGKF0p6AWWWmhKSeJ3kpQ2W?=
 =?us-ascii?Q?7YUjIIFCCzIBrwfLr3PeH+T14agxVO5tRC1bNXgu4oDKXvXFtkaIYbL1UHeX?=
 =?us-ascii?Q?SfhHc87Js8alybUPc26Aq6zIqskCOW5e/ROvDUlBnedU1/ZzdKg3QGzbCDK3?=
 =?us-ascii?Q?ZJi9134c3gBbH/8JeNMraJAJhN1abFPfH4rC7RjhZ3gCKWZ4tykyaARVN5BX?=
 =?us-ascii?Q?Q/kHNuJv6uKMmLZPoDpVWmY9+YL+lUrrBKeASts+kzDILyeFPXvXndgelofQ?=
 =?us-ascii?Q?/MJY8P3G+ks9t65mn48FI04rn7qLaECcRX/8QraeOuRc6EPQ3RTCEKeGazmM?=
 =?us-ascii?Q?cWzULwP++ArvB/E3LiaPipC2udyrIJ/TdoCALXTCU2ParOHAiE2cjrieetrY?=
 =?us-ascii?Q?o5R6jCB0ICTWHg1HldrtwpQtFR0WVeGDoociCnervu91AtDunVq5Gfkey5iv?=
 =?us-ascii?Q?UkvfD3Oel5PLYuZTOvhBFowFU2YEZjJ1kC+aGBVJ/22X0wxnDqbtKohAp2Ix?=
 =?us-ascii?Q?O87/4fmhOC3ki2I6wLud1KXJkrXseX09ydcdvnQW9BG/WvISoOfcEzDzWDzI?=
 =?us-ascii?Q?iUNzy5WXH3k1sFSTdngAXI58Gyvks/wI8RGcbTKVkCxiKsYsrI67ZB433ibb?=
 =?us-ascii?Q?+fF/EmPQufc9K1A4Ce+UiETm6rsXuxsXagpQVmIiqyCVEPd+UtdI9i/BtZZo?=
 =?us-ascii?Q?yiRWXXzO/lI9KDNgRVI8PSK5ViXBYqSG+B5pLinY1arDfdq4PE1ezOow7NVC?=
 =?us-ascii?Q?xqb43nQhl47xRfCVYbnN34sMaPhVjmVky/7LUA02zGqzVDxaYoktuPH8wYCP?=
 =?us-ascii?Q?0fkPq0h+7gqzWSReuM37KSnBVqQiv5LQTTY5OlbNNuKVS5LYLyc70mZCXuz0?=
 =?us-ascii?Q?6h7wh9WPDysCZc1Bsbvoc7ybnNB/od8ktNDCq2VMzNYDJcbzeDVxuDJqDBq/?=
 =?us-ascii?Q?8qkYHqdlsA47YbZxpEaeEyH9zFTsRftwQdKRcH8An7KN4dMV+CLCzkYrco49?=
 =?us-ascii?Q?lODl5l7DPkIZyEM4o+sGuuHma5amgzIdKtWg+XrK2WOZysabC43lylRb8BZE?=
 =?us-ascii?Q?lFjrfqmSzzibwNyBSU0+HnLlIwHGla8aUpelMJadl8QFEIAww9Zj9/atEtzU?=
 =?us-ascii?Q?uQTLE1qCKPVQIw93HLnV8eJTwAw1P80M954298PkPzMwuurbqsmGdd7mzzRn?=
 =?us-ascii?Q?uP6QKlY0jiOciXQJk9376GTzR/KHlExA55SnWkvf1Scn1YFvD2/qtNe1Jsiu?=
 =?us-ascii?Q?UzENEWLYby1mOPh+RE8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2025 08:30:52.7888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d61a6d9a-011e-4aea-6382-08de03e97f36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585

From: Cosmin Ratiu <cratiu@nvidia.com>

PSP support requires a set of cap bits to be set, otherwise an init
error is logged.

But logging an error when PSP cannot be initialized is too much, and not
in line with other features. If a feature cannot be initialized because
it is not supported, that's not an error. An error should only be
printed when the feature cannot be initialized because of an actual
error.

Fixes: 89ee2d92f66c ("net/mlx5e: Support PSP offload functionality")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index b4cb131c5f81..8565cfe8d7dc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -893,27 +893,27 @@ int mlx5e_psp_init(struct mlx5e_priv *priv)
 
 	if (!mlx5_is_psp_device(mdev)) {
 		mlx5_core_dbg(mdev, "PSP offload not supported\n");
-		return -EOPNOTSUPP;
+		return 0;
 	}
 
 	if (!MLX5_CAP_ETH(mdev, swp)) {
 		mlx5_core_dbg(mdev, "SWP not supported\n");
-		return -EOPNOTSUPP;
+		return 0;
 	}
 
 	if (!MLX5_CAP_ETH(mdev, swp_csum)) {
 		mlx5_core_dbg(mdev, "SWP checksum not supported\n");
-		return -EOPNOTSUPP;
+		return 0;
 	}
 
 	if (!MLX5_CAP_ETH(mdev, swp_csum_l4_partial)) {
 		mlx5_core_dbg(mdev, "SWP L4 partial checksum not supported\n");
-		return -EOPNOTSUPP;
+		return 0;
 	}
 
 	if (!MLX5_CAP_ETH(mdev, swp_lso)) {
 		mlx5_core_dbg(mdev, "PSP LSO not supported\n");
-		return -EOPNOTSUPP;
+		return 0;
 	}
 
 	psp = kzalloc(sizeof(*psp), GFP_KERNEL);
-- 
2.31.1


