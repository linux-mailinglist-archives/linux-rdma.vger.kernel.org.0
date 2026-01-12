Return-Path: <linux-rdma+bounces-15462-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAAAD12C0C
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 14:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 051BF3056565
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 13:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09043590B7;
	Mon, 12 Jan 2026 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qXpO1cGM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C3427602C;
	Mon, 12 Jan 2026 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224191; cv=fail; b=T70TbotKtJvihyoFj27HSaLsy8oA8XOzLao2yPJ9NrbjOO4CqMsbPuaZvZwpa3Ba4NKouQzKE6PZxcH9TS+xmD8RAEkgWzrqwyJo0ahYgUydn0sWB4OwPKpbItrGs6vGTh1Dy/3kd6kElWkjeKnLc2uz6OQMssAYLrem+GuLBRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224191; c=relaxed/simple;
	bh=TE4WXu2YL9mEXo9JD2jG30P4Q5Dgg1BhmiOJqcuA8lo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDjski6+CavbfswU9vgLRkxkA4r6p436e2D3Pf0W7XuU23KZZvYcnLLzUrbp8d8PKgRaPG9yyZnYQPNr87k1k0CuK2hztoKgnToifNuY3Yo7z5ldyVzIMr+39g36QzSnGcvfZBo3PvGSjbhYKN91w3+vfNoVgUKSM4W22tQHb6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qXpO1cGM; arc=fail smtp.client-ip=52.101.85.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUZvQE31Qyaao1sdIs0s0BWVMHQ4sfnpHk9G0wTLKVjX86gDCzJ9lfY7NT9vvtx7BGdtZ4p0cDgqoB5ZGBauMgZpTH4ubi026HwVY9FK1yyEAAVtJhFHH9fAiJSOQUaAho/5XXtmO8szjJNKgK7Lx26sCoBE3J3dQlwKptREad2fSi+w1n4MX4cMVr+uSAOcj9tTjPDB7bQHvJavXgZ3AOv9PwcccdbDVi7g+80EibtDPEzEjgSzQd8pzFOo0k40becj9hg4REGCq+KKPpWbphcYxnPceZBnKGC3dTRMJOGNpDprrLrvUU9pWa7rfEGQNi9SosqZKJs39jU0QyZomA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+irih6VYI4g3IS2/tqcU63mWIluptYIAeRbw+syyrV0=;
 b=Z/GKj9eGnUVUuGubbR13wQ6sLPptSz1bAKEJDhX6Er0nxFMVBzo1xp3yVspcOtlWWwKLggcjjDsmnCMRLrP3pu7CHgZk6spuifFysNVD9ToycGFuYEn53zO8+FKBl8OAjtlS6Lo9XMh2vgl53/yjAwDRL+XjcyoL+zrBDaUBGWfWjUSHOH97M4hhJN2tA5LAtDM/BvrRqzjQ8pb9zHLnGfMnlDoAdyPNnRHuD+PQedpzfOq8KD9zT5ISRRmXFwcKhI4oNFm+8yN22knu68LP0EwHELpFvoqkFeOLSa741BYb5PViBKHIfiIV5sxozCbQOLcqqlAHm2izO9uuyEBoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+irih6VYI4g3IS2/tqcU63mWIluptYIAeRbw+syyrV0=;
 b=qXpO1cGMEheyIpPSDMZCPtm3Bpba45Rc3XfnWDoeKidCygF+p3NeNEPlRSk8S4t61g2v9bgGXKueZ/XO/Z8uatlIO9E8Cptrv2GNbLtT4CODtGbuVTDBWtB+kjTBs927D9/rnb+E5T+4wtUmPvdjSjKzB4vHFXYkXBGHENQG6xI8Z6vyyJGBZ5EbeID8192SeMCgzZ37EEVNJ6dxU0RkJ0aPJppbroPTl8piWi0eA/pMPdDOMnm3UNdmdIyRLOOZ5zNK5zEStW0lBDtZfM+DFmgutq18IjfI4aFCpJbxyb5EIJm21J7iWG6H9RnWCWwTrjREUi0zZ76uqkCyQmT6yQ==
