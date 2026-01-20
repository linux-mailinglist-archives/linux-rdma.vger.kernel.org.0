Return-Path: <linux-rdma+bounces-15738-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F142DD3C16E
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E71E95A0795
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 08:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB9E3BBA1A;
	Tue, 20 Jan 2026 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mpgDjC+8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B843BBA09;
	Tue, 20 Jan 2026 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895938; cv=fail; b=vDTnWKERj99fOwZ3wBmQWvYftEaJ8+QZufotFbFf7063cCCFdD2GCKSCJUU63FnqblyANA3mx/iTzpe1jZiHtaJGWjk3qp9eq/dyh4Ru1RK+a5Tc/7H0vZdrwzmKiHtvgANNvubZXvS7YFRUpG4qRatHNtFTfCamyFPSSFBgWfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895938; c=relaxed/simple;
	bh=VWzdc/N3eHvOuNpEWDMZSRK9dEYUvBPoVQXmOAKh/9k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLArui6iv9g+oe6V5Mz9KXo9u20X9PI2v0qZ+n5bFbNcuvVo6qqADfRag7/XfzOVsUZOuoQORhwFYA1h17x7MOQq73+d9shFPWeM17JXbgl7qg8+eDE+Zny8TmAOP1XNtqGbL9Xu6AACOKFsnlRMA7gxXtzVD2WUta/oYfyRjEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mpgDjC+8; arc=fail smtp.client-ip=40.93.194.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbrsmCA3aJzn/WjKf4hlwvrus3QpTgplsjpyGNizlG3zLyWR4GBHJszUier9T6JMtHjyPaDxzfYUJQbu3lFFyU1Lvtek9sO6ivkCE6nSLVZ9swEhOVufrAFgtP25aNix3Z+vQuN4exEt0qf6aecjuRXWozgG3Ih/OAtfBNorxV0YRWLLHLw5KwU1TbAqwAVYd63m3G9cncA2SxuT8EwGHH5DRfSYB6xaecM/A8kSCgV3hzpdgWEj7oR746muylkCXMAVnKQa5VxSocULRrw5YSVB9MAa3WWNgXWDs39Zr5e7zZELjKmIwxHuRj9TiKTnvXjJVJ4z0Bobqc5jWH6Xwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lcu8UkvoEodiGMvwyq/H6ywtfatxV6MKanff74mRObg=;
 b=hDxDAE6MdKaxO/KsY/q87lq0060nSIMwrvEZvsjcTCFIy7n7bDz2iPYEdCM7ax3M/blcq0VRgOc3PU/RGR3ccSplr3WHnw605trl8KE4EXufvWM2M2UYwFPDimUjxOkJ+/jvvBuz6Xcr3IljAU8OiTVAK/OXbPNhDQ/fMiLS3NFztbJZQ0zWXSFdfMviGe1rN+luAoER7W4v+ys9ZFQDkJIB9dIeABAktCW8t6um/YF0tnuqfJeXdYhXF4DFahBaAnYjQBq1WncEzTonOwsWT3bKaRBTCZbV8gw1GvSOkU3ZMbPJP65sg5XLTezRENSiDQb7y5QtuKUxZgCpMtYn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lcu8UkvoEodiGMvwyq/H6ywtfatxV6MKanff74mRObg=;
 b=mpgDjC+8OtWGWynb27ZR4OY90mEPHaD2qbimvA3wFjGkChkvSLmr9cwE1nq8G2DmCTLkPaUU8oXR88aqmQok1P3vzJ9Ramwy1gd+s9BlYt7mZ2XQXnymB1uTYY1t/897DoyHOlRnA7VCVrcxtH9lHHrvSq1ijiGtO7SKJ56xdZM949zKpohLKwJ+gKZaIzA4eKOIjZMfYuJ4h9ME2UjENeL2gqBVG2ZJNMrIs0M8MPivhKCa5qeKmG5O8VbsRWWCILYrU0BFcVbB6InUnFmKIAXNKp5KojDXuOi6x7g1VJXn4I9x/Fmvw8ocN5yfotLoADBEVP6Y3HQWhR5P1DFTfg==
