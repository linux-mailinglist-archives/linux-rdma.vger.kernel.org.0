Return-Path: <linux-rdma+bounces-12830-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E08B2DDD7
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 15:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4401C810F8
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 13:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496C331E0E9;
	Wed, 20 Aug 2025 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YFvAGoEq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7230672617;
	Wed, 20 Aug 2025 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696769; cv=fail; b=rRQ4oaUAKSuz0GzQBwtU2x+R7FCrpTcm62Zt9vPvhEypt7ssTiquLpzPMUpyj+d7n3WabGmpBTqhHQEn4f/nKWjGjFIfqxRJqh4nSejQv0BuVS2I7+YIprgnNQPvFcL/nGCjkEaIKmzh7svhwxvGVuPasR/XzZIx6ycvuhHiUTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696769; c=relaxed/simple;
	bh=2BmW6xWzEiXN81x9Y+FenFu6pf12YbA/o91syxmD1WA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U9AtwrraqrGndZlCgNZXIMmLJEt47t/LbhFlE178n7+eTrmpIGOfjPIgDFTBxtSGbpBR7VhOcXN3uXyfI/5TkAbf1NTO9m29ReGlwJ2JH4vPJkn9lxxRZ0Crh9UjReT3GhPMyUw40nocFP+gSwjsmJXccc/ZCuAqqLwB3fh5JDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YFvAGoEq; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGtbGjzfBlUPfTe1xAhPjefBudsJ1/RBj6F8f4V1PNG0BdZRxKkXGUFgZplag46cLApVxBFrmjacCNwSAKY1fbjSa3boboLqzmuER9SmOFPnBOfv0O850qCoehLfPko7S6DnvI7vBD+iCVayAKZmtk2uPv+N7O+ZWA2YRaAWw7vyD13VY0KCpuNIQZwxM+SpAUMNC9Z0grZFwj31oPf93CwfKM+iAN+Paf6dba0lMoWmDHwEvWAt3r2H9DWhxkPdcyWu6KQ5uiQHABGULWC8UmjulZ8cWqXrvZU5hxy1y1Vxoj/f5OkjYa2aArM72z7RT4KhhR3ykTCxugwuFK24dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eocWRjyTYzwR3otHtiogpO0ZI3cmr4HPMc34i6jZMmU=;
 b=LnMrTCDf0QMGmrHSaqpQUOhArp9mVt01eRpFShvZVdh47KHLzwlysjE0WZR1GgEprhjxNeLwZMz0SXoCdoHkpy3VQ1c7210xivMyYQ75+2zm00lX1coQjhPdoIYDhMr0aG75nHy21XvQ8XTSPx2pU6/wH7UG7ZCd/Vdbb3aScWmnafqP6L9qcYbyc2DuuMhMrD68p8prm1aaFi1SB7yhOXGnqdtk6ZuCCyGFKZIg03NGwfXjOma1eFXuu80VV+mxqPwPg45cUwGSn2ZF5TF0S06JyHdgczR8JR3kQ1fIODmUORr546V9POi2jtQc1t08WPPj2BJVBEGh75G1zYewkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eocWRjyTYzwR3otHtiogpO0ZI3cmr4HPMc34i6jZMmU=;
 b=YFvAGoEqo+xKLaD2g8WWJhoO+FqGTNoOpr59+GLqfFOucswzgmwQZqsf/dUcH2gMKcIIuwxScwG6Zadwv8cM4W1XhrtF3NYWqZN82ckg3dY7RAl4tPINHClAyPUXd9h35giri7fnMLWEqYqQqCCajQfLF08WfCza7vniILilaJRTFhju0044njYfNjXBLcIpNGvUWMGqw/o6eodcBeqpanKuCifmarbRIWGjLGbdAyLbgJuRb/XgqkiTM069nUE1uer5qweKUGxkjisX/d0ATGTx+TCEV7AV2/L2T6X4+AKY7zeVKJ3JAdzxVgcqTS/1xDTc4q7mBDSkco/NC+DqCg==
Received: from BLAPR03CA0053.namprd03.prod.outlook.com (2603:10b6:208:32d::28)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 13:32:42 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::30) by BLAPR03CA0053.outlook.office365.com
 (2603:10b6:208:32d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.25 via Frontend Transport; Wed,
 20 Aug 2025 13:32:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 13:32:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:32:20 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:32:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 20
 Aug 2025 06:32:16 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, <przemyslaw.kitszel@intel.com>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH V2 net 0/8] mlx5 misx fixes 2025-08-20