Received: from SJ0PR05CA0100.namprd05.prod.outlook.com (2603:10b6:a03:334::15)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 13:23:02 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::f1) by SJ0PR05CA0100.outlook.office365.com
 (2603:10b6:a03:334::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Mon,
 12 Jan 2026 13:23:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 13:23:02 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 05:22:43 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 05:22:43 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 12
 Jan 2026 05:22:38 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 2/3] net/mlx5e: SHAMPO, Improve allocation recovery
Date: Mon, 12 Jan 2026 15:22:08 +0200
Message-ID: <1768224129-1600265-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768224129-1600265-1-git-send-email-tariqt@nvidia.com>
References: <1768224129-1600265-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: 27bc0ef4-2bc2-40ac-8024-08de51ddb6a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|30052699003|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dqa6CRU5YRWD4CtZq+POFB1xS3B8vEy22WmVCeo+ZPGxm99iuJn+6PHnNY13?=
 =?us-ascii?Q?X1P+p4OjPZs+Zjaaj4k3RwXRRxfeNBT+hMMdGuhYdo+B9dq2pAiPPBRsCk8W?=
 =?us-ascii?Q?FPD517zcS3MQrYFz66+L1YmNBDf1vet/DzBx6HTNqiHQ7wJbZZS+pVe3ocXP?=
 =?us-ascii?Q?3xEhVW3l1djRMbawjixMaaYIv9brvGK7Zh40wgiqTJeBeH0EJklG1Bm3wZDq?=
 =?us-ascii?Q?vZFDvQZQT8X0J8C1ZsHAEWlRauOFW4dLMLcEOc/e9ZoidCVep7MZhRlIwawo?=
 =?us-ascii?Q?DBFj1Xe2ElDXwnGHdUB3uL04AXdYykSODdvwML1rwv7UmHUsVijQ393omUDO?=
 =?us-ascii?Q?gZjRFru8LZHja9SJafuNifb5E1DoCi+sC2xgj0PZBtzIBwwI6RjxOAXpcjxy?=
 =?us-ascii?Q?qVf2/7WkMNvibn1+Pk5+lFUp/H5PwwNN9fDtkfC0Eci7llKvc8uwhdbXqXKp?=
 =?us-ascii?Q?PFIk6Gd2loitkRCcA+TKjq0KOtzXhePKOidr9Ut7Ho+TcQooShljt9lh48Gt?=
 =?us-ascii?Q?wwchAPiYPL6evoJZPMFYHvhxNSb/JBp7D9FZqKjUIoItjnSEGYnydv8KvPtz?=
 =?us-ascii?Q?VeElmmBmfkZRzSW8u+qxWh0iVPDXBOuVYPtkdvsB0EGt5D3ao/mnpIHQS/+1?=
 =?us-ascii?Q?yyMvwgvvFMTK7aRpPGt+eJ1WZKucHVj1OZMXMm5Xtxr0Mh0E9Cqw6UDk8HqK?=
 =?us-ascii?Q?TXmCMsCPgamv/ocaBRM2COLCdWLPePW1DH4HnMY6n03p7MtI9OSzCnHFBPol?=
 =?us-ascii?Q?7Wx4Ii1F29nFmjQH4Y4Zua5zkAKuYkiEnSZw1bIOe8qK5RVd4HvcoguQk9Lk?=
 =?us-ascii?Q?XUcEtGQo5qufhMafmco64ND7qeEqLI/SF9B4DmTNJk9xQ3zBwEojFy/9qn5p?=
 =?us-ascii?Q?/TVZQ6SfIn1knqfCEHylfZ+HQFR7KbOxPNzt2zMo7Bx0bFeZQUSj/iErgx4O?=
 =?us-ascii?Q?teNNzhFD1+F3ps1L4WoZmNpCtUj6joUt03Oz7mNkAt24fENJMBtq/5qIVrpt?=
 =?us-ascii?Q?wxH8JnQAiBIJchzWoQ8pAu1mJ+2mDkjW1rN2GbayP57wB6pZ76PgA/DMkewH?=
 =?us-ascii?Q?YyDHnmaWWPKQmgZP649zE0E0z4hgo6mF4C+r5e0Pze8hoMSowqpbZ/bo+6qZ?=
 =?us-ascii?Q?zMoORFSKLTP6Ocl/15eHPFU62tT8sBy8TfbQSSXY1YMA8wRgOBSEtFtuHtr9?=
 =?us-ascii?Q?HN0b8Ol6/U+r8o/2pS/+2SCjSo87fZhQrbttxpn/HDlHmIgi+zqreE4hLnxy?=
 =?us-ascii?Q?eRkZAVFQdyyyBbXQPaIbd61Yf8O2lueHbfzjpYUemn1cDLDH79b0xAZdA3iY?=
 =?us-ascii?Q?UANVa0087jrIMrTFd+a13oHI04GvNvWMWyYKNcY+TUFLWEqycpiEYMKARAAW?=
 =?us-ascii?Q?q5lr9xRKPsWfbZNiLeUblfnIBu/Dho8mF2Yelj/ryBVESK7iC7MsShyy8B+e?=
 =?us-ascii?Q?jDOC6+ZGgt9JnEGYy5QziG6vLOmST5+W48I35EDbSgeRheca6MxzyXKAZxu3?=
 =?us-ascii?Q?GG6c/JtdTo/nlvqYSCe22vsfvw/YRzC8YD+TK4cuCqkwlAiQGFQyURpmRiNq?=
 =?us-ascii?Q?NTkn0if1HToxGhW7h2c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(30052699003)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 13:23:02.5565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bc0ef4-2bc2-40ac-8024-08de51ddb6a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192

