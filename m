Return-Path: <linux-rdma+bounces-14644-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 642B4C74231
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 202E135DC53
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 13:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2E733D6CC;
	Thu, 20 Nov 2025 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i/KqD6Kp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6AA33CE8C;
	Thu, 20 Nov 2025 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644457; cv=fail; b=LOIrhK9qM0JB2jXi/U+TAinTxhiqOWB3s2zHCTGnp99PS7H1kCGy0VUf6QBDXZ4lnhvFV/ZM3ndnA0yhPnzCGrgBlRSdU6boDp/x7rSENAYr+smbkeVk/Up3ewZVd9+6Ton6zGYg+zmZVwiYzNOhtk8jZsmsLakPB+1J/3ErGLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644457; c=relaxed/simple;
	bh=MbVxho+XCYBx7CG5kRU+tO+bYkWV7BVFVzfwHTZUZEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cncGqNUitXbk0a4GgjZ34fObpPwGo4s53dcC/nVXlIHwdp35Ddh7moqImEShQd/ZxKx4fmrrAzkjlXuXPPHlbwjvw97ShhxWIDRmI+eFgv1+xb76DxYLguDgifwvRF++LZTfgW16oLaJ/ee1hQUndWMHquNTnxf5rvXcy/tEhc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i/KqD6Kp; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZJ5CbL5Ww2qOrmEVr828uHi9nNGNpYztiY7xyHlDfbNHqXHTxFjjp0576kYqizBzwe7To+3SMG4yvoCBZPcxAGkY6aAt3FkNd6si9FzJ2Igxoe2Q6qBr8Z3lXYAh0xQC806tr5SEukdRYg6SuhhdkEck06wLvVJn0IMgD+E8WSuouVf4ZtMOW9GZ7aF56esUO6r3eY2cNTIvBTYW//mrJ/mIO3yzwIKjL2OKaJqoBavBUQD9eZmlmI/A5Z11OeWrAnDbM4O41Nd08A3KtBK6gKzDMFp7VQwbWwvOcSBgCmCHL3riavmWCXf7o/muui/RG1ZYHgJosNd+8wwQghARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYwTR48nMUCfz5qL3U1kzqd/wypSf0QN/aHbJzu+36g=;
 b=vkFUx14JNotfn9e5AD2DjGUoXCtjWQBnMBlApHwHnRuz9ZQKM3NQINsHy5qW53lECb2qMFHXtOaRy8hP4VZcrwyz9/Ucc/Lw7+qH4MuIofBMXltv8Wfe9zlwnO+JFtdq5RxkUaarlGg9XFGdc/SNBkg72hf8bmMqWUX783jlsNah3B2aPtCCcXEMt1fGA875RPs3T8NHLZVGjfPyEVniVN4aFw6gXqAbYCt4GvHOagviqNreGmvF7sfVPSyjvDnw7G8TxXmXRyH4eMzbHA1cv8eMJNfabFyaTvT4ooegAR0NHqRH/BJ5gZuCuu3eHygUzjYMdIclxC4I35neuwg6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYwTR48nMUCfz5qL3U1kzqd/wypSf0QN/aHbJzu+36g=;
 b=i/KqD6KpTxXgQWDPumtc4gJ72A6Xu2oJa4VoeX9HyOhqbhpaqS4sQYFoHfzatF9RQzLPYpczclpaIsgf5p0hTlfOiZKnAtdfXSUR6sgZf+KA2yUmV0xkRNO1rjBTE7A+87aIIzAOePC63+TgGFLIzDSxpg7FrhkmhsOZhzEcujoTLqZnncxUffB9tzLP2L8dnF5xHojnmHxL83SZCAL9KX+ZoHbN+64zTEpyimXvsBj3HGj3XmluCbzx7jyB3M2yNALzkRPOeUrRiGICRi7OdDtOP9jGShRqtRO/Lm1m0YkEu1RRfEGq7cDkY8dKHRJmLO9mpryOX2zTCvmiwtDzrg==
