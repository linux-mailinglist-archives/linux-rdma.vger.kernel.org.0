Return-Path: <linux-rdma+bounces-16138-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGX5LD/zeWnT1AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16138-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:30:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BDDA0700
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEB1A3025E0A
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2189C350A02;
	Wed, 28 Jan 2026 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gAqv1Em9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D99B34F47E;
	Wed, 28 Jan 2026 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599696; cv=fail; b=k3WPMsVS/VZ5e3BJ25+j9xND1A4gdHbrKp36JFX9qBo29Vs5qpyVDMvJt/ok7bmWaYVcLqTd0KvCm6X8Ant+d0TfQwo8TOJqjs5Y+Y5H1jWYAdHW9Sx0jmoNR+ebcK+IgFkBl6R7QyK8+Ajb6yY/78xIVRIGe3oyW681XqNoHvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599696; c=relaxed/simple;
	bh=RjAnyV49OpqLxH1Y/1/JYniSm6cVIzb8TL2yHKgRTfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLknPQia8d9K+s05flkZWPXi9p7yOpKwgZMSL8K62KHL5/aW4k9x8j5KGOuUqIoBMknuWgWXcPT7loIcu262UaXTAUsFVL+aY7rn5Gs5mnlDmQF+JPO1B47SM1CWIVGvQwDXe3H94o3KTmGWDRiKATX7xN5HZZP6UhSi4jGtzpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gAqv1Em9; arc=fail smtp.client-ip=52.101.85.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5+hoT3kisFsXerhHiZBBzVipPRbpjylYgobBGakPcqXzxdiUUM9zJGBDf07f6J6rNt41oGkMmQx/3+gJoHMhJSF6qUzcj6EovdiLRnwkSkhupgKR5LJAl9YjkVKV8VT+bbg9ozFsZ2CLxHSySopqHz16eGIDdbGIeZos8N353fa+Sq2kkNq8keHrDYp1y8+tYB1g36/NdvoecfQmQnJkulhiLqDTeJvmWk0qE05O2EZEMLvleLuMH/8jckNk9py7ZLaVFk22iAdf1OEUmrfoRBBAU3M25MXsalxvnOz3pIud/iLUomhbpIU+Pmul6gAvffyjokUB1hUut1GeEm6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2GtwMvng+TR169kHZ1pzGoSguw7VuTInPh8458bkCg=;
 b=vyZs6gdr2OjlOtuXM045HQEXDtxmiAVNq9QcWbVZKMm+oGRP2dXXlPtTJGinkH/VKTXA6QYVbJGxdkdyGclJ8xG5NwBaqau5R1ZDooOapHOFOQRNDbZPjeqd4ysfxYoPDk6WHAwAnN0979D1LjKP00xeXl60/BZ+mxYJjLspMpvqD0Eg5py3y0FsOoZS4oi5BwusE+zYKikLyoeDwTID/YsYtLsjs2qO18vF06Dc/6IIceUf82ayclYiIajNm0SvnJRGVrLXQ+pmPCoDqHuBWjLT9BkkEzVOU+V8q+XDzCafbsF6PYLP3T8ycsYzMmSbJ/v1zBIboxcSqxPC2sfjOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2GtwMvng+TR169kHZ1pzGoSguw7VuTInPh8458bkCg=;
 b=gAqv1Em9fOuElc0s7z7X+akbb7mouMeS5e4GnTwDINx2IiCZFkbZlDHXXuB5qdJVaa7D4LdPoPoLU1fRPQrQtTL9QS9aTaGdRj64Q0EjwypWcmBsozbqWroBz1BU+R87+mW3lqLFhB1CQtjIj3b3jLhJNFyDmQe4F8iPC/b4wllQtPQQPVQYNpzOuDRZPOeKbaKoWcc7mMoLNT1AbMYroBFXxB/3xjKpC20Exy7WH874Jg6Gycx5j7q6HNJsSuD/NTxRDc3Hu1oJO93OqwH8Sn9SWz9KgpJpBVUc4AKlxzIWtWMQz/4z89zuBFxNfdtgJb96mAQGfnv/0YyCgmZ80g==