From: Dragos Tatulea <dtatulea@nvidia.com>

When memory providers are used, there is a disconnect between the
page_pool size and the available memory in the provider. This means
that the page_pool can run out of memory if the user didn't provision
a large enough buffer.

Under these conditions, mlx5 gets stuck trying to allocate new
buffers without being able to release existing buffers. This happens due
to the optimization introduced in commit 4c2a13236807
("net/mlx5e: RX, Defer page release in striding rq for better recycling")
which delays WQE releases to increase the chance of page_pool direct
recycling. The optimization was developed before memory providers
existed and this circumstance was not considered.

This patch unblocks the queue by reclaiming pages from WQEs that can be
freed and doing a one-shot retry. A WQE can be freed when:
1) All its strides have been consumed (WQE is no longer in linked list).
2) The WQE pages/netmems have not been previously released.

This reclaim mechanism is useful for regular pages as well.

Note that provisioning memory that can't fill even one MPWQE (64
4K pages) will still render the queue unusable. Same when
the application doesn't release its buffers for various reasons.
Or a combination of the two: a very small buffer is provisioned,
application releases buffers in bulk, bulk size never reached
=> queue is stuck.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 57e20beb05dc..aae4db392992 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1083,11 +1083,24 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 	return i;
 }
 
+static void mlx5e_reclaim_mpwqe_pages(struct mlx5e_rq *rq, int head,
+				      int reclaim)
+{
+	struct mlx5_wq_ll *wq = &rq->mpwqe.wq;
+
+	for (int i = 0; i < reclaim; i++) {
+		head = mlx5_wq_ll_get_wqe_next_ix(wq, head);
+
+		mlx5e_dealloc_rx_mpwqe(rq, head);
+	}
+}
+
 INDIRECT_CALLABLE_SCOPE bool mlx5e_post_rx_mpwqes(struct mlx5e_rq *rq)
 {
 	struct mlx5_wq_ll *wq = &rq->mpwqe.wq;
 	u8  umr_completed = rq->mpwqe.umr_completed;
 	struct mlx5e_icosq *sq = rq->icosq;
+	bool reclaimed = false;
 	int alloc_err = 0;
 	u8  missing, i;
 	u16 head;
@@ -1122,11 +1135,20 @@ INDIRECT_CALLABLE_SCOPE bool mlx5e_post_rx_mpwqes(struct mlx5e_rq *rq)
 		/* Deferred free for better page pool cache usage. */
 		mlx5e_free_rx_mpwqe(rq, wi);
 
+retry:
 		alloc_err = rq->xsk_pool ? mlx5e_xsk_alloc_rx_mpwqe(rq, head) :
 					   mlx5e_alloc_rx_mpwqe(rq, head);
+		if (unlikely(alloc_err)) {
+			int reclaim = i - 1;
 
-		if (unlikely(alloc_err))
-			break;
+			if (reclaimed || !reclaim)
+				break;
+
+			mlx5e_reclaim_mpwqe_pages(rq, head, reclaim);
+			reclaimed = true;
+
+			goto retry;
+		}
 		head = mlx5_wq_ll_get_wqe_next_ix(wq, head);
 	} while (--i);
 
-- 
2.31.1


