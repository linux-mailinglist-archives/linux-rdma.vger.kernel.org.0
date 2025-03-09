Return-Path: <linux-rdma+bounces-8514-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF087A586D0
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 19:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 261CA7A3E13
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 18:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B061F09AD;
	Sun,  9 Mar 2025 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EA9IkUZn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12FE1E834E;
	Sun,  9 Mar 2025 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543702; cv=fail; b=LSq1Z+OpU0MIx9QMEG9W6UgXrVWK/XzK7gmJUk4QXJuOnsRqrKbg69OQBruWlYJXU31jEItDfMDOl3x3jrEmkP8H4FPIc+h/fluyunU3cqmF+yxCs6zKYUeuvlR5ESqoUtxibC0P6PYJ9U/CWMlibk/mrFdx4A4Cl4dW/mLKgUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543702; c=relaxed/simple;
	bh=mE5cRektXGbAAS6sSLaBWdlyw0TdkeOPfTEDP4osQvs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bcj7VU/Mrz9utsL9TahoO5gzTG7du7kBaYOWtUeSwKLKH/6MuUiGpOCJdP3wzVzmmz5WPBAC3YnehKnHPoqiZzki0kR2nUniZ5KKaCMGLXPjtGeF9LjTkRDEN1CKYhqunFL5ZJWnM8aeyA2vrzZ4brsSP+y1D/PnVfWTEqt43yE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EA9IkUZn; arc=fail smtp.client-ip=40.107.212.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QibxSx70EkliNkqDnDGX2aaECyMPk+yMMi+zysx3dc9BqA27TEK2TdJlfNZXwoCuMOLCEGwTp1Lg2CWlM6yYc5t0c/DFxpx/aHEsKBOnpMnz9LGJS4SMg7hOJFE62rWNpLcfNt64Ti9uW0aMqQ8bZZ87b9MFE45bHDImZXvo4LmrDCk4gAShWUeh+LOIZtNtNB/o7wLqxio3GRkVbC4/wdUsryGHNaTFTCUG28t0uYq1gGpseq69CE6nh2KTcoxXixcqwetGIGaTsYWKL/nnM9pJIa5TYPA79M4ytcTLz9T9BnGhB3aLudFsIPSueDqflqMOAZPVlZkMYZf13rwCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYVN57Huf+0YLTQDpFNNeKWQrVP5F25fREn/KJM4yOc=;
 b=kOR/7FQLAP9Uw98REx0eTelS+lcjTNfARs0XcoD8MUZbr8NIxMOXlDE1h/IzDs3byoamhT4axnC96cxT9Vs+kD9jKmGLk2YZf0cQzTp1Z6QksZsTjkOKCGxge1cX/FBwKnKnK5M1tLzoTKE6gxRlrBr8SGEqqdcyJnNj16NOqwbVNM1yFZTNkobPCYHN8ZJ2J4YTSRE3xyeEF1YoP0yUvq+zL9N+KUYhx1bf4zl+LDXYMy5tiZMT1BjBHekNYrfvNAQ8KnQefvJrA8HID+ldnmCBCxWyGj2y+a39Cvsov4r6+rlg0nzozvCLsBwt/DS+/ZEeH0BE+KnHlzKYnUfsIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYVN57Huf+0YLTQDpFNNeKWQrVP5F25fREn/KJM4yOc=;
 b=EA9IkUZncTqpaaANuIRZZEoCLywbyk4QxvXm/+npXCb/pvy/kbLaZjEpoMXF5jOfZGdTtz9e5nqvQxgCH6zQ4U9Xiz0+rqMmp3PUaH1nyR72sPx1TFSx+d7RA+NFK4U49H5AkPEWDxSur0IPyvG+PnBtu+5ymT3KyBou5WnabaE4kw9uDCrNEB/KlTFJwlcU/3RXW38btRKwdI4dG7u8c4QF6xJCzT3uo+uMfVndQEm97HfOf+9m8F3YbnVw5M0w7RveIYio3V0Kvq3l8I4ErsnmWFKXy6z/R5EVkc2IQ+96xDBhOTrsno4N/eiOkJ9BlCjX6727LUOO5x7B95uaig==
Received: from SA0PR11CA0124.namprd11.prod.outlook.com (2603:10b6:806:131::9)
 by CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 18:08:14 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::9e) by SA0PR11CA0124.outlook.office365.com
 (2603:10b6:806:131::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Sun,
 9 Mar 2025 18:08:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Sun, 9 Mar 2025 18:08:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Mar 2025
 11:08:09 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Mar 2025 11:08:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Mar 2025 11:08:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/3] mlx5: Support HWS flow meter/sampler actions in FS core
