Return-Path: <linux-rdma+bounces-12897-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC58B34460
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 16:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2A417F751
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB73301014;
	Mon, 25 Aug 2025 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="StAAw3mT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7882FCBEF;
	Mon, 25 Aug 2025 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132547; cv=fail; b=adwkw4m7TX7Qpbfe4DKah5YtMY//4maCMKqLc6yldg/aINa2S90N4+KfyyEOJez/+Qo7G33aV5PksOZwNVdhHfvgjvvujDt8H6+EfSuNqkHNejE/7Yf9yAmbO30T9XAzagVMcQfc/kIo2zFXcoAIq4O4pMhNehsAXRLxS72mAUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132547; c=relaxed/simple;
	bh=wG3F75iWSSdU6h8xSzGqEc0JVUoC45WBRCIwSqVa714=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NbN33xsQ5g/H/kCA5mrO/EYQPfVVOFv/9Xm7vRcyvKCxawvo4y2E+TT1ps7T8LiurxR1LbwBoFfyX2oZBY6zYjZULs3bcdtAf5ZjEHfAz0BKb1zNaqCbOeUlALWya9n8xJu1LSt/nKtJt34DHlydnldhkD1DYrvxKnrg7MwL/Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=StAAw3mT; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPyxXANu95zC6rNiPikrufVyjsPd8Ow5X0N/PBvpBx61ns45fbPvKpRy/i2YljoQWyPLMe2oSChahO5T7He7P/XflOW5VuOX7MMbfMuLbqIYuLInOOIFdhAOBMcAoBJhr4pgCMwXYVxDf5d2x8jYOm+GA5FOVVRCZaECMfX8LdaZ3kYcazoyvAhVCNaE3jxDpCXwOQ9FygiAKegiDpgP3fIIY/390sw57Tp3jtWNVP8hDfJKHPHtxTdXsw4KZUQkVVe0IRj2PMbBikA1Q4A+WLvaZyetGoG4uWf2CZupP5Az0d4eERl3K3EyKcQm8x4TAfU29dWV4y7D5gOD56k0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoaeTIlm5Hd4gDlAKTRUQB3kvcECjTJ7y8aAuzPSRRY=;
 b=KEo9Y2CE4QV4IhE23l12YRTVfD/A9X70EyGP0SVaDoGSN4rxjT/q405XOdjdId5jlqCeo7L61oEN7EgZ0KmElEqx5Ftkz7R2ZGqkYNL6InX/Aci2KmV1iVmVVbQmGda0FzdRuJ8jBxZrxTWS3TYij0GonWNYcmwMDKhq/g025npa273/OzE+PvIOJ3JmWnxzdrNFYZuO8DDHxwCeir62pP9za429U/sOHC2a7a51QhJGuR9QygEvggn6A0jyV0Rvw9lroZEwMsoBkXqyMEreEmu+MDTdd/R1wcynnyC58KqXmYQqyFPTmsjXkLFAkLQxUsT8eCke4YPfZ+6Pg3a0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoaeTIlm5Hd4gDlAKTRUQB3kvcECjTJ7y8aAuzPSRRY=;
 b=StAAw3mTW1bh+QUZMsqlJnymjBQxIAtMjdzM4OGAx7+UlGFCawg+vcRMqxmm8r2iveo+B3KuwHvoFHFMXAmcqU6BTJziBAUGClh+9vC7GGpT1V6IUsQfQr2lMMgr0jploMs4FxC0dzC58+mdv7fPWvuNBXyfJuBfwmhmmqrzmu7nUvrpESGtTnTMgF+MT0hXtTKz2BCuosBtMXvtdznH3Qjt95L5HymohhATJhWFkhFK86DUeqcZfKZi+Dllie4wKzF8fqyVQRi2XXjhoqBDIxkuRKxm7gI67KXyQoSgZj9eUROgQLL9uTFAVHp1OR78KOYEQiIrFAd3dNsCvXDJNg==
Received: from BN9PR03CA0160.namprd03.prod.outlook.com (2603:10b6:408:f4::15)
 by IA0PPF170E97DF1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Mon, 25 Aug
 2025 14:35:42 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::54) by BN9PR03CA0160.outlook.office365.com
 (2603:10b6:408:f4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 14:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 14:35:42 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 07:35:24 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 25 Aug 2025 07:35:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 25 Aug 2025 07:35:20 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net V2 08/11] net/mlx5: Prevent flow steering mode changes in switchdev mode
