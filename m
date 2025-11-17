Return-Path: <linux-rdma+bounces-14567-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC19C664F5
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 22:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 291A54E397F
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DBE32695F;
	Mon, 17 Nov 2025 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MB3/WDE0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BBF324B32;
	Mon, 17 Nov 2025 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763415776; cv=fail; b=dkUjjgeBzunVKPObxjeF/w5tf4PoxTnjkpDHX4x5H4GXegGcxhAT8VbkKaP2sOU2NFZBaazDt7+A4kF2fXoCXt8M3T29qdmSHNCWDg/jfupV/sCmi3Rq95gp6ClEcG07CD/OE/xa2XcL9et4qo6qBtVWidx/O59iTIllDw8aIbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763415776; c=relaxed/simple;
	bh=i/lr6GFEaOERB2RgTasZd5WDFzTEn/adI3k4fLdlkaY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h8zOpZIpQBAuxDkSejNF34tgSr52NfvdDXa1mVfbYCxtLCwyUhWfZPU50dsLJj7D5vkscsuZwA+uUAUoVKtPoIVB+ve+kXCXdSz1pXmQGZiOfOdrJRVGVjNjXY4nBWyE2vXBUL46eqEj6BghELxYeb5QMdfJPHLAAVHntZ1eljU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MB3/WDE0; arc=fail smtp.client-ip=52.101.193.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1bm2PVsVfkP8lS3uDE/cI+dtqNZYkcTes7CWlQNwPntadXr7s2TCT7acyoTZhjZVwVeM+6qyC8Sm+oH/77a5sUG8ayWm6iOWFJcZvyfe3usFmFc5nycCdfFVykDZtMbOxc8YjgkezRlS5kA5H6b6gAnMPcLdo0cQWL1d9JYxY3xgCWq1wV19EQ+TYRyuKLU1X4o3UTc+DHsHPu49bbvSZ/OeqtxLdAIMhVQ/3JECMInN1iXk5xoeO85kd9EkVHJmOeqdcSkpHeeU0PgkNDTYgGU7qOSBbapsab/z2lbLcuNhUDNkmI42ukM2kmK4LZur39sLSHNy5y7llvLlTyAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnM8J3MXIWzUn+bDgn4zkVZsc+DJVc4411q3PZuy3BE=;
 b=VYmjqfzli7tuu0wP8LX+0jZlg4+esAnG00trpKG48dFqsNqJyHplJc65vwA+ipMFvxOfMTGaoD+FzRwYCi9+2b66wD5wkd19V/lpCor+93CVMGlGQtPksSrU97K3EKA31hRkgMEPxa8S9h1TM2Sfv4LYzT8DU3fmVhS9PBgsXidibXR+VXvjeq2mRMf4YELGLKhITtej/RyKUIIcVlml0jg2+xppQLnHv16EiE4NisFy5evqLWVSNj+5XkdK5IscwRn/JC8VvZA7S8zczelAexw96WRJZrooWNqEA05FCkdlh57vHRnVP0eCO6QE6M3Gc7nhdWdBSipWV2Pbh6mXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnM8J3MXIWzUn+bDgn4zkVZsc+DJVc4411q3PZuy3BE=;
 b=MB3/WDE00zmdf5rKWO9snp3em2q4BLplq7X4cmstqpQx95ULe+8pKVCj4886A2hbfDXWcCzqTmt+B4Pc6P+bt8vOsizBFIGPaRpRd7x/brmMQdIaQfXrrunvoDVPll23bS550UKif1M0dpia3CJYJd3PnX5rw/tZ0febccNsLIzbD66z6SJCX2AJs6yW4ZJEn7slRkU9smgmLqjG9N4f/uq6dfUlkfC1S3Bp5u+oqBatfxzwz00/TKE79Zb/E/2MybADZFKT4IZxJ9YTNd5AsHSRsFMzzONjb8Mwtn/VyWIZyggE9B7DtP41csNFEcznR07XBd9JxuL/3JMQgn8NKQ==
Received: from CH0PR03CA0207.namprd03.prod.outlook.com (2603:10b6:610:e4::32)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Mon, 17 Nov
 2025 21:42:50 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::76) by CH0PR03CA0207.outlook.office365.com
 (2603:10b6:610:e4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 21:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 21:42:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 13:42:31 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 13:42:30 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 17
 Nov 2025 13:42:26 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 0/5] net/mlx5: misc changes 2025-11-17
