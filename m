Return-Path: <linux-rdma+bounces-7742-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EC9A34CDC
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 19:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBB03ACAD5
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB77245B08;
	Thu, 13 Feb 2025 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SfaDrOq5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F41245AFC;
	Thu, 13 Feb 2025 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469770; cv=fail; b=Y5x//xW8bVIY6lq7YwRoHW25RbiMOpfsXKIPcBkMK8GUVX+/PSWEwf12L+QqllpXWS0Z4v7S9xOIEDzdItCwh7H606Iaybcea47gPerQSVkwfyaAwiuCJzyDiF2qbOAJfS145b8WLpM/v5c+Hd/LOPVOP+8tKoxqIUatVt6ng68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469770; c=relaxed/simple;
	bh=ZAEXr7Q02KhvbZHJww5YwcM8wlx7LK8+URSVVKgLi14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhCLOtZH2CL0L3VvrGMLRj+s6ViGYd+iQbMFahw5RKveZqSoPY2dd1m5VgH5Fj+bv0NmTkMcvnmMROIQNOm/aqapIYKZFS5VJxFF0PT8Fhlqw6MzAsfQoKS9sMBBog2exubAUCXPA2ueyAkr3gveiAMbcdRZQDHsuYwWaqLGnkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SfaDrOq5; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7M0+LDsw+A57p19z2suWTCVZj+nOqeAwIU209JPR/UJy3MPHTRf1158DtRK1NmmjDM2Pq+g3mjl5RCcc//eQbJMwyHCIDUXpKaRovnNNsAzzvU71dTto0JziCeBjLpWMMdwUxmsM9lx3skwJUEFW2lh8pUXENLuIUxjjMIoKKjNICaW3T6JHFSQ+wJ7Pni9UHgC94BZ97dMn/GOrQ9T1GmbWPo5huHm/+t5VsnQ7Cqj0eJfzy9bPQ6o7r8XD5eYXcLJQfU8//n80V4IUg857WJYmghljTN4X4fvXxLofx+uPVQMuVO64O9fbnWMFutEG6i8TGa3secuE0z8f7hpyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEZgWR79MgK/zlaY0b6+/Oeb2ucjqGyLh99aXrGuKks=;
 b=I/paAw0C3jDjxJMhCfBARgcbGP+zw2bLDqPR5JV3Hgjq+uw1EDYGBZ4vMF6eVgft/pFJZIO3SNgkK2MFnne4gzmd+HchalULK6h5EbrtOVCEJFqiGO5aGYAEUKBJbADjDqVCzawkDRgKp7w0IBtESu79+bpRrFFj5zwREvmAsvcGDb4NueKK3pY68dlIJlFasZz10LSuPTEb0aL4VnjNuHEKJlg0C/M2UtlUUdEtJUoyX48R/NeGXW3lXkxKm+BJUKfWEn1qDGsPDbQJvxFvXjuAo76rGKO97Hlp3T9NCAv/dNE7iAl3lIgvXBwnFLPADjW6NnJmEB/UsFc8IQ2o1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEZgWR79MgK/zlaY0b6+/Oeb2ucjqGyLh99aXrGuKks=;
 b=SfaDrOq5KG/nthG5Jl11+80OEjY56wH8C2q1hGuhzjIXqqwipINUfcQGFCI/MLnAByQMXiniapIedDcTDB5Tgi1jG1v6xmkvuMKXE4Nt4+7Ek1MFuDBPaWshACR9+QE1g4poLVTQhqcXQN68VM2lpWAxUlFFgHh7GN1LXA7srZ2VbBL8xhb9zXIy++JeAEw8XTp4iW9TWm87yUbZXvsZP/Cyq2RSLS6MHiCC4HBiNDhEXPEREtYBUl8ET5LLj9bVHkkAfkEkhDuRn49Pl78bejTCKWA8Aop7NjNmvy3DYpMami7yxkSiq4FR+nKNMnMury9SU3uBDc7Ho8zwJZOMBA==