Received: from SA1P222CA0129.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::9)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:14:09 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::74) by SA1P222CA0129.outlook.office365.com
 (2603:10b6:806:3c2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 13:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:14:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:13:53 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:13:53 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 20
 Nov 2025 05:13:47 -0800
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
Subject: [PATCH net-next 07/14] devlink: Allow parent dev for rate-set and rate-new
Date: Thu, 20 Nov 2025 15:09:19 +0200
Message-ID: <1763644166-1250608-8-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a925f7c-f239-4f88-52c3-08de2836b114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aTMMPLCOLnnaSID42q93vFGdYyKYFkd6BqmIP33eUwkZZ2L7s3M/z6b8bYhs?=
 =?us-ascii?Q?AtvgWpOS+Mi/ZtN3PTXopDBkPSs7qAvKM7UzPYZGQnVgMeLxkDNVEFSUWMjm?=
 =?us-ascii?Q?ROyFH9AJFqj+PzP38pktnWiqzAA4wWdUnIXOU+2Yt7cQjjp/O6z8tEk/G8az?=
 =?us-ascii?Q?HhsPiZV1xmobtCVsDCrz9PCDdkjtK0Y2igcRJxeJlbtlDfRsFGMaCGN6Uayd?=
 =?us-ascii?Q?Fx2Ben84lKccNetyVEW//OQc/Ot5NvcBGICj2tk00opna8DQPz8xheOq//Jz?=
 =?us-ascii?Q?3M4c3KtCCo7WuSQip0ehojRYrrltCoUnjDZH9H1R910Zw+m5nkd+ytod+spM?=
 =?us-ascii?Q?/RII/zCFAACIVbWG3RWYEwpni7HoazWHKUMphjCIuFfjw4OydQy+/MKvy5tw?=
 =?us-ascii?Q?bYBevmYy+B1wK0+Hy44qNhmr4bQxgXDtaL1YuTY2V44EbQqD83wgrpzwpQ0t?=
 =?us-ascii?Q?8kvlSMFuKAVICrX1xr2M95FXb+UbdIrve9fqU98gnvmrz+myckHT1svhl5ZE?=
 =?us-ascii?Q?rHjWB+XkbeHK3VUBHuz5Ut83O6Esy2ZXoA/UBF5ipaSaAEYmCvrrT05RtJQn?=
 =?us-ascii?Q?N45JMqFBmYAMsn/dMzzWTwIM7cRtWsYYQfINRbnVg2Zj2fo2/czYAx9gZvDG?=
 =?us-ascii?Q?c3K/HqQOOq2in/85bGyta/X0fWN0Sfnm9Mtz6UpjuYnxYDLKDptXzwSzoXE1?=
 =?us-ascii?Q?hiUKWHnT7NZxgLrc1zLG6YYrOn3juLKKnO9raZWX9BktsPoOIrM01ZNHrGhL?=
 =?us-ascii?Q?R7fsr4UDObhzFTSZObShZjQ3sIspuMtqTuz/vAvt7wLn+iJ+zl403GcMNVLI?=
 =?us-ascii?Q?Pvs8ztzoUzrQEWOpNGlmeftNJy2HCMUaek/4BeuN+tTynxrszLUn0srqj6xM?=
 =?us-ascii?Q?V6xK6pvo6PrHZVQ/GKiPs69D7c/sSbmvmO/oMlEn/2/PTJLTjr+aUV+PNlPE?=
 =?us-ascii?Q?4FI9PbsXqVICCoNXn2P+FOInj21yYYarduvdj/TnVVNXQslrjNsRgGKrdN6B?=
 =?us-ascii?Q?TomlavnO9FJ1bYcIKTApOt2FFoTkSy/zPzPSrbNkUbbRtO9whOzs5+JUPpu3?=
 =?us-ascii?Q?WWbLHanshd2L9igjCzN1ocXSm2l8C3VDI1V4DUOAw3qwzH3kvN8YNd8YXW72?=
 =?us-ascii?Q?DH3dgRP3n38zZa+azHMPdPWtODSi0k8FejpO8t1EKPP3QMCpcm924boHoB5t?=
 =?us-ascii?Q?3X4oFe1cHNBHF5XDOKG/tGBQqjNQtpvJDZPsSq6BNpap7INQl2t0yJBlTx9G?=
 =?us-ascii?Q?+6QOJpj1vLH4gTnNt81ziCVx5ODU9JXoKsAP0snz6giqlBUHIgVE9OPBV6z8?=
 =?us-ascii?Q?eWlIsrpVVioqPUXz/tgy7/KT/v3DczTANyD31LfON0iteWzRO/5cDFNt2Mdc?=
 =?us-ascii?Q?E/6CkQmWBfuMUcErk75OibyHwasDF8e+2bxpqwUFsRU6EFyDSvm9lRGAZubI?=
 =?us-ascii?Q?/Zlh0Kiv8YM5OOIjYoGwqr/q+g+wwNMgSdkyV3y+FPXKyubSdPM7Kt+lic36?=
 =?us-ascii?Q?YDvBSi2JZWaCMlP+lfy+QVmiqdP0i5bpg6HZovCbe2RGQUnW+NsTbHtmRa1z?=
 =?us-ascii?Q?oCC56Cvl4rJfg223naI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:14:09.6050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a925f7c-f239-4f88-52c3-08de2836b114
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146

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
index fe49acd2b271..9c55e6ae9547 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -2209,8 +2209,8 @@ operations:
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
@@ -2222,6 +2222,7 @@ operations:
             - rate-tx-weight
             - rate-parent-node-name
             - rate-tc-bws
+            - parent-dev
 
     -
       name: rate-new
@@ -2230,8 +2231,8 @@ operations:
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
@@ -2243,6 +2244,7 @@ operations:
             - rate-tx-weight
             - rate-parent-node-name
             - rate-tc-bws
+            - parent-dev
 
     -
       name: rate-del
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 3cabbc1207f2..73a6441da7a2 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -534,7 +534,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_PARENT_DEV + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -544,10 +544,11 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_B
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
@@ -557,6 +558,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_B
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
+	[DEVLINK_ATTR_PARENT_DEV] = NLA_POLICY_NESTED(devlink_dl_parent_dev_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
@@ -1200,21 +1202,21 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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


