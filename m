Return-Path: <linux-rdma+bounces-11526-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD297AE3114
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 19:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5F71702B9
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 17:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0A0154426;
	Sun, 22 Jun 2025 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Okhchgfs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D651F8908;
	Sun, 22 Jun 2025 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750613004; cv=fail; b=kLH4T9ZUW93mH//AUWYj6USiFS1FHFFNChV3KFqE5od/o9ApUYjJ22Q6DcRz8lr3mTQBPtQxgg6OexzDEO3RMcWNbjUjLA+fEaNspeKlPsmrA2rJfb257GgK6IaU+ncycpgu8Y5K19KnDyo5JJf41bs+5wmnYKON8FJIjxqO048=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750613004; c=relaxed/simple;
	bh=yU9qX4QWkdm0HiJGgvc6bhcrfjQpBUuzUWMC3nmhf30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPMNJw3tudNvR3tVGAV54d4vvwfFW3Ajqb3wHAlVy0rTw2tVtsQZeLuo3eNOdrI9RvY3PQavP7mJ3+u6AVzONx/oonMNNSTgSm0IOhDiFBgIsdPAvXbTRp1WqdOEImNRjnYu8sxudTaAPnhYsC8DS0/IhbdERCY8tyuqX4eBXhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Okhchgfs; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gffoabK5+K6SQeWv0eStM9i96wGUd+XwhVOMD4vN0Ztw22Us8wRjY5l+kECfPdv1gBklYcXmqAUar9TdxR9UV6EFRSP65wH/TAwKjq4YidCMVOlOyhiEmbX12da/oH4kB7aVf5XKDboaONZKfT97HNX4jJWRS7CDui2afo49s302pD71fdBjR0KsbmpWuZlDx4f5Mqn0GunoJH1TZdi68rNzXKzZNSxISAHDiZ6Viu2I9f3pjBv9U9oy0pSwuZwoKWfTGllaq2MjZE2jvTGfAUOEksmkcdnKa8PeCyOP6oqzSVVb7OcqLXUU2Sguuul9zDeXUlixi3J+ckzr02Uh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7gy8/RtDH03zPU87GIEWJlarXtse1XhrcI/p0mpGOM=;
 b=C9eKDLIOY/nGm/re390tYEIk67GdOZpWdlXNLsnT9eGZ5bn2gmkHTMHd7wUHcRUd9QqorEmOgGtvZSwan2WWVqxKKJPFprpaX7kANkKd3AzDI6A3KeHk6XJ/KUDyM/AAHpq8pro5M9G+gipP03loXCgxxvT6Ga5ygomGwatxIRwC6HXc1drQhZ2SIpcKPIeXDXYGnkjy676m6swLlPZtJ8mAl1/6PcnrO/gt/Gb8LnPhPawAjerngMWqjnLKxEk8QLYxfhmOR9A9gL2MGJyFBeMa/fFCMJ0hECmpi4qKmSuN5YhP8rjR4WGhq4Egd+U0JY5V6bDdzljKDlLdhEw5SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7gy8/RtDH03zPU87GIEWJlarXtse1XhrcI/p0mpGOM=;
 b=Okhchgfss4FusrYeSMgWmKcWbkC+UJTnBEBWgCFGo/vQfpIaRg8c/JTfEk7i1smhOyIUYlPRZeA9AqJhWTUX1IMdnXZwrmPMFU6U/0/g+c/DHdw5KHNlMKabePahuRe5mE7FZuZ90z0s4g575dmAvjJ129XqVgWNTWOLDmmuk9OehBwwXGxoD16hDZy1goV+GIyxg7yP/BbsX+9+yy35EG+GBUhLu8okdtwXAjV4oWC39vnXyiswpD5nO310gyMUdcspkyWTph6Fr+hPwQrvoOd2bvdVl5LMQrN+l6y3SqRIdZgnJmMWr55jxvlVZsE7MRBlqgZtwbPjra2kgAyRJw==
Received: from BN9PR03CA0192.namprd03.prod.outlook.com (2603:10b6:408:f9::17)
 by PH7PR12MB7186.namprd12.prod.outlook.com (2603:10b6:510:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Sun, 22 Jun
 2025 17:23:17 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::f8) by BN9PR03CA0192.outlook.office365.com
 (2603:10b6:408:f9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.28 via Frontend Transport; Sun,
 22 Jun 2025 17:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Sun, 22 Jun 2025 17:23:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 22 Jun
 2025 10:23:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 22 Jun 2025 10:23:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 22 Jun 2025 10:23:10 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v2 8/8] net/mlx5: Add HWS as secondary steering mode
