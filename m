Return-Path: <linux-rdma+bounces-7741-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2661AA34CC9
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 19:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96FC188E678
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E45245035;
	Thu, 13 Feb 2025 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QOBbo/pW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5BB242937;
	Thu, 13 Feb 2025 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469765; cv=fail; b=qVfErmx7z1qDL9Vo13JrR9msi2iHEE2SCaTo+h4bc+Rgc6w4APdFu07yB3mIH/3KmRQTJQ/8vfIFerRTwEoKh0rzUJJFlTOBcqu1jnSO3wDFFTiQOtpeGlpRXZw00rclLpTMftvf7xiXgGPD70qMDD67DZtAYTDobMFLIftYetU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469765; c=relaxed/simple;
	bh=QOVf4+orqAB+OJkeqYOR7se/bD/2GDoKD2fZ0ew9tcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpQOj9FFEUfXxge1IqQvR3sKKZNdotveeSkbnoyXpWto35vulrVtQgwos78N8EC9OA7chmIOe4RMu/IwQTDgRv/lEzzqEHGuWF2EytBKUDA2vxpaxm6KTVdR6M4bbaTN3OqGOkzeU3T4h4akFUT08wVzHRPYmTP6gHhkam2Isko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QOBbo/pW; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLS+3S8zAtgS+ZWiJ6Lzgk1D67yZL01fSuwQ32KGrvBNw+n0uBHmszPuK6Q8KgiIjPuw5qHlGc/wTxXttkrwrX2ybxL58oATz1Rmfw5RlId7RSh/KYfg+qrNIxEBd0Kpb9sJQnJjrX/rMZ9Gwcqn2yUInSWV/28MpZ7CNoP5l2/BKGLpjO5b9Mm+9qsNN1aBhWhANF2rl2RgAhFctMD96FkuGm43APlXNOqHEokSBVpf3bEEbc9vHvPPlr384ANW9DQ+hQJmDPR2ps2jHVmUHFu7xEV1h4UlO3ZIcApki3EIRWFvS2gmtHlOQ8qvu8IkA0NLqlVs2KXaI0nhKmTO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSCgfREw3pC9lcEtAaMhTPg7LD7+s4HkRro7cPvahL0=;
 b=emlE4jPofczBjQZ/HcNmg90EBp7KPywdmomQSeLr7v//i04Ll4gZ8/ZFW3fTHntJSZSzk0Kg/pht8SXWK5azhOaO95IAw49amLToVkcWnoEZqvqrSWGiapw6bawGzOPShUDi2xwBthJH9XUjS11BOToOYMiX39n4HsW+Q5bR/o0aiyYDlr5jnZdtWpldAeqMcL7FO/0a4wWlDazNDbX2RAsNzo2iayAqIF87whiVBXgXGxn6lVNFarWeXoaIlGDx9G8y01k3/rxQs+Sxycc6zCJyo7/mS9RUSXcHkBWl/j8ozT7NRzq3Cl32x2fm+fCo6jb/8YCLEhYvyR9wOX/L8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSCgfREw3pC9lcEtAaMhTPg7LD7+s4HkRro7cPvahL0=;
 b=QOBbo/pWNp4IT2sbTPbMJSJnQMTRXCBeJu9aA/8MVFpz3dBtKStz2ur7qhcwpnCBvjs4JbxFQUh+ysvVkSk2CE89S8z1oj4vJusZZ34cclQujBpT8i8iYEVaBummLu87HAoHGGEx5W9SEhd380O4XgPKgP8hbq2zlnEL+jktXKzBG5BHOihYyZkqg0jkuBW1uxAS6arL1eX1KGqEJfJPqjA+qlcJK0c7YzZ9Uqq6+p+sTZJh+Q5pLNpCZXoVQZuPXP8yCVAJDXKucswQRIxHYemPlCKOmdk2CZ9aVm4h/9o5Yoy1vP7fjqGNilxShIQsXwNuclQc2b73KejvmfzzNg==
