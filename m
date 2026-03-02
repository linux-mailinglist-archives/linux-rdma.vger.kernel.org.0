Return-Path: <linux-rdma+bounces-17392-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLs8ICe0pWkBFQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17392-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 17:00:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1851DC49A
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 17:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF25C3117294
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 15:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A35E41C0B8;
	Mon,  2 Mar 2026 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tfft8Fcv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FC64218B8;
	Mon,  2 Mar 2026 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466812; cv=fail; b=tLNcoKd6wV7LwEB3a2deauPr/uaexuYAYzi2jggZqb6p3PSuZa07aE8guTq4vI5y5jkOvnHUYSPefEx1JW+nrVkTsJyf2ToYNFhIM9EEoCWBhtf9U5kImnH3PC4RBDVGYHZKXFILlFbBDrz2kDK4Ymi7eDm76XDyJp8Xg1GwZY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466812; c=relaxed/simple;
	bh=zaDHJBCIdieIRlTeL/KO3QeyZNW7qFTyAWZ9hf+5Odg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qj8Jn1Ijx4RgfomHX4tsHhFYTPrQPEQ7tg3s3t7ZXGk2FSNohNJ8B3mqw79gWOTd6U90lLdAjF8swt3kG2xLLXbMRT8IaEfshxogBduxyI20nXvgjnLOTurbjgwQ0BNBZWoM+0boRtLUQoRksJEEOR8hV5V3ekXJH0YQsTaxyAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tfft8Fcv; arc=fail smtp.client-ip=40.107.200.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9Qj1ZWf9rNB0XqEqtTMbU041jybiYah5eyLX/3fLSSs23wLkHqfDYOmvGM16P9CMvK1SySSuhDLX+aPY3yqlq0YzBDEcfo4/hoXk6jlZId5ayc7H8iDZ+IRiDhO4+tWijBdG5mjkUNGOmTilufUe0MqsjQUUHrCr3cZsJqb18qdNJX/ManJ2Psg8nfSIIyYj6t2qRx8eiiJMwzHJQwSS8AwmNbu6trJSfX4ERechi6d2+F5VQZA0SBaY+PIS+x9HfKy0v6j1ekMon0RDDdIulrRLQpuUEhQUJRN55sxt+9GDI/IAgKquc7/rjpeUp9Cx/7JfDd5MAhNeDIo1/u/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56YfrInrP1XLgbiqs+n4EFOZSuEJN6PugTRLW3fF38k=;
 b=hF/0WAwW0ANeGT+mJTlA73Joo0Fsh/L4KeyNfZVKk1EN/Qh1Wc2DsUvzz2CLTMSbc2V3C0oJCJqndXM+yboeF4I9Md9ZFqJLpxKMWU5vh2a328vtZ2qkNVgFkfHQbO4dHtEGWNbUAD68vdQkfUTjKpiWJCGsZoZL1Idw4P/mYkNkjeyopbZgkIW5Is/ZddMTyZWv0IQE4y0l+X4EoZ7S3KaTTL39B/foqpcHctsz95KQSyk+4E6e9n+KhH9cIC/0XFch8w0d7nXyn/BXAeT96wTou9gizxXZ1OnLPU2UGhB+642ewK4ZBZ/7qI6k9YCiMzmdbQegqv6mUbs5CaxfEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56YfrInrP1XLgbiqs+n4EFOZSuEJN6PugTRLW3fF38k=;
 b=tfft8Fcv5JXrOqx/+P25oqML6AMwONtaO3pApYYy5hFldgdkSHjcY3DS0ZECpEVp91EbNIpCJByLT10wSvuEhNYhE5D+OY9F49UcfCEIHhA8O48ZY480ilKtkgLzxQomyBm2+QW5bKOE6BtjhRbxpXA5Ax5900QbJ5kC2D/M7WLHWV4C5Rr5cwMEhLdpkradQtqQfKCMCT5LyDTvQlrLFu+6HFjD0Oo66t5Cnx9gATqCiasKj0gjrUe7NMziukS0RsCGH5oCGB1/HcVYl1mQDLMjW8IFqjPtqlxmmmhyEkkliX+dB9UGyS/YaL2YWwjKHWBr/8PDzxG0LoWfcjBeEA==
