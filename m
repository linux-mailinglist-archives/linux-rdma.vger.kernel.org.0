Return-Path: <linux-rdma+bounces-14729-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A43C82B0E
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 23:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46203A78FA
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 22:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2A433509C;
	Mon, 24 Nov 2025 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MCXk/8kA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012001.outbound.protection.outlook.com [40.93.195.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B62F744C;
	Mon, 24 Nov 2025 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023382; cv=fail; b=jPO2w6Qc3Pz1mWnb+U/GruC9Q7T2D3lt2TyDutJSYw4niYSaF7HtPFNtTZQUK0ioD1W/jam1O47eg56iT4HB9uFAIF1Za94yo7nylOjFq5PqZ2Y+fxRuzM5pwzC+DWQWAqAjcDI9WNVrt9E2UFzjW5Oz10IhPq4ZQ1KVFKB0uUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023382; c=relaxed/simple;
	bh=j+JpDB8lrUITToa6HtXVUiQKkYMS06iYiub1LMNjBWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIky+M5wXN9f8tSrUODGpIrVO7l7fnB9OOZZEkHbDVi13A5vmLLge+PAN+f7xrEoUhmoaVT20+QFR8sJfd4+m0m+NMmCk/LSHdBQujveHoFBixJr6mTLT+GNi4eUPAqzixQu3GYDgDqRK60e1vHZbZOK98k4Evl1HINAHRFqhDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MCXk/8kA; arc=fail smtp.client-ip=40.93.195.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1kNpXxy8a8Q1tztLjtCeUaLnI1RlYRxR51uebzv7UwYU6r8+9Q+mNmEH+aATnFmVBuvmA6ZFFbgbUtK4gNeWJugrBe8ffcIeQ2MTuczsRuKsT+wQDQQpwwifCMIlVTdaj9nxaUDBQm7PGZ1NI4XPAe1rbzB9A9oEVH3SMFy3W6h9lZNdDHEQOqc428sW4uilnMKk2Ak9Tp+6vOq5n2swNWhNU8uPkfA9BnN6gLj1NgrV2pHlWLpKrnmhVc9sAXHMlPqO5SqshkKK5pQt6cdcg560RxORjZn7lkWKxFaB7aWleF0Tu9Vts1zZiBvBWCAxUYzEkqC2+av+wkw4y5SlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7MGL78J8w1FDJhYk01+ZTwT+lZwV/itnX/hL3p0kBQ=;
 b=K7Kqvr414xln12yda631NdCZF7zHmAh5aFeQoHPSwerccIgwqnaF+LmtggI8LakEipy6joq36Ghx3HWhhSmWBZogMnNERtjJyLPB1ZJxsHlEmXg/K1d74iWXlb4gTXsEAajbQeJ8zqG7Srhweq+Iu/FJmhu5H2ZPkb/xTBS6sbXmr8V3R1kyog6lNy1vUcTNOq3yj0sZkd5/+ZOmbQh3WfmbzxcyJmuDm4kYiQ7ay2/hOwfz6t9I9cizeHhYTidcl0jJJOH8smDH2NTgY9QB6T0oHFbGCbKr2XZDNQCLrb3OZe3mDzgrQhROjN+U7ln1E43CKvLsGyQR1TDwniqtxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7MGL78J8w1FDJhYk01+ZTwT+lZwV/itnX/hL3p0kBQ=;
 b=MCXk/8kANvRKuGl9sbdb3Izapo/PH04j3Ohc9dOF6RS7Jhpd6dOOIqj7vnFDEyzFFoTNtXEdA9B8LC42XIAXPhr/rYY4RPcCzmXViEqMtCJk60SdhL+NLFHQa68KweHoq3uwdvR6fE6hWf+pZWrc9W4zj/Y69zQ7tpbSJx3+v3FmMWHpkKKqapWTGx2w9U4IvUTvZLDWYL7GH5QJTgZvLSuESR65Vi8D2+STMQ1WYJbpmCsZlvOdxMh4qGaQYuZiaDe3GXkud9S4Ulb8/gUe3hS0GYKxUOVulP52oNmAkpSlh2MD2yjse4XEQNrLaZuoFJ3+ywsAZ5tOxFcGieRVxw==
Received: from SA1P222CA0112.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::25)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 22:29:34 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::97) by SA1P222CA0112.outlook.office365.com
 (2603:10b6:806:3c5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 22:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 22:29:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 14:29:19 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 14:29:19 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 14:29:14 -0800
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
Subject: [PATCH net-next V3 07/14] devlink: Allow parent dev for rate-set and rate-new
Date: Tue, 25 Nov 2025 00:27:32 +0200
Message-ID: <1764023259-1305453-8-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
References: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 900c2ee4-86be-454d-8177-08de2ba8f1aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?piEZSPqyh1JP2NkmRSUw6CkyB1+Oiepy3bn0vKCHQhlQiVYx9L/bEzhNOxPo?=
 =?us-ascii?Q?Qlhl1T9aafa4sg61sOBkX2TjnZ+KKRJtG9k/cPKt0OyXoSdpDJqvJg7HcXD1?=
 =?us-ascii?Q?6iDSvC12M2urWUfHYHO1Y7gxeF8Ld/37rHfm8SvlYFnklo3IF1e5I3GipU9u?=
 =?us-ascii?Q?1gfu02pccjoFRVkuoyOPrXnvh0wFRSOJeQX48+JVhDo9gq+wb2yQx+kHrs9Q?=
 =?us-ascii?Q?pi8UtsYWA2lPmNyvMBQzvfdDWrgsqFQYS43DPCfJtZH2t1SUxclEJ7w+mGSJ?=
 =?us-ascii?Q?ul25mSG9YGYfa1JyE5ThGcQatuo6/ByOHQ/qOliX3ecvxWxP27Wwb49FhZGk?=
 =?us-ascii?Q?/RoRuxAqktJQc+clpWI4RlXbdy+5nK56T2m3NStvwlGntPEl8BFmA0OgZDeD?=
 =?us-ascii?Q?o4K9ZDvfHdPjv3fd9/sotU7J2rlM1QPOjoyqYEGbxHsP9hchffceJOgaESCH?=
 =?us-ascii?Q?HCH05A+kuoSjzfcUYYkq8PvsciCNgLLyYPbDHJVJltAQM9PwcE717cZhvLy4?=
 =?us-ascii?Q?fQfAxQU2cwQttj9dq4LLMtRa0W9vtJgClbeAVwExEGsqhbINsIaeauzAr8Zh?=
 =?us-ascii?Q?ROZSapupkKZ4ZwIKyb8XnPgCwHjWDLsN46AB8Ch028anEngtoxL8D9cKXEcd?=
 =?us-ascii?Q?JmkrC0w5QQfUsZJr3wg1sgBuYKqD43FKTA52kn9PJbASuExf5flUpbsw9fnr?=
 =?us-ascii?Q?d/LdBvNaKO7nVky0AcAUQXMNSF3jyz9c4grz8qHqTaIuL2f4j3LgQVa6i7Kr?=
 =?us-ascii?Q?9rNxPLWFEt71m4bBqYZNJtxHM9mXguh+qN3E199QB86jmhU17ZH/qCboBbck?=
 =?us-ascii?Q?jPL5XFWp1loihOevZpYAG4GisShhVry+UL7gZePubd1nMsoL5HJQFgdFegt9?=
 =?us-ascii?Q?kW/N7yrMN9j2xDI6K0keI+0Hl+mKJEi35beVYH54Okc8GBu1z7sTbk93BUWr?=
 =?us-ascii?Q?WLLXbO4GuZ9wuGLD+7XmmfcYyUv4I5Z2fYpsKvYj6iPVYhwKJr5XhaEvkHIt?=
 =?us-ascii?Q?5S/nqt5jd/w2W3XI39/zXgcjDwIAQEziS4ad8amrraQ7qQkKZT65in8mtwE2?=
 =?us-ascii?Q?DrrBsksu6ZFSF43UYa/Ierk/4Ogby6Yfyg2Gc7BQwrd4tev7JBX4dY2CxsUo?=
 =?us-ascii?Q?/Bp6y2QY2XukYi1xh09UnC2TKPIA6jqYcBAV1/4UVH1eLSklbiUwPewg8owq?=
 =?us-ascii?Q?n4COuWDAK5pW4x8GM1ubPHUyXwd4grVvpJUraUcwb+IWpcKnp2/i7ucwum/6?=
 =?us-ascii?Q?n5UVziVDrrYinTtOF8us85cyPl+jx7Be4oX/Pd9rn8YdJEL4z18PrBuVtp3p?=
 =?us-ascii?Q?wCzMQgqmPsVCMTdyH4p7onYOBM5l6kyTmiY+gzEttbbMwOuC+9mej2Ge9at2?=
 =?us-ascii?Q?ykFO7yzuWluP1wVilvjFKU9JTLNSpp43ofPwmijSTlojsR+8so6JRH/Di2xL?=
 =?us-ascii?Q?VdCOXQD3UcV+U+EWmaOqWb1wy/x93Buem9+r7kcgX1QAl97PApsVRhJdbSEC?=
 =?us-ascii?Q?+tx0LSSO4lq3MYrtRZSiv+DZ0Xxh8koSvGp6DDWDtVzJzbxxuQGZw5y2n+N0?=
 =?us-ascii?Q?JnhBVn8728F9Qu+ndWY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:29:34.0930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 900c2ee4-86be-454d-8177-08de2ba8f1aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906

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


