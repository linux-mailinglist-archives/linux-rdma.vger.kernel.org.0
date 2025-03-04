Return-Path: <linux-rdma+bounces-8320-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 983FBA4E1E9
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 15:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC88317CC70
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 14:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE7C25C6FF;
	Tue,  4 Mar 2025 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HuKM1jww"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967C626A0DE;
	Tue,  4 Mar 2025 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099621; cv=fail; b=S0fwZ5JYJ2Tc1Hv6voBF4lGmFQ0OELV9PiIZDNvtQPqwfqRA1frOaSUHF5hQmqCSKORjOSFsECPC/hGXSSvk2FsQD0AiHKmFaN4L9sMtvzq65ChN/bUjPG0EYTAfeuKzL5/sTh0I9j5gNHEzJN1MTQdFPuwHkx2iZONFpqDdGDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099621; c=relaxed/simple;
	bh=tfGWtadPK8LMvP+WRH55EPqWutKekk91WqJRI4aZBU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMSmSX2xc41WqGbRZHKdRT3FCmkaSb3odkUvQ4UyEAx3iW+yZrtld8gf2CuiclzgqUNuBnt89itO1UB4XIMv1ntbEq5GNFBrjPaE/ehLnNusLoeb4572oBCNyZkyTBH6lGknrXukurH9xrdJw0R4CUahUWU6s652Adikp6JfJnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HuKM1jww; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOqRmG1NLD7Drfvkxxrmr0HX8D3RDZmopJe9Bwug3L3qP5IMUUB4U3Xy5bVDsxs1qsskAfV+iCKJe2CcBGw9NTIjbaX/ABUvnONyhjjWyY5p4KVJtOoiDVyGrGfNmLCbDgVoPq/UOM4m6lBVfUOMSpbW0nUJ5Skh3E5wtkehN9G/XWv4pCqYtDPmQzoGE5WD3DibP+6Akn5q8GthwnHfRcOS7hzjWR6XRjG1fZOZQwnaqEB6hc4cLemN1jMCsPWU1aeF9iVAiV9X9dcOK9JmK7JpIncvPonQjdr/MEAqZ74ij1TXYWrfvk6CV9He+FXNutHSS8iu872CYtjl+3qvJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7vCV7+OsUltXOkyJyEX4OaAL2krjryTS02ZFkLTxZE=;
 b=VwssP2uojk/BisnLav5M/x88Hp9ybXgOvUMB5lKdlsWODjSkIah985VnLprJu6sGq2Np7iJcNgkRJCc2Tpgr4XvI/aQXDdGd4tAdjodaaRyoV1iewDB18w2WNI51N5DIkIEFFQ3I8J0AIeDSX5Eq4FNjVWBx9CFwucMkrjDOjB4g0TdBXJHNLYoulT0eKcee84ltpvtumeS3+3bXhahJjj1KKgjrN3nKyIttQiy7WK97xRXd/A5S7+Mz+bykiIK+jtyLerGyP8qzvWelOVI6TTgcBXgoB5Y27+vKKkuZUx1wI2k0Rx/eYBiB5BZFvSWR1hHUC+JZ/vlyYNLJoiuEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7vCV7+OsUltXOkyJyEX4OaAL2krjryTS02ZFkLTxZE=;
 b=HuKM1jwwu+i0F4p0xPRMZVrBNwDUr+RkgnK87sQEqplkVMbfNHAH6j46cSJtY8+j9tGfnhGh+/WmwU67YrpSpiupngx5qTqid4SiqnO7a4IfVmKWBVsvrT0UUJxyY1FRdzgzzB3yqKaf4MJRqc5/4WFaVWEvSe2GuXDwE88wGLN5Bwgz7k54qwsO0KsVa7JDNlO7iuBhvxJuwp5O5MMpc+xIw8N5xiG7jvRVydtFgkd0zxOgp5ZGhlhlymrQHmKpbS9POxoxtULXjb2xFlF+ixDBGeaf8NDMxciW/ZotdvezHqUgUJAE/oHm6SZPaasQquQ4sYqg5h/UftIqcTh/+Q==
