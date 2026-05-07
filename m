Return-Path: <linux-rdma+bounces-20181-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APuEJTbe/GlFUwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20181-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 20:47:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 103904ED980
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 20:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FA283019121
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 18:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8F033CE86;
	Thu,  7 May 2026 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rfIAYKHY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FED18050;
	Thu,  7 May 2026 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179632; cv=fail; b=LtBwM60+mbfkpzoKfqWxh2JwQlWW0oj3b4pJq3DB5SoK5ppXHuKZqAHCxV9w0wDuByPyhwwiIhF7yJHWiUe6rfevFeYqD3ePLD/1XiuJpKRP6NUqpijUCUPV44pdIYhfoulbzsXgOL5GA4IQy6i9b+HymGycH8HApyIXNP0vs0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179632; c=relaxed/simple;
	bh=qwYFXp0hZd9ptAO8fSEYmz/oAX7BOGaIXS1688APZOo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ew6rrzMIcBpZVVfYIu4P9KeOTwel0Lcbr8naMSAr0xk4lolw42mJzBui71r24xINrLtiQJxgHKlojcYlmti3j/GqFUP5NSTI883p6AUCK0yvkYVW+baEqqF6Puw5kzamGLpO8wMQo6NxCCerfBXjuBJKaLqekOTCAImvnqWdaWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rfIAYKHY; arc=fail smtp.client-ip=52.101.85.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SN9qJmgX9uBpNhUN73lhJLdak1Du11hJSuuP5Kyl7RnEnOvPfAFNHQirkRHY5gZ+XmGfSJ+P1A1gLdGfzMCRyacF+Ar8e1jWjhBiNeEp3f4LuNzucDgkrIMzeOgkB7ujSZQWglwxIs9PlDReB78+Y6AznoCXXEMHb5+wR29ISJqKhuqsKkhCR75NH6x/RDPu1NhWbsTl2UJicegDvOz6KhrRjYOlJAwKwfayrHjy6D1KEeX4LgIii1tGpshPM+NvvbDaDmkS77NiTxPBYspVDXCYdUd9Vu+wMfGdwkc6a3Of4XfiTbtO4Ky373nkEkhBj2o5nqsDrKs5SK+1bCOE8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4v6BXCklsc41QxH/Kdt3UIRmaNlBGYqJoyp9yfChlk=;
 b=X8ZeHjKQzOa9PeNl48Q1EbkHCDH9wdSfRQ7gswdEuuci8k68GYtIIUHxyE6JMu6DWPUR4ficTelnc7dpoFggbvYL4w33anCRtLcrV2UMOLdYmZVAUmNK7Ged4e2Xw63+SFYvbsD2WrRR1H1F7zP5cdp1gse9GMtv5HbtPAyGzbY7d6jZGwy45jm195FB0lYID8a+ZqkMs77QNkAOoAaxHmRev1cmjwwK0rFMTUz1xH9Oc8iMXcx/UhEiPm+kx8/lpSoWyGEpBZqXbGuwUJria9V3WeM30UpTL/3jfjFcjNtf0Vt9ILEU+UdRx1uchFYCV2DjYyW6OWFbu+I3/w7UrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4v6BXCklsc41QxH/Kdt3UIRmaNlBGYqJoyp9yfChlk=;
 b=rfIAYKHYUndFsOa4vOezbgU35jcsPAPKVHRnzYp611/xlG1G9Lw64lFCsfQtpfP+fEA9kmP15vZpbdnyVrT26/fw3bedhaJ4TxQrpFXsTAx5H0YnXTeOQv3AmyfuvH8p6JVeX9dq4IZ5LSJoD1+lRCvA7oDYnLZEuvY6N7qeytFae+lwL430Y1FRPGiSC4XtyJnOHO6ujABNFG+ubbNWGViVAPlGd7hBBRg6nXqqEsU+b+qqp8KnzyjSGSGAqfsDBVed4/WCwdj13lKWflarWu88/9S+dFpvVS/l/9yMeXqWzpQOLM1poqt6FXDdP2ljUf8Y0DaEoC1alqBFumzucA==
