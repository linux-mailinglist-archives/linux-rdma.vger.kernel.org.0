Return-Path: <linux-rdma+bounces-12016-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD65AFFA28
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 08:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156DA4E4245
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 06:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEA628725D;
	Thu, 10 Jul 2025 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pJKcGmpI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C3A22AE75;
	Thu, 10 Jul 2025 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130345; cv=fail; b=UYlmq4/rJv0k45gLMRrtrECovu9bqetwiAs65TpL5NVc/BGwxmNtzXlu7tJXsUdEB97+hRe4kho+LK52jC7YBHkHbvwNCzbeeOYR0wf8muRYr1fHBtwpbVWs02ruc2DFG6PyicG9psihFe0T4q4CLSBlvppqv0oWwc9pmXdx2ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130345; c=relaxed/simple;
	bh=UbVnQYw8e5Vnyd6Q3VcCcxwIH0+zlAweDYEJuK3UweI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YIZLum3gUxGlBAokO9dRN1YlP7OVFXjQ/oo8+ghTsveaLt+xGyWciLBtsZc/8i9FkSKy5nHtL4UnSpHG69fJVg2luR4o5feuX4l9xNvoo1ajLyP9ixQsxmGrQr1S4CltrEZnKrLEQvDpumIIm0+fxoMBtKkH7IHJvmVwpPxdkXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pJKcGmpI; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uS3zhaopcocZyNrpXvOxd+Ca9Gkl5Sim4cqqkA0guHeFQF9EAgApfXU9S722k8Vu3rd3T/ymVS4cztsU+3MntQjrjNeMG020/LxIGgrot5j49MM9FBE71BM4rp7uHQs5g0V0xFaIcCZgA9DcB7M9wZYH3tNDD72D2yrIenkcUz5hgqkCzFe7liPan6HfpIaDfFCJSZStp/fMP/DuHdL8SuXVr9Ukd0POt/0pTEz5K1Im1p2QpomYGMrRXPK1atfzuoMnf3D4jI2pTNy3K4XTAvltjBY3knyaJdSFNgpN2W6yqZ114sjr5YEyI8QGZxhZwuiZNUMe7lPv0GSxUG1ZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZKVyVNiVyFb3+5k1AN3s8UfPvIfDLRgxAmOAtgEJRA=;
 b=UCBx8p6GmUOIYLyo4pTyhlhCHVZq7fQUC/PVZMfSV3GQ8eZPQkcrFoVJIA7eOBIAY/1/VXk7iBxx9fsFpVJbmMlkv4qBNCZlY2SdMDnNz8D5zvp9xTQJRGPDlH5pWj7VsuTc+S4Wj1s9eldP6fUSWnVpzm4L463LmJNMhLBqDnRIDMlhf8O8FAZmqWe+PieMdOnGQuyZwRU8s5AOs05NdwN/eVntKJxxCtxLSgRP+F9eqJV2BH9Ew8MOCCWHnkj19QbdaRhBXZRwaJQtYSeostmM6R8EC3A+I2Vu8KRjpPhRvFDtlO5lZ7r7AFYCjmdm/QUKaqdbVOYZAA9xZNeYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZKVyVNiVyFb3+5k1AN3s8UfPvIfDLRgxAmOAtgEJRA=;
 b=pJKcGmpI4kKaUal/PHOnvKyTXWiw05pDhyP9FsGJUiC4HsJ8Bc9qK+crs+hmMYz+hCtJKsuPAdk+bpC+M29D+TTcsU0J5BsWfWaktJJ0YRFt9kDCzFT/G+HSC05F8ICrnpDOpEyerVaEkC7yYKueICaVIz6cp0FLegeFa6vX3luxt/CnWFWA92ZAw7RmBFp4PKnQ+2SRMkB5k+NLWJHMct2zzS8JPB3lW2RgTrB+RomkrHmTXYJIdDE5fOc+RoqImUyQV23gLTdarDlzgsAw7zYbnS0inJE4mA9zzw2mk5i1uTaj20KEATRW0qk4O1GIkghgWb7f61TnLuN34dC/qA==
Received: from CH2PR18CA0024.namprd18.prod.outlook.com (2603:10b6:610:4f::34)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 06:52:20 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::32) by CH2PR18CA0024.outlook.office365.com
 (2603:10b6:610:4f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Thu,
 10 Jul 2025 06:52:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:52:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:52:06 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:52:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 9 Jul
 2025 23:52:02 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next V2 0/3] net/mlx5e: Add support for PCIe congestion events
