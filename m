Return-Path: <linux-rdma+bounces-14148-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504FAC2045D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 14:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8377B422B59
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 13:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF28C246332;
	Thu, 30 Oct 2025 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VXfQw96M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269E42557A;
	Thu, 30 Oct 2025 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831248; cv=fail; b=bqxiNjgXtFyFBaCHc3EXYVahwgV7KgqJ7na0+SW1YJ4Jh1sWlRv6xG3kA0EfdJiY2Bsu26jjK1SQRBDJDXuak4wXMAae5fE/zW4ImCazy0WctJS8gzmxSTrPOBBfbFi24SaTzOixFs6VnIcSdYY+irx+uoJZWMe6b0SzpGNOiSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831248; c=relaxed/simple;
	bh=4kGoM6h/LCEVWJPY4LIE7IS6j/eAO2JkSsLrErf6Y6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3ULFIa1PtL00bKuF6Rp489q3UHqS3rCshM26h/yflj6j3JfBG5ZNGvvAfi3ftM65POmETPnLqfzShP2M2I0jBJeBWUETt5oWzaY1cMDXoCtHDRF1nEhC0mifD/P7y1IL9gxDovmR+4BEB8FqD5N19TbjE+Uou0Br22Bh+b6/rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VXfQw96M; arc=fail smtp.client-ip=40.93.196.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvnfIopL/Dx5HRbQFvWZJpL2GFjO+8bePzb0MORnZL1Hlf8OI6B3jY+1U25/MERKCMA0HyXosUuPIj5pWPRe3FWZFp3V4kqYSutKIpYm681ST0a2eOLtYhew6hDO9KRH9bj3J2neu9kwX/+rnm4/hiSjLqV0y0c1pLePsgIvfPiXX/6i+L3OB+Onx15h0BbK7V3vgFGBU1OO66mVXjam5KGXZn6Ktk/6I9Y8TmC1OvKm+x107dLw3yfP5D6GfAUlqQUn6HueefB6ZEiNDouEa2kPE9kvOA8iFjxogBjAN23LBTJKmGSWXNWDGYxGpizHxitKBMrYjLOicJq5KdE2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsvhX++rS+wqVoXibKKbp2OVYieZYLqFoF2g4vL95Uw=;
 b=TFdYid8tNzOxWeurwh/8HO+eoY13wOIi+FQ+xIatDAZUMXC1cvfBiZOiBhBj+3KYdJsP1jiHC95T94X8raWNy5f7pGW5NwSFv2npyHFvHkgvRCcQeuVubzYu2KnS9UNwSjKfG8rUVq6xytTkW/BZPe+xWpyvsqQylXNh5irKQ8TNA0Y3tvbElPFP6WFVRKDPXGDVQyjSgHmiHGFY6eSE0KGHP2fe7AnNRM9dETEvXwdAZYjUT+pY/gG/k478h96l3pM9ap80d+u8Mn3e5NHNN6wVrO44TdUdiuv/qBSK5lcnTplanj3bcJcqF7E2PgRX5OSLO9ADbz1q5Tf/TiLT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsvhX++rS+wqVoXibKKbp2OVYieZYLqFoF2g4vL95Uw=;
 b=VXfQw96MXeRW8jGIvx58b18KiauD7cgc2PCP3xxk/zq7UbZpAt5Hv/cqgfzRb0vjpOR1oQ/Z4WzC+x2CljROXlUzg8Q3iVbgtyxQR+tgb71YXYIDhW/khNCY6oROqmNQGntd92ySWVJw7TodVsnkQA3Av5ujcBq9M5n64rG6Hpc65X7fZgtD/hfot2GuUb7EvSXbLIk0fnWKzcynV64G6p90B5GTJtvLDdw3XWk8IqGhHwKTkrT8gdPQWLbJQIKc4dX7zfcuY1lF6Mjh+7vq9WTLAtvPP17E2gQJ/nVaIsm7AYYu0wk9JhyAoWV9cNwG635nJYRTKsSUgIYp6u4CbA==
Received: from DS7PR03CA0291.namprd03.prod.outlook.com (2603:10b6:5:3ad::26)
 by IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 13:34:02 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:3ad:cafe::74) by DS7PR03CA0291.outlook.office365.com
 (2603:10b6:5:3ad::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 13:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Thu, 30 Oct 2025 13:34:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 06:33:40 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 06:33:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Oct 2025 06:33:35 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 6/7] net/mlx5e: Pass old channels as argument to mlx5e_switch_priv_channels
