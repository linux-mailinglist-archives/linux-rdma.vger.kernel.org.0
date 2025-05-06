Return-Path: <linux-rdma+bounces-10073-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D3FAAC28D
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 13:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FFA03BA00C
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 11:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCA227AC39;
	Tue,  6 May 2025 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AINZlrzw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8899C72639;
	Tue,  6 May 2025 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530858; cv=fail; b=WNcURdUHegCiAaTsrRFh+eA+OJAAovA3801VhW1GVcyuqzK5fW72unedh5bya7xNTFS2wuijC65sXkcInhkisz7GTj35HFKl1HM4uwJyWoV5NLTgAmyl+HGWBYxLNdeQ2IifbnNMAF60Acs+kc7OPKXyuha8e5tyjUpjhfXyxXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530858; c=relaxed/simple;
	bh=5J0s/YjUlV0PmKN8U1mF0p8vUjveb0bTbnBF0J0BwIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INmN0jdIbJLW223AdJPefA4FsOZHMBfXilzCHplIWjw4bGYmrAOntRVQnwtzb6duId/PQi/ri9YNeutrcm1bm8gk8hG1e3EODtfn7dLZlpFQiPkE6wrFLAy+AZ78sNEK73tr8Dj+evDX2c8d+gkacoLv0uT2xiRKjFxa8sSZlwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AINZlrzw; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytL5viEloLiyF/1eg87FFbSl3XdZXUxwOUILrScWcN1CWyG3zyAXbLSgcYyZ1Y+kcfNSXliQhHw7z/NonVi2Hu3Rtvfa/Uwaj7f3eDS7cGKbqxUPa6SHwkVF9ob2DejFFExxy6Iyr9XHuWuwHAmvrgTSzt6wxoCQlAR2yfP+rQG/+OGyvFwUIq9/mUgY+RhUqNsoea0mTrvAUyt4vIX3TvpggOmEfMO8ApwCNaFY1xwW+ernae5AACZFfalrDP6BAcly2g4N6Lhpo1M6Ctv3uGKUEciTZz841ECYcxTqEzGIYPBfgek97BW/G0C1Q4vKGTSXNaBG5hVhmc7xZtF05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDH/LjJSd3KvT5Z4PHv2gE+uaFj0WA8SJK0OarGgSzw=;
 b=IgnMMnOEuiWQD/BAsdKxfVUiujqbdrDuAXXFizJuulooMUsTNaV4lN/0OcPpZ2yrzkSxYmSHwRabFpupB1QLESVukZzCt9kVsYCZ9JxkjMy422yzpV9hQ5PGLbGRR233b/VfboK1kmrKgy3X5dQxz++mo1QUtb7fhTUdQF8q69U7Zp7KJigJRHbiFAK2i0KSANCKSOGMvG86wICp0c9WFtJs1YCqtaKO3TJ7nAENuxRESmvWlxBeFxvMowS63K7yhegDDKn1Ijk9iiVaK/efrvwwegmcalf3SApe2cK/PdthrQ4bXBN0ETW9o/zbRG5yYuKx0ZTpmGM9kKCRc8HjSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDH/LjJSd3KvT5Z4PHv2gE+uaFj0WA8SJK0OarGgSzw=;
 b=AINZlrzwRJP3m6xtWDuGeARiEnHa5XZa3o9NK+eK02bZmqnv1JxImqTrd8YiHnnd1W3zVkI5FbUNS5aDuWgqlU2Ia/2IpjnKcsgMdShl0Nf6L+Iqp0wNh4b7EwsfyX2Q9Jt4EA8IAcRxCKfvkMvSj3HTLQmJZAhp6opir7bAyqOuzDCAEi9Wr3dtpQ6bPRqpR/uWgHbvkFDwS/9e9gRojOck/wxqQy7NfSgahmCDMClMCLlzZc6If+dzubrTV4dF+fxj67r57Eq0wbD9yJ9O5gmph76+r4G5hsZ1yF8h8vZ7Tu8BxG6uUEv7PviB/JavVsry91fO9V8WFCEX1QTEoQ==