Received: from MW4PR04CA0173.namprd04.prod.outlook.com (2603:10b6:303:85::28)
 by CH1PR12MB9575.namprd12.prod.outlook.com (2603:10b6:610:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Mon, 2 Mar
 2026 15:53:18 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::66) by MW4PR04CA0173.outlook.office365.com
 (2603:10b6:303:85::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.18 via Frontend Transport; Mon,
 2 Mar 2026 15:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 15:53:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 07:52:51 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 07:52:51 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 2 Mar
 2026 07:52:48 -0800
From: Chiara Meiohas <cmeiohas@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: <michaelgur@nvidia.com>, <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>
Subject: [PATCH iproute2-next 4/4] rdma: Add FRMR pools set pinned command
Date: Mon, 2 Mar 2026 17:52:00 +0200
Message-ID: <20260302155200.2611098-5-cmeiohas@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260302155200.2611098-1-cmeiohas@nvidia.com>
References: <20260302155200.2611098-1-cmeiohas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|CH1PR12MB9575:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf0a5ab-e194-48d2-793e-08de7873d092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	iMDuDHeW58jYQKZ+zsaBx3roTvrW5VTB4geiX0ArJeosdvZv0MCKlzYClpybBtONhBRthpEDNz/J9OZqlenQ0+GS1zJmX0xnrsfevD2cSL76cPkDGKtD5QXCc7XUHseeubJ+y3Gp9dTHsMBghleCWf0dgBlUqg4eCeCgM915Jt0N6cpg7DA4sORSn9fGibmWGQGjC2G1yqpF5wOgiipjtQrzAFQj9FsxNohxyzGIMj69B0VGXGdEBSQ7dmRyWUhx6W1LO7RYtViuuNRK+866C/Wlo5kcCaM8Lsfq5v1bSJY5JhbSKUij/uKBhQB/dA7DISoGh0/fbtmjP2JJa1dkewohKPc4DlE3tLK1moBgRAdkKHg1SPCRSihjQilepe2FMYbat3DtzaBHLBmnouFVTNdI7k2qGa28AO3oDlgBxUcwXv3zbRvI137mWcNUJHtd70XQ41iDRqsnvVBQesbOHggSbrYUcWMqsJpj0oXSliAT0obm/aZQ6cKoJO6ZivgRTOB3yqSLlckC5IB0ZKdKErwdjawNtM7yBTJD9gU5Tvllcq7kwP2BW0jOmKJuVgc/eEAUnjhcUxHZv6J66YxIuNOM1LHGjS5HL3rmlIsCoWvTwfMsAOfF36rSTTgd4liae8rnlKcY8coOY+uCk0a1jM/37WEEwzlmIVJ4JArOFejeUaiuNFNK8EhsagtHQPPsJfpHTvblxmfRANZRHGimgUEcRhJKVZtEiFmOctG7pDQjCTBHgtvJacMpWkc+Xbev2ynZnioPYaPFuHzHFnw45kGXNTd79XI6u8U4AHzWD2ZQKXm/cMN1fi0JZlOL0CfpwGpdA3ElMfwoXR0/c/4Yiw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZacIXOkkmQhr/meazRIc6FKTSKs0UX3lwBRYacx53lVWA8GMGkkjh3NL/aTlgQEMK9wzH6NluqcKs9kAA+J4e4krV8vA33kOHKWcadHA0PjvtbXx3MHpMYgX9M1YlfqYPrGTJZUWSRTdDq1kXOrBMEsiHMBo/T0wnHr6+3OXHQipwLCMFtiKmkVk0s5LHOMAnsunNj5rTnQqaIeyGbzUxeGjBEGkhUMqdExtC3rVZJ8o+t9yOLhZCXFaeQGhC0kBRqnUDK5vBmcKPu27OnYNbINd9dNPJXZawCQVD4mj4S5q14rW+C41V2YQwZEz9xZBHn3AHtJwRvH5VDx7K5MyhTHL9dTykAA8Wljt4QGkeY3MWvFv4tmLPbeTjI1eMqvsn+gf+pSKpfteeHZ9uS7Q2sIBwPWCm8vUthy6GnU09mKVINsL4Or5vyEPlg7wI44z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 15:53:14.7987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf0a5ab-e194-48d2-793e-08de7873d092
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9575
X-Rspamd-Queue-Id: DA1851DC49A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17392-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,networkplumber.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmeiohas@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

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
index a6dc33f3..60c4024e 100644
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
2.38.1


