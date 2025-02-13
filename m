Return-Path: <linux-rdma+bounces-7746-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05940A34CD8
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 19:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67FB77A15CE
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4F024BBF6;
	Thu, 13 Feb 2025 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MWPjA7JZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CDE24A07C;
	Thu, 13 Feb 2025 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469787; cv=fail; b=TB5TwKU2YinWK4+/PCfHNFaBKPUT5Q0hmMrC1iBqg2iMUh5nE8XOhh+62GDf9m7s4JuYwjZheCxS95KUy5ITQffFZTKmT7Qbm0ppd8wBPq1tJ+C/jUaJK0puZDOM+NOzrAv3oAu9VGpzd26aeLioEAF8t5ZL9YyRhjImBu1hBnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469787; c=relaxed/simple;
	bh=L4Z1QlNT0mtnEY4RbxNfFe2ED31I2Qao044vvWqDuJg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQ+x809ZWqwAzpzbGb/gYOlI0a4X2XxDkB4iofaAW5l2DWkqmMgzpGSndvq2hqT7Xd5M0cbppUjJZaZVPRi45S+g9KuodCwiwScj4QXL+oQLnMhYNmMzcTjHu7NMb2O5/LeCPT7o5vMRmAR1+37J9/e8CFOnlBIcWv3dxxSgpVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MWPjA7JZ; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyHDsL211HC6M33a3mOPhtD92PhZ1b/RGbl4BKLrI8kHRzC7gba7qEv8qOMEvtu7aEr4NkyjxTPs9LbO+GxA4p7x3ZhyJT+PwUeKSVk8L72XWqGt43BQchhaUxOrbO/7HrLN5T6ZiSaZ/DBfVAvWYisWP3VxA3XRt0X0jF5xO7dRJG1lUBNZu8fak95mM0Z34+Vc/SndLhVgQSLhjBX0B+4vUz2/tQVUSZD3hnzP5mlk2ZaybOn3IdNXmSjBQf0dp43CAymfez6Df1plxEj94sH67SyNfkiWCa6wGRQCIAM/N3xNK9WfdUY/CCsJh60dGALB7nr7XVasmQFu58X1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XllvOjya/7tVBuqu4C4KLFEiRLbqjpnmsQmoO8VcknI=;
 b=uTabLbMUkwGQl7DjM5nA3L7J43CENwTKuJl0+0qRbBclTUcqy4Q+1a+IA0h0iL5Jo++AlMJbzqTH5V7UkBAhOTbq/wGmhRnRnmzRZA7xKQoMRVM1iSA6CYtBsMX7IvLyppNv8tWy8lAXnLN1/Q7gn9jAssrLi8dCXYfCHc2YGPkI21fWGOz+tROVYQlJRVK0edU3vwSh+zsKJueIi8wkU7Y2earaGKdDg3xpr08qURZ/sS1XnYhdc4bde2gV6cdmaQ4FoJaHZtlDW3amtyKpsRgh/f4+1/I0JMr7esmKExizhm+micKidGTihkS+npf/VcfuihNVgNq5f8PXDSh6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XllvOjya/7tVBuqu4C4KLFEiRLbqjpnmsQmoO8VcknI=;
 b=MWPjA7JZv4APDKy3Z1XEe7AaRglLw/sggLnrs1vk6SGy8gfBcS7ymyhdLGIlnI1VZtsuobfd1EC1DmaVwcaoDVRFzXUH2mJXvPFI4i8VnxAd5pdOolXoYS6pZuW/kmA7J4bu3/N3q6k77HjwuoCcerqeLAR9tyOvWn0Z31MN+KtffRD75iXByqyITFiC5fdqEEqpMZ+UwRxISEoXMnKdHUJrS8OBJCH6mMakABa2BVoW2ADwbRURO+KJ6FhiBTMuSyY7rh4+o1PtYsnr6hWZOr+Tl0Ulrz7JLEP/Dp1DgdzDpMVzRH3A90woQrWhFfFmDfyA2F80MO3aJxbicAlO7g==
