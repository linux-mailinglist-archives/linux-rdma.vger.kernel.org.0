Return-Path: <linux-rdma+bounces-12217-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D30B077DA
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 16:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DDF1C40A42
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 14:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BE525B31B;
	Wed, 16 Jul 2025 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mkqHYKEv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B0253B58;
	Wed, 16 Jul 2025 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675533; cv=fail; b=qVlkR1pmUUnG+6hTHDbIMrRfp5x4QowSGKZmZjGzKFDnaRe7k4P/76FTmJZq/d5BsdopabKoXgHilIWOvnpGBeQyhg0MJoHyEWUILgh4RLx3WSeyeH4fXkY5P5L7W/m/g2N7u1XNeTmBLh1ohumKM6zLcGDq8RmZifS84biAekU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675533; c=relaxed/simple;
	bh=Ncz1o/lYvfVEz0GcnxG8DS/GQytfC28eqx0QdGiCr6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHe3BC5S5NufYEM6kz46SGLFs+G7Zh93EJJYfgXkM8FvjT53eeoBzQGi/WTFaG4CRUf4mb9QBkhOpp7KXpFhSqgtm91JvZc+wgS41KIKqHNgQooKww34e6ETijCtTOggOf5f4cdELhNq981+cVDubstvjBzCtkTf6fdXh0DaYTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mkqHYKEv; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Acoyq2CaPKKMptPHd8CDcOzsIpbddexYgrWm8uJrhNRLzg7QJ2sKDdgyZ+n8v9rID7N7H77G9hEhrda0fap4W8Cj0BnzW0yyc3UWrPFeLfq81EVTZ8pEB6UX7yr2R1wYByHjwsWdeqNqLVR0sGnbw2Tp6pZ+kPjVXGdlCCFJSLwGP/uz7gEg13uVfgkRD0NWh0x3moS58Npf9AxRSXR5sO2xakbD9X74PhPPEMwzeZKmluIk8o+KU3uBiBPThcB94wk4LonCAXjrtSvHzmw3A+edxrpczTfI+xYRbXSOKam/97aQi+4MGVki2RBOGaW1e/3+qKwCB1R5KM1JSqUczQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ckif8WlyrLNq8TT48AqriK74smL745xtI2CxU6IX98=;
 b=JktYeMkl+/QTBZyxJr3SlkMHtlq4Fmn3+VK0Fz+aJ/Ry8pSF8kZY9dL1WmJwhYWT2Fpp0U8lyOSABEen5Rtxzb5OVSVSCtdHkEws+AVMZz/ZHvRCi2Z6n3NtERmHkZxoEG5nIs8SVkJiqzXR58u0Y+WBVwdNGsMGzO7PY8IHZpUGUyKHbmuYl8muoFsM3zewM6veaI7jW9jCrBvstUslJtrHqnWUKPMTU1METljVgSRY0AkRkXaeaDSjBxPBFgk1e8A5xdPeuWBYRBUOtDMaGY+18Jid6mal+pjwu8OJccdDxZw5/2N4+pHovkwNKS40N3kTu8SXL4cTBy3ZGx0rMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ckif8WlyrLNq8TT48AqriK74smL745xtI2CxU6IX98=;
 b=mkqHYKEvP5RfenL1NFl7P/dQU9X0NjnjqUlcFAFzxhtmZvQNBwgGrOjf9l2OWFhDHzgCAHnBlc9xH1a8qhRhiARWAjmTDez3sexy2rEC1uiN5pRXg/v66svKultbZEGNYmxFOapF5w4+mueIlnNZrjhFwv49ljxJy24L0eI8xDpeSEH1lRHif8MugBJjRscmqAh4MmaidJCfvcyHNdvreqt2GScJCA3i0U7y5YRl30mRwHYO2/LDCINR8BrMsjMK1VYhSop30JOtVf0ARYOtbsci87rD64UqziZmuH0+tJCKYedSlEdqrfDVl3CMnHuLCvhv02+cgeqapIXSKQKc5g==
Received: from SJ0PR03CA0257.namprd03.prod.outlook.com (2603:10b6:a03:3a0::22)
 by SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Wed, 16 Jul
 2025 14:18:46 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::d6) by SJ0PR03CA0257.outlook.office365.com
 (2603:10b6:a03:3a0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 14:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 14:18:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 07:18:32 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Jul 2025 07:18:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 16 Jul 2025 07:18:28 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next V2 3/6] net/mlx5e: Properly access RCU protected qdisc_sleeping variable
