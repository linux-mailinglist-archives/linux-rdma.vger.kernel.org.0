Return-Path: <linux-rdma+bounces-14690-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7C3C7DCEE
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 08:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A483ABCD1
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 07:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F330E2BE625;
	Sun, 23 Nov 2025 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tLff/M2I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D47296BAA;
	Sun, 23 Nov 2025 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763882644; cv=fail; b=sfhJPlxilvp/ezoC+lm1kdDcra2hyWpmY9sBYHqU+EdK+Dmcy9+xeUk0gZ37ba/BeCdh9aXn/p8KVeWKJda+8W9dBmnCRT+FbpV8SjzCnjdO5RvI8qIpl5DQMuvrxLpSKixYyamw6qICjEh/MmBpQ5UkHSwNNxBSQdu0knkspmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763882644; c=relaxed/simple;
	bh=i4wia0sHLKDHhSKGvUEYQSrIb1YQHBSPHrimw1lpyaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3gemI8N5L41izQlbRgz0FSxwfonAfslvQtMi0wLAKOAxZHtQcDJpkocvTjSuNMu98qk+vneyLvZHLkT2HK7YOkyNdyTvRxlGpo9RGcTgzFSiuxPHvv2wcsl+6mo0xOpXEnOsjbOA8nB/SeAh7dT/r9M4gJMwP7pmcgD7FCI7QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tLff/M2I; arc=fail smtp.client-ip=52.101.53.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXu959jGKULQEREjcTHQ3RGbRtfxHtuUcCifNbaY9QzstccEo5vrlmYydRWcsmDc5bB6sdeJR8RFZFMR1wsaU4UKgekGB6LCYEnxLv3h9oruVUqQvItcnMjaQWLlU5fzk3LpP7zLvhXPGeT+5rd2U+LbBGEHkQWlHBKGt7v67UC1z+RNxsLKt4iY1Rb8DeNu1JrdsfJI1UW8S9CJUSo2XagY6+ML9I66BiW2kV4Cnw8vDVlJ66PPIBZQH5P9cvaRpbsLLnU8gzZcDPkTWcV+Ni32+mCbEb5ug/DWT8cYEcWJKfwULgfrYxreAWEO1oC9Eom/fp6nd+RYbiktI0SBCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtWrTV9+wo2tN7h17N/HD6NvbGEo5t0j7CYUEjUbLdY=;
 b=g6O6zOkYU5aogNIn1fGlantOaEbnEtd0DsZ9Lmik9xjEDp0B3SxzDs4AwGeLrsA7kZ7LSVir37I+gyfVVY5J2sIeFaJnxDxDVn/JOmUmke6ud7NMgF6/oyPkolWwuSKy/+o6pZRXSI5f6oB2YumjStZBeS2gOXdWtQvEO8n87bx735vKYT99Lgl+jUx3+y3Nrbn49uc+C/0eq1etKccO0tFLFQctbUOY6vkwZXLuLczN2YIICgsmtbPP7gOeRNcblTUaEAyXK31AcLbLBQj01r0126RD1CX9tQ7AJ+o00j2ZWNrPuFgtt8rg0vqXvwF8mdjz/tHcAkumDlenHIHs0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtWrTV9+wo2tN7h17N/HD6NvbGEo5t0j7CYUEjUbLdY=;
 b=tLff/M2IBkaC0o4xiiVzSTETWdSFF7ZBktixVbfIMHVeURFfZ7xSyCXhvGHu+rJmQjfHnT715DW2+rYA/0GspSMbMIOLVqz5EbKKKGgbuMSlmTZUrl5Uy90W/kv7fu+ao+ITxAoYGsMs4lSQYg3vf4YiadVuLLI0NFk/tmwdiwhWQeWaoDyJq3oR0N4j68p5qY7t5IrPWRxz5Dsrmu42yaP9dpdxk6nDEFWTi4Kyyndyt1fRsAbERobeVARRZq/NdxoEMzFY/4G08GImijPkRifPDJrMKQPA3EZd/jb6Qx73huoOfHz9EczGn0Eyi5bhp8iWfvhAGGTb9FuLeSjsNQ==