Date: Mon, 25 Aug 2025 17:34:31 +0300
Message-ID: <20250825143435.598584-9-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825143435.598584-1-mbloch@nvidia.com>
References: <20250825143435.598584-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|IA0PPF170E97DF1:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1f5a8f-269d-498d-9bfe-08dde3e4ab8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9hU/K7WCU7KQW88ZO4Au8qoPW74+10YJEkTxk1NuYitkX+Oq9cvVHNoHN2jY?=
 =?us-ascii?Q?sglEPqeUG1fgNaSD46CspdA+D3VoCMpVY6ebgYVi97JR6y33jParK/4NBW3l?=
 =?us-ascii?Q?a9VWVocKEJwzDfM5/dyelP6HfxO8Vp2qZYPDP1yqIBcPyurX6+h/l3ipj6TL?=
 =?us-ascii?Q?JSWxEuyLXowdS7UKElslScoNIH5/3teknMfOs/TNohi87jZq80LLP2FT3w/x?=
 =?us-ascii?Q?aN7h4PmnXliKir0FVFcG+ST3PDhd/BnfIf+swug/r0KhNPWXiYdAzMBr2Jbi?=
 =?us-ascii?Q?4goAeguMwsBfMNWkoYh6WpZx0b/D8bFg3bsnWWA3omsZlgYpHsYU54CdNqcX?=
 =?us-ascii?Q?dmrk+PM6/7sXZCuivSRE0ICI7S6WBjgWfzp87x7V7wswM3pWKHLSGOHv9QSl?=
 =?us-ascii?Q?6w8BilkZdIX1ClkKFYpJA0mBRdfRRl8EAjxQCmY9Kl1BDpDSlW6ezyqaWbuf?=
 =?us-ascii?Q?kMRIXyNM5Vkg46GGew+WVWhHDx2+rU9GSPIZBpRR+APGWUKOQkLAN1pWmKxg?=
 =?us-ascii?Q?xWtKR1Vn0HUlWutSXqo576/Q5TSmadOAU3O1uKgyIHq0u86+BxeAPpxfyjHN?=
 =?us-ascii?Q?gR6XQtBqcGOnwsEjPcWdYgDINQmbEy9bD/kkoqh5cnPwlqHYhNFLVaHO3Eb2?=
 =?us-ascii?Q?njAHn8K7LegK+oiSSqB3OLX80mXFyn0Qtjg5qQRA5/rc+Bl24T63n7mOSQkY?=
 =?us-ascii?Q?tdEITst/RU3l4Z7B26E8Sp30neatg4ow6SGNnZRahi9yZWuYvMs/4f+H2b6i?=
 =?us-ascii?Q?27zG3FXFbJ3yfHp72MAf+SW6Qqnsvl+NItPbgrUeqLs5WYk4y1rzHx4aA6K0?=
 =?us-ascii?Q?2SarPnP6GqSvXlvyArDui0qzImsGP6fSNzsVtQjZ8KcxCxa3IQdfJ8bzHjB6?=
 =?us-ascii?Q?T0Rq6R+j3DtVvFGRhHuzlYGlcS8Ie7cwOxZCd6KXLRBC4Vo9K/SygfpfNjoK?=
 =?us-ascii?Q?Edn50Tu8JdCNg66mfwUjnpIFHMCNxTVhYNdj9Gd07xk/d9tReYEJJ6HsNTtX?=
 =?us-ascii?Q?9IFHjaVlcIFe99g8+ABv2qDtUmDtgvUnSQ4cIflnnedLRo0WPRD5RMlLE935?=
 =?us-ascii?Q?hUL2YCHKOuNbQum1xUs1OIuv1oGx5Xm+LE5hNGt6//ZSrwkyCCTmzWYMc3oM?=
 =?us-ascii?Q?2h6SvEvnSARqkuM0cJ21KlwPl0heV0XyFq9/tFK63nKFi8LvIW8Hvn87DbJD?=
 =?us-ascii?Q?E08q8MTGz1+bbDYLqiMR+laD3G82mrDRTPQ6mQH7XsHZRZdwGrR7XYuWnZ2q?=
 =?us-ascii?Q?+9QELx88GlpAMIJh6rXbvONQcM2rRuFMbTFB7uI1rk+HOUCtt1m8rcK+NUs0?=
 =?us-ascii?Q?O6IQpblgcS075oFkkzxL0NljIJjAE2YEY+p/5MtZ9985j+/J6iXQFdZfeC80?=
 =?us-ascii?Q?rWGGJDgwMSirlvTo0xhSqx/LWhOHDMw77+dWBPwqsD/mh9DpvV3n9EpyAAxi?=
 =?us-ascii?Q?NsuMIQ+ZHv+YJVwhriMonjaJ813yxqKTsk3v1zeAOyCJdvhkLO6DHTNpU5Ui?=
 =?us-ascii?Q?ob62l8CyHypgT/aCNRmyW418vaTyVIrpsHce?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:35:42.4739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1f5a8f-269d-498d-9bfe-08dde3e4ab8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF170E97DF1

From: Moshe Shemesh <moshe@nvidia.com>

Changing flow steering modes is not allowed when eswitch is in switchdev
mode. This fix ensures that any steering mode change, including to
firmware steering, is correctly blocked while eswitch mode is switchdev.

Fixes: e890acd5ff18 ("net/mlx5: Add devlink flow_steering_mode parameter")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index d87392360dbd..cb165085a4c1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3734,6 +3734,13 @@ static int mlx5_fs_mode_validate(struct devlink *devlink, u32 id,
 	char *value = val.vstr;
 	u8 eswitch_mode;
 
+	eswitch_mode = mlx5_eswitch_mode(dev);
+	if (eswitch_mode == MLX5_ESWITCH_OFFLOADS) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Changing fs mode is not supported when eswitch offloads enabled.");
+		return -EOPNOTSUPP;
+	}
+
 	if (!strcmp(value, "dmfs"))
 		return 0;
 
@@ -3759,14 +3766,6 @@ static int mlx5_fs_mode_validate(struct devlink *devlink, u32 id,
 		return -EINVAL;
 	}
 
-	eswitch_mode = mlx5_eswitch_mode(dev);
-	if (eswitch_mode == MLX5_ESWITCH_OFFLOADS) {
-		NL_SET_ERR_MSG_FMT_MOD(extack,
-				       "Moving to %s is not supported when eswitch offloads enabled.",
-				       value);
-		return -EOPNOTSUPP;
-	}
-
 	return 0;
 }
 
-- 
2.34.1


