Return-Path: <linux-rdma+bounces-6939-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2299BA0817E
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 21:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28DEB188C60F
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 20:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A2A200B95;
	Thu,  9 Jan 2025 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F/UWmtJ0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACCB2F43;
	Thu,  9 Jan 2025 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736455441; cv=fail; b=bTIUs/3fuzD/ohP211UjwV46CZwjG1/BhzQJ7cSzcXuwOaghBm6U9Z6hl9jMXU2DVscZWE08LA1L6r5JpzN59Gv8HUUOVIuGNgSm4xA3me+Y4CWprLs3XbesWuh3AmtbyCiK8bIi6DU9Bivv9ycR7B4cotSbOvZML5BPsvO4B5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736455441; c=relaxed/simple;
	bh=dCwdwXlYr0gaIiljOPER2o/Y8MajfrT7h6mN+Sq20EA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Leh+xQ7aI7KfBtzmSGqaqIhMUaMCgzoNeINHR1jTrQ0hEkL2b8yCG9Ut65gHhhCQUxqjgqOeHK7Gn57kD0b597HbcIU/uhyt/Y7/W+lJSoKNLdxxctk+DF+8wyAhyIgLsgPrvaqtV6d5zHKsOP79QXLd6jvByGJTnG6ejS17K90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F/UWmtJ0; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTK7n3/5ZFNG4zlbcJoDqRMV8pWOA3IFGjyQH52/dDcNLUfHEFJS/QzWKY2tjJwcNz600fvowm2TOIWD/a1Zoht3k++r61ipLRqoHB3tzF2LjIK3j9vmkaAEQOl0SQfFMu4dp2QBxIxRuGJrITm344bHhSqcz5uzV48SUsmLuFrJqxFGVWXxKvcFN5phirOMo0z3wumbA/LVG5Rr0SlJAsMzdglyqJhFdt4DDXwPyBpDbkcBeM5XUvT1cgDg0xi4eJbgbk42ZsOq8kuMCLOAbZaSdzX4D95h3duoA98xSzLE1ltDSK23rIKzuf0NBjR6rnvnrhXV1s+fhvqrre4+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3sSSuvlgwtWCaQrvZWkNkVFtW4EoJxc5XFDhqE+Cmg=;
 b=n2oI5obH+6sIBI3p31jIyJ6kE3/u1fj8PH7Noh8U0O4JoJLOvIhl6OC1j94O6Gd3t5KkiNl9r4R4g+kJvd37rieM4v83Oe3aIifyT7lx4PJhXiLJZeW//GIhNQbUMmKFFhIq8kcT6qkijiHLjfCbQ1q2AwjySX4Du1qB7FS1q0N7Mg2nHJgCNrNIN1MCCpWR9p11Och6SiQIVBrSCQBTFOY4YYyg0N/PDp6Zor+S1Rf0vWQw1LvEvUJGJScbHi42ny9fZbMqG6hLB/gzdzsDsY6HWt6iCoVkHxstZ1w0BwKp+TDsqgFSY0aAYtrfRulx4j9j4OeJ2efpCW/DTDtsKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3sSSuvlgwtWCaQrvZWkNkVFtW4EoJxc5XFDhqE+Cmg=;
 b=F/UWmtJ05/KFi7qQbpRArm7vGrXW9ife/SdhIbS+L9nd8HABCLnGPiGdNUzNiACFJn5erQZ3WoLiL3Os3+thSCaZ+59qVdAc4cFbgvTcKy4fLT/z8ikPcTFsAAZdkreASupBlu5V2kgPzW1RCV7jtyQ17CpcvlGHHi+O+ewQRgstPmJPZ6trEwmrSBXBf/b+C7pcPEeyRqscv1tKqO89lNWRgLZmO+6df08lBCxIUG/jOLjv9sNacbFiom0e1gWgI0/aoiTUNNAiGa7WSr1DbRC3QSWYShSo7r96FDaYYzpF9p8zjj1/spcvDvLqcTSU9xfA9gR0n43qYrkCytWAmw==
Received: from BN9PR03CA0489.namprd03.prod.outlook.com (2603:10b6:408:130::14)
 by IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 20:43:56 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::8b) by BN9PR03CA0489.outlook.office365.com
 (2603:10b6:408:130::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Thu,
 9 Jan 2025 20:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 20:43:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 12:43:45 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 9 Jan 2025 12:43:44 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 9 Jan 2025 12:43:42 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Gal Pressman <gal@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH mlx5-next 0/4] mlx5-next updates 2025-01-09
