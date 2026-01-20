Return-Path: <linux-rdma+bounces-15743-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EF5D3C17E
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40E785A33D1
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE703B8D44;
	Tue, 20 Jan 2026 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bsctbBtA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E383C00AE;
	Tue, 20 Jan 2026 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895965; cv=fail; b=Mo8VPaZ+emh/reDkDf/xm4xYqH3OEahObaRd4C25garQM91UE4/PyOBCWj7ZoaWjr7LtA5a6clr6JlMac8BD9kFUTQ2MoUM6YN7lC5PwGni2isa/BrO6khk+UVI54wiYyOCmFWgLBhxCmP25NRkGWp4vWRHBDKlcL3BuG+TbXos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895965; c=relaxed/simple;
	bh=0UDiLkalK4FBc5QpavK4U+AEv7jfjAHyFRwGKj4SB6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XopobQ+CfzQu975KhDJnrMPB5XiMcLSyWF8KeWHbbNnA3G/YTN20iMeQeArx80Mcsnmd2SZcZqnKDDDt+owMtCrYo6b/jWnv0fccljic1PgYnjZxTw5WoDs1sY9O98G8+BS9GClLAT90q4ihNTJH2dFopEtjhjxVcH+XW1CB7SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bsctbBtA; arc=fail smtp.client-ip=52.101.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTJ+QanOVeD3GZiCn/1/5ieeU1zMdfrChC1dHNVJBLY1UCuO1blzkkPDCb4y63aBWXuL0yqIXCvweXdcxkvNatVkQ77i2AOHSnrKku94PMjEfNoWru9gVjEIQosL08Ry+i7oc/yxJo0zJgNmImFW/gXamvvRBh6ISZ9NqiRvmQl0NdFjVmutEu2jLHEARnv0VyJcltyfQ2p/QNLJDGEaj/t/uRyf0qB7KcOFBIqYCqnPMEAilcKB6M+zVfpKa2oVbHvYmbs45MnyCMY1y1LW1A8usLHpiWXlvMqpX2fIn/SvgdShPwi/s464kwbM1tr9+2PsPTWtw9N7QkO0vQ75NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbO9ug2d8Ch+qnoVdGsDzyif78qyJD4itBUakR43yJI=;
 b=oXeRVDDy6uTy//l/Aj8+utdeaI85NXmrsVdNPhkdPo3pCZxdaC0suDmG9EJD5E5cHEocwkvPJJiHcy3t1XiR0CgOWHqzf9wkwjhA3Zt/EJWX98pME5bfcJdpDl7ZqjGED0KQv/z0w5WvxsuQWrYWw7nBdfbi9syNyLDsLTY/1SoWEsNLHy372D+ORegs4OGaynTeBbEvYniiO2piIuN8yvq6AOoLropU8nkZ0glAztNhCc4MOxW7cUb8VVHxatb9kMMh0wI05uOnPZfi0lTfgnVhLZ/A+hf89zNnWIY/oB8Vf7Mjy7KhpTGohsB/iBOCEKFsoTIJrZ+3kw1v8OM41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbO9ug2d8Ch+qnoVdGsDzyif78qyJD4itBUakR43yJI=;
 b=bsctbBtAtuerpZbe+mcJPa8oSQh0IqMa9XQ+42xSisbotEWgbRzDIvJMTCHuPkVhSJ+euPDtFn5+ZYGhnyi2LMS4ppQcCKg8GhMXePLINhiRtYQ8E8J9vZT5XcndfZx7nBEQ5xCHi9nHG6D+622ufm7heIuvRUc2Y1c5RYHR3ioGU1sW/YuSTBU6RwlZUNDFur+h4rKr2ByGea4bYG872eLaqE8Qyo3caYvrbIkLWIM6BL1oU94o97Rg408ned0PbUkZp1U4kIqovgnvyCZK14ODJEZp4PzyhATF92CdTbANcZyE2W/UHqk7XNtSw8d4jaq8chLswSpE7LQp8xViFw==
