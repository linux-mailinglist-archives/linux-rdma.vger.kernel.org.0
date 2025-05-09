Return-Path: <linux-rdma+bounces-10180-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D50AB09EF
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 07:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF9C7BE83A
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 05:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E61726A0A0;
	Fri,  9 May 2025 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TlVDGqep"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED1266F0D;
	Fri,  9 May 2025 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746769785; cv=fail; b=uKt1ldFaQ7zKNtORwLSXiZ0K+H7ZsCDK+OWZhpM3yYnAgpVRiqYLjh2pj9kAVueBa7Elh/cf/SKe6AHvdXRHpAL47rhH0noOexHjELOOisKwrd3MaBsF9qJrJsYekzI7dqmhktBm1g3FmE6gYeYTQqVydwtcti3+pIl5otujglc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746769785; c=relaxed/simple;
	bh=AI9dSxq4Z+IpCN6cZB5dypTWeArEMEHLcjF3PERKSeo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKhp4hVfT8L5+ILvvFQvSklgY2HxV/GIzu2sMWVqhDLqihSGET5DLOd3qvQfwgaibt7v3CUOLHmAxQeDCFRzv9+TISYDEptKSGZdSWre4+LLcX3+GHEeTK1nInUV8aLWJrc1U1UBi3/XPVGWbm+z+sz9aB6ljykbQWSrH/zbCyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TlVDGqep; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3h88lX5BiNTdrwKWzfsTaCr5GulXak++b3MhM29ZcsG6qq+uN9BLEWR1rKOE7/fbMxvtPclu0Pyq/wBBC73c7KjIoVr7jpSpqjBAesVmoTr92tMnndDLhHIt7+ZdkvaIYXrps2mhpsyTYW+4mBGIAdC7qT4qUynhPmD1kUGqjdvP2pF68JBYkO7rhnZQoYxourl0XOszrhlc8UVbrZ6bhE01URGYa8f/KQdksh7rtcDd66CH6aFKnyNYg0dXurRWINjzsHkcr9EcQql4lyRKzouvzZl0gC1HO2caC5mjam4LQsn2cdzwD+NqbNI/drP3JlqkOczGhB1YbLdowe/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0FJMFSa/rRfu/MExx5axW6cgHoTscbzOjMdlIKyi08=;
 b=RMG5+D0l2noxY8teBkloY8UxQa/04fJ2TaY3ubmGt2vc9bcjLz3I36HFasXU0+Z5I+pbPRisGA6MO7vf3LhX0gE77fISn9RF0+M88uuwWw/C25kRPEHWlPJUu5RSRtBl92tAeLbyj/N5+1gpPkXdk4RK9BurCKcrgMcAkEEjFqCanFhSK9MgFZ6KF1nlb5zXvnpkMy2svPBrj/cXBLeYjcmmUydaOWUhqGXcI+HyhhTO7Wsn4pcwITjWNBre5hVUa5++/I3APhRIIdgHWYiExQ/ouXMW3lrHV0+AIKudiKsI8CMI8Ft44H2lhPFZ0XpYbA3ljcXGQgLryqeS2lz7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0FJMFSa/rRfu/MExx5axW6cgHoTscbzOjMdlIKyi08=;
 b=TlVDGqepnPrAKMzWk6m8m4kF6dZ8Da4HsCMKH9pvZIxM+bM2ksavvLCA6qPsQBX9t5XIKYPnWPyV70nTBEUdnrGftEjs6R+r6DVxd0xaHvydn9j/dSp+Tr6NOFP9xVSuq64WFsEMaKO86CiZiEyYOk1o7LJuS1IBabS2EnfzUHkxtEnate6PTLOCtlCjLubJjVRlkhXZ2CFljS2taITJHc+w9/5Zs+5dmX2l2Ha2pLGygHqV3lAfQQSQpBW6Dw3Qu3Ebt1KaAXsnbklsHKL+ap9ISYGxH1Q40OY0pwWfDoHn+4Zpaq8M70STZseEIDfR3p3qc02/ngRGmmWyCII74g==
