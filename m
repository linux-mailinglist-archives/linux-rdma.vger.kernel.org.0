Return-Path: <linux-rdma+bounces-12890-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3753B34446
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 16:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB8B164A65
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BBC2EFDBB;
	Mon, 25 Aug 2025 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z+eMafDz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120B31E3DFE;
	Mon, 25 Aug 2025 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132505; cv=fail; b=uYVjQwLoiFJjXwzRpYtuUD6avn7TI1Z1h+Oljp4w3jHiW0bOvd7VFgfNUJs5oc3DkqpD78GVaxJnaautHNet8wFdQ3P7b2B6fgfZUE34RKRCTLcrG5ClLnLEuP1UmHwQKNpI/ov1xY5/CamT5zChapZwQiay8ObaXHz9sravhXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132505; c=relaxed/simple;
	bh=k3BXMbj1OeltXIXRzCS8eUEZo3ROh7h0Dj9cDg7hueI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g3hLyEeoBbcCzp5xvp6XrXLfMLHEo94NkaCiSDAs2wkAxS9s/kJ2+rnR7sDC64O1KbtM8gtbU6cIrIR0ye0vmE2m/w7IxQUayEmH/3BNxAAlvK60IZK3/Z248FJcsbmRUzSwv8AUqiIH+YWwH/PBuQO9XimCCn4tqkdmyhf8zh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z+eMafDz; arc=fail smtp.client-ip=40.107.212.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fObWHmHEsSh/64r9qPpMwOCLPMp27fMFMA2TvE+5D7sbLB8ZHoR+Rk+C2F/a+BYBe82tNVKFRUZkNraJG4G00RpYwFE8+s1BMNAiu5l5k0r1A+KDIQkomOKaorwOEGiiRd0YfXPTalL4UfvTuDJXzeQkZHCndkVrbpKaKuzkPZqmHInsRpHdgJV45CD8vbfMD+3pQBXxeazrUq3vqsdPmOvyt+VCbXe0yAxxFN/W2YLo7Ujw1ahtGXLfsEbDQTM0gYEnKeeQS+NRzZRvaL3d1ZN8uf2ZJYkQy/sN6jszc+GaHD8MqjtQgPtchApquABNEsQqIm4L/FTHImQf5mOwDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcNJ1bZmTFxfkuLwUsmzkNznz0HF2tkImWp/SCDNGnc=;
 b=uCXP6Zfa1wCJqUuBwaJKIIr8DW+Ezpac727EbeUQwsLbHwwpGl4Z8gblcrh4BYDoJwmPbrBDFVSdWueRlMpT1Mw99sGS1cSglhrUB/1G8G7+u1yPKhPmUDHNcGTh+7llj9TVHIIEqX2TlKT0Z4UFm3KIxjN50X4FSSkyAGOkgdT2ed++eYK4lESB7rVBZK9zS//lv3P7pfaXulhJh8Fl77ZCyoaWA9xirpZt6lxEFy4pxEHvgEDicAioUWpiMi377mr9SaB0JGAuvIKwxj3yncCc5YCfC0WnMw24us+/dkKnjwCgQdVGDQPM1SZY9MgK0cuXLsr3sKlSdMrs38ew+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcNJ1bZmTFxfkuLwUsmzkNznz0HF2tkImWp/SCDNGnc=;
 b=Z+eMafDz+PaqzJpdgT6EI+Gc4p0b9p16h6qoePNA7yRlluf92OpixAG2CE/RKbKGPEJdo1D26/v7PWfaW+BIp+jKOYoM6wu8QsGyTjxk3FyKZOhPcck89cdNFpdSxkTen+whPNaLJMBUccRG3MAktUHiAsS8minXpN519oDevpFb3igfbklxNVeeoV4K9WeR3RPZ9hgYRkZ/7AICZ1hICUDy4jccVKTTVbzDhUBG/wgK3a91NwMTjipNHU4x4X/XLUoPELdmPiyeHOkpZJyaebeCd6dznZVoJxnsXvAOgmIoqNHJkIGp/H3EeGao91iE8P7xsPu9QWDFlo2qLiyv+A==
