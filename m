Return-Path: <linux-rdma+bounces-18006-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOsaEqmssWmzEQAAu9opvQ
	(envelope-from <linux-rdma+bounces-18006-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:55:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E31826851D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 383633018E2B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 17:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78843E63A8;
	Wed, 11 Mar 2026 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="Laml9E9j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023082.outbound.protection.outlook.com [40.93.201.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9493E63A4
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251747; cv=fail; b=MkXTajWt9FvLSgOjUKSeXjRBnEWABnrdx93plwSehJ9E1E+Bo9D2Nm4KMd7/dD4OoSVVzKOTi9j+oI5g/quV86AAkh/Tr8RC4COTW2sYLDrs8oLkVdNcWlQFqY++0vzEpZGRkMXIi6+69smdRx7p0/Sy6Qs1Cym9pRsSxM/bVNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251747; c=relaxed/simple;
	bh=XTKNIQQ3nysAGhHvIj4npPA3KoGbFHbSooAABrXvlMc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSmt9m55mCVFXAbbUv7esnnGHp9TJeKgbhoDzR+fdTT8YcnHvMAtxVf1e+5XwaWPw5UmKIBtCsxwPkrR1xYsyTFmrQeDg9AApz2kPex8/td0fRW/cJvnVtwCWsk3CcIPsJJbSworK338Msp22JOMagp7iHsjCEFSjePvQdHcfJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=Laml9E9j; arc=fail smtp.client-ip=40.93.201.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JijqkcteT5tA78Px8CuCWXfZQ5fz+xKlgNpBr5/s4ccFTtmVGorcWSHLWUF+n5Z7MoqoTAOST8GL3aCYBZHapdkRbpghNicZco/WJ/GByzYxI2pzfQH+klESLeEB7j8igCBlVHbHOf+sWveRx5+MG+T5bR8WUk4KpzNVWsFVA6MtLdLyfWwCzF06jbJgeXn+rmfOzNl5CBRxOVLEG4nVwjPFAkJOA/QtMyneust7Zr3edqxxBZjwO/m3Q9qU0xg8LoqzdKEQGEAHDVaV+pvME7dG9EVbzj2RsmDXyV9kxgDnR9iC1uZyZgosnQLeLYBBlYz8kA69nO6NvnBi04yRcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAJK8CxgCsuJnqdbAxFO/aX/8pv6Y2+0lS5/o8sYr/o=;
 b=bdPJn1JwCUZ/ssKxIp482SBxjRFTA4gbi3gHxa+C+fZTRnbqB28AwBS2wlvJoYcV32e2EBMtLt0KKP/75feNgBXUjUm3pArxW2/qg3jRCZ0hYXi7odmvA/nPKRzCiY4RBN3lWFcl+6w5GeXu3Ga8XnTTCAT+StDRMulSTqfkmsm/GWztYCDFES1hykh6EquqplJxfflbwXAk983F2RXgRd+7PyNLzF3goqVkkC1ZM93XhepjpUrLWfVY4eklpMcAPcnr+aXPtxmtRmQpoc1SPLBqpyc1Frl8xOrkOaCPjHfzpmnD0UmXzM1/hMps3ysTodI2p05szkbpABp0VxSVdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAJK8CxgCsuJnqdbAxFO/aX/8pv6Y2+0lS5/o8sYr/o=;
 b=Laml9E9jMU0OxQM3fkMxbEKyxaH3Wv0xqu3cXL48+MQq7M2fNg98ZMog/jc2KfyCNefUhXL5YQ01hFAl9huM8vATMv5oJ6KnD1piMQj3fx2BTXh5zW8gNRQgZD0WafWq2p64ewxo9hGkBTrWdbNa/17oNAade1qJHq+Ya/p5mSvc3+bL1VOW8avDYMDgcYQFMUlaDJ3eUH0+MbJP2JidSTcno1PekUrgn+u1TULWChsd2z65fq89wKJ5Gbro0smUWWFU3Jmf96lcPBfTcDphCyNnzOjzM9qtTJpoY/TghIPgxSQ+ebCXYK1hwCikWXM4kSzYcxVVFt+07Kap3KjJkQ==
Received: from BL1PR13CA0400.namprd13.prod.outlook.com (2603:10b6:208:2c2::15)
 by CH1PR01MB9264.prod.exchangelabs.com (2603:10b6:610:2b1::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.12; Wed, 11 Mar 2026 17:55:42 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::87) by BL1PR13CA0400.outlook.office365.com
 (2603:10b6:208:2c2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Wed,
 11 Mar 2026 17:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 11 Mar 2026 17:55:41 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 7E94014D819;
	Wed, 11 Mar 2026 13:55:41 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 7C1541810D6C5;
	Wed, 11 Mar 2026 13:55:41 -0400 (EDT)
Subject: [PATCH for-next resend 23/24] RDMA/hfi2: Make it build
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org
Date: Wed, 11 Mar 2026 13:55:41 -0400
Message-ID:
 <177325174147.57064.2017344581337669615.stgit@awdrv-04.cornelisnetworks.com>
In-Reply-To:
 <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
References:
 <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|CH1PR01MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 95568819-b459-4ec5-926f-08de7f976956
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|34020700016|1800799024|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dTzs0j9eK9N5umTq+U+LjRpGvFI4BtE9AM8oEzXC9URfcVOeBs9DqdnGO7suoZ4XdWZcQW9+uFPCok8F79MSg7q5J/cyceRrTK493YpVT7+3aa8h6KlKAk5045BOXlxLGlCxlgLPu1CbHF3cb8uOeMvz8dZMVTIrifLfeku+M4gdkxnSkMzVdnhn9DY5hbK3Fh8h+8rRuGnZLMOb+COW58In6LJ/aGXHs5CSV05BmZZsNpKyGcXS+PFbCM8kSSPODNDlrRxYhgjlE+Q90YoE59EiPSaea+fxsbrk622R3w/Xg+Dmr7u8bMk8jlJHGp6oq5448Inx0qopRY27Bdx3YpS96DdnMo+K9dJnID1AE2LsDUZx0z+yiig1PR2tFz1pBdHIU++/M7xxDw2HtHf1w/ZhiPrsEtwnRBOOvhHZDnILyuvNYgc3ndVFMzSZitnClEcH9dzXea2jc1LZqDRD/QSksKcUHgkF75EUihArHpDi3/EK7bqb9UbR7rzPI4NCnCO1Vh9WdcOkDciYII03lA5F/p2Mf8V2FSoadxXPIYXgxeG/mmCA0v7HlUM9rDLKzHvcbOgGHU6ptneTgAHsq7uNALigsnx6MDg6tkWy32dpQm/CVSLw0jx0z9a3kXCb9tsT/QbFawecEPWYzYVZMOEWdgSmLL7t31xzQBQArlD1Yw47WhUW6ZN5CkBQNjA6kuJidEEjzKRUpSQQoxIxfUMLHWQNGixP3Q8WBMGAQlPzSgCC0VDJ7YvdpM4OpHExd02XqvRwKskdILjGQpdQ2Q==
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(34020700016)(1800799024)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NFN9YXyXcJqPa4fK1BlO/CFk3GA9xV3ubnWZDdF4qu0bu+ngxt6G5ApTXDcatKUeumcO1s53hCDXXJtmqy4mJXbvZD/6yOD/PHBNYfn4h+p+VRJ2lwIuh2K7orAW1VoDLUZ9IZN2A8qabey2qcM+wy8rmXs8Yo88gHfVircqMavrTF62ulc/ci4A1GqAK/yvRFCcjBMpNSp7EGD2+usm2D2LbWxPXJYkQy+igQamlz/iz8QGYpY989FJpFxopL7GHBDabXTK5mFIvHSSK16w5G6RJChflr5CVB9d4PfE8rSe9o7KIcDtENaCz185/vgw3JkNGsWxZaSzY1YUF03RbELrEqxaiKxjxZmdKCXd5wiPafj9w5yh7McMftp2/9nhPweD0sUEI17J2RWwobRdj+ucpfQ5ecHpvRzObvhmH2crqtAE4t6rFXIDZk8ct0Zk
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:55:41.6655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95568819-b459-4ec5-926f-08de7f976956
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR01MB9264
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18006-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[awdrv-04.cornelisnetworks.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fu-berlin.de:email,cornelisnetworks.com:dkim,cornelisnetworks.com:email,dubeyko.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 1E31826851D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add in the Makefile now that all the pieces are in place.

Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 MAINTAINERS                        |    8 +++++++-
 drivers/infiniband/Kconfig         |    1 +
 drivers/infiniband/hw/Makefile     |    1 +
 drivers/infiniband/hw/hfi2/Kconfig |   25 +++++++++++++++++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/hw/hfi2/Kconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index c1fbd873fe14..5ac1c7064310 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11261,9 +11261,15 @@ F:	include/uapi/linux/cciss*.h
 HFI1 DRIVER
 M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
 L:	linux-rdma@vger.kernel.org
-S:	Supported
+S:	Obsolete
 F:	drivers/infiniband/hw/hfi1
 
+HFI2 DRIVER
+M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
+L:	linux-rdma@vger.kernel.org
+S:	Supported
+F:	drivers/infiniband/hw/hfi2
+
 HFS FILESYSTEM
 M:	Viacheslav Dubeyko <slava@dubeyko.com>
 M:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 80ed8bab0ed3..eb9722e9d0ac 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -85,6 +85,7 @@ source "drivers/infiniband/hw/cxgb4/Kconfig"
 source "drivers/infiniband/hw/efa/Kconfig"
 source "drivers/infiniband/hw/erdma/Kconfig"
 source "drivers/infiniband/hw/hfi1/Kconfig"
+source "drivers/infiniband/hw/hfi2/Kconfig"
 source "drivers/infiniband/hw/hns/Kconfig"
 source "drivers/infiniband/hw/ionic/Kconfig"
 source "drivers/infiniband/hw/irdma/Kconfig"
diff --git a/drivers/infiniband/hw/Makefile b/drivers/infiniband/hw/Makefile
index c42b22ac3303..d32ee79464a3 100644
--- a/drivers/infiniband/hw/Makefile
+++ b/drivers/infiniband/hw/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_INFINIBAND_OCRDMA)		+= ocrdma/
 obj-$(CONFIG_INFINIBAND_VMWARE_PVRDMA)	+= vmw_pvrdma/
 obj-$(CONFIG_INFINIBAND_USNIC)		+= usnic/
 obj-$(CONFIG_INFINIBAND_HFI1)		+= hfi1/
+obj-$(CONFIG_INFINIBAND_HFI2)		+= hfi2/
 obj-$(CONFIG_INFINIBAND_HNS_HIP08)	+= hns/
 obj-$(CONFIG_INFINIBAND_QEDR)		+= qedr/
 obj-$(CONFIG_INFINIBAND_BNXT_RE)	+= bnxt_re/
diff --git a/drivers/infiniband/hw/hfi2/Kconfig b/drivers/infiniband/hw/hfi2/Kconfig
new file mode 100644
index 000000000000..948e1c3d613c
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/Kconfig
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright(c) 2025-2026 Cornelis Networks, Inc.
+config INFINIBAND_HFI2
+	tristate "Cornelis OPX Gen1 support"
+	depends on X86_64 && INFINIBAND_RDMAVT && I2C && !UML
+	depends on PCI_IOV
+	select MMU_NOTIFIER
+	select CRC32
+	select I2C_ALGOBIT
+	help
+	This is a low-level driver for Cornelis OPX Gen1 adapter.
+config HFI2_DEBUG_SDMA_ORDER
+	bool "HFI2 SDMA Order debug"
+	depends on INFINIBAND_HFI2
+	default n
+	help
+	This is a debug flag to test for out of order
+	sdma completions for unit testing
+config HFI2_SDMA_VERBOSITY
+	bool "Config SDMA Verbosity"
+	depends on INFINIBAND_HFI2
+	default n
+	help
+	This is a configuration flag to enable verbose
+	SDMA debug



