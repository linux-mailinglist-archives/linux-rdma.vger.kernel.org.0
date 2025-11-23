Return-Path: <linux-rdma+bounces-14692-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C28BC7DD2C
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 08:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 798E5353130
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 07:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494222C158E;
	Sun, 23 Nov 2025 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZsZrJqI3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013013.outbound.protection.outlook.com [40.93.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EACD2D1914;
	Sun, 23 Nov 2025 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763882654; cv=fail; b=eD0aVdhQrkRbNDduzicum7sIWfeUn5yLtI+QBh0leEYrQwlBhQ/+YCuTiu/VNjI5PVMIDLOb3jXP0Nj03eByzXjB1PtpfuwI4F3Z2y/BTnjzG+MNRdv9nirTqK0BNxQpHIregfszbOv4p7UYjgoV7AmQ//K2oeg8BRIq2f0vuZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763882654; c=relaxed/simple;
	bh=j+JpDB8lrUITToa6HtXVUiQKkYMS06iYiub1LMNjBWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epsQHFuQXLMrAqnMlZquNN72ByzrKPBnI/iBs7FOh4exyW13ZKhv5wGMO0R1zmUcOGm7PUrQD1iq0IpsGizZCDIBNj9rYaPhmbIyEcSeRXpsXlDSrzzn/q7OhKz/HEVOQ6XTGGjRvLKkAgNK37GElcWc+G1FIdy9P8bsswbyHYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZsZrJqI3; arc=fail smtp.client-ip=40.93.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRp9U6NrFNMVtjCPetxFeIhUqF4fJwBHh7sV90wsZq7EoiM85ffyLgc+jv7RJACOmNEBN8sU7ZFXKz2dJqRIAmxKQc24EaQvv/TXKfrybxP/1fHfrYRr29NWnxuK0aAc0ZIDzsyLio7elMfMGRM7oX07eSk8SVjLj+YMsZXray2jsPq6gqlAlAiNCpI2nWVH05tTXlY810tp+rEzopEPBcgVm6iXCv8eLkobm0y/T+iZuhD/NOX/C/SENi4iktQ4mfwGwUKEX2u2Xh9nnTaBUj1l25IJV+1Nm55YjdB8WoeZW9JMbmA3GvtCTQNvJvrFn523vQiGYiTfDJO5Ko4c7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7MGL78J8w1FDJhYk01+ZTwT+lZwV/itnX/hL3p0kBQ=;
 b=TY5w2XV7nq82MGzgCkrANVBX0/tDOoncbQDr5I2oZwh1Uy3sBAX7iMPqCJfDs1dfT4l+Rei+YMcV/Hl97FjefZW+X1hi0aQV60/orxITLSkyxzu9H0njY267Jo+3IVVfqaW2+Pf5i3L33lNfdytt5fXJbbK1O8L+HHLo6EhWkXanAkA42RtUezinVSKVnYyoOv3OapRiGLUC9aDNtnkczA3Ne1D12DfkxauuKub8IpmVWjg2hSO6ncgYJuI7K1f3pl30wXoCbboXNb7CIt6tfSodis0SuD2SmUswWfsUHhAphZUQnJGmshiXt/2EiqqZbwsiQVOKvVTTn8IqIZIODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7MGL78J8w1FDJhYk01+ZTwT+lZwV/itnX/hL3p0kBQ=;
 b=ZsZrJqI3IL7B1iGTjO16sQkI+i9LpL/R1ZcFc75evuk3d9/fBEHg+OGO0dPYTJh869Vugwmx0lqdYFFoDOAjcMDlYhUdC7yKUeL2K1/RzW1NPGY5iNLl7vbeOfiUVmWDN4AvgNDOV7x3dlGnK6IGD4CktG0V9Wjtr8k+IJiz1P4KigIeTmkiO6+im9aQdRnFSl4q0NsAx9dujJmp/w9IyWop9Lb/m0YOP7NJ463XmaFa9oH3qc6xFRI5I1mRxr9fag/qJRS5UGFknra5wityZIv2/tKdLD3iZLqVKzPcio1RQYzuwMBF31+sOeUsvN4yf3RcVaa6N07tVhIPRdtd1g==
Received: from PH5P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::6)
 by PH7PR12MB7308.namprd12.prod.outlook.com (2603:10b6:510:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sun, 23 Nov
 2025 07:24:07 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:34a:cafe::4e) by PH5P220CA0008.outlook.office365.com
 (2603:10b6:510:34a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Sun,
 23 Nov 2025 07:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 07:24:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:23:55 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:23:54 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 22
 Nov 2025 23:23:49 -0800
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
Subject: [PATCH net-next V2 07/14] devlink: Allow parent dev for rate-set and rate-new
Date: Sun, 23 Nov 2025 09:22:53 +0200
Message-ID: <1763882580-1295213-8-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|PH7PR12MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: cd71e4d6-237e-45bb-a29f-08de2a6149be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4uaVownBJs2XkFx+SPJuqqTBqDRwa1Sk+1BMQfSkKiUa/MZQLzpqr2uM9E5Z?=
 =?us-ascii?Q?KGy5l15iUnAPxI6jC0us5pdsPHbsACtNFWcmCyIjvuMdrIQpRrpCAaOsMXLg?=
 =?us-ascii?Q?6fAt0Q6JstnnFSdTWQ7bx4RQATsVYg2IFGUq6vfEijlVGxgUdXXYMcN4bLAq?=
 =?us-ascii?Q?sAII9wSQ/lcELFcG/rKNqWYJAkZbRbxC1EfD1NjkRrdoj/4hP3fgD3tjIKuc?=
 =?us-ascii?Q?EKsa4dxax5JZeziwD8UPT9tRF6DHksm7vaF9gI/JN4D01dJP5IGjxm9E0nSL?=
 =?us-ascii?Q?mjUw6VQ54QgTY/ujCFfSDTuAfofMJIFzizfR8mZE9AAHwHML13uVwZHWMMY6?=
 =?us-ascii?Q?VS/rvSAZEmpE/tGfmA5fcXf0xfDldPuO+q+15giAI+QRuCM+SN6UWbFnbym8?=
 =?us-ascii?Q?ZSt7JwYwGXZ+3oTXabSsZ49KCSzG2ymxkUD8eAYKEvopMIqGRZouIzvLTLRI?=
 =?us-ascii?Q?Qn4lRswkTARyxwEh+auQ/Uy1haiCWim23IRM+shfhss6FR905LmmpjXUKl0O?=
 =?us-ascii?Q?x92c5iE0Hv7P2lHZPrRykJqJ+ULkLi7S9wE4M8VKMIAH2DRGQzfNUgHegYwp?=
 =?us-ascii?Q?5RmNFqD/3Mgjt+0LmrkbcNDiOfZIxNQmpj+h80B/kxglj1GKL4DJu+hga9PK?=
 =?us-ascii?Q?GNmy/sl0i5SQZBm1LCk7grTpigVx8qA/ztRE7mQOv/cuNC/5QeT0iSoo7m8F?=
 =?us-ascii?Q?2WvlWhN2wpPOxdOuFze3/A0BsAv8qvRjOZGfl6VCSEWIcBvJzkeVQ0b9C+E8?=
 =?us-ascii?Q?CcV0jnw7FFAtrAhsa2+556JDUVdc6ULwLlHNF5FfZEhTo9zh9ZjHD5YSUr0E?=
 =?us-ascii?Q?gyPZU0kKKEABL6qmPIz4FoiIyZlLeFguc8VvfoOJhLBrbq5vUGqAxg6W1ELp?=
 =?us-ascii?Q?nlW8G/G9xG4ymVbeMY5cXcxPSbx3BcPMBIEj8sJDr/W9g3cQS3I4R0W4SniI?=
 =?us-ascii?Q?V6gi3WOeend4dfyX/mFmjsdLQUqdJoNYmsC8KDG4yrjo3AI6Q/4OSn7t80mi?=
 =?us-ascii?Q?QxVJpqYZ+e+WkDJqeuvsemFZxoxRR/lsHnnCWnIFvZm7BQV7t39i/IxahdcR?=
 =?us-ascii?Q?ZrNqieK+LMdzhYXNx+gTkj4TBaM0nlfq/++Hp8C71c6u76uRWlsIPevAtJX3?=
 =?us-ascii?Q?6MHseLkWTx3Fzp1kYaAoypwPO24Zmvkquvk1cdGPrhK+1DgkzOfJ86FZ0g0o?=
 =?us-ascii?Q?lnNyT5iTWmSw/KQySRpEeOHji5ESryYrN5PxXZkFNjwQgz+fHLnYAvldLPGE?=
 =?us-ascii?Q?PQEUBC+1bYpzuJznCAYI5/SIZyuZmavDYobS0RSQEfEOzt4MWlRYbSveA/g7?=
 =?us-ascii?Q?2AydyGqTLp5/Pu2/DcHejmT9wPnGneYTiOxDEZva0YS9A3FqQAMnHGxmy5Q7?=
 =?us-ascii?Q?7ijMT6VK9ff1uijpGYtD3RqdYIFH/INW49nouCunXTC0WWrBdhHQdNKT1aCU?=
 =?us-ascii?Q?MAYrNs5CMP5S9GrZD5gGWaBrq6D33MaV0y7B6bA7+s1yohKVQe6lZ0E9Qu2c?=
 =?us-ascii?Q?qbq+pgoRhUUckcAZk605Ko7DjBIUILx1d6M7x2EnudkzfjRSo2LWS01F9V1H?=
 =?us-ascii?Q?QsddzHgvXy/CebvnYjw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 07:24:06.8944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd71e4d6-237e-45bb-a29f-08de2a6149be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7308

From: Cosmin Ratiu <cratiu@nvidia.com>

Currently, a devlink rate's parent device is assumed to be the same as
the one where the devlink rate is created.

This patch changes that to allow rate commands to accept an additional
argument that specifies the parent dev. This will allow devlink rate
groups with leafs from other devices.

Example of the new usage with ynl:

Creating a group on pci/0000:08:00.1 with a parent to an already
existing pci/0000:08:00.1/group1:
./tools/net/ynl/pyynl/cli.py --spec \
Documentation/netlink/specs/devlink.yaml --do rate-new --json '{
    "bus-name": "pci",
    "dev-name": "0000:08:00.1",
    "rate-node-name": "group2",
    "rate-parent-node-name": "group1",
    "parent-dev": {
        "bus-name": "pci",
        "dev-name": "0000:08:00.1"
    }
  }'

