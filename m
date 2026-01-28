Return-Path: <linux-rdma+bounces-16146-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLtFAFv0eWnT1AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16146-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:34:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2FEA080C
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B4DC3003377
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E56D3542F7;
	Wed, 28 Jan 2026 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T75ZEAPW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013051.outbound.protection.outlook.com [40.93.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036793542EA;
	Wed, 28 Jan 2026 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599740; cv=fail; b=otbenjIjhaqFgMiRhBGUtJap0YscRgihBNxnAe31ZRvqXMDDS1M582Nl9uHmmkuq7fGdFruck/vMPP9/p8XxSiU3T6XfmoJjxjc3DGf+gGNT1Ws1ZHf75X4Phttplj4sa6dVsAmfgEvt9NJFn+jbL00Cq5LViTV+YreQu16276k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599740; c=relaxed/simple;
	bh=fvD7xDuu7auUJXUITzkkcmgOyewcAPtPGeigJWFv2yc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bM8ge21EeUn+HLXXbnkT6hnE4J+pkuikfRqBZVE9ThBxmA2/dPMdQ8UBeYUpqmOig1YI7U+hUH+tb9sZnFrppSvga8GmCvgyoz6Z3mKwvsdG86eosnrJ6wUvS8mfWMXKwegGPuZJjr2q9MtLTnhwdXU7Duns07uBGv1XbHUKbyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T75ZEAPW; arc=fail smtp.client-ip=40.93.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTtyNVO5p9CRiqj+3LVDG8eEmsgO7QU84buUOQ06kLGwDEaFVe3J7sLEUP/NzYPAFS3gy5/YhVPXU2GacmJRBCaYyDXVh2u4n9FlPAleIteLDfIf5V7NRGdp5NrmHspytuRZo83EWO/zMlJkru/eu4NEN19uw/zUIyEPKkKneVs6wyvWcQH8II5qhVeSskW82VfSy2Lr06MbiQMZgdP49AYd+XO0XdWwVAh0wlgbbHRFlzt/O1wPHzb+w+tNdCYkjTO+D/F0D9cD1OH5z0Yc7WzrflakK2/tzd7ktAyle5bhvTDNadHJnPrOYNHhpaFwj4+qZEaRfemnXA0wDEpBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwgwDv0rBR4dsZKTftvK9Mj0+5SpWmJkLLfaVYtwvhc=;
 b=f1p51heTjeP1IcxSBU3PdQ5FZ/fpktslInRGSwUstRsnZ8FE/Ag81nlLRzBnEKZW1oXN0NQfdv765olwSPjXEcTC4KFtbO0OqPeq3vmb+qsPxlVInNNjwtaP07YUHP4wOUEwMAEmSnRrUBgqwTOQuynNPK9NLh6WnkkaG+XmZF/ODG2NekhGZqh4LLBndMMghwTNL/Ei+R/aciAv/pjZQWe8sLwEPXF32isBMxY8KeqilZz5DNiGzuZa2ZFuKOYPqCriPrgXhlXOaKh0/YiEhUzniuVLS8nRBhbIF5Jqn/uOtSXPb1Jt8pOluUyezWLk+UE0iDER5MHMshpr+9OkwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwgwDv0rBR4dsZKTftvK9Mj0+5SpWmJkLLfaVYtwvhc=;
 b=T75ZEAPWqMn6I7NV5OsBEE1dWy3B+YlTqEsvEz27E+DMcLvNKxXqxaCNihIwMfYhX22q5KzmAlHCh7VTPxFFxGSh77s4j9ncDb6xRNO94mhk3YuyI8/0SV2gBTSCgCQPyHfj4VDIYO/6pavPnKTj9hX3b8G0mxhw/6oPXJg8wlp1hRfdqUdphPuUqhNlU6+sHAaAv+qYLOkgSwh0bm87sNHHjPPCLMSwoVItNuCoA5+vWJ7zt/8rxBj85gBdIhZkqngeMxvq/CTPDfLVmJshLb9v442hCXVPhtozkDHGMF+SBq8v5dH1pjDKXjHWuq2wgakkfs2UbHtrqMyLVlq3wg==
Received: from SA0PR11CA0032.namprd11.prod.outlook.com (2603:10b6:806:d0::7)
 by SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 11:28:48 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::9c) by SA0PR11CA0032.outlook.office365.com
 (2603:10b6:806:d0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Wed,
 28 Jan 2026 11:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 11:28:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:28:37 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:28:36 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 28
 Jan 2026 03:28:31 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH net-next V7 12/14] net/mlx5: Store QoS sched nodes in the sh_devlink
