Return-Path: <linux-rdma+bounces-12832-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08920B2DDD8
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 15:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E39FD4E536D
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 13:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D763218CA;
	Wed, 20 Aug 2025 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VHY67Ocy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C879320CDB;
	Wed, 20 Aug 2025 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696781; cv=fail; b=nOIPEvUhHcnK4MZC5tehPfKg49fYg5e8HYE7uWsA8Okf8SItb+Yvj0/+9u5mnlcuIN8/4KRilvJz1TaKy2toR2pPvS2oUgGUpzh6AlrLdGINVG3pNXzMlJDpeIBDCcngJo0rpcKGyvHIjaSLESQnSHtc1bFZXpCi+qj4kZSbZVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696781; c=relaxed/simple;
	bh=1iWr3VpmwgrC9jbZslac6dmMVPmlEcpF0PvyLjN8Xaw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLqY18WArNjUaMfTDP8xDNJI46NkUCviDRxjIk+82yWUHtdvA+V4sptdNet9jRiR9vJcMP/I2cK3sjdU3qmABQdfC2lkF+SKsYlDxmwxiD2VTb4BMNNu16SwSrH052i1zzJbBa5YDGE+kOYMSNgGFvf5wVLxQvdbRE4VELEGu0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VHY67Ocy; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S12TPwycc6Dmbf6hnF4r7K3B0vwLPFhUV6MqodfODO57apCbg16hVQpkfd1QMdP1qnovpEs/pL5XiMSSwqFrJM3f9QJuFopozBioNiydl9owWfsoQnaU+HTlgqB4mUDXBTCBPMeU4noFD+hyLKQ4eL5885OkuzOwfcufx8ZXdS4b/0U3gnN4N1hb1LN6x3D4z3ZQj5T2FKhcF14Uwcbj6frc3IpK3f7usoI8JW4rpWQNjqKZxg6jTmAdSCL76Uy+kumsBTNgV/t0Hrud35GODPW0TtUkxAOkcpY+r9n3j6OMJIGAzIIf9BCc04YTvTDeiFDzxX3qx2bI24xGFisNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTfB8vC2cQKB0KgEoL6y9IK8zyTR1wamxHZJCsXmNjA=;
 b=nXGHxssKRpLlt8EhJgwn/3kqxWkpaCvhMU4EIJrj9fiRrQQoDMdi9u6PUZ/i+CmIzVO5wFqP/p5dRk8jLNede3gX/eWPgqWz5hcIHbz+8RPLeUEgRcP56MdWZ3s/AvaPGfX0gz5iWtYvAuyPUBBz8Qs6PlaLzfvjXHFCuls89ZMZcr7sZOohN2H05cq0EImMmNVuXFyTkGkJaOftgmAlIFMnlig8IqS0qR6ybURGWyPPt2t2dUq8/MiAloRWAJ4Qwub5YBCAhIrN82jIvx4mCop6xAbam2vLMarsUwQoKkPKZnb+ApQXDD+sF09XOqaE25xWkNTtkUnj0aCqqqDFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTfB8vC2cQKB0KgEoL6y9IK8zyTR1wamxHZJCsXmNjA=;
 b=VHY67OcyPi28SAkZO+lrhX1QungQz1HhutQ4yDnuN6RmGGw1YE49fg4lT8xRFdKXS8PUzSWzU8QZAJXovYByn4lBVQsgMmRhPFLy4R0GRH1zdchzumqf6TzuI9vRrk3jdwMEO9XScHcNnQgsl7Qo1loH7WiN2KnYzagEg9neylVMWjlXqpq6FoPRH8vNVpjs/uSx2We09cPbU7RBdZ3LpobcQ92/PbHUY4ePfM3HwJeJ5vpIs36r8ddNMPvL7VHpVSg17FrclB/SOu9apnKxBZS8amvXOFUb6BE20SCh7lz13pMTwJEgPrirbmf86aGA4jrijTLxAFeeo3gIQSLJBQ==