Received: from CH0PR03CA0078.namprd03.prod.outlook.com (2603:10b6:610:cc::23)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 18:02:41 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::90) by CH0PR03CA0078.outlook.office365.com
 (2603:10b6:610:cc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 18:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 18:02:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 10:02:17 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 10:02:16 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 13
 Feb 2025 10:02:12 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Jiri Pirko <jiri@nvidia.com>
CC: Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Donald Hunter
	<donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
	<corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [PATCH net-next 02/10] devlink: Store devlink rates in a rate domain
Date: Thu, 13 Feb 2025 20:01:26 +0200
Message-ID: <20250213180134.323929-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250213180134.323929-1-tariqt@nvidia.com>
References: <20250213180134.323929-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df51301-e64b-4721-fc7a-08dd4c589c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LgBza8nuZrkCLXuwGkTvxvKHF5KvGcnOe0TRVv9xCYQiJsBp4oT3xs92NOv7?=
 =?us-ascii?Q?YuWfNVxfpIdT2W9Tno3milXGKOB4gugaCJoeTYa4eQNeBrVOt9eev3kP/0JZ?=
 =?us-ascii?Q?K5ALcA70IDq0BqAocPpmH8Rv3O3ZbKLCZ6XzPC1e8h9RxLlS/TevMlchX2KB?=
 =?us-ascii?Q?7ebv5z4SeEr/dK14ouO/s20w1Qz88vcOlBUPTzvjGfwrgmBIpmSxt9OnKOse?=
 =?us-ascii?Q?gtckRTeRyJyzHgW8oVkK41ceyEWWty/UFzjFxezCXXqnJy9NsvHNrCW8wBtg?=
 =?us-ascii?Q?Kvcek6IdmMhiQDANjbsrm4o4kCsG7YtsVGFguHThFfDTPAPwPToA2yXzpRQS?=
 =?us-ascii?Q?b1eP4hqpjaCOHd4MMfyBSqi/PEFXn0KzkwDIKXOGLggJYnKY5cuTz/JCt7Tv?=
 =?us-ascii?Q?U2+JunwJ33eMUnNJR+2/m7FsTnvNOUA0+kAUYBSD7pbL7RdeWAryYgQWR05Z?=
 =?us-ascii?Q?OhSm1P+EnezoAB1bXZkkDlc/1Mj8dXJjIuVc9upjw6IZvLUicCpNe+U/+zAX?=
 =?us-ascii?Q?EwHFxCnqnSbAOYK7YbUnQu1gBTIICcCOV6xpif1GxFbAsHp0FRTviRrIshBK?=
 =?us-ascii?Q?aHjxsnpgPzlgRycibyNZyNnhOg8QTl545E9kiF6GLnMmOoXS+dYXaGBYNj2b?=
 =?us-ascii?Q?icu/6JyZfOhOGVgNYgF/G02QRlVwoyLSgGG/CRxcJXGjiYtCvEF6j+8CPrad?=
 =?us-ascii?Q?o1zoH3RQpMAkrE3E7QsRJ/4fglQkGzHUq/CKB6coDdUrQy21ZpBWILaaDOth?=
 =?us-ascii?Q?dGvmD4yBrSARiB5o+8F9Gxxbjnz8uohX7m08qVMOV/A75sDiZQEGaRzpcyp+?=
 =?us-ascii?Q?S6UQTvxoGeBf4Y/fRd3HhUXuyMxL92IQU4pyGhPbFLC2lOwexQMh7fABhvri?=
 =?us-ascii?Q?OpXmigiI6SH7/jjQLzNMOCVWs3B1msnS0YRXFiYu/KLw2dpgjDlBC6E20EvT?=
 =?us-ascii?Q?HSmWYbRjaI95zxsPky8BaJ4i4H3HfSsZ50996/gXowFyZl5alfUI+9341ZCp?=
 =?us-ascii?Q?pJu/D/HyjM2s5FqLwFT3AXF5cokMbKN7J6YQQQnQtdCbC9zJNrNCZ4kFK15t?=
 =?us-ascii?Q?uNMrEDT5aWKDT6tVVYbAIJZ/TjGSuLihj0ZZckSjftEeR85GW+Xa8kc19p+s?=
 =?us-ascii?Q?LC9aICh1qk3uRA2cUQVeRq3X7uUHXijstxe9exmeC24hO1SaF4l+dKEylDGr?=
 =?us-ascii?Q?8RaHwSDhi7fjLsByZ3dk5wLmtj85c+XO03OSu9+vmyOyyAoJkRXll599ZJwA?=
 =?us-ascii?Q?s4f86dQDcRxmMqtBY/983KmLfW0pLnaO8+qAVWkrAopQMWUqq0hzyi6SkXnP?=
 =?us-ascii?Q?jvOExsUI6CxwSpp/pGpfeDDDmRCVFW1WAr7eWV/EEqcJ3yvc/OsoCydwRKA3?=
 =?us-ascii?Q?9qWSvjbd+8bkZ5HUXDsk9xYMoEnQJnTM/CMvAb5WR26WyKQ8xvV1S4GB3tk1?=
 =?us-ascii?Q?QOr9VgDgKKiW3yioAQRsjr/bhqQ7pHAxOYXP6yv5NGIL5JV7DajF7SS6Ou+Q?=
 =?us-ascii?Q?fGOuGYGWz9nsuGg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:02:41.3518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df51301-e64b-4721-fc7a-08dd4c589c07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019

From: Cosmin Ratiu <cratiu@nvidia.com>

Introduce the concept of a rate domain, a data structure aiming to store
devlink rates of one or more devlink objects such that rate nodes within
a rate domain can be parents of other rate nodes from the same domain.
This commit takes the first steps in that direction by:
- introducing a new 'devlink_rate_domain' data structure, allocated on
  devlink init.
- storing devlink rates from the devlink object into the rate domain.
- converting all accesses to the new data structure.
- adding checks for everything that walks rates in a rate domain so that
  the correct devlink object is looked at. These checks are now spurious
  since all rate domains are private to their devlink object, but that
  is about to change and this is a good moment to add those checks.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/core.c          | 11 ++++++++--
 net/devlink/dev.c           |  2 +-
 net/devlink/devl_internal.h |  7 ++++++-
 net/devlink/rate.c          | 41 ++++++++++++++++++++++---------------
 4 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index f49cd83f1955..06a2e2dce558 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -314,6 +314,7 @@ static void devlink_release(struct work_struct *work)
 	mutex_destroy(&devlink->lock);
 	lockdep_unregister_key(&devlink->lock_key);
 	put_device(devlink->dev);
+	kvfree(devlink->rate_domain);
 	kvfree(devlink);
 }
 
