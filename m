Return-Path: <linux-rdma+bounces-12280-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891A9B092C1
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 19:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A285A3FAA
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 17:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB9F302CAB;
	Thu, 17 Jul 2025 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YPqmH2pp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F30F302075;
	Thu, 17 Jul 2025 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771897; cv=fail; b=o3EwLhp9nGxy7ZdCeJUCSsfZn+ctL5Bk6UAbiRZxQJDYUcTCcdKinSkJNopnZe6H40aMpf+1x9/ehX1esz9tdRH0lSrVxuXW9kKZ1LXjDthcdTXuU9wi5U7R6XmBdZFxcyGMZ9Q6AeXVlrbvfHDXxJDczhpcznrqoqwH/haW/R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771897; c=relaxed/simple;
	bh=HPycOSSh1ITMDQ1ssP+Hko3Z7tVtMtW6MPVgQzVbr1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDQnoG6pd0/fiPJJVnrWzteIY44XkkWMBrBoAeWgbRJCFD51Wv4fQwSJQ70vGgtysJkGX7bp7ZIa+1cfTJkn++FzJ7DMFpuuZG9PvbmnWqJR47SEEwAWmj1s/SYdPteb/5Yz8Fsx31/rE6iwNpVPfglFeP0ViS9iQAUuVFCfr4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YPqmH2pp; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7wIsE1fECJCvTKupEYVNFMSuGov/o7pZYmQCWJ5BLhrX0pDzxelxexh/e7vlBANcOrbqzCsuYhFkVPB0V1kGNFC6eZ5IhGyoHdMboLUZFDE8tFD/VaX8iJMiSn61L1eU60WhMKD8uNQs1BoRKH7AdtX9QX7JQZNUiuQPpQ+VO6z8QS13XJChQUN0CCWPHPgeUycK9WhpZs/1i3mOL+xyHvsjWbvn3JnwE6WEZp6jtadscqU275jp6j7GPCowScVb4ZhNzur3VEuyWRi/uJKDwyMuG2SLAE6XCfVwPf5jULMLtcH372J4QQXhz6Tl9e13PB/FUQ4SvALVo3RiiiFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWQ7HlKGH13+ztzPgCYp3ySw5gZkcgsqc7vHdbm4vGA=;
 b=DnDX+CdExUP0y6of1fZew1LZWBT8RZIDsszKy0qd1GN+/H72fp6bj0nZNB7bofNKtww4d8T6daRieNC8JMzbDmyTdz8wwl1IFXX9kTdLi/+73pTm8bb+Yhl02arbcanm3c2zrKbzmJZAHbsiLlCSI0gp0CLlmhTg7cwtRhJcAneP8Xn3BDBQt4sBsWvawFai2FRZiCqR2FUhCQgp1MT+uAsvl6ZsdQlrQ8qXlrj61Bumw1isXnxaOgq6lvFwCewxZ1sl5vkXO7BBQ8jYXb8TmrERqi0x8XqLKdqodL98B6/V0k/qVRtG3+ta40xH4WPLCcZEtcrasbkuxxWAne+hCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWQ7HlKGH13+ztzPgCYp3ySw5gZkcgsqc7vHdbm4vGA=;
 b=YPqmH2ppZaBxJeUfTwJSql9R7hZzRpQxrCPTV7KN6RHMZUH7q7GOvXlXSKUUWjBXgCM/c50DTYppZvmYiTtGZQ5iWsHHoHqBhyuQxuUCScTma4Zqjmh5MwslZnocQYJzJ06ofGppNF4dqVtQnA4G273slqyDjGmetocTkc05hBpOymy37AHvc/L08KDaZZACqzLTggcYUYglJmtv7vQa2mBTHRjezIPn7Mpj6CJBBCJrBIOaU6w02UtWFB9v9dAEKy3QRUO/48ZRrQFFn2NDbkomDsoey4l1AYyfJzkW+gDRi30dLTB1mVNlubjSw6XDO3xVqnMxF+vFKWWCjNA/DA==
