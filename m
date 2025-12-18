Return-Path: <linux-rdma+bounces-15078-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E231CCCAFE
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 17:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C60B3076E0B
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1AD363C41;
	Thu, 18 Dec 2025 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jW85R0MZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180AD3624BB;
	Thu, 18 Dec 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073521; cv=fail; b=bytnoEyS/vtT96q47ILQ8LC+TvIbC6kAuL1jpXzOE74cucLz+NUssm3xHTc1DHj6Fb7Sh5giQB++MWhAoTe9hM6ygwq1TjAEJAgsBAgILdm1IqZc7KeA5EBzexZUybghHZUQsTjxZ5NCTkgg+NXkDTrjjLtmnF/Kekz3yXIHLkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073521; c=relaxed/simple;
	bh=1z5ZiG+eRhsyll0FQwl6z3RVyxyF1nf1Uhk9c5wuwF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4NMTv8xQQriVvfcdozgxmfzBs+DaH6Vy2swNvTUNu7x3zv2oKWl+/F0SGSQmEoAzZyhrOGsgnuQJpIAh+fNwB1SbuYKFLZQ/PazwSMIexBqei8TbH3LUMK1EsndfWn+A3bkA9KlFVL3hce4EQHfb5PWa9S30lBoM1CJjqXLKT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jW85R0MZ; arc=fail smtp.client-ip=52.101.43.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9Sv+EOzGylK/VejCxsGu6VyWFXDa3dF6hZK7gVv2W7z8FwzSzHdpBMjt5LaXnA7+IsziwMxP1sNnCWk8oZZhcejb6IKuhpr3uACpOFBVlu4YHziOozujFpNDxuAdHq+lJEEWJrRtOyFFjZQChAjNw9ujwxrhVZ2VDMn05PL//OHiWl489UI98iyAYS9lrAS1TN29R3OqjwF3euwdu06vGeYpckrDgAmeNGzmyP9M79xKL+vMx7aZkrd8NOdt1oChhkCf43UEA6Lkv8VLAD4JKx8Xjr9sABGzCsSsnSJpRmAOjzMlmnlxBtFiARtkaSZQM3qL/nQNT0KJQu2WUzb1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJccDAGKZNIBU8P+sxdIsnRlgNtx6sW/6sHW8aQrXgE=;
 b=b/iJ7URnyErvdHaZFEtqN1a/TRt7KiAUB4D5mhat9E51qFZBW19h5GtNZhLjOyy4lfvCF7ijAmJM6wjBY7neLYqKg+UpAqpalMagMnE/GXKVORtmy1Ny2mEmdzCppuOmIeizh80dpbSsWVFBkZ890GYMkfwGaf0Xn1eUGC898JHBqIdfUsagHEGagDaoJ/K91P80hS+eETzHyGT0SkqUaczVI7tj1Y2aVu5XFQNZ3m4viPv4ETzS/F4OKBeg0yzk/429z8+ajuEkcaKS1MkU2/aot6er4h3pLR+ACLvtJVW16uTuEtedgJRF1Ax1oCHm4t7ddlDLJar0k6aUuqYCLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJccDAGKZNIBU8P+sxdIsnRlgNtx6sW/6sHW8aQrXgE=;
 b=jW85R0MZSkqtvGwgdIyplKXdIkhxnaKNQTVZ+IitA2vYh/ZyjRej/6AiKCJYofZn33/uT/cnaGSYAf6e8z8+xKpEPzRSHW6ZKpJ5JsIew7RP3QOyAyw6rSlxZK+vol26oTw19HHj8WLj7AUOXjJkuwVpXCcG97VOUnl4QBVy+WoKTsicguMMSpf9STVz5/lVSJ6ce9Fai8pqAn3CB0JxjhKLEGhkHXMtpB76zQ4XdAzf3c0PtPK08RRhTCLbuiyxOHqbkP2N4oau8AZKLbtDViJh9DVSAmtvKVsn9249JndwZELX6YvxfUdgepyReNp5vYXyk0L3dzmLXAHAbrpKqA==