@@ -424,6 +425,11 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	if (!devlink)
 		return NULL;
 
+	devlink->rate_domain = kvzalloc(sizeof(*devlink->rate_domain), GFP_KERNEL);
+	if (!devlink->rate_domain)
+		goto err_rate_domain;
+	INIT_LIST_HEAD(&devlink->rate_domain->rate_list);
+
 	ret = xa_alloc_cyclic(&devlinks, &devlink->index, devlink, xa_limit_31b,
 			      &last_id, GFP_KERNEL);
 	if (ret < 0)
@@ -436,7 +442,6 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	xa_init_flags(&devlink->snapshot_ids, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->nested_rels, XA_FLAGS_ALLOC);
 	write_pnet(&devlink->_net, net);
-	INIT_LIST_HEAD(&devlink->rate_list);
 	INIT_LIST_HEAD(&devlink->linecard_list);
 	INIT_LIST_HEAD(&devlink->sb_list);
 	INIT_LIST_HEAD_RCU(&devlink->dpipe_table_list);
@@ -455,6 +460,8 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	return devlink;
 
 err_xa_alloc:
+	kvfree(devlink->rate_domain);
+err_rate_domain:
 	kvfree(devlink);
 	return NULL;
 }
@@ -477,7 +484,7 @@ void devlink_free(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->resource_list));
 	WARN_ON(!list_empty(&devlink->dpipe_table_list));
 	WARN_ON(!list_empty(&devlink->sb_list));
-	WARN_ON(!list_empty(&devlink->rate_list));
+	WARN_ON(!list_empty(&devlink->rate_domain->rate_list));
 	WARN_ON(!list_empty(&devlink->linecard_list));
 	WARN_ON(!xa_empty(&devlink->ports));
 
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 5ff5d9055a8d..c926c75cc10d 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -434,7 +434,7 @@ static void devlink_reload_reinit_sanity_check(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->trap_list));
 	WARN_ON(!list_empty(&devlink->dpipe_table_list));
 	WARN_ON(!list_empty(&devlink->sb_list));
-	WARN_ON(!list_empty(&devlink->rate_list));
+	WARN_ON(!list_empty(&devlink->rate_domain->rate_list));
 	WARN_ON(!list_empty(&devlink->linecard_list));
 	WARN_ON(!xa_empty(&devlink->ports));
 }
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 9cc7a5f4a19f..209b4a4c7070 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -30,10 +30,14 @@ struct devlink_dev_stats {
 	u32 remote_reload_stats[DEVLINK_RELOAD_STATS_ARRAY_SIZE];
 };
 
