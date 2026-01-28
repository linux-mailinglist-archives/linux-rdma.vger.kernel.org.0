Return-Path: <linux-rdma+bounces-16136-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHt5FbnzeWnT1AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16136-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:32:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E91A2A0767
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 100973088B0F
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0C434EEF1;
	Wed, 28 Jan 2026 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hEEmqvYJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E4B34EEE2;
	Wed, 28 Jan 2026 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599682; cv=fail; b=djtpK5awQ+Ygnz5oHbJvq9qzuC4flPsckZ8ffP/gsVw+4Go/JWtyvow9BFivVhMdAhz/KWS757jplP7UYQtzYaUvTkdpT3JMl1nJlW0oPqwXvU8mtH1Tu8A2mXoZdxfzQtq+dla/NLmxIfgYp1zzkuRL5MTYHw+EibaKAm/DjTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599682; c=relaxed/simple;
	bh=VWzdc/N3eHvOuNpEWDMZSRK9dEYUvBPoVQXmOAKh/9k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSyEHPYYfbAP6dfF8kx4powDSK6QlCS3VNpH/r+8z9CRLQJqkzEv8Y1nHK4uJiJQIUqm7rXzcMvamyZeAXX/AN4ydUH701BCa0k19mczvnDy4JEWAcqTENgA3GzYwJT+O6IfYWAUR3mGgrEN++mnIiCY3FlcfHwZ4fYoI1J/V1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hEEmqvYJ; arc=fail smtp.client-ip=52.101.85.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KH3RKCfXaeG3PIp4v5vAUMGpiReI6XdFYmYftci3qo9NLuj3jvimJyd/Lj5i9mPSsoPwYs9D5xdWy1Spr77sFBiCLuSwYXIm0FngonU9E03Nf7QeCPU6QMg69WKN/J8CI4a26xz7pKbhtk2Qo8lBHJJj/2u/qM7jvJ0isCebyc6HWSOvnDJBQfw+0PE+wEddXH54pPCUkg05zF4gUsh/uIQYrxSaL0MyHcRhuOOCNgw7wwcktVGJki0rjMzcKcCf4RoOmL3O0LTE/47QB7UaQJYUq4SiDbbm5rCYBXVm6DPUOk37tqxRGa1/ZdnMdnx9QdNzVQ8KeXhOJGkEbP8h0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lcu8UkvoEodiGMvwyq/H6ywtfatxV6MKanff74mRObg=;
 b=heFGNdh6XFZFEcVcXRm0GyBpfArtw4omz7t7ONDsfxKZyw5ypw/3tSGeDHwvbWJWqpafHa0yts+JR3p7QYk+vi5acMdDh8ztFNN+mwa26FJklJcFN9/KEaG+EACjDZPgYEEOt5FCNilDeqhKxYRz1RyInmyObl3A8Uwv/PL0WW5666RKe9uvbnYyRdgDsh+qMozsyeHoBvyVIxMQLpexFZQ8xmvilYewB7kIxML7y510dwwfV2YuUFKKI30t6CxE/CqOsFkg8mgiPD4tZbKP+1Stvom9T5gSP5jxtnmCm1ib6xi+0Yvzf5IUmxfC5KKOM0iS98a6/XNr3ach69PHKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lcu8UkvoEodiGMvwyq/H6ywtfatxV6MKanff74mRObg=;
 b=hEEmqvYJXK3w37Q2g8/XNP5czcPHz5S/7TKmPcZTpfzFeCm4mXuv7/gt8zg5vS8yawMbTJ+wLbMbcqcQCdjKpf3KUADyBQ7Yx2EfzKYDuTZttneADI1b8z15RGH81USyzQTdlSGDL+Zk7UMI7lxYPV/MdHtac9RlZ0w6sL+cuSC7BLCnnBRRX0Dx8nqqqme/HPa+K2TnS2yUUkDGNAHvSLRcLM4yeHIYONcLe5e75ARudeTccvcaA3QujmXIXQheGliqM3V1FaQgDS4Gt6zJ1CaHnNqvv9o8sY11mfpjCIHobEuqP2sxxP1g+wZ2yAQdDS48T/LFxO6cbKVKnjsn7Q==
