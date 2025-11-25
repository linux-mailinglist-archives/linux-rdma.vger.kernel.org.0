Return-Path: <linux-rdma+bounces-14761-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCB7C86EB2
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 21:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D1A5352998
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 20:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E4833B949;
	Tue, 25 Nov 2025 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uJTy4WcH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1B933B6DD;
	Tue, 25 Nov 2025 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101233; cv=fail; b=lVFs1yjxV+dTVXTjkaO1nNToXNdljxh5aGrGwTuYj3KWk3P5fQER3SBHlaF9nqxHhWIQyYh19gFELZ67d1W/uVFsdfp24D5IeDqUAionbE6ymaZUOpKd6xcHrrCJC+9ecR6uhEXmRfMc6+mO334EijUY6OuGnBUgmWND2wuOaqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101233; c=relaxed/simple;
	bh=P8W0FIsXR1/VWMEyIG4knFrRhHdsOvI7EcP/vxGKWms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uq7DrrAj8lfqtKymR3Q0f8SWUqcAU7H+WcCftgj75rSf9JXBmlVT9Y0PMXgGA97TJ2vUWrcedjmPnlGZxTjRDSB11mIhHM7k9bRZ3Uj3y0/WHSN6vNmsw/JjPt0IAzFAafS+jwj3A9+jWxdEK8YT9P/rc9seSbbeXP5ulwnqQGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uJTy4WcH; arc=fail smtp.client-ip=40.93.198.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+4YvDykp/tpn7K/IwLNRXZncSH82mAdZBITFKRoFT8r4sIdg0BQqs1SDhGzVNcQf8cvP6ZVKuGhS02tqfXPNQAH5WTueW5fyIJMRiIFCWOKCwnGIpCAzjeKWK59eU5wq3IUZ0AqYyan7bnJLHw1eA0PZ04mmIqBYV8fqR0G3hSiH8WQHTrHXuhn4u3G/QcVYBFELfFMQb2GmHppnghUwd/DABJcqR5xL6U3W8hWAqw2U1iSKiEVtnme8hltJnZuqfkDbaQZB3ATupxbcmLZ1KDRYLe6XOWuntzFDNI3hsZe4NvEGjxas86629uDZHYNTgV2knfUYj8OCF9jnBLyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kglGhXi4BWERJc11i4b/YsEsnv0Fea8SDE586jjlVTY=;
 b=rJTIjmJOUFpq2DKuS3a0LiQWms5Kp5Jfh6ShCUmJOIvRf8bIUBqrb+33th6o+5qVvP+U3jnUVaWSgFR5PvmpweUlG7SIZQDOJPw4CeTIIfMr7AuC6H1CDP+AP/vRCl3jh1P9eWsUmTNM5X0AmBuyYRNdWhJcP/6RXR+4Du99akVyCS0EMyJEay5sVW/grQkYuvl8WyvviezInV5cKOeC0UOBtd0lJaIFr7xGGJVix5T4JDk1Xgo4O/tgPVxaquxx+7MwhFr85KnXHHaSmraX8wRzX5wxtJ1/UdIwL1Z+GFR1yr5OSxFnRFKBUIbT7gkz1nfrqw6LoBOHXxSNpUcc8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kglGhXi4BWERJc11i4b/YsEsnv0Fea8SDE586jjlVTY=;
 b=uJTy4WcHoGYRQ8Fhh2HmZ0jMLUQLa/6CxWeK/IstJeGmXXygXDLepWOxQVFkqkJfjzJ+C1S09IIS0siTwMvIf2RLTZ0Jth79CJvdkXcBz+EXSSxoFB/Yw05NwOzbR/0zYTH5UfoYBxjmkifx0xoqkmgva+Pm7zEfYenQNT6RSOzONyXF0eMSIMVWNLpTddNdGWVHBCf98WYXaHqGF7tChq10hxrO7QYQaJPVUwFGjRh0ua48cJX/as9g1QzGVjPCGhfTMePDXWz9rBjDo5c4KrF7E+SO74PIy7VxAfzwtlJM36E+2k2JcvaC5T6ZtwhFNoHv5Gkx1FavvIYgzuKs4w==
