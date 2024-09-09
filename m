Return-Path: <linux-rdma+bounces-4820-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF599714CA
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 12:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ABC71F211D8
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 10:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07141B3F18;
	Mon,  9 Sep 2024 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U6LzhAtc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1441B3F0B
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876324; cv=fail; b=VulGNms1mVosu3qHYwK74T8Q1SDp8zGByVBaEWzG8JUJciAbSyEuVaC82OILeOehOITJO4mEQHsubaqhw1vAZ1ilKRbMPe8sP2F/UE4pWLVJGaHExSW1N5Sb0+gUNQG/iEQTcinlzsbOx4Xzi5IsZFE7V62+7dVLAevn8UqHWws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876324; c=relaxed/simple;
	bh=F3SafvsTI5H1BmXMLDFC9k2hly3o03djWWxKjZzctFY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jPGS5cHWkCBhov9XW42YLD8LmohLxHkjnFDVmXVVSNJ4Bs21NVc1oYuGh/xgDzYkvCnSZ1UPWvEitSOICBMDAv/CXN2E/bxpRnZXti6c+oZ9gET2xjHylsOPCKAVsIqZH8TFj0+2MMbDUFstUf0ca3Hibt9nh1T8jIuMEdoXeEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U6LzhAtc; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYeXipiVB31BGHzgVBwMHqP6S74ytaFJgva77gSjBP69g5Cg7bYlz1dyCctUGWkehcxd8IRJEL+jkdlXrNd+/3TF2AJYizKJdHNvZM+x4ygho/UzcwMcGi7cH9xjz5IlCFh5qhQQYPbwQMrCPgJ7TgdGV8hPwftuLFx5wWAWlXR/52KiJLD//Q6/bllcjrKR/48eiI7F74Sh37OjSyWMC4LBwK85r1Wg0jvNiMW3ABnmSu7c5W0xKQMWKbcGSgvnf96XzJhySEMRyjs6IRHa3aUh6MAnVl9tklz+L+LaqQbZeUwqHAOsYuBKojH9UzukuyXmXLBKft8axroHw/w7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+gSNray4AZFDenDCE4kN8lzdLv9p9gNLOPcgSgfLq8=;
 b=o6yQBR9eGtap7SLB9b34SjSb9uM6igVnEDaHkr8sdxYc8CnatSV/zNYXFCC3n2zEQn/x/CKqppXQic55uvbYYfTBrXG/j8Ond9Hf/RaFrwm73kD+IyQvmu/JT9KqYz113GpM1vDBblaF0LeNL5FT1g014AYOcZN6oXL0JXRqn9+A5m6gZn/c7ZAhc6CA91wXjBC3PrsFlx3srxHKOVjGkqOTro/MC/pHNK22YdRPSINJa96aPOJKVaB5aqm8aHpuGaddl4mmwqQDOGqbPoPo9hCh2EnUMUYf4gS8YZaotkCImjeHvz1XOORl0H20/UfiocXu4qsr3iKjGMp21q+05g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+gSNray4AZFDenDCE4kN8lzdLv9p9gNLOPcgSgfLq8=;
 b=U6LzhAtcSSOVDj5ATJEQdY4kuXALI6RoXgOkDUIHcNGjvmo5Tm9hXgkjImyXryobkOgbXm5yPNgkIKmMP5tFhpQj/G/e8/VgwA6Hoj3rDFbjADGFyCEn3gmXWQkd6cIpHlPgeEiMJ0W9WdXVXwHxkZq/mBopDFuie7l0Bkq0+d3rPvL7pLRP01vTMxAQVi53l9ELERfYhYwc7XcHlYZix6UPWX8kTFc9h5+BUp2uMad2wyqdi1UmVV7B07K+cqsx3XvEi6gvl9m/6/hGh/pA3hkaV6PImIANEDEnBI6tbg3eeNbw4a7xOozFlhjzAv6hO8Sy3khTv0qu646/ZGOTdQ==
Received: from MN2PR06CA0022.namprd06.prod.outlook.com (2603:10b6:208:23d::27)
 by DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Mon, 9 Sep 2024 10:05:18 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::8a) by MN2PR06CA0022.outlook.office365.com
 (2603:10b6:208:23d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 10:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 10:05:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 03:05:08 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Sep 2024 03:05:08 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Sep 2024 03:05:06 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v2 rdma-next 0/8] Introduce mlx5 Memory Scheme ODP
