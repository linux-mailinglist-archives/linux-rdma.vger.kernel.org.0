Return-Path: <linux-rdma+bounces-15971-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPIqIt7/dWmMKQEAu9opvQ
	(envelope-from <linux-rdma+bounces-15971-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:34:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D301804CB
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD9243008995
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 11:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AB531B124;
	Sun, 25 Jan 2026 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TY10XDG4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BC031AA95;
	Sun, 25 Jan 2026 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769340815; cv=fail; b=FgskJzuA08w/XsObTW0oezYlU/dCDFyfVttFwvNg1Jw8VyErUedx+ZH6T92cblkJBzYLwr65XiMIV+5RPiv7mvkKvN9ViB20BbW+gScU+W3yM17FShGXge2aadhmqqyPfvtdMv2S28aECl5f7Tl0XP+mIQQwsm+Ikmvs/ChSgA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769340815; c=relaxed/simple;
	bh=2k4iyQWzP6RlrsSJc+uJiicsIUlFSqxM0zOasboSqvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pL7QNKJhDT49SdcjlA8BZWRZ5a59rzRNuAo5gFHD3iI6URjjZtCpyZTfsNOODh2QjTg9JDzX2APM3afRycaIO6EGuXf/ho83vO8EhHJo8m0CQ6QZAcB3OqT/7RfDj4M5xeNhYfTLtTmBPd4/JgtsOPWsCsjAZGkcT7jbb8fD6+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TY10XDG4; arc=fail smtp.client-ip=52.101.61.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmVnhTa1hoofog3E8CIpTIuhEk5ps1N4DGgS6cpMjMdVICOGkxxshBYDGgNHug8Cjgy0VDhLxKisJR5esSzGtgn5AM2XaLz8XFQB6XA/JnCf1M7Uen4DfNICODblLr00Mf++GUl01r/xlKlYT/WambX01H1Rb9co2eNJst2X7YnZh0Qg7GRZcSBKG7U+P+Y1rXIEST7F9U1j/O4Cz3GaGn1/F10T8DQlulcG4qIrvjoir+6kF0sDnZEIiAnoxn4cO3x8DE+6ibwp5jcBz+3p22HwzVX6zdW9uewWByfzJS3WgjeXJZTGxtV9eX83Y4kEReenxCplhks+uNBgolvkrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lw3OdExdZL9j2yAW7FMv6igy2TVoyFPUGFT5CYF2gvQ=;
 b=bWFRPwkFf0GhoRHJ3/hKTaelfprNdf5EyRssVMCgFItBSL6Ko+vdZswhnPYb76HK4xzGM1xBySdFkpJnFNyzdp41O8G/Z8M1q6rb7HzeM0X8hVD7QaGaGmtdVd8BVoTTGoC1JTWg2kYZxLavhxMHTTUk9YXO4b922thLyb8NrHnFBYoPlUlqsLmwxEzdUyT9b22oU4nsxS5FsH0aLbvGdpJ4mKcQLTdBXLqdk96RSl67z1MKXq0E4Firqv+fs2YecOFSUgVcFl5HjJfvehD0ob7dGVWrgARvGQ0xJHxR4/UvCGhGa4N0AILQ0nTWM868L5dyuVaj61wMp/YhEPiUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw3OdExdZL9j2yAW7FMv6igy2TVoyFPUGFT5CYF2gvQ=;
 b=TY10XDG4pbLDnXDYM5TDHtVIrMu7JcmvbKetQfTgmiQof7SMMQyOstnjbVkAXamLh8h7w5ba6j6wkqlI84DkpHnctp/VQICdhKAx43HCCUUTDimCqRbJyhaJU3Lu6rztnqSX8b3fL+wEQs1spFkHINtmIJGlhysmPA1LzCPBKVhq7mjgpf4tyR671damQetfAuM/hGT9M94hPisS4roanbr93Xlu32nDubch+Ze2f5BDB9hQfqP3f0+5bboh/dUINLCzSHoL/7rM1OEX0kbKX2akvvUYSnA7W4KgldYwg8D1fHDEHijeyhvQW96yTQDr5J+/+7s8G24GYDK+bz2rPg==
Received: from SA9P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::21)
 by DS4PR12MB9564.namprd12.prod.outlook.com (2603:10b6:8:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 25 Jan
 2026 11:33:28 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::82) by SA9P221CA0016.outlook.office365.com
 (2603:10b6:806:25::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.14 via Frontend Transport; Sun,
 25 Jan 2026 11:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sun, 25 Jan 2026 11:33:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:33:19 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:33:18 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 25
 Jan 2026 03:33:13 -0800
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
Subject: [PATCH net-next V6 06/14] devlink: Decouple rate storage from associated devlink object
Date: Sun, 25 Jan 2026 13:31:55 +0200
Message-ID: <1769340723-14199-7-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1769340723-14199-1-git-send-email-tariqt@nvidia.com>
References: <1769340723-14199-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|DS4PR12MB9564:EE_
X-MS-Office365-Filtering-Correlation-Id: eb81a959-071d-49dd-931d-08de5c058f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?urzYjZRSF4tl2pEeP6pFfhcxHZ5q2d6EsBjE1krnlEoBdnPOT4cWFLXXUalR?=
 =?us-ascii?Q?HuXOcRgbCTzvfNzUcrVJcQT0MCcbgDgPUmzDu6nJu4p6EfTnfFTDYa21utqB?=
 =?us-ascii?Q?pEKuCPaQK4NRtrlavHWpKhh3Ih+cA0fS6Zsuvi4x1gDcCP2G1kACW0udNG2O?=
 =?us-ascii?Q?2xXk/z86P9jCcmKBShktI5h4WGo6QTME7GWQcj6mnDEUtKa2XD0fyus0Wuvm?=
 =?us-ascii?Q?6tVQbJizO79sV5Uz39tvJaZuenmsHkJdvyKxyRANSqDhfeaPyfW8YlX2thuo?=
 =?us-ascii?Q?RvBhfeSyBG6tlxzP7/UVVLdaBHz33svc2znLZAOJp8UCeaJaWD81X1XU3Icn?=
 =?us-ascii?Q?kfaOdULoTMSROI2Qs0KbNjI8KLtJEM1iQjszZsf4n0WxAcnZOjj3KR47H1Ub?=
 =?us-ascii?Q?uToj8SoyUbzaq8hF2IUmcvin4byXdASp/Clmp+FkT8eZSr3FdyA3FAr5dj80?=
 =?us-ascii?Q?MM/xs20Ua2Mwbm1OiMnRc2PYVqOgEv8UjIbRpmbAvtTOgXel1pCdPDMK5avl?=
 =?us-ascii?Q?LA8afe2eaWk2Ofm1rpOw5jg9ue+PFI3KMlTCrQhxAhs32IJL7q35kM7rFzTL?=
 =?us-ascii?Q?kzBT5yc81U9qrv/G2lpGSf21IDS1kTNe7COgSceagUsIItIyg4XUr0n/QyZg?=
 =?us-ascii?Q?ArUxro3r0zipdEZuEfIG/hJK+YNBa2RXrSly/nPmccfJH6JXkDNoclp5Sxuk?=
 =?us-ascii?Q?0/+mXBqlK7ClqoS/L2sqp2f3pHPA/1dMwmlGlFaCh8vv3OaP2in40rayWZm4?=
 =?us-ascii?Q?sf0Cdy6z7g9iuPGtpORIQalZcHueBqDEsx50kG1/WtOCxn53G4ULY3rJgr+s?=
 =?us-ascii?Q?q65xxYn+ExYYSk89xW4N7qiZJZRRrG5pdypBmgHEUvIFBfSG87U3enNlrZtU?=
 =?us-ascii?Q?Lz9flVZSuqfwVp4Q8OI1dzH2eanGdhMbtiC5joF5ng4OCUn1y4nbJ18ZObrw?=
 =?us-ascii?Q?5YH4vQ6tCvozoguZy1HXwi70t9iDa7zi5/wkNqzQ2BoAKfFnvw4Mmm4N4Eyk?=
 =?us-ascii?Q?ohBV5eg2b1BMLOIZGwv+DH8kU0YFSzMHyp2jTfR+vFMZMZLl66Nb7E4jSQHA?=
 =?us-ascii?Q?FiFMK6oMDZF9uJYvhHBOLg3YztGfwfUHgr9/ERwuLqba4jsMu+lQFPNEP+B9?=
 =?us-ascii?Q?YLSwIrPDExwL+3f171j4KDlcq0PvsyWfluRz6kBgangljB856L3YCB8L69zu?=
 =?us-ascii?Q?tETAmjMHA1OvfnocEVBj12JCQnI3fhuKg0HKFW2pB1F//rG3KI59+M715HRH?=
 =?us-ascii?Q?Z1Ow+6Vvfk/Ytlf9uHaE+HSAlEcjf0e7zdm8XxGs/f+MBxTQ6mtAfDzhwbHz?=
 =?us-ascii?Q?Ry3KmTUs6yvTdPWEWdrH52x0DCNpQstLVruGY3i3rqdK6tZfU+0BD19LHmmx?=
 =?us-ascii?Q?Kc26P33TtgLe+sflmC5N2YFd27m+P+54e4WuTKvhz85lNKX0PZPL1fzcTJvf?=
 =?us-ascii?Q?p1PayoyFazmBbVBJ82FvkJBYu1hXDwJuwXco4EaUym6/1dRQI6GFG/LdkK13?=
 =?us-ascii?Q?fQuUi284UuxZVDd14Op02VShLJJmYMkBImwYbIrEmHSmDUKmLv+q7yRrWJJc?=
 =?us-ascii?Q?l+MDISri/3BDuXofCk0wrNMmO0boxpDswCv3Kb1jl/pzQOkXNJdsQWODXeWf?=
 =?us-ascii?Q?1JQ5U949XhbiSpxxuaJ9hTagoS0cHTeb9l/VBrR2hs8CSSmgdTSrqqVPqRud?=
 =?us-ascii?Q?+WVwLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 11:33:28.2763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb81a959-071d-49dd-931d-08de5c058f6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9564
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
	TAGGED_FROM(0.00)[bounces-15971-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2D301804CB
X-Rspamd-Action: no action

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
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/net/devlink.h |   2 +
 net/devlink/rate.c    | 192 +++++++++++++++++++++++++++++++-----------
 2 files changed, 143 insertions(+), 51 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index c453faec8ebf..fbb434185a67 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1820,6 +1820,8 @@ void devlink_port_attrs_pci_sf_set(struct devlink_port *devlink_port,
 				   bool external);
 int devl_port_fn_devlink_set(struct devlink_port *devlink_port,
 			     struct devlink *fn_devlink);
+struct devlink *devl_rate_lock(struct devlink *devlink);
+void devl_rate_unlock(struct devlink *devlink);
 struct devlink_rate *
 devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 		      struct devlink_rate *parent);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 0d68b5c477dc..c062fd8a6c36 100644
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
@@ -209,17 +235,20 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
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
 
-		if (idx < state->idx) {
+		if (idx < state->idx || devlink_rate->devlink != devlink) {
 			idx++;
 			continue;
 		}
+
 		err = devlink_nl_rate_fill(msg, devlink_rate, cmd, id,
 					   cb->nlh->nlmsg_seq, flags, NULL);
 		if (err) {
@@ -228,6 +257,7 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 		}
 		idx++;
 	}
+	devl_rate_unlock(devlink);
 
 	return err;
 }
