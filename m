Return-Path: <linux-rdma+bounces-15160-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D99CD626D
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 14:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 731B23082AF9
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 13:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07282C325B;
	Mon, 22 Dec 2025 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DWz27ys5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C025332E;
	Mon, 22 Dec 2025 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766409982; cv=fail; b=c0Wuj87ofB2U5ew8ToPMWjYJ7aUWVQ2mqoEqEw2v+yrztSNBeGtRPlQBeoNJ/gQkqMD7TyzltyiiDqSbj+tB7dcbKeAX+5xya2DIUPBq4WSH51wzHGEugDdeEamYPdeNHn2A0KOTu2QFlQA48FUzl0ZJB3wFRGZXEBCCU1K+fa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766409982; c=relaxed/simple;
	bh=GSKbmn6hs10XJfNd4lv4C0fCvv6Yx9FoQigCQlVqIJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkTn1KX2dfby3riFDLxEPcSLxnvnvZ1cikWHQw0kdFCddTgHf78t7Y8s3FSjV7wO3hUZJnoeybhARIjE7sz2u3qFGAp1C3NIWgxnvPa0HZx2mDPl7NxIs6mFV1SE38qZYczhs2jIyRH3HNFPeq5EnP1LAnUtEOC94Jou25LYSF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DWz27ys5; arc=fail smtp.client-ip=40.93.198.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EW/VLvXLGs+5Am/a1k0pfLn3wHMbRElYtA8mQGUh5roaSqrrMjMHEb55Mzt8cXwgmpCSNORUXVNvuxfR3lLnVkvuYGm9NdjdTHHK3cb8cHoCm7JzujN2dDOgv6Jsvob6wTn1kggdsR9Lh3E29eT6u42gKcMLd1J0xG3UKMqkiwR9sGMjIFiohoefaoDqo9oS3ukIVRwgBQMsfBSvUFEsV5TmEOvWXXQZ0vozUuZJtKWHM0RihKnKUpXtU9uaKgxQwh2wJuqvBcA04VsC/mDZqZer4ZmryU0Vg2hzPlj5G24rU1/rx3pgrIyfWbMIE2USNV8PEvnzqgm+NYBIFbjMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4DmJ3CR4h79VZEfZxdmhrG+QCdWKNoXBIPfKWFnrj8=;
 b=JCdmffs5jlGqThO/2boZIkSlrW3lOcvbJoG8adQ1k87iZpgobBUN4b8JnIk9iHSTDsiPZNfNygml/vWl3DcYCZeD8Slffnae9h0sBpAwYebRsaioqSxx4IMrGZJvogPW8mrguGmB0RgB71wjk41pPOHGFrIb2CiE8744I6SO9mRtHsWWfv6tpAzyuh81NB4+hHWlySTeOjTvzilfqNrPBhY6MHgWzCS4WmCUoqNGAW2UodsWhUwR/J4BjHeVbyYSWqIp4yL2F+/PI36w+5RL0SMDrsKmeSyHdXbjDqTpnmmrfUNRQSQoscC0L+Rw+YEz7jkzvA6QQGKY6dbxFpBNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4DmJ3CR4h79VZEfZxdmhrG+QCdWKNoXBIPfKWFnrj8=;
 b=DWz27ys51PQkgJGI3P3DDEMTVZkhSA5umXK5u6Vd6GE4A3JV4YWopYsGa9sQPYKzBwubSaQmvz3EHLdnfA+BxjlI6fELwL4r7E4T/1WKcL0An7oY0T12SsIluMoBzn3yCHB0Uc0XHcabt5YnvsvZuJmx6d3eGi7tFVq7Pi9Ry26Ah0ktGLNFIUxzAg/8eb0crq4Sq/oAiv1KFv1GgmoG7Nm3tuuq4XGcyci9SE13lVof3Ju2kOoS4qWoNhjPgN52rextEJM/qIIVW7uh6eHj6OarHmqaiDpgwqFoCUw8Qf5qVAz64kQ6WdITp4w9LJys3cp5cyZT36oBcTSy5tVGjw==
