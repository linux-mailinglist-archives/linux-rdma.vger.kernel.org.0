Return-Path: <linux-rdma+bounces-14007-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1278C00352
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 11:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C2D3AF2B1
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 09:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79931305E00;
	Thu, 23 Oct 2025 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pyWNSOoZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA193302745;
	Thu, 23 Oct 2025 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211083; cv=fail; b=F419tv5ScKTP+tZWDXzAKfHHKoeaufTQy0roqx4JxTP72Rwx5XSVbPgZ74lcUJRNirfOe6WxapM5l7WARWfvsSRH5VRnXY2pyHSxbHaS9avhoxDHggkbWgMW49JoRNRpZwxgQJs+2dB7yYJd+Pva/Q6WxhQB/as+rbnQ3Ss+iIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211083; c=relaxed/simple;
	bh=25f98pzgJBDXW9xe1/SqSAbYfcl0mL4S+hhQfryq98I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmIu6c6OZPI1jiDP/8HmsYmHZ9n9JT56ciUdXn6FyFmpNaxKszoqVaD4VZUgrkTMlBqH5wqsMs4T4b7RwSRTpCRsnuMyaqH6I3oDX/044SGjNhYwYn4f9qRtNRZXByJuFNgrcGvAPTMBHTJbFHd9WfYxSIQD1/mMLvo78iZlx5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pyWNSOoZ; arc=fail smtp.client-ip=52.101.48.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juDDQ+c+gsZ4FqBirN3O/FZAS6KlioBDU7h9327nAnIdXjAfdQWH0S5/o8YewU5ZpzJ7jPeONa/MAPvQto8eq3PqosINaktKRYRF4BBMwC5zy/epZKo+ZkEtEoPkM9IjY8/MtqtSGbYzAyw2BIF8HrWcgY1Qbgs9tSHlWXM6L2yzdjAeRyKqzp2nQSAdZQ+q7DMSabYoi9QPSyLJMXFsff7DWRGNqXtnvzRrL7K+akQoamCFJ/tFzWLCs1r3yrDvridv/raPsCWTiMUmNnybopT7YTJSwqJbnOwwcGAb7qFi23kTImy9LmbxsYGpu1iESAUVFDgSMX064bu2UwF1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39eB8OgZ9oMfByzRSgLrRP9zb9Da64vKZ4cFFRuM/Cs=;
 b=cvSFS1EHcakRUE/I8kbTnjVUrIrKUmLMvKtL6Wh5fkZIc3yatftJcHYPAJO7yVH4cbAaqjU0V5jNHMoaTyr6+DkPDOQOvHU/uH59qiw6rX07Xd4YQDQGaG2ADMZc7DkSMa/X+z7dYRk4jncVS9nqHV3dDoftN3ASnS91DwZ3+66qjrjh666g/I9bePC6/+/BS12WdGxI/PqqJVx8me18jeggNfjrL0CpDR272/tyys3llOY1kY5cgt+ujB+pYE3ubNIWm95nTuKzEgv5FGJ3H17MKrcaTwfSOsrgjREfu6cSmSLKv1pCuCOD+l4tbSIoJ/oDMipymkJAuc1IrcuDoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39eB8OgZ9oMfByzRSgLrRP9zb9Da64vKZ4cFFRuM/Cs=;
 b=pyWNSOoZRrSfKVDdDkAtlSg7pdXOk4Y/RHUR3xU41fLfkR/z33pILpMU6x4UJWPIaZcFF+R3ZamWWqNDokch/mNDXEuiRUCFfHK01f8UHs07ykbQGQVdtbsmTGUPxOuPU0MXPeknr+qdQndX520sZvp40FCXv9GiBZhs4zzbbXYajF/owyzCJsnOtDvJap2nq1T7c8WiFQ9P2K9JMvpyBChhoPUX/XG28N1j+YmkT70MzFopmQqH0EQ5lwsWOYE54EkkY0LjecsJGWAk+D9URahlCPQUzm77bghuHeeb5+vYryCIZe4/dcWxYBOky96/nt2SOkE12AV1ra19Bx4ZUQ==
