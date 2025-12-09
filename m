Return-Path: <linux-rdma+bounces-14941-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 129F2CAFFF3
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Dec 2025 14:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71ECA30C6A4C
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Dec 2025 12:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C65329376;
	Tue,  9 Dec 2025 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jBJJtlx5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0351C701F;
	Tue,  9 Dec 2025 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765285027; cv=fail; b=QleuzhTsRAKi01SVTzHeB0YaFk8f0+L2QzDB8h09zWASk2WgCwfuL3PouN2R1u/gE4wwK5hDdQkLrhsAUGwwqHvlDw0lw29oB4KmH9pQ8hLufmskuLXEu7Mh9TejYyrW/BR9rektJqtsX6WQp4D3usg2gQEwF/NQBKvcw+NZmzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765285027; c=relaxed/simple;
	bh=xXMzTOn9TrQozecYWXJVUnLdm9AuZLHXmT1x6McPKYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNNX5Y3XaHv43k/aD6QTh3dp4PuIrxxNQUu6dlYWILLzCF5LOyJEHETFY6LiqS7v8cjKKcTSFwpET+rpImos/3NkmsAanmMkLsmTf3sB/0DxHM97/cbkC8bjrjvDwAxkm03FAgBYK7nLDoU5XJXMyFeAi4L2iNgGLNca5c2zG+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jBJJtlx5; arc=fail smtp.client-ip=52.101.56.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlXfHbOf+l5xdYGhzlIwZez9lpLrnAMlNRvWHjWKpvjiDnWr2MbDJ/MP51IVsAlQZBRPGrVH4fprFmTf22mxNEZP/cHnT4OSGqvTBjXVfM8dXUuxhR8aQAjEifZMTN3o8YnSw4UkcRu68qv1OHo+NAm5BOEw4z1+s0o2/ZQrELlZuaawe0K+uhwiWMMVrzxkg5Ia1EhkGD/s7SVDc+DtvJ3iLKJulmFB+DcQLGJF3BvH/0OeVnc+RwxfNrYepP/udLPaubceKt7AEJCff8y1BEfnHgr5cwgemQNrQBS29+LRmTcqnnpkl1d7czGy7OxUolVazGry+TdZWn4boiX8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvxJIzN6bOO22nLlovBTPtpoEM7kx1wb/usOwR0nrX8=;
 b=ZgFfY0QJrc1UfmZhAEtgd0LpuewkX4xsLmKgNIVutPtAnJwn0naV508Sp/DtWFZ6cFgd+Thq/ewikLxPyHpX+zQMhQTLCoLbl320bngTwaON7PwV+v8hpdVFAW4qqnVejjEiO4IBmiGWCjj2Vh0fM+qT3ZeY7SVsWyFni9tsTYm4d29H+jmq3JleqT9NF4zAFIdNp1Zo0b7gooWNw8wWy3XsTv3SzQd7ZUIJS1sPOW905NZJ5v+be1u7lBzV2LobnWD7tIgz/Ugks/mrZPBZaQDtL6BUEDfoIIRK+8QBNqRwnGavugDf7rCUnc43aTs96O2uzKJWJmuOa/Kb0RiUzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvxJIzN6bOO22nLlovBTPtpoEM7kx1wb/usOwR0nrX8=;
 b=jBJJtlx5WIeAsOB2zzzScL3fJdgtRj/NXlxpk1cLYEdYlBwNkOZdCQvsCdjygezIjEK1Ag8xDChj3eBZWI1OJpdX8+f8IPg8kQc154SJt/4yK4+vTEso6pvxiSR+CgtbZphVuTgVswi3zXC+DyZsjYhYA+kpC4qGZb0wWI0Iai33CkvhSEmWkQAb2VQCZtkgBRfP28hU+7KBxgeRdqCnXUw2O+kvYvOwCYTGTrxVJbQJGJuDnvmFMV92JHIdsCvj4XaaOLy4ZqiQRq3eWtS5wasaiZBmXHvdKUFn85W6beJHThqCaGNAczUU265he3VkptqCqNM01CxQCs4ZkMXvHQ==
