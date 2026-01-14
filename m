Return-Path: <linux-rdma+bounces-15542-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C8CD1CF2E
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 08:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC30530BE460
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 07:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C11037B3F0;
	Wed, 14 Jan 2026 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A5v3M82t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011014.outbound.protection.outlook.com [40.93.194.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C43037998F;
	Wed, 14 Jan 2026 07:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376932; cv=fail; b=boo/Cpy550ol9wPEQ/K6Y9b9vrddtoJRaan4HKsANW2TZtPl79C2OFXKMubBEEeH9kmEAT7y7bvMRuyiOYktjViF3AKgyAQLffGqUYTHiHlGLLxoUAhthEiCnv2HNze8oLEjjQnzG+ESzoIarVnMFOfVuhG+Jq++96DpwWe/e5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376932; c=relaxed/simple;
	bh=5mbRNASIi4ub51zOtarxOncS33iZbevI3grCNmxuw1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iaxos2o6lVLbKx8fnIU/x4V2nIwhHCuFX29xU7nLUoj8CupxlyN7jcmYswBRL46YszXWlaC4j1xs+MYApkjkMq4LiZGW0aerv7Q+vIeIgWrXwlBbVRiNxrmoJKmmE0u22Ko5x2wqQfigTTNyONaxUnL7vSxk2s7xCJhv6xr/uRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A5v3M82t; arc=fail smtp.client-ip=40.93.194.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/FdmRmcEqs3v9WYrGHkQmCxycY77e6diTfItKf4o4mqVYklCbGyD440L50dRJ5kXXc6ehwWGhg+QdvdQFQQq9lnOWdBTTr4tVrPR3QeVsnTUf3A1HF9q+kY4iy/8zM+Rrip5AT0EYESb7gwoMXi+NBC2tZ/bX7AQD9ppZC/ulyzNUFiv15Yt3M/FDk/PxQ0srzk4EC18B1zEM2SRXpR3nVVZfdVDAN0r80zvgOKZeZZYld+HZyYi6Ot9UvKESrRdV//xCPWBo8GyRbkqHutHThV/5WzpNXGvjjEbMuMuLPBh77bfrs9JVNc+gj9IhOxlDSC7qXILGHI8rVZ00IxUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MxxlEr5wdoKFiyK8S+QkihcYiAvhdwzEaeFjLGvLtk=;
 b=LIBcuAK6EBBPXFet9zRf1CpCf8Cqo9xL49qxN8h0RXy5rmj5Z8WXo59CV2hb6pu64xsRrJ3h1YdxVKc78VtsXBTMyPd0ndk9uQyTH1w+Q86E2pbzh3+00mMNV+XOe1cjqkucJ6rzXynND78WHscwVq0pZgOHlqWOYjoYJfcRf6mXM3e3hdXBA7g7QeEeYl3pXhCu2M2QJFdCNqvnRMSsJEz6jAZHbH24Ft4vjEyzcdbqYd9M5WNHWAqGs5zmosKbyjdmBxylFgRqjYPjpk3hMpxemEjXEYqeftVW9Zc0iSlMQEuQSOtKajpbAHf21qDFuecV3swMVsgGjmd6K/snuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MxxlEr5wdoKFiyK8S+QkihcYiAvhdwzEaeFjLGvLtk=;
 b=A5v3M82tohHBlXupaztWXXhSm4kxhU7WTP2G3QwsvUqLq5P+tMddheYhB6dCG7zV7G2HSU56Dx66z/FXT9eX9nrwypqTxkE+dUIWcbF7yPa8WWFI6TXkatYPV0rAXUEbhxlAFXIYL8LJG3NOv+M5dcBGc7Riv3rbh1LND/vIh/e8mdBbLNIwHvVUqnzJyng8uUtJ6HL6z03F+Bmi8utQnFGlyYJO2HHRiTcQRWTrQLdiZVH9jt5evrOh8PJY1kajWsXMtGf/JfZBK6X35CMBv0gMekDxoOrNa2tkE35kwbGWszsDmqaZLugb2cPVDc3P291QTAP0BS7ShUZBuY5y0Q==
Received: from PH0PR07CA0114.namprd07.prod.outlook.com (2603:10b6:510:4::29)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 07:48:42 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::49) by PH0PR07CA0114.outlook.office365.com
 (2603:10b6:510:4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Wed,
 14 Jan 2026 07:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 07:48:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 23:48:28 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 13 Jan 2026 23:48:27 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 23:48:24 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, William Tu
	<witu@nvidia.com>, <toke@redhat.com>
Subject: [PATCH net-next V2 2/4] net/mlx5e: Use regular ICOSQ for triggering NAPI
Date: Wed, 14 Jan 2026 09:46:38 +0200
Message-ID: <1768376800-1607672-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768376800-1607672-1-git-send-email-tariqt@nvidia.com>
References: <1768376800-1607672-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b783f4-18df-41d6-c5ef-08de53415656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGFLbklsZHlEcGtOZ0lxd0V5UHRabVZKbjZ6ZzN4SzRnVkt5eUcxclUwaVIw?=
 =?utf-8?B?V3NTWXFMUjZORnBXWC8rOCtUcG5pZS9SUEtaeDdydGVCak8yUWNKZWpGTDlO?=
 =?utf-8?B?QTMxYTZ0cTN0TERiT21nQmdoWGFqOEdpWVo2NzA2NHBQbXRtaFV0VTluMDJz?=
 =?utf-8?B?YldSeS9VZ1RsNzdKclNjU1UwSWUwZTdhQTNjK1dOMUtZcFNZZllTVS8yMnZS?=
 =?utf-8?B?ZmJqRjJ3enJZOXZFSWtYcnBidVpkcFVuUWg5S1lZWFdSUnRXZ1JiU3RrUDBk?=
 =?utf-8?B?a3RpdW1yVVpuc0Z4aUUzUjFCc3drUUdPZmd0b2d3ZnJ5L2xldzUvZkloOUFP?=
 =?utf-8?B?OGtRMG5mZmJWZ3BrbHVxQVBHVW9PSWNaczlpTWZULzdZazUwZ245Q3ZuS3BF?=
 =?utf-8?B?S2FTUDUrUE1BWWwxVmwzWElSRG5hOWNJakc2TUxjeGcxWDZTTThmU0RtYkJU?=
 =?utf-8?B?Ni9lYTl6Um9VN1l0MFgraVE2TEZ2YXZlZzFTVE9md3RoeW4wMmxVUUtheDBY?=
 =?utf-8?B?QnFvdWRCdFRaSjNoMmpTUisvdTMvUjdNZlJtTFVxdVMyYldXcnhlTnlZMnhU?=
 =?utf-8?B?ZkFaQnFHSlRkeDJVQktSaWZWSHNNNU9mWDcrTkwwNUFRelAvdEthYUloOUFl?=
 =?utf-8?B?UDFRZUlTRTUwaEEzZnRiU2FWZmNBdGtvSHJHMnBBV0RKQk43R0N3SUk2ZWR1?=
 =?utf-8?B?a0pJenJNM2ZMejBVQVF2amh2TjBSYUU5UWp6dmRVdEVBQ0hxRzJCdzAxVEZW?=
 =?utf-8?B?QWY3dWVkN0NlUHV3NTI0NEpSTlJ0WTBGMVc3aXczVGc1NlFLY25oK0xtaUJG?=
 =?utf-8?B?UFppbnZPVENaL0FRSTdjQ1R3UjdTYjlyYTl3cU9qNFFEU1FwU3FNSkhHb0Zh?=
 =?utf-8?B?VXZTb3NwbktmaElUOGlKUWNjeWNpTW5WOE1mSnl1Nng0aGkySERjSVlvRVQ3?=
 =?utf-8?B?VkQyMURyNi96bUdjbEp6eFA2bFg4a2VROXBkRkN5cjlJSEJ0SnhtUHB2dm50?=
 =?utf-8?B?ZklvYXNGS2NTLyt3RHByNjdrQjJqSTZqVk4vRVd5OWpRajJ6Z0hCb3UyNDAv?=
 =?utf-8?B?dU5CMHFram5HNXQ5NURLejRUdDdaajN4WkovTmI3WUl5dTlyZkRRYkQ0azZz?=
 =?utf-8?B?OU00RjRFSkVUOFFBL3Z1Z2JzeXVrZTdxSjRKYms3d2hiZHRvVy9Ta0dURFEw?=
 =?utf-8?B?a2JQTlhsNTRJQ1UzM0tCK0k5dVJjOGVtT0N1amxRY0I2cEVWUzJDMUJ1TitY?=
 =?utf-8?B?dU9xeWpkR3VZMkJIS05venJYUEtEd3pCamFFVHMvVjNtNnFDZk5WcFVQeDA3?=
 =?utf-8?B?a1QvMkp1bTFrdGhNR0ZneU4yRWUzT2RnV25CK2g0c3ZtUDQ5N094K1NqZ3p4?=
 =?utf-8?B?UUlQOXM2TFhZZlVScGlRMDdmR1BPK3JBUXdQMzdkeHdrN0YremhxZTFwR21j?=
 =?utf-8?B?ZUE0a2g3YjZJbUFWenBoUUp0QUR0YlY4REFhSlJpcU8rbVJXbisrR1hHS2p1?=
 =?utf-8?B?YUh1ZkpraU5hVlhXaFMwRzUzelJ5SlN6U2t3bmVBMWg3UXB4TExNZE5BRE8z?=
 =?utf-8?B?eWdBMW5ySVJUU2IvZlRiRkluWWNWSWpxZklQNXJMUThIZTVXUUV5T04yOWUw?=
 =?utf-8?B?d2FXOXY3dzlRR2Y5RXgwZTFLNFdldnoyYzJIQ2l2U2o5Ly9vbnQxTVRVMnRJ?=
 =?utf-8?B?b3lQOWNrb3BDWnh0TmJzc05CWWJjZnNjR0JzMVRSa0Z5QnhFRGRCNkhkSVB2?=
 =?utf-8?B?NnRhRDJIWWQwS01uOUZLNjBvQkJNeTJ6aHlUczZnbU1ETnBySG9DbityRCt5?=
 =?utf-8?B?Sm42YVhZYVZDS0QvN3ZJQW9LNkYrYTc2R0NDRFdYZFQzRjlrUXhaZUJuOE9t?=
 =?utf-8?B?c1lIampDMjI0NmU4MmRwZ1l4SkxzM2tZVFdLdHF5cVVjQUlPT3R5YTRnRUw3?=
 =?utf-8?B?aDdzODZqL3BZMjBJS3RSZlBMZ1BMQWgwUDdXS1JqZEtCOHEvbk9FYWR1aUlD?=
 =?utf-8?B?TjRDaWY5VnNUd1ZISFo3QUI0eVVVaHRWWkRnZEVtS1RvWXVyYXBWVEVTUzlr?=
 =?utf-8?B?SloyemZYSGhGUnpFUHNESUJvT01Zb200ZDVsNWpzZEZBNG5rSWYrZGJ3V3FK?=
 =?utf-8?Q?HCIg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 07:48:41.8449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b783f4-18df-41d6-c5ef-08de53415656
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930

From: William Tu <witu@nvidia.com>

Before the cited commit, ICOSQ is used to post NOP WQE to trigger
hardware interrupt and start NAPI, but this mechanism suffers from
a race condition: mlx5e_alloc_rx_mpwqe may post UMR WQEs to ICOSQ
_before_ NOP WQE is posted. The cited commit fixes the issue by
replacing ICOSQ with async ICOSQ, as a new way to post the NOP WQE
to trigger the hardware interrupt and NAPI.

The patch changes it back by replacing async ICOSQ with regular
ICOSQ, for the purpose of saving memory in later patches, and solves
the issue by adding a new SQ state, MLX5E_SQ_STATE_LOCK_NEEDED
for syncing the start of NAPI.

What it does:
- Switch trigger path from async ICOSQ to regular ICOSQ to reduce
  need for async SQ.
- Introduce MLX5E_SQ_STATE_LOCK_NEEDED and mlx5e_icosq_sync_lock(),
  unlock() to prevent the race where UMR WQEs could be posted before
  the NOP WQE used to trigger NAPI.
- Use synchronize_net() once per trigger cycle to quiesce in-flight
  softirqs before serializing the NOP WQE and any UMR postings via
  the ICOSQ lock.
- Wrap ICOSQ UMR posting in en_rx.c and xsk/rx.c with the new
  conditional lock.

The conditional locking approach is critical for performance: always
locking would impose unnecessary overhead. Synchronization is not needed
between regular NAPI cycles once the channel is activated and running.
The lock is only required to protect against the race during channel
activation—specifically, when the very first NOP WQE is posted to trigger
NAPI. After that initial trigger, normal NAPI polling handles subsequent
work without contention. The MLX5E_SQ_STATE_LOCK_NEEDED flag ensures we
pay the synchronization cost only when necessary.

Signed-off-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 21 ++++++++++++++++++-
 .../mellanox/mlx5/core/en/reporter_tx.c       |  1 +
 .../ethernet/mellanox/mlx5/core/en/xsk/rx.c   |  3 +++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 13 ++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 ++++
 5 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index ebd3b90e17fd..83cfa3983855 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -388,6 +388,7 @@ enum {
 	MLX5E_SQ_STATE_DIM,
 	MLX5E_SQ_STATE_PENDING_XSK_TX,
 	MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC,
+	MLX5E_SQ_STATE_LOCK_NEEDED,
 	MLX5E_NUM_SQ_STATES, /* Must be kept last */
 };
 
@@ -545,7 +546,10 @@ struct mlx5e_icosq {
 	u32                        sqn;
 	u16                        reserved_room;
 	unsigned long              state;
-	/* icosq can be accessed from any CPU - the spinlock protects it. */
+	/* icosq can be accessed from any CPU and from different contexts
+	 * (NAPI softirq or process/workqueue). Always use spin_lock_bh for
+	 * simplicity and correctness across all contexts.
+	 */
 	spinlock_t                 lock;
 	struct mlx5e_ktls_resync_resp *ktls_resync;
 
@@ -801,6 +805,21 @@ struct mlx5e_channel {
 	struct dim_cq_moder        tx_cq_moder;
 };
 
+static inline bool mlx5e_icosq_sync_lock(struct mlx5e_icosq *sq)
+{
+	if (likely(!test_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &sq->state)))
+		return false;
+
+	spin_lock_bh(&sq->lock);
+	return true;
+}
+
+static inline void mlx5e_icosq_sync_unlock(struct mlx5e_icosq *sq, bool locked)
+{
+	if (unlikely(locked))
+		spin_unlock_bh(&sq->lock);
+}
+
 struct mlx5e_ptp;
 
 struct mlx5e_channels {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 9e2cf191ed30..4adc1adf9897 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -15,6 +15,7 @@ static const char * const sq_sw_state_type_name[] = {
 	[MLX5E_SQ_STATE_DIM] = "dim",
 	[MLX5E_SQ_STATE_PENDING_XSK_TX] = "pending_xsk_tx",
 	[MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC] = "pending_tls_rx_resync",
+	[MLX5E_SQ_STATE_LOCK_NEEDED] = "lock_needed",
 };
 
 static int mlx5e_wait_for_sq_flush(struct mlx5e_txqsq *sq)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
index 2b05536d564a..4f984f6a2cb9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
@@ -23,6 +23,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	struct mlx5_wq_cyc *wq = &icosq->wq;
 	struct mlx5e_umr_wqe *umr_wqe;
 	struct xdp_buff **xsk_buffs;
+	bool sync_locked;
 	int batch, i;
 	u32 offset; /* 17-bit value with MTT. */
 	u16 pi;
@@ -47,6 +48,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 			goto err_reuse_batch;
 	}
 
+	sync_locked = mlx5e_icosq_sync_lock(icosq);
 	pi = mlx5e_icosq_get_next_pi(icosq, rq->mpwqe.umr_wqebbs);
 	umr_wqe = mlx5_wq_cyc_get_wqe(wq, pi);
 	memcpy(umr_wqe, &rq->mpwqe.umr_wqe, sizeof(struct mlx5e_umr_wqe));
@@ -143,6 +145,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	};
 
 	icosq->pc += rq->mpwqe.umr_wqebbs;
