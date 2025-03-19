Return-Path: <linux-rdma+bounces-8812-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82049A686BA
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 09:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660AE17835F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 08:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A012512EF;
	Wed, 19 Mar 2025 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U9nvzwBD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F405A250C1B;
	Wed, 19 Mar 2025 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372759; cv=fail; b=HRox5/uXT7ZPQ1MFecRwvO0jOQMvs10LQF3eBfLuX4G/wbA6h3NkQD6dFQppj93jam0sbqSGE8otPMU4bDlMM8GO5IiX9CXjS5+dSEbycMI7P7HQwIVyk8ruSz/uhC/eJVRlOh8lfOke2ebUZwCldunLwTEYC/gOe61Jfqg0RbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372759; c=relaxed/simple;
	bh=tfGWtadPK8LMvP+WRH55EPqWutKekk91WqJRI4aZBU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5M74bdp1jwX7qTCYY/bX21eF4zourP5tzfJc0691xccsitHS6RWh62r9N0PwqjDYDvuIjwq3R/ndzcJin0DbBNKmW4AFQccF8k72NokjvRvdCW8xgE6ZmK+RoZJ7nN8zVyEoGAQcw63un+QTltZBLxPXRxB6i5/GXQ8Eu74TEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U9nvzwBD; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSRa+sHte0MaPRD+ZDAidzwx4Q4o4CCKh9ZWHzWUZkUzOthkdW1csfJBvi7JVWP9J9wLq/fjS7THn8cOeLMMXLU5Bo0ezMVbnBrD2/vthUnVJqjekW8ocQFwuoZlPDOOdY7J+N4O60fUNEJsOKZj1QDGSjCY3jdu0cQhvyakbhmOBshUN+wI/6TUrIoswlkLlfV1MIjxtEcdM+syxdGhPZADr9opb30oRlWl0AcBUROXqX/FOpNbPSqYnxVn/d8QUlMWxUd3afRU69BKyK+m3UvRv2aIGljSBoDwzolLFg7AVcEIH49BML4R/5m65GIlzjkkQWg9nEHLc3S5mIa3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7vCV7+OsUltXOkyJyEX4OaAL2krjryTS02ZFkLTxZE=;
 b=lCA9X//LFR/uHvU2ouMD69W7ZddvXl1eRSDs6d1RP6HZ6hrJwWr8AsUQRhOKqiwXUT43lwG7DaHop6qZNtdvBnPoPcIBf0jY86sKgesB4uFgXqOlcpRnRAq4MXbEOf6lcjuodobxc27u60Cz/sVHn1DnLBU4B2udAHot+t/Ue5S/sungUGDljEXsuBIPKWsKHu86x7Ar5csKYMd8XaRdOOCA93poxwDptxeAZtLb40rXYbfLjb3fNhJhJmbKTZQV6AKgqFODHQNGnOtYgfy5G1bwIjhG6rPrXsReX88DJ2vXi9LJkEDFhCj24gISWhXDT06JI451FvwnCCmNwPRTjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7vCV7+OsUltXOkyJyEX4OaAL2krjryTS02ZFkLTxZE=;
 b=U9nvzwBDGB2oV+thvHXG/4nmIAhqdiKY+oR+MR43hQ33B405a/OKcXkby6sxYb/0b2/u4e4QLUX55gN+oRUzrFAK6jVLv2FuuPpD2/W49b3GwDUiflJrH6S8kjGuk3x/gStKv1twXbKQiw6zNzj3UtHjEYeQvg098Q5GifjzCIkL3J0gfxjOGsL+oQrq9mvzXpVVml2ogP629IRaaqsDLBi6KQfUv3F22IHToGUhVJgcTG3fmuCV90ix1+7YZljzg99hdvr4b7DF9G5IZKmH1kAJAVRvrpeSKH57S8Lo/1u6z5J/10ZgwWMIwTon/hsN6gTLZWRowSecza4jBszQtQ==
Received: from PH7P220CA0075.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::11)
 by SJ5PPF28EF61683.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 08:25:53 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::9b) by PH7P220CA0075.outlook.office365.com
 (2603:10b6:510:32c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.31 via Frontend Transport; Wed,
 19 Mar 2025 08:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 08:25:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 01:25:40 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 01:25:40 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Mar 2025 01:25:38 -0700
From: Patrisious Haddad <phaddad@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
	<jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH iproute2-next 2/2] rdma: Add optional-counter option to rdma stat bind commands
