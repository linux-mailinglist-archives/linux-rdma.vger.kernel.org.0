Return-Path: <linux-rdma+bounces-16133-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMA+ECfzeWnT1AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16133-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:29:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B33A06DC
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 717F63063433
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD02434EEE5;
	Wed, 28 Jan 2026 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DYCHvir0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF96221DB5;
	Wed, 28 Jan 2026 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599667; cv=fail; b=kBqkuZdPEEMnFy6j2Qt3cWo1zitNAgcCn6SMe31ODJSRhC5kzxwycdvIsu/3Ykva3bRA/js+PzTrITie4E/0gF8t3fxwvym7eXPMx/dSrMGxvDC4mhSfB392H2aA7hikR86N+mDR/jiQ/v+t9qoxsQKVzSwK0iM3m8b8RHTE600=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599667; c=relaxed/simple;
	bh=tqtxwkcgdOO9oPYo3qxVIErS5pN3t1jUljPH9CoKqd8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AGhoEAYXOrJs9rTQknNmWf3/RjDjqUt4+NMHKbqdBqfBNtEsRxIx20NB58yFUYAPt3eMCF/g+nqlIZiJSJJ+ul8qx8R0e1dWItDLE3Df+y88G9t2takZhrApVrB1JeUwWjVYofe8SRf3A9NFIQ/6ch3u+L2HR9sJuypFhi+aBP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DYCHvir0; arc=fail smtp.client-ip=40.93.198.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSkuyLKn0vX752ToiLab9ARju6QFFI7UtDFOFi7PvkWZojdpC5K/7KkDwdIpVmF4Q/kRxma34dS04eAKUlYOs43Xyh8Oe3/TeZ+l0FUpqswn+7XHI1PCflmmxRBE9gKtoEd8gNgZkg1IrbOnuVhvxlr/4h1cYuyJbl7ETt3YxxBThTvSptj2+kt+kKmAhwzvh/+edoOs/MPlXRAu1VEtVlNxa1PvTV9oHxAMPxg3UdXLvxHwrPAAqSTd0jpzi9FOD7wvhntoITCrlY+eQ1VWopJPyIzRNhBdvfE9zLutuRJ0CeS0DcQifLzV85u9kUyW943yH4+rYr1a7WUWyUEWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FM2wI9zxQTLmuj8vb0eiP2ZMQh9x+hYZqZ4ojv8MAmQ=;
 b=Rwl64jN0FOuDjKs9XekewLMmLcx2j2zlG5Wig/JKrrO1Q/a/H047AerWljc8qHudkEMFEeRHCOF/GmMbmfBYgWYIg5D56LNdn3aFFIWQOYpGLmFFaqrg+4ANsVmPt+vmbyclnUNme9EByjXV/kPEBTm1u9KiKZH+R9QDW4BPzg9e1bo+lhJA6l9kgjbpLQPYvtcV4nKjZAnKGKiGzk6EzesUbp33pBJAXUyvJHo4svrB+IPGjoJL8hZxSx0hU8gIkG4eVDR9hDzxGp/PeT7oMkprV1Uc6ssXzex9YolDCEb6Ld+371s5ScZG7zdNJZNL4yiUixP6rY6GXxq24vY8jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM2wI9zxQTLmuj8vb0eiP2ZMQh9x+hYZqZ4ojv8MAmQ=;
 b=DYCHvir0xj/hHqKpgc6Y1bxRmB/SLamUQZYc84Gr1GE7hiYwpnCOTEFwAHwy5NUyBvOmyI36p2YRtORAfjp0tAxne1x3L3+02oimLgUwGx9QcNuwwO2nqmm+TTNbeISJURMSVlAZCEVgWX1pE6u/UsUhmNU+EFYF4zJEogZHDbjeEMCoSDaSNaKRHhqnw8EpQEEH9mELkjXvW9V6vTs+mpl4YLoyQmjvBu8mxBMtOSGJI9s9zcbtF4jFWxDrei9k0l5I05RI+YwvMDe9R30u9kj5VHv7b+fcvReAjjBCWykXEQvvMZ2k1IzhUaQUmWqOLAos/ky4/eNeanWUJaMlVg==
