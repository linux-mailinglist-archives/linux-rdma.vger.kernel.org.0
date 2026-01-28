Return-Path: <linux-rdma+bounces-16137-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFLIEQL0eWnT1AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16137-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:33:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF73A07B0
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7524B309DDB2
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A9834F241;
	Wed, 28 Jan 2026 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oSFsMEUd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CA634EEE2;
	Wed, 28 Jan 2026 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599691; cv=fail; b=LAJTox4CFCIP5ANtHiCP7q7mv75eO0oGxAOdgDxc7wo1dWFBSsx10b+mHMKYoN4E4+PS6KGZdpMcIhKIExjRgzOip0PiSnaTP7zrxoU7RFpmMo3OkHRjzBAPxWwVwPdH/ZnzAs5XROs+qNjFUd31BRgopTewTcufcmTaXPagDow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599691; c=relaxed/simple;
	bh=/no988dXRByA4dAv6xSmtV1gqdNqkJud8OF8Lw/T7fY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6DZl5q7osqNNSM4i5NoWHtIy4zfVNZNNsKoZUMjAqn0NFFr8jl+ze1GAbpXM0hXCgrWNTLaEaa4q5OWbqectDNIYUss/5+inkbD5c0X4ailALZ6oYnV5X44utdO3wTWdQeOsM3Hy6OuWBlzrvSVWgHHMGTh5MMrUDQcd1lYqfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oSFsMEUd; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhEj2NsEtV39odxRukpbJ4mFlHICHaKoyq0Qu8fJzAJ+/kd1Py4Rz7fhllfhodSWHNklbtvgvUaTIPzXiO/enLzlGYmZsDjCIXUtZb0NdzBaYiF2UtPSEkL3slwQAsoLYl84fAd5GFsi86rKDefqSMpLRsJUYLohiJKAYbDIKJljpQBAmKH0+AQM+MfLGV947Vc1fD+pjeoxPROi/5PPBl6qjqhb1NsA43x4DjW5fD9fRvmhdu6pHDNWX4gtEgv2JFI4C+JP60hWPo7rFWEPmV0ayR5B2DMGbV7siKzUgo1Dte33s0QWzx2yKQQi48GwhFahsGcGzUW7FoBYHn/Rbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDRVdmRjGd6OOqu3CIeP6RyxaEBJy6PkXdTwAY/9YLw=;
 b=BnZY/+SNsDmCDKyKqP/3Vboq2P2niHjL8RQnjeDtF7UU/yUUPbvctwlssKeBIO1pdFgZa25oaKKxz6hI1M+itFCmb4ZXNIUAhQYLzEGVaXMcChWUe4NlBqeYx4jWjqHQwxvnbgglGKhdLlBEMWfDG20z99lxfKRkggKJzv+sT75pLTWCGE2KQxAkxN9Qej/qgcDyR8Kth9INmvWfINOeasqVmHip74KSa16v+qyOyhB4pftlinWSXXpSWKKOIgIZ/ezeAM8JA1kO/y8mfcyurunt0BcH9auLB2dLnoh5ZviMuzqdF+TcbUbHRddYhoDbwiN9omrHXCPtyEr4a5DwZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDRVdmRjGd6OOqu3CIeP6RyxaEBJy6PkXdTwAY/9YLw=;
 b=oSFsMEUd7aJH2YaGXZ+OlY+EqAHzGCybzlgl7Bx1wvhVFd3b90DsEXoxZqebwsrVJdK0OIo1tnMFSPtSdGhqPm0mmR5zOmJt9q6EWlR8zkDVhkdDvSDfFyHJ7Aylb4JlJ75UCE3MJqzNWsQSnEiRrOlz0ix1r76rKWbNoN9XTeIsOTgXIsj3DdZkbWdk7jw7S9bqYpqQ+VaNguhNUATpXmMSMR3dL+CMfMhGnGAHG3tS4SdQGiQZd6pN9hQxOEkDoto5Ltfnw6koLmzQrQOqb9NpX+ba88N7O3caePW5kU61ULb9bccKvdPgw2jiwbJGUlpbg0vTVMrssxDSWzJ/lQ==
