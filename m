Return-Path: <linux-rdma+bounces-22611-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cru/BirDRGrr0QoAu9opvQ
	(envelope-from <linux-rdma+bounces-22611-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:35:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6566EAB05
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:35:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=mdonv5tD;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22611-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22611-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FCDE304B124
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 07:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EF03B38BB;
	Wed,  1 Jul 2026 07:33:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBF83009F6;
	Wed,  1 Jul 2026 07:33:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891239; cv=fail; b=iBt/OEnDSE7YWkxZtfowsoxS1QqRsD5oCtY2jfoG5DGfkPLmwGAnBCbG6JSP1fUuXeOLvqGwIx6rsTwhDYRDA5+zs5kKxDZFouSlxD7se0J4qyauy/2wsEObWi7AUwvJOvP0h+84+NTzPpuAFtEHyyOXhEhJzJ8Uul83P07oNKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891239; c=relaxed/simple;
	bh=+aZcsrGh+SBMyA8f6UMK8lP/vx/mBYxblsumo6wH0+c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eTwOgP6VvGzlb43JWE26iTyz5u9XaOdYXMWEpr3rbGLQ5HOFfeaXompW2/1nqjft7Cr3UnlCkgifBGqzIjUCkmKocF5orMgARVObpNieqr2AvU6ZVZ+Zd2eJRhk9qY3hBAOeYHkbYROHndPezS8coQKSH1StvIY+6MwVg443cZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mdonv5tD; arc=fail smtp.client-ip=40.93.194.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vlrr9rgZ3CU3xlwLejNLBJjDqRkk0Kzz+V2LXrySVFvKqlSbkoMgdY+NiDyw4pgTcp4+dvDA7jXw/pKxeneTyrjLImaVnFndvPKtJxKEyNGc7qUmlinWn9mzKZah6HtfGK1X6usWxQ2likXg9DgHrW8hCOMBp9h8IVR/DGO/JSYhkW6y1fWBFbL5Qm7kHLE4gyBUNyzI15GzGirVB2znVtvlP25SxNsXRnl9rciZxPEV3Kw7kaVFzCi+pJrmM3/3Q3E26DEd0EP/HtbBgMQvV4KAO3xnaD9Qm78RBfg4zXZIynhO3VYmwf3H9li/qJ793G4DO/g/yZCqaJ1SL6PPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZju8gqC19syWpSyCaF5JiYgTB84dHvVv84SZip3LG8=;
 b=lEePD2yOOIl05ZPbcFOi+SovREC/sROlL1/mGSXcp4Iba9LABRazgqM4cTbSoyes7MBg1I5MjGrV+YtDlarurvLCsKJrwW71sppTZoTaWVQwE1H3UR+cJZcXyIw9Wc/5RebHq3YNS/PYN8W6wAt1sGd9+cJgQp1VQk98CxkAgQUFTix2PFqlEv+Of6u75k77xUwYNLEJqW0zSxCPb2/5hRnzTMciNJ15CJpuffLfuc14bQFi+OhCqSSTRZBWXtBHIhCW41hFrJ0njsuOPZmU8u+841YI40G0pw45BN9+plPnQDhe9kEW1wjqpUkj9+yOI47j4jJCLSuxLHxHd42/Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZju8gqC19syWpSyCaF5JiYgTB84dHvVv84SZip3LG8=;
 b=mdonv5tDAiRPztRMMSVt+q54LKX+v+bw9n4+9x1yQZ1tnvQ77vKTxosEZ2c+QUY/uXflzKYO7tocxoeBu2c8q79XiHfGXFkJa4h2sbF1SOUbgXNHjaoGlZrsOi2oUYIo0JCWHE2RCeXv4cSwN2ZosWPslZEHXTaQKaQaYHkkTOVIrgewx4abgocAopUMwtQF68kL0vEcVN9cgchqHv1W9hfF/37Mwil/wZQioL0ypFjt3OMEFOkerNOqLvzwoRdejxnp7G/fVRJ9SPm07EV71YSl6uNS0KfRb53XXTv/NvpkQAkZ8tudZ8+68Zik0EmHb9ivCGKMdDNbZ9h/deQBJQ==
Received: from DS7PR03CA0191.namprd03.prod.outlook.com (2603:10b6:5:3b6::16)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:33:45 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::b) by DS7PR03CA0191.outlook.office365.com
 (2603:10b6:5:3b6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 07:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 07:33:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:33:23 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:33:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 00:33:13 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Adithya Jayachandran <ajayachandra@nvidia.com>, Bobby Eshleman
	<bobbyeshleman@meta.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, Daniel Jurgens
	<danielj@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, David Wei
	<dw@davidwei.uk>, Donald Hunter <donald.hunter@gmail.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Joe Damato <joe@dama.to>, Jonathan Corbet
	<corbet@lwn.net>, Kees Cook <kees@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ratheesh Kannoth
	<rkannoth@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, Shay Drori <shayd@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Simon Horman
	<horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Tariq Toukan
	<tariqt@nvidia.com>, Willem de Bruijn <willemb@google.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V10 00/14] devlink and mlx5: Support cross-function rate scheduling
