Return-Path: <linux-rdma+bounces-7744-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C99A34CDF
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 19:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ADA5188FFED
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5898924292E;
	Thu, 13 Feb 2025 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uL5O9YoB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170DF24292A;
	Thu, 13 Feb 2025 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469784; cv=fail; b=GVSNGu4pYsABaINJ10zODFvHwyLycxj4stk8NSfzQ9D3BDTpc1dgTBBlZLBa5mvoVqUK6SXkB11S2ugqaagHKEWkTyHEsvBTofm/LOXnaiIsiDp0L1wvyafqHIdLRxmFjMXgf/1ENyzyk/GQWXUlm6HAqlCIUkB0cSVma1NNyaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469784; c=relaxed/simple;
	bh=l+RFeF98hsmYMyhj2o/mtfYeRC4Pf36QPGXocLJCtfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zjl+Bh1/SqxoJPWBhVGz4Anw9e2vBoWEsdjB+o+TS0rq+7OdeOLwlL21hlsLNrV6WMXmg08oHv0OlHjCQwMfNrzMN3C8uA95wSQaCjof76vsoULSNWeyA+xeIN65x+zKSBTNT9pccHS5DPVelsNTm051hQ28jyau8LaxK0eQPQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uL5O9YoB; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwCns3oFUmI78VKHkwBHyPMftqtba3luE+kKZ1Ap/VkwMJ0PZeW3wqwSdNhf4LvorD6yFahIrXqP6eZNpnEGentzFzILQQFhg2xhJfepmzc28CrV2+4gZKJkQksxEMc1IsSlF/S2cDWcujSp+pj6xwTZ4vh8jvO82zvOFbxxMrfIZpEVy+Eio+ufuhXaLwpMtXfcfJaT4vLenEI2a9QiOnnc+tecByN7k1Ao5jflDmGeD34sCdWTQ2NNOB3ie5D1vVSUoeIEYokaEPKDxd2ycODRtwt8POwsYec1fyCVptKetesIcKnliLGy6X6j4xgJdIHT18wR0ZGQiIWfiX7leA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJA9WmaQT0Jbe7DCedFA8gxyY0GJ5FGvLgzw/cKptEE=;
 b=ut9a1ci/kmCmqHz3UJ4XUJbiTPfre+j2hEkfOrcgctkgus2M+Odt+Z+l6GaLxK42Pv56lzwUqDjreFg3mNdwDsClQAO/hSSLgwUyx2ZQMoL/SwXhdr9ndcnacnn5hMkVTRdncZHv6NlyFcLskKUqREAma60D3UymB+B5MI1vCaemimMLKbakdbK5VpMxDXSZzlvSg3xaJ/4Ahc3Ay7QFHrLOgO71V9pBv+dmrjMeVBRMNCesOfLxPxyi9Tym3Vu8eFypqB23f07ifM0tslDxwjfjComsczbVwHVtnyRCwFx7GgBy9ooo4cThlpIZm5NmrGqlIHiPrPyHyzZNun3H4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJA9WmaQT0Jbe7DCedFA8gxyY0GJ5FGvLgzw/cKptEE=;
 b=uL5O9YoBo3Dcnuj8ivUaZldVRssOnAnZqWyR3E8nDv0r7+b6AYg/GaiMSdkApqkdQ//rEE+m0X3D/ee5iQZf9IZJo5J845DIcGOF/dlGBfm+y6tBVXFjk2XLCkwAv5ocX4vO5YMfgRhKGSL7WWy4LTdGEHHx/jI9d5l2XKXTJOSTlmuqBBynY/RfzSWigzPbYwqaA933oKrRHLnRp/jZBqX4ANyBsIHVIUi/abXTIxnHSFhaL1Gy2ChlhuUt1Bnix7DWGXEUOo+GgnWhx17az7dd7x7yp76+fKOlXfT7Pb0sdlcB38hkV7sXt4MCZa135AufiCg7hjVvb47XUYXtMw==
