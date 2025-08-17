Return-Path: <linux-rdma+bounces-12802-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEF6B29507
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 22:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C37D203FB2
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 20:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C3530497C;
	Sun, 17 Aug 2025 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OZEjddkx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E786B246BB2;
	Sun, 17 Aug 2025 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755462242; cv=fail; b=Kxvnko/NXMJETiPjB0sCVo4MFgG54MDfKjE+c7d5cQpyVk6rS8VPQOD6rG5RF9XAj5X2xjZmAbOOL8gnqWjm04vHa+OkXBbgbeM6zPdX8yBzccaFH9EU4vCvKwREBU7/IFgGuVENIcfxOSqF7BjhtZkHrvr5R1Md1zFW1UWC0bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755462242; c=relaxed/simple;
	bh=H0ndwvCuplFCdjpCrEUgKkYCmczwREKDMlGA1QGSZBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaPMbJGov1mkpflaijEHxfzhpdo6IWSuu9e86m2koqPOj5Jh+o2lBIPgOmuCbBmTvPeCaoXFQbl6+BDzJaBOwfNfo5KMHOnu/+8/BFnY4Id0QrynshzE/LJYe3IeFlUzuZMJjuus4VlhbuR1dJy7wwG95VY8JuB6Kxqi6PJDPSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OZEjddkx; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYCAiMWt2MvOfjp7iziKJr09WciFxTupczvwC5RQYvHiQPqVWHLRxz38ynRkfSC8YPrOytYRtgbeoVRt5TT19MpEI0ytAnNW1Qih18wP8heUsf2uut3RbRE7B8RQdwI4XPzsIg50qF+gTTCPlRtg1ZbhTft8NML5czc9WHfELqZeVyql8to0d6yxycavRW0nFbQQ4adXgtArDaL9K9JmrE1+UFx4JagpwcSIq5NosgaE/fDqZ/H0vmH1+7PnAgou3k+Y4/tyiAmHzK3/c84XDNvbQICf2V96d7qdALCqjxJtDutwA1Qo9pq7aZHp+X8QX8r8N48Qt4CPJYz/xr3Y7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BB3HVhxekA6So6LDXjUc/5a0sxmRXxst+l4irD7tcos=;
 b=K8qAQojRHR5AZ40MZOjEdJtyCCvEIr+o5SOZdtHvPH9qLxzfDp6fmFIXAS/mQVK8URqgDgjmlEPOoz0Fte/Nfdwv/TFKN3EG+i8p8If7qfRWfhSUDZNUi4jFziOd2UacRLL1VLxuQyWLaBrKrxP+O+EasYqn6XxS/03cbUcYswsy/R5/fu9oXSrTtLMqlnL+XwAUYSlqBxyAb2O2E9O7DH0ueAiSLCC+6CmaaDtKx4+b9FJ0EWa7n29UZu4ZK/VjR/ZlOe7htmHjrZI6UC+/HhjY9LYuEMyThJU+gjK3IeoGF6513kjwzx50OelCi/pS8FQhFjBRbvVVnSwgu8y3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BB3HVhxekA6So6LDXjUc/5a0sxmRXxst+l4irD7tcos=;
 b=OZEjddkxzsfp/y2JYLVK2Ce+9OJyUY+j+HKT4NL7yPwKI5FxJh1EZ9yiRJnBLzKpCqusT4KjBMFcPLslE+IfAMS8xvinvr6wwzQenQ23ods4SFxXqIeljBjpTuuy0R2j4RtZsKhIjnnbWh8RlvfaKMs9K6LTy3lKMgYNnI+/Up8kF5V0Lr5Ay3iyCCsQ9SwSL7lq/gsJIvVRfE0LBfttBCnDx+XbpLFnfRn7atGTJtvtfRkeFzolmlr8uOaW+5EHlrdN7KWli5NG+c1JUnmJhxlvUIR7XDuXpZ7O9WL+LBIflgsc7H20wrSwD7xplETZFWSsQF8OgzX7sPmIU+fkMw==