Date: Wed, 28 Jan 2026 13:25:42 +0200
Message-ID: <20260128112544.1661250-13-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260128112544.1661250-1-tariqt@nvidia.com>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|SA0PR12MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: 958c5ee8-59a7-4bb5-19f3-08de5e6067f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kzjIef0c+LHKoLuHpXAeYKZpGh9vX17PmR1WkWvkXH/lgy9GFjh2DXUeRgTO?=
 =?us-ascii?Q?0WjgHg/t9MXRcoE1VKqbGARYzlWPASLeFqMA/xttEwlUU+Pk3AoNRsdkqUtN?=
 =?us-ascii?Q?ImCYUdF1Y9T4EFPJg0HxF6Hez/Rjuc60838KsUe6L8jeqAHVL/cboKTypZzQ?=
 =?us-ascii?Q?oiaVFhAaql19CaqZ0NnDZxwuyqyVn0I0KX8U94CZVozWZUt2k2KAoRSJYyqb?=
 =?us-ascii?Q?ufPEa76gAS/v9Egat2+tUNJyqPIB1N6KIq3ZY9QXH30P0Sk+LmXNJkGsoHVr?=
 =?us-ascii?Q?nb0FvNrvc7GDgyLI/E7iu7jmOXWy3YqJqjiVTb/9Zx6viu57hJhy2qTMPWrk?=
 =?us-ascii?Q?448x5jW68hzuIkErN3j9jK4ca+BEjddJBWuvlaTEO6LgX8jax435jLRN+/oc?=
 =?us-ascii?Q?L0EYaJqIepD6wkCY4PfdR5DBPMFzzLj54cEtW+HzMqqSTluaGARgPPkjsuLn?=
 =?us-ascii?Q?nI/ekeFeUCwlsFHaXpicLmUhv461sgRXC+Zu0KdwW+USEopqPR8Yc1FH+NqS?=
 =?us-ascii?Q?mfiuuFCkLzekd0+RCWySvueH07G691DGbkhs2yLWOlymiYfVMxzJ+h4p2YkQ?=
 =?us-ascii?Q?E0Ot8R9zwKIeDlzib2dcZkasu+ZYKMLngV69nDqDNqocudUqjLww30zgY9Is?=
 =?us-ascii?Q?9U9JWDfAkEm4TzBfFIT1Z65o2wsIiFbuEvYhKUjo32L8afN3ZleReqhIlF4F?=
 =?us-ascii?Q?HkAuqouFf4yPLurzEaQgq16RM/mqUzQJ60+monf6aGVWT3WnMSdZUROozbT1?=
 =?us-ascii?Q?BmaY6ftlzPpdF3woOeJ+YasQzF9342uAOs1cVDPUKjCNkD4Noc11PO8zxl6S?=
 =?us-ascii?Q?TudR0raJUNWvZq9uGIg6Q773VRk+usAg1NuJ/7dawNohBiF7M4+Z0FJA/+nU?=
 =?us-ascii?Q?vYkX+KbpAzKIInJaZzH+dpm2physBPiKkjaWlYh+0p815AiBTgAtWNPSUpPu?=
 =?us-ascii?Q?R7VS1USJ0z1XH5+erWfzibqMc7GvLtaNIg/J3Sz9my0uUHoM4sPMmYVZUPjN?=
 =?us-ascii?Q?AbsnMauUcVj9R8N2Gxzv9hojbXUoa6HbRAqG/En0L1LAhYSNkMByFsRGZnRT?=
 =?us-ascii?Q?M1zu1zVMolGFO07qORt28nwauqv59aewmRPJBDbai5KoRCfKq6jmLKoCrl+Y?=
 =?us-ascii?Q?SEU9w/v8OMyB3Q6UnGR+UnQ+kbuQV5/HFGxC6D0LSVngIort91BpQLixtds8?=
 =?us-ascii?Q?tknqRWsct/Fb7bBFndckTtR7/iUGdlR/Aql9eIwBzavtF1cYrD4YR7O8tGO8?=
 =?us-ascii?Q?s8S8D1m6d+ScQcvOE48+xJ6/2ILetK51QqjHPm9XhfwUfH8AyivzjEkW76y4?=
 =?us-ascii?Q?DvVShMD+aSyab8RbBgH+y/KqiCNBiHxq+GixIK1HWWRtxjrce2R1X0jYLfAi?=
 =?us-ascii?Q?NMBTyXJV/S4bSZZN+C5zr7N1NHigSM7VUrDVv0RfxJejuVazCqMZgVQ8xySm?=
 =?us-ascii?Q?itp9A5g2LRdRBtdNJOmPDNkx35yDc5C8C+gjbYnSKA4THoE5Ogt2J2kgszl1?=
 =?us-ascii?Q?NNQYrPZzRtbAmxqYm2ZU0X6mfsouclRtevSV0cb1JyDlStpR0odJTE180nZj?=
 =?us-ascii?Q?nmc+wIhzc009HfOplwAr66lMlz08IUaAwbJzYB/P1ApDzZrBoo0plaRvu8KC?=
 =?us-ascii?Q?o8Dm6ZoesO+G/3Umli/mCfNf1IN+4AiOWQRX4OK/KM394kxco6Mm9I5X0rBS?=
 =?us-ascii?Q?/TzJpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:28:48.5953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 958c5ee8-59a7-4bb5-19f3-08de5e6067f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16146-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9A2FEA080C
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

