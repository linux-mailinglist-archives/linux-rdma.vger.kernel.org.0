Return-Path: <linux-rdma+bounces-12797-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B09B294F8
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 22:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9002F203AF4
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 20:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9368F23F26A;
	Sun, 17 Aug 2025 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="arSKGAkq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D531218A6DB;
	Sun, 17 Aug 2025 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755462223; cv=fail; b=rM6goYrrzlSizYn2r+o89VEV0pjj/cucizzukkssiHefV8w15kbjFvGIIUxPOCnS0YnnDlbo6c2dQFNne+CEHoL5iJ0S/Xoc9BfwvqhORKyJUGLJ7Nf9Pb77GgoXMmWkNVO+jHXt+xjiLr4v3A+CpS78zzgwjngkN3LAXStxxZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755462223; c=relaxed/simple;
	bh=O+8hDs7Vhxe7K2bS/AgjzTjeOHHzaXcJs0/YcWSGLa0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKMhGFrthbzjhKKgFqZ6OFyA5FkIW09rSpm4wwaGwKOL3ZUFo8gCVfJ4WxZl7UxUL0lc3zpD7IDP9ZXpvcc09poYV3mErBeff9FA/2QIERPjUVrAbQJylKVMbi86CZ6RrT1FhSzJUUoEb26czRMmDkNYBRhDKsDxUwCD2Q3aXYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=arSKGAkq; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfCoTC/GIEWXo8G4FH42K62qSW5M8eBsWfXbSOy9GKzsIQyldhoYJyLSIfBAH6Fr6uZWQwJaeLpAi2Is1YQ6WWdQKbSouvvS3++/a9Ej5P9OVbiROMblrR0i7YcsUoy+Dx0vc6cvVCx6Fj2G6AxUwVevVDpNQ/AI84VQlR6sAkHQE3oO/zAHq1QZ5ZIOqJLYQGg/cSHcY/hMjYV3b8JVKUaD53ZsdHX+/XoT3LHJdWSNVFpAPxtvAc29U5Kme8xT2uXdeax1VmHQFhp+gi3wmuz9BFWBy9H1FM7lP3W1cdXtNuEd9TpRTneNTyuBgo2pc+IDztxZmVVxxPSYZJaE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TQR7HqyjHUUj8x3+SNbQbQ6bnshD+b9Aidmb4wBVJw=;
 b=ICKNP1tB3JsHUVn0vEkAbPWgUwKWgGxec6btBO7pzzr/+ecO2JPHoQGRwu1J/eJON5Cg0u7IDU6UR30UifO2gUyoxjhfolDpJsSY32egHBAZXtdqz0AymQzhyo++1jVR3HQkJPYcPdBMTzRccD50mBXFp0FjLRqHBLj51876letEdYynOJeXHo1g4vDCHevx3tBggTt8XR+C1LE/b5mGkjt8HrHztkXvsLrU3drRd7S3dtjp5zrwvuOwoRhJE6d1wptFnbj9FQXSm7F7qLy0ZKG2otgCWPxBSKWNbrgVNI3i+94Xnpn0I93yHbL/7jaq2kVWq5B33L/HxrR6bCMviQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TQR7HqyjHUUj8x3+SNbQbQ6bnshD+b9Aidmb4wBVJw=;
 b=arSKGAkq1I9phOqrHrQ/3nSBIloenAcBEFF6H9OFc5WIf9Xe5xkXR1d//wCzEFm50Kq0SQgU9xoJk6njfOHtWvTBwQTEsS59hzXOafKTa9vwOvkGR6LIBibX5PNK9hhRlC56KZ3xNfNBjlJBnetBV7NeNliuDWtfrMmPwFUJneO2qrwdYzKZsyNjcgdP5wnOr24gThYxLdlzGQRYnZpCrM5f0BEyGHK8Ou7uleJ9pOb3BjrIWbUteRV1oCbP/6H+Uov6hWV0ONnwSBYk3YEFZpwFYInAkSwVhtza4E2b6wJGGD/+S4w7F4bsAkp4Zt0iJ1X0zuAxDPWPshn/hwFCDw==