Received: from MN2PR05CA0040.namprd05.prod.outlook.com (2603:10b6:208:236::9)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 09:17:54 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::23) by MN2PR05CA0040.outlook.office365.com
 (2603:10b6:208:236::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 09:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 09:17:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 23 Oct
 2025 02:17:45 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 02:17:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 23
 Oct 2025 02:17:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>
Subject: [PATCH net-next 3/5] net/mlx5: Refactor PTP clock devcom pairing
Date: Thu, 23 Oct 2025 12:16:58 +0300
Message-ID: <1761211020-925651-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761211020-925651-1-git-send-email-tariqt@nvidia.com>
References: <1761211020-925651-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: cde2ba34-3003-4a1b-3b31-08de12150c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UEifPBHONMol7mpYa4o4lCTl1CLvIHdE1SQhojjp6/R91M9LAvH0Z1FizoY2?=
 =?us-ascii?Q?ubmQvum4o5vhdz72mTu3kQY2eSlq/dHUavzefEUYjkg5xNYe9ONij5AqHK8m?=
 =?us-ascii?Q?nXOFsLK5Pvcez5s3+o/EsJluL6uL1AfMaN+oogUSGwKZhZYH6azQzUE93aDY?=
 =?us-ascii?Q?5szsZywG6rePUa9z/7w51jMTxnAr2gpAaoCITun40PYlJU1jGAkkTRrf8lYs?=
 =?us-ascii?Q?hgXCOBmpdXk9kIbfkVmr6QtrG5hym4WJMtT0NQiug6lnp1pWdqVSbhBkzRuq?=
 =?us-ascii?Q?RJ+99ZhZqkiw1hdz9FMPf8kcT7K7olxw1Q4xBXzIEj+cb9RYwIkHqE/NV/25?=
 =?us-ascii?Q?LaJUAXH/q8HioNs5PD21ROEPgDTeSkrHCiyxlAKCWDvtCjtNyR6F8Z3QgFJh?=
 =?us-ascii?Q?/0u/TwPiyxjyFAwOnRiStgKy3ydWnnpuDML/JJmOExxP3r7EDv6E4WHXLqpr?=
 =?us-ascii?Q?D/DFNeClnOjGmUf3D2DqiQ5ZDSkyH8taqng5nrP1zaZoAz6rrVKTaA15MbG6?=
 =?us-ascii?Q?xqzygaE8U7MLvxpeqkr+UAG8o+WKV41X1d0vSt7ZtWMMICwxYGrmm4//nMAu?=
 =?us-ascii?Q?091LEIOUT3dUsU6LqV161b02GqWQVTtlKOhv3xXs7NYpjnTgMnbosFtwGSik?=
 =?us-ascii?Q?6/Skm9LOQkF9lhin4lMz8qPgpDZwMJWBZHIdGXccZy6tqL48ntWMFaH5pTKy?=
 =?us-ascii?Q?4defa6xOQBE4TYYe3JTz40K+ZpnJJt17KqawgbU9k4m3/GaASpc3Ga3Y1pVI?=
 =?us-ascii?Q?M1ZmqCGyzXtIrHfbytApMtYHYQ0u3Vi25uAaHG4jWr76A8VTAKHDyLcN6YbO?=
 =?us-ascii?Q?OCvYQR76Ekz80I40VFY+OCb1SXMFrozQRO01S1a1vHlZ2ZVp4UoNO7ufkEl2?=
 =?us-ascii?Q?Yk57n5uPcNmDGFxcrSjTJMBFbA0n3p+pUJwKors3DpwjFQCqXZfhLyGKq+b4?=
 =?us-ascii?Q?NdIjVeLSAkYlQgAgNLyirWbOrnZB7ob1odDMSJcKIJxrnuHJA7Eh8gj73gOY?=
 =?us-ascii?Q?bKtjmd7AMJt+mnGXVyTbritksv3akOAjEgvZi/WgHaxS43U09aQzHlN1SRs7?=
 =?us-ascii?Q?io9a3hwhgrBjm0WAdZ4D5NW0xqVLDQLTcWhqL3c9x9TlAyfHcnvXYArGa3Qp?=
 =?us-ascii?Q?bXk2Nw5sBoyCCUol3B9FvaL9sBF9CeWBeIbqKuO37i94WtikAIvNT2WqrMRH?=
 =?us-ascii?Q?G+LRVoDo3KLaZZK2axyKtuqEuw9woMbi5wo1ajS3r4B205Ni27yvkT8WHJpY?=
 =?us-ascii?Q?KeciYQtvIaSLKP3kesv0hFJGERnHrEUzp4Kfl/u1r/x1p7nwHESvecQB6EYp?=
 =?us-ascii?Q?RvQ/TYycKdiQdk1q22eYRrkWn5fZFRgOAc9e2AcmFgshtaUJE1fpV8ZqO261?=
 =?us-ascii?Q?OB3qtncdRWWWrNoae+hIiuko6qLzWS+S+IDBDeXY/1hq2HC3Pz7+GlY1y4KF?=
 =?us-ascii?Q?/gSMl1c1+Sue/5329CoRqt1+9ghyZ2cpiDnvT9SEvxjGAf82ks0yie5qYjct?=
 =?us-ascii?Q?hBYD1RHdxrrMBI8Sp0j4v+aGFErGhXAFMnSrW5mBm/K7n9Qc2hiiU1ZG70ZD?=
 =?us-ascii?Q?kN74hAbJ8L2YcsOBb8g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:17:54.0409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cde2ba34-3003-4a1b-3b31-08de12150c3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748

From: Mark Bloch <mbloch@nvidia.com>

Refactor PTP clock device component pairing to use the clock identity
buffer instead of casting it to a u64 key. This change leverages the new
software system image GUID infrastructure.

Changes include:
- Pass identity buffer to mlx5_shared_clock_register().
- Use memcpy for identity buffer in devcom matching attributes.
- Remove intermediate u64 key conversion.
- Add BUILD_BUG_ON to ensure identity size fits in match key.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index d0ba83d77cd1..759033a18ad9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -1432,15 +1432,17 @@ static int mlx5_clock_alloc(struct mlx5_core_dev *mdev, bool shared)
 	return 0;
 }
 