Received: from CH2PR15CA0005.namprd15.prod.outlook.com (2603:10b6:610:51::15)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 13 Feb
 2025 18:02:58 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::61) by CH2PR15CA0005.outlook.office365.com
 (2603:10b6:610:51::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Thu,
 13 Feb 2025 18:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 18:02:57 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 10:02:36 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 10:02:36 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 13
 Feb 2025 10:02:31 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Jiri Pirko <jiri@nvidia.com>
CC: Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Donald Hunter
	<donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
	<corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [PATCH net-next 06/10] devlink: Allow rate node parents from other devlinks
Date: Thu, 13 Feb 2025 20:01:30 +0200
Message-ID: <20250213180134.323929-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250213180134.323929-1-tariqt@nvidia.com>
References: <20250213180134.323929-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|BY5PR12MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf7768e-7691-4657-a796-08dd4c58a5de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SbCReYfU2nrcz8H4HLlHFIO6ar8vEVlgXNTaMBeukChkDf7eE8Wgi9fwihCm?=
 =?us-ascii?Q?rB/6oba49NPo5mLKrNhfq/bLo4kH0Oxbuqt1JXkV8cNvj7JGKD7sFmLmpCoJ?=
 =?us-ascii?Q?6a7YZ3I5CZLn5NcVLl7rnaHlfPLm1Utc5PMg91s9nddDkqKrg0QhJtYYNNLv?=
 =?us-ascii?Q?OnsejSEAB57s+H+JXp4IqpiYfWhj45pKPHKmBvVjFW5K5ck6OY6W7uLC5jjo?=
 =?us-ascii?Q?RgRe2abJyfrkUJkNUvUD/7gad/Sh58aa1nJtxKwaREFfLpIOpExMygKxTPwc?=
 =?us-ascii?Q?0ALwcFvIGWPZjIHJzAo29fge+BvsQ4UwCqf6BHsim6KW3+0z+oM8/3sOni1w?=
 =?us-ascii?Q?3UvvtjIIwEnJWqstr3UBlhzzti/3J2ZoThJFVXKQDmsHmP59+7aRNcetNkbr?=
 =?us-ascii?Q?KGU34Jocr1G8N0vNTGKfykcax6SwaaVtyDQ5+/RWGihpDQW68/yBuNrrEmvb?=
 =?us-ascii?Q?uAy30eIWX/JJbx9T+3X7M/UyrJ4QExz9wKX4mBD9kR6RViefwa793nzM1Hv9?=
 =?us-ascii?Q?/n+hnXs63rLssv/oRU/415UJz4tN0WCKNk4H2BEA1rYglQO/KuRq+pc1HB/t?=
 =?us-ascii?Q?h+jJI2vX2Hv9LYpKYuVKVEvQuKgGSLNDml/H9pL6fCBtoj5FhUALI/9zaZ+G?=
 =?us-ascii?Q?+dVYesN+vokW8L6WEFheqsfmmr83RA9qSfKeyJrH5JwDxa8ZzjaeFANvQ+aK?=
 =?us-ascii?Q?oeVnYJMswSaAQNtpE/3V29IPm1JiwrB3jOTOMdJkqh37rc9xCUODBl5OU+fW?=
 =?us-ascii?Q?YeK7UFUZC2exDx80P6PvPGGFjkQyWiuAJhxRM/RkItdHOW2c9VwvmjqDGilp?=
 =?us-ascii?Q?1V2Qs5tFJQz9LvA3WcG3f1jwmdI8WEbtl2Z+L9j14e1T8wsYoiZUVFgLpBV/?=
 =?us-ascii?Q?kzghaxUTAza5x95dypyn0yRVTKlciaQYH9/ILVtebKR88ZFT7YLO+Xr5yd4N?=
 =?us-ascii?Q?KrWwg/NcTdYfXV4tX5ZK6VH4DWaHWTsTlCsQ2yimyiwZQA/RDJPO3zRYSvvP?=
 =?us-ascii?Q?xZxGVUiLsAKc+8Fn1X/Ze2hXQs+ROoc55C6wb4t4jI2yeKqDMvq2NY1F5beY?=
 =?us-ascii?Q?drwlKgulPM/3V5GHRUDTTGanVjX4fAkqpkt6FSDas5nYI3bUuar89Ar/cX/x?=
 =?us-ascii?Q?mD5gc9lL4MotVOOlXGBmJtm0NgG45JEO/paIddMQrrZnRWrDD6VLadDRwL98?=
 =?us-ascii?Q?v5PWHPwGLlTuV51NVQzF/xKvi/rm5hkaTr+vqaJBPj7UwhwjaCtqQ5YM9Ph+?=
 =?us-ascii?Q?CX1wWAg40FDTUP00+qKtl0iZXSxUXKtMotw5PWTmPOruggcA+jtEErdNnSdV?=
 =?us-ascii?Q?wzdfRrK9RtsHCoUkiiFolSZCnitDZ7XR8hQqnXnEZboILkayrHYebnKCwZVe?=
 =?us-ascii?Q?jY/PIrMzNhlyhrdxgCJQRlEUsbid70nGkElRLEPWU1gEXo4QTctZEumIpQ+O?=
 =?us-ascii?Q?rMbHUJXsXrqWBt2uYeT7c0UAxIWUo4VoG7uUn8JuqAdBtRHifPzc8w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:02:57.8425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf7768e-7691-4657-a796-08dd4c58a5de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162

From: Cosmin Ratiu <cratiu@nvidia.com>

This commit make use of the unlocked parent devlink from
info->user_ptr[1] to assign a devlink rate node to the requested parent
node. Because it is not locked, none of its mutable fields can be used.
But parent setting only requires:
1. Verifying that the same rate domain is used. The rate domain is
   immutable once set, so this is safe.
2. Comparing devlink_rate->devlink with the requested parent devlink.
   As the shared devlink rate domain is locked, other entities cannot
   concurrently make changes to any of its rates.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/rate.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 38f18216eb80..e6b4f4cb8a01 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -125,10 +125,26 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
 			devlink_rate->tx_weight))
 		goto nla_put_failure;
 