Received: from SJ0PR13CA0007.namprd13.prod.outlook.com (2603:10b6:a03:2c0::12)
 by SA5PPF9BB0D8619.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 13:26:12 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::dd) by SJ0PR13CA0007.outlook.office365.com
 (2603:10b6:a03:2c0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.10 via Frontend Transport; Mon,
 22 Dec 2025 13:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 13:26:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 05:26:06 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 22 Dec 2025 05:26:06 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 05:26:04 -0800
From: Patrisious Haddad <phaddad@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: Michael Guralnik <michaelgur@nvidia.com>, <netdev@vger.kernel.org>,
	<jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, Patrisious Haddad
	<phaddad@nvidia.com>
Subject: [RFC iproute2-next 4/4] rdma: Add FRMR pools set pinned command
Date: Mon, 22 Dec 2025 15:25:46 +0200
Message-ID: <20251222132549.995921-5-phaddad@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251222132549.995921-1-phaddad@nvidia.com>
References: <20251222132549.995921-1-phaddad@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|SA5PPF9BB0D8619:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b80d88-2b97-4ab4-500f-08de415dac75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R/b7oCJIiqAtJpyL7LXO8edXi+Fv0lJimbQrSVDsaJGBF/KBbLE6LZO4rBzA?=
 =?us-ascii?Q?zES/E4GsYNB61oMulMaK5q+7TzBenPQcWZck4hX5uFhb/sL3+I3jJQnv8OwJ?=
 =?us-ascii?Q?BYkxrwVkwrMICzkCPiP1mArLouErg/1kqWLsoWsQNvJd1cDuOGh1iRNDxDSu?=
 =?us-ascii?Q?GDzKcAtMxk23WG5wJ0dKoH2ogKPBeeTeJF5wDl2QCufya9dQA+ILkmjC2Toc?=
 =?us-ascii?Q?3YDnY6/bxF8jPuGB+3LMWxMFnlHMp2nflQO37NrBkimqziXf0BiVTGQVM76m?=
 =?us-ascii?Q?uSXpMmhQzQavYqh7/IVxkK2y9ea8ocHpzQfZAp4T1NGsMuus8B91Sk5Oq5lX?=
 =?us-ascii?Q?35hMrh5mk8Hc9EmWFK4uz+HDuJWSKwZwOjqN8hXoEYnpzxZxLer/xnjclGy1?=
 =?us-ascii?Q?vvy3YkB+shXHTL+6hAmfiHKq06yNZXKP6wzePCXfsWk5Cp19kZ8fqfmMwOuE?=
 =?us-ascii?Q?CXmq3i61ZFYrhXbAYcIxQSo6/rdsbdzVN0eGX3AaKbUl0x9oGmoHr6K40mcU?=
 =?us-ascii?Q?tThNnfHhy6SPX4g1/fr8hkyqHltK0bO9+t8yGLVxCDIeS5depkGPe7V5fjHy?=
 =?us-ascii?Q?tlSDrAxQPJY/pyYd9eTnqBIko/YSFEGQ4QNKI0uECETJdPBqakVEb4dNIOxI?=
 =?us-ascii?Q?bh71BmQ527dgNg0AAiAg3E4d+eF00M0WHj1OhsqXxZrTiiVXkSFoWUdLQjBa?=
 =?us-ascii?Q?eOaCOUppfIAY/1Eqi66Gb1tI5k00n8Rl/Hxj1Xz3Eozn7YjwH/aPd+HsL3DN?=
 =?us-ascii?Q?DGETP60J0D4TA8FnG6JjVnc+sD6fAn9qjjwhvfHLkxkaJqWeR6rB2AhXl8Qk?=
 =?us-ascii?Q?dIpMj4OL2WsDmL+12KHLzUsAXV1tyZLtwoePzhx00ItJGgWJx1p94fpjzBqQ?=
 =?us-ascii?Q?KjFnWc/igB5I3BgrnQwPy8K15zJ8qvUPrKp7ekiJzqvKzSj3JTzRCEaE7dge?=
 =?us-ascii?Q?RW/H0ailstzHbXsKbEkCCziZYy+n/3N7RP6dXhhI30JXSDtcORmPoNKFn9KH?=
 =?us-ascii?Q?NB6ypFVkFLIT6GqsEhYjhsxgrfKZYjLuYxzSUY4M5CUjUczM6ao+xit0StNc?=
 =?us-ascii?Q?LoCLJrfKXJUOhUrhScwfCg7rt+nk7aUasqPRnQK/gQvmHCReT6i2nn0fLHs6?=
 =?us-ascii?Q?b4AxCMKQy0YFXv4I6nybDfws/pQl8GDVLWAw2yVyTW31C+m8mFlBy0B4Bzzl?=
 =?us-ascii?Q?KyfSO8EaiWdwW/azp6EvaZvh7VEjBQAq4acnNh0hX2ziRggfF1IqbyLz2zuM?=
 =?us-ascii?Q?M77fPJdx76ih6aNRX2BpjiCfAhpvciZa2vdqBfLlWRESL6GtZ8SuYjwoXuMG?=
 =?us-ascii?Q?w6Hqb3C3gnZJ6fY5tBh4FHCCGe48KMSgEAM/sk2j7z5dhXpN5lBwlUEmACAE?=
 =?us-ascii?Q?WIDdoDmjYj949+b1bhZDTdnGh/a55eUqFxe0xaXH/n2Upr88fO9pZSzJi3ev?=
 =?us-ascii?Q?N5eQGVbgncc4z2DgXDUPlC7DkJwk1d+lrwI+ocUi4W5lGBfYA4m4ZI7x9ua0?=
 =?us-ascii?Q?fzmVtrP5pTadf1jMtk42/cGX+Zymtzglv7Eo/Qwpfg7zzB1JjQC3zZC/1CKJ?=
 =?us-ascii?Q?xd9ky+IK2Rbh5qWLxXA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 13:26:11.4087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b80d88-2b97-4ab4-500f-08de415dac75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9BB0D8619

From: Michael Guralnik <michaelgur@nvidia.com>

Add an option to set the amount of pinned handles to FRMR pool.
Pinned handles are not affected by aging and stay available for reuse in
the FRMR pool.

Usage:
Set 250 pinned handles to FRMR pool with key 800000000000000 on
device rocep8s0f0
$rdma resource set frmr_pools dev rocep8s0f0 pinned 800000000000000 250

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
---
 man/man8/rdma-resource.8 | 21 +++++++++
 rdma/res-frmr-pools.c    | 93 +++++++++++++++++++++++++++++++++++++++-
 rdma/res.c               |  1 +
 rdma/res.h               |  1 +
 4 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/man/man8/rdma-resource.8 b/man/man8/rdma-resource.8
index 7b09f4cc..e4274cf8 100644
--- a/man/man8/rdma-resource.8
+++ b/man/man8/rdma-resource.8
@@ -33,6 +33,14 @@ rdma-resource \- rdma resource configuration
 .BR aging
 .IR AGING_PERIOD
 
+.ti -8
+.B rdma resource set frmr_pools
+.BR dev
+.IR DEV
+.BR pinned
+.IR HEX_POOL_KEY
+.IR PINNED_VALUE
+
 .ti -8
 .B rdma resource help
 
@@ -54,6 +62,14 @@ If this argument is omitted all links are listed.
 .I "AGING_PERIOD"
 - specifies the aging period in seconds for unused FRMR handles. Handles unused for this period will be freed.
 
+.PP
+.I "HEX_POOL_KEY"
+- specifies the hexadecimal pool key that identifies a specific FRMR pool.
+
+.PP
+.I "PINNED_VALUE"
+- specifies the pinned value for the FRMR pool. A non-zero value pins handles to the pool, preventing them from being freed by the aging mechanism.
+
 .SH "EXAMPLES"
 .PP
 rdma resource show
@@ -141,6 +157,11 @@ rdma resource set frmr_pools dev rocep8s0f0 aging 120
 Set the aging period for FRMR pools on device rocep8s0f0 to 120 seconds.
 .RE
 .PP
+rdma resource set frmr_pools dev rocep8s0f0 pinned 1000000000000 25000
+.RS 4
+Pin 25000 handles to the FRMR pool identified by key 1000000000000 on device rocep8s0f0 to prevent them from being freed.
+.RE
+.PP
 
 .SH SEE ALSO
 .BR rdma (8),
diff --git a/rdma/res-frmr-pools.c b/rdma/res-frmr-pools.c
index 29efb9cd..01a02e47 100644
--- a/rdma/res-frmr-pools.c
+++ b/rdma/res-frmr-pools.c
@@ -41,14 +41,40 @@ static void encode_hex_pool_key(const union frmr_pool_key *key,
 	strcpy(hex_string, temp_hex + i);
 }
 
+/* Function to decode hex string to FRMR pool key */
+static int decode_hex_pool_key(const char *hex_string, union frmr_pool_key *key)
+{
+	char padded_hex[FRMR_POOL_KEY_HEX_SIZE + 1] = { 0 };
+	int len, pad_len;
+
+	len = strlen(hex_string);
+	if (len > FRMR_POOL_KEY_HEX_SIZE) {
+		pr_err("Hex pool key too long: %d (max %d characters)\n", len,
+		       FRMR_POOL_KEY_HEX_SIZE);
+		return -EINVAL;
+	}
+
+	/* Pad with leading zeros if needed */
+	pad_len = FRMR_POOL_KEY_HEX_SIZE - len;
+	memset(padded_hex, '0', pad_len);
+	strcpy(padded_hex + pad_len, hex_string);
+
+	if (hex2mem(padded_hex, key->raw, FRMR_POOL_KEY_SIZE) < 0) {
+		pr_err("Invalid hex pool key: %s\n", hex_string);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int res_frmr_pools_line(struct rd *rd, const char *name, int idx,
 			       struct nlattr **nla_line)
 {
 	uint64_t in_use = 0, max_in_use = 0, kernel_vendor_key = 0;
 	char hex_string[FRMR_POOL_KEY_HEX_SIZE + 1] = { 0 };
 	struct nlattr *key_tb[RDMA_NLDEV_ATTR_MAX] = {};
+	uint32_t queue_handles = 0, pinned_handles = 0;
 	union frmr_pool_key key = { 0 };
-	uint32_t queue_handles = 0;
 
 	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY]) {
 		if (mnl_attr_parse_nested(
@@ -116,6 +142,13 @@ static int res_frmr_pools_line(struct rd *rd, const char *name, int idx,
 		    nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE]))
 		goto out;
 
+	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED])
+		pinned_handles = mnl_attr_get_u32(
+			nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED]);
+	if (rd_is_filtered_attr(rd, "pinned", pinned_handles,
+				nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED]))
+		goto out;
+
 	open_json_object(NULL);
 	print_dev(idx, name);
 
