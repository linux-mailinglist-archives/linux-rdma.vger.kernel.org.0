Return-Path: <linux-rdma+bounces-14642-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D2DC74213
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1299B349E2F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 13:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF2833ADAD;
	Thu, 20 Nov 2025 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DkWLvdmP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921D1333755;
	Thu, 20 Nov 2025 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644448; cv=fail; b=tuwnX8UH2aq1cE5rQxlbxTPTDgtXsJgc5Vbjbhjoz53tz29/8d/EHLHx++pMPFIX0IWTlxBMn21mzR8Yz5JIls3UhH/8bAoum0VzavomusigtOqHT74eFiKvJEGSd5007L98Lt6G720f/Xw2XLAsiQI7V3ezfwLwk2/ouC3gpG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644448; c=relaxed/simple;
	bh=U2TYAyDQgwUfleqgjbj55T4WckZEKGbANv1FS+qIZG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sclpPDQOpaKKRnH8jx0+p/Spm4nxDp725k0jzrLReH/3KvZ7Lb0WNU8AKUtcFJxT+khx2JQlT61D36Eq1aze6QvQNQw8jMBxpn4380sfW1LBc0+akm5MESLtFmWLsGMbLh3BTvd5yffU5QhLoyuuv/9WexVbe3XjyyIsLNiJSkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DkWLvdmP; arc=fail smtp.client-ip=40.107.209.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2aVvfaUibCId0Jvqi2B0HR64aaMnvhe3amdC/Fhl26o8ghUWDGLkdi2noD3Qd9qwkDIarGMDQ58h+a6G8oiMlWT5PnhbqKZy6QdbiHJIYns4QNK22kKyYKun0N+ebfAZs8GaFdnD1EZB+c9SteY6bF+sFkjs4Cfwkmmi03E729XNMfOQaeXgCKam9hpVZ1Ee5I0wKAZ/eSbxvJTskWgV2xeDDt00JNyvO7K0nNt9pD9R3VjtESlKZTYi+u4I0iDAf+/i4JNkIO7SljZRrThqc9q4/w61g/EKI7z5n5qr+A/Zi8sL8QxMAlqvkH4H881WqcQhBhkP1pDEAFnpP2f4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZJP9aS/I2FNomzxPhrDzIBEkQ3Dah57Fn5YpEF2TI8=;
 b=Kl3RYaCKFOV7OAMSUN03sMarEkKZQQvewsyQK1mVyLhn6U6BWazCuqOy15U4VF2aQempoibimxuRIFIiEMBi62fu87ggCRREkZiM3B4eSAgK4wHXYPT4U2idB92PKDyVzScK4oN0Lx74Ef3Swst8NuO1yXkzytd2wLPug14+Opls2fR4+W4V3jv0LsogDb4DreZlpJqVsn8F4tXwXU7mFJIU34uPq5KuBLR4bzdJaRexqOaguH2p1ysUNiJPaiE/Uh1M4mlDsMAvnXDQvY+xZPyiSLmudyIu02fm/n+QxeS1MiZK4pSfU5wtvn+CHMYwh7u3Wumz7R+DajoFA5QMcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZJP9aS/I2FNomzxPhrDzIBEkQ3Dah57Fn5YpEF2TI8=;
 b=DkWLvdmPpKjAyAmdm+WircvAlofF8oXwK6TGfsbBFDQuM+2Of4lLwhL+4CTniweg78ZprjJ5gBCWGKGXKoiDlutC2tAvnlbEnXxk4bitjFMFQGthqVxkMiacCf5RUokPQ9tnuOSHNFwqqaPagHOCV9fVfby93Wxon7EIYc6TxHedd49N2hf457+CGtm/1Vnjr+cE9ZjRgxhXNRe4VbA3cZlE4Suj0o98cUpWmg8sjL5iGpa4QnAyiDHwCja/zXrpt0L9kYSKDmq/L0RZSYorJ8cwPXQBc/90mboXWjsJWrTCSmate6UDVBpyseJeDN7b8qgzYAD8MMr6l8m3I96ZOQ==
