Return-Path: <linux-rdma+bounces-22843-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t7L1HvQ7TWrIxAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22843-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 19:48:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3537371E680
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 19:48:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Bjir8gG2;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22843-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22843-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2C03300C9BD
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DC943F4B7;
	Tue,  7 Jul 2026 17:46:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB0420879;
	Tue,  7 Jul 2026 17:46:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446362; cv=fail; b=cxhpdI5ckvGtPLZ949EOIjIz2c8l8B4E1Arzry2ClE0rHwErAMUa2Cv8J3KRYTZEXgLEqpNeRo7y/WdtOriOkqbQGl2rGOxu6IOqPkYuDyTMEVqrrln1+62FEHTO3/T6+MxpuD9bTJymSPp8dBPif4tnTd3Hp5MWyliD7GFrk7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446362; c=relaxed/simple;
	bh=/IuLDTQxw2JYdYjMRbq7YyVuJ8BLMvXaj5Dt7GCuKPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PU7j+9cvHGrYlZpblLWjLk/FzBsjIQ+5ReQBwPCnq80ddEsJRnWDDf1dG81hdmtOTqXm8IxQ8X8ndOcfCnfrqtTm9Phpi6Q9kEjz3Y3dYQ2eVZyQsGO80Lb2U3TIPUnUMy+V81vqNJQ3YS/XtXSXQ84HuvYP2e6kQU9ICMV7gUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bjir8gG2; arc=fail smtp.client-ip=40.107.208.39
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yADpw/JMEfdSvh5C5/g4GNlxdIwi07QIekNJpq/3Gyp2pX5a5rYhJlitax1/8yhq5jiYSbfNsVkL7tH6X39ZThjWPgrp8zEgy8Ru8EW2yTRsLvAL5S9rNsnPiN8B+htIGCa+uyJ4kNnLS3E9k/DTIDcCBkV1IHDvGxY6AH4KOVvWrByvr5FjRKpsbWuh+DM3lUUOrfh+HxXTBF3HT4oa7lWgvpj3w5lllRC1wAfCLT76MnyuDe7RLPOfSlsiMuRroiKZWNo0m4HJupWxvGHITWKmNUWRUIJZ7kk3YH3d0atcAp+Uj0oi8Nv8Ad/sp21/ScYmrbPn1ShXcGNNy6OtGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fbgz8yo+5uCX9GnKg+7xdiP08romZ2W2B7Gh7d8216Y=;
 b=By4ZAyOO5FQJlERfI/EPKCKniiA6q2w35bOcdAYQX2VHSfSFGP1v7Q6oz+JJ4YzbhdQvKF7FaldRaAwl0GezWfW8wwnIsneCkS3K4JdIxrtpvtXiVRO1NEx/9jsrwKPnfhdJckWVFYejzf3HBIzg3WBei3JfitQ6Ru9Y1ItHBjGN1Xk2xW4hqkMwXrZdBC5y50qIVLh/jmzoFhYhZPjko3A5+H71DrXCv3yk/HlS4BdCBk2U8/yvGL9dCRppYaasiMbCOXQKYEZRc+nz4NMq/ZPw6u1fmhUTJD+IqtmubhPe05Y/6Ga7JmBVyKZ4bhoXMC3Uq4YIcbNFDmDd3SbvBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fbgz8yo+5uCX9GnKg+7xdiP08romZ2W2B7Gh7d8216Y=;
 b=Bjir8gG2J6Qy35uvPEIWMkzF/4qqWv2+B2CL4qiKOZtyKTBJ+b6qi/Gg1lB56JxwgTadp4pIpExVaktItzJ1jtr7waCVF2ok8YnX+K3jarfWh458wKqzRGHFkxANdvYbpMNyVTwKwf88+kQ3QJQJA3R+fvo9z2x3GGyVBaKStVcnJKkU9N4cDYNU7SnIUJMxy5lrAYWpdwczOZHEkJMfEYEff1J+W1MxYnYg9MG67aQ4SuV7ptMpxLd791R+AIuGyLAzqFLyGB6I+0GPHb4ESSkV8uGknsEWru++4fv3JTvBu5UoIyFcXl5Xn+tg3whiQG2CbSld8wMw59DGvFuaMQ==
Received: from CH5P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::26)
 by CH8PR12MB9789.namprd12.prod.outlook.com (2603:10b6:610:260::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 17:45:57 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1f2::4) by CH5P221CA0019.outlook.office365.com
 (2603:10b6:610:1f2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 17:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 17:45:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 10:45:44 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 7 Jul 2026 10:45:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Jul 2026 10:45:40 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next V5 2/6] devlink: Factor out eswitch mode setting
