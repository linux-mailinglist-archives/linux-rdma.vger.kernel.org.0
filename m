Return-Path: <linux-rdma+bounces-13479-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7511B84337
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 12:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5CC016AFD5
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 10:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C585B2FBE09;
	Thu, 18 Sep 2025 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BubhRTfC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8F2C08AC;
	Thu, 18 Sep 2025 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192277; cv=fail; b=c61LFYuylnTAJPmxdHiJjm0pk9kXs+LTTDXdqFayBxXgDw/47/RYiigSQKpH169AIdIlZ8NSqiWoz5Nc8xzZAHQFT8Vui1ZffBZGNNo38q3WiJqow/cpgxPUCnmjfpiLzPik8ETEFum7TQlSaRoEw1pwKfWz4i2nZDx8pTlJvXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192277; c=relaxed/simple;
	bh=VoqeVIuuU+n4jSNKxwqKLlS5aDwAh4RWbgYJ8j/R5Ts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/UThf/PDcwvYJYzvT8tU7D1ImxQzPe5cGfDvwFFjM+gFxagbIqXSPK8WtQv7rEK4AWomSy27bgfU8WtaOpAvr1ArEJ/ZFFsxFVDQ6BbdDtlcuO9m0p/ONDpy8TJn/UY1kLhLOZzisd9EHY0BCFYHQGgQasXS0hsTt4x3XuKSFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BubhRTfC; arc=fail smtp.client-ip=52.101.46.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juCys61QGCGnIOAWwERvyLQiTTOQX52wSTUcYrQK78o2vYZW25GE2aKXvRKQ2Z1N7Epdu8nzDBTn/2j+f0brkahif+R38/KZUglDNevMnni/OXhx1AbovoLU58lPs09PovVcfbQNfhfd/Oewg29aEcSFn75KkiJf/BfMImuw8T/yUNPRpjkT6W+UviO/6XNrmi6DHds9Tp2Ge+3Ip+Yt7MwD1EF/zeNEh3TB8Cj33I3gbklywwO+IQxJ8A2x3ZEPrHhBwaP/GGq+KSAnW66dZKvRJmTe84JC0NwA70lfARPVayr81NQzEC4eoicMIPJfv+iOHtCiMTwtj2/5v3UQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuB845ZKWeW1cuJ2SyMT75kQK1wJgFZROXONcj/Qu2M=;
 b=MO1v5rIFVJsF9PRcGMVHzWgubkEJPFhjfy0ZC6FTvDWYqdVah6d2Iea7XMgSeLqwo6PKzyixcaaPYKrxTP/SQY+0m4aAew4JpLrrI6QSgjCvMeJYghitrZgpp2Vx437cJFzPONUuqFA12VyGOrkZQYPMyHocSm5q9USD9HSB5LKV/cD9V4oAWUTkOfJ5RlPAra/72FMw+RO9W+E8j7arjrAdhmcbWOd+dWo2APdWit6uPub4NapYNSxaYetFtMsWaSIpO/UWS47RQ49me3IYHPHmWQzndlwjztyYif+IHFCsgu+VP4Zz8Ps9JITS2EDUNNYX5quINXYXsEVxcDSE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuB845ZKWeW1cuJ2SyMT75kQK1wJgFZROXONcj/Qu2M=;
 b=BubhRTfC1TiYqwVYs2/qs9qp671Oyd5g7JZqbyOROaBOO7MRryAoOY2MR3N8oMMCbPq/dxzwMO4yz3Xh78WwuYpJe0cmh/w7EFawc9c1RGZkf0RdlQI5dQIHPSSlX+Ag9ruDilv2Z3QNbfWWjNgIrc1p2g9hx91hW6EWYOKF3iLb7E+9jmwICczb0wQG0WBVpNbK36Ox2xaxpiYQSEponUvzcm9ERuySBaZHdGErp1SIwYSYbvzajRqOqHtZVjSvfHmuIr3IIErtg9X7hPy80sMFaZXsf+ewx+MPNf5DsDYJ/HGSyw0lxJ7HO/PWLPoVpB+xQwnTOtGj2UPqzU9XDw==