Received: from MW2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:907::31) by
 SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 11:27:24 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::41) by MW2PR16CA0018.outlook.office365.com
 (2603:10b6:907::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 6 May 2025 11:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 11:27:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 04:27:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 04:27:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 6 May 2025 04:27:10 -0700
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
Subject: [PATCH net-next V8 1/5] devlink: Extend devlink rate API with traffic classes bandwidth management
Date: Tue, 6 May 2025 14:26:39 +0300
Message-ID: <1746530803-450152-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1746530803-450152-1-git-send-email-tariqt@nvidia.com>
References: <1746530803-450152-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c138882-8e7b-4fb0-87cc-08dd8c90f91b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yMJ7JU0vi+KM0BhjT+WuMPDWcqlXogc6NRc5R3XOMcjjvCBKdyomygXi0yPL?=
 =?us-ascii?Q?zSU4hQCRZ+GS8coD1lqRUwzdVMb3SJwopz3calnM8PjMQ/OOrcZ2/5Ud6z6J?=
 =?us-ascii?Q?nOYdWd9eK91bZ10/chLuahB25vVNmCrud8hQsafIYTZXhbQpTKhSFrU9UNL/?=
 =?us-ascii?Q?Ny6PQPd9/VoGOYGJo9nOBzCGIJJhWr+VMEhNcHMo/uS7jdfQVo3yqx+Yf9I4?=
 =?us-ascii?Q?zlE/Jt5sWgXdsMjKYTwmwBqk3sUOKiXwQQGIkuHcNQQwowL74Hh8mqXK4OSe?=
 =?us-ascii?Q?PzQJgLx8DAXeRwzMWj+lXGKq82TqMv1tLrSRE/JoCacJHzcRf0PURvp2R2EY?=
 =?us-ascii?Q?R1l9CBIpmp8GW1GPo6xXF7Mpoha6B0MSDrCAcEW4z/7KPHzShgIf+iPMpuGF?=
 =?us-ascii?Q?o955a7FVPS2oCRUJMON/FNok23zAOlGxdUXPHFYprVdSx/vowMzZp7YF6W+C?=
 =?us-ascii?Q?nEaz5Wc2EF6Wb5AoVfe+NV9cEI5Nm89WLlwpYn/MKsbUjeEAaNeWEGD2Y3g2?=
 =?us-ascii?Q?A5XYjSX+sGIsIYaxUsTl4P7ckXDP0l5NAchuMd7Wtmbh5azcAVDvNavT2/N7?=
 =?us-ascii?Q?T2s0fB3ooCf8/WHlZn1nfsmM73mEQZP6yzejXiObzkhEyLEn8F/HJ6iFE1S3?=
 =?us-ascii?Q?TTMoq3gPwt3IT8V4wahakDd2oiS8g/rLgd76ERD9uezCBlbxoUV27DDcL5gm?=
 =?us-ascii?Q?MxnsO6+lCUqpVZUXKeTMYmd7lH4t0lqp2Gp7OJQTi2vONJdNe15fcxjdl0aL?=
 =?us-ascii?Q?Drnkt2KQUXkt9Gxy/G78Sm2bYoRlDEAtUHKB8F5RXNYg/Fgp3xxsy5laRTfv?=
 =?us-ascii?Q?kjV6htYtkEiPF+0CDQ8jysAygDW7WA3CfyRKJTucg+PcdNpGxrEFEBuTTeQZ?=
 =?us-ascii?Q?zL1Z8ZJYI4gaWA7ufHwqtxyd/BFk541BF2jv2qeHb4pjbeYAo2raqPo2xlW+?=
 =?us-ascii?Q?+hZw3xUjdbFzdEunPGnB8ei1Y209aoba/ucSWdHBxW5hcJA3RenSdeM23jnU?=
 =?us-ascii?Q?JMl+kAcu1fBHZJALmPzDrUhAZelqB0iLpCt/wmJgJq5Z97WRXffGiv+sWxMQ?=
 =?us-ascii?Q?LHBsLBqC8mkh11iDlYPmgoPpliZ/YjT0LdsKpz7qh+v13aWCKMWy6zongP1z?=
 =?us-ascii?Q?zdLvg8H6kIBu9y8dFwQu+wXnQLMc0K728Ij+Ztz0i12gXpyWtnki+gPJjlIl?=
 =?us-ascii?Q?GMX6Dvlf4CwpCAqAWOld5jks0Gu95I+sKG9CQ/F2iZKoGsfz57r/Edwh8Z6d?=
 =?us-ascii?Q?LzIIsEKAZcVwgeC1eAjXZfyA3UOyOZlKJhnbaqK+1aschthCiIEMx+tNYuAS?=
 =?us-ascii?Q?2nCGOHZDFNOzmt2DyCi6W5UtumVZDSWW7c5797m16e2gvzXL8rDDX4olkhIh?=
 =?us-ascii?Q?RxxHORmapuMl5uAXVnP9kOkwonczb+T50L96Zm3tpzrwVVEt7wp8KhOXNHrW?=
 =?us-ascii?Q?/zY1hKwtk+J2E8AZS4ACWdTsWBuaQOYCij91L0wsFLYmzRUGlm1Uixz5MS1v?=
 =?us-ascii?Q?TeS8iPdvr+SZhwINY7zBaTRn9z6yVzQMcTMA?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 11:27:23.8320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c138882-8e7b-4fb0-87cc-08dd8c90f91b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995

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
 include/net/devlink.h                         |   9 ++
 include/uapi/linux/devlink.h                  |   4 +
 net/devlink/netlink_gen.c                     |  16 ++-
 net/devlink/netlink_gen.h                     |   2 +
 net/devlink/rate.c                            | 127 ++++++++++++++++++
 7 files changed, 196 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index bd9726269b4f..64b6aaa02047 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -202,6 +202,11 @@ definitions:
         name: exception
       -
         name: control
+  -
+    name:  devlink-rate-tc-index-max
+    header: net/devlink.h
+    type: const
+    value: 7
 
 attribute-sets:
   -
@@ -820,7 +825,26 @@ attribute-sets:
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
@@ -1225,6 +1249,14 @@ attribute-sets:
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
@@ -2150,6 +2182,7 @@ operations:
             - rate-tx-priority
             - rate-tx-weight
             - rate-parent-node-name
+            - rate-tc-bws
 
     -
       name: rate-new
@@ -2170,6 +2203,7 @@ operations:
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
index b8783126c1ed..1b7fa11b5841 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -20,6 +20,7 @@
 #include <uapi/linux/devlink.h>
 #include <linux/xarray.h>
 #include <linux/firmware.h>
+#include <linux/dcbnl.h>
 
 struct devlink;
 struct devlink_linecard;
@@ -99,6 +100,8 @@ struct devlink_port_attrs {
 	};
 };
 
