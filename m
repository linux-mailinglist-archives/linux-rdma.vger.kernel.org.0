Return-Path: <linux-rdma+bounces-14944-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44535CB000E
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Dec 2025 14:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BE95313F11E
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Dec 2025 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF8A329C4A;
	Tue,  9 Dec 2025 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LjBKYdMA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012069.outbound.protection.outlook.com [40.93.195.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F66322B6D;
	Tue,  9 Dec 2025 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765285047; cv=fail; b=FXVhxqeG5KQPJ2zjqrCK5CXRLnwg1S77QDa3uGeEMvSufeMnjg+kwxVYeMSXtE3Z7i64z2VzwYFrnSq7Umd0gz8SldIKG2LQRGxL5txZn+7Z4s6oWN/9JDmwiykGmFvTcNkT5RMadQu3fLpp0mwBu3Cw5kPUw7aVFi4cHvvEEmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765285047; c=relaxed/simple;
	bh=5HEjhxHDdcofq+gLo2QW2WxsEepBY6OpTI/WB4fBDAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFGdXK5GjDq2ztIjR8FA9YSGzAzGceFh3E9yPYbPYTcXOADi0SfVvUh3xVM0WYi+Rv4TeL1Fd7npemCWBJ/73vkYtJHVaJhA1EoIkUzzAUinUbvYBFK9zONcOzWO3TfbZ8D/ZySP9W6JvUOD2dMjPgHRa6xxYVbMhlzsSNpFd0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LjBKYdMA; arc=fail smtp.client-ip=40.93.195.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycI/aHk2hfb9poR3rdZeGSts6IEbRJ743DAVLYH/XOGWbdWdwa2/NlguIFshas+Q0NaH4xaLdUMljVcej1kKyGcm6Ir4se56QobabVkmzOkta/hatMa/n7/3Hymw9os1J8cMdNV1Ae9VUt0C+IgK7+9vcb9uEzsOSbfKZPGKgQi0ZJ6kaVmMBpTUXQGHEBZ0zFC/GLBF1ou/nFebaChFunPadvGdkgo6DPJwVnwqGnd2EophTqvpTBGfHaPg2Xr8iQvxpatTDh20ajzkYS2LEORj9O2XcP/sl0pTYVKsAvJVBexWMjP5wS/sJPTK7J2gqYcnp3AXj9B6+cXGMQUkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQfMJ0Fh36XPJsRjg257B/afW81IQKTp0Qm861bHvMM=;
 b=No3huxRScASCtJb5iU7jkyGgMml8U9x8VIW0R50gNYeGtvZ7ZpKK3dH45mAC6gBZtnuzdRb//JIOHycuwMX267gdqfzeM8rDWMR9ewO57OBKsUomT/Dc87yKira4IdRjjQglf+rXNX2gbiY3Dpclbc8EqdoWa7oe+zU4V2iEXqWMmOkayUkuATds9J0iz9xhoUl8VwsG68YUfACVhp2dM+H94/51PeDqVk0hidFR/WIuUIG39D122bBUBMFzX7OyjaIqPgwNQsg3VecdfCVWrV8JWpbLTcWQOVIKaXFVKErat9/I+1LD5oP7aBc1UAvJMTXooppkInVcVoHoxRxLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQfMJ0Fh36XPJsRjg257B/afW81IQKTp0Qm861bHvMM=;
 b=LjBKYdMAvJkzUDyvFELWylaBwla6NkUZUFj7a3ChO2pbEPTcYIq05QU83orBzj/OkciIzdTCVxsw2hTxfv6wQf3JeiE28qILyzaEuIoMCLnRryC1V1/O6To1u5eHmGIrye+9CLLQTWMbA0i+08JkleMfm8fvaNg42PVMjZdNcgAlpB+Ng6F+Cn33an3zQpSFbBmmNXJ9ATZYm8S3GxoOF6kcGSA1ZqBK5AMruvC0USgHNIxEk2OHtlSi/X+7RQdzOSJy4YzYYTTg5beoaHcXIyfdunjhy5aGIJLSKE3T/fAT6nTAbo+QhOe84T15lRHOn6VtcLvdJ83jV+EzGjA0Zg==
Received: from BY5PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:1e0::31)
 by LV5PR12MB9778.namprd12.prod.outlook.com (2603:10b6:408:300::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 12:57:16 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::94) by BY5PR03CA0021.outlook.office365.com
 (2603:10b6:a03:1e0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 12:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 9 Dec 2025 12:57:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 04:57:07 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Dec 2025 04:57:07 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 04:57:03 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Breno Leitao <leitao@debian.org>, Alexandre Cassen
	<acassen@corp.free.fr>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net 7/9] net/mlx5e: Trigger neighbor resolution for unresolved destinations
