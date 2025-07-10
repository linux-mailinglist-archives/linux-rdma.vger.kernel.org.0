Return-Path: <linux-rdma+bounces-12035-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D144B0048C
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 16:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DB7645739
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 13:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655D5272818;
	Thu, 10 Jul 2025 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JIdN3GOC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011AF274FDA;
	Thu, 10 Jul 2025 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155699; cv=fail; b=Bd/lGvBiff4H0IgXzKLmH9v9GOegEJbQdhKYWHFXX1K0Te7anfRq/+nUfJ0h6HODnN1aFNwOx4PvjdGpA+jy99NGCS6k0goZ3MQqq8VchtEWWnsrtWKhwH6a7fEhTO5iQqS4e729Gs7joqchF2Df4QKUKx3py/HSkMubMQ18JM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155699; c=relaxed/simple;
	bh=RnF1tCFfaBEzj9YyXi5zFnx2LDnLWDSy6p45WVctRjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7vkxirLTd8eAenrY6hr5bizNWmRP3S3V68soO1/M3Mn8pjuz7XHxfcSkeQ90JrluyuH6ZH5OdQQI1YDM9ZHvdLszETPHyLX6N3qK/CENZIYpNA/O8ZdOl7Vs9i7NMZOxV/Ux/7xNGth0ToBtQnK+Nlx47oBXpGZAWHlKVKVacg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JIdN3GOC; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2RFNIKsdtpYV1p+8TgLZXm6iCTJFpRmzTzOIkO6z/6P0Q4joUOdYP+7B0sg+AkcfS49+oOe4TCGB887lgIOSLLAe67x/gdW2vSyYNBIsf/IALm1/nIhWjxSKMnSwZW5Wqym8rD9MZBJSDRHjhLMZaNSaoLcW9RtzBMPNSel+Uw7G11p7WAZ5bLBOpqJ/f1X/NnVZQMhcSFF6M9BFPRwasfnAz2tnCDAoTik9TVJvnviX8t2Kdtx2ESOgY5CnyaIOK/IahN+u6+Jkeorg/kSxxbDH4cRnLdMYTinSEr0xxjlHhO93KANrNfql0E6Pfhv+hLkqdaOSXLY8rqXvbUy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNpidH8E2P7S+YbA5NcLW1N8WmsMOj5m3WoPqYYtpEc=;
 b=jcdgotx/8NY/GBvNAt3sHTJUNtTkHuaipFMbDh/h3+st1754N/pR2oq+j6ST73ysWbrHLO+sq0jbexMUNv4ddDUIAo6Sy2GoInYF51Fh++e+oUj+YWGnY7ebuGmRmadzUnTntdJdL6bHvxEcdJplSOKDAIW9Z5bVx5IeCUbSQB65r9Nm6SLSjjiCJ5Tt/redFYAfdf3nv2VKPu5m7wQ5QIUVFTGz3PTL9ofCsL/IB2lPU64PyH7Cb0aaICv4GnDfkN/vaLv6RK1yE8e5hCvK9/D0qxTWv8uWzHjn2hGmecgxHJMa8ZzEhayW2Cz0hKOziGW5nngXvEsbSPGj8IkEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNpidH8E2P7S+YbA5NcLW1N8WmsMOj5m3WoPqYYtpEc=;
 b=JIdN3GOCS0ZCtyQrgyYaW8qvUw0RbsCnwoxBX4rYS+i9Z19+EvoAEynws2qLBJ6bP7kyxvRAfQIRnsVXaRmc0eTlWrZOYLsgYT18lJ2rVCp2cP3NCp7sAnap4YzC0Mfccoc1llCqZ0dQwgF7RxGGp8gUz3fhEpyeQQLHIAZBL2TKXzZrn3TUbQyHojNqTjK50bk1H1mIcXlpNEq58xYURwILQzphsgoeD2oJUuMGIjDpceTaWQXeP9PiGk8/a7hVioc7Jjwe3oefO9SFfDXTcsN06OpwiC2btnm2mw5zfi1BnfuQG36nGwWu7McxW4SSQjGNMaN2w1ZiKxEHimwbdA==
Received: from DM6PR07CA0102.namprd07.prod.outlook.com (2603:10b6:5:337::35)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 10 Jul
 2025 13:54:53 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::30) by DM6PR07CA0102.outlook.office365.com
 (2603:10b6:5:337::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 13:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 13:54:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Jul
 2025 06:54:43 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Jul 2025 06:54:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Jul 2025 06:54:39 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net 2/3] net/mlx5e: Fix race between DIM disable and net_dim()