Received: from SA9PR13CA0049.namprd13.prod.outlook.com (2603:10b6:806:22::24)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sun, 23 Nov
 2025 07:23:51 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::d3) by SA9PR13CA0049.outlook.office365.com
 (2603:10b6:806:22::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.8 via Frontend Transport; Sun,
 23 Nov 2025 07:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 07:23:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:23:42 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:23:42 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 22
 Nov 2025 23:23:36 -0800
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
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V2 05/14] devlink: Decouple rate storage from associated devlink object
Date: Sun, 23 Nov 2025 09:22:51 +0200
Message-ID: <1763882580-1295213-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
References: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 8879d69e-1a82-4339-d5a3-08de2a61406b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OmQ0HSLEMtVXxl0Q2sU9gsPUOgOcYJpHS74TsRdzvo51ShAe2goFHwe3AJ4j?=
 =?us-ascii?Q?rC0VgQtYshBwdrM8SC7Er2GPuuaQPqz3Lu+EJtO/J9huqnnNB11tYuHY1NB6?=
 =?us-ascii?Q?gIQuFx0NqKVfQPEdCGgobxKonpY/yViQfJXwtfrn/KhV7Eywmz7zl0uupocq?=
 =?us-ascii?Q?c4dISB4V6t30BHFtMnNEIkzOWnwbAxtZ5vQ7hnNE+HllqGkMoI03wT8sUXtC?=
 =?us-ascii?Q?gdwYAlN4M/fBvP+eO3enkIaz9UK8GHjoWtdr9CTRnZjFOnffyvbBLejeHrFk?=
 =?us-ascii?Q?aAe6uvko6wo0UEAjGld++7jKeKFA+j1dDtVhIZDpTYm820n0PqQUTQkSWE3X?=
 =?us-ascii?Q?PkFNt2iT6dRtlWl38oDAY52U4P6L7qTpMIrx9CpaJZG/6IYiiZROTehZujrN?=
 =?us-ascii?Q?es+heCoDc+1be5Mxm7sAKyehOa/G+dI5onLp1LYVmDTPx35UiE8NIqXlhJJI?=
 =?us-ascii?Q?dyosli9DrOT2MCkuX1/nGyQtRFeUWKlh++c7Ga9IPC8yUjGjBnk83CSVgFk/?=
 =?us-ascii?Q?akCA9xTC771P//x3FttMZmU7XBX5MVSZ2Q3lxiaGpWQONfh2MaKBUGVtZw8l?=
 =?us-ascii?Q?FrZVaL9/TMRdvG8nt+n7gg7t8MRs5Ow86styISOlqUVU9qr5/1VMr05vLYJD?=
 =?us-ascii?Q?6ZJ0kuSUsPr/6m61qlvzct+aMkARVY6Tx2pHveYEAFYAOuWhr0864X//J/4h?=
 =?us-ascii?Q?ZHNQW0P0xCiYQzBc+/XT4ta9QnvVfWpDUf45tmAKFo4X9eNV13t1xpyAONSG?=
 =?us-ascii?Q?RqTyWL5Q5rMgQ0ldBjOwuBR2KzHMXIYsmdwhzwWnuogQVil5LQSpEDwREyIc?=
 =?us-ascii?Q?rdS0WWHVIifV+WQEwtqzu6W/EmeOddKjNJPb02nNbx/dIb3dnAL4RgutKbPF?=
 =?us-ascii?Q?bNR1R+59QJU3IPQ6B5tkm9VUzz/rB0wR1tOJEtsEpmoNZyaRlrSWGqK9zYQU?=
 =?us-ascii?Q?OE/crH6tlO5p52fCZ+KCql6LZG3De6P1FhHR1G57s41pT4qK5DsUC13PHMXU?=
 =?us-ascii?Q?YC5ooKarouNrkx2aKava9ja/axqiIubKttfaE39MjcrtP3uaJWX4+X/kQV3E?=
 =?us-ascii?Q?T0ZBKTGnPhhjXBOUQXD1sbWOCRFsHDS5Dd+TAhXr9oRwhZiROZY3jRN9lLp9?=
 =?us-ascii?Q?F36LBXQeydMdUQWqgDDNIWXdrYDx/a55oE/ahey78ikw0ud84uoa5Wptw1eD?=
 =?us-ascii?Q?iVVxN5kTUXWHAoGJkFCnfdRIJM2ybMrE6YCVtpJkYkgQQ8cSstXd4EsSlaZp?=
 =?us-ascii?Q?vgcBa7hV3a5VykkRtOIQlnaTeACwTDN617YHCYaBoPl+MJPIPslhz+Cz74Jx?=
 =?us-ascii?Q?EYcWJFadowV7YnHYdtMeP34zErQrRC2VN8jttiGrci2DDr/OyaTDKTqrGpG6?=
 =?us-ascii?Q?X3S7HdVbJc5fmvtNts0M06x2ysbNe538utg4lr6QCm+T3upjeWM8ouIKLx5N?=
 =?us-ascii?Q?0wEhc0F/PGU9cYmI9M8Q4I0MhKkUMeIq0nqtWeJr5Stlea1IxglX8QNnpHMf?=
 =?us-ascii?Q?sLOSZ0HefnDovMacATw6oPAX8cAmw9T3l/dg37Zclmo5bZs0pX3duuu0FJME?=
 =?us-ascii?Q?3LguYRxum3CQ7vDuflE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 07:23:51.2590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8879d69e-1a82-4339-d5a3-08de2a61406b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417