In order to support cross-esw scheduling, the nodes for all devices need
to be accessible from the same place so that normalization can work.
Store them in the shared devlink instance and provide an accessor for
them.

Protecting against concurrent QoS modifications is now done with
the shd lock. Enable the supported_cross_device_rate_nodes devink ops
attribute so that all calls originating from devlink rate acquire the
shd lock. Only the additional entry points into QoS need to acquire the
shd lock.

Enabling supported_cross_device_rate_nodes now is safe, because
mlx5_esw_qos_vport_update_parent will reject cross-esw parent updates.
This will change in the next patch.

As part of this change, the E-Switch qos domain concept was removed.
E-Switch QoS domains were added with the intention of eventually
implementing shared qos domains to support cross-esw scheduling in the
previous approach ([1]), but they are no longer necessary in the new
approach.

[1] https://lore.kernel.org/netdev/20250213180134.323929-1-tariqt@nvidia.com/

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   1 +
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 201 +++++-------------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   3 -
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   9 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  11 +-
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  30 ++-
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  |   2 +
 7 files changed, 88 insertions(+), 169 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index ea77fbd98396..a040c81b10ce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -385,6 +385,7 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.rate_node_del = mlx5_esw_devlink_rate_node_del,
 	.rate_leaf_parent_set = mlx5_esw_devlink_rate_leaf_parent_set,
 	.rate_node_parent_set = mlx5_esw_devlink_rate_node_parent_set,
+	.supported_cross_device_rate_nodes = true,
 #endif
 #ifdef CONFIG_MLX5_SF_MANAGER
 	.port_new = mlx5_devlink_sf_port_new,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 8c3a026b8db4..0d187399d846 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -5,60 +5,16 @@
 #include "lib/mlx5.h"
 #include "esw/qos.h"
 #include "en/port.h"
+#include "sh_devlink.h"
 #define CREATE_TRACE_POINTS
 #include "diag/qos_tracepoint.h"
 
 /* Minimum supported BW share value by the HW is 1 Mbit/sec */
 #define MLX5_MIN_BW_SHARE 1
 
