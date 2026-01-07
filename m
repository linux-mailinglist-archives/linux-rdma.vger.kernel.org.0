Return-Path: <linux-rdma+bounces-15339-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6996CFCD45
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 10:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCD593076813
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 09:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D642D6409;
	Wed,  7 Jan 2026 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z7sVKDaC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010065.outbound.protection.outlook.com [52.101.193.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9AF2F6905;
	Wed,  7 Jan 2026 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777562; cv=fail; b=NaXuKXa/JAijHDIy2F+zvtpnWieuMsaGfpXM6MgZLs3oA4K1+fkFKZUu/zPDJ7wkrsHk98bcJOqno/v+Le8DQhhfFuE1fakobMRkd0fjGX+Oc1rl6uhmW9gqhLvUe3aoO3sVis1X3/mW2aEoZUb5w3OGAFszG7pRzhb+RVMLRsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777562; c=relaxed/simple;
	bh=1fqlgckwZHHQU5rp8nu8nPEUjXl11BIwxRskLa4LX+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyGxs7+vPHUf/PGt4baQE4yVE9vZexeFfAFu/wpDj2SHTf06dVqhSw3As38vcZDkrIQkxWXs4uzlSOYKwxaoFRSsmiJBkU8PqJHiI8wszAZT5WBFMIWstVS3szHxIVn5SNMfUJrF/zamsAoDmL+3Rs/9aJj2UsnquJ1JBvYwqiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z7sVKDaC; arc=fail smtp.client-ip=52.101.193.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOKtXO7hPt9qQm9hzRZ5196kNaOEmTuEIYLWhXia6OauWI6duD4IdO6UoPydFW/CrAHJNsfaDFWXKn5QHCkQ82ODY5bbh/VXrOOH0W/VQ1CZ9ykazPkX/z7MzekeCoVX3KUlqid+9SeyD2mPFlvliD+bVcTcd7TyV+ljeun3xaKEqA4GwcEt2FK5AUlcXP9qcnUH8xgjDrMyboJSVkZm459UqYfYe+LWiJvzRnVW3zNiQzOYEG9CqgYMO61OR7HcOnV5NG8DND+GCdpfn6JvXL0IvaRINLslwdfiwTL3WLfsy8teWXslw8bG54G6NyuFepXRQtBwCvDJWVC4zTlhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kx6DEcvEwXS0eCxMISCDzKgvm+m37zBQFbwoPN4/WiQ=;
 b=XmXCAHvssXwXsZe92x4U9O7eNkFSUmFmPbhbcq///IxXUp2y7YEvIGmNjkgw2J3VQNwr1F3zBqf4Pe8l5+nH9/n9iV/32pKn/r5NFOiqk+nKqZpvM+S5CcHGKMUbJHrYAbOYoCEZmqJ7ql/9P7QeDe7XpiINWasQSkdwmM56TSTpI6p+XACApvFk9WOt9RVM+EikOrJ62r2l8097Y+tQa7L7ympMsMCqBg8YN8dAVRS7SOme51ipxKmanSTNN3gG8jBGebsMtxo7iFLrioJka6Ddw/jTY5kO/isN1p0egHDGaTBegLiVX3WYWiV1XhuUUStllSTd5u8U74rlUw/zyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx6DEcvEwXS0eCxMISCDzKgvm+m37zBQFbwoPN4/WiQ=;
 b=Z7sVKDaCivQrIpRIvU7rQziKyb6fSpstk4JvAIU41ZAmsQYPA72eb0H+kl6EnHaVv4JbT3BN3V1/5c7vruUNtFie7jHqLxa1FCV3A1Hu+MIeTjbb5J+wJF5COX/kNYCZEvUYynlHrHDux8JMIKXFZ5FN6nn1DGgxeUp9Rg3cQpGhs/CQlOIAsP7LE/X4LgZswwiN8ZPv92wq5fs/XBYVSrZ6tlLgrMx8AXh2k2YZO0RKw44/Kjsqud6f0Om4XcioRzEP+K0q2VD8gIzAbbSN1R8kVJAvFbdaZwGVfT2TGvIYJygB+rHaJ+0f/cV5CDC26Nwx8fAJljikxOurbvn4Tg==
Received: from SJ0PR05CA0188.namprd05.prod.outlook.com (2603:10b6:a03:330::13)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 09:19:16 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::28) by SJ0PR05CA0188.outlook.office365.com
 (2603:10b6:a03:330::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Wed, 7
 Jan 2026 09:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 09:19:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 01:18:59 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 7 Jan 2026 01:18:58 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 01:18:55 -0800
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: [PATCH net-next 1/3] net/mlx5e: TSO for GRE over vlan
Date: Wed, 7 Jan 2026 11:18:46 +0200
Message-ID: <20260107091848.621884-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107091848.621884-1-mbloch@nvidia.com>
References: <20260107091848.621884-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: e882d3e9-f010-4111-ed31-08de4dcdd4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2//VopRCgCBWScnYjazqzBz/UlbasgKTE4R9oWFbtB1zN3t5wIzFPsa6qg9n?=
 =?us-ascii?Q?J66B1wqqUVv4PW3DJqrRFvmlvr7jgZs2v3yBkXATErPrJCZflkdMSP2ZIWMR?=
 =?us-ascii?Q?IKyyVyEOgK/KZuwLUIoKfb1ZF/CoxN3oGnW6aWiB6AwnPR/VY6Ex7NDLD1Dw?=
 =?us-ascii?Q?+1a8bvFfJ9ALQ6M2CulqKrP/LhjoekLEhcMMqi3d6IVi+7rp7EoA275txO3d?=
 =?us-ascii?Q?+aOYh7xqU9Sb1oCW+XuIb2wX0FdDv6ZxcFJmiDrl8bcWIMmlqcft73MxknY6?=
 =?us-ascii?Q?TMm9y6nLqrRdXzKUtAC8mgTRDl0fQO4vN33D7cIcJ36//VlvqI6oRe1tuhGY?=
 =?us-ascii?Q?gl/q8dzCPZfayjWjnhNk5MVMkOaew5JJkKmA8L/Jg3BFfkHjsHEF5KHQl9ev?=
 =?us-ascii?Q?w4t+xyrBLWdJ4q8SNdGsS5z7OE4DwAeAlQ0vhECKMd2ILsceHMIsXpP4Yf/z?=
 =?us-ascii?Q?Xp3iqyzVQft+6slKuGtjk7XLyquHRfuYVJCpbWZUUfZ0mHpLqlIBJmOP3Zi6?=
 =?us-ascii?Q?3j0XmEiAbXW3FXn9uN6+iPWZfH3t9ApJVWItGR7qFsj/AAoJRTp+VyIhWSCm?=
 =?us-ascii?Q?M2cxgR9N4J8D8pEwOZ2+JqEAYpjHGLYANcoJgln9OJi0YCndRQiokbKmHZSk?=
 =?us-ascii?Q?F5jn0MCzjN94tODxHIL5qzCPx/UzwVaau8AJ0ytA6t6WflqGIGIngiQ+RWFy?=
 =?us-ascii?Q?04mubX9WOUCp1v901I/UGEcZyL7ktV3D7d5SNP3HrZ9hM+ymOQV2gF8XQ7iE?=
 =?us-ascii?Q?ph90Yga3I1Xvx1o70qmXzQK5siaTG5dNoAaGHujhcM1fGTOBaBSXhWLiJ8s9?=
 =?us-ascii?Q?4OBxwzHbnu6MfnEYxJ8q/kzCWieN2nlnNow69e3LiQB1wehfeVNy19GaN0+f?=
 =?us-ascii?Q?5sKGuC4IeN1z2a6C5vSs4migzW7z20NBrZc5BLLEzpcWnR32xQka27ZHZrVk?=
 =?us-ascii?Q?ONaF6NYwjPNjz/V3pMcailjIUBz0P36BwhWrB6lg17rr0ygaCikAaYOCOSJp?=
 =?us-ascii?Q?MImIipvLJxOb9s8eMnllw+MtjEjIoOK+VplCoigLxJKjGkn9lzCTkpiC+Tzc?=
 =?us-ascii?Q?WIoUZbLpHKri3aKZ7n1iWa8m+2z2O10T9A73Izd5k0ywKLYndHxEdyjhsQQB?=
 =?us-ascii?Q?ku1f3aMGi5Fk1SYnovEujq8Wy4baZAXWF1WQzsTRGflzcX5smUmcdmdYHIp9?=
 =?us-ascii?Q?GpTZmktUYaItXd1FQfEHfYveKgGfq0bcsaHPXzUncx+o6k8o4JjUfgDqh/Mf?=
 =?us-ascii?Q?IvszNGbgyIN7ePJ5lGt38Y6vOoeZEyXj2hhDgYbDGWsZ6zFsQp9NuXQgFt+i?=
 =?us-ascii?Q?Z8L2j34/ICcLgNuZaPZ+yU7C2RDPZmMW1ptOP5+jcDSTxPhxnicBxdVN57Oi?=
 =?us-ascii?Q?3mjyOIzA55luQw5r09kkVXNs9nHprEdAQVtpo2vH5kx3Rp3X9H4vjDFUQ0pD?=
 =?us-ascii?Q?ooSj9kR7FPgxpIPfLAhSB3R1/7bymvXRBZPmdttz2WgIZFmcxgSn1gdkXhZR?=
 =?us-ascii?Q?NDj1eT8Fm/zgF9CF9gIarrwakg3U0FduedhRCY96ROfxbXL3sY5PWZy3uK+9?=
 =?us-ascii?Q?Ob8mbNIPO+Jd61nHSAs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:19:16.5492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e882d3e9-f010-4111-ed31-08de4dcdd4c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890

From: Gal Pressman <gal@nvidia.com>

The hardware supports segmentation offload of GRE tunnel over vlan,
allow it by adding it to vlan_features.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 07fc4d2c8fad..1734c4dd1d0f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5800,6 +5800,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 					   NETIF_F_GSO_GRE_CSUM;
 		netdev->gso_partial_features |= NETIF_F_GSO_GRE |
 						NETIF_F_GSO_GRE_CSUM;
+		netdev->vlan_features |= NETIF_F_GSO_GRE | NETIF_F_GSO_GRE_CSUM;
 	}
 
 	if (mlx5e_tunnel_proto_supported_tx(mdev, IPPROTO_IPIP)) {
-- 
2.34.1