Received: from DS7PR06CA0030.namprd06.prod.outlook.com (2603:10b6:8:54::22) by
 SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 18:02:39 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::db) by DS7PR06CA0030.outlook.office365.com
 (2603:10b6:8:54::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Thu,
 13 Feb 2025 18:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 18:02:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 10:02:22 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 10:02:21 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 13
 Feb 2025 10:02:17 -0800
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
Subject: [PATCH net-next 03/10] devlink: Serialize access to rate domains
Date: Thu, 13 Feb 2025 20:01:27 +0200
Message-ID: <20250213180134.323929-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 96fe06d4-d542-4f2f-bd22-08dd4c589a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0/d50+X0q4wDWWxNgDxaJaQk5jwMNSfmMGEl9Pqb94Pegw3P7ieMDX7qMxmp?=
 =?us-ascii?Q?BdyaCWE6eZY/mFY3ORlT3ySuZ0C+2s0aS9ujPiwHKZ+AWF/W2zhgD0Llre2s?=
 =?us-ascii?Q?H5kYh3uz2GYCt5FQ/BIkHxGIIKf/EfJp3MEDoZGLm6pqrmSMtOdovkPen2be?=
 =?us-ascii?Q?A5qJ85T+oL5zKfozNTL9STmgUoC+YPf7x18HbiEDVdk4cFBFnNlrtKYeKBGF?=
 =?us-ascii?Q?HlOJ+rOQdqDkPc3eDv9fByQSPdYnO7dz6c1NedbjFXho+zaYdFvLOtFNrfb+?=
 =?us-ascii?Q?bQFKa8w2c2cME8xTHPnPoO4zM5C5nB2PKtWl1V9SS1PIhg62F/Ch14bOJ5pt?=
 =?us-ascii?Q?OiurS6G7pnsvRM4uEeD+kuZNILTmoqZXZSnyl8DM1CJdr5Q1E+uMS1BuB9e4?=
 =?us-ascii?Q?+LJlLQEpuhJj4wIvt3bueO2AXCdv4srWa+hKXDxbTw7piLrRnET0QVqsKF6D?=
 =?us-ascii?Q?t3UECr/8RW2jsvwykgWHnl3UjYwCdc8VuS/D4yDaUB4T3K9Dax4bffSY0wPj?=
 =?us-ascii?Q?Jtp3zBYrs2yfg5Qy6QdR9EMDeevJCSU5skypF3yrr9CjASJIQQ0/IxpdNjOl?=
 =?us-ascii?Q?2qsW0oGmyX1aGRB58lYjgDzZ35e8VVYHJCZaJ3VZNZrjef50HWyn86E1LUzV?=
 =?us-ascii?Q?AHPHVeqpv4wvENlhPPEd/i+2VZnY/c0/ymBdmKTXf/AVM7GZSehCWvR2/c0J?=
 =?us-ascii?Q?ruWjg8pES6J3iUx89B9EsyChEdZNdROLvJCEALlRIdKQBdrXZJgDSDKYoHlQ?=
 =?us-ascii?Q?980Mm5HyFq9q1L5gzSs6cIi9jdkkxvGCXZT80m9xZhVSBBZMjFgSUz6NXMDW?=
 =?us-ascii?Q?VvQse91DHlX/Y17Sijebu7a5cvHBmaWwsL9XPEoSb1KeQLjb3NhECXZ59q9X?=
 =?us-ascii?Q?3Hre7yjPvLqeDv09G8z+SKaHnhv9pwM3NBPTnDARXp6IjGJym95pLTwEWk13?=
 =?us-ascii?Q?FC4XvpzxLbgPQI1EFMXxLK7i3v674QIGC3RBvQcJdWCkt7cg4Qwt9o2NwK6j?=
 =?us-ascii?Q?LP9QpKffjLveJvXqdDcuC2yfIBnVuYX0kHYi6FTzhAI2jQfCFbtMTUI+s8vI?=
 =?us-ascii?Q?RIFx36gXLx6/uA4nz1NAdRrORefjHTgc+GAP3r4FOIHVw/wqeYolny1/COTt?=
 =?us-ascii?Q?I5jS1NCjeYjC6x3mRiv+TaPGm2elISJoqTFpqTCxzbezUTfmKTZVvBMxkNRc?=
 =?us-ascii?Q?lcrcFD7pHl8YRqEL81flW8aMEQLP0oLv1FCUujqFneg51o1sMrb0c1+6AYoG?=
 =?us-ascii?Q?yQSPmpgI3GVPMxuTcXjxZ4SodvOPK8f4i2f8xpfJLJQQiDFai29RxAN7oIoU?=
 =?us-ascii?Q?TT/nkEaSUBCPf373WWlTZ/8n6UElVH+hnZauCq4/5d3Enx6AmdBpKG3WuFcJ?=
 =?us-ascii?Q?9lmz51uKgJErwvCSrY+KWFj48BVAVw2EOSc5sw9nI+Hq0JOsHL6NZUABk+I6?=
 =?us-ascii?Q?CVy3VFP5k6Fyo/JbksvJiYQrL0SLSipEgYW2ORGn2Y2a9KPP9diS+30HfYSy?=
 =?us-ascii?Q?+Z6gwwjQy0J0hoQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:02:38.1268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fe06d4-d542-4f2f-bd22-08dd4c589a14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738

From: Cosmin Ratiu <cratiu@nvidia.com>

Access to rates in a rate domain should be serialized.

This commit introduces two new functions, devl_rate_domain_lock and
devl_rate_domain_unlock, and uses them whenever serial access to a rate
domain is needed. For now, they are no-ops since access to a rate domain
is protected by the devlink lock.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/devl_internal.h |   4 ++
 net/devlink/rate.c          | 114 +++++++++++++++++++++++++++---------
 2 files changed, 89 insertions(+), 29 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 209b4a4c7070..fae81dd6953f 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -121,6 +121,10 @@ static inline void devl_dev_unlock(struct devlink *devlink, bool dev_lock)
 		device_unlock(devlink->dev);
 }
 
