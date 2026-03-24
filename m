Return-Path: <linux-rdma+bounces-18567-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFTIOB6FwmkAegQAu9opvQ
	(envelope-from <linux-rdma+bounces-18567-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:35:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4253085AC
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD287315F12D
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBA93F7E75;
	Tue, 24 Mar 2026 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iWCGPUoF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1875B3F7E73;
	Tue, 24 Mar 2026 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355424; cv=fail; b=lmAMoJBVezwPfbCueo1AUgOH6lE73oSiGgft0CufI6UE16Xy+60upv43MLLxfNV9r7ZZ1NWIr18XBnF3vK+290tOp+YZoRjccuH8Sd5TutUYkXILtoIVCWYnjOSRA3h4JjKtUSOsiSPyQIpVblnxqxJ86UKuZ7kZSDv9Qpy41gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355424; c=relaxed/simple;
	bh=HffbYagBGF96jSWJsEuQ48htMMwKk20FWYY7/ZVST5I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWmnSFGx7QPV/lG8zeLZGMB8k6Mlii6onymRssPKjz7kvGhDOQH8Dddbb72Ytw5NVGR9gqhO7MGQbKobg0kmCZcirbO+WXGyLptiw+D6aEKMGH6MVv2mOJ2Zm3tAlXkD87NW1ArWiONj+SEMujL6nIYhzLz7Q4HcEy0exNdjOrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iWCGPUoF; arc=fail smtp.client-ip=52.101.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAJl80mSdl5n8+dNqa+uzlJfBYlbde8rBsWlpzbJGOiYyweBw05r0vYSN4+QdlCOCGILXhm6t4yHZZIPfDJY9ruGKT+HybvV1PQXoNMt773vv4rpXbvhMgtzZ6qmQcC+4LtKbInHadUTz2CXCf8g8VChu//bHY88UQLTofHFhCvx8lHt1OI9/A7j4n7jgiuZCO261dsdOX39b/AQfoSh/JAnPDElG/k8SziF7k2IyEqNPfeLZEMf4BhkWkEtxrFgSnpE5dejJN2RlnfNjDolZ/CJJ7rhOL8Avcwv6brFV6BBzKGG0RcS1NWLkVSy+jyDHGKS08KSmYxiRCljiDe7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rdus4tQiTn3x/J4ZBpefcJjTzoVcuA51JzrwDfOhvzE=;
 b=vn1xw5NFdzdKAx9c6TKXaP4e0QYjcI7Ugxk5gGxZjiKfMM3+l3TWovUQtwU8AZy8VThHZebUJPiGJUIkjzsR3GxrqtIWGQLhhEof23b6hRcORFvgo3DKjupspoQloiJ5PQ5fS4IwMxfuIKWNnva59ze9YGPyWFqROzWVVsisvG+vpZ8g5v+itoO8tABG+am66HKBdSczsyIGONR/R+1QgeiucH2W7VeacE4CGubYYC7Jib0tTf9jBPxgdxPDBQGt+T26iqpiQbebFbS6LlHmyWYvv7X/VRHwOaa7Nd2WpyKP1ksqZHXPdbpsiboeD1+ngaeEM0kdKZ8qMRVjX6VYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rdus4tQiTn3x/J4ZBpefcJjTzoVcuA51JzrwDfOhvzE=;
 b=iWCGPUoFuQWAobtiaJscpxv2oO9SOEg1xlFLkOTTUPu7X/qnaDPIQuC4GTbILIdGTBS5noup76n5aur9l2exnfrH6UbBonB6pcLIGzsJogFbi9Qmkw3dAGGlGdkp5xa+77jrwRa7unoiKwkUvNDYx19BQnRhhN8Gjv4yVbNaqz1F9PKWMdaBqS4wPuiNN2vTQaCK6ULJfP5yTkJOaq9bURDZR5yqiHiQKLNL5KbwMp7H+0NktFTAiLqNe+hdufqY5UoBOwHH4pTQkCcd4ZDlt60i8A0oTSalEtk3Jn23EZKZIq13d4tOcPRf5n+BM1YmncLfezATu8Ex9t+xOH/F5A==
Received: from SA0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:806:130::21)
 by SJ2PR12MB9139.namprd12.prod.outlook.com (2603:10b6:a03:564::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:30:08 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:130:cafe::9e) by SA0PR13CA0016.outlook.office365.com
 (2603:10b6:806:130::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:30:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:30:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:29:53 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:29:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 24
 Mar 2026 05:29:44 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Chuck Lever <chuck.lever@oracle.com>, "Matthieu Baerts
 (NGI0)" <matttbe@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Shay
 Drory" <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Willem de Bruijn <willemb@google.com>, David Wei
	<dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net-next V8 03/14] devlink: Migrate from info->user_ptr to info->ctx