Received: from CH0PR13CA0044.namprd13.prod.outlook.com (2603:10b6:610:b2::19)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 25 Aug
 2025 14:35:00 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::f3) by CH0PR13CA0044.outlook.office365.com
 (2603:10b6:610:b2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.10 via Frontend Transport; Mon,
 25 Aug 2025 14:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 14:35:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 07:34:46 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 25 Aug 2025 07:34:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 25 Aug 2025 07:34:42 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net V2 00/11] mlx5 misc fixes 2025-08-25
Date: Mon, 25 Aug 2025 17:34:23 +0300
Message-ID: <20250825143435.598584-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e65e24-0d38-414e-5b38-08dde3e49293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0alS1Y+6Z21GWMmWo3sIpC54yw0x64h8kA4qz4kDMbZ9HHac16Dj/uvK0e1l?=
 =?us-ascii?Q?BNeGz8P+NQ5YlfOE4cxunvOuoSx1Kx9FfNnWw/BzyFoI4XY60dt7Sy5CZ4mu?=
 =?us-ascii?Q?fFDY7brnh3Qy2VAYlcO6EhtTziekBMmoyti2ydCJ4HOuJ6yG75tQzOIpDgKn?=
 =?us-ascii?Q?2gJBA78iRhh583jHlIn1ylt5JzESdhbhN/HGiQzcflVtWNajhslQbBtxpJ/p?=
 =?us-ascii?Q?HCZd4jE7ZTt/5OuNLTU34WtoEIJTAo2Q2rqUMQhsLh46g3TXham/xoFJlCby?=
 =?us-ascii?Q?vYaPlUvWJ4ho+7CgMMtNHjaFd2PxUx8nZMWyEUN3niskRzuQok/8k51r1v5t?=
 =?us-ascii?Q?BwToF52PXsaSxEMqG+xRW2FuD1pXC84ZZ2eUL2fEB/XYgaa5apW00FdDY7hB?=
 =?us-ascii?Q?x99ZSg5wnIgWwye0WA2HPPQM2uJUpYOuknjfhvj2gfuQnp0XnPU3jSMmmYUn?=
 =?us-ascii?Q?PPUMjW9zqbGtgHY2QRVPyTcToRBcrtE1MAo2xCv1V9cH9WMXNzNDAKCh/zfm?=
 =?us-ascii?Q?L+IP6FtZR9cT0TRluVK4xICRNOjVY0WMrBN79BzCEIJtPg/WIYLrnU7ytSgx?=
 =?us-ascii?Q?JwNP8iFiJIVY2AxDFBZDWCPCP3JGDf0wGq/pztMk0FkmPYDWa27xcFYtOuYj?=
 =?us-ascii?Q?Zu5S+lagDw5LjIjA1ArnOienCAXgmW/QNHSSoAoZtlCIpYtuoakXCBx+8IQ2?=
 =?us-ascii?Q?SS71JZhf0SN5F8Ej5oWClV82Bxc5bDfobFfdIxQ81D8CeDyitq566P2zFg7C?=
 =?us-ascii?Q?PUxjQgcrWKwofApG1/rGKHruYrOFU6tO4dED+b6p6h62NU9rebA9Q4DqUeuu?=
 =?us-ascii?Q?KUwmApg/i4nX1A7tY1oHa3FW2EbdsYVz1UfTc9i6SJdj/2+tKRibOGjtuLno?=
 =?us-ascii?Q?HAYOvTBB17ObUVV+Lh7VHk9K1gQApLdbGN+uwdzWVL8KxbAt+kk2b7jzcdWs?=
 =?us-ascii?Q?/xpLy4RZiLfJX6lShPCAO2y7Hg+V7zeSXdVh3Gukw9g0XfJiGCrHRItiNavW?=
 =?us-ascii?Q?QdGumbzyC9tmxe3K4B2BSjO/v+1RxXpcRSS81bv7Mj85eOrBTGUgf3LRxw9Z?=
 =?us-ascii?Q?cIxaM3s5gx9tEyVLHpdp3bK1/FCRg1ksPt3CKrRXBaiCjZKeuKUpzPCSbjPW?=
 =?us-ascii?Q?CAl+K/iOQ52bfE6jyLVu/iIaxminUATY5rxwqwaMCr5TjtBcqp0PAXq2GaAO?=
 =?us-ascii?Q?5p0FR0Qu8bp+c9Zxl0AOZjLNuc24AYZAoTiH0RsOZv6CA66QKrYexP+7xsTC?=
 =?us-ascii?Q?+8rALH+kLtz2vZmd0rI2vuTpAR0q6+gw8oD6qvvdeklnhVd/9VZK6sr3MVWs?=
 =?us-ascii?Q?iDlO4lLtyjlFnQLDb/cb1WiLvIhNTajEVwXkc7JciC95c8WlNpwTSMmoNV54?=
 =?us-ascii?Q?DpOewGkpBEq3o5fJYAcK4TzvC3yWGnjfGgEY+z2yRN6s5ZYmbT2FiQOY6urZ?=
 =?us-ascii?Q?st/2dbC+alQqcctrVu0SiaYiiBli6j2El9UTk1h00hGf+IQpSalkyS9H8j8L?=
 =?us-ascii?Q?IgBxjdeOZSu2+ZTgY0z5NOoH/6SkfXnGcBkU?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:35:00.6148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e65e24-0d38-414e-5b38-08dde3e49293
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

