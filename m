Return-Path: <linux-rdma+bounces-14638-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B812EC741D5
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6ACE35B4DB
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 13:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BF633A70C;
	Thu, 20 Nov 2025 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kekun3+N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EFC32BF4B;
	Thu, 20 Nov 2025 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644422; cv=fail; b=a2c+HIctQ7gmIkq02XI0cIxroIF52AZIhbJ7kS/obSEukL1nRUE6zCJrT0ML9NrvMaA2xGjan23ai9JonX1KlS3v3r59H1Ysb2JZfEZFsAnPM9kTVS6Ox1nXwvNazdMMX3AO5H10qDy+y91n/2YMd3ArNPsTgIbGhlpVsiBnZ5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644422; c=relaxed/simple;
	bh=P8W0FIsXR1/VWMEyIG4knFrRhHdsOvI7EcP/vxGKWms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYGyL6Y8BFoeWWdtqd0oiBSg1tGn/iaBCzrop91D6LziPO/Apa+EDMOltBJy4CVENVJNQ9Wlcd1/unzl4Rb0lHSNhsozd+7T8xenhd82BsA6AdnnFSPCSbJcGEI0P/hpTzweQ6dulghKtHajoTLH1uaIxXniKS/y2CFcj40wT8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kekun3+N; arc=fail smtp.client-ip=52.101.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tbo0fej935LKFeGh7hvSVbOuBkozNETqZ47X/gmvPPxy3azRp/hCQXUKxsNA8WEA0WE6+HxO1WFe+FMjjyM8B6nf4FPaRvj936PnQAlHAxJM4zzmm2oXDmpHyLRHpdmrBuUMmew6Xb0QdxQ9AYOB3r6HAA09ff6OuHljyF46PzFCVP3IFNqM+ozHK9Z1LAJZVUze6pX+bsQyFb0ZG0MRn9BkmiEjBbaHNOj8Iju8Tkph0WdTcdVDKOGS4eJdaTBTBQDctOWk1xJJz+8o4RG4YysUhKmQLCMSpNjAiG4p1AUf6DdL2Xb98EJx8OpdDVS9ZgE64TIk9AUB38NqPSWLUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kglGhXi4BWERJc11i4b/YsEsnv0Fea8SDE586jjlVTY=;
 b=jLFbzHAJtPieRMFtTmhgm+g8NhGinBqTQjKD1VjN85+FmBmHY1qS/S/6bsMEIaqvkCu5sTu/a1LRCFDTaT6V2Nw6NktJ3XVx3N7ide0YSRHKbu9F8LaJ/L0Nmkc8vOkuCeZCSbXwOtVlLYu3dCBQKFkqmNsJNfIe1U3Ey3wCzVNZ/4vrdR87hmEnnjoLLgKzHDJp1dkjQGcsXh+4bhfp8ekbYnHyDSIvqMP8QE+bU3skvktVlyEOWKqpfrN/KZTi+bm8jbiZVh7R+www9BSwQMojtkncttGGut1nDcMFcOnw8+2vzKaa/Nhaydj2Ea/U8Ot1qZ0nNiTlgAr4xCET1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kglGhXi4BWERJc11i4b/YsEsnv0Fea8SDE586jjlVTY=;
 b=kekun3+NXntX9Ovqn1MUXUxbZTySP/8aoD5u+M87BYvTPA0s0wJ/ueHTOolL/4ZpFHTiNadWBteWj+N7rEuwUMjGGMZOwmnxVx6he70te7VYOB5kf7ZzmRonuzvJrzoml4GevmRWzJ4eVCJEgNqUG/8EiR/qpWPjtzzl/ThkJNxmpQAYoGcsfOnNf5lku/xyL75lSIaU+8MvAl1af0WBxK8hbizFeWvqbMiY6rOQbMxDxT1PfSsVN4td2mldrP1SgbY+g6BRc1eJF6EIUCwcQdX5XJQAXGh+KZznoNnc7b03zxwUbgZUjZ02naOSADuchtwsilJHbiBrFMNnYzJ1zA==