-/* Holds rate nodes associated with an E-Switch. */
-struct mlx5_qos_domain {
-	/* Serializes access to all qos changes in the qos domain. */
-	struct mutex lock;
-	/* List of all mlx5_esw_sched_nodes. */
-	struct list_head nodes;
-};
-
-static void esw_qos_lock(struct mlx5_eswitch *esw)
-{
-	mutex_lock(&esw->qos.domain->lock);
-}
-
-static void esw_qos_unlock(struct mlx5_eswitch *esw)
-{
-	mutex_unlock(&esw->qos.domain->lock);
-}
-
 static void esw_assert_qos_lock_held(struct mlx5_eswitch *esw)
 {
-	lockdep_assert_held(&esw->qos.domain->lock);
-}
-
-static struct mlx5_qos_domain *esw_qos_domain_alloc(void)
-{
-	struct mlx5_qos_domain *qos_domain;
-
-	qos_domain = kzalloc(sizeof(*qos_domain), GFP_KERNEL);
-	if (!qos_domain)
-		return NULL;
-
-	mutex_init(&qos_domain->lock);
-	INIT_LIST_HEAD(&qos_domain->nodes);
-
-	return qos_domain;
-}
-
-static int esw_qos_domain_init(struct mlx5_eswitch *esw)
-{
-	esw->qos.domain = esw_qos_domain_alloc();
-
-	return esw->qos.domain ? 0 : -ENOMEM;
-}
-
-static void esw_qos_domain_release(struct mlx5_eswitch *esw)
-{
-	kfree(esw->qos.domain);
-	esw->qos.domain = NULL;
+	devl_assert_locked(esw->dev->shd);
 }
 
 enum sched_node_type {
@@ -111,7 +67,8 @@ static void esw_qos_node_attach_to_parent(struct mlx5_esw_sched_node *node)
 	if (!node->parent) {
 		/* Root children are assigned a depth level of 2. */
 		node->level = 2;
-		list_add_tail(&node->entry, &node->esw->qos.domain->nodes);
+		list_add_tail(&node->entry,
+			      mlx5_shd_get_qos_nodes(node->esw->dev));
 	} else {
 		node->level = node->parent->level + 1;
 		list_add_tail(&node->entry, &node->parent->children);
@@ -324,14 +281,15 @@ static int esw_qos_create_rate_limit_element(struct mlx5_esw_sched_node *node,
 static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw,
 					      struct mlx5_esw_sched_node *parent)
 {
-	struct list_head *nodes = parent ? &parent->children : &esw->qos.domain->nodes;
 	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
 	struct mlx5_esw_sched_node *node;
+	struct list_head *nodes;
 	u32 max_guarantee = 0;
 
 	/* Find max min_rate across all nodes.
 	 * This will correspond to fw_max_bw_share in the final bw_share calculation.
 	 */
+	nodes = parent ? &parent->children : mlx5_shd_get_qos_nodes(esw->dev);
 	list_for_each_entry(node, nodes, entry) {
 		if (node->esw == esw && node->ix != esw->qos.root_tsar_ix &&
 		    node->min_rate > max_guarantee)
@@ -372,10 +330,11 @@ static void esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
 				       struct mlx5_esw_sched_node *parent,
 				       struct netlink_ext_ack *extack)
 {
-	struct list_head *nodes = parent ? &parent->children : &esw->qos.domain->nodes;
 	u32 divider = esw_qos_calculate_min_rate_divider(esw, parent);
 	struct mlx5_esw_sched_node *node;
+	struct list_head *nodes;
 
+	nodes = parent ? &parent->children : mlx5_shd_get_qos_nodes(esw->dev);
 	list_for_each_entry(node, nodes, entry) {
 		if (node->esw != esw || node->ix == esw->qos.root_tsar_ix)
 			continue;
@@ -715,7 +674,7 @@ __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sch
 		goto err_alloc_node;
 	}
 
-	list_add_tail(&node->entry, &esw->qos.domain->nodes);
+	list_add_tail(&node->entry, mlx5_shd_get_qos_nodes(esw->dev));
 	esw_qos_normalize_min_rate(esw, NULL, extack);
 	trace_mlx5_esw_node_qos_create(esw->dev, node, node->ix);
 
@@ -1108,7 +1067,8 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 		return -ENOMEM;
 	}
 	if (!parent)
-		list_add_tail(&sched_node->entry, &esw->qos.domain->nodes);
+		list_add_tail(&sched_node->entry,
+			      mlx5_shd_get_qos_nodes(esw->dev));
 
 	sched_node->max_rate = max_rate;
 	sched_node->min_rate = min_rate;
@@ -1143,7 +1103,7 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 	struct mlx5_esw_sched_node *parent;
 
 	lockdep_assert_held(&esw->state_lock);
-	esw_qos_lock(esw);
+	devl_lock(esw->dev->shd);
 	if (!vport->qos.sched_node)
 		goto unlock;
 
@@ -1152,7 +1112,7 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 
 	mlx5_esw_qos_vport_disable_locked(vport);
 unlock:
-	esw_qos_unlock(esw);
+	devl_unlock(esw->dev->shd);
 }
 
 static int mlx5_esw_qos_set_vport_max_rate(struct mlx5_vport *vport, u32 max_rate,
@@ -1191,26 +1151,25 @@ int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *vport, u32 max_rate, u32 min_
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err;
 
-	esw_qos_lock(esw);
+	devl_lock(esw->dev->shd);
 	err = mlx5_esw_qos_set_vport_min_rate(vport, min_rate, NULL);
 	if (!err)
 		err = mlx5_esw_qos_set_vport_max_rate(vport, max_rate, NULL);
-	esw_qos_unlock(esw);
+	devl_unlock(esw->dev->shd);
 	return err;
 }
 
 bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *min_rate)
 {
-	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	bool enabled;
 
-	esw_qos_lock(esw);
+	devl_lock(vport->dev->shd);
 	enabled = !!vport->qos.sched_node;
 	if (enabled) {
 		*max_rate = vport->qos.sched_node->max_rate;
 		*min_rate = vport->qos.sched_node->min_rate;
 	}
-	esw_qos_unlock(esw);
+	devl_unlock(vport->dev->shd);
 	return enabled;
 }
 
@@ -1576,9 +1535,9 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 			return err;
 	}
 