Received: from DM6PR06CA0076.namprd06.prod.outlook.com (2603:10b6:5:336::9) by
 BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Tue, 4 Mar 2025 14:46:52 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::5c) by DM6PR06CA0076.outlook.office365.com
 (2603:10b6:5:336::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Tue,
 4 Mar 2025 14:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 14:46:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Mar 2025
 06:46:43 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 06:46:42 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 4 Mar 2025 06:46:40 -0800
From: Patrisious Haddad <phaddad@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
	<jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [RFC iproute2-next 2/2] rdma: Add optional-counter option to rdma stat bind commands
Date: Tue, 4 Mar 2025 16:46:16 +0200
Message-ID: <20250304144621.207187-3-phaddad@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250304144621.207187-1-phaddad@nvidia.com>
References: <20250304144621.207187-1-phaddad@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e6b603-17e4-40a3-8c49-08dd5b2b6699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KsitoqliHKqhgGqars94MSQeHdnDzHYrQJmVj5kJ4UxVxWIxTFvDUi48Yodr?=
 =?us-ascii?Q?zL+pb8USsmuDlYqAGc+66JZPayp9p3AA3cBnnfwZvqlBOGFwFBHw12GA2jJS?=
 =?us-ascii?Q?pp4vzO4UIntVSyG5Tv2qbWnHFle42VDDgZds9+pTi2qguZ82s1/tLNJYH6Xl?=
 =?us-ascii?Q?T3/+SrXYF2gFu1npRNvAhTP4LQNGH9TKB+8Yl6EbrAObMPj24lvq5q+21gmN?=
 =?us-ascii?Q?kxX7gWey4tju3+decjIYvurl38TLPJv5cIi9fahV7t38Wpa254WfvC/BhH3c?=
 =?us-ascii?Q?jO8Zb3bZwQq/MFPT8zALxIPQAw7Q1WpITaYzrpi67Q5n+UJJI29p6CeQfMwF?=
 =?us-ascii?Q?505MJht32NclF1bcthBa0Ua83pZ9uPci3uoZMPhC0yKgAU57lw/rAyIEIbZF?=
 =?us-ascii?Q?QepGzQ7modMwxenoCfYs0/q4L/sEKEiGuLURhqaeyZ7wfOjUuWqfCSbRXcTa?=
 =?us-ascii?Q?K81UMgOBa9/kQ1iUchn5Jz/FJUpbx83gqaRzImnSvLbfp67ghInSG10r214d?=
 =?us-ascii?Q?ptTarc9szbK3x3gaud/c9Rnp+RB1gBDwjfdJadJg74O4K0jZXK52SDnGyhPl?=
 =?us-ascii?Q?F0QgWp5sObrwGQew50ij3qrf0D7PkcUlD8MACDprR74jXbGJve8zqmiWtmef?=
 =?us-ascii?Q?kIGVGXzRqjX28HYXCNpjXbx7hB2yR0w1I4cA6yx+DyU9k5edP3yHtDaDrNCe?=
 =?us-ascii?Q?wvzvIBAA8UTt7PVupziNcG+PSPGfP+743tb8syYVmLO35xZqwvgRHGthdBxf?=
 =?us-ascii?Q?abPg3A1V8Jxh8hbh6O5tSIPwMXV49frL4GpXv80d3rBVToie8GMhooCCYt9K?=
 =?us-ascii?Q?QdzKg4zcE+6Eqtnh0PNO8hICxlE/rCnYN2+CFHcPMvYvxUElY7OSMR8odfS2?=
 =?us-ascii?Q?n/sLsGZ7K3xAnnft9xQBZvb1RddncJrBKYIqwPK5Ljn1OoMF9izvVLINBakp?=
 =?us-ascii?Q?9Pf3JnODoapv0UMsUUGtCxotO9jF0qE2Neu/MrdyCGdiCMCSuUcynJZCmzeN?=
 =?us-ascii?Q?8P/4ig8Nv1/AzBsGkIYW6oXEOzNLafcZGa14SfXBNOGbPT/bEtCyavddXEUs?=
 =?us-ascii?Q?zCsyNXE8F4O7TxBrJwv6rZc7orO88weZpD751y843UHFuG911z6+vCh+Yg1e?=
 =?us-ascii?Q?i/0Z1m0NvzfDMP2PeILt/OrySwh3IaJT2f/pgk8JiPfy9b0/8DxgZZsk60MW?=
 =?us-ascii?Q?+9D4RCbIrPxz3xFYKp2Q1+CuFDkShSNLQe67lxtv2t2mEOokG7mgGkom5Uoj?=
 =?us-ascii?Q?IuAA4vTNHF+x2U6sft5RYGXSbH5RU1VTRm8mnmvJ7gNkLYO29ltKJPv/4qeu?=
 =?us-ascii?Q?ki+cXbik9uvemC20J9P4mahrzKTaRvvYyXCWNc3v40ncqrgE9zCQMB2/u0uT?=
 =?us-ascii?Q?rBXgk6t9DNgN1pZ0HSBcWld0au+cQWWVbbhvM478gje5JShEdYrpKN8Y45C6?=
 =?us-ascii?Q?pWHlwcUG9MTdIkj1rR5X3k5mSzy/014Vel7sFVEXmflm81/D/MwBQmRPqla/?=
 =?us-ascii?Q?2DGlBH8MEedAdxY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 14:46:51.8288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e6b603-17e4-40a3-8c49-08dd5b2b6699
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619

Add a new optional filter named optional-counter to commands:
rdma stat qp set link [link_name] auto

The new filter value can be either on or off and it must be the last
provided filter in the command, not providing it would be the same as off.

It indicates that when binding counters to a QP we also want the
currently enabled optional-counters on the link to be bound as well.

In addition Adjust rdma statistic man page to reflect the new
optional-counter changes.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
---
 man/man8/rdma-statistic.8 |  6 +++++
 rdma/stat.c               | 50 +++++++++++++++++++++++++++++++++++++--
 rdma/utils.c              |  1 +
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/man/man8/rdma-statistic.8 b/man/man8/rdma-statistic.8
index 7dd2b02c..337e31ef 100644
--- a/man/man8/rdma-statistic.8
+++ b/man/man8/rdma-statistic.8
@@ -39,6 +39,7 @@ rdma-statistic \- RDMA statistic counter configuration
 .B auto
 .RI "{ " CRITERIA " | "
 .BR off " }"
+.B [ optional-counters | on/off ]
 
 .ti -8
 .B rdma statistic
@@ -180,6 +181,11 @@ rdma statistic qp set link mlx5_2/1 auto type on
 On device mlx5_2 port 1, for each new user QP bind it with a counter automatically. Per counter for QPs with same qp type.
 .RE
 .PP
+rdma statistic qp set link mlx5_2/1 auto type on optional-counters on
+.RS 4
+On device mlx5_2 port 1, for each new user QP bind it with a counter automatically. Per counter for QPs with same qp type. Whilst also binding the currently enabled optional-counters.
+.RE
+.PP
 rdma statistic qp set link mlx5_2/1 auto pid on
 .RS 4
 On device mlx5_2 port 1, for each new user QP bind it with a counter automatically. Per counter for QPs with same pid.
diff --git a/rdma/stat.c b/rdma/stat.c
index bf78f7cc..2c1bf68e 100644
--- a/rdma/stat.c
+++ b/rdma/stat.c
@@ -7,6 +7,7 @@
 #include "rdma.h"
 #include "res.h"
 #include "stat.h"
+#include "utils.h"
 #include <inttypes.h>
 
 static int stat_help(struct rd *rd)
@@ -62,7 +63,8 @@ static struct counter_param auto_params[] = {
 	{ NULL },
 };
 
-static int prepare_auto_mode_str(uint32_t mask, char *output, int len)
+static int prepare_auto_mode_str(uint32_t mask, bool opcnt, char *output,
+				 int len)
 {
 	char s[] = "qp auto";
 	int i, outlen = strlen(s);
@@ -90,6 +92,10 @@ static int prepare_auto_mode_str(uint32_t mask, char *output, int len)
 		if (outlen + strlen(" on") >= len)
 			return -EINVAL;
 		strcat(output, " on");
+
+		strcat(output, " optional-counters ");
+		strcat(output, (opcnt) ? "on" : "off");
+
 	} else {
 		if (outlen + strlen(" off") >= len)
 			return -EINVAL;
@@ -104,6 +110,7 @@ static int qp_link_get_mode_parse_cb(const struct nlmsghdr *nlh, void *data)
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX] = {};
 	uint32_t mode = 0, mask = 0;
 	char output[128] = {};
+	bool opcnt = false;
 	uint32_t idx, port;
 	const char *name;
 
@@ -126,7 +133,10 @@ static int qp_link_get_mode_parse_cb(const struct nlmsghdr *nlh, void *data)
 		if (!tb[RDMA_NLDEV_ATTR_STAT_AUTO_MODE_MASK])
 			return MNL_CB_ERROR;
 		mask = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_STAT_AUTO_MODE_MASK]);
