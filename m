Return-Path: <linux-rdma+bounces-16145-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APRZG171eWkE1QEAu9opvQ
	(envelope-from <linux-rdma+bounces-16145-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:39:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B267BA09E8
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A08733061B69
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043FC353EEC;
	Wed, 28 Jan 2026 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DbjyX5vw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3243434EF1E;
	Wed, 28 Jan 2026 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599728; cv=fail; b=FnQ8m/U9ZRMBD0+B3eQG0smWfZc/iNFbMU8kVDkyUwsCVq7DW3cV0ba/ECLlNTVR4fSMaLY+zft3XAYmeYdI9CXtDeyRhli2h730WwFeNvgKsT7cQWs6YNpuLvnc4u+IBix/32gM7fjE+eUM/1tQgHqNzhzWtoLDOBG5eXrR11o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599728; c=relaxed/simple;
	bh=ZiuPw4gxpJnm8Fp0BXF0/Uke9+Efb6aDVL1bFBDGfhE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVUNEOsorDDStByNQ7g03v94pGBehJhCXchQ6xQ2jwZtpy2JCEnDdmycTf/sADzWFTXozHkZnZzacPqHFO58QE9CX1b8fkQk2eDF08eC3zpi4uun0KmSyvAyfmlHSP5dO4Si800ZPudqWE007DlJB5JeM+nPswTSTvUqtkVOlpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DbjyX5vw; arc=fail smtp.client-ip=52.101.52.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhS3LwAwZb1Hi1dfWjW7sCGRQ4gd1pFhV1EvnHj/Lruek+mp/NkImr7AoU6/oJ/kusr15uJk+Ev8FOfmuySoC2tAZhuHsogCpNO2p8Zjspn6MwZgwwiSqzOuvTwl2Rdua+JO961N0KsRbEZG93CxGZ7d0doGOA93C0WorXRzj2NmAWuf3V1pp0bbFulEMclhGgtpWOzSqBDIRk7O2+2jfxQxYhX1aLEZq+OWEEywRlxlrP/HWYj9QOOTm8WkcpvM627NSCII7+eCPh/e3XDqu6dlGsSeErnUTfHybqEBCONDv+sqK9ieiK2Iix314FykqJrInIuCA5wxSyUzcujCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gbcaRZVuCbu+AI/JbON4SU/SCvsGg3RX98vpdOBgJk=;
 b=Nsh3sk7JhpG905+mhrOLMwPuj2imH/X2PdbUD9wJrrjBePB4nMd80T5xzfqVOzEvA/thkLQPIi/0Enp9F3Dy1WNjlQBrJsILQ3HSipPzWutKGZcc/sT5SNgxgLLWF/Z1LternlXKnZptKIopz58Pi+Z3Ya8o9uiJCq1U0Uwn7NA34hflPLV4A+s2iuddRVb573yXgugjGy3JX/4iXx5LJj8mO/aTvR5XAURx4idzH84GFuJU4pb8C2b/wGai9QNaGCmli5Nf5t7pST6EQiP3hYR6NizB/JcejTScucihnxPU9nuF6ORm03Jx5NL0/pvy83bGqPn9EVkXLFf5Dpv4xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gbcaRZVuCbu+AI/JbON4SU/SCvsGg3RX98vpdOBgJk=;
 b=DbjyX5vwnckVw5wiLCvWLV9ETHl6A4kfKxreJLKRvDUXv6kSezWk63N/QYLiP6PpwLiaSgTxzxjd/ilzaiCtmbnq42JdTLgNGSndqBSV2g8kl5LBsGHuYCLxYd34ph74huTEERz94A6a+AOwuczyvI1EOy6+2R/1rFp8Mzivz4QiIJ1HpQwDKnpY/3z1x1tdt1cHuRErmWfLDsf8YIE7yRec0xHFMp8RJHJGzgHNmijfufqfwWGzVNUy5jlpPAv3azXDKceq7hztq5+CNgoesTMzSKqYeclu5mxfQDjRKpv6Ti6LsFrXBC+m9URTus8SSu0ezI3+gNc5EFtO3RuKWw==
Received: from PH8PR07CA0019.namprd07.prod.outlook.com (2603:10b6:510:2cd::18)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.8; Wed, 28 Jan 2026 11:28:41 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::2e) by PH8PR07CA0019.outlook.office365.com
 (2603:10b6:510:2cd::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 11:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 11:28:40 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:28:31 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:28:30 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 28
 Jan 2026 03:28:25 -0800
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
Subject: [PATCH net-next V7 11/14] net/mlx5: Expose a function to clear a vport's parent
Date: Wed, 28 Jan 2026 13:25:41 +0200
Message-ID: <20260128112544.1661250-12-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: c0acb878-4c99-4ad6-508a-08de5e606334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rBlPqer4c/gDrQAognuN+F9ze1gA/7RJdKglLj49l078EIlBMUHZRIbC4wjj?=
 =?us-ascii?Q?5nGKvyyyXYwh5IpPf0N/yxs1D3Q7roo0/0iPuLXYYz36SCubXpcNJSBvCHU1?=
 =?us-ascii?Q?DnSt57RC0TpT0Nz8JDJBST9yWhXYBPReOLMx6qcuRuYamj/x29Jp2+pTDNwY?=
 =?us-ascii?Q?xjFPUjLym59dsSvLsXBtqaNJO5BLfPOFGeU4ifpm270+pqvTxfFi0Sv19AC8?=
 =?us-ascii?Q?v/bT91oSK8faGw/R7wCky3TgfLaQnKMDtq75CiDKrY5JDMaavdDcV5f37//N?=
 =?us-ascii?Q?/Gm0knbEzkHgKAAROIbevirOdtgQeKZDnA/Er13b5c4vcUH/KVakvF52K3qu?=
 =?us-ascii?Q?4ciSydlBPup6+HnVQxUgNy/SncIBshu0AbGXvbK2DZlX63s5756rxg4yzof4?=
 =?us-ascii?Q?R6yz6r9+aLzOyKbSpsSZQqzEJbT9xekR4mwlXwUsrNtxDcLYd/DaAA6SQTnE?=
 =?us-ascii?Q?VZsJ4wslVmcImlSsFFw66TmXZIc1o26MQJS1/8AHGrSSyyID5K1FT+D6EBAK?=
 =?us-ascii?Q?Yuin75D+I8aeT0XSOU8FHojWRReeCSpg3G+95So0T37y2hleqzddsBFoU0IL?=
 =?us-ascii?Q?zSLlBA/4mBQY08ImS0q6BzTe+pfUlZenOYLsAgOvoF45RBu16vNum8+5y3QW?=
 =?us-ascii?Q?tqgXOXM8EyUDyWOyP1wPQkMyZSUUehCobljjAGu4AK10RdP8etXLpM66RbBs?=
 =?us-ascii?Q?1J/H8b14+/DSf9xnSGG5AvEyZ7fbaVnDeFSv4/7LSMpxKOIATsloA+rK081P?=
 =?us-ascii?Q?879zJBjnIwMesKsTCIwy2woYu58QKqZGiZaUAXyBjXV3QtK2vU09VF/vzQ/q?=
 =?us-ascii?Q?uY9l181pRBRoA+U7tK7mTA1saK1lc8Mg5he/gnRRKaTuhpzIXyFhXU6XEZXO?=
 =?us-ascii?Q?u/6TxQAh0GYnIsg8f0XRbf9U3wvUXdFy6dJxlZH//IYK85Ahukz2f9wVuKhM?=
 =?us-ascii?Q?RkS88lSqa1HLwLVT90ih02jqfSGPOfQYPeyBKUIF49FAci71qkZyW7L1yVFF?=
 =?us-ascii?Q?p0cffskt284jdcNTp2BZwCmyB7i7oKVF+s0AFWe43GmakZYlSeyZu1vcH63B?=
 =?us-ascii?Q?4+gp922Doeaj1idSNtrPVtuyYTwsEXZuIk1idbmCEjh+i81ZJfPblLPbIHLb?=
 =?us-ascii?Q?5brjEfZq7zi8TwEqlO2cM9HNsZM/LelieReQ5jzSTQ0mQj+kICznOgTr836t?=
 =?us-ascii?Q?SKAnSh4W3t7YaCXmjwH6QTCDO9fesvio75u0778LgeSWPJayNhSYttRa3N+G?=
 =?us-ascii?Q?rOz+a8GlVn9Uz61CgP9ZBDpi0M9R6U3Ab1sFazFfzCsSIRwUBhio8mucurqd?=
 =?us-ascii?Q?oGMP2LJQpRFfVht2EAOjlgpRTIzRShdHYMRck9VJ2GTNik6BwrL35+iHSu0z?=
 =?us-ascii?Q?pb0I8rQh06dHLthQEDzKIk1vJbRChZkQo4UtzWRDyB6OC3ZrtxUyQV2eguMU?=
 =?us-ascii?Q?tfGZ68xjb3/ZIv1DUjPrW7D4g1vo7DuMLn1AjVSq3I9kOG/8Jh+oFl0LF+uD?=
 =?us-ascii?Q?Y2OWnRfxYwyMrfrL4k6p9EL6w5T5ftk9Cdk52KF9kD5tyeJoSfc9SbSHCGxt?=
 =?us-ascii?Q?EDQ0Q56LJH1wt7/Fn0Us9wi6/NI7bKTvjFkaL/j/vTdyyPCvES3ylTCBgCUG?=
 =?us-ascii?Q?uJVqAo51OFZfSY36151vieAP2XvZ6Qadwa16enYqi8QDJuyQMK9FI61FQ+5n?=
 =?us-ascii?Q?JG6HKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:28:40.6150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0acb878-4c99-4ad6-508a-08de5e606334
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16145-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B267BA09E8
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

Currently, clearing a vport's parent happens with a call that looks like
this:
	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);