From: Cosmin Ratiu <cratiu@nvidia.com>

Devlink rate leafs and nodes were stored in their respective devlink
objects pointed to by devlink_rate->devlink.

This patch removes that association by introducing the concept of
'rate node devlink', which is where all rates that could link to each
other are stored. For now this is the same as devlink_rate->devlink.

After this patch, the devlink rates stored in this devlink instance
could potentially be from multiple other devlink instances. So all rate
node manipulation code was updated to:
- correctly compare the actual devlink object during iteration.
- maybe acquire additional locks (noop for now).

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/net/devlink.h |   2 +
 net/devlink/rate.c    | 192 +++++++++++++++++++++++++++++++-----------
 2 files changed, 144 insertions(+), 50 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index cb839e0435a1..df481af91473 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1814,6 +1814,8 @@ void devlink_port_attrs_pci_sf_set(struct devlink_port *devlink_port,
 				   bool external);
 int devl_port_fn_devlink_set(struct devlink_port *devlink_port,
 			     struct devlink *fn_devlink);
+struct devlink *devl_rate_lock(struct devlink *devlink);
+void devl_rate_unlock(struct devlink *devlink);
 struct devlink_rate *
 devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 		      struct devlink_rate *parent);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 0d68b5c477dc..ddbd0beec4b9 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -30,13 +30,31 @@ devlink_rate_leaf_get_from_info(struct devlink *devlink, struct genl_info *info)
 	return devlink_rate ?: ERR_PTR(-ENODEV);
 }
 