Received: from SN7PR04CA0031.namprd04.prod.outlook.com (2603:10b6:806:120::6)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 11:27:38 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:120:cafe::9) by SN7PR04CA0031.outlook.office365.com
 (2603:10b6:806:120::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 11:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 11:27:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:27:25 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:27:23 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 28
 Jan 2026 03:27:17 -0800
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
Subject: [PATCH net-next V7 00/14] devlink and mlx5: Support cross-function rate scheduling
Date: Wed, 28 Jan 2026 13:25:30 +0200
Message-ID: <20260128112544.1661250-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8967d6-243f-41a1-d2f0-08de5e603dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|30052699003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TR0BvwKeI2sUeXzkTKsG3PjmOBqVIeIF+RAVVKVJacuQ2lH0UkaT0tP34B8o?=
 =?us-ascii?Q?OYRLJpbEkA/Y9kIJTHYvd7ijclOgOuODpQcigqNPVTrBqA5yU2+LfAE4BwhS?=
 =?us-ascii?Q?Gxcu/piBHD2PfjQQj06qmjKXw4/4oD/FI5e4HPNRa9gW6i0dvnhiGDQGXb4e?=
 =?us-ascii?Q?XpXtwwDoziX68kpTXGa/kh714TXtNczbN7fGBUtkXQ8EKAnlzPj/SQ4874m1?=
 =?us-ascii?Q?bzcDa3+1JRTpp8Le/gkhJGX0S6+zuMme/O/KPX67C/e7UcjsWADL+SI6tsnb?=
 =?us-ascii?Q?DTrZO3Rw660TUI84+VIrE/AviJ6zMhIj0WjeM61MC75a7T0De1oDg1xO8JX1?=
 =?us-ascii?Q?wPWBesY7r8TtBaiPO6vGsinY4o+UMT3PaALAB1dEQBJa/8W4aI+EQbGJpDos?=
 =?us-ascii?Q?LCZnr771FZy3MlQu7N3/nYrEVaUmw3RPvmtmXg6XQi3x35JSMjzOkkviQ7Kg?=
 =?us-ascii?Q?s1jPFS1Xx8C93OKxtIod0bYNxs5Gvz+ZGB7usAYNAGDajUOX5O2AMqtwh3MW?=
 =?us-ascii?Q?kBGe+UDogCFsxSW3UzZqG3a0ZNblzfEItbKXH0mYxXuiROavWFwGaJS6GnWO?=
 =?us-ascii?Q?5upAkiyg2xSNUITUXpi9aKkc0tt+IZbhliIQGaYo5dmgtUHfIlEwXjrGXnTO?=
 =?us-ascii?Q?Zq72GKO0FNvi1zdMNgUy9NNMWklsJiNpoaw/oLMyt5Un4xH+aZEIgAKpc8sE?=
 =?us-ascii?Q?tfC7gdXda1Tg8fbfdOnQV+eL14Xi+BdsK9Ut5Oi18OB6SJLjtejVmVLXxmFJ?=
 =?us-ascii?Q?3R9bfFNP3eqRQmvotVdZgfzSQcGo9N3IBiMDA8P3mYS2+mUdnG3a+FkZSHcp?=
 =?us-ascii?Q?Ei1Dx3urtrqvQ6KOP/5DObvXhMna7l76PzdhmdO5B4/cO3+jOzdt4741gI6S?=
 =?us-ascii?Q?g93V3nJdp/3gQQCNa93bTmxtM7tqJG6p6176j+a0uYvyFjfDuv85ow4U3GIo?=
 =?us-ascii?Q?xKipdQeKMJfeA1La8XuGYIQsfZuaMFIoUr67hlZUB4ZtSCJ0uyEe3jcK/EcV?=
 =?us-ascii?Q?Xcp1Lx37DbSywmWqDluDgFjxDr7HI0iAYlj7/JX0DBzqT1w1cg5hIrAx8rMT?=
 =?us-ascii?Q?ZEZU+vyI4sxnAJuro45BrirfolT/EXUIX3lBf79ofsPQ7YVmqyEseU5Qktz5?=
 =?us-ascii?Q?7rdk5xepGdrmqUDP+w0BQ+4udlpeoAy1T33Nnt2JhJchqm4UuH/c6HkqkPAU?=
 =?us-ascii?Q?vzzETKSnmNAly9vYBpBolny/whzfMpAeWwFKCPE6k4OODBq1j1MHIHgcJm5c?=
 =?us-ascii?Q?4PniyLxx8TUsI442hu6GFllDBzzss93LDkgGjeM5TsxeIJLAfqHiM/tgRpEt?=
 =?us-ascii?Q?tnChBHfLijJfwu8EDqJ+8zaqadhuY8p2At7GxI/S4NP6UM8T4iF+s+/70vRO?=
 =?us-ascii?Q?U1793aYQ7pcEgbmOkZTaqusRR2819hgYcsfzucn+PQn8MotgcLuS9PRjiDNh?=
 =?us-ascii?Q?B9ESu8doIDrCZWzfh1GQNPsFVjZd8hf+x/1vj6U1GCJ7oQ5ItdJKBt4U94HO?=
 =?us-ascii?Q?prV5Xz3DH4TPT68BlxAXigIX7sbPMGztBIC4gB/Mh2dL7/6rpjHZEVIrLQm/?=
 =?us-ascii?Q?mHEfjmP3lAXbDbESJ5WT/ACb/LDY9YwmvKWgZHAwxQRmHJE4wWLvb5eVAoQj?=
 =?us-ascii?Q?A8ahh0qb3bNUvpc23pG+KjxhAjQtWVFZthSieGf6M6OjJhqAFByLEhSgcODg?=
 =?us-ascii?Q?n3bC0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(30052699003)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:27:37.8047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8967d6-243f-41a1-d2f0-08de5e603dc4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16133-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A9B33A06DC
X-Rspamd-Action: no action

Hi,

This series by Cosmin and Jiri adds support for cross-function rate
scheduling in devlink and mlx5.
See detailed explanation by Cosmin below [1].

Regards,
Tariq


[1]
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

The solution proposed in this patch series consists of two parts:

1. Representing the underlying physical NIC as a shared devlink object
   on the faux bus and nesting all its PF devlink instances in it.

2. Changing the devlink rate implementation to store rates in this
   shared devlink object, if it exists, and use its lock to protect
   against concurrent changes of the scheduling tree.

With these in place, cross-esw scheduling support is added to mlx5.
The neat part about this approach is that it works for SFs as well,
which are already nested in their parent PF instances. So with this
series, complex scheduling trees spanning multiple SFs across multiple
PFs of the same NIC can now be supported.

V1 of this patch series was sent a long time ago [2], using a different
approach of storing rates in a shared rate domain with special locking
rules. This new approach uses standard devlink instances and nesting.

Patches:

devlink rate changes for cross-device TX scheduling:
devlink: Reverse locking order for nested instances
documentation: networking: add shared devlink documentation
devlink: Add helpers to lock nested-in instances
devlink: Refactor devlink_rate_nodes_check
devlink: Decouple rate storage from associated devlink object
devlink: Add parent dev to devlink API
devlink: Allow parent dev for rate-set and rate-new
devlink: Allow rate node parents from other devlinks
devlink: introduce shared devlink instance for PFs on same chip

mlx5 support for cross-device TX scheduling:
net/mlx5: Add a shared devlink instance for PFs on same chip
net/mlx5: Expose a function to clear a vport's parent
net/mlx5: Store QoS sched nodes in the sh_devlink
net/mlx5: qos: Support cross-device tx scheduling
net/mlx5: Document devlink rates

[2] https://lore.kernel.org/netdev/20250213180134.323929-1-tariqt@nvidia.com/

v7:
- Fix file truncate issue (AI-agent).
- Moved new handlers and parent dev policy to next patch (Simon Horman).
- Link to V6: https://lore.kernel.org/netdev/1769340723-14199-1-git-send-email-tariqt@nvidia.com/T/#u

V6:
- Really stopped using __free (Krzysztof Kozlowski).
- Fixed incorrect state->idx usage in rate dump (AI tool).
- Merged patches V5.12 and V5.14 to close a bisect bug (AI tool).
- Link to V5: https://lore.kernel.org/all/1768895878-1637182-1-git-send-email-tariqt@nvidia.com/

V5:
- Made parts of shd generic devlink infra (Jakub).
- Stopped using __free (Krzysztof Kozlowski).
- Moved some generated netlink in the correct patch (Simon Horman).
- Addressed cleanup bug (Jakub).
- Clarified uses of shared devlink in documentation.

V4:
- Fix typo in documentation (Randy Dunlap).

V3:
- Remove mistakenly repeated devlink interface in docs (Jakub).
- Add Jiri's review tags on ML.

V2:
- Rebase.
- Add Jiri's review tags on ML.

Cosmin Ratiu (11):
  devlink: Reverse locking order for nested instances
  devlink: Add helpers to lock nested-in instances
  devlink: Refactor devlink_rate_nodes_check
  devlink: Decouple rate storage from associated devlink object
  devlink: Add parent dev to devlink API
  devlink: Allow parent dev for rate-set and rate-new
  devlink: Allow rate node parents from other devlinks
  net/mlx5: Expose a function to clear a vport's parent
  net/mlx5: Store QoS sched nodes in the sh_devlink
  net/mlx5: qos: Support cross-device tx scheduling
  net/mlx5: Document devlink rates

Jiri Pirko (3):
  documentation: networking: add shared devlink documentation
  devlink: introduce shared devlink instance for PFs on same chip
  net/mlx5: Add a shared devlink instance for PFs on same chip

 Documentation/netlink/specs/devlink.yaml      |  22 +-
 .../networking/devlink/devlink-port.rst       |   2 +
 .../networking/devlink/devlink-shared.rst     |  95 +++++
 Documentation/networking/devlink/index.rst    |   1 +
 Documentation/networking/devlink/mlx5.rst     |  33 ++
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   1 +
 .../mellanox/mlx5/core/esw/devlink_port.c     |   2 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 332 ++++++++----------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   3 -
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   9 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  14 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  17 +
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  99 ++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  |  14 +
 include/linux/mlx5/driver.h                   |   1 +
 include/net/devlink.h                         |  13 +
 include/uapi/linux/devlink.h                  |   2 +
 net/devlink/Makefile                          |   2 +-
 net/devlink/core.c                            |  48 ++-
 net/devlink/dev.c                             |   7 +-
 net/devlink/devl_internal.h                   |  11 +-
 net/devlink/netlink.c                         |  67 +++-
 net/devlink/netlink_gen.c                     |  23 +-
 net/devlink/netlink_gen.h                     |   8 +
 net/devlink/rate.c                            | 290 +++++++++++----
 net/devlink/sh_dev.c                          | 163 +++++++++
 27 files changed, 985 insertions(+), 299 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
 create mode 100644 net/devlink/sh_dev.c


base-commit: 239f09e258b906deced5c2a7c1ac8aed301b558b
-- 
2.44.0


