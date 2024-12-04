Return-Path: <linux-rdma+bounces-6250-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2189E47A0
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 23:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB0C16AB82
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 22:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9202A1B415B;
	Wed,  4 Dec 2024 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d5Xldhwo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306F91A8F82;
	Wed,  4 Dec 2024 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350322; cv=fail; b=UKrEdqbhIWm+SwW1OfngKqcngRJV4n9rSpSFbKIfDv+IW0AoPOJy5Ts9Hryi/zW18Wnas6FMAGTBLqoac3KUFOTOhqp8HAMw/WcPpZcO3LGZrxtoEK/2zn141PHWAOUu9kcEZiyQkAu3cpus7lQYCn8pP8ljxXfjULQ3I2lIWkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350322; c=relaxed/simple;
	bh=Hy03DKxyJPucv1RnNQVbHTM2ODUTyQccO2a+qBmeIVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OuJ+jZ+TdF3AN0mzWa7ICKMKs290AwoP2Cgjjp0Y/s0bghjHIh/qJLxMOXpoaO6B5XSVayuGHVgnA+hj0jZdPyLFZ7DuvaQxVGMy0EJYdcDdiC5wd++VxoJ5ZcAg9N4T/P0FVbfbvyGAR56o+qJICVX1d0nzT69fP0e5xpMtO7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d5Xldhwo; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4wfDr+b1yogpGzxFvCEEimGt6R86Hs2CLEyj2T0lnHiwPlB5Xbh+rCeji4UVmaNycRBqL3YAaz4V2w2juz//kTq38x9nWxNYzgU804vuuhurNcgoEVauvCHyJOyipEtkzxWgd46M0LgM3CkQckHGQpXSNeMuguZkaRDxYHAkTe/W3O53GapCHVmoO9nC1e3H0chIM7MrNkcztiYKA7ddINZJgIhyI4fG+w01kosoWpVlgq8TtGS3IT8QNwiSgadKD1BnoLLxb9cCTOpvnnVQ5Ui+jFKHFzysjT5rqOyB9y+7a8l6u12XhQIARub+zkUfEXcocZcaSoR33tmaCiVPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOVWpb/7hYWvWhQSd2dQ2U5woGT/mKO63tTTSw20his=;
 b=gEgoLyMtWil753rsdFWEzdBXmR5LvdseyP8O+UDmvP7Y2HLMnsZcJcwnGccqAP1/l4skSN7j/3BAMBEHTe2LOkxyNQ/LFU4U3DPqlI0LwtuWSJQkaps0/vL/Q+Y8PSv7XfNu8HNnoBkmRgI6b8vBNx7g0Xdn5SEsUDpK81qs+aWR6rlZeunbO9eUTVGRAtLFg/NKelo/gVdJbZ3SQu8Y7NCg2pI93R3S7OPmhe6Y9NU/bnQ8aAGFmqh2lFWCNlkLFDglQzUhZ14Z8QV+KbejK/eyW8PpeHoFN+KCiIiIyZM9ASrv2/1hzJgDJ2Awd8DPk8pCaeqikwLyTEIWehKLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOVWpb/7hYWvWhQSd2dQ2U5woGT/mKO63tTTSw20his=;
 b=d5XldhwoAG5FJez2ya0ocqcyaZw/R6CH+0ej/ZnWxHbJ3yhKGzn6uneB1PJmzx8zZIG3/k80mXURbMld+eG04C/V565nw+78uFcH91R//uKORCMkAPxWxmskeE+BsEEXYvo2Q0UccAoHiVNQXIgE0QAhb4SKYW8qyD44m9hXS72Re6727v75i+gePTpvfFZiCex3YrAQEQRjhuW5CDSBpLYySIMSeBSfa9X304FD6ptwZLd3b//5rB3iibJrXBtsEaAahBzLnlPjGupw+/+CUNPEJH8J+2luxZcbWQJkvKZmFZFpH/SRh1ksA2k1CAqSTwcydiB+fxBdwZA5cnQQKg==
Received: from SJ2PR07CA0013.namprd07.prod.outlook.com (2603:10b6:a03:505::15)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 4 Dec
 2024 22:11:52 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::5) by SJ2PR07CA0013.outlook.office365.com
 (2603:10b6:a03:505::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Wed,
 4 Dec 2024 22:11:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 22:11:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:32 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:32 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 4 Dec
 2024 14:11:28 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V5 07/11] devlink: Extend devlink rate API with traffic classes bandwidth management