Received: from BN0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:408:ee::15)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Thu, 17 Jul
 2025 17:04:51 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:ee:cafe::5c) by BN0PR04CA0010.outlook.office365.com
 (2603:10b6:408:ee::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Thu,
 17 Jul 2025 17:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 17:04:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Jul
 2025 10:04:32 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Jul
 2025 10:04:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 17
 Jul 2025 10:04:28 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next 2/3] net/mlx5: Allocate cpu_mask on heap to fix frame size warning for large NR_CPUS
Date: Thu, 17 Jul 2025 20:03:11 +0300
Message-ID: <1752771792-265762-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752771792-265762-1-git-send-email-tariqt@nvidia.com>
References: <1752771792-265762-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SA3PR12MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b0a036-9914-4b32-b722-08ddc5540b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3h3cUcwRnJOYXhsY3BvdVhaVVVBRWEzMTBrdW8yNnAvOTZkcE11SStnZC80?=
 =?utf-8?B?QnFxTHdVYlgyclA3MjhCN09Pa2N3R0JOYVovbU5uRGYyVkllRzM4djE3N3hl?=
 =?utf-8?B?Q1lIRHF5Ylk2QkRnOTJyUFNPb3Z2bzk3M1M1eXZscXFINGhIa1NRM0ZBU0Mx?=
 =?utf-8?B?bWNRM3NzeUJQM0JZeUcrOE00OGVSTzRoc1VIYjlDalUyUzVvOWhKdXRhb0tV?=
 =?utf-8?B?VXdNUms3aGVEMDk3WU53dVBhUGFNQTdoRHFhZmNPUjIyQVJpTjlEc1FTTldl?=
 =?utf-8?B?TWlkSHpacjdUcGQ2NFlzWXAzdEZLd3c5RWplSGVFS1gvZXVQS1FmQnFtMjlQ?=
 =?utf-8?B?aFBQc2Y1NUlLZklzUHhYekNxa3ZIT2REQnRwVkdsMTFQckt2NUxMSVduN1Bh?=
 =?utf-8?B?U1FjOUJ3MU91b0F3UWZPdWxwTUJZQ1Y5WjlLTmFFWUZ6S1hQdHNFUExlZVhY?=
 =?utf-8?B?QTZoYVN5VFkzSHRPeWJBa3ZZM0JRMU9vWXl3Tk5qdG5nQXMxeDVKQ3NKbXNn?=
 =?utf-8?B?ZisxdEZLQkFqaGtoTGZSZGx1RnFaYWRWL0tHN0VpcWhKb21EZlh0aWFYcm5K?=
 =?utf-8?B?NDRUVFpETjVvNURSWE11MVQ0OWdwNXAwbkhRb1ZGWlBRbHlpcVBTZVg2NXBr?=
 =?utf-8?B?WHhVdWgxb01nZXVRMExtVmp5c2drT3k3ZEhVRzdCOW9lWWloRXRjV3FhVDF5?=
 =?utf-8?B?Sy9TTHY5cUhxZ3E4T05PWGVnS3VJWGYyNWhuRzRqN25HRFZqQXR0TkVaVnBv?=
 =?utf-8?B?R3ZuNWJlZ0dXYk9VdlNSeUJyaWR5ZlVWMHJtdFdZWnlEOUlGMkYvK3p1Zy9S?=
 =?utf-8?B?eVpRN1VtT1JkdWJmREh0ZC8zeEN5R1A2TlBNY0x4ek4wWmV0TzJsVmpraEMx?=
 =?utf-8?B?MHJFOUp4Ylc2TWN4LzcwZzZ1dnVDak1PMkJSQzd4QzhFM1pGYWlEckk5bE5N?=
 =?utf-8?B?UHFpMXVqMURwQktROE96S2tQaTVKdHNUSmlLajRyWGdZc1VQZE8rNlkrdVdQ?=
 =?utf-8?B?VThqL0VWN0laRjRZczZ5YTgzaXowbTlBUEZkcG1SRDBqV2xjanlhaW0wUEVU?=
 =?utf-8?B?OFVoUUVhSEFBcGFKL01QZG1RZE5tdTE3T3hjRlN2bWI5RXFKakpwckN6QVRu?=
 =?utf-8?B?ZTJNVC9abFVyUFpLaE9OMmVlUTRzYTFySytRN3hxWTE3ZjREcjRRWHJKQ0o3?=
 =?utf-8?B?YmNrUjhyYTk4dEJUbFlOay85MFQra1AzNWttRUtRRFd5LzVhL2hTU2pIYXdX?=
 =?utf-8?B?dFVvMWNuOUhjM2tRRXdhVEhteitBTVVaQW1wZFY3VHFrR2NrdUJxU1hGdjRG?=
 =?utf-8?B?dVNHaFRtSGx5MkJvQ21peWJCL3dtbEV0dTY3VC9WdVlpSk1SeVhNcTdmK0Ft?=
 =?utf-8?B?WGRGZENhdTRhdjR4V3FuYThBdll5djRLbWc5d3dEMk9VaEcrUnB0aUR0T2Fr?=
 =?utf-8?B?MzZzVGdoczZTSGV0VUwyREdyM1lGSXU3cFc5cHhDZS9pWFFmNy9OVldkUFFF?=
 =?utf-8?B?ZHBtN1E2UlpMMnhPK21pK0lKR1ZPL3luelVEY1BIdzZCNDZYWUlCMG9aTDY4?=
 =?utf-8?B?YWdweWZVSldqa0NkMjh3dDlpd1BRWk9FbFpTQ0dlNmo2dXVmNUQzbmJ4bTQr?=
 =?utf-8?B?VTRtd3BsQ0VuS1FxYTVHQnF6VWNkNjF6Y2w2YnI4Y2V5bTRHZGZPWlNiMUlz?=
 =?utf-8?B?NEZleXZnMUhrTk1HSW1kS2pCdmZPZjVNbGpJeXNEZXhsWFJ1R0p5VUpjWkx1?=
 =?utf-8?B?MGx5VTNuZDhWNUZOLzNDWHNXWUxuVEFTVkpIdE8wQkdUZjJHTVNvOURYZDI5?=
 =?utf-8?B?cStiNGR5R0hNZG9DTDIrN3JuZUk4dW91bC9yMXJCWDk3SDk5UnR4eXd1bmcw?=
 =?utf-8?B?TjVId1h1NHU3OTdjV3BITFl2Ym91a1dHMXByN25tSHh1LzZ1T0JjM1dtQjhQ?=
 =?utf-8?B?RWRmTUMrVWZ0QUxaaWRTampRN3N1MEJ0eEJGL3B2ZjNZNUxRbVdqRUJxcUlT?=
 =?utf-8?B?RHp1WFlKZ3hobis1anpzZG9pTk1qMkYvajBDWEVGeGtIZi9qa1lDT0lQcHVU?=
 =?utf-8?B?Ym0vN2ZMT0tEOExIa1NFVEdQK2g1VlA4a1ZJUT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 17:04:50.7206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b0a036-9914-4b32-b722-08ddc5540b00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107

