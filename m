Return-Path: <linux-rdma+bounces-13993-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A573BFF60D
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 08:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02093A8EA5
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 06:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDF529BD87;
	Thu, 23 Oct 2025 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CrMFUx5I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011057.outbound.protection.outlook.com [40.93.194.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CC91B7F4;
	Thu, 23 Oct 2025 06:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201910; cv=fail; b=LtQnYPJTfbc92/QWIXd16IUABWL7wfyFaOxFgSE7GgV0/WajI/YlsifLOYqt436paHc7X3so0zuo9FenkV6fLtBWllTLj3hyCHniULqc0G5M9H2rkv1w6t4xF+tzPbOxkeCVIl4La2FMuninB4lq9zJYKPvuTxMsTocjqzYRoPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201910; c=relaxed/simple;
	bh=xNNqT5fcI6GfRmV7p3+m5H2uoMDwfWdXSxfIbt0L/2Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IfckmkQQ+VFnKiBitCUHc9+JPFR1Bk48LfsKwVjAKcTFztt5la7hrkhBXAwC5DjWScXKYj6/aHojKbiJ+Z36PHOghHx6sTEL5cdYy5qu1m+bQwF0fwUoC9SmQH2DtteRaNMEC3iNXbc47BtFDxgiiY/GUkw1xHX3PgsuIZpWtw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CrMFUx5I; arc=fail smtp.client-ip=40.93.194.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tL2EKHQtvtv8Rzmlc1EsknYOFbIg8SbN+k22oDlzCAlWsNzM5N5NdwrFkdRjEAVkzhgoPu46j0FbUXb5XJk6CtFr+/JaB8dXjLclQjjGNbLRngF+A8nTeEe2TPHDEMXjWSA/vbx/VA83YeTjenIy04hgqnE99vgbsf/fuKqt2JzjeyUnVpiwNbA9/3dXkB/Nq8R/ky5pDhe0b2yfIg7PxsuXeCYgpJ7vUmbPB2OvmXV4ZnP5tB/KUPjpkNscVPrr7KQZ+FiJUO5BElqW/Pgc+8dorsjgqUclfvA7lhu9nLe8JoYO+EbUfCCShaqmSprGoZhgQKHVBV0c8rbAwJuzBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gm84BXzXzTq9xLwE2Pd+bOHCuU8q7TWR14bj2Mthv+E=;
 b=HvipD8qWGeDp8/omCyK3/Af/vOQ/8bJM5TAxUE/btyekRSHFIXTAODP9mRxUNFwU1HOuKNBvK0aUto2weBoRlafdj4p03dk0yuq3mLlHfPSZ1s9DU1IYHw5PKxLkgf9brfx/QbP/XBCF/Snos+C9gH1jkm1A7FF3iyIv04iqR8RL383keDL4r+yKj9y/lDGux/hpRaifnkEKD6Cl0hU+S6p7ysu2miSN1QkBQ21CAvP9oP1m3Vt1Sb5mj43bwO9kbYNT3UTGpiAIxIx78vpdwB0PVXuGzis/4jh4XUVB0vHDDx+wSrUlO5YtlkkrgjIHBCPcG/oNuZl+gZgugQti1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm84BXzXzTq9xLwE2Pd+bOHCuU8q7TWR14bj2Mthv+E=;
 b=CrMFUx5IAAIa3tIoy1caN43n1Gj6aA+Inm0zhEiFMkOgxX42QAPUwcKfbfE7NyGuC6FfYCXmDlzQQwtCJz/1YE/4KO69PTKQMTEzASf+3cVoFxvCNRvOERqeFV/xB0jzjJ/k3h06RoirRzxyRJKb0nM1k4eiBfPl9OwfXtHBabDANla7QtVd9JtotLJJqfQclq9JzVizEpeRZloBvrSOHBXfIj+q3NO/QZKFElCyY9bmgCK45e05FiS1HqlNOxJD0bNBPCMYYWr1ZDUs56qNdoS6rOqGcLqQK9cdkktleUQXjv9rVC9Nb2iUeZb8i7ZiKI0nrcKCnkqdoLetCNEroQ==
Received: from CYZPR20CA0022.namprd20.prod.outlook.com (2603:10b6:930:a2::21)
 by DS2PR12MB9824.namprd12.prod.outlook.com (2603:10b6:8:2be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 06:45:03 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:a2:cafe::60) by CYZPR20CA0022.outlook.office365.com
 (2603:10b6:930:a2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 06:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 06:45:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 22 Oct
 2025 23:44:49 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 23:44:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 22
 Oct 2025 23:44:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 0/7] net/mlx5e: Reduce interface downtime on configuration change
Date: Thu, 23 Oct 2025 09:43:33 +0300
Message-ID: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DS2PR12MB9824:EE_
X-MS-Office365-Filtering-Correlation-Id: cc034d61-4bbb-4be3-7cbb-08de11ffb20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FRX1wDaVR4K1YJNz+mdzyHcgEFxvL3tfYqGdwGzDxPnkF/1UOYoebeku7SGQ?=
 =?us-ascii?Q?niBZXBZcx9/rCfH0fpIk/VW6K3w6ZdRcj3DMP57Pq6NzWavzdNps6VKU3Ey7?=
 =?us-ascii?Q?W0xMN9HxRluxs+qL2WupSt6ulzSMLPissrQWW/ojx2rDFYVrsUxMDQ6pjqHs?=
 =?us-ascii?Q?jyNu6Xb1UWgu+tSnU/f2t5c4jvka9+uI55jFhIWWxD2B/JzLa8zHmmlnn1kB?=
 =?us-ascii?Q?LlJ5QdiynAWau67lvaLn8RpBRkhoPNjPrprcV8+XZqywcohqtlMwAUZkFk7H?=
 =?us-ascii?Q?ps9mPurev4uUXfG8ikMkBVFMqPxkN9dXfTZWCQOru3fCIGfI2HF0MnP/IziA?=
 =?us-ascii?Q?m5SvsdDyWXOt1rf8kGY/j6l0V3HnSEbovD/l5eYcjsHV28wQSUHMOFbbA7iQ?=
 =?us-ascii?Q?0KAx0hlJnouZjHSMxOmtmJi2Zx9pTg24pe+0sx+ySrpoaukyzAcr/KUwCNlp?=
 =?us-ascii?Q?nRgG/rqJd8+au4pU+O0x6AnHX9j1qwK9Ghw1tbDKzDZ73k07UmeH0un7tL8j?=
 =?us-ascii?Q?0USiKqO8vnv2B2r1pibLAQheH8uhoKgu3iwF0XtBCg9Ny/fP2RykMtpYPop6?=
 =?us-ascii?Q?33Y+dFSccpElGWt2Ez07kn/Y4Eke85dPyezzju8sO3NudM8yljavOHIq7PmL?=
 =?us-ascii?Q?S1BR3pZBbjZ4DMm5C9XkPRrpyDOA7c6JXDG8iEHhAZCiBXyPft17zJymXC7I?=
 =?us-ascii?Q?Z81O71z+hhoz478+7oeTQmYW7Gh+kc0w+Ue3dPec/nzrfWtHYnx2CVTXxNnw?=
 =?us-ascii?Q?fxzwulLy0MTBgH6SAQ1qStTfoRarx4fVbNOuQov3CHo/pe8fNevUrUnbcfOH?=
 =?us-ascii?Q?hCQqlVKJ+shjdX/jeTS7ARx+p0JXIzFvBZzLJvzBThFRCaLtm+Pi3vi3nOic?=
 =?us-ascii?Q?f48v4+godSx/1q2VjsHh5Qv2yj5xhyTNxdVq/Pm17SzCm0ZGsKuo1q79nPrC?=
 =?us-ascii?Q?K9DymRroVqWqr32X/DK9klTJqh3oX10FKY2hsQQ/5/+UT0FpBiF7vgkgtsmS?=
 =?us-ascii?Q?9i+nXQlssfXcoTH7atjvyNroDMe9n6i7R8Z6kLRh44pF2BdOem8s4KltpUtK?=
 =?us-ascii?Q?c9eDnyT+JfRGTrLz1hjAgDkgA6MLw0CNhjufG/4dMYy4JAnsyy5GNsC8QB2U?=
 =?us-ascii?Q?FB0pX7alhAa6mLfzyPdpH9RiZIIAPw6bEQzCR0eo1D/OI7ztqDKlDK9DPsDO?=
 =?us-ascii?Q?TQ1XGt+BBvDg1e0Yf/hGy5LFx1r1/oTNaMiVFqA+ZUBdKpLzYImiWtGyFEJs?=
 =?us-ascii?Q?3Jux+05Kbh+MvlhPjLByObCGUpTyUUWAW4Z9Czql3hJ7tEKV1BoAsE661Hw9?=
 =?us-ascii?Q?EytA9jHl5kkNF1yuk7W+NSOf6O6oT9LB3pUUl/V13uMxnHFR3XyBM+hqv5ZE?=
 =?us-ascii?Q?zCx/pjv5KczTZ4/aLWhsgwkec4C+gmyPvgkAde1eeZEMwDBHSiaUofExihhK?=
 =?us-ascii?Q?0ytjEjMUUJ3pag7SFyuMj7gjK20bFgcBw+YU4LV+piAVB1x8WGjlzJSLnyFb?=
 =?us-ascii?Q?qzPO9kvJUpvyap7mi0LcMTJgs96apuMODdqOOIvZEHiDRJGflDCf6TTPyE4c?=
 =?us-ascii?Q?SMg1elZ85XnYyWF8uVI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 06:45:03.3654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc034d61-4bbb-4be3-7cbb-08de11ffb20e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9824

Hi,

This series significantly reduces the interface downtime while swapping
channels during a configuration change, on capable devices.

Here we remove an old requirement on operations ordering that became
obsolete on recent capable devices. This helps cutting the downtime by a
factor of magnitude, ~80% in our example.

Perf numbers:
Measured the number of dropped packets in a simple ping flood test,
during a configuration change operation, that switches the number of
channels from 247 to 248.

Before: 71 packets lost
After:  15 packets lost, ~80% saving.

Regards,
Tariq

Tariq Toukan (7):
  net/mlx5e: Enhance function structures for self loopback prevention
    application
  net/mlx5e: Use TIR API in mlx5e_modify_tirs_lb()
  net/mlx5e: Allow setting self loopback prevention bits on TIR init
  net/mlx5: IPoIB, set self loopback prevention in TIR init
  net/mlx5e: Do not re-apply TIR loopback configuration if not necessary
  net/mlx5e: Pass old channels as argument to mlx5e_switch_priv_channels
  net/mlx5e: Defer channels closure to reduce interface down time

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 +-
 .../net/ethernet/mellanox/mlx5/core/en/rss.c  |  2 +
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  |  1 +
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |  7 +++
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |  1 +
 .../net/ethernet/mellanox/mlx5/core/en/tir.c  | 29 ++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en/tir.h  |  3 ++
 .../ethernet/mellanox/mlx5/core/en_common.c   | 46 +++++++++----------
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 31 +++++++++----
 .../ethernet/mellanox/mlx5/core/en_selftest.c |  4 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c |  7 ++-
 11 files changed, 94 insertions(+), 41 deletions(-)


base-commit: d550d63d0082268a31e93a10c64cbc2476b98b24
-- 
2.31.1