Received: from SJ0PR13CA0065.namprd13.prod.outlook.com (2603:10b6:a03:2c4::10)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 12:56:59 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::be) by SJ0PR13CA0065.outlook.office365.com
 (2603:10b6:a03:2c4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 12:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 9 Dec 2025 12:56:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 04:56:48 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Dec 2025 04:56:48 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 04:56:44 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Breno Leitao <leitao@debian.org>, Alexandre Cassen
	<acassen@corp.free.fr>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net 3/9] net/mlx5: fw_tracer, Validate format string parameters
Date: Tue, 9 Dec 2025 14:56:11 +0200
Message-ID: <1765284977-1363052-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
References: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: b8536ee6-4293-45be-8db2-08de37227055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024|13003099007|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hF6U+BFIe/jHGAtBLUg+54rsuNRWc43oVwa7wREWhncrga/8lPmjaCF3KgSU?=
 =?us-ascii?Q?3AY2ZNZwF5exX3tUiCJSsaTx6164b47z96TBhiTLDDi7f0OyaHvJx71mez9X?=
 =?us-ascii?Q?oCcQxszgXATAlMovgmwv6e01mava+whTLI51EHqqzUFwJvPRbc6/M1oRer4Y?=
 =?us-ascii?Q?SeMkOeudbyLwdRjIbiP0PfuKYuZtMI1jHHRU26H6NZgYqwLAL/GnV+l9XSk3?=
 =?us-ascii?Q?opytufoAelPY0TMCxPRW82k5EpR/ipokR3L7B9WkF27GVKwXkocD9bOXGyrt?=
 =?us-ascii?Q?U41bm42/XyhYoUYKVfPlk50YnHc44aMymxWcXbdJTiF+9WDfKAFmEZWkeMV3?=
 =?us-ascii?Q?melB1Osirs5uiVZYVULihEJ2QMjFb2YuHQ2swVqNmEH7n5phD7trECehM4l3?=
 =?us-ascii?Q?FEw93e2BvqZvTtFuigW0lFL28cZU4T3rzrRVen5qm3PuYaHpeXmoaJgbqUO3?=
 =?us-ascii?Q?qmFgmIQcWeX146gnRvUbXclz8GYTwHgH/Hxvd79BwwT7WLDgCzTNi58W173f?=
 =?us-ascii?Q?vTFcX0uuwicrwUFMlnjDv/4D6Gf9igAeexaFAv2V/QU3GVo/sYGNBpPn5WZp?=
 =?us-ascii?Q?MB025wZ08+VlRmeOyrxO4lVqnUgFWL8Oz/6H+z55yotKpPa/XJ8Le1n/DYo/?=
 =?us-ascii?Q?K4dhlC2zq1Ewoxv7Z4085niLY6eCxe8OWsfy0rt9iqBau5gt4gcelA/RtCX3?=
 =?us-ascii?Q?XGbXynlRGVPfLs0iOFcO8Zk514UIgJsiiidTyWYfiNq6dQ587jRxPvFnoVJt?=
 =?us-ascii?Q?L5kYALxyZ+3wmeXxHjamqNxVfKmi4mOpi7wjN6U66M/LhBKQ9a6OFVTivMJI?=
 =?us-ascii?Q?4U1soOUFopNjabHmQe5BKZPjaCfB/JktSzTOw1wDWJWUgP4598qht4km4VTv?=
 =?us-ascii?Q?qIzLp411Sfr0NhZ9NU4PX2qTW4QLrjAzNNzH8S4aoeXP7IpdyitiDbxa5O6q?=
 =?us-ascii?Q?RIdp30DbXtxevYznE//10yeXfjjaDhm8O6/2rd4kv0OBu0W9pa01fbVVMJCE?=
 =?us-ascii?Q?dIQ3/4rXOqepY3AJDCYTR4VqArEdeOXjUExVTszx+7l42EQ1p2ppdhAZeZWC?=
 =?us-ascii?Q?UwglWIvcTnC4uakRQA1QJCBOv/EJChahV6C5i67LeOV2oVVnOO7oWt4rOs3V?=
 =?us-ascii?Q?7u/fPJ6KrYY7ZC+x9tKApRanmGp/DLbc6eDQu/ch0E89oJ+LBrjD2z7UNC8i?=
 =?us-ascii?Q?dJCHvR8nIBHsFMVWoaLfjGQOe6LjZBhfLZnkKt11JOah6QlrKH9mHe/HvehP?=
 =?us-ascii?Q?Rn+zv3JXcUbNOULI/ebAmWNY+HJPIDxgQBhM+/x5/sNYW8LZv+/vqpZ2GJGV?=
 =?us-ascii?Q?5aQFsdlcrECbdBTSx816PLuAxuU2aYOz2/b9LLxynbUe2BqS3UP+21FfmK9b?=
 =?us-ascii?Q?fQkPoFuOFzDaNpDhgONEyr1ocjHzsiA77djTls+cKZNXGQITYO/mLJxXMwRy?=
 =?us-ascii?Q?zhlcjHh78avWNDcNZ/FI6+O1IVjAjwFpB4HtTeZxSnmCUFvxr8m7qLai+Fbu?=
 =?us-ascii?Q?AhXxs3Om3L/s/eKrhsQ5H0CbhyAxoHQYf7tX0N2vPN6F8mVsveKVwAjc+Lwf?=
 =?us-ascii?Q?wLOxh9he7eHNp3FEQ1N6gqFE4ppyZOhb/3gjra9zjEGhVm7VpHG4XocrjC0p?=
 =?us-ascii?Q?rw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024)(13003099007)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 12:56:58.6064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8536ee6-4293-45be-8db2-08de37227055
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903