+static inline void devl_rate_domain_lock(struct devlink *devlink) { }
+
+static inline void devl_rate_domain_unlock(struct devlink *devlink) { }
+
 typedef void devlink_rel_notify_cb_t(struct devlink *devlink, u32 obj_index);
 typedef void devlink_rel_cleanup_cb_t(struct devlink *devlink, u32 obj_index,
 				      u32 rel_index);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 535863bb0c17..54e6a9893e3d 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -167,18 +167,22 @@ void devlink_rates_notify_register(struct devlink *devlink)
 {
 	struct devlink_rate *rate_node;
 
+	devl_rate_domain_lock(devlink);
 	list_for_each_entry(rate_node, &devlink->rate_domain->rate_list, list)
 		if (rate_node->devlink == devlink)
 			devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	devl_rate_domain_unlock(devlink);
 }
 
 void devlink_rates_notify_unregister(struct devlink *devlink)
 {
 	struct devlink_rate *rate_node;
 
+	devl_rate_domain_lock(devlink);
 	list_for_each_entry_reverse(rate_node, &devlink->rate_domain->rate_list, list)
 		if (rate_node->devlink == devlink)
 			devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
+	devl_rate_domain_unlock(devlink);
 }
 
 static int
@@ -190,6 +194,7 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 	int idx = 0;
 	int err = 0;
 
+	devl_rate_domain_lock(devlink);
 	list_for_each_entry(devlink_rate, &devlink->rate_domain->rate_list, list) {
 		enum devlink_command cmd = DEVLINK_CMD_RATE_NEW;
 		u32 id = NETLINK_CB(cb->skb).portid;
@@ -209,6 +214,7 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 		}
 		idx++;
 	}
+	devl_rate_domain_unlock(devlink);
 
 	return err;
 }
@@ -225,23 +231,33 @@ int devlink_nl_rate_get_doit(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *msg;
 	int err;
 
+	devl_rate_domain_lock(devlink);
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
 
+	devl_rate_domain_unlock(devlink);
 	return genlmsg_reply(msg, info);
+
+err_fill:
+	nlmsg_free(msg);
+unlock:
+	devl_rate_domain_unlock(devlink);
+	return err;
 }
 
 static bool
@@ -470,18 +486,24 @@ int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 	const struct devlink_ops *ops;
 	int err;
 
+	devl_rate_domain_lock(devlink);
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
+	if (!ops || !devlink_rate_set_ops_supported(ops, info, devlink_rate->type)) {
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
 
 	err = devlink_nl_rate_set(devlink_rate, ops, info);
-
 	if (!err)
 		devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
+unlock:
+	devl_rate_domain_unlock(devlink);
 	return err;
 }
 
@@ -501,15 +523,21 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!devlink_rate_set_ops_supported(ops, info, DEVLINK_RATE_TYPE_NODE))
 		return -EOPNOTSUPP;
 
