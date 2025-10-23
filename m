Return-Path: <linux-rdma+bounces-13999-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB95CBFF66D
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 08:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8C0E4FB85D
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 06:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8922D5936;
	Thu, 23 Oct 2025 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fc3sD3jL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24AC279DC9;
	Thu, 23 Oct 2025 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201938; cv=fail; b=VDHuEbMWoK+2EO3mytjNu94NtTB79F47ULuemM8Xeas4rT80lXxHLAwtPYXkR4n8qx2+VK2/44pb1sdikaCJJ9HhbiY43JeL3AOsVhYYpa9xqeYHJzWyuRH3xHpI1yjrpTojZO5Apn1wH610Q6SzToCxTNspA4tWGTFpWlDDnvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201938; c=relaxed/simple;
	bh=7pBuq/T2bDIwA3VHu7djf/2Xj3/hmnHh0yxd5TYfwAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfwMXiNO4X4lcMtQG/cHThP96SdUDsmlT54HWNeK1yD79D2TyStHMAaisankcfQzzhEJjyFKqERYn+3qPIcuecuUs1sec3KhYzUCgYG+Gd8tY4yS7sia3/wE1wVDCIJMqd82geVh8E8d/TiNc8uhC6Syc7J+FYYwj2n19legv9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fc3sD3jL; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nz4hl9gvs9uge5s0GswoH7XhoZP3OJ00lIPgSMK9MvtphSfoc8d41XLxlSNGVVT9BwSTLMNbIZb6b4rAn58NF6PirhXTg8E6nkMS6hIuLCsHiG3g17THVje8wqmCLHg15A17WGmFnuHFdIDm0OV8x9z1RkO9PxPYcyYVt+wQb6CFHCuYOQ294iCzUhJ3ZiHyfuCxXxF7PGF3KX0y2LfklR8uUFw5/T19luiyghIkeizfdpPoJz5dvoepAAGfyUXnuRAYFv48UlKfGjpomgZUySmZOETuaiEAyw85uFS2eph1Gre9WWBe2+4+Qk0JTjtHtHP3y8TBuBcxbdOZzLvsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sl0mDsdQSj75LPR3Hi01Zmcf10j+vGeqO8WXSes0ejs=;
 b=gYUZ4k0QqfNrsO2J+RuPulv0/8lV0ghrq1foMg+07M2QGLTMQbl0G3a4lDZI6CXRz8StBiWy8VyflwF2eQdk70OlF1tn+ihXrVASjjKLlEAVuWLuJml1Yfrry3uThh5dD8oMfgIZ9FW6TnVmgy+kV7T5HSwq/qpZQS7bqoLrx/lgTo7aOy5qoAfSfyyEC+8QXBXinOhKY2vYX+AnnfEV0bwELF2kc4AdfVzD4/5aGlOfX3PnwcQ7Df0Wq9Kqylz5FJXZ89zQy2/57L6LhkpShIHtrF9CgP8r0tlQbJ6sorSQ61b8WXTAFWEoao+2Nu7sjV0A2ffHkrDCeuSLfyiqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sl0mDsdQSj75LPR3Hi01Zmcf10j+vGeqO8WXSes0ejs=;
 b=Fc3sD3jLMHdEs9oSNP6BKLZPrqZa3oso7/mRq9ZHUvIszmegNY66chdrb+POVuIlpsy+8Mfa3F8vjsoFdDi1N3+N75VezpDZnlWKg6R58sgZkj4tK6CT69T4Grt4b3Cg2lRmGr8AwYyzcQaRlivyuU28W7aVYBMbaBAqoXldye0uAidbd4kFPHkE0kK1pbxqexZKZUiZFnBGcWN1Ixv4rumUd3KOhTwvirDUU/HiqOS81BKQ1YnaYm7gjIMomDWtcJlPF2meArIPOPVxqm6zyf0WZyveGsC4CPuDHTERadbGsyiEXvLNUfLQsu4UD2Z6qgbCZ62uvH0W8NFRC1jm8w==
Received: from CH0PR03CA0043.namprd03.prod.outlook.com (2603:10b6:610:b3::18)
 by SN7PR12MB8057.namprd12.prod.outlook.com (2603:10b6:806:34a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Thu, 23 Oct
 2025 06:45:30 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::ec) by CH0PR03CA0043.outlook.office365.com
 (2603:10b6:610:b3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 06:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 06:45:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 22 Oct
 2025 23:45:17 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 23:45:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 22
 Oct 2025 23:45:12 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 6/7] net/mlx5e: Pass old channels as argument to mlx5e_switch_priv_channels