+struct devlink *devl_rate_lock(struct devlink *devlink)
+{
+	return devlink;
+}
+
+static struct devlink *
+devl_get_rate_node_instance_locked(struct devlink *devlink)
+{
+	return devlink;
+}
+
+void devl_rate_unlock(struct devlink *devlink)
+{
+}
+
 static struct devlink_rate *
 devlink_rate_node_get_by_name(struct devlink *devlink, const char *node_name)
 {
 	struct devlink_rate *devlink_rate;
+	struct devlink *rate_devlink;
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
-		if (devlink_rate_is_node(devlink_rate) &&
+	rate_devlink = devl_get_rate_node_instance_locked(devlink);
+	list_for_each_entry(devlink_rate, &rate_devlink->rate_list, list) {
+		if (devlink_rate->devlink == devlink &&
+		    devlink_rate_is_node(devlink_rate) &&
 		    !strcmp(node_name, devlink_rate->name))
 			return devlink_rate;
 	}
@@ -190,17 +208,25 @@ static void devlink_rate_notify(struct devlink_rate *devlink_rate,
 void devlink_rates_notify_register(struct devlink *devlink)
 {
 	struct devlink_rate *rate_node;
+	struct devlink *rate_devlink;
 
-	list_for_each_entry(rate_node, &devlink->rate_list, list)
-		devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	rate_devlink = devl_rate_lock(devlink);
+	list_for_each_entry(rate_node, &rate_devlink->rate_list, list)
+		if (rate_node->devlink == devlink)
+			devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	devl_rate_unlock(devlink);
 }
 
 void devlink_rates_notify_unregister(struct devlink *devlink)
 {
 	struct devlink_rate *rate_node;
+	struct devlink *rate_devlink;
 
-	list_for_each_entry_reverse(rate_node, &devlink->rate_list, list)
-		devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
+	rate_devlink = devl_rate_lock(devlink);
+	list_for_each_entry_reverse(rate_node, &rate_devlink->rate_list, list)
+		if (rate_node->devlink == devlink)
+			devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
+	devl_rate_unlock(devlink);
 }
 
 static int
@@ -209,10 +235,12 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_rate *devlink_rate;
+	struct devlink *rate_devlink;
 	int idx = 0;
 	int err = 0;
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
+	rate_devlink = devl_rate_lock(devlink);
+	list_for_each_entry(devlink_rate, &rate_devlink->rate_list, list) {
 		enum devlink_command cmd = DEVLINK_CMD_RATE_NEW;
 		u32 id = NETLINK_CB(cb->skb).portid;
 
@@ -220,6 +248,9 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 			idx++;
 			continue;
 		}
+		if (devlink_rate->devlink != devlink)
+			continue;
+
 		err = devlink_nl_rate_fill(msg, devlink_rate, cmd, id,
 					   cb->nlh->nlmsg_seq, flags, NULL);
 		if (err) {
@@ -228,6 +259,7 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 		}
 		idx++;
 	}
+	devl_rate_unlock(devlink);
 
 	return err;
 }
@@ -244,23 +276,33 @@ int devlink_nl_rate_get_doit(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *msg;
 	int err;
 
+	devl_rate_lock(devlink);
 	devlink_rate = devlink_rate_get_from_info(devlink, info);
-	if (IS_ERR(devlink_rate))
-		return PTR_ERR(devlink_rate);
+	if (IS_ERR(devlink_rate)) {
+		err = PTR_ERR(devlink_rate);
+		goto unlock;
+	}
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
+	if (!msg) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 
 	err = devlink_nl_rate_fill(msg, devlink_rate, DEVLINK_CMD_RATE_NEW,
 				   info->snd_portid, info->snd_seq, 0,
 				   info->extack);
-	if (err) {
-		nlmsg_free(msg);
-		return err;
-	}
+	if (err)
+		goto err_fill;
 
+	devl_rate_unlock(devlink);
 	return genlmsg_reply(msg, info);
+
+err_fill:
+	nlmsg_free(msg);
+unlock:
+	devl_rate_unlock(devlink);
+	return err;
 }
 
 static bool
@@ -590,24 +632,32 @@ int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 	const struct devlink_ops *ops;
 	int err;
 
+	devl_rate_lock(devlink);
 	devlink_rate = devlink_rate_get_from_info(devlink, info);
-	if (IS_ERR(devlink_rate))
-		return PTR_ERR(devlink_rate);
+	if (IS_ERR(devlink_rate)) {
+		err = PTR_ERR(devlink_rate);
+		goto unlock;
+	}
 
 	ops = devlink->ops;
-	if (!ops || !devlink_rate_set_ops_supported(ops, info, devlink_rate->type))
-		return -EOPNOTSUPP;
+	if (!ops ||
+	    !devlink_rate_set_ops_supported(ops, info, devlink_rate->type)) {
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
 
 	err = devlink_nl_rate_set(devlink_rate, ops, info);
 
 	if (!err)
 		devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
+unlock:
+	devl_rate_unlock(devlink);
 	return err;
 }
 
 int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *rate_devlink, *devlink = info->user_ptr[0];
 	struct devlink_rate *rate_node;
 	const struct devlink_ops *ops;
 	int err;
@@ -621,15 +671,21 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!devlink_rate_set_ops_supported(ops, info, DEVLINK_RATE_TYPE_NODE))
 		return -EOPNOTSUPP;
 
+	rate_devlink = devl_rate_lock(devlink);
 	rate_node = devlink_rate_node_get_from_attrs(devlink, info->attrs);
-	if (!IS_ERR(rate_node))
-		return -EEXIST;
-	else if (rate_node == ERR_PTR(-EINVAL))
-		return -EINVAL;
+	if (!IS_ERR(rate_node)) {
+		err = -EEXIST;
+		goto unlock;
+	} else if (rate_node == ERR_PTR(-EINVAL)) {
+		err = -EINVAL;
+		goto unlock;
+	}
 
 	rate_node = kzalloc(sizeof(*rate_node), GFP_KERNEL);