Received: from CH0PR03CA0449.namprd03.prod.outlook.com (2603:10b6:610:10e::25)
 by BN7PPF915F74166.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Sun, 17 Aug
 2025 20:23:56 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::97) by CH0PR03CA0449.outlook.office365.com
 (2603:10b6:610:10e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Sun,
 17 Aug 2025 20:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sun, 17 Aug 2025 20:23:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 17 Aug
 2025 13:23:53 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 17 Aug 2025 13:23:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 17 Aug 2025 13:23:49 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Erez Shitrit
	<erezsh@nvidia.com>
Subject: [PATCH net 5/7] net/mlx5: HWS, don't rehash on every kind of insertion failure
Date: Sun, 17 Aug 2025 23:23:21 +0300
Message-ID: <20250817202323.308604-6-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250817202323.308604-1-mbloch@nvidia.com>
References: <20250817202323.308604-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|BN7PPF915F74166:EE_
X-MS-Office365-Filtering-Correlation-Id: 49780a51-1a27-4555-70c2-08ddddcbfe0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nvLQESqafQlP1GyM02Loi59nbktec8ZuifaGKx0wyJgAbmjv0NnT181FlzwF?=
 =?us-ascii?Q?B6zXNVDES13gU/wQ99+QmOnUDi5Fxa1G/1PeXWb3vS8uOgR6sHTpdcylfKk0?=
 =?us-ascii?Q?8nHMTKNyPqRJnwVtghBI+q0oP7rGJN6Clgb/HbqbwdpNH6oIx3IEc4Ec6OJY?=
 =?us-ascii?Q?FMc3nXc4Y0aDQA4CjOsj4ctc8lscJsqDKtpKEAaKdFxv5FeLBD2EGLEcdJhg?=
 =?us-ascii?Q?+SPFghH6RDDRyd43JqvsBH1UGnsDADLPfWq/rwU02MnN7CPX4M5zXcNU6c6H?=
 =?us-ascii?Q?sn/nGvCOBk00jZHXP9Xs2X/CiYjfb3uwHbv5b+Gz4KDuolWeneYtrmT5MaHg?=
 =?us-ascii?Q?DlV0xdsJYUQVZHiSbcxpRkF/AFQLwSSDnyK1GgboWHmBMBR9TCGqMp29CnO3?=
 =?us-ascii?Q?2RswE7QBcOmh7c8HAjb+iwEDZOUVTMSTtah9/LhBg2K4C3+Kz6bPndniIaMG?=
 =?us-ascii?Q?vI40UgNRPLfjbpKHFwAdJTI2/t4MYdgMD/qLEpxllhQ5Z2YVklOJhgFbMJ4H?=
 =?us-ascii?Q?jvpeoUH3y1UDMZQYVMetBVBbJLTjZGyCLrQSAby27+Kxrv/0zeHVBzjbQa3T?=
 =?us-ascii?Q?2tSrnb8A1/6ObtVjoVQKsA9x1ArNHuRoaMun8q5Ci1ogqMeBuoftqPfjuePH?=
 =?us-ascii?Q?NQMLCNkvOnrmq3+NOGNdYSDJdje72V5n9kQXOPaUcSPRUrEAHRPhBPgNl+Xn?=
 =?us-ascii?Q?GhovHonr5SZJBEBqD4b1GA86cqcB/0HX3v9Ni8qJbUUQhH1E5qs7p3iAq1my?=
 =?us-ascii?Q?He5qYgUpCyzBz4EUgIx/OXsij+hrM8ikQsJW+SBioZWA2bTjxBeIqkQl5v3/?=
 =?us-ascii?Q?7bnG3egvJE/0HaWJTgeWAQWOEJ90NPi7nNtbAXfUbBVzpNRxwooac6KvRzls?=
 =?us-ascii?Q?Bu6RXtmGw1sM6BAu/HLWbvxcB7z3x+zjcK36l+AVSOHURJ6AbLZTdzqH4tMW?=
 =?us-ascii?Q?x+j0GzDje3X3WZB2d5B3CQ3fpP5MdGxNh1n+Ed143+Byhk7kxEWSnAde/FOm?=
 =?us-ascii?Q?4pJh4WfxVQe5umTXU9zLmp44dFQVH89wmP9NPHUwJJ7K4TAiBg1mCi8/B5+E?=
 =?us-ascii?Q?Q7zMh62ACPCpKlVMv52wFzkgaUgHLC3L1QVugnS9gIys0In37MJSOhkWuQJn?=
 =?us-ascii?Q?BMkUk/e2R9xxJxbUJUajKdVKjv0cJj9AF3yUGLoL3MX7OaOIoBOaVJc6rZda?=
 =?us-ascii?Q?a03Lj+HHVr1mhiK4x3Cu2a05+Ju9XKEyfnZxMzapcMB4aC8NleA+VfV4QGHc?=
 =?us-ascii?Q?n2eVCuMpplqXmdcnFVOOmWh4gzQdyUh3IXhcTuqZDrQcebo7KmRMOi7eVb2g?=
 =?us-ascii?Q?QUh8dAnSqCfWaKiFpyODNNlqz6c+t8yEG1CO4QbZDWhcyZ8WJeQYvJ4G+rsa?=
 =?us-ascii?Q?khmaG1IiyCTY04NMc5yx7BhQfyK10baSckk4gTRqch0iuyrawnc3kvO3dDbG?=
 =?us-ascii?Q?0AcP2u2I5ICetEqvAtMsMqjwM/Ok669kMEv1eJn2YWIyKLk5waVPkmTP0cib?=
 =?us-ascii?Q?XAxJiOur5jy/OMnVe8nfGNu2f4zwBqpU+ih4?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 20:23:56.5301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49780a51-1a27-4555-70c2-08ddddcbfe0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF915F74166

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

If rule creation failed due to a full queue, due to timeout
in polling for completion, or due to matcher being in resize,
don't try to initiate rehash sequence - rehash would have
failed anyway.

Fixes: 2111bb970c78 ("net/mlx5: HWS, added backward-compatible API handling")
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c         | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 2a59be11fe55..adeccc588e5d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -1063,6 +1063,21 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 		return 0; /* rule inserted successfully */
 	}
 
+	/* Rule insertion could fail due to queue being full, timeout, or
+	 * matcher in resize. In such cases, no point in trying to rehash.
+	 */
+	if (ret == -EBUSY || ret == -ETIMEDOUT || ret == -EAGAIN) {
+		mutex_unlock(queue_lock);
+		mlx5hws_err(ctx,
+			    "BWC rule insertion failed - %s (%d)\n",
+			    ret == -EBUSY ? "queue is full" :
+			    ret == -ETIMEDOUT ? "timeout" :
+			    ret == -EAGAIN ? "matcher in resize" : "N/A",
+			    ret);
+		hws_bwc_rule_cnt_dec(bwc_rule);
+		return ret;
+	}
+
 	/* At this point the rule wasn't added.
 	 * It could be because there was collision, or some other problem.
 	 * Try rehash by size and insert rule again - last chance.
-- 
2.34.1


