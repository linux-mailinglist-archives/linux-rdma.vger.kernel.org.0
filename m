Return-Path: <linux-rdma+bounces-16588-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sODpDL2phGlL4QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16588-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:31:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92238F3FFA
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74AF33012CF3
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 14:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2C13F0763;
	Thu,  5 Feb 2026 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EDA8zGaT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ED4218845;
	Thu,  5 Feb 2026 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301875; cv=fail; b=naE8H5ApqslX1D3nmUiQmLQYAjEozssehluGPrsuLaHA0h6/pYio3DO9DK/L12WN9HtVM2s+WsRYjZr6HPWGvanJ2UXdgUFqpR6RbVbp/7/EekHiJlbVly7gw/+zjmSR/40QDtxGyUrHeEGpvpdnjFhOyuZAorUvCbysffvo9v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301875; c=relaxed/simple;
	bh=vmyMjIOE+LB/Ax0RAUog4ninSEPPLXakUXupJbiVFgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jea+N48a9+EtjVSaR/jPMJXiZ3eRcdrbcswXMXiACH7jhgTtEwFTHgJ7KckX8Sy03heXBAtrMckvwD1x3RKF9e5E+wyMQ24/ZwkdXyvBK9roMAtBmYTxFsipo0DMrE1nN6OUVVQTCMtoHbz3X6Q6aIVJQCq2CiW9IAlFER4XqKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EDA8zGaT; arc=fail smtp.client-ip=52.101.61.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGGSRLqyEO/zjzk8j9e9uMTFvK90CXM0MxKiH/ZHjtjHYO6EUhvUScvYmGpOox+x+Qvk83IzPa+CjQdCAElPMe8M5/aJyz+mPkHG3hH5N4cfJ24EEfvpJEzahr9jYB8cPjvmlTq6ykuYq/2iePILX5VpSEcOv/c8yx2S9dVDXg9dfxGiLQbnibaICu20zbBrGwxWe6BrqxW2+ufSjd7TrscHaQvWJd7VMt5ZZqgb2U9rUQ0ESrejz0L83hKfvzUlMd0nkQ1f7xkXssVkFUfopzQisJxEbeuKb1uUMOZBhXzMLVoyqObluJvSbH5DdWM8QDKM8lK3lRw2yHz6o09tyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4DSEXjCKQGrsmYFqTKNkKd5dimIMBY1MQMFTlLLeHE=;
 b=fan4p8VtfgbPkomHhW1tnQejIPffrJS2aWOqaveUnLY7QeOl/L9R+o+i1nz/dBpIt3Znf179ZxnO8T67yGkhoU3ATmQ3QLVWMSrz5gXBG9+XkW/1DkRwJ3hMkFRKQ8flTiN+V/pdhBQZGlWzEqprCLvDxfgNCLdWee6duDx1G+WIJWc8nNbrMhFUO+ia1n6KEGLc538x6GHUcxnps4Up+yhajX2sRsGQV/ZTDQPY/Tw+R5zgr4CDPKnpBOR7LEkx8g79rTMqjfgYvUe8whX/Npdd3mejOiGbCixrJ0NL++T267RNCMWZFMeO4y63wVTu+hSLfOpvqy56ghtM+0ZNXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4DSEXjCKQGrsmYFqTKNkKd5dimIMBY1MQMFTlLLeHE=;
 b=EDA8zGaTUlkUjM13scNAQVVoIkfR40S6GErAjHoVsniYCqhLKZeOGY80dDnxX38Ydi8HzmtatMcxYU1SH1gKQL5PHP62h9njevaUxTyno0Yb/Rn07eJLHBjZ9UMNI6vQo0LPj9owpSVO2+NdQIME8x6B4da61ldDKhqU7AZKeh2UtDrnspbY9aSUjaOmAqIcf7w1HQwwIVrYsrqEJOreI1tH4zuIQR8a+7yQSfk1YnRredu2eV/pmmTMGgMgNth7elT5KHrSlOqVrWOVz7f2zLuUuu95QrjXJw+RC+za99u3m3GBE5MVo+lBTN/dcD/e+ZpTf/gpJTNZIRI4hB6Feg==