Date: Thu, 10 Jul 2025 16:53:43 +0300
Message-ID: <1752155624-24095-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752155624-24095-1-git-send-email-tariqt@nvidia.com>
References: <1752155624-24095-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c669f89-3654-435a-b51b-08ddbfb95890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BNNYwiGNinsxKudVW2hVOsos3bpPGdIhTXM9g/TfL9fv4zIfus5VFPdleiow?=
 =?us-ascii?Q?Yfmmzd50OUCNETNHKyGR4yeNrCGWxfYVk/VV59T1b5vnxe9IG5WZZ0eSKdz4?=
 =?us-ascii?Q?Lfm2SeC1qtM1QsaBoXVSp30xkPFEUhybWFppTUzQrMZKrfvIj4jZkcyPiDbE?=
 =?us-ascii?Q?BZ7M6fy0deTQjQRG72orUy4l6tb5zfqJN36YRK4rMiFgg/saXeNJGx5Gm9RC?=
 =?us-ascii?Q?G12fMXJblo1P9un1Y7WWpkQMFnk6bA9DBrYgOZxi+wQ/kRF/oKlQIL+FCbe2?=
 =?us-ascii?Q?Ep8o9x3MV0L0x2ILs5W2Yu4gDxjBB5mqO0NNwoye7Qpyn3MSvnvOmTiWucG5?=
 =?us-ascii?Q?BO2TU1o3aXb27I13krbd446tKlcFXZwL1edokod12Z7mbDv/XeQljRZfxk0P?=
 =?us-ascii?Q?HWdD44keBqz0FuA3ra+GGAzOFQGWGSDenPUr/ndnCJTAGrUQas+kg2Hdmy21?=
 =?us-ascii?Q?i0380mlVSmemPy2GW/5Otky7DRgAd2HYiEbEAkePhI27SfNFNrMOJrYRG6+z?=
 =?us-ascii?Q?O+KAFgGJIUEZUqrHj6I5e76BIchwPim65+KKiiFfSqfX1F/aQhTg9+qLs6Op?=
 =?us-ascii?Q?Eq+8d8r3lMAsIN0gaQPDG/zwpS3Y8Srck6e36O6DAZyRkZsn88YwLBg9fh/i?=
 =?us-ascii?Q?EJm7XcW6ZOyCUQooYqtXqXFPwhN2wZEENCrRLIlZNvDUxamT4gWGQ0OKTUAr?=
 =?us-ascii?Q?h6ZRuk4kOGmN8vWfa9GPxy8Y5U2HO4tdkldDp/PDJ5qcE1/5Y415aiQc6mfL?=
 =?us-ascii?Q?93iXdJoeSP+B/hparXttGJ3vJMO2AOX2yRvm85JWTmwZQd9iYqc0B+lnIMjK?=
 =?us-ascii?Q?SY4kRBShW9qBG+jZN0/D380Kc5A7/RLWXNOp4dFfQUTts/FGCK5ikuhUij8G?=
 =?us-ascii?Q?NWEc+B17KjNGDi+vebe/ttNjmkLD2xDWJ5rZzIAAhIoA6E/uzguow98B+Nqc?=
 =?us-ascii?Q?GSGsuyx5KobwMgKZvMXnZ2xRwNXSGU5rEzotrqe5Eij9hZkzFfz1gKPmE5LJ?=
 =?us-ascii?Q?Lpnt22yG0KUr/Ki2Q/l4p2E7eIjOe6R+jS1x61cWxzo+33u439c6L1SIN0I3?=
 =?us-ascii?Q?SyfR+Xj17z6ZfVSsGn2G2TNmTJc1Zi+xh353Xyr2nJ5JS4jChBk0kOMbkS9x?=
 =?us-ascii?Q?1MwE9+IlKZuGr9rqHCo+q1OdhHItrnEMynpURX5BPvfFzK1bupWe5mBDbVoj?=
 =?us-ascii?Q?FRJ7BTxeyMySSZttjWg8rIx0QM+XhN/BNWCNal0e8xeO3+l/aJ481qtvnQQU?=
 =?us-ascii?Q?SejhS3Y/uCHSl1ISIxUlmewGbMAyidhOkHjBVIAussps3vZ6kWl1hYIZYnGh?=
 =?us-ascii?Q?qGAn81KIpGpPnkvnsWyUIo3dtRtn9DUYttRdN4xtKRvNs0E36WZUNKt0vHCX?=
 =?us-ascii?Q?lj40JBDpm+7RYDXdCmCXAR1t2NIDXw5RzXRjByt97C8FtQfe6QWWmknBT5Pb?=
 =?us-ascii?Q?IvffXYa1WqflK0HZk8b4GjQZQvek0jcuHU21eIuVFiFUmx3bZACrrl+gH8ie?=
 =?us-ascii?Q?BjmzA3Np3jp4MDuhBj5xkI/Qp4Hj3GyhSHee?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 13:54:53.0894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c669f89-3654-435a-b51b-08ddbfb95890
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692