Received: from BY3PR04CA0012.namprd04.prod.outlook.com (2603:10b6:a03:217::17)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 20:07:04 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::4a) by BY3PR04CA0012.outlook.office365.com
 (2603:10b6:a03:217::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 20:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 20:07:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:06:42 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:06:42 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 25
 Nov 2025 12:06:36 -0800
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
	<rdunlap@infradead.org>
Subject: [PATCH net-next V4 01/14] devlink: Reverse locking order for nested instances
Date: Tue, 25 Nov 2025 22:06:00 +0200
Message-ID: <1764101173-1312171-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|PH7PR12MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 712f27d6-813a-4efb-1f7c-08de2c5e33c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SkHpQFZL1wwiaXjoci8X6P2ybfH3yxAcLKMTWPDWobob6U5fW2Ui3uIEZfPv?=
 =?us-ascii?Q?a3iExGMA2o76bJRJ5djfLkmB/b/7ARMG8xCxk/Ltck9pHTmIcAjgEqwW0ZkH?=
 =?us-ascii?Q?/BU8ajKaIXVSMiSABVusEX0eSsJn2K0iGqkMs2oISGdGIv7IUc5JU3X3gKJL?=
 =?us-ascii?Q?sF9H1lbOq4+L9svR45iNO0RbzhEv8+RVKL+9+k02MH/OxPZB1Tx9dj9TUfR7?=
 =?us-ascii?Q?x21qeV5ECLRHpmOw5+v0e4DL6N0/rSCEuiIkmPgSNh2fiNikkxqdYCWfC9sV?=
 =?us-ascii?Q?SbDR282fH5H+7H4TAGhCRFtORw5VQ+Ea+19UlVctD3MPEqjGD82jAkQWFu1C?=
 =?us-ascii?Q?sDst4RLRSIllV5fsQxR/lFadUHC8QUvnNxEIr28b4Of77Jp4k0oywJ+It+XA?=
 =?us-ascii?Q?0RReSiICWZuiDx+g9/kcNZjDMCfF4c2hz994vWxdycOaKVxvzLA7vUvNuvfP?=
 =?us-ascii?Q?aF3y9M7iNlvPfg1KLV3QgRGU85R2CuZeyie47lhZlDj1Y02C40z1jCaYPOLH?=
 =?us-ascii?Q?H4B315OT4h1LXIFbfzcTtUUGgwiVNAzsL1QlNrIQmZh+McgcD3IUneZe8mLl?=
 =?us-ascii?Q?i/arEdBY7zhUdqWTTpJ4Q1Qk6BR0Tz+oQ3LRzvkbwVRfQwRkzP2x9DyABlmW?=
 =?us-ascii?Q?Y6D2eZd/kyJpbABkRy0pMPfD7Tk+dKYDN6z/NE2OSBDBBV6i0fZxDdPAEnOI?=
 =?us-ascii?Q?BnguZmjAb9FkRB3A5kLbvJ3bAZlfIwKUgao6vddKZV4Z9jytA2VisHfQN7El?=
 =?us-ascii?Q?JXbu3rCDqtrreMb2+pFcPup33UQZSkE5sKoPe13nRHv8bOAAcUPh2duCu4Ei?=
 =?us-ascii?Q?IbvRtscGZArjbMSsDTsg8lgOd1/3esgKmGu4ynt3RU39GQf2fDymXL9AjT2Q?=
 =?us-ascii?Q?eBwwZesY3hqPaFfBtCwJ4wZ8Pv2Ix0j/uNqj6p2FQzrUU3aw4xTkx+GJ1VES?=
 =?us-ascii?Q?7QUtr2XYR6gaWm5lKxdmAMQB3lzY1yhNK7KZgSftzPTK60INoOqAEGcG4qPY?=
 =?us-ascii?Q?kftrNRx6dCuCZCEzFZQds6MCqBJ5oPm5ctivbeIACh5LpIVEmYH8mEm+xdAR?=
 =?us-ascii?Q?LNBzslwyTkOMPDF9TsY5YnWqBQVx2rKnlYFlSxINLP6zHHi3LXrG2tSsGdTx?=
 =?us-ascii?Q?b9jdv2Wps7Y3yYqWqXrO1ye+c7ref5lcVPdqCxJyyhn6BHvJUiAMjNJTZadH?=
 =?us-ascii?Q?jBkoLVRZ22t0SU3uHbKnOjsZ2olmJgcfyrElDrYocLf/W7h7GsliiMTF+q1d?=
 =?us-ascii?Q?tA2VjiiokJFqwz5+Qdk+KW7UgKsbLVrv/hVu6OveqJG2e1AytYme9BVRukkx?=
 =?us-ascii?Q?QSPkrx4G5w3tlsLTBu7Nna4Y//7o9x5ELTZBo+E2ak5+Szqo1ihsYc6TAEvb?=
 =?us-ascii?Q?hjD8wglZ34DXUG9Jc32qold5+QMet6c2FELkcum3wX/rwMM/CRDJSZ2Z7X8P?=
 =?us-ascii?Q?9Cx0CCU9/3hLpeuouaxlGZf2unfmLR2vBUE2Crf2uuG0039Iwtvgfzvh5T+L?=
 =?us-ascii?Q?IM73qZcQcToNJCkbbm0bg5EbDnQkRcRkWsdPodxqX3gMzGNPfdleHRgT6YLk?=
 =?us-ascii?Q?jnC6oWabpreQNL/a9yo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 20:07:03.9050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 712f27d6-813a-4efb-1f7c-08de2c5e33c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687

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


