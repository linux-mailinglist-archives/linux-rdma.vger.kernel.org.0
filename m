Return-Path: <linux-rdma+bounces-11982-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0104AFD981
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 23:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF2F4A8693
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 21:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6F7242D64;
	Tue,  8 Jul 2025 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ayKMqGnj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CC423C8B3;
	Tue,  8 Jul 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009420; cv=fail; b=RqPmvKjIicHNcJS10C/MGJlZdjnCR2zKSUnIcX5nMJ7ygVEbDgAdQN3ZC4sl9ZP5ole5Krz0amyiEKeDM9X0Hp7NrkglCaQEv+IG7JhWvtu4BidLIgZmXvbebiFx+rEq486zak9pSALkmRiyKUNGyobOhAiWz29Halxh/TPJTjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009420; c=relaxed/simple;
	bh=uy18lxTnbIj/c5ly/HD9QjUsso4mzqWoN5P/vwA6kjU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UGUIv0cwNMA1RnybllhJlwJv/CnijhUlS6j970DeyCYScWSnM+jRMfIJuNs6K1vG/evXASRnJEALFRiGgxmt9GklfxM7LMd4Vv+9W5h9ve1T5tbg4Ta8i5A32tbG+WkWAUtwfCuWov9G7PglUTXpbSfKP46BnQ1ABSU0gUUtqNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ayKMqGnj; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F083UGUa/NjXwg37V+uQsrK93lZbanwYOkUnhSfe2o4xb176iWInts+eRED3ejsYY+sjsa4wit220rvm3MUexM5jWBVnEFKMtzyIzohu4P5AfMdKR+fpt2UTNZHniyjeB6xfxbMc6UiJmmmTxxybJ193GBRGj7y+nrLbglLB+Ac3yc5XEAOiHbIyPmcVu0lW2QuN9AyRvt7MZz0+bVNvhfiDEQ3EfxW0hGrXTyAhzFySIiCD7HCFFJSdkgJtxiPIP8FSW8hVOzv3Uxfpabk4+RIV8OVwXBMg1rlHd63TOm6i30qo0bqTHtuX52gvpFfX9LC1QVqEZ5n/Gqf7j+H75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nf4YHhVOxfRWQgAvLdvVil/pRlX2kEQC32z+zLlk0bY=;
 b=y1Z0yQOwzcCJsk7EjiOgwtzw66K9XOl5A6q0h7YXV5P85YToSn8BKMtCRPsK7v7uyY6bv7IhB3r1z77vNr8irTy52x1LDmFBSw3LaulVAs7CgFYDLLKlyEKoBxvvOcBdwq6Jr43+FHouNy4kPvE+2IxtCWG15JVlNVFQQ8YCSKznxVB5AjbDzzK1LZ0XXx8OmFmkesrwUR+Lkx/jb5sxNwfOHZDR0XJNEbcN3HPn8CEglcQIoHnWGa0YkDATGTwtabuL/3jDSuVgk6v8Bbg25qgQHzQN/18Ch6BnCj2yG3c37Rd+Uz1ruFn9PZhKlXpQky4eAuCtmWQhBzDpwTiEqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nf4YHhVOxfRWQgAvLdvVil/pRlX2kEQC32z+zLlk0bY=;
 b=ayKMqGnj9UCr1y1GIijao+QvKe3kpWOw8z+5+oR6XpyMyOiRXvnEQyXdDvTIVf40y8s7nb/W2vdVlLWqJrJy597yEGg9e/yI6lkonEhCeBKyF1iQi2Z6LQpkLXxr1GSFCeLVq5OM0hDS98qj76UN+cKxZsJeLJxs3nh8YipaXZfoUZYJ9H0jByRELWtFVLA4Df8jMk3RTQNdkb0VeoTF/DKu35Qabhmj/geVUoqAq7D2iBd+9JVMb5psFwY9q+8swxZSn6nYmkA5jYRO6iKIRkys1vTc0ZkxqFh9v+vvvlLzGlG4LaaTzV1J0WSDWKp2zmjpVz9LwEPTXjOaRJkCZw==
Received: from PH7P220CA0129.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::23)
 by DS0PR12MB9274.namprd12.prod.outlook.com (2603:10b6:8:1a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 21:16:54 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::f7) by PH7P220CA0129.outlook.office365.com
 (2603:10b6:510:327::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 21:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 21:16:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 14:16:37 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Jul 2025 14:16:37 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 14:16:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/5] net/mlx5: misc changes 2025-07-09