+	devl_rate_domain_lock(devlink);
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
@@ -530,6 +558,7 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	refcount_set(&rate_node->refcnt, 1);
 	list_add(&rate_node->list, &devlink->rate_domain->rate_list);
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	devl_rate_domain_unlock(devlink);
 	return 0;
 
 err_rate_set:
@@ -538,6 +567,8 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	kfree(rate_node->name);
 err_strdup:
 	kfree(rate_node);
+unlock:
+	devl_rate_domain_unlock(devlink);
 	return err;
 }
 
@@ -547,13 +578,17 @@ int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 	struct devlink_rate *rate_node;
 	int err;
 
+	devl_rate_domain_lock(devlink);
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
@@ -564,20 +599,26 @@ int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 	list_del(&rate_node->list);
 	kfree(rate_node->name);
 	kfree(rate_node);
+unlock:
+	devl_rate_domain_unlock(devlink);
 	return err;
 }
 
 int devlink_rate_nodes_check(struct devlink *devlink, struct netlink_ext_ack *extack)
 {
 	struct devlink_rate *devlink_rate;
+	int err = 0;
 
+	devl_rate_domain_lock(devlink);
 	list_for_each_entry(devlink_rate, &devlink->rate_domain->rate_list, list)
 		if (devlink_rate->devlink == devlink &&
 		    devlink_rate_is_node(devlink_rate)) {
 			NL_SET_ERR_MSG(extack, "Rate node(s) exists.");
-			return -EBUSY;
+			err = -EBUSY;
+			break;
 		}
-	return 0;
+	devl_rate_domain_unlock(devlink);
+	return err;
 }
 
 /**
@@ -595,13 +636,19 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 {
 	struct devlink_rate *rate_node;
 
+	devl_rate_domain_lock(devlink);
+
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
@@ -615,12 +662,15 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 	rate_node->name = kstrdup(node_name, GFP_KERNEL);
 	if (!rate_node->name) {
 		kfree(rate_node);
-		return ERR_PTR(-ENOMEM);
+		rate_node = ERR_PTR(-ENOMEM);
+		goto unlock;
 	}
 
 	refcount_set(&rate_node->refcnt, 1);
 	list_add(&rate_node->list, &devlink->rate_domain->rate_list);
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+unlock:
+	devl_rate_domain_unlock(devlink);
 	return rate_node;
 }
 EXPORT_SYMBOL_GPL(devl_rate_node_create);
@@ -648,6 +698,7 @@ int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
 	if (!devlink_rate)
 		return -ENOMEM;
 
+	devl_rate_domain_lock(devlink);
 	if (parent) {
 		devlink_rate->parent = parent;
 		refcount_inc(&devlink_rate->parent->refcnt);
@@ -660,6 +711,7 @@ int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
 	list_add_tail(&devlink_rate->list, &devlink->rate_domain->rate_list);
 	devlink_port->devlink_rate = devlink_rate;
 	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
+	devl_rate_domain_unlock(devlink);
 
 	return 0;
 }
@@ -680,11 +732,13 @@ void devl_rate_leaf_destroy(struct devlink_port *devlink_port)
 	if (!devlink_rate)
 		return;
 
+	devl_rate_domain_lock(devlink_port->devlink);
 	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_DEL);
 	if (devlink_rate->parent)
 		refcount_dec(&devlink_rate->parent->refcnt);
 	list_del(&devlink_rate->list);
 	devlink_port->devlink_rate = NULL;
+	devl_rate_domain_unlock(devlink_port->devlink);
 	kfree(devlink_rate);
 }
 EXPORT_SYMBOL_GPL(devl_rate_leaf_destroy);
@@ -702,6 +756,7 @@ void devl_rate_nodes_destroy(struct devlink *devlink)
 	const struct devlink_ops *ops = devlink->ops;
 
 	devl_assert_locked(devlink);
+	devl_rate_domain_lock(devlink);
 
 	list_for_each_entry(devlink_rate, &devlink->rate_domain->rate_list, list) {
 		if (!devlink_rate->parent || devlink_rate->devlink != devlink)
@@ -723,5 +778,6 @@ void devl_rate_nodes_destroy(struct devlink *devlink)
 			kfree(devlink_rate);
 		}
 	}
+	devl_rate_domain_unlock(devlink);
 }
 EXPORT_SYMBOL_GPL(devl_rate_nodes_destroy);
-- 
2.45.0


