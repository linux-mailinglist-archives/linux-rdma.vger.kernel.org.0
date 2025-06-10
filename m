Return-Path: <linux-rdma+bounces-11138-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28668AD3C4B
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C79397AA8AB
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A4823536E;
	Tue, 10 Jun 2025 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YGqqd01q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B7620102D;
	Tue, 10 Jun 2025 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568248; cv=fail; b=Aus1SbD2M/C+8M5PJFBFT3i/DVHK2UZ4iU7By+hqIOXdizeczjnk1A7C81YEP6SrPHPfBE1VTWFUhZLU9RuFYewWaJwBiD+heygxTVo7GOOJwRFZuWv3XGzBDQNmJUTKWOajmCq4eF5A0p7C51T8k8WbAa3PDA73bLqUAHfybZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568248; c=relaxed/simple;
	bh=uKq2ysJiBf8cg3H0HXFADKDn/1Jx5QP4GBLHF+Sfg1c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dL4Ex6k4glf6sAlhcdA4GEeiVS84sdAle0ckGSUK8HY/JHyN4vlzrgqGf6uy7nUqvn6ajg3HLjF4C0t2aON6ebVArt4JbINxQ7HSjG/T8TcVoqa6+94Q33WpU6dfHNA75rOPf1r5NHGuslhrkwM+tBKQT3toBf9ZHatwIjIZvjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YGqqd01q; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmUt88/hujpzCWjZ/MkaWd1puiXTPwNQR51Qn6UVdEHZbhmxlKbpyOwTCBMzsb0b2Db/Zrw7XtKQ7Ssybm20uSYqkOEFm0YMxhdcOWDD3m9gqpPHBxGKM7z0uI4qO7PjWReYa98N8s8mhVsK/DGj9GumGpbYtXVbYWeixm4ROMiSkOlxHOE2h+c/Ou1lTpeBKuEfpuFxH9tK02oE5Bm7WTATub0jBI1fygZOWLp3Jy+Tven0D8uKfNKzwm6ZDt+nfoIreM5gvrgujyYdX6xF/caNs271mw2gRCkfpBbyL8TX+HA5YZLmyB2tfYUAV6f5MAJTkbLT95ASpYkfG21lPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwuEJzLglAnCfVcnv6YDD008lkhon+FSazqD3Wcss18=;
 b=BXqVu6ZPN+K3iTsDCn7gf6DZ4VUeE5abwgK1CnwbPHBxs2VDGlViJfLRuXo8VwU+d+wvJLCbVmn8MyuYdt/Vxk8AlxoEzwWZkKK1lUSPbgU06wQX5g2uXj0106z14hfamErvfAAQ0HHFK7I9GfVSw1arvKc31X3jzN5dfBWd79mf8HjTEU0Z+2NdK+eg7/G7SpAXBYhaYiSUDgRgj1lux3gAj8Ja8t1IqRl6dOfy1wbrSDE4qu/8qFB5rMcRC6pOq4+8hwQ6uXcXRZJmSyXWZgnsa8FbYdXcCuCIYAuXBWwvdnwwpfplkzHVSA6TqtL0PecaH05yZ6VHeXPMV8zCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwuEJzLglAnCfVcnv6YDD008lkhon+FSazqD3Wcss18=;
 b=YGqqd01qbp0ud52hKv+rgi4mBMbJW2ezKPrUedS2Icx+JNz5PSYmdw+/aA/HKHyLhDRV5f9XK/gi6moVa6l/NcZaDWDJjCEZoq4SCdoqd8o7a7iR90t9vR55NNUMbq1++Xu/uwFwsuzx1ZgE2GL8pWyerYmteDnbNSEfCkMDi3d++3FLY7wvHNVR2tJnpqRt3hp3f5QBZpyrEja+uJCX6NOwK4UBjaR7WCGfdDgcRp/Oh5FUwKNzfkP1qnopnMOeVoUAdx7UIRES4EFxkW1Zlnyh6eRVU94xXJoV4skT1KgoLGBGdOaf6Mri2p1bo+eG3XyPT5wH2n89iziZp7ugyQ==
Received: from BN9PR03CA0903.namprd03.prod.outlook.com (2603:10b6:408:107::8)
 by MW6PR12MB8914.namprd12.prod.outlook.com (2603:10b6:303:244::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Tue, 10 Jun
 2025 15:10:43 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::65) by BN9PR03CA0903.outlook.office365.com
 (2603:10b6:408:107::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Tue,
 10 Jun 2025 15:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:10:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:10:18 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:10:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:10:14 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v4 00/11] net/mlx5e: Add support for devmem and io_uring TCP zero-copy
