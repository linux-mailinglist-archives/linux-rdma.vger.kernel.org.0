Return-Path: <linux-rdma+bounces-12211-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8659B06EEF
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 09:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D6F3A74B8
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 07:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD1B28B7C8;
	Wed, 16 Jul 2025 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QQJQuibo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD8326B97D;
	Wed, 16 Jul 2025 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651013; cv=fail; b=rwMnic01JN0etb0xOlc70Ql4S4r0q4lo2KJiOk0skziLgpgDa1bK9RUijValMvGTzN2EmYNYPQjBebpluwDWV6Vg0nn5O2d4sJ9BA6eT0mVtPE3qTzss42s1o4PbhzQKV8yQ/ko5iq21NpBhixZ7NueYC1Awy8RNyyPrR0p57/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651013; c=relaxed/simple;
	bh=N8P6s8t9sIYGKLFKNfFdmB9VJJBc+M/+tjbs8B4pRFU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mG72vp055z6pmMlz9jymVLuKiH/FOTLz9dtBDu5ORLXzsju8BYWwADG3kQ5hGBB3SwVNf0MkLSeHW0o6SejKle3K83TClaaOmXCtyjSQ8jN2ee3gKNHyvOEJbsenGqAUVOsrkhuVgBj2CIp0GC4R0NgPUEMtF+bBfdD4czLdDEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QQJQuibo; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPUcg4KZGAdOB93q/KXu4wxbdE0HNyuZfqOto442TsxRRqE2IBNBu91wXTIA7DhomovOZe0kVek/8OvfiI97L22K1oSL5gqmgL+aC4PxWT3AtEYtGkjdXOBYhlosRvyLTO3wd43rLli5LflUl2Kh2xwFZ9ZobZ3BupJMUG83XKuLftkkU+sHGLoyarU0awOICs5oOpcoUsp6PtWYV0nhkEITENxwTlK3vFQE4LcmOTcncfg71znQ0SNNvZg+cwuLdTjNY30LTEAM5v7kkZsSyKEL7b6f1rvimZ5Oh56DUMBICFyJZE7g1xTmL1hPCQrI3Ct34iQdRUspjSSbAJeMPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XX0p6QXDoHlqsZVJdfRpjU8ZYpmLXTc/7Hm8sPK6x4Y=;
 b=LZPCQekHKA6hWVyopdyczKn5RqiS7JYMEqoALaM65rYyuPChVX0xDH4DYBvLHTGYgxPJWiI5n2HTg4xTLxXMKdS2NewFTqJv+QEe0MYI/6bHik6vNvcgFGNyQNsd6gTNuYluBCmSdBHFANlsC9FYxdRoDdgXKhsWU/bVFZHVBHowGrCEbXjytcfnW97kJzsDSJq6xo7Hsj945atcAB4dwRDACHdz24OEYyzjeik+cOZ3hnIIHUERSKw5Ry5rc2T4Yn9y/JFGAsYPX+Kvur1uRsmZw8l1VBEiM697wkp0EnXXiM9qUkdAEtqs4swuUG4v9dAuMFjYRGbASvoKv/UP7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XX0p6QXDoHlqsZVJdfRpjU8ZYpmLXTc/7Hm8sPK6x4Y=;
 b=QQJQuiboaMnHsrraN0TOuIjBiIfO0aGIMJqA3FvEnxPlrDVpV77p4NAbm97vLS5nc/4TXE/LucsV80uATw42bkvXJeLqMd/iTKHMz6n+KuQcDQ2x3fcrNHOrnd81SrokUbeqoEg05WShEuvZXEhVnDRnpYjbQmG8IYgxKjH3hDyLjS9xKRZr0C3WNImJU1TGGt0tKUjpqq6eLD/RZSXxWLSTSvTBJstiSopqOU1kGoR0m3TOVOVoBg64/Tt0SjGA4SAYMOgY/JNZQrjWYMZg80FYgxyPFLd2HPWSMc8BEJg2mqGJ6CtA5VQ8hwPuFY6lVUIZGOyAKvNVb31Tbp7T2Q==
Received: from BL1PR13CA0010.namprd13.prod.outlook.com (2603:10b6:208:256::15)
 by DS2PR12MB9710.namprd12.prod.outlook.com (2603:10b6:8:276::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:30:05 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:208:256:cafe::2) by BL1PR13CA0010.outlook.office365.com
 (2603:10b6:208:256::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 07:30:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.1 via Frontend Transport; Wed, 16 Jul 2025 07:30:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 00:29:45 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Jul
 2025 00:29:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 16
 Jul 2025 00:29:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH net] net/mlx5: Update the list of the PCI supported devices