Received: from SJ0PR03CA0219.namprd03.prod.outlook.com (2603:10b6:a03:39f::14)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 13:32:55 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::75) by SJ0PR03CA0219.outlook.office365.com
 (2603:10b6:a03:39f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 13:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 13:32:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:32:25 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:32:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 20
 Aug 2025 06:32:20 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, <przemyslaw.kitszel@intel.com>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, William Tu
	<witu@nvidia.com>
Subject: [PATCH V2 net 1/8] net/mlx5: Base ECVF devlink port attrs from 0
Date: Wed, 20 Aug 2025 16:32:02 +0300
Message-ID: <20250820133209.389065-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820133209.389065-1-mbloch@nvidia.com>
References: <20250820133209.389065-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 27599339-7336-474b-7d69-08dddfee11cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EYEI7+pPC0FCh9mTASzzeOYe/NrH3SiGgN6VzAlQHuCS2DutPKrfJl1a93gO?=
 =?us-ascii?Q?JFwdfv0d9pXLGvkWsV/vYdfvwi/785yQ5IkveuqEPuVEKO7LE1JZgIdPyf+9?=
 =?us-ascii?Q?GxcG6mWxhzaQd5bHgoBFAYIRyLJncT6SXme9wK4qmYrpSn1yOxjGFtb/7Ns+?=
 =?us-ascii?Q?R0ZEGkJSjp2dGZdDmXXZr0Oj0EaMw1ldk6NHcxj6OOsjP6YakcqyfNI+HpHf?=
 =?us-ascii?Q?iqpog3SG+pOV0cDZSXzyaelZnRnVidYUf/eNH0qSi2XIHxJxOkSF0JkSQ1P6?=
 =?us-ascii?Q?7mWdecmIkjHnrRsoIY6OcDlU9pWVwfxJgw5WY/HhjovEpBzXj6aZzwVFnOST?=
 =?us-ascii?Q?YU0v+zn6yZlkhIdyVZIFY0K3r+0wzwbZNVZ4Qroko8KMtSuINHvWavBMDl0T?=
 =?us-ascii?Q?pmKb6RaRJhv9qJ51tHFM2lxum3hjJ3zaydWcS0iZvI4kmCXIyf3+P/2QGfJL?=
 =?us-ascii?Q?i+gaQrY6W84aPPxHEY+mJ1Cc1uWanR9LJr8ff+jJEbdn3ZJKmcGH7e29W4nE?=
 =?us-ascii?Q?1qbAhcEaIqrmxgqTCESKjjmaEl0sAJLNeM90QFLLGC6wRmk18jd1YOxvHreo?=
 =?us-ascii?Q?nNvKoNlnazuk/Sh37+F6/agolgAg83alqL7o7jE6E2GXX9ceqfGlwEixIijS?=
 =?us-ascii?Q?0GmdPeTLrPGsGiNmlrwOPbvoBtGIQh/KeZnt4Jb8cXxWgpREvkb9dIZUnaES?=
 =?us-ascii?Q?PXmFYDTZD+htQ+/ntcQMHFZprTJG1a5BB6+mPQjrSXkSU7KDI8QWL44fYctK?=
 =?us-ascii?Q?oyN8AEnePa4aZccsnZDUeRUGlSTeAf6RJ7O0b+lL9H14O4hXQp2SZVSg6/+t?=
 =?us-ascii?Q?osNrmtDuf9ADXjoR/kY/phN1rHfkW8VqgybiBwAf9tL3RKtiF96+Z684XXBa?=
 =?us-ascii?Q?NQN5/9KSeyA6H/6SKX5TSj/yFAt67L1KnH2IsbzH0Twjo3JVcg1uw6OTlUq9?=
 =?us-ascii?Q?xItclD0TIOvR2dbmVuXqFYdxZgBSjucQns5lWPyUXMFOUexNYknWAhrRKBkw?=
 =?us-ascii?Q?QmxknpPYAwGdf3TwG7oN+6AJTFSlfcQcECQ/ZRWt/SM5jNNZynEV7Th+CVC3?=
 =?us-ascii?Q?MDhNRnUAXu0KXBEWRcR9zkeawhGWCpg3N46Kolzh7rsP62MsnocyzDvQ+Jde?=
 =?us-ascii?Q?LH9Q0Ax1TJZvwjQQhSYN/npe7LAv/d4INI4ZYG8OG7q+uBKK/osvt2PJAjMU?=
 =?us-ascii?Q?OjA8oCH9OA8mGRKBuMyK7YCvC63Q8JwMQCapQMD/p7xQEAN0twTuwkXBk7Oh?=
 =?us-ascii?Q?z5jaIZjht7+xE+HEGGVKyLdDUQWPPMITf7cWzVD6RJuIvfWmmgiQ477khUXy?=
 =?us-ascii?Q?A8rkzwyNnT/y1YZ5nhm0SqlsIQ8Unph3oO6Ko1MYsESUmt/8BIwW2KBiuwJy?=
 =?us-ascii?Q?nPYUk7jNX5/JAqNzS9JVidShYTP3tGyzSqbaOjWKTxgMRUKegQFDynZmUDlC?=
 =?us-ascii?Q?eE08lnMDgc5R6cBGvYWrOzWJPuvDa/E+EriaZzKvDZjm+6IKYtS2umjZBMMz?=
 =?us-ascii?Q?46rSgiirzPwXp4+iEWaFA0Nxn117NEtFcj5b?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:32:54.9097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27599339-7336-474b-7d69-08dddfee11cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452

From: Daniel Jurgens <danielj@nvidia.com>

Adjust the vport number by the base ECVF vport number so the port
attributes start at 0. Previously the port attributes would start 1
after the maximum number of host VFs.

Fixes: dc13180824b7 ("net/mlx5: Enable devlink port for embedded cpu VF vports")
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index b7102e14d23d..c33accadae0f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -47,10 +47,12 @@ static void mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(struct mlx5_eswitch *
 		devlink_port_attrs_pci_vf_set(dl_port, controller_num, pfnum,
 					      vport_num - 1, external);
 	}  else if (mlx5_core_is_ec_vf_vport(esw->dev, vport_num)) {
+		u16 base_vport = mlx5_core_ec_vf_vport_base(dev);
+
 		memcpy(dl_port->attrs.switch_id.id, ppid.id, ppid.id_len);
 		dl_port->attrs.switch_id.id_len = ppid.id_len;
 		devlink_port_attrs_pci_vf_set(dl_port, 0, pfnum,
-					      vport_num - 1, false);
+					      vport_num - base_vport, false);
 	}
 }
 
-- 
2.34.1


