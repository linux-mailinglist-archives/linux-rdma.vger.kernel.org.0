Return-Path: <linux-rdma+bounces-14332-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F7CC43AD1
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 10:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F3E188B3D3
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 09:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E106B2D63E8;
	Sun,  9 Nov 2025 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DHa7D9xk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFFC2D46A9;
	Sun,  9 Nov 2025 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762681143; cv=fail; b=LD7FyK1B6sRjrCsgxR6kLSjvLOXX2PEYbG3Wq81OEnAVWlFl1v2F3a5A8gV9r/M45D2WMtzCb2hDYy8mtbWw+Z2hKmTlbTKK57ih1oORFNb7kJAIjJfiAfFWrIqTnnUefIdfXEhHjFp1Wx0ZajAsxI3FG3BI2G7Odk2IZEuHAxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762681143; c=relaxed/simple;
	bh=KKh2cEkP56vqvEkluLx2S1e5G0fnej4SzrtpbEu2qdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBx/QWZEJ+2qF5zAXms/4m87YUWBOdo4+RZeUbb3KHPwsBHNBiwGJWJRuEzuxRUEmashRH9A4Jd9dV8pWNH7dHaB8CxTdfaazWUjPc6Sso7yrqwPTbV/Q5P9y8irXRKFZcatRYHzM03v5Ocpw3ycQsmIupzQfYOM4ELug8+5E+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DHa7D9xk; arc=fail smtp.client-ip=52.101.52.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFvJvJe81n97DnQ9aXO/+Mw/XeKY1pFRSyKXeDP1eQTihcCDLvx/0zQIIi7XJGkqdJRcWuHEWBMeUcwm1L0MPLciINTKb+/KS2p0IyL30SNMaYMok+cGP7R90k06a6n5vXHGbb/TZbKxpJGWpUWDHu9lRtefGTqBfXAeJnmFxcIASiluqMjt+LPw05QUyrOX2YbKU93u7S0FeWQ3QvzG9aNCVDNYDxJuE+PV0ZjJXmEDojP3wE373RUpDkZKFgEEEX4eFFDZz4L5CpQcUOzKin3NxSfaTn3BALxbZTlE6tVxQ+1ACwC1QOLGpK8KeHKeEQ//OVz4DjoekEFWavlIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1u4f8vahpPDZYACXYsO6wxWBI3aODBKx1RvjaapLp4=;
 b=cTxtgvn2FesNBM2e0S8ABUema67CJX3+kLOvdwB/viRSLLUDViVQx/Ux0T3CHWD2EAkAU9168zmbPE3Hx7KAbxz4XIDiYYWilmV9p7ZlVq91rwKWb6ai6smkkBtrDL1eYMxl4LMV06OvPCqX4Fs5QL8553RBhgyq38c5pcs31XysBsSYOHXL+dZlBSC30pyRdZjmfGrKQES6WHIMteaeI5Kf7rPi8vyojtlItFhd+vLgNG00sRFTzjuZVcQXthJHZSQl0fmI4AD260a5RrWvNVvh/7R0duP6Cff+gFMQUYpGLnn9KB9E9vL0r3MsuMUo+bGv0kwtRyxXmdC5a4DBYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1u4f8vahpPDZYACXYsO6wxWBI3aODBKx1RvjaapLp4=;
 b=DHa7D9xkZUbuXCZscohAOMD6kLhM8Yx/ZfFWrDcw3HpchH0B2wnXtlv9IzBUHqm25LOLOkl/PN9mmsUDqET7a7XmslE8jbEYgKyb2NHkpxHZ1JV3qpETLDeOidXcDKzqeWNzhkQadhzjApP+c4W5ob+O/upF0ypn6I7NB6e8urPzUhnw5G9OocCMsMYIwLiQa0nVAbGTKm1XYd7gOuNloHxZLVTzZjWiVBSgFCEHf0QbFsj7up+7ZsXe5mRVmgNuHEMmwxxZEt97xkSy6NlbBe1Qk2xMfF1vVsETL5eLvgnOfolSV+Zk1a6CfM94pVJD8a3Rpc2LXPGTix+ueOocxw==