Received: from CH2PR04CA0008.namprd04.prod.outlook.com (2603:10b6:610:52::18)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.38; Fri, 9 May
 2025 05:49:33 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::d8) by CH2PR04CA0008.outlook.office365.com
 (2603:10b6:610:52::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Fri,
 9 May 2025 05:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 05:49:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 22:49:22 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 8 May
 2025 22:49:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 8 May
 2025 22:49:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Jiri Pirko <jiri@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>,
	"Jiri Pirko" <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: [PATCH net-next V9 1/5] devlink: Extend devlink rate API with traffic classes bandwidth management
Date: Fri, 9 May 2025 08:43:05 +0300
Message-ID: <1746769389-463484-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1746769389-463484-1-git-send-email-tariqt@nvidia.com>
References: <1746769389-463484-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CY5PR12MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: f9872564-9839-4368-65d4-08dd8ebd45fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/jKDFKCbP3O0ma77znMPpXXZteQJHy5QWjarMCv6BMwZRaZ8kqmBiUPf5KWz?=
 =?us-ascii?Q?SXDLq/aO6hOjhbzSUGiwO2wmWvvKcaAkR8VYgdbjiRijBQ3divlq2w2LFFQc?=
 =?us-ascii?Q?UW9hqHWVe+Bfeqli3o0BQ1WyKVBXO2AHsG3f/YwgK1ynI4pBTG92nzPGxzSk?=
 =?us-ascii?Q?YDODiwr0j00A1/INF5HnNVtS5nwKe7oOv4XzXZpWih+lmG28r55s38wSvhc6?=
 =?us-ascii?Q?qApWHHZcm+rdAcoFObElf+CA82FpDna1RFeQ9TLWWIH+G3PMLAeqECB3QDu7?=
 =?us-ascii?Q?ZrjNd7RV2wAJkkyqUjfm4P43qaSGJc+W+fgRPhb3HCNFVzyjJmx0WMj+Gfkx?=
 =?us-ascii?Q?0WrhqICd12mrlVteDuZF0XLTpeHyVcpxzE2+HmNVXvsctG/Aa3l5+h13P+PR?=
 =?us-ascii?Q?RloGudWEyyC+n1E+fqk71+UmLvUdPY79RctvzoX4FVBALlYIgnP5m58CQWnD?=
 =?us-ascii?Q?cba6fZrrkssfwSXHI5I252jfOfIMtuUsqSpiP2uUke+nsuK6p1b4NUxbZGxT?=
 =?us-ascii?Q?+xfA5+OihAHRwsvrOw8UBj3GoZVzNP05oQ1eCrpX5VPU6v8dxBX+se/82U7I?=
 =?us-ascii?Q?PDzqfog7EZlAliknB7YOk+zxkshWBtWugOmguwjKWiRBrkg4SmvYWZsgh1Ad?=
 =?us-ascii?Q?IqOTX5WMtfapIV7EFxOXdHIwcmQs9tK+UnCRFpKGvnpOrJS9XKP9KaCoCSV8?=
 =?us-ascii?Q?i+Eb9YhVUGuB46CbMGCOm+7gBsyE+4UTcEZCAPgLfXQPog5mFrnhIE4Oupee?=
 =?us-ascii?Q?yYPyZ/iK4NgkprqR574DCUBvYUQBew3PQjIqbwoTEVSXyrOpTa28FdDvtI0o?=
 =?us-ascii?Q?wcoe8Tq8zaZN0w3hinXCrjV+x+zoIdOMNdoLka8l+2T9izkZCxuDI1Yura7U?=
 =?us-ascii?Q?qlgspWdz2fLx1BhblLR1GzzGKp8JcOaaKxmgug42ikxa/ZAUR8HuAqzmE2Lu?=
 =?us-ascii?Q?0dRwerNPq2dxrD9K4JVPTguwRE9A/XEgqPQEGuf6plwSbMYTZlKAbH1RTSTH?=
 =?us-ascii?Q?M24Z8wVLeFtH45TdV15aSLfZhqF08/UgyzxyG6undXRxFPOf7t//Z8+eMIo0?=
 =?us-ascii?Q?9uTS7MrULziRjQYHZ85hFOkWkTczWOERsfYajJmPrLiLE1kB24yAap9bYxhC?=
 =?us-ascii?Q?FK2dEKg0SiAlGsKxNMEn6w8h0jDtPlV2Ct8l82oacrNxMrOjmgNII0b16yzT?=
 =?us-ascii?Q?OhgnHHah9rjXouas/9jSkovswGkgUyT6cYkH6/ZaGpLwvbHRqeLaYHzBhqpu?=
 =?us-ascii?Q?5j8DhSx5C5kpNomV/1/XryV3Ujy1sMgSkQreggsqYFRof2aEvJv1Bun8sonq?=
 =?us-ascii?Q?BkKsx4jcLJVVjyjg1oib8KSABtMpCyMihYs4UFQr7uB7MpIwhbEdJuB8u9ew?=
 =?us-ascii?Q?i6h7IYvaReq4Ube4hPwEwI9RpVHFtoT8h8K5ZNe47fAMfcOUGze1UhEUh84w?=
 =?us-ascii?Q?DHphC9lemu9w8T3v6osqXnFv8rQnnGRRkwhkRI6iVzBzRykIhzExIt41ZdCS?=
 =?us-ascii?Q?IbhdCymn2uCg3N2caOm166XQr6aiRv8XUEn0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 05:49:32.9153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9872564-9839-4368-65d4-08dd8ebd45fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297

From: Carolina Jubran <cjubran@nvidia.com>

Introduce support for specifying bandwidth proportions between traffic
classes (TC) in the devlink-rate API. This new option allows users to
allocate bandwidth across multiple traffic classes in a single command.

This feature provides a more granular control over traffic management,
especially for scenarios requiring Enhanced Transmission Selection.

Users can now define a specific bandwidth share for each traffic class,
such as allocating 20% for TC0 (TCP/UDP) and 80% for TC5 (RoCE).

Example:
DEV=pci/0000:08:00.0

$ devlink port function rate add $DEV/vfs_group tx_share 10Gbit \
  tx_max 50Gbit tc-bw 0:20 1:0 2:0 3:0 4:0 5:80 6:0 7:0

$ devlink port function rate set $DEV/vfs_group \
  tc-bw 0:20 1:0 2:0 3:0 4:0 5:20 6:60 7:0

Example usage with ynl:

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml \
  --do rate-set --json '{
  "bus-name": "pci",
  "dev-name": "0000:08:00.0",
  "port-index": 1,
  "rate-tc-bws": [
    {"rate-tc-index": 0, "rate-tc-bw": 50},
    {"rate-tc-index": 1, "rate-tc-bw": 50},
    {"rate-tc-index": 2, "rate-tc-bw": 0},
    {"rate-tc-index": 3, "rate-tc-bw": 0},
    {"rate-tc-index": 4, "rate-tc-bw": 0},
    {"rate-tc-index": 5, "rate-tc-bw": 0},
    {"rate-tc-index": 6, "rate-tc-bw": 0},
    {"rate-tc-index": 7, "rate-tc-bw": 0}
  ]
}'

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml \
  --do rate-get --json '{
  "bus-name": "pci",
  "dev-name": "0000:08:00.0",
  "port-index": 1
}'

