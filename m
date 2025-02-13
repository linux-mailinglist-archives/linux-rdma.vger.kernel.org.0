Return-Path: <linux-rdma+bounces-7707-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCA2A33B90
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 10:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BF6167A78
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 09:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C40212D67;
	Thu, 13 Feb 2025 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cyv1CjOJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9414211712;
	Thu, 13 Feb 2025 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440064; cv=fail; b=rlTnRFhtBfGESu7FiJ6Oj5sWzIERDSmYY+T8rQz77bM6P3DBVLAaO67nx9Ev2TzLJPN8UgoTRBg6MoZLOuSYFZgzDGgcyl1JLibjvIKMBb1vLdnXFdW2YxZ2VoW5Bp5BZh/whgC/0ddcDhbyB8641jM+hxSXD4pESu8V82xlDqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440064; c=relaxed/simple;
	bh=nz770tneXCQVVn6zDDOYoOloDFqziktnYOY027CxClg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJoc1/vkmrJy+viGH4zFDju6P6Kc3C2WGbHTz/OwxcfGqE5Tzd2V5pCjnwKT969JbS3zompX42Ci6KcgF4QXwhG068QdivTO3GrOs2qXcQ6UBaEGUPVDZsT7NDVxDrVJihNjl+zDqGpehpfOG3oiLNbSNi/mgVhxzXfWVUYu7Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cyv1CjOJ; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycG6UhTk7sIuUy21Lu/KZ5u9iyBbI80PUf209ef0bkRaKWp8e/c4HcTVJt4Uzo3BMgQR51BVu+WWu4DofIEO8WrPiOSUdLl8CbJr6ENy3XK8fmY9sEkTOf2iaAhwAP2NL9xKnIAMMGcfoU2DwLXoGUG1PAnXbMvDv69lQF2qICC+ok5lwZxCzoBjwoE8uFZNxwXdyfrYgIEqOUJaRnr9jh1AbN2VW1PNwi1BzAvs1w4qNeanRlDPwYSOhFq6qp9qAw46jUu1XZ9Tj9YrcKaFPagnv7aRMXlDZAuM6/uQ6QPinYdYJH7BUE+MX2njFwxosQJWGZvQhJyxQe8+qEzAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obTRZAZxiBmCi4vlHdW/trjZmWDiJzg/I5vpj7KePZc=;
 b=gHfk28XWqM4p6kzYa93siTPPd1UASd4Olz50D0AQCWg4NWDt+0Qppkl072hp9IPoGIPLmvOsU/yn7XLeETFXZaZ2u0yCsBu8hu4oZQyZmrJXpn8mnjsOtd+t3Z6o45v00wm/1rin4TzIrVfuLaBeVeNKZ3Zm+jWsO0oLwtCfmMY/kJqXpCF4yF3jv0Kv3tEnnJOJjpFx3Mv3Y7mXe67OQycsBTRxAPOsADIUYkVV+8z287cYXzCzd1n2LMjrMPo3jxvxZyr3EC5Aqcww43ca0jCVKDFxC5ikr9eSgSax5weijeCulldU93nMbEpV9hkldLiNNXMJOKoQm9SsG1jSDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obTRZAZxiBmCi4vlHdW/trjZmWDiJzg/I5vpj7KePZc=;
 b=cyv1CjOJUI9+aFBgbLWQDCJK4VXteTS4mdYHpzw40gWCEGyKgJPs9a4dpW/h5WspTRTw7UHeeGBD34mYDfqxdnldY4T6QuPg3VpCGNgjdL/94h3kw6OhWV5mdkYZMQfAEQu1XeqEMzFiYs+3aY966goPgJL0zUwRNqUv3BOhRvNNQfe6WSHiYZJdOCGDyZLGhJtBL0k+ckGa/9e4zcDyQ88K398KFIKzbOUKIB789Xzs263KgTfeFDf/7H1aQxNkl2Ar8tMjDnK/yMgCg7QQn+tgLAWbE2zNrIgD0meODiluFRddOQmJ45TyQcp3TsRR65HDIUgBTaZyJYQiW3mi/Q==
Received: from MN2PR18CA0030.namprd18.prod.outlook.com (2603:10b6:208:23c::35)
 by CY5PR12MB6299.namprd12.prod.outlook.com (2603:10b6:930:20::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Thu, 13 Feb
 2025 09:47:38 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:23c:cafe::f1) by MN2PR18CA0030.outlook.office365.com
 (2603:10b6:208:23c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 09:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 09:47:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 01:47:26 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Feb 2025 01:47:26 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Feb 2025 01:47:23 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Shahar Shitrit <shshitrit@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 1/4] net/mlx5: Apply rate-limiting to high temperature warning