-	esw_qos_lock(esw);
+	devl_lock(esw->dev->shd);
 	err = mlx5_esw_qos_set_vport_max_rate(vport, rate_mbps, NULL);
-	esw_qos_unlock(esw);
+	devl_unlock(esw->dev->shd);
 
 	return err;
 }
@@ -1667,44 +1626,24 @@ static void esw_vport_qos_prune_empty(struct mlx5_vport *vport)
 	mlx5_esw_qos_vport_disable_locked(vport);
 }
 
-int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
-{
-	if (esw->qos.domain)
-		return 0;  /* Nothing to change. */
-
-	return esw_qos_domain_init(esw);
-}
-
-void mlx5_esw_qos_cleanup(struct mlx5_eswitch *esw)
-{
-	if (esw->qos.domain)
-		esw_qos_domain_release(esw);
-}
-
 /* Eswitch devlink rate API */
 
 int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack)
 {
 	struct mlx5_vport *vport = priv;
-	struct mlx5_eswitch *esw;
 	int err;
 
-	esw = vport->dev->priv.eswitch;
-	if (!mlx5_esw_allowed(esw))
+	if (!mlx5_esw_allowed(vport->dev->priv.eswitch))
 		return -EPERM;
 
 	err = esw_qos_devlink_rate_to_mbps(vport->dev, "tx_share", &tx_share, extack);
 	if (err)
 		return err;
 
-	esw_qos_lock(esw);
 	err = mlx5_esw_qos_set_vport_min_rate(vport, tx_share, extack);
-	if (err)
-		goto out;
-	esw_vport_qos_prune_empty(vport);
-out:
-	esw_qos_unlock(esw);
+	if (!err)
+		esw_vport_qos_prune_empty(vport);
 	return err;
 }
 
@@ -1712,24 +1651,18 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 					  u64 tx_max, struct netlink_ext_ack *extack)
 {
 	struct mlx5_vport *vport = priv;
-	struct mlx5_eswitch *esw;
 	int err;
 
-	esw = vport->dev->priv.eswitch;
-	if (!mlx5_esw_allowed(esw))
+	if (!mlx5_esw_allowed(vport->dev->priv.eswitch))
 		return -EPERM;
 
 	err = esw_qos_devlink_rate_to_mbps(vport->dev, "tx_max", &tx_max, extack);
 	if (err)
 		return err;
 
-	esw_qos_lock(esw);
 	err = mlx5_esw_qos_set_vport_max_rate(vport, tx_max, extack);
-	if (err)
-		goto out;
-	esw_vport_qos_prune_empty(vport);
-out:
-	esw_qos_unlock(esw);
+	if (!err)
+		esw_vport_qos_prune_empty(vport);
 	return err;
 }
 