Date: Tue, 9 Dec 2025 14:56:15 +0200
Message-ID: <1765284977-1363052-8-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
References: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|LV5PR12MB9778:EE_
X-MS-Office365-Filtering-Correlation-Id: 469564b7-7e8d-4cdd-b9ea-08de37227ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nIot/NhXMAiIpA6VZeu6MOBSzl8jKOdPH8KKJKC7mOh7r8FDX6eI1d1DH8yJ?=
 =?us-ascii?Q?H1gL2sDLv0QbjXl4FJfcIafYFeQ0oee21VZY/SoIokR+3yNDgo1eGlXxdkQS?=
 =?us-ascii?Q?9sHlf8T8ZnlfJA6L6t8b75Rz7cFix+Wf0QF7uPHFVJtQQ94uiFVgsGl1ZFxc?=
 =?us-ascii?Q?WXwhOkuCX6ZrqIbnX1GIascKUp0IO/akVP6ZBxVtxPbU4bA2TBwkQD/9KfEM?=
 =?us-ascii?Q?JnAexWZ3Pz5bpFmUva8J26T9k0NqHHdYbvsiIL1Tq/SR9DJ8NXGbWvfpVGnK?=
 =?us-ascii?Q?t1E6LOj6VOZQ13B9EPfaATcpiTTP6MDpaIDmVb17FAb+Dx1nyPqZmSpw2HoA?=
 =?us-ascii?Q?y/esGG4Cclaggxe6PFYxEKj2HSbUI1II/U/YDGdxu4lCUkw2ZJKvdrpYGcf/?=
 =?us-ascii?Q?OahioTnXPO5f4qUQBegp1yBvMIhZvHL+5OLqibulP5FCE7X079xGuGEXYy3P?=
 =?us-ascii?Q?9qjP5x2+urcBvMN7Z1oVoPRxoKQntfunopn7kkxd49jHtw4hsD4+arRc7fP1?=
 =?us-ascii?Q?K4Ttlp87UvuIIfrAz2Dkpvx8QC8VApwEf2ADKKUI1mFhgu5uGV3TUwic+pUa?=
 =?us-ascii?Q?b+Y2LP7S8qXBxnyKeIcuCzAyCh+OycGbrQhNe+nM16rH5jTG97ZxZzhVEZAL?=
 =?us-ascii?Q?biddamV/lxTKEfe8VKc6BT4gzu/QmubJ2qGyB7pXlbNXHmxMxw+3AyXFC48r?=
 =?us-ascii?Q?v0OWxwoz54lEBFIKFldN6nZCzrYh2x/OEq5+oF/kJouREx7OrbEHrvOE7PnX?=
 =?us-ascii?Q?D/zAfDAdA7kF2S6HEh7DZrZ8UmfBvOHqzMIAeh9rvNjNlR4AncZ22H4CH4SH?=
 =?us-ascii?Q?tsw8cnI0ot8Pzst8RVCzxRQ9sAdM60uV8gJZfmnDZOwIu1umN2bN+PdNi3pA?=
 =?us-ascii?Q?fYETjiUOtImQ5WVjpbx9AOzAeBre72bY5G+p/MIBK+cnUzMWKWtLaH7YJRFv?=
 =?us-ascii?Q?lC7Oyr8nxrmDxrhocR3L8BQW0aHqDhShvUM1oE5/UQNTUfVMQxRMUxiNiRnp?=
 =?us-ascii?Q?lIjEY2b7Y/wgC8eF2Zd/TUKM9oJdPSyWwfzh20asG1vQnBUgRLUfvFj6BW2C?=
 =?us-ascii?Q?R4aQmh+fJftoYowUY2GlzIkRjxrqu+Kr6Wgc69Wk51gDPjqNYZRsTjM9VAkE?=
 =?us-ascii?Q?tmJYom7+x+IQl/ed/BeO3BZLTAb2DP3aB1QtHRRHE1Dwl32JJUX0y8TxXXrb?=
 =?us-ascii?Q?vvOS1gidhNo8AgCPWOCKAStTCK/VXB7xIPmmK60G98FIAv/rrrriTr09hT8t?=
 =?us-ascii?Q?0vrpW81ctHC1ap+3/JgNMqtZMhCBz0nxJ+A85tBCechEA2t2PxSYLohYw21a?=
 =?us-ascii?Q?kCvTTwsD2kcNmg3TfzBN+mCUzycU6KpiL8DBKxicHoy6a+El3Nj379YG2Y5J?=
 =?us-ascii?Q?UDNtWXmhBq6TLdVc0PDQY7UoDjVe7sB1stReKh/ZK4NqDgVWIst7DFQmLgce?=
 =?us-ascii?Q?LJOg40bvfMCHqFlm5D+iaamuWcQJn+8xg83gQQPa159APuyPlY0Ww8JefSxu?=
 =?us-ascii?Q?2UNloDVcK4c24a59LLyimYixsRZCpIeKTL5bFfVBjJai2/Og0sJUkKf1a4ti?=
 =?us-ascii?Q?lRxZ7xvXh+hUwa/LzVUKPsNn0Hj6+gFj2Q31k+3K?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 12:57:16.2564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 469564b7-7e8d-4cdd-b9ea-08de37227ae4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9778

