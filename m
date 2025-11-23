Return-Path: <linux-rdma+bounces-14688-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2883FC7DCE1
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 08:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224D03AB002
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 07:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CE62C11F6;
	Sun, 23 Nov 2025 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BIVJeMb+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44942C028C;
	Sun, 23 Nov 2025 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763882624; cv=fail; b=dJwYNmqxLYnqr1Ehxt+00xYCoTcvJRYXg4wW3DJwIhAMTjyCEHHDW3BRbxQvrMvh/pBiarP+6PL87GoKR99KKt4++xlT0P8+BqJBpcdM5ub2JnqrxnpoyZL8AnaG9w7mSggx4i81qcpLOFJBqg6zzX6MMc8FbHflxNwxkYoTUAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763882624; c=relaxed/simple;
	bh=TR6J5kaeMnMHt+COoNaLdOk/eQgwymLaKE8/E4+L7Mw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggajgqrazIxVWXH11g3XnBRYC/fnkjOYekrNfccXlaL2HRL6TkuZuAFBMMZ6KEsEcvdg/k0KOPFFg2OmaGAi7huIw6gXjwSOTcofNXHlHngiDmrEfwoOcnzv9iVWSyYYBJn+EvxU+HL49wT2Q+LKStAb/VXHaXj7DbINF7ofJ14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BIVJeMb+; arc=fail smtp.client-ip=52.101.61.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEKokqASazj4pHB4fD+3Fv+dmHoxEd+z5Ct7vtlWqFheZ6T6kFrAh/C1AyZk9uDnZL98NWHE1cGnULHDBSMbflfzN0p7pbOR9V8bRMhSpgVjwjnHrNpv6FQlShUPPrdxYe4okP/W0CXMiVUKbNgFy6smEegO71eW6+adUPLzSjXRsLFyiEwVBh8s7wevpgUrMjSg0VgknaVLTMbTCZaqLzJJ2EU7ecIiXrtNBWwj/W/20F4SNnaNAzfXuwsisrNRv1uISibm0deQAGcy5Hy/XILHuGEi6f5FMjY1SQt5Pco5Fuvi60qdjB1CrnXQQ+OTXHDspFIo1NF7pq4tl+pXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CdlQFXorOD2C7oWz685wggWy9NmZxX/sOcpJpJC7aM=;
 b=oqEuZq8CeNtHBTc3eA1+zem/QJxEqL0zhljmUTRQZgpRZftFLoI0IDigisKaXhn0MUbsFfC3thHrkexk/lSIIvoU2LSHRftKSFGzQ8jmyErAeFNTCdcCxpIO7LoVKznupRzOi5CKYFkxubD2N1P0aAddxZIi4SmrbKDkHKeX3lDHJRGfLGYuVvgz+j/qf33tUX1pBP6onCKhQGByq1+YCKbvvWgsbvQ5YZeo/LbYsmDWrDuR+rFbdBzMfQ+ErYXNF6jzg5HrWYMYwqzS++hD2U+DMGjGvIRIoc047l2/mq9nkrFF7an/yYR3iD5ru1/4Ze8dmrUb/i04NdejY/FkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CdlQFXorOD2C7oWz685wggWy9NmZxX/sOcpJpJC7aM=;
 b=BIVJeMb+DWsJXCXolRXcVitFvTS8izM2cpwFTnMVvfN+4M9UAZBeZna6w6dsjE9vsyp2AIagrAE2c3d1nmrG3nrHpAVwkN6EVUebwtooq4LciEmh2XaaWl2r/bn0nLmdHe1QSP/ANT25ZUMD9Wr53GoXCYLkYVwRh914C9VzrJ3QYuiZiwwAWSq3ztaGmyzkyfKM4xBrWI38YNLYOaOSlSYU7sNxrLFsojujMl6cma4qIn0sB9BA6O0YP082bW09P3w/jknFKO1pALcgoXmg4oiHn+XhWV/l3oy7YuIKXnQ9t0hQ9OYblJTmtxhtWl5eojYxSb/Lss5IEeBAUGoY6w==