@@ -1740,34 +1673,30 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
 {
 	struct mlx5_esw_sched_node *vport_node;
 	struct mlx5_vport *vport = priv;
-	struct mlx5_eswitch *esw;
 	bool disable;
 	int err = 0;
 
-	esw = vport->dev->priv.eswitch;
-	if (!mlx5_esw_allowed(esw))
+	if (!mlx5_esw_allowed(vport->dev->priv.eswitch))
 		return -EPERM;
 
 	disable = esw_qos_tc_bw_disabled(tc_bw);
-	esw_qos_lock(esw);
 
 	if (!esw_qos_vport_validate_unsupported_tc_bw(vport, tc_bw)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "E-Switch traffic classes number is not supported");
-		err = -EOPNOTSUPP;
-		goto unlock;
+		return -EOPNOTSUPP;
 	}
 
 	vport_node = vport->qos.sched_node;
 	if (disable && !vport_node)
-		goto unlock;
+		return 0;
 
 	if (disable) {
 		if (vport_node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
 			err = esw_qos_vport_update(vport, SCHED_NODE_TYPE_VPORT,
 						   vport_node->parent, extack);
 		esw_vport_qos_prune_empty(vport);
-		goto unlock;
+		return err;
 	}
 
 	if (!vport_node) {
@@ -1782,8 +1711,6 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
 	}
 	if (!err)
 		esw_qos_set_tc_arbiter_bw_shares(vport_node, tc_bw, extack);
-unlock:
-	esw_qos_unlock(esw);
 	return err;
 }
 
@@ -1793,28 +1720,22 @@ int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node,
 					 struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *node = priv;
-	struct mlx5_eswitch *esw = node->esw;
 	bool disable;
 	int err;
 
-	if (!esw_qos_validate_unsupported_tc_bw(esw, tc_bw)) {
+	if (!esw_qos_validate_unsupported_tc_bw(node->esw, tc_bw)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "E-Switch traffic classes number is not supported");
 		return -EOPNOTSUPP;
 	}
 
 	disable = esw_qos_tc_bw_disabled(tc_bw);
-	esw_qos_lock(esw);
-	if (disable) {
-		err = esw_qos_node_disable_tc_arbitration(node, extack);
-		goto unlock;
-	}
+	if (disable)
+		return esw_qos_node_disable_tc_arbitration(node, extack);
 
 	err = esw_qos_node_enable_tc_arbitration(node, extack);
 	if (!err)
 		esw_qos_set_tc_arbiter_bw_shares(node, tc_bw, extack);
-unlock:
-	esw_qos_unlock(esw);
 	return err;
 }
 
@@ -1822,17 +1743,14 @@ int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void
 					    u64 tx_share, struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *node = priv;
-	struct mlx5_eswitch *esw = node->esw;
 	int err;
 
-	err = esw_qos_devlink_rate_to_mbps(esw->dev, "tx_share", &tx_share, extack);
+	err = esw_qos_devlink_rate_to_mbps(node->esw->dev, "tx_share",
+					   &tx_share, extack);
 	if (err)
 		return err;
 
-	esw_qos_lock(esw);
-	err = esw_qos_set_node_min_rate(node, tx_share, extack);
-	esw_qos_unlock(esw);
-	return err;
+	return esw_qos_set_node_min_rate(node, tx_share, extack);
 }
 
 int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *priv,
@@ -1846,10 +1764,7 @@ int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *
 	if (err)
 		return err;
 
-	esw_qos_lock(esw);
-	err = esw_qos_sched_elem_config(node, tx_max, node->bw_share, extack);
-	esw_qos_unlock(esw);
-	return err;
+	return esw_qos_sched_elem_config(node, tx_max, node->bw_share, extack);
 }
 
 int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
@@ -1857,30 +1772,23 @@ int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
 {
 	struct mlx5_esw_sched_node *node;
 	struct mlx5_eswitch *esw;
-	int err = 0;
 
 	esw = mlx5_devlink_eswitch_get(rate_node->devlink);
 	if (IS_ERR(esw))
 		return PTR_ERR(esw);
 
-	esw_qos_lock(esw);
 	if (esw->mode != MLX5_ESWITCH_OFFLOADS) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Rate node creation supported only in switchdev mode");
-		err = -EOPNOTSUPP;
-		goto unlock;
+		return -EOPNOTSUPP;
 	}
 
 	node = esw_qos_create_vports_sched_node(esw, extack);
-	if (IS_ERR(node)) {
-		err = PTR_ERR(node);
-		goto unlock;
-	}
+	if (IS_ERR(node))
+		return PTR_ERR(node);
 
 	*priv = node;