+	mlx5e_icosq_sync_unlock(icosq, sync_locked);
 
 	icosq->doorbell_cseg = &umr_wqe->hdr.ctrl;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e666d9cc1817..fdbcc22b6c61 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2750,11 +2750,16 @@ static int mlx5e_channel_stats_alloc(struct mlx5e_priv *priv, int ix, int cpu)
 
 void mlx5e_trigger_napi_icosq(struct mlx5e_channel *c)
 {
-	struct mlx5e_icosq *async_icosq = &c->async_icosq;
+	bool locked;
 
-	spin_lock_bh(&async_icosq->lock);
-	mlx5e_trigger_irq(async_icosq);
-	spin_unlock_bh(&async_icosq->lock);
+	if (!test_and_set_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &c->icosq.state))
+		synchronize_net();
+
+	locked = mlx5e_icosq_sync_lock(&c->icosq);
+	mlx5e_trigger_irq(&c->icosq);
+	mlx5e_icosq_sync_unlock(&c->icosq, locked);
+
+	clear_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &c->icosq.state);
 }
 
 void mlx5e_trigger_napi_sched(struct napi_struct *napi)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1f6930c77437..1fc3720d2201 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -778,6 +778,7 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	struct mlx5_wq_cyc *wq = &sq->wq;
 	struct mlx5e_umr_wqe *umr_wqe;
 	u32 offset; /* 17-bit value with MTT. */
+	bool sync_locked;
 	u16 pi;
 	int err;
 	int i;
@@ -788,6 +789,7 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 			goto err;
 	}
 
+	sync_locked = mlx5e_icosq_sync_lock(sq);
 	pi = mlx5e_icosq_get_next_pi(sq, rq->mpwqe.umr_wqebbs);
 	umr_wqe = mlx5_wq_cyc_get_wqe(wq, pi);
 	memcpy(umr_wqe, &rq->mpwqe.umr_wqe, sizeof(struct mlx5e_umr_wqe));
@@ -835,12 +837,14 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	};
 
 	sq->pc += rq->mpwqe.umr_wqebbs;
+	mlx5e_icosq_sync_unlock(sq, sync_locked);
 
 	sq->doorbell_cseg = &umr_wqe->hdr.ctrl;
 
 	return 0;
 
 err_unmap:
+	mlx5e_icosq_sync_unlock(sq, sync_locked);
 	while (--i >= 0) {
 		frag_page--;
 		mlx5e_page_release_fragmented(rq->page_pool, frag_page);
-- 
2.31.1


