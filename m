Return-Path: <linux-rdma+bounces-15338-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F85CFCD37
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 10:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFEAF306ECF8
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 09:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECE22D9782;
	Wed,  7 Jan 2026 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lywkos9l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01D42F6904;
	Wed,  7 Jan 2026 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777560; cv=fail; b=fOXFWUDkoOsfminZkMJzFiHcI/dT7OwM0K4X0F1z+0yvmFDm2Y9B6gavrFX5HcDcX0q1X2Gm08OHXE1NH3ec2aaJr59ThBe5th5e+oLPXPNV7cYS087P88iApgO1YBHs8Wd0d8M1POgzTUeZmnCg9whiOx9n0kmRE69l5dm/toM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777560; c=relaxed/simple;
	bh=vtFnqNHpr7ZzDArj7am6I9UIpAsDFTg0UgaaUuHPanI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pxFulGZJ5Zt3nG+ccbMzBfbHDcYvSox+Zuiwt2EwJivL+MTGDO4yMC9OD0MpCDKhcN1eGTo/yHe0InY6OJhz73mWkgT75RhqLrtRGQyGiPjLn+s4ZbsYi5gR9bROuJhamnGS1UOdDgTuF9EMfKyeayMAFBvSTBD/c8HGAj9jrM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lywkos9l; arc=fail smtp.client-ip=52.101.46.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9pv7i2jsUA9KqH4z+OQCtkhTJgM+A8wPE3ha0oOD4nXhCfvhvf0/1BP0C+B1kLYHsFEkqtCtuSaCd13nXFoh/lJc9oGzUTz8bpPbegnnBSulrHYSJfKu3XVDs/v2Ueg++2M8MsRfrLXKU1YVvLOa7j78aA9ayxooSaC4O7fUGbrkfhnjTKn4zk0gSwZwm3gf5ddx6bGHfjepmSMUTaiKrZPoUAvOjMiKzNrMzd3T5oDgBHP/lIlZXLCL2ZAnH9daxS0sVl+lPlcIR6Jk9nk44lkS6tAsSz/QFf/1xsrRNz7tT3G7wEUx7DC9wo2Mt/uyloYo1+y6Pvc+DbNZQS27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1K+5gnkDkV6BDcSMQcsicLcc4r0fJRmxrHWwqMO0Qgc=;
 b=tRJ0OZRNO4fiJraMpAHil5LojOEv9Au+Tcwc8x4YiDdpR7n0hmL/a0NLuEovHMDo0HyCKvZJ1zA50G9fuY2rYJC49GtBabR28sYn1CGAE1U4knjsH64iOeFG75UFAPVWd4GwVMxV7OYKSwRXaZrJKBQFe+9A8PVb0dAoKYwNFEEy2wYOkO6V5T1pq9m7k2ifN3b9nwdxZ6Eaz3cWLZZTR8suXVVHw9mnUbc+gzFQK0kFI20/sc0gQIO9P2hDFcq6kCj26GTm57JPg/Gj9JXQN0KWha6p9sP837ZFhHAXDEFyaaSAzG6A0yUZevv1Ir/Gx1a6l/IdbLRSEzuQPExcAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1K+5gnkDkV6BDcSMQcsicLcc4r0fJRmxrHWwqMO0Qgc=;
 b=Lywkos9leQ0daskTIUyzq1e3S+AmRm/+y6nnZRFw8UQS/ZzNA4R78Yg2TyNjdM00ZxLVcTgX5RS02fzmuooCYMZhC3bnBgiv76D7i/M+Y9GKmk5cC/ft0XQoZ4pi6uf1jCJKUak4yGxml1qMhwCbXc+WAYbrF0rIPNTKWHE17ZxeIFTM5fHDqzuS4xDndOsQYyJvPQIdugbCvJwm0rAZgtKspypM1jF/owU24TAKOZMGvw/8bzRoE9nTTvnViK7GWxZb3vMh8Z+TLDpgW7gbx4uT65aI7XR2B1Y7FFa32RxIjtXWV0voyADiv9hgXeiXSbAGwuSN6C/8HKiym8lM6A==
