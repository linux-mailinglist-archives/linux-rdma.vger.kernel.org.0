Return-Path: <linux-rdma+bounces-14725-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7329CC82A8D
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 23:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F6594E6F15
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 22:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F07335551;
	Mon, 24 Nov 2025 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oequ68XQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B093F33554D;
	Mon, 24 Nov 2025 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023354; cv=fail; b=D0eVOb6ccnhTbGO2wrqirES4maZ/ym7F/jwZ8xbMBLicNy4EdPJ6spCBpVo1HYhpYd2EG4g9EOjIg6JhGZVt7tsbdzvGqE10sn7xVjhlbcFBkyghGBhdBKCUULhmFowQvIoQN8qunReMAywvTjuFQLburGsBMVl+q9CMYjVN17o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023354; c=relaxed/simple;
	bh=TR6J5kaeMnMHt+COoNaLdOk/eQgwymLaKE8/E4+L7Mw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dfg56prqFob7g1J3tLdkrckhvduu6AJrEkBtEylyGqXP8ZONJHRlWd+nzh6+cuXpJP/ZxQTqccCOtMGjI0faohZfqAXYYyMRDY+TU7xX+JPdxeSspJs3oa9zirRzLOpXyvJeYleYh4gn3cMxIc7YlxRLZHGQJUE7xLLtY730aDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oequ68XQ; arc=fail smtp.client-ip=52.101.56.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5inSSonrhgmeWxVSfuQlx+n2NP63M7fxom6bUhLdbHHqfQTOHfFCYdzY8uITwOcwbafJ1dnuhVVSmwexqJv9LPGQSNjgnqY2+nOdI1peWDFeb0eoG/RQK6bNIlfhYtkk00p2sjcUSiJ9uzZDnQ8AlLKS+AiUhIw+2YWbz8vjM9dWIuCt/UExwleckXR3KcSTLSNhJGxId0FZcxPadIQP5mqlFmOVEN4nUQC7Q13zWwCgsK6ukm5iGt7nhnsb4xfrPv2rE/eirz6aaHB2ERkO3KtZ1R9oIPPK5LBgJjjKgTNXvGTI7CpriL/8/LqaXSff457LENEp6usWrCEpjUvXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CdlQFXorOD2C7oWz685wggWy9NmZxX/sOcpJpJC7aM=;
 b=nPyZBeQjHbOz9rsSd/thB55f2OYNlU1uaXmkQ9SFkq9mOeHueguYmZ6ooESfCINfK07IG+brux9gEOygJ+G4Y4FQLHnmPBqFZ/wEBuQPKV8ZEseNb0Cb4/0Yxv86FDgoIsGkODrvUeu5esCXgVtNsbFZXgpbjfDDMjSKqvjBUrI7hw0Dd23O2k1FyGLrgO91AgccGgW3bueznQl2/TGEcEgnWK2U1UeSVGmxUZ/6ae/uYLpCZ86xSgEXUD/rRM0DQ7SdR7TPMJdA5NUr2050wcs/ADS+kbpcStphL3SWb5NOsfavn3TBfpyhvA/Fk/Hg1vFmCskqJmc92OuPvdA0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CdlQFXorOD2C7oWz685wggWy9NmZxX/sOcpJpJC7aM=;
 b=Oequ68XQsKZ0paX+C3bm9OJv1by35VmGZS1qpmPJkTMsvySBi8DOhFsmiYeJr1kBz/RqJIpPD3Fgl83P/lk7q/tl7ZrqBUbC2VUBNv/vXaXipbxjyYsDcG7oOo/7F2tnbZI39EN+4RiUebPXDgAKe8V1/tfziJ+t2H/TEFs3XyRm8vB3tIj7c+C+8l268fI0VGp1DjSIOVW+IlVJZDoMvVksLKGI6sXeXIPI61kQkg9s47QZ9w98uNUFCAz1bNTWfEeOLi7VzXx65zmOMTcLVjloN/P4E7IU9Zr/eSwofY3zhb7qYT4ldePBJc26GFyiy2CpdlUijd3fN41ObzSn6g==