From: Shay Drory <shayd@nvidia.com>

When NR_CPUS is set to 8192 or higher, the current implementation that
allocates struct cpu_mask on the stack leads to a compiler warning
about the frame size[1].

This patch addresses the issue by moving the allocation of struct
cpu_mask to the heap.

[1]
drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c: In function ‘irq_pool_request_irq’:
drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c:70:1: warning:
the frame size of 1048 bytes is larger than 1024 bytes
[-Wframe-larger-than=]
   70 | }
      | ^
drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c: In function ‘mlx5_ctrl_irq_request’:
drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c:478:1: warning: the
frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
  478 | }
      | ^
drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c: In function ‘mlx5_irq_request_vector’:
drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c:597:1: warning: the
frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
  597 | }
      | ^

drivers/net/ethernet/mellanox/mlx5/core/eq.c: In function ‘comp_irq_request_sf’:
drivers/net/ethernet/mellanox/mlx5/core/eq.c:925:1: warning: the frame
size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
  925 | }
      | ^

drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c: In function ‘irq_pool_request_irq’:
drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c:74:1: warning:
the frame size of 1048 bytes is larger than 1024 bytes
[-Wframe-larger-than=]
   74 | }
      | ^

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reported-by: Arnd Bergmann <arnd@kernel.org>
Closes: https://lore.kernel.org/all/20250620111010.3364606-1-arnd@kernel.org
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  | 19 +++++++---
 .../mellanox/mlx5/core/irq_affinity.c         | 21 ++++++++---
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 37 +++++++++++++------
 3 files changed, 53 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 66dce17219a6..779efc186255 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -876,19 +876,25 @@ static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
 {
 	struct mlx5_irq_pool *pool = mlx5_irq_table_get_comp_irq_pool(dev);
 	struct mlx5_eq_table *table = dev->priv.eq_table;
-	struct irq_affinity_desc af_desc = {};
+	struct irq_affinity_desc *af_desc;
 	struct mlx5_irq *irq;
 
 	/* In case SF irq pool does not exist, fallback to the PF irqs*/
 	if (!mlx5_irq_pool_is_sf_pool(pool))
 		return comp_irq_request_pci(dev, vecidx);
 
-	af_desc.is_managed = false;
-	cpumask_copy(&af_desc.mask, cpu_online_mask);
-	cpumask_andnot(&af_desc.mask, &af_desc.mask, &table->used_cpus);
-	irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
-	if (IS_ERR(irq))
+	af_desc = kzalloc(sizeof(*af_desc), GFP_KERNEL);
+	if (!af_desc)
+		return -ENOMEM;
+
+	af_desc->is_managed = false;
+	cpumask_copy(&af_desc->mask, cpu_online_mask);
+	cpumask_andnot(&af_desc->mask, &af_desc->mask, &table->used_cpus);
+	irq = mlx5_irq_affinity_request(dev, pool, af_desc);
+	if (IS_ERR(irq)) {
+		kfree(af_desc);
 		return PTR_ERR(irq);
+	}
 
 	cpumask_or(&table->used_cpus, &table->used_cpus, mlx5_irq_get_affinity_mask(irq));
 	mlx5_core_dbg(pool->dev, "IRQ %u mapped to cpu %*pbl, %u EQs on this irq\n",
@@ -896,6 +902,7 @@ static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
 		      cpumask_pr_args(mlx5_irq_get_affinity_mask(irq)),
 		      mlx5_irq_read_locked(irq) / MLX5_EQ_REFS_PER_IRQ);
 
+	kfree(af_desc);
 	return xa_err(xa_store(&table->comp_irqs, vecidx, irq, GFP_KERNEL));
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
index 2691d88cdee1..d0a845579d33 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
@@ -47,29 +47,38 @@ static int cpu_get_least_loaded(struct mlx5_irq_pool *pool,
 static struct mlx5_irq *
 irq_pool_request_irq(struct mlx5_irq_pool *pool, struct irq_affinity_desc *af_desc)
 {
-	struct irq_affinity_desc auto_desc = {};
+	struct irq_affinity_desc *auto_desc;
 	struct mlx5_irq *irq;
 	u32 irq_index;
 	int err;
 
+	auto_desc = kzalloc(sizeof(*auto_desc), GFP_KERNEL);
+	if (!auto_desc)
+		return ERR_PTR(-ENOMEM);
+
 	err = xa_alloc(&pool->irqs, &irq_index, NULL, pool->xa_num_irqs, GFP_KERNEL);
-	if (err)
-		return ERR_PTR(err);
+	if (err) {
+		irq = ERR_PTR(err);
+		goto out;
+	}
 	if (pool->irqs_per_cpu) {
 		if (cpumask_weight(&af_desc->mask) > 1)
 			/* if req_mask contain more then one CPU, set the least loadad CPU
 			 * of req_mask
 			 */
 			cpumask_set_cpu(cpu_get_least_loaded(pool, &af_desc->mask),
-					&auto_desc.mask);
+					&auto_desc->mask);
 		else
 			cpu_get(pool, cpumask_first(&af_desc->mask));
 	}
 	irq = mlx5_irq_alloc(pool, irq_index,
-			     cpumask_empty(&auto_desc.mask) ? af_desc : &auto_desc,
-			     NULL);
+			     cpumask_empty(&auto_desc->mask) ?
+			     af_desc : auto_desc, NULL);
 	if (IS_ERR(irq))
 		xa_erase(&pool->irqs, irq_index);
+
+out:
+	kfree(auto_desc);
 	return irq;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 40024cfa3099..ac00aa29e61a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -470,26 +470,32 @@ void mlx5_ctrl_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *ctrl_irq)
 struct mlx5_irq *mlx5_ctrl_irq_request(struct mlx5_core_dev *dev)
 {
 	struct mlx5_irq_pool *pool = ctrl_irq_pool_get(dev);
-	struct irq_affinity_desc af_desc;
+	struct irq_affinity_desc *af_desc;
 	struct mlx5_irq *irq;
 
-	cpumask_copy(&af_desc.mask, cpu_online_mask);
-	af_desc.is_managed = false;
+	af_desc = kzalloc(sizeof(*af_desc), GFP_KERNEL);
+	if (!af_desc)
+		return ERR_PTR(-ENOMEM);
+
+	cpumask_copy(&af_desc->mask, cpu_online_mask);
+	af_desc->is_managed = false;
 	if (!mlx5_irq_pool_is_sf_pool(pool)) {
 		/* In case we are allocating a control IRQ from a pci device's pool.
 		 * This can happen also for a SF if the SFs pool is empty.
 		 */
 		if (!pool->xa_num_irqs.max) {
-			cpumask_clear(&af_desc.mask);
+			cpumask_clear(&af_desc->mask);
 			/* In case we only have a single IRQ for PF/VF */
-			cpumask_set_cpu(cpumask_first(cpu_online_mask), &af_desc.mask);
+			cpumask_set_cpu(cpumask_first(cpu_online_mask),
+					&af_desc->mask);
 		}
 		/* Allocate the IRQ in index 0. The vector was already allocated */
-		irq = irq_pool_request_vector(pool, 0, &af_desc, NULL);
+		irq = irq_pool_request_vector(pool, 0, af_desc, NULL);
 	} else {
-		irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
+		irq = mlx5_irq_affinity_request(dev, pool, af_desc);
 	}
 
+	kfree(af_desc);
 	return irq;
 }
 
