Return-Path: <linux-rdma+bounces-14393-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2E6C4DB96
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 13:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 439664FCE65
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 12:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB8E358D24;
	Tue, 11 Nov 2025 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AydTrWNd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012008.outbound.protection.outlook.com [40.93.195.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597A7358D19;
	Tue, 11 Nov 2025 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863936; cv=fail; b=ZvUfMuLSxIkuSIlv6oRqeA/uO679FOUfamIBQTxaXy+u9sVQuY1b6kBu+mipxMQDLZ5aJ2wsWU4NRKUQTFmFr9Pnk/M4CFSNsu0pCZHkPAbA5zxu5nPdHdvBrZUi2fQF2N0YH+bzZYI+bZ53h3aSMNb8nvW2kNxFCDxT3Qmyy0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863936; c=relaxed/simple;
	bh=Va0ZUN8h4LZYTv/gpwvdRHTHn3ZUj2axJPrf0+NukAQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gO50pXLli8kjVAu3N4VnfxIJ3iheKGsU10OfVrOFMkts5HlRuUiRw5LxBGX664WufZgMQrpqO/MkbpoMlQnouXumgvZdxWtos/ZguJ3Kn2fL9CcqqRcgMk7hoppTkAwb5Nlayje8EyoIWggJOTxvcPkBwmIyZQ6u/6fcHCHQ/Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AydTrWNd; arc=fail smtp.client-ip=40.93.195.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfTSJNhZRffivQDDmk840dDhFUSH7q7xXX2nCD9TXJkgRZRkxkxXKA7bcwJekubOR7ANoS8MRza/m4TC3S17d1WXViYAHbCaOmme2wlWvplS99z4LQLMOWkosN9TgFOWO4yfc8+2TCyNPF/4iUfhd97JFpSZzgMTqSZ0XauTxRqHGkZyUZuM3su12u5BHlxrGIRGJn6U2YSuk48lW7Ryp2H1X5uE4/x+aPYxr6RGwi81oDJf1ci3kAqzfbPbHbuFh79ufwm4hnGfOh890hQHFvu/lH2fhwsveTO8CwK2WcxFSHYlLa6Q6Wzt1XiT+SF6J1U5X9K3ekCHleQdUfi3zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=568ZJI1t63TwE+2Vg6FBO7twsNmkVlvaTSH/AwD3Ghs=;
 b=nY8ufuyeLhR3pAmUGgQ3CEMpivCBSRrkBzTXiyfrTY1LHY0L9zhSmIpIiinA7x6P1kO/EPDvvukunP9pFUTYgYer/TNLz4OB+jyfBiV6ZHzAT6/6OBlpQFZYK8eWQsmFM8m/UmsmSDL9JJaoA/ZEFdOnMlkhocB31djuvjBNFmlb4d8w5KVWZzI9iRNTyPTebYTAjoJumNaHUuXEGCutmZKp95tmVL8PktJfJySjlF4GY3icJV7cQbSX+VTscMPjKSZKcW85tsXr1jr11F+l8lnBN4WYYFUqLthHhkX6Q+4urYdg+/sy4igKYeu+K4vIkZz2hMULxmZT43xm+P/3SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=568ZJI1t63TwE+2Vg6FBO7twsNmkVlvaTSH/AwD3Ghs=;
 b=AydTrWNdnzpMStlbvQl/k/pq8mjbO0AfqDLNclYMpxJi7Ij4l9rS1yJsJaT369Od8iMiFgtPwBjcZxf+Ixqwp4CLNv7Fn4yGWUmPHOqCS3DyV9bZl/MuqzMtjk7wyMXOGuVOs+nvzLa8PMDP616cKmrlihIAlh7Xha8iMkkTJN9abQi5JuNDUpJAEIxy/ZjknBY8QDjjcqdoyCEyFFBemzE/hocHoibum0WtdHbs/JXfxSZJttcFTvOZDkEaPUmhBo8+uxpSo8MrUMhRwPNXcBJMlKwFCudfgLzGu34LsOFF/KM60GhOyprXApO7Gn/AC0VTwgiu0bQjaN/E/kEtBQ==
Received: from MN0P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::34)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 12:25:27 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::cc) by MN0P223CA0019.outlook.office365.com
 (2603:10b6:208:52b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 12:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 12:25:25 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 04:25:18 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 11 Nov 2025 04:25:18 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 04:25:13 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, "Maher
 Sanalla" <msanalla@nvidia.com>
Subject: [PATCH mlx5-next] net/mlx5: Expose definition for 1600Gbps link mode
Date: Tue, 11 Nov 2025 14:24:48 +0200
Message-ID: <1762863888-1092798-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SA1PR12MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 2705dddf-b262-4e2f-6865-08de211d64be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QmltMvdEpVpfkVbqBWmKwCSM4oWQeFeklI+YzITp28nTZl1VDlvDdKfHoDMG?=
 =?us-ascii?Q?aKCD+loYMT9l2oxoyA04nOGYi6OSAh+hWUqOs3yZs0aOQTGXuGUdElYH4Okl?=
 =?us-ascii?Q?a7wadsM81Dgok6i5W89A40FIIEEq4pkhmOJNnrlNLrUnjQjwjjd+1Yhystc5?=
 =?us-ascii?Q?tUeiZo/g0NmiJkbrutWcI72w3cixJfhknaJ2AjY11/ZRYsqcMJqjpmHcqWyh?=
 =?us-ascii?Q?xJ2+fSD+k0YqNML/Q5l/N1UefMSG/IEj3vqk780G9JsXqTAL4lJg8L2OQmic?=
 =?us-ascii?Q?CEaHMDyv/0ZvSsaQ413jQE14SgUv0mRh3EgpOEVxGddBmx1+oe8vwyFyoQHT?=
 =?us-ascii?Q?v2yAv8r2KFxpfgz2ABKv6kyuKsTOxYn1vgavGnnQIqZdQVyeJOQ5DVqUy23u?=
 =?us-ascii?Q?hdrGRQLVIhO6ueMkgAlVOiffpdOpQQAdnBZ9jjt4XdVDA3w4BK/8XnO2nVzz?=
 =?us-ascii?Q?avK3yMCDUjtOLzLoOAOv0uXtflSv+f/09fOo80cA1pl8ZNgV44v5PbIK6Gn9?=
 =?us-ascii?Q?f08vkkCBUKhENxI7HzFuZChm6y2dIbDJd2gW0VnARVf8/uX/MjysWy7PaZzA?=
 =?us-ascii?Q?JahmsKaxFKnRgsolrFxJ0QhkuXJsIVtlJTzBTQj29PrJu/R9RS+YDT1Co0mb?=
 =?us-ascii?Q?3b9nI52+oySqw2JIXoDuW4WHimjHwNzYuvO9X0JJH/UaKd+EVlXSO3ZXDKER?=
 =?us-ascii?Q?Q271qLv8SPVcxghGiWLn+Sbhi90DL0lgeQ6bHBZ9vHQLhThw0hTUiPkWNr/1?=
 =?us-ascii?Q?cAEzPhKOCmvlsXxYQNNfTnxC9mvdfHpqO6kWYOYNV0TVGZLg85Sv30wtgUoH?=
 =?us-ascii?Q?3+Vwq/OG5AhNGX5WIY3wknGLgbx24w+d+qkuv+p7bNx9XnRZNMginssg9XQo?=
 =?us-ascii?Q?8Xjbudab8Wx9LuWgoHUdz5CSpLUBouTCYHSN/sq5r04pdrwZS6NVq4jjPc9/?=
 =?us-ascii?Q?SEGUCxcsj72JsiauP7J80kduaWQkxbgVlFvc4u+NfCsz5YkUGJFyFSKl7DN2?=
 =?us-ascii?Q?iZgyULO93vRqFCVtv7aE/RgVerfwIUNwmODurZc7feORIsJlIKZWjqpb4mcG?=
 =?us-ascii?Q?/DnqjiJmJ/Dn6zw6dA1jYAJOAcrE+G7Kdz9+OJ9OyQwTjUkLCeJlH6zyaYt0?=
 =?us-ascii?Q?hrSDvxzHA4HmYmVHsEdwSeEkC69Fqno1Vy3PDusWiggPCGa4uvYdrU/Y2duZ?=
 =?us-ascii?Q?g0BaBopG7Esj1twJv1781rsPY6OQvdbTDKNJCGhfWSb3X/2jg3z5GMtk0jjr?=
 =?us-ascii?Q?Nn3ar82WgruTPhD3wAODSqpXqaonPwC4I2EP9aY+L4zt1S8eRYWM89uSv4o5?=
 =?us-ascii?Q?navUOF1i0yANBeu9X3MQTC0qgiKIH0ns3Tn+3qdvDIl8Z7jU3VKKl4JeGqdo?=
 =?us-ascii?Q?/ANZysmvldDbg6LOjc+4v+7EPTYNZioI5wf9Ke5rkX67hv7w86h4J5mbJSyN?=
 =?us-ascii?Q?5LWjwTZzZKedRhBBKcw0jrdaZFXaPjI0Sk574OdFPWwpRLvqlaNrzkN87U9u?=
 =?us-ascii?Q?oYXXeNnYhmQ3a0ffaXdODRT+3kmbxi9JvEhE6JNVJRHLUjvAMom6X57b5nHV?=
 =?us-ascii?Q?dJgpo753Zb6Q1fN7yVY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 12:25:25.9934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2705dddf-b262-4e2f-6865-08de211d64be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679

This patch exposes new link mode for 1600Gbps, utilizing 8 lanes at
200Gbps per lane.

Co-developed-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/port.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mlx5/port.h b/include/linux/mlx5/port.h
index 58770b86f793..1df9d9a57bbc 100644
--- a/include/linux/mlx5/port.h
+++ b/include/linux/mlx5/port.h
@@ -112,6 +112,7 @@ enum mlx5e_ext_link_mode {
 	MLX5E_400GAUI_2_400GBASE_CR2_KR2	= 17,
 	MLX5E_800GAUI_8_800GBASE_CR8_KR8	= 19,
 	MLX5E_800GAUI_4_800GBASE_CR4_KR4	= 20,
+	MLX5E_1600TAUI_8_1600TBASE_CR8_KR8	= 23,
 	MLX5E_EXT_LINK_MODES_NUMBER,
 };
 

base-commit: 583b4fe1c19d978bb787e0adf9ce469cb7f68455
-- 
2.31.1