Setting the parent of leaf node pci/0000:08:00.1/65537 to
pci/0000:08:00.0/group1:
./tools/net/ynl/pyynl/cli.py --spec \
Documentation/netlink/specs/devlink.yaml --do rate-set --json '{
    "bus-name": "pci",
    "dev-name": "0000:08:00.1",
    "port-index": 65537,
    "parent-dev": {
        "bus-name": "pci",
        "dev-name": "0000:08:00.0"
    },
    "rate-parent-node-name": "group1"
  }'

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 10 ++++++----
 net/devlink/netlink_gen.c                | 18 ++++++++++--------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 1f41d934dc5b..bfeacfcfdf9e 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -2217,8 +2217,8 @@ operations:
       dont-validate: [strict]
       flags: [admin-perm]
       do:
-        pre: devlink-nl-pre-doit
-        post: devlink-nl-post-doit
+        pre: devlink-nl-pre-doit-parent-dev-optional
+        post: devlink-nl-post-doit-parent-dev-optional
         request:
           attributes:
             - bus-name
@@ -2230,6 +2230,7 @@ operations:
             - rate-tx-weight
             - rate-parent-node-name
             - rate-tc-bws
+            - parent-dev
 
     -
       name: rate-new
@@ -2238,8 +2239,8 @@ operations:
       dont-validate: [strict]
       flags: [admin-perm]
       do:
-        pre: devlink-nl-pre-doit
-        post: devlink-nl-post-doit
+        pre: devlink-nl-pre-doit-parent-dev-optional
+        post: devlink-nl-post-doit-parent-dev-optional
         request:
           attributes:
             - bus-name
@@ -2251,6 +2252,7 @@ operations:
             - rate-tx-weight
             - rate-parent-node-name
             - rate-tc-bws
+            - parent-dev
 
     -
       name: rate-del
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 8fbe0417ab55..91d2c9b69391 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -535,7 +535,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_PARENT_DEV + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -545,10 +545,11 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_B
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
+	[DEVLINK_ATTR_PARENT_DEV] = NLA_POLICY_NESTED(devlink_dl_parent_dev_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_NEW - do */
-static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
+static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_PARENT_DEV + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -558,6 +559,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_B
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
+	[DEVLINK_ATTR_PARENT_DEV] = NLA_POLICY_NESTED(devlink_dl_parent_dev_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
@@ -1201,21 +1203,21 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 	{
 		.cmd		= DEVLINK_CMD_RATE_SET,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.pre_doit	= devlink_nl_pre_doit,
+		.pre_doit	= devlink_nl_pre_doit_parent_dev_optional,
 		.doit		= devlink_nl_rate_set_doit,
-		.post_doit	= devlink_nl_post_doit,
+		.post_doit	= devlink_nl_post_doit_parent_dev_optional,
 		.policy		= devlink_rate_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
+		.maxattr	= DEVLINK_ATTR_PARENT_DEV,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_RATE_NEW,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.pre_doit	= devlink_nl_pre_doit,
+		.pre_doit	= devlink_nl_pre_doit_parent_dev_optional,
 		.doit		= devlink_nl_rate_new_doit,
-		.post_doit	= devlink_nl_post_doit,
+		.post_doit	= devlink_nl_post_doit_parent_dev_optional,
 		.policy		= devlink_rate_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
+		.maxattr	= DEVLINK_ATTR_PARENT_DEV,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
-- 
2.31.1