Received: from SA0PR11CA0202.namprd11.prod.outlook.com (2603:10b6:806:1bc::27)
 by CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 09:19:13 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::ce) by SA0PR11CA0202.outlook.office365.com
 (2603:10b6:806:1bc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 09:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 09:19:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 01:18:54 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 7 Jan 2026 01:18:54 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 01:18:51 -0800
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 0/3] mlx5: Add TSO support for UDP over GRE over VLAN
Date: Wed, 7 Jan 2026 11:18:45 +0200
Message-ID: <20260107091848.621884-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|CH3PR12MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e184ae9-807d-4bd5-0e71-08de4dcdd29e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oboRRAXTrVlvCjJary+8JUFoXSmIdwypDdCtatOz8UGTiIxm08O1W2nWxTeZ?=
 =?us-ascii?Q?w11lVoaExVo3QRccJafBeB/YsB9XgjpkRLt8wOFVdbNNG4HkG9kAW2WO+0IY?=
 =?us-ascii?Q?rk6k2FPOrWe1cGn/OypqHldGEC7mYY0dpiLcTOq3/qcK2mY0+USzrU73qB9a?=
 =?us-ascii?Q?v9i6otqaK/sBTwkm0Y/DIzWc5gpC0r/iEBspFZ68UQdVgWRdH5r4fzTVHkab?=
 =?us-ascii?Q?a9c1OILWLwyjADNBcedN3pRGlnYuB5meJl/d9T0Mok7APKnHceCGjZ+z8iQx?=
 =?us-ascii?Q?9g6mhUK+QnH8P9YFGvhz94C3MGo05WMdy/BdKyF/MONHVDszb6/I0SNtdZJU?=
 =?us-ascii?Q?Z1f3QbJNriRkeQ3xzGw8fhTxPwCd9HBpjNZP7hPP7iaJT50tBxt8jR6I6Vgt?=
 =?us-ascii?Q?vlNn8C8aDJl0dWJF6xX80Lel2kaAIHnn96mrguLrPHD3re13fwfrplop3AdV?=
 =?us-ascii?Q?NbCiy8e6237PiOizX2U2awmVa6ZlY1Fj017fzzzIrAf1U/9ttsSkjRz+DIiW?=
 =?us-ascii?Q?lDJHGF8nvEZOH2lschAKDzsINQXglWZwNEP0BH9MdZ7jI4RCB2QBt7EugKWw?=
 =?us-ascii?Q?NnLpAguuIiQ0JfqDNhnZlIg3pUDm2XaxwVV6SI5IWxZTe2miBLdyZbND/FYa?=
 =?us-ascii?Q?aY3iaNfeVev9GLEcHhMLmJGaKxAsf/kfDWS6vZGAYhlfrnqi1DMOesBHyOC6?=
 =?us-ascii?Q?pcMzrN/nvMEH9vp3PtpC35DsI9W4ul6TMqlKq6TiQgboa4cSXzjGLZO6Amgk?=
 =?us-ascii?Q?q8k+hEI5LSuVfM1yksbuaOsIM2ETPnbG5te+9Ehy6GLvghuDYGiqeuZV7pcX?=
 =?us-ascii?Q?toGE5fEPrDKPZFWtojyHAU9wOKBibf3CvSpU7uKpFfA1lYmwQXLjTTPijXB5?=
 =?us-ascii?Q?7VNj9MDdPyEzWoqBe5/chQGJTnQSXOw0Go0iUnGbA876uqPdDS/KvpGHkTCn?=
 =?us-ascii?Q?C2StW7yOQmMBcFt+qVwA8RJbSpVSXm7TtT+1bLmSNSLmgpxoZM2AqOzO2tg1?=
 =?us-ascii?Q?j5Gqmw4YgZsFvvJyu36qlMW/xaGRQxnCq4aOhjI/DhV5PC2+t1gfDGV8y7NQ?=
 =?us-ascii?Q?a2UQJGSSCU5Sy/gCoUv/svPpcVtGYpsofCB3ZjSG54G3BI24gk9nV8n8tkyw?=
 =?us-ascii?Q?IkVutM5HRZhV3xNq0m918By1YqSIZfxuex4YiFxr4N3oheKRhFmg7LKGOCiS?=
 =?us-ascii?Q?tqVRwXC49snufbO7EVIpMPjWbjsVXcu8SlvVsdtQvjPa54A0SH2HdIvgCvRC?=
 =?us-ascii?Q?sCMNr1eVdrnxG6EzKzo//6ZloRUY+TeV8cMVF9a2wfVFEXHxHlR3JU58rLEs?=
 =?us-ascii?Q?4YHnncdOwQlglv1ZLkL61S28rJtLwa7NkSZWqExs3rhkHgdjm2UWW8BETmDZ?=
 =?us-ascii?Q?FeQSnVVrZNM8YS+Nv0/7OdGpHip8GqICRI7TzD/+ZsqRD1rinkpI+3vcFlVM?=
 =?us-ascii?Q?4X7xDUglt3oaZlKnRglrfzTouhRU44ihaKQ/z/dYAWnd3yZbe2m4AtgGswbL?=
 =?us-ascii?Q?DoJhibEXm0EKNu31F2g2ZNNn3K7qDZF518D59HvSsHtJ5WzBUk17lwCqWexr?=
 =?us-ascii?Q?0xEDq3bdw1BrK+8IsgM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:19:12.9074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e184ae9-807d-4bd5-0e71-08de4dcdd29e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260

Hi,

The following 3 small patches by Gal add support for TSO for
UDP over GRE over VLAN packets.

Gal Pressman (3):
  net/mlx5e: TSO for GRE over vlan
  net/mlx5e: TSO for UDP over GRE over vlan packets
  net/mlx5e: Remove GSO_PARTIAL for non _CSUM GRE

 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: 956f569c90ab507559342d289f4c923adfbf06f5
-- 
2.34.1