Received: from CH0P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::28)
 by PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 18:02:56 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::24) by CH0P221CA0011.outlook.office365.com
 (2603:10b6:610:11c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 18:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 18:02:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 10:02:32 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 10:02:31 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 13
 Feb 2025 10:02:26 -0800
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
Subject: [PATCH net-next 05/10] devlink: Allow specifying parent device for rate commands
Date: Thu, 13 Feb 2025 20:01:29 +0200
Message-ID: <20250213180134.323929-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|PH0PR12MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: f3dee10d-0891-4cf5-e822-08dd4c58a423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4jU0UaI0o2jH1u3lCC4U9glI9gRpmgf5ol8fBwhsEUCIEtiiHZEFj/dUUhLY?=
 =?us-ascii?Q?b28Lglw27+2uPQ366V6XBp2QbIJAqDftF+ozw0yWl9IlN7DeV/V8iRA6oEg/?=
 =?us-ascii?Q?JqdyPEAqL7NBKwHrNEEIHR/bkL39K2KNceO9ZTnZrzFE3AV3qczXV3WSiFZd?=
 =?us-ascii?Q?hJT08pvEAJKS73xrycnoTbXjvEvORxH1D000D/wUFkfxZYdgx3Iii/Eo/mV9?=
 =?us-ascii?Q?7WaZMW9aWhAhXNOujY9oFJRxdwiTLkSfs7KEDocJMVeeyqa0zz3g8tAasDpc?=
 =?us-ascii?Q?98n1+PWuWZmqomhxm3+ysCCOMD5LCbx8XFIx8shRpuoDSk7QIJW77eameM1r?=
 =?us-ascii?Q?oTItBP5m4ikjrlQnRSUAxLNcF22H6Uc3C4NN722N95WUOL00p2/tnWbsBlNc?=
 =?us-ascii?Q?Yxmw3zSWma3FJKQztpfz6rScWyk5yZrsvl4OEL57xzl6WTEuCIYs4fOQ4lWh?=
 =?us-ascii?Q?/ARtRq1BPfdiXSLNaJ1d52dO7hle9mJti2W0/h9eE3d3tHMXDw++EQF7ojIL?=
 =?us-ascii?Q?atD46KV0NCQ9c8k/sCSc59a/YF/TFzjjjymUrA4g9ZcAUzW99191D/D9ORpB?=
 =?us-ascii?Q?EQ+0RrTH/L2wgsy2wOGhOkPm7BeLpQTAgHH9xBzwp86OHNTU4MpmQZdUzn3e?=
 =?us-ascii?Q?p6v7O6HaP3N5hbcxgWPOrP7DOXUljtNqBEEPEDj971/YrUj5qXSJC5irf1bB?=
 =?us-ascii?Q?ysE0/2ZDNK686M/jK10a5yENOOAGRipp8Y3J2L6NQAnGNlXL6Zin1x4+qiLq?=
 =?us-ascii?Q?me5iqgRAklb6LaRmP29VnOBwduC/Q3kCotbA277nVMM4Bo2A46kgTzOYANwc?=
 =?us-ascii?Q?R6leSDvdulSfaSfTFEMictwETe30MFtRD0/tX9QxrbPDZlX4PJ8dGPrL2Qfz?=
 =?us-ascii?Q?j6Wjlgsj1OkITc8z/XHXlulw5whL8KZwECyFa+WTyzc37YKsdLdHjbFSHdAT?=
 =?us-ascii?Q?0qLCEPLMuhxqSs9aVsCO4zRBM0NWIpzFJn2osCPMPihrlgaleiEdHNgwe/uJ?=
 =?us-ascii?Q?tT9LhVpwWq9VizGm/f+fiW5Ibg2KJ7TiCdFAbkl7ZlX5jsjix6i6ZauJILzY?=
 =?us-ascii?Q?Io+Jf3htFiWD4ZviTs2egi8wCjaiGiG3pWMk+ua/jiqBge/2kpZX0hmGT7FK?=
 =?us-ascii?Q?x+v3pkhisD8qWkuc3lm+i/MBya8FqDNoRZbVMj8SgV08Uxs2xIkhiJmJX0C4?=
 =?us-ascii?Q?rwsASZUlWKNM7c8c/WE+WhNIQYweCKRLPBpDPIfCM88Z//ilvcXCq8/i46FX?=
 =?us-ascii?Q?W6utlvbJ52bjsS1XzGgUoxySPHoQYgYggadSTshHbbNUPWZhbbWZvkqFe4ml?=
 =?us-ascii?Q?MD8g6jy2uFl98AbD2al47drX2ExOUoMkRlXRgzP4SuEb0C3CF+TLSzidRL2V?=
 =?us-ascii?Q?fdp3la/B1gF2Sd0GNOzA529GzKaHyPHUeiMdMa9dJzNba7avQdsPIuuQsXlv?=
 =?us-ascii?Q?Y42TP6LgI9NH8p8qJMKZcZ+W3b2NGbnrTEYhq6XVcW3zlBaLib7x0bXQtpvr?=
 =?us-ascii?Q?RLpNA9tG5xthbQo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:02:54.9409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3dee10d-0891-4cf5-e822-08dd4c58a423
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080

From: Cosmin Ratiu <cratiu@nvidia.com>

Previously, the parent device was assumed to be the same one as one
owning the rate node being manipulated.

This patch expands that by allowing rate commands to accept two
additional arguments, the parent bus name and the parent dev name.
Besides introducing these two attributes in the uapi, this patch:
- adds plumbing in the 'rate-new' and 'rate-set' commands to access
  these attributes.
- extends devlink-nl-pre-doit with getting and saving a reference to the
  parent dev in info->user_ptr[1].
  The parent dev needs to exist and be registered and is then unlocked
  but not put. This ensures that it will stay alive until the end of the
  request.
- changes devlink-nl-post-doit with putting the parent reference, if
  obtained.

Example usage with ynl:
Setting parent to a rate node on another device
./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml \
  --do rate-set --json '{ \
    "bus-name": "pci", \
    "dev-name": "0000:08:00.1", \
    "port-index": 65537, \
    "parent-dev-bus-name": "pci", \
    "parent-dev-name": "0000:08:00.0", \
    "rate-parent-node-name": "group1" \
  }'

Getting the rate details:
./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml \
  --do rate-get --json '{ \
    "bus-name": "pci", \
    "dev-name": "0000:08:00.1", \
    "port-index": 65537 \
  }'

Output:
{'bus-name': 'pci',
 'dev-name': '0000:08:00.1',
 'parent-dev-bus-name': 'pci',
 'parent-dev-name': '0000:08:00.0',
 'port-index': 65537,
 'rate-parent-node-name': 'group1',
 'rate-tc-bws': <snipped for brevity>
 'rate-tx-max': 0,
 'rate-tx-priority': 0,
 'rate-tx-share': 0,
 'rate-tx-weight': 0,
 'rate-type': 'leaf'}

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 18 ++++--
 include/uapi/linux/devlink.h             |  3 +
 net/devlink/netlink.c                    | 74 +++++++++++++++++++-----
 net/devlink/netlink_gen.c                | 20 ++++---
 net/devlink/netlink_gen.h                |  7 +++
 5 files changed, 95 insertions(+), 27 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 09fbb4c03fc8..252db0f080ba 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -820,6 +820,12 @@ attribute-sets:
       -
         name: region-direct
         type: flag
+      -
+        name: parent-dev-bus-name
+        type: string
+      -
+        name: parent-dev-name
+        type: string
 
   -
     name: dl-dev-stats
@@ -2137,8 +2143,8 @@ operations:
       dont-validate: [ strict ]
       flags: [ admin-perm ]
       do:
-        pre: devlink-nl-pre-doit
-        post: devlink-nl-post-doit
+        pre: devlink-nl-pre-doit-parent-dev-optional
+        post: devlink-nl-post-doit-parent-dev-optional
         request:
           attributes:
             - bus-name
@@ -2149,6 +2155,8 @@ operations:
             - rate-tx-priority
             - rate-tx-weight
             - rate-parent-node-name
+            - parent-dev-bus-name
+            - parent-dev-name
 
     -
       name: rate-new
@@ -2157,8 +2165,8 @@ operations:
       dont-validate: [ strict ]
       flags: [ admin-perm ]
       do:
-        pre: devlink-nl-pre-doit
-        post: devlink-nl-post-doit
+        pre: devlink-nl-pre-doit-parent-dev-optional
+        post: devlink-nl-post-doit-parent-dev-optional
         request:
           attributes:
             - bus-name
@@ -2169,6 +2177,8 @@ operations:
             - rate-tx-priority
             - rate-tx-weight
             - rate-parent-node-name
+            - parent-dev-bus-name
+            - parent-dev-name
 
     -
       name: rate-del
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 9401aa343673..a7b62e53b7eb 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -614,6 +614,9 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
+	DEVLINK_ATTR_PARENT_DEV_BUS_NAME,	/* string */
+	DEVLINK_ATTR_PARENT_DEV_NAME,		/* string */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 593605c1b1ef..d8e7e23afce2 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -12,6 +12,7 @@
 #define DEVLINK_NL_FLAG_NEED_PORT		BIT(0)
 #define DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT	BIT(1)
 #define DEVLINK_NL_FLAG_NEED_DEV_LOCK		BIT(2)
+#define DEVLINK_NL_FLAG_NEED_PARENT_DEV		BIT(3)
 
 static const struct genl_multicast_group devlink_nl_mcgrps[] = {
 	[DEVLINK_MCGRP_CONFIG] = { .name = DEVLINK_GENL_MCGRP_CONFIG_NAME },
@@ -177,20 +178,15 @@ int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info *info)
 	return 0;
 }
 