Date: Mon, 17 Nov 2025 23:42:04 +0200
Message-ID: <1763415729-1238421-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 9487c315-e91f-4999-a9ad-08de2622411b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cEenJ0CMGC8iX+xoT4IbPy1k2ouu1TnV+uoYMJMzWSZgCMDKz30pXz42sJUE?=
 =?us-ascii?Q?SMGSMeDR1QqeYgl7IopGp0ztyFkyJhPrQ0BVIW5ReD5465vogUlt4b+D4/FO?=
 =?us-ascii?Q?pLPWtOhheHeD6AAdb3WobbvwLsu8Mai7niGRHXb/dVGH6ms7yoNIXhY/k7E0?=
 =?us-ascii?Q?uDdOi4aEjAgr30txcdquzYw7a/yqkqaJQzobeULK65aBaintOS+2h1V0olrk?=
 =?us-ascii?Q?AVCS4Pza5PYiLgbTXKr23bkBobT4qhmW3aW6Z249jHxg0vhRLFE1dOxn6xV5?=
 =?us-ascii?Q?pl8IsLzYaxEKVYNI8gkA286svN4zKhfHc4cUwhe8RxVl2lbLy2HgiR6ELeZx?=
 =?us-ascii?Q?IP92StHbLVblSVU89kCA/NcItrkLoT8KAoVtMGgb3ZT1OgUxAsx1ZjznFrev?=
 =?us-ascii?Q?eb8bx1I30Yz6bZM3lroZCYlMk6amRTpoFp3WlbB2gsH+eAdPS8EjWuiIPgq3?=
 =?us-ascii?Q?7bhTKGhNAdgy0hGWizv2NkNcRqkQY/91jGxmEBBx/7XRBmlHYDqgnIEKr2GR?=
 =?us-ascii?Q?+jGa2rqK/CVgm9FLb0of3DWdWs7fIwXfOfhUKaPRDRcXKBjVCNn1ERmwCRuy?=
 =?us-ascii?Q?gJwBfZo6Nmvzl7IezNbnDYCL8bK79gjW1u0YcJzHGGpUDJPVfEUCgpv53mBL?=
 =?us-ascii?Q?d+ro+UuQV8vfnp0KeCTWmXftKi7v2VfZatStq6x1kv/ispDwa5lfc8/sCvGi?=
 =?us-ascii?Q?efQyB9poaYyz9lM9Qb2FpdRQVLSyAdR4jDDO35cKgvGWvbSIKOM9ex2QKinc?=
 =?us-ascii?Q?UIS03M3TvYuI4/QCbmL9l5QyTxQIIUb13zJba7N//3tXVKc2DOnxaL83EaBe?=
 =?us-ascii?Q?4kWdlUlGD4EfGqDfG39zpbDAf6449oAQBaF1rgo48NU73zf2n9eLE4V0HJ+j?=
 =?us-ascii?Q?lBMCIvRrCO3OJ2HMmQRf4hj/RXjskKisH6VIE3OMiWbBIVs+gbxbHRx6Px+r?=
 =?us-ascii?Q?OTwJIiBCqcmUkduC5cgUgSc2OeQi+laKUjjz00aLS7EYP3GUWeGs+5Gw54XU?=
 =?us-ascii?Q?1CRMwJhWHox1UnLRySu4mhcKMervDu7oSbE1H+bgIeSKP8ezDBICUtpGJSqc?=
 =?us-ascii?Q?/ydAr3Wl0HDHWuCClBLYVP/pX7etmxtodO1TmWjhUWmrLzsLxArZFrOv/0Qz?=
 =?us-ascii?Q?FuGrddJyBDfYU8YHSCL69Mx0heEuxLtV/7XDaWjTj/UQfaxKkNM8B4c02djT?=
 =?us-ascii?Q?rtrhdf2vRqQLt291N++nxHGC3T0TvTZCSfkf4P2DhaL51t8JhRDUssPkoJEt?=
 =?us-ascii?Q?2KZZX8XW2Bw7L6NikOwDRrykduYFWByu/J3VlVXIoAmdM3ZVfMpfmmMYcas0?=
 =?us-ascii?Q?bm0QJpssopi0c8D3k1hNMMFx+11g+xZraW2LK3dxTVh7dvDjpJGmKwrxBRsU?=
 =?us-ascii?Q?+w1JV1H2NXzCzyjTDCqXueLyphRjJb2iLqLuPWXRWCJ1pFHEeRfxKJiy15zl?=
 =?us-ascii?Q?w7YbBS5tSIMwZ5nW3yUV7iGrALyNLvogVmi5nQVaW2q5Luc0rTV54pL/1d8U?=
 =?us-ascii?Q?ehLtovQ2fGwefsQrIETJfwDWKeaL5rwqY7gbzH0lRbeiw5qZRhDeFEpdn+Pm?=
 =?us-ascii?Q?BwVZYhBp/0yrYbqG4aM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 21:42:49.4758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9487c315-e91f-4999-a9ad-08de2622411b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187

Hi,

This series contains misc enhancements to the mlx5 driver.

Regards,
Tariq


Carolina Jubran (2):
  net/mlx5e: Recover SQ on excessive PTP TX timestamp delta
  net/mlx5: Remove redundant bw_share minimal value assignment

Gal Pressman (1):
  net/mlx5: Refactor EEPROM query error handling to return status
    separately

Saeed Mahameed (1):
  net/mlx5: Abort new commands if all command slots are stalled

Tariq Toukan (1):
  net/mlx5: Use EOPNOTSUPP instead of ENOTSUPP

 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 55 +++++++++++++++++++
 .../mellanox/mlx5/core/diag/fw_tracer.c       |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  | 21 +++++--
 .../net/ethernet/mellanox/mlx5/core/en/ptp.h  |  2 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 19 ++++---
 .../mellanox/mlx5/core/en_fs_ethtool.c        |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c |  7 ---
 .../ethernet/mellanox/mlx5/core/fpga/core.c   |  2 +-
 .../ethernet/mellanox/mlx5/core/lib/vxlan.c   |  2 +-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  4 +-
 .../net/ethernet/mellanox/mlx5/core/port.c    | 35 ++++++------
 .../mlx5/core/steering/sws/dr_domain.c        |  8 +--
 include/linux/mlx5/driver.h                   |  1 +
 14 files changed, 111 insertions(+), 51 deletions(-)


base-commit: c9dfb92de0738eb7fe6a591ad1642333793e8b6e
-- 
2.31.1