+/* Stores devlink rates associated with a rate domain. */
+struct devlink_rate_domain {
+	struct list_head rate_list;
+};
+
 struct devlink {
 	u32 index;
 	struct xarray ports;
-	struct list_head rate_list;
 	struct list_head sb_list;
 	struct list_head dpipe_table_list;
 	struct list_head resource_list;
@@ -55,6 +59,7 @@ struct devlink {
 	 */
 	struct mutex lock;
 	struct lock_class_key lock_key;
+	struct devlink_rate_domain *rate_domain;
 	u8 reload_failed:1;
 	refcount_t refcount;
 	struct rcu_work rwork;
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index d163c61cdd98..535863bb0c17 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -36,8 +36,9 @@ devlink_rate_node_get_by_name(struct devlink *devlink, const char *node_name)
 {
 	static struct devlink_rate *devlink_rate;
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
-		if (devlink_rate_is_node(devlink_rate) &&
+	list_for_each_entry(devlink_rate, &devlink->rate_domain->rate_list, list) {
+		if (devlink_rate->devlink == devlink &&
+		    devlink_rate_is_node(devlink_rate) &&
 		    !strcmp(node_name, devlink_rate->name))
 			return devlink_rate;
 	}
@@ -166,16 +167,18 @@ void devlink_rates_notify_register(struct devlink *devlink)
 {
 	struct devlink_rate *rate_node;
 
-	list_for_each_entry(rate_node, &devlink->rate_list, list)
-		devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	list_for_each_entry(rate_node, &devlink->rate_domain->rate_list, list)
+		if (rate_node->devlink == devlink)
+			devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
 }
 
 void devlink_rates_notify_unregister(struct devlink *devlink)
 {
 	struct devlink_rate *rate_node;
 
-	list_for_each_entry_reverse(rate_node, &devlink->rate_list, list)
-		devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
+	list_for_each_entry_reverse(rate_node, &devlink->rate_domain->rate_list, list)
+		if (rate_node->devlink == devlink)
+			devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
 }
 
 static int
@@ -187,7 +190,7 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 	int idx = 0;
 	int err = 0;
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
+	list_for_each_entry(devlink_rate, &devlink->rate_domain->rate_list, list) {
 		enum devlink_command cmd = DEVLINK_CMD_RATE_NEW;
 		u32 id = NETLINK_CB(cb->skb).portid;
 
@@ -195,6 +198,9 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 			idx++;
 			continue;
 		}
+		if (devlink_rate->devlink != devlink)
+			continue;
+
 		err = devlink_nl_rate_fill(msg, devlink_rate, cmd, id,
 					   cb->nlh->nlmsg_seq, flags, NULL);
 		if (err) {
@@ -522,7 +528,7 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_rate_set;
 
 	refcount_set(&rate_node->refcnt, 1);
-	list_add(&rate_node->list, &devlink->rate_list);
+	list_add(&rate_node->list, &devlink->rate_domain->rate_list);
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
 	return 0;
 
@@ -565,8 +571,9 @@ int devlink_rate_nodes_check(struct devlink *devlink, struct netlink_ext_ack *ex
 {
 	struct devlink_rate *devlink_rate;
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list)
-		if (devlink_rate_is_node(devlink_rate)) {
+	list_for_each_entry(devlink_rate, &devlink->rate_domain->rate_list, list)
+		if (devlink_rate->devlink == devlink &&
+		    devlink_rate_is_node(devlink_rate)) {
 			NL_SET_ERR_MSG(extack, "Rate node(s) exists.");
 			return -EBUSY;
 		}
@@ -612,7 +619,7 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 	}
 
 	refcount_set(&rate_node->refcnt, 1);
-	list_add(&rate_node->list, &devlink->rate_list);
+	list_add(&rate_node->list, &devlink->rate_domain->rate_list);
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
 	return rate_node;
 }
@@ -650,7 +657,7 @@ int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
 	devlink_rate->devlink = devlink;
 	devlink_rate->devlink_port = devlink_port;
 	devlink_rate->priv = priv;
-	list_add_tail(&devlink_rate->list, &devlink->rate_list);
+	list_add_tail(&devlink_rate->list, &devlink->rate_domain->rate_list);
 	devlink_port->devlink_rate = devlink_rate;
 	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
 
@@ -691,13 +698,13 @@ EXPORT_SYMBOL_GPL(devl_rate_leaf_destroy);
  */
 void devl_rate_nodes_destroy(struct devlink *devlink)
 {
-	static struct devlink_rate *devlink_rate, *tmp;
+	struct devlink_rate *devlink_rate, *tmp;
 	const struct devlink_ops *ops = devlink->ops;
 
 	devl_assert_locked(devlink);
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
-		if (!devlink_rate->parent)
+	list_for_each_entry(devlink_rate, &devlink->rate_domain->rate_list, list) {
+		if (!devlink_rate->parent || devlink_rate->devlink != devlink)
 			continue;
 
 		refcount_dec(&devlink_rate->parent->refcnt);
@@ -708,8 +715,8 @@ void devl_rate_nodes_destroy(struct devlink *devlink)
 			ops->rate_node_parent_set(devlink_rate, NULL, devlink_rate->priv,
 						  NULL, NULL);
 	}
-	list_for_each_entry_safe(devlink_rate, tmp, &devlink->rate_list, list) {
-		if (devlink_rate_is_node(devlink_rate)) {
+	list_for_each_entry_safe(devlink_rate, tmp, &devlink->rate_domain->rate_list, list) {
+		if (devlink_rate->devlink == devlink && devlink_rate_is_node(devlink_rate)) {
 			ops->rate_node_del(devlink_rate, devlink_rate->priv, NULL);
 			list_del(&devlink_rate->list);
 			kfree(devlink_rate->name);
-- 
2.45.0