-struct devlink *
-devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
-			    bool dev_lock)
+static struct devlink *
+devlink_get_lock(struct net *net, struct nlattr *bus_attr, struct nlattr *dev_attr, bool dev_lock)
 {
+	char *busname, *devname;
 	struct devlink *devlink;
 	unsigned long index;
-	char *busname;
-	char *devname;
-
-	if (!attrs[DEVLINK_ATTR_BUS_NAME] || !attrs[DEVLINK_ATTR_DEV_NAME])
-		return ERR_PTR(-EINVAL);
 
-	busname = nla_data(attrs[DEVLINK_ATTR_BUS_NAME]);
-	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
+	busname = nla_data(bus_attr);
+	devname = nla_data(dev_attr);
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
 		if (strcmp(devlink->dev->bus->name, busname) == 0 &&
@@ -206,19 +202,45 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	return ERR_PTR(-ENODEV);
 }
 
+struct devlink *
+devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs, bool dev_lock)
+{
+	if (!attrs[DEVLINK_ATTR_BUS_NAME] || !attrs[DEVLINK_ATTR_DEV_NAME])
+		return ERR_PTR(-EINVAL);
+
+	return devlink_get_lock(net, attrs[DEVLINK_ATTR_BUS_NAME],
+				attrs[DEVLINK_ATTR_DEV_NAME], dev_lock);
+}
+
 static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 				 u8 flags)
 {
+	bool parent_dev = flags & DEVLINK_NL_FLAG_NEED_PARENT_DEV;
 	bool dev_lock = flags & DEVLINK_NL_FLAG_NEED_DEV_LOCK;
+	struct devlink *devlink, *parent_devlink = NULL;
+	struct nlattr **attrs = info->attrs;
 	struct devlink_port *devlink_port;
-	struct devlink *devlink;
 	int err;
 
-	devlink = devlink_get_from_attrs_lock(genl_info_net(info), info->attrs,
-					      dev_lock);
-	if (IS_ERR(devlink))
-		return PTR_ERR(devlink);
+	if (parent_dev && attrs[DEVLINK_ATTR_PARENT_DEV_BUS_NAME] &&
+	    attrs[DEVLINK_ATTR_PARENT_DEV_NAME]) {
+		parent_devlink = devlink_get_lock(genl_info_net(info),
+						  attrs[DEVLINK_ATTR_PARENT_DEV_BUS_NAME],
+						  attrs[DEVLINK_ATTR_PARENT_DEV_NAME], dev_lock);
+		if (IS_ERR(parent_devlink))
+			return PTR_ERR(parent_devlink);
+		info->user_ptr[1] = parent_devlink;
+		/* Drop the parent devlink lock, but don't put it just yet.
+		 * This will keep it alive until the end of the request.
+		 */
+		devl_dev_unlock(parent_devlink, dev_lock);
+	}
 
+	devlink = devlink_get_from_attrs_lock(genl_info_net(info), attrs, dev_lock);
+	if (IS_ERR(devlink)) {
+		err = PTR_ERR(devlink);
+		goto parent_put;
+	}
 	info->user_ptr[0] = devlink;
 	if (flags & DEVLINK_NL_FLAG_NEED_PORT) {
 		devlink_port = devlink_port_get_from_info(devlink, info);
@@ -237,6 +259,9 @@ static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 unlock:
 	devl_dev_unlock(devlink, dev_lock);
 	devlink_put(devlink);
+parent_put:
+	if (parent_dev && parent_devlink)
+		devlink_put(parent_devlink);
 	return err;
 }
 
@@ -265,6 +290,13 @@ int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 	return __devlink_nl_pre_doit(skb, info, DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT);
 }
 