Date: Wed, 1 Jul 2026 10:32:40 +0300
Message-ID: <20260701073254.754518-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|DS7PR12MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2e555d-1939-4e04-c8b9-08ded74314d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|23010399003|82310400026|7416014|376014|1800799024|36860700016|18002099003|13003099007|5023799004|11063799006|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SHLoxC+SPh0RpZUyNYCd3dLlsNATh9WQSRdx0wkS46aetgAyLAmsatlfaaAqwsugP/avOoc032ycGZzpprcyRmJdXPKsMojRNiVOt1Bhj5zOg4YQvD+stmGioiKQcL9GtyNvI02ZE9K+Bo1ewVCAMH+G5a4ctBaITZ3U93lKPYEEHkTQsgb9NZPooBwnEMdKQysXrHfDgf5vPrhcUuIv4qBTXwKnAxFQtUF76rUUK3PCUm6AAcDY2tQhFTVJSmfG7K+C3eao72Vv7TJgW5lPwl7swdoPySWB7FMy6XAisYmn2/wTixJo9IlZ+uG/bdQPDmTB8SHaikT4h/yN4+5pz8z62b/fUs/jJzU3c2HWTy1YDGXFKHfSQKeP7bVqsV3Pn/uQ96q/j6cH54Bns2XWdI+HBsEKnP85Vyitkw5q21ARODDtYU6GUMuzWHSJ5XgQcFtm359T5xV13UXGHnKbgVdsjBXYpXyaL7uqKfnIZ7Wejlxw45dXPR/s6DQDrTsE6BrfcKbCmBuwWQNp21dOz53N38vPrM5R6g0SXf3B9rQOGCxP5NMrtH4DLc6d73gUyLzte+DCmJC/cfWeYg4rBGm5TzJQNXUXKXdVVHso2SPokvxoTKHWQnH6rr4lAgkmYfb3CZIjcqGRFB6kv4WIosQ+XJu1D6OIPZM0mL6YC2b/dCfSM1gAs7S18ewWxXaT/PPTp3jR4Cgz6KBDYLA/Ag==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(30052699003)(23010399003)(82310400026)(7416014)(376014)(1800799024)(36860700016)(18002099003)(13003099007)(5023799004)(11063799006)(3023799007)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	a4VlWFtCOShOWL5AKcm/oMtXi2x7suICIJRW6YCNOL90piUVH17GgYaI0eWynSDbnvrFLaXTPFjbG1dZiuTY1ojxYrnmmoiSCrf6KhOdODv4IOToT5a8QAVVb4/kpUzzA+DxxXrulOhZ6YwLsVP6W2p4PNohwBUmABYZopVyq0sb6f722wrwsTp055pGkhLAoFVx8WxtZPCScdpIkwBL4c2fWU3WBQJFCWKz9Do5lZBtOkimCEATa3X5ZCC92OhCcIsiySxj82KZopp4GCaNLxx0KouUMRnCihiDAczCZqrA0F05jMLXZ3ngI0fEOD65yAs3sorSupce9ljKGlMNKoe/vMVM19mo9TTBZjWAxlnbWc/VE/ZEq9LolHSNT+NCD9/1s0hSR3nJJUM881mBbttiLxSmkf41awUyf3Lg9mPwsRj3fK0YI9ETPRuyb4Ej
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:33:44.2981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2e555d-1939-4e04-c8b9-08ded74314d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:ajayachandra@nvidia.com,m:bobbyeshleman@meta.com,m:cjubran@nvidia.com,m:cratiu@nvidia.com,m:daniel@iogearbox.net,m:danielj@nvidia.com,m:daniel.zahka@gmail.com,m:dw@davidwei.uk,m:donald.hunter@gmail.com,m:dtatulea@nvidia.com,m:jiri@nvidia.com,m:jiri@resnulli.us,m:joe@dama.to,m:corbet@lwn.net,m:kees@kernel.org,m:leon@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:ohartoov@nvidia.com,m:parav@nvidia.com,m:petrm@nvidia.com,m:rkannoth@marvell.com,m:saeedm@nvidia.com,m:shshitrit@nvidia.com,m:shayd@nvidia.com,m:shuah@kernel.org,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:sdf@fomichev.me,m:tariqt@nvidia.com,m:willemb@google.com,m:gal@nvidia.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:donaldhunter@gmail.co
 m,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22611-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,meta.com,iogearbox.net,gmail.com,davidwei.uk,resnulli.us,dama.to,lwn.net,kernel.org,vger.kernel.org,marvell.com,linuxfoundation.org,fomichev.me,google.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B6566EAB05

Hi,

This series by Cosmin adds support for cross-function rate scheduling in
devlink and mlx5.
See detailed explanation by Cosmin below [0].

Regards,
Tariq