-unlock:
-	esw_qos_unlock(esw);
-	return err;
+	return 0;
 }
 
 int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
@@ -1889,10 +1797,9 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	struct mlx5_esw_sched_node *node = priv;
 	struct mlx5_eswitch *esw = node->esw;
 
-	esw_qos_lock(esw);
 	__esw_qos_destroy_node(node, extack);
 	esw_qos_put(esw);
-	esw_qos_unlock(esw);
+
 	return 0;
 }
 
@@ -1909,7 +1816,6 @@ mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
 		return -EOPNOTSUPP;
 	}
 
-	esw_qos_lock(esw);
 	if (!vport->qos.sched_node && parent) {
 		enum sched_node_type type;
 
@@ -1920,13 +1826,15 @@ mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
 	} else if (vport->qos.sched_node) {
 		err = esw_qos_vport_update_parent(vport, parent, extack);
 	}
-	esw_qos_unlock(esw);
+
 	return err;
 }
 
 void mlx5_esw_qos_vport_clear_parent(struct mlx5_vport *vport)
 {
+	devl_lock(vport->dev->shd);
 	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
+	devl_unlock(vport->dev->shd);
 }
 
 int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
@@ -1939,13 +1847,8 @@ int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
 	int err;
 
 	err = mlx5_esw_qos_vport_update_parent(vport, node, extack);
-	if (!err) {
-		struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-
-		esw_qos_lock(esw);
+	if (!err)
 		esw_vport_qos_prune_empty(vport);
-		esw_qos_unlock(esw);
-	}
 
 	return err;
 }
@@ -2071,14 +1974,12 @@ static int mlx5_esw_qos_node_update_parent(struct mlx5_esw_sched_node *node,
 					   struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *curr_parent;
-	struct mlx5_eswitch *esw = node->esw;
 	int err;
 
 	err = mlx5_esw_qos_node_validate_set_parent(node, parent, extack);
 	if (err)
 		return err;
 
-	esw_qos_lock(esw);
 	curr_parent = node->parent;
 	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
 		err = esw_qos_tc_arbiter_node_update_parent(node, parent,
@@ -2088,15 +1989,11 @@ static int mlx5_esw_qos_node_update_parent(struct mlx5_esw_sched_node *node,
 	}
 
 	if (err)
-		goto out;
-
-	esw_qos_normalize_min_rate(esw, curr_parent, extack);
-	esw_qos_normalize_min_rate(esw, parent, extack);
-
-out:
-	esw_qos_unlock(esw);
+		return err;
 
-	return err;
+	esw_qos_normalize_min_rate(node->esw, curr_parent, extack);
+	esw_qos_normalize_min_rate(node->esw, parent, extack);
+	return 0;
 }
 
 int mlx5_esw_devlink_rate_node_parent_set(struct devlink_rate *devlink_rate,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index 0a50982b0e27..f275e850d2c9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -6,9 +6,6 @@
 
 #ifdef CONFIG_MLX5_ESWITCH
 
-int mlx5_esw_qos_init(struct mlx5_eswitch *esw);
-void mlx5_esw_qos_cleanup(struct mlx5_eswitch *esw);
-
 int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *evport, u32 max_rate, u32 min_rate);
 bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *min_rate);
 void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 4b7a1ce7f406..51eacc286cbb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -49,6 +49,7 @@
 #include "ecpf.h"
 #include "en/mod_hdr.h"
 #include "en_accel/ipsec.h"