Date: Mon, 9 Sep 2024 13:04:56 +0300
Message-ID: <20240909100504.29797-1-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|DM4PR12MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 51256cfe-d793-4d1f-812c-08dcd0b6e8b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DG2Ez2zkJURj0vF+zA7NJPkariJ0tcd/y3yr8G5Ozv9wjSbxgda1846+F68H?=
 =?us-ascii?Q?wRaAQZtJzsBJBs9RBOgNOmtQx56D6Bf0l8dDRtQ2y+Sip424cEqOoAjhhGDM?=
 =?us-ascii?Q?4hlMeJidTbPd7YN3iDothjom+aXTRNFlkr56+5j8SB2zS6ltvmULtnnXzlL6?=
 =?us-ascii?Q?0F4jkASu6mENs0WrJIxK4G45Z55XHzaDA75YOAq/oVfIHrytTgrLbBHAWATN?=
 =?us-ascii?Q?X+XcKKFHsGZVQT47jQNvEBzBmABzv+36cJuDzgjFe2d6+XGt1CI3SlrDB2/s?=
 =?us-ascii?Q?Pw9l+p/IBWdDbFoVxd6UrU73nIMWOIDULTLEtLnmBYUKehOeVBPKWMiWz8VO?=
 =?us-ascii?Q?HceNJUEsHnoihqqZhT8T52VycvdLRC76BKSRXu7DB5fCi0hxKUoRx/Ftlr7j?=
 =?us-ascii?Q?UJkIkIKHLMSXp2Eu7IEvA8e70nJ3mI1PFMLEoPXsj8kJaPQJJv6PI5aVT866?=
 =?us-ascii?Q?GL67wKarhmtzOZmgQOwFHlXidpEXCWhuULw1qsPDSIqgI3em7Mx5mh7UAh4A?=
 =?us-ascii?Q?xUdlS5c9IgMAaQADsLvI6bNpdYuCHHiPPY3IAptTE9oDrqXnPOJ/pGtIdmut?=
 =?us-ascii?Q?Olm1Kp7mAYd0eTU8px4xuSOQ+gQywyf/bf98c9DsvBGnY7FRWjZqwMMWYKb9?=
 =?us-ascii?Q?OSlaJ7KCqEKU9b591NU37ODQzTMwM4dztUa4i7+mxOksXmqmRIu/uAmprOlk?=
 =?us-ascii?Q?EElMJ/0kjp39qUycNHfVXN9phcxwgam6j3g1ceP4Q0VsqdIT92Fm+O6bC1va?=
 =?us-ascii?Q?iz9lMsyGRdevwX655mI+OQl2B8ZsPDIDf1OmP6rUS2JWnO7REwx/DvhwY3xy?=
 =?us-ascii?Q?gmd0c4jq1Ko4lMSERB72/juJN1uvQovqt+wSsa7Y+JpkaF/w30P+dfZ5oTRi?=
 =?us-ascii?Q?lLJ1FnIEeXnY/o3IMK5/EGUub6nmsOJSQ8LKG/qwJMLsJ+XKjcXThM2ZmHcO?=
 =?us-ascii?Q?gAuUnc9RwLmcJGFiQs46rC/+SPhJEBPTKgyQ8QouEP7ct4DvAaiZKjJfgSd/?=
 =?us-ascii?Q?F2InSsZXXJH+RaWfaChYcRaEwZIozUkt6SyKp93JEKvXAug5s3ZtpGv8tdoO?=
 =?us-ascii?Q?9YEnWo+g7x1HIdRzzEOZqcTJIbWZ5G80/TWBtMGAVaXUFkFi9hzgvEn0q+j7?=
 =?us-ascii?Q?Yan0MHzdgccUxLlQ1ZsLBlpzfHBlCQWMO6K6uBe3ODnokAStZ1Q1ezaYCh7J?=
 =?us-ascii?Q?ATbQ3IKGEs8qhVNB16V9aVAONnz+IduLTpFvmzR9cZVE94gjR5tLciAQRyMZ?=
 =?us-ascii?Q?BSuvaOZLJwPXlSZvXUZUsAyTjJWCHV0egwWaYEJgDO3VXLlqo145VlLnT5Qq?=
 =?us-ascii?Q?euqOHdE9gOHUwNnLMNN+sEmq9I3KrsWmLHysk+sCJ+9/hIY1Nwh2n3rNEi+w?=
 =?us-ascii?Q?SKk3BHSKUZ3Gp8aidv3lSawjjVPjtRnRydIwNSsP8rorybE7EVcR1EvM02GH?=
 =?us-ascii?Q?QCtUmfIsG9ysBEN5nTpDdKMOZ4JdBkrN?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 10:05:18.4868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51256cfe-d793-4d1f-812c-08dcd0b6e8b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400

This series introduces a new ODP scheme in mlx5 where the FW takes the
responsibility of parsing and providing page fault data to the driver
to handle the fault.
As opposed to the current ODP transport scheme where the driver is
responsible for reading and parsing work queues and querying mkeys to
acquire needed info to handle the page fault.

The new scheme allows driver to support ODP over Devx QPs where driver
is not able to access the QP buffers, owned by the user application,
to read the work queue requests.
Furthermore, the new scheme allows support for ODP with new indirect
MKEY types as the driver doesn't need to query or parse indirect mkeys
in this scheme.

The driver will enable the new scheme on devices that have the relevant
capabilities. Otherwise, transport scheme ODP will be the default.

The move to memory scheme ODP is transparent to existing ODP
applications and no change is needed.
New application that want to take advantage of the new functionality
should query which scheme is active and it's capabilities using Devx.

v1->v2:
- switch mlx5_umem_find_best_pgsz to a function and rename

Michael Guralnik (8):
  net/mlx5: Expand mkey page size to support 6 bits
  net/mlx5: Expose HW bits for Memory scheme ODP
  RDMA/mlx5: Add new ODP memory scheme eqe format
  RDMA/mlx5: Enforce umem boundaries for explicit ODP page faults
  RDMA/mlx5: Split ODP mkey search logic
  RDMA/mlx5: Add handling for memory scheme page fault events
  RDMA/mlx5: Add implicit MR handling to ODP memory scheme
  net/mlx5: Handle memory scheme ODP capabilities

 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  30 +-
 drivers/infiniband/hw/mlx5/mr.c               |  10 +-
 drivers/infiniband/hw/mlx5/odp.c              | 400 ++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/main.c    |  54 ++-
 include/linux/mlx5/device.h                   |  30 +-
 include/linux/mlx5/mlx5_ifc.h                 |  64 ++-
 6 files changed, 457 insertions(+), 131 deletions(-)

-- 
2.17.2