Date: Thu, 13 Feb 2025 11:46:38 +0200
Message-ID: <20250213094641.226501-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250213094641.226501-1-tariqt@nvidia.com>
References: <20250213094641.226501-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CY5PR12MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e8e756-3ef8-4c70-6632-08dd4c13738d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AExg/q9qXaRaC490xQ+YbgxXiZTfnlrXNlaqLjXhJblhXc0xdBnjJM51+sDB?=
 =?us-ascii?Q?zlOP9thbkGNVqIgxCHnHvfL6Wjg2bGmb9/yxZTneSd3a7Nm1yEBht4jw1zUE?=
 =?us-ascii?Q?Uy5L3kmZrjdecRyvnJH0uRd/AuJsKc1Au7Ic9WsFTWlwxk3tIIcK+yBFbzLL?=
 =?us-ascii?Q?Mwig8GRfO7PzfP1nGbqTxB+Lw+W7RUhCc6fJjfNBjxSxyepiLfIG3bmXia9o?=
 =?us-ascii?Q?3ajQOMYoByPKPp8mIDJ2k7Eze0mkPxJiVlF0OYXeBwk2Un+0+rGus8llRy8p?=
 =?us-ascii?Q?zQzWteuWSlPGICSTPlMgS/XQcdu7EgMsxsIv8/eHIWRl/fborPUiVKRpNFjh?=
 =?us-ascii?Q?C2ZPGUagPCrk3Y6NJHi7r17xW4oyPE5QKxL4Zld0xwJFbQw3DaGc/THPH80C?=
 =?us-ascii?Q?hm76Gy5qE4qmUkd3RMFa7xF4gST9HQ7VZthSGLIRvsjElcb0OtsALtOaydxP?=
 =?us-ascii?Q?FjKfMffbUQCcfz5XCFel9Rdwn8HrO9VA4G4dgks3LBtNomWYeqHhx13c5Hgh?=
 =?us-ascii?Q?KZaRGC6BljQ3Chy/EnbKjgpYy56KV6FhOnsAxjWcG5G13ThWk1785pQJR2Br?=
 =?us-ascii?Q?BpZyyR6xPITs6fCV/oZtY5L63MV00rkKM5GsLMJgv4WFclvn3rGhb8ktAXpd?=
 =?us-ascii?Q?NIDDq88sWgvnkXUJ+FJz958vN4zc+XCd6PqjrcG1RiMk/ngRrGmMh5HiRCcD?=
 =?us-ascii?Q?j4X5u5GPDTI//tbs2OnM/kH8N1db7s+K8eoaNsOJqe+PlqTI/wC9IWhnRZW0?=
 =?us-ascii?Q?l6HwCsV0GLbEHl2uwUkGYDv0nNWF2yg+/MAbzdyVu9fRzM/2yyU73ClmbQqY?=
 =?us-ascii?Q?JVxfm5IiU6UAmgdAyrAKv04QgtNHddR3UKLsl0ayX1jo1iCYtJZjJHbbkHir?=
 =?us-ascii?Q?WqjP5iKyR+hNH4pu/xvy1DTmureMyZoFsjpov2yQdBjZ5Y/0roV9K3I+vF2a?=
 =?us-ascii?Q?i/fX1rhJ5Lh4djIXuxDdOrhoSgl7pYyPB97ROoU8nu3AqiLRkflqOhPxh6vX?=
 =?us-ascii?Q?Gzxyx9mDrFteoeOGOW4dbM5eyKY+IpyIwax+o4Hn/1uQYj/mmynUHHymc/Sp?=
 =?us-ascii?Q?eFpVdM+xb0BqJgBOgvOIYHBXSaBEEOzL7C1vJyv5lWjxW+WT06DcCzY77hI7?=
 =?us-ascii?Q?ACZSIyE6wiCsQpelryLJxnoQF2XJjWiyVPQkimbOT054yNWsUYB42drFjV2H?=
 =?us-ascii?Q?tKinKNN0thWRDDzxjY1FoOi+hk4Mr/t0NZsx1mmEHSHUw0V/mnHK/E/eVrm7?=
 =?us-ascii?Q?gHDXSQIf2pOBVXzMRFWyafNJdklQRbR2wWzhbbOoKO7kugjp80nt3H1szo9L?=
 =?us-ascii?Q?AnhAI4hYqQu+kQgjOXBg+Mgw21ctovwE8Mh76uW0Gn9c0c9K0dz1VE6mqqSe?=
 =?us-ascii?Q?tyiUlKRiA5aLKqHf6Rt1PFFTYKRtJloGvbw3lLno1GlJlda6iNRklqlb/m/I?=
 =?us-ascii?Q?Arqk6lMKIudhyHQcs6NYlo67Pqqxfy5uInaMWpVacpbDNSVURAQIoYu3vp5T?=
 =?us-ascii?Q?j7hI5SSgunVsPU4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 09:47:38.1027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e8e756-3ef8-4c70-6632-08dd4c13738d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6299

From: Shahar Shitrit <shshitrit@nvidia.com>

Wrap the high temperature warning in a temperature event with
a call to net_ratelimit() to prevent flooding the kernel log
with repeated warning messages when temperature exceeds the
threshold multiple times within a short duration.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/events.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
index d91ea53eb394..e8beb6289d01 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -165,9 +165,10 @@ static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
 	value_lsb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_lsb);
 	value_msb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_msb);
 
-	mlx5_core_warn(events->dev,
-		       "High temperature on sensors with bit set %llx %llx",
-		       value_msb, value_lsb);
+	if (net_ratelimit())
+		mlx5_core_warn(events->dev,
+			       "High temperature on sensors with bit set %llx %llx",
+			       value_msb, value_lsb);
 
 	return NOTIFY_OK;
 }
-- 
2.45.0