-	if (!rate_node)
-		return -ENOMEM;
+	if (!rate_node) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 
 	rate_node->devlink = devlink;
 	rate_node->type = DEVLINK_RATE_TYPE_NODE;
@@ -648,8 +704,9 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_rate_set;
 
 	refcount_set(&rate_node->refcnt, 1);
-	list_add(&rate_node->list, &devlink->rate_list);
+	list_add(&rate_node->list, &rate_devlink->rate_list);
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	devl_rate_unlock(devlink);
 	return 0;
 
 err_rate_set:
@@ -658,6 +715,8 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	kfree(rate_node->name);
 err_strdup:
 	kfree(rate_node);
+unlock:
+	devl_rate_unlock(devlink);
 	return err;
 }
 
@@ -667,13 +726,17 @@ int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 	struct devlink_rate *rate_node;
 	int err;
 
+	devl_rate_lock(devlink);
 	rate_node = devlink_rate_node_get_from_info(devlink, info);
-	if (IS_ERR(rate_node))
-		return PTR_ERR(rate_node);
+	if (IS_ERR(rate_node)) {
+		err = PTR_ERR(rate_node);
+		goto unlock;
+	}
 
 	if (refcount_read(&rate_node->refcnt) > 1) {
 		NL_SET_ERR_MSG(info->extack, "Node has children. Cannot delete node.");
-		return -EBUSY;
+		err = -EBUSY;
+		goto unlock;
 	}
 
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
@@ -684,6 +747,8 @@ int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 	list_del(&rate_node->list);
 	kfree(rate_node->name);
 	kfree(rate_node);
+unlock:
+	devl_rate_unlock(devlink);
 	return err;
 }
 