+int devlink_nl_pre_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					    struct sk_buff *skb,
+					    struct genl_info *info)
+{
+	return __devlink_nl_pre_doit(skb, info, DEVLINK_NL_FLAG_NEED_PARENT_DEV);
+}
+
 static void __devlink_nl_post_doit(struct sk_buff *skb, struct genl_info *info,
 				   u8 flags)
 {
@@ -274,6 +306,10 @@ static void __devlink_nl_post_doit(struct sk_buff *skb, struct genl_info *info,
 	devlink = info->user_ptr[0];
 	devl_dev_unlock(devlink, dev_lock);
 	devlink_put(devlink);
+	if ((flags & DEVLINK_NL_FLAG_NEED_PARENT_DEV) && info->user_ptr[1]) {
+		devlink = info->user_ptr[1];
+		devlink_put(devlink);
+	}
 }
 
 void devlink_nl_post_doit(const struct genl_split_ops *ops,
@@ -289,6 +325,14 @@ devlink_nl_post_doit_dev_lock(const struct genl_split_ops *ops,
 	__devlink_nl_post_doit(skb, info, DEVLINK_NL_FLAG_NEED_DEV_LOCK);
 }
 
+void
+devlink_nl_post_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					 struct sk_buff *skb,
+					 struct genl_info *info)
+{
+	__devlink_nl_post_doit(skb, info, DEVLINK_NL_FLAG_NEED_PARENT_DEV);
+}
+
 static int devlink_nl_inst_single_dumpit(struct sk_buff *msg,
 					 struct netlink_callback *cb, int flags,
 					 devlink_nl_dump_one_func_t *dump_one,
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f9786d51f68f..2dc82cc9a0b1 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -496,7 +496,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_PARENT_DEV_NAME + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -505,10 +505,12 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_W
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_PARENT_DEV_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_PARENT_DEV_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_RATE_NEW - do */
-static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
+static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_PARENT_DEV_NAME + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -517,6 +519,8 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_W
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_PARENT_DEV_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_PARENT_DEV_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
@@ -1160,21 +1164,21 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 	{
 		.cmd		= DEVLINK_CMD_RATE_SET,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.pre_doit	= devlink_nl_pre_doit,
+		.pre_doit	= devlink_nl_pre_doit_parent_dev_optional,
 		.doit		= devlink_nl_rate_set_doit,
-		.post_doit	= devlink_nl_post_doit,
+		.post_doit	= devlink_nl_post_doit_parent_dev_optional,
 		.policy		= devlink_rate_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
+		.maxattr	= DEVLINK_ATTR_PARENT_DEV_NAME,
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
-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
+		.maxattr	= DEVLINK_ATTR_PARENT_DEV_NAME,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 8f2bd50ddf5e..dd402264a47f 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -27,12 +27,19 @@ int devlink_nl_pre_doit_dev_lock(const struct genl_split_ops *ops,
 int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 				      struct sk_buff *skb,
 				      struct genl_info *info);
+int devlink_nl_pre_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					    struct sk_buff *skb,
+					    struct genl_info *info);
 void
 devlink_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		     struct genl_info *info);
 void
 devlink_nl_post_doit_dev_lock(const struct genl_split_ops *ops,
 			      struct sk_buff *skb, struct genl_info *info);
+void
+devlink_nl_post_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					 struct sk_buff *skb,
+					 struct genl_info *info);
 
 int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
-- 
2.45.0


