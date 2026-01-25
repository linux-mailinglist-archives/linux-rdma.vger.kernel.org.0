Return-Path: <linux-rdma+bounces-15970-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULcfECkAdmm3KQEAu9opvQ
	(envelope-from <linux-rdma+bounces-15970-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:36:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9A88053E
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68A1630374BB
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 11:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DA831A564;
	Sun, 25 Jan 2026 11:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a7bZ10Ub"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA14D31AA83;
	Sun, 25 Jan 2026 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769340808; cv=fail; b=N4c4vrUWEWPahSt2zk0MyED1CbU92srDXDXSTJp1xD5OD1Pezce+qR06DAO7/8j5ASIQH1Na6e0sjh0C77QkNRm3P9oKgdG/GrZmCfeQmm7LtZDKUBRPoy7QRQOmX89jBXy8WKaxrI+R8muTg+xyp0f9ooOrN3z28v8JBgLgNOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769340808; c=relaxed/simple;
	bh=nH5ol/PxbpUFSsMYiq+pTqdicerk0UXBHPlHdXsF5BI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgzI2eZAWjCG7Q08SRiCvhBNcadMQb/iCWjYSymfazaRxt9gn9th7UrpZGMG13S63NT/cL4+rt6JvHn9hyCfohSpX+5oYx6rXS7QAJFRBI4pYFAEvvp3SNuyXTx0bnCc+vJ6qFW7vaecBDyk0KHJ13m84fq4xYNWTEEWo1CHUOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a7bZ10Ub; arc=fail smtp.client-ip=52.101.85.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AE7IUq1/CNeV6Yd5uwDPUHH66gKHdjYObidnjGbUo+uxAodCYpUVX0Y44r7sh/tW75AdAddgBuzoY/IMATFYcW22tQGpYEox41jt33/0EeZ6pYEeWhgoE0WHt54JRPC263XlbjJ0+05IAd4ESHmJOoFuO1sAreOcDWa8Hta65AqvVxpTqAC9F9jh07EqWEBLNEVDJcfW32jGCoYi29MRkFTuXyBHBNopyiP0PRw7FLmBn4tZq6loun9PIMWYb0mdPQL2lTkmTHPd9BaW1oLhKJVnwZTsd1mavyBRfkT5KxYpPRsJ+4aDmNmxL5cgzpFD16buVJA73QcUZpPtk72/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnCbHNUc9XI23m9dXnGHmRPEurG1Osz6c5L1XFqdAHA=;
 b=fVMVvx//ua3RqcgvhLSJJMz5XKIcXjM69ZF+LyWFDOOBtqMWV1cVulfgg+CKaCelUOA7y4wNZc53mFexj87tOsYK8Y/LE2oL+qjqnwXFrOcw/FoX1SvNj9G4vVAJ5tDn9uRRY5cQDpS9YkJv6euNpXGpR63MpqTVFm9SCxBUaMJREvx9VVEQbceVOe21A/pm/fLBAfT2i2NEpvRqdU0rLzHtDqp6z6dZTLoRBiAlmXivAJFL6oCdkZ77K0anRWZKjExyiWvZhkRGxNKhj4fTB+WNRObVDncY87mJIzeERx70ywusZJQ9j4IQDAi4zilghkWVc+vjBqHJRTYTXvL7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnCbHNUc9XI23m9dXnGHmRPEurG1Osz6c5L1XFqdAHA=;
 b=a7bZ10UbDLrzTECpKcKwLp8CxibEIjKiOmgxOA3csf2qtPn46HG8HIOPwPoPAt5vTyI4GndpmWexAkuO8XJqarxNa6gBCW9XBd1WVygBv2UB3ANkyM1NrE7nYx1xzfhYj9IZB1nLkQfdwhU21Zq4ohyAWpTLitFUfY0PrkJDzLFNMlWrGqMTdCOxXjflVMrdaSl1qira8Z8l26F7FmoOHqMAi9YLQrveR7arcycnzdlH58BQ/9Ib1V106Jk5ofzxlSYa3WwUceEiUnn8WuZGM4MhrnzFwKBcor4EY5IcRT6DKwZBo/it0jgunCc6IZjG4wv1UWgSOjipjO3O/WiuMw==
Received: from BN9PR03CA0081.namprd03.prod.outlook.com (2603:10b6:408:fc::26)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 25 Jan
 2026 11:33:23 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::d2) by BN9PR03CA0081.outlook.office365.com
 (2603:10b6:408:fc::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Sun,
 25 Jan 2026 11:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sun, 25 Jan 2026 11:33:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:33:13 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:33:13 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 25
 Jan 2026 03:33:07 -0800
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
Subject: [PATCH net-next V6 05/14] devlink: Refactor devlink_rate_nodes_check
Date: Sun, 25 Jan 2026 13:31:54 +0200
Message-ID: <1769340723-14199-6-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DS7PR12MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b956af-ebe4-4ef3-8753-08de5c058c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RVvZbVSil7ExyR9HXbiwBb/8vEdrqE8SWnqeV4oFgjuaoRkTLJX7U2JAOLBd?=
 =?us-ascii?Q?qAz3U7O+yy05iwSr+yxIPLMr7ehwYSwpeARq6o7RUsAdFD6Bsb5ZVD8q2cDn?=
 =?us-ascii?Q?4K5eiCPnidglO/YUNNFsJ5fsJqaJxD65yhbb5UNX9kYMLjyfzX24jiyuAmjT?=
 =?us-ascii?Q?VQYQR3tNTLsRFeMOJvv3+netwo6B5Lynmx0ITHO2tYvjmn0UGwcuWK95tduB?=
 =?us-ascii?Q?Iq5llAFbuaoXcLYOBpmO13KY03UtRxcOKhaOx4JVXh8QyYlqkz1LapLORNU/?=
 =?us-ascii?Q?NWKJvaKZuE11Ag5I3peGdYu2EZ0rDbbYnPaSDyk9vczv6eM4aHqZDFDL5Hh6?=
 =?us-ascii?Q?2cznTBN0tGuuT6hj55iS3cmBMaRCK6Hr4L0jgEZLnRjC097RH7sITsv3foj5?=
 =?us-ascii?Q?1ZT9cexzVMalCXSjXAqSZMACgZPLhX2HrcIe2R10U/q2QXZNv+oFWHBzqu2p?=
 =?us-ascii?Q?OrRwOIdXBRL+OSJQWwXqzVMf67JY1MNc1vN2ZSL6wdjlTxWQhtZrKZMzT3VE?=
 =?us-ascii?Q?B7R2yPTvwOYLD8y14zOxwtuFZGv75eEQ+rjPM1BuL3d7Ds+07Zb5cL8wjBla?=
 =?us-ascii?Q?QZPfE0pQxAmDGPkRrUPvTrQLcK2URul3BeOKgwZdVBoEvhbzQAhlipW9VN5c?=
 =?us-ascii?Q?41H7umSO4a8I83SleGTMzNZu1uU5Rn23NELYH2+CgINP6vh7ePfnGfxs9Gkq?=
 =?us-ascii?Q?S8TehY1QDzc0U5NJ4yTbZnQoSxxNCUyUgeWxdBKLsdXqacsv7/VpD4HJDsl7?=
 =?us-ascii?Q?CtOz6eQKQPMFNs80KApOsOPxWZuWqMjN93SUGehiW2Ocx1guJZdgOa3uAdAc?=
 =?us-ascii?Q?qFXPuQ6PwtSR5BFOl5olyPjfuaPaIoKeQOhhogpZFKa3hD26cmPo2ea6kCFC?=
 =?us-ascii?Q?M3g3oBqkR3omOZOSiRIMu28tDzosrScXBgd0N8aICW3aMJ/cHIEHE/AJ3Uiv?=
 =?us-ascii?Q?fFeclEuhSl9oGOBsXQlTrDq/Yefg+OQe9wbxdRUQ7YAnX5cNKJ0R9946k9J3?=
 =?us-ascii?Q?o5tehcwjhHKxc0lt4+ucm3rFL+JyrEG1w8iwR8sXpkCnpm6L20N2TtZ5qXK5?=
 =?us-ascii?Q?sWsYrS47AA7RbMecADaFs9RDeinUSefFzSbVHANSLnQtN4fS9mWIpbV2ihT8?=
 =?us-ascii?Q?Lo3pzfGuP7hkPSbDGRuO6EAlQ/sjUpvAVDJ/hhE8bAA9qSgeWlS15W6euMqQ?=
 =?us-ascii?Q?m82z8K6GReGKSU5W0lElTKoltEYYjUtd4GxwIS0Uz6kJiYfM+bHLl8xQ6uUo?=
 =?us-ascii?Q?QMJ4j7V4falLDlg3MJ7cJ9GiPcnOeDZsWTHo57vciyutDbOOz2QzdcOJcVY2?=
 =?us-ascii?Q?kkN13lkwGbwy6xgvuoUb7jwhAaJyt2OiuW989XV3e9n3WI89Pk3Vay6n7jZd?=
 =?us-ascii?Q?N2HIJcOUvdyae6D5gGH3v83+aDf9gG43l4ewGCKvvsx1Y4rBVngk4QxNTbZj?=
 =?us-ascii?Q?nqJRvbod3N8QkVouETyKm/YIJ//8i8AtHAtNUTdF09r9t4vOkLfCalWVEjlx?=
 =?us-ascii?Q?+XQuC+fR4uV8FNYeU3omlnyN9GBkcd256/jkT1w9wj/lkvDxTUbOuX98CQ1F?=
 =?us-ascii?Q?aYK1fzcYNoIeeGfJGwIIHAqMcAjvUPT8TJiUFXiQuoTIGIYrcScqrfs97RFU?=
 =?us-ascii?Q?ZpneaUvWtnKf79g3sHvFRp3I7aKaOnAi6IGSZAFYXpXNnu7zbEJQXBjdIDCo?=
 =?us-ascii?Q?spKp4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 11:33:23.2339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b956af-ebe4-4ef3-8753-08de5c058c72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15970-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EF9A88053E
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

devlink_rate_nodes_check() was used to verify there are no devlink rate
nodes created when switching the esw mode.

Rate management code is about to become more complex, so refactor this
function:
- remove unused param 'mode'.
- add a new 'rate_filter' param.
- rename to devlink_rates_check().
- expose devlink_rate_is_node() to be used as a rate filter.

This makes it more usable from multiple places, so use it from those
places as well.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/core.c          |  2 +-
 net/devlink/dev.c           |  7 ++++---
 net/devlink/devl_internal.h |  6 ++++--
 net/devlink/rate.c          | 13 +++++++------
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index f228190df346..f72d8cc0d6dd 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -517,7 +517,7 @@ void devlink_free(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->resource_list));
 	WARN_ON(!list_empty(&devlink->dpipe_table_list));
 	WARN_ON(!list_empty(&devlink->sb_list));