@@ -148,6 +181,8 @@ static int res_frmr_pools_line(struct rd *rd, const char *name, int idx,
 		      nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE]);
 	res_print_u64("max_in_use", max_in_use,
 		      nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE]);
+	res_print_u32("pinned", pinned_handles,
+		      nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED]);
 
 	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
 	close_json_object();
@@ -220,10 +255,65 @@ static int res_frmr_pools_one_set_aging(struct rd *rd)
 	return ret;
 }
 
+static int res_frmr_pools_one_set_pinned(struct rd *rd)
+{
+	union frmr_pool_key pool_key = { 0 };
+	struct nlattr *key_attr;
+	uint32_t pinned_value;
+	const char *hex_key;
+	uint32_t seq;
+
+	if (rd_no_arg(rd)) {
+		pr_err("Please provide pool key and pinned value.\n");
+		return -EINVAL;
+	}
+
+	hex_key = rd_argv(rd);
+	rd_arg_inc(rd);
+
+	if (decode_hex_pool_key(hex_key, &pool_key))
+		return -EINVAL;
+
+	if (rd_no_arg(rd)) {
+		pr_err("Please provide pinned value.\n");
+		return -EINVAL;
+	}
+
+	if (get_u32(&pinned_value, rd_argv(rd), 10)) {
+		pr_err("Invalid pinned value: %s\n", rd_argv(rd));
+		return -EINVAL;
+	}
+
+	rd_prepare_msg(rd, RDMA_NLDEV_CMD_RES_FRMR_POOLS_SET, &seq,
+		       (NLM_F_REQUEST | NLM_F_ACK));
+	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_DEV_INDEX, rd->dev_idx);
+
+	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED,
+			 pinned_value);
+
+	key_attr =
+		mnl_attr_nest_start(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY);
+	mnl_attr_put_u8(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS,
+			pool_key.fields.ats);
+	mnl_attr_put_u32(rd->nlh,
+			 RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS,
+			 pool_key.fields.access_flags);
+	mnl_attr_put_u64(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY,
+			 pool_key.fields.vendor_key);
+	mnl_attr_put_u64(rd->nlh,
+			 RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS,
+			 pool_key.fields.num_dma_blocks);
+	mnl_attr_nest_end(rd->nlh, key_attr);
+
+	return rd_sendrecv_msg(rd, seq);
+}
+
 static int res_frmr_pools_one_set_help(struct rd *rd)
 {
 	pr_out("Usage: %s set frmr_pools dev DEV aging AGING_PERIOD\n",
 	       rd->filename);
+	pr_out("Usage: %s set frmr_pools dev DEV pinned HEX_POOL_KEY PINNED_VALUE\n",
+	       rd->filename);
 	return 0;
 }
 