Date: Thu, 10 Jul 2025 09:51:29 +0300
Message-ID: <1752130292-22249-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a45f5d-bf32-43bc-398a-08ddbf7e50e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y3ccTdSRPssmh7UC9L0qpIFiSGdgbsqhOgweNqL9/VZMfbKcpb3f3+tvnppE?=
 =?us-ascii?Q?uu/WeZnfy+AxREQJAD3UP9WXd/WDcknrCSBc/hQ4bE8NwOfl+cXrbRBqjJZm?=
 =?us-ascii?Q?pH2zpQXVq1oP/6re0LjSieOB7JlI90uUMfHJIgFvbID53Ic+dn0wLR6vdhad?=
 =?us-ascii?Q?arTY3xr/83fvdAl1Q7SvfdH+I2xPPEEgc7K18HKATUzZT86Z+hqHJTV4bA6X?=
 =?us-ascii?Q?iTJcEAWkriVVuA9i30nQnVWr2g8RE8IaBVebbY/9X/c+pBs/FItlsj0XmZm5?=
 =?us-ascii?Q?5jCBUj8/NH62WgFBj20YRKw3hJZETB7H1cjp3YmjTT78vFoxwKSE+LWujbYE?=
 =?us-ascii?Q?DsNfkvGJDjsDadX97Dcyax+3SzLDzGzd+7gCllNjnYuFq4D6+rRuS4jcOVaZ?=
 =?us-ascii?Q?B1ay9Mh+RducwJk4z5ZxcVsUZ2ez+dLU+SGgLja9QTUZZLGoVmjK5xFRyB9D?=
 =?us-ascii?Q?8YX7Mh7SnkNpD67kDEmZe3xQeinczhOCVegIUB2UQpEjD0AcSyvTnU/v7NYA?=
 =?us-ascii?Q?bz0wW3bUJxsfcyXn83Ef6wjDhn8l/LUM3E3phHA1icijNNaJjTc/gRwdsPrj?=
 =?us-ascii?Q?Yb7AOOmf6ksDY2uPunbFm24BK42WFJsg5G6pU7EkI+TCdM/+oCRb8Ythv732?=
 =?us-ascii?Q?wkB3tfko7qa329VRLhf56MyfOKG6+YvUoKSlFaxO2cRH/A1l8qvJrNxi9ASA?=
 =?us-ascii?Q?qBUVftidX8zNP/UEt3vDECWgp82ZL/xBUquwhM4hgm3kr05+iegJhSWGxRnC?=
 =?us-ascii?Q?jd50UJRZxygwpeaHUHdpVKjTH8iFbo/w/Sq8HxxoCMS+9MkV2Bvg5oPsOyls?=
 =?us-ascii?Q?lz1PhML7SE2VSq1EMj6tqnB50v4hbVp5PHqzP+2kkFzuYQHEhe7JVm46rD0E?=
 =?us-ascii?Q?yv+t2/dWFBSoQKemgw1BcoJPfKXvyC9gmO50CJnl6bY0uaqazG+FOPugSNO4?=
 =?us-ascii?Q?++OXpMsmW5ttcj1qFDBuyefBqhuoJgy7WqE9NHhM2JfhR50A7jNVJJH3LBAf?=
 =?us-ascii?Q?a5AeuDK6iM4hIgKjpiJDu0F8l0B/D0MoiE6agquwaLJIbyPxAaaRrYDPBBnT?=
 =?us-ascii?Q?Czy5wTGz4+ddau1yRqaHHCQmFOQql+4pGdF4nVGizfFzNOf2A3mD+tuwpHXR?=
 =?us-ascii?Q?FqVfTQ8bXCmqLuhV7cJAEr44DoMCSZl0KrzVy8qB25cOVOkTL+wL/xCdwWtz?=
 =?us-ascii?Q?uEe1128mrLRPcyKAeoeUhRWzZzOxTZ9CwFo0tDDfraC9IR078oqVsWfS9b2I?=
 =?us-ascii?Q?XdWnsm+Dv1pj47xqV8jllVW8L0JVmp9EctKYPaNStvPVbuhKvrNYaTZmpKtm?=
 =?us-ascii?Q?jtVy7jx64TG0rqmmdTSPx1EZP69MpiMoioYQjjt9XCdF2+LWb3LM41VF9SFr?=
 =?us-ascii?Q?q5BIiiUZ7tWHt6vXwzzbKNl6BnYP6ApB7gTxovPKmhzXktwY56D8opWMATrx?=
 =?us-ascii?Q?IGdDDj+YLShNCLsOCl8lYVK/pn4/RlKpb7qp7xntXB5Qj344EdFHMSOHdO4x?=
 =?us-ascii?Q?utENJ1qPD8xWcNgl4WdR+d2+FHg3K2mon2BlqxkKcKEqBlv5bwSR9FXOWQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:52:19.8942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a45f5d-bf32-43bc-398a-08ddbf7e50e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066

Hi,

This is V2. Previous one submitted by Mark.
Find it here:
https://lore.kernel.org/all/20250619113721.60201-1-mbloch@nvidia.com/

Find detailed feature description by Dragos below [1].

Regards,
Tariq

V2:
- Rebase on top of the IFC patches, they got pulled through mlx5-next.


[1]
PCIe congestion events are events generated by the firmware when the
device side has sustained PCIe inbound or outbound traffic above
certain thresholds. The high and low threshold are hysteresis thresholds
to prevent flapping: once the high threshold has been reached, a low
threshold event will be triggered only after the bandwidth usage went
below the low threshold.

This series adds support for receiving and exposing such events as
ethtool counters.

2 new pairs of counters are exposed: pci_bw_in/outbound_high/low. These
should help the user understand if the device PCI is under pressure.
The thresholds are configurable via sysfs when the feature is supported.

Dragos Tatulea (3):
  net/mlx5e: Create/destroy PCIe Congestion Event object
  net/mlx5e: Add device PCIe congestion ethtool stats
  net/mlx5e: Make PCIe congestion event thresholds configurable

 .../ethernet/mellanox/mlx5/counters.rst       |  32 ++
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   2 +
 .../mellanox/mlx5/core/en/pcie_cong_event.c   | 464 ++++++++++++++++++
 .../mellanox/mlx5/core/en/pcie_cong_event.h   |  11 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   3 +
 .../ethernet/mellanox/mlx5/core/en_stats.c    |   1 +
 .../ethernet/mellanox/mlx5/core/en_stats.h    |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |   4 +
 9 files changed, 519 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.h


base-commit: c65d34296b2252897e37835d6007bbd01b255742
-- 
2.31.1