Received: from PH8P220CA0032.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::10)
 by PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 15:58:29 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::60) by PH8P220CA0032.outlook.office365.com
 (2603:10b6:510:348::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 15:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 15:58:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 07:58:11 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 18 Dec 2025 07:58:11 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Dec 2025 07:58:06 -0800
From: Edward Srouji <edwards@nvidia.com>
To: <edwards@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe
	<jgg@ziepe.ca>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Or Har-Toov <ohartoov@nvidia.com>, "Maher
 Sanalla" <msanalla@nvidia.com>
Subject: [PATCH mlx5-next 02/10] net/mlx5: Propagate LAG effective  max_tx_speed to vports
Date: Thu, 18 Dec 2025 17:58:05 +0200
Message-ID: <20251218-vf-bw-lag-mode-v1-2-7d8ed4368bea@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251218-vf-bw-lag-mode-v1-0-7d8ed4368bea@nvidia.com>
References: <20251218-vf-bw-lag-mode-v1-0-7d8ed4368bea@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766069544; l=12727;  i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;  bh=Awua+wWYDe386DrscYUnPCv6WF2teNaNDM2UWKYe7VM=;  b=CEOVh9ELN31riAsdjOu98m3WYy4j6fN0ygCVYiBQ5FkK4su+SlowVQduADRf/ABVqxkEq0JHL  kJEIye4Y4PLDbFv0HM4WAYZJ7njuehBx4U648T7+eQhXRmP8j7j/9gc
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;  pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
Content-Transfer-Encoding: quoted-printable
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|PH7PR12MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: b127398a-ef91-42e6-5fc3-08de3e4e4978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjBGWUEvRldBbXFBQTFDWGhRSFZlOG8zMGdNWFRLc1Jza1JVUnNuY3hmVzR6?=
 =?utf-8?B?a2x0ckRDREp5NmpTYVRyWHhwT0lENEg3SCtxelZ3eHFscHM1WSt4VHFRNDRh?=
 =?utf-8?B?Q0tDaGRGVC9EcHF0Y3U0bmJSdkg4MDR5c2IyMkFsS1UrdEJ0cEZJUDd3M0s4?=
 =?utf-8?B?YmR4cFJhWEFMMUo0d08ySysvd1ZaM054RUsxdC8rZmdYT2hCa3hwaUd5UXZ6?=
 =?utf-8?B?ME9qZ29lUmdUczZXdmd4UGFleEF4bTFFcE8rNzFRK2FwbnY1cWtGYmFTdElp?=
 =?utf-8?B?cFk1NTUvWGxWbTEvWWZENjBsaTVGeFQ1MjBsbDgwMkMwa1locXJPNEpWTE1y?=
 =?utf-8?B?S0dXRWZnWmlvL1FjTk9WWUJsOTdkTHBrbE1PTU1OaGs2SHlhc3MrZGZUZXpm?=
 =?utf-8?B?VHRZeG9maFd3RENMUjBSdy8wdkJBei9jeEFnTGpNcE5uZmJPdlRIbnpTcmZr?=
 =?utf-8?B?L3Nvby9VWHZxcGdITGp2WmhTYUhOQU1KZDRMZCtDUDhWYzF5M0VtQlBvSG5l?=
 =?utf-8?B?dkpoU25RbTdCNkl6a3hEN2N1LytUWjV0cWtJcXlsZ0VJV1pGd1Rnb2xtRndw?=
 =?utf-8?B?ZkVFV3FYNzdkVFNVVUxScXpjR1dKNkxhUW1qZ0hGdEhleSswbEFxS0FOclBn?=
 =?utf-8?B?V2xMaHAwQ2tjbDVvWE85ZWFKT1VtWXUwdklicnd1ZmJnemdJazZMVzlKTzAx?=
 =?utf-8?B?djVvL1pUT0lSaHBrTi9rSXFhQmtSWU9pbTUyZEFXcTI3a1dNUkxMeitWNU0r?=
 =?utf-8?B?TG5ic3poWTBscXV5eTBhbWpvK09kYXhaaENzYlFnb2w0a2NMSjJZc25hWDFn?=
 =?utf-8?B?ZDJhUE9BY2l2NGZ2UmVqUGczMTdjakVHbHVOK0NIMWRJUGdhVlJObnJqc0M1?=
 =?utf-8?B?WjNackJSaUFsL2RBNzhac0ZjRGRwREF3emIwa0tYUFVrZ3ZWRGZrS1B1UDBB?=
 =?utf-8?B?dUN3M3o3VzJJWnluOWszYmhwUklwbVZmMzFHd2gyU2h1dFNmVFFJdDMvbVRu?=
 =?utf-8?B?Y0ZSTTBqNzVQU0xyZVJEUDhHZWQ4L3ptZi9iZkliM0s5NWxwMUJxem0vQmZ4?=
 =?utf-8?B?YXlGMkNXYmJHSnBGT3pZRy80RWRWVExQL21tTHQ4VW9mb01ZY3VOaTlHMzcw?=
 =?utf-8?B?NEJQMjFUd3Nnd2piNG16SkJXRFVaZk5MOG5pMmRKNlh2Y3RrcHFBZkR5dG5E?=
 =?utf-8?B?L250bk9WcEpyYU5vSDRKMjBlS0VrZkxaMjdYSG83S3BGdEpqRHVReTRLQjAw?=
 =?utf-8?B?M1JJWS9wUUQ3S2JiZGw0UzQwSlVZT2dxMkcxK0Q5UVRRUDBrVnVydHBxTHdj?=
 =?utf-8?B?dThFT1ZwYldnSUJZQndqck00a0dKZnNCKzgyOFd4bngyNDNoWEcwenRPZFUw?=
 =?utf-8?B?eHlnenBxTFNTenBMSEFNaDgxdVkzOHFGbnBZWVk0U1pmcTdHc3ZvMkRWMENJ?=
 =?utf-8?B?SmZ1VG42Y1FIRE9hRDRrQ1Y2OWZYdDZTY3pnVUlmRE1LZzltaVc5bjh6aWwv?=
 =?utf-8?B?UTgzZWNWZXpudmhLUTdSbWd5L2VCV3V5ZSs1aldBaG1kbkdmVDh0c3d4WmJj?=
 =?utf-8?B?Q2dhaG5yZ2ZWd0x4RWxHckFNazJZWlNNcnBTV3JhalE5anFVbXA0SFN5dHg3?=
 =?utf-8?B?NUNVRU1HV0JUc0k3WjBsWEEzQlljYUVsOXN3N25HMUZFbWFPODdOWHhYWjRO?=
 =?utf-8?B?cklaQm9JZlZOZkJKNWdBQUhBZDRQY0c0ejFHWndYTVhKcTRwOTF3M3lSMXAv?=
 =?utf-8?B?bSt6amJpR3hrVUk1NDhPRFlXMDRoT3pvOXpoVVZzcDhNRDd0ZzBHcmhQcGFC?=
 =?utf-8?B?YTZnQVVUQWFlQnhxYkEyczdUSmhIRVkxR2oweml1YUZYb1dCeUQ0YVE1aW5K?=
 =?utf-8?B?dFA0UWRRWDdCUytEeWo3TXd0ZW5MaGg0b25CZzNGcy9tK3FqVllRZS9MNDZo?=
 =?utf-8?B?MHZpcTRCVU83SVhwSlRodVVVTjNPTUxqMXoydFlvaHlwaXVqaEZDdEV5TDdU?=
 =?utf-8?B?a3hCL09pV0Z6a0EyZGRrUEJWeDVNNUxWVHVGRmx6Y2wxQndEekNtTUlWU3Ro?=
 =?utf-8?B?MzMrTHp2Y1VWZnNVRXZzVHZpaVIyNjNrLzZmKzJ5ZUp1RkJwWExCdXE0eExG?=
 =?utf-8?Q?YLuYIfDsbh/D9M9h7nUzTyMR6?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:58:29.3222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b127398a-ef91-42e6-5fc3-08de3e4e4978
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176

From: Or Har-Toov <ohartoov@nvidia.com>=0D
=0D
Currently, vports report only their parent's uplink speed, which in LAG=0D
setups does not reflect the true aggregated bandwidth. This makes it=0D
hard for upper-layer software to optimize load balancing decisions=0D
based on accurate bandwidth information.=0D
=0D
Fix the issue by calculating the possible maximum speed of a LAG as=0D
the sum of speeds of all active uplinks that are part of the LAG.=0D
Propagate this effective max speed to vports associated with the LAG=0D
whenever a relevant event occurs, such as physical port link state=0D
changes or LAG creation/modification.=0D
=0D
With this change, upper-layer components receive accurate bandwidth=0D
information corresponding to the active members of the LAG and can=0D
make better load balancing decisions.=0D
=0D
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>=0D
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>=0D
Reviewed-by: Mark Bloch <mbloch@nvidia.com>=0D
Signed-off-by: Edward Srouji <edwards@nvidia.com>=0D
---=0D
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  | 158 +++++++++++++++++=
++++=0D
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |   9 ++=0D
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   1 +=0D
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |  24 ++++=0D
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |  45 ++++++=0D
 include/linux/mlx5/vport.h                         |   4 +=0D
 6 files changed, 241 insertions(+)=0D
=0D
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/lag/lag.c=0D
index 1ac933cd8f02..a042612dcde6 100644=0D
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c=0D
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c=0D
@@ -996,6 +996,126 @@ static bool mlx5_lag_should_disable_lag(struct mlx5_l=
ag *ldev, bool do_bond)=0D
 	       ldev->mode !=3D MLX5_LAG_MODE_MPESW;=0D
 }=0D
 =0D