Received: from PH8P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::9)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Sun, 23 Nov
 2025 07:23:38 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::e5) by PH8P220CA0025.outlook.office365.com
 (2603:10b6:510:348::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Sun,
 23 Nov 2025 07:23:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 07:23:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:23:30 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:23:29 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 22
 Nov 2025 23:23:24 -0800
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
Subject: [PATCH net-next V2 03/14] devlink: Add helpers to lock nested-in instances
Date: Sun, 23 Nov 2025 09:22:49 +0200
Message-ID: <1763882580-1295213-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
References: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: d325884b-bf2b-4972-015b-08de2a613886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nb9ok7yFb7XlL4pZWJWdwqPA0lqhZyDCnKdqTG9lXBdKGE0AI18K6CUfGoIV?=
 =?us-ascii?Q?Ikpr6ngj3ZhaH0sFRKXPLxpScVH08XXdKAVkjGtKBZ54XYsztFfXTSHM9+ag?=
 =?us-ascii?Q?KpqIRdb8elhOQZQoWwDwjUT1fTyCizPXnc6NT6S/r6a2d3iiB9bD0Fz3lxp9?=
 =?us-ascii?Q?fW6QQAZRT4a3o4ZdkuRRhztJhw/LIgL7dysBRFZFaK1ihFq4bwLZHPWO2sxy?=
 =?us-ascii?Q?+gZLSm1H1brBQx7rFUpO4Kz7epMFIboJmsWaGsksLp9vzJc6tmBN5vmzUGdp?=
 =?us-ascii?Q?VdOTROLFdlqwEA07HBb/vWfoCrLWMD6DRQDrWA+sQo9WJrs78VG23aH/2yCV?=
 =?us-ascii?Q?LQuYmb4JrXU1sqxLAnn3TG+oRz2BXpSJqwwA6tvQyReMuvnSLY/oWQYayZg4?=
 =?us-ascii?Q?Wwo2KBX5yrmY/sNxRVxQGkW3cmcI7g/3YOwSQ22TXcsn+MfOzJLPArUNWKxb?=
 =?us-ascii?Q?/aUjb139lrFvDtjPo2Xyvur+QYS5CifUDhS+BwiyQNCl4p+joNB+anfpHk/i?=
 =?us-ascii?Q?70b/AH2MThzwXPP7IAchcNml/0We4ucHDqiIwvnQ2nJ87y0PBCfsbICKvDms?=
 =?us-ascii?Q?7rbGYPXXxK+WfeT3fbvrArnVw0ofp2PjNEzAWL4PzHtKmVgUThSxXZaPEVUQ?=
 =?us-ascii?Q?G/iSBZX05YpJrW2n1UgV08gulz/NL+rIb/KxcsYlBREVY5DPv4Fj3iDe0v7b?=
 =?us-ascii?Q?XeJj251bBkL72WyiUxoUIyBRNSeSmu5DEwlrevbgDxLzJTrOIV8tt5qp75yl?=
 =?us-ascii?Q?pbNVhxWamorUTWwdv+iuXMZwYTptanaAYnalzJC6d7CMfgfWUpmZGcIkIWla?=
 =?us-ascii?Q?NOqpg3fmFKZNUcoV3n80qu8dXlUkblirz69iUUjJ6dqnuQAA0ocpzkbiyRZq?=
 =?us-ascii?Q?2Mq6kun6m204WE985DDMkc2lz9f6ODi4TvHLTEhb5BEcxyuT5ziMud0Nw1EG?=
 =?us-ascii?Q?4tr53/ZCHA0B18vxM7DjQL2PkktUeiVZGRmrlqCVaQ4qm6Kw5px6J0tpkbH+?=
 =?us-ascii?Q?JYlB4nIQw3dMmrgCd+6gBTznwdFAFNPrDLzzaapfJ/lgazoZcVFTwGjmm4MI?=
 =?us-ascii?Q?8OoAU9P0vw8caYPQuqD2JL7kEwL+m3WoP7X3j8PROEmZZ1eYZxWuJbOvnsCs?=
 =?us-ascii?Q?Nj7PXkWu1ShOqXEFA9FzIgOeQTmNqEP6JuBAoEq4zuSqpPQ+Woy/vd4g6JML?=
 =?us-ascii?Q?IVVQjAv3WzFExAKNXiTTTpVQR5E8N4TszBeVQ61ZJFNahE+Wn7YyCIKJa2K+?=
 =?us-ascii?Q?R0cveXlmvALLRk5ptouzRt1iJ6Q1ikK+wiAjL1XsQuZDjruEYSOCwix1OfmV?=
 =?us-ascii?Q?j3OJsWs0Q/oG2Zm+J6bGzvo6HNrZo5qUDykRoI5xqybWzklYlpm9gWopyu/Y?=
 =?us-ascii?Q?FJcESYFF2w79KaSsow6x9bvbGFOEdEEGoNV1+gKt7utUS1JygpnXadeN4jhN?=
 =?us-ascii?Q?ZjKJl1urfp5MqAYcq/68+1olrUkgwA9diG66r7Jb2xoLy+JMhh1xrOuvLvhj?=
 =?us-ascii?Q?N5j+27yVsbHqqB1cQVFLiEPXM16d3HNCNc8g0KvYcjMduH2K/j6ayiwnu20x?=
 =?us-ascii?Q?g0vTO7eQlzfGJEnylN8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 07:23:38.0231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d325884b-bf2b-4972-015b-08de2a613886
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753

From: Cosmin Ratiu <cratiu@nvidia.com>

Upcoming code will need to obtain a reference to locked nested-in
devlink instances. Add helpers to lock, obtain an already locked
reference and unlock/unref the nested-in instance.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/core.c          | 42 +++++++++++++++++++++++++++++++++++++
 net/devlink/devl_internal.h |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 6ae62c7f2a80..f228190df346 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -67,6 +67,48 @@ static void __devlink_rel_put(struct devlink_rel *rel)
 		devlink_rel_free(rel);
 }
 