Date: Tue, 10 Jun 2025 18:09:39 +0300
Message-ID: <20250610150950.1094376-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|MW6PR12MB8914:EE_
X-MS-Office365-Filtering-Correlation-Id: d15cc503-8517-4d50-7307-08dda830f7be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rCChvPF/Sizk7eV4bdVxqpzrWJfDsd8aBzNCIFd5bsOfbm4rsVMxkoCOIQ4Y?=
 =?us-ascii?Q?s6H7srjtiiG58FTzfu4TLiqk5O8SO/Y9tEHNJlCv/8D8b7j7e+AZ0gIoLehu?=
 =?us-ascii?Q?+PZHZHQ8zrQgxPSUapR/gqYCrgqzONqcTwk8yTjNoyTHkU1f2deqaggjDPSH?=
 =?us-ascii?Q?B9KIoXTTTj6ux0FtzZAZbB/WN6j55kSbNuvq6tUDIEXuJR8ED+Sp4Z2p6oKZ?=
 =?us-ascii?Q?qt5Qeudjct9aPKkI6nzUBd+XzcjZH65qT+sFQKeU6JmLIczIv47jEAx5rW3T?=
 =?us-ascii?Q?jXJXOMiY3Yx5Ngyl7PGj4TOgkj3wxStNXMbzHeERdjQE3kDKSBAeUHxjQ7Fk?=
 =?us-ascii?Q?6W35fAUvB9HgilqZ5G1WJWPvGydoarhx+TT91AnTqDPHJfBGh52+3zpNivJB?=
 =?us-ascii?Q?t3lfhz2ab5e0xGM/CXphB6gSQ1l51cOonV7oSJqXFkplkrqXtRSx6ZVvhFz5?=
 =?us-ascii?Q?weVeR41JQAjDXUewl1qB2vL4EFXRGDutsKBz7ZUJSabZRk10yC1Gn8CCCYSv?=
 =?us-ascii?Q?M+VdVUfUKdbPpebBv4kqsN4TeEdON8/rU6ab0qRCP0Tt/zr+hPRA3dhcxzyi?=
 =?us-ascii?Q?aOtGU/CBUbnWL+zSHjc4lXD3WD0KYAmDuFRs+hPHd86MxBYOJroITeHddpir?=
 =?us-ascii?Q?kQnYEcEXGPbpIap/JY0xjZOPv8jxD9hMT0q3nh6oH40lJ9tv1FdC19/WuyvZ?=
 =?us-ascii?Q?LCmV3+dV3MOswkzVgGMgR2YYi0HlzJ7mls0DLQvsc82/i/ijcYcZ0elDoGZC?=
 =?us-ascii?Q?q+6nSTIvmRVYlxdajJ8HT+NOve5tHVKeNRLrcJAfk5+r86JOcMmO+kJYUesP?=
 =?us-ascii?Q?4k6CA/4Sp6sVwZBjNKvyRHh/1IxF5u8apNbMA0xebmXCc4Z5VqoD6X/TnUMK?=
 =?us-ascii?Q?Yajfs7c0Gz/S77AANcGV55YVE5CFZJXqTqZ6w1+Qfij/HYgc5zGZaRlgad3r?=
 =?us-ascii?Q?du9QXSfglE8iFlUGy+c6r9b0eulQdIX3yprzlxf18Q+dTdj0ksFflBgQdxDs?=
 =?us-ascii?Q?IHgFgtGQe4w4SCEalUWBQMaKOry3RsvswwdIB2vc8Ft0Fmy/2tAiqbA8mfy5?=
 =?us-ascii?Q?5qpcUa+ycBN1QZ5S3dgbOWANe8SXM5nBb+QlWwO9dgNySh7J+zOoOqd0JROS?=
 =?us-ascii?Q?2liiIgb+RZ+UDpvYNWR/m0nhkh95ZTZ5xkeccOY2MA5Om26Ja0gTPNDzlusm?=
 =?us-ascii?Q?icPn54t+HknkFX37RZv9DnRb9E5VhFS02hDTnaTdlfQw/hmKPMIJbRsn/dEh?=
 =?us-ascii?Q?Ousp+tex1jNIlPNhXYeNZ8cdvkE4tT2EHG1voxLkvrlTP4MXIrBeZyqjyvSa?=
 =?us-ascii?Q?5hBsSqZ8eqvrB/DCIdzfe7s13EbnVBcN0rxP+B55q8vgcRdZMn7ow3VZbZ1o?=
 =?us-ascii?Q?KQxAO/rGEEnjb8jyjkeQq0pZHyJSvTf5HUn9jnyadF2MRGQEJYYP09XmapiH?=
 =?us-ascii?Q?f0Y4vGtcqCEKuP0JjhPoyPkvINNCCwC/dyNo5ODdE+RBkzQw1TukbWYS3Hd4?=
 =?us-ascii?Q?z0aHSD13k3vJ+X0vKWR52WAUPnyoRxX6bQga/t9CgvgVEuw+u2Zr83Bcug?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:10:42.2817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d15cc503-8517-4d50-7307-08dda830f7be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8914

