Return-Path: <linux-rdma+bounces-14763-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DE9C86ED0
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 21:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A5904EA991
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 20:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0884733C533;
	Tue, 25 Nov 2025 20:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TcrU5lkc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013019.outbound.protection.outlook.com [40.93.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E0833C508;
	Tue, 25 Nov 2025 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101241; cv=fail; b=XA+3Gt94E3OQ3Jn/izpFcnr7TR0+p9/Fz8rzZXQPx1IpnVfdGQz+zs3580+EnEjTuQhQw6Wro6QxD6EXjEYyFNBcOdyhg7UVgjKcAO134mLDIDtc0UnIEKcG99Sn0W5x+QToRyzSdl//2GfSrqgiavRKOd/WhLzO1x3XtnaI/7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101241; c=relaxed/simple;
	bh=TR6J5kaeMnMHt+COoNaLdOk/eQgwymLaKE8/E4+L7Mw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D0dHVRozGbH+Vax2OXfKwVYy2Vwcud5zrvXl822Q53MsczBjka9mA7LKWiZNisFZoKrX6cpbqeYY2zEKUj/xarpwxCwli2RpKZ53sTCNZRARf/YFabhVIPwPDxrBEQ9JhBLLyF3yFBS6csebgcTaZZIA+Mie/4u08pm4FdKmLg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TcrU5lkc; arc=fail smtp.client-ip=40.93.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1k1/i4WaStAvbFw10v8X5hh+Ayx2Qr43jYNuOw626tkKfBAWvs23A0mgmug5u3jJ2G53q7+h+1O9skk2mrBaAhyazbnjU+5WXay2ebkq74wRiPY4xT54+cF6QbR9EMsYER9pR2uIewhP3KYTjIEa/3bU9SUhTzgECcPwAMVWnIuVQYous0EvZ+sbvPnu5TPzgsZbWYbT9ouNWutXgQqv1seJLHOUhtuOOnhR0DCD3M/oMeIn9AVAjHBbuJxL1jTgbRZbIUwt1oy7xxWjxP66sU2wRBm6q08880RCfbrhh8wjjUL9rZJ/yTzxUgoDdd7+cBuzaW4q+jc1Zy7dDlR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CdlQFXorOD2C7oWz685wggWy9NmZxX/sOcpJpJC7aM=;
 b=GH7CGqbzNipt3WFDDbFrvLLFRo6xpLncRGDeKrg00CA8D2Ru6ISXGDQ1HRTDBwqZWe4KKZidC7rr5zBGtHkTju+xIL8pGgpAbv8RtRmTV4c9gEJkDnjgtTlcGZ9KsEKR7l/MvGPvntAKWiPxhaLge7Y7AweF+XP/YZSmfcnyWfSBKqonRV+0iqbUteM0LLy30yCINE5aSESnN0tHui6APynstud31Bmfh+/lh/1p2urXzeLJ/0Kz3SBJR1gNh352Z3FKUWPQgcyl/PRnEj9y+v0UYgwkVFsuwLOqZWKqqHRsK74fUohAPCf9shVU54jRORxbb6cbb6b54GmyJ4jjnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CdlQFXorOD2C7oWz685wggWy9NmZxX/sOcpJpJC7aM=;
 b=TcrU5lkcaAhFokKtR/bjeKUqWg9ZHxhrgCf5gF1JIJ4J1Ctrsiz5xc1OFUFZxhk/BotoPX1/zYfFEXIXasfxOgB3ar+CPILZuVOvjmi/CTR3T0fAxAPLvkZ2BVTw5ql9W9f3c2bt+g02Rb1fKn3HNOQz/lGcgKVN3l0wzjf2r3X+rT+ZjTdPFHsI59CauDOoTRfaGhOKPvrbV0LY6ykkf754ECJsO/2JQb2bNEo/SLNbw2aC/QvXssRhsXNAxbaIDAv1PFNTwTssOCefC0yzZsx74kNfVZENOKDHCtOrqolah/6uWmcbmJ9iz4+8MR/V82N02pzu5IP+Vx9jAuEpKQ==
Received: from BY3PR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:217::24)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Tue, 25 Nov
 2025 20:07:14 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::72) by BY3PR04CA0019.outlook.office365.com
 (2603:10b6:a03:217::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 20:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 20:07:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:06:54 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:06:53 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 25
 Nov 2025 12:06:48 -0800
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
Subject: [PATCH net-next V4 03/14] devlink: Add helpers to lock nested-in instances
Date: Tue, 25 Nov 2025 22:06:02 +0200
Message-ID: <1764101173-1312171-4-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 905b8dfd-fb6c-430e-1360-08de2c5e3a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oAt0Cf4o+SLrsVQR8ctSMmiWzV6q7/moCj8xTLfvMhRGHmTWbwmu7KC05+zC?=
 =?us-ascii?Q?rw3ZqULp4b36PbRID2fSLRoE7jCG8J+H5SLFe9ZqQYdmtQCHHXn0nha7ebjc?=
 =?us-ascii?Q?m+rXtjNtZhh+ton8U1evB5m+WqyGkvmxaX7JT9nJJJXoQvFL72baJ1mJGoSl?=
 =?us-ascii?Q?6KJVTHOve8OAfgbI9NrA+tKCzg5kzhpjMWzBYJatQTUor1g7BkJJzmwYjoz+?=
 =?us-ascii?Q?J5LLCf6hVa4ynsYfSOtJRDKo6246ORugsCf4tAhSuEA/nKhUT7T2KIzdtz9A?=
 =?us-ascii?Q?utxMDSmrzAI45kvZ1UMsklCtpI99o3+hOUxvOn1Kr5iMw9dU6SaMBnZ4SUOH?=
 =?us-ascii?Q?KNdrHAH5piyimCeWHs3RCsEjxoNeAPsvXh+dw8nDiN2JY7GtKfKTvwnWAT1G?=
 =?us-ascii?Q?fdfsbl9VVzT2XDgb4HDD/IYFijeQrPP/3WkurPVHA0RoNjRocSMrJqC0cTVC?=
 =?us-ascii?Q?2DyzNLoeE1vRSOAaJrLvR6bmENYba2uN5Gz0C8JekP+kZTKU0UcHMUd6m+CD?=
 =?us-ascii?Q?UiOGa+hRkeZtmN4QOTbbhlEGTrajv5fYt/7KngQHYDJbaNJV+n9vZc3jQ8ee?=
 =?us-ascii?Q?FDk/nlJ18zTxvUAmonfHOyUxFz2bZ41rWCPnmMHcfn71csH8Oi1JxY0rsl0E?=
 =?us-ascii?Q?FrMbrQsf5ptKkfkIEkYPGt8mMz4gW1qVnHKIct67You0VO5FlbITpAVZq1fp?=
 =?us-ascii?Q?G6pTZYFdAXNKrBN6sjkKtKzcUdLtGSmkt389Byj+wuMAH36UBkjHs5ux02YR?=
 =?us-ascii?Q?NIO8QEGwwRZltR6Vz1zzPa8XoA93Iw8QjpcEZ9wwi/h/4bASJ2pnPliYaR7w?=
 =?us-ascii?Q?RzKhskZLum6sYOOA72P840EGOocc4vhomoSLAzaVNI8XRDRSDkQKQy4EE2bO?=
 =?us-ascii?Q?DRps1P4V3zvaHalZvxAMKUXzSEAVxxf2bsdzQ73nwUJVn8/W3GXeu+r/BBRc?=
 =?us-ascii?Q?7XuCF4AFHDKwnhUWaHGFGzeKQ9vEs3mVohr5aBCA84wfNBW85WESapry51bX?=
 =?us-ascii?Q?AeVMRG3kZNjBNeUSDj8YIGzA8RxopD9XQCLjEyM76sV9FZqtKH0KEDSnZfg2?=
 =?us-ascii?Q?oiXHsylwtZbnjG/BS+oANBXyt7XDKlgyD5rlt0Vx+kXhjIogKlCGbR8dxeiQ?=
 =?us-ascii?Q?DmHWNHC60NiPG4EUQXcQYyUvCVmOou3s0n5n4BbRUzwBQuies5lhe2SgELtD?=
 =?us-ascii?Q?vY0dN8WFSeMxjQzvgGYjfsyfautNeIuhuLbHWQOk7UGzBV/v2AMtE/Sp0zqj?=
 =?us-ascii?Q?UWoP2hK99zBeZyNDm/hzGrb6j0E9TO7KTXZjADADpXHJtLeJ16eQQHuDsEjB?=
 =?us-ascii?Q?exUjo42aIscEZefJ9fjbO/LKwCE9/Qrc8LJhWil8lng0TWZOD8nOdFsuAXgV?=
 =?us-ascii?Q?qpMyUa7rihGEX1CvCXXGEx2A8g1nGrHuc2IjdehBdUyiRBnYY33zzFUC34Nv?=
 =?us-ascii?Q?XwExv03f5/LkFumnuMcwISKn3EkRqLD0+zNJ4V5o4IlLyMsRQ9UzTojPWXds?=
 =?us-ascii?Q?Wd6ootwkwqhP7oFluODUsCtXP8m4sMhoxdUkwFrGev2d8HrWc2rNHQBpew9K?=
 =?us-ascii?Q?TPyS9WC3QUbFydwNP9s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 20:07:14.6668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 905b8dfd-fb6c-430e-1360-08de2c5e3a31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796

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


