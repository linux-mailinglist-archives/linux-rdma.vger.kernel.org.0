Return-Path: <linux-rdma+bounces-13554-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D913FB8FAD6
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 11:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D232A0704
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 09:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C2F283FD6;
	Mon, 22 Sep 2025 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e/csiHV0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7644F21B9DE;
	Mon, 22 Sep 2025 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531719; cv=fail; b=SB+trQZohtfqO5OwjX/NBH45PDiEDFSU7KdhLz4qNGpBJ3HMcehkfKBuWobzRAwcxjav684q665u5EhQPxeDE3vXcUSeVSFLkAybYYoM/P6U+uXjGGRIQda1sLeNRy3CpwgYMUNJfXO4z2xFpOSoB96uY/bMcHBsx/VFWkoyeFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531719; c=relaxed/simple;
	bh=0aSMw7exjT90s5w5Z74fheJ3nVgUnpwkcFP/f771w/Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KF+UpvY/Rl7Q1SXNPmu83YeJIv7NnfV5EVdtpt5+YEcS340IxRq6wKuEBAqhs9yTzjGIUU1iZS1qTC3CVnV0MoxXUNcGmVGgm3s/C1Y1S+lW3zN5IiqCrV6hd3qr1Uu+qenRIz1U+U20YkuPtznBrc3sY88v620BGdAFni0bkes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e/csiHV0; arc=fail smtp.client-ip=40.107.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMQORrfjGi20u2WpdlV7uO+rFI3kl2gppd/S12e2t5RLyMb3mT2t1o4wubuobhop2rBYE2kLvYWFLxQ2dE6muw003D3gt3/8eyaLmdG7PwzVH5/arNe9hNPweXOaCktukYqXqNiqzliWbD4sGL86xHvEy/ekOAq0ao855Hf98vJ5Wp+xI6s8v2X1ATxpva8XFYX6s/rzFIkjSBUG6IgMzabhFjZlEKdWY8MzM2+i6qKqAOrFrOlANskegp3/3GqaVpIO7iJiu8XlnrVoTR9Zd8bNkfehJ/RJ8W40+gBfq9hYy+hQm1hvuRXGPBIcU4ftuUO41tEL5lH8bFIV3Sz6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFO1uEZuwWcr+PQWQhYOY0NwzLqXlT00TQIV8z7p1S4=;
 b=usRyuAgTcny5j6wR6w8TouQC1WFisxr3+jpc8CMqAkDkFXGgvn/DOUccaHVJgDj3A2Dm87jOakm6yv2LFevZkjEFWxcvofHLZhvVp71S7ymxiKHihYA0STy84++VPTz+MyuEJ3fxDCymyePZ2SI+t1ZJ2FegdQJ+sczZIGBElh5bkP6J3UcqLyaa0lWkecLGA3GaCApznUjGRPBgbpoTWH0thAMRDfjg1VHpKEzjT7TVtMU6CpjyDay6LzEBrEFxFbsEtw7pTzeXndb285cIB7eKr3pJ4kWLp6fw669isqbJt40CPhhpXy9NWplFq4gquxW4u9xVYglLQx4pVTL26A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFO1uEZuwWcr+PQWQhYOY0NwzLqXlT00TQIV8z7p1S4=;
 b=e/csiHV0xLqpyYgO/X8MyLtdUTuzs/FVTJMMI8WhTeVPAGIma63vDe9Ewh+GVSy3PVYt6PQOb5IaqNkh+ma5nsuGWg1pGTvjnRGoWnjOlmilKIiywwGoXxv1YiDCo4qTboYcrfDLq8y/0YXk/7K6heJTPYQDqcvPotjKc8d4CAMZ5fjfFABi/AuaT+6HuhNGInjomShiYbCe0ol33q1ioNjYixhvczib5kW5hUcdBQ0hIxb82BiedT2n5Xq1ie4qhET/GDSEJVC/idbJmhGiYcvv8NdC4pB6zbYSXOiShuHHFoUENW7UkrUlAXDEDYoIis1huN4nxzmfBFU/rVBwOg==
Received: from CH2PR18CA0024.namprd18.prod.outlook.com (2603:10b6:610:4f::34)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 09:01:55 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::4f) by CH2PR18CA0024.outlook.office365.com
 (2603:10b6:610:4f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 09:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 09:01:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 02:01:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 22 Sep 2025 02:01:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 02:01:37 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net-next 0/7] net/mlx5: misc changes 2025-09-22