Received: from CH0PR04CA0084.namprd04.prod.outlook.com (2603:10b6:610:74::29)
 by DM4PR12MB8523.namprd12.prod.outlook.com (2603:10b6:8:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Thu, 7 May
 2026 18:47:06 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::b9) by CH0PR04CA0084.outlook.office365.com
 (2603:10b6:610:74::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 18:47:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 18:47:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 11:46:43 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 11:46:42 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 7 May
 2026 11:46:40 -0700
From: Chiara Meiohas <cmeiohas@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: <michaelgur@nvidia.com>, <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Chiara Meiohas <cmeiohas@nvidia.com>
Subject: [PATCH iproute2-next] rdma: Align FRMR pool UAPI names with merged kernel UAPI
Date: Thu, 7 May 2026 21:46:09 +0300
Message-ID: <20260507184609.3439875-1-cmeiohas@nvidia.com>
X-Mailer: git-send-email 2.38.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DM4PR12MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: cccd7e56-894a-41fc-9a8c-08deac69094f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qBopXLGsj+kl5ABoYyfwF7NF21wZmK0pTcDr9j11YVDkVi8WVwJSU1YIJt99GVofhFvcC1fkk/mg93fpIaQdqvN8rjkSiDtQ0LjKC79YZatXDZAyqIomU8N2haIaEo9zKn8Y2KFgeUkGDGSKyHbQ2y0y8Y8fZvfVVedK12HLPDUFqL/MWYbIH0RQmGPfQ78XaPJMK072fK0QoBAzbDnfLyKIk180S0jV5Q0v41ztr284CwR1TaFRs18EM1i2/01KA6nn/KGf9UksulScBd7AujJ/Cn2Ca0MY9sdQAFitabdblzn6/lqpUvlCnTupxgX8NU6uPel+Y1qUnynSCGnumAXRS9QloRnDB4cWU98Jy2x3ZsoN8AjXsDZDH8h1BQASUMWHR4nzFbyxlUlSsYXsjPO0eub8pinwEfcTtyxjHUHKqsujO+KN4JhRgZ7Ru7ixLLkGUPvHSZHVCWWw4D76MXjZZFks4OAiQVZN/Q+5FmK4cfQrLA9UZ9yEsZTFDOv8o6GPjhZwht+9QFgng35QE+m4NgZhNVSW2FXUWQe6x7teqihACQ3MjGL7X+28Do4cXmvnwJpxS2tilszbXfYV6D1Brctv3JkSnLACVz9WCnobvBhqU+p6n04zUVt/V0T0IkUIOAu+kjchm+DnNRuKiQTUL2nhqegXNEaKzYm/F/XYj9QV/HXqaJpFi31mcKN/DyhBEnF1ALHKIdFaCBRw5mGWw0FUKA3iCPEZJGSKHxg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Zt39UZgDvOGZqiPHSwnHiMrdoxUoILh1YxhiQ2C82rwc2fEBaSY9fKl+ePYPeiv+N0C2Mnu7zr7fb77WLW1jexUrRKucYENs4jjSmHXp2VAwx7FvMbm3K75zlwEikqppZRidF2yRkJ0ciGINrZRrT9p8gjhKs/rhhC1FMS/yeUIQO+pg1Ume2sT+5OPhESSwkILtE72vOCWEjoTGZz7gSMC/4jmYRMXnEE84tWp+NA7yk0ao93hijU2EM1WA5NfCAHNrPX8cyWcONq3tI9umJr6ZD2GbkaVHbdFdh7S+18Ufj1xsnLLB6WsPFmLbwIV1N9cjTbhoJVfLozrUjkBKXPeNPLTNma3JJgnc7HCxmx7bp3KUXbhlT/fdh8/Y+jyNKA6JY+vUzWu6zyTgLJeaBdA4VpSj7Q55Zp00frX6PwxHPhFHUnvT5pO0W99XXjbI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:47:05.9565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cccd7e56-894a-41fc-9a8c-08deac69094f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8523
X-Rspamd-Queue-Id: 103904ED980
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20181-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,networkplumber.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmeiohas@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

The FRMR pools UAPI merged in kernel v7.0-rc1 commit dbd0472fd7a5
("RDMA/nldev: Expose kernel-internal FRMR pools in netlink")
uses different identifier names than what the iproute2 FRMR pools
series was developed against.

Update the vendored copy of RDMA UAPI and all references in the rdma
tool to match the names that actually shipped in the kernel.

Fixes: 93368ee34528 ("rdma: Update headers")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
---
 rdma/include/uapi/rdma/rdma_netlink.h | 30 ++++----
 rdma/res-frmr-pools.c                 | 98 +++++++++++++--------------
 rdma/res.h                            |  2 +-
 3 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
index 8709e558b..4356ec4a1 100644
--- a/rdma/include/uapi/rdma/rdma_netlink.h
+++ b/rdma/include/uapi/rdma/rdma_netlink.h
@@ -308,9 +308,9 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_MONITOR,
 
-	RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET, /* can dump */
+	RDMA_NLDEV_CMD_FRMR_POOLS_GET, /* can dump */
 
-	RDMA_NLDEV_CMD_RES_FRMR_POOLS_SET,
+	RDMA_NLDEV_CMD_FRMR_POOLS_SET,
 
 	RDMA_NLDEV_NUM_OPS
 };