Received: from BN9PR03CA0738.namprd03.prod.outlook.com (2603:10b6:408:110::23)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 11:28:07 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:110:cafe::3a) by BN9PR03CA0738.outlook.office365.com
 (2603:10b6:408:110::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 11:28:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 11:28:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:27:54 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:27:53 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 28
 Jan 2026 03:27:48 -0800
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
Subject: [PATCH net-next V7 05/14] devlink: Refactor devlink_rate_nodes_check
Date: Wed, 28 Jan 2026 13:25:35 +0200
Message-ID: <20260128112544.1661250-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260128112544.1661250-1-tariqt@nvidia.com>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: 94477fd3-f323-4926-7184-08de5e604f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bS74l7JpbFaTCvnqw7WdUWr51Ls4CZA8JWmOR0OqtX0+27QY2uzFPqPRKoiH?=
 =?us-ascii?Q?36w//7+9afs2OtnK4DoGsvvfEMKqrz2kGuyqffJL6yxeVQbOksNYqW3VfYDz?=
 =?us-ascii?Q?5Ddj9KRo5t5SYTLLG1HhQElJ8wBWMiU0IulgNqes3OEBOreLqsl8fBBPhobT?=
 =?us-ascii?Q?pMlmPcQWa5DNrovVeT2EnnYRzfzgnK5Vac+RNEYpmlruCpp0Mc5i3Hg5rNMz?=
 =?us-ascii?Q?0iMV0/TFnOEyo99PW6dFAesREKyBz8BEGC6PBimS/GcmBeFW9WOvC113T8R+?=
 =?us-ascii?Q?SQeHw6IBTBASoIKFL7l/UqSJYKtk5mSfU4HRryFKDUseLkpeoOSPwCcGys1G?=
 =?us-ascii?Q?F0npNzypptbjgm8bctA1RwE/+BKsfsMAe/7OOiK+UGZ5sFbLQbJ7p+HVk6ux?=
 =?us-ascii?Q?QW7PMB58OQYmFjCXVCEUldEPPXtUzK6OM9WNcaU9vXcArxBXW3oL0crv41L8?=
 =?us-ascii?Q?OY24KxLOJ7bOS6rTs4VdOQ8g+Tn7jqu2p62+OKMI6MnDuyTqFMPzhMLNeBSm?=
 =?us-ascii?Q?kdOZ5blu/IdxVYwu70P6Cm8pAdQO+hoMM49ya2MoqAPSmrFJMEUgbBn9qPsU?=
 =?us-ascii?Q?2YHbpI3dPzdPI/UqVaoRkv3lkmbwc/QaRShPhPoeukNSnTZV0JyleUiOT5xf?=
 =?us-ascii?Q?/P4qwNuQXNHOAPaK15yFbC+wc/IpkBN/Rt65fdDs/7pfjOWeovEB60XRvgbM?=
 =?us-ascii?Q?X6a8qw+FT4gTVQdW30jXEiQ4pDgDqgJdceEfQ7rXmR8tk398+63ha5aeYFp6?=
 =?us-ascii?Q?TGJoZJWCMmgpniHtqrk3DMK+CgTJuVb01HsU3u5qGaMT/2z2cg7xsyFQlzyd?=
 =?us-ascii?Q?+6sv+7KTzhKNyr651veU6agxFfHbiHsGnMLlBC4ZxLLQl6s1AmfJAkVfuL0j?=
 =?us-ascii?Q?6q+3ysvcsOpVox7YW6HvOHLSUlrVmzPLoVFtHPhBx6rOfGvguXbxMKynC/mI?=
 =?us-ascii?Q?j+AGu8wvBC3q6ez9/sLVHKbqcEz3bKQp+kJF0Z/i4p8UBrolP1m2DDaM6eFp?=
 =?us-ascii?Q?wk6LaHYwRMopqYULwFnrjb/ik++QKQZm9eipmW3fP/Rtz7XpsS94LnHV82ED?=
 =?us-ascii?Q?1HvALafVih4PlfoWC8S4S6AQBsT0sxjcpUoEF475FosCBHth7kR3IIFBNTJj?=
 =?us-ascii?Q?46UXegEZrQmgGB/ITgoX7uI1oVRLbfzI57DbuazlT/LhkDV7p+BKjuL8IzQW?=
 =?us-ascii?Q?+8u0lmGaCQ4eu8MSi241CKx5IBoPVQ1ikRNnLYuozO63zciarOAk2YdkYMFR?=
 =?us-ascii?Q?dAsgNm4B3i2Ym1W4DP2sLiz6hsCP0kd8RYk+RjsQP0Ouuz1fsmf9DGUHsJrf?=
 =?us-ascii?Q?hZwT8ZyKC/QqowpVc5GMyYrkb2+Mdi0hqe5osUirLkY0ciWUn/n1BzHVqgxa?=
 =?us-ascii?Q?X8CgfhEg3CbwM2jzedv91ATYRURjdlH84GJgrCJVsI8Uz5ZgmWnndljQOgmb?=
 =?us-ascii?Q?Qevb5u34Kq2yVS7Aq2EYMwkcWuu0axqjMBGP78iDYM856LKizjYGHGwdGWBO?=
 =?us-ascii?Q?5gCjhy9yCa+CBQ5gW2sCutLdYX6movxRrQ4tAn/Vr+GojkAuZDjSAWxzx9C0?=
 =?us-ascii?Q?opA0AXDxX4WcL+XV+g6fF0M3aYCJL8pefJEcNGC24lcnTPdEivPongoKLW8B?=
 =?us-ascii?Q?xuZhGZT9/jXi1+o1Vv34cY9fyE1j6BnOSThXT5iqZxL13fYEZlgIwqFo1E2V?=
 =?us-ascii?Q?4Jb6uQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:28:07.1015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94477fd3-f323-4926-7184-08de5e604f43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16138-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 79BDDA0700
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

devlink_rate_nodes_check() was used to verify there are no devlink rate
nodes created when switching the esw mode.

Rate management code is about to become more complex, so refactor this
function:
- remove unused param 'mode'.
- add a new 'rate_filter' param.
- rename to devlink_rates_check().
- expose devlink_rate_is_node() to be used as a rate filter.

This makes it more usable from multiple places, so use it from those
places as well.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/core.c          |  2 +-
 net/devlink/dev.c           |  7 ++++---
 net/devlink/devl_internal.h |  6 ++++--
 net/devlink/rate.c          | 13 +++++++------
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index f228190df346..f72d8cc0d6dd 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -517,7 +517,7 @@ void devlink_free(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->resource_list));
 	WARN_ON(!list_empty(&devlink->dpipe_table_list));
 	WARN_ON(!list_empty(&devlink->sb_list));