Received: from DS7PR05CA0100.namprd05.prod.outlook.com (2603:10b6:8:56::23) by
 BN7PPFB3F5C406F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:59:19 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:8:56:cafe::bd) by DS7PR05CA0100.outlook.office365.com
 (2603:10b6:8:56::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 07:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Tue, 20 Jan 2026 07:59:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:59:10 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 19 Jan 2026 23:59:10 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 23:59:04 -0800
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
Subject: [PATCH net-next V5 08/15] devlink: Allow parent dev for rate-set and rate-new
Date: Tue, 20 Jan 2026 09:57:51 +0200
Message-ID: <1768895878-1637182-9-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
References: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|BN7PPFB3F5C406F:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c59d2a-85e2-4f54-55a6-08de57f9d06c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RA12Hhb0HnOI5PdIC4G9DjWO8s1EiIZzkKGs7HtBXA36PmiQ4Z0NzdMzU95E?=
 =?us-ascii?Q?P+aGKttP//evgIdu65YWuOysLNobXfyW35XnJAsays+/i4E0ifYur4GDZBoO?=
 =?us-ascii?Q?zZD8LlOAC0hph4PJ2eOA5WSh22Aal58q6Pb+Lq2diSuQ//hBOk3qptSH4Mpd?=
 =?us-ascii?Q?WcrZmczMYLyTH1+sq8ijMhg3CWle00Cqax4PueTy+daFTkX4NtpX3ZTkQGUX?=
 =?us-ascii?Q?gmynBdftbUC/XKz8kx56ocEane1P76zbfFfttQWV0URai/C3z5PRZ6250FKP?=
 =?us-ascii?Q?Vqw/Z57O10l3oEDmgk/VlQsq0/fclQTOkxm+MEme3J74zOcy1W4crw0tuUIU?=
 =?us-ascii?Q?/+0rF/vySd6reuR8pcKHa6aGX8I+EJy9BvXWYrtrdjURLXe1RcdE0DpOdoSK?=
 =?us-ascii?Q?FObUzt2EfQW9LoomuDPGp3BK1j4DbtSrT3KM9yRenCCB8RdkKhZD72BzIW4T?=
 =?us-ascii?Q?EfRBIUR6Nv+k+hJxERw2h7Ve6Yc+jeTC0U+1PE5Yf18UdGwRcwU+Oq7df4Sy?=
 =?us-ascii?Q?5Vc5uiXbNGN/UTkAarG5fcA1/AAGUR+M+pIU2d81ITfZpwkWtFviK56xeFNp?=
 =?us-ascii?Q?+C3hoVQaKji13RMcxrEcKRPX7bNSxx48AC8CuCTGvjMobwArrb+7X2MRjq+E?=
 =?us-ascii?Q?meWC9VZCOUySklITijwV+wMAyDpN58aSV4jSbf74gjTl6THqLREynXz4qUio?=
 =?us-ascii?Q?5nBjRugbiqGgOrT9zUC/Vf0rXJK7neWbdfjzEGitV3qpGjDlU7l+w0gAr1Fq?=
 =?us-ascii?Q?w+6gg/hT3dZnOg2kBmQFkpjfGdES5xUfM861j9EsDcBZKw1h9VLawvurBEr/?=
 =?us-ascii?Q?x2HvCohV7E3gayOtot/FbjvOnghZega8FyLjAUUNo1Lxa/FqLixn7l04ZBNz?=
 =?us-ascii?Q?c39TqtEJo3VsFfrSK3wk6yF7s67L5vIgg0WdTo4lPAkQOUzHjFEchT3jnAbS?=
 =?us-ascii?Q?6TWw8tzErWzgo7yAJVYnHSoEzESLCY235EsBosChUZl9NQkMtRBaQGpQS5Gr?=
 =?us-ascii?Q?6j7deL8tvPMmcWqhVWgngmnLbI9R0oYszsKE/mx7GF4sIvL52XjeSF4OglP0?=
 =?us-ascii?Q?UJKQ6ewzX8oREKEo5sZqZZziAWUfTfsXyHCTtf5JqhXWT08XMuEPrIPig105?=
 =?us-ascii?Q?D2uUffLhWvhNxhale7e1oa8I01NxnvilM1jwwva1x5tvbYFQY2tkQEuPacBh?=
 =?us-ascii?Q?9IE7KwjDoZlp/S6dRQHSr39HURcfXSgtI8FfBtZGhmpS2r1JxCfjK9Jgocg8?=
 =?us-ascii?Q?CEZXFfECTsESo+W6FuHH6HyrVR9iPDvXxUIIXS0PKBdw8UPVZEqaZDqGdPRS?=
 =?us-ascii?Q?9DtqkZ+EED2fVm6Ce3qMSee4uygc/ZQGIQBiMP+7SPCE411Gtd+QgLKTwVWj?=
 =?us-ascii?Q?wsGKN6vnCMpwqS1mNrLN1n/vuBlyjXcSgVm+6gmwOan7tAl294NOkL88HRYs?=
 =?us-ascii?Q?3iL+DwTQ6xwPQz/WVxv7HN9D/d+Zbi1XvYuoq/1GSi93OnsJnuDV4RxqM6bE?=
 =?us-ascii?Q?Zp0+Wlz21G22ykMe9NhITpakEe4QEmgBCYm+vAYrytf4M6THu8Yv4kpiXlqS?=
 =?us-ascii?Q?TgxYFcmjr+XCS++T9tk4iimMacze75v6B/oBvX24ePaFdv+sSbl9OH0JN8Fm?=
 =?us-ascii?Q?iBbEKaV5tGN+u+o8YQ7skmSFY8fHAqFjJuxZW2smlOn0e90PWh8VUFIErbnh?=
 =?us-ascii?Q?ztBM1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:59:18.7259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c59d2a-85e2-4f54-55a6-08de57f9d06c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFB3F5C406F

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
index a8fd0a815c0d..c81c467f144f 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -2218,8 +2218,8 @@ operations:
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
@@ -2231,6 +2231,7 @@ operations:
             - rate-tx-weight
             - rate-parent-node-name
             - rate-tc-bws
+            - parent-dev
 
     -
       name: rate-new
@@ -2239,8 +2240,8 @@ operations:
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
@@ -2252,6 +2253,7 @@ operations:
             - rate-tx-weight
             - rate-parent-node-name
             - rate-tc-bws
+            - parent-dev
 
     -
       name: rate-del
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 6b691bdbf037..f82656d6d7c1 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -536,7 +536,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_PARENT_DEV + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -546,10 +546,11 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_B
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
@@ -559,6 +560,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_B
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
+	[DEVLINK_ATTR_PARENT_DEV] = NLA_POLICY_NESTED(devlink_dl_parent_dev_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
@@ -1202,21 +1204,21 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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
2.44.0