-static void mlx5_shared_clock_register(struct mlx5_core_dev *mdev, u64 key)
+static void mlx5_shared_clock_register(struct mlx5_core_dev *mdev,
+				       u8 identity[MLX5_RT_CLOCK_IDENTITY_SIZE])
 {
 	struct mlx5_core_dev *peer_dev, *next = NULL;
-	struct mlx5_devcom_match_attr attr = {
-		.key.val = key,
-	};
+	struct mlx5_devcom_match_attr attr = {};
 	struct mlx5_devcom_comp_dev *compd;
 	struct mlx5_devcom_comp_dev *pos;
 
+	BUILD_BUG_ON(MLX5_RT_CLOCK_IDENTITY_SIZE > MLX5_DEVCOM_MATCH_KEY_MAX);
+	memcpy(attr.key.buf, identity, MLX5_RT_CLOCK_IDENTITY_SIZE);
+
 	compd = mlx5_devcom_register_component(mdev->priv.devc,
 					       MLX5_DEVCOM_SHARED_CLOCK,
 					       &attr, NULL, mdev);
@@ -1594,7 +1596,6 @@ int mlx5_init_clock(struct mlx5_core_dev *mdev)
 {
 	u8 identity[MLX5_RT_CLOCK_IDENTITY_SIZE];
 	struct mlx5_clock_dev_state *clock_state;
-	u64 key;
 	int err;
 
 	if (!MLX5_CAP_GEN(mdev, device_frequency_khz)) {
@@ -1610,12 +1611,10 @@ int mlx5_init_clock(struct mlx5_core_dev *mdev)
 	mdev->clock_state = clock_state;
 
 	if (MLX5_CAP_MCAM_REG3(mdev, mrtcq) && mlx5_real_time_mode(mdev)) {
-		if (mlx5_clock_identity_get(mdev, identity)) {
+		if (mlx5_clock_identity_get(mdev, identity))
 			mlx5_core_warn(mdev, "failed to get rt clock identity, create ptp dev per function\n");
-		} else {
-			memcpy(&key, &identity, sizeof(key));
-			mlx5_shared_clock_register(mdev, key);
-		}
+		else
+			mlx5_shared_clock_register(mdev, identity);
 	}
 
 	if (!mdev->clock) {
-- 
2.31.1