Date: Thu, 5 Dec 2024 00:09:27 +0200
Message-ID: <20241204220931.254964-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241204220931.254964-1-tariqt@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 85679cd9-48be-4541-c406-08dd14b0a75f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cZLM/k8fvqSIpG/la7CYHcfwfwZv3HklWIF0ex4i8K4DCv+nwODUvClHF0Z9?=
 =?us-ascii?Q?fNPlEhMHuUF3OwEdUczyEGycAE4p40kJAEqT6pnowbg8GHZK2xSfZf62i//D?=
 =?us-ascii?Q?wKN2z4AXOa61jz6ggBXjb8ByeQW+ikySzyObc3RajmfG4Ii+7uDf++Y7MJ/r?=
 =?us-ascii?Q?ozzY6zbp+vSL2hkIkF4cWeHTzi9NL/8wjBh4If8L7MY8x0QIQj6DJVwpCUrD?=
 =?us-ascii?Q?gGR2MkkSOmx51Iqrx9cQDUQZ6eivIEu6yaaOTcpQm/5sqf/PQoIUU8p98zq3?=
 =?us-ascii?Q?YaEdm+JSAgIPSSjLfYHUlK+tSYcrzPMPRLmAw05z26uUXFrvwa0HO7CVHdRT?=
 =?us-ascii?Q?BNgx9GlEv7S3LfsfXCk7qnwXNTtT6TKcknOXOKvZW9ZD6tSVp23WkUsWwv/c?=
 =?us-ascii?Q?zSbY5kPybm+fZwF0Tmehh1lmsh2ndk6C8p1sKHKVFw689UX02ofbNxiMR7/s?=
 =?us-ascii?Q?QcxeUlzNNbqAKEIo66Fn9UtD19AEehnXnnwO5ZkvUUmxinkz2JzvSWfwUp36?=
 =?us-ascii?Q?a/m5DtnDRAhbrNLaOnJ/2QELzQUbmDCZ3VeEwLwH7fRYcvYZywAs3owst/YV?=
 =?us-ascii?Q?rmdhl2VbdbJwgTGBfbzQ7xwfnx2ndsnw3HpW3iqH7jlYe9t0z2Mbsn7WDTep?=
 =?us-ascii?Q?nqdxHwmX2toznMCOiJurNR5ybPm17LKcqL9ku6tqt4IpckxCKNJJR7FwhrLd?=
 =?us-ascii?Q?Xbwkxor7nbHMrNCLzHBDdJT0CNiW4IhRc/wvnqqXzjGN1rNg6bba3UMaUQUz?=
 =?us-ascii?Q?sEV1uhC88+Ah21ufQ6rNvbh4FLhTNhLSY09kLiaYsgjHzLadglqksDHpF5mn?=
 =?us-ascii?Q?dyCMfGx62tYfLgIOqOGsDO6TwfERrubZfuAS9AVi3DnxILQeUTKqxomU0GVY?=
 =?us-ascii?Q?bIreGHJ1xaZmRStoHYi/XhtwAwaIz8rJfCmtv6xi//91zYc61NPDUka5terB?=
 =?us-ascii?Q?ZxF3QHboGWbx1Z1No46Mq4ww1FcK9hbc5H7GWSLWcKkBQgX1Q/Kz/C7feaLK?=
 =?us-ascii?Q?ZIFD6pqAvY+qXunhNXezJj3OB5Wxpd7xwJ6gtxUAJnKnCjJfECeD4ZjRnQkA?=
 =?us-ascii?Q?ixzw/flTAMejGP5sMO1T1spBEByCIp8RqnX4tjQDAha64Od5Q59YXy0Z68AL?=
 =?us-ascii?Q?XNWk3dbVP4yrRPlwn3Xe4MplNyqamxRcZ0G8b24dlkJK33dyd2Q3kXW7qwXt?=
 =?us-ascii?Q?k0/sddNeT1CscIZYLjl1TMBn3GPn0VhzhL28Oz5eIYE9q/nWVVSws6Np2iPS?=
 =?us-ascii?Q?pGJvFkV5Ov/KM8YlQ1OPnxwStc/lkJndLBZOT3IVpmIADKQ123iHM2skIzjj?=
 =?us-ascii?Q?CsB3bAmmLNSiwX426NsiC0BbiHBf+M1XbCbSI7ddXgWx6MO1lh+XVRi2Yv3o?=
 =?us-ascii?Q?FQi3poR3mNo5gbIdrrLQyozzpNDbMjDhZ8dW9Vvw0sv0d7j7nJPIWxRwsjqB?=
 =?us-ascii?Q?MJ3G+3vkYg5SdIFkw/SyGsM1Q0ckdlU1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 22:11:50.9942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85679cd9-48be-4541-c406-08dd14b0a75f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288

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
 Documentation/netlink/specs/devlink.yaml |  28 ++++-
 include/net/devlink.h                    |   7 ++
 include/uapi/linux/devlink.h             |   4 +
 net/devlink/netlink_gen.c                |  15 ++-
 net/devlink/netlink_gen.h                |   1 +
 net/devlink/rate.c                       | 124 +++++++++++++++++++++++
 6 files changed, 174 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 09fbb4c03fc8..7fceb8fdc73b 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -820,7 +820,23 @@ attribute-sets:
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
@@ -1225,6 +1241,14 @@ attribute-sets:
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
@@ -2149,6 +2173,7 @@ operations:
             - rate-tx-priority
             - rate-tx-weight
             - rate-parent-node-name