Received: from CH0PR03CA0411.namprd03.prod.outlook.com (2603:10b6:610:11b::27)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Sun, 17 Aug
 2025 20:23:36 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::e5) by CH0PR03CA0411.outlook.office365.com
 (2603:10b6:610:11b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Sun,
 17 Aug 2025 20:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sun, 17 Aug 2025 20:23:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 17 Aug
 2025 13:23:35 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 17 Aug 2025 13:23:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 17 Aug 2025 13:23:31 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Itamar Gozlan
	<igozlan@nvidia.com>
Subject: [PATCH net 1/7] net/mlx5: HWS, fix bad parameter in CQ creation
Date: Sun, 17 Aug 2025 23:23:17 +0300
Message-ID: <20250817202323.308604-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250817202323.308604-1-mbloch@nvidia.com>
References: <20250817202323.308604-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: a6321f6b-7f1e-440f-1f4a-08ddddcbf237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ZBRTT+YaKmcjpos8krve2kYaqrVLrBhlvuKDE/jPwu4FDykcSJC6NWNq4HI?=
 =?us-ascii?Q?TT9zG8QCMP7ATyzafzpeVic9vk3vkbJ1Ar3sn0LIk5w+4dqM3uV+5o3k2sSs?=
 =?us-ascii?Q?CLdjum6Hg3KCX5tVl6c9eJbls7WZkH4amZELYjIboMynuR/jWcDvXdpzTUe6?=
 =?us-ascii?Q?o8eRHl4fQrmK7Mo24DC/93MDTxZFqWyBF89oqlGwvOeePwiF3r0dfZq2coob?=
 =?us-ascii?Q?gMiFqpqPUf5wwvJtLPt8fcGvn8SNUkFtKnbzW1QmheX6rr2hHFtwfpah4vK7?=
 =?us-ascii?Q?g7Nin+mogLNWZ7KLif3N+ybk71VLdgVaq7rWE62LSTndNBA36Pu1tLvmJ4WY?=
 =?us-ascii?Q?/TcW9e7lTWxOTAcrrHiFY55heOIpBjvHOO4FZ5aWslAW1mxaC/QJhgc/dktl?=
 =?us-ascii?Q?wa6EqAOZ38rSCI39+Ewh7XmfJgqqO0kKkB0pN6bpX5SGvKnIOsoRAw/aCmAw?=
 =?us-ascii?Q?xjfQ4joAF0pZcNa/EL3BEyjneReN/FzY5s0TroAC9YcR69Ki0p7+sh7ydmqu?=
 =?us-ascii?Q?q5L9+EgPEszfsEJNEYn4SxDiVn5nnz4ND1FBZoZx6AuBgtu29qql2QSKpngy?=
 =?us-ascii?Q?BgBBh747kP7juStuNCSAENzG2U76+Z0PGkP1BDWSf6wFq+J558SEIMTqf+3N?=
 =?us-ascii?Q?DYRn9ZSwhOMOtrFXCW8tvQ5H0j+PA9v54/gP6lqD7yy7Yg1QFHpPgcY6Kslo?=
 =?us-ascii?Q?AmaMb/DUzi2kNpxm1szNBYYFHaUp1gXlwP4VxlLADXu72dvNcLoH2UFjc3wU?=
 =?us-ascii?Q?A4abtww0z7JaNl75Lc4vKWaAP9BxGS55UKDJU+Bal9twG/QaAkl2SIHV4B/Y?=
 =?us-ascii?Q?Av6w4yniWVPdujFHVgAjZrsq6alYjd3SuZO9WaSlbiFQvlBzoGst+sjQTUBt?=
 =?us-ascii?Q?Rd1pLeUnjpL5g8MpH6LbRDpNP4911H0rCogzJ435s1+EFyIKphZ/rCyi6Gk5?=
 =?us-ascii?Q?qHyRPAT0Z+UUY+G6Ir7TGvv+oLt1RBWAKTjOFj9G4QkxMQbvpJ8xokvrE6Th?=
 =?us-ascii?Q?U1LK7h9kQPNLDb+5i0/Umke4C3ktF53R0114UtWl6HnCgzR0gIzbBOI2xGHA?=
 =?us-ascii?Q?sJZNme4CWJ3Z+aU8JGovLknxctnRCTQ9ahkZfoyP5aTBu4Fi6VzRAdMDtGlx?=
 =?us-ascii?Q?AgfdZhuuwmcIFN8X/ycfdslrj23wx7PDgGiYGrwTFhiK0aBnVuB/SmqyLpwf?=
 =?us-ascii?Q?cdpdrQ2euy/QOPI7Yow8Teuqx/ta3+z8Dt6OGLM7V2WYLP7xw7F5FUltf8pe?=
 =?us-ascii?Q?U2T4BNtVyvT/+Pg6//6yZU5Uf9fzhBxZ1r91RLnJTOcxtI2pNRB9SyWMHPJ2?=
 =?us-ascii?Q?OeiWxwRDO53ZRDApcjWf8G9tw6W7Z9uKiHLI0l63DvQnVoUTWRlfqwM64mEA?=
 =?us-ascii?Q?AUN9n6pvQpYgZYtVKWtvUkBwJy3uUIhOItl8e9apoRwdWxBi8GcO9Mokc9Xv?=
 =?us-ascii?Q?dUbm6705ZF88REcObnC309uqMK3NR4Lwv1OzE5SvOJgifL1IjsljLYqetsIg?=
 =?us-ascii?Q?snSPQKTsAtKbpDeATkrCsNpKEq3oh4vYtq9d?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 20:23:36.6874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6321f6b-7f1e-440f-1f4a-08ddddcbf237
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

'cqe_sz' valid value should be 0 for 64-byte CQE.

Fixes: 2ca62599aa0b ("net/mlx5: HWS, added send engine and context handling")
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
index c4b22be19a9b..b0595c9b09e4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
@@ -964,7 +964,6 @@ static int hws_send_ring_open_cq(struct mlx5_core_dev *mdev,
 		return -ENOMEM;
 
 	MLX5_SET(cqc, cqc_data, uar_page, mdev->priv.uar->index);
-	MLX5_SET(cqc, cqc_data, cqe_sz, queue->num_entries);
 	MLX5_SET(cqc, cqc_data, log_cq_size, ilog2(queue->num_entries));
 
 	err = hws_send_ring_alloc_cq(mdev, numa_node, queue, cqc_data, cq);
-- 
2.34.1