Change that to something nicer that looks like this:
	mlx5_esw_qos_vport_clear_parent(vport);

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c     | 11 +++++++++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h     |  3 +--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 89a58dee50b3..31704ea9cdb4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -202,7 +202,7 @@ void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_vport *vport)
 		return;
 	dl_port = vport->dl_port;
 
-	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
+	mlx5_esw_qos_vport_clear_parent(vport);
 	devl_rate_leaf_destroy(&dl_port->dl_port);
 
 	devl_port_unregister(&dl_port->dl_port);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 4278bcb04c72..8c3a026b8db4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1896,8 +1896,10 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	return 0;
 }
 
-int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
-				     struct netlink_ext_ack *extack)
+static int
+mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
+				 struct mlx5_esw_sched_node *parent,
+				 struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err = 0;
@@ -1922,6 +1924,11 @@ int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_s
 	return err;
 }
 
+void mlx5_esw_qos_vport_clear_parent(struct mlx5_vport *vport)
+{
+	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
+}
+
 int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
 					  struct devlink_rate *parent,
 					  void *priv, void *parent_priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index ad1073f7b79f..20cf9dd542a1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -452,8 +452,7 @@ int mlx5_eswitch_set_vport_trust(struct mlx5_eswitch *esw,
 				 u16 vport_num, bool setting);
 int mlx5_eswitch_set_vport_rate(struct mlx5_eswitch *esw, u16 vport,
 				u32 max_rate, u32 min_rate);
-int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *node,
-				     struct netlink_ext_ack *extack);
+void mlx5_esw_qos_vport_clear_parent(struct mlx5_vport *vport);
 int mlx5_eswitch_set_vepa(struct mlx5_eswitch *esw, u8 setting);
 int mlx5_eswitch_get_vepa(struct mlx5_eswitch *esw, u8 *setting);
 int mlx5_eswitch_get_vport_config(struct mlx5_eswitch *esw,
-- 
2.44.0


