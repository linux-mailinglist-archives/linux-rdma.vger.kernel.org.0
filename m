Return-Path: <linux-rdma+bounces-14640-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 315D9C741F4
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74F72356F76
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 13:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB76B33B963;
	Thu, 20 Nov 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J7Ymknnn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E8A33AD92;
	Thu, 20 Nov 2025 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644433; cv=fail; b=gWhsDt9gEi9D5tXnn+4NH2Rf6d50QnWS+rgJzaBpAn8pAWFUxsXo+uBwUWEXYcfJ5fDwtiFXqR9tvpN6fKj5MDjw0FvU0Jpg8l5f75/XmjWucRaAVHrkbh3ZPUQ5y4+f57h/zY49erbNmfPgzou43xUIJf9H0/QsU42s+cSOmkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644433; c=relaxed/simple;
	bh=F4KBhu6lbcTnfzqWsIQNxHDF/bbxKhoyR97aufjY2l4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7UfzQo0/aBvzqCWpvey6Ji3kFJc4kscqaSoaVearaXx0W5REW/LZevHVsUDt81KsIABOO/1ERyqVzn8HciAjUrJrWkGbzXJE+mE4dar7h0gm0FuoP4JvRJI8IfsAk0XiBmF322dARNcvz3291fYzKiKkwjM1uJWKI4klPW+YnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J7Ymknnn; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8P0kfPn9z9azP89kIWHSw0IXXO64VSQfHDSDHp6nN/Rea5mK3lnl/9F5RAALA1YQ/YtXRBTn7RoIUghSk8JwaaWT1G8rY6iYPMX8nXBtY94/XSWFJ/IasBYbfhEr7dOkNzhZU0/QjLBA+Kv6EKth3H6sN/MeeMkCLi+vPKWJbEqukuWh6WoGUP+JDPgIOaTtbBJwztL9R5pKZQHsJCwEfpDiKpRMasCTyTAvD2FdIucfgYYe1mAmPWjR1wHiR8+6R702rJMdiwjE4Ak0z7YDAaedgLtZsP0PsbmhvvujsFZ/Dm+WisFeue9iMy77+rIHdBdpmZYT+sUN4Pj29nZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe/uSWnjL/s08PB4yaaM6Ls4oPQchv8ygCsRDdEZ4ds=;
 b=ocaDdmCh0Oq9P1qWC/Ee5/oRCtaRz/fnDYWBQm1l9XJaQ/7NMQ4O7sRprs1jX/8QOwVPB7wiFssCKbYOhPq/KwukcO9UE7T7gtO1paIZWp7OUlkJDmPYM8wEwVcUGilo3gN6a9Kgt2g3ErWkI0BeLBa0nEZQGD48sCKxZxcpcjSJTdVADuTnTZgj/cFvCoV1ssYB3LD0ZuvbL0h4oMsyctqy24Cz4g3TROltZgYKL+sOU7Nh6daYruROP15MprN8Yp+/3PIx51jw8CPu8t8S1/Nwm0lHZtl+B4SG0cEb4pLmLsOM2Fyp9+Rz8V4M/GTk/Q+OTHA5S3WkF8kmauY0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe/uSWnjL/s08PB4yaaM6Ls4oPQchv8ygCsRDdEZ4ds=;
 b=J7YmknnnJAl2oZjBpM43wxD4RkO1GCMn030C8C5l2XTPVFJgEVYvwXSFFqI3CGLuuGi/uaKJCrty/Ho3OwHD2L4CMql9blQdGtrj6yBgM8U9e1yzuNN/p+Kz+7wtAUA4pyKx1U8dgN36s7eshWLS2oMQl49GewQHNs3jp1l6GVH9BwZYN5Sgj8KQXBqleLyotKqlVjBG7ud+85DfmP+CD9Z2QLEyiXMvFW27/pU8LOBy7PFp6868UQKkz7i6LzPkwzsij7Uz8K7IZPiAu8AHHTXpb7ycrIO4Yl/WnOt/H5bOsNU/hJ/owa+8U/4VChav5nEQcsl0r+2pZ3fkgN+E8A==