@@ -233,6 +323,7 @@ static int res_frmr_pools_one_set(struct rd *rd)
 		{ NULL, res_frmr_pools_one_set_help },
 		{ "help", res_frmr_pools_one_set_help },
 		{ "aging", res_frmr_pools_one_set_aging },
+		{ "pinned", res_frmr_pools_one_set_pinned },
 		{ 0 }
 	};
 
diff --git a/rdma/res.c b/rdma/res.c
index 63d8386a..1ff257c2 100644
--- a/rdma/res.c
+++ b/rdma/res.c
@@ -29,6 +29,7 @@ static int res_help(struct rd *rd)
 	pr_out("          resource show frmr_pools dev [DEV]\n");
 	pr_out("          resource show frmr_pools dev [DEV] [FILTER-NAME FILTER-VALUE]\n");
 	pr_out("          resource set frmr_pools dev DEV aging AGING_PERIOD\n");
+	pr_out("          resource set frmr_pools dev DEV pinned HEX_POOL_KEY PINNED_VALUE\n");
 	return 0;
 }
 
diff --git a/rdma/res.h b/rdma/res.h
index dffbdb52..4758f2ea 100644
--- a/rdma/res.h
+++ b/rdma/res.h
@@ -198,6 +198,7 @@ struct filters frmr_pools_valid_filters[MAX_NUMBER_OF_FILTERS] = {
 	{ .name = "queue", .is_number = true },
 	{ .name = "in_use", .is_number = true },
 	{ .name = "max_in_use", .is_number = true },
+	{ .name = "pinned", .is_number = true },
 };
 
 RES_FUNC(res_frmr_pools, RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET,
-- 
2.47.0


