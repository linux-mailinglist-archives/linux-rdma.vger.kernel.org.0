Return-Path: <linux-rdma+bounces-14752-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1BEC83AA1
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 08:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB1604E5D55
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 07:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B746E2E6CD5;
	Tue, 25 Nov 2025 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nroxNBzZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91072DA750;
	Tue, 25 Nov 2025 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764054815; cv=fail; b=V9N0OrXs/8eHfxMO+HxpCpafM50gxwNrGjBOag1GNHoJFSB0VQDUOIHQIu3m96gDl35hSRyamrHSL9iAW7gxAryLNYWVYJe5Tu66qxyyUhe3Omzki3AEariByG2KS3VKIxJYL7tVFWNm1bKrqAbtOv/fCI+okSK2S11z7o0tO90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764054815; c=relaxed/simple;
	bh=aMNarF+UGzY0+nxpb8WcTg45ER9WXR5V0OmT/6tnDAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4njtPsWXZ9k6aUOeEkc5SWTsfAYRhCfxjQKIlALbdZad2iLKE5BjGlC1MHvGpKwgH85wx1NM1RrzbUoucCOiBuuV3HK6G/TLTwx2y27izT/MwJwsCQ6sGI67Or3UbZpQD1UfeE2PCOuJfs93quHlNoANC4ROOtPm5Kfy4ClR+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nroxNBzZ; arc=fail smtp.client-ip=52.101.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2/RfFXIW9AXWO+hZc0r8GYxd6kow1sLlRcnzqHrQHeMIEtaowwtWpkkpLfREy9Brxw7ifIEy/ZaX94MdtQ2qF1gWesQcMPmRi66uOy4NmNg+VojaI5A9ea8wEpVZCP0q8lbkNXjuTZ1meA8gkk2n3wfMdnG25ejAsy2vrz4LDbW4oEg7yzM9fdk9MbUr8N3pJgLu+DZt/Ty/5Y0MNWeExauG+8wmfRH+X0PnFYTibtJ6AEPu9hujySwiPxH/DiFEqGvKDgFvcxdomkmkKCGLpi4Njx8Q2vtBbTi/PZvA6qKluaTT5FvRYDYjUAHbnFY4eD3E/6XtSYDf+owLmD/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSxQO3n+BNUUrRX1Chc6z+yb+mtKqnDufsbVHSCrgi0=;
 b=MuZ5o+lBLA4eCwuDLm2n4kBqAaSzp8xjYms7AAec2rxfORUpsl2teDDjgFnfNrmzBUY+qQw4O5uu1xYjpdTFQfahKGBOwHjHZTa7NRV0BcI7StA7TV7ghyNMrDnTGv2CHbcWsm/U+9v6F0PRzYXF3CpldL10DWmDBASsNc/TV0nwDPMsNNzK7B4ZXPireQeHBeKNnRSSU6ZsA4z9aaXAF85A4/0YfqbQOhY9Krhg7RlNXpkaFxdyrQohLJ0rPjyZYU6gsdvFxOmTYdNWTwpAyavasrSFA4nF8shmZByGxVzCW7kl+re4vICMw9Svuzjotiu7QD33rBwVyNN0stYgUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSxQO3n+BNUUrRX1Chc6z+yb+mtKqnDufsbVHSCrgi0=;
 b=nroxNBzZUlE9GDve//GWeNsna5c/jX8I/yg2fAYLfiMIx4RDqAP+/AylMHfPmCsJLeimvpka0A+HHrQ7TN3Ff/14Mn26KsHa+En/RhCqbtrMlqKSA8U6cDaAofHPaiO4YbvZKPhMZICxFTuPSSW2P6Nqc7JQJUdtDatdqQqrl7q+CTskUychodHh9GdzLdbaCaMu5pH24OLPQaSy51NABbGBLLyWhLElKDUAgW3ab3rIXsVldBSqHIm3da2G/QEUftX30lC0DvsaJsy035b4FUUBhSwjYihIRhE4/SEgN5Sd6EdbWAQGrxE7ZH05CLby9ZNgyrQnHa/aeGk0z1OYyQ==