-	if (devlink_rate->parent)
-		if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
-				   devlink_rate->parent->name))
+	if (devlink_rate->parent) {
+		struct devlink_rate *parent = devlink_rate->parent;
+
+		if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME, parent->name))
 			goto nla_put_failure;
+		if (parent->devlink != devlink) {
+			/* The parent devlink isn't locked, but a reference to
+			 * it is held so it cannot suddenly disappear.
+			 * And since there are rate nodes pointing to it,
+			 * the parent devlink is fully initialized and
+			 * the fields accessed here are valid and immutable.
+			 */
+			if (nla_put_string(msg, DEVLINK_ATTR_PARENT_DEV_BUS_NAME,
+					   parent->devlink->dev->bus->name))
+				goto nla_put_failure;
+			if (nla_put_string(msg, DEVLINK_ATTR_PARENT_DEV_NAME,
+					   dev_name(parent->devlink->dev)))
+				goto nla_put_failure;
+		}
+	}
 
 	genlmsg_end(msg, hdr);
 	return 0;
@@ -281,9 +297,18 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 	const char *parent_name = nla_data(nla_parent);
 	const struct devlink_ops *ops = devlink->ops;
 	size_t len = strlen(parent_name);
+	struct devlink *parent_devlink;
 	struct devlink_rate *parent;
 	int err = -EOPNOTSUPP;
 
+	parent_devlink = info->user_ptr[1] ? : devlink;
+	if (parent_devlink != devlink) {
+		if (parent_devlink->rate_domain != devlink->rate_domain) {
+			NL_SET_ERR_MSG(info->extack,
+				       "Cannot set parent to a rate from a different rate domain");
+			return -EINVAL;
+		}
+	}
 	parent = devlink_rate->parent;
 
 	if (parent && !len) {
@@ -301,7 +326,11 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 		refcount_dec(&parent->refcnt);
 		devlink_rate->parent = NULL;
 	} else if (len) {
-		parent = devlink_rate_node_get_by_name(devlink, parent_name);
+		/* parent_devlink (if != devlink) isn't locked, but the rate
+		 * domain, immutable once set, is already locked and the parent
+		 * is only used to determine node owner via pointer comparison.
+		 */
+		parent = devlink_rate_node_get_by_name(parent_devlink, parent_name);
 		if (IS_ERR(parent))
 			return -ENODEV;
 
@@ -762,8 +791,8 @@ EXPORT_SYMBOL_GPL(devl_rate_leaf_destroy);
  * devl_rate_nodes_destroy - destroy all devlink rate nodes on device
  * @devlink: devlink instance
  *
- * Unset parent for all rate objects and destroy all rate nodes
- * on specified device.
+ * Unset parent for all rate objects that involve this device and destroy all
+ * rate nodes on it.
  */
 void devl_rate_nodes_destroy(struct devlink *devlink)
 {
@@ -774,7 +803,9 @@ void devl_rate_nodes_destroy(struct devlink *devlink)
 	devl_rate_domain_lock(devlink);
 
 	list_for_each_entry(devlink_rate, &devlink->rate_domain->rate_list, list) {
-		if (!devlink_rate->parent || devlink_rate->devlink != devlink)
+		if (!devlink_rate->parent ||
+		    (devlink_rate->devlink != devlink &&
+		     devlink_rate->parent->devlink != devlink))
 			continue;
 
 		refcount_dec(&devlink_rate->parent->refcnt);
@@ -784,6 +815,7 @@ void devl_rate_nodes_destroy(struct devlink *devlink)
 		else if (devlink_rate_is_node(devlink_rate))
 			ops->rate_node_parent_set(devlink_rate, NULL, devlink_rate->priv,
 						  NULL, NULL);
+		devlink_rate->parent = NULL;
 	}
 	list_for_each_entry_safe(devlink_rate, tmp, &devlink->rate_domain->rate_list, list) {
 		if (devlink_rate->devlink == devlink && devlink_rate_is_node(devlink_rate)) {
-- 
2.45.0