Date: Wed, 20 Aug 2025 16:32:01 +0300
Message-ID: <20250820133209.389065-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: e10ea920-904f-4caa-bafd-08dddfee09ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d/SLWe5cZ7D93g7my/jzYCp5LdypK3f5cSo1fjmJ5gpPSDDiN2SWFMLCRMp2?=
 =?us-ascii?Q?akiKCCwN8+ZANx3j1x5t0duDQRBSPoeUuQCgeWRkfzWVA8OcZFygCvUGoPqx?=
 =?us-ascii?Q?+Q8Q0Z5oP61d6eNy9ANmIe1MDLpNLZuFOgYivKKwqI8OJB4xMleE9MFlR7F9?=
 =?us-ascii?Q?XhlARiuQeXiaLGc43BH1hakoaLfDag3+qVHjSlZxydZHPh9LjIrIP8itHJTf?=
 =?us-ascii?Q?VsTIiKC0mO7RtuZ5m8ghXK0PXqtQfvUE6xr02cv/7flLelLhntUb/lVUtZPH?=
 =?us-ascii?Q?FjrFQ0kwGkdmxEqGCdOqL00iMUxePoBOd/M/pfNUHJM53g6GvuFSbsw+93ZE?=
 =?us-ascii?Q?MOYAjGUxk4aGUmW9IyI8gPo3RMVG6APkaFB6075Xa3y2+VMfZfvrGGrMKWlk?=
 =?us-ascii?Q?sRtFlq2bHjWMxmcof/PlJWkqQDj9ESgCpNCdtNljKi8qL9Fdn2x/VYmb3ptz?=
 =?us-ascii?Q?bycmwhn/RCEwkm825p8mcSaDQ8wONKFGrBNcQ9NkiWRYQuUA1UKCXrgdck0C?=
 =?us-ascii?Q?A7x4bsLcRuFO8MEWH5V8G7VtoKhErWgIveOiGwc0YFAK9nSrcr9ZR06QTNHj?=
 =?us-ascii?Q?nPU54cEkc7p4DlyjbUczyf9sEnrDiaO/HNqeTrXPJT7bnqJ6pBJsSclnku/9?=
 =?us-ascii?Q?+HT+aLMikCXAA8tPe++Y5U0Dl64Gn6s3WjwFph1KXFEaWZnXHH7E8eni1nZ4?=
 =?us-ascii?Q?8cgHSxA+c4fNRDKFEy+bEaGW6HSGgD6mJGGHIuhURlUFIEI79lxCrnhywZTb?=
 =?us-ascii?Q?WDMD5tBhA1t5x5Fk+1Z8M+pzJVv2gheutkJcYE+ZbT+n184GbVD7Yl5lPTSn?=
 =?us-ascii?Q?LTXly5hfFgx8RuYka56KpKX1bz/NZNY6qkiNr5z984LJnk+T0NWFK0db4Nx5?=
 =?us-ascii?Q?P+8Nk/5iow1JWPdKz4NiYn8NQqUaIA9q8SWeLIGONsU+pfDa1s8UvTRuBQda?=
 =?us-ascii?Q?pFFNd4xrJclw8Zkc26RyC1LD79pC/ts4MjUNNk7t1VLCv9aldu1Otwzzyj8I?=
 =?us-ascii?Q?SozGLA7R+2dRbaJBIi5v1ZJQkoKeHylTykT+nGzqxL5DC1jUiFM0kVrodEbb?=
 =?us-ascii?Q?pfkFwQ4yekOwvBmX/DkyE1gO8+DQoYrs/zEJoTDLB0CAxYLvKHC+uzpG1zti?=
 =?us-ascii?Q?g6oz2c+1Sp3rpX3O8P3nhQ6D88yNMshVx1nz0bAaooXNF4/qFJS5bg/WaQD9?=
 =?us-ascii?Q?ytqRKZG3BEAOo1xdS2p3/56hm4eYVTeAkMA6U2G8kIHM4uMi5Vmm+n07cIoh?=
 =?us-ascii?Q?e7stIR8KuerC3qVcxfTEEtCr0mq91W/QcCFmhWHO09gSoKtJuf6BnmoXOsfr?=
 =?us-ascii?Q?9dd96P5audi7UZK++Gg23WPtseO6Eq/2GcM/Px2qyZzloTsFPMyZixxCHLiT?=
 =?us-ascii?Q?O9NVOgHQKjIAIii7vTfeapuxbsPdDmOWp3RZvX2yQX7hecRtm10ctZC9ioGz?=
 =?us-ascii?Q?j9Bwlpnovnnifbovd485Pw+KMTxUWxQiGGpr3dlw9G9VvW7PmB5GH4k0xYRJ?=
 =?us-ascii?Q?AvmkwySYskqvTnxyoQ+iGoxONnsU2cnSDsFc3KpsGzTO8a3xbiMI9zjd7g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:32:41.7497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e10ea920-904f-4caa-bafd-08dddfee09ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

v1: https://lore.kernel.org/all/1755095476-414026-1-git-send-email-tariqt@nvidia.com/

Changelog:

v1->v2:
- Addressed comments made by Przemek. The order of Carolina's
  patches was adjusted to fix the issues raised, and one additional
  patch was added.

- Added a fix by Armen at the end of the patchset.

Alexei Lazar (1):
  net/mlx5e: Query FW for buffer ownership

Armen Ratner (1):
  net/mlx5e: Preserve shared buffer capacity during headroom updates

Carolina Jubran (5):
  net/mlx5: Remove default QoS group and attach vports directly to root TSAR
  net/mlx5e: Preserve tc-bw during parent changes
  net/mlx5: Destroy vport QoS element when no configuration remains
  net/mlx5: Fix QoS reference leak in vport enable error path
  net/mlx5: Restore missing scheduling node cleanup on vport enable failure

Daniel Jurgens (1):
  net/mlx5: Base ECVF devlink port attrs from 0

 .../ethernet/mellanox/mlx5/core/en/dcbnl.h    |   1 -
 .../mellanox/mlx5/core/en/port_buffer.c       |  18 +-
 .../ethernet/mellanox/mlx5/core/en_dcbnl.c    |  12 +-
 .../mellanox/mlx5/core/esw/devlink_port.c     |   4 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 183 ++++++++++--------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   5 -
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   2 +
 .../net/ethernet/mellanox/mlx5/core/port.c    |  20 ++
 8 files changed, 140 insertions(+), 105 deletions(-)


base-commit: 51f27beeb79f9f92682158999bab489ff4fa16f6
-- 
2.34.1