@@ -692,14 +757,20 @@ int devlink_rates_check(struct devlink *devlink,
 			struct netlink_ext_ack *extack)
 {
 	struct devlink_rate *devlink_rate;
+	struct devlink *rate_devlink;
+	int err = 0;
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list)
-		if (!rate_filter || rate_filter(devlink_rate)) {
+	rate_devlink = devl_rate_lock(devlink);
+	list_for_each_entry(devlink_rate, &rate_devlink->rate_list, list)
+		if (devlink_rate->devlink == devlink &&
+		    (!rate_filter || rate_filter(devlink_rate))) {
 			if (extack)
 				NL_SET_ERR_MSG(extack, "Rate node(s) exists.");
-			return -EBUSY;
+			err = -EBUSY;
+			break;
 		}
-	return 0;
+	devl_rate_unlock(devlink);
+	return err;
 }
 
 /**
@@ -716,14 +787,20 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 		      struct devlink_rate *parent)
 {
 	struct devlink_rate *rate_node;
+	struct devlink *rate_devlink;
 
+	rate_devlink = devl_rate_lock(devlink);
 	rate_node = devlink_rate_node_get_by_name(devlink, node_name);
-	if (!IS_ERR(rate_node))
-		return ERR_PTR(-EEXIST);
+	if (!IS_ERR(rate_node)) {
+		rate_node = ERR_PTR(-EEXIST);
+		goto unlock;
+	}
 
 	rate_node = kzalloc(sizeof(*rate_node), GFP_KERNEL);
-	if (!rate_node)
-		return ERR_PTR(-ENOMEM);
+	if (!rate_node) {
+		rate_node = ERR_PTR(-ENOMEM);
+		goto unlock;
+	}
 
 	if (parent) {
 		rate_node->parent = parent;
@@ -737,12 +814,15 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 	rate_node->name = kstrdup(node_name, GFP_KERNEL);
 	if (!rate_node->name) {
 		kfree(rate_node);
-		return ERR_PTR(-ENOMEM);
+		rate_node = ERR_PTR(-ENOMEM);
+		goto unlock;
 	}
 
 	refcount_set(&rate_node->refcnt, 1);
-	list_add(&rate_node->list, &devlink->rate_list);
+	list_add(&rate_node->list, &rate_devlink->rate_list);
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+unlock:
+	devl_rate_unlock(devlink);
 	return rate_node;
 }
 EXPORT_SYMBOL_GPL(devl_rate_node_create);
@@ -758,10 +838,10 @@ EXPORT_SYMBOL_GPL(devl_rate_node_create);
 int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
 			  struct devlink_rate *parent)
 {
-	struct devlink *devlink = devlink_port->devlink;
+	struct devlink *rate_devlink, *devlink = devlink_port->devlink;
 	struct devlink_rate *devlink_rate;
 
-	devl_assert_locked(devlink_port->devlink);
+	devl_assert_locked(devlink);
 
 	if (WARN_ON(devlink_port->devlink_rate))
 		return -EBUSY;
@@ -770,6 +850,7 @@ int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
 	if (!devlink_rate)
 		return -ENOMEM;
 
+	rate_devlink = devl_rate_lock(devlink);
 	if (parent) {
 		devlink_rate->parent = parent;
 		refcount_inc(&devlink_rate->parent->refcnt);
@@ -779,9 +860,10 @@ int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
 	devlink_rate->devlink = devlink;
 	devlink_rate->devlink_port = devlink_port;
 	devlink_rate->priv = priv;
-	list_add_tail(&devlink_rate->list, &devlink->rate_list);
+	list_add_tail(&devlink_rate->list, &rate_devlink->rate_list);
 	devlink_port->devlink_rate = devlink_rate;
 	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
+	devl_rate_unlock(devlink);
 
 	return 0;
 }
@@ -797,16 +879,19 @@ EXPORT_SYMBOL_GPL(devl_rate_leaf_create);
 void devl_rate_leaf_destroy(struct devlink_port *devlink_port)
 {
 	struct devlink_rate *devlink_rate = devlink_port->devlink_rate;
+	struct devlink *devlink = devlink_port->devlink;
 
-	devl_assert_locked(devlink_port->devlink);
+	devl_assert_locked(devlink);
 	if (!devlink_rate)
 		return;
 
+	devl_rate_lock(devlink);
 	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_DEL);
 	if (devlink_rate->parent)
 		refcount_dec(&devlink_rate->parent->refcnt);
 	list_del(&devlink_rate->list);
 	devlink_port->devlink_rate = NULL;
+	devl_rate_unlock(devlink);
 	kfree(devlink_rate);
 }
 EXPORT_SYMBOL_GPL(devl_rate_leaf_destroy);
@@ -815,18 +900,22 @@ EXPORT_SYMBOL_GPL(devl_rate_leaf_destroy);
  * devl_rate_nodes_destroy - destroy all devlink rate nodes on device
  * @devlink: devlink instance
  *
- * Unset parent for all rate objects and destroy all rate nodes
- * on specified device.
+ * Unset parent for all rate objects involving this device and destroy all rate
+ * nodes on it.
  */
 void devl_rate_nodes_destroy(struct devlink *devlink)
 {
 	const struct devlink_ops *ops = devlink->ops;
 	struct devlink_rate *devlink_rate, *tmp;
+	struct devlink *rate_devlink;
 
 	devl_assert_locked(devlink);
+	rate_devlink = devl_rate_lock(devlink);
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
-		if (!devlink_rate->parent)
+	list_for_each_entry(devlink_rate, &rate_devlink->rate_list, list) {
+		if (!devlink_rate->parent ||
+		    (devlink_rate->devlink != devlink &&
+		     devlink_rate->parent->devlink != devlink))
 			continue;
 
 		if (devlink_rate_is_leaf(devlink_rate))
@@ -839,13 +928,16 @@ void devl_rate_nodes_destroy(struct devlink *devlink)
 		refcount_dec(&devlink_rate->parent->refcnt);
 		devlink_rate->parent = NULL;
 	}
-	list_for_each_entry_safe(devlink_rate, tmp, &devlink->rate_list, list) {
-		if (devlink_rate_is_node(devlink_rate)) {
+	list_for_each_entry_safe(devlink_rate, tmp, &rate_devlink->rate_list,
+				 list) {
+		if (devlink_rate->devlink == devlink &&
+		    devlink_rate_is_node(devlink_rate)) {
 			ops->rate_node_del(devlink_rate, devlink_rate->priv, NULL);
 			list_del(&devlink_rate->list);
 			kfree(devlink_rate->name);
 			kfree(devlink_rate);
 		}
 	}
+	devl_rate_unlock(devlink);
 }
 EXPORT_SYMBOL_GPL(devl_rate_nodes_destroy);
-- 
2.31.1


