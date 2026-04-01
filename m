Return-Path: <linux-rdma+bounces-18917-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKDQOh9qzWkkdQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18917-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:55:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5794337F7A3
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1382230D7CEA
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 18:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9204447DD55;
	Wed,  1 Apr 2026 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FYe2DFVK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010064.outbound.protection.outlook.com [40.93.198.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0433F3F20ED;
	Wed,  1 Apr 2026 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069515; cv=fail; b=nTkTF6t2udpehgRXjQuGUCqy0NHna88FKduklVCOMzWcNRHReqKI9pL49976IQOMUVV+ZLnFvrGfx9xH+01XiXkTTzHWJBfHWkYE6Zt/SoZ+KTMsDNPYqNt6tPGkI7U+sBVeVNJWJa5+BeH3dd56KREzv0eup4kY5DwxePObC0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069515; c=relaxed/simple;
	bh=DckUnnbCleomrizKlwrKycQ9ggX75YComkXbesnh8wA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdjolno6ekHLA/25CSCdsqLpm0oKi5iJSkU5hcr/gg2e74nx0wVH08a6Kyq8FIThEzE6oqhWK7h8w5vsQN6tBaXBdj7j3QEyTX0grp9D5H1WEQ/vf+a9ZZCa0Xb5kuCXdjCaNPeImB9CXu5OA2BlracVIaU+IPAoNBg7GMyeRdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FYe2DFVK; arc=fail smtp.client-ip=40.93.198.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beJavG3e1hJ3QAhaPgCrpUAX9rHW72hVaYSX2VXCwtJ2AXCW2oyhPCIVN5L+ZojkvECtGriFlccj9nFuyKnMM9PL6pWIjC8Tv8I8yUNJSBRXJNouJItUF2gCLh23ThR8Hb32A4cq02Dwjh2785WT/YfboJ9MftupkjdXxuDh+SEPCP/d/ZpEjrx3OR3pHxK2OWh+835+IEGBYfaJ3EjOt3AY2iJ0RMZN9Ci4sgesem2F+peegaTePOg3Ml0fVB2oAA1MqsWKjdQMO4QxhKb75tlGQ7S55fkyt4UzhwQzkmW47ZpeaGruhbFz66Nxb36fbWAsywPdxdUHb0jxnQixaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvlYivcBtfRlOHFQzTpB84NQMC2Ek+XeiXd1NRUX5AI=;
 b=Li1BmWnyXbmnFkdof0pDuNT8IurU4a/Vko3jgCICbJnjxfPJEWm5AiMCSiAZuifS7JJ0VQ2I1MTpoM3dpqeS8isxg4yFo3erz7Wp29D+RFwEwc/smxVPkzyX3jrvUx9gEyqsxHunA1sn+7uQmxacK+E629taMtjNG9o7tItfI0L9SIhYPzbRrOG7+7XThGiGAgCuR3JdKOcLUd3KrEx+QJZgQ3wr0y0inSx/SzNedur/xis7ri+S6CrXpCTfWqRrj6SZvYMkxM8aV7TuvAkVQBcBU8EEbrLLRIljRFsm6+9OBbUgqItY3p8WI2QGa8gk6QlTYUIKADMjg6QNp+gHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvlYivcBtfRlOHFQzTpB84NQMC2Ek+XeiXd1NRUX5AI=;
 b=FYe2DFVKT8ezFWRWwybd8Dw76Q0KqSlpVl3BdjAActfFTA/1G46mEUrbctEj7Sah+lkXLey0zzB4n35AoCOCIfsD17FU2FBgeQuYyYzH11dkbfVOzBVCbqJigdccEVokCEjeYROcMz5l0GIhbLPRZ4s7KX4x3fBiV/n/wyhmonWYoKyBuzU4hvu4w1f+LXsycYmYp0TvhpKRC8Hmu25ciMH0DCn9LR/xAtyAipQ0azL9sD4ILMpg0XUKc/WGTWQGHNn02BrI3b4aPbQErfVLv6IIxwRRFsl+cr6f/+Tn1uCKmULezxinsYwEQHBt5KZYSedfII+Np7N8cmWxRC/vxA==
Received: from MW4PR03CA0068.namprd03.prod.outlook.com (2603:10b6:303:b6::13)
 by IA0PR12MB7531.namprd12.prod.outlook.com (2603:10b6:208:43f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 18:51:45 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::9c) by MW4PR03CA0068.outlook.office365.com
 (2603:10b6:303:b6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 18:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 18:51:45 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:51:24 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:51:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Apr
 2026 11:51:15 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, Shay Drori <shayd@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, Kees Cook <kees@kernel.org>, "Daniel
 Jurgens" <danielj@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V4 07/12] devlink: Add port-specific option to resource dump doit
Date: Wed, 1 Apr 2026 21:49:42 +0300
Message-ID: <20260401184947.135205-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260401184947.135205-1-tariqt@nvidia.com>
References: <20260401184947.135205-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|IA0PR12MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea95cb8-e967-40e1-b3fe-08de901fb8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yaxZLp6IezmLqHYKFN4ZrrPw8k1oVIQx7JIIhA6zeWisXxvDo3BNvzJpcWutZx7UgmbbvasE9Rdwq2RhcgKYLV9I+631u3EyLtMEOZdiblDPTwau7CpMZntVgJltbSAFxAICr0DYCElUEIc6gWJBdXddO2BOJl0VT5zJT/+uJbTRgpzfFSYzxEno/L4rl5/B7/ArDn8t6oJSvKCr5huFS/bHmnMNCfDcPHWZSx4PQZ+qJmr6xdSGns7iB9881bHmf7ogW/Kt5epuxXfkP1hFqnhPSMu/F/qymTlG3OOYepm1u/ULWQF8IgR9MD61QEpShEL1sF/oU1Smv+8AUr+aOxk04hkGLQ9BRs8roRDQcp04c5MFuAjlltYF8I2LNAdNxi7yIg62lzdC2lqjyczhw+PolP2QpmJajoR4bym6q4qbYq57rMMAvvIKn8L3pPE3OCxjZ3Cc19AmipWLUgcp1ub2Oxyh4xpR0FxG9lteWrffHhHdiZQ30wseVLDcnXp3QqdtvSa1yyR1UQC69gyGwTwkto602Dc5t8hxvr28zDtbZ2+Kj7FPijIjk3O0DqypAND5yDlJ67b1Tk+MpMFI0ecqEqb0VQinO48MnaaP6Sy3dmxMqsuutuNt5ua8uoaDbaGEqNxxFOMpzil5G3cpE7LcwMRK/QIHqFgIPyfuZcA6yWNxV39iT5ac7Z/nJCTplu1qbvulYMkbh+VxiHCnKlUHLw20+QQrH5K4dJRsjPVsoN0rZIoFlwpX2KLoiGMAfjfQIEaCMkcPKh0raz5ocQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(376014)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PkI2bGkVP9mmhidmlO0JTCUt/7dAcxMg0Es6vL2i2od7z2dv52MT2XFT1pldI4bb1lKZHvsuIKYHoprejSUIFLMv2vEe67vYGF0Cr/gJDHHcF4NaTxaftQoCPoqI0g9QXkYGAYdNbHMAFpDMz7kjD/RjvEkvwSxEamIIrkave6F1LHbifAd0xzUjOUvTyWapQnfi4/ErxHJejGKZmVt3TP0kNpYSi0jBRWB8+j91NrHp75JK2zSQz5GlHVABxiZBwjMlJF6rRHNDj8RajAB/vDQuqoQdDv65cKH2w7VgfL5JsYbIDWRlNfNDHKE3tLxscLXc2/V6aIOmuJYRngmS3IndvnsTAPsLeJBP7hjqYIBJXvC/+L7PmXhAxdATqYMWddFnzhd4KFKLyz9X4sxH2i31fwON1OtovjZtrsFKN/6CuxTt3RHtkXnBqHNFNATA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 18:51:45.2716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea95cb8-e967-40e1-b3fe-08de901fb8e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7531
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18917-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5794337F7A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Or Har-Toov <ohartoov@nvidia.com>

Allow querying devlink resources per-port via the resource-dump doit
handler. When a port-index attribute is provided, only that port's
resources are returned. When no port-index is given, only device-level
resources are returned, preserving backward compatibility.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml |  4 +++-
 net/devlink/netlink_gen.c                |  3 ++-
 net/devlink/netlink_gen.h                |  4 ++--
 net/devlink/resource.c                   | 20 +++++++++++++++++---
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index c423e049c7bd..34aa81ba689e 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1757,19 +1757,21 @@ operations:
       attribute-set: devlink
       dont-validate: [strict]
       do:
-        pre: devlink-nl-pre-doit
+        pre: devlink-nl-pre-doit-port-optional
         post: devlink-nl-post-doit
         request:
           attributes:
             - bus-name
             - dev-name
             - index
+            - port-index
         reply: &resource-dump-reply
           value: 36
           attributes:
             - bus-name
             - dev-name
             - index
+            - port-index
             - resource-list
       dump:
         request:
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index a5a47a4c6de8..9cc372d9ee41 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -309,6 +309,7 @@ static const struct nla_policy devlink_resource_dump_do_nl_policy[DEVLINK_ATTR_I
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
+	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_RESOURCE_DUMP - dump */
@@ -962,7 +963,7 @@ const struct genl_split_ops devlink_nl_ops[75] = {
 	{
 		.cmd		= DEVLINK_CMD_RESOURCE_DUMP,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.pre_doit	= devlink_nl_pre_doit,
+		.pre_doit	= devlink_nl_pre_doit_port_optional,
 		.doit		= devlink_nl_resource_dump_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_resource_dump_do_nl_policy,
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index d79f6a0888f6..20034b0929a8 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -24,11 +24,11 @@ int devlink_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 			struct genl_info *info);
 int devlink_nl_pre_doit_port(const struct genl_split_ops *ops,
 			     struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_pre_doit_dev_lock(const struct genl_split_ops *ops,
-				 struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 				      struct sk_buff *skb,
 				      struct genl_info *info);
+int devlink_nl_pre_doit_dev_lock(const struct genl_split_ops *ops,
+				 struct sk_buff *skb, struct genl_info *info);
 void
 devlink_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		     struct genl_info *info);
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 48f195063551..0f1d90bc4b09 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -251,8 +251,10 @@ static int devlink_resource_list_fill(struct sk_buff *skb,
 static int devlink_resource_fill(struct genl_info *info,
 				 enum devlink_command cmd, int flags)
 {
+	struct devlink_port *devlink_port = info->user_ptr[1];
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_resource *resource;
+	struct list_head *resource_list;
 	struct nlattr *resources_attr;
 	struct sk_buff *skb = NULL;
 	struct nlmsghdr *nlh;
@@ -261,7 +263,9 @@ static int devlink_resource_fill(struct genl_info *info,
 	int i;
 	int err;
 
-	resource = list_first_entry(&devlink->resource_list,
+	resource_list = devlink_port ?
+		&devlink_port->resource_list : &devlink->resource_list;
+	resource = list_first_entry(resource_list,
 				    struct devlink_resource, list);
 start_again:
 	err = devlink_nl_msg_reply_and_new(&skb, info);
@@ -277,6 +281,9 @@ static int devlink_resource_fill(struct genl_info *info,
 
 	if (devlink_nl_put_handle(skb, devlink))
 		goto nla_put_failure;
+	if (devlink_port &&
+	    nla_put_u32(skb, DEVLINK_ATTR_PORT_INDEX, devlink_port->index))
+		goto nla_put_failure;
 
 	resources_attr = nla_nest_start_noflag(skb,
 					       DEVLINK_ATTR_RESOURCE_LIST);
@@ -285,7 +292,7 @@ static int devlink_resource_fill(struct genl_info *info,
 
 	incomplete = false;
 	i = 0;
-	list_for_each_entry_from(resource, &devlink->resource_list, list) {
+	list_for_each_entry_from(resource, resource_list, list) {
 		err = devlink_resource_put(devlink, skb, resource);
 		if (err) {
 			if (!i)
@@ -319,9 +326,16 @@ static int devlink_resource_fill(struct genl_info *info,
 
 int devlink_nl_resource_dump_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	struct devlink_port *devlink_port = info->user_ptr[1];
 	struct devlink *devlink = info->user_ptr[0];
+	struct list_head *resource_list;
+
+	if (info->attrs[DEVLINK_ATTR_PORT_INDEX] && !devlink_port)
+		return -ENODEV;
 
-	if (list_empty(&devlink->resource_list))
+	resource_list = devlink_port ?
+		&devlink_port->resource_list : &devlink->resource_list;
+	if (list_empty(resource_list))
 		return -EOPNOTSUPP;
 
 	return devlink_resource_fill(info, DEVLINK_CMD_RESOURCE_DUMP, 0);
-- 
2.44.0