@@ -244,23 +274,33 @@ int devlink_nl_rate_get_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -590,24 +630,32 @@ int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -621,15 +669,21 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -648,8 +702,9 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_rate_set;
 
 	refcount_set(&rate_node->refcnt, 1);
-	list_add(&rate_node->list, &devlink->rate_list);
+	list_add(&rate_node->list, &rate_devlink->rate_list);
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	devl_rate_unlock(devlink);
 	return 0;
 
 err_rate_set:
@@ -658,6 +713,8 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	kfree(rate_node->name);
 err_strdup:
 	kfree(rate_node);
+unlock:
+	devl_rate_unlock(devlink);
 	return err;
 }
 
@@ -667,13 +724,17 @@ int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -684,6 +745,8 @@ int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 	list_del(&rate_node->list);
 	kfree(rate_node->name);
 	kfree(rate_node);
+unlock:
+	devl_rate_unlock(devlink);
 	return err;
 }
 
@@ -692,14 +755,20 @@ int devlink_rates_check(struct devlink *devlink,
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
@@ -716,14 +785,20 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
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
@@ -737,12 +812,15 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
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
@@ -758,10 +836,10 @@ EXPORT_SYMBOL_GPL(devl_rate_node_create);
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
@@ -770,6 +848,7 @@ int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
 	if (!devlink_rate)
 		return -ENOMEM;
 
+	rate_devlink = devl_rate_lock(devlink);
 	if (parent) {
 		devlink_rate->parent = parent;
 		refcount_inc(&devlink_rate->parent->refcnt);
@@ -779,9 +858,10 @@ int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
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
@@ -797,16 +877,19 @@ EXPORT_SYMBOL_GPL(devl_rate_leaf_create);
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
@@ -815,18 +898,22 @@ EXPORT_SYMBOL_GPL(devl_rate_leaf_destroy);
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
@@ -839,13 +926,16 @@ void devl_rate_nodes_destroy(struct devlink *devlink)
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
2.40.1