Date: Thu, 30 Oct 2025 15:32:38 +0200
Message-ID: <1761831159-1013140-7-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
References: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|IA1PR12MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 60797f91-71ba-4efd-a0e7-08de17b8fce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0UV9hx3RFBQjP/logwOSk2MXYz9pK8z1RrK18bnY+uJzzXIatwHM6Id3kDww?=
 =?us-ascii?Q?l8f3dZGWQlk0bM/wqfmIowSZTKTVAzRiQgm6n60453Omc6CsVMQnvjD47TDc?=
 =?us-ascii?Q?D3Yp2KJtBGiEOxJF2yIEQ1YLb0278EnWYouqvWPGWRQkH4vdNME+B/UdsIZX?=
 =?us-ascii?Q?aTHMKRIkLNbrwZ8VCks/Ol9/+Mh3HiBQcLOLXC9a4WOFFwsLBjKCQuOXE6HE?=
 =?us-ascii?Q?wZM+V6CdKzX8Fgpj+4JqEMwMaQPRGTLQDhoiFdfQTH4l1yV182rJiU+SzWYa?=
 =?us-ascii?Q?tWjt6hEM7BzuBzYxiHhs2hRAZ7PKGSNVfLIJr9LgG+ogBCPIYrPSSMwMDr2u?=
 =?us-ascii?Q?urQDPgyBk9RzQZBwEtkjVEEy/Indtwqqazu8On6n4Hu1c06aG8AaNGmIlxH6?=
 =?us-ascii?Q?vIJV/N8cBWub68t6vDCF7qJkYsP37W+gR68JlFAkxweiWYv6rSXBIAmp2/SZ?=
 =?us-ascii?Q?qgMNkJQ1QOcQccq6QEZ21HkUio+qaREKoGtP7K19Kq6cxUyPaPRuLMnKst8N?=
 =?us-ascii?Q?3b6Py8CGmul843NAYf8ZxVA18nx8O1hV44Tf7bSqfD+SzuDegnbHSgQYLxeJ?=
 =?us-ascii?Q?HfxVGRu9Bu2mw02mCO1jGReG+4IzN2z+Wd8VJKpOsIqvae65j9tERAYujazP?=
 =?us-ascii?Q?Fknzfw6qHuVCshFKO5MeMH9ghT/e85aG+6VdJPBv1FgxMhjTdLU4rRyghNy7?=
 =?us-ascii?Q?+qcUSQs7iEXMWbOaOqWi7p6B9PM8sC/t/clSH1Hcc3vMT4W5OCUUjmDaKowy?=
 =?us-ascii?Q?qzTLV9tBE5wK5zUcR1bzpRDYLYupPBNXZnODWbcz69YTqP0aLixofZZ20E3J?=
 =?us-ascii?Q?5s99Ovr6OmKUwoYnWrQViRO6BSNPekIt7syaqZ2ydoE9ktbAyqsMQmNEvaPA?=
 =?us-ascii?Q?pbGek13e4c4Z7G4KjBHby8T3hzDcYeSFILwhMTwQnv27KS/O5ZI7z6WUIIHJ?=
 =?us-ascii?Q?ImFBazlxncws+PyyjeC8gz2FFt2wc/I2S+9/bz2BV9GrOMYSZ1QCTf2d2VA7?=
 =?us-ascii?Q?b7i1WOn48UJCdUHxj25Xv9l5kDJ6AptIU7e32Ku//9stan6eLIra/XXvAO/n?=
 =?us-ascii?Q?07RXf/zWBifNeEzwEWcgKp35hS1muqSBykdAHsx2c/Ex23GuznRc86uk2uPB?=
 =?us-ascii?Q?Na0SXUkb+MGrxaYpLYtT4TNsI5V3nRyLChnUTsyZa5T2bwH7zzncCpIfgLXq?=
 =?us-ascii?Q?h7q5R0jLalXhDxhu+kDk/JJ94lvbNlUfVbx9dA6Ip4daXAjmi6uGfmsTdqLc?=
 =?us-ascii?Q?uifofv1zxqTNIFnklf1hTGkFWbIWhbxX6oat7ns3W3OGGJdUMH5UX7Htzo/O?=
 =?us-ascii?Q?3b1+gwQc04wYHFBlWi3d5hwc8QCA93/xkoDA7eUWretUBiFvC5hECu7DWSGv?=
 =?us-ascii?Q?fcqMfBkkbMlwelnmKC5jKzTA/DuLM4cqGtZYtgQ3HFh+dMO1WzYFl3druOzV?=
 =?us-ascii?Q?rDCMjn1cJrB6n0wmYW0T//nwlygdJzdU+XpgRQAy58XDZQsWZIb7tWwL4TAg?=
 =?us-ascii?Q?TdjKKxYxYv53tfOnoDrg21MqMk/TqGn+sCf4UnCdPqNDwXdttyjZBw/bG9Jk?=
 =?us-ascii?Q?YdOsyDTogX48iICkQY8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:34:01.6191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60797f91-71ba-4efd-a0e7-08de17b8fce8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6163