[0]
devlink objects support rate management for TX scheduling, which
involves maintaining a tree of rate nodes that corresponds to TX
schedulers in hardware. 'man devlink-rate' has the full details.

The tree of rate nodes is maintained per devlink object, protected by
the devlink lock.

There exists hardware capable of instantiating TX scheduling trees
spanning multiple functions of the same physical device (and thus
devlink objects) and therefore the current API and locking scheme is
insufficient.

This patch series changes the devlink rate implementation and API to
allow supporting such hardware and managing TX scheduling trees across
multiple functions of a physical device.

Modeling this requires having devlink rate nodes with parents in other
devlink objects. A naive approach that relies on the current
one-lock-per-devlink model is impossible, as it would require in some
cases acquiring multiple devlink locks in the correct order.

The solution proposed in this patch series makes use of the recently
introduced shared devlink instance [1] to manage rate hierarchy changes
across multiple functions.

V1 of this patch series was sent a long time ago [2], using a different
approach of storing rates in a shared rate domain with special locking
rules. This new approach uses standard devlink instances and nesting.

The first part of the series adds support to devlink rates for
maintaining the rate tree across multiple functions.

The second part changes the mlx5 implementation to make use of this (and
cleans up remnants of the previous approach, involving rate domains).

The neat part about using the shared devlink object is that it works for
SFs as well, which are already nested in their parent PF instances. So
with this series, complex scheduling trees spanning multiple SFs across
multiple PFs of the same NIC can now be supported.

---

[1] https://lore.kernel.org/all/20260312100407.551173-1-jiri@resnulli.us/T/#u
[2] https://lore.kernel.org/netdev/20250213180134.323929-1-tariqt@nvidia.com/
[3] https://lore.kernel.org/netdev/20260325152801.236343-1-jiri@resnulli.us/

Comments from internal Sashiko review:
> When a rate node is linked to a parent on a different devlink device, should
> the rate-get reply and dump operations also include the parent's device
> information?
> Currently, parent-dev is only added to the request attributes for rate-set
> and rate-new, but it appears to be omitted from the serialization logic and
> the rate-get reply definition. Does this render the cross-device
> relationship invisible to user space monitoring tools?

[CR] Preexisting problem with devlink rate API, the rate-get command
specifies only a subset of output attributes. May be fixed separately.