+#ifdef CONFIG_MLX5_ESWITCH=0D
+static int=0D
+mlx5_lag_sum_devices_speed(struct mlx5_lag *ldev, u32 *sum_speed,=0D
+			   int (*get_speed)(struct mlx5_core_dev *, u32 *))=0D
+{=0D
+	struct mlx5_core_dev *pf_mdev;=0D
+	int pf_idx;=0D
+	u32 speed;=0D
+	int ret;=0D
+=0D
+	*sum_speed =3D 0;=0D
+	mlx5_ldev_for_each(pf_idx, 0, ldev) {=0D
+		pf_mdev =3D ldev->pf[pf_idx].dev;=0D
+		if (!pf_mdev)=0D
+			continue;=0D
+=0D
+		ret =3D get_speed(pf_mdev, &speed);=0D
+		if (ret) {=0D
+			mlx5_core_dbg(pf_mdev,=0D
+				      "Failed to get device speed using %ps. Device %s speed is not av=
ailable (err=3D%d)\n",=0D
+				      get_speed, dev_name(pf_mdev->device),=0D
+				      ret);=0D
+			return ret;=0D
+		}=0D
+=0D
+		*sum_speed +=3D speed;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int mlx5_lag_sum_devices_max_speed(struct mlx5_lag *ldev, u32 *max_=
speed)=0D
+{=0D
+	return mlx5_lag_sum_devices_speed(ldev, max_speed,=0D
+					  mlx5_port_max_linkspeed);=0D
+}=0D
+=0D
+static void mlx5_lag_modify_device_vports_speed(struct mlx5_core_dev *mdev=
,=0D
+						u32 speed)=0D
+{=0D
+	u16 op_mod =3D MLX5_VPORT_STATE_OP_MOD_ESW_VPORT;=0D
+	struct mlx5_eswitch *esw =3D mdev->priv.eswitch;=0D
+	struct mlx5_vport *vport;=0D
+	unsigned long i;=0D
+	int ret;=0D
+=0D
+	if (!esw)=0D
+		return;=0D
+=0D
+	if (!MLX5_CAP_ESW(mdev, esw_vport_state_max_tx_speed))=0D
+		return;=0D
+=0D
+	mlx5_esw_for_each_vport(esw, i, vport) {=0D
+		if (!vport)=0D
+			continue;=0D
+=0D
+		if (vport->vport =3D=3D MLX5_VPORT_UPLINK)=0D
+			continue;=0D
+=0D
+		ret =3D mlx5_modify_vport_max_tx_speed(mdev, op_mod,=0D
+						     vport->vport, true, speed);=0D
+		if (ret)=0D
+			mlx5_core_dbg(mdev,=0D
+				      "Failed to set vport %d speed %d, err=3D%d\n",=0D
+				      vport->vport, speed, ret);=0D
+	}=0D
+}=0D
+=0D
+void mlx5_lag_set_vports_agg_speed(struct mlx5_lag *ldev)=0D
+{=0D
+	struct mlx5_core_dev *mdev;=0D
+	u32 speed;=0D
+	int pf_idx;=0D
+=0D
+	speed =3D ldev->tracker.bond_speed_mbps;=0D
+=0D
+	if (speed =3D=3D SPEED_UNKNOWN)=0D
+		return;=0D
+=0D
+	/* If speed is not set, use the sum of max speeds of all PFs */=0D
+	if (!speed && mlx5_lag_sum_devices_max_speed(ldev, &speed))=0D
+		return;=0D
+=0D
+	speed =3D speed / MLX5_MAX_TX_SPEED_UNIT;=0D
+=0D
+	mlx5_ldev_for_each(pf_idx, 0, ldev) {=0D
+		mdev =3D ldev->pf[pf_idx].dev;=0D
+		if (!mdev)=0D
+			continue;=0D
+=0D
+		mlx5_lag_modify_device_vports_speed(mdev, speed);=0D
+	}=0D
+}=0D
+=0D
+void mlx5_lag_reset_vports_speed(struct mlx5_lag *ldev)=0D
+{=0D
+	struct mlx5_core_dev *mdev;=0D
+	u32 speed;=0D
+	int pf_idx;=0D
+	int ret;=0D
+=0D
+	mlx5_ldev_for_each(pf_idx, 0, ldev) {=0D
+		mdev =3D ldev->pf[pf_idx].dev;=0D
+		if (!mdev)=0D
+			continue;=0D
+=0D
+		ret =3D mlx5_port_oper_linkspeed(mdev, &speed);=0D
+		if (ret) {=0D
+			mlx5_core_dbg(mdev,=0D
+				      "Failed to reset vports speed for device %s. Oper speed is not a=
vailable (err=3D%d)\n",=0D
+				      dev_name(mdev->device), ret);=0D
+			continue;=0D
+		}=0D
+=0D
+		speed =3D speed / MLX5_MAX_TX_SPEED_UNIT;=0D
+		mlx5_lag_modify_device_vports_speed(mdev, speed);=0D
+	}=0D
+}=0D
+#endif=0D
+=0D
 static void mlx5_do_bond(struct mlx5_lag *ldev)=0D
 {=0D
 	int idx =3D mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);=0D
@@ -1083,9 +1203,12 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)=0D
 						     ndev);=0D
 			dev_put(ndev);=0D
 		}=0D