Date: Tue, 24 Mar 2026 14:28:37 +0200
Message-ID: <20260324122848.36731-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260324122848.36731-1-tariqt@nvidia.com>
References: <20260324122848.36731-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|SJ2PR12MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: f94a03f5-fa76-471a-932b-08de89a115af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	58CQ+p8xoLqVuOATmv1rRZYHWI/7gP/48wE5GXXUe/9Xoe9wchTu9a/0GwocIt2vZSIkeOog9HK0+VEhajri1ePxpA6v/9P++BR4i9v6RL1GPreOxvu17w45p0qzVKUDY+80sl5X3R07ALjb7yJvM/8visAzGR/qHzvUNt5CCxiNY+ZedoSe15i6GTVVofRQaN1e/uDWLSotr8zso7M8M1IqUuwez76AW6Bu6nt4wLJDePZZwBU/vzqHNEHaTCFVlP2UkHGVxBIPmeSrT+cJtUSawivbtaLZr8Yl58tpTK4J7kLwbtE/bZUjOG5Himp6LSSo1uW5NujmHsylUTtMejj6pqvGWIVXCfxuNO7ACON34GO2JuD4T7H/1Jj6Zw0gHf/fdQvUvaWE+28r/yl558EUMFrz7wI2YvkNMoL6+5885e7A5ust78dt8Ep52XYvaKX+0ekPiP8ke832E54iTkVu71dyiulqdkg4lfk5osLXdUQ9kP1+YD3fyeJe0fMnK+ZyLaMozaWze9yNsTcvRudwSVe0TjPBqh30bsanFyfk3bDtL97BepKmO9nRFYV7ts3yePL1AP3mUKttOe7bONfH8AjcXUG4XyhmwQmmqC3C98Dzv4YACXyfsVUOyeQfqOUR6JDTQjY9EK7wZWFHHibgE3AdhAkfYRAxSDsxzdS7SP5l3J12+XfzCpIqM3Ym2vVMmNLhxzQ0EUMtG+qtEyRBjYg3DkE4Di8GeanQGqcWEJfQKTw64GOoQvVtYyGaeBSB9GqrmWzYuKeI08Kr6A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QwUQLubO3xp8+tJ6cE8VTAYkdG0gOB8I1QZ6Qad0k3lAkE/iIiHGKCBI/fnB/4/B1G/U2WEBOr3nys+h6mSeqZDli2eXQclwWqou/2QAxgJRAOHPVfq+IWK5pBpBFePVHEfvMZVy8BuxtY+WxHXOBTt00oYk247lvYJk46XXyTZoDbtaO7Cn5SrS1456ul29mD5qhSRSVVMijSHB4CrxEUm4m8egGAXk+QFCJvraPv+DtzcsGtk5SwdUsPOzN8KJdnyI9kQ1BjDCgP/IOW3ODt5oXccaKPuW/UgF3KM0CjE53TWkNP83CUvrLROd9cTTWLOwjI2Exl4dyihx1xV5lpWt+xe+pjzmToX1lf6L00UzYdQ8Ht/E4NR1qyGRIQEb1bzsfJ6N68MN+n66wkZtWA9h6PJYiWPsN3sFF/O9I1cj8tMU6PjvvZVPV+6/rCQe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:30:07.7091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f94a03f5-fa76-471a-932b-08de89a115af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9139
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,google.com,davidwei.uk,fomichev.me,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18567-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8A4253085AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