Received: from DM6PR11CA0006.namprd11.prod.outlook.com (2603:10b6:5:190::19)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Sun, 9 Nov
 2025 09:38:57 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:190:cafe::19) by DM6PR11CA0006.outlook.office365.com
 (2603:10b6:5:190::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Sun,
 9 Nov 2025 09:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Sun, 9 Nov 2025 09:38:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 01:38:51 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 01:38:50 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 9 Nov
 2025 01:38:46 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>
Subject: [PATCH net 1/5] net/mlx5e: Fix missing error assignment in mlx5e_xfrm_add_state()
Date: Sun, 9 Nov 2025 11:37:49 +0200
Message-ID: <1762681073-1084058-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1762681073-1084058-1-git-send-email-tariqt@nvidia.com>
References: <1762681073-1084058-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d062675-a316-4664-d9bd-08de1f73ce2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RdlcLQHdn3Ej4mr+PpfSKD483NqpL4sfcdd/kk8rK17GHXqM/fJb9XNZDp1v?=
 =?us-ascii?Q?wuKEkXOaB+BmRYC7/pDy4J09axXSE4rDItJDB1vNpsZjuKdSqXCj8bLKh0hw?=
 =?us-ascii?Q?OGMc9SIxt/kzZ+6kaNRRphTqeDp1+weCri1muIBLW+Xlt1XIepkmZvocJwBW?=
 =?us-ascii?Q?m/dSvZvrfT2/b30lnCsqqtCpI2/D2iAuteCdjsy5ZEtebM/cV+c6MpfHHrcl?=
 =?us-ascii?Q?Hv+dOgEVB0tMcZI8W3013GmYKz9a7tyhnNtgozohYjltQIvWtjJw8V8SM//C?=
 =?us-ascii?Q?4OiAVixzxMF7EASzrFKGDbWBX+dNMUXh7yBvIsXD8SjeXEXI4y8Nc+/s5dyY?=
 =?us-ascii?Q?iwm6tZsog7rdtM6alR2Mo0NDRuLoxIPOUcNbtTlh9PeKtSsRFP/hu18eBwe1?=
 =?us-ascii?Q?jqEqhT0pE+Mdpvpwo0GLa33mgkDavcM728xjHZ9mEGI0kFkeIgb3J4QrMMm6?=
 =?us-ascii?Q?rB2bb3Rgz2RYA+OQfkR7y4+9uxrTQaWQ7jGP9AhIKz1uZzxaa0gFIYhz40vc?=
 =?us-ascii?Q?VkFvWy0OfzoLaO02EWMUH917IkZtG/7ptUSycj8lvIkT0vRcN0znON+CcYyi?=
 =?us-ascii?Q?4XKWVplAM2C5ImipKwxTbj8y3Ad1gxJw+keFJOwCIfRmlEdSd3i4DtRFiB9K?=
 =?us-ascii?Q?ifA3wVxSkF/3nAeUZBWkRW16DrzBXxUwJumxTqPTNd44Yg4k6vslRh1iDZ0g?=
 =?us-ascii?Q?eRvi9SDKLJQe6u2gEpF8QKRqAM4e6lP+bGgPK8Zj7GA+0FflzkpmawPXBZe9?=
 =?us-ascii?Q?ruU7KpOfLDnQCWpmZX6KPoHMwwzu4WvAY04xiSaOOommF3Tbi6fXN+iIEyZk?=
 =?us-ascii?Q?jKdoNlL4FNH9+ZmXRCYOuYxzCYO0VMOMFxa+jhG2SuKBJNwrvmx9VCm4EkVD?=
 =?us-ascii?Q?biRIHM3t2BWccxH6Tj3ygl46ojJF+sUvymIdSt/2uo/gf8Gjg7W5/V3ShsfC?=
 =?us-ascii?Q?+uPjZkOLr3vWrCbyJ/E4nHhH6GZrpimbYdRQwgFoaT32/xoSyNB5eJZ78w3Q?=
 =?us-ascii?Q?GIYae+JvJ2vhsUJyjRqsYbX61lZu9yEPE49CFE9zN66THhF0VczIxdXO2Mxt?=
 =?us-ascii?Q?pDrxlQ6fcYVjyybDd6Yb8TzO+4JNEnUNKLIJexmB1VR9j+aR76EbwyxCHoPQ?=
 =?us-ascii?Q?KNifEc4cDa4ZXzyq0iP72z3aNM4HBY+T9BQdii9ofQ5MxhDMyeVb9CFy9M6M?=
 =?us-ascii?Q?9q0yuiPDAcgT7P39ni064NQHpB11DfrRvoi3n2CjsZWXSWOQe/iUMczXNK3A?=
 =?us-ascii?Q?GhBIGOZX48pNKUeHQe9ATYpbxooPOCXD8oOh0IIbcXa9Kos05L9kWuhRHQea?=
 =?us-ascii?Q?4lf+31DEUdTMYn2DhaPK6mRAJsqFcoCzLPlKDvWvWwjThxf1T3BzragnEHKy?=
 =?us-ascii?Q?MQ1TZ9NvLQXqU+yHptolgtf2jS1L/OqN+BH/vRb6hnv4pykde+WR8YoZBvQU?=
 =?us-ascii?Q?Ny8uFaqnaehifgMqpdxtbeXzJDGiAAxPeYJU1YUbbXcyHNoSuFgIj6AKDZC1?=
 =?us-ascii?Q?KbzzosuyL78Lyuwp2W5yDWVffxZT0p2FXtMkfvSbS8qMrH2/NqrYddUfsO9q?=
 =?us-ascii?Q?eAenZXe+Yw4GFgWXSIL92nF4QYlovM2cyNGL+22w?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 09:38:57.2416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d062675-a316-4664-d9bd-08de1f73ce2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166

From: Carolina Jubran <cjubran@nvidia.com>

Assign the return value of mlx5_eswitch_block_mode() to 'err' before
checking it to avoid returning an uninitialized error code.

Fixes: 22239eb258bc ("net/mlx5e: Prevent tunnel reformat when tunnel mode not allowed")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202510271649.uwsIxD6O-lkp@intel.com/
Closes: http://lore.kernel.org/linux-rdma/aPIEK4rLB586FdDt@stanley.mountain/
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 0a4fb8c92268..35d9530037a6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -804,7 +804,8 @@ static int mlx5e_xfrm_add_state(struct net_device *dev,
 		goto err_xfrm;
 	}
 
-	if (mlx5_eswitch_block_mode(priv->mdev))
+	err = mlx5_eswitch_block_mode(priv->mdev);
+	if (err)
 		goto unblock_ipsec;
 
 	if (x->props.mode == XFRM_MODE_TUNNEL &&
-- 
2.31.1