Received: from BN1PR10CA0007.namprd10.prod.outlook.com (2603:10b6:408:e0::12)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 11:28:01 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:e0:cafe::20) by BN1PR10CA0007.outlook.office365.com
 (2603:10b6:408:e0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 11:27:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 11:28:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:27:48 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:27:47 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 28
 Jan 2026 03:27:42 -0800
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
Subject: [PATCH net-next V7 04/14] devlink: Add helpers to lock nested-in instances
Date: Wed, 28 Jan 2026 13:25:34 +0200
Message-ID: <20260128112544.1661250-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee9a5d5-7f6a-4fc4-c364-08de5e604b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EAFlT7AJWRu7A3noIaYs59gx+y+lLYAotYnLzgBVQp81nydf1iXF5rQEpUQX?=
 =?us-ascii?Q?bJXt+dikOAPVnLhssPfUkI1Q3qcHH3+aSMEyqi4tnEv1czHK5PL6hOoT25w/?=
 =?us-ascii?Q?vu1vP2fBhKKrAr/jKUmeYzLfvAdeDOqEwMkcUux2YpQ60T8bxY2Djx491vou?=
 =?us-ascii?Q?RHKaDhRTDXWLDoMeeYtLFGWUxgNITe0JXF5Tqhf1eHAX85Ffuk7NlCkWhdjP?=
 =?us-ascii?Q?s2T9IAMA611Xu35+gBlkEz3VbPq8wSCtEQsr3gIvM/sKuaF2vyGsZvXAvpRg?=
 =?us-ascii?Q?nFuRGNFhYN5JzEveW4ZTTqbd/5NH9BEAQn8E04aKfH+gid/iHVJQnvMpk9Ht?=
 =?us-ascii?Q?YaiFDpR6KpHbYB5H+VD+pz/LrtrRkqQilwVa12fd2Vmu1ejA9z8crIcqDA2y?=
 =?us-ascii?Q?uqywAtX1PyaAF/bRv6dQlJZUO60/eOSA/DdZ5EFkQGBWBdWb/ZmzKKNgI2Xa?=
 =?us-ascii?Q?Nqg9W0LqnMGcbuZZXzbNS7LlzBYravQd7P8SnsUHJS610O9psWfuD+1Uj8/D?=
 =?us-ascii?Q?AgBvGFBTysYY7yFArKqJEH8fPLmkK6rG+CIc3r1N+/gbE3gNyf42t+Q4sPQq?=
 =?us-ascii?Q?0ywSwG2J937i1yETSydnD1umSZCuqkIimb9C/sh5z3RsIG2k17qPbobz99rs?=
 =?us-ascii?Q?ottKYG6HTBAZgxK02EXjs1a2tFmnTDQfrYWC7fC2giBa0A52+gqc83Oiabsr?=
 =?us-ascii?Q?zh00B+2VWZaOHKsYkUWJsEFigomZmU/ODKs/3wuIOZm9UTSFSm5KSjrzAPDt?=
 =?us-ascii?Q?RqPkWIs3J3ntVNXdgvPWHa99Q3QBumdSv3ONW/N1hqRxQSNptzvptj+8uKFI?=
 =?us-ascii?Q?hMDT9VeY6AVZMESwH3LZ8Tk8f2SecSnGXuzpCI0TJlClYI4vt+nXCvwILxDZ?=
 =?us-ascii?Q?9wUbz86ajHeRWl+M9KSXdksjPTCBn8FczDO6nXjbD/F4KHaJOxM6rcMjorGK?=
 =?us-ascii?Q?bnugXLqblLIhp390itHLwM2JRHoDow/Vgn9SFKpkeT6c45IbCZhHpDjZSZkZ?=
 =?us-ascii?Q?v0MiySNzfsl0jW3Sfb6ef6p/IF6TbXzjMrOLleVKYUb/UOrYiI2FWlc+aBal?=
 =?us-ascii?Q?g97t423+kSKNDK5Ujx/brsC1+JgwylR+XAWiTkGGtkxzdIdMOJ2ePlxpX+Sl?=
 =?us-ascii?Q?76U9hAkOfZyIVbxBojQKV0eJr34/+yf9kGaxqHcr2RDU4WVQJKAyEMFdLxi6?=
 =?us-ascii?Q?dZFfYFaicK4fkadeLGP2vIyrfjbozQvc8HO9WJU5bf6CYNOOfY3JRyGr0JP5?=
 =?us-ascii?Q?3Sve61eCEll/665jB53VksjuD3aiUXtFqVXFhi2kMDqNwz/3FZERoJv3+OMi?=
 =?us-ascii?Q?sonY701eT/1msWjfWCZiOS08gwuuz5pPrvkcde9peZIiPkGqNgNCgsy4054f?=
 =?us-ascii?Q?tvPJgG2vfaLVI8se1dtRwpZVG8m6pMU5hUD6qeB37PsxMk5evHFYxn1/LRf8?=
 =?us-ascii?Q?O7OyOtvVXuZ3cQ6vylQMcDAf52mzfDblz+kELhiPVgsjXXrJnZNVOphgpZDd?=
 =?us-ascii?Q?ISaAG7CW6AEF6IKKZ8d3ojgc+fHDHrQRvt69cW2+a1fpVWTb//7joTrgf9dd?=
 =?us-ascii?Q?hTbw7M7P66N5JdWEXuLrfHPewqtxiY4FPeoBpZhHSRFUmqzgWYVcK4ORbeP6?=
 =?us-ascii?Q?1YEqMcI8Iy0g3itpUS1Ooa4txS6CDCnlB9r2fMyWnzubWIuoGR2S0Jf4S/ru?=
 =?us-ascii?Q?+uEwSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:28:00.4368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee9a5d5-7f6a-4fc4-c364-08de5e604b4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16137-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BDF73A07B0
X-Rspamd-Action: no action

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