From: Shay Drory <shayd@nvidia.com>

Add validation for format string parameters in the firmware tracer to
prevent potential security vulnerabilities and crashes from malformed
format strings received from firmware.

The firmware tracer receives format strings from the device firmware and
uses them to format trace messages. Without proper validation, bad
firmware could provide format strings with invalid format specifiers
(e.g., %s, %p, %n) that could lead to crashes, or other undefined
behavior.

Add mlx5_tracer_validate_params() to validate that all format specifiers
in trace strings are limited to safe integer/hex formats (%x, %d, %i,
%u, %llx, %lx, etc.). Reject strings containing other format types that
could be used to access arbitrary memory or cause crashes.
Invalid format strings are added to the trace output for visibility with
"BAD_FORMAT: " prefix.

Fixes: 70dd6fdb8987 ("net/mlx5: FW tracer, parse traces and kernel tracing support")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reported-by: Breno Leitao <leitao@debian.org>
Closes: https://lore.kernel.org/netdev/hanz6rzrb2bqbplryjrakvkbmv4y5jlmtthnvi3thg5slqvelp@t3s3erottr6s/
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/diag/fw_tracer.c       | 83 ++++++++++++++++---
 .../mellanox/mlx5/core/diag/fw_tracer.h       |  1 +
 2 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
index 7bcf822a89f9..b415dfe5de45 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
@@ -33,6 +33,7 @@
 #include "lib/eq.h"
 #include "fw_tracer.h"
 #include "fw_tracer_tracepoint.h"