Date: Thu, 23 Oct 2025 09:43:39 +0300
Message-ID: <1761201820-923638-7-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
References: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SN7PR12MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf86d95-b5ca-491b-5314-08de11ffc1f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DmXicekIXHW4ZqpLAZFMduPT4MouL4YQ4hr0A2xnvVIrpZQtnuWFiDPaEaL+?=
 =?us-ascii?Q?yLiOTI8k+Kt4mEtkBiqhu2hROUodvFLWCXRZ82cOjsh2y6K2yf5Gy+6Fs+qG?=
 =?us-ascii?Q?K2V3fHF6KB03h+DTAhwfDTQesBQofTGP2kF8YohKOUIubIKu0wKlheIabIoa?=
 =?us-ascii?Q?6LC5f5glL1dm80aXht3CVrpnGCMbiaakM5rdxAptdOlU4zEqYOT6CTQ3/Fwb?=
 =?us-ascii?Q?CDAlFpt7tyMFccj97v07NMrNdAjV6dxQbbNUFJpjLfGEkLu7mtk9qQMGJJJR?=
 =?us-ascii?Q?Cgf0sWCSYpoCiujKt9Q0Aw7kiFJv7V58biAUFCninuXN+bGhzKZS7qz06f1K?=
 =?us-ascii?Q?H5YZBQvpX5six13TBXN98S+wBTp3IKO+MQfte3Z1LsIXvm6XMN4LKgUwYRCl?=
 =?us-ascii?Q?SyIQERf0qV/Qyq+fjc5GalHMPkybSP2dyGcrU/Tj3waOKz5e7GIjjJ5eLtSb?=
 =?us-ascii?Q?WtrxaHofDlphKZc9wriaicF1dpl92SbLtQy6co+SnDNtBDlo0fr4k7wWp0cW?=
 =?us-ascii?Q?hmiduAKqx9hafCn4PM5yO1xAFglOa0Wt/Ua1z4gclCcR2fQnGAWgvQqLC9HW?=
 =?us-ascii?Q?sixNF7DnycaeXjNYjxfWYseE+ApY7lzvhpI4vJ+81/aXVanvmIdftWeBoxZb?=
 =?us-ascii?Q?bmu0mzOCtzDRYT3V5UtPdVktYBl7pYuEYg2uPKfhn6vb54zKPv1glP7sFTX5?=
 =?us-ascii?Q?FiT0V549Oxd2jFUBjAdnszTUZbjR9CG2qg19MNTYPSFtmd1v9B4u363wA+XV?=
 =?us-ascii?Q?MQlYPks2obNIV/bklIRNC5VBbNWztcOZTQvOM2MVz4UTXELlMhF0DmxLiHyf?=
 =?us-ascii?Q?hEAN9Fvr1oBAcVcyCL9T4gXRxgc0A6Dhfr6RPj0mIpxycccSo+YtDSem4LcX?=
 =?us-ascii?Q?j78jNANfG1YfYlzERCwW8eLWt23V8jajiWNd3EpvusxLX9QqpDR61ltrSVfm?=
 =?us-ascii?Q?pS6VwmXASl9ZG+dNPiRYr6TU0gPaPgwJvzdTK3a/IIl6IMLOx+9m8SHkLtVO?=
 =?us-ascii?Q?AeVXaorVv2JtBk+bKKp4/4axai8TrRuDjqtiRxA2mv1dpOCkaxNs3HdDsMAZ?=
 =?us-ascii?Q?spE6gDPWwDY5HMlFZDUtXPYD8nK2G9MBzBEVF30phXMAWvWCpZcfMEZK3FAF?=
 =?us-ascii?Q?dM2FWqruqEqRMN3ayGyevhAn9NDVLiARIFWCVw8Oo4N2HgBgO3pkZk26ufFL?=
 =?us-ascii?Q?yetnVMl++jjiQdYkIvZlo8uCnbakQpwaZ3DaOzgw6o6heqQ+PV7sAHXX9kLe?=
 =?us-ascii?Q?D/drwT0t32hz6qI4eRm3sLtjkT1dYnh4HK2erMbDRe02QddBusq8HZJ8EjLO?=
 =?us-ascii?Q?QUigWxcm/FpMiskK7F5o3KGJie9fgSaZgJa+sbe3SyG4F/KHSX6RFFJv8pgs?=
 =?us-ascii?Q?c1DZyL6M9qYRJqKWa6z13M8guzdYJcgdiX0p0auzIA2AL+r1RM1CPYmPcHer?=
 =?us-ascii?Q?vkGoKKFgWbQc7GaJB8NRKqQcGaw3iO4Xep7yIrFzOc4+uqoBHjc5Rv8+l3l2?=
 =?us-ascii?Q?CmQafH/PAdrUFB0W4u/f2Fp0wcm7dzC5LfNSRHhmnWzfXXRBiJxncp8r6DKE?=
 =?us-ascii?Q?UxGYR8CYk2r7x1BhyRc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 06:45:30.0285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf86d95-b5ca-491b-5314-08de11ffc1f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8057

Let the caller function mlx5e_safe_switch_params() maintain a copy
of the old channels, and pass it to mlx5e_switch_priv_channels().

This is in preparation for the next patch.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 8e13f2542d8d..cd2842dcffcd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3356,12 +3356,12 @@ static int mlx5e_switch_priv_params(struct mlx5e_priv *priv,
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
 
@@ -3370,7 +3370,6 @@ static int mlx5e_switch_priv_channels(struct mlx5e_priv *priv,
 
 	mlx5e_deactivate_priv_channels(priv);
 
-	old_chs = priv->channels;
 	priv->channels = *new_chs;
 
 	/* New channels are ready to roll, call the preactivate hook if needed
@@ -3379,12 +3378,12 @@ static int mlx5e_switch_priv_channels(struct mlx5e_priv *priv,
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
@@ -3403,16 +3402,20 @@ int mlx5e_safe_switch_params(struct mlx5e_priv *priv,
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
@@ -3421,11 +3424,15 @@ int mlx5e_safe_switch_params(struct mlx5e_priv *priv,
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
@@ -3433,7 +3440,9 @@ int mlx5e_safe_switch_params(struct mlx5e_priv *priv,
 
 err_cancel_selq:
 	mlx5e_selq_cancel(&priv->selq);
+err_free_chs:
 	kfree(new_chs);
+	kfree(old_chs);
 	return err;
 }
 
-- 
2.31.1