Date: Tue, 7 Jul 2026 20:45:23 +0300
Message-ID: <20260707174527.425134-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707174527.425134-1-mbloch@nvidia.com>
References: <20260707174527.425134-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CH8PR12MB9789:EE_
X-MS-Office365-Filtering-Correlation-Id: 051cbd1e-8259-438a-6cd7-08dedc4f99a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|82310400026|1800799024|36860700016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	G6w+c7YHYA9iU1ZdsDQruvQSsvOe6HNW4eAFONvXv2OhuCwRPU/729cqIhU3ouQnL2zw7DOgO58xkN8XzaYPBO29W+em1JGY3uOaWioPiO3o0K4Ekr/kZzAtNjs/yzzsJBz9OgZvM3rG4ooQ9jODRIwirYnTCgssRV99cyIprvyMtcR8AQtVjralE6mNnH5l1Soq/32XWeOAOtvqQzRSQUtfnM3hdBNav51tQqKomhJYgTyOqM9yDRGLp3dxo8q3y26bkvt01xwq92rTh4Tsb3fCyTnTUXJyJ7vgFu+eUaMQYTOBBqpCEcEZVhAtGVymCCL5cx7MepYiRljhMy/R0LrnwBOBYBuomjg8KlFgwiU78MNSc6enMcwov7rdkmdCFbQt4qj7Ox+rct0bX9x2iXE9FT3HQGHJFhM+muAsamKSDQ/cLJdEoHRwE5gLHFAILbNdXqb3metnES9rW3DLTrHIdNoON9XV37nnTMAa8eOjXCyq5ADa4wxaTu5UpLKy/M2nOa0X01CRteysGmjneHqY3szFcR6adKiX4SagYeQ8PIvASwxYYkS7CujWQXyraXwR2LMkOLZ6mdvTCnDZyGkGJO43ZHFgc0NuWXouuNXEbXpvBNeTUGpL4W1Fg+5qSYFrq6qk6iQBxk7Vvvn2pBhmbLBnF7I0ELKF2XTdF+aQzUAs2KWR9Mc8cgwODJlP
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UVC5DRFKyfI1qjPZ4UUfEVeCSXoT5Bvougx8f1z8i6zUs8X+USn0o8HmeXa+hBCGhdMoBuj8Xn6A2Kov5ioPJaB2CLw7OSEy1U9cYwCb9r4hIudY9iFj6iCI7ydR3mxfFS9oQOaIYoeixx2Jk6vOXCgjX4ueD2UQweeCcTtPAEy8t+AMLA+8Oec7PJxBQSLM7LhXQcVEsAN1YXVYeF6iI0yQA9dM4H67DAgIHKTderEAgLAeBCTI4RuItBJS/kWGnzT1W4tVtgxFnG6lkwMKZohxPQtfKtDJTv3/+cmQCqDKgiFj2e5uwTblom6ZUCPQ8E/txM69pXAOuulTWvTs8eThQ/yclyCIq/kjlIyJv7XS+XyU6DOuE0PrDW1Jaa2MYxdeaHA/X94rED2QiINAnGtaLn24lU+yV/pS2YPGYi9AQj1/Te+cf9Fm9u3zjmd8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:45:56.9905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 051cbd1e-8259-438a-6cd7-08dedc4f99a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9789
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22843-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:mbloch@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3537371E680

Move the common eswitch mode set checks into a small helper and use it
from the netlink eswitch set command. Making the same validation
available to the devlink core path that applies eswitch mode defaults.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 net/devlink/dev.c           | 27 ++++++++++++++++++++-------
 net/devlink/devl_internal.h |  3 +++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index bcf001554e84..119ef105d0a7 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -702,6 +702,25 @@ int devlink_nl_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return genlmsg_reply(msg, info);
 }
 
+int devlink_eswitch_mode_set(struct devlink *devlink,
+			     enum devlink_eswitch_mode mode,
+			     struct netlink_ext_ack *extack)
+{
+	const struct devlink_ops *ops = devlink->ops;
+	int err;
+
+	devl_assert_locked(devlink);
+
+	if (!ops->eswitch_mode_set)
+		return -EOPNOTSUPP;
+
+	err = devlink_rates_check(devlink, devlink_rate_is_node, extack);
+	if (err)
+		return err;
+
+	return ops->eswitch_mode_set(devlink, mode, extack);
+}
+
 int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
@@ -712,14 +731,8 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 	u16 mode;
 
 	if (info->attrs[DEVLINK_ATTR_ESWITCH_MODE]) {
-		if (!ops->eswitch_mode_set)
-			return -EOPNOTSUPP;
-		err = devlink_rates_check(devlink, devlink_rate_is_node,
-					  info->extack);
-		if (err)
-			return err;
 		mode = nla_get_u16(info->attrs[DEVLINK_ATTR_ESWITCH_MODE]);
-		err = ops->eswitch_mode_set(devlink, mode, info->extack);
+		err = devlink_eswitch_mode_set(devlink, mode, info->extack);
 		if (err)
 			return err;
 	}
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index cdf894ba5a9d..af43b7163f78 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -348,6 +348,9 @@ bool devlink_rate_is_node(const struct devlink_rate *devlink_rate);
 int devlink_rates_check(struct devlink *devlink,
 			bool (*rate_filter)(const struct devlink_rate *),
 			struct netlink_ext_ack *extack);
+int devlink_eswitch_mode_set(struct devlink *devlink,
+			     enum devlink_eswitch_mode mode,
+			     struct netlink_ext_ack *extack);
 
 /* Linecards */
 unsigned int devlink_linecard_index(struct devlink_linecard *linecard);
-- 
2.43.0