V1: https://lore.kernel.org/all/20250824083944.523858-1-mbloch@nvidia.com/

Changelog:

V1->V2:
- Patch 9 was fixed to address build warning found by kernel test robot.

Alexei Lazar (3):
  net/mlx5e: Update and set Xon/Xoff upon MTU set
  net/mlx5e: Update and set Xon/Xoff upon port speed set
  net/mlx5e: Set local Xoff after FW update

Lama Kayal (4):
  net/mlx5: HWS, Fix memory leak in hws_pool_buddy_init error path
  net/mlx5: HWS, Fix memory leak in hws_action_get_shared_stc_nic error flow
  net/mlx5: HWS, Fix uninitialized variables in mlx5hws_pat_calc_nop error flow
  net/mlx5: HWS, Fix pattern destruction in mlx5hws_pat_get_pattern error path

Moshe Shemesh (4):
  net/mlx5: Reload auxiliary drivers on fw_activate
  net/mlx5: Fix lockdep assertion on sync reset unload event
  net/mlx5: Nack sync reset when SFs are present
  net/mlx5: Prevent flow steering mode changes in switchdev mode

 .../net/ethernet/mellanox/mlx5/core/devlink.c |   2 +-
 .../mellanox/mlx5/core/en/port_buffer.c       |   3 +-
 .../mellanox/mlx5/core/en/port_buffer.h       |  12 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  19 ++-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  15 +--
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 126 ++++++++++--------
 .../ethernet/mellanox/mlx5/core/fw_reset.h    |   1 +
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  |  10 ++
 .../net/ethernet/mellanox/mlx5/core/sf/sf.h   |   6 +
 .../mellanox/mlx5/core/steering/hws/action.c  |   2 +-
 .../mellanox/mlx5/core/steering/hws/pat_arg.c |   6 +-
 .../mellanox/mlx5/core/steering/hws/pool.c    |   1 +
 12 files changed, 136 insertions(+), 67 deletions(-)


base-commit: ec79003c5f9d2c7f9576fc69b8dbda80305cbe3a
-- 
2.34.1


