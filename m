Return-Path: <linux-rdma+bounces-19109-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPzNMbxf1Wlq5QcAu9opvQ
	(envelope-from <linux-rdma+bounces-19109-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:49:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7EE3B4005
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51EEA30CCD40
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 19:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A2C378D94;
	Tue,  7 Apr 2026 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CjwbOVTx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9D23783C3;
	Tue,  7 Apr 2026 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590999; cv=fail; b=fsMIOnjS3u5SigpTjjotiriNdK4pfj+/oEebP1P3dy50DsxEfILz3Sla+MrCDrsZa6kxq+Y53RmBuhiBrDHXT6y8zwW1UC8tnFikBllIihRHXc0vEqj5Ma7MRncjI2VnjYXXnz3izec4MdjfnsAqnJh9z7yiVzz50BdNnQVyPgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590999; c=relaxed/simple;
	bh=U0vmrjSLJWj5pF0319FHoJqrq4GtBKM+1rjX3RUju6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/ITq7olZDXCz1aW4MJ4Ulcmy3hkN/pHQvzBTi5X/oFK3QL5CGqBFO4yX2RTU662CGj5NZIA3iiauj9nWPlc2G4ULXEvjmRR1Um1WwSegjD2o6AmXDNnOMix+CydDH7cbFlP0XcAOaNQuYqi2uFq4Usrc/vTx42stA2R2+RJKvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CjwbOVTx; arc=fail smtp.client-ip=52.101.193.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ix1KwB/4KEExGQ4NzRTH3LPpz5Lm/A6W3L6tIV3V910GMmOxWd/PIXQNj37xJGPZflmRoIGXndhRhkXpun+1g+Bp7y5bUziNE/9e88itGRvbbhO0HrBtEhoMjL90SxrNzeygmGsOqGJtHu4z1g8KhrP/fidRtWpaHr5YeJCRwf2UjZJqI9ecOoJ1uU+rrfvVpZ0KYJ8cxLYEsfFNvcS5byRhxl6wainIIKk1u5CX/MqFu8nrspojv6kWxQLWLjDWS/QqEpDhsojZgrxtwuhARVNmIUw2KVgUNyQLuD02a539lAppr/HnUJ0y54AlxGDdF56wkaVeYnAbGYmcerm2xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HokPBDlLYsdDlJ163yoUhgtS8o98HmZ1B1zRTzni1h0=;
 b=RFwc98hJKk0sBvjkra97lvUm/PW0EoacbnBhFwuXHdE78+uyZn3eVGLuLafbTkY9otPoLRZJUhBHUKMxgi4Y8JXCRNvLiabLZ6B48FNaRu31RzjVG9kNv463OPnzBoa6xKq7pyLPvd8uVSvw3qlNpRy5LWNwnjE4w60ICAon8/hUH2ZoV33QZ2HbaFzCh1jFWSxi6h0yObP2fpZ61SWg8cqSStQPkDidh0FvGhvnLpeSlpk9++QQcjAbs1dH9qwqppbhn2gAaq1TS1jv3EH+lJV6s2kgRN8QCIgmx+w+XLg2d57UZhkakIbcR7MLZUIc1xVPobs7P7bDoDdYq6wrcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HokPBDlLYsdDlJ163yoUhgtS8o98HmZ1B1zRTzni1h0=;
 b=CjwbOVTxGDRpTYo/lF1rE1WWzARLQS3P/+fHr2S4FrguP/BKRxV3G+NWudir63pvZhHuRjjGWsfZGWYvm3yTHVrd4blQtjJPTvIpzyGd5izr38o1pqNXBx2EwuFdWUU4M82FhGG9qJuH7umosM55Ar+3Q3mVyt/c+EniMUsE+sZ9l6mBVDVu9Ef0/rMgTU2aXOlBKYHXazctV4QsUwgjscahj6G9+frWjR7KqOKDH055Zy5B9Cb9KRPwkEwLyA9EECOv0gz6nIkUinZBMbNjn41JGd3HCk3RPaxNHWHxLfmJ5nHLFOMFyQD05va+/bb2wrkLC3i/NSxoPqmIeC70PQ==
Received: from BN1PR14CA0015.namprd14.prod.outlook.com (2603:10b6:408:e3::20)
 by LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 19:43:09 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::60) by BN1PR14CA0015.outlook.office365.com
 (2603:10b6:408:e3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.35 via Frontend Transport; Tue,
 7 Apr 2026 19:43:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Tue, 7 Apr 2026 19:43:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:42:48 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:42:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Apr
 2026 12:42:39 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, "Matthieu Baerts (NGI0)"
	<matttbe@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Carolina Jubran
	<cjubran@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Daniel Zahka
	<daniel.zahka@gmail.com>, Shahar Shitrit <shshitrit@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, Parav Pandit
	<parav@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, "Shay
 Drori" <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V5 07/12] devlink: Add port-specific option to resource dump doit
Date: Tue, 7 Apr 2026 22:41:02 +0300
Message-ID: <20260407194107.148063-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260407194107.148063-1-tariqt@nvidia.com>
References: <20260407194107.148063-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|LV2PR12MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: a1070ca1-e1c5-498d-31e8-08de94dde5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Y4l42R6J1arPjFJakmUYJ0F7pjeh8seSMDsLuzucRPyUocnxv15l6h8WeD7qX5L4YAqAowWJ/NSMqXbCVbvG/pWhgyeL9Sd+s5qojZH7jFn+EvInJwMQjz/ksBkNEzIf4bowSFT1zYdGKNtjdpBzaKtGwM3kVkwP9qEDz5ix2W7SOxEaYYgtvOlRGIYLas7RQ/fUQqsXIefZju9z+eHH6HGICCkyNLsc6CeT3uRGNeF6oBUsjdv1BDfrqz1N/VjeLmXLvCA/TL5nfs+6BW6wmDh+rrwdCAid+L2Q3dLc9VG1joVDwsBiFEiU+H2dEZ7f184ztfHjQhYeSAE83x36r7senBJLn2Cz6llwAmnetXjS4ZYEN1f7S/JmJq3w9NSTSr/8ZxY+KyX2EuGN/Hd9QK03uBp5V6sqrKeAE5Bffe4G0mQwqmd8dVcMCp71cbNoyb0rUy+hp63dhC5lfwb+/Tpvd53wDNdRfvH0WxM6Bk5N2APHDu7q/Ism3CBOabECMfYVoZUKcLjDRUORA+A3bnvH20YIq75u+wunC27rHlgvoxLfD3rtyHdNms4lzWk2Vqnqfl7ttR7ahizOQaazFengSd9Kv1kIggeMmDb5Mql8DvbG8H/hs/IAKGCF/pICeAIGCcUkECpUu6HvpYglSpOgS14+JXz46tmvxQt8S0qyfhwmK7kzpLKIN4GMfyrNo9Y8uXzl6p07Fv5VkmXGhcaee6zY1pn7/9jeqRBW3uBtTHseflr0FaWQ0XUiilabE6abCVqkQkcG+XzXSdb2kQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ipn1icpCYFPgcTvGftIxvBQ18B/6ulmd99O29dGGfQGIGTBhPLIaqMRPkAwDjDBT+6o5cEE/OYUD/1rMTHZs3LBJuj+E5TvlWyHoVdfP29EAGVQpHJLmjBaWZcLZTLnn0b+a28OjFbDpFmxi9VpJAUpfXe7fxouP8wAjR/ELRSplZWARzmwX6dHonYVxVZCD1MII8w3d158sudxvf9yAQtSRK2jdwh32+RyrxL3gS0CND1StxHb7Ayd9DA9MEmgkT8LKc45SBXp1LPROwl0q80KJHdE7o0Vqma4km4QJymNXmvmF2Z3MlsAVRAS+OBPVOPG9TnBa5A+QX4ZUn/gk7hbzoUnfZP2RWdP7M6/Q7HZ+FIO5cEWiz3i/S8vQF2bIb+G4dG58ci6hrvXVYCa3zRmabgrn1Kt2w6BG2oLsW5wLo802uNlQy5anpJoHyTXv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 19:43:09.5457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1070ca1-e1c5-498d-31e8-08de94dde5cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19109-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5D7EE3B4005
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
index 7984eda63eb6..bf5221fb3e64 100644
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