Date: Thu, 9 Jan 2025 22:42:27 +0200
Message-ID: <20250109204231.1809851-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ae3ad9-6f2d-48ad-dfbc-08dd30ee5652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d43M/Gb2Dq27hJMw49w4wlEAUtx2YRSbaZkwreL5Zf0SEHDJKyjnp8uwOLl4?=
 =?us-ascii?Q?Z2sP4v3IzqSqQaLYekDtkH/L6hmG0BS3YJboZr/6TJVMVaD/eJS1c3K9t9cb?=
 =?us-ascii?Q?gwrkRhe6hajylozwG7RdxL09vGSabguAmVb+31Ok8ncqs1ptjukmaGpVrIsg?=
 =?us-ascii?Q?n6gk1WgqvpPs2EIeqjIeU2pPkl6NMIdTxMtVkTdrHM1oPSgV4jfAagnkDRoz?=
 =?us-ascii?Q?SjMX8rlA8TX2SUX6KqffxnR5lGRU41vZ7seNu/3tOoaCYa4btk7SdgnjjsCy?=
 =?us-ascii?Q?aPnAFniFlWLBUmaF+RIdIMVPdt1+HKWoVzNDj5R9DNI+grKqMxKeyW7sE0vp?=
 =?us-ascii?Q?7c73Jnp/x215TvrZwYqJue9I3jBuPtV7ol39dpFhGfAt5HyYv+9vKv4s8jIq?=
 =?us-ascii?Q?1o137t0ySraYcphGM/GNIOFPzwZNM0ZS8Vpq7w/zvZFTanf6bQ59CGRSkpnc?=
 =?us-ascii?Q?moCGAindWQIDp8dHVUZQlMb3KQdJEUVYDsBCRlRRmGRV3fSmIfnNligS/ys2?=
 =?us-ascii?Q?Jr/Vr1y3vIVivtp4fzVU9C1cbiY1x5BGriV4L2PsY9IoI2Ix/biijS5s9ZVv?=
 =?us-ascii?Q?sdhFAEuWnfl8a9jVkWqCuJJU7WZeguiUIdrqiCzdBf2F+V/pgGIgx8hcBw2b?=
 =?us-ascii?Q?KMYz11noii2DK8EIneXnmNuYIN/Plb61mSfe2sm/NX9bAVjKyTtezWLieTtD?=
 =?us-ascii?Q?pBm55q2sdc8RBtaO2XhK63ER2ht2w8cOpp1JYqP+8rXiBtIRn0Xe75EmkCmR?=
 =?us-ascii?Q?3gYpEnu8GbQgmoA2ufvIfYky3iMuv+wunfo/QvtJuREoO18YtGG6m93F6s5h?=
 =?us-ascii?Q?Rslps87lcj8vKNymde3PWcFZC/K7AWEG5XneCfxpH/fV962Q4D/QhHcyBNV5?=
 =?us-ascii?Q?bvTBeNRR5OqCaRVVaz6ZSCysUiA1ESUapTmfUT7m1QhvQ8u5HwCSe6RPEe/t?=
 =?us-ascii?Q?nRASuZ/Z+S1SLHrIDn+tzgQnoebNi3giy+Z83EGqNfTw5CgHlytIwxmdW/J5?=
 =?us-ascii?Q?K9F1/R1WagFjsz5WG6OQjM/8XKnXD0QdB4Mz/qrBaVOe0TBf3X+wi5e1swF6?=
 =?us-ascii?Q?jCGBDwKMY/IyOEfBrmcH2MnVuOta+WyMgueCxzP2WjGnfhCFiuZxED/iiGWT?=
 =?us-ascii?Q?uSVmZxMcUhK3Nb9rTrmcMoiXaYWfBtyP4u0wVSni3f0Ewv6FKS5bV8tSFxPv?=
 =?us-ascii?Q?RMn5S21rS+M7oj+CiqlRScDIS80vcWPZC4+5JktE4ah/fXoUDJJIdw88aumz?=
 =?us-ascii?Q?sU9CGuHT6FYCzrw60HteeESzkkEkVDmxl3ztNXJy5AqRkQ8Cpolr4ZuN6ays?=
 =?us-ascii?Q?XuTkiU+DN8akey+g6bqIWTOTjOm4jsL69dqtYIf7SLOSRXQT4/eQB3NGq+6Q?=
 =?us-ascii?Q?0rsOgyuvVW/fS7WgBkhpBaTprWSTjfv8y1v1xhCPlJglF5fVX+q6ChvVMo8d?=
 =?us-ascii?Q?2fOra/nX3VeEouu80RJtUSW+/VmSBmb9EI+uBJ36X8hZFT3VFr2sXkJ7NIpZ?=
 =?us-ascii?Q?D7UnXZW+bOuAQq4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 20:43:56.3224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ae3ad9-6f2d-48ad-dfbc-08dd30ee5652
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029

Hi,

This series contains mlx5 IFC updates as preparation for upcoming
features.

Regards,
Tariq

Akiva Goldberger (1):
  net/mlx5: Add nic_cap_reg and vhca_icm_ctrl registers

Jianbo Liu (2):
  net/mlx5: Update mlx5_ifc to support FEC for 200G per lane link modes
  net/mlx5: Add support for MRTCQ register

Saeed Mahameed (1):
  net/mlx5: SHAMPO: Introduce new SHAMPO specific HCA caps

 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |  6 ++
 .../net/ethernet/mellanox/mlx5/core/main.c    |  5 ++
 include/linux/mlx5/device.h                   |  4 +
 include/linux/mlx5/driver.h                   |  3 +
 include/linux/mlx5/mlx5_ifc.h                 | 73 +++++++++++++++++--
 5 files changed, 86 insertions(+), 5 deletions(-)


base-commit: aeb3ec99026979287266e4b5a1194789c1488c1a
-- 
2.45.0