-	WARN_ON(!list_empty(&devlink->rate_list));
+	WARN_ON(devlink_rates_check(devlink, NULL, NULL));
 	WARN_ON(!list_empty(&devlink->linecard_list));
 	WARN_ON(!xa_empty(&devlink->ports));
 
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 02602704bdea..e3a36de4f4ae 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -434,7 +434,7 @@ static void devlink_reload_reinit_sanity_check(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->trap_list));
 	WARN_ON(!list_empty(&devlink->dpipe_table_list));
 	WARN_ON(!list_empty(&devlink->sb_list));
-	WARN_ON(!list_empty(&devlink->rate_list));
+	WARN_ON(devlink_rates_check(devlink, NULL, NULL));
 	WARN_ON(!list_empty(&devlink->linecard_list));
 	WARN_ON(!xa_empty(&devlink->ports));
 }
@@ -713,10 +713,11 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[DEVLINK_ATTR_ESWITCH_MODE]) {
 		if (!ops->eswitch_mode_set)
 			return -EOPNOTSUPP;
-		mode = nla_get_u16(info->attrs[DEVLINK_ATTR_ESWITCH_MODE]);
-		err = devlink_rate_nodes_check(devlink, mode, info->extack);
+		err = devlink_rates_check(devlink, devlink_rate_is_node,
+					  info->extack);
 		if (err)
 			return err;
+		mode = nla_get_u16(info->attrs[DEVLINK_ATTR_ESWITCH_MODE]);
 		err = ops->eswitch_mode_set(devlink, mode, info->extack);
 		if (err)
 			return err;
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index aea43d750d23..8374c9cab6ce 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -300,8 +300,10 @@ int devlink_resources_validate(struct devlink *devlink,
 			       struct genl_info *info);
 
 /* Rates */
-int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
-			     struct netlink_ext_ack *extack);
+bool devlink_rate_is_node(const struct devlink_rate *devlink_rate);
+int devlink_rates_check(struct devlink *devlink,
+			bool (*rate_filter)(const struct devlink_rate *),
+			struct netlink_ext_ack *extack);
 
 /* Linecards */
 unsigned int devlink_linecard_index(struct devlink_linecard *linecard);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index d157a8419bca..0d68b5c477dc 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -12,8 +12,7 @@ devlink_rate_is_leaf(struct devlink_rate *devlink_rate)
 	return devlink_rate->type == DEVLINK_RATE_TYPE_LEAF;
 }
 
-static inline bool
-devlink_rate_is_node(struct devlink_rate *devlink_rate)
+bool devlink_rate_is_node(const struct devlink_rate *devlink_rate)
 {
 	return devlink_rate->type == DEVLINK_RATE_TYPE_NODE;
 }
@@ -688,14 +687,16 @@ int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
-			     struct netlink_ext_ack *extack)
+int devlink_rates_check(struct devlink *devlink,
+			bool (*rate_filter)(const struct devlink_rate *),
+			struct netlink_ext_ack *extack)
 {
 	struct devlink_rate *devlink_rate;
 
 	list_for_each_entry(devlink_rate, &devlink->rate_list, list)
-		if (devlink_rate_is_node(devlink_rate)) {
-			NL_SET_ERR_MSG(extack, "Rate node(s) exists.");
+		if (!rate_filter || rate_filter(devlink_rate)) {
+			if (extack)
+				NL_SET_ERR_MSG(extack, "Rate node(s) exists.");
 			return -EBUSY;
 		}
 	return 0;
-- 
2.40.1


