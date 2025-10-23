Return-Path: <linux-rdma+bounces-14000-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A01BFF673
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 08:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E415500B0D
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 06:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA2C285CB8;
	Thu, 23 Oct 2025 06:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uPp0W80r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185D02D63F8;
	Thu, 23 Oct 2025 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201940; cv=fail; b=RlbqOmg3HhmRaya5o+3MEu2sCxaawTC+5wUH1K39HAKDOh7fQB/IQ48E9YsZ1vhq1e/4J8P3EXxcXhv3AmLjNWT+na5eXPt9TmQRvwWgALN7FJZsMuTgrZIHNyAogxKFrHOJ27sPBHWCo0F20O8/FrGxpANcYIRJNsPI7dCsx9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201940; c=relaxed/simple;
	bh=dabtuQVcQNCLyIkOwRCOEkoOwOI5CAyxA2+qkhA/MVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emBlUkAvFV204WjjNMnLMYuixNhW/IzCRks+3D0a3geDPpEnyb8BxfSqTOjS1FTmYIsloS9esywCVs4n1dHW3z8LMDxOskBWtvCXaSTHvp8LVWoPAIdPU0+tCSkfl7SWNl46Z3Y7zlcq4BhBwxnmNpOd0MN6+tfrRKaMc08mIjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uPp0W80r; arc=fail smtp.client-ip=52.101.85.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmWt19mDA5dUCoynrwaKSKvxV63k/R/RCH9TRmfTylMGi804g2cQjxaa+jGPheQ3oBKCy+wr3vlfFh3BrQ6TwTG4HWl5xhiowm7QNcFkZ892xV5JOCEwdwlL13vlawFcwr9PcPOfSqcokB5nRx2aURbML0TXtCU/FSJB7W8jG/9g4fHjDf1JrrPq5HoAqv3UxHOPGB4WuW+rV0JYQ2VuMueSjzH8Qc04A2w8v1UvndDVtPV6wHieml7lTcHgh9kEbYjG2xGq/p2cY1NE24nrIIRQbk/8eqedH7Wytc58+ONG2FEd96XWqSudjVS4f1Z5kzlmcULUEE8w5rcdNaifBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Kgwn28g2gS02bNmgmSinUw7Ka6Hi6Ym5ItA1egQ7Ug=;
 b=jYAuL/MeI6VTYy96H6/ZadzhAV/q84XpDEiFRVCRGuQNAF2Pq3ViUxJdxJT+wfsdjgQD/G7+AW3DTWxkgoOlxwSwBIaLAdv1F45PkjcGtUh7UP+/1tS3dDYWxi+m363n/Ii+JV5I2THMk4305x5tk9ZPUuREOLVrtQFdOQDOQXc4DjB/MimQCyL/COpdsVlwcemH5qp/m5wgZvGUFOfZdc9IJQQkw9EwAfMgvhXqXyrkf+S0jTzlq9JpBzWSGOWBBMU6gQ9gVVc3u0NCi9V8hPbrM3cTx2ZqqUNEk68XCfagXpWtYAZHYRkxwx8gn+lKSUK+mMjdXHB91ifdX4EFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Kgwn28g2gS02bNmgmSinUw7Ka6Hi6Ym5ItA1egQ7Ug=;
 b=uPp0W80r8L2kV0Q0xzj8GCUA+ccZ9C2s4WHr7saJGJSp/O/7Pw/P/E/3Z8QFyuK0i8wqOoT+Bj7Cp0jF/dpwa32k3TDRrxwGnAIRE+Gyau1KyBiJt3mX7cRhNcMmxBmfB/gDk4Nm+owLOKhAQDSVldozXWkT5waUse3o0HJpO72zN3tOaLPKjeHmgPrA7xj7OgI8SVyU9YQo1NZLRoR9Ak1T1Bjtwwa/UBL7EX9iJ3+VHvYU+Qhw5eHLKDmSHslq1lxwdeTPlCBNrtvi6FAK6XIbWMt3NQaQRbPRvg/gM6vyM8vCW8KtouNvIxbTnmy3rjwY4N/5w1978ovoXu09Ew==
Received: from CH0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:610:76::7)
 by CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 06:45:35 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::cf) by CH0PR04CA0002.outlook.office365.com
 (2603:10b6:610:76::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 06:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 06:45:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 22 Oct
 2025 23:45:21 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 23:45:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 22
 Oct 2025 23:45:17 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 7/7] net/mlx5e: Defer channels closure to reduce interface down time
