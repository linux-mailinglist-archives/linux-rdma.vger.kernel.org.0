Return-Path: <linux-rdma+bounces-22086-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MJfWHR+PKWoYZgMAu9opvQ
	(envelope-from <linux-rdma+bounces-22086-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 18:21:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB0266B5E6
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 18:21:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=G+pB0XOY;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22086-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22086-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B379366FEE2
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 15:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B836C49219A;
	Wed, 10 Jun 2026 15:42:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5429548C8C5;
	Wed, 10 Jun 2026 15:42:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106177; cv=fail; b=tKpZUii31TR1aWFcl/oooD5zwjPxVn4wLox/KU+H/1jRvKKNHHZGgwwGhbrKL6K8K03hCB3L9PLBTQ95U2HBzjxQJflXZvjnuze8PXdHkivMNdjMMJ7cIOQsD3WHhgRgErwK+pcZNlA8NYWLwa5SeZP5honmi+j0Ce5SXp37MEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106177; c=relaxed/simple;
	bh=7hhgQdEuKk9U3L3Bul0d71TAuACGPy/N/Wj4A0yg/FU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUqNVLrqjyzU63TA5Rd3l5sWsHT+CvfyfiEWkol5zOIY5py5+FUQ5YSa0CdkIO52DsJlzh2jmnF2hMYrO0d8hiPGo7+I6x3lZRika8ERmzls0415lv5Sddd7lgPmTvHd1y8LGOirGu+c6ye0QMEcrkSbkzBjEyYX1SoEdYMq8L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G+pB0XOY; arc=fail smtp.client-ip=40.93.196.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPyaMSDvNIyELV/LMIQqqGVgQv8wsd2EXXRctm4orgRRV5viEzGT2U/KsK+KBie6pGQYdvFesbypweMo4u7nTmj+UCj1eoheA30Sd5VwEWaWyyuceMwr/EE77nBk2J73lIR/Js7BOZnYJi31MdUHhVyQ6MVL1olDG7nR7WX0f9QeYnJ7+GZkEu2la744Ojunf3CXXaUItjNDGNUvmRsFe2so7dBHgNZ3ebvs72DtLeuOfdmNKBRtnkFGwFsNE6o8b8CH0o5YZEbLf3PuiAPLJvC22E7GFmmGGLzrRrxsdCtj89FOSOIpT/7IfPZA3bQKoyddAkUgMeVPDoTLEGSHCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyZ58W4A/jIcUBEn0NpcpII08nyAwFocmbFdvs27pUI=;
 b=jXgjZfIM6YyQBEiK9o7oFCT3nStLtuYbUHJQj51iKXGpBCVDmPJq23yvlKkv+rBgua8hwbltHRBlcVZ3BLllh8Fp650wOJ1PIx7yrkZ+oSLVLv0PSplOgP9uEfyes+TZsWBgYR7vqtgHBTfVNuAW7JchChnHkDIMVspw4E/7/MgbCc+CuMpdauC8eyjZd+vrKlAmTXh4N8zQ0t7SOIsklngbHv/MvlcmnGY9yv5gdJyCO2CB+O1VQzBIFGrRyC0u8vMhGCPJBSk9YvUth5tfBX0eUoVn+RcacZEET3JtZFJnbi+2DnT2EhrSu5bqpwkT4RJdj839mIu1+oR8l8yyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyZ58W4A/jIcUBEn0NpcpII08nyAwFocmbFdvs27pUI=;
 b=G+pB0XOYCj9Cd7mf9M4TlyIPyE54bh4GNJJ85JvE4bFfOXT71XoP/tJxHqyZfF74Q6tyjNmK8KISSDvWiUiD9yQ18qNqRlhWqiLvId+6W3p7SmPUER/a3G+83uNxooIhG/ANsZf5atuSQCPlEwWpoyLv2rcvSCo4SGbnYX1/qrU=
Received: from BN0PR08CA0009.namprd08.prod.outlook.com (2603:10b6:408:142::13)
 by SJ2PR12MB8135.namprd12.prod.outlook.com (2603:10b6:a03:4f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 15:42:50 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::68) by BN0PR08CA0009.outlook.office365.com
 (2603:10b6:408:142::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 15:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 15:42:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 10:42:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 08:42:48 -0700
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 10:42:45 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dwmw2@infradead.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [for-next v4 5/5] RDMA/mlx5: move mlx5 clock info to common struct ib_uverbs_clock_info
Date: Wed, 10 Jun 2026 21:12:16 +0530
Message-ID: <20260610154216.712374-6-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610154216.712374-1-abhijit.gangurde@amd.com>
References: <20260610154216.712374-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SJ2PR12MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbe2749-1aa6-4853-1900-08dec706ed66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|36860700016|82310400026|1800799024|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	7s/aUDuO4ZBx5EASs89WfXy4EKvSfdP3exzmom98EccEuNnY216PSfPnbUzwJvRXOzOKxQrjDOO+dnhKaMYG+f2O0hLDN8wlEfdniqOsF10fVEw45LFDi9eRnxMzfnSn0S3f1Pyb5Q7VxLBj4v4Kj4658YtWDXkeZ/B1/3lltfVlEx3bDCUfCJ835s1KcO8Ji+br82JU0kx+gEUsWKpCkDF+HmVjVXyz/tz8ctS5Yo/xmoy/EpOMiJJY+u9r8KhPpehyn1ITCceATKIINbiPtZ7inqke8EnD+9wIR/QFXiJ1PXXY+p9aQYyoM/k3As7EkfaiHHjeo0Rs4c7rk36GZzmj/zx/E/+qdMemUt9rBKqI5xWoZVgrawSKkUMstWDUKjrrl32fGI8ByP+lwaqURiMhZnexX9KgqqwAgPAYDRJ7C51cjMXSd3zocBqBO3sqc2Nb+xMoqRKp1RJMMcevz2Ea7t5urOh3MwIPvZB9lQyznygCzw0PXcDMENJm/DGif4msgyQm9RwGjb3h7LjLR1Wqiqcf6ZT3hCUptN0xP7Lvum7ysPNluxE+WsWX6Zp3zcYo7nqfTI4XHC8rOkR+M5jjpdd8Xezfl2zOwrL1IFP+J9HSvcvVYDy9bJNOALYMTAr5D9rjqZOKSc+OHRMM/Vo3ffBce9upslAVwV4oATxWHYFWM3tvTeoGV6TIZnOOSDCFTq8DWUjI7hE7e3bVznvfAiRjnTvf+uBzAZyGqfw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(18002099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xienidovDw94Kv/GiF3zKz72FoCoH0LMKJQTsGkJSMVPr/zyivN9BWqDTphb+rdhEW9Nlz7lAoBWDdqXGvH17JHTXbrH1Apa/iT8DR4r6/J0vR47UOe7DOUc9d1BCuRPTg8seRlkL/OLcfca3WcC+bBwgOUlKhD+Roa66WXx5eoVTfkJnQnNMsZNoCJwOVM2v5/aeKF0pVDIr33F5dhFZ36rHormvjYJf/nvti9Q41NdyrPm+Uq/CyB6QtL3eq8hElBhu/hWVBNajTgAtP/TAJAe0RNAu21r79LIBsJFFi/j+6pxCJMxJ69D5Ybq8sk/gkcdFFsUhzy++/1z8fZbOCGmsaYlk5iq6MtI4QaFGqwR9hgM4uDCewdGV+KMCrBq4Nf5DI4B2HN0cIjQkZCGvXS7dZYMsq0hB+Z0ez/tvLCM3YjSmxQRMe0OTLwKI5DM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:42:49.9370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbe2749-1aa6-4853-1900-08dec706ed66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-22086-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:allen.hubbe@amd.com,m:nikhil.agarwal@amd.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dwmw2@infradead.org,m:abhijit.gangurde@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFB0266B5E6

Use struct ib_uverbs_clock_info from ib_user_verbs.h for clock info.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 include/uapi/rdma/mlx5-abi.h | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
index 8a6ad6c6841c..a39226cd62dc 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -472,17 +472,10 @@ struct mlx5_ib_modify_wq {
 	__u32	reserved;
 };
 
-struct mlx5_ib_clock_info {
-	__u32 sign;
-	__u32 resv;
-	__aligned_u64 nsec;
-	__aligned_u64 cycles;
-	__aligned_u64 frac;
-	__u32 mult;
-	__u32 shift;
-	__aligned_u64 mask;
-	__aligned_u64 overflow_period;
-};
+/*
+ * deprecated, see struct ib_uverbs_clock_info from ib_user_verbs.h
+ */
+#define mlx5_ib_clock_info ib_uverbs_clock_info
 
 enum mlx5_ib_mmap_cmd {
 	MLX5_IB_MMAP_REGULAR_PAGE               = 0,
-- 
2.43.0