Received: from BY3PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:39a::11)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 07:13:30 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::9d) by BY3PR03CA0006.outlook.office365.com
 (2603:10b6:a03:39a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 07:13:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 07:13:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:13:17 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:13:17 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 24
 Nov 2025 23:13:10 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>
Subject: [PATCH net-next 1/3] net: Introduce netif_xmit_time_out_duration() helper
Date: Tue, 25 Nov 2025 09:12:54 +0200
Message-ID: <1764054776-1308696-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764054776-1308696-1-git-send-email-tariqt@nvidia.com>
References: <1764054776-1308696-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: a996f1a4-920d-4938-33e5-08de2bf222f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mm7zRKMvC45aysIy6LceyMUYKXmyYT2V2kqhHoPQRSlteBpNRxOpHS4JtaP5?=
 =?us-ascii?Q?scuE/gD/kqxNNY9r/ZBHP3Jq57A5HrQW15XSa/jvNvW8b0lDluhzsPo2ttZl?=
 =?us-ascii?Q?+S2GTbO36j4385BoIHDeeYOPmvAx5ldJYmOjagDDEA68eG3TCt3NmmjLsymn?=
 =?us-ascii?Q?wXeJsPLq/3TbENUI2nPYF/DHbJaoK0h9DCdqtOTofaYn9k+VXkK3R9tuMrGM?=
 =?us-ascii?Q?6NL529/QGK4msVB3seWAPIUAjjy4eiV8bpWjF29hfvQyvjgCtToeiNPWh2Mp?=
 =?us-ascii?Q?l7MpI8U6IW/4xsNc2dV9hgWlAgiX6PRJOw8o3gD/enBkS09AVwSTihg2B66v?=
 =?us-ascii?Q?DF0m+mpz7nHzqksC3jp1YqJDETq0kT/Z943PugPfIy4hjHjncwtzIouea82b?=
 =?us-ascii?Q?oHGrJ9iIiO3LvwFdjtiCuciH0mpBwLk8K0XC1ROJ2Tg3anUQM9Y7vAo7eP+0?=
 =?us-ascii?Q?Xj8TMH28HdmhgqWiQfXuMJH7F7xBJ/INSgR0ToTV62j150pSv7n8V/x/6uOo?=
 =?us-ascii?Q?iFyHuG9SOPqSDx0JP4m6OglBcIeI2Aks8Xfx6KTXznnk4icdBB5sHZ31pSmD?=
 =?us-ascii?Q?lqpwZGYqlaR9R/k9l4r8QLXsl5PDngEGl3hDfNqeqDWXSFx2oDlplMSFwf08?=
 =?us-ascii?Q?/qrZHbQLdulsiX1p3Nk6BusvGnVZA+VfJMJ5nM/4BFvifIOACLFEAcPF4eyj?=
 =?us-ascii?Q?I/Girz4mlWo6RjJxrkodZhvCudvMCp2lvB6Ko5TRf84uhfCGFDipXCehyglc?=
 =?us-ascii?Q?D4pXTpSDO8FL+fgu3Ux/j4fCdoWLdBL+IbRRYYyAkCplVWMe/zxQJFbgSzwX?=
 =?us-ascii?Q?BEUtflH5e9oLaVVqN3KaMfnS3QjFv7TWvU/hL0VyANeAO8lDdjJy/klPfKZF?=
 =?us-ascii?Q?eGnwJtTXGgjie8Y7SiHG3gz3fDIhP9P9Q0XTl1/u2ULPVd6tNazaUDYDS3Jy?=
 =?us-ascii?Q?L4DESCBrhZ291gpdIGa7wgi76gFlD/8CR4bCOTiGR92kHZzb6L3RUvtUlntq?=
 =?us-ascii?Q?h/u0qYNAatG4KJTFo51zzSFKx858eCSWIaGn4YeBl+IBsxaHN6ymo+ARgOhK?=
 =?us-ascii?Q?pUBD5hZS2CTx22/qdL49nytODAz/8ijS8tJBLRBUzSsJik04vPb1IM/rKJkn?=
 =?us-ascii?Q?DV3ysigaqqtNe4NarrMamY2y+IpYrG1Ff6eyb7rUvMTcf4PSyPg3+8U/SSiX?=
 =?us-ascii?Q?tQqoyHVK6T+e2myVKXO3dA3KIHn/MYuYz5hBvsMWjlgufleTeePkrpi6lhwK?=
 =?us-ascii?Q?lD5O7zUaKRl1nblLldEueM5ex2pKwDAYYHs3M42H+5ioFxWBoSlNlBp24YOU?=
 =?us-ascii?Q?7Wt3duhrc7/g6WQlF/6030QnRSQZqqd0pjnKZMV7Hux0wXDI5AtGfLRgsJTK?=
 =?us-ascii?Q?oCe4CyeKaedDlhSwgVrSyX6sAElItVvxxYwv+FiYakqxyYjvhMtpzrkN+Auc?=
 =?us-ascii?Q?1Xdv1dWiVgpkAZS3mnsNZi1cYtA+bbQM+l9eshCsoyOPnAua41VhnV+B6byT?=
 =?us-ascii?Q?F7NUI8X+xsR/adyxlK+g2oPW/gWc1CAzOmZt7cJWIoalgoIy5lMIWqr/iSJs?=
 =?us-ascii?Q?dYFXvAQcKWZOVbdJAYs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:13:30.1608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a996f1a4-920d-4938-33e5-08de2bf222f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834

From: Shahar Shitrit <shshitrit@nvidia.com>

Introduce a new helper function netif_xmit_time_out_duration() to
check if a TX queue has timed out and report the timeout duration.
This helper consolidates the logic that is duplicated in several
locations and also encapsulates the check for whether the TX queue
is stopped.

As the first user, convert dev_watchdog() to use this helper.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/netdevice.h | 15 +++++++++++++++
 net/sched/sch_generic.c   |  7 +++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e808071dbb7d..3cd73769fcfa 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3680,6 +3680,21 @@ static inline bool netif_xmit_stopped(const struct netdev_queue *dev_queue)
 	return dev_queue->state & QUEUE_STATE_ANY_XOFF;
 }
 