This series adds support for zerocopy rx TCP with devmem and io_uring
for ConnectX7 NICs and above. For performance reasons and simplicity
HW-GRO will also be turned on when header-data split mode is on.

Performance
===========

Test setup:

* CPU: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz (single NUMA)
* NIC: ConnectX7
* Benchmarking tool: kperf [0]
* Single TCP flow
* Test duration: 60s

With application thread and interrupts pinned to the *same* core:

|------+-----------+----------|
| MTU  | epoll     | io_uring |
|------+-----------+----------|
| 1500 | 61.6 Gbps | 114 Gbps |
| 4096 | 69.3 Gbps | 151 Gbps |
| 9000 | 67.8 Gbps | 187 Gbps |
|------+-----------+----------|

The CPU usage for io_uring is 95%.

Reproduction steps for io_uring:

server --no-daemon -a 2001:db8::1 --no-memcmp --iou --iou_sendzc \
	--iou_zcrx --iou_dev_name eth2 --iou_zcrx_queue_id 2

server --no-daemon -a 2001:db8::2 --no-memcmp --iou --iou_sendzc

client --src 2001:db8::2 --dst 2001:db8::1 \
	--msg-zerocopy -t 60 --cpu-min=2 --cpu-max=2

Patch overview:
================

First, a netmem API for skb_can_coalesce is added to the core to be able
to do skb fragment coalescing on netmems.

The next patches introduce some cleanups in the internal SHAMPO code and
improvements to hw gro capability checks in FW.

A separate page_pool is introduced for headers, to be used only when
the rxq has a memory provider.

Then the driver is converted to use the netmem API and to allow support
for unreadable netmem page pool.

The queue management ops are implemented.

Finally, the tcp-data-split ring parameter is exposed.

Changelog
=========

Changes from v3 [3]:
- Dropped ethtool stats for hd_page_pool.

Changes from v2 [2]:
- Added support for netmem TX.
- Changed skb_can_coalesce_netmem() based on Mina's suggestion.
- Reworked tcp_data_split setting to no longer change HW-GRO in
  wanted_features.
- Switched to a single page pool when rxq has no memory providers.

Changes from v1 [1]:
- Added support for skb_can_coalesce_netmem().
- Avoid netmem_to_page() casts in the driver.
- Fixed code to abide 80 char limit with some exceptions to avoid
  code churn.

References
==========
[0] kperf: git://git.kernel.dk/kperf.git
[1] v1: https://lore.kernel.org/all/20250116215530.158886-1-saeed@kernel.org/
[2] v2: https://lore.kernel.org/all/1747950086-1246773-1-git-send-email-tariqt@nvidia.com/
[3] v3: https://lore.kernel.org/netdev/20250609145833.990793-1-mbloch@nvidia.com/

Dragos Tatulea (3):
  net: Allow const args for of page_to_netmem()
  net: Add skb_can_coalesce for netmem
  net/mlx5e: Add TX support for netmems

Saeed Mahameed (8):
  net/mlx5e: SHAMPO: Reorganize mlx5_rq_shampo_alloc
  net/mlx5e: SHAMPO: Remove redundant params
  net/mlx5e: SHAMPO: Improve hw gro capability checking
  net/mlx5e: SHAMPO: Separate pool for headers
  net/mlx5e: Convert over to netmem
  net/mlx5e: Add support for UNREADABLE netmem page pools
  net/mlx5e: Implement queue mgmt ops and single channel swap
  net/mlx5e: Support ethtool tcp-data-split settings

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  11 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |  36 ++-
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   3 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  33 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 305 +++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 136 ++++----
 include/linux/skbuff.h                        |  12 +-
 include/net/netmem.h                          |   2 +-
 8 files changed, 371 insertions(+), 167 deletions(-)


base-commit: 2c7e4a2663a1ab5a740c59c31991579b6b865a26
-- 
2.34.1