Date: Thu, 23 Oct 2025 09:43:40 +0300
Message-ID: <1761201820-923638-8-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|CH3PR12MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e7d301-7073-4ff3-b79c-08de11ffc4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PLBTUHS48P/u+JOUj92YNki0NEnE9SXOu5/vZYtndvqoWrsIUh6aomqNxXUC?=
 =?us-ascii?Q?0Gb5gd8+I4UWYcDPnRZvJhg6IUos5vGt7llGaVWaEjBkT+/IA6EirmuhMHpm?=
 =?us-ascii?Q?ERpmWI3Fl4HMkSIIq+sRIRKWWoYHrlULbMX3NJ9w+/CeIwQsdwc+ByX18yTY?=
 =?us-ascii?Q?6YXg5SX5DwAaU12ZXOYk0y7oj7yzfnB0ADsBo8G5DTDKukXu24WwShwkWyQX?=
 =?us-ascii?Q?17T0f6Bptm55LMQXCmVe2wBKghh0cH23BZTfYNiFi1uUBEHxw1Ra3TAt2iG/?=
 =?us-ascii?Q?OmWVReUU2yC/OliavWzc0dKBGXmK1u3vLX1BL0SRcQ2hGCTjopD23Simr7/0?=
 =?us-ascii?Q?7iwlVq+IMWYG70PqZ1EP9HaRRqBErgDG03IGA4TI4CVTBVGxe3G448pvda/I?=
 =?us-ascii?Q?+noZPqmV/lsSUiAp4J1RSam8Tc7JFXPzRmHNv2ZP4e+rpr6maBjNB5NRZJtS?=
 =?us-ascii?Q?Ehe/zOed9672eSI4VQF/buXUDkyAFojamAdkQ8/REjvqOt7RiIyWi+iODgG1?=
 =?us-ascii?Q?bCWTFbmAJoV4tPGMAemfpKTwSWjQF4FhG45H2saJ6Iq5OO56pR8bb8ecP9zX?=
 =?us-ascii?Q?GnWTquBa4FSsxrDqPEaYkDDSDPe8TIF99sGLPfQfU1UBf2C4ORA+2OGejhGQ?=
 =?us-ascii?Q?S6oeRr3FWwckuTaVSfpQiCxHcJTW8nBbcDrLSvTsKwsJytLmax4S+tgkNzw6?=
 =?us-ascii?Q?+jtQhFF2MY6c+l25/La7aW1x4EOP2tblbDvrRWAbFPZ5oOEHVxrKTCbt6mnt?=
 =?us-ascii?Q?AeR8p0NxiVOO6L5ezBN8VtPouKzL0b+mEpkoB8Yo/ECqOCL3vxkWVC5ZR+Jr?=
 =?us-ascii?Q?hwsYZRE5Ji+P5Mu7Y4UtuLCLGWm7Sjw3OKEDsKrIkUyLxHu0ZohX6RpnnMbM?=
 =?us-ascii?Q?RNl/Wm82GrBeRv8wMAGEvSsxrB9dEUo6ExXrFxXurUKlyJpFrfPM2t3lLphV?=
 =?us-ascii?Q?EErpeCT1ejqIzollUodG5HAbiF4ySKwZ3/ashD1Cb8FmvtnII57Flnw7OOwC?=
 =?us-ascii?Q?QskSXsnbrcRLuCdorud1xw97Im2fepmw2qmaH8h+n0M37NjVcgMNPq++HTl0?=
 =?us-ascii?Q?SeemugsNBC41kF2+7eUJYaKvpyejHIJ05oWxDdcL47M81TUsEBk8Pk3rZQeg?=
 =?us-ascii?Q?q+uJUTv7sXDGeqNmwgAsav5sWk9q0YOH05+Mt0taGgHZMum8krN6khji7MA+?=
 =?us-ascii?Q?DvIu0BJhc1kjNjbRrVhb362Pv0aukCcpHF4OlUw4gLxAO78UD3C8C0XNc7jq?=
 =?us-ascii?Q?bmYcga7evifPZ2AHy3qeEnB2YglrX+ahZOrm4Re4ksCCbBkTR2Cphdq1RAcQ?=
 =?us-ascii?Q?2azKtPLXyB0X/j8tcRoQGI91Ng8sX4cG2S16rYMmqIWEoJfvrgShv9gm/NBH?=
 =?us-ascii?Q?dtutpWhQ7PE6D+rGP2RId+IvjdU6sJE0zYohwuxhH4Rp4S+VNSxCqGdXcEYe?=
 =?us-ascii?Q?nNLTJynZxHVlbDI+NHq9cr+Vru7Ts6if+k8lGFxXs88+YHuql3ae6ZKbn0f5?=
 =?us-ascii?Q?aFh20miCcA5ePDUlBpcsiL7nyGdBIIHfWrpI+0zASDQ8e0W6WlBBUUF0+jhl?=
 =?us-ascii?Q?yIAw0CfWgMX+0qHlrfE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 06:45:35.0562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e7d301-7073-4ff3-b79c-08de11ffc4f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879

Cap bit tis_tir_td_order=1 indicates that an old firmware requirement /
limitation no longer exists. When unset, the latency of several firmware
commands significantly increases with the presence of high number of
co-existing channels (both old and new sets). Hence, we used to close
unneeded old channels before invoking those firmware commands.

Today, on capable devices, this is no longer the case. Minimize the
interface down time by deferring the old channels closure, after the
activation of the new ones.

Perf numbers:
Measured the number of dropped packets in a simple ping flood test,
during a configuration change operation, that switches the number of
channels from 247 to 248.

Before: 71 packets lost
After:  15 packets lost, ~80% saving.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index cd2842dcffcd..a4c2c78660b0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3383,7 +3383,8 @@ static int mlx5e_switch_priv_channels(struct mlx5e_priv *priv,
 		}
 	}
 
-	mlx5e_close_channels(old_chs);
+	if (!MLX5_CAP_GEN(priv->mdev, tis_tir_td_order))
+		mlx5e_close_channels(old_chs);
 	priv->profile->update_rx(priv);
 
 	mlx5e_selq_apply(&priv->selq);
@@ -3431,6 +3432,9 @@ int mlx5e_safe_switch_params(struct mlx5e_priv *priv,
 	if (err)
 		goto err_close;
 
+	if (MLX5_CAP_GEN(priv->mdev, tis_tir_td_order))
+		mlx5e_close_channels(old_chs);
+
 	kfree(new_chs);
 	kfree(old_chs);
 	return 0;
-- 
2.31.1