+struct devlink *devlink_nested_in_get_lock(struct devlink_rel *rel)
+{
+	struct devlink *devlink;
+
+	if (!rel)
+		return NULL;
+	devlink = devlinks_xa_get(rel->nested_in.devlink_index);
+	if (!devlink)
+		return NULL;
+	devl_lock(devlink);
+	if (devl_is_registered(devlink))
+		return devlink;
+	devl_unlock(devlink);
+	devlink_put(devlink);
+	return NULL;
+}
+
+/* Returns the nested in devlink object and validates its lock is held. */
+struct devlink *devlink_nested_in_get_locked(struct devlink_rel *rel)
+{
+	struct devlink *devlink;
+	unsigned long index;
+
+	if (!rel)
+		return NULL;
+	index = rel->nested_in.devlink_index;
+	devlink = xa_find(&devlinks, &index, index, DEVLINK_REGISTERED);
+	if (devlink)
+		devl_assert_locked(devlink);
+	return devlink;
+}
+
+void devlink_nested_in_put_unlock(struct devlink_rel *rel)
+{
+	struct devlink *devlink = devlink_nested_in_get_locked(rel);
+
+	if (devlink) {
+		devl_unlock(devlink);
+		devlink_put(devlink);
+	}
+}
+
 static void devlink_rel_nested_in_notify_work(struct work_struct *work)
 {
 	struct devlink_rel *rel = container_of(work, struct devlink_rel,
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 14eaad9cfe35..aea43d750d23 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -120,6 +120,9 @@ typedef void devlink_rel_notify_cb_t(struct devlink *devlink, u32 obj_index);
 typedef void devlink_rel_cleanup_cb_t(struct devlink *devlink, u32 obj_index,
 				      u32 rel_index);
 
+struct devlink *devlink_nested_in_get_lock(struct devlink_rel *rel);
+struct devlink *devlink_nested_in_get_locked(struct devlink_rel *rel);
+void devlink_nested_in_put_unlock(struct devlink_rel *rel);
 void devlink_rel_nested_in_clear(u32 rel_index);
 int devlink_rel_nested_in_add(u32 *rel_index, u32 devlink_index,
 			      u32 obj_index, devlink_rel_notify_cb_t *notify_cb,
-- 
2.31.1