output for rate-get:
{'bus-name': 'pci',
 'dev-name': '0000:08:00.0',
 'port-index': 1,
 'rate-tc-bws': [{'rate-tc-bw': 50, 'rate-tc-index': 0},
                 {'rate-tc-bw': 50, 'rate-tc-index': 1},
                 {'rate-tc-bw': 0, 'rate-tc-index': 2},
                 {'rate-tc-bw': 0, 'rate-tc-index': 3},
                 {'rate-tc-bw': 0, 'rate-tc-index': 4},
                 {'rate-tc-bw': 0, 'rate-tc-index': 5},
                 {'rate-tc-bw': 0, 'rate-tc-index': 6},
                 {'rate-tc-bw': 0, 'rate-tc-index': 7}],
 'rate-tx-max': 0,
 'rate-tx-priority': 0,
 'rate-tx-share': 0,
 'rate-tx-weight': 0,
 'rate-type': 'leaf'}

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml      |  36 ++++-
 .../networking/devlink/devlink-port.rst       |   7 +
 include/net/devlink.h                         |   6 +
 include/uapi/linux/devlink.h                  |   7 +
 net/devlink/netlink_gen.c                     |  15 ++-
 net/devlink/netlink_gen.h                     |   1 +
 net/devlink/rate.c                            | 127 ++++++++++++++++++
 7 files changed, 194 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 05fee1b7fe19..d5d40193dac5 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -224,6 +224,11 @@ definitions:
         value: 10
       -
         name: binary