Date: Wed, 19 Mar 2025 10:25:26 +0200
Message-ID: <20250319082529.287168-3-phaddad@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250319082529.287168-1-phaddad@nvidia.com>
References: <20250319082529.287168-1-phaddad@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SJ5PPF28EF61683:EE_
X-MS-Office365-Filtering-Correlation-Id: 7768a39f-307a-4f7a-bfd0-08dd66bfa9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5AKBGH4xf98NpLHJuJ4fClRJgeCa0pbhArlLVnabf3JpOOKTv6S/w3313NIa?=
 =?us-ascii?Q?v1/BVkj0SN5HmGpCrVpwJMkxD7wus3gaielmRp2v4Kas5ioq9LP1iYgtb3k8?=
 =?us-ascii?Q?QMTfc454ebMIW38hhcS2Ce8bI6K62Sdv2giI7DZ75qobKse7Xw1S2NOzcXdq?=
 =?us-ascii?Q?MwavsRS/As7x4VRlqN6rM1SF8hR/UVtFsfOcCwlOb1fZ6QXt+E7BOjKyxVW9?=
 =?us-ascii?Q?3IV+PFsgc5vIxuyWDqJP/2K5tdXqlBlbO9Oc4ySfXvNpBfD3ndASz30OtGzq?=
 =?us-ascii?Q?wc4U3I6xeViHmInoIqmidhgC64l3RdE8hpB3wKKFinEbEk3DcV7CObYvdDda?=
 =?us-ascii?Q?Etop0OM5MuJnbhsO8oYUWW/L9+I84uQA6N0LWepJal+j7fpdkrgkRPdraR4q?=
 =?us-ascii?Q?JU0m0uAKQkmTnQgEu8jdMf/bF8qpnR8VGNcm1CjcwJZPQXi7YxRvqTDHaeW6?=
 =?us-ascii?Q?ctUyY2ZBZzuOG6pKKna3aPdZJOHmhQ1C/8lk63zO2YL3+M2KIP9b+5I2qrLy?=
 =?us-ascii?Q?MBSBYpnJPBNxM/RwCM338cuANKDpOYPRiuoP06qOgj6kK4v5xB0/BGnb0JnW?=
 =?us-ascii?Q?b53Vq3QnpIkRflQ6eruztBaSudYypUog8HKo7D8VQDXuzO3KQ+1Iz8FSPUoH?=
 =?us-ascii?Q?2eEaN8XFqEOYispb51qWmsklOJOdfEqeVcEiHOCiHxnkuwEEm46VLQt/C24e?=
 =?us-ascii?Q?indlFOvnflwaivkAWMLPrhUYF74zImo6GM5WDIX/JXorWmRjTqjY0+fm1t+M?=
 =?us-ascii?Q?3XXVawN30UHrfA6oyFVxd8vOvPE9iE7OyQsPgnnjyBC4eH7jHi3sFCy6cKrZ?=
 =?us-ascii?Q?S8lGY/dcGKZUmjxTPFd/8Hu1ezRh68vkmPm3S8jUj65Ham5loKkYUIBi8jRQ?=
 =?us-ascii?Q?zefP8E2dr9NoXi5o2LnKEqxT43jTlFCwP09FmJe6+27XdcK8j19oBu7wv54n?=
 =?us-ascii?Q?tP7232UuSzITra6Kvs/mLvo/FV1IezYnBVarcmrrhPZnPlQmuLmhjjR/gf+M?=
 =?us-ascii?Q?5NQlcATQausL4Bw51SlvV6sQtumnwSela2Qs33933VGMLcMDT48oLDOBA3Zz?=
 =?us-ascii?Q?KQppqbmWT6GCIHe1TsBMOvJ/xkaVmJ0CDjuT9eb5nQUKBo+RSWQVNmZrXoiZ?=
 =?us-ascii?Q?zIdMV/ZNPFbCtBsfpZ/5HveNU+yipPe7x5lwr0YyRkS0AiCrrzTGADPN7hIk?=
 =?us-ascii?Q?0XqRyaztIi1hlU7cug3jWZZPilMI8LosjAu/cLEjEwWIIUrlql0V0TJ3Iagp?=
 =?us-ascii?Q?crUU9O3PBbuXUaSuaueYq0Bc6rpcYuL5zehIksFeJsJ7AcipWrSM5VqztMVB?=
 =?us-ascii?Q?rG4Xv5C/FYZzzav20i/El4ahd+NoU596gPQnlQ8MMYAVmQaS+RSA7HxmkLH7?=
 =?us-ascii?Q?cgG1l378MAS7/VeyscgrrQjq+giVDhLrd3SJPLdt7w0Rcd6HzWd9vGlbN8eo?=
 =?us-ascii?Q?FqJD+ceFCdDTnNb5VNy4VJBt6CjG6hIl/DeQPR55o8yv7xvKhXTYOtj2gPDx?=
 =?us-ascii?Q?fJakmuCWmtfSe94=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 08:25:53.0003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7768a39f-307a-4f7a-bfd0-08dd66bfa9e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF28EF61683

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