Date: Sun, 22 Jun 2025 20:22:26 +0300
Message-ID: <20250622172226.4174-9-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250622172226.4174-1-mbloch@nvidia.com>
References: <20250622172226.4174-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|PH7PR12MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: a930569c-70ed-4671-15f1-08ddb1b179f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5fCZgDAO+yEG1Z+VscjLFdpjMYzsHkONf7rQfe1y0Zk2Ep/aYX5KNF7GemiQ?=
 =?us-ascii?Q?dK8sFgpPpVRut6mOuG1brEaF2rDQG9H/gMgOTXrirX39b8l7Cv0uCyfzCYIm?=
 =?us-ascii?Q?fNWiXj4jbuYhF5hkrIAvJ2g3XHtKDs2fiS3MgyF0Xt5pZ2OjvwAXw4ml6C/W?=
 =?us-ascii?Q?Nogfgi/nrzx6JiwVlt9XQuUZfXt4Y6aGQhVonl/hso4ooyqb0yINcrFrl0mq?=
 =?us-ascii?Q?ywDCEC69ORCd7zoLJKargQx+xemYD9x3ilra+Xl2CgRzYs7RTepxSPPbr2uO?=
 =?us-ascii?Q?5KPTQOORVaZEXuq0ERrwFAhOiythlhW4Zgcih/RoCrCqp6hc17bU6dqs8ast?=
 =?us-ascii?Q?m7RoUkYNH+Yt6ixANkKq8ku4uN7Tb0dghUQAdEUwF9R4tSDVmXy15b6ZvWzo?=
 =?us-ascii?Q?JUvYSFtdLA9jRaKByDZKcNSZ+929E9FzlNaYeN5ajaKSG5WihANlZtPewdSj?=
 =?us-ascii?Q?EafbBT7Lk0rhW0jQQyrWG/Xn4MTRZ7Lz7s+qSqOgIhF77Iset/YBDHSjxWEo?=
 =?us-ascii?Q?niLCP49kWqQ30HU39PKHdwM+asNY0B1zEB1qJhU7H1aW6ZWM3iSDW9WxJpiH?=
 =?us-ascii?Q?6vw+GUepra8c10/XB2YTrXQrZort0PP7npkPtLbPI40GZyHREok2YBbbeZHy?=
 =?us-ascii?Q?xhunOPKw1HbFjnvWyqXnP0khdPCUF33He3miv3KxqwVa6cV6DHYncxiBdav2?=
 =?us-ascii?Q?SJYO8MKHRFjwDTuLElxPH47PqCFQmBx3JYyZb33m+Bd86CKGtj21zt4JBHNj?=
 =?us-ascii?Q?X0kgiBPRVAaKLRpibfi3Sd0SEh2oM9sjPSYPyy8wQM+p/vWOi/BX+MHVkTCL?=
 =?us-ascii?Q?z+8kC2G8eOjviu5nEe05DprmNEH2/M7uiwgOAMQka9c9AS5QRVbj52SEVRMz?=
 =?us-ascii?Q?ZzBV8LelRPcsQBUNplbwcvHVtQ53GNFEeJDfloJUP+qxUmcFNIx34WlWk/u5?=
 =?us-ascii?Q?ObhwIie3xziEd8FlNHn5XpE2z//WeA3K1wZTJJyJ8BVc/Y5Uv9xpNAaqzVzi?=
 =?us-ascii?Q?aBuihpckhw5pMGsfG22iX/5Ea+8mctmXEPiJqs/CXNhHhEliH3g/w4EE1hPP?=
 =?us-ascii?Q?3jHppV26OtQnBnslt1VfASB9fK4vPijEK6R4nP6monR3moz0WSMK3+PHEmQq?=
 =?us-ascii?Q?HGmvNjWjfixfHaBd74m4PaOvtpIc6aWkU94WhgpTjbbyt7TZpXVHANY6KrpO?=
 =?us-ascii?Q?m4iVRiLXsox3etljeFdj77uDhrR8twFx0J2VNxEwh9O8fmhkrhuZNppXTL0B?=
 =?us-ascii?Q?S6ojz8vvHxHwhMA4s+tiSeRTwjXJnSpM3WU1Fmm/4CW7s1RzI1NXGeBAzerL?=
 =?us-ascii?Q?QrUAWNEASGM5A0VyFK599SXsMqHuzjrjtvOCpuILRphetiM/vPIbx5fsPgjK?=
 =?us-ascii?Q?cnZaVMp8bHF3KeHNZnpb/SOoJyovvSxO0YfVTLPFHKV61/LEu5gLwIN8XNye?=
 =?us-ascii?Q?VJHDCWLgL7cyvjlqICw/v+TSgryEE74aFVxfG8a1RwjaXLQ/xpzjF2hMKA+N?=
 =?us-ascii?Q?C4EmmRlugCkm/7Eq8tnGG/0KPZhsa9UD83Ah?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2025 17:23:16.8542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a930569c-70ed-4671-15f1-08ddb1b179f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7186

From: Moshe Shemesh <moshe@nvidia.com>

Add HW Steering (HWS) as a secondary option for device steering mode. If
the device does not support SW Steering (SWS), HW Steering will be used
as the default, provided it is supported. FW Steering will now be
selected as the default only if both HWS and SWS are unavailable.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index a8046200d376..f30fc793e1fb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3919,6 +3919,8 @@ int mlx5_fs_core_alloc(struct mlx5_core_dev *dev)
 
 	if (mlx5_fs_dr_is_supported(dev))
 		steering->mode = MLX5_FLOW_STEERING_MODE_SMFS;
+	else if (mlx5_fs_hws_is_supported(dev))
+		steering->mode = MLX5_FLOW_STEERING_MODE_HMFS;
 	else
 		steering->mode = MLX5_FLOW_STEERING_MODE_DMFS;
 
-- 
2.34.1


