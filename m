Return-Path: <linux-rdma+bounces-18797-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMZIFbO0ymmE/QUAu9opvQ
	(envelope-from <linux-rdma+bounces-18797-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 19:36:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB00535F579
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 19:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34E583024CB7
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3290237D105;
	Mon, 30 Mar 2026 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZWrsXzh0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA267374E43;
	Mon, 30 Mar 2026 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892017; cv=fail; b=m1buDWb+H7JN3WYL5sqIGkmmEv/WMJ6bcAt253vK7BJJv/2DAZOVUsyHQaMnK14CPZv7xOsrWbk6UD+HDDxK/tS7LrNUZ9aULVeaJpKwOIZJ+DLMbEafStbRP18hmDCgfY4UebibGST5cZ6dpdTxLQcWDYk3gtdCf73WwDwxpFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892017; c=relaxed/simple;
	bh=LWmIKVaMfGigSH8XSoWWQj2krUgiWQt2ICBGhlGPODQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhSu/+PeqGbOn8UTk4rk3H1eE2KAnZjj7cCUYFLkx6yxMXmLVUrUAm4vw2efPBp3DjAgjOWC5yfwxpxtcfpCLSfoMu4kG2Jg+M2USA4fI/2x1Ffq5mCxlsmD+iZGuriwtgfk7uxjKTpAMZZS4afdTXCG4O3NAHAAws8G2L5dkzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZWrsXzh0; arc=fail smtp.client-ip=52.101.56.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tv6kM/1wh5Z/omCF+JM2OgOwDuHQ08dnT6T7hvzZCdKvcS6BeAYP5IcC+w0f67e18UyjrAFAHEZGdh5r2DgoiGaUI5ix312vxyCiVJ5WVsohC03pp/Hnk5Jov8N0I2y6Pn8FsuqcsM84X+Dtmkwg2tOKUsdWzhMn2hsf/PUFMz3oeyeEc1DkYP5V3OE2VPEbK7mTFJd1K0YuOk5gbGgo2EWS2T7Ej8LhDFt8bGQv2VncvN1xuUBtZKr31fkYh5bMegjmt4rjp4dMkbZ98fkJF1QlgAFNAxdBXpq2SuVtM0SUvo/vwQb6ItE4UuxCBF9F5HJfN3FNBj2QmcYblkVszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNyevR6/SSAVzK7zWV2xVQV19t2i5OI43K49ePJWBIE=;
 b=SIb0kx4QTzmqipE+4S7R2/TPuokmwhAq6CBQafrSTbg78ctg04WxHp9rFdkiU8U8lFXijd3YtolSn2I5frzbEpGvz0Pl5scP2FRTHxDXZMCMZ3E3VCkTgwibJAvnT0dR/A9nl58KO2NdoD0Rz5i17RX/5WRXSidygU5zzckhlkjDirQR7Q9GhIAIEskVvQJxz3jskJd1vNi9eGV+VVCT0ve3RmQkY6CtESXgpDi67kULKFoCnbA6y7v8iUQfylJA0h2g1XyTyHvsEQiIN6al+qjkqKgAou+C7InUIZY+cBnHIRl4K5vWfpQHQ7djX1tQa6lBeqiLz6v9lWogBHaDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNyevR6/SSAVzK7zWV2xVQV19t2i5OI43K49ePJWBIE=;
 b=ZWrsXzh0BoE3iaEsP378eoxSTzEh88GhLVsnFs2MqWQwmGBIC6fITtnBQimb3wppb7GL9rovLwCweArNKi5oN4T1k9aECvaVJ3phS3D6XO2nzEK+ExOGFgJ8NkK62wYaxkVcf/2m0Aa2ZBe2uMlUO9UsKu35u9VLprNBkNM41CdvLzeY1Jt+F0MyUrN3NXSoAvlNuNUhhQLGUrQPph8hRNMyzRSU6KOJ+Lbw5gVieWIuY9TtHYoOQEFomM3YGLeEp2FPHHdqDnLx+BVs3XMIW+suclOhzYsnnRYJx78LR2PKgVP7nJjhztAXBCdy6SAkky+6TOR9dldyOpdWXxJ2Bg==
Received: from MN2PR22CA0022.namprd22.prod.outlook.com (2603:10b6:208:238::27)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 17:33:30 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::74) by MN2PR22CA0022.outlook.office365.com
 (2603:10b6:208:238::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 17:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 17:33:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 10:33:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 10:33:09 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 30
 Mar 2026 10:33:07 -0700
From: Chiara Meiohas <cmeiohas@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: <michaelgur@nvidia.com>, <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>
Subject: [PATCH v2 iproute2-next 1/4] rdma: Update headers
Date: Mon, 30 Mar 2026 20:31:15 +0300
Message-ID: <20260330173118.766885-2-cmeiohas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e7c664-1bee-4f56-3f5e-08de8e8275c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lbC00eqmehN5InXLDWTKymtBipiaUMQMz7/FJR2ekifH0g9Cm4ubhdz/NmmQp01+kQHpv0q0osniDdgUJtFaWV9NwEaKEVD3lGdeN0syI6IDn17sfUu2v0YR6nqSZl5Y1fXJlcA8Gp98nFKMsx1iRlN3dm4aAx+ik64RZna7JB6KLITaNHAXpcEc6SossTCXiAjzHUsf3niZ99BDR/bEju0001gWZ5heJI6Tc2Wdo9b6TjAJU13DrqCd7pea+id7FF0sSTx68YaHINyP80mDf7HYDkrbsNbE07JrSDgYvyNSmjYjJ1FsF58/HeOTtHRUE6DOT2fQAOk/Pl/tTNaCNmgZCSTG974MerdzonVeewBINCtqpXoQez75wzol5k5LoasivooBddXH66WHBrRIzVM0BbraEyh89/m/KIhKwYHapWGTufeb6l6+JOW+4JA2S/qXHAzPQ0/9RH9k2LadDhbPoYDZiGdnAhp/OwWVCVZvNvx/bthu10Eue0B0vMb1r9bC6qqJNpnuhSehsqGY9ZyXtlI1NFcQ/YVGrcFjTj/JtdgvMRPlmucs77eWqh06x53i+guV2DL+C5BpVMIVCt8t12fS0DJ/7AHzXZv94fZeOUvpPdlG0kXbcokE9e++Os+JxIwrtUnL5wgS3S5Abz3s/CXJxU0YKvU33nc3SCcppNaiTt95wbh5xzscwPArYhqFmua6TKikOVMg6US4WF3SUrCv28dAZPGGMPl53Vr3nKuvqZEqk37x/EFzVhyrN1DUF/LEbyNViD63y9OBog==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7mctfuAi+jUNKE7RvOHldN403kubQcpmnpheo9NH1MSga5NsPXzWoxXfu2JDPTAw2dQ70Fn25FGlZ0dbgKSNSYiw/9WsBvnvLQZDKpq+5O3r52B09BLM7MRIlYr16BU7GolCqgqiydzVas8ERBVaqqLOaYTctHBNHyKDQmNoOlBqcrv8IyjrNvac312NmwHIpqbgEg2gtFQhDo8oixpy5+Py7r9iiF/kFsWM6Qhufs2qXNtQdcT5AAhtgNYXCpA8/CI6OKXXXJbmMUhD+NukA55EbY+OsBaCNytdENdeL5ob2YO3f4SZEnoLp3OeRwX8aw3okxRKWelQNViJLM6X3vmxduSfdjmdjGKXpru/n55ezBLW6qoE31zgzMntVIZnMNX4hOYTLVZeut0+anYfSnow66kk6q/goR934OVVtN2MkHjs1kzlpOuEZsLL0nKA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 17:33:30.3781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e7c664-1bee-4f56-3f5e-08de8e8275c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802
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
	TAGGED_FROM(0.00)[bounces-18797-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: CB00535F579
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michael Guralnik <michaelgur@nvidia.com>

Update rdma_netlink.h file up to kernel commit dbd0472fd7a5
("RDMA/nldev: Expose kernel-internal FRMR pools in netlink")

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Chiara Meiohas <cmeiohas@nvidia.com>
---
 rdma/include/uapi/rdma/rdma_netlink.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
index ec8c19ca..8709e558 100644
--- a/rdma/include/uapi/rdma/rdma_netlink.h
+++ b/rdma/include/uapi/rdma/rdma_netlink.h
@@ -308,6 +308,10 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_MONITOR,
 
+	RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET, /* can dump */
+
+	RDMA_NLDEV_CMD_RES_FRMR_POOLS_SET,
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -582,6 +586,24 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_SYS_ATTR_MONITOR_MODE,	/* u8 */
 
 	RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED,	/* u8 */
+
+	/*
+	 * FRMR Pools attributes
+	 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOLS,			/* nested table */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_ENTRY,		/* nested table */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY,		/* nested table */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS,		/* u8 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS,	/* u32 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY,	/* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS, /* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES,	/* u32 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE,	/* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE,		/* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_AGING_PERIOD,	/* u32 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED,		/* u32 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_KERNEL_VENDOR_KEY, /* u64 */
+
 	/*
 	 * Always the end
 	 */
-- 
2.38.1