Date: Wed, 16 Jul 2025 17:17:49 +0300
Message-ID: <1752675472-201445-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752675472-201445-1-git-send-email-tariqt@nvidia.com>
References: <1752675472-201445-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SJ0PR12MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: 361304f3-5bca-4deb-84f7-08ddc473ad55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xFFpNS1724R1gZO13nmq2m2LpDydyymMlvyAfCW0SA2YGQudwDt46Ejisrbz?=
 =?us-ascii?Q?fB2HeOLvqG1hyxWK8Wqv7d9DCwTMkeXG0j9KvaIlZIbQse7KXSQfOXIy94Jb?=
 =?us-ascii?Q?MQ6jasO/bHv5GsiTERgcMTHLjEXiTGSR+NS7xeL1yzpAKR0KPlWi5DkWUWES?=
 =?us-ascii?Q?/OMBxTM/So7WFTmicp/w7e4Hg97oyVrk48S1qpuQpIPfhA/s245VWKkJyVkN?=
 =?us-ascii?Q?SM4ZnqtK7ivhnF1z/IcvNnTc9TJjWCvqqQB6MqGaBopMFqnqWMmDhNhqo487?=
 =?us-ascii?Q?1eCDV+emmTLM6t++GMXgWeRT9TjkKvX1mXDgU9/CN97GbMWTg3V3xrWOn7z3?=
 =?us-ascii?Q?xMIfKDjJXMuTIkGB3Oupzr1y1ziwSSJ4CI6S0RPIKC31kwBTvAMuObU4miok?=
 =?us-ascii?Q?MmhEc3+XkCup6Kn7KNELwvz9MNm3Pyg420BJPiMSy9lkE0aFcp42Ivq+1/Bl?=
 =?us-ascii?Q?3f+2n/vd31JtIz53tUwpNQyfqLDhi0SbZfajfNSdt53wolUq/NbGUJ5PJP6Q?=
 =?us-ascii?Q?s3r6V1OMKTesxZKXI+xqlTAcZTHCKoRthuCsCXr4cxDTHDj4tDBFjEC/prZp?=
 =?us-ascii?Q?rCdisb7L0mocr6p2GBK5E/obL/F6WCN36sV8IEb3DlU6v8r8gEPoy7ES0JZ8?=
 =?us-ascii?Q?Oi81nD/kMw2a3gR9CJg89INrNQAmuIhhcz9qOh08jrQpfyeR44tFYOtKos58?=
 =?us-ascii?Q?45JpMnUHCj4vC+zq07k8IWB8vfmEeCilBa+cZhNbIJ0R6wXNbsV8PTIDj62T?=
 =?us-ascii?Q?aoWUjNYD85HDjp+VOi0ZxpxXb6fiAQt/pQIkpyJrvMR5hOBMhqxFN5yyPXFL?=
 =?us-ascii?Q?sk7b1+tymMpPNXfMRm444NLlSvhAENFsDcQLUO4dJZCe5qt8zbNe1DZM7gbG?=
 =?us-ascii?Q?sRk8Pn+rn9oelZWLAeeWfPkNm1nnWxIRTFZyFoAaaUtVWm/i6K1oB+0HfMCq?=
 =?us-ascii?Q?B9r5HBfCbyLneSXyjwUYYo9l76cxFeyR4YWsHu/kC0xBZj+PT7Kc2bhAp9gz?=
 =?us-ascii?Q?ULZ6XCpVviPTAC+/4qOG9aVZNx4E2amMHFZK9Y9o93we3rf1WX6r5kdV+x5P?=
 =?us-ascii?Q?esps+0L3N1lxvPvWdqU7+CabgIPpBf3R2YICmcdQPpd2DJUhhbwVe2RSZb9y?=
 =?us-ascii?Q?52cMmgZbSzGsDi3yfLlP7X+BJO605WTIUsbCJtSpGMylth9wGwwfLCPbqiF9?=
 =?us-ascii?Q?P0SRsJCSxql8NNZqt883AkkzTnKlVNMppJZokJOVcIjFnR25qw8HlqnTVDdY?=
 =?us-ascii?Q?0NHQjJME0ABcINs4b3rd9KiJEJHYxLB82LNFxS9Q9nPIAd6JGjkfBqRubAIT?=
 =?us-ascii?Q?2n28ctbMLOVPmwCGg5JyjLXyyLAAxIje34wKgHcqn1AfxPU6MPx2S6ECQ31p?=
 =?us-ascii?Q?qrGgPI11qBFVGzbyfJj5wpWB/n7D9J3G1DW0lX0OfHvY/hhdc66N18sh+ZoD?=
 =?us-ascii?Q?/8Xe3ocryCcj+vDKbLCXPR+LUX1Ww1uVv/l3rG+bZMePjRkRLtYVWWWW7Czw?=
 =?us-ascii?Q?FcIfXp5C/na2IbeHjxa+njIhbs4AGmV2AiuK?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 14:18:46.3686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 361304f3-5bca-4deb-84f7-08ddc473ad55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709

From: Leon Romanovsky <leonro@nvidia.com>

qdisc_sleeping variable is declared as "struct Qdisc __rcu" and
as such needs proper annotation while accessing it.

Without rtnl_dereference(), the following error is generated by sparse:

drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:377:40: warning:
  incorrect type in initializer (different address spaces)
drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:377:40:    expected
  struct Qdisc *qdisc
drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:377:40:    got struct
  Qdisc [noderef] __rcu *qdisc_sleeping

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
index f0744a45db92..4e461cb03b83 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
@@ -374,7 +374,7 @@ void mlx5e_reactivate_qos_sq(struct mlx5e_priv *priv, u16 qid, struct netdev_que
 void mlx5e_reset_qdisc(struct net_device *dev, u16 qid)
 {
 	struct netdev_queue *dev_queue = netdev_get_tx_queue(dev, qid);
-	struct Qdisc *qdisc = dev_queue->qdisc_sleeping;
+	struct Qdisc *qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
 
 	if (!qdisc)
 		return;
-- 
2.31.1