Received: from SA0PR11CA0124.namprd11.prod.outlook.com (2603:10b6:806:131::9)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 22:29:08 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::c9) by SA0PR11CA0124.outlook.office365.com
 (2603:10b6:806:131::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 22:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 22:29:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 14:28:56 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 14:28:55 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 14:28:50 -0800
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
Subject: [PATCH net-next V3 03/14] devlink: Add helpers to lock nested-in instances
Date: Tue, 25 Nov 2025 00:27:28 +0200
Message-ID: <1764023259-1305453-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
References: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: fff46013-bde0-496f-fcae-08de2ba8e23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1eJvNgZ6wBfy5VHrG3VBTmFDHNpCBe09bcr5eCREswwIfgB4JLaQSnY5ba3j?=
 =?us-ascii?Q?xOMj/ecN9DRJz06lSW77rhjImdWOChE5Nfq1C6t0GbcaSeHKg1V4RT0pah5Q?=
 =?us-ascii?Q?rznV/1Ef2df3wncpqJi4TGcD012OTBQAYismFqpa5CQgFLKtNctnW+n0bxEw?=
 =?us-ascii?Q?BdkUF/s4mpXcdPTixWuicgjopO5N6xnUaLanaBdSJDgsMo+BuX4vuGoGO9lT?=
 =?us-ascii?Q?VkH+w8JvDsozEmpqC8higICdfo3A/MKGDoc4GP2QoHK+3SJsAbPfVwkMGToE?=
 =?us-ascii?Q?1Vk6OunFWx8BFAmvmmJIh3CVq9jPT1aGDTGXd3hmyYPmI7FqyMFo/Ae6vQK1?=
 =?us-ascii?Q?w6nWi4Ik6A1LM2PCvw4EBHLS+8eiGP28KOSzipy7LYL/YFQqtnPuNm3ZnTr2?=
 =?us-ascii?Q?fygPGHvTF4YM40J7wLG4WD6lqB78zxaRJ/f5BEr88p0wo2BAt/IWDTd/jQx1?=
 =?us-ascii?Q?g6pqU4+qA8/K4QXolpr59EmpZMjgkoHZ2LVMVWFrEyHdC+Y0yPv+pdrrnGO9?=
 =?us-ascii?Q?gxMITuk7S5N9DnrLr/FVlgv3+Dzw1pXbGWheO9arv3JggGJv0qt8YRs07FPY?=
 =?us-ascii?Q?W0+fKb9bEQBQ6kHodXF/vYM5vlaXn14+yO+d/CSRv4brML0NOv6o4ROL+sFm?=
 =?us-ascii?Q?WgeeJA3jlux0dUEjfGM6F9VU7DcoQMGV1ygtvb4jT+8KQFRC3Ym5VI50GhCf?=
 =?us-ascii?Q?yDdmdt8oo227MKV7WTUgIq1JbPpN2RBjehXnwgD5IIMa4o4cou+RHBJZa47i?=
 =?us-ascii?Q?hJUAWZTjqbcB6bBEdvsaEnvqd930+j6eSrZFT6HG71EtfyCOOWNBCnUyXeGk?=
 =?us-ascii?Q?EMxaUDXCCosw4nHSTH2aOlAtIf5OwpaJB2tiK7SPt2AyjWqgFFyUuDIBzY/J?=
 =?us-ascii?Q?/Wh7ykizpQZa3EIKOdl4Wsp8r2ah0uLnkzXlA91G4FR2Bpzt0lT2c1WN44t/?=
 =?us-ascii?Q?ndKTKwH5hIrFRgPCaz/a9f7qKLYtzRGyA+VsVShgEitTXalkkmKbcNfn3E2x?=
 =?us-ascii?Q?7i3d7oiuIAc9hDwb2ChIWQZ5NEyme1aleVMlXW/7G1212/4xQMgDmkcN482p?=
 =?us-ascii?Q?TzDLRbwL8UWt4fmB0eH0Ol56L4EAahB4Dh/l2hlVygqR8YgbMH0ETqKvCmix?=
 =?us-ascii?Q?Bn1TUJzaQpRBg5kJDMZVDlxOg96Gl1oE/9uCqY1fuCcrHo3fdlMNzj47Hj02?=
 =?us-ascii?Q?+WJ6Rae0mXaviMsVDzx8IjfM8NX06sb0eyzaQyCbB8VMwFUziGosfNjhpwA5?=
 =?us-ascii?Q?8MzW0+ekrnAg2FUtSHeWq9PsfJogFlmnRCGK/2ZNVTQauBOhv84BxdXfHxje?=
 =?us-ascii?Q?4MtoVVfRn3/8A1JIj3Gn7MYBWa9Qx4M7LRYwnRRhbLr4AncPB71MiA6H/KXu?=
 =?us-ascii?Q?3tL/oPljRe7aKL4hJjPeaNlgSfQ0qJm526Q6D7hC3VvC6G1fVV1eGulsEv8i?=
 =?us-ascii?Q?t8dRhVVbnCZA4FE411SDfFCE01w4RAllJMsnZ6YO5yrNfU2vrSDWwudRaQDR?=
 =?us-ascii?Q?Q6EOXNs+2vkFHCgyQrzn+teu65et/xZl87TrIoAbVnxOgf7AN1hlFcYrQJgH?=
 =?us-ascii?Q?5a3XytkPs9YQOjC6Sqo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:29:08.2222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fff46013-bde0-496f-fcae-08de2ba8e23e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

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