Received: from CH2PR02CA0011.namprd02.prod.outlook.com (2603:10b6:610:4e::21)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:58:53 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:4e:cafe::17) by CH2PR02CA0011.outlook.office365.com
 (2603:10b6:610:4e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 07:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Tue, 20 Jan 2026 07:58:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:58:39 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 19 Jan 2026 23:58:39 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 23:58:33 -0800
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
Subject: [PATCH net-next V5 03/15] devlink: Reverse locking order for nested instances
Date: Tue, 20 Jan 2026 09:57:46 +0200
Message-ID: <1768895878-1637182-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
References: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa98a07-425d-471a-a6ab-08de57f9c128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vrnUaNvc/EYukftUoufdZ+0a7U2m8VnttkViy7kFQWL5CTyGCZWLo0sQBINO?=
 =?us-ascii?Q?52FnIImHDvbpK/PRfo94+uVTP6wL7xfqpdEx6Kr6Ex89KGIT4CgFg9mPnDP4?=
 =?us-ascii?Q?PcGvZnpv+2l1h3FrGBcGbBZ2ErFlMdYTDPuMe+oFF6XzNvmhN02PhlbL9gj/?=
 =?us-ascii?Q?3MGjwVIDDljoD78nhxOUWyu4coUeA1csOwAzo0fDF5hjn4pgAeb4F8bZj6KN?=
 =?us-ascii?Q?Ims+57P+YlbH09CHlyh10Jse7L4CTUaiPyTbW3glr1SBmVc+AgfpTMIhUQ8p?=
 =?us-ascii?Q?exQOA9oz5CoyAm1DZ30GklnsdXPP3Etyw/jjFBZFWMyk9RsgDXfaA85n3srk?=
 =?us-ascii?Q?InQFrPEeJcWQ35OFfL4QF207O5z/edhhZtCAdFW6Y1jztkKNAQF7n5H4WyNh?=
 =?us-ascii?Q?uJmtRrvTtN1V7oY1QGJD7FKTuglUAEhvLwvxh4dB3Exqm1SVQI1h8swfgMiI?=
 =?us-ascii?Q?AMX5cmqvPpDA6a/OcXc0nfNP6GHq8R9iEm1qWq7IzziWbDY3E8AQZjhR3/bk?=
 =?us-ascii?Q?u+/IFG5jaj/g3kuS5VGkV30f+SkChktRnvQCuI+labnWRF2Hm6hsofuj2SlL?=
 =?us-ascii?Q?9Ri+wO60oGzeq9ddzxEmaeUG4jXkYLpeK+YW+WgydZNgvbmDZaluOzkcU6LP?=
 =?us-ascii?Q?96YOWXgY+OQDKEZeTwU7TRNfeKyOG2neWuVMHJoH3fxrCjOtNKMRtLiGXCuM?=
 =?us-ascii?Q?Ah9MF9zkQOtWZg/tGoXn2pJZiBzmzJBhzUWUqAAi+S/bQKIVdVaFqFJYfpmG?=
 =?us-ascii?Q?PvB+UkSNkAi0slL6PmQ1z8qnllaf6TOS05w5hO7navv0Szu2lybb7fmK2Ooy?=
 =?us-ascii?Q?5hPVCv1AAzo/4iof+H1qeplq5QvOeJp3/ek8q0cz0Hxs5PTovHe7sj4350Cl?=
 =?us-ascii?Q?3fewDAWeo0LF6YdofbSvkl7btl5L25/G2M3Gnjkq6MFb+T3IC10snMZbelv/?=
 =?us-ascii?Q?8zK/L77gGygGsCLgl5N3PT+s9aMkNWW3FhNWkCr5SM/cPHWciOK0Ft3Ul4nW?=
 =?us-ascii?Q?IQ7bTy7DRTzdI7aqqYgwpmGdUsUxcdyq3I8mAK+vJc+jZgMsDolzZ0+Eqqku?=
 =?us-ascii?Q?/cMH2L0wYKyJL2n+OkgDLgkgBz3Zz8BOnJS1f3+bEg3c7qS5IN0OxpaODSfW?=
 =?us-ascii?Q?41U8Rj11Q3a80jkQZvP68U5Df3XYypMSZeOu8yqLRhmEEQVY0vjOm+K84goA?=
 =?us-ascii?Q?rlcULu8u2CAmhCqGrkPmdoTfzkyKT2io0uEUrhvVIbeAbdG7BlkFe9bogBb1?=
 =?us-ascii?Q?VQGIzROKCrF7YoHSubDkyO6noXRpiltZoqRqPmGWTydfIoyneKr6cVr7C7u8?=
 =?us-ascii?Q?1azMXDEw56c864gdh0httgjfP3XmeMZOIt1aqgrrKeWiLANQ+yDIyNXCUVvw?=
 =?us-ascii?Q?0OEFtzPVSsy9lZT0/Wmjfybozy9Q0OclRM0RsvrYZ4YCY5Ao4KQUDEC6YhKW?=
 =?us-ascii?Q?cj+tS/guxAgm/inuSlrSOvBL9UJzqd7nR+VPeGBlZnbaCN5VK/1Mea/iZjMq?=
 =?us-ascii?Q?QhvihbiLUIXM2yiHL2EsE3WXZ4Op6ZfOp581vFscYkHKYLYl1QtSU4mJJr54?=
 =?us-ascii?Q?Xj5VTamsiGp7tTCuLqucUtN6tOWmPXMQPe5lyBNiawdCmOIh6OC0unagOJ5h?=
 =?us-ascii?Q?ABmacBpGnv7g2mXgVxIFwIrr6F8xFRAn6fDgFqPN7w3n61YBDWTs65b7vb0F?=
 =?us-ascii?Q?m2DTCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:58:53.0934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa98a07-425d-471a-a6ab-08de57f9c128
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108

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


