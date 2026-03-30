Return-Path: <linux-rdma+bounces-18800-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBYpCxi1ymmE/QUAu9opvQ
	(envelope-from <linux-rdma+bounces-18800-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 19:38:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C070535F5A6
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 19:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F1EF305ACA5
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 17:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9305E3DBD5C;
	Mon, 30 Mar 2026 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h++LiBPk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBD0377011;
	Mon, 30 Mar 2026 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892037; cv=fail; b=hXu/NDuKpjtvvPAoZ8frpSNRTzK7PbdaFCqx97mgy7jDqFVs88HEU5psL93OCYHfXfwK41/AFoC93hY+4RTNHXQxSv8mJs1SrxQvfJimagYvuGY0nqI1TtEfSFYY1DbugNz42K0A6oDCWhTOyUnj638GBjpZ5X9vgxI1e+ehiBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892037; c=relaxed/simple;
	bh=O4BAB5XBpNShOdQNUqPgZlL/rF6wG9H4ga4rD6guNVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGa49HcL+dR5mUcxqH/6kj2FglpEOUb+RVTCOvo/BuKuMdpgmNgTzhrqj9NS8mBL2sUqEBrUyzxFyvMbWD2189R18sLxanUocvatJmGTwPCTOgxeoKJG0s1HONpx1OIAZUpO+NciFquBMQJ5/OTossliWAs06vqchEskgMo3y+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h++LiBPk; arc=fail smtp.client-ip=52.101.61.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uj5w3RafDXbCXmyi8edyJnxwlsdxwp9Gu/vIbEAxOxgQDlnD9nbcfCTc0nxTA++U+ulIpBt42gjcbC0WY1DPslwmUvUKpfXS+yo9b2Ju7wnAi7FodnXUbkMJYgpCxJDlX1PAyDHTpme/UY7USNFlRvj9phq234ON1q/7Mc/VyTf+Bnqe28BU8FSH7KdyNrVXCD9pWD3JqbkTJ9ClvimRts72yUFMrJWwJIy/iPmZ0/UGBsz657+yZwAmYCgw0Fa2MqD1dnxrgVVSgd819BQgIJKu9weuwoO3AHJ6pG0wqmyoaOvwve0uOQswRRv5S/01cKxGVR+X5WwtfYtYpNLbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdpk35RJ8fFmCmWFB8AuhiWocHIDzDiPIDYGasmxEdc=;
 b=om7BHLvi8duxxo5NHbHvw0l0QKRunGSmfW2vIVzwc0SNhW7KIWsxpSl39ZrDoU9/X9hluxW2h0cFeNHk5qo6xqWpqtl2L/9NpalhX0HrUGKuSLW+Ht495mCrdbLN9V9bis1zez+2gEOyvUmDoHvjVXE3Z3KwRL3fBY/q6Ldd1HC727sAK8KzxYoumZwaCQ0ulDocKZC7kvrJD7nlBPVDfehawpDkQrotCumf2GNo8dD5Yds1CZPJAGMjv/caT97tPTktUMtw8nzOA/1EviqcQCJU75VvJSgPHd19uMMacZvqPow0lW+kDAlM2ZSS8tMIDDkWdYx10WBCE8Y+kDeH3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdpk35RJ8fFmCmWFB8AuhiWocHIDzDiPIDYGasmxEdc=;
 b=h++LiBPk9b9JgfuOpOZ3oZOChRt2ibxC83LkzNaeUhlJ3jpOGcK2VuhNBIRQwbD78j13ZBKcbN6vigUTEGhvNIrBwBHllMqWen4NwXUddgmRFgK8pFPtxG4PA0sPDBV2AOKFYuuxbw0Z5Wiay+DSeOKCaP1obKMcEBQKNtxM9KSjfI0S21O81KqlHWh2Cvv87nlImSkf1jG1Q5rJhQ47atReDc2en0vgnsml/vXqWpUrRcCk9vIKIZnEg3rkBQYyp1HYKBSJbUMyY+K2+2G0Nflh8e2MiKA534vxyqTb7XA4aZXQtadSfcS/Ktu1eJCIzXAmGvQx3ZIIiaF/8puD0A==
Received: from MN2PR22CA0017.namprd22.prod.outlook.com (2603:10b6:208:238::22)
 by CH0PR12MB8486.namprd12.prod.outlook.com (2603:10b6:610:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 17:33:50 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::3) by MN2PR22CA0017.outlook.office365.com
 (2603:10b6:208:238::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 17:33:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 17:33:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 10:33:33 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 10:33:32 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 30
 Mar 2026 10:33:30 -0700
From: Chiara Meiohas <cmeiohas@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: <michaelgur@nvidia.com>, <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>
Subject: [PATCH v2 iproute2-next 4/4] rdma: Add FRMR pools set pinned command
Date: Mon, 30 Mar 2026 20:31:18 +0300
Message-ID: <20260330173118.766885-5-cmeiohas@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260330173118.766885-1-cmeiohas@nvidia.com>
References: <20260330173118.766885-1-cmeiohas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|CH0PR12MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b7673b-d033-464c-5770-08de8e8281ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	R+D3u3bUMonadW9kxAfNW6DRM/1Jy9+MTmOm1nmIvbxqgbprTthIMSN8Bg2T3la3azR+jbJAdAitW09MEeksa9kd/fxnuotQK34jLFDn/s/XTkhnA8IFJKnJ8+d5PUJbFzAPPVB+6ZyCYnpdXuf2MLnJ2UMCSfgitF4yypG9JuwGK6g9MTPMPAJEqFZFwVr6WhDCLvodK1i18t74gQdYtfOPbn54SnOL97X8lCzy1UxHbHlh4zjHr2ReIS3VwQkjY8jywJ6CCDOvVHBTF5m0vAipV2lt5jOXbjO7TNZ+ozHSPPzUofhZ50j77FFau2aKnDShw11k3Di9HNZEapAffKcq8ADUT7z34hzrMmrrqUDP2AH5Fnt/alBle/WdQy3q6gHyMXccNoMMapJORSmWTE8jiY5/35Q/VSaYmJB1Xrry9fzPTvTWkj/MumQ9Te1xfz3WFSZDGtXMeoV537/NjkenNwKAfjWSYw0kzhnd8cWWyWBMlD1YDo8e4No/C/Ovs8A4ZvS8eE3ve6RxoornGgj/NTjbqEGPxZNbPkq0SYTqTMkVnexS8+8COvr103kJGyjnyyvJYoAqsONReMoeXufkT8XRJq8z+UTTtaQYpNW64UAC8WTp5yPBkiyQhgOglpQZ6qbb5ltFU7cOfjtAUnyDyVnA2MjyLKu3Gp+CZg1oCC4eiUNooWTWf8GO1zP+x7gyjOE/mK5TtpjidGYLSV6Lad7hERrP+RTRqN93bwXAAlMS6p4r2V9n5ilhDs4vkRGbw55IXHmK1UPbPJzwwg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	temjVQVpUyK0W1jgL358jgNjZOEiaAUx2tGQ7rskqoz7U1quXwRGsdIAr7c8/IWAmhEmog8Tixmi2sWWx76X8/1eHIzo3QVX8IeCoHD2tWcIL3Qr6rzgxSKtpdcyw84R5HwlswVNZcObk6TWYIRSx3SqL6zgUnOUExZWgrktSaoL7ZoR1dXujLW5kg+rPxDeZ9wa9/cEcq/LeaAT79woVrsMaKRfSt2WzvN856bPqY8z0OfgMsp1JaUmVVxacAeDPr/9yKY3nzSkJlONypffWEGhz2snI2PeMLrRU2DBwx+lg8jUTvx7V7i+Ao+o3WN9Q0o2XamDMI92fItSmLnIroVoXBYEKOBh+bW2a82F8RuoKLsNEqr1xtQeh54rY+oZzKrUtgOmELKQxhb6D7ZSdXin5nBpsxKKn/DEK7WTMG6JVqv15zSlIlgs3U2CFKtv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 17:33:50.3880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b7673b-d033-464c-5770-08de8e8281ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8486
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
	TAGGED_FROM(0.00)[bounces-18800-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,networkplumber.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmeiohas@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C070535F5A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michael Guralnik <michaelgur@nvidia.com>

Add an option to set the amount of pinned handles to FRMR pool.
Pinned handles are not affected by aging and stay available for reuse in
the FRMR pool.

The pool is identified by a colon-separated key of hexadecimal fields
(vendor_key:num_dma_blocks:access_flags:ats) as shown in the 'show'
command output.

Usage:
  Set 250 pinned handles to FRMR pool with key 0:800:0:0 on
  device rocep8s0f0
  $rdma resource set frmr_pools dev rocep8s0f0 pinned 0:800:0:0 250

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Chiara Meiohas <cmeiohas@nvidia.com>
---
 man/man8/rdma-resource.8 |  21 +++++++
 rdma/res-frmr-pools.c    | 121 ++++++++++++++++++++++++++++++++++++++-
 rdma/res.c               |   1 +
 rdma/res.h               |   1 +
 4 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/man/man8/rdma-resource.8 b/man/man8/rdma-resource.8
index a6dc33f3..1138cd23 100644
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
+.IR POOL_KEY
+.IR PINNED_VALUE
+
 .ti -8
 .B rdma resource help
 
@@ -54,6 +62,14 @@ If this argument is omitted all links are listed.
 .I "AGING_PERIOD"
 - specifies the aging period in seconds for unused FRMR handles. Handles unused for this period will be freed.
 
+.PP
+.I "POOL_KEY"
+- specifies the pool key that identifies a specific FRMR pool. The key is a colon-separated list of hexadecimal fields in the format vendor_key:num_dma_blocks:access_flags:ats.
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
+rdma resource set frmr_pools dev rocep8s0f0 pinned 0:1000:0:0 25000
+.RS 4
+Pin 25000 handles to the FRMR pool identified by key 0:1000:0:0 on device rocep8s0f0 to prevent them from being freed.
+.RE
+.PP
 
 .SH SEE ALSO
 .BR rdma (8),
diff --git a/rdma/res-frmr-pools.c b/rdma/res-frmr-pools.c
index c9d80c4b..abcd2188 100644
--- a/rdma/res-frmr-pools.c
+++ b/rdma/res-frmr-pools.c
@@ -17,14 +17,68 @@ struct frmr_pool_key {
 /* vendor_key(16) + ':' + num_dma_blocks(16) + ':' + access_flags(8) + ':' + ats(1) + '\0' */
 #define FRMR_POOL_KEY_MAX_LEN 45
 
+static int decode_pool_key(const char *str, struct frmr_pool_key *key)
+{
+	const char *p = str;
+	char *end;
+	int i = 0;
+
+	while (*p) {
+		uint64_t val;
+
+		errno = 0;
+		val = strtoull(p, &end, 16);
+		if (errno == ERANGE || end == p || (*end != ':' && *end != '\0')) {
+			pr_err("Invalid pool key: %s\n", str);
+			return -EINVAL;
+		}
+
+		switch (i) {
+		case 0:
+			key->vendor_key = val;
+			break;
+		case 1:
+			key->num_dma_blocks = val;
+			break;
+		case 2:
+			if (val > UINT32_MAX)
+				goto out_of_range;
+			key->access_flags = val;
+			break;
+		case 3:
+			if (val != 0 && val != 1)
+				goto out_of_range;
+			key->ats = val;
+			break;
+		default:
+			if (val) {
+				pr_err("Unsupported pool attributes passed in pool key\n");
+				return -EINVAL;
+			}
+		}
+		i++;
+		p = *end ? end + 1 : end;
+	}
+
+	if (i < 4) {
+		pr_err("Invalid pool key: %s, expected 4 fields\n", str);
+		return -EINVAL;
+	}
+	return 0;
+
+out_of_range:
+	pr_err("Pool key field at index %d value out of range\n", i);
+	return -EINVAL;
+}
+
 static int res_frmr_pools_line(struct rd *rd, const char *name, int idx,
 			       struct nlattr **nla_line)
 {
 	uint64_t in_use = 0, max_in_use = 0, kernel_vendor_key = 0;
 	struct nlattr *key_tb[RDMA_NLDEV_ATTR_MAX] = {};
+	uint32_t queue_handles = 0, pinned_handles = 0;
 	char key_str[FRMR_POOL_KEY_MAX_LEN];
 	struct frmr_pool_key key = { 0 };
-	uint32_t queue_handles = 0;
 
 	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY]) {
 		if (mnl_attr_parse_nested(
@@ -92,6 +146,13 @@ static int res_frmr_pools_line(struct rd *rd, const char *name, int idx,
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
 
@@ -127,6 +188,8 @@ static int res_frmr_pools_line(struct rd *rd, const char *name, int idx,
 		      nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE]);
 	res_print_u64("max_in_use", max_in_use,
 		      nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE]);
+	res_print_u32("pinned", pinned_handles,
+		      nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED]);
 
 	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
 	close_json_object();
@@ -202,10 +265,65 @@ static int res_frmr_pools_one_set_aging(struct rd *rd)
 	return rd_sendrecv_msg(rd, seq);
 }
 
+static int res_frmr_pools_one_set_pinned(struct rd *rd)
+{
+	struct frmr_pool_key pool_key = { 0 };
+	struct nlattr *key_attr;
+	uint32_t pinned_value;
+	const char *key_str;
+	uint32_t seq;
+
+	if (rd_no_arg(rd)) {
+		pr_err("Please provide pool key and pinned value.\n");
+		return -EINVAL;
+	}
+
+	key_str = rd_argv(rd);
+	rd_arg_inc(rd);
+
+	if (decode_pool_key(key_str, &pool_key))
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
+			pool_key.ats);
+	mnl_attr_put_u32(rd->nlh,
+			 RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS,
+			 pool_key.access_flags);
+	mnl_attr_put_u64(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY,
+			 pool_key.vendor_key);
+	mnl_attr_put_u64(rd->nlh,
+			 RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS,
+			 pool_key.num_dma_blocks);
+	mnl_attr_nest_end(rd->nlh, key_attr);
+
+	return rd_sendrecv_msg(rd, seq);
+}
+
 static int res_frmr_pools_one_set_help(struct rd *rd)
 {
 	pr_out("Usage: %s set frmr_pools dev DEV aging AGING_PERIOD\n",
 	       rd->filename);
+	pr_out("Usage: %s set frmr_pools dev DEV pinned POOL_KEY PINNED_VALUE\n",
+	       rd->filename);
 	return 0;
 }
 
@@ -215,6 +333,7 @@ static int res_frmr_pools_one_set(struct rd *rd)
 		{ NULL, res_frmr_pools_one_set_help },
 		{ "help", res_frmr_pools_one_set_help },
 		{ "aging", res_frmr_pools_one_set_aging },
+		{ "pinned", res_frmr_pools_one_set_pinned },
 		{ 0 }
 	};
 
diff --git a/rdma/res.c b/rdma/res.c
index 63d8386a..062f0007 100644
--- a/rdma/res.c
+++ b/rdma/res.c
@@ -29,6 +29,7 @@ static int res_help(struct rd *rd)
 	pr_out("          resource show frmr_pools dev [DEV]\n");
 	pr_out("          resource show frmr_pools dev [DEV] [FILTER-NAME FILTER-VALUE]\n");
 	pr_out("          resource set frmr_pools dev DEV aging AGING_PERIOD\n");
+	pr_out("          resource set frmr_pools dev DEV pinned POOL_KEY PINNED_VALUE\n");
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