+		mlx5_lag_set_vports_agg_speed(ldev);=0D
 	} else if (mlx5_lag_should_modify_lag(ldev, do_bond)) {=0D
 		mlx5_modify_lag(ldev, &tracker);=0D
+		mlx5_lag_set_vports_agg_speed(ldev);=0D
 	} else if (mlx5_lag_should_disable_lag(ldev, do_bond)) {=0D
+		mlx5_lag_reset_vports_speed(ldev);=0D
 		mlx5_disable_lag(ldev);=0D
 	}=0D
 }=0D
@@ -1286,6 +1409,38 @@ static int mlx5_handle_changeinfodata_event(struct m=
lx5_lag *ldev,=0D
 	return 1;=0D
 }=0D
 =0D
+static void mlx5_lag_update_tracker_speed(struct lag_tracker *tracker,=0D
+					  struct net_device *ndev)=0D
+{=0D
+	struct ethtool_link_ksettings lksettings;=0D
+	struct net_device *bond_dev;=0D
+	int err;=0D
+=0D
+	if (netif_is_lag_master(ndev))=0D
+		bond_dev =3D ndev;=0D
+	else=0D
+		bond_dev =3D netdev_master_upper_dev_get(ndev);=0D
+=0D
+	if (!bond_dev) {=0D
+		tracker->bond_speed_mbps =3D SPEED_UNKNOWN;=0D
+		return;=0D
+	}=0D
+=0D
+	err =3D __ethtool_get_link_ksettings(bond_dev, &lksettings);=0D
+	if (err) {=0D
+		netdev_dbg(bond_dev,=0D
+			   "Failed to get speed for bond dev %s, err=3D%d\n",=0D
+			   bond_dev->name, err);=0D
+		tracker->bond_speed_mbps =3D SPEED_UNKNOWN;=0D
+		return;=0D
+	}=0D
+=0D
+	if (lksettings.base.speed =3D=3D SPEED_UNKNOWN)=0D
+		tracker->bond_speed_mbps =3D 0;=0D
+	else=0D
+		tracker->bond_speed_mbps =3D lksettings.base.speed;=0D
+}=0D
+=0D
 /* this handler is always registered to netdev events */=0D
 static int mlx5_lag_netdev_event(struct notifier_block *this,=0D
 				 unsigned long event, void *ptr)=0D