Date: Wed, 9 Jul 2025 00:16:22 +0300
Message-ID: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DS0PR12MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd5e596-2fef-445b-6216-08ddbe64c354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1gZDsfEUKuqIYL6sM1sedF3a0UwIDiKETwQ3rDodS6WpBZ4NLvfdy0Uyux7p?=
 =?us-ascii?Q?3bHLerBuZxPGMaewrg8j3mbuO5232ENa2BCjlZjdMhQOfKvimj/iXA8sQmhT?=
 =?us-ascii?Q?uP4TNlnyIUxrjAiLRpXtmGH/KhMSzvinpalX6iEMyO7slBd7qANAVBeGJ/rR?=
 =?us-ascii?Q?QKM1Oj92zF8yEvUKXJfzr53sj9Z6+dvhKT4MSSrKPmp1jCtUNwpG55zbR5cF?=
 =?us-ascii?Q?aLnaSPh8zncaXKV7c8pCNmU5BMT2wBWq1RIeQtWsBXm41lhLmNziU+T02fqu?=
 =?us-ascii?Q?6YXRo+g4PTq7QFN2CZ3dvOGb/1vgzsKJubXvTx4Qco8vGtVQZZKPqDcLB7tv?=
 =?us-ascii?Q?P8o4LjlJo/9g9sIoSG3J/huQfdLoKcX2mVsHI7477NrtUk/wHtFqna/VeNFQ?=
 =?us-ascii?Q?bhUWd8lF0h+o2wUFajbj1HvBJhC0XEvx4RAOWVxFZ2jS4F5P/91dqXjJUp/3?=
 =?us-ascii?Q?uyTpq5Nxx9IhD5wlSxqpA1zxoJbtPAKpOrqz0P75ni8dAh6FXR/wsYceTiVK?=
 =?us-ascii?Q?1srUJNnoDa2LZ26FruTEWb8J+qtoTHRihKSNjoJ6gtV7xTWwSZMJ1hU0EBjX?=
 =?us-ascii?Q?IxI1fgd20GGIyewyKZKFguSF5817MMS+4jKwfdSaDMAPPH39LTesMqjM6cWm?=
 =?us-ascii?Q?ZvO5Xdpux01DL5ZKjGzH5KJHKXKYOmXNdVlqupI6eNmEi3fbEAJyXf7YSLnb?=
 =?us-ascii?Q?4PNCwbRhtxmfZfTz6///uFmmgauxbqwE+H9bDL1XuMplMwRnD0R0UBpSUo9E?=
 =?us-ascii?Q?r6Ge7L7AUvmz5fVROJGGRpf3xXmGD4MUyN6REQ7N0HeXJ8A8zRPi50qSnnCY?=
 =?us-ascii?Q?NUj+HoUBoFQ3HTUDUm9BveO8tTbod9fDCblRNmXk6nzujZktOACeEgBiCcHH?=
 =?us-ascii?Q?8ZougdeWAjvkhoymoZHjat3pRO0/VbJCaBQw4VlAm7kKLnaKXpGy6bDexIGK?=
 =?us-ascii?Q?CRcojQjt7DJqTOpZ7kMSY1Jo3RJCZErSd27OKt51dNwjucL6cpAIvK+9mq63?=
 =?us-ascii?Q?xs3AGmjeRe29bOi4ZOZAjo6DZ1/TxBlTzmU8DQz5WOnv2h4fjjskG1Fp4JfM?=
 =?us-ascii?Q?bw+C/h8X2tp8vELPmSrqxAewKFiJ75+PBESsXWrVk+0A3STCwwefahTvKbw0?=
 =?us-ascii?Q?q5o6Cwrm4TzITiPfhPMfa8snQM7nlJuTUnatGdGVrLUVzN8Mm/JVCYkNKm8g?=
 =?us-ascii?Q?GvkzUPbeiX+jEBVQc/RqELOGtO/Cyq61FVPHej8C7VZITT3F2Am94REkVgQx?=
 =?us-ascii?Q?9UyJz0BoDqH+DnTpWPPknj2xnkBSeh1XXxd/2AWSb1yIfSCXlZ0626GfUUBR?=
 =?us-ascii?Q?f55RAyQAt0tIKmMqvQSVAyNGKGol9tcHCZscdQ0VPPVgvrKRJ17hB8C8mrN4?=
 =?us-ascii?Q?Kb60REqWY6xLvT9dMd+U2R4RDNwi/3PSFwK0usRNlzl4S/etuqHUXLOx00Bx?=
 =?us-ascii?Q?piz3D53WfrQ/0gjh106wYaGUMWxluZ6abh7TR51mhhB644LRPYUB/Jy9SBie?=
 =?us-ascii?Q?jvKvQP3C3Gz3DSzWk709f6fI7chnLhgDAp2x?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 21:16:53.8270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd5e596-2fef-445b-6216-08ddbe64c354
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9274

Hi,

This series contains misc enhancements to the mlx5 driver.

Regards,
Tariq


Carolina Jubran (1):
  net/mlx5e: Remove unused VLAN insertion logic in TX path

Cosmin Ratiu (1):
  net/mlx5e: CT: extract a memcmp from a spinlock section

Gal Pressman (1):
  net/mlx5e: Replace recursive VLAN push handling with an iterative loop

Maor Gottlieb (1):
  net/mlx5: Warn when write combining is not supported

Tariq Toukan (1):
  net/mlx5e: RX, Remove unnecessary RQT redirects

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 -
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  |  2 -
 .../mellanox/mlx5/core/en/reporter_tx.c       |  1 -
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |  4 +-
 .../mellanox/mlx5/core/en/tc/act/vlan.c       | 43 ++++++++++---------
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    |  5 ++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 -
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  9 +---
 drivers/net/ethernet/mellanox/mlx5/core/wc.c  |  3 ++
 9 files changed, 31 insertions(+), 39 deletions(-)


base-commit: 19c066f940666bf6c0982635e4441100ca8d75bc
-- 
2.31.1