Date: Sun, 9 Mar 2025 20:07:40 +0200
Message-ID: <1741543663-22123-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d4d845-12c8-4d26-0ed0-08dd5f355be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gRslLy6AAGCFVqCJZ/QoUkY+6BjNcLA2GPRBzjxDXXwqjv4gqGvEzyFuOSfq?=
 =?us-ascii?Q?KULf3JfSgiSusgEcCYg1FXND1p85O/MH4vzglnOkIIpOA/De4n/+FocH6oiH?=
 =?us-ascii?Q?fKQ3MVe8akCLAnSYijOxgQ+sYIC0bj8eSFxyE4IBkh99vm5H3r4T7QS9rPlE?=
 =?us-ascii?Q?Sgy3aucQZExh08hyRhllvwyFs0j9cUeJO/L4fi0ZQCH2SKWOUvlVSFxdbty8?=
 =?us-ascii?Q?+d9dk67wDDPloKan45sAkpCkwFP/k3xoCA0l4s74VUFCAYFkT74asIZqjdNl?=
 =?us-ascii?Q?QqifLzeAEOzUecOv2VGjmmM61ZdxxEtD7d8jNylWJSbew8CkaHUGqw9K2+R1?=
 =?us-ascii?Q?ENbZ259KV3mTJMGDdPBaoIn5QcbuCcD5k8glOoeyAbM6z8ggIdNeXz9cOBeh?=
 =?us-ascii?Q?vhWJgcd3JqjeYasUOYHYb+zixOWYlKl8WB18ntMccJeK/ENfTZKJY7A8ogLT?=
 =?us-ascii?Q?N99xDpsUM/gTV4IQsACkW0uf0WSj1C0/tVHuGgeDuoFnhbsA7292N+YDVQS2?=
 =?us-ascii?Q?x/6IHtv4yBl65VxL9qbbTCqQavCb7VFqcfjG0e4pgQ2K7lY8ItmbZEvCj70E?=
 =?us-ascii?Q?hfTotJyNmgCxzElQfS29YK7N/j3W5UjV1U2cBn/acWRR3MHZTRWQjrGerGaA?=
 =?us-ascii?Q?5R1pNhHA2sFQ8+SnVLL8sd2dTL9MgLjGilkZKOqdN1MUbxmdstPcuJ+wVGtK?=
 =?us-ascii?Q?N6VYsSfqJHEH7p4mGn5/uJ5vFACJJjFrYOYWNA+owpMo/nYZif3ARA6wOKiz?=
 =?us-ascii?Q?SWWTbVCNsnHzL8v58M/rPfIGvlQ1sYLevJsxWdfwxb3XQBmPQMcBlWn+G8c9?=
 =?us-ascii?Q?vUShF2bw6HsQwPWYpjtx3y7CjKDTn7804carqZi2+FyEG01VPQUkcKzmNKe2?=
 =?us-ascii?Q?EFoiYsyFFbEWqyG+8kCiKzwAzfyQgdDcSFGUtM+QzmMlgvlSPxYYET2CRwbr?=
 =?us-ascii?Q?CpAgURcpOzVceA4+MXJ8UMFZXVdUdNUO3LE0l/S059mradPJg7d0WjqvWG90?=
 =?us-ascii?Q?/AtYNIcB+IHo7iB0wC6Qt40D6ZdZa0tGJwIazUpt7SZh2+4Oru7lN5aiWChJ?=
 =?us-ascii?Q?8Zml7pUSIBV5QoRalKRvAFf8qZSo3WlSNkwMTapAlxwPWq7rYrEA21SVh1Ls?=
 =?us-ascii?Q?SdTlhl2rPKbTx/rYvf9u5+SVY0aXj1VlgjNNC/KHZCEdgnaT8O/8QpNgg3dE?=
 =?us-ascii?Q?83oU7Gsx0RvCNCfe3Wfx6P5gjbdtmkri6S0zjSPCQyu8sgtjZlJunB7djxjO?=
 =?us-ascii?Q?tm21BnOIUCEc6dpKhDtzZeUEDbXmeYd+nMD2bEGeTxB31WzwCiFNk1OlHBGc?=
 =?us-ascii?Q?SWI1dIjVN2BFtqVFyqy+4zIs0VrsJupsO3tSRjT6hzFeCBLPBbjrxgdWVLah?=
 =?us-ascii?Q?2rVvDYKMvd77pw/G+Q3T7Rv1kLgaujH3Map3YrCDqYhHdvGR9PbVG7brumMU?=
 =?us-ascii?Q?lp3axLhUlD8zGuxKvQRhWKzzU3U/p5/x0r9hhzt5kimpVUhqBLl1jeHrnd25?=
 =?us-ascii?Q?WijkN8hcTbtVSAE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2025 18:08:13.4700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d4d845-12c8-4d26-0ed0-08dd5f355be0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506

Hi,

This series by Moshe adds support for flow meter and flow sampler HW
Steering actions in FS core level. As these actions can be shared by
multiple rules, these patches use refcounts to manage the HWS actions
sharing in FS core level.

Regards,
Tariq

Moshe Shemesh (3):
  net/mlx5: fs, add API for sharing HWS action by refcount
  net/mlx5: fs, add support for flow meters HWS action
  net/mlx5: fs, add support for dest flow sampler HWS action

 .../ethernet/mellanox/mlx5/core/en/tc/meter.c |   5 +
 .../ethernet/mellanox/mlx5/core/en/tc/meter.h |  13 +
 .../mellanox/mlx5/core/eswitch_offloads.c     |   1 +
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |   8 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 231 +++++++++++++++++-
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |  24 ++
 .../mlx5/core/steering/hws/fs_hws_pools.c     |  41 +---
 include/linux/mlx5/fs.h                       |   1 +
 8 files changed, 272 insertions(+), 52 deletions(-)


base-commit: 8ef890df4031121a94407c84659125cbccd3fdbe
-- 
2.45.0