@@ -1317,6 +1472,9 @@ static int mlx5_lag_netdev_event(struct notifier_bloc=
k *this,=0D
 		break;=0D
 	}=0D
 =0D
+	if (changed)=0D
+		mlx5_lag_update_tracker_speed(&tracker, ndev);=0D
+=0D
 	ldev->tracker =3D tracker;=0D
 =0D
 	if (changed)=0D
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/ne=
t/ethernet/mellanox/mlx5/core/lag/lag.h=0D
index 4918eee2b3da..8de5640a0161 100644=0D
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h=0D
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h=0D
@@ -48,6 +48,7 @@ struct lag_tracker {=0D
 	unsigned int is_bonded:1;=0D
 	unsigned int has_inactive:1;=0D
 	enum netdev_lag_hash hash_type;=0D
+	u32 bond_speed_mbps;=0D
 };=0D
 =0D
 /* LAG data of a ConnectX card.=0D
@@ -116,6 +117,14 @@ int mlx5_deactivate_lag(struct mlx5_lag *ldev);=0D
 void mlx5_lag_add_devices(struct mlx5_lag *ldev);=0D
 struct mlx5_devcom_comp_dev *mlx5_lag_get_devcom_comp(struct mlx5_lag *lde=
v);=0D
 =0D
+#ifdef CONFIG_MLX5_ESWITCH=0D
+void mlx5_lag_set_vports_agg_speed(struct mlx5_lag *ldev);=0D
+void mlx5_lag_reset_vports_speed(struct mlx5_lag *ldev);=0D
+#else=0D
+static inline void mlx5_lag_set_vports_agg_speed(struct mlx5_lag *ldev) {}=
=0D
+static inline void mlx5_lag_reset_vports_speed(struct mlx5_lag *ldev) {}=0D
+#endif=0D
+=0D
 static inline bool mlx5_lag_is_supported(struct mlx5_core_dev *dev)=0D
 {=0D
 	if (!MLX5_CAP_GEN(dev, vport_group_manager) ||=0D
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/=
net/ethernet/mellanox/mlx5/core/mlx5_core.h=0D
index cfebc110c02f..9fdb9a543cf1 100644=0D
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h=0D
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h=0D
@@ -381,6 +381,7 @@ const struct mlx5_link_info *mlx5_port_ptys2info(struct=
 mlx5_core_dev *mdev,=0D
 u32 mlx5_port_info2linkmodes(struct mlx5_core_dev *mdev,=0D
 			     struct mlx5_link_info *info,=0D
 			     bool force_legacy);=0D
+int mlx5_port_oper_linkspeed(struct mlx5_core_dev *mdev, u32 *speed);=0D
 int mlx5_port_max_linkspeed(struct mlx5_core_dev *mdev, u32 *speed);=0D
 =0D
 #define MLX5_PPS_CAP(mdev) (MLX5_CAP_GEN((mdev), pps) &&		\=0D
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/e=
thernet/mellanox/mlx5/core/port.c=0D
index 85a9e534f442..83044c9b6b41 100644=0D
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c=0D
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c=0D
@@ -1200,6 +1200,30 @@ u32 mlx5_port_info2linkmodes(struct mlx5_core_dev *m=
dev,=0D
 	return link_modes;=0D
 }=0D
 =0D
+int mlx5_port_oper_linkspeed(struct mlx5_core_dev *mdev, u32 *speed)=0D
+{=0D
+	const struct mlx5_link_info *table;=0D
+	struct mlx5_port_eth_proto eproto;=0D
+	u32 oper_speed =3D 0;=0D
+	u32 max_size;=0D
+	bool ext;=0D
+	int err;=0D
+	int i;=0D
+=0D
+	ext =3D mlx5_ptys_ext_supported(mdev);=0D
+	err =3D mlx5_port_query_eth_proto(mdev, 1, ext, &eproto);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	mlx5e_port_get_link_mode_info_arr(mdev, &table, &max_size, false);=0D
+	for (i =3D 0; i < max_size; ++i)=0D
+		if (eproto.oper & MLX5E_PROT_MASK(i))=0D
+			oper_speed =3D max(oper_speed, table[i].speed);=0D
+=0D
+	*speed =3D oper_speed;=0D
+	return 0;=0D
+}=0D
+=0D
 int mlx5_port_max_linkspeed(struct mlx5_core_dev *mdev, u32 *speed)=0D
 {=0D
 	const struct mlx5_link_info *table;=0D
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/=
ethernet/mellanox/mlx5/core/vport.c=0D
index 306affbcfd3b..78b1b291cfa4 100644=0D
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c=0D
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c=0D
@@ -62,6 +62,28 @@ u8 mlx5_query_vport_state(struct mlx5_core_dev *mdev, u8=
 opmod, u16 vport)=0D
 	return MLX5_GET(query_vport_state_out, out, state);=0D
 }=0D
 =0D
+static int mlx5_query_vport_admin_state(struct mlx5_core_dev *mdev, u8 opm=
od,=0D
+					u16 vport, u8 other_vport,=0D
+					u8 *admin_state)=0D
+{=0D
+	u32 out[MLX5_ST_SZ_DW(query_vport_state_out)] =3D {};=0D
+	u32 in[MLX5_ST_SZ_DW(query_vport_state_in)] =3D {};=0D
+	int err;=0D
+=0D
+	MLX5_SET(query_vport_state_in, in, opcode,=0D
+		 MLX5_CMD_OP_QUERY_VPORT_STATE);=0D
+	MLX5_SET(query_vport_state_in, in, op_mod, opmod);=0D
+	MLX5_SET(query_vport_state_in, in, vport_number, vport);=0D
+	MLX5_SET(query_vport_state_in, in, other_vport, other_vport);=0D
+=0D
+	err =3D mlx5_cmd_exec_inout(mdev, query_vport_state, in, out);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	*admin_state =3D MLX5_GET(query_vport_state_out, out, admin_state);=0D
+	return 0;=0D
+}=0D
+=0D
 int mlx5_modify_vport_admin_state(struct mlx5_core_dev *mdev, u8 opmod,=0D
 				  u16 vport, u8 other_vport, u8 state)=0D
 {=0D
@@ -77,6 +99,29 @@ int mlx5_modify_vport_admin_state(struct mlx5_core_dev *=
mdev, u8 opmod,=0D
 	return mlx5_cmd_exec_in(mdev, modify_vport_state, in);=0D
 }=0D
 =0D
+int mlx5_modify_vport_max_tx_speed(struct mlx5_core_dev *mdev, u8 opmod,=0D
+				   u16 vport, u8 other_vport, u16 max_tx_speed)=0D
+{=0D
+	u32 in[MLX5_ST_SZ_DW(modify_vport_state_in)] =3D {};=0D
+	u8 admin_state;=0D
+	int err;=0D
+=0D
+	err =3D mlx5_query_vport_admin_state(mdev, opmod, vport, other_vport,=0D
+					   &admin_state);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	MLX5_SET(modify_vport_state_in, in, opcode,=0D
+		 MLX5_CMD_OP_MODIFY_VPORT_STATE);=0D
+	MLX5_SET(modify_vport_state_in, in, op_mod, opmod);=0D
+	MLX5_SET(modify_vport_state_in, in, vport_number, vport);=0D
+	MLX5_SET(modify_vport_state_in, in, other_vport, other_vport);=0D
+	MLX5_SET(modify_vport_state_in, in, admin_state, admin_state);=0D
+	MLX5_SET(modify_vport_state_in, in, max_tx_speed, max_tx_speed);=0D
+=0D
+	return mlx5_cmd_exec_in(mdev, modify_vport_state, in);=0D
+}=0D
+=0D
 static int mlx5_query_nic_vport_context(struct mlx5_core_dev *mdev, u16 vp=
ort,=0D
 					bool other_vport, u32 *out)=0D
 {=0D
diff --git a/include/linux/mlx5/vport.h b/include/linux/mlx5/vport.h=0D
index f876bfc0669c..2acf10e9f60a 100644=0D
--- a/include/linux/mlx5/vport.h=0D
+++ b/include/linux/mlx5/vport.h=0D
@@ -41,6 +41,8 @@=0D
 	 (MLX5_CAP_GEN(mdev, port_type) =3D=3D MLX5_CAP_PORT_TYPE_ETH) &&	\=0D
 	 mlx5_core_is_pf(mdev))=0D
 =0D
+#define MLX5_MAX_TX_SPEED_UNIT 100=0D
+=0D
 enum {=0D
 	MLX5_CAP_INLINE_MODE_L2,=0D
 	MLX5_CAP_INLINE_MODE_VPORT_CONTEXT,=0D
@@ -58,6 +60,8 @@ enum {=0D
 u8 mlx5_query_vport_state(struct mlx5_core_dev *mdev, u8 opmod, u16 vport)=
;=0D
 int mlx5_modify_vport_admin_state(struct mlx5_core_dev *mdev, u8 opmod,=0D
 				  u16 vport, u8 other_vport, u8 state);=0D
+int mlx5_modify_vport_max_tx_speed(struct mlx5_core_dev *mdev, u8 opmod,=0D
+				   u16 vport, u8 other_vport, u16 max_tx_speed);=0D
 int mlx5_query_nic_vport_mac_address(struct mlx5_core_dev *mdev,=0D
 				     u16 vport, bool other, u8 *addr);=0D
 int mlx5_query_mac_address(struct mlx5_core_dev *mdev, u8 *addr);=0D
=0D
-- =0D
2.47.1=0D
=0D