+#include <linux/ctype.h>
 
 static int mlx5_query_mtrc_caps(struct mlx5_fw_tracer *tracer)
 {
@@ -358,6 +359,43 @@ static const char *VAL_PARM		= "%llx";
 static const char *REPLACE_64_VAL_PARM	= "%x%x";
 static const char *PARAM_CHAR		= "%";
 
+static bool mlx5_is_valid_spec(const char *str)
+{
+	/* Parse format specifiers to find the actual type.
+	 * Structure: %[flags][width][.precision][length]type
+	 * Skip flags, width, precision & length.
+	 */
+	while (isdigit(*str) || *str == '#' || *str == '.' || *str == 'l')
+		str++;
+
+	/* Check if it's a valid integer/hex specifier:
+	 * Valid formats: %x, %d, %i, %u, etc.
+	 */
+	if (*str != 'x' && *str != 'X' && *str != 'd' && *str != 'i' &&
+	    *str != 'u' && *str != 'c')
+		return false;
+
+	return true;
+}
+
+static bool mlx5_tracer_validate_params(const char *str)
+{
+	const char *substr = str;
+
+	if (!str)
+		return false;
+
+	substr = strstr(substr, PARAM_CHAR);
+	while (substr) {
+		if (!mlx5_is_valid_spec(substr + 1))
+			return false;
+
+		substr = strstr(substr + 1, PARAM_CHAR);
+	}
+
+	return true;
+}
+
 static int mlx5_tracer_message_hash(u32 message_id)
 {
 	return jhash_1word(message_id, 0) & (MESSAGE_HASH_SIZE - 1);
@@ -419,6 +457,10 @@ static int mlx5_tracer_get_num_of_params(char *str)
 	char *substr, *pstr = str;
 	int num_of_params = 0;
 
+	/* Validate that all parameters are valid before processing */
+	if (!mlx5_tracer_validate_params(str))
+		return -EINVAL;
+
 	/* replace %llx with %x%x */
 	substr = strstr(pstr, VAL_PARM);
 	while (substr) {
@@ -570,14 +612,17 @@ void mlx5_tracer_print_trace(struct tracer_string_format *str_frmt,
 {
 	char	tmp[512];
 
-	snprintf(tmp, sizeof(tmp), str_frmt->string,
-		 str_frmt->params[0],
-		 str_frmt->params[1],
-		 str_frmt->params[2],
-		 str_frmt->params[3],
-		 str_frmt->params[4],
-		 str_frmt->params[5],
-		 str_frmt->params[6]);
+	if (str_frmt->invalid_string)
+		snprintf(tmp, sizeof(tmp), "BAD_FORMAT: %s", str_frmt->string);
+	else
+		snprintf(tmp, sizeof(tmp), str_frmt->string,
+			 str_frmt->params[0],
+			 str_frmt->params[1],
+			 str_frmt->params[2],
+			 str_frmt->params[3],
+			 str_frmt->params[4],
+			 str_frmt->params[5],
+			 str_frmt->params[6]);
 
 	trace_mlx5_fw(dev->tracer, trace_timestamp, str_frmt->lost,
 		      str_frmt->event_id, tmp);
@@ -609,6 +654,13 @@ static int mlx5_tracer_handle_raw_string(struct mlx5_fw_tracer *tracer,
 	return 0;
 }
 
+static void mlx5_tracer_handle_bad_format_string(struct mlx5_fw_tracer *tracer,
+						 struct tracer_string_format *cur_string)
+{
+	cur_string->invalid_string = true;
+	list_add_tail(&cur_string->list, &tracer->ready_strings_list);
+}
+
 static int mlx5_tracer_handle_string_trace(struct mlx5_fw_tracer *tracer,
 					   struct tracer_event *tracer_event)
 {
@@ -619,12 +671,18 @@ static int mlx5_tracer_handle_string_trace(struct mlx5_fw_tracer *tracer,
 		if (!cur_string)
 			return mlx5_tracer_handle_raw_string(tracer, tracer_event);
 
-		cur_string->num_of_params = mlx5_tracer_get_num_of_params(cur_string->string);
-		cur_string->last_param_num = 0;
 		cur_string->event_id = tracer_event->event_id;
 		cur_string->tmsn = tracer_event->string_event.tmsn;
 		cur_string->timestamp = tracer_event->string_event.timestamp;
 		cur_string->lost = tracer_event->lost_event;
+		cur_string->last_param_num = 0;
+		cur_string->num_of_params = mlx5_tracer_get_num_of_params(cur_string->string);
+		if (cur_string->num_of_params < 0) {
+			pr_debug("%s Invalid format string parameters\n",
+				 __func__);
+			mlx5_tracer_handle_bad_format_string(tracer, cur_string);
+			return 0;
+		}
 		if (cur_string->num_of_params == 0) /* trace with no params */
 			list_add_tail(&cur_string->list, &tracer->ready_strings_list);
 	} else {
@@ -634,6 +692,11 @@ static int mlx5_tracer_handle_string_trace(struct mlx5_fw_tracer *tracer,
 				 __func__, tracer_event->string_event.tmsn);
 			return mlx5_tracer_handle_raw_string(tracer, tracer_event);
 		}
+		if (cur_string->num_of_params < 0) {
+			pr_debug("%s string parameter of invalid string, dumping\n",
+				 __func__);
+			return 0;
+		}
 		cur_string->last_param_num += 1;
 		if (cur_string->last_param_num > TRACER_MAX_PARAMS) {
 			pr_debug("%s Number of params exceeds the max (%d)\n",
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.h b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.h
index 5c548bb74f07..30d0bcba8847 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.h
@@ -125,6 +125,7 @@ struct tracer_string_format {
 	struct list_head list;
 	u32 timestamp;
 	bool lost;
+	bool invalid_string;
 };
 
 enum mlx5_fw_tracer_ownership_state {
-- 
2.31.1