Let the caller function mlx5e_safe_switch_params() maintain a copy
of the old channels, and pass it to mlx5e_switch_priv_channels().

This is in preparation for the next patch.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ad9835129383..4edf64e1572a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3357,12 +3357,12 @@ static int mlx5e_switch_priv_params(struct mlx5e_priv *priv,
 }
 
 static int mlx5e_switch_priv_channels(struct mlx5e_priv *priv,
+				      struct mlx5e_channels *old_chs,
 				      struct mlx5e_channels *new_chs,
 				      mlx5e_fp_preactivate preactivate,
 				      void *context)
 {
 	struct net_device *netdev = priv->netdev;
-	struct mlx5e_channels old_chs;
 	int carrier_ok;
 	int err = 0;
 
@@ -3371,7 +3371,6 @@ static int mlx5e_switch_priv_channels(struct mlx5e_priv *priv,
 
 	mlx5e_deactivate_priv_channels(priv);
 
-	old_chs = priv->channels;
 	priv->channels = *new_chs;
 
 	/* New channels are ready to roll, call the preactivate hook if needed
@@ -3380,12 +3379,12 @@ static int mlx5e_switch_priv_channels(struct mlx5e_priv *priv,
 	if (preactivate) {
 		err = preactivate(priv, context);
 		if (err) {
-			priv->channels = old_chs;
+			priv->channels = *old_chs;
 			goto out;
 		}
 	}
 
-	mlx5e_close_channels(&old_chs);
+	mlx5e_close_channels(old_chs);
 	priv->profile->update_rx(priv);
 
 	mlx5e_selq_apply(&priv->selq);
@@ -3404,16 +3403,20 @@ int mlx5e_safe_switch_params(struct mlx5e_priv *priv,
 			     mlx5e_fp_preactivate preactivate,
 			     void *context, bool reset)
 {
-	struct mlx5e_channels *new_chs;
+	struct mlx5e_channels *old_chs, *new_chs;
 	int err;
 
 	reset &= test_bit(MLX5E_STATE_OPENED, &priv->state);
 	if (!reset)
 		return mlx5e_switch_priv_params(priv, params, preactivate, context);
 
+	old_chs = kzalloc(sizeof(*old_chs), GFP_KERNEL);
 	new_chs = kzalloc(sizeof(*new_chs), GFP_KERNEL);
-	if (!new_chs)
-		return -ENOMEM;
+	if (!old_chs || !new_chs) {
+		err = -ENOMEM;
+		goto err_free_chs;
+	}
+
 	new_chs->params = *params;
 
 	mlx5e_selq_prepare_params(&priv->selq, &new_chs->params);
@@ -3422,11 +3425,15 @@ int mlx5e_safe_switch_params(struct mlx5e_priv *priv,
 	if (err)
 		goto err_cancel_selq;
 
-	err = mlx5e_switch_priv_channels(priv, new_chs, preactivate, context);
+	*old_chs = priv->channels;
+
+	err = mlx5e_switch_priv_channels(priv, old_chs, new_chs,
+					 preactivate, context);
 	if (err)
 		goto err_close;
 
 	kfree(new_chs);
+	kfree(old_chs);
 	return 0;
 
 err_close:
@@ -3434,7 +3441,9 @@ int mlx5e_safe_switch_params(struct mlx5e_priv *priv,
 
 err_cancel_selq:
 	mlx5e_selq_cancel(&priv->selq);
+err_free_chs:
 	kfree(new_chs);
+	kfree(old_chs);
 	return err;
 }
 
-- 
2.31.1