@@ -590,19 +590,19 @@ enum rdma_nldev_attr {
 	/*
 	 * FRMR Pools attributes
 	 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOLS,			/* nested table */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_ENTRY,		/* nested table */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY,		/* nested table */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS,		/* u8 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS,	/* u32 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY,	/* u64 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS, /* u64 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES,	/* u32 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE,	/* u64 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE,		/* u64 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_AGING_PERIOD,	/* u32 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED,		/* u32 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_KERNEL_VENDOR_KEY, /* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOLS,		/* nested table */
+	RDMA_NLDEV_ATTR_FRMR_POOL_ENTRY,	/* nested table */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY,		/* nested table */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS,	/* u8 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY,	/* u64 */
 
 	/*
 	 * Always the end
diff --git a/rdma/res-frmr-pools.c b/rdma/res-frmr-pools.c
index abcd21884..d5faa5c14 100644
--- a/rdma/res-frmr-pools.c
+++ b/rdma/res-frmr-pools.c
@@ -80,83 +80,83 @@ static int res_frmr_pools_line(struct rd *rd, const char *name, int idx,
 	char key_str[FRMR_POOL_KEY_MAX_LEN];
 	struct frmr_pool_key key = { 0 };
 
-	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY]) {
+	if (nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_KEY]) {
 		if (mnl_attr_parse_nested(
-			    nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY],
+			    nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_KEY],
 			    rd_attr_cb, key_tb) != MNL_CB_OK)
 			return MNL_CB_ERROR;
 
-		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS])
+		if (key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS])
 			key.ats = mnl_attr_get_u8(
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS]);
-		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS])
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS]);
+		if (key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS])
 			key.access_flags = mnl_attr_get_u32(
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS]);
-		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY])
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS]);
+		if (key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY])
 			key.vendor_key = mnl_attr_get_u64(
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY]);
-		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS])
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY]);
+		if (key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS])
 			key.num_dma_blocks = mnl_attr_get_u64(
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS]);
-		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_KERNEL_VENDOR_KEY])
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS]);
+		if (key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY])
 			kernel_vendor_key = mnl_attr_get_u64(
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_KERNEL_VENDOR_KEY]);
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY]);
 
 		if (rd_is_filtered_attr(
 			    rd, "ats", key.ats,
-			    key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS]))
+			    key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS]))
 			goto out;
 
 		if (rd_is_filtered_attr(
 			    rd, "access_flags", key.access_flags,
-			    key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS]))
+			    key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS]))
 			goto out;
 
 		if (rd_is_filtered_attr(
 			    rd, "vendor_key", key.vendor_key,
-			    key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY]))
+			    key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY]))
 			goto out;
 
 		if (rd_is_filtered_attr(
 			    rd, "num_dma_blocks", key.num_dma_blocks,
-			    key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS]))
+			    key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS]))
 			goto out;
 	}
 
-	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES])
+	if (nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES])
 		queue_handles = mnl_attr_get_u32(
-			nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES]);
+			nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES]);
 	if (rd_is_filtered_attr(
 		    rd, "queue", queue_handles,
-		    nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES]))
+		    nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES]))
 		goto out;
 
-	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE])
+	if (nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE])
 		in_use = mnl_attr_get_u64(
-			nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE]);
+			nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]);
 	if (rd_is_filtered_attr(rd, "in_use", in_use,
-				nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE]))
+				nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]))
 		goto out;
 
-	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE])
+	if (nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE])
 		max_in_use = mnl_attr_get_u64(
-			nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE]);
+			nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE]);
 	if (rd_is_filtered_attr(
 		    rd, "max_in_use", max_in_use,
-		    nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE]))
+		    nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE]))
 		goto out;
 
-	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED])
+	if (nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES])
 		pinned_handles = mnl_attr_get_u32(
-			nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED]);
+			nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES]);
 	if (rd_is_filtered_attr(rd, "pinned", pinned_handles,
-				nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED]))
+				nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES]))
 		goto out;
 
 	open_json_object(NULL);
 	print_dev(idx, name);
 
-	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY]) {
+	if (nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_KEY]) {
 		snprintf(key_str, sizeof(key_str),
 			 "%" PRIx64 ":%" PRIx64 ":%x:%s",
 			 key.vendor_key, key.num_dma_blocks,
@@ -166,30 +166,30 @@ static int res_frmr_pools_line(struct rd *rd, const char *name, int idx,
 		if (rd->show_details) {
 			res_print_u32(
 				"ats", key.ats,
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS]);
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS]);
 			res_print_u32(
 				"access_flags", key.access_flags,
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS]);
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS]);
 			res_print_u64(
 				"vendor_key", key.vendor_key,
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY]);
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY]);
 			res_print_u64(
 				"num_dma_blocks", key.num_dma_blocks,
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS]);
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS]);
 			res_print_u64(
 				"kernel_vendor_key", kernel_vendor_key,
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_KERNEL_VENDOR_KEY]);
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY]);
 		}
 	}
 
 	res_print_u32("queue", queue_handles,
-		      nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES]);
+		      nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES]);
 	res_print_u64("in_use", in_use,
-		      nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE]);
+		      nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]);
 	res_print_u64("max_in_use", max_in_use,
-		      nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE]);
+		      nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE]);
 	res_print_u32("pinned", pinned_handles,
-		      nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED]);
+		      nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES]);
 
 	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
 	close_json_object();
@@ -215,12 +215,12 @@ int res_frmr_pools_parse_cb(const struct nlmsghdr *nlh, void *data)
 
 	mnl_attr_parse(nlh, 0, rd_attr_cb, tb);
 	if (!tb[RDMA_NLDEV_ATTR_DEV_INDEX] || !tb[RDMA_NLDEV_ATTR_DEV_NAME] ||
-	    !tb[RDMA_NLDEV_ATTR_RES_FRMR_POOLS])
+	    !tb[RDMA_NLDEV_ATTR_FRMR_POOLS])
 		return MNL_CB_ERROR;
 
 	name = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_DEV_NAME]);
 	idx = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
-	nla_table = tb[RDMA_NLDEV_ATTR_RES_FRMR_POOLS];
+	nla_table = tb[RDMA_NLDEV_ATTR_FRMR_POOLS];
 
 	mnl_attr_for_each_nested(nla_entry, nla_table) {
 		struct nlattr *nla_line[RDMA_NLDEV_ATTR_MAX] = {};
@@ -256,10 +256,10 @@ static int res_frmr_pools_one_set_aging(struct rd *rd)
 		return -EINVAL;
 	}
 
-	rd_prepare_msg(rd, RDMA_NLDEV_CMD_RES_FRMR_POOLS_SET, &seq,
+	rd_prepare_msg(rd, RDMA_NLDEV_CMD_FRMR_POOLS_SET, &seq,
 		       (NLM_F_REQUEST | NLM_F_ACK));
 	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_DEV_INDEX, rd->dev_idx);
-	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_AGING_PERIOD,
+	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD,
 			 aging_period);
 
 	return rd_sendrecv_msg(rd, seq);
@@ -294,24 +294,24 @@ static int res_frmr_pools_one_set_pinned(struct rd *rd)
 		return -EINVAL;
 	}
 
-	rd_prepare_msg(rd, RDMA_NLDEV_CMD_RES_FRMR_POOLS_SET, &seq,
+	rd_prepare_msg(rd, RDMA_NLDEV_CMD_FRMR_POOLS_SET, &seq,
 		       (NLM_F_REQUEST | NLM_F_ACK));
 	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_DEV_INDEX, rd->dev_idx);
 
-	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED,
+	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,
 			 pinned_value);
 
 	key_attr =
-		mnl_attr_nest_start(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY);
-	mnl_attr_put_u8(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS,
+		mnl_attr_nest_start(rd->nlh, RDMA_NLDEV_ATTR_FRMR_POOL_KEY);
+	mnl_attr_put_u8(rd->nlh, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS,
 			pool_key.ats);
 	mnl_attr_put_u32(rd->nlh,
-			 RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS,
+			 RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS,
 			 pool_key.access_flags);
-	mnl_attr_put_u64(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY,
+	mnl_attr_put_u64(rd->nlh, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY,
 			 pool_key.vendor_key);
 	mnl_attr_put_u64(rd->nlh,
-			 RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS,
+			 RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS,
 			 pool_key.num_dma_blocks);
 	mnl_attr_nest_end(rd->nlh, key_attr);
 
diff --git a/rdma/res.h b/rdma/res.h
index 8d7b4a0bf..1f71115b9 100644
--- a/rdma/res.h
+++ b/rdma/res.h
@@ -200,7 +200,7 @@ struct filters frmr_pools_valid_filters[MAX_NUMBER_OF_FILTERS] = {
 	{ .name = "pinned", .is_number = true },
 };
 
-RES_FUNC(res_frmr_pools, RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET,
+RES_FUNC(res_frmr_pools, RDMA_NLDEV_CMD_FRMR_POOLS_GET,
 	 frmr_pools_valid_filters, true, 0);
 
 int res_frmr_pools_set(struct rd *rd);
-- 
2.38.1