> > diff --git a/net/devlink/rate.c b/net/devlink/rate.c
> > index 5436811cfbbd..2b30329a1394 100644
> > --- a/net/devlink/rate.c
> > +++ b/net/devlink/rate.c
> > @@ -660,9 +660,11 @@ int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
> >
> >  int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
> >  {
> > -	struct devlink *rate_devlink, *devlink = devlink_nl_ctx(info)->devlink;
> > +	struct devlink_nl_ctx *ctx = devlink_nl_ctx(info);
> > +	struct devlink *devlink = ctx->devlink;
> While ctx is now retrieved, does the rest of the function ignore
> ctx->parent_devlink?

> It looks like the command handlers never retrieve or use the parent devlink,
> and unconditionally use the child's devlink for lookups and assignments. Will
> this cause cross-device parent assignments to silently fail or return -ENODEV
> since they search for the parent node exclusively on the child's device?

[CR] False positive, it's used in devlink_nl_rate_parent_node_set().

> Additionally, looking at how the parent devlink is prepared in
> __devlink_nl_pre_doit() (which is called via
> DEVLINK_NL_FLAG_OPTIONAL_PARENT_DEV):
> __devlink_nl_pre_doit()
>     if (parent_dev && attrs[DEVLINK_ATTR_PARENT_DEV]) {
>         parent_devlink = devlink_get_parent_from_attrs_lock(net, attrs);
>         ...
>         devlink_nl_ctx(info)->parent_devlink = parent_devlink;
>         /* Drop the parent devlink lock but don't release the reference.
>          * This will keep it alive until the end of the request.
>          */
>         devl_unlock(parent_devlink);
>     }
> To actually implement the cross-device feature in the command handlers, the
> parent's rate list would need to be accessed. Since the parent devlink lock
> is explicitly dropped here, wouldn't accessing the parent's rate list
> without its lock violate devlink locking rules and lead to data races?

[CR] Locking changes are intentional. All rate changes for anything in
the rate group now acquire the root devlink lock, where rates are
stored.

> >   * devl_rate_nodes_destroy - destroy all devlink rate nodes on device
> >   * @devlink: devlink instance
> >   *
> > - * Unset parent for all rate objects and destroy all rate nodes
> > - * on specified device.
> > + * Unset parent for all rate objects involving this device and destroy all rate
> > + * nodes on it.
> >   */
> >  void devl_rate_nodes_destroy(struct devlink *devlink)
> >  {
> > -	const struct devlink_ops *ops = devlink->ops;
> >  	struct devlink_rate *devlink_rate, *tmp;
> > +	const struct devlink_ops *ops;
> > +	struct devlink *rate_devlink;
> >
> >  	devl_assert_locked(devlink);
> > +	rate_devlink = devl_rate_lock(devlink);
> >
> > -	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
> > -		if (!devlink_rate->parent)
> > +	list_for_each_entry(devlink_rate, &rate_devlink->rate_list, list) {
> > +		if (!devlink_rate->parent ||
> > +		    (devlink_rate->devlink != devlink &&
> > +		     devlink_rate->parent->devlink != devlink))
> >  			continue;
> >
> > +		/* This could destroy rate objects on other devlinks in the
> > +		 * same hierarchy under 'rate_devlink'. This is safe because
> > +		 * the shared common ancestor is locked so there can be no
> > +		 * other concurrent rate operations on devlink_rate->devlink.
> > +		 */
> > +		ops = devlink_rate->devlink->ops;
> Does this code invoke devlink_ops callbacks on other devlink instances
> without holding their instance lock?
> While the comment indicates the shared common ancestor lock prevents concurrent
> rate operations, the child device's instance lock (devlink_rate->devlink) is
> not held.
> Could this violate the devlink locking contract if the driver is executing
> concurrent non-rate operations on the child instance? Because devlink
> drivers rely on the instance lock to serialize access to their internal
> structures, could invoking these callbacks unlocked cause data corruption or
> trigger lockdep splats if the driver asserts devl_assert_locked()?

[CR] As mentioned in the comment, concurrent ops which touch rates
_will_ eventually acquire the shared devlink lock, so they're safe. We
don't care about other ops, since we only touching rates here.

> > @@ -321,22 +307,19 @@ static int esw_qos_create_rate_limit_element(struct mlx5_esw_sched_node *node,
> >  	return esw_qos_node_create_sched_element(node, sched_ctx, extack);
> >  }
> >
> > -static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw,
> > -					      struct mlx5_esw_sched_node *parent)
> > +static u32
> > +esw_qos_calculate_min_rate_divider(struct mlx5_esw_sched_node *parent)
> >  {
> > -	struct list_head *nodes = parent ? &parent->children : &esw->qos.domain->nodes;
> > -	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
> > +	u32 fw_max_bw_share = MLX5_CAP_QOS(parent->esw->dev, max_tsar_bw_share);
> This is a pre-existing issue, but does this division risk a divide-by-zero
> panic regression?
> If the hardware does not support bandwidth sharing, max_tsar_bw_share
> could be 0. If a user subsequently sets a non-zero tx_share (minimum rate
> guarantee), max_guarantee becomes greater than 0, resulting in
> max_guarantee / fw_max_bw_share.
> Should we validate whether fw_max_bw_share is non-zero before performing
> the division?

[CR] Preexisting, also not really possible for fw to give a value of 0
for the divisor.

> > @@ -665,7 +631,6 @@ static int esw_qos_create_tc_arbiter_sched_elem(
> >  		struct netlink_ext_ack *extack)
> >  {
> >  	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
> > -	u32 tsar_parent_ix;
> >  	void *attr;
> This is a pre-existing issue, but is there a hardware scheduling element
> leak when transitioning a node to a TC arbiter?
> When esw_qos_tc_arbiter_scheduling_setup() calls
> esw_qos_create_tc_arbiter_sched_elem(node, extack), it provisions a new
> hardware element and immediately overwrites node->ix with its ID.
> If the subsequent step esw_qos_create_vports_tc_nodes(node, extack) fails,
> it jumps to err_tc_node_create and restores node->ix = curr_ix, but it
> doesn't appear to tear down the newly created scheduling element. Does this
> permanently leak the newly provisioned hardware element in the firmware?

[CR] False alarm, the call to esw_qos_node_destroy_sched_element()
destroys the new temporary scheduling element on failure.

> > @@ -1319,11 +1288,9 @@ static int esw_qos_switch_tc_arbiter_node_to_vports(
> >  	struct mlx5_esw_sched_node *node,
> >  	struct netlink_ext_ack *extack)
> >  {
> This is a pre-existing issue, but what happens if the rollback path fails
> during vport migration in esw_qos_switch_vports_node_to_tc_arbiter()?
> If an error occurs, it attempts to rollback by calling
> esw_qos_switch_vport_tcs_to_vport(). If this rollback fails internally
> (e.g. due to ENOMEM in esw_qos_vport_update()), the vport is
> successfully restored to the doomed TC arbiter node, and the error
> is silently ignored.
> Then, the caller esw_qos_node_enable_tc_arbitration() executes
> esw_qos_tc_arbiter_scheduling_teardown(), which frees the TC arbiter's
> VPORTS_TC_TSAR nodes without freeing the attached vport VPORT_TC nodes.
> Does this leak the vport TC nodes and leave them holding use-after-free
> pointers to their freed parents, leading to memory corruption when the
> vport is later disabled?

[CR] Preexisting, also hard to hit. Requires a failure mid-way when
switching nodes to TC arbitration AND a failure during rollback. Fixing
it outside the scope of this series.

> > @@ -1888,7 +1855,9 @@ mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
> >  		err = mlx5_esw_qos_vport_enable(vport, type, parent, 0, 0,
> >  						extack);
> >  	} else if (vport->qos.sched_node) {
> > -		err = esw_qos_vport_update_parent(vport, parent, extack);
> > +		err = esw_qos_vport_update_parent(vport,
> > +						  parent ? : esw->qos.root,
> > +						  extack);
> Can this sequence cause a use-after-free regression on esw->qos.root
> when updating a vport's QoS configuration?
> If a vport is the only QoS user in the E-Switch, esw->qos.refcnt is 1.
> If its QoS configuration is updated, esw_qos_vport_update() is called
> with the parent argument pointing to esw->qos.root (since this patch
> changes the default parent from NULL to esw->qos.root).
> Inside esw_qos_vport_update(), mlx5_esw_qos_vport_disable_locked() drops
> the vport's QoS reference, decrementing esw->qos.refcnt to 0. This
> triggers esw_qos_destroy(), freeing esw->qos.root.
> The function then calls mlx5_esw_qos_vport_enable(..., parent, ...) passing
> the stale parent pointer. Because parent is no longer NULL, it doesn't
> fetch the newly re-allocated root node, and instead passes the freed
> pointer to __esw_qos_alloc_node(), resulting in a use-after-free.

[CR] False alarm. The finding confuses esw_qos_vport_disable() and
mlx5_esw_qos_vport_disable_locked(). esw_qos_vport_disable() doesn't
touch the refcnt.

> > @@ -1859,13 +1840,15 @@ mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
> >  						  extack);
> >  	}
> > -	esw_qos_unlock(esw);
> > +
> >  	return err;
> >  }
> >
> >  void mlx5_esw_qos_vport_clear_parent(struct mlx5_vport *vport)
> >  {
> > +	esw_qos_lock(vport->dev);
> >  	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
> > +	esw_qos_unlock(vport->dev);
> >  }
> Could this lead to a recursive mutex deadlock during VF teardown on older
> hardware where shd is NULL?
> In the teardown path, mlx5_eswitch_unload_pf_vf_vport() already acquires
> esw->state_lock. It then proceeds to call:
> mlx5_eswitch_unload_pf_vf_vport()
>   mlx5_eswitch_unload_vport()
>     mlx5_esw_offloads_unload_rep()
>       mlx5_esw_offloads_devlink_port_unregister()
>         mlx5_esw_qos_vport_clear_parent()
> Since this patch changes mlx5_esw_qos_vport_clear_parent() to
> unconditionally call esw_qos_lock(), which falls back to acquiring
> esw->state_lock when dev->shd is NULL, won't this result in an attempt to
> re-acquire the non-recursive state_lock that is already held by the
> teardown process?

[CR] False alarm. state_lock isn't held during VF teardown.

> > @@ -839,13 +940,17 @@ void devl_rate_nodes_destroy(struct devlink *devlink)
> >  		refcount_dec(&devlink_rate->parent->refcnt);
> >  		devlink_rate->parent = NULL;
> When unsetting the parent of a rate object in devl_rate_nodes_destroy(),
> this patch allows it to happen to cross-device child nodes (where
> devlink_rate->devlink != devlink). Since the child's devlink instance is
> still active, shouldn't its state change (losing its parent) be
> communicated to user space?
> Omitting devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW) here might
> leave user space monitors out of sync, incorrectly believing the active child
> is still attached to the deleted parent node.

[CR] Preexisting, devl_rate_nodes_destroy() didn't send notifications.

> > +static struct devlink *devl_rate_lock(struct devlink *devlink)
> >  {
> > -	return devlink;
> > +	struct devlink *rate_devlink = devlink, *parent;
> > +
> > +	devl_assert_locked(devlink);
> > +
> > +	while (rate_devlink->ops &&
> > +	       rate_devlink->ops->supported_cross_device_rate_nodes) {
> > +		parent = devlink_nested_in_get_lock(rate_devlink);
> > +		if (!parent)
> > +			break;
> Can this lead to list corruption if the parent devlink is unregistered?
> If the parent is unregistered concurrently (for example, a PF is unregistered
> before VF teardown), devlink_nested_in_get_lock() will return NULL because of
> this internal check:
> devlink_nested_in_get_lock() {
>     ...
>     if (devl_is_registered(devlink))
>         return devlink;
>     ...
>     return NULL;
> }
> Since parent is NULL, this loop breaks and returns the child devlink lock
> instead of the parent's lock. Later, in functions like devl_rate_leaf_destroy(),
> list_del(&devlink_rate->list) is called on the rate node.
> Because the rate node is chained into the parent's rate_list, does this
> modify the parent's list concurrently without holding its lock?

[CR] This misunderstands the nesting hierarchy. VFs are not nested in
PFs, PFs are nested in shd, which is reference counted (=> outlives all
PFs) and keeps all rate nodes for all PFs.

> This is a pre-existing issue, but does devlink_nl_rate_del_doit()
> unconditionally free rate nodes even if the driver rejects the deletion?
> Looking at devlink_nl_rate_del_doit() in net/devlink/rate.c:
> devlink_nl_rate_del_doit() {
>     ...
>     err = devlink->ops->rate_node_del(rate_node, rate_node->priv,
>                                       info->extack);
>     if (rate_node->parent)
>         refcount_dec(&rate_node->parent->refcnt);
>     list_del(&rate_node->list);
>     kfree(rate_node->name);
>     kfree(rate_node);
>     ...
> }
> If the hardware or driver cannot fulfill the request and ops->rate_node_del()
> returns an error like -EBUSY, the function ignores the error regarding memory
> management and proceeds to kfree() the rate node.
> Could this leave the driver with a dangling pointer to the freed rate node,
> triggering a use-after-free later?

[CR] Preexisting, it is intentional that the node is removed no matter
what the rate_node_del op manages to do.

> > @@ -243,7 +243,29 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
> > +	err = nla_parse_nested(tb, maxtype, attrs[DEVLINK_ATTR_PARENT_DEV],
> > +			       devlink_dl_parent_dev_nl_policy, NULL);
> Could this nla_parse_nested() call pass down an extended ACK pointer instead
> of NULL?
> When passing NULL for the extack parameter, if the nested attribute is
> malformed (such as a missing NLA_F_NESTED flag), userspace will receive a
> silent -EINVAL without a descriptive error message.
> Because devlink_get_parent_from_attrs_lock() is called by
> __devlink_nl_pre_doit() which has access to the genl_info structure and
> its extack pointer, passing it down to this function would allow for
> reporting accurate validation errors to userspace.

[CR] Valid, but quite a lot of plumbing is necessary for extack to be
used here. Out of scope of the series.

> This is a pre-existing issue, but does the error path in
> devlink_nl_rate_new_doit() leak the parent's reference count?
> If devlink_nl_rate_set() successfully sets the parent (which increments
> parent->refcnt) but fails on a subsequent attribute validation like tc_bw,
> it returns an error.
> The cleanup path in devlink_nl_rate_new_doit() handles the error:
> err_rate_set:
>     ops->rate_node_del(rate_node, rate_node->priv, info->extack);
> err_node_new:
>     kfree(rate_node->name);
> err_strdup:
>     kfree(rate_node);
> Because this path frees the node but never decrements the parent's refcnt,
> does this permanently elevate the parent's refcount, falsely indicating it
> has children and preventing it from ever being deleted?

[CR] Preexisting, will be fixed separately with a net patch.

> > @@ -30,14 +30,42 @@ devlink_rate_leaf_get_from_info(struct devlink *devlink, struct genl_info *info)
> >  	return devlink_rate ?: ERR_PTR(-ENODEV);
> >  }
> >
> > +/* Repeatedly walks the nested devlink chain while cross device rate nodes are
> > + * supported and finds the topmost instance where rates should be stored.
> > + * That instance is locked, referenced and returned.
> > + * When cross device rate nodes aren't supported the original devlink instance
> > + * is returned.
> > + */
> >  static struct devlink *devl_rate_lock(struct devlink *devlink)
> >  {
> > -	return devlink;
> > +	struct devlink *rate_devlink = devlink, *parent;
> > +
> > +	devl_assert_locked(devlink);
> > +
> > +	while (rate_devlink->ops &&
> > +	       rate_devlink->ops->supported_cross_device_rate_nodes) {
> > +		parent = devlink_nested_in_get_lock(rate_devlink);
> > +		if (!parent)
> > +			break;
> > +		if (rate_devlink != devlink) {
> > +			/* Unlock intermediate instances. */
> > +			devl_unlock(rate_devlink);
> > +			devlink_put(rate_devlink);
> > +		}
> > +		rate_devlink = parent;
> > +	}
> > +	return rate_devlink;
> >  }
> Now that devl_rate_lock() returns the shared ancestor, does this cause
> devlink_rates_check() to skip child rate nodes?
> In net/devlink/rate.c:devlink_rates_check(), the loop filters nodes by the
> devlink pointer:
> 	rate_devlink = devl_rate_lock(devlink);
> 	list_for_each_entry(devlink_rate, &rate_devlink->rate_list, list)
> 		if (devlink_rate->devlink == devlink &&
> 		    (!rate_filter || rate_filter(devlink_rate))) {
> 			...
> 			err = -EBUSY;
> 			break;
> 		}
> Because of this check, if a user creates an SF rate node and then triggers an
> eswitch mode change to legacy on the PF devlink, devlink_rates_check() skips
> the SF node and returns 0 instead of -EBUSY.
> Could this allow mlx5_devlink_eswitch_mode_set() to proceed and unconditionally
> free the QoS domain in mlx5_esw_qos_cleanup(), while the child SF devlink and
> its software rate node remain active?
> If so, a subsequent operation on the active child SF rate node (like
> DEVLINK_CMD_RATE_DEL) would invoke mlx5_esw_devlink_rate_node_del() and call
> esw_qos_lock(), leading to a NULL pointer dereference when accessing
> esw->qos.domain->lock.

[CR] False alarm, no driver uses supported_cross_device_rate_nodes yet
so this code path isn't taken. QoS domains are removed in a later patch
in the series before the cross device flag is enabled, so this finding
is moot.

> >  static int mlx5_esw_qos_max_link_speed_get(struct mlx5_core_dev *mdev, u32 *link_speed_max,
> > -					   bool take_rtnl,
> >  					   struct netlink_ext_ack *extack)
> >  {
> >  	int err;
> >
> > -	if (!mlx5_lag_is_active(mdev))
> > +	if (!mlx5_lag_is_active(mdev) ||
> > +	    mlx5_lag_query_bond_speed(mdev, link_speed_max) < 0 ||
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This is a pre-existing issue, but does mlx5_lag_query_bond_speed() have a race
> condition when accessing the ldev->tracker structure?
> The mlx5_lag_query_bond_speed() function reads ldev->tracker.bond_speed_mbps
> while holding lag_lock. However, mlx5_lag_netdev_event() modifies
> ldev->tracker holding only rtnl_lock, without holding lag_lock:
> drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c:mlx5_lag_netdev_event() {
>     ...
>     ldev->tracker = tracker;
>     ...
> }
> Concurrently, mlx5_ldev_add_netdev() modifies fields inside it under lag_lock,
> meaning its updates can be overwritten and lost by the read-modify-write in
> mlx5_lag_netdev_event().
> Since this patch now heavily relies on mlx5_lag_query_bond_speed() for QoS
> max link speed, could this expose readers to observing torn or inconsistent
> tracker states?

[CR] Preexisting, no impact. Either a value of 0 is read, or the correct one.

> > @@ -458,10 +461,17 @@ esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
> >  	MLX5_SET(scheduling_context, sched_ctx, max_average_bw,
> >  		 vport_node->max_rate);
> > +	if (vport->dev != dev) {
> > +		/* The port is assigned to a node on another eswitch. */
> > +		MLX5_SET(vport_element, attr, eswitch_owner_vhca_id_valid,
> > +			 true);
> > +		MLX5_SET(vport_element, attr, eswitch_owner_vhca_id,
> > +			 MLX5_CAP_GEN(vport->dev, vhca_id));
> Does this code silently truncate the vhca_id if it is >= 2048?
> The hardware structure mlx5_ifc_vport_element_bits defines
> eswitch_owner_vhca_id as an 11-bit field, but MLX5_CAP_GEN(..., vhca_id)
> returns a 16-bit identifier. The MLX5_SET macro will silently apply a
> mask of 0x7ff. Should there be a bounds check returning an error like
> -EOVERFLOW here, or does the hardware actually support a 16-bit field?

[CR] vhca_id >= 2048 would imply a NIC with that many physical ports,
which is only possible in theory. Not worth addressing.

> > @@ -1221,8 +1260,15 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
> >  	if (err)
> >  		return err;
> >
> > -	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type)
> > +	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type) {
> >  		esw_qos_tc_arbiter_get_bw_shares(vport_node, curr_tc_bw);
> Does this condition skip the preservation and restoration of TC bandwidth
> shares when transitioning between different node types?
> When a vport transitions away from SCHED_NODE_TYPE_TC_ARBITER_TSAR
> (e.g., to a regular SCHED_NODE_TYPE_VPORT), curr_type != type evaluates to
> true, causing the function to skip saving the current tc_bw shares.
> esw_qos_vport_disable() then unconditionally clears vport_node->tc_bw to
> zero.
> If the subsequent esw_qos_vport_enable() fails, the rollback path attempts
> to restore the old TC_ARBITER_TSAR state.
> However, because curr_type != type, the code skips restoring the bandwidth
> shares via esw_qos_set_tc_arbiter_bw_shares().
> Are the vport's bandwidth guarantees permanently erased in this failure
> scenario?

[CR] Pre-existing, unlikely and low-impact: If tc-bw settings fail,
there will be an error and an opportunity for the user to retry.

> > @@ -1990,6 +1990,13 @@ void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf)
> >  		 esw->esw_funcs.num_vfs, esw->esw_funcs.num_ec_vfs, esw->enabled_vports);
> >
>  	mlx5_eswitch_invalidate_wq(esw);
> > +
> > +	if (esw->mode == MLX5_ESWITCH_OFFLOADS) {
> > +		struct devlink *devlink = priv_to_devlink(esw->dev);
> > +
> > +		devl_rate_nodes_destroy(devlink);
> > +	}
> > +
> Can this reordering cause a use-after-free if leaf unparenting fails?
> Devlink's devl_rate_nodes_destroy() calls ops->rate_leaf_parent_set(..., NULL)
> which maps to mlx5_esw_qos_vport_update_parent(). Devlink ignores the return
> value of this callback.
> If the hardware operation fails (e.g., due to a firmware timeout), the driver
> leaves vport->qos.sched_node->parent pointing to the original parent node.
> Devlink then unconditionally proceeds to destroy and free the rate node.
> Later, when mlx5_eswitch_unload_vf_vports() executes, it calls
> mlx5_esw_qos_vport_disable(), which reaches esw_qos_vport_disable():
> drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c:esw_qos_vport_disable() {
>     ...
> 	list_del_init(&vport_node->entry);
> 	esw_qos_normalize_min_rate(vport_node->esw, vport_node->parent, extack);
>     ...
> }
> Will this dereference the freed vport_node->parent, resulting in list
> corruption or a use-after-free?

[CR] This is a preexisting problem, brought to light by the reordering
of group destruction before leaf destruction. It's extremely unlikely,
requiring the firmware command to reparent a vport to its root to fail.
Fixing this properly requires multiple patches and will be pursued after
this series.

> > @@ -2039,6 +2040,9 @@ void mlx5_eswitch_disable_locked(struct mlx5_eswitch *esw)
> >  		 esw->mode == MLX5_ESWITCH_LEGACY ? "LEGACY" : "OFFLOADS",
> >  		 esw->esw_funcs.num_vfs, esw->esw_funcs.num_ec_vfs, esw->enabled_vports);
> >
> > +	if (esw->mode == MLX5_ESWITCH_OFFLOADS)
> > +		devl_rate_nodes_destroy(devlink);
> > +
> Does this identical reordering in the locked disable path suffer from the
> same unparenting failure use-after-free described above?

[CR] Same comment as above. QoS improvements for the error paths will
follow.

V10:
- Added a comment in devl_rate_nodes_destroy clarifying locking.
- Expanded 'supported_cross_device_rate_nodes' comment with locking
  expectations.
- Simplified rate locking by only keeping the common ancestor locked.
- Removed devlink_nested_in_get_locked and devlink_nested_in_put_unlock.
- devlink_nl_rate_parent_node_set iterates over the proper rate list.
- Refactored mlx5 locking given dev->shd is now optional (after [3]).
- Fixed a bug in pruning introduced by the root node patch.
- Fixed a bug on failure when detaching a node from parent.
- Clarified expectations for shared devlink rate storage.
- Fixed incorrect net namespace when listing shared instances.

V9:
https://lore.kernel.org/netdev/20260326065949.44058-1-tariqt@nvidia.com/

Cosmin Ratiu (14):
  devlink: Update nested instance locking comment
  devlink: Add a helper for getting a nested-in instance
  devlink: Migrate from info->user_ptr to info->ctx
  devlink: Decouple rate storage from associated devlink object
  devlink: Add parent dev to devlink API
  devlink: Allow parent dev for rate-set and rate-new
  devlink: Allow rate node parents from other devlinks
  net/mlx5: qos: Use mlx5_lag_query_bond_speed to query LAG speed
  net/mlx5: qos: Refactor vport QoS cleanup
  net/mlx5: qos: Model the root node in the scheduling hierarchy
  net/mlx5: qos: Remove qos domains and use shd
  net/mlx5: qos: Support cross-device tx scheduling
  selftests: drv-net: Add test for cross-esw rate scheduling
  net/mlx5: Document devlink rates

 Documentation/netlink/specs/devlink.yaml      |  30 +-
 .../networking/devlink/devlink-port.rst       |   2 +
 Documentation/networking/devlink/index.rst    |   8 +-
 Documentation/networking/devlink/mlx5.rst     |  33 +
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   1 +
 .../mellanox/mlx5/core/esw/devlink_port.c     |   1 -
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 605 +++++++++---------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   3 -
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  27 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  18 +-
 include/net/devlink.h                         |   9 +
 include/uapi/linux/devlink.h                  |   2 +
 net/devlink/core.c                            |  20 +-
 net/devlink/dev.c                             |  16 +-
 net/devlink/devl_internal.h                   |  20 +
 net/devlink/dpipe.c                           |  14 +-
 net/devlink/health.c                          |  12 +-
 net/devlink/linecard.c                        |   4 +-
 net/devlink/netlink.c                         |  82 ++-
 net/devlink/netlink_gen.c                     |  24 +-
 net/devlink/netlink_gen.h                     |   8 +
 net/devlink/param.c                           |   4 +-
 net/devlink/port.c                            |  18 +-
 net/devlink/rate.c                            | 331 +++++++---
 net/devlink/region.c                          |   6 +-
 net/devlink/resource.c                        |  14 +-
 net/devlink/sb.c                              |  22 +-
 net/devlink/trap.c                            |  12 +-
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/devlink_rate_cross_esw.py  | 296 +++++++++
 30 files changed, 1132 insertions(+), 511 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/devlink_rate_cross_esw.py


base-commit: 1c664ec4b9ea827b609d296921ed5bad8a40a158
-- 
2.44.0