Date: Wed, 16 Jul 2025 10:29:29 +0300
Message-ID: <1752650969-148501-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|DS2PR12MB9710:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad00e24-367e-465f-162b-08ddc43a959d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3nl/6OhY3f3Re17OpP5NAoGnwH7JyHwiU/XtPbg/MUQ4ZWf1KzVsKqaSsa+e?=
 =?us-ascii?Q?MhKkFJbs23iapBsSxbRXewyPMBtSssMY2NhHFGKMmLwJ3eUnnjOCCplRQzKe?=
 =?us-ascii?Q?ZDMt6W8+NxoLyYYl2r1eSlKkYF/9mh6bgbhY6kzoCb0392eq7QutHCj9yMXa?=
 =?us-ascii?Q?RsW8K9QK+n6e0XDh9j7jjiriL0NCr5NmErrDomN9XBGALQ6DFqmlMuexrqKy?=
 =?us-ascii?Q?sWrLQ5Z8kL1sgPs4bIIZFWdpU54lvRetfw23/6k4Ey1tZUNnXldFuC639Vdx?=
 =?us-ascii?Q?jgbLpSudW4xrhkBAKCCWKxIY+rqmuunC4eq+GzXMiDrHyNIceIAokWvFSLHx?=
 =?us-ascii?Q?Z4NU1FLM7St3lPkJd7fza5u9fFAmB1HVjlPSDjDlmNCcvJoQbMcYpWLDJWMV?=
 =?us-ascii?Q?4pmfnnZJ6vXhQYZHv+C14w4ylfVl4cqW9CU80p8uiOrJZMxbjcte3+cvoWS1?=
 =?us-ascii?Q?lF2VOqqHVAQC0k0XBVOOgnHsuHlO7fMErkpWR0veQuzvgguMxzOQrHpyBgg9?=
 =?us-ascii?Q?LRyjFfJ5MtvVC82hfSx428e165urTzuv+SMGY6BBtSzfKm86u12uT3zXOj54?=
 =?us-ascii?Q?G5jCHTtgREdR7FtXCBqsPRREYlxG/PMANDOahRj9//GyZpOuxchwIjbiwFRw?=
 =?us-ascii?Q?gsX8i3mSFbZ7efVzqWAokGhaQOSFnYnGjTQqufhhD2mrpmCJ/b0e0gY2/pxS?=
 =?us-ascii?Q?bTbmDle3i3bgk4XwpElH7wrMDZLdWJsu9uWTuF7gjlPX20MBFlFevEneMRYx?=
 =?us-ascii?Q?J79cohYpJgJ21EmwIfB3nWv2k5uYT+kd8bUs6mISTlcomj5untMhofn4EG4R?=
 =?us-ascii?Q?hudvo7yy5/Cm9nsmgOqWQy6459Tj0oPkEz/8dzPjxwMdytJtmmBWjgP2yA9K?=
 =?us-ascii?Q?8aX58NjlbB3syWEfJhA2s0SbGjuqF7cgtMRlgysnV72egv26KiBsiwxB6vgz?=
 =?us-ascii?Q?X0m6GCL3A7fX8sf7M1PcbUIrrhTZAzydQbNQaN+YCBtkueFdS2ayML2vW2X/?=
 =?us-ascii?Q?9tDxMS+PitCw5e+Sx2ELeGO0PjnafoVRprd0ruuhc9Ak/UqslB5CbBPAsMtr?=
 =?us-ascii?Q?BYSODMZUY/x9f4NJbCT+axkcqd8N0JKVx9OtYk1tdy9qm6nPnZSQuEuw4n6h?=
 =?us-ascii?Q?bu68EwquPg4oIY8/BE0rftqO7+AIXuHlc4kcgIGDtEX+sfX8k+8uzphvS670?=
 =?us-ascii?Q?AOa9MFTHvxDUO2zZFy649xAFrzUU9xHS9VWwuYXcpsTMZPDVvXK14mImUwNJ?=
 =?us-ascii?Q?+u3PN3eMoN19IS6w+2DHdbXmKHuR9mTLHSeTobR0cLQGPlknE6dqVSIIm1rc?=
 =?us-ascii?Q?Srv/+ddcMQBnBYTVCZsE89MJ+nutlHuQfv2pV5dJx0sMzgYw7DhI3hOuuwh4?=
 =?us-ascii?Q?6mqXN9iuGdm6f8Pi0RYVM/TmTK9rmeFexABTBa01OFmRYSptmqXnn9L9zJk9?=
 =?us-ascii?Q?trDDavUyzlNg9CY5ifcM+Y8amLEF44kY62rDMKbbE1636LPnDjRdB2y7f2dQ?=
 =?us-ascii?Q?50pItMEzeV98Cqo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:30:05.1936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad00e24-367e-465f-162b-08ddc43a959d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9710

From: Maor Gottlieb <maorg@nvidia.com>

Add the upcoming ConnectX-10 device ID to the table of supported
PCI device IDs.

Fixes: 7472d157cb80 ("net/mlx5: Update the list of the PCI supported devices")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Eran Ben Elisha <eranbe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 41e8660c819c..9c1504d29d34 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -2257,6 +2257,7 @@ static const struct pci_device_id mlx5_core_pci_table[] = {
 	{ PCI_VDEVICE(MELLANOX, 0x1021) },			/* ConnectX-7 */
 	{ PCI_VDEVICE(MELLANOX, 0x1023) },			/* ConnectX-8 */
 	{ PCI_VDEVICE(MELLANOX, 0x1025) },			/* ConnectX-9 */
+	{ PCI_VDEVICE(MELLANOX, 0x1027) },			/* ConnectX-10 */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d2) },			/* BlueField integrated ConnectX-5 network controller */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d3), MLX5_PCI_DEV_IS_VF},	/* BlueField integrated ConnectX-5 network controller VF */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d6) },			/* BlueField-2 integrated ConnectX-6 Dx network controller */

base-commit: dae7f9cbd1909de2b0bccc30afef95c23f93e477
-- 
2.31.1