@@ -548,16 +554,23 @@ struct mlx5_irq *mlx5_irq_request_vector(struct mlx5_core_dev *dev, u16 cpu,
 {
 	struct mlx5_irq_table *table = mlx5_irq_table_get(dev);
 	struct mlx5_irq_pool *pool = table->pcif_pool;
-	struct irq_affinity_desc af_desc;
 	int offset = MLX5_IRQ_VEC_COMP_BASE;
+	struct irq_affinity_desc *af_desc;
+	struct mlx5_irq *irq;
+
+	af_desc = kzalloc(sizeof(*af_desc), GFP_KERNEL);
+	if (!af_desc)
+		return ERR_PTR(-ENOMEM);
 
 	if (!pool->xa_num_irqs.max)
 		offset = 0;
 
-	af_desc.is_managed = false;
-	cpumask_clear(&af_desc.mask);
-	cpumask_set_cpu(cpu, &af_desc.mask);
-	return mlx5_irq_request(dev, vecidx + offset, &af_desc, rmap);
+	af_desc->is_managed = false;
+	cpumask_clear(&af_desc->mask);
+	cpumask_set_cpu(cpu, &af_desc->mask);
+	irq = mlx5_irq_request(dev, vecidx + offset, af_desc, rmap);
+	kfree(af_desc);
+	return irq;
 }
 
 static struct mlx5_irq_pool *
-- 
2.31.1