+static inline unsigned int
+netif_xmit_timeout_ms(struct netdev_queue *txq, unsigned long *trans_start)
+{
+	unsigned long txq_trans_start = READ_ONCE(txq->trans_start);
+
+	if (trans_start)
+		*trans_start = txq_trans_start;
+
+	if (netif_xmit_stopped(txq) &&
+	    time_after(jiffies, txq_trans_start + txq->dev->watchdog_timeo))
+		return jiffies_to_msecs(jiffies - txq_trans_start);
+
+	return 0;
+}
+
 static inline bool
 netif_xmit_frozen_or_stopped(const struct netdev_queue *dev_queue)
 {
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 852e603c1755..aa6192781a24 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -523,10 +523,9 @@ static void dev_watchdog(struct timer_list *t)
 				 * netdev_tx_sent_queue() and netif_tx_stop_queue().
 				 */
 				smp_mb();
-				trans_start = READ_ONCE(txq->trans_start);
-
-				if (time_after(jiffies, trans_start + dev->watchdog_timeo)) {
-					timedout_ms = jiffies_to_msecs(jiffies - trans_start);
+				timedout_ms = netif_xmit_timeout_ms(txq,
+								    &trans_start);
+				if (timedout_ms) {
 					atomic_long_inc(&txq->trans_timeout);
 					break;
 				}
-- 
2.31.1