From: Jianbo Liu <jianbol@nvidia.com>

When initializing the MAC addresses for an outbound IPsec packet offload
rule in mlx5e_ipsec_init_macs, the call to dst_neigh_lookup is used to
find the next-hop neighbor (typically the gateway in tunnel mode).
This call might create a new neighbor entry if one doesn't already
exist. This newly created entry starts in the INCOMPLETE state, as the
kernel hasn't yet sent an ARP or NDISC probe to resolve the MAC
address. In this case, neigh_ha_snapshot will correctly return an
all-zero MAC address.

IPsec packet offload requires the actual next-hop MAC address to
program the rule correctly. If the neighbor state is INCOMPLETE when
the rule is created, the hardware rule is programmed with an all-zero
destination MAC address. Packets sent using this rule will be
subsequently dropped by the receiving network infrastructure or host.

This patch adds a check specifically for the outbound offload path. If
neigh_ha_snapshot returns an all-zero MAC address, it proactively
calls neigh_event_send(n, NULL). This ensures the kernel immediately
sends the initial ARP or NDISC probe if one isn't already pending,
accelerating the resolution process. This helps prevent the hardware
rule from being programmed with an invalid MAC address and avoids
packet drops due to unresolved neighbors.

Fixes: 71670f766b8f ("net/mlx5e: Support routed networks during IPsec MACs initialization")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 6c79b9cea2ef..a8fb4bec369c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -358,6 +358,9 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 
 	neigh_ha_snapshot(addr, n, netdev);
 	ether_addr_copy(dst, addr);
+	if (attrs->dir == XFRM_DEV_OFFLOAD_OUT &&
+	    is_zero_ether_addr(addr))
+		neigh_event_send(n, NULL);
 	dst_release(rt_dst_entry);
 	neigh_release(n);
 	return;
-- 
2.31.1