Received: from SN6PR16CA0045.namprd16.prod.outlook.com (2603:10b6:805:ca::22)
 by SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 10:44:32 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::f7) by SN6PR16CA0045.outlook.office365.com
 (2603:10b6:805:ca::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 10:44:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 10:44:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 18 Sep
 2025 03:44:21 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 03:44:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 18
 Sep 2025 03:44:15 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Julia
 Lawall" <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
	Richard Cochran <richardcochran@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, <cocci@inria.fr>,
	"Gal Pressman" <gal@nvidia.com>
Subject: [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR() to %pe candidates
Date: Thu, 18 Sep 2025 13:43:46 +0300
Message-ID: <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|SJ2PR12MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: e8dbb6cd-f92e-4248-4876-08ddf6a059d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?271TJPTUkzAmqxJ6kNg/E+g8jAftuB+mB2wF1b23RSQZGSp48vwahG8zG0rB?=
 =?us-ascii?Q?kc+7oE2Kgm5T86Nyfb/RRH6DpeP6Vi9vt+etz5AEvbCodf70G0EH9R1wICoU?=
 =?us-ascii?Q?Mw1M2lUEp8V8OPfOwaF6IExZlgbk1ZIEt0wM9rGhF63b4ZY66GTg3rXbYIkt?=
 =?us-ascii?Q?sSjU9Kt9rTE5FXMSBlFsx3HPwJcMSQlBtGlSVFogHPD2Ch34WNsJp7V2xyVH?=
 =?us-ascii?Q?5LLDpAE8ikz+IN6xIfryJlwVNAXAVtHB3TTaOhxhcDKmIjHiVP5/6v+8NsZD?=
 =?us-ascii?Q?Etxs27NE91qeHTLFzECO3UQdrQK4Mml/xrZ/8exN89kQc291GJClt+hzCga1?=
 =?us-ascii?Q?G9kuhxoM5y8edhcXNe2z6g1hP0YHW06yoe/BfKzhpyp2QXjN4lHkGRUH2Jhm?=
 =?us-ascii?Q?RHSI4QDlBltC6917cUGbNbn9+ppqg6Jx9cjh8utFRADhrVD/z6VjxzRxUwHz?=
 =?us-ascii?Q?FR7dO9W5CiielTwyNaVRS2U/Qu2VUM6yuvNfywnbbz9tnvgP5szdO7FiATs7?=
 =?us-ascii?Q?7AggTbrTE0RSeNJQQsWJlbM9Kb+dBRIAZqolJV62JcUpggdpPJzBzMOeJV/S?=
 =?us-ascii?Q?OasrDYz8PBPZEZNi/O1uCtcES600BqPRQswQAYcLGUuiZ9UNIG7wcoGPkGdD?=
 =?us-ascii?Q?6c+a+/Zw/zmsaIR36QWVnxEPmK5Jpn+By3DgnmTbHdIUvECYsSeO/SUgI2WP?=
 =?us-ascii?Q?/htXLgdVlZe9AxpXXjIi9TJDnBQ/g73zQGXOyh1b9HuqPGrwN/bIMGivom5p?=
 =?us-ascii?Q?AjNUkrNkXjF8b2zzFVB6WO8NTTdpGugz2Jp9bLT6FPRe3Cp1xBG5AJoZ8iNR?=
 =?us-ascii?Q?xco9SnEarRAuvKSWtFA5CTrg13zp85rvOxKwb/3GzDzDFJP+wG2lroFw4ffQ?=
 =?us-ascii?Q?0yp+Rtq265JI111wc18qbZo351QbfehHmql4R0pqiBNMzOmQdWwZ59xwE86N?=
 =?us-ascii?Q?RHT0bmhSYyizgHA+FwHOsXZaMRLSnkNku09uxfkofu3LqIrkt7CmtL3YDHJb?=
 =?us-ascii?Q?+r6IZWusF2RpmJc1bpI/93bsLBKNvV9qtpRtL9drQSZm16YvpY/QPLiD+f4N?=
 =?us-ascii?Q?CaJL18hiwBDIMVYXH2p7gUHK5JbeR5+pIERJbdoPX8FhYFzCEzS4sO/tLgdK?=
 =?us-ascii?Q?yr32pX8+W0rGQdBWhIo3b72Ar2H6318Em6fPvA3rM7cTtB5kw1iI44XWqWL0?=
 =?us-ascii?Q?KEHwmsqozkU0iyV8Lu7OAd7Q43H5Ok/19tnhQag3hT+sItQ8ayr3y3EZM5yM?=
 =?us-ascii?Q?L0AQQ+/K/Dd/iHuIMYlb6gA7bRtFemjdULWRHtmvfsRgd2ljaIhsaGNAVcBe?=
 =?us-ascii?Q?z+EZmdjWYmOBm/6jzlnT6CW7TzsqXa8RBE42+Kp+JzfqoUvW/oCOkqmqit86?=
 =?us-ascii?Q?7I00wTvZ2p/9MscGvZ138VXk+qNe5Wn+uC01SFZ+B60F9/lbZAhC7ECeSyMG?=
 =?us-ascii?Q?oJzBn1w1HSt5p3vOImjJuQBwSXUd8fg01WDsBAAR5kdb7M5R+HUBHhi7uuIZ?=
 =?us-ascii?Q?Q3BON/AhcdWZD80QEP8ASeJCYC8l1ESEoJSS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 10:44:31.6987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8dbb6cd-f92e-4248-4876-08ddf6a059d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943

From: Gal Pressman <gal@nvidia.com>

Add a new Coccinelle script to identify places where PTR_ERR() is used
in print functions and suggest using the %pe format specifier instead.

For printing error pointers (i.e., a pointer for which IS_ERR() is true)
%pe will print a symbolic error name (e.g,. -EINVAL), opposed to the raw
errno (e.g,. -22) produced by PTR_ERR().
It also makes the code cleaner by saving a redundant call to PTR_ERR().

The script supports context, report, and org modes.

Example transformation:
    printk("Error: %ld\n", PTR_ERR(ptr));  // Before
    printk("Error: %pe\n", ptr);          // After

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Alexei Lazar <alazar@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 scripts/coccinelle/misc/ptr_err_to_pe.cocci | 34 +++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 scripts/coccinelle/misc/ptr_err_to_pe.cocci

diff --git a/scripts/coccinelle/misc/ptr_err_to_pe.cocci b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
new file mode 100644
index 000000000000..0494c7709245
--- /dev/null
+++ b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use %pe format specifier instead of PTR_ERR() for printing error pointers.
+///
+/// For printing error pointers (i.e., a pointer for which IS_ERR() is true)
+/// %pe will print a symbolic error name (e.g., -EINVAL), opposed to the raw
+/// errno (e.g., -22) produced by PTR_ERR().
+/// It also makes the code cleaner by saving a redundant call to PTR_ERR().
+///
+// Confidence: High
+// Copyright: (C) 2025 NVIDIA CORPORATION & AFFILIATES.
+// URL: https://coccinelle.gitlabpages.inria.fr/website
+// Options: --no-includes --include-headers
+
+virtual context
+virtual org
+virtual report
+
+@r@
+expression ptr;
+constant fmt;
+position p;
+identifier print_func;
+@@
+* print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
+
+@script:python depends on r && report@
+p << r.p;
+@@
+coccilib.report.print_report(p[0], "WARNING: Consider using %pe to print PTR_ERR()")
+
+@script:python depends on r && org@
+p << r.p;
+@@
+coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print PTR_ERR()")
-- 
2.31.1