+  -
+    name:  devlink-rate-tc-index-max
+    header: uapi/linux/devlink.h
+    type: const
+    value: 7
 
 attribute-sets:
   -
@@ -844,7 +849,26 @@ attribute-sets:
       -
         name: region-direct
         type: flag
-
+      -
+        name: rate-tc-bws
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-rate-tc-bws
+      -
+        name: rate-tc-index
+        type: u8
+        checks:
+          min: 0
+          max: devlink-rate-tc-index-max
+      -
+        name: rate-tc-bw
+        type: u32
+        doc: |
+             Specifies the bandwidth allocation for the Traffic Class as a
+             percentage.
+        checks:
+          min: 0
+          max: 100
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1249,6 +1273,14 @@ attribute-sets:
       -
         name: flash
         type: flag
+  -
+    name: dl-rate-tc-bws
+    subset-of: devlink
+    attributes:
+      -
+       name: rate-tc-index
+      -
+       name: rate-tc-bw
 
 operations:
   enum-model: directional
@@ -2174,6 +2206,7 @@ operations:
             - rate-tx-priority
             - rate-tx-weight
             - rate-parent-node-name
+            - rate-tc-bws
 
     -
       name: rate-new
@@ -2194,6 +2227,7 @@ operations:
             - rate-tx-priority
             - rate-tx-weight
             - rate-parent-node-name
+            - rate-tc-bws
 
     -
       name: rate-del
diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index 9d22d41a7cd1..bc3b41ac2d51 100644
--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -418,6 +418,13 @@ API allows to configure following rate object's parameters:
   to all node children limits. ``tx_max`` is an upper limit for children.
   ``tx_share`` is a total bandwidth distributed among children.
 
+``tc_bw``
+  Allow users to set the bandwidth allocation per traffic class on rate
+  objects. This enables fine-grained QoS configurations by assigning specific
+  bandwidth percentages to different traffic classes. When applied to a
+  non-leaf node, tc_bw determines how bandwidth is shared among its child
+  elements.
+
 ``tx_priority`` and ``tx_weight`` can be used simultaneously. In that case
 nodes with the same priority form a WFQ subgroup in the sibling group
 and arbitration among them is based on assigned weights.
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 0091f23a40f7..135f7382386e 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -118,6 +118,8 @@ struct devlink_rate {
 
 	u32 tx_priority;
 	u32 tx_weight;
+
+	u32 tc_bw[DEVLINK_RATE_TCS_MAX];
 };
 
 struct devlink_port {
@@ -1482,6 +1484,8 @@ struct devlink_ops {
 					 u32 tx_priority, struct netlink_ext_ack *extack);
 	int (*rate_leaf_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
 				       u32 tx_weight, struct netlink_ext_ack *extack);
+	int (*rate_leaf_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
+				   u32 *tc_bw, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_share_set)(struct devlink_rate *devlink_rate, void *priv,
 				      u64 tx_share, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_max_set)(struct devlink_rate *devlink_rate, void *priv,
@@ -1490,6 +1494,8 @@ struct devlink_ops {
 					 u32 tx_priority, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
 				       u32 tx_weight, struct netlink_ext_ack *extack);
+	int (*rate_node_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
+				   u32 *tc_bw, struct netlink_ext_ack *extack);
 	int (*rate_node_new)(struct devlink_rate *rate_node, void **priv,
 			     struct netlink_ext_ack *extack);
 	int (*rate_node_del)(struct devlink_rate *rate_node, void *priv,
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index a5ee0f13740a..6932a05c694d 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -221,6 +221,9 @@ enum devlink_port_flavour {
 				      */
 };
 
+#define DEVLINK_RATE_TCS_MAX 8
+#define DEVLINK_RATE_TC_INDEX_MAX (DEVLINK_RATE_TCS_MAX - 1)
+
 enum devlink_rate_type {
 	DEVLINK_RATE_TYPE_LEAF,
 	DEVLINK_RATE_TYPE_NODE,
@@ -629,6 +632,10 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
+	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
+	DEVLINK_ATTR_RATE_TC_INDEX,		/* u8 */
+	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index e340d955cf3b..6d5b8296b049 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -45,6 +45,11 @@ const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_
 	[DEVLINK_PORT_FN_ATTR_CAPS] = NLA_POLICY_BITFIELD32(15),
 };
 
+const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1] = {
+	[DEVLINK_ATTR_RATE_TC_INDEX] = NLA_POLICY_RANGE(NLA_U8, 0, DEVLINK_RATE_TC_INDEX_MAX),
+	[DEVLINK_ATTR_RATE_TC_BW] = NLA_POLICY_RANGE(NLA_U32, 0, 100),
+};
+
 const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1] = {
 	[DEVLINK_ATTR_SELFTEST_ID_FLASH] = { .type = NLA_FLAG, },
 };
@@ -523,7 +528,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -532,10 +537,11 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_W
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_NEW - do */
-static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
+static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -544,6 +550,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_W
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
@@ -1191,7 +1198,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
+		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1201,7 +1208,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_new_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
+		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 8f2bd50ddf5e..fb733b5d4ff1 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -13,6 +13,7 @@
 
 /* Common nested types */
 extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
+extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1];
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
 
 /* Ops table for devlink */
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 8828ffaf6cbc..56ee4aca2eff 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -80,6 +80,29 @@ devlink_rate_get_from_info(struct devlink *devlink, struct genl_info *info)
 		return ERR_PTR(-EINVAL);
 }
 
