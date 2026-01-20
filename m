Return-Path: <linux-rdma+bounces-15739-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C858D3C17B
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C97915A10DB
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 08:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5CD3BC4EE;
	Tue, 20 Jan 2026 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qzVBw57C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013024.outbound.protection.outlook.com [40.93.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE023BC4DD;
	Tue, 20 Jan 2026 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895943; cv=fail; b=pbj3j7osvAldUsD/WQNbYA4vziWvYq24OCNtMJvi4uHib7eaFi0H+Lh5t5mEarmzFDFsX96ZolxqPy+UFlYbrd+cOeIFLQP+mscSeIYGQ1Nfk3BenIndmME7jPE5uEveQU5xxG0Qcn6g0uARgWoLhaqaBVaBNeojHaEg3hkKK2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895943; c=relaxed/simple;
	bh=/no988dXRByA4dAv6xSmtV1gqdNqkJud8OF8Lw/T7fY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpcLHInuIZKCCaegVfck+Ss73UKX/eQ9PT4mLDHq0Vas9iktDkmHHIo9kdfjPUhgSZ5JnOHHpTNqIq2AyZO7YVqfKin0CBlOzXEfUYhPrM9hCXDQ2mIYRa9JIuOVJan6jh+MkQ2L7u743QfoHeShgbUPRpww/1Wc4QWQlrkTkdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qzVBw57C; arc=fail smtp.client-ip=40.93.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivbO9u/Rc5O139MXpdURrtasb7h/bQum5dMv24/er9fVaWSVwbtIjJXXUA7fVDZlEDV5vLYbdzM0jA7DRg5BB2q2gHGjo2mnlWccxqAag+vTPt/vMgQQrUmfbOOE72Mv6l5NEg9R7XPMnFuKiPhRJF3YI/zC4SJg3eOtJHMcP1XUhpIYOEtxal58sgv2Uvu+00p+IMndIbWfj3pVOtyKzyKHIOdvkudxMMK6b3bKMSFbk5W1FEYEcTWeMVVTcL8EVi54qw6aPmuvDrxCUVE1b4dMbI7KamlxC6hQjXU2LCKKIABdKU/hII3/lKHU2mEpUgyyqNaMWvzGQPxKC0KQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDRVdmRjGd6OOqu3CIeP6RyxaEBJy6PkXdTwAY/9YLw=;
 b=LjyUIyFA3heIez6yR8n8lsV3oWqJ+ERW0+HDbgff/6ON6LIHHBj//tZK9cBWp8EQCqGp3fjDxNF4Po7ZHOW0yyUcTFxw3cIyedGJaPf7qOFw86MOMSFOBS42X0BUE/kTIpJENMI4H9AbIy202gS6ez6Sde2qztDS9lpUY9mRgAm972H8FvonsEQtIQdsYgtVJCt108TUQeVPuTEsGJ41CDpMrQSxENLlx2PR1gtSiE1NqmC+pEOWRkdunc0Pszay5f7+k+PuSMnyEr7lwtF3wuljEd6IFcMEJ6JiKcbB0MyT8Z0Fdg2Ue16HKHpZP+UyWNyGiTOY2dS2PgFqmw0xLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDRVdmRjGd6OOqu3CIeP6RyxaEBJy6PkXdTwAY/9YLw=;
 b=qzVBw57CPJl7ssu/Og0ikLDuHKLcrh0NWQAOWGw65juPU3UK4rvHavyz/s51JYjPIciKDWa/bHGWpk2UbkKK/FlbMmTWTDevNC60+frapgHIIwAuQ/ry/YD8r2owMYUGtuUEBqm5TptZQPOaPzmHKbWbXVqUOwkFDY/5V8RWS2LJdwiZxJ6c83P96oAeFxioKa1m6gGaPH59H/IRtPMMQXuoime0uKxodea65b8cg+454HPs14I4rA6Cwkn9ZyNVvdT5PLJ+a/KgmHf9BNp06gbRTnVALjEkjCIXksCo/ABVHptTqPBL5O08a3mY5apdwauX+iNiGwoQgijX76VLYg==
Received: from CH2PR02CA0015.namprd02.prod.outlook.com (2603:10b6:610:4e::25)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Tue, 20 Jan
 2026 07:58:57 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:4e:cafe::b5) by CH2PR02CA0015.outlook.office365.com
 (2603:10b6:610:4e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.13 via Frontend Transport; Tue,
 20 Jan 2026 07:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Tue, 20 Jan 2026 07:58:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:58:45 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 19 Jan 2026 23:58:45 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 23:58:39 -0800
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
Subject: [PATCH net-next V5 04/15] devlink: Add helpers to lock nested-in instances
Date: Tue, 20 Jan 2026 09:57:47 +0200
Message-ID: <1768895878-1637182-5-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 3162e688-7487-4a9e-e639-08de57f9c3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aE6ePKTJUyu1/93Oj4TiwSf00tm5htrRFOEFOT4Fqs9/bBzYUQLmaZKlB97M?=
 =?us-ascii?Q?uDZSspQ6wohYAkaMTvAUTDnvIEnjE4VNndKVS8YpbW5stiB72B1Bpwj7fWNu?=
 =?us-ascii?Q?jaiqDUmdVIhfifjy8sJ/xUrlRDKhiaHOuzVEd4EXIJxDekmPdJD9prpUKlhR?=
 =?us-ascii?Q?+fqZpbuEYzBH02J21vFWtAEO33oyu9ppImqv+FDQt/q+IZrwDssatQqfPHg9?=
 =?us-ascii?Q?ie8KfMCqXQ6+0snYiVXEHjpwtcc+SbYcqPx0xYkukfFNSk4B+nVaQ1p+8mWr?=
 =?us-ascii?Q?vekKK2vRG9KSa05l8Re+y4nwVR/8NtEG1pjAijsMpKu71XnrSZmNIFw0BuAX?=
 =?us-ascii?Q?q3iSnT5YXMykmVJmkFEes7U02GRn9CPp7Fev7TuVtzwqcg6VsJ8WfM4OUyUr?=
 =?us-ascii?Q?H5FlGBvz2b3Q9juFfy+TnIuv+MlwjuuPJlOkBmVx/EsZKEG7/3gHw+tjbv+s?=
 =?us-ascii?Q?ZUtzYUrVubND/ejfDUyQrv8+44+IQzu19IaawpEOg8ldAZHh2Zp6j+kIlg8m?=
 =?us-ascii?Q?X+uZ7Twvycr7+9VWNHTRYLyRn9xPD9S230a/0QwTEd31flZ0p1gjVp6/+SCI?=
 =?us-ascii?Q?VmUHaykmgJZ45PGl+d1jZW/ku2cdv0pk0yApDV/FrFs7/jt1LfYclcQMryg3?=
 =?us-ascii?Q?cSeQRXO1w1dJNTaS+26pDi1g2zwnDLHiXaeld+l3qELKxUfsL1WGhrN9YfTh?=
 =?us-ascii?Q?TLaEzfViPfAF9E4xDfWNPTklHs7K0fRHa6vMiq+JiCgVYtL3+WQglE2K2kb/?=
 =?us-ascii?Q?6amsq1PVORO8st2AkOxhF8T8ViBUIP95A4M8UXQWeYbmvOLN561EYD7kYHzf?=
 =?us-ascii?Q?hbdT7z9iW7kfGAwm84GQbZ0+Otv+g3RsJHEY/mZnW1j0NcTlG/b8Ec49zz+y?=
 =?us-ascii?Q?ou6NcnQ4EUM9DSfE47+ovihULAJmij/QmtjkhJeQhfR1cuh0unOI2pCprm16?=
 =?us-ascii?Q?6WvfiVUZCmYuw5uNCMXPRBFAwERhMFZmrxDJwsRwSCzDSD8j9MPHtOYKblDd?=
 =?us-ascii?Q?eTDSXSuzh36yyPZ2w6KX/KWad/cjX3NSZYK6E4nr0NJ8qAVw4CIWmNIV8eC9?=
 =?us-ascii?Q?OzakCySxzCEjPfGgszJ+D/ymwF//xXGEoz1vq/gEMcLjnpuNM4rDDQRnTUR/?=
 =?us-ascii?Q?yJXvO/0zRVMlEFFWXKOMNRtH7AnsZh+wjzEDZl43jprXesOG1T6IlvIHgrvf?=
 =?us-ascii?Q?1CdyOUgPY5U+ZSWCFGPronD+BgzflKftyE5LwbmgxCFYuWUUMBD683V0Npa1?=
 =?us-ascii?Q?9CdXJXsSfAoFeg9K3Fg6/OE9ENL5qQUR2f+brXPEa3o3L799JwczMXiF9nHm?=
 =?us-ascii?Q?A6qifBo9mXkRIBUVif4TFNwjpK0Iyxh0eYHskie9wFdgAYevT1lDJAr4lU/F?=
 =?us-ascii?Q?Bzj1AfnvqUm56iaiaQm2de7hJaZhLpuLRlc5ndhFlvfbGAZPLaNEdtF2/FY4?=
 =?us-ascii?Q?QI5uBleIu6OPZzaXzgCPNzbZLIFeSFQ0F3wiJVuyVOdpYMyBQThIpDVs3ve2?=
 =?us-ascii?Q?SxK80Uw/C9dX3WgNHICkMfLon3sU/DQyRaP41CIbkDa/gG37a/5+oRjwWUmb?=
 =?us-ascii?Q?r+gKawhxeRgQgP1mqjroJGNuapij2WzKj9rPo89S6zfXvblSUwh1NmnWYOm2?=
 =?us-ascii?Q?TuZXK3JysW0zh7PpYwAc+hGvkIum9YZ5Yc+vKAKsS3z2O/wTAaE9Tli0KpTd?=
 =?us-ascii?Q?JHbgiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:58:57.6995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3162e688-7487-4a9e-e639-08de57f9c3e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806

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
2.44.0