Received: from SA1P222CA0114.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::21)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 13:13:59 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::40) by SA1P222CA0114.outlook.office365.com
 (2603:10b6:806:3c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 20 Nov 2025 13:13:58 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:13:40 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:13:40 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 20
 Nov 2025 05:13:34 -0800
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
Subject: [PATCH net-next 05/14] devlink: Decouple rate storage from associated devlink object
Date: Thu, 20 Nov 2025 15:09:17 +0200
Message-ID: <1763644166-1250608-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
References: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: d8befb13-57e0-433f-7701-08de2836aa7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3tX3opQW2EET2D3KJjiHVS7MEV0r6cizZUrxIYbxohqwh/5c+FFN0ypjLrRx?=
 =?us-ascii?Q?RXW1RvRKJj4CnyThOzFRERnYCJyRqxSGJ5vMBYCrQSx5nKQGBrycb6/rp7mQ?=
 =?us-ascii?Q?ji1ZeNQhtq7i1pSmWYxt2ytk3c3tTy1/5ijq5VZDBTtEBJ7MkZin4moUW++9?=
 =?us-ascii?Q?QDOvKyhz8S4Nixvt3RoezPcJW9AYjEYkpAblunvFRGGVItrFtLC+HbiWaFKv?=
 =?us-ascii?Q?9QyJpKWAAZdeHZ9Yynota32SZ6107FEzlOfkreovQBXFWZBnyKW2+TcU0qqD?=
 =?us-ascii?Q?iNMsicGso96OF43y8EITeShQXwXE5td2JC5ht5ZiNVjRYX3kff2u/GpnUeB5?=
 =?us-ascii?Q?zoJf/teL9U9lff0zpeixudYAjDa/Ib6i8ZQT6HeMtyGloyMuMbq8QS6SGGVf?=
 =?us-ascii?Q?N/YOuAi+q3Oo9huPkwvWS1dtwPOa6obxpnYHNEDztZqPkRzKWihCJRbyMkf4?=
 =?us-ascii?Q?wpLDOxBULbYkgxo52X+Nv7Q9Y5xWyWMZvhEEgtmiUx5uJLmkXHRP7K6lXxL4?=
 =?us-ascii?Q?x3ukoXZTTlvz+Ry2AbndyqJpxZFQ/4BMs4nlQ3LJ6cRc4umqSSMI5kl7wH57?=
 =?us-ascii?Q?kK51kHh/buGNg/MgkveDfEE1UJEtAQQ1TxF5LClJhB+UJCUtf6x+bkIt71D9?=
 =?us-ascii?Q?juSRlJg8h+qlzNhpMzw4JoMqytWukiO7lelxiYvg1KSLeb1T0U7sRJQvCXaO?=
 =?us-ascii?Q?PlzaJI/Kb6sv4xM7j/OMqY6efxS0KJ6L+irc5t5bFzbwBS2VRudpUFBaNGSs?=
 =?us-ascii?Q?X9SvTLnsT2+C1+x/WDiUVvD8LpVTNEAnW0fSPkdBwWXwEbPX4hffztb8VdLX?=
 =?us-ascii?Q?pwqoDvuyZRGjDap0QQMzmiaG0A1GzXGcAnzXW/oXc1JP/OZ4GgRibExP/a+z?=
 =?us-ascii?Q?hjb7GECg5ZeaSgrAE2ngdixhKcTK31hiixM1gbOjVECYhV34sfZMhEjJWCWK?=
 =?us-ascii?Q?lql6drSHVDoEnWKbSXiN7sVQ5UrG3NRjEzBo7/l2Xcf0wlEjoD/y+XAJolg5?=
 =?us-ascii?Q?L6q4s91NlroR/3QuCAFG1hlcscFf1WXke2Cc3YbLOLPDSnqK8+yej/+zZAAE?=
 =?us-ascii?Q?t2r/j3P8XbOZByfpJf9ImG41KcEkG47OEUt10SdO1BSmkiP0VWIkc53eLiMM?=
 =?us-ascii?Q?SQsXF5xkOyy9fY5/nEDfXNhyw+TZAN0k5xgHkEJ7Uk8KR0b/LsRT0CJ9a6Sg?=
 =?us-ascii?Q?bZolatGZ88zYv1tZM+1qceV9Rsw5pOT3aCyAHQ4rGWcL7vBw66/cXato7+j1?=
 =?us-ascii?Q?hac2ukYh0HUu75ZAkwROMSwNiM64dGp9F40aAZIFCYVZD9a0+ztVyWj8TpH+?=
 =?us-ascii?Q?DDqWu7nidBi0uaRO0kBdKGHUem35q/YdEb63EifLXSpFZNFDYJqwmRjxKTj1?=
 =?us-ascii?Q?fla136ZFjBatf9lXTajpeJmkxdSe88o9ZadGVYhBXqka0E3zMax2707gFMJa?=
 =?us-ascii?Q?4Q+kbYAlm5O9VW5CM+EaeTyUG9bcZvcjHQYIh4ZuIs6jut7EdM3wIt1XnbUu?=
 =?us-ascii?Q?HjL627UPGSkDiVC5OQ/VDLMBP1ZIah2yLryotEd/UbTxse8pVj9oMQwtHx/L?=
 =?us-ascii?Q?SRGCC/DIRzGl7g9A/9k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:13:58.5287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8befb13-57e0-433f-7701-08de2836aa7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406

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
index d01046ef0577..7e7789098f0e 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1771,6 +1771,8 @@ void devlink_port_attrs_pci_sf_set(struct devlink_port *devlink_port,
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