+static int devlink_rate_put_tc_bws(struct sk_buff *msg, u32 *tc_bw)
+{
+	struct nlattr *nla_tc_bw;
+	int i;
+
+	for (i = 0; i < DEVLINK_RATE_TCS_MAX; i++) {
+		nla_tc_bw = nla_nest_start(msg, DEVLINK_ATTR_RATE_TC_BWS);
+		if (!nla_tc_bw)
+			return -EMSGSIZE;
+
+		if (nla_put_u8(msg, DEVLINK_ATTR_RATE_TC_INDEX, i) ||
+		    nla_put_u32(msg, DEVLINK_ATTR_RATE_TC_BW, tc_bw[i]))
+			goto nla_put_failure;
+
+		nla_nest_end(msg, nla_tc_bw);
+	}
+	return 0;
+
+nla_put_failure:
+	nla_nest_cancel(msg, nla_tc_bw);
+	return -EMSGSIZE;
+}
+
 static int devlink_nl_rate_fill(struct sk_buff *msg,
 				struct devlink_rate *devlink_rate,
 				enum devlink_command cmd, u32 portid, u32 seq,
@@ -129,6 +152,9 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
 				   devlink_rate->parent->name))
 			goto nla_put_failure;
 
+	if (devlink_rate_put_tc_bws(msg, devlink_rate->tc_bw))
+		goto nla_put_failure;
+
 	genlmsg_end(msg, hdr);
 	return 0;
 
@@ -316,6 +342,89 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 	return 0;
 }
 