Replace deprecated info->user_ptr[0]/[1] with a typed
devlink_nl_ctx struct stored in info->ctx. The struct aliases
the same union memory, so the migration is safe.

There are no functionality changes here.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/dev.c           | 16 ++++++++--------
 net/devlink/devl_internal.h | 13 +++++++++++++
 net/devlink/dpipe.c         | 14 +++++++-------
 net/devlink/health.c        | 12 ++++++------
 net/devlink/linecard.c      |  4 ++--
 net/devlink/netlink.c       |  8 ++++----
 net/devlink/param.c         |  4 ++--
 net/devlink/port.c          | 18 +++++++++---------
 net/devlink/rate.c          |  8 ++++----
 net/devlink/region.c        |  6 +++---
 net/devlink/resource.c      |  6 +++---
 net/devlink/sb.c            | 22 +++++++++++-----------
 net/devlink/trap.c          | 12 ++++++------
 13 files changed, 78 insertions(+), 65 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 57b2b8f03543..bcf001554e84 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -222,7 +222,7 @@ static void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
 
 int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct sk_buff *msg;
 	int err;
 
@@ -519,7 +519,7 @@ devlink_nl_reload_actions_performed_snd(struct devlink *devlink, u32 actions_per
 
 int devlink_nl_reload_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	enum devlink_reload_action action;
 	enum devlink_reload_limit limit;
 	struct net *dest_net = NULL;
@@ -683,7 +683,7 @@ static int devlink_nl_eswitch_fill(struct sk_buff *msg, struct devlink *devlink,
 
 int devlink_nl_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct sk_buff *msg;
 	int err;
 
@@ -704,7 +704,7 @@ int devlink_nl_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	const struct devlink_ops *ops = devlink->ops;
 	enum devlink_eswitch_encap_mode encap_mode;
 	u8 inline_mode;
@@ -906,7 +906,7 @@ devlink_nl_info_fill(struct sk_buff *msg, struct devlink *devlink,
 
 int devlink_nl_info_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct sk_buff *msg;
 	int err;
 
@@ -1134,7 +1134,7 @@ int devlink_nl_flash_update_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *nla_overwrite_mask, *nla_file_name;
 	struct devlink_flash_update_params params = {};
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	const char *file_name;
 	u32 supported_params;
 	int ret;
@@ -1302,7 +1302,7 @@ devlink_nl_selftests_fill(struct sk_buff *msg, struct devlink *devlink,
 
 int devlink_nl_selftests_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct sk_buff *msg;
 	int err;
 
@@ -1372,7 +1372,7 @@ static const struct nla_policy devlink_selftest_nl_policy[DEVLINK_ATTR_SELFTEST_
 int devlink_nl_selftests_run_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *tb[DEVLINK_ATTR_SELFTEST_ID_MAX + 1];
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct nlattr *attrs, *selftests;
 	struct sk_buff *msg;
 	void *hdr;
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 3b4364677b18..1af445f044e5 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -150,6 +150,19 @@ int devlink_rel_devlink_handle_put(struct sk_buff *msg, struct devlink *devlink,
 				   bool *msg_updated);
 
 /* Netlink */
+struct devlink_nl_ctx {
+	struct devlink *devlink;
+	struct devlink_port *devlink_port;
+};
+
+static inline struct devlink_nl_ctx *
+devlink_nl_ctx(struct genl_info *info)
+{
+	BUILD_BUG_ON(sizeof(struct devlink_nl_ctx) >
+		     sizeof_field(struct genl_info, ctx));
+	return (struct devlink_nl_ctx *)info->ctx;
+}
+
 enum devlink_multicast_groups {
 	DEVLINK_MCGRP_CONFIG,
 };
diff --git a/net/devlink/dpipe.c b/net/devlink/dpipe.c
index c8d4a4374ae1..08c7b66fc3e8 100644
--- a/net/devlink/dpipe.c
+++ b/net/devlink/dpipe.c
@@ -213,7 +213,7 @@ static int devlink_dpipe_tables_fill(struct genl_info *info,
 				     struct list_head *dpipe_tables,
 				     const char *table_name)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_dpipe_table *table;
 	struct nlattr *tables_attr;
 	struct sk_buff *skb = NULL;
@@ -290,7 +290,7 @@ static int devlink_dpipe_tables_fill(struct genl_info *info,
 
 int devlink_nl_dpipe_table_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	const char *table_name =  NULL;
 
 	if (info->attrs[DEVLINK_ATTR_DPIPE_TABLE_NAME])
@@ -478,7 +478,7 @@ int devlink_dpipe_entry_ctx_prepare(struct devlink_dpipe_dump_ctx *dump_ctx)
 	if (!dump_ctx->hdr)
 		goto nla_put_failure;
 
-	devlink = dump_ctx->info->user_ptr[0];
+	devlink = devlink_nl_ctx(dump_ctx->info)->devlink;
 	if (devlink_nl_put_handle(dump_ctx->skb, devlink))
 		goto nla_put_failure;
 	dump_ctx->nest = nla_nest_start_noflag(dump_ctx->skb,
@@ -563,7 +563,7 @@ static int devlink_dpipe_entries_fill(struct genl_info *info,
 int devlink_nl_dpipe_entries_get_doit(struct sk_buff *skb,
 				      struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_dpipe_table *table;
 	const char *table_name;
 
@@ -650,7 +650,7 @@ static int devlink_dpipe_headers_fill(struct genl_info *info,
 				      struct devlink_dpipe_headers *
 				      dpipe_headers)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct nlattr *headers_attr;
 	struct sk_buff *skb = NULL;
 	struct nlmsghdr *nlh;
@@ -713,7 +713,7 @@ static int devlink_dpipe_headers_fill(struct genl_info *info,
 int devlink_nl_dpipe_headers_get_doit(struct sk_buff *skb,
 				      struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 
 	if (!devlink->dpipe_headers)
 		return -EOPNOTSUPP;
@@ -747,7 +747,7 @@ static int devlink_dpipe_table_counters_set(struct devlink *devlink,
 int devlink_nl_dpipe_table_counters_set_doit(struct sk_buff *skb,
 					     struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	const char *table_name;
 	bool counters_enable;
 
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 449c7611c640..7ff0d707734a 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -358,7 +358,7 @@ devlink_health_reporter_get_from_info(struct devlink *devlink,
 int devlink_nl_health_reporter_get_doit(struct sk_buff *skb,
 					struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_health_reporter *reporter;
 	struct sk_buff *msg;
 	int err;
@@ -456,7 +456,7 @@ int devlink_nl_health_reporter_get_dumpit(struct sk_buff *skb,
 int devlink_nl_health_reporter_set_doit(struct sk_buff *skb,
 					struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_health_reporter *reporter;
 
 	reporter = devlink_health_reporter_get_from_info(devlink, info);
@@ -715,7 +715,7 @@ EXPORT_SYMBOL_GPL(devlink_health_reporter_state_update);
 int devlink_nl_health_reporter_recover_doit(struct sk_buff *skb,
 					    struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_health_reporter *reporter;
 
 	reporter = devlink_health_reporter_get_from_info(devlink, info);
@@ -1157,7 +1157,7 @@ static int devlink_fmsg_dumpit(struct devlink_fmsg *fmsg, struct sk_buff *skb,
 int devlink_nl_health_reporter_diagnose_doit(struct sk_buff *skb,
 					     struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_health_reporter *reporter;
 	struct devlink_fmsg *fmsg;
 	int err;
@@ -1252,7 +1252,7 @@ int devlink_nl_health_reporter_dump_get_dumpit(struct sk_buff *skb,
 int devlink_nl_health_reporter_dump_clear_doit(struct sk_buff *skb,
 					       struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_health_reporter *reporter;
 
 	reporter = devlink_health_reporter_get_from_info(devlink, info);
@@ -1269,7 +1269,7 @@ int devlink_nl_health_reporter_dump_clear_doit(struct sk_buff *skb,
 int devlink_nl_health_reporter_test_doit(struct sk_buff *skb,
 					 struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_health_reporter *reporter;
 
 	reporter = devlink_health_reporter_get_from_info(devlink, info);
diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
index 8315d35cb91d..fd18f2759770 100644
--- a/net/devlink/linecard.c
+++ b/net/devlink/linecard.c
@@ -171,7 +171,7 @@ void devlink_linecards_notify_unregister(struct devlink *devlink)
 
 int devlink_nl_linecard_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_linecard *linecard;
 	struct sk_buff *msg;
 	int err;
@@ -371,7 +371,7 @@ static int devlink_linecard_type_unset(struct devlink_linecard *linecard,
 int devlink_nl_linecard_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_linecard *linecard;
 	int err;
 
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 32ddbe244cb7..5624cf71592f 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -252,18 +252,18 @@ static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 	if (IS_ERR(devlink))
 		return PTR_ERR(devlink);
 
-	info->user_ptr[0] = devlink;
+	devlink_nl_ctx(info)->devlink = devlink;
 	if (flags & DEVLINK_NL_FLAG_NEED_PORT) {
 		devlink_port = devlink_port_get_from_info(devlink, info);
 		if (IS_ERR(devlink_port)) {
 			err = PTR_ERR(devlink_port);
 			goto unlock;
 		}
-		info->user_ptr[1] = devlink_port;
+		devlink_nl_ctx(info)->devlink_port = devlink_port;
 	} else if (flags & DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT) {
 		devlink_port = devlink_port_get_from_info(devlink, info);
 		if (!IS_ERR(devlink_port))
-			info->user_ptr[1] = devlink_port;
+			devlink_nl_ctx(info)->devlink_port = devlink_port;
 	}
 	return 0;
 
@@ -304,7 +304,7 @@ static void __devlink_nl_post_doit(struct sk_buff *skb, struct genl_info *info,
 	bool dev_lock = flags & DEVLINK_NL_FLAG_NEED_DEV_LOCK;
 	struct devlink *devlink;
 
-	devlink = info->user_ptr[0];
+	devlink = devlink_nl_ctx(info)->devlink;
 	devl_dev_unlock(devlink, dev_lock);
 	devlink_put(devlink);
 }
diff --git a/net/devlink/param.c b/net/devlink/param.c
index cf95268da5b0..201e0619683b 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -566,7 +566,7 @@ devlink_param_get_from_info(struct xarray *params, struct genl_info *info)
 int devlink_nl_param_get_doit(struct sk_buff *skb,
 			      struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_param_item *param_item;
 	struct sk_buff *msg;
 	int err;
@@ -667,7 +667,7 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 
 int devlink_nl_param_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 
 	return __devlink_nl_cmd_param_set_doit(devlink, 0, &devlink->params,
 					       info, DEVLINK_CMD_PARAM_NEW);
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 7fcd1d3ed44c..93b4a45892e0 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -594,7 +594,7 @@ void devlink_ports_notify_unregister(struct devlink *devlink)
 
 int devlink_nl_port_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
+	struct devlink_port *devlink_port = devlink_nl_ctx(info)->devlink_port;
 	struct sk_buff *msg;
 	int err;
 
@@ -830,7 +830,7 @@ static int devlink_port_function_set(struct devlink_port *port,
 
 int devlink_nl_port_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
+	struct devlink_port *devlink_port = devlink_nl_ctx(info)->devlink_port;
 	int err;
 
 	if (info->attrs[DEVLINK_ATTR_PORT_TYPE]) {
@@ -856,8 +856,8 @@ int devlink_nl_port_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 int devlink_nl_port_split_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_port *devlink_port = devlink_nl_ctx(info)->devlink_port;
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	u32 count;
 
 	if (GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_PORT_SPLIT_COUNT))
@@ -887,8 +887,8 @@ int devlink_nl_port_split_doit(struct sk_buff *skb, struct genl_info *info)
 
 int devlink_nl_port_unsplit_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_port *devlink_port = devlink_nl_ctx(info)->devlink_port;
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 
 	if (!devlink_port->ops->port_unsplit)
 		return -EOPNOTSUPP;
@@ -899,7 +899,7 @@ int devlink_nl_port_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
 	struct devlink_port_new_attrs new_attrs = {};
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_port *devlink_port;
 	struct sk_buff *msg;
 	int err;
@@ -961,9 +961,9 @@ int devlink_nl_port_new_doit(struct sk_buff *skb, struct genl_info *info)
 
 int devlink_nl_port_del_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
+	struct devlink_port *devlink_port = devlink_nl_ctx(info)->devlink_port;
 	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 
 	if (!devlink_port->ops->port_del)
 		return -EOPNOTSUPP;
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 41be2d6c2954..478142910919 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -239,7 +239,7 @@ int devlink_nl_rate_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 int devlink_nl_rate_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_rate *devlink_rate;
 	struct sk_buff *msg;
 	int err;
@@ -585,7 +585,7 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 
 int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_rate *devlink_rate;
 	const struct devlink_ops *ops;
 	int err;
@@ -607,7 +607,7 @@ int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_rate *rate_node;
 	const struct devlink_ops *ops;
 	int err;
@@ -663,7 +663,7 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 
 int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_rate *rate_node;
 	int err;
 
diff --git a/net/devlink/region.c b/net/devlink/region.c
index 5588e3d560b9..537779bbff07 100644
--- a/net/devlink/region.c
+++ b/net/devlink/region.c
@@ -469,7 +469,7 @@ static void devlink_region_snapshot_del(struct devlink_region *region,
 
 int devlink_nl_region_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_port *port = NULL;
 	struct devlink_region *region;
 	const char *region_name;
@@ -588,7 +588,7 @@ int devlink_nl_region_get_dumpit(struct sk_buff *skb,
 
 int devlink_nl_region_del_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_snapshot *snapshot;
 	struct devlink_port *port = NULL;
 	struct devlink_region *region;
@@ -633,7 +633,7 @@ int devlink_nl_region_del_doit(struct sk_buff *skb, struct genl_info *info)
 
 int devlink_nl_region_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_snapshot *snapshot;
 	struct devlink_port *port = NULL;
 	struct nlattr *snapshot_id_attr;
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 351835a710b1..763355d22517 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -107,7 +107,7 @@ devlink_resource_validate_size(struct devlink_resource *resource, u64 size,
 
 int devlink_nl_resource_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_resource *resource;
 	u64 resource_id;
 	u64 size;
@@ -216,7 +216,7 @@ static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
 static int devlink_resource_fill(struct genl_info *info,
 				 enum devlink_command cmd, int flags)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_resource *resource;
 	struct nlattr *resources_attr;
 	struct sk_buff *skb = NULL;
@@ -284,7 +284,7 @@ static int devlink_resource_fill(struct genl_info *info,
 
 int devlink_nl_resource_dump_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 
 	if (list_empty(&devlink->resource_list))
 		return -EOPNOTSUPP;
diff --git a/net/devlink/sb.c b/net/devlink/sb.c
index 49fcbfe08f15..129bd016e302 100644
--- a/net/devlink/sb.c
+++ b/net/devlink/sb.c
@@ -204,7 +204,7 @@ static int devlink_nl_sb_fill(struct sk_buff *msg, struct devlink *devlink,
 
 int devlink_nl_sb_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_sb *devlink_sb;
 	struct sk_buff *msg;
 	int err;
@@ -306,7 +306,7 @@ static int devlink_nl_sb_pool_fill(struct sk_buff *msg, struct devlink *devlink,
 
 int devlink_nl_sb_pool_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_sb *devlink_sb;
 	struct sk_buff *msg;
 	u16 pool_index;
@@ -415,7 +415,7 @@ static int devlink_sb_pool_set(struct devlink *devlink, unsigned int sb_index,
 
 int devlink_nl_sb_pool_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	enum devlink_sb_threshold_type threshold_type;
 	struct devlink_sb *devlink_sb;
 	u16 pool_index;
@@ -506,7 +506,7 @@ static int devlink_nl_sb_port_pool_fill(struct sk_buff *msg,
 int devlink_nl_sb_port_pool_get_doit(struct sk_buff *skb,
 				     struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
+	struct devlink_port *devlink_port = devlink_nl_ctx(info)->devlink_port;
 	struct devlink *devlink = devlink_port->devlink;
 	struct devlink_sb *devlink_sb;
 	struct sk_buff *msg;
@@ -624,8 +624,8 @@ static int devlink_sb_port_pool_set(struct devlink_port *devlink_port,
 int devlink_nl_sb_port_pool_set_doit(struct sk_buff *skb,
 				     struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_port *devlink_port = devlink_nl_ctx(info)->devlink_port;
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_sb *devlink_sb;
 	u16 pool_index;
 	u32 threshold;
@@ -716,7 +716,7 @@ devlink_nl_sb_tc_pool_bind_fill(struct sk_buff *msg, struct devlink *devlink,
 int devlink_nl_sb_tc_pool_bind_get_doit(struct sk_buff *skb,
 					struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
+	struct devlink_port *devlink_port = devlink_nl_ctx(info)->devlink_port;
 	struct devlink *devlink = devlink_port->devlink;
 	struct devlink_sb *devlink_sb;
 	struct sk_buff *msg;
@@ -864,8 +864,8 @@ static int devlink_sb_tc_pool_bind_set(struct devlink_port *devlink_port,
 int devlink_nl_sb_tc_pool_bind_set_doit(struct sk_buff *skb,
 					struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_port *devlink_port = devlink_nl_ctx(info)->devlink_port;
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	enum devlink_sb_pool_type pool_type;
 	struct devlink_sb *devlink_sb;
 	u16 tc_index;
@@ -902,7 +902,7 @@ int devlink_nl_sb_tc_pool_bind_set_doit(struct sk_buff *skb,
 
 int devlink_nl_sb_occ_snapshot_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	const struct devlink_ops *ops = devlink->ops;
 	struct devlink_sb *devlink_sb;
 
@@ -918,7 +918,7 @@ int devlink_nl_sb_occ_snapshot_doit(struct sk_buff *skb, struct genl_info *info)
 int devlink_nl_sb_occ_max_clear_doit(struct sk_buff *skb,
 				     struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	const struct devlink_ops *ops = devlink->ops;
 	struct devlink_sb *devlink_sb;
 
diff --git a/net/devlink/trap.c b/net/devlink/trap.c
index 8edb31654a68..793ffc66dc11 100644
--- a/net/devlink/trap.c
+++ b/net/devlink/trap.c
@@ -302,7 +302,7 @@ static int devlink_nl_trap_fill(struct sk_buff *msg, struct devlink *devlink,
 int devlink_nl_trap_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_trap_item *trap_item;
 	struct sk_buff *msg;
 	int err;
@@ -412,7 +412,7 @@ static int devlink_trap_action_set(struct devlink *devlink,
 int devlink_nl_trap_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_trap_item *trap_item;
 
 	if (list_empty(&devlink->trap_list))
@@ -511,7 +511,7 @@ devlink_nl_trap_group_fill(struct sk_buff *msg, struct devlink *devlink,
 int devlink_nl_trap_group_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_trap_group_item *group_item;
 	struct sk_buff *msg;
 	int err;
@@ -682,7 +682,7 @@ static int devlink_trap_group_set(struct devlink *devlink,
 int devlink_nl_trap_group_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_trap_group_item *group_item;
 	bool modified = false;
 	int err;
@@ -804,7 +804,7 @@ int devlink_nl_trap_policer_get_doit(struct sk_buff *skb,
 {
 	struct devlink_trap_policer_item *policer_item;
 	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct sk_buff *msg;
 	int err;
 
@@ -924,7 +924,7 @@ int devlink_nl_trap_policer_set_doit(struct sk_buff *skb,
 {
 	struct devlink_trap_policer_item *policer_item;
 	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 
 	if (list_empty(&devlink->trap_policer_list))
 		return -EOPNOTSUPP;
-- 
2.44.0