From: Carolina Jubran <cjubran@nvidia.com>

There's a race between disabling DIM and NAPI callbacks using the dim
pointer on the RQ or SQ.

If NAPI checks the DIM state bit and sees it still set, it assumes
`rq->dim` or `sq->dim` is valid. But if DIM gets disabled right after
that check, the pointer might already be set to NULL, leading to a NULL
pointer dereference in net_dim().

Fix this by calling `synchronize_net()` before freeing the DIM context.
This ensures all in-progress NAPI callbacks are finished before the
pointer is cleared.

Kernel log:

BUG: kernel NULL pointer dereference, address: 0000000000000000
...
RIP: 0010:net_dim+0x23/0x190
...
Call Trace:
 <TASK>
 ? __die+0x20/0x60
 ? page_fault_oops+0x150/0x3e0
 ? common_interrupt+0xf/0xa0
 ? sysvec_call_function_single+0xb/0x90
 ? exc_page_fault+0x74/0x130
 ? asm_exc_page_fault+0x22/0x30
 ? net_dim+0x23/0x190
 ? mlx5e_poll_ico_cq+0x41/0x6f0 [mlx5_core]
 ? sysvec_apic_timer_interrupt+0xb/0x90
 mlx5e_handle_rx_dim+0x92/0xd0 [mlx5_core]
 mlx5e_napi_poll+0x2cd/0xac0 [mlx5_core]
 ? mlx5e_poll_ico_cq+0xe5/0x6f0 [mlx5_core]
 busy_poll_stop+0xa2/0x200
 ? mlx5e_napi_poll+0x1d9/0xac0 [mlx5_core]
 ? mlx5e_trigger_irq+0x130/0x130 [mlx5_core]
 __napi_busy_loop+0x345/0x3b0
 ? sysvec_call_function_single+0xb/0x90
 ? asm_sysvec_call_function_single+0x16/0x20
 ? sysvec_apic_timer_interrupt+0xb/0x90
 ? pcpu_free_area+0x1e4/0x2e0
 napi_busy_loop+0x11/0x20
 xsk_recvmsg+0x10c/0x130
 sock_recvmsg+0x44/0x70
 __sys_recvfrom+0xbc/0x130
 ? __schedule+0x398/0x890
 __x64_sys_recvfrom+0x20/0x30
 do_syscall_64+0x4c/0x100
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
...
---[ end trace 0000000000000000 ]---
...
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Fixes: 445a25f6e1a2 ("net/mlx5e: Support updating coalescing configuration without resetting channels")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_dim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
index 298bb74ec5e9..d1d629697e28 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
@@ -113,7 +113,7 @@ int mlx5e_dim_rx_change(struct mlx5e_rq *rq, bool enable)
 		__set_bit(MLX5E_RQ_STATE_DIM, &rq->state);
 	} else {
 		__clear_bit(MLX5E_RQ_STATE_DIM, &rq->state);
-
+		synchronize_net();
 		mlx5e_dim_disable(rq->dim);
 		rq->dim = NULL;
 	}
@@ -140,7 +140,7 @@ int mlx5e_dim_tx_change(struct mlx5e_txqsq *sq, bool enable)
 		__set_bit(MLX5E_SQ_STATE_DIM, &sq->state);
 	} else {
 		__clear_bit(MLX5E_SQ_STATE_DIM, &sq->state);
-
+		synchronize_net();
 		mlx5e_dim_disable(sq->dim);
 		sq->dim = NULL;
 	}
-- 
2.31.1