-	WARN_ON(!list_empty(&devlink->rate_list));
+	WARN_ON(devlink_rates_check(devlink, NULL, NULL));
 	WARN_ON(!list_empty(&devlink->linecard_list));
 	WARN_ON(!xa_empty(&devlink->ports));
 
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 02602704bdea..e3a36de4f4ae 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -434,7 +434,7 @@ static void devlink_reload_reinit_sanity_check(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->trap_list));
 	WARN_ON(!list_empty(&devlink->dpipe_table_list));
 	WARN_ON(!list_empty(&devlink->sb_list));
-	WARN_ON(!list_empty(&devlink->rate_list));
+	WARN_ON(devlink_rates_check(devlink, NULL, NULL));
 	WARN_ON(!list_empty(&devlink->linecard_list));
 	WARN_ON(!xa_empty(&devlink->ports));
 }
@@ -713,10 +713,11 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[DEVLINK_ATTR_ESWITCH_MODE]) {
 		if (!ops->eswitch_mode_set)
 			return -EOPNOTSUPP;
-		mode = nla_get_u16(info->attrs[DEVLINK_ATTR_ESWITCH_MODE]);
-		err = devlink_rate_nodes_check(devlink, mode, info->extack);
+		err = devlink_rates_check(devlink, devlink_rate_is_node,
+					  info->extack);
 		if (err)
 			return err;
+		mode = nla_get_u16(info->attrs[DEVLINK_ATTR_ESWITCH_MODE]);
 		err = ops->eswitch_mode_set(devlink, mode, info->extack);
 		if (err)
 			return err;
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index aea43d750d23..8374c9cab6ce 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -300,8 +300,10 @@ int devlink_resources_validate(struct devlink *devlink,
 			       struct genl_info *info);
 
 /* Rates */
-int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
-			     struct netlink_ext_ack *extack);
+bool devlink_rate_is_node(const struct devlink_rate *devlink_rate);
+int devlink_rates_check(struct devlink *devlink,
+			bool (*rate_filter)(const struct devlink_rate *),
+			struct netlink_ext_ack *extack);
 
 /* Linecards */
 unsigned int devlink_linecard_index(struct devlink_linecard *linecard);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index d157a8419bca..0d68b5c477dc 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -12,8 +12,7 @@ devlink_rate_is_leaf(struct devlink_rate *devlink_rate)
 	return devlink_rate->type == DEVLINK_RATE_TYPE_LEAF;
 }
 
-static inline bool
-devlink_rate_is_node(struct devlink_rate *devlink_rate)
+bool devlink_rate_is_node(const struct devlink_rate *devlink_rate)
 {
 	return devlink_rate->type == DEVLINK_RATE_TYPE_NODE;
 }
@@ -688,14 +687,16 @@ int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
-			     struct netlink_ext_ack *extack)
+int devlink_rates_check(struct devlink *devlink,
+			bool (*rate_filter)(const struct devlink_rate *),
+			struct netlink_ext_ack *extack)
 {
 	struct devlink_rate *devlink_rate;
 
 	list_for_each_entry(devlink_rate, &devlink->rate_list, list)
-		if (devlink_rate_is_node(devlink_rate)) {
-			NL_SET_ERR_MSG(extack, "Rate node(s) exists.");
+		if (!rate_filter || rate_filter(devlink_rate)) {
+			if (extack)
+				NL_SET_ERR_MSG(extack, "Rate node(s) exists.");
 			return -EBUSY;
 		}
 	return 0;
-- 
2.44.0