Received: from BN9PR03CA0170.namprd03.prod.outlook.com (2603:10b6:408:f4::25)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 14:31:10 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:f4:cafe::2) by BN9PR03CA0170.outlook.office365.com
 (2603:10b6:408:f4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 14:31:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 5 Feb 2026 14:31:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 06:30:52 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 06:30:51 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 06:30:46 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>
Subject: [PATCH net-next V2 2/7] devlink: Add port-level resource registration infrastructure
Date: Thu, 5 Feb 2026 16:28:28 +0200
Message-ID: <20260205142833.1727929-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260205142833.1727929-1-tariqt@nvidia.com>
References: <20260205142833.1727929-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: b05feaac-cbbf-4e41-df11-08de64c33541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fPnvhlL1ZRhfh5yJ/47qpLzjI3hux5YlljWY4dvr/bvzHePEkeJY5jbUV72e?=
 =?us-ascii?Q?ecPNWA0djXcYCZ1KDo4ewEsmktrD4fzTH/ZWpBFrNX6FMil29u7psK97s+iZ?=
 =?us-ascii?Q?KgmRL2J4ut99RaJr0/HISIytKW/kVtdul5nH+a7FYp7A1dI0RIiJgRN9oCSW?=
 =?us-ascii?Q?lpBO6vKIohCOlorhmSUHgP8h3jiJVxkBBkd7+8n9C6yjybrlghZyJCP+CUFG?=
 =?us-ascii?Q?6lNT00jah5ccUksrtt1apJ1P7ADrcLXqJo42LUQcXX01ewvXepWZKmn+xh26?=
 =?us-ascii?Q?HPrWULgPKhILKAxK3B9p34KMxoa/zI1riWEqCxrdbcRaU4RWN8uiPbvdppzb?=
 =?us-ascii?Q?1eIHt3+tuxq9KXrxBPTJU3nl+FGI81XZEmtNb8PGNWhPn9C+JRPEFPuESfFJ?=
 =?us-ascii?Q?jTU5CoXIeeJgiQTmENnmZ4krK3o3J+HhLWwG4T0f986KZWwYsS2qADCm0z0t?=
 =?us-ascii?Q?ASTXc85aS+EsM//F2enZzf8YqRJlNVOMyJKuYh3NYy1xGh+soez1N4zTIb+m?=
 =?us-ascii?Q?0NjhzUHFy6Ub5FE9fK2Y1Idta2zZQrvVipW1KHCHVCBqXDz4YRmTBwjVqOXW?=
 =?us-ascii?Q?Buzh9ucMXnQ4iL6L7nqdAzhSn8lS/I5OnNinlQkptchLu4Xj0pdNXYSVixeV?=
 =?us-ascii?Q?4Eg2mob29ZfhBQHcgDVMzOcfbYgd+YaBbuhEmXuFY61Qd52AWPsgCnojgd3T?=
 =?us-ascii?Q?gSb8XtI51wjCBsgL4fEDVpOfNLBfxVczsAm761XmYl9170P6H3WgYBLXW4ve?=
 =?us-ascii?Q?QmygZeO4Rir3n6l5K8sO7Gm/KTlo2iIKtJNm6zyDZXcjW3i6Xy4aZwmOfHTd?=
 =?us-ascii?Q?RGzjv0DRpfZevwvJAtueZbM6XmAtmWpPDLV3909zP5hEuHgp6nMom6WYo30W?=
 =?us-ascii?Q?k57RXLF+zC3j/HK1J9fYT2AXWJDNy9Pvojh1YbN2kCq9Y/p6qWP7SxeO8OPe?=
 =?us-ascii?Q?Tfe9/gG11qJhh7nYKXsIv2HmocHz06bCeERzQa7C+JQJbOyEL2hx9mrWAr+W?=
 =?us-ascii?Q?ndDNiLgArDjo3/sf/0qz7nuCfqM8OSTv7yAJxNxqdzwb0G+Qyvo87lafXImC?=
 =?us-ascii?Q?FjD2vDFETpZ5pwxu726wLMi1qinNoYec8ilsMPnKkYBSy2zzo3a4hpQnCcj9?=
 =?us-ascii?Q?ALwI8SVoViNVe6iGXljA/tSVHGYCSt/6lzJ7PlcVTMmHr6U5Ilstvhmd15+T?=
 =?us-ascii?Q?1/wQZ2+y4um8A20cyh+nOPQX0oe9VE9zBN/3+WCZ4SN7xatDXYCoWuR7wdQ+?=
 =?us-ascii?Q?tkyQRdsd4QbM0nzdfNUpk/G7g4jIjlyBXsNUMzAL6SjIo+muy+FZqmN1+21s?=
 =?us-ascii?Q?xEmDyzXxJFCTOPhVGKRRVjBtBlSgZxNY6tR62aASuI/ebstU5vyWX3/SGLPZ?=
 =?us-ascii?Q?9TjI0IFNplvE2RY4QPhWxKXlVakaPWnVxTgqz8REZ2CoasZ63wKTySreuOT4?=
 =?us-ascii?Q?PVN2pzAhDreIfdqry1H0CPPxQoE5CZpbW577JGTC+s82pdgnvUkih1/LI+Sr?=
 =?us-ascii?Q?0vbbXzF0SvUO1jDAetdTpJDEz08kuN2mMfsoV2DWAdKvVULZyS88JK2VGT7w?=
 =?us-ascii?Q?Ec0Nl9nauV2kZKIeOemvDbP+qqA42IE9Y0KXKtVv89nSJRzxx4H2mz5vk4Ee?=
 =?us-ascii?Q?mOYlJNWPvLY1FU3eK/vqDws=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M7wnPMblwiWmPnGqP5BDYeVVfX8ohnqd+uxrBy6DSOoJBhOnr3ZCByHzn7K+Cr7Z8M+adjOYRkXcXv0feZd5rHO74mp4xnSS0s3KzcCSI6YB/CE4vRuB+4tk1BbIayN8lGCKEbmiPQyui/hjVD6b77JRCT44vTqUAZhA4Hbe/r5jAkrUISqgEGTp/GudfExu9mlm0u/mYNEO1sVf5K/1X5MxmjfjUxYQAPYoW6NcV/wvfBTbAa8mqD8TLEVbPrqCXWC5TsBYn0Adgwi9iRjxnqh4w+eErguYYZyK7sFYjbjQsoGh/pFkG5C8DsCJgGZ2Hm7MIv6abXuNV27n2ZEK/tcznAdW3TmfoT2PKm+fw1ofgow9TpEw47eaR6N/DYo1fz5Ipen+ys26PJj9jd5+HeFXS6UVJjomgaygFSGAfFXxtUXYlUUtdvJW0hyF/ZL6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:31:10.6260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05feaac-cbbf-4e41-df11-08de64c33541
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16588-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 92238F3FFA
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

The current devlink resource infrastructure supports only device-level
resources. Some hardware resources are associated with specific ports
rather than the entire device, and today we have no way to show resource
per-port.

Add support for registering resources at the port level.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/net/devlink.h  |  8 ++++++++
 net/devlink/port.c     |  3 +++
 net/devlink/resource.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index cb839e0435a1..40335ecc3343 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -129,6 +129,7 @@ struct devlink_rate {
 struct devlink_port {
 	struct list_head list;
 	struct list_head region_list;
+	struct list_head resource_list;
 	struct devlink *devlink;
 	const struct devlink_port_ops *ops;
 	unsigned int index;
@@ -1881,6 +1882,13 @@ void devlink_resources_unregister(struct devlink *devlink);
 int devl_resource_size_get(struct devlink *devlink,
 			   u64 resource_id,
 			   u64 *p_resource_size);
+int
+devl_port_resource_register(struct devlink_port *devlink_port,
+			    const char *resource_name,
+			    u64 resource_size, u64 resource_id,
+			    u64 parent_resource_id,
+			    const struct devlink_resource_size_params *params);
+void devl_port_resources_unregister(struct devlink_port *devlink_port);
 int devl_dpipe_table_resource_set(struct devlink *devlink,
 				  const char *table_name, u64 resource_id,
 				  u64 resource_units);
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 93d8a25bb920..10d0d88894a3 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1024,6 +1024,7 @@ void devlink_port_init(struct devlink *devlink,
 		return;
 	devlink_port->devlink = devlink;
 	INIT_LIST_HEAD(&devlink_port->region_list);
+	INIT_LIST_HEAD(&devlink_port->resource_list);
 	devlink_port->initialized = true;
 }
 EXPORT_SYMBOL_GPL(devlink_port_init);
@@ -1041,6 +1042,7 @@ EXPORT_SYMBOL_GPL(devlink_port_init);
 void devlink_port_fini(struct devlink_port *devlink_port)
 {
 	WARN_ON(!list_empty(&devlink_port->region_list));
+	WARN_ON(!list_empty(&devlink_port->resource_list));
 }
 EXPORT_SYMBOL_GPL(devlink_port_fini);
 
@@ -1135,6 +1137,7 @@ void devl_port_unregister(struct devlink_port *devlink_port)
 	devlink_port_notify(devlink_port, DEVLINK_CMD_PORT_DEL);
 	xa_erase(&devlink_port->devlink->ports, devlink_port->index);
 	WARN_ON(!list_empty(&devlink_port->reporter_list));
+	devlink_port_fini(devlink_port);
 	devlink_port->registered = false;
 }
 EXPORT_SYMBOL_GPL(devl_port_unregister);
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 2ab4f0dfe0d6..1b06a1f408fa 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -533,3 +533,46 @@ void devl_resource_occ_get_unregister(struct devlink *devlink,
 	resource->occ_get_priv = NULL;
 }
 EXPORT_SYMBOL_GPL(devl_resource_occ_get_unregister);
+
+/**
+ * devl_port_resource_register - devlink port resource register
+ *
+ * @devlink_port: devlink port
+ * @resource_name: resource's name
+ * @resource_size: resource's size
+ * @resource_id: resource's id
+ * @parent_resource_id: resource's parent id
+ * @params: size parameters
+ *
+ * Generic resources should reuse the same names across drivers.
+ * Please see the generic resources list at:
+ * Documentation/networking/devlink/devlink-resource.rst
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int
+devl_port_resource_register(struct devlink_port *devlink_port,
+			    const char *resource_name,
+			    u64 resource_size, u64 resource_id,
+			    u64 parent_resource_id,
+			    const struct devlink_resource_size_params *params)
+{
+	return __devl_resource_register(devlink_port->devlink,
+					&devlink_port->resource_list,
+					resource_name, resource_size,
+					resource_id, parent_resource_id,
+					params);
+}
+EXPORT_SYMBOL_GPL(devl_port_resource_register);
+
+/**
+ * devl_port_resources_unregister - unregister all devlink port resources
+ *
+ * @devlink_port: devlink port
+ */
+void devl_port_resources_unregister(struct devlink_port *devlink_port)
+{
+	__devl_resources_unregister(devlink_port->devlink,
+				    &devlink_port->resource_list);
+}
+EXPORT_SYMBOL_GPL(devl_port_resources_unregister);
-- 
2.44.0