+static int devlink_nl_rate_tc_bw_parse(struct nlattr *parent_nest, u32 *tc_bw,
+				       unsigned long *bitmap, struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
+	u8 tc_index;
+
+	nla_parse_nested(tb, DEVLINK_ATTR_MAX, parent_nest, devlink_dl_rate_tc_bws_nl_policy,
+			 extack);
+	if (!tb[DEVLINK_ATTR_RATE_TC_INDEX]) {
+		NL_SET_ERR_ATTR_MISS(extack, parent_nest, DEVLINK_ATTR_RATE_TC_INDEX);
+		return -EINVAL;
+	}
+
+	tc_index = nla_get_u8(tb[DEVLINK_ATTR_RATE_TC_INDEX]);
+
+	if (!tb[DEVLINK_ATTR_RATE_TC_BW]) {
+		NL_SET_ERR_ATTR_MISS(extack, parent_nest, DEVLINK_ATTR_RATE_TC_BW);
+		return -EINVAL;
+	}
+
+	if (test_and_set_bit(tc_index, bitmap)) {
+		NL_SET_ERR_MSG_FMT(extack, "Duplicate traffic class index specified (%u)",
+				   tc_index);
+		return -EINVAL;
+	}
+
+	tc_bw[tc_index] = nla_get_u32(tb[DEVLINK_ATTR_RATE_TC_BW]);
+
+	return 0;
+}
+
+static int devlink_nl_rate_tc_bw_set(struct devlink_rate *devlink_rate,
+				     struct genl_info *info)
+{
+	DECLARE_BITMAP(bitmap, DEVLINK_RATE_TCS_MAX) = {};
+	struct devlink *devlink = devlink_rate->devlink;
+	const struct devlink_ops *ops = devlink->ops;
+	int rem, err = -EOPNOTSUPP, i, total = 0;
+	u32 tc_bw[DEVLINK_RATE_TCS_MAX] = {};
+	struct nlattr *attr;
+
+	nla_for_each_attr(attr, genlmsg_data(info->genlhdr),
+			  genlmsg_len(info->genlhdr), rem) {
+		if (nla_type(attr) == DEVLINK_ATTR_RATE_TC_BWS) {
+			err = devlink_nl_rate_tc_bw_parse(attr, tc_bw, bitmap, info->extack);
+			if (err)
+				return err;
+		}
+	}
+
+	for (i = 0; i < DEVLINK_RATE_TCS_MAX; i++) {
+		if (!test_bit(i, bitmap)) {
+			NL_SET_ERR_MSG_FMT(info->extack,
+					   "Bandwidth values must be specified for all %u traffic classes",
+					   DEVLINK_RATE_TCS_MAX);
+			return -EINVAL;
+		}
+
+		total += tc_bw[i];
+	}
+
+	if (total && total != 100) {
+		NL_SET_ERR_MSG_FMT(info->extack,
+				   "Sum of all traffic class bandwidth values must be 100, got %u",
+				   total);
+		return -EINVAL;
+	}
+
+	if (devlink_rate_is_leaf(devlink_rate))
+		err = ops->rate_leaf_tc_bw_set(devlink_rate, devlink_rate->priv, tc_bw,
+					       info->extack);
+	else if (devlink_rate_is_node(devlink_rate))
+		err = ops->rate_node_tc_bw_set(devlink_rate, devlink_rate->priv, tc_bw,
+					       info->extack);
+
+	if (err)
+		return err;
+
+	memcpy(devlink_rate->tc_bw, tc_bw, sizeof(tc_bw));
+
+	return 0;
+}
+
 static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
 			       const struct devlink_ops *ops,
 			       struct genl_info *info)
@@ -388,6 +497,12 @@ static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
 			return err;
 	}
 
+	if (attrs[DEVLINK_ATTR_RATE_TC_BWS]) {
+		err = devlink_nl_rate_tc_bw_set(devlink_rate, info);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -423,6 +538,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 					    "TX weight set isn't supported for the leafs");
 			return false;
 		}
+		if (attrs[DEVLINK_ATTR_RATE_TC_BWS] && !ops->rate_leaf_tc_bw_set) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    attrs[DEVLINK_ATTR_RATE_TC_BWS],
+					    "TC bandwidth set isn't supported for the leafs");
+			return false;
+		}
 	} else if (type == DEVLINK_RATE_TYPE_NODE) {
 		if (attrs[DEVLINK_ATTR_RATE_TX_SHARE] && !ops->rate_node_tx_share_set) {
 			NL_SET_ERR_MSG(info->extack, "TX share set isn't supported for the nodes");
@@ -449,6 +570,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 					    "TX weight set isn't supported for the nodes");
 			return false;
 		}
+		if (attrs[DEVLINK_ATTR_RATE_TC_BWS] && !ops->rate_node_tc_bw_set) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    attrs[DEVLINK_ATTR_RATE_TC_BWS],
+					    "TC bandwidth set isn't supported for the nodes");
+			return false;
+		}
 	} else {
 		WARN(1, "Unknown type of rate object");
 		return false;
-- 
2.31.1