Received: from SJ0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:a03:33e::26)
 by SA5PPFA403A61D8.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8da) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:13:34 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:33e:cafe::30) by SJ0PR03CA0051.outlook.office365.com
 (2603:10b6:a03:33e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:13:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:13:14 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:13:14 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 20
 Nov 2025 05:13:08 -0800
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
Subject: [PATCH net-next 01/14] devlink: Reverse locking order for nested instances
Date: Thu, 20 Nov 2025 15:09:13 +0200
Message-ID: <1763644166-1250608-2-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|SA5PPFA403A61D8:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b47c624-3303-417c-3605-08de28369bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D3WIJchK5XTTHLrwuwhYvJxLebCApM5SDuN5iPocE87tf4C6ss11jddAyf9v?=
 =?us-ascii?Q?Q/ISMxzjRLO4RgftDNT9VQaDF0MW2qU8APNsyxoqrZCLPPk9whewr9CSolf3?=
 =?us-ascii?Q?NoHRNBqOdUcZo1ThkAtNZFYkXRgxty9KXtiyZ8yD6uK/7AjQYVD+VC0pAq8t?=
 =?us-ascii?Q?gOZhrSOD8zChTnNK5HAqXvhHmnharuxZWmxLS+H1qIiKXC5oShkb7YXeBbaB?=
 =?us-ascii?Q?TjaVHadAtJHcsuAG5/jNQMUTCxPK7VpcYewIoBAf4rf8/g2Wqfq8yyr+2mBB?=
 =?us-ascii?Q?kN/hAh/4T75lAJZYlABdhXfXs8EyovBDS6uanjI9JIjeSOQ5gF4zPURzJ243?=
 =?us-ascii?Q?P3dBmv/8B0NlFR/a8uO0M7C3YN1kB8BsMTcWGjfPFdOM/y9ethisE+Wh0+1W?=
 =?us-ascii?Q?TqaJcfX5eLgiO5KT3rm20XRizHkPZrrbeW3lPEWrE+Bs/WHFAaL3Q6B9xt4z?=
 =?us-ascii?Q?PSS2fPC2eJEcYeX4ct8/KYrag8sfzKq5Z5SJwmc5X4oafNMHM60Dpm8rJjm8?=
 =?us-ascii?Q?siQ9F6DAgP5WQOo/+gXJ5pCChX7BBEc+NVNRjsa2Pkrkxzvb/9TB8Pv6QdjT?=
 =?us-ascii?Q?raKJ+DDgK2Bi9fOqwYtY7lyj5vCJlmJa1JEVyHCFiIvbprkSrlKOxV9utqim?=
 =?us-ascii?Q?aZEgAwdNaGlKLbYecBheFVyOKB1t5mCca8mGY0ltdXhwhb05JD82hpSXaM5e?=
 =?us-ascii?Q?PUO5wmlkvYpwaLODVhD09tT8+CsBRBpG2/9UGNwk0TNRMkKAEGNGQBaTDP9p?=
 =?us-ascii?Q?kuAO164/CKPekjMYlJ5zQlDuPRmuHJAymwQj4/gRD5hYLgDZ5ZJhkw/mRm7Y?=
 =?us-ascii?Q?SSWVOSUQLcQSBL+e/0PAZ09Kuh6GOkWqhHGzzxaIO/a7Rj13uuT/RmpscyaW?=
 =?us-ascii?Q?CJL1ya/RHMDT+2A8ybRLw5K8dBt6SZ5f80yfgPFLILBtKGwy3YcnNu0PktZi?=
 =?us-ascii?Q?lpDFwtjaF9D+hjcRSQMKUco9mWps8m/dsSBJkusM1FDXfD3LaVNHyFK9oI03?=
 =?us-ascii?Q?4ZZKsXszwtjFW5afKpWKHUdfsQMBx3qjs8kQr5ptls1xnW1kIQhredQFPBlR?=
 =?us-ascii?Q?32dE8/wIoU4b4wfwaHHxpbIDCfxjOMXWDOlVuk8R8wNjoGc2dlLlGjeh2lO6?=
 =?us-ascii?Q?6cMbIAc4o8ygCccBvDgLlNwNehHHnP+q7xzhGL8YczBnVKBGTHxGFT5VJXJr?=
 =?us-ascii?Q?+X46iV0OijiG1jFnjtsNuMezmKyhybJb1FdY8+JST0yHRapDr2h4k/Wl1BZT?=
 =?us-ascii?Q?fHZltssWRd51Va325vSVXYGyGUMWOIT3MtEJ7iUuK3l2LUH9wW5LfwDRlw3a?=
 =?us-ascii?Q?ypb21K8umXhFJF2zuVlg6Remal6IIbBwOg0ek+twDn0AXoRRVZls9vAZUF2z?=
 =?us-ascii?Q?K1puFTNWi2cTHczrrMF53FmaJL/YXuVr4GqP+g2P+PO0IO2264fJijefcQlC?=
 =?us-ascii?Q?xEOM1XKmFmsbebBdVcrcpuk26CSjv3v9lZk6+xfLLDbFQ1fTL0uZObb4Ltf/?=
 =?us-ascii?Q?lNKTlMg5WllmHJUDur1j8KmHVM528A3ROrIof351jqTMVeQvnozermJhyVdJ?=
 =?us-ascii?Q?VFn4S8IPY1x9TnlQHgA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:13:34.1724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b47c624-3303-417c-3605-08de28369bf1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFA403A61D8

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
2.31.1