+            - rate-tc-bws
 
     -
       name: rate-new
@@ -2169,6 +2194,7 @@ operations:
             - rate-tx-priority
             - rate-tx-weight
             - rate-parent-node-name
+            - rate-tc-bws
 
     -
       name: rate-del
diff --git a/include/net/devlink.h b/include/net/devlink.h
index fbb9a2668e24..277b826cdd60 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -20,6 +20,7 @@
 #include <uapi/linux/devlink.h>
 #include <linux/xarray.h>
 #include <linux/firmware.h>
+#include <linux/dcbnl.h>
 
 struct devlink;
 struct devlink_linecard;
@@ -117,6 +118,8 @@ struct devlink_rate {
 
 	u32 tx_priority;
 	u32 tx_weight;
+
+	u32 tc_bw[IEEE_8021QAZ_MAX_TCS];
 };
 
 struct devlink_port {
@@ -1469,6 +1472,8 @@ struct devlink_ops {
 					 u32 tx_priority, struct netlink_ext_ack *extack);
 	int (*rate_leaf_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
 				       u32 tx_weight, struct netlink_ext_ack *extack);
+	int (*rate_leaf_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
+				   u32 *tc_bw, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_share_set)(struct devlink_rate *devlink_rate, void *priv,
 				      u64 tx_share, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_max_set)(struct devlink_rate *devlink_rate, void *priv,
@@ -1477,6 +1482,8 @@ struct devlink_ops {
 					 u32 tx_priority, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
 				       u32 tx_weight, struct netlink_ext_ack *extack);
+	int (*rate_node_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
+				   u32 *tc_bw, struct netlink_ext_ack *extack);
 	int (*rate_node_new)(struct devlink_rate *rate_node, void **priv,
 			     struct netlink_ext_ack *extack);
 	int (*rate_node_del)(struct devlink_rate *rate_node, void *priv,
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 9401aa343673..b3b538c67c34 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -614,6 +614,10 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
+	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
+	DEVLINK_ATTR_RATE_TC_INDEX,		/* u8 */
+	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f9786d51f68f..b7b7829175dc 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -18,6 +18,11 @@ const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_
 	[DEVLINK_PORT_FN_ATTR_CAPS] = NLA_POLICY_BITFIELD32(15),
 };
 
+const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1] = {
+	[DEVLINK_ATTR_RATE_TC_INDEX] = { .type = NLA_U8, },
+	[DEVLINK_ATTR_RATE_TC_BW] = NLA_POLICY_RANGE(NLA_U32, 0, 100),
+};
+
 const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1] = {
 	[DEVLINK_ATTR_SELFTEST_ID_FLASH] = { .type = NLA_FLAG, },
 };
@@ -496,7 +501,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -505,10 +510,11 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_W
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
@@ -517,6 +523,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_W
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
@@ -1164,7 +1171,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
+		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1174,7 +1181,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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
index 8828ffaf6cbc..4bee2481115c 100644
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
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
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
 
@@ -316,6 +342,86 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
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
+		NL_SET_ERR_MSG(extack, "Traffic class index is expected");
+		return -EINVAL;
+	}
+
+	tc_index = nla_get_u8(tb[DEVLINK_ATTR_RATE_TC_INDEX]);
+
+	if (tc_index >= IEEE_8021QAZ_MAX_TCS) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "Provided traffic class index (%u) exceeds the maximum allowed value (%u)",
+				   tc_index, IEEE_8021QAZ_MAX_TCS - 1);
+		return -EINVAL;
+	}
+
+	if (!tb[DEVLINK_ATTR_RATE_TC_BW]) {
+		NL_SET_ERR_MSG(extack, "Traffic class bandwidth is expected");
+		return -EINVAL;
+	}
+
+	if (test_and_set_bit(tc_index, bitmap)) {
+		NL_SET_ERR_MSG(extack, "Duplicate traffic class index specified");
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
+	DECLARE_BITMAP(bitmap, IEEE_8021QAZ_MAX_TCS) = {};
+	struct devlink *devlink = devlink_rate->devlink;
+	const struct devlink_ops *ops = devlink->ops;
+	u32 tc_bw[IEEE_8021QAZ_MAX_TCS] = {};
+	int rem, err = -EOPNOTSUPP, i;
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
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
+		if (!test_bit(i, bitmap)) {
+			NL_SET_ERR_MSG_FMT(info->extack,
+					   "Bandwidth values must be specified for all %u traffic classes",
+					   IEEE_8021QAZ_MAX_TCS);
+			return -EINVAL;
+		}
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
@@ -388,6 +494,12 @@ static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
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
 
@@ -423,6 +535,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
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
@@ -449,6 +567,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
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
2.44.0