Date: Mon, 22 Sep 2025 12:01:04 +0300
Message-ID: <1758531671-819655-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c2a7f4-d510-4c1f-c96a-08ddf9b6adae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g2dLJ0O5gVPwPC61FuAaqmM5gXYCx2O4bjyDaWXpNmTGMQ5v5B2taIGcP/W/?=
 =?us-ascii?Q?j0/hlChVcSihKIiPjuXyMgd6IeIstTZ34fmRYFLgM8id59zsp7Vp7lDhi9Qw?=
 =?us-ascii?Q?CvvLi+7h+/oGZoZoXmFreqIVyBmnXnS13G7QSMU+XRlYB0IshUpM1IjopIgG?=
 =?us-ascii?Q?UatZzQpXjOdFxv3dXFr+nfAu1CBPxNnHUU/JH8dXlfTxQqDR4fJV7WnbxNl5?=
 =?us-ascii?Q?QuDGzk7CA/zvJnvaMxn27F0eoufMTQujEM6+eGl6Zj0HsmU1A2AXCMUOGvGA?=
 =?us-ascii?Q?2MchWliaRDOwXTnd4A0oMeAEa5RmZFA3PXwTyZaFUaWd5ad8IuOR21SsWfyd?=
 =?us-ascii?Q?IVpdPlqIWb7AkMi0L8SxbNPFACcDljMZEYoYIxZgkrtvWVr2CeBXXZtJdEHk?=
 =?us-ascii?Q?Ozjpcqg81RpmdjvPD7rBSs01MkJoj5XvXxpt1ZZXyENQMdj7C+bYkSOMCjho?=
 =?us-ascii?Q?UKGfX/Ba1GbooApG740zFOLjAsxszCsM3qgVJkyyjILaQj55v+0sXza60CBL?=
 =?us-ascii?Q?rHyKmMR1UYXNvEnImwwIBQhCcCiiItikuF984sr2OB/PEwiiXSycFpmDwoPA?=
 =?us-ascii?Q?esTSu7mFSVnpigUjwprT2bPVI6Gqvh06VWCruPnlw3ZWdW1QUX2nza+aklse?=
 =?us-ascii?Q?kBb1K1yqJr6hqMVyG+gg5akyxzRGIztvg3pNmiKCQ18QQ28Hv8h+nOlx0Q/j?=
 =?us-ascii?Q?R4xxAu0xVDPWrQIrJ9ijvd0OPt9kzEyEBaJZXbjPJZY8H8kN9sXz01jNUG2E?=
 =?us-ascii?Q?7UPAHC3L3f172KfzDzPRbbdbkzLCpXAXGQTmgZro+FXQo9yZLVdpeFD6uckW?=
 =?us-ascii?Q?VF5ejPt9QANgZ6l0Vyubhg7LSeuz3Jk1vHZTk66MdVNJ3KfJanrqKCwRdCTp?=
 =?us-ascii?Q?LgZpasb/6YuAuccs03qMGPaZ+mXx18NJng1PIsIZhDOYJrdDfzu+0EMbCOHU?=
 =?us-ascii?Q?D7UtFZEZ2VhQq6XFU+NH8fCI8Ul5rJLwyttoIAPor8S0/0UT7QflBBNyTHf/?=
 =?us-ascii?Q?ITsBdGRFX014EQBAV29Vydcf7ZrdI1v8OLvEuNc3cpIpYZiNi4VVEI73Ou8V?=
 =?us-ascii?Q?y+he42MuB7NY8kqM0OCR4RcHlhD27juR5f0AIP0o8xxtQoZw4Dg2LLqA21UZ?=
 =?us-ascii?Q?CuWH4pH6ENKXRd2uVKOMrrYwoxF+vwWbpWRP5Ivjx0vOV6t0YrsneNZ8v1sQ?=
 =?us-ascii?Q?6yaqBU1RuGgVmUBn/yox5x6GJdsSXFPmGCn8xguqyQRjDyt7ajeyi2pdE8Nc?=
 =?us-ascii?Q?8ip5vsvs2gUlPEA48EtvWmAjQIXerzRRbX3UAed0FS6z7nVUX+eCKhclDcV1?=
 =?us-ascii?Q?AkZIAh1G07X375iD4a/8LouoIH61g+WmtRukQQXBZeylYYve+WAr9ID43DX8?=
 =?us-ascii?Q?UbfxzLjtp47Mh62NvGIvoBO9WiPPF8o7Yu3nHEtdsdLXvkxMDwiqdEo8u5xP?=
 =?us-ascii?Q?+ZIXf0V++CxVNvlgU7zWuvO3UAQkqpxyAcuN9F+h6vnDF/L6JedeoOYWUDxy?=
 =?us-ascii?Q?chuAHziANyWfhBrUb0B1hqk9H4ZyfDTmAwGb?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 09:01:54.8173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c2a7f4-d510-4c1f-c96a-08ddf9b6adae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325

Hi,

This series contains misc enhancements to the mlx5 driver.

Regards,
Tariq


Carolina Jubran (4):
  net/mlx5: Improve QoS error messages with actual depth values
  net/mlx5e: Remove unused mdev param from RSS indir init
  net/mlx5e: Introduce mlx5e_rss_init_params
  net/mlx5e: Introduce mlx5e_rss_params for RSS configuration

Gal Pressman (1):
  net/mlx5e: Use extack in set rxfh callback

Jianbo Liu (1):
  net/mlx5e: Prevent entering switchdev mode with inconsistent netns

Vlad Dogaru (1):
  net/mlx5: HWS, Generalize complex matchers

 .../net/ethernet/mellanox/mlx5/core/en/rss.c  |   91 +-
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  |   30 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |   43 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |    2 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   15 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |    6 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c |   15 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |   33 +
 .../mellanox/mlx5/core/steering/hws/bwc.c     |   37 +-
 .../mellanox/mlx5/core/steering/hws/bwc.h     |   21 +-
 .../mlx5/core/steering/hws/bwc_complex.c      | 1821 +++++++----------
 .../mlx5/core/steering/hws/bwc_complex.h      |   60 +-
 .../mellanox/mlx5/core/steering/hws/definer.c |   87 +-
 .../mellanox/mlx5/core/steering/hws/definer.h |    9 +-
 14 files changed, 996 insertions(+), 1274 deletions(-)


base-commit: 312e6f7676e63bbb9b81e5c68e580a9f776cc6f0
-- 
2.31.1