Received: from BN9PR03CA0226.namprd03.prod.outlook.com (2603:10b6:408:f8::21)
 by BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 11:27:55 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:f8:cafe::b2) by BN9PR03CA0226.outlook.office365.com
 (2603:10b6:408:f8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 11:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 11:27:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:27:42 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:27:41 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 28
 Jan 2026 03:27:36 -0800
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
Subject: [PATCH net-next V7 03/14] devlink: Reverse locking order for nested instances
Date: Wed, 28 Jan 2026 13:25:33 +0200
Message-ID: <20260128112544.1661250-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260128112544.1661250-1-tariqt@nvidia.com>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|BN5PR12MB9511:EE_
X-MS-Office365-Filtering-Correlation-Id: a3008f44-8b7a-4335-abfc-08de5e604802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tOptxymmmCY5ESc/cXNvNprmrbB29xzgHXAb5nXyMfHc9dCOhQiBiP7xhXkb?=
 =?us-ascii?Q?R9r/kMM+D6wdp6yQXaS/2QYvSLcFoyExPTzuLOeYJMOzyP8Gxz7tDjeI0MZZ?=
 =?us-ascii?Q?58iaOSvn6jXCjxKdqv78TEWi3Q1j07kR7TSPsZc2b+Qj4d1uQgJNfPq1m4AF?=
 =?us-ascii?Q?8hIbR6GSAumdR95xN8J184sA029KwN5lII6/cQzriViQNKsrliF+lrNk+yQF?=
 =?us-ascii?Q?fi8kIID3Qwgwmmm5uWFMGHVpfFfHNt6nbNCG4PHtqX2YlRtqq5IiSUeLi2Iz?=
 =?us-ascii?Q?aACHROTjziEFSqQOK5k97gQiWrK+17mphchEF09+H5gzgqkhH2GZVKaGlq9f?=
 =?us-ascii?Q?Qr1MbAsy8Q8wi3C1tE+al3VWcRr9XpNF/vq2zk8D5wP9sjG1eShUS3KUUXWv?=
 =?us-ascii?Q?ey/2opCKXC3oxmSv7Nszohu7Iy1dckt7mepojzYfght+C0XzsANIMWyHl2fo?=
 =?us-ascii?Q?hi1EgIIcnPgZju3/3f8hO+gp/0kJOTXSHi8m9yuuho56nYBaE/fqsQahAMqj?=
 =?us-ascii?Q?gbwBwRfhycf9Vln9wVig+grmAlV4BUSbmM6JFyILZas+bwA805oNEh4b4DAM?=
 =?us-ascii?Q?THkOjXAPqD7uoEZ8AsuZHr24VkwYHAWVLyfOi1t1753edjBuHho4wKOgdxbA?=
 =?us-ascii?Q?Q/27ZmHrKE0l4hT+ZSQTchEHSZsF0IqAkaXEoR799V8hgnda6B4iyFJS9J6u?=
 =?us-ascii?Q?9/y7FOl/Vi07cnUoZSaqTTVQ51/ojxOnSt8V9RqkO0obU+avOPSed2ALTQiE?=
 =?us-ascii?Q?sCGn1lzO5jpPT9Eq4YKcJDMLSnhYUc0mmofAJs8iU0c9S2whqHbD+7BVdcTa?=
 =?us-ascii?Q?42Wb1y7yZIwOxhxn9GO1YV6G+FxF/1MIpCLbSm6TG4i/BKaDjR1AkyGq6fJ0?=
 =?us-ascii?Q?lPmNR3+VbHinFTr03nLQESsRphzMmpfS1SeTMsUrPsVx55EXocBkO48o4I28?=
 =?us-ascii?Q?fHI66FK+MmE50leoG3qD+DR16X6Zwpbx0JGiY3NDeBlGVlA54hnNo5yGSKOW?=
 =?us-ascii?Q?pCNb9WaRx6XO+Rm92mnWj3VVKvByOepclmtadfw9xuYfTlKh7Ovfl3nasbjd?=
 =?us-ascii?Q?xvqPMRsaTMLwhUpu7di3MGtxwylC6EaFeaHUmX9zOSQiOJENmM2GWvLq9eur?=
 =?us-ascii?Q?508JgzkB+wrnv9+vM4IiOaRopoV1SUPeGKuTByA6GpRlsbADN9JNP0m3CRkc?=
 =?us-ascii?Q?NYgS3eU2Uw+kQgRP7wKs9PXrgQjsrt7spEw81bfgtFTxEHn/d4GrDMIN/EbF?=
 =?us-ascii?Q?J2S/IXfgvvsCJdj+rkWW/s1Api2qAV0xMusoVlWof8pjUBxaV7vNpfu3KBcO?=
 =?us-ascii?Q?Y2zGbHnBlhYeEGO37t/LI9LIX0V1Tdf8IQqge6QVws3zdJxZmzL1l01A/6wV?=
 =?us-ascii?Q?gfeDakYizp+cfkBpT2JtJun+eoYLAThxfIkY+rNg9oUa4UmqTkvZQpsnge+t?=
 =?us-ascii?Q?xYjaR9at+wxQwgu/QErKIt71bzFXwysttzSy+wSohAsOffpNEgEPN/OqS47a?=
 =?us-ascii?Q?RyJNGNkBmMo00L9rROKhhpWmYo6APs6YHHUVgrzIXvyy1K+xQxyymkycOCkV?=
 =?us-ascii?Q?4EetM52MJ/36TURRexTR1OUzAV9pIxqqDR0ohTzMVDyF5uFZJlhWI1+AmkN+?=
 =?us-ascii?Q?1QYuaR2b0VcqMwVfVC21WlgOSy2bHFqIKn0QjMG++LwrQwu7MN/Uovf7zx0n?=
 =?us-ascii?Q?V2XHUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:27:54.9404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3008f44-8b7a-4335-abfc-08de5e604802
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9511
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
	TAGGED_FROM(0.00)[bounces-16136-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E91A2A0767
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

Commit [1] defined the locking expectations for nested devlink
instances: the nested-in devlink instance lock needs to be acquired
before the nested devlink instance lock. The code handling devlink rels
was architected with that assumption in mind.

There are no actual users of double locking yet but that is about to
change in the upcoming patches in the series.

Code operating on nested devlink instances will require also obtaining
the nested-in instance lock, but such code may already be called from a
variety of places with the nested devlink instance lock. Then, there's
no way to acquire the nested-in lock other than making sure that all
callers acquire it first.

Reversing the nested lock order allows incrementally acquiring the
nested-in instance lock when needed (perhaps even a chain of locks up to
the root) without affecting any caller.

The only affected use of nesting is devlink_nl_nested_fill(), which
iterates over nested devlink instances with the RCU lock, without
locking them, so there's no possibility of deadlock.

So this commit just updates a comment regarding the nested locks.

[1] commit c137743bce02b ("devlink: introduce object and nested devlink
relationship infra")

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 58093f49c090..6ae62c7f2a80 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -178,9 +178,7 @@ int devlink_rel_nested_in_add(u32 *rel_index, u32 devlink_index,
  * a notification of a change of this object should be sent
  * over netlink. The parent devlink instance lock needs to be
  * taken during the notification preparation.
- * However, since the devlink lock of nested instance is held here,
- * we would end with wrong devlink instance lock ordering and
- * deadlock. Therefore the work is utilized to avoid that.
+ * Since the parent may or may not be locked, 'work' is utilized.
  */
 void devlink_rel_nested_in_notify(struct devlink *devlink)
 {
-- 
2.44.0