-		prepare_auto_mode_str(mask, output, sizeof(output));
+		if (tb[RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED])
+			opcnt = mnl_attr_get_u8(
+				tb[RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED]);
+		prepare_auto_mode_str(mask, opcnt, output, sizeof(output));
 	} else {
 		snprintf(output, sizeof(output), "qp auto off");
 	}
@@ -351,6 +361,7 @@ static const struct filters stat_valid_filters[MAX_NUMBER_OF_FILTERS] = {
 	{ .name = "lqpn", .is_number = true },
 	{ .name = "pid", .is_number = true },
 	{ .name = "qp-type", .is_number = false },
+	{ .name = "optional-counters", .is_number = false },
 };
 
 static int stat_qp_show_one_link(struct rd *rd)
@@ -395,9 +406,37 @@ static int stat_qp_show(struct rd *rd)
 	return rd_exec_cmd(rd, cmds, "parameter");
 }
 
+static bool stat_get_on_off(struct rd *rd, const char *arg, int *ret)
+{
+	bool value = false;
+
+	if (strcmpx(rd_argv(rd), arg) != 0) {
+		*ret = -EINVAL;
+		return false;
+	}
+
+	rd_arg_inc(rd);
+
+	if (rd_is_multiarg(rd)) {
+		pr_err("The parameter %s shouldn't include range\n", arg);
+		*ret = EINVAL;
+		return false;
+	}
+
+	value = parse_on_off(arg, rd_argv(rd), ret);
+	if (*ret)
+		return false;
+
+	rd_arg_inc(rd);
+
+	return value;
+}
+
 static int stat_qp_set_link_auto_sendmsg(struct rd *rd, uint32_t mask)
 {
 	uint32_t seq;
+	bool opcnt;
+	int ret;
 
 	rd_prepare_msg(rd, RDMA_NLDEV_CMD_STAT_SET,
 		       &seq, (NLM_F_REQUEST | NLM_F_ACK));
@@ -408,6 +447,13 @@ static int stat_qp_set_link_auto_sendmsg(struct rd *rd, uint32_t mask)
 	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_STAT_MODE,
 			 RDMA_COUNTER_MODE_AUTO);
 	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_STAT_AUTO_MODE_MASK, mask);
+	if (rd_argc(rd)) {
+		opcnt = stat_get_on_off(rd, "optional-counters", &ret);
+		if (ret)
+			return ret;
+		mnl_attr_put_u8(rd->nlh, RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED,
+				opcnt);
+	}
 
 	return rd_sendrecv_msg(rd, seq);
 }
diff --git a/rdma/utils.c b/rdma/utils.c
index 07cb0224..87003b2c 100644
--- a/rdma/utils.c
+++ b/rdma/utils.c
@@ -479,6 +479,7 @@ static const enum mnl_attr_data_type nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_PARENT_NAME] = MNL_TYPE_STRING,
 	[RDMA_NLDEV_ATTR_EVENT_TYPE] = MNL_TYPE_U8,
 	[RDMA_NLDEV_SYS_ATTR_MONITOR_MODE] = MNL_TYPE_U8,
+	[RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED] = MNL_TYPE_U8,
 };
 
 static int rd_attr_check(const struct nlattr *attr, int *typep)
-- 
2.47.0