+#define DEVLINK_RATE_TC_INDEX_MAX (IEEE_8021QAZ_MAX_TCS - 1)
+
 struct devlink_rate {
 	struct list_head list;
 	enum devlink_rate_type type;
@@ -118,6 +121,8 @@ struct devlink_rate {
 
 	u32 tx_priority;
 	u32 tx_weight;
+
+	u32 tc_bw[IEEE_8021QAZ_MAX_TCS];
 };
 
 struct devlink_port {
@@ -1482,6 +1487,8 @@ struct devlink_ops {
 					 u32 tx_priority, struct netlink_ext_ack *extack);
 	int (*rate_leaf_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
 				       u32 tx_weight, struct netlink_ext_ack *extack);
+	int (*rate_leaf_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
+				   u32 *tc_bw, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_share_set)(struct devlink_rate *devlink_rate, void *priv,
 				      u64 tx_share, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_max_set)(struct devlink_rate *devlink_rate, void *priv,
@@ -1490,6 +1497,8 @@ struct devlink_ops {
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
index f9786d51f68f..186f31522af0 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -9,6 +9,7 @@
 #include "netlink_gen.h"
 
 #include <uapi/linux/devlink.h>
+#include <net/devlink.h>
 
 /* Common nested types */
 const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1] = {
@@ -18,6 +19,11 @@ const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_
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
@@ -496,7 +502,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -505,10 +511,11 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_W
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
@@ -517,6 +524,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_W
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
@@ -1164,7 +1172,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
+		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1174,7 +1182,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_new_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
+		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 8f2bd50ddf5e..e3558cf89be4 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -10,9 +10,11 @@
 #include <net/genetlink.h>
 
 #include <uapi/linux/devlink.h>
+#include <net/devlink.h>
 
 /* Common nested types */
 extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
+extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1];
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
 
 /* Ops table for devlink */
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 8828ffaf6cbc..aff5682aead7 100644
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
+	DECLARE_BITMAP(bitmap, IEEE_8021QAZ_MAX_TCS) = {};
+	struct devlink *devlink = devlink_rate->devlink;
+	const struct devlink_ops *ops = devlink->ops;
+	int rem, err = -EOPNOTSUPP, i, total = 0;
+	u32 tc_bw[IEEE_8021QAZ_MAX_TCS] = {};
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