Received: from SJ0PR03CA0059.namprd03.prod.outlook.com (2603:10b6:a03:33e::34)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:13:46 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:33e:cafe::c2) by SJ0PR03CA0059.outlook.office365.com
 (2603:10b6:a03:33e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 13:13:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:13:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:13:27 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:13:27 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 20
 Nov 2025 05:13:21 -0800
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
Subject: [PATCH net-next 03/14] devlink: Add helpers to lock nested-in instances
Date: Thu, 20 Nov 2025 15:09:15 +0200
Message-ID: <1763644166-1250608-4-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d427b21-acf8-47ac-8c4a-08de2836a31c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HzhULbc8I0AeKnK//ryf5QIqlxjRDl9WVOY82rLnAN289NGwGJFRkJG3qNaV?=
 =?us-ascii?Q?6aiaDhjxgvO1G1nN2n11jMbAGQBYLigSqIzKWpHzY4SOlX6n99CaggCIO346?=
 =?us-ascii?Q?txy0PVoUe4pueHORm3fVFBReUFUNTKhm4+SaLxk+jhpvfQCRdYhrCRhKzfyH?=
 =?us-ascii?Q?eWOMYeDMUBf0hUmRpTSqOluA8YGZKBbEuaNYz04cFe0i1puhjYy5zVz9Hb5Y?=
 =?us-ascii?Q?a+4XPrNEG+iRX+L0/iJg/joZnZux7lI8q+I4LoJjKlR6oNmWADJLE+V+6Ahq?=
 =?us-ascii?Q?/CLIkutiqEk+xvJD9hmtvmHZqf4CFuBeLWy1c/ZkYqq855/8YpCfVVmc20/5?=
 =?us-ascii?Q?2W7EHSxr20dW6KTGoul9K4ALekuMX4u0JNerfOCvmDT2gHOqNi4JJhNlQcHd?=
 =?us-ascii?Q?HZkknSnMu5ydNgf33TYqVTF6a3Udd2dO2sqLpWfw0NbrJkz9NmgdKYiWHvI7?=
 =?us-ascii?Q?ybW4nNJTcPWg5PNxrIoraj375xRxJKvXp7SqVLlaDuJIK7jQagmvALcwlf1H?=
 =?us-ascii?Q?sunt46x/QTTqoiS25TGUNUMHzYCR5mY0k0vtGDXJSlOSVP0cHfPT0xZPFy5p?=
 =?us-ascii?Q?c/NxleWrS6UK0CUIA49EXVxGkoq4ybo6PDaP3ICGhha0SCxZFSIEi5an9VuR?=
 =?us-ascii?Q?IjOYjhfGXOJKx7HbTzhwrKKhdBb7k7HV55ZoXK+f8vU4PY8CL02FfAWPMgUa?=
 =?us-ascii?Q?uIQZxUH6qypQndOQm64jKBJ7HkluQan/kgh2ax8gtM0yPMrC6LQev9u8oqAt?=
 =?us-ascii?Q?95UBkFEIR5/svnAieCNqgT/zYdiw4XtFjb/xFDkuVFj3VjcLZtip4gybRQiI?=
 =?us-ascii?Q?/k+lJBF6/L/MMeiMCxivaGBjy0H592beaJxSSoPIonQuHMw+keJfBfMCYWk0?=
 =?us-ascii?Q?Wcjfu3CJ0XEJXCWdQHolbUI8mJnionzXlAaKr2qnK3ZeWj3cuf3wE0/vAZRG?=
 =?us-ascii?Q?HBQNUW4C/NBb/CoWjde2IuAVkFEOGZDcYAFYJFcTqtkld1QC9iOIpRDrlwoC?=
 =?us-ascii?Q?xNB2tGWpFLfpqk6oYMNDUQk0ybwjz5bo8DpyXwFGQ2BvWRxO/Q3rdnh+4JTA?=
 =?us-ascii?Q?BZE+8872lhbmBUEZuFho6gOKrwBQXmjBbzG7RbX7H4IMWn2ILheZRuMuzfG3?=
 =?us-ascii?Q?ut+5o74hBBQXCGMdHU8AD38Y0TObYqffgGRjdBRDZoduYnu372wUzaUTexz1?=
 =?us-ascii?Q?v3WnSg2DWsJbFgl+qFdO16otHoqet5gVW+viF885sCtGRc0eJkIV70Y/iP7t?=
 =?us-ascii?Q?Knrh07RhmC6HOkeoWQGFP0dZG/y6+2KxEJBTd8BlKWqlIokrdNY/8+D4CcEc?=
 =?us-ascii?Q?A3pCKvwTrwVfoo16uy6Rvk2i3DwQdi2IMc7bZDKgUfjRtfvkdh/6+cIsuMnU?=
 =?us-ascii?Q?VzX8A8Z8wc2Kq/q/xqvlM/kQECSJYjBjTCT61V+lYPb/n89bEdQKsySQ/Js+?=
 =?us-ascii?Q?nAztFI5hPhXCd9rEM0PHxqMtRndqvMvflCsxar0+3ZzBUgQ+xe1dhlwM6DnB?=
 =?us-ascii?Q?qTASxQowejiiY9wNrqtw7dFwKYhZq+e5t0/OjM1Qn16PWMLsHBu5P5u+3+iM?=
 =?us-ascii?Q?Bn2uZKJw/pZYyZ70Zy8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:13:46.2139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d427b21-acf8-47ac-8c4a-08de2836a31c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484

From: Cosmin Ratiu <cratiu@nvidia.com>

Upcoming code will need to obtain a reference to locked nested-in
devlink instances. Add helpers to lock, obtain an already locked
reference and unlock/unref the nested-in instance.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
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