+#include "sh_devlink.h"
 
 enum {
 	MLX5_ACTION_NONE = 0,
@@ -1618,10 +1619,6 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 	MLX5_NB_INIT(&esw->nb, eswitch_vport_event, NIC_VPORT_CHANGE);
 	mlx5_eq_notifier_register(esw->dev, &esw->nb);
 
-	err = mlx5_esw_qos_init(esw);
-	if (err)
-		goto err_esw_init;
-
 	if (esw->mode == MLX5_ESWITCH_LEGACY) {
 		err = esw_legacy_enable(esw);
 	} else {
@@ -2028,9 +2025,6 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 		goto reps_err;
 
 	esw->mode = MLX5_ESWITCH_LEGACY;
-	err = mlx5_esw_qos_init(esw);
-	if (err)
-		goto reps_err;
 
 	mutex_init(&esw->offloads.encap_tbl_lock);
 	hash_init(esw->offloads.encap_tbl);
@@ -2080,7 +2074,6 @@ void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
 
 	esw_info(esw->dev, "cleanup\n");
 
-	mlx5_esw_qos_cleanup(esw);
 	destroy_workqueue(esw->work_queue);
 	WARN_ON(refcount_read(&esw->qos.refcnt));
 	mutex_destroy(&esw->state_lock);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 20cf9dd542a1..d145591b3434 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -224,8 +224,9 @@ struct mlx5_vport {
 
 	struct mlx5_vport_info  info;
 
-	/* Protected with the E-Switch qos domain lock. The Vport QoS can
-	 * either be disabled (sched_node is NULL) or in one of three states:
+	/* Protected by mlx5_shd_lock().
+	 * The Vport QoS can either be disabled (sched_node is NULL) or in one
+	 * of three states:
 	 * 1. Regular QoS (sched_node is a vport node).
 	 * 2. TC QoS enabled on the vport (sched_node is a TC arbiter).
 	 * 3. TC QoS enabled on the vport's parent node
@@ -356,7 +357,6 @@ enum {
 };
 
 struct dentry;
-struct mlx5_qos_domain;
 
 struct mlx5_eswitch {
 	struct mlx5_core_dev    *dev;
@@ -383,12 +383,13 @@ struct mlx5_eswitch {
 	struct rw_semaphore mode_lock;
 	atomic64_t user_count;
 
-	/* Protected with the E-Switch qos domain lock. */
+	/* The QoS tree is stored in mlx5_shd.
+	 * QoS changes are serialized with mlx5_shd_lock().
+	 */
 	struct {
 		/* Initially 0, meaning no QoS users and QoS is disabled. */
 		refcount_t refcnt;
 		u32 root_tsar_ix;
-		struct mlx5_qos_domain *domain;
 	} qos;
 
 	struct mlx5_esw_bridge_offloads *br_offloads;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
index 202f4ae99fa9..22fd6e0e4b7a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -9,6 +9,16 @@
 static const struct devlink_ops mlx5_shd_ops = {
 };
 
+struct mlx5_shd_priv {
+	struct list_head qos_nodes;
+};
+
+static int mlx5_shd_priv_init(struct mlx5_shd_priv *shd_priv)
+{
+	INIT_LIST_HEAD(&shd_priv->qos_nodes);
+	return 0;
+}
+
 int mlx5_shd_init(struct mlx5_core_dev *dev)
 {
 	struct pci_dev *pdev = dev->pdev;
@@ -49,13 +59,20 @@ int mlx5_shd_init(struct mlx5_core_dev *dev)
 	*end = '\0';
 
 	/* Get or create shared devlink instance */
-	devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0);
+	devlink = devlink_shd_get(sn, &mlx5_shd_ops,
+				  sizeof(struct mlx5_shd_priv));
 	kfree(sn);
 	if (!devlink) {
 		err = -ENOMEM;
 		goto out;
 	}
 
+	err = mlx5_shd_priv_init(devlink_shd_get_priv(devlink));
+	if (err < 0) {
+		devlink_shd_put(devlink);
+		return err;
+	}
+
 	dev->shd = devlink;
 out:
 	kfree(vpd_data);
@@ -69,3 +86,14 @@ void mlx5_shd_uninit(struct mlx5_core_dev *dev)
 
 	devlink_shd_put(dev->shd);
 }
+
+struct list_head *mlx5_shd_get_qos_nodes(struct mlx5_core_dev *dev)
+{
+	struct mlx5_shd_priv *shd_priv;
+
+	if (!dev->shd)
+		return NULL;
+	devl_assert_locked(dev->shd);
+	shd_priv = devlink_shd_get_priv(dev->shd);
+	return &shd_priv->qos_nodes;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
index 8ab8d6940227..ec6a03471204 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
@@ -9,4 +9,6 @@
 int mlx5_shd_init(struct mlx5_core_dev *dev);
 void mlx5_shd_uninit(struct mlx5_core_dev *dev);
 
+struct list_head *mlx5_shd_get_qos_nodes(struct mlx5_core_dev *dev);
+
 #endif /* __MLX5_SH_DEVLINK_H__ */
-- 
2.44.0


