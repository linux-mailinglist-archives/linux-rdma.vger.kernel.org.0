Return-Path: <linux-rdma+bounces-17992-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH6MB4SssWmzEQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17992-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:55:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 960892684EA
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C24A30936D8
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 17:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8E43E6393;
	Wed, 11 Mar 2026 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="iUTlXcG1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022117.outbound.protection.outlook.com [40.107.200.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A867F363094
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251678; cv=fail; b=PqK4xotJ+tOwp0CHNqX1JI5e+gS881FakOR2zrgRf/LOiEC5Wwv5CqyYMY97jRcS9v/8UFUP/GMMTre6FT0eFK13as1XYsj1FTSSGnRM4AjOe0ErW6w9a6kh5WZ8al63xjdx2WtACFLokIvIggoFbl46P6tlj7LsE4BagR72CgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251678; c=relaxed/simple;
	bh=AYMiim+IfWvVXo5yaao/xwWjL8TkidmcRcos42a+iTA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUOk+9spi4FmVhlgaVLX61ma9fjl55OD0j4l38zNA3+IWKm8eSXVL8W6ZZ6xUYxzmJcGNKIMDOR2wlwSDYPNaoWzvR7i4LY2rga0iZIFJWUZlC2OA9ToL4lxzyr1LrjKGfPcypSLD8boqRuorGEFdpBH0/44F9QeioN/oMUSUcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=iUTlXcG1; arc=fail smtp.client-ip=40.107.200.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvGmpxXBlMpO/PlEHxGYZB7KS/OgYtQvpgGLVWkKhsnh9c0NgiOI22X+GORZCPI3ISFdX2Ui2Z2+/xbVTu8YcGleoyzZKtTti1qlq/tKpqPmDH/mPCsb8quKu1vvzcnmpkLyK/EZPTph5b7oN2cE+qSQ+xR8BTATAwSLNRcp3u9CXUQFYdfgnaeefC6wGqUg4IIXiBbrZhNFSpT7ybz2Z692jyYSSsgW+0LbzL9Mho0TTbWA+hQ/d5hopve6SEaHoj2F+3AETwVcIVfQQ5+c89I0Htf+cDi4LwGUkdINJ6xTaPrD24fw8qNTPLQGaCV1O5htERucDH7kDOVHF2uhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRWv0PCAYb+UT71MDgLQiQLwqt0PpVqH/4hx3fz8MTs=;
 b=yYkbrzbfQqfCTfAUWF1djbuXx6YUwmj5FiAa9qYd86RGG+s9Z929/QMdBE8smib5xCcHiSv97mfQrK+mCDR1BQN4avzmn6T0N18GyYCA2wJy6Nu/9JbG6O8xwtJ+zt6sc3tKB8yNVUnfVsGAiTLAF0RKF0Tm90xmAx6Zi3FJm7wrAt42vy4CIzf2X1+1gEIdB8tjlFFWMGG0Kb4tCZ0p3ARLRRiZ5igBvnnhH0G6rey36EsEH9K2Aq729NTfD8j6zCy4TV3xGN7KNhLvrjt1BJ8OJvGyZffGJJfuUDMGCBl6ayh2qtZ49+nzl+690a12QaT99EO8YVrQaCDlYekLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.148.235.34) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRWv0PCAYb+UT71MDgLQiQLwqt0PpVqH/4hx3fz8MTs=;
 b=iUTlXcG1Z4DJu+Rcf+CkxOPAZ0at3LT6uz3EgwcAosIm2vJ/iWriE9SwONept/eRNoUaYWiHRbTKEaVXBNRiyFs/huGtNl9+BL3KbyuP+njTrWepx1m6CNYv5BPL5lukFgGGStvD7fNcXRO3s+z1rWwG8F/rmz92+CRblgBkSR8FW5Fih7OFMbrHsN8laTJCuAsgn1FO2+NBwjYIJgnqBIz9lP/aRsQgTsIPgMV/va9skmzgrOYmf3zVBpLg7LycsHh9anbhCpjJ/s4vj0ktAwerE+aKqdqsmwzqWATd5BYxL4atoh4F+q43hMIvjhZMLYKSsOqM/TtQLyVrkHGnXw==
Received: from SJ0PR13CA0036.namprd13.prod.outlook.com (2603:10b6:a03:2c2::11)
 by IA1PR01MB9369.prod.exchangelabs.com (2603:10b6:208:592::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.12; Wed, 11 Mar 2026 17:54:06 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::30) by SJ0PR13CA0036.outlook.office365.com
 (2603:10b6:a03:2c2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 17:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.148.235.34)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=cornelisnetworks.com;
Received-SPF: Fail (protection.outlook.com: domain of cornelisnetworks.com
 does not designate 50.148.235.34 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.148.235.34;
 helo=cn-mailer-00.localdomain;
Received: from cn-mailer-00.localdomain (50.148.235.34) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 11 Mar 2026 17:54:07 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id B35A914D817;
	Wed, 11 Mar 2026 13:54:05 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id A9B9C1810D6C5;
	Wed, 11 Mar 2026 13:54:05 -0400 (EDT)
Subject: [PATCH for-next resend 04/24] RDMA/hfi2: Add in HW register access
 support
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Wed, 11 Mar 2026 13:54:05 -0400
Message-ID:
 <177325164561.57064.4448649984406383407.stgit@awdrv-04.cornelisnetworks.com>
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
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|IA1PR01MB9369:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5366f9-ef2a-417c-d0e6-08de7f97311c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|34020700016|82310400026|1800799024|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	O6lCONx3QgVEDbgvrXK+LknlgsKh3M0hIJQqczG1byBE0+Yd5Kdyrbxx4rhqzyvsmpFx1kI7/s0l36Uqq87gYRwK/vhvKnOtBLvFKEaPlGSLHzEjD3Qt83oYfT7+LS3SZN53QRLOSzjsxVJSzxn/kzIIeBCwdkzqBucsUVSLmZVOZATvxDGFcYHKps3FPUuqC+wSH79MKb0x0mDbB2bQ/OLsnTQ3vfX+rNiHe/b7xbFtMADxAvJ7eVXUZ6ZnCa61eWbWyFaPrkamaKvuVABwX82NBDqv5Wh+MzBBxeJMW4w2fxSHlsCsXTjCyBZUziyz4AwbEdi2Dk9i4jbeETDefjyCRSYtzvgt4A1gwYGAN1lcQBOhpuJBIZezLr967Uv9i7ojHHIEQkNANy6MwxUo2/NiK10BWir1CyH/3OEWdcJWzxlO63S6lkwIITYJIBHIgCg9G7KxG3C+eJmg4MY6SLu+h61SI7B9poTergAaWBN7kueH1GCbm6dDZtltanispLRKYQRN4guMKKUlykhSNV8QcMnYuvI9jNJO5SNjUI7lYImd8esfcs39+NdzOLELJ2WkudwEmIr/sauIuBVATVaXnxqqiJAPV2Rz5Slt4Ua2TzSLKltLzGdNylFAmhzVpoT+J7Nd54z3B0uzuuCnOJf01srKSIaVCd78yYV9LMtUwb8adAueQHssTQRuHrqgJVm7WynK0ho2EkRA1UWjQPK6gUxjKrBHfpcpxaovMIMmYmFYCjcDCDsOHMu4S3gZAXmOkC/ydoR0DNZicN3Lrg==
X-Forefront-Antispam-Report:
	CIP:50.148.235.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:c-50-148-235-34.hsd1.mn.comcast.net;CAT:NONE;SFS:(13230040)(36860700016)(376014)(34020700016)(82310400026)(1800799024)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aCG7MR8az2hrVeHvPC7sl0Gt5Tg//ShPxd5UYIMGdp0+AUFB4LXr+RM8/f3WBAMkgYJQbtZCljIx2BXJZf8g26IBfbPKk/gZlyP1XoW52TF/4EIVw0yI053sh33e2nGPIhAPtCZ7cCJmBBX9r/TjLzTlD9eg6gjQrktSBDo5D2Po4bGQYuX2EFnfce6sKW5f0yIaYxDxP/ofCNix4NYPobRICecgEaZbI1RCLqSj/e0MC89m1m4EjL/tVx0fUOGbxqkAcDTgk/JjSbDt4AP2P/2j009BZcNvujXNis64i0xeNv7iEfoTshXk4qaCGBQbhkFyoDcUV7OTpzrT7wWOmBMhfk+qthSlsiuumhh98OxhkUlGyUQPkkMyRK2XfIf2SiPOlAEHZ9hgb2l8tsoKdE2jqfDUWfQAkQQcuT6uFeIj7smZYdQbXWeSaSwaSUf+
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:54:07.1223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5366f9-ef2a-417c-d0e6-08de7f97311c
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[50.148.235.34];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR01MB9369
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL_FRESH15(3.00)[pfx.work:url];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,awdrv-04.cornelisnetworks.com:mid,cornelisnetworks.com:dkim,cornelisnetworks.com:email,psc.work:url,pfx.work:url];
	TAGGED_FROM(0.00)[bounces-17992-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[cornelisnetworks.com:s=selector1];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[cornelisnetworks.com,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.400];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 960892684EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add in files that implement the use of the registers defined in the header
files added previously.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/chip.c     |12762 +++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/chip_gen.c | 1093 +++
 drivers/infiniband/hw/hfi2/chip_jkr.c |  989 +++
 drivers/infiniband/hw/hfi2/sriov.c    |  440 +
 drivers/infiniband/hw/hfi2/vf2pf.c    | 1111 +++
 drivers/infiniband/hw/hfi2/vf2pf_lb.c |  966 ++
 6 files changed, 17361 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/chip.c
 create mode 100644 drivers/infiniband/hw/hfi2/chip_gen.c
 create mode 100644 drivers/infiniband/hw/hfi2/chip_jkr.c
 create mode 100644 drivers/infiniband/hw/hfi2/sriov.c
 create mode 100644 drivers/infiniband/hw/hfi2/vf2pf.c
 create mode 100644 drivers/infiniband/hw/hfi2/vf2pf_lb.c

diff --git a/drivers/infiniband/hw/hfi2/chip.c b/drivers/infiniband/hw/hfi2/chip.c
new file mode 100644
index 000000000000..c9012ea0b970
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/chip.c
@@ -0,0 +1,12762 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+/*
+ * This file contains all of the code that is specific to the HFI chip
+ */
+
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+
+#include "hfi2.h"
+#include "file_ops.h"
+#include "trace.h"
+#include "mad.h"
+#include "pio.h"
+#include "sdma.h"
+#include "eprom.h"
+#include "efivar.h"
+#include "platform.h"
+#include "aspm.h"
+#include "affinity.h"
+#include "debugfs.h"
+#include "fault.h"
+#include "netdev.h"
+#include "chip_registers_jkr.h"
+#include "vf2pf.h"
+#include "sriov.h"
+
+uint num_vls = HFI2_MAX_VLS_SUPPORTED;
+module_param(num_vls, uint, 0444);
+MODULE_PARM_DESC(num_vls, "Set number of Virtual Lanes to use (1-8)");
+
+/*
+ * Default time to aggregate two 10K packets from the idle state
+ * (timer not running). The timer starts at the end of the first packet,
+ * so only the time for one 10K packet and header plus a bit extra is needed.
+ * 10 * 1024 + 64 header byte = 10304 byte
+ * 10304 byte / 12.5 GB/s = 824.32ns
+ */
+uint rcv_intr_timeout = (824 + 16); /* 16 is for coalescing interrupt */
+module_param(rcv_intr_timeout, uint, 0444);
+MODULE_PARM_DESC(rcv_intr_timeout, "Receive interrupt mitigation timeout in ns");
+
+uint rcv_intr_count = 16; /* same as qib */
+module_param(rcv_intr_count, uint, 0444);
+MODULE_PARM_DESC(rcv_intr_count, "Receive interrupt mitigation count");
+
+ushort link_crc_mask = SUPPORTED_CRCS;
+module_param(link_crc_mask, ushort, 0444);
+MODULE_PARM_DESC(link_crc_mask, "CRCs to use on the link");
+
+uint loopback;
+module_param_named(loopback, loopback, uint, 0444);
+MODULE_PARM_DESC(loopback, "Put into loopback mode (1 = serdes, 3 = external cable");
+
+int sdma_yield = 1000;	/* how often to yield when in thrd intr handler */
+module_param_named(sdma_yield, sdma_yield, int, 0644);
+MODULE_PARM_DESC(sdma_yield, "How long to run threaded SDMA irq without yield, mS");
+
+int rcvwcb = -1;	/* RcvIportCtrl.RcvWcb setting */
+module_param(rcvwcb, int, 0444);
+MODULE_PARM_DESC(rcvwcb, "Receive DMA write coalesce boundary (0=64, 1=128, 2=256, 3=512), default: WFR=0, other=3");
+
+/* Other driver tunables */
+uint rcv_intr_dynamic = 1; /* enable dynamic mode for rcv int mitigation*/
+static ushort crc_14b_sideband = 1;
+static uint use_flr = 1;
+uint quick_linkup; /* skip LNI */
+
+/* str must be a string constant */
+#define FLAG_ENTRY(str, extra, flag) {flag, str, extra}
+#define FLAG_ENTRY0(str, flag) {flag, str, 0}
+
+/* Send Error Consequences */
+#define SEC_WRITE_DROPPED	0x1
+#define SEC_PACKET_DROPPED	0x2
+#define SEC_SC_HALTED		0x4	/* per-context only */
+#define SEC_SPC_FREEZE		0x8	/* per-HFI only */
+
+#define DEFAULT_KRCVQS		  2
+#define MIN_KERNEL_KCTXTS         2
+#define FIRST_KERNEL_KCTXT        1
+
+/*
+ * RSM types
+ */
+#define RSM_TYPE_FECN             0
+#define RSM_TYPE_DEPRECATED       1
+#define RSM_TYPE_AIP              2
+#define RSM_TYPE_VERBS            3
+#define RSM_TYPE_MAD_RSP          4
+#define RSM_TYPE_MAD_ACTION       5
+
+/* Bit offset into the GUID which carries HFI id information */
+#define GUID_HFI_INDEX_SHIFT     39
+
+/* RSM fields for Verbs */
+#define QW_SHIFT               6ull
+/* QPN[7..1] */
+#define QPN_WIDTH              7ull
+
+/* LRH.BTH: QW 0, OFFSET 48 - for match */
+#define LRH_BTH_QW             0ull
+#define LRH_BTH_BIT_OFFSET     48ull
+#define LRH_BTH_OFFSET(off)    ((LRH_BTH_QW << QW_SHIFT) | (off))
+#define LRH_BTH_MATCH_OFFSET   LRH_BTH_OFFSET(LRH_BTH_BIT_OFFSET)
+#define LRH_BTH_SELECT
+#define LRH_BTH_MASK           3ull
+#define LRH_BTH_VALUE          2ull
+
+/* LRH.SC[3..0] QW 0, OFFSET 56 - for match */
+#define LRH_SC_QW              0ull
+#define LRH_SC_BIT_OFFSET      56ull
+#define LRH_SC_OFFSET(off)     ((LRH_SC_QW << QW_SHIFT) | (off))
+#define LRH_SC_MATCH_OFFSET    LRH_SC_OFFSET(LRH_SC_BIT_OFFSET)
+#define LRH_SC_MASK            128ull
+#define LRH_SC_VALUE           0ull
+
+/* SC[n..0] QW 0, OFFSET 60 - for select */
+#define LRH_SC_SELECT_OFFSET  ((LRH_SC_QW << QW_SHIFT) | (60ull))
+
+/* QPN[m+n:1] QW 1, OFFSET 1 */
+#define QPN_SELECT_OFFSET      ((1ull << QW_SHIFT) | (1ull))
+
+/* RSM fields for AIP */
+/* LRH.BTH above is reused for this rule */
+
+/* BTH.DESTQP: QW 1, OFFSET 16 for match */
+#define BTH_DESTQP_QW           1ull
+#define BTH_DESTQP_BIT_OFFSET   16ull
+#define BTH_DESTQP_OFFSET(off) ((BTH_DESTQP_QW << QW_SHIFT) | (off))
+#define BTH_DESTQP_MATCH_OFFSET BTH_DESTQP_OFFSET(BTH_DESTQP_BIT_OFFSET)
+#define BTH_DESTQP_MASK         0xFFull
+#define BTH_DESTQP_VALUE        0x81ull
+
+/* DETH.SQPN: QW 1 Offset 56 for select */
+/* We use 8 most significant Soure QPN bits as entropy fpr AIP */
+#define DETH_AIP_SQPN_QW 3ull
+#define DETH_AIP_SQPN_BIT_OFFSET 56ull
+#define DETH_AIP_SQPN_OFFSET(off) ((DETH_AIP_SQPN_QW << QW_SHIFT) | (off))
+#define DETH_AIP_SQPN_SELECT_OFFSET \
+	DETH_AIP_SQPN_OFFSET(DETH_AIP_SQPN_BIT_OFFSET)
+
+/* L4_TYPE QW 1, OFFSET 0 - for match */
+#define L4_TYPE_QW              1ull
+#define L4_TYPE_BIT_OFFSET      0ull
+#define L4_TYPE_OFFSET(off)     ((L4_TYPE_QW << QW_SHIFT) | (off))
+#define L4_TYPE_MATCH_OFFSET    L4_TYPE_OFFSET(L4_TYPE_BIT_OFFSET)
+#define L4_16B_TYPE_MASK        0xFFull
+#define L4_16B_ETH_VALUE        0x78ull
+
+/* 16B VESWID - for select */
+#define L4_16B_HDR_VESWID_OFFSET  ((2 << QW_SHIFT) | (16ull))
+/* 16B ENTROPY - for select */
+#define L2_16B_ENTROPY_OFFSET     ((1 << QW_SHIFT) | (32ull))
+
+/* defines to build power on SC2VL table */
+#define SC2VL_VAL( \
+	num, \
+	sc0, sc0val, \
+	sc1, sc1val, \
+	sc2, sc2val, \
+	sc3, sc3val, \
+	sc4, sc4val, \
+	sc5, sc5val, \
+	sc6, sc6val, \
+	sc7, sc7val) \
+( \
+	((u64)(sc0val) << SEND_SC2VLT##num##_SC##sc0##_SHIFT) | \
+	((u64)(sc1val) << SEND_SC2VLT##num##_SC##sc1##_SHIFT) | \
+	((u64)(sc2val) << SEND_SC2VLT##num##_SC##sc2##_SHIFT) | \
+	((u64)(sc3val) << SEND_SC2VLT##num##_SC##sc3##_SHIFT) | \
+	((u64)(sc4val) << SEND_SC2VLT##num##_SC##sc4##_SHIFT) | \
+	((u64)(sc5val) << SEND_SC2VLT##num##_SC##sc5##_SHIFT) | \
+	((u64)(sc6val) << SEND_SC2VLT##num##_SC##sc6##_SHIFT) | \
+	((u64)(sc7val) << SEND_SC2VLT##num##_SC##sc7##_SHIFT)   \
+)
+
+#define DC_SC_VL_VAL( \
+	range, \
+	e0, e0val, \
+	e1, e1val, \
+	e2, e2val, \
+	e3, e3val, \
+	e4, e4val, \
+	e5, e5val, \
+	e6, e6val, \
+	e7, e7val, \
+	e8, e8val, \
+	e9, e9val, \
+	e10, e10val, \
+	e11, e11val, \
+	e12, e12val, \
+	e13, e13val, \
+	e14, e14val, \
+	e15, e15val) \
+( \
+	((u64)(e0val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e0##_SHIFT) | \
+	((u64)(e1val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e1##_SHIFT) | \
+	((u64)(e2val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e2##_SHIFT) | \
+	((u64)(e3val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e3##_SHIFT) | \
+	((u64)(e4val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e4##_SHIFT) | \
+	((u64)(e5val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e5##_SHIFT) | \
+	((u64)(e6val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e6##_SHIFT) | \
+	((u64)(e7val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e7##_SHIFT) | \
+	((u64)(e8val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e8##_SHIFT) | \
+	((u64)(e9val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e9##_SHIFT) | \
+	((u64)(e10val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e10##_SHIFT) | \
+	((u64)(e11val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e11##_SHIFT) | \
+	((u64)(e12val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e12##_SHIFT) | \
+	((u64)(e13val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e13##_SHIFT) | \
+	((u64)(e14val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e14##_SHIFT) | \
+	((u64)(e15val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e15##_SHIFT) \
+)
+
+/* all CceStatus sub-block freeze bits */
+#define ALL_FROZE (CCE_STATUS_SDMA_FROZE_SMASK \
+			| CCE_STATUS_RXE_FROZE_SMASK \
+			| CCE_STATUS_TXE_FROZE_SMASK \
+			| CCE_STATUS_TXE_PIO_FROZE_SMASK)
+/* all CceStatus sub-block TXE pause bits */
+#define ALL_TXE_PAUSE (CCE_STATUS_TXE_PIO_PAUSED_SMASK \
+			| CCE_STATUS_TXE_PAUSED_SMASK \
+			| CCE_STATUS_SDMA_PAUSED_SMASK)
+/* all CceStatus sub-block RXE pause bits */
+#define ALL_RXE_PAUSE CCE_STATUS_RXE_PAUSED_SMASK
+
+#define CNTR_MAX 0xFFFFFFFFFFFFFFFFULL
+#define CNTR_32BIT_MAX 0x00000000FFFFFFFF
+
+/*
+ * CCE Error flags.
+ */
+static const struct flag_table cce_err_status_flags[] = {
+/* 0*/	FLAG_ENTRY0("CceCsrParityErr",
+		CCE_ERR_STATUS_CCE_CSR_PARITY_ERR_SMASK),
+/* 1*/	FLAG_ENTRY0("CceCsrReadBadAddrErr",
+		CCE_ERR_STATUS_CCE_CSR_READ_BAD_ADDR_ERR_SMASK),
+/* 2*/	FLAG_ENTRY0("CceCsrWriteBadAddrErr",
+		CCE_ERR_STATUS_CCE_CSR_WRITE_BAD_ADDR_ERR_SMASK),
+/* 3*/	FLAG_ENTRY0("CceTrgtAsyncFifoParityErr",
+		CCE_ERR_STATUS_CCE_TRGT_ASYNC_FIFO_PARITY_ERR_SMASK),
+/* 4*/	FLAG_ENTRY0("CceTrgtAccessErr",
+		CCE_ERR_STATUS_CCE_TRGT_ACCESS_ERR_SMASK),
+/* 5*/	FLAG_ENTRY0("CceRspdDataParityErr",
+		CCE_ERR_STATUS_CCE_RSPD_DATA_PARITY_ERR_SMASK),
+/* 6*/	FLAG_ENTRY0("CceCli0AsyncFifoParityErr",
+		CCE_ERR_STATUS_CCE_CLI0_ASYNC_FIFO_PARITY_ERR_SMASK),
+/* 7*/	FLAG_ENTRY0("CceCsrCfgBusParityErr",
+		CCE_ERR_STATUS_CCE_CSR_CFG_BUS_PARITY_ERR_SMASK),
+/* 8*/	FLAG_ENTRY0("CceCli2AsyncFifoParityErr",
+		CCE_ERR_STATUS_CCE_CLI2_ASYNC_FIFO_PARITY_ERR_SMASK),
+/* 9*/	FLAG_ENTRY0("CceCli1AsyncFifoPioCrdtParityErr",
+	    CCE_ERR_STATUS_CCE_CLI1_ASYNC_FIFO_PIO_CRDT_PARITY_ERR_SMASK),
+/*10*/	FLAG_ENTRY0("CceCli1AsyncFifoPioCrdtParityErr",
+	    CCE_ERR_STATUS_CCE_CLI1_ASYNC_FIFO_SDMA_HD_PARITY_ERR_SMASK),
+/*11*/	FLAG_ENTRY0("CceCli1AsyncFifoRxdmaParityError",
+	    CCE_ERR_STATUS_CCE_CLI1_ASYNC_FIFO_RXDMA_PARITY_ERROR_SMASK),
+/*12*/	FLAG_ENTRY0("CceCli1AsyncFifoDbgParityError",
+		CCE_ERR_STATUS_CCE_CLI1_ASYNC_FIFO_DBG_PARITY_ERROR_SMASK),
+/*13*/	FLAG_ENTRY0("PcicRetryMemCorErr",
+		CCE_ERR_STATUS_PCIC_RETRY_MEM_COR_ERR_SMASK),
+/*14*/	FLAG_ENTRY0("PcicRetryMemCorErr",
+		CCE_ERR_STATUS_PCIC_RETRY_SOT_MEM_COR_ERR_SMASK),
+/*15*/	FLAG_ENTRY0("PcicPostHdQCorErr",
+		CCE_ERR_STATUS_PCIC_POST_HD_QCOR_ERR_SMASK),
+/*16*/	FLAG_ENTRY0("PcicPostHdQCorErr",
+		CCE_ERR_STATUS_PCIC_POST_DAT_QCOR_ERR_SMASK),
+/*17*/	FLAG_ENTRY0("PcicPostHdQCorErr",
+		CCE_ERR_STATUS_PCIC_CPL_HD_QCOR_ERR_SMASK),
+/*18*/	FLAG_ENTRY0("PcicCplDatQCorErr",
+		CCE_ERR_STATUS_PCIC_CPL_DAT_QCOR_ERR_SMASK),
+/*19*/	FLAG_ENTRY0("PcicNPostHQParityErr",
+		CCE_ERR_STATUS_PCIC_NPOST_HQ_PARITY_ERR_SMASK),
+/*20*/	FLAG_ENTRY0("PcicNPostDatQParityErr",
+		CCE_ERR_STATUS_PCIC_NPOST_DAT_QPARITY_ERR_SMASK),
+/*21*/	FLAG_ENTRY0("PcicRetryMemUncErr",
+		CCE_ERR_STATUS_PCIC_RETRY_MEM_UNC_ERR_SMASK),
+/*22*/	FLAG_ENTRY0("PcicRetrySotMemUncErr",
+		CCE_ERR_STATUS_PCIC_RETRY_SOT_MEM_UNC_ERR_SMASK),
+/*23*/	FLAG_ENTRY0("PcicPostHdQUncErr",
+		CCE_ERR_STATUS_PCIC_POST_HD_QUNC_ERR_SMASK),
+/*24*/	FLAG_ENTRY0("PcicPostDatQUncErr",
+		CCE_ERR_STATUS_PCIC_POST_DAT_QUNC_ERR_SMASK),
+/*25*/	FLAG_ENTRY0("PcicCplHdQUncErr",
+		CCE_ERR_STATUS_PCIC_CPL_HD_QUNC_ERR_SMASK),
+/*26*/	FLAG_ENTRY0("PcicCplDatQUncErr",
+		CCE_ERR_STATUS_PCIC_CPL_DAT_QUNC_ERR_SMASK),
+/*27*/	FLAG_ENTRY0("PcicTransmitFrontParityErr",
+		CCE_ERR_STATUS_PCIC_TRANSMIT_FRONT_PARITY_ERR_SMASK),
+/*28*/	FLAG_ENTRY0("PcicTransmitBackParityErr",
+		CCE_ERR_STATUS_PCIC_TRANSMIT_BACK_PARITY_ERR_SMASK),
+/*29*/	FLAG_ENTRY0("PcicReceiveParityErr",
+		CCE_ERR_STATUS_PCIC_RECEIVE_PARITY_ERR_SMASK),
+/*30*/	FLAG_ENTRY0("CceTrgtCplTimeoutErr",
+		CCE_ERR_STATUS_CCE_TRGT_CPL_TIMEOUT_ERR_SMASK),
+/*31*/	FLAG_ENTRY0("LATriggered",
+		CCE_ERR_STATUS_LA_TRIGGERED_SMASK),
+/*32*/	FLAG_ENTRY0("CceSegReadBadAddrErr",
+		CCE_ERR_STATUS_CCE_SEG_READ_BAD_ADDR_ERR_SMASK),
+/*33*/	FLAG_ENTRY0("CceSegWriteBadAddrErr",
+		CCE_ERR_STATUS_CCE_SEG_WRITE_BAD_ADDR_ERR_SMASK),
+/*34*/	FLAG_ENTRY0("CceRcplAsyncFifoParityErr",
+		CCE_ERR_STATUS_CCE_RCPL_ASYNC_FIFO_PARITY_ERR_SMASK),
+/*35*/	FLAG_ENTRY0("CceRxdmaConvFifoParityErr",
+		CCE_ERR_STATUS_CCE_RXDMA_CONV_FIFO_PARITY_ERR_SMASK),
+/*36*/	FLAG_ENTRY0("CceMsixTableCorErr",
+		CCE_ERR_STATUS_CCE_MSIX_TABLE_COR_ERR_SMASK),
+/*37*/	FLAG_ENTRY0("CceMsixTableUncErr",
+		CCE_ERR_STATUS_CCE_MSIX_TABLE_UNC_ERR_SMASK),
+/*38*/	FLAG_ENTRY0("CceIntMapCorErr",
+		CCE_ERR_STATUS_CCE_INT_MAP_COR_ERR_SMASK),
+/*39*/	FLAG_ENTRY0("CceIntMapUncErr",
+		CCE_ERR_STATUS_CCE_INT_MAP_UNC_ERR_SMASK),
+/*40*/	FLAG_ENTRY0("CceMsixCsrParityErr",
+		CCE_ERR_STATUS_CCE_MSIX_CSR_PARITY_ERR_SMASK),
+/*41-63 reserved*/
+};
+
+/*
+ * Misc Error flags
+ */
+#define MES(text) MISC_ERR_STATUS_MISC_##text##_ERR_SMASK
+static const struct flag_table misc_err_status_flags[] = {
+/* 0*/	FLAG_ENTRY0("CSR_PARITY", MES(CSR_PARITY)),
+/* 1*/	FLAG_ENTRY0("CSR_READ_BAD_ADDR", MES(CSR_READ_BAD_ADDR)),
+/* 2*/	FLAG_ENTRY0("CSR_WRITE_BAD_ADDR", MES(CSR_WRITE_BAD_ADDR)),
+/* 3*/	FLAG_ENTRY0("SBUS_WRITE_FAILED", MES(SBUS_WRITE_FAILED)),
+/* 4*/	FLAG_ENTRY0("KEY_MISMATCH", MES(KEY_MISMATCH)),
+/* 5*/	FLAG_ENTRY0("FW_AUTH_FAILED", MES(FW_AUTH_FAILED)),
+/* 6*/	FLAG_ENTRY0("EFUSE_CSR_PARITY", MES(EFUSE_CSR_PARITY)),
+/* 7*/	FLAG_ENTRY0("EFUSE_READ_BAD_ADDR", MES(EFUSE_READ_BAD_ADDR)),
+/* 8*/	FLAG_ENTRY0("EFUSE_WRITE", MES(EFUSE_WRITE)),
+/* 9*/	FLAG_ENTRY0("EFUSE_DONE_PARITY", MES(EFUSE_DONE_PARITY)),
+/*10*/	FLAG_ENTRY0("INVALID_EEP_CMD", MES(INVALID_EEP_CMD)),
+/*11*/	FLAG_ENTRY0("MBIST_FAIL", MES(MBIST_FAIL)),
+/*12*/	FLAG_ENTRY0("PLL_LOCK_FAIL", MES(PLL_LOCK_FAIL))
+};
+
+/*
+ * TXE PIO Error flags and consequences
+ */
+static const struct flag_table pio_err_status_flags[] = {
+/* 0*/	FLAG_ENTRY("PioWriteBadCtxt",
+	SEC_WRITE_DROPPED,
+	SEND_PIO_ERR_STATUS_PIO_WRITE_BAD_CTXT_ERR_SMASK),
+/* 1*/	FLAG_ENTRY("PioWriteAddrParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_WRITE_ADDR_PARITY_ERR_SMASK),
+/* 2*/	FLAG_ENTRY("PioCsrParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_CSR_PARITY_ERR_SMASK),
+/* 3*/	FLAG_ENTRY("PioSbMemFifo0",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_SB_MEM_FIFO0_ERR_SMASK),
+/* 4*/	FLAG_ENTRY("PioSbMemFifo1",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_SB_MEM_FIFO1_ERR_SMASK),
+/* 5*/	FLAG_ENTRY("PioPccFifoParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_PCC_FIFO_PARITY_ERR_SMASK),
+/* 6*/	FLAG_ENTRY("PioPecFifoParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_PEC_FIFO_PARITY_ERR_SMASK),
+/* 7*/	FLAG_ENTRY("PioSbrdctlCrrelParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_SBRDCTL_CRREL_PARITY_ERR_SMASK),
+/* 8*/	FLAG_ENTRY("PioSbrdctrlCrrelFifoParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_SBRDCTRL_CRREL_FIFO_PARITY_ERR_SMASK),
+/* 9*/	FLAG_ENTRY("PioPktEvictFifoParityErr",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_PKT_EVICT_FIFO_PARITY_ERR_SMASK),
+/*10*/	FLAG_ENTRY("PioSmPktResetParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_SM_PKT_RESET_PARITY_ERR_SMASK),
+/*11*/	FLAG_ENTRY("PioVlLenMemBank0Unc",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_VL_LEN_MEM_BANK0_UNC_ERR_SMASK),
+/*12*/	FLAG_ENTRY("PioVlLenMemBank1Unc",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_VL_LEN_MEM_BANK1_UNC_ERR_SMASK),
+/*13*/	FLAG_ENTRY("PioVlLenMemBank0Cor",
+	0,
+	SEND_PIO_ERR_STATUS_PIO_VL_LEN_MEM_BANK0_COR_ERR_SMASK),
+/*14*/	FLAG_ENTRY("PioVlLenMemBank1Cor",
+	0,
+	SEND_PIO_ERR_STATUS_PIO_VL_LEN_MEM_BANK1_COR_ERR_SMASK),
+/*15*/	FLAG_ENTRY("PioCreditRetFifoParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_CREDIT_RET_FIFO_PARITY_ERR_SMASK),
+/*16*/	FLAG_ENTRY("PioPpmcPblFifo",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_PPMC_PBL_FIFO_ERR_SMASK),
+/*17*/	FLAG_ENTRY("PioInitSmIn",
+	0,
+	SEND_PIO_ERR_STATUS_PIO_INIT_SM_IN_ERR_SMASK),
+/*18*/	FLAG_ENTRY("PioPktEvictSmOrArbSm",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_PKT_EVICT_SM_OR_ARB_SM_ERR_SMASK),
+/*19*/	FLAG_ENTRY("PioHostAddrMemUnc",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_HOST_ADDR_MEM_UNC_ERR_SMASK),
+/*20*/	FLAG_ENTRY("PioHostAddrMemCor",
+	0,
+	SEND_PIO_ERR_STATUS_PIO_HOST_ADDR_MEM_COR_ERR_SMASK),
+/*21*/	FLAG_ENTRY("PioWriteDataParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_WRITE_DATA_PARITY_ERR_SMASK),
+/*22*/	FLAG_ENTRY("PioStateMachine",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_STATE_MACHINE_ERR_SMASK),
+/*23*/	FLAG_ENTRY("PioWriteQwValidParity",
+	SEC_WRITE_DROPPED | SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_WRITE_QW_VALID_PARITY_ERR_SMASK),
+/*24*/	FLAG_ENTRY("PioBlockQwCountParity",
+	SEC_WRITE_DROPPED | SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_BLOCK_QW_COUNT_PARITY_ERR_SMASK),
+/*25*/	FLAG_ENTRY("PioVlfVlLenParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_VLF_VL_LEN_PARITY_ERR_SMASK),
+/*26*/	FLAG_ENTRY("PioVlfSopParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_VLF_SOP_PARITY_ERR_SMASK),
+/*27*/	FLAG_ENTRY("PioVlFifoParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_VL_FIFO_PARITY_ERR_SMASK),
+/*28*/	FLAG_ENTRY("PioPpmcBqcMemParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_PPMC_BQC_MEM_PARITY_ERR_SMASK),
+/*29*/	FLAG_ENTRY("PioPpmcSopLen",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_PPMC_SOP_LEN_ERR_SMASK),
+/*30-31 reserved*/
+/*32*/	FLAG_ENTRY("PioCurrentFreeCntParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_CURRENT_FREE_CNT_PARITY_ERR_SMASK),
+/*33*/	FLAG_ENTRY("PioLastReturnedCntParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_LAST_RETURNED_CNT_PARITY_ERR_SMASK),
+/*34*/	FLAG_ENTRY("PioPccSopHeadParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_PCC_SOP_HEAD_PARITY_ERR_SMASK),
+/*35*/	FLAG_ENTRY("PioPecSopHeadParityErr",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_PEC_SOP_HEAD_PARITY_ERR_SMASK),
+/*36-63 reserved*/
+};
+
+/* TXE PIO errors that cause an SPC freeze */
+#define ALL_PIO_FREEZE_ERR \
+	(SEND_PIO_ERR_STATUS_PIO_WRITE_ADDR_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_CSR_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_SB_MEM_FIFO0_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_SB_MEM_FIFO1_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_PCC_FIFO_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_PEC_FIFO_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_SBRDCTL_CRREL_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_SBRDCTRL_CRREL_FIFO_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_PKT_EVICT_FIFO_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_SM_PKT_RESET_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_VL_LEN_MEM_BANK0_UNC_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_VL_LEN_MEM_BANK1_UNC_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_CREDIT_RET_FIFO_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_PPMC_PBL_FIFO_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_PKT_EVICT_SM_OR_ARB_SM_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_HOST_ADDR_MEM_UNC_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_WRITE_DATA_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_STATE_MACHINE_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_WRITE_QW_VALID_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_BLOCK_QW_COUNT_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_VLF_VL_LEN_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_VLF_SOP_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_VL_FIFO_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_PPMC_BQC_MEM_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_PPMC_SOP_LEN_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_CURRENT_FREE_CNT_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_LAST_RETURNED_CNT_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_PCC_SOP_HEAD_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_PEC_SOP_HEAD_PARITY_ERR_SMASK)
+
+/*
+ * TXE SDMA Error flags
+ */
+static const struct flag_table sdma_err_status_flags[] = {
+/* 0*/	FLAG_ENTRY0("SDmaRpyTagErr",
+		SEND_DMA_ERR_STATUS_SDMA_RPY_TAG_ERR_SMASK),
+/* 1*/	FLAG_ENTRY0("SDmaCsrParityErr",
+		SEND_DMA_ERR_STATUS_SDMA_CSR_PARITY_ERR_SMASK),
+/* 2*/	FLAG_ENTRY0("SDmaPcieReqTrackingUncErr",
+		SEND_DMA_ERR_STATUS_SDMA_PCIE_REQ_TRACKING_UNC_ERR_SMASK),
+/* 3*/	FLAG_ENTRY0("SDmaPcieReqTrackingCorErr",
+		SEND_DMA_ERR_STATUS_SDMA_PCIE_REQ_TRACKING_COR_ERR_SMASK),
+/*04-63 reserved*/
+};
+
+/* TXE SDMA errors that cause an SPC freeze */
+#define ALL_SDMA_FREEZE_ERR  \
+		(SEND_DMA_ERR_STATUS_SDMA_RPY_TAG_ERR_SMASK \
+		| SEND_DMA_ERR_STATUS_SDMA_CSR_PARITY_ERR_SMASK \
+		| SEND_DMA_ERR_STATUS_SDMA_PCIE_REQ_TRACKING_UNC_ERR_SMASK)
+
+/*
+ * TXE Egress Error flags
+ */
+#define SEES(text) SEND_EGRESS_ERR_STATUS_##text##_ERR_SMASK
+static const struct flag_table egress_err_status_flags[] = {
+/* 0*/	FLAG_ENTRY0("TxPktIntegrityMemCorErr", SEES(TX_PKT_INTEGRITY_MEM_COR)), /* WFR */
+/* 1*/	FLAG_ENTRY0("TxPktIntegrityMemUncErr", SEES(TX_PKT_INTEGRITY_MEM_UNC)), /* WFR */
+/* 2 reserved */
+/* 3*/	FLAG_ENTRY0("TxEgressFifoUnderrunOrParityErr",
+		SEES(TX_EGRESS_FIFO_UNDERRUN_OR_PARITY)),
+/* 4*/	FLAG_ENTRY0("TxLinkdownErr", SEES(TX_LINKDOWN)),
+/* 5*/	FLAG_ENTRY0("TxIncorrectLinkStateErr", SEES(TX_INCORRECT_LINK_STATE)),
+/* 6 reserved */
+/* 7*/	FLAG_ENTRY0("TxPioLaunchIntfParityErr",
+		SEES(TX_PIO_LAUNCH_INTF_PARITY)),
+/* 8*/	FLAG_ENTRY0("TxSdmaLaunchIntfParityErr",
+		SEES(TX_SDMA_LAUNCH_INTF_PARITY)),
+/* 9-10 reserved */
+/*11*/	FLAG_ENTRY0("TxSbrdCtlStateMachineParityErr",
+		SEES(TX_SBRD_CTL_STATE_MACHINE_PARITY)),
+/*12*/	FLAG_ENTRY0("TxIllegalVLErr", SEES(TX_ILLEGAL_VL)),
+/*13*/	FLAG_ENTRY0("TxLaunchCsrParityErr", SEES(TX_LAUNCH_CSR_PARITY)), /* WFR */
+/*14*/	FLAG_ENTRY0("TxSbrdCtlCsrParityErr", SEES(TX_SBRD_CTL_CSR_PARITY)),
+/*15*/	FLAG_ENTRY0("TxConfigParityErr", SEES(TX_CONFIG_PARITY)),
+/*16*/	FLAG_ENTRY0("TxSdma0DisallowedPacketErr",
+		SEES(TX_SDMA0_DISALLOWED_PACKET)),
+/*17*/	FLAG_ENTRY0("TxSdma1DisallowedPacketErr",
+		SEES(TX_SDMA1_DISALLOWED_PACKET)),
+/*18*/	FLAG_ENTRY0("TxSdma2DisallowedPacketErr",
+		SEES(TX_SDMA2_DISALLOWED_PACKET)),
+/*19*/	FLAG_ENTRY0("TxSdma3DisallowedPacketErr",
+		SEES(TX_SDMA3_DISALLOWED_PACKET)),
+/*20*/	FLAG_ENTRY0("TxSdma4DisallowedPacketErr",
+		SEES(TX_SDMA4_DISALLOWED_PACKET)),
+/*21*/	FLAG_ENTRY0("TxSdma5DisallowedPacketErr",
+		SEES(TX_SDMA5_DISALLOWED_PACKET)),
+/*22*/	FLAG_ENTRY0("TxSdma6DisallowedPacketErr",
+		SEES(TX_SDMA6_DISALLOWED_PACKET)),
+/*23*/	FLAG_ENTRY0("TxSdma7DisallowedPacketErr",
+		SEES(TX_SDMA7_DISALLOWED_PACKET)),
+/*24*/	FLAG_ENTRY0("TxSdma8DisallowedPacketErr",
+		SEES(TX_SDMA8_DISALLOWED_PACKET)),
+/*25*/	FLAG_ENTRY0("TxSdma9DisallowedPacketErr",
+		SEES(TX_SDMA9_DISALLOWED_PACKET)),
+/*26*/	FLAG_ENTRY0("TxSdma10DisallowedPacketErr",
+		SEES(TX_SDMA10_DISALLOWED_PACKET)),
+/*27*/	FLAG_ENTRY0("TxSdma11DisallowedPacketErr",
+		SEES(TX_SDMA11_DISALLOWED_PACKET)),
+/*28*/	FLAG_ENTRY0("TxSdma12DisallowedPacketErr",
+		SEES(TX_SDMA12_DISALLOWED_PACKET)),
+/*29*/	FLAG_ENTRY0("TxSdma13DisallowedPacketErr",
+		SEES(TX_SDMA13_DISALLOWED_PACKET)),
+/*30*/	FLAG_ENTRY0("TxSdma14DisallowedPacketErr",
+		SEES(TX_SDMA14_DISALLOWED_PACKET)),
+/*31*/	FLAG_ENTRY0("TxSdma15DisallowedPacketErr",
+		SEES(TX_SDMA15_DISALLOWED_PACKET)),
+/*32*/	FLAG_ENTRY0("TxLaunchFifo0UncOrParityErr",
+		SEES(TX_LAUNCH_FIFO0_UNC_OR_PARITY)),
+/*33*/	FLAG_ENTRY0("TxLaunchFifo1UncOrParityErr",
+		SEES(TX_LAUNCH_FIFO1_UNC_OR_PARITY)),
+/*34*/	FLAG_ENTRY0("TxLaunchFifo2UncOrParityErr",
+		SEES(TX_LAUNCH_FIFO2_UNC_OR_PARITY)),
+/*35*/	FLAG_ENTRY0("TxLaunchFifo3UncOrParityErr",
+		SEES(TX_LAUNCH_FIFO3_UNC_OR_PARITY)),
+/*36*/	FLAG_ENTRY0("TxLaunchFifo4UncOrParityErr",
+		SEES(TX_LAUNCH_FIFO4_UNC_OR_PARITY)),
+/*37*/	FLAG_ENTRY0("TxLaunchFifo5UncOrParityErr",
+		SEES(TX_LAUNCH_FIFO5_UNC_OR_PARITY)),
+/*38*/	FLAG_ENTRY0("TxLaunchFifo6UncOrParityErr",
+		SEES(TX_LAUNCH_FIFO6_UNC_OR_PARITY)),
+/*39*/	FLAG_ENTRY0("TxLaunchFifo7UncOrParityErr",
+		SEES(TX_LAUNCH_FIFO7_UNC_OR_PARITY)),
+/*40*/	FLAG_ENTRY0("TxLaunchFifo8UncOrParityErr",
+		SEES(TX_LAUNCH_FIFO8_UNC_OR_PARITY)),
+/*41*/	FLAG_ENTRY0("TxCreditReturnParityErr", SEES(TX_CREDIT_RETURN_PARITY)),
+/*42*/	FLAG_ENTRY0("TxSbHdrUncErr", SEES(TX_SB_HDR_UNC)),
+/*43*/	FLAG_ENTRY0("TxReadSdmaMemoryUncErr", SEES(TX_READ_SDMA_MEMORY_UNC)),
+/*44*/	FLAG_ENTRY0("TxReadPioMemoryUncErr", SEES(TX_READ_PIO_MEMORY_UNC)),
+/*45*/	FLAG_ENTRY0("TxEgressFifoUncErr", SEES(TX_EGRESS_FIFO_UNC)),
+/*46*/	FLAG_ENTRY0("TxHcrcInsertionErr", SEES(TX_HCRC_INSERTION)),
+/*47*/	FLAG_ENTRY0("TxCreditReturnVLErr", SEES(TX_CREDIT_RETURN_VL)),
+/*48*/	FLAG_ENTRY0("TxLaunchFifo0CorErr", SEES(TX_LAUNCH_FIFO0_COR)),
+/*49*/	FLAG_ENTRY0("TxLaunchFifo1CorErr", SEES(TX_LAUNCH_FIFO1_COR)),
+/*50*/	FLAG_ENTRY0("TxLaunchFifo2CorErr", SEES(TX_LAUNCH_FIFO2_COR)),
+/*51*/	FLAG_ENTRY0("TxLaunchFifo3CorErr", SEES(TX_LAUNCH_FIFO3_COR)),
+/*52*/	FLAG_ENTRY0("TxLaunchFifo4CorErr", SEES(TX_LAUNCH_FIFO4_COR)),
+/*53*/	FLAG_ENTRY0("TxLaunchFifo5CorErr", SEES(TX_LAUNCH_FIFO5_COR)),
+/*54*/	FLAG_ENTRY0("TxLaunchFifo6CorErr", SEES(TX_LAUNCH_FIFO6_COR)),
+/*55*/	FLAG_ENTRY0("TxLaunchFifo7CorErr", SEES(TX_LAUNCH_FIFO7_COR)),
+/*56*/	FLAG_ENTRY0("TxLaunchFifo8CorErr", SEES(TX_LAUNCH_FIFO8_COR)),
+/*57*/	FLAG_ENTRY0("TxCreditOverrunErr", SEES(TX_CREDIT_OVERRUN)),
+/*58*/	FLAG_ENTRY0("TxSbHdrCorErr", SEES(TX_SB_HDR_COR)),
+/*59*/	FLAG_ENTRY0("TxReadSdmaMemoryCorErr", SEES(TX_READ_SDMA_MEMORY_COR)),
+/*60*/	FLAG_ENTRY0("TxReadPioMemoryCorErr", SEES(TX_READ_PIO_MEMORY_COR)),
+/*61*/	FLAG_ENTRY0("TxEgressFifoCorErr", SEES(TX_EGRESS_FIFO_COR)),
+/*62*/	FLAG_ENTRY0("TxReadSdmaMemoryCsrUncErr",
+		SEES(TX_READ_SDMA_MEMORY_CSR_UNC)), /* WFR */
+/*63*/	FLAG_ENTRY0("TxReadPioMemoryCsrUncErr",
+		SEES(TX_READ_PIO_MEMORY_CSR_UNC)), /* WFR */
+};
+
+/*
+ * TXE Egress Error Info flags
+ */
+#define SEEI(text) SEND_EGRESS_ERR_INFO_##text##_ERR_SMASK
+static const struct flag_table wfr_egress_err_info_flags[] = {
+/* 0*/	FLAG_ENTRY0("Reserved", 0ull),
+/* 1*/	FLAG_ENTRY0("VLErr", SEEI(VL)),
+/* 2*/	FLAG_ENTRY0("JobKeyErr", SEEI(JOB_KEY)),
+/* 3*/	FLAG_ENTRY0("JobKeyErr", SEEI(JOB_KEY)),
+/* 4*/	FLAG_ENTRY0("PartitionKeyErr", SEEI(PARTITION_KEY)),
+/* 5*/	FLAG_ENTRY0("SLIDErr", SEEI(SLID)),
+/* 6*/	FLAG_ENTRY0("OpcodeErr", SEEI(OPCODE)),
+/* 7*/	FLAG_ENTRY0("VLMappingErr", SEEI(VL_MAPPING)),
+/* 8*/	FLAG_ENTRY0("RawErr", SEEI(RAW)),
+/* 9*/	FLAG_ENTRY0("RawIPv6Err", SEEI(RAW_IPV6)),
+/*10*/	FLAG_ENTRY0("GRHErr", SEEI(GRH)),
+/*11*/	FLAG_ENTRY0("BypassErr", SEEI(BYPASS)),
+/*12*/	FLAG_ENTRY0("KDETHPacketsErr", SEEI(KDETH_PACKETS)),
+/*13*/	FLAG_ENTRY0("NonKDETHPacketsErr", SEEI(NON_KDETH_PACKETS)),
+/*14*/	FLAG_ENTRY0("TooSmallIBPacketsErr", SEEI(TOO_SMALL_IB_PACKETS)),
+/*15*/	FLAG_ENTRY0("TooSmallBypassPacketsErr", SEEI(TOO_SMALL_BYPASS_PACKETS)),
+/*16*/	FLAG_ENTRY0("PbcTestErr", SEEI(PBC_TEST)),
+/*17*/	FLAG_ENTRY0("BadPktLenErr", SEEI(BAD_PKT_LEN)),
+/*18*/	FLAG_ENTRY0("TooLongIBPacketErr", SEEI(TOO_LONG_IB_PACKET)),
+/*19*/	FLAG_ENTRY0("TooLongBypassPacketsErr", SEEI(TOO_LONG_BYPASS_PACKETS)),
+/*20*/	FLAG_ENTRY0("PbcStaticRateControlErr", SEEI(PBC_STATIC_RATE_CONTROL)),
+/*21*/	FLAG_ENTRY0("BypassBadPktLenErr", SEEI(BAD_PKT_LEN)),
+};
+const struct flag_data wfr_egress_err_info_data = {
+	.table = wfr_egress_err_info_flags,
+	.size = ARRAY_SIZE(wfr_egress_err_info_flags),
+};
+
+/* TXE Egress errors that cause an SPC freeze */
+#define ALL_TXE_EGRESS_FREEZE_ERR \
+	(SEES(TX_EGRESS_FIFO_UNDERRUN_OR_PARITY) \
+	| SEES(TX_PIO_LAUNCH_INTF_PARITY) \
+	| SEES(TX_SDMA_LAUNCH_INTF_PARITY) \
+	| SEES(TX_SBRD_CTL_STATE_MACHINE_PARITY) \
+	| SEES(TX_LAUNCH_CSR_PARITY) \
+	| SEES(TX_SBRD_CTL_CSR_PARITY) \
+	| SEES(TX_CONFIG_PARITY) \
+	| SEES(TX_LAUNCH_FIFO0_UNC_OR_PARITY) \
+	| SEES(TX_LAUNCH_FIFO1_UNC_OR_PARITY) \
+	| SEES(TX_LAUNCH_FIFO2_UNC_OR_PARITY) \
+	| SEES(TX_LAUNCH_FIFO3_UNC_OR_PARITY) \
+	| SEES(TX_LAUNCH_FIFO4_UNC_OR_PARITY) \
+	| SEES(TX_LAUNCH_FIFO5_UNC_OR_PARITY) \
+	| SEES(TX_LAUNCH_FIFO6_UNC_OR_PARITY) \
+	| SEES(TX_LAUNCH_FIFO7_UNC_OR_PARITY) \
+	| SEES(TX_LAUNCH_FIFO8_UNC_OR_PARITY) \
+	| SEES(TX_CREDIT_RETURN_PARITY))
+
+/*
+ * TXE Send error flags
+ */
+#define SES(name) SEND_ERR_STATUS_SEND_##name##_ERR_SMASK
+static const struct flag_table send_err_status_flags[] = {
+/* 0*/	FLAG_ENTRY0("SendCsrParityErr", SES(CSR_PARITY)),
+/* 1*/	FLAG_ENTRY0("SendCsrReadBadAddrErr", SES(CSR_READ_BAD_ADDR)),
+/* 2*/	FLAG_ENTRY0("SendCsrWriteBadAddrErr", SES(CSR_WRITE_BAD_ADDR))
+};
+
+/*
+ * TXE Send Context Error flags and consequences
+ */
+static const struct flag_table sc_err_status_flags[] = {
+/* 0*/	FLAG_ENTRY("InconsistentSop",
+		SEC_PACKET_DROPPED | SEC_SC_HALTED,
+		SEND_CTXT_ERR_STATUS_PIO_INCONSISTENT_SOP_ERR_SMASK),
+/* 1*/	FLAG_ENTRY("DisallowedPacket",
+		SEC_PACKET_DROPPED | SEC_SC_HALTED,
+		SEND_CTXT_ERR_STATUS_PIO_DISALLOWED_PACKET_ERR_SMASK),
+/* 2*/	FLAG_ENTRY("WriteCrossesBoundary",
+		SEC_WRITE_DROPPED | SEC_SC_HALTED,
+		SEND_CTXT_ERR_STATUS_PIO_WRITE_CROSSES_BOUNDARY_ERR_SMASK),
+/* 3*/	FLAG_ENTRY("WriteOverflow",
+		SEC_WRITE_DROPPED | SEC_SC_HALTED,
+		SEND_CTXT_ERR_STATUS_PIO_WRITE_OVERFLOW_ERR_SMASK),
+/* 4*/	FLAG_ENTRY("WriteOutOfBounds",
+		SEC_WRITE_DROPPED | SEC_SC_HALTED,
+		SEND_CTXT_ERR_STATUS_PIO_WRITE_OUT_OF_BOUNDS_ERR_SMASK),
+/* 5-63 reserved*/
+};
+
+/*
+ * RXE Receive Error flags
+ */
+#define RXES(name) RCV_ERR_STATUS_RX_##name##_ERR_SMASK
+static const struct flag_table rxe_err_status_flags[] = {
+/* 0*/	FLAG_ENTRY0("RxDmaCsrCorErr", RXES(DMA_CSR_COR)),
+/* 1*/	FLAG_ENTRY0("RxCrkIntfParityErr", RXES(DC_INTF_PARITY)),
+/* 2*/	FLAG_ENTRY0("RxRcvHdrUncErr", RXES(RCV_HDR_UNC)),
+/* 3*/	FLAG_ENTRY0("RxRcvHdrCorErr", RXES(RCV_HDR_COR)),
+/* 4*/	FLAG_ENTRY0("RxRcvDataUncErr", RXES(RCV_DATA_UNC)),
+/* 5*/	FLAG_ENTRY0("RxRcvDataCorErr", RXES(RCV_DATA_COR)),
+/* 6*/	FLAG_ENTRY0("RxRcvQpMapTableUncErr", RXES(RCV_QP_MAP_TABLE_UNC)),
+/* 7*/	FLAG_ENTRY0("RxRcvQpMapTableCorErr", RXES(RCV_QP_MAP_TABLE_COR)),
+/* 8*/	FLAG_ENTRY0("RxRcvCsrParityErr", RXES(RCV_CSR_PARITY)),
+/* 9*/	FLAG_ENTRY0("RxCrkSopEopParityErr", RXES(DC_SOP_EOP_PARITY)),
+/*10*/	FLAG_ENTRY0("RxDmaFlagUncErr", RXES(DMA_FLAG_UNC)),
+/*11*/	FLAG_ENTRY0("RxDmaFlagCorErr", RXES(DMA_FLAG_COR)),
+/*12*/	FLAG_ENTRY0("RxRcvFsmEncodingErr", RXES(RCV_FSM_ENCODING)),
+/*13*/	FLAG_ENTRY0("RxRbufFreeListUncErr", RXES(RBUF_FREE_LIST_UNC)),
+/*14*/	FLAG_ENTRY0("RxRbufFreeListCorErr", RXES(RBUF_FREE_LIST_COR)),
+/*15*/	FLAG_ENTRY0("RxRbufLookupDesRegUncErr", RXES(RBUF_LOOKUP_DES_REG_UNC)),
+/*16*/	FLAG_ENTRY0("RxRbufLookupDesRegUncCorErr",
+		RXES(RBUF_LOOKUP_DES_REG_UNC_COR)),
+/*17*/	FLAG_ENTRY0("RxRbufLookupDesUncErr", RXES(RBUF_LOOKUP_DES_UNC)),
+/*18*/	FLAG_ENTRY0("RxRbufLookupDesCorErr", RXES(RBUF_LOOKUP_DES_COR)),
+/*19*/	FLAG_ENTRY0("RxRbufBlockListReadUncErr",
+		RXES(RBUF_BLOCK_LIST_READ_UNC)),
+/*20*/	FLAG_ENTRY0("RxRbufBlockListReadCorErr",
+		RXES(RBUF_BLOCK_LIST_READ_COR)),
+/*21*/	FLAG_ENTRY0("RxRbufCsrQHeadBufNumParityErr",
+		RXES(RBUF_CSR_QHEAD_BUF_NUM_PARITY)),
+/*22*/	FLAG_ENTRY0("RxRbufCsrQEntCntParityErr",
+		RXES(RBUF_CSR_QENT_CNT_PARITY)),
+/*23*/	FLAG_ENTRY0("RxRbufCsrQNextBufParityErr",
+		RXES(RBUF_CSR_QNEXT_BUF_PARITY)),
+/*24*/	FLAG_ENTRY0("RxRbufCsrQVldBitParityErr",
+		RXES(RBUF_CSR_QVLD_BIT_PARITY)),
+/*25*/	FLAG_ENTRY0("RxRbufCsrQHdPtrParityErr", RXES(RBUF_CSR_QHD_PTR_PARITY)),
+/*26*/	FLAG_ENTRY0("RxRbufCsrQTlPtrParityErr", RXES(RBUF_CSR_QTL_PTR_PARITY)),
+/*27*/	FLAG_ENTRY0("RxRbufCsrQNumOfPktParityErr",
+		RXES(RBUF_CSR_QNUM_OF_PKT_PARITY)),
+/*28*/	FLAG_ENTRY0("RxRbufCsrQEOPDWParityErr", RXES(RBUF_CSR_QEOPDW_PARITY)),
+/*29*/	FLAG_ENTRY0("RxRbufCtxIdParityErr", RXES(RBUF_CTX_ID_PARITY)),
+/*30*/	FLAG_ENTRY0("RxRBufBadLookupErr", RXES(RBUF_BAD_LOOKUP)),
+/*31*/	FLAG_ENTRY0("RxRbufFullErr", RXES(RBUF_FULL)),
+/*32*/	FLAG_ENTRY0("RxRbufEmptyErr", RXES(RBUF_EMPTY)),
+/*33*/	FLAG_ENTRY0("RxRbufFlRdAddrParityErr", RXES(RBUF_FL_RD_ADDR_PARITY)),
+/*34*/	FLAG_ENTRY0("RxRbufFlWrAddrParityErr", RXES(RBUF_FL_WR_ADDR_PARITY)),
+/*35*/	FLAG_ENTRY0("RxRbufFlInitdoneParityErr",
+		RXES(RBUF_FL_INITDONE_PARITY)),
+/*36*/	FLAG_ENTRY0("RxRbufFlInitWrAddrParityErr",
+		RXES(RBUF_FL_INIT_WR_ADDR_PARITY)),
+/*37*/	FLAG_ENTRY0("RxRbufNextFreeBufUncErr", RXES(RBUF_NEXT_FREE_BUF_UNC)),
+/*38*/	FLAG_ENTRY0("RxRbufNextFreeBufCorErr", RXES(RBUF_NEXT_FREE_BUF_COR)),
+/*39*/	FLAG_ENTRY0("RxLookupDesPart1UncErr", RXES(LOOKUP_DES_PART1_UNC)),
+/*40*/	FLAG_ENTRY0("RxLookupDesPart1UncCorErr",
+		RXES(LOOKUP_DES_PART1_UNC_COR)),
+/*41*/	FLAG_ENTRY0("RxLookupDesPart2ParityErr",
+		RXES(LOOKUP_DES_PART2_PARITY)),
+/*42*/	FLAG_ENTRY0("RxLookupRcvArrayUncErr", RXES(LOOKUP_RCV_ARRAY_UNC)),
+/*43*/	FLAG_ENTRY0("RxLookupRcvArrayCorErr", RXES(LOOKUP_RCV_ARRAY_COR)),
+/*44*/	FLAG_ENTRY0("RxLookupCsrParityErr", RXES(LOOKUP_CSR_PARITY)),
+/*45*/	FLAG_ENTRY0("RxHqIntrCsrParityErr", RXES(HQ_INTR_CSR_PARITY)),
+/*46*/	FLAG_ENTRY0("RxHqIntrFsmErr", RXES(HQ_INTR_FSM)),
+/*47*/	FLAG_ENTRY0("RxRbufDescPart1UncErr", RXES(RBUF_DESC_PART1_UNC)),
+/*48*/	FLAG_ENTRY0("RxRbufDescPart1CorErr", RXES(RBUF_DESC_PART1_COR)),
+/*49*/	FLAG_ENTRY0("RxRbufDescPart2UncErr", RXES(RBUF_DESC_PART2_UNC)),
+/*50*/	FLAG_ENTRY0("RxRbufDescPart2CorErr", RXES(RBUF_DESC_PART2_COR)),
+/*51*/	FLAG_ENTRY0("RxDmaHdrFifoRdUncErr", RXES(DMA_HDR_FIFO_RD_UNC)),
+/*52*/	FLAG_ENTRY0("RxDmaHdrFifoRdCorErr", RXES(DMA_HDR_FIFO_RD_COR)),
+/*53*/	FLAG_ENTRY0("RxDmaDataFifoRdUncErr", RXES(DMA_DATA_FIFO_RD_UNC)),
+/*54*/	FLAG_ENTRY0("RxDmaDataFifoRdCorErr", RXES(DMA_DATA_FIFO_RD_COR)),
+/*55*/	FLAG_ENTRY0("RxRbufDataUncErr", RXES(RBUF_DATA_UNC)),
+/*56*/	FLAG_ENTRY0("RxRbufDataCorErr", RXES(RBUF_DATA_COR)),
+/*57*/	FLAG_ENTRY0("RxDmaCsrParityErr", RXES(DMA_CSR_PARITY)),
+/*58*/	FLAG_ENTRY0("RxDmaEqFsmEncodingErr", RXES(DMA_EQ_FSM_ENCODING)),
+/*59*/	FLAG_ENTRY0("RxDmaDqFsmEncodingErr", RXES(DMA_DQ_FSM_ENCODING)),
+/*60*/	FLAG_ENTRY0("RxDmaCsrUncErr", RXES(DMA_CSR_UNC)),
+/*61*/	FLAG_ENTRY0("RxCsrReadBadAddrErr", RXES(CSR_READ_BAD_ADDR)),
+/*62*/	FLAG_ENTRY0("RxCsrWriteBadAddrErr", RXES(CSR_WRITE_BAD_ADDR)), /* WFR */
+/*63*/	FLAG_ENTRY0("RxCsrParityErr", RXES(CSR_PARITY)) /* WFR */
+};
+
+/* RXE errors that will trigger an SPC freeze */
+#define ALL_RXE_FREEZE_ERR  \
+	(RCV_ERR_STATUS_RX_RCV_QP_MAP_TABLE_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RCV_CSR_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_DMA_FLAG_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RCV_FSM_ENCODING_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_FREE_LIST_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_LOOKUP_DES_REG_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_LOOKUP_DES_REG_UNC_COR_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_LOOKUP_DES_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_BLOCK_LIST_READ_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_CSR_QHEAD_BUF_NUM_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_CSR_QENT_CNT_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_CSR_QNEXT_BUF_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_CSR_QVLD_BIT_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_CSR_QHD_PTR_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_CSR_QTL_PTR_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_CSR_QNUM_OF_PKT_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_CSR_QEOPDW_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_CTX_ID_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_BAD_LOOKUP_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_FULL_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_EMPTY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_FL_RD_ADDR_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_FL_WR_ADDR_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_FL_INITDONE_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_FL_INIT_WR_ADDR_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_NEXT_FREE_BUF_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_LOOKUP_DES_PART1_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_LOOKUP_DES_PART1_UNC_COR_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_LOOKUP_DES_PART2_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_LOOKUP_RCV_ARRAY_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_LOOKUP_CSR_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_HQ_INTR_CSR_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_HQ_INTR_FSM_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_DESC_PART1_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_DESC_PART1_COR_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_DESC_PART2_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_DMA_HDR_FIFO_RD_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_DMA_DATA_FIFO_RD_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_DATA_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_DMA_CSR_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_DMA_EQ_FSM_ENCODING_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_DMA_DQ_FSM_ENCODING_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_DMA_CSR_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_CSR_PARITY_ERR_SMASK)
+
+#define RXE_FREEZE_ABORT_MASK \
+	(RCV_ERR_STATUS_RX_DMA_CSR_UNC_ERR_SMASK | \
+	RCV_ERR_STATUS_RX_DMA_HDR_FIFO_RD_UNC_ERR_SMASK | \
+	RCV_ERR_STATUS_RX_DMA_DATA_FIFO_RD_UNC_ERR_SMASK)
+
+/*
+ * DCC Error Flags
+ */
+#define DCCE(name) DCC_ERR_FLG_##name##_SMASK
+static const struct flag_table dcc_err_flags[] = {
+	FLAG_ENTRY0("bad_l2_err", DCCE(BAD_L2_ERR)),
+	FLAG_ENTRY0("bad_sc_err", DCCE(BAD_SC_ERR)),
+	FLAG_ENTRY0("bad_mid_tail_err", DCCE(BAD_MID_TAIL_ERR)),
+	FLAG_ENTRY0("bad_preemption_err", DCCE(BAD_PREEMPTION_ERR)),
+	FLAG_ENTRY0("preemption_err", DCCE(PREEMPTION_ERR)),
+	FLAG_ENTRY0("preemptionvl15_err", DCCE(PREEMPTIONVL15_ERR)),
+	FLAG_ENTRY0("bad_vl_marker_err", DCCE(BAD_VL_MARKER_ERR)),
+	FLAG_ENTRY0("bad_dlid_target_err", DCCE(BAD_DLID_TARGET_ERR)),
+	FLAG_ENTRY0("bad_lver_err", DCCE(BAD_LVER_ERR)),
+	FLAG_ENTRY0("uncorrectable_err", DCCE(UNCORRECTABLE_ERR)),
+	FLAG_ENTRY0("bad_crdt_ack_err", DCCE(BAD_CRDT_ACK_ERR)),
+	FLAG_ENTRY0("unsup_pkt_type", DCCE(UNSUP_PKT_TYPE)),
+	FLAG_ENTRY0("bad_ctrl_flit_err", DCCE(BAD_CTRL_FLIT_ERR)),
+	FLAG_ENTRY0("event_cntr_parity_err", DCCE(EVENT_CNTR_PARITY_ERR)),
+	FLAG_ENTRY0("event_cntr_rollover_err", DCCE(EVENT_CNTR_ROLLOVER_ERR)),
+	FLAG_ENTRY0("link_err", DCCE(LINK_ERR)),
+	FLAG_ENTRY0("misc_cntr_rollover_err", DCCE(MISC_CNTR_ROLLOVER_ERR)),
+	FLAG_ENTRY0("bad_ctrl_dist_err", DCCE(BAD_CTRL_DIST_ERR)),
+	FLAG_ENTRY0("bad_tail_dist_err", DCCE(BAD_TAIL_DIST_ERR)),
+	FLAG_ENTRY0("bad_head_dist_err", DCCE(BAD_HEAD_DIST_ERR)),
+	FLAG_ENTRY0("nonvl15_state_err", DCCE(NONVL15_STATE_ERR)),
+	FLAG_ENTRY0("vl15_multi_err", DCCE(VL15_MULTI_ERR)),
+	FLAG_ENTRY0("bad_pkt_length_err", DCCE(BAD_PKT_LENGTH_ERR)),
+	FLAG_ENTRY0("unsup_vl_err", DCCE(UNSUP_VL_ERR)),
+	FLAG_ENTRY0("perm_nvl15_err", DCCE(PERM_NVL15_ERR)),
+	FLAG_ENTRY0("slid_zero_err", DCCE(SLID_ZERO_ERR)),
+	FLAG_ENTRY0("dlid_zero_err", DCCE(DLID_ZERO_ERR)),
+	FLAG_ENTRY0("length_mtu_err", DCCE(LENGTH_MTU_ERR)),
+	FLAG_ENTRY0("rx_early_drop_err", DCCE(RX_EARLY_DROP_ERR)),
+	FLAG_ENTRY0("late_short_err", DCCE(LATE_SHORT_ERR)),
+	FLAG_ENTRY0("late_long_err", DCCE(LATE_LONG_ERR)),
+	FLAG_ENTRY0("late_ebp_err", DCCE(LATE_EBP_ERR)),
+	FLAG_ENTRY0("fpe_tx_fifo_ovflw_err", DCCE(FPE_TX_FIFO_OVFLW_ERR)),
+	FLAG_ENTRY0("fpe_tx_fifo_unflw_err", DCCE(FPE_TX_FIFO_UNFLW_ERR)),
+	FLAG_ENTRY0("csr_access_blocked_host", DCCE(CSR_ACCESS_BLOCKED_HOST)),
+	FLAG_ENTRY0("csr_access_blocked_uc", DCCE(CSR_ACCESS_BLOCKED_UC)),
+	FLAG_ENTRY0("tx_ctrl_parity_err", DCCE(TX_CTRL_PARITY_ERR)),
+	FLAG_ENTRY0("tx_ctrl_parity_mbe_err", DCCE(TX_CTRL_PARITY_MBE_ERR)),
+	FLAG_ENTRY0("tx_sc_parity_err", DCCE(TX_SC_PARITY_ERR)),
+	FLAG_ENTRY0("rx_ctrl_parity_mbe_err", DCCE(RX_CTRL_PARITY_MBE_ERR)),
+	FLAG_ENTRY0("csr_parity_err", DCCE(CSR_PARITY_ERR)),
+	FLAG_ENTRY0("csr_inval_addr", DCCE(CSR_INVAL_ADDR)),
+	FLAG_ENTRY0("tx_byte_shft_parity_err", DCCE(TX_BYTE_SHFT_PARITY_ERR)),
+	FLAG_ENTRY0("rx_byte_shft_parity_err", DCCE(RX_BYTE_SHFT_PARITY_ERR)),
+	FLAG_ENTRY0("fmconfig_err", DCCE(FMCONFIG_ERR)),
+	FLAG_ENTRY0("rcvport_err", DCCE(RCVPORT_ERR)),
+};
+
+/*
+ * LCB error flags
+ */
+#define LCBE(name) DC_LCB_ERR_FLG_##name##_SMASK
+static const struct flag_table lcb_err_flags[] = {
+/* 0*/	FLAG_ENTRY0("CSR_PARITY_ERR", LCBE(CSR_PARITY_ERR)),
+/* 1*/	FLAG_ENTRY0("INVALID_CSR_ADDR", LCBE(INVALID_CSR_ADDR)),
+/* 2*/	FLAG_ENTRY0("RST_FOR_FAILED_DESKEW", LCBE(RST_FOR_FAILED_DESKEW)),
+/* 3*/	FLAG_ENTRY0("ALL_LNS_FAILED_REINIT_TEST",
+		LCBE(ALL_LNS_FAILED_REINIT_TEST)),
+/* 4*/	FLAG_ENTRY0("LOST_REINIT_STALL_OR_TOS", LCBE(LOST_REINIT_STALL_OR_TOS)),
+/* 5*/	FLAG_ENTRY0("TX_LESS_THAN_FOUR_LNS", LCBE(TX_LESS_THAN_FOUR_LNS)),
+/* 6*/	FLAG_ENTRY0("RX_LESS_THAN_FOUR_LNS", LCBE(RX_LESS_THAN_FOUR_LNS)),
+/* 7*/	FLAG_ENTRY0("SEQ_CRC_ERR", LCBE(SEQ_CRC_ERR)),
+/* 8*/	FLAG_ENTRY0("REINIT_FROM_PEER", LCBE(REINIT_FROM_PEER)),
+/* 9*/	FLAG_ENTRY0("REINIT_FOR_LN_DEGRADE", LCBE(REINIT_FOR_LN_DEGRADE)),
+/*10*/	FLAG_ENTRY0("CRC_ERR_CNT_HIT_LIMIT", LCBE(CRC_ERR_CNT_HIT_LIMIT)),
+/*11*/	FLAG_ENTRY0("RCLK_STOPPED", LCBE(RCLK_STOPPED)),
+/*12*/	FLAG_ENTRY0("UNEXPECTED_REPLAY_MARKER", LCBE(UNEXPECTED_REPLAY_MARKER)),
+/*13*/	FLAG_ENTRY0("UNEXPECTED_ROUND_TRIP_MARKER",
+		LCBE(UNEXPECTED_ROUND_TRIP_MARKER)),
+/*14*/	FLAG_ENTRY0("ILLEGAL_NULL_LTP", LCBE(ILLEGAL_NULL_LTP)),
+/*15*/	FLAG_ENTRY0("ILLEGAL_FLIT_ENCODING", LCBE(ILLEGAL_FLIT_ENCODING)),
+/*16*/	FLAG_ENTRY0("FLIT_INPUT_BUF_OFLW", LCBE(FLIT_INPUT_BUF_OFLW)),
+/*17*/	FLAG_ENTRY0("VL_ACK_INPUT_BUF_OFLW", LCBE(VL_ACK_INPUT_BUF_OFLW)),
+/*18*/	FLAG_ENTRY0("VL_ACK_INPUT_PARITY_ERR", LCBE(VL_ACK_INPUT_PARITY_ERR)),
+/*19*/	FLAG_ENTRY0("VL_ACK_INPUT_WRONG_CRC_MODE",
+		LCBE(VL_ACK_INPUT_WRONG_CRC_MODE)),
+/*20*/	FLAG_ENTRY0("FLIT_INPUT_BUF_MBE", LCBE(FLIT_INPUT_BUF_MBE)),
+/*21*/	FLAG_ENTRY0("FLIT_INPUT_BUF_SBE", LCBE(FLIT_INPUT_BUF_SBE)),
+/*22*/	FLAG_ENTRY0("REPLAY_BUF_MBE", LCBE(REPLAY_BUF_MBE)),
+/*23*/	FLAG_ENTRY0("REPLAY_BUF_SBE", LCBE(REPLAY_BUF_SBE)),
+/*24*/	FLAG_ENTRY0("CREDIT_RETURN_FLIT_MBE", LCBE(CREDIT_RETURN_FLIT_MBE)),
+/*25*/	FLAG_ENTRY0("RST_FOR_LINK_TIMEOUT", LCBE(RST_FOR_LINK_TIMEOUT)),
+/*26*/	FLAG_ENTRY0("RST_FOR_INCOMPLT_RND_TRIP",
+		LCBE(RST_FOR_INCOMPLT_RND_TRIP)),
+/*27*/	FLAG_ENTRY0("HOLD_REINIT", LCBE(HOLD_REINIT)),
+/*28*/	FLAG_ENTRY0("NEG_EDGE_LINK_TRANSFER_ACTIVE",
+		LCBE(NEG_EDGE_LINK_TRANSFER_ACTIVE)),
+/*29*/	FLAG_ENTRY0("REDUNDANT_FLIT_PARITY_ERR",
+		LCBE(REDUNDANT_FLIT_PARITY_ERR))
+};
+
+/*
+ * DC8051 Error Flags
+ */
+#define D8E(name) DC_DC8051_ERR_FLG_##name##_SMASK
+static const struct flag_table dc8051_err_flags[] = {
+	FLAG_ENTRY0("SET_BY_8051", D8E(SET_BY_8051)),
+	FLAG_ENTRY0("LOST_8051_HEART_BEAT", D8E(LOST_8051_HEART_BEAT)),
+	FLAG_ENTRY0("CRAM_MBE", D8E(CRAM_MBE)),
+	FLAG_ENTRY0("CRAM_SBE", D8E(CRAM_SBE)),
+	FLAG_ENTRY0("DRAM_MBE", D8E(DRAM_MBE)),
+	FLAG_ENTRY0("DRAM_SBE", D8E(DRAM_SBE)),
+	FLAG_ENTRY0("IRAM_MBE", D8E(IRAM_MBE)),
+	FLAG_ENTRY0("IRAM_SBE", D8E(IRAM_SBE)),
+	FLAG_ENTRY0("UNMATCHED_SECURE_MSG_ACROSS_BCC_LANES",
+		    D8E(UNMATCHED_SECURE_MSG_ACROSS_BCC_LANES)),
+	FLAG_ENTRY0("INVALID_CSR_ADDR", D8E(INVALID_CSR_ADDR)),
+};
+
+/*
+ * DC8051 Information Error flags
+ *
+ * Flags in DC8051_DBG_ERR_INFO_SET_BY_8051.ERROR field.
+ */
+static const struct flag_table dc8051_info_err_flags[] = {
+	FLAG_ENTRY0("Spico ROM check failed",  SPICO_ROM_FAILED),
+	FLAG_ENTRY0("Unknown frame received",  UNKNOWN_FRAME),
+	FLAG_ENTRY0("Target BER not met",      TARGET_BER_NOT_MET),
+	FLAG_ENTRY0("Serdes internal loopback failure",
+		    FAILED_SERDES_INTERNAL_LOOPBACK),
+	FLAG_ENTRY0("Failed SerDes init",      FAILED_SERDES_INIT),
+	FLAG_ENTRY0("Failed LNI(Polling)",     FAILED_LNI_POLLING),
+	FLAG_ENTRY0("Failed LNI(Debounce)",    FAILED_LNI_DEBOUNCE),
+	FLAG_ENTRY0("Failed LNI(EstbComm)",    FAILED_LNI_ESTBCOMM),
+	FLAG_ENTRY0("Failed LNI(OptEq)",       FAILED_LNI_OPTEQ),
+	FLAG_ENTRY0("Failed LNI(VerifyCap_1)", FAILED_LNI_VERIFY_CAP1),
+	FLAG_ENTRY0("Failed LNI(VerifyCap_2)", FAILED_LNI_VERIFY_CAP2),
+	FLAG_ENTRY0("Failed LNI(ConfigLT)",    FAILED_LNI_CONFIGLT),
+	FLAG_ENTRY0("Host Handshake Timeout",  HOST_HANDSHAKE_TIMEOUT),
+	FLAG_ENTRY0("External Device Request Timeout",
+		    EXTERNAL_DEVICE_REQ_TIMEOUT),
+};
+
+/*
+ * DC8051 Information Host Information flags
+ *
+ * Flags in DC8051_DBG_ERR_INFO_SET_BY_8051.HOST_MSG field.
+ */
+static const struct flag_table dc8051_info_host_msg_flags[] = {
+	FLAG_ENTRY0("Host request done", 0x0001),
+	FLAG_ENTRY0("BC PWR_MGM message", 0x0002),
+	FLAG_ENTRY0("BC SMA message", 0x0004),
+	FLAG_ENTRY0("BC Unknown message (BCC)", 0x0008),
+	FLAG_ENTRY0("BC Unknown message (LCB)", 0x0010),
+	FLAG_ENTRY0("External device config request", 0x0020),
+	FLAG_ENTRY0("VerifyCap all frames received", 0x0040),
+	FLAG_ENTRY0("LinkUp achieved", 0x0080),
+	FLAG_ENTRY0("Link going down", 0x0100),
+	FLAG_ENTRY0("Link width downgraded", 0x0200),
+};
+
+static u32 chip_to_opa_lstate(struct hfi2_devdata *dd, u32 chip_lstate);
+static int set_physical_link_state(struct hfi2_devdata *dd, u64 state);
+static void read_vc_remote_phy(struct hfi2_devdata *dd, u8 *power_management,
+			       u8 *continuous);
+static void read_vc_remote_fabric(struct hfi2_devdata *dd, u8 *vau, u8 *z,
+				  u8 *vcu, u16 *vl15buf, u8 *crc_sizes);
+static void read_vc_remote_link_width(struct hfi2_devdata *dd,
+				      u8 *remote_tx_rate, u16 *link_widths);
+static void read_vc_local_link_mode(struct hfi2_devdata *dd, u8 *misc_bits,
+				    u8 *flag_bits, u16 *link_widths);
+static void read_remote_device_id(struct hfi2_devdata *dd, u16 *device_id,
+				  u8 *device_rev);
+static void read_local_lni(struct hfi2_devdata *dd, u8 *enable_lane_rx);
+static int read_tx_settings(struct hfi2_devdata *dd, u8 *enable_lane_tx,
+			    u8 *tx_polarity_inversion,
+			    u8 *rx_polarity_inversion, u8 *max_rate);
+static void handle_qsfp_int(struct hfi2_devdata *dd, u32 source, u64 reg);
+static void handle_dcc_err(struct hfi2_devdata *dd,
+			   unsigned int context, u64 err_status);
+static void handle_lcb_err(struct hfi2_devdata *dd,
+			   unsigned int context, u64 err_status);
+static void handle_8051_interrupt(struct hfi2_devdata *dd, u32 unused, u64 reg);
+static void handle_cce_err(struct hfi2_devdata *dd, u32 unused, u64 reg);
+static void handle_misc_err(struct hfi2_devdata *dd, u32 unused, u64 reg);
+static void handle_txe_err(struct hfi2_devdata *dd, u32 unused, u64 reg);
+static void set_partition_keys(struct hfi2_pportdata *ppd);
+static int do_8051_command(struct hfi2_devdata *dd, u32 type, u64 in_data,
+			   u64 *out_data);
+static int read_idle_sma(struct hfi2_devdata *dd, u64 *data);
+static int thermal_init(struct hfi2_devdata *dd);
+
+static int wait_phys_link_offline_substates(struct hfi2_pportdata *ppd,
+					    int msecs);
+static int wait_logical_linkstate(struct hfi2_pportdata *ppd, u32 state,
+				  int msecs);
+static void log_physical_state(struct hfi2_pportdata *ppd, u32 state);
+static int wait_physical_linkstate(struct hfi2_pportdata *ppd, u32 state,
+				   int msecs);
+static int wait_phys_link_out_of_offline(struct hfi2_pportdata *ppd,
+					 int msecs);
+static void read_planned_down_reason_code(struct hfi2_devdata *dd, u8 *pdrrc);
+static void read_link_down_reason(struct hfi2_devdata *dd, u8 *ldr);
+static void dc_shutdown(struct hfi2_devdata *dd);
+static void dc_start(struct hfi2_devdata *dd);
+static int qos_rmt_entries(unsigned int n_krcv_queues, unsigned int *mp,
+			   unsigned int *np);
+static void clear_full_mgmt_pkey(struct hfi2_pportdata *ppd);
+static int wait_link_transfer_active(struct hfi2_devdata *dd, int wait_ms);
+static void clear_rsm_rule(struct hfi2_devdata *dd, int rule_index);
+
+#define NUM_MISC_ERRS (IS_GENERAL_ERR_END + 1 - IS_GENERAL_ERR_START)
+#define NUM_DC_ERRS (IS_DC_END + 1 - IS_DC_START)
+#define NUM_VARIOUS (IS_VARIOUS_END + 1 - IS_VARIOUS_START)
+
+/*
+ * Helpers DC error interrupt table entries.  Different helpers are needed
+ * because of inconsistent register names.
+ */
+#define DC_EE1(reg, handler, desc) \
+	{ reg##_FLG, reg##_FLG_CLR, reg##_FLG_EN, ICD_NORMAL, handler, desc }
+#define DC_EE2(reg, handler, desc) \
+	{ reg##_FLG, reg##_CLR, reg##_EN, ICD_NORMAL, handler, desc }
+
+/*
+ * Table of the "misc" grouping of error interrupts.  Each entry refers to
+ * another register containing more information.
+ */
+static const struct err_reg_info misc_errs[NUM_MISC_ERRS] = {
+	EE_N(CCE_ERR,		  handle_cce_err,    "CceErr"),
+	EE_I(WFR_RCV_ERR,	  handle_rxe_err,    "RxeErr"),
+	EE_N(MISC_ERR,		  handle_misc_err,   "MiscErr"),
+	{}, /* reserved */
+	EE_N(WFR_SEND_PIO_ERR,    handle_pio_err,    "PioErr"),
+	EE_N(WFR_SEND_DMA_ERR,    handle_sdma_err,   "SDmaErr"),
+	EE_E(WFR_SEND_EGRESS_ERR, handle_egress_err, "EgressErr"),
+	EE_N(WFR_SEND_ERR,	  handle_txe_err,    "TxeErr")
+	/* the rest are reserved */
+};
+
+/*
+ * Index into the Various section of the interrupt sources
+ * corresponding to the Critical Temperature interrupt.
+ */
+#define TCRIT_INT_SOURCE 4
+
+/*
+ * SDMA error interrupt entry - refers to another register containing more
+ * information.
+ */
+static const struct err_reg_info sdma_eng_err =
+	EE_S(WFR_SEND_DMA_ENG_ERR, handle_sdma_eng_err, "SDmaEngErr");
+
+static const struct err_reg_info various_err[NUM_VARIOUS] = {
+	{}, /* PbcInt */
+	{}, /* GpioAssertInt */
+	EE_N(ASIC_QSFP1, handle_qsfp_int, "QSFP1"),
+	EE_N(ASIC_QSFP2, handle_qsfp_int, "QSFP2"),
+	{}, /* TCritInt */
+	/* the rest are reserved */
+};
+
+/*
+ * The DC encoding of mtu_cap for 10K MTU in the DCC_CFG_PORT_CONFIG
+ * register can not be derived from the MTU value because 10K is not
+ * a power of 2. Therefore, we need a constant. Everything else can
+ * be calculated.
+ */
+#define DCC_CFG_PORT_MTU_CAP_10240 7
+
+/*
+ * Table of the DC grouping of error interrupts.  Each entry refers to
+ * another register containing more information.
+ */
+static const struct err_reg_info dc_errs[NUM_DC_ERRS] = {
+	DC_EE1(DCC_ERR,		handle_dcc_err,	       "DCC Err"),
+	DC_EE2(DC_LCB_ERR,	handle_lcb_err,	       "LCB Err"),
+	DC_EE2(DC_DC8051_ERR,	handle_8051_interrupt, "DC8051 Interrupt"),
+	/* dc_lbm_int - special, see is_dc_int() */
+	/* the rest are reserved */
+};
+
+
+/* ======================================================================== */
+
+/* return true if this is WFR chip revision a */
+int is_ax(struct hfi2_devdata *dd)
+{
+	int chip_rev_minor;
+
+	if (dd->params->chip_type != CHIP_WFR)
+		return 0;
+
+	chip_rev_minor = (dd->revision >> CCE_REVISION_CHIP_REV_MINOR_SHIFT)
+				& CCE_REVISION_CHIP_REV_MINOR_MASK;
+	return (chip_rev_minor & 0xf0) == 0;
+}
+
+/* return true if this is WFR chip revision b or not WFR */
+int is_bx(struct hfi2_devdata *dd)
+{
+	int chip_rev_minor;
+
+	if (dd->params->chip_type != CHIP_WFR)
+		return 1;
+
+	chip_rev_minor = (dd->revision >> CCE_REVISION_CHIP_REV_MINOR_SHIFT)
+				& CCE_REVISION_CHIP_REV_MINOR_MASK;
+	return (chip_rev_minor & 0xF0) == 0x10;
+}
+
+/* return true is kernel urg disabled for rcd */
+bool is_urg_masked(struct hfi2_ctxtdata *rcd)
+{
+	u64 mask;
+	u32 is = rcd->dd->params->is_rcvurgent_start + rcd->ctxt;
+	u8 bit = is % 64;
+
+	mask = read_csr(rcd->dd, rcd->dd->params->cce_int_mask_reg + (8 * (is / 64)));
+	return !(mask & BIT_ULL(bit));
+}
+
+/*
+ * Append string s to buffer buf.  Arguments curp and len are the current
+ * position and remaining length, respectively.
+ *
+ * return 0 on success, 1 on out of room
+ */
+static int append_str(char *buf, char **curp, int *lenp, const char *s)
+{
+	char *p = *curp;
+	int len = *lenp;
+	int result = 0; /* success */
+	char c;
+
+	/* add a comma, if first in the buffer */
+	if (p != buf) {
+		if (len == 0) {
+			result = 1; /* out of room */
+			goto done;
+		}
+		*p++ = ',';
+		len--;
+	}
+
+	/* copy the string */
+	while ((c = *s++) != 0) {
+		if (len == 0) {
+			result = 1; /* out of room */
+			goto done;
+		}
+		*p++ = c;
+		len--;
+	}
+
+done:
+	/* write return values */
+	*curp = p;
+	*lenp = len;
+
+	return result;
+}
+
+/*
+ * Using the given flag table, print a comma separated string into
+ * the buffer.  End in '*' if the buffer is too short.
+ */
+static char *flag_string(char *buf, int buf_len, u64 flags,
+			 const struct flag_table *table, int table_size)
+{
+	char extra[32];
+	char *p = buf;
+	int len = buf_len;
+	int no_room = 0;
+	int i;
+
+	/* make sure there is at least 2 so we can form "*" */
+	if (len < 2)
+		return "";
+
+	len--;	/* leave room for a nul */
+	for (i = 0; i < table_size; i++) {
+		if (flags & table[i].flag) {
+			no_room = append_str(buf, &p, &len, table[i].str);
+			if (no_room)
+				break;
+			flags &= ~table[i].flag;
+		}
+	}
+
+	/* any undocumented bits left? */
+	if (!no_room && flags) {
+		snprintf(extra, sizeof(extra), "bits 0x%llx", flags);
+		no_room = append_str(buf, &p, &len, extra);
+	}
+
+	/* add * if ran out of room */
+	if (no_room) {
+		/* may need to back up to add space for a '*' */
+		if (len == 0)
+			--p;
+		*p++ = '*';
+	}
+
+	/* add final nul - space already allocated above */
+	*p = 0;
+	return buf;
+}
+
+/* first 8 CCE error interrupt source names */
+static const char * const cce_misc_names[] = {
+	"CceErrInt",		/* 0 */
+	"RxeErrInt",		/* 1 */
+	"MiscErrInt",		/* 2 */
+	"Reserved3",		/* 3 */
+	"PioErrInt",		/* 4 */
+	"SDmaErrInt",		/* 5 */
+	"EgressErrInt",		/* 6 */
+	"TxeErrInt"		/* 7 */
+};
+
+/*
+ * Return the miscellaneous error interrupt name.
+ */
+static char *is_misc_err_name(char *buf, size_t bsize, unsigned int source)
+{
+	if (source < ARRAY_SIZE(cce_misc_names))
+		strscpy_pad(buf, cce_misc_names[source], bsize);
+	else
+		snprintf(buf, bsize, "Reserved%u",
+			 source + IS_GENERAL_ERR_START);
+
+	return buf;
+}
+
+/*
+ * Return the SDMA engine error interrupt name.
+ */
+char *is_sdma_eng_err_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "SDmaEngErrInt%u", source);
+	return buf;
+}
+
+/*
+ * Return the send context error interrupt name.
+ */
+char *is_sendctxt_err_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "SendCtxtErrInt%u", source);
+	return buf;
+}
+
+static const char * const various_names[] = {
+	"PbcInt",
+	"GpioAssertInt",
+	"Qsfp1Int",
+	"Qsfp2Int",
+	"TCritInt"
+};
+
+/*
+ * Return the various interrupt name.
+ */
+static char *is_various_name(char *buf, size_t bsize, unsigned int source)
+{
+	if (source < ARRAY_SIZE(various_names))
+		strscpy_pad(buf, various_names[source], bsize);
+	else
+		snprintf(buf, bsize, "Reserved%u", source + IS_VARIOUS_START);
+	return buf;
+}
+
+/*
+ * Return the DC interrupt name.
+ */
+static char *is_dc_name(char *buf, size_t bsize, unsigned int source)
+{
+	static const char * const dc_int_names[] = {
+		"common",
+		"lcb",
+		"8051",
+		"lbm"	/* local block merge */
+	};
+
+	if (source < ARRAY_SIZE(dc_int_names))
+		snprintf(buf, bsize, "dc_%s_int", dc_int_names[source]);
+	else
+		snprintf(buf, bsize, "DCInt%u", source);
+	return buf;
+}
+
+static const char * const sdma_int_names[] = {
+	"SDmaInt",
+	"SdmaIdleInt",
+	"SdmaProgressInt",
+};
+
+/*
+ * Return the SDMA engine interrupt name.
+ */
+char *is_sdma_eng_name(char *buf, size_t bsize, unsigned int source)
+{
+	/* what interrupt */
+	unsigned int what  = source / TXE_NUM_SDMA_ENGINES;
+	/* which engine */
+	unsigned int which = source % TXE_NUM_SDMA_ENGINES;
+
+	if (likely(what < 3))
+		snprintf(buf, bsize, "%s%u", sdma_int_names[what], which);
+	else
+		snprintf(buf, bsize, "Invalid SDMA interrupt %u", source);
+	return buf;
+}
+
+/*
+ * Return the receive available interrupt name.
+ */
+char *is_rcv_avail_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "RcvAvailInt%u", source);
+	return buf;
+}
+
+/*
+ * Return the receive urgent interrupt name.
+ */
+char *is_rcv_urgent_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "RcvUrgentInt%u", source);
+	return buf;
+}
+
+/*
+ * Return the send credit interrupt name.
+ */
+char *is_send_credit_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "SendCreditInt%u", source);
+	return buf;
+}
+
+/*
+ * Return the reserved interrupt name.
+ */
+static char *is_reserved_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "Reserved%u", source + IS_RESERVED_START);
+	return buf;
+}
+
+static char *cce_err_status_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags,
+			   cce_err_status_flags,
+			   ARRAY_SIZE(cce_err_status_flags));
+}
+
+static char *rxe_err_status_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags,
+			   rxe_err_status_flags,
+			   ARRAY_SIZE(rxe_err_status_flags));
+}
+
+static char *misc_err_status_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags, misc_err_status_flags,
+			   ARRAY_SIZE(misc_err_status_flags));
+}
+
+static char *pio_err_status_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags,
+			   pio_err_status_flags,
+			   ARRAY_SIZE(pio_err_status_flags));
+}
+
+static char *sdma_err_status_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags,
+			   sdma_err_status_flags,
+			   ARRAY_SIZE(sdma_err_status_flags));
+}
+
+static char *egress_err_status_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags,
+			   egress_err_status_flags,
+			   ARRAY_SIZE(egress_err_status_flags));
+}
+
+static char *egress_err_info_string(struct hfi2_devdata *dd, char *buf,
+				    int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags,
+			   dd->params->egress_err_info_data->table,
+			   dd->params->egress_err_info_data->size);
+}
+
+static char *send_err_status_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags,
+			   send_err_status_flags,
+			   ARRAY_SIZE(send_err_status_flags));
+}
+
+static void handle_cce_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	char buf[96];
+	int i = 0;
+
+	/*
+	 * For most these errors, there is nothing that can be done except
+	 * report or record it.
+	 */
+	dd_dev_info(dd, "CCE Error: %s\n",
+		    cce_err_status_string(buf, sizeof(buf), reg));
+
+	if ((reg & CCE_ERR_STATUS_CCE_CLI2_ASYNC_FIFO_PARITY_ERR_SMASK) &&
+	    is_ax(dd)) {
+		/* this error requires a manual drop into SPC freeze mode */
+		/* then a fix up */
+		start_freeze_handling(dd, FREEZE_SELF);
+	}
+
+	for (i = 0; i < NUM_CCE_ERR_STATUS_COUNTERS; i++) {
+		if (reg & (1ull << i)) {
+			incr_cntr64(&dd->cce_err_status_cnt[i]);
+			/* maintain a counter over all cce_err_status errors */
+			incr_cntr64(&dd->sw_cce_err_status_aggregate);
+		}
+	}
+}
+
+/*
+ * Check counters for receive errors that do not have an interrupt
+ * associated with them.
+ */
+static void do_rcverr_timer(struct work_struct *work)
+{
+	struct hfi2_devdata *dd = container_of(work, struct hfi2_devdata,
+					       rcverr_work);
+	struct hfi2_pportdata *ppd;
+	u32 cur_ovfl_cnt;
+	int pidx;
+
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		ppd = &dd->pport[pidx];
+		cur_ovfl_cnt = read_port_cntr(ppd, C_RCV_OVF, CNTR_INVALID_VL);
+
+		if (ppd->rcv_ovfl_cnt < cur_ovfl_cnt &&
+		    ppd->port_error_action & OPA_PI_MASK_EX_BUFFER_OVERRUN) {
+			ppd_dev_info(ppd, "%s: PortErrorAction bounce\n", __func__);
+			set_link_down_reason(ppd,
+				OPA_LINKDOWN_REASON_EXCESSIVE_BUFFER_OVERRUN, 0,
+				OPA_LINKDOWN_REASON_EXCESSIVE_BUFFER_OVERRUN);
+			queue_work(ppd->link_wq, &ppd->link_bounce_work);
+		}
+		ppd->rcv_ovfl_cnt = cur_ovfl_cnt;
+	}
+}
+
+#define RCVERR_CHECK_TIME 10
+static void update_rcverr_timer(struct timer_list *t)
+{
+	struct hfi2_devdata *dd = timer_container_of(dd, t, rcverr_timer);
+
+	/* avoid timer interrupt context CSR access when simulating */
+	if (dd->icode == ICODE_FUNCTIONAL_SIMULATOR)
+		queue_work(dd->update_cntr_wq, &dd->rcverr_work);
+	else
+		do_rcverr_timer(&dd->rcverr_work);
+	mod_timer(&dd->rcverr_timer, jiffies + HZ * RCVERR_CHECK_TIME);
+}
+
+
+void handle_rxe_err(struct hfi2_devdata *dd, u32 pidx, u64 reg)
+{
+	struct hfi2_pportdata *ppd = &dd->pport[pidx];
+	char buf[96];
+	int i = 0;
+
+	ppd_dev_info(ppd, "Receive Error: %s\n",
+		     rxe_err_status_string(buf, sizeof(buf), reg));
+
+	if (reg & ALL_RXE_FREEZE_ERR) {
+		int flags = 0;
+
+		/*
+		 * Freeze mode recovery is disabled for the errors
+		 * in RXE_FREEZE_ABORT_MASK
+		 */
+		if (is_ax(dd) && (reg & RXE_FREEZE_ABORT_MASK))
+			flags = FREEZE_ABORT;
+
+		start_freeze_handling(dd, flags);
+	}
+
+	for (i = 0; i < NUM_RCV_ERR_STATUS_COUNTERS; i++) {
+		if (reg & (1ull << i))
+			incr_cntr64(&dd->rcv_err_status_cnt[i]);
+	}
+}
+
+static void handle_misc_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	char buf[96];
+	int i = 0;
+
+	dd_dev_info(dd, "Misc Error: %s",
+		    misc_err_status_string(buf, sizeof(buf), reg));
+	for (i = 0; i < NUM_MISC_ERR_STATUS_COUNTERS; i++) {
+		if (reg & (1ull << i))
+			incr_cntr64(&dd->misc_err_status_cnt[i]);
+	}
+}
+
+void handle_pio_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	char buf[96];
+	int i = 0;
+
+	dd_dev_info(dd, "PIO Error: %s\n",
+		    pio_err_status_string(buf, sizeof(buf), reg));
+
+	if (reg & ALL_PIO_FREEZE_ERR)
+		start_freeze_handling(dd, 0);
+
+	for (i = 0; i < NUM_SEND_PIO_ERR_STATUS_COUNTERS; i++) {
+		if (reg & (1ull << i))
+			incr_cntr64(&dd->send_pio_err_status_cnt[i]);
+	}
+}
+
+void handle_sdma_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	char buf[96];
+	int i = 0;
+
+	dd_dev_info(dd, "SDMA Error: %s\n",
+		    sdma_err_status_string(buf, sizeof(buf), reg));
+
+	if (reg & ALL_SDMA_FREEZE_ERR)
+		start_freeze_handling(dd, 0);
+
+	for (i = 0; i < NUM_SEND_DMA_ERR_STATUS_COUNTERS; i++) {
+		if (reg & (1ull << i))
+			incr_cntr64(&dd->send_dma_err_status_cnt[i]);
+	}
+}
+
+static inline void __count_port_discards(struct hfi2_pportdata *ppd)
+{
+	incr_cntr64(&ppd->port_xmit_discards);
+}
+
+static void count_port_inactive(struct hfi2_pportdata *ppd)
+{
+	__count_port_discards(ppd);
+}
+
+static u64 egress_err_info(struct hfi2_pportdata *ppd, bool loopback)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u8 pidx = loopback ? loopback_pidx(ppd) : ppd->hw_pidx;
+
+	/* read err source first */
+	u64 src = read_eport_csr(dd, pidx, dd->params->send_egress_err_source_reg);
+	u64 info = read_eport_csr(dd, pidx, dd->params->send_egress_err_info_reg);
+	char buf[96];
+
+	/* clear down all observed info as quickly as possible after read */
+	write_eport_csr(dd, pidx, dd->params->send_egress_err_info_reg, info);
+
+	ppd_dev_info(ppd,
+		     "%s Egress Error Info: 0x%llx, %s Egress Error Src 0x%llx\n",
+		     loopback ? "LB" : "FC",
+		     info, egress_err_info_string(dd, buf, sizeof(buf), info), src);
+	return info;
+}
+
+/*
+ * We have had a "disallowed packet" error during egress. Determine the
+ * integrity check which failed, and update relevant error counter, etc.
+ *
+ * Note that the SEND_EGRESS_ERR_INFO register has only a single
+ * bit of state per integrity check, and so we can miss the reason for an
+ * egress error if more than one packet fails the same integrity check
+ * since we cleared the corresponding bit in SEND_EGRESS_ERR_INFO.
+ */
+static void handle_send_egress_err_info(struct hfi2_pportdata *ppd,
+					int vl)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 info = egress_err_info(ppd, false);
+
+	if (dd->is_sriov)
+		info |= egress_err_info(ppd, true);
+
+	/* Eventually add other counters for each bit */
+	if (info & dd->params->port_discard_egress_errs) {
+		int weight, i;
+
+		/*
+		 * Count all applicable bits as individual errors and
+		 * attribute them to the packet that triggered this handler.
+		 * This may not be completely accurate due to limitations
+		 * on the available hardware error information.  There is
+		 * a single information register and any number of error
+		 * packets may have occurred and contributed to it before
+		 * this routine is called.  This means that:
+		 * a) If multiple packets with the same error occur before
+		 *    this routine is called, earlier packets are missed.
+		 *    There is only a single bit for each error type.
+		 * b) Errors may not be attributed to the correct VL.
+		 *    The driver is attributing all bits in the info register
+		 *    to the packet that triggered this call, but bits
+		 *    could be an accumulation of different packets with
+		 *    different VLs.
+		 * c) A single error packet may have multiple counts attached
+		 *    to it.  There is no way for the driver to know if
+		 *    multiple bits set in the info register are due to a
+		 *    single packet or multiple packets.  The driver assumes
+		 *    multiple packets.
+		 */
+		weight = hweight64(info & dd->params->port_discard_egress_errs);
+		for (i = 0; i < weight; i++) {
+			__count_port_discards(ppd);
+			if (vl >= 0 && vl < TXE_NUM_DATA_VL)
+				incr_cntr64(&ppd->port_xmit_discards_vl[vl]);
+			else if (vl == 15)
+				incr_cntr64(&ppd->port_xmit_discards_vl
+					    [C_VL_15]);
+		}
+	}
+}
+
+/*
+ * Input value is a bit position within the SEND_EGRESS_ERR_STATUS
+ * register. Does it represent a 'port inactive' error?
+ */
+static inline int port_inactive_err(int posn)
+{
+	return (posn >= ilog2(SEES(TX_LINKDOWN)) &&
+		posn <= ilog2(SEES(TX_INCORRECT_LINK_STATE)));
+}
+
+/*
+ * Input value is a bit position within the SEND_EGRESS_ERR_STATUS
+ * register. Does it represent a 'disallowed packet' error?
+ */
+static inline int disallowed_pkt_err(int posn)
+{
+	return (posn >= ilog2(SEES(TX_SDMA0_DISALLOWED_PACKET)) &&
+		posn <= ilog2(SEES(TX_SDMA15_DISALLOWED_PACKET)));
+}
+
+/*
+ * Input value is a bit position of one of the SDMA engine disallowed
+ * packet errors.  Return which engine.  Use of this must be guarded by
+ * disallowed_pkt_err().
+ */
+static inline int disallowed_pkt_engine(int posn)
+{
+	return posn - ilog2(SEES(TX_SDMA0_DISALLOWED_PACKET));
+}
+
+/*
+ * Translate an SDMA engine to a VL.  Return -1 if the tranlation cannot
+ * be done.
+ */
+static int engine_to_vl(struct hfi2_pportdata *ppd, int engine)
+{
+	struct sdma_vl_map *m;
+	int vl;
+
+	/* range check */
+	if (engine < 0 || engine >= TXE_NUM_SDMA_ENGINES)
+		return -1;
+
+	rcu_read_lock();
+	m = rcu_dereference(ppd->sdma_map);
+	vl = m->engine_to_vl[engine];
+	rcu_read_unlock();
+
+	return vl;
+}
+
+/*
+ * Translate the send context (sofware index) into a VL.  Return -1 if the
+ * translation cannot be done.
+ */
+static int sc_to_vl(struct hfi2_devdata *dd, int sw_index)
+{
+	struct send_context_info *sci;
+	struct send_context *sc;
+	int i;
+
+	sci = &dd->send_contexts[sw_index];
+
+	/* there is no information for user (PSM) and ack contexts */
+	if ((sci->type != SC_KERNEL) && (sci->type != SC_VL15))
+		return -1;
+
+	sc = sci->sc;
+	if (!sc)
+		return -1;
+	if (sc->ppd->vld[15].sc == sc)
+		return 15;
+	for (i = 0; i < num_vls; i++)
+		if (sc->ppd->vld[i].sc == sc)
+			return i;
+
+	return -1;
+}
+
+void handle_egress_err(struct hfi2_devdata *dd, u32 pidx, u64 reg)
+{
+	struct hfi2_pportdata *ppd = &dd->pport[pidx];
+	u64 reg_copy = reg;
+	char buf[96];
+	bool err_info_avail = true; /* info available on first call only */
+
+	if (reg & ALL_TXE_EGRESS_FREEZE_ERR)
+		start_freeze_handling(dd, 0);
+	else if (is_ax(dd) &&
+		 (reg & SEND_EGRESS_ERR_STATUS_TX_CREDIT_RETURN_VL_ERR_SMASK))
+		start_freeze_handling(dd, 0);
+
+	while (reg_copy) {
+		int posn = fls64(reg_copy);
+		/* fls64() returns a 1-based offset, we want it zero based */
+		int shift = posn - 1;
+		u64 mask = 1ULL << shift;
+
+		if (port_inactive_err(shift)) {
+			count_port_inactive(ppd);
+		} else if (err_info_avail && disallowed_pkt_err(shift)) {
+			int vl = engine_to_vl(ppd, disallowed_pkt_engine(shift));
+
+			handle_send_egress_err_info(ppd, vl);
+			err_info_avail = false;
+		}
+		incr_cntr64(&dd->send_egress_err_status_cnt[shift]);
+		reg_copy &= ~mask;
+	}
+
+	if (reg)
+		ppd_dev_info(ppd, "Egress Error: %s\n",
+			     egress_err_status_string(buf, sizeof(buf), reg));
+}
+
+static void handle_txe_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	char buf[96];
+	int i = 0;
+
+	dd_dev_info(dd, "Send Error: %s\n",
+		    send_err_status_string(buf, sizeof(buf), reg));
+
+	for (i = 0; i < NUM_SEND_ERR_STATUS_COUNTERS; i++) {
+		if (reg & (1ull << i))
+			incr_cntr64(&dd->send_err_status_cnt[i]);
+	}
+}
+
+/*
+ * The maximum number of times the error clear down will loop before
+ * blocking a repeating error.  This value is arbitrary.
+ */
+#define MAX_CLEAR_COUNT 20
+
+/* helper for interrupt_clear_down() register read */
+static u64 read_icd_csr(struct hfi2_devdata *dd, enum icd_type type,
+			u32 idx, u32 reg)
+{
+	switch (type) {
+	case ICD_NORMAL:
+		return read_csr(dd, reg);
+	case ICD_SDMA:
+		return read_sdma_csr(dd, idx, reg);
+	case ICD_INGRESS:
+		return read_iport_csr(dd, idx, reg);
+	case ICD_EGRESS:
+		return read_eport_csr(dd, idx, reg);
+	}
+	return 0;
+}
+
+/* helper for interrupt_clear_down() register write */
+static void write_icd_csr(struct hfi2_devdata *dd, enum icd_type type,
+			  u32 idx, u32 reg, u64 value)
+{
+	switch (type) {
+	case ICD_NORMAL:
+		write_csr(dd, reg, value);
+		return;
+	case ICD_SDMA:
+		write_sdma_csr(dd, idx, reg, value);
+		return;
+	case ICD_INGRESS:
+		write_iport_csr(dd, idx, reg, value);
+		return;
+	case ICD_EGRESS:
+		write_eport_csr(dd, idx, reg, value);
+		return;
+	}
+}
+
+/*
+ * Clear and handle an error register.  All error interrupts are funneled
+ * through here to have a central location to correctly handle single-
+ * or multi-shot errors.
+ *
+ * The error register info indicates the type of access needed for the error
+ * register.  The idx is an indexer for the error register.
+ *
+ * If the handler loops too many times, assume that something is wrong
+ * and can't be fixed, so mask the error bits.
+ */
+void interrupt_clear_down(struct hfi2_devdata *dd, u32 idx,
+			  const struct err_reg_info *eri)
+{
+	u64 reg;
+	u32 count;
+
+	/* read in a loop until no more errors are seen */
+	count = 0;
+	while (1) {
+		reg = read_icd_csr(dd, eri->type, idx, eri->status);
+		if (reg == 0)
+			break;
+		write_icd_csr(dd, eri->type, idx, eri->clear, reg);
+		if (likely(eri->handler))
+			eri->handler(dd, idx, reg);
+		count++;
+		if (count > MAX_CLEAR_COUNT) {
+			u64 mask;
+
+			dd_dev_err(dd, "Repeating %s bits 0x%llx - masking\n",
+				   eri->desc, reg);
+			/*
+			 * Read-modify-write so any other masked bits
+			 * remain masked.
+			 */
+			mask = read_icd_csr(dd, eri->type, idx, eri->mask);
+			mask &= ~reg;
+			write_icd_csr(dd, eri->type, idx, eri->mask, mask);
+			break;
+		}
+	}
+}
+
+/*
+ * CCE block "misc" interrupt.  Source is < 16.
+ */
+static void is_misc_err_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	const struct err_reg_info *eri = &misc_errs[source];
+
+	if (eri->handler) {
+		interrupt_clear_down(dd, 0, eri);
+	} else {
+		dd_dev_err(dd, "Unexpected misc interrupt (%u) - reserved\n",
+			   source);
+	}
+}
+
+static char *send_context_err_status_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags,
+			   sc_err_status_flags,
+			   ARRAY_SIZE(sc_err_status_flags));
+}
+
+/*
+ * Send context error interrupt.
+ *
+ * All send context errors cause the send context to halt.  The normal
+ * clear-down mechanism cannot be used because we cannot clear the
+ * error bits until several other long-running items are done first.
+ * This is OK because with the context halted, nothing else is going
+ * to happen on it anyway.
+ */
+void is_sendctxt_err_int(struct hfi2_devdata *dd, unsigned int hw_context)
+{
+	struct send_context_info *sci;
+	struct send_context *sc;
+	char flags[96];
+	u64 status;
+	u32 sw_index;
+	int i = 0;
+	unsigned long irq_flags;
+
+	sw_index = dd->hw_to_sw[hw_context];
+	if (sw_index >= dd->num_send_contexts) {
+		dd_dev_err(dd,
+			   "out of range sw index %u for send context %u\n",
+			   sw_index, hw_context);
+		return;
+	}
+	sci = &dd->send_contexts[sw_index];
+	spin_lock_irqsave(&dd->sc_lock, irq_flags);
+	sc = sci->sc;
+	if (!sc) {
+		dd_dev_err(dd, "%s: context %u(%u): no sc?\n", __func__,
+			   sw_index, hw_context);
+		spin_unlock_irqrestore(&dd->sc_lock, irq_flags);
+		return;
+	}
+
+	/* tell the software that a halt has begun */
+	sc_stop(sc, SCF_HALTED);
+
+	/*
+	 * All per-send context errors will halt the context and no more
+	 * errors can be generated.  Calling interrupt_clear_down() to handle
+	 * repeating errors is not needed.  The per-context error status
+	 * register is cleared when the context is re-enabled.
+	 */
+	status = read_sctxt_csr(dd, hw_context, dd->params->send_ctxt_err_status_reg);
+
+	dd_dev_info(dd, "Send Context %u(%u) Error: %s\n", sw_index, hw_context,
+		    send_context_err_status_string(flags, sizeof(flags),
+						   status));
+
+	if (status & SEND_CTXT_ERR_STATUS_PIO_DISALLOWED_PACKET_ERR_SMASK)
+		handle_send_egress_err_info(sc->ppd, sc_to_vl(dd, sw_index));
+
+	/*
+	 * Automatically restart halted kernel contexts out of interrupt
+	 * context.  User contexts must ask the driver to restart the context.
+	 */
+	if (sc->type != SC_USER)
+		queue_work(dd->hfi2_wq, &sc->halt_work);
+	spin_unlock_irqrestore(&dd->sc_lock, irq_flags);
+
+	/*
+	 * Update the counters for the corresponding status bits.
+	 * Note that these particular counters are aggregated over all
+	 * contexts.
+	 */
+	for (i = 0; i < NUM_SEND_CTXT_ERR_STATUS_COUNTERS; i++) {
+		if (status & (1ull << i))
+			incr_cntr64(&dd->sw_ctxt_err_status_cnt[i]);
+	}
+}
+
+void handle_sdma_eng_err(struct hfi2_devdata *dd, unsigned int source,
+			 u64 status)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	struct sdma_engine *sde;
+	int i = 0;
+
+	if (source < dr->first_sdma_engine || source >= dr->last_sdma_engine) {
+		dd_dev_err(dd, "%s: engine %u out of range\n", __func__, source);
+		return;
+	}
+	sde = &dd->per_sdma[source];
+#ifdef CONFIG_HFI2_SDMA_VERBOSITY
+	dd_dev_err(sde->dd, "CONFIG SDMA(%u) %s:%d %s()\n", sde->this_idx,
+		   slashstrip(__FILE__), __LINE__, __func__);
+	dd_dev_err(sde->dd, "CONFIG SDMA(%u) source: %u status 0x%llx\n",
+		   sde->this_idx, source, (unsigned long long)status);
+#endif
+	sde->err_cnt++;
+	sdma_engine_error(sde, status);
+
+	/*
+	 * Update the counters for the corresponding status bits.
+	 * Note that these particular counters are aggregated over
+	 * all 16 DMA engines.
+	 */
+	for (i = 0; i < NUM_SEND_DMA_ENG_ERR_STATUS_COUNTERS; i++) {
+		if (status & (1ull << i))
+			incr_cntr64(&dd->sw_send_dma_eng_err_status_cnt[i]);
+	}
+}
+
+/*
+ * CCE block SDMA error interrupt.  Source is < 16.
+ */
+static void is_sdma_eng_err_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+
+	if (source < dr->first_sdma_engine || source >= dr->last_sdma_engine) {
+		dd_dev_err(dd, "%s: engine %u out of range\n", __func__, source);
+		goto clear_down; /* must not access sde, but must clear intr */
+	}
+#ifdef CONFIG_HFI2_SDMA_VERBOSITY
+	struct sdma_engine *sde = &dd->per_sdma[source];
+
+	dd_dev_err(dd, "CONFIG SDMA(%u) %s:%d %s()\n", sde->this_idx,
+		   slashstrip(__FILE__), __LINE__, __func__);
+	dd_dev_err(dd, "CONFIG SDMA(%u) source: %u\n", sde->this_idx,
+		   source);
+	sdma_dumpstate(sde);
+#endif
+clear_down:
+	interrupt_clear_down(dd, source, &sdma_eng_err);
+}
+
+/*
+ * CCE block "various" interrupt.  Source is < 8.
+ */
+static void is_various_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	const struct err_reg_info *eri = &various_err[source];
+
+	/*
+	 * TCritInt cannot go through interrupt_clear_down()
+	 * because it is not a second tier interrupt. The handler
+	 * should be called directly.
+	 */
+	if (source == TCRIT_INT_SOURCE)
+		handle_temp_err(dd);
+	else if (eri->handler)
+		interrupt_clear_down(dd, 0, eri);
+	else
+		dd_dev_info(dd,
+			    "%s: Unimplemented/reserved interrupt %d\n",
+			    __func__, source);
+}
+
+static void handle_qsfp_int(struct hfi2_devdata *dd, u32 src_ctx, u64 reg)
+{
+	/* src_ctx is always zero */
+	struct hfi2_pportdata *ppd = dd->pport;
+	unsigned long flags;
+	u64 qsfp_int_mgmt = (u64)(QSFP_HFI0_INT_N | QSFP_HFI0_MODPRST_N);
+
+	if (reg & QSFP_HFI0_MODPRST_N) {
+		if (!qsfp_mod_present(ppd)) {
+			ppd_dev_info(ppd, "%s: QSFP module removed\n",
+				     __func__);
+
+			ppd->driver_link_ready = 0;
+			/*
+			 * Cable removed, reset all our information about the
+			 * cache and cable capabilities
+			 */
+
+			spin_lock_irqsave(&ppd->qsfp_info.qsfp_lock, flags);
+			/*
+			 * We don't set cache_refresh_required here as we expect
+			 * an interrupt when a cable is inserted
+			 */
+			ppd->qsfp_info.cache_valid = 0;
+			ppd->qsfp_info.reset_needed = 0;
+			ppd->qsfp_info.limiting_active = 0;
+			spin_unlock_irqrestore(&ppd->qsfp_info.qsfp_lock,
+					       flags);
+			/* Invert the ModPresent pin now to detect plug-in */
+			write_csr(dd, dd->hfi2_id ? ASIC_QSFP2_INVERT :
+				  ASIC_QSFP1_INVERT, qsfp_int_mgmt);
+
+			if ((ppd->offline_disabled_reason >
+			  HFI2_ODR_MASK(
+			  OPA_LINKDOWN_REASON_LOCAL_MEDIA_NOT_INSTALLED)) ||
+			  (ppd->offline_disabled_reason ==
+			  HFI2_ODR_MASK(OPA_LINKDOWN_REASON_NONE)))
+				ppd->offline_disabled_reason =
+				HFI2_ODR_MASK(
+				OPA_LINKDOWN_REASON_LOCAL_MEDIA_NOT_INSTALLED);
+
+			if (ppd->host_link_state == HLS_DN_POLL) {
+				/*
+				 * The link is still in POLL. This means
+				 * that the normal link down processing
+				 * will not happen. We have to do it here
+				 * before turning the DC off.
+				 */
+				queue_work(ppd->link_wq, &ppd->link_down_work);
+			}
+		} else {
+			ppd_dev_info(ppd, "%s: QSFP module inserted\n",
+				     __func__);
+
+			spin_lock_irqsave(&ppd->qsfp_info.qsfp_lock, flags);
+			ppd->qsfp_info.cache_valid = 0;
+			ppd->qsfp_info.cache_refresh_required = 1;
+			spin_unlock_irqrestore(&ppd->qsfp_info.qsfp_lock,
+					       flags);
+
+			/*
+			 * Stop inversion of ModPresent pin to detect
+			 * removal of the cable
+			 */
+			qsfp_int_mgmt &= ~(u64)QSFP_HFI0_MODPRST_N;
+			write_csr(dd, dd->hfi2_id ? ASIC_QSFP2_INVERT :
+				  ASIC_QSFP1_INVERT, qsfp_int_mgmt);
+
+			ppd->offline_disabled_reason =
+				HFI2_ODR_MASK(OPA_LINKDOWN_REASON_TRANSIENT);
+		}
+	}
+
+	if (reg & QSFP_HFI0_INT_N) {
+		ppd_dev_info(ppd, "%s: Interrupt received from QSFP module\n",
+			     __func__);
+		spin_lock_irqsave(&ppd->qsfp_info.qsfp_lock, flags);
+		ppd->qsfp_info.check_interrupt_flags = 1;
+		spin_unlock_irqrestore(&ppd->qsfp_info.qsfp_lock, flags);
+	}
+
+	/* Schedule the QSFP work only if there is a cable attached. */
+	if (qsfp_mod_present(ppd))
+		queue_work(ppd->link_wq, &ppd->qsfp_info.qsfp_work);
+}
+
+static int request_host_lcb_access(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	ret = do_8051_command(dd, HCMD_MISC,
+			      (u64)HCMD_MISC_REQUEST_LCB_ACCESS <<
+			      LOAD_DATA_FIELD_ID_SHIFT, NULL);
+	if (ret != HCMD_SUCCESS && !(dd->flags & HFI2_SHUTDOWN)) {
+		dd_dev_err(dd, "%s: command failed with error %d\n",
+			   __func__, ret);
+	}
+	return ret == HCMD_SUCCESS ? 0 : -EBUSY;
+}
+
+static int request_8051_lcb_access(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	ret = do_8051_command(dd, HCMD_MISC,
+			      (u64)HCMD_MISC_GRANT_LCB_ACCESS <<
+			      LOAD_DATA_FIELD_ID_SHIFT, NULL);
+	if (ret != HCMD_SUCCESS) {
+		dd_dev_err(dd, "%s: command failed with error %d\n",
+			   __func__, ret);
+	}
+	return ret == HCMD_SUCCESS ? 0 : -EBUSY;
+}
+
+/*
+ * Set the LCB selector - allow host access.  The DCC selector always
+ * points to the host.
+ */
+static inline void set_host_lcb_access(struct hfi2_devdata *dd)
+{
+	write_csr(dd, DC_DC8051_CFG_CSR_ACCESS_SEL,
+		  DC_DC8051_CFG_CSR_ACCESS_SEL_DCC_SMASK |
+		  DC_DC8051_CFG_CSR_ACCESS_SEL_LCB_SMASK);
+}
+
+/*
+ * Clear the LCB selector - allow 8051 access.  The DCC selector always
+ * points to the host.
+ */
+static inline void set_8051_lcb_access(struct hfi2_devdata *dd)
+{
+	write_csr(dd, DC_DC8051_CFG_CSR_ACCESS_SEL,
+		  DC_DC8051_CFG_CSR_ACCESS_SEL_DCC_SMASK);
+}
+
+/*
+ * Acquire LCB access from the 8051.  If the host already has access,
+ * just increment a counter.  Otherwise, inform the 8051 that the
+ * host is taking access.
+ *
+ * Returns:
+ *	0 on success
+ *	-EBUSY if the 8051 has control and cannot be disturbed
+ *	-errno if unable to acquire access from the 8051
+ */
+int acquire_lcb_access(struct hfi2_devdata *dd, int sleep_ok)
+{
+	struct hfi2_pportdata *ppd = dd->pport;
+	int ret = 0;
+
+	/*
+	 * Use the host link state lock so the operation of this routine
+	 * { link state check, selector change, count increment } can occur
+	 * as a unit against a link state change.  Otherwise there is a
+	 * race between the state change and the count increment.
+	 */
+	if (sleep_ok) {
+		mutex_lock(&ppd->hls_lock);
+	} else {
+		while (!mutex_trylock(&ppd->hls_lock))
+			udelay(1);
+	}
+
+	/* this access is valid only when the link is up */
+	if (ppd->host_link_state & HLS_DOWN) {
+		ppd_dev_info(ppd, "%s: link state %s not up\n",
+			     __func__, link_state_name(ppd->host_link_state));
+		ret = -EBUSY;
+		goto done;
+	}
+
+	if (dd->lcb_access_count == 0) {
+		ret = request_host_lcb_access(dd);
+		if (ret) {
+			if (!(dd->flags & HFI2_SHUTDOWN))
+				ppd_dev_err(ppd,
+					    "%s: unable to acquire LCB access, err %d\n",
+					    __func__, ret);
+			goto done;
+		}
+		set_host_lcb_access(dd);
+	}
+	dd->lcb_access_count++;
+done:
+	mutex_unlock(&ppd->hls_lock);
+	return ret;
+}
+
+/*
+ * Release LCB access by decrementing the use count.  If the count is moving
+ * from 1 to 0, inform 8051 that it has control back.
+ *
+ * Returns:
+ *	0 on success
+ *	-errno if unable to release access to the 8051
+ */
+int release_lcb_access(struct hfi2_devdata *dd, int sleep_ok)
+{
+	int ret = 0;
+
+	/*
+	 * Use the host link state lock because the acquire needed it.
+	 * Here, we only need to keep { selector change, count decrement }
+	 * as a unit.
+	 */
+	if (sleep_ok) {
+		mutex_lock(&dd->pport->hls_lock);
+	} else {
+		while (!mutex_trylock(&dd->pport->hls_lock))
+			udelay(1);
+	}
+
+	if (dd->lcb_access_count == 0) {
+		dd_dev_err(dd, "%s: LCB access count is zero.  Skipping.\n",
+			   __func__);
+		goto done;
+	}
+
+	if (dd->lcb_access_count == 1) {
+		set_8051_lcb_access(dd);
+		ret = request_8051_lcb_access(dd);
+		if (ret) {
+			dd_dev_err(dd,
+				   "%s: unable to release LCB access, err %d\n",
+				   __func__, ret);
+			/* restore host access if the grant didn't work */
+			set_host_lcb_access(dd);
+			goto done;
+		}
+	}
+	dd->lcb_access_count--;
+done:
+	mutex_unlock(&dd->pport->hls_lock);
+	return ret;
+}
+
+/*
+ * Initialize LCB access variables and state.  Called during driver load,
+ * after most of the initialization is finished.
+ *
+ * The DC default is LCB access on for the host.  The driver defaults to
+ * leaving access to the 8051.  Assign access now - this constrains the call
+ * to this routine to be after all LCB set-up is done.  In particular, after
+ * hf1_init_dd() -> set_up_interrupts() -> clear_all_interrupts()
+ */
+static void init_lcb_access(struct hfi2_devdata *dd)
+{
+	dd->lcb_access_count = 0;
+}
+
+/*
+ * Write a response back to a 8051 request.
+ */
+static void hreq_response(struct hfi2_devdata *dd, u8 return_code, u16 rsp_data)
+{
+	write_csr(dd, DC_DC8051_CFG_EXT_DEV_0,
+		  DC_DC8051_CFG_EXT_DEV_0_COMPLETED_SMASK |
+		  (u64)return_code <<
+		  DC_DC8051_CFG_EXT_DEV_0_RETURN_CODE_SHIFT |
+		  (u64)rsp_data << DC_DC8051_CFG_EXT_DEV_0_RSP_DATA_SHIFT);
+}
+
+/*
+ * Handle host requests from the 8051.
+ */
+static void handle_8051_request(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+	u16 data = 0;
+	u8 type;
+
+	reg = read_csr(dd, DC_DC8051_CFG_EXT_DEV_1);
+	if ((reg & DC_DC8051_CFG_EXT_DEV_1_REQ_NEW_SMASK) == 0)
+		return;	/* no request */
+
+	/* zero out COMPLETED so the response is seen */
+	write_csr(dd, DC_DC8051_CFG_EXT_DEV_0, 0);
+
+	/* extract request details */
+	type = (reg >> DC_DC8051_CFG_EXT_DEV_1_REQ_TYPE_SHIFT)
+			& DC_DC8051_CFG_EXT_DEV_1_REQ_TYPE_MASK;
+	data = (reg >> DC_DC8051_CFG_EXT_DEV_1_REQ_DATA_SHIFT)
+			& DC_DC8051_CFG_EXT_DEV_1_REQ_DATA_MASK;
+
+	switch (type) {
+	case HREQ_LOAD_CONFIG:
+	case HREQ_SAVE_CONFIG:
+	case HREQ_READ_CONFIG:
+	case HREQ_SET_TX_EQ_ABS:
+	case HREQ_SET_TX_EQ_REL:
+	case HREQ_ENABLE:
+		ppd_dev_info(ppd, "8051 request: request 0x%x not supported\n",
+			     type);
+		hreq_response(dd, HREQ_NOT_SUPPORTED, 0);
+		break;
+	case HREQ_LCB_RESET:
+		/* Put the LCB, RX FPE and TX FPE into reset */
+		write_csr(dd, DCC_CFG_RESET, LCB_RX_FPE_TX_FPE_INTO_RESET);
+		/* Make sure the write completed */
+		(void)read_csr(dd, DCC_CFG_RESET);
+		/* Hold the reset long enough to take effect */
+		udelay(1);
+		/* Take the LCB, RX FPE and TX FPE out of reset */
+		write_csr(dd, DCC_CFG_RESET, LCB_RX_FPE_TX_FPE_OUT_OF_RESET);
+		hreq_response(dd, HREQ_SUCCESS, 0);
+
+		break;
+	case HREQ_CONFIG_DONE:
+		hreq_response(dd, HREQ_SUCCESS, 0);
+		break;
+
+	case HREQ_INTERFACE_TEST:
+		hreq_response(dd, HREQ_SUCCESS, data);
+		break;
+	default:
+		ppd_dev_err(ppd, "8051 request: unknown request 0x%x\n", type);
+		hreq_response(dd, HREQ_NOT_SUPPORTED, 0);
+		break;
+	}
+}
+
+/*
+ * Set up allocation unit vaulue.
+ */
+void set_up_vau(struct hfi2_pportdata *ppd, u8 vau)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg = read_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg);
+
+	/* do not modify other values in the register */
+	reg &= ~SEND_CM_GLOBAL_CREDIT_AU_SMASK;
+	reg |= (u64)vau << SEND_CM_GLOBAL_CREDIT_AU_SHIFT;
+	write_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg, reg);
+}
+
+/*
+ * Set up initial VL15 credits of the remote.  Assumes the rest of
+ * the CM credit registers are zero from a previous global or credit reset.
+ * Shared limit for VL15 will always be 0.
+ */
+void set_up_vl15(struct hfi2_pportdata *ppd, u16 vl15buf)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg = read_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg);
+
+	/* set initial values for total and shared credit limit */
+	reg &= ~(SEND_CM_GLOBAL_CREDIT_TOTAL_CREDIT_LIMIT_SMASK |
+		 SEND_CM_GLOBAL_CREDIT_SHARED_LIMIT_SMASK);
+
+	/*
+	 * Set total limit to be equal to VL15 credits.
+	 * Leave shared limit at 0.
+	 */
+	reg |= (u64)vl15buf << SEND_CM_GLOBAL_CREDIT_TOTAL_CREDIT_LIMIT_SHIFT;
+	write_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg, reg);
+
+	write_eport_csr(dd, ppd->hw_pidx,
+		dd->params->send_cm_credit_vl15_reg,
+		(u64)vl15buf << SEND_CM_CREDIT_VL15_DEDICATED_LIMIT_VL_SHIFT);
+}
+
+/*
+ * Zero all credit details from the previous connection and
+ * reset the CM manager's internal counters.
+ */
+void reset_link_credits(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int i;
+
+	/* remove all previous VL credit limits */
+	for (i = 0; i < TXE_NUM_DATA_VL; i++)
+		write_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_credit_vl_reg + (8 * i), 0);
+	write_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_credit_vl15_reg, 0);
+	write_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg, 0);
+	/* reset the CM block */
+	pio_send_control(ppd, PSC_CM_RESET);
+	/* reset cached value */
+	dd->vl15buf_cached = 0;
+}
+
+/* convert a vCU to a CU */
+static u32 vcu_to_cu(u8 vcu)
+{
+	return 1 << vcu;
+}
+
+/* convert a CU to a vCU */
+static u8 cu_to_vcu(u32 cu)
+{
+	return ilog2(cu);
+}
+
+/* convert a vAU to an AU */
+static u32 vau_to_au(u8 vau)
+{
+	return 8 * (1 << vau);
+}
+
+static void set_linkup_defaults(struct hfi2_pportdata *ppd)
+{
+	ppd->sm_trap_qp = 0x0;
+	ppd->sa_qp = 0x1;
+}
+
+/*
+ * Graceful LCB shutdown.  This leaves the LCB FIFOs in reset.
+ */
+static void lcb_shutdown(struct hfi2_devdata *dd, int abort)
+{
+	u64 reg;
+
+	/* clear lcb run: LCB_CFG_RUN.EN = 0 */
+	write_csr(dd, DC_LCB_CFG_RUN, 0);
+	/* set tx fifo reset: LCB_CFG_TX_FIFOS_RESET.VAL = 1 */
+	write_csr(dd, DC_LCB_CFG_TX_FIFOS_RESET,
+		  1ull << DC_LCB_CFG_TX_FIFOS_RESET_VAL_SHIFT);
+	/* set dcc reset csr: DCC_CFG_RESET.{reset_lcb,reset_rx_fpe} = 1 */
+	dd->lcb_err_en = read_csr(dd, DC_LCB_ERR_EN);
+	reg = read_csr(dd, DCC_CFG_RESET);
+	write_csr(dd, DCC_CFG_RESET, reg |
+		  DCC_CFG_RESET_RESET_LCB | DCC_CFG_RESET_RESET_RX_FPE);
+	(void)read_csr(dd, DCC_CFG_RESET); /* make sure the write completed */
+	if (!abort) {
+		udelay(1);    /* must hold for the longer of 16cclks or 20ns */
+		write_csr(dd, DCC_CFG_RESET, reg);
+		write_csr(dd, DC_LCB_ERR_EN, dd->lcb_err_en);
+	}
+}
+
+/*
+ * This routine should be called after the link has been transitioned to
+ * OFFLINE (OFFLINE state has the side effect of putting the SerDes into
+ * reset).
+ *
+ * The expectation is that the caller of this routine would have taken
+ * care of properly transitioning the link into the correct state.
+ * NOTE: the caller needs to acquire the dd->dc8051_lock lock
+ *       before calling this function.
+ */
+static void _dc_shutdown(struct hfi2_devdata *dd)
+{
+	lockdep_assert_held(&dd->dc8051_lock);
+
+	if (dd->dc_shutdown)
+		return;
+
+	dd->dc_shutdown = 1;
+	/* Shutdown the LCB */
+	lcb_shutdown(dd, 1);
+	/*
+	 * Going to OFFLINE would have causes the 8051 to put the
+	 * SerDes into reset already. Just need to shut down the 8051,
+	 * itself.
+	 */
+	write_csr(dd, DC_DC8051_CFG_RST, 0x1);
+}
+
+static void dc_shutdown(struct hfi2_devdata *dd)
+{
+	mutex_lock(&dd->dc8051_lock);
+	_dc_shutdown(dd);
+	mutex_unlock(&dd->dc8051_lock);
+}
+
+/*
+ * Calling this after the DC has been brought out of reset should not
+ * do any damage.
+ * NOTE: the caller needs to acquire the dd->dc8051_lock lock
+ *       before calling this function.
+ */
+static void _dc_start(struct hfi2_devdata *dd)
+{
+	lockdep_assert_held(&dd->dc8051_lock);
+
+	if (!dd->dc_shutdown)
+		return;
+
+	/* Take the 8051 out of reset */
+	write_csr(dd, DC_DC8051_CFG_RST, 0ull);
+	/* Wait until 8051 is ready */
+	if (wait_fm_ready(dd, TIMEOUT_8051_START))
+		dd_dev_err(dd, "%s: timeout starting 8051 firmware\n",
+			   __func__);
+
+	/* Take away reset for LCB and RX FPE (set in lcb_shutdown). */
+	write_csr(dd, DCC_CFG_RESET, LCB_RX_FPE_TX_FPE_OUT_OF_RESET);
+	/* lcb_shutdown() with abort=1 does not restore these */
+	write_csr(dd, DC_LCB_ERR_EN, dd->lcb_err_en);
+	dd->dc_shutdown = 0;
+}
+
+static void dc_start(struct hfi2_devdata *dd)
+{
+	mutex_lock(&dd->dc8051_lock);
+	_dc_start(dd);
+	mutex_unlock(&dd->dc8051_lock);
+}
+
+/*
+ * Handle a SMA idle message
+ *
+ * This is a work-queue function outside of the interrupt.
+ */
+void handle_sma_message(struct work_struct *work)
+{
+	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
+							sma_message_work);
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 msg;
+	int ret;
+
+	/*
+	 * msg is bytes 1-4 of the 40-bit idle message - the command code
+	 * is stripped off
+	 */
+	ret = read_idle_sma(dd, &msg);
+	if (ret)
+		return;
+	ppd_dev_info(ppd, "%s: SMA message 0x%llx\n", __func__, msg);
+	/*
+	 * React to the SMA message.  Byte[1] (0 for us) is the command.
+	 */
+	switch (msg & 0xff) {
+	case SMA_IDLE_ARM:
+		/*
+		 * See OPAv1 table 9-14 - HFI and External Switch Ports Key
+		 * State Transitions
+		 *
+		 * Only expected in INIT or ARMED, discard otherwise.
+		 */
+		if (ppd->host_link_state & (HLS_UP_INIT | HLS_UP_ARMED))
+			ppd->neighbor_normal = 1;
+		break;
+	case SMA_IDLE_ACTIVE:
+		/*
+		 * See OPAv1 table 9-14 - HFI and External Switch Ports Key
+		 * State Transitions
+		 *
+		 * Can activate the node.  Discard otherwise.
+		 */
+		if (ppd->host_link_state == HLS_UP_ARMED &&
+		    ppd->is_active_optimize_enabled) {
+			ppd->neighbor_normal = 1;
+			ret = set_link_state(ppd, HLS_UP_ACTIVE);
+			if (ret)
+				ppd_dev_err(ppd,
+					    "%s: received Active SMA idle message, couldn't set link to Active\n",
+					    __func__);
+		}
+		break;
+	default:
+		ppd_dev_err(ppd,
+			    "%s: received unexpected SMA idle message 0x%llx\n",
+			    __func__, msg);
+		break;
+	}
+}
+
+/*
+ * Clear first, then set.  This allows for multi-bit fields to be set.
+ *
+ * Performs same action on loopback RcvIportCtrl register if SRIOV.
+ */
+static void adjust_rcvctrl(struct hfi2_pportdata *ppd, u64 add, u64 clear)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 rcvctrl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dd->rcvctrl_lock, flags);
+	rcvctrl = read_iport_csr(dd, ppd->hw_pidx, dd->params->rcv_iport_ctrl_reg);
+	rcvctrl &= ~clear;
+	rcvctrl |= add;
+	write_iport_csr(dd, ppd->hw_pidx, dd->params->rcv_iport_ctrl_reg, rcvctrl);
+	if (dd->is_sriov) {
+		rcvctrl = read_iport_csr(dd, loopback_pidx(ppd),
+					 dd->params->rcv_iport_ctrl_reg);
+		rcvctrl &= ~clear;
+		rcvctrl |= add;
+		write_iport_csr(dd, loopback_pidx(ppd),
+				dd->params->rcv_iport_ctrl_reg, rcvctrl);
+	}
+	spin_unlock_irqrestore(&dd->rcvctrl_lock, flags);
+}
+
+static inline void add_rcvctrl(struct hfi2_pportdata *ppd, u64 add)
+{
+	adjust_rcvctrl(ppd, add, 0);
+}
+
+static inline void clear_rcvctrl(struct hfi2_pportdata *ppd, u64 clear)
+{
+	adjust_rcvctrl(ppd, 0, clear);
+}
+
+static void set_wcb(struct hfi2_pportdata *ppd, int wcb)
+{
+	u64 set;
+
+	/* reject anything out of range, fields are the same for all chips */
+	if ((wcb & JKR_RCV_IPORT_CTRL_RCV_WCB_MASK) != wcb)
+		return;
+	set = (u64)wcb << JKR_RCV_IPORT_CTRL_RCV_WCB_SHIFT;
+	adjust_rcvctrl(ppd, set, JKR_RCV_IPORT_CTRL_RCV_WCB_SMASK);
+}
+
+/*
+ * Steps needed to handle active PIO and SDMA when a link goes down.  Not
+ * called at interrupt time.
+ *
+ * This is an alternative to an SPC freeze for link down.  It depends on the
+ * hardware ability to flush packets when in the wrong link state.  WFR does
+ * not have this feature and should continue to perform an SPC freeze on link
+ * down.
+ */
+void start_linkdown_handling(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct send_context *sc;
+	int sc_flags;
+	int i;
+
+	/*
+	 * Stop step
+	 *
+	 * SDMA: Keep the engines running - other ports may be using them.
+	 * Expect all descriptors bound for the down port to be processed,
+	 * but the contents dropped.  This ability is only available on
+	 * hardware after WFR.  Pre-WFR, the descriptor would stall.
+	 *
+	 * PIO: Halt, with linkdown flag, all of the enabled send contexts for
+	 * this port.
+	 */
+	sc_flags = SCF_LINK_DOWN;
+	for (i = 0; i < dd->num_send_contexts; i++) {
+		sc = dd->send_contexts[i].sc;
+		if (!sc || sc->ppd != ppd || !(sc->flags & SCF_ENABLED))
+			continue;
+
+		sc_stop(sc, sc_flags);
+	}
+
+	/*
+	 * Disable step
+	 *
+	 * SDMA: The engines are left running.  Nothing to do.
+	 *
+	 * PIO: Disable all contexts for this port.  Non-user contexts will be
+	 * re-enabled at linkup time.  User contexts will be re-enabled when
+	 * the user requests a context reset.
+	 */
+	for (i = 0; i < dd->num_send_contexts; i++) {
+		sc = dd->send_contexts[i].sc;
+		if (!sc || sc->ppd != ppd)
+			continue;
+
+		sc_disable(sc);
+	}
+}
+
+/*
+ * Called from all interrupt handlers to start handling an SPC freeze.
+ */
+void start_freeze_handling(struct hfi2_devdata *dd, int flags)
+{
+	struct send_context *sc;
+	int i;
+	int sc_flags;
+
+	if (flags & FREEZE_SELF)
+		write_csr(dd, CCE_CTRL, CCE_CTRL_SPC_FREEZE_SMASK);
+
+	/* enter frozen mode */
+	dd->flags |= HFI2_FROZEN;
+
+	/* notify all SDMA engines that they are going into a freeze */
+	sdma_freeze_notify(dd, !!(flags & FREEZE_LINK_DOWN));
+
+	sc_flags = SCF_FROZEN | SCF_HALTED | (flags & FREEZE_LINK_DOWN ?
+					      SCF_LINK_DOWN : 0);
+	/* do halt pre-handling on all enabled send contexts */
+	for (i = 0; i < dd->num_send_contexts; i++) {
+		sc = dd->send_contexts[i].sc;
+		if (sc && (sc->flags & SCF_ENABLED))
+			sc_stop(sc, sc_flags);
+	}
+
+	/* Send context are frozen. Notify user space */
+	for (i = 0; i < dd->num_pports; i++)
+		hfi2_set_uevent_bits(&dd->pport[i], _HFI2_EVENT_FROZEN_BIT);
+
+	if (flags & FREEZE_ABORT) {
+		dd_dev_err(dd, "Aborted freeze recovery. Please REBOOT system\n");
+		return;
+	}
+	/* queue non-interrupt handler */
+	queue_work(dd->hfi2_wq, &dd->freeze_work);
+}
+
+/*
+ * Wait until all 4 sub-blocks indicate that they have frozen or unfrozen,
+ * depending on the "freeze" parameter.
+ *
+ * No need to return an error if it times out, our only option
+ * is to proceed anyway.
+ */
+static void wait_for_freeze_status(struct hfi2_devdata *dd, int freeze)
+{
+	unsigned long timeout;
+	u64 reg;
+
+	timeout = jiffies + msecs_to_jiffies(FREEZE_STATUS_TIMEOUT);
+	while (1) {
+		reg = read_csr(dd, CCE_STATUS);
+		if (freeze) {
+			/* waiting until all indicators are set */
+			if ((reg & ALL_FROZE) == ALL_FROZE)
+				return;	/* all done */
+		} else {
+			/* waiting until all indicators are clear */
+			if ((reg & ALL_FROZE) == 0)
+				return; /* all done */
+		}
+
+		if (time_after(jiffies, timeout)) {
+			dd_dev_err(dd,
+				   "Time out waiting for SPC %sfreeze, bits 0x%llx, expecting 0x%llx, continuing",
+				   freeze ? "" : "un", reg & ALL_FROZE,
+				   freeze ? ALL_FROZE : 0ull);
+			return;
+		}
+		usleep_range(80, 120);
+	}
+}
+
+/*
+ * Do all freeze handling for the RXE block.
+ */
+static void rxe_freeze(struct hfi2_devdata *dd)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	int i, j;
+	struct hfi2_ctxtdata *rcd;
+
+	/* disable all receive contexts */
+	for (i = 0; i < dd->num_pports; i++) {
+		struct hfi2_portrsrcs *pr = &dr->ppr[i];
+
+		/* disable port */
+		clear_rcvctrl(&dd->pport[i], RCV_CTRL_RCV_PORT_ENABLE_SMASK);
+
+		for (j = 0; j < pr->num_rcv_contexts; j++) {
+			u16 ctxt = pr->rcv_context_base + j;
+
+			rcd = hfi2_rcd_get_by_index(dd, ctxt);
+			hfi2_rcvctrl(dd, HFI2_RCVCTRL_CTXT_DIS, rcd);
+			hfi2_rcd_put(rcd);
+		}
+	}
+}
+
+/*
+ * Unfreeze handling for the RXE block - kernel contexts only.
+ * This will also enable the port.  User contexts will do unfreeze
+ * handling on a per-context basis as they call into the driver.
+ */
+static void rxe_kernel_unfreeze(struct hfi2_devdata *dd)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	struct hfi2_ctxtdata *rcd;
+	u32 rcvmask;
+	u16 i;
+	u16 j;
+
+	/* enable all kernel contexts */
+	for (i = 0; i < dd->num_pports; i++) {
+		struct hfi2_pportdata *ppd = dd->pport + i;
+		struct hfi2_portrsrcs *pr = &dr->ppr[i];
+
+		for (j = 0; j < pr->num_rcv_contexts; j++) {
+			u16 ctxt = pr->rcv_context_base + j;
+
+			rcd = hfi2_rcd_get_by_index(dd, ctxt);
+			/*
+			 * Ensure all non-user contexts are enabled.
+			 */
+			if (!rcd || is_user_context(rcd)) {
+				hfi2_rcd_put(rcd);
+				continue;
+			}
+			rcvmask = HFI2_RCVCTRL_CTXT_ENB;
+			/* HFI2_RCVCTRL_TAILUPD_* needs to be set explicitly */
+			rcvmask |= hfi2_rcvhdrtail_kvaddr(rcd)
+					? HFI2_RCVCTRL_TAILUPD_ENB
+					: HFI2_RCVCTRL_TAILUPD_DIS;
+			hfi2_rcvctrl(dd, rcvmask, rcd);
+			hfi2_rcd_put(rcd);
+		}
+
+		/* enable port */
+		add_rcvctrl(ppd, RCV_CTRL_RCV_PORT_ENABLE_SMASK);
+	}
+}
+
+/*
+ * Non-interrupt SPC freeze handling.
+ *
+ * This is a work-queue function outside of the triggering interrupt.
+ */
+void handle_freeze(struct work_struct *work)
+{
+	struct hfi2_devdata *dd = container_of(work, struct hfi2_devdata,
+								freeze_work);
+
+	/* wait for freeze indicators on all affected blocks */
+	wait_for_freeze_status(dd, 1);
+
+	/* SPC is now frozen */
+
+	/* do send PIO freeze steps */
+	pio_freeze(dd);
+
+	/* do send DMA freeze steps */
+	sdma_freeze(dd);
+
+	/* do send egress freeze steps - nothing to do */
+
+	/* do receive freeze steps */
+	rxe_freeze(dd);
+
+	/*
+	 * Unfreeze the hardware - clear the freeze, wait for each
+	 * block's frozen bit to clear, then clear the frozen flag.
+	 */
+	write_csr(dd, CCE_CTRL, CCE_CTRL_SPC_UNFREEZE_SMASK);
+	wait_for_freeze_status(dd, 0);
+
+	if (is_ax(dd)) {
+		write_csr(dd, CCE_CTRL, CCE_CTRL_SPC_FREEZE_SMASK);
+		wait_for_freeze_status(dd, 1);
+		write_csr(dd, CCE_CTRL, CCE_CTRL_SPC_UNFREEZE_SMASK);
+		wait_for_freeze_status(dd, 0);
+	}
+
+	/* do send PIO unfreeze steps for kernel contexts */
+	pio_kernel_unfreeze(dd);
+
+	/* do send DMA unfreeze steps */
+	sdma_unfreeze(dd);
+
+	/* do send egress unfreeze steps - nothing to do */
+
+	/* do receive unfreeze steps for kernel contexts */
+	rxe_kernel_unfreeze(dd);
+
+	/*
+	 * The unfreeze procedure touches global device registers when
+	 * it disables and re-enables RXE. Mark the device unfrozen
+	 * after all that is done so other parts of the driver waiting
+	 * for the device to unfreeze don't do things out of order.
+	 *
+	 * The above implies that the meaning of HFI2_FROZEN flag is
+	 * "Device has gone into freeze mode and freeze mode handling
+	 * is still in progress."
+	 *
+	 * The flag will be removed when freeze mode processing has
+	 * completed.
+	 */
+	dd->flags &= ~HFI2_FROZEN;
+	wake_up(&dd->event_queue);
+
+	/* no longer frozen */
+}
+
+/**
+ * update_xmit_counters - update PortXmitWait/PortVlXmitWait
+ * counters.
+ * @ppd: info of physical Hfi port
+ * @link_width: new link width after link up or downgrade
+ *
+ * Update the PortXmitWait and PortVlXmitWait counters after
+ * a link up or downgrade event to reflect a link width change.
+ */
+void update_xmit_counters(struct hfi2_pportdata *ppd, u16 link_width)
+{
+	int i;
+	u16 tx_width;
+	u16 link_speed;
+
+	tx_width = tx_link_width(link_width);
+	link_speed = get_link_speed(ppd->link_speed_active);
+
+	/*
+	 * There are C_VL_COUNT number of PortVLXmitWait counters.
+	 * Adding 1 to C_VL_COUNT to include the PortXmitWait counter.
+	 */
+	for (i = 0; i < C_VL_COUNT + 1; i++)
+		get_xmit_wait_counters(ppd, tx_width, link_speed, i);
+}
+
+static void read_ltp_rtt(struct hfi2_pportdata *ppd)
+{
+	u64 reg;
+
+	if (read_lcb_csr(ppd, DC_LCB_STS_ROUND_TRIP_LTP_CNT, &reg)) {
+		ppd_dev_err(ppd, "%s: unable to read LTP RTT\n", __func__);
+		ppd->link_ltp_rtt = 0;
+	} else {
+		ppd->link_ltp_rtt = reg;
+	}
+}
+
+/*
+ * Handle a link up interrupt from the 8051.
+ *
+ * This is a work-queue function outside of the interrupt.
+ */
+void handle_link_up(struct work_struct *work)
+{
+	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
+						  link_up_work);
+	struct hfi2_devdata *dd = ppd->dd;
+
+	set_link_state(ppd, HLS_UP_INIT);
+
+	/* cache the read of DC_LCB_STS_ROUND_TRIP_LTP_CNT */
+	read_ltp_rtt(ppd);
+	/*
+	 * OPA specifies that certain counters are cleared on a transition
+	 * to link up, so do that.
+	 */
+	clear_linkup_counters(ppd);
+	/*
+	 * And (re)set link up default values.
+	 */
+	set_linkup_defaults(ppd);
+
+	/*
+	 * Set VL15 credits. Use cached value from verify cap interrupt.
+	 * In case of quick linkup, vl15 value will be set by
+	 * handle_linkup_change. VerifyCap interrupt handler will not be
+	 * called in those scenarios.
+	 */
+	if (!quick_linkup)
+		set_up_vl15(ppd, dd->vl15buf_cached);
+
+	/* enforce link speed enabled */
+	if ((ppd->link_speed_active & ppd->link_speed_enabled) == 0) {
+		/* oops - current speed is not enabled, bounce */
+		ppd_dev_err(ppd,
+			    "Link speed active 0x%x is outside enabled 0x%x, downing link\n",
+			    ppd->link_speed_active, ppd->link_speed_enabled);
+		set_link_down_reason(ppd, OPA_LINKDOWN_REASON_SPEED_POLICY, 0,
+				     OPA_LINKDOWN_REASON_SPEED_POLICY);
+		set_link_state(ppd, HLS_DN_OFFLINE);
+		start_link(ppd);
+	}
+}
+
+/*
+ * Several pieces of LNI information were cached for SMA in ppd.
+ * Reset these on link down
+ */
+static void reset_neighbor_info(struct hfi2_pportdata *ppd)
+{
+	ppd->neighbor_guid = 0;
+	ppd->neighbor_port_number = 0;
+	ppd->neighbor_type = 0;
+	ppd->neighbor_fm_security = 0;
+}
+
+static const char * const link_down_reason_strs[] = {
+	[OPA_LINKDOWN_REASON_NONE] = "None",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_0] = "Receive error 0",
+	[OPA_LINKDOWN_REASON_BAD_PKT_LEN] = "Bad packet length",
+	[OPA_LINKDOWN_REASON_PKT_TOO_LONG] = "Packet too long",
+	[OPA_LINKDOWN_REASON_PKT_TOO_SHORT] = "Packet too short",
+	[OPA_LINKDOWN_REASON_BAD_SLID] = "Bad SLID",
+	[OPA_LINKDOWN_REASON_BAD_DLID] = "Bad DLID",
+	[OPA_LINKDOWN_REASON_BAD_L2] = "Bad L2",
+	[OPA_LINKDOWN_REASON_BAD_SC] = "Bad SC",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_8] = "Receive error 8",
+	[OPA_LINKDOWN_REASON_BAD_MID_TAIL] = "Bad mid tail",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_10] = "Receive error 10",
+	[OPA_LINKDOWN_REASON_PREEMPT_ERROR] = "Preempt error",
+	[OPA_LINKDOWN_REASON_PREEMPT_VL15] = "Preempt vl15",
+	[OPA_LINKDOWN_REASON_BAD_VL_MARKER] = "Bad VL marker",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_14] = "Receive error 14",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_15] = "Receive error 15",
+	[OPA_LINKDOWN_REASON_BAD_HEAD_DIST] = "Bad head distance",
+	[OPA_LINKDOWN_REASON_BAD_TAIL_DIST] = "Bad tail distance",
+	[OPA_LINKDOWN_REASON_BAD_CTRL_DIST] = "Bad control distance",
+	[OPA_LINKDOWN_REASON_BAD_CREDIT_ACK] = "Bad credit ack",
+	[OPA_LINKDOWN_REASON_UNSUPPORTED_VL_MARKER] = "Unsupported VL marker",
+	[OPA_LINKDOWN_REASON_BAD_PREEMPT] = "Bad preempt",
+	[OPA_LINKDOWN_REASON_BAD_CONTROL_FLIT] = "Bad control flit",
+	[OPA_LINKDOWN_REASON_EXCEED_MULTICAST_LIMIT] = "Exceed multicast limit",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_24] = "Receive error 24",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_25] = "Receive error 25",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_26] = "Receive error 26",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_27] = "Receive error 27",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_28] = "Receive error 28",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_29] = "Receive error 29",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_30] = "Receive error 30",
+	[OPA_LINKDOWN_REASON_EXCESSIVE_BUFFER_OVERRUN] =
+					"Excessive buffer overrun",
+	[OPA_LINKDOWN_REASON_UNKNOWN] = "Unknown",
+	[OPA_LINKDOWN_REASON_REBOOT] = "Reboot",
+	[OPA_LINKDOWN_REASON_NEIGHBOR_UNKNOWN] = "Neighbor unknown",
+	[OPA_LINKDOWN_REASON_FM_BOUNCE] = "FM bounce",
+	[OPA_LINKDOWN_REASON_SPEED_POLICY] = "Speed policy",
+	[OPA_LINKDOWN_REASON_WIDTH_POLICY] = "Width policy",
+	[OPA_LINKDOWN_REASON_DISCONNECTED] = "Disconnected",
+	[OPA_LINKDOWN_REASON_LOCAL_MEDIA_NOT_INSTALLED] =
+					"Local media not installed",
+	[OPA_LINKDOWN_REASON_NOT_INSTALLED] = "Not installed",
+	[OPA_LINKDOWN_REASON_CHASSIS_CONFIG] = "Chassis config",
+	[OPA_LINKDOWN_REASON_END_TO_END_NOT_INSTALLED] =
+					"End to end not installed",
+	[OPA_LINKDOWN_REASON_POWER_POLICY] = "Power policy",
+	[OPA_LINKDOWN_REASON_LINKSPEED_POLICY] = "Link speed policy",
+	[OPA_LINKDOWN_REASON_LINKWIDTH_POLICY] = "Link width policy",
+	[OPA_LINKDOWN_REASON_SWITCH_MGMT] = "Switch management",
+	[OPA_LINKDOWN_REASON_SMA_DISABLED] = "SMA disabled",
+	[OPA_LINKDOWN_REASON_TRANSIENT] = "Transient"
+};
+
+/* return the neighbor link down reason string */
+static const char *link_down_reason_str(u8 reason)
+{
+	const char *str = NULL;
+
+	if (reason < ARRAY_SIZE(link_down_reason_strs))
+		str = link_down_reason_strs[reason];
+	if (!str)
+		str = "(invalid)";
+
+	return str;
+}
+
+/*
+ * Handle a link down interrupt from the 8051.
+ *
+ * This is a work-queue function outside of the interrupt.
+ */
+void handle_link_down(struct work_struct *work)
+{
+	u8 lcl_reason, neigh_reason = 0;
+	u8 link_down_reason;
+	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
+						  link_down_work);
+	int was_up;
+	static const char ldr_str[] = "Link down reason: ";
+
+	if ((ppd->host_link_state &
+	     (HLS_DN_POLL | HLS_VERIFY_CAP | HLS_GOING_UP)) &&
+	     ppd->port_type == PORT_TYPE_FIXED)
+		ppd->offline_disabled_reason =
+			HFI2_ODR_MASK(OPA_LINKDOWN_REASON_NOT_INSTALLED);
+
+	/* Go offline first, then deal with reading/writing through 8051 */
+	was_up = !!(ppd->host_link_state & HLS_UP);
+	set_link_state(ppd, HLS_DN_OFFLINE);
+	xchg(&ppd->is_link_down_queued, 0);
+
+	if (was_up) {
+		lcl_reason = 0;
+		/* link down reason is only valid if the link was up */
+		read_link_down_reason(ppd->dd, &link_down_reason);
+		switch (link_down_reason) {
+		case LDR_LINK_TRANSFER_ACTIVE_LOW:
+			/* the link went down, no idle message reason */
+			ppd_dev_info(ppd, "%sUnexpected link down\n",
+				     ldr_str);
+			break;
+		case LDR_RECEIVED_LINKDOWN_IDLE_MSG:
+			/*
+			 * The neighbor reason is only valid if an idle message
+			 * was received for it.
+			 */
+			read_planned_down_reason_code(ppd->dd, &neigh_reason);
+			ppd_dev_info(ppd,
+				     "%sNeighbor link down message %d, %s\n",
+				     ldr_str, neigh_reason,
+				     link_down_reason_str(neigh_reason));
+			break;
+		case LDR_RECEIVED_HOST_OFFLINE_REQ:
+			ppd_dev_info(ppd,
+				     "%sHost requested link to go offline\n",
+				     ldr_str);
+			break;
+		default:
+			ppd_dev_info(ppd, "%sUnknown reason 0x%x\n",
+				     ldr_str, link_down_reason);
+			break;
+		}
+
+		/*
+		 * If no reason, assume peer-initiated but missed
+		 * LinkGoingDown idle flits.
+		 */
+		if (neigh_reason == 0)
+			lcl_reason = OPA_LINKDOWN_REASON_NEIGHBOR_UNKNOWN;
+	} else {
+		/* went down while polling or going up */
+		lcl_reason = OPA_LINKDOWN_REASON_TRANSIENT;
+	}
+
+	set_link_down_reason(ppd, lcl_reason, neigh_reason, 0);
+
+	/* inform the SMA when the link transitions from up to down */
+	if (was_up && ppd->local_link_down_reason.sma == 0 &&
+	    ppd->neigh_link_down_reason.sma == 0) {
+		ppd->local_link_down_reason.sma =
+					ppd->local_link_down_reason.latest;
+		ppd->neigh_link_down_reason.sma =
+					ppd->neigh_link_down_reason.latest;
+	}
+
+	reset_neighbor_info(ppd);
+
+	/* disable the port */
+	clear_rcvctrl(ppd, RCV_CTRL_RCV_PORT_ENABLE_SMASK);
+
+	/*
+	 * If there is no cable attached, turn the DC off. Otherwise,
+	 * start the link bring up.
+	 */
+	if (ppd->port_type == PORT_TYPE_QSFP && !qsfp_mod_present(ppd))
+		dc_shutdown(ppd->dd);
+	else
+		start_link(ppd);
+}
+
+void wfr_handle_link_bounce(struct work_struct *work)
+{
+	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
+							link_bounce_work);
+
+	/*
+	 * Only do something if the link is currently up.
+	 */
+	if (ppd->host_link_state & HLS_UP) {
+		set_link_state(ppd, HLS_DN_OFFLINE);
+		start_link(ppd);
+	} else {
+		ppd_dev_info(ppd, "%s: link not up (%s), nothing to do\n",
+			     __func__, link_state_name(ppd->host_link_state));
+	}
+}
+
+/*
+ * Mask conversion: Capability exchange to Port LTP.  The capability
+ * exchange has an implicit 16b CRC that is mandatory.
+ */
+static int cap_to_port_ltp(int cap)
+{
+	int port_ltp = PORT_LTP_CRC_MODE_16; /* this mode is mandatory */
+
+	if (cap & CAP_CRC_14B)
+		port_ltp |= PORT_LTP_CRC_MODE_14;
+	if (cap & CAP_CRC_48B)
+		port_ltp |= PORT_LTP_CRC_MODE_48;
+	if (cap & CAP_CRC_12B_16B_PER_LANE)
+		port_ltp |= PORT_LTP_CRC_MODE_PER_LANE;
+
+	return port_ltp;
+}
+
+/*
+ * Convert an OPA Port LTP mask to capability mask
+ */
+int port_ltp_to_cap(int port_ltp)
+{
+	int cap_mask = 0;
+
+	if (port_ltp & PORT_LTP_CRC_MODE_14)
+		cap_mask |= CAP_CRC_14B;
+	if (port_ltp & PORT_LTP_CRC_MODE_48)
+		cap_mask |= CAP_CRC_48B;
+	if (port_ltp & PORT_LTP_CRC_MODE_PER_LANE)
+		cap_mask |= CAP_CRC_12B_16B_PER_LANE;
+
+	return cap_mask;
+}
+
+/*
+ * Convert a single DC LCB CRC mode to an OPA Port LTP mask.
+ */
+static int lcb_to_port_ltp(int lcb_crc)
+{
+	int port_ltp = 0;
+
+	if (lcb_crc == LCB_CRC_12B_16B_PER_LANE)
+		port_ltp = PORT_LTP_CRC_MODE_PER_LANE;
+	else if (lcb_crc == LCB_CRC_48B)
+		port_ltp = PORT_LTP_CRC_MODE_48;
+	else if (lcb_crc == LCB_CRC_14B)
+		port_ltp = PORT_LTP_CRC_MODE_14;
+	else
+		port_ltp = PORT_LTP_CRC_MODE_16;
+
+	return port_ltp;
+}
+
+static void clear_full_mgmt_pkey(struct hfi2_pportdata *ppd)
+{
+	if (ppd->pkeys[2] != 0) {
+		ppd->pkeys[2] = 0;
+		(void)hfi2_set_ib_cfg(ppd, HFI2_IB_CFG_PKEYS, 0);
+		hfi2_event_pkey_change(ppd->dd, ppd->port);
+	}
+}
+
+/*
+ * Convert the given link width to the OPA link width bitmask.
+ */
+static u16 link_width_to_bits(struct hfi2_devdata *dd, u16 width)
+{
+	switch (width) {
+	case 0:
+		/*
+		 * Quick linkup does not set the width.
+		 * Just set it to 4x without complaint.
+		 */
+		if (quick_linkup)
+			return OPA_LINK_WIDTH_4X;
+		return 0; /* no lanes up */
+	case 1: return OPA_LINK_WIDTH_1X;
+	case 2: return OPA_LINK_WIDTH_2X;
+	case 3: return OPA_LINK_WIDTH_3X;
+	case 4: return OPA_LINK_WIDTH_4X;
+	default:
+		dd_dev_info(dd, "%s: invalid width %d, using 4\n",
+			    __func__, width);
+		return OPA_LINK_WIDTH_4X;
+	}
+}
+
+/*
+ * Do a population count on the bottom nibble.
+ */
+static const u8 bit_counts[16] = {
+	0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4
+};
+
+static inline u8 nibble_to_count(u8 nibble)
+{
+	return bit_counts[nibble & 0xf];
+}
+
+/*
+ * Read the active lane information from the 8051 registers and return
+ * their widths.
+ *
+ * Active lane information is found in these 8051 registers:
+ *	enable_lane_tx
+ *	enable_lane_rx
+ */
+static void get_link_widths(struct hfi2_pportdata *ppd, u16 *tx_width,
+			    u16 *rx_width)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u16 tx, rx;
+	u8 enable_lane_rx;
+	u8 enable_lane_tx;
+	u8 tx_polarity_inversion;
+	u8 rx_polarity_inversion;
+	u8 max_rate;
+
+	/* read the active lanes */
+	read_tx_settings(dd, &enable_lane_tx, &tx_polarity_inversion,
+			 &rx_polarity_inversion, &max_rate);
+	read_local_lni(dd, &enable_lane_rx);
+
+	/* convert to counts */
+	tx = nibble_to_count(enable_lane_tx);
+	rx = nibble_to_count(enable_lane_rx);
+
+	/*
+	 * Set link_speed_active here, overriding what was set in
+	 * handle_verify_cap().  The ASIC 8051 firmware does not correctly
+	 * set the max_rate field in handle_verify_cap until v0.19.
+	 */
+	if ((dd->icode == ICODE_RTL_SILICON) &&
+	    (dd->dc8051_ver < dc8051_ver(0, 19, 0))) {
+		/* max_rate: 0 = 12.5G, 1 = 25G */
+		switch (max_rate) {
+		case 0:
+			ppd->link_speed_active = OPA_LINK_SPEED_12_5G;
+			break;
+		case 1:
+			ppd->link_speed_active = OPA_LINK_SPEED_25G;
+			break;
+		default:
+			ppd_dev_err(ppd,
+				    "%s: unexpected max rate %d, using 25Gb\n",
+				    __func__, (int)max_rate);
+			ppd->link_speed_active = OPA_LINK_SPEED_25G;
+			break;
+		}
+	}
+
+	ppd_dev_info(ppd,
+		     "Fabric active lanes (width): tx 0x%x (%d), rx 0x%x (%d)\n",
+		     enable_lane_tx, tx, enable_lane_rx, rx);
+	*tx_width = link_width_to_bits(dd, tx);
+	*rx_width = link_width_to_bits(dd, rx);
+}
+
+/*
+ * Read verify_cap_local_fm_link_width[1] to obtain the link widths.
+ * Valid after the end of VerifyCap and during LinkUp.  Does not change
+ * after link up.  I.e. look elsewhere for downgrade information.
+ *
+ * Bits are:
+ *	+ bits [7:4] contain the number of active transmitters
+ *	+ bits [3:0] contain the number of active receivers
+ * These are numbers 1 through 4 and can be different values if the
+ * link is asymmetric.
+ *
+ * verify_cap_local_fm_link_width[0] retains its original value.
+ */
+static void get_linkup_widths(struct hfi2_pportdata *ppd, u16 *tx_width,
+			      u16 *rx_width)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u16 widths, tx, rx;
+	u8 misc_bits, local_flags;
+	u16 active_tx, active_rx;
+
+	read_vc_local_link_mode(dd, &misc_bits, &local_flags, &widths);
+	tx = widths >> 12;
+	rx = (widths >> 8) & 0xf;
+
+	*tx_width = link_width_to_bits(dd, tx);
+	*rx_width = link_width_to_bits(dd, rx);
+
+	/* print the active widths */
+	get_link_widths(ppd, &active_tx, &active_rx);
+}
+
+/*
+ * Set ppd->link_width_active and ppd->link_width_downgrade_active using
+ * hardware information when the link first comes up.
+ *
+ * The link width is not available until after VerifyCap.AllFramesReceived
+ * (the trigger for handle_verify_cap), so this is outside that routine
+ * and should be called when the 8051 signals linkup.
+ */
+void get_linkup_link_widths(struct hfi2_pportdata *ppd)
+{
+	/* FIXME: Do not query the DC for values on JKR.
+	 * Run-time check so I don't get a warning that
+	 * get_linkup_widths() is unused.
+	 */
+	if (ppd->dd->params->chip_type == CHIP_WFR) {
+		u16 tx_width, rx_width;
+
+		/* get end-of-LNI link widths */
+		get_linkup_widths(ppd, &tx_width, &rx_width);
+
+		/* use tx_width as the link is supposed to be symmetric on link up */
+		ppd->link_width_active = tx_width;
+	} else {
+		u32 original_lwa = ppd->link_width_active;
+
+		/* FIXME: overwrite the "real" default active of 100G so
+		 * in case the opa tools fail because of an unknown speed.
+		 */
+		ppd->link_speed_active = OPA_LINK_SPEED_25G;
+		ppd->link_speed_enabled = OPA_LINK_SPEED_25G;
+
+		/* FIXME: pretend linkup code */
+		ppd->link_width_active = OPA_LINK_WIDTH_4X;
+		pr_info("%s: link_width_active 0x%x (original) 0x%x (set), link_width_downgrade_supported 0x%x, link_speed_active 0x%x\n",
+			__func__,
+			original_lwa,
+			ppd->link_width_active,
+			ppd->link_width_downgrade_supported,
+			ppd->link_speed_active);
+	}
+	/* link width downgrade active (LWD.A) starts out matching LW.A */
+	ppd->link_width_downgrade_tx_active = ppd->link_width_active;
+	ppd->link_width_downgrade_rx_active = ppd->link_width_active;
+	/* per OPA spec, on link up LWD.E resets to LWD.S */
+	ppd->link_width_downgrade_enabled = ppd->link_width_downgrade_supported;
+	/* cache the active egress rate (units {10^6 bits/sec]) */
+	ppd->current_egress_rate = active_egress_rate(ppd);
+}
+
+/*
+ * Handle a verify capabilities interrupt from the 8051.
+ *
+ * This is a work-queue function outside of the interrupt.
+ */
+void handle_verify_cap(struct work_struct *work)
+{
+	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
+								link_vc_work);
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+	u8 power_management;
+	u8 continuous;
+	u8 vcu;
+	u8 vau;
+	u8 z;
+	u16 vl15buf;
+	u16 link_widths;
+	u16 crc_mask;
+	u16 crc_val;
+	u16 device_id;
+	u16 active_tx, active_rx;
+	u8 partner_supported_crc;
+	u8 remote_tx_rate;
+	u8 device_rev;
+
+	set_link_state(ppd, HLS_VERIFY_CAP);
+
+	lcb_shutdown(dd, 0);
+
+	read_vc_remote_phy(dd, &power_management, &continuous);
+	read_vc_remote_fabric(dd, &vau, &z, &vcu, &vl15buf,
+			      &partner_supported_crc);
+	read_vc_remote_link_width(dd, &remote_tx_rate, &link_widths);
+	read_remote_device_id(dd, &device_id, &device_rev);
+
+	/* print the active widths */
+	get_link_widths(ppd, &active_tx, &active_rx);
+	ppd_dev_info(ppd,
+		     "Peer PHY: power management 0x%x, continuous updates 0x%x\n",
+		     (int)power_management, (int)continuous);
+	ppd_dev_info(ppd,
+		     "Peer Fabric: vAU %d, Z %d, vCU %d, vl15 credits 0x%x, CRC sizes 0x%x\n",
+		     (int)vau, (int)z, (int)vcu, (int)vl15buf,
+		     (int)partner_supported_crc);
+	ppd_dev_info(ppd, "Peer Link Width: tx rate 0x%x, widths 0x%x\n",
+		     (u32)remote_tx_rate, (u32)link_widths);
+	ppd_dev_info(ppd, "Peer Device ID: 0x%04x, Revision 0x%02x\n",
+		     (u32)device_id, (u32)device_rev);
+	/*
+	 * The peer vAU value just read is the peer receiver value.  HFI does
+	 * not support a transmit vAU of 0 (AU == 8).  We advertised that
+	 * with Z=1 in the fabric capabilities sent to the peer.  The peer
+	 * will see our Z=1, and, if it advertised a vAU of 0, will move its
+	 * receive to vAU of 1 (AU == 16).  Do the same here.  We do not care
+	 * about the peer Z value - our sent vAU is 3 (hardwired) and is not
+	 * subject to the Z value exception.
+	 */
+	if (vau == 0)
+		vau = 1;
+	set_up_vau(ppd, vau);
+
+	/*
+	 * Set VL15 credits to 0 in global credit register. Cache remote VL15
+	 * credits value and wait for link-up interrupt ot set it.
+	 */
+	set_up_vl15(ppd, 0);
+	dd->vl15buf_cached = vl15buf;
+
+	/* set up the LCB CRC mode */
+	crc_mask = ppd->port_crc_mode_enabled & partner_supported_crc;
+
+	/* order is important: use the lowest bit in common */
+	if (crc_mask & CAP_CRC_14B)
+		crc_val = LCB_CRC_14B;
+	else if (crc_mask & CAP_CRC_48B)
+		crc_val = LCB_CRC_48B;
+	else if (crc_mask & CAP_CRC_12B_16B_PER_LANE)
+		crc_val = LCB_CRC_12B_16B_PER_LANE;
+	else
+		crc_val = LCB_CRC_16B;
+
+	ppd_dev_info(ppd, "Final LCB CRC mode: %d\n", (int)crc_val);
+	write_csr(dd, DC_LCB_CFG_CRC_MODE,
+		  (u64)crc_val << DC_LCB_CFG_CRC_MODE_TX_VAL_SHIFT);
+
+	/* set (14b only) or clear sideband credit */
+	reg = read_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_ctrl_reg);
+	if (crc_val == LCB_CRC_14B && crc_14b_sideband) {
+		write_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_ctrl_reg,
+				reg | SEND_CM_CTRL_FORCE_CREDIT_MODE_SMASK);
+	} else {
+		write_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_ctrl_reg,
+				reg & ~SEND_CM_CTRL_FORCE_CREDIT_MODE_SMASK);
+	}
+
+	ppd->link_speed_active = 0;	/* invalid value */
+	if (dd->dc8051_ver < dc8051_ver(0, 20, 0)) {
+		/* remote_tx_rate: 0 = 12.5G, 1 = 25G */
+		switch (remote_tx_rate) {
+		case 0:
+			ppd->link_speed_active = OPA_LINK_SPEED_12_5G;
+			break;
+		case 1:
+			ppd->link_speed_active = OPA_LINK_SPEED_25G;
+			break;
+		}
+	} else {
+		/* actual rate is highest bit of the ANDed rates */
+		u8 rate = remote_tx_rate & ppd->local_tx_rate;
+
+		if (rate & 2)
+			ppd->link_speed_active = OPA_LINK_SPEED_25G;
+		else if (rate & 1)
+			ppd->link_speed_active = OPA_LINK_SPEED_12_5G;
+	}
+	if (ppd->link_speed_active == 0) {
+		ppd_dev_err(ppd, "%s: unexpected remote tx rate %d, using 25Gb\n",
+			    __func__, (int)remote_tx_rate);
+		ppd->link_speed_active = OPA_LINK_SPEED_25G;
+	}
+
+	/*
+	 * Cache the values of the supported, enabled, and active
+	 * LTP CRC modes to return in 'portinfo' queries. But the bit
+	 * flags that are returned in the portinfo query differ from
+	 * what's in the link_crc_mask, crc_sizes, and crc_val
+	 * variables. Convert these here.
+	 */
+	ppd->port_ltp_crc_mode = cap_to_port_ltp(link_crc_mask) << 8;
+		/* supported crc modes */
+	ppd->port_ltp_crc_mode |=
+		cap_to_port_ltp(ppd->port_crc_mode_enabled) << 4;
+		/* enabled crc modes */
+	ppd->port_ltp_crc_mode |= lcb_to_port_ltp(crc_val);
+		/* active crc mode */
+
+	/* set up the remote credit return table */
+	assign_remote_cm_au_table(ppd, vcu);
+
+	/*
+	 * The LCB is reset on entry to handle_verify_cap(), so this must
+	 * be applied on every link up.
+	 *
+	 * Adjust LCB error kill enable to kill the link if
+	 * these RBUF errors are seen:
+	 *	REPLAY_BUF_MBE_SMASK
+	 *	FLIT_INPUT_BUF_MBE_SMASK
+	 */
+	if (is_ax(dd)) {			/* fixed in B0 */
+		reg = read_csr(dd, DC_LCB_CFG_LINK_KILL_EN);
+		reg |= DC_LCB_CFG_LINK_KILL_EN_REPLAY_BUF_MBE_SMASK
+			| DC_LCB_CFG_LINK_KILL_EN_FLIT_INPUT_BUF_MBE_SMASK;
+		write_csr(dd, DC_LCB_CFG_LINK_KILL_EN, reg);
+	}
+
+	/* pull LCB fifos out of reset - all fifo clocks must be stable */
+	write_csr(dd, DC_LCB_CFG_TX_FIFOS_RESET, 0);
+
+	/* give 8051 access to the LCB CSRs */
+	write_csr(dd, DC_LCB_ERR_EN, 0); /* mask LCB errors */
+	set_8051_lcb_access(dd);
+
+	/* tell the 8051 to go to LinkUp */
+	set_link_state(ppd, HLS_GOING_UP);
+}
+
+/**
+ * apply_link_downgrade_policy - Apply the link width downgrade enabled
+ * policy against the current active link widths.
+ * @ppd: info of physical Hfi port
+ * @refresh_widths: True indicates link downgrade event
+ * @return: True indicates a successful link downgrade. False indicates
+ *	    link downgrade event failed and the link will bounce back to
+ *	    default link width.
+ *
+ * Called when the enabled policy changes or the active link widths
+ * change.
+ * Refresh_widths indicates that a link downgrade occurred. The
+ * link_downgraded variable is set by refresh_widths and
+ * determines the success/failure of the policy application.
+ */
+bool apply_link_downgrade_policy(struct hfi2_pportdata *ppd,
+				 bool refresh_widths)
+{
+	int do_bounce = 0;
+	int tries;
+	u16 lwde;
+	u16 tx, rx;
+	bool link_downgraded = refresh_widths;
+
+	/* use the hls lock to avoid a race with actual link up */
+	tries = 0;
+retry:
+	mutex_lock(&ppd->hls_lock);
+	/* only apply if the link is up */
+	if (ppd->host_link_state & HLS_DOWN) {
+		/* still going up..wait and retry */
+		if (ppd->host_link_state & HLS_GOING_UP) {
+			if (++tries < 1000) {
+				mutex_unlock(&ppd->hls_lock);
+				usleep_range(100, 120); /* arbitrary */
+				goto retry;
+			}
+			ppd_dev_err(ppd,
+				    "%s: giving up waiting for link state change\n",
+				    __func__);
+		}
+		goto done;
+	}
+
+	lwde = ppd->link_width_downgrade_enabled;
+
+	if (refresh_widths) {
+		get_link_widths(ppd, &tx, &rx);
+		ppd->link_width_downgrade_tx_active = tx;
+		ppd->link_width_downgrade_rx_active = rx;
+	}
+
+	if (ppd->link_width_downgrade_tx_active == 0 ||
+	    ppd->link_width_downgrade_rx_active == 0) {
+		/* the 8051 reported a dead link as a downgrade */
+		ppd_dev_err(ppd, "Link downgrade is really a link down, ignoring\n");
+		link_downgraded = false;
+	} else if (lwde == 0) {
+		/* downgrade is disabled */
+
+		/* bounce if not at starting active width */
+		if ((ppd->link_width_active !=
+		     ppd->link_width_downgrade_tx_active) ||
+		    (ppd->link_width_active !=
+		     ppd->link_width_downgrade_rx_active)) {
+			ppd_dev_err(ppd,
+				    "Link downgrade is disabled and link has downgraded, downing link\n");
+			ppd_dev_err(ppd,
+				    "  original 0x%x, tx active 0x%x, rx active 0x%x\n",
+				    ppd->link_width_active,
+				    ppd->link_width_downgrade_tx_active,
+				    ppd->link_width_downgrade_rx_active);
+			do_bounce = 1;
+			link_downgraded = false;
+		}
+	} else if ((lwde & ppd->link_width_downgrade_tx_active) == 0 ||
+		   (lwde & ppd->link_width_downgrade_rx_active) == 0) {
+		/* Tx or Rx is outside the enabled policy */
+		ppd_dev_err(ppd,
+			    "Link is outside of downgrade allowed, downing link\n");
+		ppd_dev_err(ppd,
+			    "  enabled 0x%x, tx active 0x%x, rx active 0x%x\n",
+			    lwde, ppd->link_width_downgrade_tx_active,
+			    ppd->link_width_downgrade_rx_active);
+		do_bounce = 1;
+		link_downgraded = false;
+	}
+
+done:
+	mutex_unlock(&ppd->hls_lock);
+
+	if (do_bounce) {
+		set_link_down_reason(ppd, OPA_LINKDOWN_REASON_WIDTH_POLICY, 0,
+				     OPA_LINKDOWN_REASON_WIDTH_POLICY);
+		set_link_state(ppd, HLS_DN_OFFLINE);
+		start_link(ppd);
+	}
+
+	return link_downgraded;
+}
+
+/*
+ * Handle a link downgrade interrupt from the 8051.
+ *
+ * This is a work-queue function outside of the interrupt.
+ */
+void handle_link_downgrade(struct work_struct *work)
+{
+	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
+							link_downgrade_work);
+
+	ppd_dev_info(ppd, "8051: Link width downgrade\n");
+	if (apply_link_downgrade_policy(ppd, true))
+		update_xmit_counters(ppd, ppd->link_width_downgrade_tx_active);
+}
+
+static char *dcc_err_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags, dcc_err_flags,
+		ARRAY_SIZE(dcc_err_flags));
+}
+
+static char *lcb_err_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags, lcb_err_flags,
+		ARRAY_SIZE(lcb_err_flags));
+}
+
+static char *dc8051_err_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags, dc8051_err_flags,
+		ARRAY_SIZE(dc8051_err_flags));
+}
+
+static char *dc8051_info_err_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags, dc8051_info_err_flags,
+		ARRAY_SIZE(dc8051_info_err_flags));
+}
+
+static char *dc8051_info_host_msg_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags, dc8051_info_host_msg_flags,
+		ARRAY_SIZE(dc8051_info_host_msg_flags));
+}
+
+static void handle_8051_interrupt(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	struct hfi2_pportdata *ppd = dd->pport;
+	u64 info, err, host_msg;
+	int queue_link_down = 0;
+	char buf[96];
+
+	/* look at the flags */
+	if (reg & DC_DC8051_ERR_FLG_SET_BY_8051_SMASK) {
+		/* 8051 information set by firmware */
+		/* read DC8051_DBG_ERR_INFO_SET_BY_8051 for details */
+		info = read_csr(dd, DC_DC8051_DBG_ERR_INFO_SET_BY_8051);
+		err = (info >> DC_DC8051_DBG_ERR_INFO_SET_BY_8051_ERROR_SHIFT)
+			& DC_DC8051_DBG_ERR_INFO_SET_BY_8051_ERROR_MASK;
+		host_msg = (info >>
+			DC_DC8051_DBG_ERR_INFO_SET_BY_8051_HOST_MSG_SHIFT)
+			& DC_DC8051_DBG_ERR_INFO_SET_BY_8051_HOST_MSG_MASK;
+
+		/*
+		 * Handle error flags.
+		 */
+		if (err & FAILED_LNI) {
+			/*
+			 * LNI error indications are cleared by the 8051
+			 * only when starting polling.  Only pay attention
+			 * to them when in the states that occur during
+			 * LNI.
+			 */
+			if (ppd->host_link_state
+			    & (HLS_DN_POLL | HLS_VERIFY_CAP | HLS_GOING_UP)) {
+				queue_link_down = 1;
+				ppd_dev_info(ppd, "Link error: %s\n",
+					     dc8051_info_err_string(buf,
+								    sizeof(buf),
+								    err &
+								    FAILED_LNI));
+			}
+			err &= ~(u64)FAILED_LNI;
+		}
+		/* unknown frames can happen durning LNI, just count */
+		if (err & UNKNOWN_FRAME) {
+			ppd->unknown_frame_count++;
+			err &= ~(u64)UNKNOWN_FRAME;
+		}
+		if (err) {
+			/* report remaining errors, but do not do anything */
+			ppd_dev_err(ppd, "8051 info error: %s\n",
+				    dc8051_info_err_string(buf, sizeof(buf),
+							   err));
+		}
+
+		/*
+		 * Handle host message flags.
+		 */
+		if (host_msg & HOST_REQ_DONE) {
+			/*
+			 * Presently, the driver does a busy wait for
+			 * host requests to complete.  This is only an
+			 * informational message.
+			 * NOTE: The 8051 clears the host message
+			 * information *on the next 8051 command*.
+			 * Therefore, when linkup is achieved,
+			 * this flag will still be set.
+			 */
+			host_msg &= ~(u64)HOST_REQ_DONE;
+		}
+		if (host_msg & BC_SMA_MSG) {
+			queue_work(ppd->link_wq, &ppd->sma_message_work);
+			host_msg &= ~(u64)BC_SMA_MSG;
+		}
+		if (host_msg & LINKUP_ACHIEVED) {
+			ppd_dev_info(ppd, "8051: Link up\n");
+			queue_work(ppd->link_wq, &ppd->link_up_work);
+			host_msg &= ~(u64)LINKUP_ACHIEVED;
+		}
+		if (host_msg & EXT_DEVICE_CFG_REQ) {
+			handle_8051_request(ppd);
+			host_msg &= ~(u64)EXT_DEVICE_CFG_REQ;
+		}
+		if (host_msg & VERIFY_CAP_FRAME) {
+			queue_work(ppd->link_wq, &ppd->link_vc_work);
+			host_msg &= ~(u64)VERIFY_CAP_FRAME;
+		}
+		if (host_msg & LINK_GOING_DOWN) {
+			const char *extra = "";
+			/* no downgrade action needed if going down */
+			if (host_msg & LINK_WIDTH_DOWNGRADED) {
+				host_msg &= ~(u64)LINK_WIDTH_DOWNGRADED;
+				extra = " (ignoring downgrade)";
+			}
+			dd_dev_info(dd, "8051: Link down%s\n", extra);
+			queue_link_down = 1;
+			host_msg &= ~(u64)LINK_GOING_DOWN;
+		}
+		if (host_msg & LINK_WIDTH_DOWNGRADED) {
+			queue_work(ppd->link_wq, &ppd->link_downgrade_work);
+			host_msg &= ~(u64)LINK_WIDTH_DOWNGRADED;
+		}
+		if (host_msg) {
+			/* report remaining messages, but do not do anything */
+			ppd_dev_info(ppd, "8051 info host message: %s\n",
+				     dc8051_info_host_msg_string(buf,
+								 sizeof(buf),
+								 host_msg));
+		}
+
+		reg &= ~DC_DC8051_ERR_FLG_SET_BY_8051_SMASK;
+	}
+	if (reg & DC_DC8051_ERR_FLG_LOST_8051_HEART_BEAT_SMASK) {
+		/*
+		 * Lost the 8051 heartbeat.  If this happens, we
+		 * receive constant interrupts about it.  Disable
+		 * the interrupt after the first.
+		 */
+		ppd_dev_err(ppd, "Lost 8051 heartbeat\n");
+		write_csr(dd, DC_DC8051_ERR_EN,
+			  read_csr(dd, DC_DC8051_ERR_EN) &
+			  ~DC_DC8051_ERR_EN_LOST_8051_HEART_BEAT_SMASK);
+
+		reg &= ~DC_DC8051_ERR_FLG_LOST_8051_HEART_BEAT_SMASK;
+	}
+	if (reg) {
+		/* report the error, but do not do anything */
+		ppd_dev_err(ppd, "8051 error: %s\n",
+			    dc8051_err_string(buf, sizeof(buf), reg));
+	}
+
+	if (queue_link_down) {
+		/*
+		 * if the link is already going down or disabled, do not
+		 * queue another. If there's a link down entry already
+		 * queued, don't queue another one.
+		 */
+		if ((ppd->host_link_state &
+		    (HLS_GOING_OFFLINE | HLS_LINK_COOLDOWN)) ||
+		    ppd->link_enabled == 0) {
+			ppd_dev_info(ppd, "%s: not queuing link down. host_link_state %x, link_enabled %x\n",
+				     __func__, ppd->host_link_state,
+				     ppd->link_enabled);
+		} else {
+			if (xchg(&ppd->is_link_down_queued, 1) == 1)
+				ppd_dev_info(ppd,
+					     "%s: link down request already queued\n",
+					     __func__);
+			else
+				queue_work(ppd->link_wq, &ppd->link_down_work);
+		}
+	}
+}
+
+static const char * const fm_config_txt[] = {
+[0] =
+	"BadHeadDist: Distance violation between two head flits",
+[1] =
+	"BadTailDist: Distance violation between two tail flits",
+[2] =
+	"BadCtrlDist: Distance violation between two credit control flits",
+[3] =
+	"BadCrdAck: Credits return for unsupported VL",
+[4] =
+	"UnsupportedVLMarker: Received VL Marker",
+[5] =
+	"BadPreempt: Exceeded the preemption nesting level",
+[6] =
+	"BadControlFlit: Received unsupported control flit",
+/* no 7 */
+[8] =
+	"UnsupportedVLMarker: Received VL Marker for unconfigured or disabled VL",
+};
+
+static const char * const port_rcv_txt[] = {
+[1] =
+	"BadPktLen: Illegal PktLen",
+[2] =
+	"PktLenTooLong: Packet longer than PktLen",
+[3] =
+	"PktLenTooShort: Packet shorter than PktLen",
+[4] =
+	"BadSLID: Illegal SLID (0, using multicast as SLID, does not include security validation of SLID)",
+[5] =
+	"BadDLID: Illegal DLID (0, doesn't match HFI)",
+[6] =
+	"BadL2: Illegal L2 opcode",
+[7] =
+	"BadSC: Unsupported SC",
+[9] =
+	"BadRC: Illegal RC",
+[11] =
+	"PreemptError: Preempting with same VL",
+[12] =
+	"PreemptVL15: Preempting a VL15 packet",
+};
+
+#define OPA_LDR_FMCONFIG_OFFSET 16
+#define OPA_LDR_PORTRCV_OFFSET 0
+static void handle_dcc_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	u64 info, hdr0, hdr1;
+	const char *extra;
+	char buf[96];
+	struct hfi2_pportdata *ppd = dd->pport;
+	u8 lcl_reason = 0;
+	int do_bounce = 0;
+
+	if (reg & DCC_ERR_FLG_UNCORRECTABLE_ERR_SMASK) {
+		if (!(dd->err_info_uncorrectable & OPA_EI_STATUS_SMASK)) {
+			info = read_csr(dd, DCC_ERR_INFO_UNCORRECTABLE);
+			dd->err_info_uncorrectable = info & OPA_EI_CODE_SMASK;
+			/* set status bit */
+			dd->err_info_uncorrectable |= OPA_EI_STATUS_SMASK;
+		}
+		reg &= ~DCC_ERR_FLG_UNCORRECTABLE_ERR_SMASK;
+	}
+
+	if (reg & DCC_ERR_FLG_LINK_ERR_SMASK) {
+		/* this counter saturates at (2^32) - 1 */
+		if (ppd->link_downed < (u32)UINT_MAX)
+			ppd->link_downed++;
+		reg &= ~DCC_ERR_FLG_LINK_ERR_SMASK;
+	}
+
+	if (reg & DCC_ERR_FLG_FMCONFIG_ERR_SMASK) {
+		u8 reason_valid = 1;
+
+		info = read_csr(dd, DCC_ERR_INFO_FMCONFIG);
+		if (!(dd->err_info_fmconfig & OPA_EI_STATUS_SMASK)) {
+			dd->err_info_fmconfig = info & OPA_EI_CODE_SMASK;
+			/* set status bit */
+			dd->err_info_fmconfig |= OPA_EI_STATUS_SMASK;
+		}
+		switch (info) {
+		case 0:
+		case 1:
+		case 2:
+		case 3:
+		case 4:
+		case 5:
+		case 6:
+			extra = fm_config_txt[info];
+			break;
+		case 8:
+			extra = fm_config_txt[info];
+			if (ppd->port_error_action &
+			    OPA_PI_MASK_FM_CFG_UNSUPPORTED_VL_MARKER) {
+				do_bounce = 1;
+				/*
+				 * lcl_reason cannot be derived from info
+				 * for this error
+				 */
+				lcl_reason =
+				  OPA_LINKDOWN_REASON_UNSUPPORTED_VL_MARKER;
+			}
+			break;
+		default:
+			reason_valid = 0;
+			snprintf(buf, sizeof(buf), "reserved%lld", info);
+			extra = buf;
+			break;
+		}
+
+		if (reason_valid && !do_bounce) {
+			do_bounce = ppd->port_error_action &
+					(1 << (OPA_LDR_FMCONFIG_OFFSET + info));
+			lcl_reason = info + OPA_LINKDOWN_REASON_BAD_HEAD_DIST;
+		}
+
+		/* just report this */
+		dd_dev_info_ratelimited(dd, "DCC Error: fmconfig error: %s\n",
+					extra);
+		reg &= ~DCC_ERR_FLG_FMCONFIG_ERR_SMASK;
+	}
+
+	if (reg & DCC_ERR_FLG_RCVPORT_ERR_SMASK) {
+		u8 reason_valid = 1;
+
+		info = read_csr(dd, DCC_ERR_INFO_PORTRCV);
+		hdr0 = read_csr(dd, DCC_ERR_INFO_PORTRCV_HDR0);
+		hdr1 = read_csr(dd, DCC_ERR_INFO_PORTRCV_HDR1);
+		if (!(dd->err_info_rcvport.status_and_code &
+		      OPA_EI_STATUS_SMASK)) {
+			dd->err_info_rcvport.status_and_code =
+				info & OPA_EI_CODE_SMASK;
+			/* set status bit */
+			dd->err_info_rcvport.status_and_code |=
+				OPA_EI_STATUS_SMASK;
+			/*
+			 * save first 2 flits in the packet that caused
+			 * the error
+			 */
+			dd->err_info_rcvport.packet_flit1 = hdr0;
+			dd->err_info_rcvport.packet_flit2 = hdr1;
+		}
+		switch (info) {
+		case 1:
+		case 2:
+		case 3:
+		case 4:
+		case 5:
+		case 6:
+		case 7:
+		case 9:
+		case 11:
+		case 12:
+			extra = port_rcv_txt[info];
+			break;
+		default:
+			reason_valid = 0;
+			snprintf(buf, sizeof(buf), "reserved%lld", info);
+			extra = buf;
+			break;
+		}
+
+		if (reason_valid && !do_bounce) {
+			do_bounce = ppd->port_error_action &
+					(1 << (OPA_LDR_PORTRCV_OFFSET + info));
+			lcl_reason = info + OPA_LINKDOWN_REASON_RCV_ERROR_0;
+		}
+
+		/* just report this */
+		dd_dev_info_ratelimited(dd, "DCC Error: PortRcv error: %s\n"
+					"               hdr0 0x%llx, hdr1 0x%llx\n",
+					extra, hdr0, hdr1);
+
+		reg &= ~DCC_ERR_FLG_RCVPORT_ERR_SMASK;
+	}
+
+	if (reg & DCC_ERR_FLG_EN_CSR_ACCESS_BLOCKED_UC_SMASK) {
+		/* informative only */
+		dd_dev_info_ratelimited(dd, "8051 access to LCB blocked\n");
+		reg &= ~DCC_ERR_FLG_EN_CSR_ACCESS_BLOCKED_UC_SMASK;
+	}
+	if (reg & DCC_ERR_FLG_EN_CSR_ACCESS_BLOCKED_HOST_SMASK) {
+		/* informative only */
+		dd_dev_info_ratelimited(dd, "host access to LCB blocked\n");
+		reg &= ~DCC_ERR_FLG_EN_CSR_ACCESS_BLOCKED_HOST_SMASK;
+	}
+
+	if (unlikely(hfi2_dbg_fault_suppress_err(&dd->verbs_dev)))
+		reg &= ~DCC_ERR_FLG_LATE_EBP_ERR_SMASK;
+
+	/* report any remaining errors */
+	if (reg)
+		dd_dev_info_ratelimited(dd, "DCC Error: %s\n",
+					dcc_err_string(buf, sizeof(buf), reg));
+
+	if (lcl_reason == 0)
+		lcl_reason = OPA_LINKDOWN_REASON_UNKNOWN;
+
+	if (do_bounce) {
+		dd_dev_info_ratelimited(dd, "%s: PortErrorAction bounce\n",
+					__func__);
+		set_link_down_reason(ppd, lcl_reason, 0, lcl_reason);
+		queue_work(ppd->link_wq, &ppd->link_bounce_work);
+	}
+}
+
+static void handle_lcb_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	char buf[96];
+
+	dd_dev_info(dd, "LCB Error: %s\n",
+		    lcb_err_string(buf, sizeof(buf), reg));
+}
+
+/*
+ * CCE block DC interrupt.  Source is < 8.
+ */
+static void is_dc_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	const struct err_reg_info *eri = &dc_errs[source];
+
+	if (eri->handler) {
+		interrupt_clear_down(dd, 0, eri);
+	} else if (source == 3 /* dc_lbm_int */) {
+		/*
+		 * This indicates that a parity error has occurred on the
+		 * address/control lines presented to the LBM.  The error
+		 * is a single pulse, there is no associated error flag,
+		 * and it is non-maskable.  This is because if a parity
+		 * error occurs on the request the request is dropped.
+		 * This should never occur, but it is nice to know if it
+		 * ever does.
+		 */
+		dd_dev_err(dd, "Parity error in DC LBM block\n");
+	} else {
+		dd_dev_err(dd, "Invalid DC interrupt %u\n", source);
+	}
+}
+
+/*
+ * TX block send credit interrupt.
+ */
+void is_send_credit_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	sc_group_release_update(dd, source);
+}
+
+/*
+ * TX block SDMA interrupt.  Source is < 48.
+ *
+ * SDMA interrupts are grouped by type:
+ *
+ *	 0 -  N-1 = SDma
+ *	 N - 2N-1 = SDmaProgress
+ *	2N - 3N-1 = SDmaIdle
+ */
+void is_sdma_eng_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	/* what interrupt */
+	unsigned int what  = source / TXE_NUM_SDMA_ENGINES;
+	/* which engine */
+	unsigned int which = source % TXE_NUM_SDMA_ENGINES;
+
+#ifdef CONFIG_HFI2_SDMA_VERBOSITY
+	dd_dev_err(dd, "CONFIG SDMA(%u) %s:%d %s()\n", which,
+		   slashstrip(__FILE__), __LINE__, __func__);
+#endif
+
+	if (likely(what < 3 && which >= dr->first_sdma_engine &&
+	    which < dr->last_sdma_engine)) {
+#ifdef CONFIG_HFI2_SDMA_VERBOSITY
+		sdma_dumpstate(&dd->per_sdma[which]);
+#endif
+		sdma_engine_interrupt(&dd->per_sdma[which], 1ull << source);
+	} else {
+		/* should not happen */
+		dd_dev_err(dd, "Invalid SDMA interrupt 0x%x\n", source);
+	}
+}
+
+/**
+ * is_rcv_avail_int() - User receive context available IRQ handler
+ * @dd: valid dd
+ * @source: logical IRQ source (offset from IS_RCVAVAIL_START)
+ *
+ * RX block receive available interrupt.
+ *
+ * This is the general interrupt handler for user (PSM) receive contexts,
+ * and can only be used for non-threaded IRQs.
+ */
+void is_rcv_avail_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	struct hfi2_ctxtdata *rcd;
+
+	rcd = hfi2_rcd_get_by_index(dd, source);
+	if (rcd) {
+		handle_user_interrupt(rcd);
+		hfi2_rcd_put(rcd);
+		return;	/* OK */
+	}
+	dd_dev_err(dd, "unexpected dataless receive available context interrupt %u\n",
+		   source);
+}
+
+/**
+ * is_rcv_urgent_int() - User receive context urgent IRQ handler
+ * @dd: valid dd
+ * @source: logical IRQ source (offset from IS_RCVURGENT_START)
+ *
+ * RX block receive urgent interrupt.
+ *
+ * NOTE: kernel receive contexts specifically do NOT enable this IRQ.
+ */
+void is_rcv_urgent_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	struct hfi2_ctxtdata *rcd;
+
+	rcd = hfi2_rcd_get_by_index(dd, source);
+	if (rcd) {
+		handle_user_interrupt(rcd);
+		hfi2_rcd_put(rcd);
+		return;	/* OK */
+	}
+	dd_dev_err(dd, "unexpected dataless receive urgent context interrupt %u\n",
+		   source);
+}
+
+/*
+ * Reserved range interrupt.  Should not be called in normal operation.
+ */
+static void is_reserved_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	char name[64];
+
+	dd_dev_err(dd, "unexpected %s interrupt\n",
+		   is_reserved_name(name, sizeof(name), source));
+}
+
+const struct is_table is_table[] = {
+/*
+ * start		 end
+ *				name func		interrupt func
+ */
+{ IS_GENERAL_ERR_START,  IS_GENERAL_ERR_END,
+				is_misc_err_name,	is_misc_err_int },
+{ IS_SDMAENG_ERR_START,  IS_SDMAENG_ERR_END,
+				is_sdma_eng_err_name,	is_sdma_eng_err_int },
+{ IS_SENDCTXT_ERR_START, IS_SENDCTXT_ERR_END,
+				is_sendctxt_err_name,	is_sendctxt_err_int },
+{ IS_SDMA_START,	     IS_SDMA_IDLE_END,
+				is_sdma_eng_name,	is_sdma_eng_int },
+{ IS_VARIOUS_START,	     IS_VARIOUS_END,
+				is_various_name,	is_various_int },
+{ IS_DC_START,	     IS_DC_END,
+				is_dc_name,		is_dc_int },
+{ IS_RCVAVAIL_START,     IS_RCVAVAIL_END,
+				is_rcv_avail_name,	is_rcv_avail_int },
+{ IS_RCVURGENT_START,    IS_RCVURGENT_END,
+				is_rcv_urgent_name,	is_rcv_urgent_int },
+{ IS_SENDCREDIT_START,   IS_SENDCREDIT_END,
+				is_send_credit_name,	is_send_credit_int},
+{ IS_RESERVED_START,     IS_RESERVED_END,
+				is_reserved_name,	is_reserved_int},
+{ 0, 0, 0, 0 } /* terminator */
+};
+
+/*
+ * General interrupt sources to enable.  This is all sources but SDMA
+ * (SdmaEngErr, Sdma, SdmaProgress, SdmaIdle), and Receive (RcvAvail,
+ * RcvUrgent).
+ */
+const struct gi_enable_entry wfr_gi_enable_table[] = {
+	{ IS_GENERAL_ERR_START, IS_GENERAL_ERR_END },
+	{ IS_SENDCTXT_ERR_START, IS_SENDCTXT_ERR_END },
+	{ IS_VARIOUS_START, IS_VARIOUS_END },
+	{ IS_DC_START, IS_DC_END },
+	{ IS_SENDCREDIT_START, IS_SENDCREDIT_END },
+	{ 1, 0 } /* terminator */
+};
+
+/*
+ * Interrupt source interrupt - called when the given source has an interrupt.
+ * Source is a bit index into an array of 64-bit integers.
+ */
+static void is_interrupt(struct hfi2_devdata *dd, unsigned int source)
+{
+	const struct is_table *entry;
+
+	/* avoids a double compare by walking the table in-order */
+	for (entry = &dd->params->is_table[0]; entry->is_name; entry++) {
+		if (source <= entry->end) {
+			trace_hfi2_interrupt(dd, entry, source);
+			entry->is_int(dd, source - entry->start);
+			return;
+		}
+	}
+	/* fell off the end */
+	dd_dev_err(dd, "invalid interrupt source %u\n", source);
+}
+
+/**
+ * general_interrupt -  General interrupt handler
+ * @irq: MSIx IRQ vector
+ * @data: hfi2 devdata
+ *
+ * This is able to correctly handle all non-threaded interrupts.  Receive
+ * context DATA IRQs are threaded and are not supported by this handler.
+ *
+ */
+irqreturn_t general_interrupt(int irq, void *data)
+{
+	struct hfi2_devdata *dd = data;
+	u64 regs[LARGEST_NUM_INT_CSRS];
+	u64 mask;
+	u32 bit;
+	u32 num_int_csrs = dd->params->num_int_csrs;
+	u32 cce_int_clear_reg = dd->params->cce_int_clear_reg;
+	u32 cce_int_status_reg = dd->params->cce_int_status_reg;
+	int i;
+	irqreturn_t handled = IRQ_NONE;
+
+	this_cpu_inc(*dd->int_counter);
+
+	/* phase 1: scan and clear all handled interrupts */
+	for (i = 0; i < num_int_csrs; i++) {
+		/* create mask from hw masked and remapped */
+		mask = dd->gi_mask[i].cce_int_mask & dd->gi_mask[i].remap;
+		if (mask == 0) {
+			regs[i] = 0;	/* used later */
+			continue;
+		}
+		regs[i] = read_csr(dd, cce_int_status_reg + (8 * i)) & mask;
+		/* only clear if anything is set */
+		if (regs[i])
+			write_csr(dd, cce_int_clear_reg + (8 * i), regs[i]);
+	}
+
+	/* phase 2: call the appropriate handler */
+	for_each_set_bit(bit, (unsigned long *)&regs[0],
+			 num_int_csrs * 64) {
+		is_interrupt(dd, bit);
+		handled = IRQ_HANDLED;
+	}
+
+	return handled;
+}
+
+static inline void __hfi2_sde_eoi_intr(struct sdma_engine *sde, u32 off, u64 status)
+{
+	struct hfi2_devdata *dd = sde->dd;
+
+	/* clear the interrupt(s) *after* handling them */
+	write_csr(dd, dd->params->cce_int_clear_reg + off, status);
+	if (sdma_work_pending(sde))
+		write_csr(dd, dd->params->cce_int_force_reg + off, sde->int_mask);
+}
+
+irqreturn_t sdma_interrupt(int irq, void *data)
+{
+	struct sdma_engine *sde = data;
+	struct hfi2_devdata *dd = sde->dd;
+	u64 status;
+	u32 off;
+
+#ifdef CONFIG_HFI2_SDMA_VERBOSITY
+	dd_dev_err(dd, "CONFIG SDMA(%u) %s:%d %s()\n", sde->this_idx,
+		   slashstrip(__FILE__), __LINE__, __func__);
+	sdma_dumpstate(sde);
+#endif
+
+	this_cpu_inc(*dd->int_counter);
+
+	/* This read_csr is really bad in the hot path */
+	off = 8 * (dd->params->is_sdma_start / 64);
+	status = read_csr(dd, dd->params->cce_int_status_reg + off) & sde->imask;
+	if (likely(status)) {
+		/* handle the interrupt(s) */
+		sdma_engine_interrupt(sde, status);
+		if (sdma_work_pending(sde))
+			return IRQ_WAKE_THREAD;
+		__hfi2_sde_eoi_intr(sde, off, status);
+	} else {
+		dd_dev_info_ratelimited(dd, "SDMA engine %u interrupt, but no status bits set\n",
+					sde->this_idx);
+	}
+	return IRQ_HANDLED;
+}
+
+irqreturn_t sdma_interrupt_thr(int irq, void *data)
+{
+	struct sdma_engine *sde = data;
+	struct hfi2_devdata *dd = sde->dd;
+	u64 status;
+	u32 off;
+	unsigned long ty;
+	unsigned long flags;
+
+	/* This read_csr is really bad in the hot path */
+	off = 8 * (dd->params->is_sdma_start / 64);
+	status = read_csr(dd, dd->params->cce_int_status_reg + off) & sde->imask;
+	ty = jiffies + msecs_to_jiffies(sdma_yield);
+	if (likely(status)) {
+again:
+		/* handle the interrupt(s) */
+		sdma_engine_interrupt(sde, status);
+
+		if (sdma_work_pending(sde)) {
+			if (time_after(jiffies, ty)) {
+				cond_resched();
+				ty = jiffies + msecs_to_jiffies(sdma_yield);
+			}
+			goto again;
+		}
+		local_irq_save(flags);
+		__hfi2_sde_eoi_intr(sde, off, status);
+		local_irq_restore(flags);
+	} else {
+		dd_dev_info_ratelimited(dd, "SDMA engine %u interrupt, but no status bits set\n",
+					sde->this_idx);
+	}
+	return IRQ_HANDLED;
+}
+
+/*
+ * Force a 0->1 transition on the given interrupt number.
+ *
+ * Caller is responsible for any complications that might
+ * arise from other concurrent activity.
+ */
+void force_intr(struct hfi2_devdata *dd, u16 nr)
+{
+	u32 reg = (nr / 64) * 8;
+	u64 bit = 1ull << (nr % 64);
+
+	/* clear bit first, to be sure it is off */
+	write_csr(dd, dd->params->cce_int_clear_reg + reg, bit);
+	/* force the above write on the chip */
+	read_csr(dd, dd->params->cce_int_clear_reg + reg);
+
+	write_csr(dd, dd->params->cce_int_force_reg + reg, bit);
+}
+
+/*
+ * Clear the receive interrupt.  Use a read of the interrupt clear CSR
+ * to insure that the write completed.  This does NOT guarantee that
+ * queued DMA writes to memory from the chip are pushed.
+ */
+static inline void clear_recv_intr(struct hfi2_ctxtdata *rcd)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+	u32 addr = dd->params->cce_int_clear_reg + (8 * rcd->ireg);
+
+	write_csr(dd, addr, rcd->imask);
+	/* force the above write on the chip and get a value back */
+	(void)read_csr(dd, addr);
+}
+
+/* force the receive interrupt */
+void force_recv_intr(struct hfi2_ctxtdata *rcd)
+{
+	write_csr(rcd->dd, rcd->dd->params->cce_int_force_reg + (8 * rcd->ireg), rcd->imask);
+}
+
+/*
+ * Return the receive sequence from the given RHF.  This routine is intended
+ * to be called without a previously determined chip type, so it needs to
+ * check the chip type to correctly extract the RHF field.  Hence "slow".
+ */
+u32 slow_rhf_rcv_seq(struct hfi2_ctxtdata *rcd, u64 rhf)
+{
+	if (rcd->dd->params->chip_type == CHIP_WFR)
+		return wfr_rhf_rcv_seq(rhf);
+	return jkr_rhf_rcv_seq(rhf);
+}
+
+static bool hfi2_packet_present(struct hfi2_ctxtdata *rcd)
+{
+	if (likely(!rcd->rcvhdrtail_kvaddr)) {
+		u32 seq = slow_rhf_rcv_seq(rcd, rhf_to_cpu(get_rhf_addr(rcd)));
+
+		return !last_rcv_seq(rcd, seq);
+	}
+	return hfi2_rcd_head(rcd) != get_rcvhdrtail(rcd);
+}
+
+/*
+ * Return non-zero if a packet is present.
+ *
+ * This routine is called when rechecking for packets after the RcvAvail
+ * interrupt has been cleared down.  First, do a quick check of memory for
+ * a packet present.  If not found, use an expensive CSR read of the context
+ * tail to determine the actual tail.  The CSR read is necessary because there
+ * is no method to push pending DMAs to memory other than an interrupt and we
+ * are trying to determine if we need to force an interrupt.
+ */
+static inline int check_packet_present(struct hfi2_ctxtdata *rcd)
+{
+	u32 tail;
+
+	if (hfi2_packet_present(rcd))
+		return 1;
+
+	/* fall back to a CSR read, correct indpendent of DMA_RTAIL */
+	tail = (u32)read_uctxt_csr(rcd->dd, rcd->ctxt, rcd->dd->params->rcv_hdr_tail_reg);
+	return hfi2_rcd_head(rcd) != tail;
+}
+
+/*
+ * Common code for receive contexts interrupt handlers.
+ * Update traces, increment kernel IRQ counter and
+ * setup ASPM when needed.
+ */
+static void receive_interrupt_common(struct hfi2_ctxtdata *rcd)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+
+	trace_hfi2_receive_interrupt(dd, rcd);
+	this_cpu_inc(*dd->int_counter);
+	aspm_ctx_disable(rcd);
+}
+
+/*
+ * __hfi2_rcd_eoi_intr() - Make HW issue receive interrupt
+ * when there are packets present in the queue. When calling
+ * with interrupts enabled please use hfi2_rcd_eoi_intr.
+ *
+ * @rcd: valid receive context
+ */
+static void __hfi2_rcd_eoi_intr(struct hfi2_ctxtdata *rcd)
+{
+	if (!rcd->rcvhdrq)
+		return;
+	clear_recv_intr(rcd);
+	if (check_packet_present(rcd))
+		force_recv_intr(rcd);
+}
+
+/**
+ * hfi2_rcd_eoi_intr() - End of Interrupt processing action
+ *
+ * @rcd: Ptr to hfi2_ctxtdata of receive context
+ *
+ *  Hold IRQs so we can safely clear the interrupt and
+ *  recheck for a packet that may have arrived after the previous
+ *  check and the interrupt clear.  If a packet arrived, force another
+ *  interrupt. This routine can be called at the end of receive packet
+ *  processing in interrupt service routines, interrupt service thread
+ *  and softirqs
+ */
+static void hfi2_rcd_eoi_intr(struct hfi2_ctxtdata *rcd)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__hfi2_rcd_eoi_intr(rcd);
+	local_irq_restore(flags);
+}
+
+/**
+ * hfi2_netdev_rx_napi - napi poll function to move eoi inline
+ * @napi: pointer to napi object
+ * @budget: netdev budget
+ */
+int hfi2_netdev_rx_napi(struct napi_struct *napi, int budget)
+{
+	struct hfi2_netdev_rxq *rxq = container_of(napi,
+			struct hfi2_netdev_rxq, napi);
+	struct hfi2_ctxtdata *rcd = rxq->rcd;
+	int work_done = 0;
+
+	work_done = rcd->do_interrupt(rcd, budget);
+
+	if (work_done < budget) {
+		napi_complete_done(napi, work_done);
+		hfi2_rcd_eoi_intr(rcd);
+	}
+
+	return work_done;
+}
+
+/* Receive packet napi handler for netdevs AIP  */
+irqreturn_t receive_context_interrupt_napi(int irq, void *data)
+{
+	struct hfi2_ctxtdata *rcd = data;
+
+	receive_interrupt_common(rcd);
+
+	if (likely(rcd->napi)) {
+		if (likely(napi_schedule_prep(rcd->napi)))
+			__napi_schedule_irqoff(rcd->napi);
+		else
+			__hfi2_rcd_eoi_intr(rcd);
+	} else {
+		WARN_ONCE(1, "Napi IRQ handler without napi set up ctxt=%d\n",
+			  rcd->ctxt);
+		__hfi2_rcd_eoi_intr(rcd);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Receive packet IRQ handler.  This routine expects to be on its own IRQ.
+ * This routine will try to handle packets immediately (latency), but if
+ * it finds too many, it will invoke the thread handler (bandwitdh).  The
+ * chip receive interrupt is *not* cleared down until this or the thread (if
+ * invoked) is finished.  The intent is to avoid extra interrupts while we
+ * are processing packets anyway.
+ */
+irqreturn_t receive_context_interrupt(int irq, void *data)
+{
+	struct hfi2_ctxtdata *rcd = data;
+	int disposition;
+
+	receive_interrupt_common(rcd);
+
+	/* receive interrupt remains blocked while processing packets */
+	disposition = rcd->do_interrupt(rcd, 0);
+
+	/*
+	 * Too many packets were seen while processing packets in this
+	 * IRQ handler.  Invoke the handler thread.  The receive interrupt
+	 * remains blocked.
+	 */
+	if (disposition == RCV_PKT_LIMIT)
+		return IRQ_WAKE_THREAD;
+
+	__hfi2_rcd_eoi_intr(rcd);
+	return IRQ_HANDLED;
+}
+
+/*
+ * Receive packet thread handler.  This expects to be invoked with the
+ * receive interrupt still blocked.
+ */
+irqreturn_t receive_context_thread(int irq, void *data)
+{
+	struct hfi2_ctxtdata *rcd = data;
+
+	/* receive interrupt is still blocked from the IRQ handler */
+	(void)rcd->do_interrupt(rcd, 1);
+
+	hfi2_rcd_eoi_intr(rcd);
+
+	return IRQ_HANDLED;
+}
+
+/* ========================================================================= */
+
+u32 read_physical_state(struct hfi2_devdata *dd)
+{
+	u64 reg;
+
+	reg = read_csr(dd, DC_DC8051_STS_CUR_STATE);
+	return (reg >> DC_DC8051_STS_CUR_STATE_PORT_SHIFT)
+				& DC_DC8051_STS_CUR_STATE_PORT_MASK;
+}
+
+u32 read_logical_state(struct hfi2_devdata *dd)
+{
+	u64 reg;
+
+	reg = read_csr(dd, DCC_CFG_PORT_CONFIG);
+	return (reg >> DCC_CFG_PORT_CONFIG_LINK_STATE_SHIFT)
+				& DCC_CFG_PORT_CONFIG_LINK_STATE_MASK;
+}
+
+static void set_logical_state(struct hfi2_devdata *dd, u32 chip_lstate)
+{
+	u64 reg;
+
+	reg = read_csr(dd, DCC_CFG_PORT_CONFIG);
+	/* clear current state, set new state */
+	reg &= ~DCC_CFG_PORT_CONFIG_LINK_STATE_SMASK;
+	reg |= (u64)chip_lstate << DCC_CFG_PORT_CONFIG_LINK_STATE_SHIFT;
+	write_csr(dd, DCC_CFG_PORT_CONFIG, reg);
+}
+
+/*
+ * Use the 8051 to read a LCB CSR.
+ */
+static int read_lcb_via_8051(struct hfi2_devdata *dd, u32 addr, u64 *data)
+{
+	u32 regno;
+	int ret;
+
+	/* register is an index of LCB registers: (offset - base) / 8 */
+	regno = (addr - DC_LCB_CFG_RUN) >> 3;
+	ret = do_8051_command(dd, HCMD_READ_LCB_CSR, regno, data);
+	if (ret != HCMD_SUCCESS)
+		return -EBUSY;
+	return 0;
+}
+
+/*
+ * Provide a cache for some of the LCB registers in case the LCB is
+ * unavailable.
+ * (The LCB is unavailable in certain link states, for example.)
+ */
+struct lcb_datum {
+	u32 off;
+	u64 val;
+};
+
+static struct lcb_datum lcb_cache[] = {
+	{ DC_LCB_ERR_INFO_RX_REPLAY_CNT, 0},
+	{ DC_LCB_ERR_INFO_SEQ_CRC_CNT, 0 },
+	{ DC_LCB_ERR_INFO_REINIT_FROM_PEER_CNT, 0 },
+};
+
+static void update_lcb_cache(struct hfi2_pportdata *ppd)
+{
+	int i;
+	int ret;
+	u64 val;
+
+	for (i = 0; i < ARRAY_SIZE(lcb_cache); i++) {
+		ret = read_lcb_csr(ppd, lcb_cache[i].off, &val);
+
+		/* Update if we get good data */
+		if (likely(ret != -EBUSY))
+			lcb_cache[i].val = val;
+	}
+}
+
+static int read_lcb_cache(u32 off, u64 *val)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(lcb_cache); i++) {
+		if (lcb_cache[i].off == off) {
+			*val = lcb_cache[i].val;
+			return 0;
+		}
+	}
+
+	pr_warn("%s bad offset 0x%x\n", __func__, off);
+	return -1;
+}
+
+/*
+ * Read an LCB CSR.  Access may not be in host control, so check.
+ * Return 0 on success, -EBUSY on failure.
+ */
+int read_lcb_csr(struct hfi2_pportdata *ppd, u32 addr, u64 *data)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+
+	/* if up, go through the 8051 for the value */
+	if (ppd->host_link_state & HLS_UP)
+		return read_lcb_via_8051(dd, addr, data);
+	/* if going up or down, check the cache, otherwise, no access */
+	if (ppd->host_link_state & (HLS_GOING_UP | HLS_GOING_OFFLINE)) {
+		if (read_lcb_cache(addr, data))
+			return -EBUSY;
+		return 0;
+	}
+
+	/* otherwise, host has access */
+	*data = read_csr(dd, addr);
+	return 0;
+}
+
+/*
+ * Use the 8051 to write a LCB CSR.
+ */
+static int write_lcb_via_8051(struct hfi2_devdata *dd, u32 addr, u64 data)
+{
+	u32 regno;
+	int ret;
+
+	/* register is an index of LCB registers: (offset - base) / 8 */
+	regno = (addr - DC_LCB_CFG_RUN) >> 3;
+	ret = do_8051_command(dd, HCMD_WRITE_LCB_CSR, regno, &data);
+	if (ret != HCMD_SUCCESS)
+		return -EBUSY;
+	return 0;
+}
+
+/*
+ * Write an LCB CSR.  Access may not be in host control, so check.
+ * Return 0 on success, -EBUSY on failure.
+ */
+int write_lcb_csr(struct hfi2_pportdata *ppd, u32 addr, u64 data)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+
+	/* if up, go through the 8051 for the value */
+	if (ppd->host_link_state & HLS_UP)
+		return write_lcb_via_8051(dd, addr, data);
+	/* if going up or down, no access */
+	if (ppd->host_link_state & (HLS_GOING_UP | HLS_GOING_OFFLINE))
+		return -EBUSY;
+	/* otherwise, host has access */
+	write_csr(dd, addr, data);
+	return 0;
+}
+
+/*
+ * Returns:
+ *	< 0 = Linux error, not able to get access
+ *	> 0 = 8051 command RETURN_CODE
+ */
+static int do_8051_command(struct hfi2_devdata *dd, u32 type, u64 in_data,
+			   u64 *out_data)
+{
+	u64 reg, completed;
+	int return_code;
+	unsigned long timeout;
+
+	hfi2_cdbg(DC8051, "type %d, data 0x%012llx", type, in_data);
+
+	mutex_lock(&dd->dc8051_lock);
+
+	/* We can't send any commands to the 8051 if it's in reset */
+	if (dd->dc_shutdown) {
+		return_code = -ENODEV;
+		goto fail;
+	}
+
+	/*
+	 * If an 8051 host command timed out previously, then the 8051 is
+	 * stuck.
+	 *
+	 * On first timeout, attempt to reset and restart the entire DC
+	 * block (including 8051). (Is this too big of a hammer?)
+	 *
+	 * If the 8051 times out a second time, the reset did not bring it
+	 * back to healthy life. In that case, fail any subsequent commands.
+	 */
+	if (dd->dc8051_timed_out) {
+		if (dd->dc8051_timed_out > 1) {
+			dd_dev_err(dd,
+				   "Previous 8051 host command timed out, skipping command %u\n",
+				   type);
+			return_code = -ENXIO;
+			goto fail;
+		}
+		_dc_shutdown(dd);
+		_dc_start(dd);
+	}
+
+	/*
+	 * If there is no timeout, then the 8051 command interface is
+	 * waiting for a command.
+	 */
+
+	/*
+	 * When writing a LCB CSR, out_data contains the full value to
+	 * be written, while in_data contains the relative LCB
+	 * address in 7:0.  Do the work here, rather than the caller,
+	 * of distrubting the write data to where it needs to go:
+	 *
+	 * Write data
+	 *   39:00 -> in_data[47:8]
+	 *   47:40 -> DC8051_CFG_EXT_DEV_0.RETURN_CODE
+	 *   63:48 -> DC8051_CFG_EXT_DEV_0.RSP_DATA
+	 */
+	if (type == HCMD_WRITE_LCB_CSR) {
+		in_data |= ((*out_data) & 0xffffffffffull) << 8;
+		/* must preserve COMPLETED - it is tied to hardware */
+		reg = read_csr(dd, DC_DC8051_CFG_EXT_DEV_0);
+		reg &= DC_DC8051_CFG_EXT_DEV_0_COMPLETED_SMASK;
+		reg |= ((((*out_data) >> 40) & 0xff) <<
+				DC_DC8051_CFG_EXT_DEV_0_RETURN_CODE_SHIFT)
+		      | ((((*out_data) >> 48) & 0xffff) <<
+				DC_DC8051_CFG_EXT_DEV_0_RSP_DATA_SHIFT);
+		write_csr(dd, DC_DC8051_CFG_EXT_DEV_0, reg);
+	}
+
+	/*
+	 * Do two writes: the first to stabilize the type and req_data, the
+	 * second to activate.
+	 */
+	reg = ((u64)type & DC_DC8051_CFG_HOST_CMD_0_REQ_TYPE_MASK)
+			<< DC_DC8051_CFG_HOST_CMD_0_REQ_TYPE_SHIFT
+		| (in_data & DC_DC8051_CFG_HOST_CMD_0_REQ_DATA_MASK)
+			<< DC_DC8051_CFG_HOST_CMD_0_REQ_DATA_SHIFT;
+	write_csr(dd, DC_DC8051_CFG_HOST_CMD_0, reg);
+	reg |= DC_DC8051_CFG_HOST_CMD_0_REQ_NEW_SMASK;
+	write_csr(dd, DC_DC8051_CFG_HOST_CMD_0, reg);
+
+	/* wait for completion, alternate: interrupt */
+	timeout = jiffies + msecs_to_jiffies(DC8051_COMMAND_TIMEOUT);
+	while (1) {
+		reg = read_csr(dd, DC_DC8051_CFG_HOST_CMD_1);
+		completed = reg & DC_DC8051_CFG_HOST_CMD_1_COMPLETED_SMASK;
+		if (completed)
+			break;
+		if (time_after(jiffies, timeout)) {
+			dd->dc8051_timed_out++;
+			dd_dev_err(dd, "8051 host command %u timeout\n", type);
+			if (out_data)
+				*out_data = 0;
+			return_code = -ETIMEDOUT;
+			goto fail;
+		}
+		udelay(2);
+	}
+
+	if (out_data) {
+		*out_data = (reg >> DC_DC8051_CFG_HOST_CMD_1_RSP_DATA_SHIFT)
+				& DC_DC8051_CFG_HOST_CMD_1_RSP_DATA_MASK;
+		if (type == HCMD_READ_LCB_CSR) {
+			/* top 16 bits are in a different register */
+			*out_data |= (read_csr(dd, DC_DC8051_CFG_EXT_DEV_1)
+				& DC_DC8051_CFG_EXT_DEV_1_REQ_DATA_SMASK)
+				<< (48
+				    - DC_DC8051_CFG_EXT_DEV_1_REQ_DATA_SHIFT);
+		}
+	}
+	return_code = (reg >> DC_DC8051_CFG_HOST_CMD_1_RETURN_CODE_SHIFT)
+				& DC_DC8051_CFG_HOST_CMD_1_RETURN_CODE_MASK;
+	dd->dc8051_timed_out = 0;
+	/*
+	 * Clear command for next user.
+	 */
+	write_csr(dd, DC_DC8051_CFG_HOST_CMD_0, 0);
+
+fail:
+	mutex_unlock(&dd->dc8051_lock);
+	return return_code;
+}
+
+static int set_physical_link_state(struct hfi2_devdata *dd, u64 state)
+{
+	return do_8051_command(dd, HCMD_CHANGE_PHY_STATE, state, NULL);
+}
+
+int load_8051_config(struct hfi2_devdata *dd, u8 field_id,
+		     u8 lane_id, u32 config_data)
+{
+	u64 data;
+	int ret;
+
+	data = (u64)field_id << LOAD_DATA_FIELD_ID_SHIFT
+		| (u64)lane_id << LOAD_DATA_LANE_ID_SHIFT
+		| (u64)config_data << LOAD_DATA_DATA_SHIFT;
+	ret = do_8051_command(dd, HCMD_LOAD_CONFIG_DATA, data, NULL);
+	if (ret != HCMD_SUCCESS) {
+		dd_dev_err(dd,
+			   "load 8051 config: field id %d, lane %d, err %d\n",
+			   (int)field_id, (int)lane_id, ret);
+	}
+	return ret;
+}
+
+/*
+ * Read the 8051 firmware "registers".  Use the RAM directly.  Always
+ * set the result, even on error.
+ * Return 0 on success, -errno on failure
+ */
+int read_8051_config(struct hfi2_devdata *dd, u8 field_id, u8 lane_id,
+		     u32 *result)
+{
+	u64 big_data;
+	u32 addr;
+	int ret;
+
+	/* address start depends on the lane_id */
+	if (lane_id < 4)
+		addr = (4 * NUM_GENERAL_FIELDS)
+			+ (lane_id * 4 * NUM_LANE_FIELDS);
+	else
+		addr = 0;
+	addr += field_id * 4;
+
+	/* read is in 8-byte chunks, hardware will truncate the address down */
+	ret = read_8051_data(dd, addr, 8, &big_data);
+
+	if (ret == 0) {
+		/* extract the 4 bytes we want */
+		if (addr & 0x4)
+			*result = (u32)(big_data >> 32);
+		else
+			*result = (u32)big_data;
+	} else {
+		*result = 0;
+		dd_dev_err(dd, "%s: direct read failed, lane %d, field %d!\n",
+			   __func__, lane_id, field_id);
+	}
+
+	return ret;
+}
+
+static int write_vc_local_phy(struct hfi2_devdata *dd, u8 power_management,
+			      u8 continuous)
+{
+	u32 frame;
+
+	frame = continuous << CONTINIOUS_REMOTE_UPDATE_SUPPORT_SHIFT
+		| power_management << POWER_MANAGEMENT_SHIFT;
+	return load_8051_config(dd, VERIFY_CAP_LOCAL_PHY,
+				GENERAL_CONFIG, frame);
+}
+
+static int write_vc_local_fabric(struct hfi2_devdata *dd, u8 vau, u8 z, u8 vcu,
+				 u16 vl15buf, u8 crc_sizes)
+{
+	u32 frame;
+
+	frame = (u32)vau << VAU_SHIFT
+		| (u32)z << Z_SHIFT
+		| (u32)vcu << VCU_SHIFT
+		| (u32)vl15buf << VL15BUF_SHIFT
+		| (u32)crc_sizes << CRC_SIZES_SHIFT;
+	return load_8051_config(dd, VERIFY_CAP_LOCAL_FABRIC,
+				GENERAL_CONFIG, frame);
+}
+
+static void read_vc_local_link_mode(struct hfi2_devdata *dd, u8 *misc_bits,
+				    u8 *flag_bits, u16 *link_widths)
+{
+	u32 frame;
+
+	read_8051_config(dd, VERIFY_CAP_LOCAL_LINK_MODE, GENERAL_CONFIG,
+			 &frame);
+	*misc_bits = (frame >> MISC_CONFIG_BITS_SHIFT) & MISC_CONFIG_BITS_MASK;
+	*flag_bits = (frame >> LOCAL_FLAG_BITS_SHIFT) & LOCAL_FLAG_BITS_MASK;
+	*link_widths = (frame >> LINK_WIDTH_SHIFT) & LINK_WIDTH_MASK;
+}
+
+static int write_vc_local_link_mode(struct hfi2_devdata *dd,
+				    u8 misc_bits,
+				    u8 flag_bits,
+				    u16 link_widths)
+{
+	u32 frame;
+
+	frame = (u32)misc_bits << MISC_CONFIG_BITS_SHIFT
+		| (u32)flag_bits << LOCAL_FLAG_BITS_SHIFT
+		| (u32)link_widths << LINK_WIDTH_SHIFT;
+	return load_8051_config(dd, VERIFY_CAP_LOCAL_LINK_MODE, GENERAL_CONFIG,
+		     frame);
+}
+
+static int write_local_device_id(struct hfi2_devdata *dd, u16 device_id,
+				 u8 device_rev)
+{
+	u32 frame;
+
+	frame = ((u32)device_id << LOCAL_DEVICE_ID_SHIFT)
+		| ((u32)device_rev << LOCAL_DEVICE_REV_SHIFT);
+	return load_8051_config(dd, LOCAL_DEVICE_ID, GENERAL_CONFIG, frame);
+}
+
+static void read_remote_device_id(struct hfi2_devdata *dd, u16 *device_id,
+				  u8 *device_rev)
+{
+	u32 frame;
+
+	read_8051_config(dd, REMOTE_DEVICE_ID, GENERAL_CONFIG, &frame);
+	*device_id = (frame >> REMOTE_DEVICE_ID_SHIFT) & REMOTE_DEVICE_ID_MASK;
+	*device_rev = (frame >> REMOTE_DEVICE_REV_SHIFT)
+			& REMOTE_DEVICE_REV_MASK;
+}
+
+int write_host_interface_version(struct hfi2_devdata *dd, u8 version)
+{
+	u32 frame;
+	u32 mask;
+
+	mask = (HOST_INTERFACE_VERSION_MASK << HOST_INTERFACE_VERSION_SHIFT);
+	read_8051_config(dd, RESERVED_REGISTERS, GENERAL_CONFIG, &frame);
+	/* Clear, then set field */
+	frame &= ~mask;
+	frame |= ((u32)version << HOST_INTERFACE_VERSION_SHIFT);
+	return load_8051_config(dd, RESERVED_REGISTERS, GENERAL_CONFIG,
+				frame);
+}
+
+void read_misc_status(struct hfi2_devdata *dd, u8 *ver_major, u8 *ver_minor,
+		      u8 *ver_patch)
+{
+	u32 frame;
+
+	read_8051_config(dd, MISC_STATUS, GENERAL_CONFIG, &frame);
+	*ver_major = (frame >> STS_FM_VERSION_MAJOR_SHIFT) &
+		STS_FM_VERSION_MAJOR_MASK;
+	*ver_minor = (frame >> STS_FM_VERSION_MINOR_SHIFT) &
+		STS_FM_VERSION_MINOR_MASK;
+
+	read_8051_config(dd, VERSION_PATCH, GENERAL_CONFIG, &frame);
+	*ver_patch = (frame >> STS_FM_VERSION_PATCH_SHIFT) &
+		STS_FM_VERSION_PATCH_MASK;
+}
+
+static void read_vc_remote_phy(struct hfi2_devdata *dd, u8 *power_management,
+			       u8 *continuous)
+{
+	u32 frame;
+
+	read_8051_config(dd, VERIFY_CAP_REMOTE_PHY, GENERAL_CONFIG, &frame);
+	*power_management = (frame >> POWER_MANAGEMENT_SHIFT)
+					& POWER_MANAGEMENT_MASK;
+	*continuous = (frame >> CONTINIOUS_REMOTE_UPDATE_SUPPORT_SHIFT)
+					& CONTINIOUS_REMOTE_UPDATE_SUPPORT_MASK;
+}
+
+static void read_vc_remote_fabric(struct hfi2_devdata *dd, u8 *vau, u8 *z,
+				  u8 *vcu, u16 *vl15buf, u8 *crc_sizes)
+{
+	u32 frame;
+
+	read_8051_config(dd, VERIFY_CAP_REMOTE_FABRIC, GENERAL_CONFIG, &frame);
+	*vau = (frame >> VAU_SHIFT) & VAU_MASK;
+	*z = (frame >> Z_SHIFT) & Z_MASK;
+	*vcu = (frame >> VCU_SHIFT) & VCU_MASK;
+	*vl15buf = (frame >> VL15BUF_SHIFT) & VL15BUF_MASK;
+	*crc_sizes = (frame >> CRC_SIZES_SHIFT) & CRC_SIZES_MASK;
+}
+
+static void read_vc_remote_link_width(struct hfi2_devdata *dd,
+				      u8 *remote_tx_rate,
+				      u16 *link_widths)
+{
+	u32 frame;
+
+	read_8051_config(dd, VERIFY_CAP_REMOTE_LINK_WIDTH, GENERAL_CONFIG,
+			 &frame);
+	*remote_tx_rate = (frame >> REMOTE_TX_RATE_SHIFT)
+				& REMOTE_TX_RATE_MASK;
+	*link_widths = (frame >> LINK_WIDTH_SHIFT) & LINK_WIDTH_MASK;
+}
+
+static void read_local_lni(struct hfi2_devdata *dd, u8 *enable_lane_rx)
+{
+	u32 frame;
+
+	read_8051_config(dd, LOCAL_LNI_INFO, GENERAL_CONFIG, &frame);
+	*enable_lane_rx = (frame >> ENABLE_LANE_RX_SHIFT) & ENABLE_LANE_RX_MASK;
+}
+
+static void read_last_local_state(struct hfi2_devdata *dd, u32 *lls)
+{
+	read_8051_config(dd, LAST_LOCAL_STATE_COMPLETE, GENERAL_CONFIG, lls);
+}
+
+static void read_last_remote_state(struct hfi2_devdata *dd, u32 *lrs)
+{
+	read_8051_config(dd, LAST_REMOTE_STATE_COMPLETE, GENERAL_CONFIG, lrs);
+}
+
+void wfr_read_link_quality(struct hfi2_pportdata *ppd, u8 *link_quality)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 frame;
+	int ret;
+
+	*link_quality = 0;
+	if (ppd->host_link_state & HLS_UP) {
+		ret = read_8051_config(dd, LINK_QUALITY_INFO, GENERAL_CONFIG,
+				       &frame);
+		if (ret == 0)
+			*link_quality = (frame >> LINK_QUALITY_SHIFT)
+						& LINK_QUALITY_MASK;
+	}
+}
+
+static void read_planned_down_reason_code(struct hfi2_devdata *dd, u8 *pdrrc)
+{
+	u32 frame;
+
+	read_8051_config(dd, LINK_QUALITY_INFO, GENERAL_CONFIG, &frame);
+	*pdrrc = (frame >> DOWN_REMOTE_REASON_SHIFT) & DOWN_REMOTE_REASON_MASK;
+}
+
+static void read_link_down_reason(struct hfi2_devdata *dd, u8 *ldr)
+{
+	u32 frame;
+
+	read_8051_config(dd, LINK_DOWN_REASON, GENERAL_CONFIG, &frame);
+	*ldr = (frame & 0xff);
+}
+
+static int read_tx_settings(struct hfi2_devdata *dd,
+			    u8 *enable_lane_tx,
+			    u8 *tx_polarity_inversion,
+			    u8 *rx_polarity_inversion,
+			    u8 *max_rate)
+{
+	u32 frame;
+	int ret;
+
+	ret = read_8051_config(dd, TX_SETTINGS, GENERAL_CONFIG, &frame);
+	*enable_lane_tx = (frame >> ENABLE_LANE_TX_SHIFT)
+				& ENABLE_LANE_TX_MASK;
+	*tx_polarity_inversion = (frame >> TX_POLARITY_INVERSION_SHIFT)
+				& TX_POLARITY_INVERSION_MASK;
+	*rx_polarity_inversion = (frame >> RX_POLARITY_INVERSION_SHIFT)
+				& RX_POLARITY_INVERSION_MASK;
+	*max_rate = (frame >> MAX_RATE_SHIFT) & MAX_RATE_MASK;
+	return ret;
+}
+
+static int write_tx_settings(struct hfi2_devdata *dd,
+			     u8 enable_lane_tx,
+			     u8 tx_polarity_inversion,
+			     u8 rx_polarity_inversion,
+			     u8 max_rate)
+{
+	u32 frame;
+
+	/* no need to mask, all variable sizes match field widths */
+	frame = enable_lane_tx << ENABLE_LANE_TX_SHIFT
+		| tx_polarity_inversion << TX_POLARITY_INVERSION_SHIFT
+		| rx_polarity_inversion << RX_POLARITY_INVERSION_SHIFT
+		| max_rate << MAX_RATE_SHIFT;
+	return load_8051_config(dd, TX_SETTINGS, GENERAL_CONFIG, frame);
+}
+
+/*
+ * Read an idle LCB message.
+ *
+ * Returns 0 on success, -EINVAL on error
+ */
+static int read_idle_message(struct hfi2_devdata *dd, u64 type, u64 *data_out)
+{
+	int ret;
+
+	ret = do_8051_command(dd, HCMD_READ_LCB_IDLE_MSG, type, data_out);
+	if (ret != HCMD_SUCCESS) {
+		dd_dev_err(dd, "read idle message: type %d, err %d\n",
+			   (u32)type, ret);
+		return -EINVAL;
+	}
+	dd_dev_info(dd, "%s: read idle message 0x%llx\n", __func__, *data_out);
+	/* return only the payload as we already know the type */
+	*data_out >>= IDLE_PAYLOAD_SHIFT;
+	return 0;
+}
+
+/*
+ * Read an idle SMA message.  To be done in response to a notification from
+ * the 8051.
+ *
+ * Returns 0 on success, -EINVAL on error
+ */
+static int read_idle_sma(struct hfi2_devdata *dd, u64 *data)
+{
+	return read_idle_message(dd, (u64)IDLE_SMA << IDLE_MSG_TYPE_SHIFT,
+				 data);
+}
+
+/*
+ * Send an idle LCB message.
+ *
+ * Returns 0 on success, -EINVAL on error
+ */
+static int send_idle_message(struct hfi2_devdata *dd, u64 data)
+{
+	int ret;
+
+	dd_dev_info(dd, "%s: sending idle message 0x%llx\n", __func__, data);
+	ret = do_8051_command(dd, HCMD_SEND_LCB_IDLE_MSG, data, NULL);
+	if (ret != HCMD_SUCCESS) {
+		dd_dev_err(dd, "send idle message: data 0x%llx, err %d\n",
+			   data, ret);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * Send an idle SMA message.
+ *
+ * Returns 0 on success, -EINVAL on error
+ */
+int send_idle_sma(struct hfi2_devdata *dd, u64 message)
+{
+	u64 data;
+
+	data = ((message & IDLE_PAYLOAD_MASK) << IDLE_PAYLOAD_SHIFT) |
+		((u64)IDLE_SMA << IDLE_MSG_TYPE_SHIFT);
+	return send_idle_message(dd, data);
+}
+
+/*
+ * Initialize the LCB then do a quick link up.  This may or may not be
+ * in loopback.
+ *
+ * return 0 on success, -errno on error
+ */
+static int do_quick_linkup(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	lcb_shutdown(dd, 0);
+
+	if (loopback) {
+		/* LCB_CFG_LOOPBACK.VAL = 2 */
+		/* LCB_CFG_LANE_WIDTH.VAL = 0 */
+		write_csr(dd, DC_LCB_CFG_LOOPBACK,
+			  2ull << DC_LCB_CFG_LOOPBACK_VAL_SHIFT);
+		write_csr(dd, DC_LCB_CFG_LANE_WIDTH, 0);
+	}
+
+	/* start the LCBs */
+	/* LCB_CFG_TX_FIFOS_RESET.VAL = 0 */
+	write_csr(dd, DC_LCB_CFG_TX_FIFOS_RESET, 0);
+
+	if (!loopback) {
+		/*
+		 * When doing quick linkup and not in loopback, both
+		 * sides must be done with LCB set-up before either
+		 * starts the quick linkup.  Put a delay here so that
+		 * both sides can be started and have a chance to be
+		 * done with LCB set up before resuming.
+		 */
+		dd_dev_err(dd,
+			   "Pausing for peer to be finished with LCB set up\n");
+		msleep(5000);
+		dd_dev_err(dd, "Continuing with quick linkup\n");
+	}
+
+	write_csr(dd, DC_LCB_ERR_EN, 0); /* mask LCB errors */
+	set_8051_lcb_access(dd);
+
+	/*
+	 * State "quick" LinkUp request sets the physical link state to
+	 * LinkUp without a verify capability sequence.
+	 * This state is in simulator v37 and later.
+	 */
+	ret = set_physical_link_state(dd, PLS_QUICK_LINKUP);
+	if (ret != HCMD_SUCCESS) {
+		dd_dev_err(dd,
+			   "%s: set physical link state to quick LinkUp failed with return %d\n",
+			   __func__, ret);
+
+		set_host_lcb_access(dd);
+		write_csr(dd, DC_LCB_ERR_EN, ~0ull); /* watch LCB errors */
+
+		if (ret >= 0)
+			ret = -EINVAL;
+		return ret;
+	}
+
+	return 0; /* success */
+}
+
+/*
+ * Do all special steps to set up loopback.
+ */
+static int init_loopback(struct hfi2_devdata *dd)
+{
+	dd_dev_info(dd, "Entering loopback mode\n");
+
+	/* all loopbacks should disable self GUID check */
+	write_csr(dd, DC_DC8051_CFG_MODE,
+		  (read_csr(dd, DC_DC8051_CFG_MODE) | DISABLE_SELF_GUID_CHECK));
+
+	/*
+	 * The simulator has only one loopback option - LCB.  Switch
+	 * to that option, which includes quick link up.
+	 *
+	 * Accept all valid loopback values.
+	 */
+	if ((dd->icode == ICODE_FUNCTIONAL_SIMULATOR) &&
+	    (loopback == LOOPBACK_SERDES || loopback == LOOPBACK_LCB ||
+	     loopback == LOOPBACK_CABLE)) {
+		loopback = LOOPBACK_LCB;
+		quick_linkup = 1;
+		return 0;
+	}
+
+	/*
+	 * SerDes loopback init sequence is handled in set_local_link_attributes
+	 */
+	if (loopback == LOOPBACK_SERDES)
+		return 0;
+
+	/* LCB loopback - handled at poll time */
+	if (loopback == LOOPBACK_LCB) {
+		quick_linkup = 1; /* LCB is always quick linkup */
+		return 0;
+	}
+
+	/* external cable loopback requires no extra steps */
+	if (loopback == LOOPBACK_CABLE)
+		return 0;
+
+	dd_dev_err(dd, "Invalid loopback mode %d\n", loopback);
+	return -EINVAL;
+}
+
+/*
+ * Translate from the OPA_LINK_WIDTH handed to us by the FM to bits
+ * used in the Verify Capability link width attribute.
+ */
+static u16 opa_to_vc_link_widths(u16 opa_widths)
+{
+	int i;
+	u16 result = 0;
+
+	static const struct link_bits {
+		u16 from;
+		u16 to;
+	} opa_link_xlate[] = {
+		{ OPA_LINK_WIDTH_1X, 1 << (1 - 1)  },
+		{ OPA_LINK_WIDTH_2X, 1 << (2 - 1)  },
+		{ OPA_LINK_WIDTH_3X, 1 << (3 - 1)  },
+		{ OPA_LINK_WIDTH_4X, 1 << (4 - 1)  },
+	};
+
+	for (i = 0; i < ARRAY_SIZE(opa_link_xlate); i++) {
+		if (opa_widths & opa_link_xlate[i].from)
+			result |= opa_link_xlate[i].to;
+	}
+	return result;
+}
+
+/*
+ * Set link attributes before moving to polling.
+ */
+static int set_local_link_attributes(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u8 enable_lane_tx;
+	u8 tx_polarity_inversion;
+	u8 rx_polarity_inversion;
+	int ret;
+	u32 misc_bits = 0;
+	/* reset our fabric serdes to clear any lingering problems */
+	fabric_serdes_reset(dd);
+
+	/* set the local tx rate - need to read-modify-write */
+	ret = read_tx_settings(dd, &enable_lane_tx, &tx_polarity_inversion,
+			       &rx_polarity_inversion, &ppd->local_tx_rate);
+	if (ret)
+		goto set_local_link_attributes_fail;
+
+	if (dd->dc8051_ver < dc8051_ver(0, 20, 0)) {
+		/* set the tx rate to the fastest enabled */
+		if (ppd->link_speed_enabled & OPA_LINK_SPEED_25G)
+			ppd->local_tx_rate = 1;
+		else
+			ppd->local_tx_rate = 0;
+	} else {
+		/* set the tx rate to all enabled */
+		ppd->local_tx_rate = 0;
+		if (ppd->link_speed_enabled & OPA_LINK_SPEED_25G)
+			ppd->local_tx_rate |= 2;
+		if (ppd->link_speed_enabled & OPA_LINK_SPEED_12_5G)
+			ppd->local_tx_rate |= 1;
+	}
+
+	enable_lane_tx = 0xF; /* enable all four lanes */
+	ret = write_tx_settings(dd, enable_lane_tx, tx_polarity_inversion,
+				rx_polarity_inversion, ppd->local_tx_rate);
+	if (ret != HCMD_SUCCESS)
+		goto set_local_link_attributes_fail;
+
+	ret = write_host_interface_version(dd, HOST_INTERFACE_VERSION);
+	if (ret != HCMD_SUCCESS) {
+		ppd_dev_err(ppd,
+			    "Failed to set host interface version, return 0x%x\n",
+			    ret);
+		goto set_local_link_attributes_fail;
+	}
+
+	/*
+	 * DC supports continuous updates.
+	 */
+	ret = write_vc_local_phy(dd,
+				 0 /* no power management */,
+				 1 /* continuous updates */);
+	if (ret != HCMD_SUCCESS)
+		goto set_local_link_attributes_fail;
+
+	/* z=1 in the next call: AU of 0 is not supported by the hardware */
+	ret = write_vc_local_fabric(dd, dd->vau, 1, dd->vcu, dd->vl15_init,
+				    ppd->port_crc_mode_enabled);
+	if (ret != HCMD_SUCCESS)
+		goto set_local_link_attributes_fail;
+
+	/*
+	 * SerDes loopback init sequence requires
+	 * setting bit 0 of MISC_CONFIG_BITS
+	 */
+	if (loopback == LOOPBACK_SERDES)
+		misc_bits |= 1 << LOOPBACK_SERDES_CONFIG_BIT_MASK_SHIFT;
+
+	/*
+	 * An external device configuration request is used to reset the LCB
+	 * to retry to obtain operational lanes when the first attempt is
+	 * unsuccesful.
+	 */
+	if (dd->dc8051_ver >= dc8051_ver(1, 25, 0))
+		misc_bits |= 1 << EXT_CFG_LCB_RESET_SUPPORTED_SHIFT;
+
+	ret = write_vc_local_link_mode(dd, misc_bits, 0,
+				       opa_to_vc_link_widths(
+						ppd->link_width_enabled));
+	if (ret != HCMD_SUCCESS)
+		goto set_local_link_attributes_fail;
+
+	/* let peer know who we are */
+	ret = write_local_device_id(dd, dd->pcidev->device, dd->minrev);
+	if (ret == HCMD_SUCCESS)
+		return 0;
+
+set_local_link_attributes_fail:
+	ppd_dev_err(ppd,
+		    "Failed to set local link attributes, return 0x%x\n",
+		    ret);
+	return ret;
+}
+
+/*
+ * Call this to start the link.
+ * Do not do anything if the link is disabled.
+ * Returns 0 if link is disabled, moved to polling, or the driver is not ready.
+ */
+int start_link(struct hfi2_pportdata *ppd)
+{
+	/*
+	 * Tune the SerDes to a ballpark setting for optimal signal and bit
+	 * error rate.  Needs to be done before starting the link.
+	 */
+	tune_serdes(ppd);
+
+	if (!ppd->driver_link_ready) {
+		ppd_dev_info(ppd,
+			     "%s: stopping link start because driver is not ready\n",
+			     __func__);
+		return 0;
+	}
+
+	/*
+	 * FULL_MGMT_P_KEY is cleared from the pkey table, so that the
+	 * pkey table can be configured properly if the HFI unit is connected
+	 * to switch port with MgmtAllowed=NO
+	 */
+	clear_full_mgmt_pkey(ppd);
+
+	return set_link_state(ppd, HLS_DN_POLL);
+}
+
+static void wait_for_qsfp_init(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 mask;
+	unsigned long timeout;
+
+	/*
+	 * Some QSFP cables have a quirk that asserts the IntN line as a side
+	 * effect of power up on plug-in. We ignore this false positive
+	 * interrupt until the module has finished powering up by waiting for
+	 * a minimum timeout of the module inrush initialization time of
+	 * 500 ms (SFF 8679 Table 5-6) to ensure the voltage rails in the
+	 * module have stabilized.
+	 */
+	msleep(500);
+
+	/*
+	 * Check for QSFP interrupt for t_init (SFF 8679 Table 8-1)
+	 */
+	timeout = jiffies + msecs_to_jiffies(2000);
+	while (1) {
+		mask = read_csr(dd, dd->hfi2_id ?
+				ASIC_QSFP2_IN : ASIC_QSFP1_IN);
+		if (!(mask & QSFP_HFI0_INT_N))
+			break;
+		if (time_after(jiffies, timeout)) {
+			ppd_dev_info(ppd, "%s: No IntN detected, reset complete\n",
+				     __func__);
+			break;
+		}
+		udelay(2);
+	}
+}
+
+static void set_qsfp_int_n(struct hfi2_pportdata *ppd, u8 enable)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 mask;
+
+	mask = read_csr(dd, dd->hfi2_id ? ASIC_QSFP2_MASK : ASIC_QSFP1_MASK);
+	if (enable) {
+		/*
+		 * Clear the status register to avoid an immediate interrupt
+		 * when we re-enable the IntN pin
+		 */
+		write_csr(dd, dd->hfi2_id ? ASIC_QSFP2_CLEAR : ASIC_QSFP1_CLEAR,
+			  QSFP_HFI0_INT_N);
+		mask |= (u64)QSFP_HFI0_INT_N;
+	} else {
+		mask &= ~(u64)QSFP_HFI0_INT_N;
+	}
+	write_csr(dd, dd->hfi2_id ? ASIC_QSFP2_MASK : ASIC_QSFP1_MASK, mask);
+}
+
+int reset_qsfp(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 mask, qsfp_mask;
+
+	/* Disable INT_N from triggering QSFP interrupts */
+	set_qsfp_int_n(ppd, 0);
+
+	/* Reset the QSFP */
+	mask = (u64)QSFP_HFI0_RESET_N;
+
+	qsfp_mask = read_csr(dd,
+			     dd->hfi2_id ? ASIC_QSFP2_OUT : ASIC_QSFP1_OUT);
+	qsfp_mask &= ~mask;
+	write_csr(dd,
+		  dd->hfi2_id ? ASIC_QSFP2_OUT : ASIC_QSFP1_OUT, qsfp_mask);
+
+	udelay(10);
+
+	qsfp_mask |= mask;
+	write_csr(dd,
+		  dd->hfi2_id ? ASIC_QSFP2_OUT : ASIC_QSFP1_OUT, qsfp_mask);
+
+	wait_for_qsfp_init(ppd);
+
+	/*
+	 * Allow INT_N to trigger the QSFP interrupt to watch
+	 * for alarms and warnings
+	 */
+	set_qsfp_int_n(ppd, 1);
+
+	/*
+	 * After the reset, AOC transmitters are enabled by default. They need
+	 * to be turned off to complete the QSFP setup before they can be
+	 * enabled again.
+	 */
+	return set_qsfp_tx(ppd, 0);
+}
+
+static int handle_qsfp_error_conditions(struct hfi2_pportdata *ppd,
+					u8 *qsfp_interrupt_status)
+{
+	if ((qsfp_interrupt_status[0] & QSFP_HIGH_TEMP_ALARM) ||
+	    (qsfp_interrupt_status[0] & QSFP_HIGH_TEMP_WARNING))
+		ppd_dev_err(ppd, "%s: QSFP cable temperature too high\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[0] & QSFP_LOW_TEMP_ALARM) ||
+	    (qsfp_interrupt_status[0] & QSFP_LOW_TEMP_WARNING))
+		ppd_dev_err(ppd, "%s: QSFP cable temperature too low\n",
+			    __func__);
+
+	/*
+	 * The remaining alarms/warnings don't matter if the link is down.
+	 */
+	if (ppd->host_link_state & HLS_DOWN)
+		return 0;
+
+	if ((qsfp_interrupt_status[1] & QSFP_HIGH_VCC_ALARM) ||
+	    (qsfp_interrupt_status[1] & QSFP_HIGH_VCC_WARNING))
+		ppd_dev_err(ppd, "%s: QSFP supply voltage too high\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[1] & QSFP_LOW_VCC_ALARM) ||
+	    (qsfp_interrupt_status[1] & QSFP_LOW_VCC_WARNING))
+		ppd_dev_err(ppd, "%s: QSFP supply voltage too low\n",
+			    __func__);
+
+	/* Byte 2 is vendor specific */
+
+	if ((qsfp_interrupt_status[3] & QSFP_HIGH_POWER_ALARM) ||
+	    (qsfp_interrupt_status[3] & QSFP_HIGH_POWER_WARNING))
+		ppd_dev_err(ppd, "%s: Cable RX channel 1/2 power too high\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[3] & QSFP_LOW_POWER_ALARM) ||
+	    (qsfp_interrupt_status[3] & QSFP_LOW_POWER_WARNING))
+		ppd_dev_err(ppd, "%s: Cable RX channel 1/2 power too low\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[4] & QSFP_HIGH_POWER_ALARM) ||
+	    (qsfp_interrupt_status[4] & QSFP_HIGH_POWER_WARNING))
+		ppd_dev_err(ppd, "%s: Cable RX channel 3/4 power too high\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[4] & QSFP_LOW_POWER_ALARM) ||
+	    (qsfp_interrupt_status[4] & QSFP_LOW_POWER_WARNING))
+		ppd_dev_err(ppd, "%s: Cable RX channel 3/4 power too low\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[5] & QSFP_HIGH_BIAS_ALARM) ||
+	    (qsfp_interrupt_status[5] & QSFP_HIGH_BIAS_WARNING))
+		ppd_dev_err(ppd, "%s: Cable TX channel 1/2 bias too high\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[5] & QSFP_LOW_BIAS_ALARM) ||
+	    (qsfp_interrupt_status[5] & QSFP_LOW_BIAS_WARNING))
+		ppd_dev_err(ppd, "%s: Cable TX channel 1/2 bias too low\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[6] & QSFP_HIGH_BIAS_ALARM) ||
+	    (qsfp_interrupt_status[6] & QSFP_HIGH_BIAS_WARNING))
+		ppd_dev_err(ppd, "%s: Cable TX channel 3/4 bias too high\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[6] & QSFP_LOW_BIAS_ALARM) ||
+	    (qsfp_interrupt_status[6] & QSFP_LOW_BIAS_WARNING))
+		ppd_dev_err(ppd, "%s: Cable TX channel 3/4 bias too low\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[7] & QSFP_HIGH_POWER_ALARM) ||
+	    (qsfp_interrupt_status[7] & QSFP_HIGH_POWER_WARNING))
+		ppd_dev_err(ppd, "%s: Cable TX channel 1/2 power too high\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[7] & QSFP_LOW_POWER_ALARM) ||
+	    (qsfp_interrupt_status[7] & QSFP_LOW_POWER_WARNING))
+		ppd_dev_err(ppd, "%s: Cable TX channel 1/2 power too low\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[8] & QSFP_HIGH_POWER_ALARM) ||
+	    (qsfp_interrupt_status[8] & QSFP_HIGH_POWER_WARNING))
+		ppd_dev_err(ppd, "%s: Cable TX channel 3/4 power too high\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[8] & QSFP_LOW_POWER_ALARM) ||
+	    (qsfp_interrupt_status[8] & QSFP_LOW_POWER_WARNING))
+		ppd_dev_err(ppd, "%s: Cable TX channel 3/4 power too low\n",
+			    __func__);
+
+	/* Bytes 9-10 and 11-12 are reserved */
+	/* Bytes 13-15 are vendor specific */
+
+	return 0;
+}
+
+/* This routine will only be scheduled if the QSFP module present is asserted */
+void qsfp_event(struct work_struct *work)
+{
+	struct qsfp_data *qd;
+	struct hfi2_pportdata *ppd;
+	struct hfi2_devdata *dd;
+
+	qd = container_of(work, struct qsfp_data, qsfp_work);
+	ppd = qd->ppd;
+	dd = ppd->dd;
+
+	/* Sanity check */
+	if (!qsfp_mod_present(ppd))
+		return;
+
+	if (ppd->host_link_state == HLS_DN_DISABLE) {
+		ppd_dev_info(ppd,
+			     "%s: stopping link start because link is disabled\n",
+			     __func__);
+		return;
+	}
+
+	/*
+	 * Turn DC back on after cable has been re-inserted. Up until
+	 * now, the DC has been in reset to save power.
+	 */
+	dc_start(dd);
+
+	if (qd->cache_refresh_required) {
+		set_qsfp_int_n(ppd, 0);
+
+		wait_for_qsfp_init(ppd);
+
+		/*
+		 * Allow INT_N to trigger the QSFP interrupt to watch
+		 * for alarms and warnings
+		 */
+		set_qsfp_int_n(ppd, 1);
+
+		start_link(ppd);
+	}
+
+	if (qd->check_interrupt_flags) {
+		u8 qsfp_interrupt_status[16] = {0,};
+
+		if (one_qsfp_read(ppd, dd->hfi2_id, 6,
+				  &qsfp_interrupt_status[0], 16) != 16) {
+			ppd_dev_info(ppd,
+				     "%s: Failed to read status of QSFP module\n",
+				     __func__);
+		} else {
+			unsigned long flags;
+
+			handle_qsfp_error_conditions(
+					ppd, qsfp_interrupt_status);
+			spin_lock_irqsave(&ppd->qsfp_info.qsfp_lock, flags);
+			ppd->qsfp_info.check_interrupt_flags = 0;
+			spin_unlock_irqrestore(&ppd->qsfp_info.qsfp_lock,
+					       flags);
+		}
+	}
+}
+
+void init_qsfp_int(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 qsfp_mask;
+
+	qsfp_mask = (u64)(QSFP_HFI0_INT_N | QSFP_HFI0_MODPRST_N);
+	/* Clear current status to avoid spurious interrupts */
+	write_csr(dd, dd->hfi2_id ? ASIC_QSFP2_CLEAR : ASIC_QSFP1_CLEAR,
+		  qsfp_mask);
+	write_csr(dd, dd->hfi2_id ? ASIC_QSFP2_MASK : ASIC_QSFP1_MASK,
+		  qsfp_mask);
+
+	set_qsfp_int_n(ppd, 0);
+
+	/* Handle active low nature of INT_N and MODPRST_N pins */
+	if (qsfp_mod_present(ppd))
+		qsfp_mask &= ~(u64)QSFP_HFI0_MODPRST_N;
+	write_csr(dd,
+		  dd->hfi2_id ? ASIC_QSFP2_INVERT : ASIC_QSFP1_INVERT,
+		  qsfp_mask);
+
+	/* Enable the appropriate QSFP IRQ source */
+	if (!dd->hfi2_id)
+		set_intr_bits(dd, QSFP1_INT, QSFP1_INT, true);
+	else
+		set_intr_bits(dd, QSFP2_INT, QSFP2_INT, true);
+}
+
+/*
+ * Do a one-time initialize of the LCB block.
+ */
+static void init_lcb(struct hfi2_devdata *dd)
+{
+	/* the DC has been reset earlier in the driver load */
+
+	/* set LCB for cclk loopback on the port */
+	write_csr(dd, DC_LCB_CFG_TX_FIFOS_RESET, 0x01);
+	write_csr(dd, DC_LCB_CFG_LANE_WIDTH, 0x00);
+	write_csr(dd, DC_LCB_CFG_REINIT_AS_SLAVE, 0x00);
+	write_csr(dd, DC_LCB_CFG_CNT_FOR_SKIP_STALL, 0x110);
+	write_csr(dd, DC_LCB_CFG_CLK_CNTR, 0x08);
+	write_csr(dd, DC_LCB_CFG_LOOPBACK, 0x02);
+	write_csr(dd, DC_LCB_CFG_TX_FIFOS_RESET, 0x00);
+}
+
+/*
+ * Perform a test read on the QSFP.  Return 0 on success, -ERRNO
+ * on error.
+ */
+static int test_qsfp_read(struct hfi2_pportdata *ppd)
+{
+	int ret;
+	u8 status;
+
+	/*
+	 * Report success if not a QSFP or, if it is a QSFP, but the cable is
+	 * not present
+	 */
+	if (ppd->port_type != PORT_TYPE_QSFP || !qsfp_mod_present(ppd))
+		return 0;
+
+	/* read byte 2, the status byte */
+	ret = one_qsfp_read(ppd, ppd->dd->hfi2_id, 2, &status, 1);
+	if (ret < 0)
+		return ret;
+	if (ret != 1)
+		return -EIO;
+
+	return 0; /* success */
+}
+
+/*
+ * Values for QSFP retry.
+ *
+ * Give up after 10s (20 x 500ms).  The overall timeout was empirically
+ * arrived at from experience on a large cluster.
+ */
+#define MAX_QSFP_RETRIES 20
+#define QSFP_RETRY_WAIT 500 /* msec */
+
+/*
+ * Try a QSFP read.  If it fails, schedule a retry for later.
+ * Called on first link activation after driver load.
+ */
+static void try_start_link(struct hfi2_pportdata *ppd)
+{
+	if (test_qsfp_read(ppd)) {
+		/* read failed */
+		if (ppd->qsfp_retry_count >= MAX_QSFP_RETRIES) {
+			ppd_dev_err(ppd, "QSFP not responding, giving up\n");
+			return;
+		}
+		ppd_dev_info(ppd,
+			     "QSFP not responding, waiting and retrying %d\n",
+			     (int)ppd->qsfp_retry_count);
+		ppd->qsfp_retry_count++;
+		queue_delayed_work(ppd->link_wq, &ppd->start_link_work,
+				   msecs_to_jiffies(QSFP_RETRY_WAIT));
+		return;
+	}
+	ppd->qsfp_retry_count = 0;
+
+	start_link(ppd);
+}
+
+/*
+ * Workqueue function to start the link after a delay.
+ */
+void handle_start_link(struct work_struct *work)
+{
+	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
+						  start_link_work.work);
+	try_start_link(ppd);
+}
+
+int bringup_serdes(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 guid;
+	int ret;
+
+	if (HFI2_CAP_IS_KSET(EXTENDED_PSN))
+		add_rcvctrl(ppd, RCV_CTRL_RCV_EXTENDED_PSN_ENABLE_SMASK);
+
+	guid = ppd->guids[HFI2_PORT_GUID_INDEX];
+	if (!guid) {
+		/* OPA spec says bits 34:32 are port number, 1-7 */
+		if (dd->base_guid)
+			guid = (dd->base_guid & ~(7ULL << 32)) | ((u64)ppd->port << 32);
+		ppd->guids[HFI2_PORT_GUID_INDEX] = guid;
+	}
+
+	/* Set linkinit_reason on power up per OPA spec */
+	ppd->linkinit_reason = OPA_LINKINIT_REASON_LINKUP;
+
+	/* one-time init of the LCB */
+	init_lcb(dd);
+
+	if (loopback) {
+		ret = init_loopback(dd);
+		if (ret < 0)
+			return ret;
+	}
+
+	get_port_type(ppd);
+	if (ppd->port_type == PORT_TYPE_QSFP) {
+		set_qsfp_int_n(ppd, 0);
+		wait_for_qsfp_init(ppd);
+		set_qsfp_int_n(ppd, 1);
+	}
+
+	try_start_link(ppd);
+	return 0;
+}
+
+void hfi2_quiet_serdes(struct hfi2_pportdata *ppd)
+{
+	/*
+	 * Shut down the link and keep it down.   First turn off that the
+	 * driver wants to allow the link to be up (driver_link_ready).
+	 * Then make sure the link is not automatically restarted
+	 * (link_enabled).  Cancel any pending restart.  And finally
+	 * go offline.
+	 */
+	ppd->driver_link_ready = 0;
+	ppd->link_enabled = 0;
+
+	ppd->qsfp_retry_count = MAX_QSFP_RETRIES; /* prevent more retries */
+	flush_delayed_work(&ppd->start_link_work);
+	cancel_delayed_work_sync(&ppd->start_link_work);
+
+	ppd->offline_disabled_reason =
+			HFI2_ODR_MASK(OPA_LINKDOWN_REASON_REBOOT);
+	set_link_down_reason(ppd, OPA_LINKDOWN_REASON_REBOOT, 0,
+			     OPA_LINKDOWN_REASON_REBOOT);
+	set_link_state(ppd, HLS_DN_OFFLINE);
+
+	/* disable the port */
+	clear_rcvctrl(ppd, RCV_CTRL_RCV_PORT_ENABLE_SMASK);
+	flush_work(&ppd->dd->freeze_work);
+}
+
+static inline int init_cpu_counters(struct hfi2_devdata *dd)
+{
+	struct hfi2_pportdata *ppd;
+	int i;
+
+	ppd = (struct hfi2_pportdata *)(dd + 1);
+	for (i = 0; i < dd->num_pports; i++, ppd++) {
+		ppd->ibport_data.rvp.rc_acks = NULL;
+		ppd->ibport_data.rvp.rc_qacks = NULL;
+		ppd->ibport_data.rvp.rc_acks = alloc_percpu(u64);
+		ppd->ibport_data.rvp.rc_qacks = alloc_percpu(u64);
+		ppd->ibport_data.rvp.rc_delayed_comp = alloc_percpu(u64);
+		if (!ppd->ibport_data.rvp.rc_acks ||
+		    !ppd->ibport_data.rvp.rc_delayed_comp ||
+		    !ppd->ibport_data.rvp.rc_qacks)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void wfr_set_port_tid_config(struct hfi2_devdata *dd, int pidx, u16 ctxt,
+			     u32 eager_base, u16 alloced,
+			     u32 expected_base, u32 expected_count)
+{
+	u64 reg;
+
+	/* set eager count and base index */
+	reg = ((u64)(alloced >> RCV_SHIFT) << RCV_EGR_CTRL_EGR_CNT_SHIFT) |
+	      ((eager_base >> RCV_SHIFT) << RCV_EGR_CTRL_EGR_BASE_INDEX_SHIFT);
+	write_rctxt_csr(dd, ctxt, dd->params->rcv_egr_ctrl_reg, reg);
+
+	/*
+	 * Set TID (expected) count and base index.
+	 * rcd->expected_count is set to individual RcvArray entries,
+	 * not pairs, and the CSR takes a pair-count in groups of
+	 * four, so divide by 8.
+	 */
+	reg = ((u64)(expected_count >> RCV_SHIFT) << RCV_TID_CTRL_TID_PAIR_CNT_SHIFT) |
+	      ((expected_base >> RCV_SHIFT) << RCV_TID_CTRL_TID_BASE_INDEX_SHIFT);
+	write_rctxt_csr(dd, ctxt, dd->params->rcv_tid_ctrl_reg, reg);
+	/* WFR does not have a port tid count */
+}
+
+/* RcvArray base address */
+static inline u8 __iomem *rcvarray_base(struct hfi2_devdata *dd, u32 ctxt)
+{
+	return dd->bar_maps[ctxt_bar_idx(ctxt)].rcvarray_wc;
+}
+
+/*
+ * Update a TID entry of a given receive context.
+ *
+ * @rcd	  Receive context being updated.
+ * @index When type is PT_EAGER or PT_EXPECTED, index is the index into the
+ *	  receive array _relative_ to how the context is set up.  Otherwise
+ *	  it is a raw index.
+ * @pa	  Physical DMA address.  If invalidating, this should be zero.
+ * @order Order of map.  If invalidating, this should be zero.
+ * @flush Forced flush.  Otherwise, will flush on eager or on 32-byte boundary.
+ */
+void wfr_put_tid(struct hfi2_ctxtdata *rcd, u32 index,
+		 u32 type, unsigned long pa, u16 order, bool flush)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+	u8 __iomem *base = rcvarray_base(dd, rcd->ctxt);
+	u64 reg;
+
+	if (!(dd->flags & HFI2_PRESENT))
+		return;
+
+	if (type == PT_EAGER)
+		index += rcd->eager_base;
+	else if (type == PT_EXPECTED)
+		index += rcd->expected_base;
+	trace_hfi2_put_tid(dd, index, type, pa, order);
+
+#define RT_ADDR_SHIFT 12	/* 4KB kernel address boundary */
+	reg = RCV_ARRAY_RT_WRITE_ENABLE_SMASK
+		| (u64)order << RCV_ARRAY_RT_BUF_SIZE_SHIFT
+		| ((pa >> RT_ADDR_SHIFT) & RCV_ARRAY_RT_ADDR_MASK)
+					<< RCV_ARRAY_RT_ADDR_SHIFT;
+	trace_hfi2_write_rcvarray(base + (index * 8), reg);
+	writeq(reg, base + (index * 8));
+
+	if (type == PT_EAGER || flush || (index & 3) == 3)
+		flush_wc();
+}
+
+/*
+ * Write an "no-op" RcvArray entry.
+ *
+ * Called by the TID registration code to write to unused/unneeded RcvArray
+ * entries to fill out a write-combining buffer line.  The HFI will ignore this
+ * write to the RcvArray entry.
+ */
+void wfr_rcv_array_wc_fill(struct hfi2_ctxtdata *rcd, u32 index, u32 type)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+
+	/*
+	 * Doing the WC fill writes only makes sense if the device is
+	 * present and the RcvArray has been mapped as WC memory.
+	 */
+	if (dd->flags & HFI2_PRESENT) {
+		if (type == PT_EAGER)
+			index += rcd->eager_base;
+		else if (type == PT_EXPECTED)
+			index += rcd->expected_base;
+
+		writeq(0, rcvarray_base(dd, rcd->ctxt) + (index * 8));
+		if ((index & 3) == 3)
+			flush_wc();
+	}
+}
+
+static void wfr_init_tids(struct hfi2_devdata *dd)
+{
+	const u64 reg = RCV_ARRAY_RT_WRITE_ENABLE_SMASK;
+	u32 num_rcv;
+	u32 i;
+
+	num_rcv = chip_rcv_array_count(dd);
+	for (i = 0; i < num_rcv; i++) {
+		/* WFR RcvArray addressing is not ctxt relative, just use 0 */
+		writeq(reg, rcvarray_base(dd, 0) + (i * 8));
+		if ((i & 3) == 3)
+			flush_wc();
+	}
+}
+
+void hfi2_clear_tids(struct hfi2_ctxtdata *rcd)
+{
+	u32 i;
+
+	for (i = 0; i < rcd->egrbufs.alloced; i++)
+		rcd->dd->params->put_tid(rcd, i, PT_EAGER, 0, 0, false);
+
+	for (i = 0; i < rcd->expected_count; i++)
+		rcd->dd->params->put_tid(rcd, i, PT_EXPECTED, 0, 0, false);
+}
+
+static const char * const ib_cfg_name_strings[] = {
+	"HFI2_IB_CFG_LIDLMC",
+	"HFI2_IB_CFG_LWID_DG_ENB",
+	"HFI2_IB_CFG_LWID_ENB",
+	"HFI2_IB_CFG_LWID",
+	"HFI2_IB_CFG_SPD_ENB",
+	"HFI2_IB_CFG_SPD",
+	"HFI2_IB_CFG_RXPOL_ENB",
+	"HFI2_IB_CFG_LREV_ENB",
+	"HFI2_IB_CFG_LINKLATENCY",
+	"HFI2_IB_CFG_HRTBT",
+	"HFI2_IB_CFG_OP_VLS",
+	"HFI2_IB_CFG_VL_HIGH_CAP",
+	"HFI2_IB_CFG_VL_LOW_CAP",
+	"HFI2_IB_CFG_OVERRUN_THRESH",
+	"HFI2_IB_CFG_PHYERR_THRESH",
+	"HFI2_IB_CFG_LINKDEFAULT",
+	"HFI2_IB_CFG_PKEYS",
+	"HFI2_IB_CFG_MTU",
+	"HFI2_IB_CFG_LSTATE",
+	"HFI2_IB_CFG_VL_HIGH_LIMIT",
+	"HFI2_IB_CFG_PMA_TICKS",
+	"HFI2_IB_CFG_PORT"
+};
+
+static const char *ib_cfg_name(int which)
+{
+	if (which < 0 || which >= ARRAY_SIZE(ib_cfg_name_strings))
+		return "invalid";
+	return ib_cfg_name_strings[which];
+}
+
+int hfi2_get_ib_cfg(struct hfi2_pportdata *ppd, int which)
+{
+	int val = 0;
+
+	switch (which) {
+	case HFI2_IB_CFG_LWID_ENB: /* allowed Link-width */
+		val = ppd->link_width_enabled;
+		break;
+	case HFI2_IB_CFG_LWID: /* currently active Link-width */
+		val = ppd->link_width_active;
+		break;
+	case HFI2_IB_CFG_SPD_ENB: /* allowed Link speeds */
+		val = ppd->link_speed_enabled;
+		break;
+	case HFI2_IB_CFG_SPD: /* current Link speed */
+		val = ppd->link_speed_active;
+		break;
+
+	case HFI2_IB_CFG_RXPOL_ENB: /* Auto-RX-polarity enable */
+	case HFI2_IB_CFG_LREV_ENB: /* Auto-Lane-reversal enable */
+	case HFI2_IB_CFG_LINKLATENCY:
+		goto unimplemented;
+
+	case HFI2_IB_CFG_OP_VLS:
+		val = ppd->actual_vls_operational;
+		break;
+	case HFI2_IB_CFG_VL_HIGH_CAP: /* VL arb high priority table size */
+		val = VL_ARB_HIGH_PRIO_TABLE_SIZE;
+		break;
+	case HFI2_IB_CFG_VL_LOW_CAP: /* VL arb low priority table size */
+		val = VL_ARB_LOW_PRIO_TABLE_SIZE;
+		break;
+	case HFI2_IB_CFG_OVERRUN_THRESH: /* IB overrun threshold */
+		val = ppd->overrun_threshold;
+		break;
+	case HFI2_IB_CFG_PHYERR_THRESH: /* IB PHY error threshold */
+		val = ppd->phy_error_threshold;
+		break;
+	case HFI2_IB_CFG_LINKDEFAULT: /* IB link default (sleep/poll) */
+		val = HLS_DEFAULT;
+		break;
+
+	case HFI2_IB_CFG_HRTBT: /* Heartbeat off/enable/auto */
+	case HFI2_IB_CFG_PMA_TICKS:
+	default:
+unimplemented:
+		if (HFI2_CAP_IS_KSET(PRINT_UNIMPL))
+			ppd_dev_info(ppd,
+				     "%s: which %s: not implemented\n",
+				     __func__,
+				     ib_cfg_name(which));
+		break;
+	}
+
+	return val;
+}
+
+/*
+ * The largest MAD packet size.
+ */
+#define MAX_MAD_PACKET 2048
+
+/*
+ * Return the maximum header bytes that can go on the _wire_
+ * for this device. This count includes the ICRC which is
+ * not part of the packet held in memory but it is appended
+ * by the HW.
+ * This is dependent on the device's receive header entry size.
+ * HFI allows this to be set per-receive context, but the
+ * driver presently enforces a global value.
+ */
+u32 lrh_max_header_bytes(struct hfi2_pportdata *ppd)
+{
+	/*
+	 * The maximum non-payload (MTU) bytes in LRH.PktLen are
+	 * the Receive Header Entry Size minus the PBC (or RHF) size
+	 * plus one DW for the ICRC appended by HW.
+	 *
+	 * hdrqentsize is in DW.
+	 *
+	 * Use this port's kernel contexts' receive header entry size.
+	 */
+	return (kctxt_hdrqentsize(ppd) - 2/*PBC/RHF*/ + 1/*ICRC*/) << 2;
+}
+
+/* set what to accept in the port hardware */
+static void set_dlid_lmc(struct hfi2_pportdata *ppd, u32 mask, u32 lid)
+{
+	u64 c1 = read_csr(ppd->dd, DCC_CFG_PORT_CONFIG1);
+
+	c1 &= ~(DCC_CFG_PORT_CONFIG1_TARGET_DLID_SMASK
+		| DCC_CFG_PORT_CONFIG1_DLID_MASK_SMASK);
+	c1 |= ((lid & DCC_CFG_PORT_CONFIG1_TARGET_DLID_MASK)
+			<< DCC_CFG_PORT_CONFIG1_TARGET_DLID_SHIFT) |
+	      ((mask & DCC_CFG_PORT_CONFIG1_DLID_MASK_MASK)
+			<< DCC_CFG_PORT_CONFIG1_DLID_MASK_SHIFT);
+	write_csr(ppd->dd, DCC_CFG_PORT_CONFIG1, c1);
+}
+
+/* set maximum MTU for the port */
+void wfr_set_port_max_mtu(struct hfi2_pportdata *ppd, u32 maxvlmtu)
+{
+	u64 config;
+	u32 dcmtu;
+
+	/* Adjust maximum MTU for the port in DC */
+	dcmtu = maxvlmtu == 10240 ? DCC_CFG_PORT_MTU_CAP_10240 :
+		(ilog2(maxvlmtu >> 8) + 1);
+	config = read_csr(ppd->dd, DCC_CFG_PORT_CONFIG);
+	config &= ~DCC_CFG_PORT_CONFIG_MTU_CAP_SMASK;
+	config |= ((u64)dcmtu & DCC_CFG_PORT_CONFIG_MTU_CAP_MASK) <<
+		  DCC_CFG_PORT_CONFIG_MTU_CAP_SHIFT;
+	write_csr(ppd->dd, DCC_CFG_PORT_CONFIG, config);
+}
+
+/*
+ * Set Send Length
+ * @ppd: per port data
+ *
+ * Set the MTU by limiting how many DWs may be sent.  The SendLenCheck*
+ * registers compare against LRH.PktLen, so use the max bytes included
+ * in the LRH.
+ *
+ * This routine changes all VL values except VL15, which it maintains at
+ * the same value.
+ */
+static void set_send_length(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 maxvlmtu = ppd->vld[15].mtu;
+	int i, j;
+	u32 thres;
+
+	/* per-vl send contexts are not present if port is not available */
+	if (!port_available_ppd(ppd))
+		return;
+
+	for (i = 0; i < ppd->vls_supported; i++) {
+		if (ppd->vld[i].mtu > maxvlmtu)
+			maxvlmtu = ppd->vld[i].mtu;
+	}
+
+	/* only WFR needs to write SendLenCheckn */
+	if (dd->params->chip_type == CHIP_WFR) {
+		u32 max_hb = lrh_max_header_bytes(ppd);
+		u64 len1 = 0;
+		u64 len2 = (((ppd->vld[15].mtu + max_hb) >> 2)
+				      & SEND_LEN_CHECK1_LEN_VL15_MASK) <<
+			   SEND_LEN_CHECK1_LEN_VL15_SHIFT;
+
+		for (i = 0; i < ppd->vls_supported; i++) {
+			if (i <= 3)
+				len1 |= (((ppd->vld[i].mtu + max_hb) >> 2)
+					 & SEND_LEN_CHECK0_LEN_VL0_MASK) <<
+					((i % 4) * SEND_LEN_CHECK0_LEN_VL1_SHIFT);
+			else
+				len2 |= (((ppd->vld[i].mtu + max_hb) >> 2)
+					 & SEND_LEN_CHECK1_LEN_VL4_MASK) <<
+					((i % 4) * SEND_LEN_CHECK1_LEN_VL5_SHIFT);
+		}
+		write_eport_csr(dd, ppd->hw_pidx, dd->params->send_len_check0_reg, len1);
+		write_eport_csr(dd, ppd->hw_pidx, dd->params->send_len_check1_reg, len2);
+	}
+	/* adjust kernel credit return thresholds based on new MTUs */
+	/* all kernel receive contexts have the same hdrqentsize */
+	for (i = 0; i < ppd->vls_supported; i++) {
+		thres = min(sc_percent_to_threshold(ppd->vld[i].sc, 50),
+			    sc_mtu_to_threshold(ppd->vld[i].sc,
+						ppd->vld[i].mtu,
+						kctxt_hdrqentsize(ppd)));
+		for (j = 0; j < INIT_SC_PER_VL; j++)
+			sc_set_cr_threshold(
+					pio_select_send_context_vl(ppd, j, i),
+					    thres);
+	}
+	thres = min(sc_percent_to_threshold(ppd->vld[15].sc, 50),
+		    sc_mtu_to_threshold(ppd->vld[15].sc,
+					ppd->vld[15].mtu,
+					kctxt_hdrqentsize(ppd)));
+	sc_set_cr_threshold(ppd->vld[15].sc, thres);
+
+	dd->params->set_port_max_mtu(ppd, maxvlmtu);
+}
+
+static void set_lidlmc(struct hfi2_pportdata *ppd)
+{
+	int i;
+	u64 sreg = 0;
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 mask = ~((1U << ppd->lmc) - 1);
+	u32 lid;
+
+	/*
+	 * Program 0 in CSR if port lid is extended. This prevents
+	 * 9B packets being sent out for large lids.
+	 */
+	lid = (ppd->lid >= be16_to_cpu(IB_MULTICAST_LID_BASE)) ? 0 : ppd->lid;
+
+	/* set port hardware */
+	set_dlid_lmc(ppd, mask, lid);
+
+	/*
+	 * Iterate over all the send contexts for this port and set their SLID
+	 * check.
+	 */
+	if (dd->params->chip_type == CHIP_WFR) {
+		sreg = ((mask & SEND_CTXT_CHECK_SLID_MASK_MASK) <<
+				SEND_CTXT_CHECK_SLID_MASK_SHIFT) |
+		       (((lid & mask) & SEND_CTXT_CHECK_SLID_VALUE_MASK) <<
+				SEND_CTXT_CHECK_SLID_VALUE_SHIFT);
+	} else {
+		sreg = ((u64)(mask & 0xffffff) << 32) | (lid & 0xffffff) |
+			BIT_ULL(63); /* PermissiveSlidAllowed */
+	}
+
+	for (i = 0; i < dd->num_send_contexts; i++) {
+		struct send_context *sc = dd->send_contexts[i].sc;
+
+		if (!sc)
+			continue;
+		if (sc->ppd != ppd)
+			continue;
+
+		hfi2_cdbg(LINKVERB, "SendContext[%d].SLID_CHECK = 0x%x",
+			  i, (u32)sreg);
+		priv_reg_op(dd, ppd->hw_pidx, sc->hw_context, sc->type,
+			    SC_CHK_SLID_OP, sreg);
+	}
+
+	/* Now we have to do the same thing for the sdma engines */
+	sdma_update_lmc(dd, mask, lid);
+}
+
+static const char *state_completed_string(u32 completed)
+{
+	static const char * const state_completed[] = {
+		"EstablishComm",
+		"OptimizeEQ",
+		"VerifyCap"
+	};
+
+	if (completed < ARRAY_SIZE(state_completed))
+		return state_completed[completed];
+
+	return "unknown";
+}
+
+static const char all_lanes_dead_timeout_expired[] =
+	"All lanes were inactive – was the interconnect media removed?";
+static const char tx_out_of_policy[] =
+	"Passing lanes on local port do not meet the local link width policy";
+static const char no_state_complete[] =
+	"State timeout occurred before link partner completed the state";
+static const char * const state_complete_reasons[] = {
+	[0x00] = "Reason unknown",
+	[0x01] = "Link was halted by driver, refer to LinkDownReason",
+	[0x02] = "Link partner reported failure",
+	[0x10] = "Unable to achieve frame sync on any lane",
+	[0x11] =
+	  "Unable to find a common bit rate with the link partner",
+	[0x12] =
+	  "Unable to achieve frame sync on sufficient lanes to meet the local link width policy",
+	[0x13] =
+	  "Unable to identify preset equalization on sufficient lanes to meet the local link width policy",
+	[0x14] = no_state_complete,
+	[0x15] =
+	  "State timeout occurred before link partner identified equalization presets",
+	[0x16] =
+	  "Link partner completed the EstablishComm state, but the passing lanes do not meet the local link width policy",
+	[0x17] = tx_out_of_policy,
+	[0x20] = all_lanes_dead_timeout_expired,
+	[0x21] =
+	  "Unable to achieve acceptable BER on sufficient lanes to meet the local link width policy",
+	[0x22] = no_state_complete,
+	[0x23] =
+	  "Link partner completed the OptimizeEq state, but the passing lanes do not meet the local link width policy",
+	[0x24] = tx_out_of_policy,
+	[0x30] = all_lanes_dead_timeout_expired,
+	[0x31] =
+	  "State timeout occurred waiting for host to process received frames",
+	[0x32] = no_state_complete,
+	[0x33] =
+	  "Link partner completed the VerifyCap state, but the passing lanes do not meet the local link width policy",
+	[0x34] = tx_out_of_policy,
+	[0x35] = "Negotiated link width is mutually exclusive",
+	[0x36] =
+	  "Timed out before receiving verifycap frames in VerifyCap.Exchange",
+	[0x37] = "Unable to resolve secure data exchange",
+};
+
+static const char *state_complete_reason_code_string(struct hfi2_pportdata *ppd,
+						     u32 code)
+{
+	const char *str = NULL;
+
+	if (code < ARRAY_SIZE(state_complete_reasons))
+		str = state_complete_reasons[code];
+
+	if (str)
+		return str;
+	return "Reserved";
+}
+
+/* describe the given last state complete frame */
+static void decode_state_complete(struct hfi2_pportdata *ppd, u32 frame,
+				  const char *prefix)
+{
+	u32 success;
+	u32 state;
+	u32 reason;
+	u32 lanes;
+
+	/*
+	 * Decode frame:
+	 *  [ 0: 0] - success
+	 *  [ 3: 1] - state
+	 *  [ 7: 4] - next state timeout
+	 *  [15: 8] - reason code
+	 *  [31:16] - lanes
+	 */
+	success = frame & 0x1;
+	state = (frame >> 1) & 0x7;
+	reason = (frame >> 8) & 0xff;
+	lanes = (frame >> 16) & 0xffff;
+
+	ppd_dev_err(ppd, "Last %s LNI state complete frame 0x%08x:\n",
+		    prefix, frame);
+	ppd_dev_err(ppd, "    last reported state state: %s (0x%x)\n",
+		    state_completed_string(state), state);
+	ppd_dev_err(ppd, "    state successfully completed: %s\n",
+		    success ? "yes" : "no");
+	ppd_dev_err(ppd, "    fail reason 0x%x: %s\n",
+		    reason, state_complete_reason_code_string(ppd, reason));
+	ppd_dev_err(ppd, "    passing lane mask: 0x%x", lanes);
+}
+
+/*
+ * Read the last state complete frames and explain them.  This routine
+ * expects to be called if the link went down during link negotiation
+ * and initialization (LNI).  That is, anywhere between polling and link up.
+ */
+static void check_lni_states(struct hfi2_pportdata *ppd)
+{
+	u32 last_local_state;
+	u32 last_remote_state;
+
+	read_last_local_state(ppd->dd, &last_local_state);
+	read_last_remote_state(ppd->dd, &last_remote_state);
+
+	/*
+	 * Don't report anything if there is nothing to report.  A value of
+	 * 0 means the link was taken down while polling and there was no
+	 * training in-process.
+	 */
+	if (last_local_state == 0 && last_remote_state == 0)
+		return;
+
+	decode_state_complete(ppd, last_local_state, "transmitted");
+	decode_state_complete(ppd, last_remote_state, "received");
+}
+
+/* wait for wait_ms for LINK_TRANSFER_ACTIVE to go to 1 */
+static int wait_link_transfer_active(struct hfi2_devdata *dd, int wait_ms)
+{
+	u64 reg;
+	unsigned long timeout;
+
+	/* watch LCB_STS_LINK_TRANSFER_ACTIVE */
+	timeout = jiffies + msecs_to_jiffies(wait_ms);
+	while (1) {
+		reg = read_csr(dd, DC_LCB_STS_LINK_TRANSFER_ACTIVE);
+		if (reg)
+			break;
+		if (time_after(jiffies, timeout)) {
+			dd_dev_err(dd,
+				   "timeout waiting for LINK_TRANSFER_ACTIVE\n");
+			return -ETIMEDOUT;
+		}
+		udelay(2);
+	}
+	return 0;
+}
+
+/* called when the logical link state is not down as it should be */
+static void force_logical_link_state_down(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+
+	/*
+	 * Bring link up in LCB loopback
+	 */
+	write_csr(dd, DC_LCB_CFG_TX_FIFOS_RESET, 1);
+	write_csr(dd, DC_LCB_CFG_IGNORE_LOST_RCLK,
+		  DC_LCB_CFG_IGNORE_LOST_RCLK_EN_SMASK);
+
+	write_csr(dd, DC_LCB_CFG_LANE_WIDTH, 0);
+	write_csr(dd, DC_LCB_CFG_REINIT_AS_SLAVE, 0);
+	write_csr(dd, DC_LCB_CFG_CNT_FOR_SKIP_STALL, 0x110);
+	write_csr(dd, DC_LCB_CFG_LOOPBACK, 0x2);
+
+	write_csr(dd, DC_LCB_CFG_TX_FIFOS_RESET, 0);
+	(void)read_csr(dd, DC_LCB_CFG_TX_FIFOS_RESET);
+	udelay(3);
+	write_csr(dd, DC_LCB_CFG_ALLOW_LINK_UP, 1);
+	write_csr(dd, DC_LCB_CFG_RUN, 1ull << DC_LCB_CFG_RUN_EN_SHIFT);
+
+	wait_link_transfer_active(dd, 100);
+
+	/*
+	 * Bring the link down again.
+	 */
+	write_csr(dd, DC_LCB_CFG_TX_FIFOS_RESET, 1);
+	write_csr(dd, DC_LCB_CFG_ALLOW_LINK_UP, 0);
+	write_csr(dd, DC_LCB_CFG_IGNORE_LOST_RCLK, 0);
+
+	ppd_dev_info(ppd, "logical state forced to LINK_DOWN\n");
+}
+
+/*
+ * Helper for set_link_state().  Do not call except from that routine.
+ * Expects ppd->hls_mutex to be held.
+ *
+ * @rem_reason value to be sent to the neighbor
+ *
+ * LinkDownReasons only set if transition succeeds.
+ */
+static int goto_offline(struct hfi2_pportdata *ppd, u8 rem_reason)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 previous_state;
+	int offline_state_ret;
+	int ret;
+
+	update_lcb_cache(ppd);
+
+	previous_state = ppd->host_link_state;
+	ppd->host_link_state = HLS_GOING_OFFLINE;
+
+	/* start offline transition */
+	ret = set_physical_link_state(dd, (rem_reason << 8) | PLS_OFFLINE);
+
+	if (ret != HCMD_SUCCESS) {
+		ppd_dev_err(ppd,
+			    "Failed to transition to Offline link state, return %d\n",
+			    ret);
+		return -EINVAL;
+	}
+	if (ppd->offline_disabled_reason ==
+			HFI2_ODR_MASK(OPA_LINKDOWN_REASON_NONE))
+		ppd->offline_disabled_reason =
+		HFI2_ODR_MASK(OPA_LINKDOWN_REASON_TRANSIENT);
+
+	offline_state_ret = wait_phys_link_offline_substates(ppd, 10000);
+	if (offline_state_ret < 0)
+		return offline_state_ret;
+
+	/* Disabling AOC transmitters */
+	if (ppd->port_type == PORT_TYPE_QSFP &&
+	    ppd->qsfp_info.limiting_active &&
+	    qsfp_mod_present(ppd)) {
+		int ret;
+
+		ret = acquire_chip_resource(dd, qsfp_resource(dd), QSFP_WAIT);
+		if (ret == 0) {
+			set_qsfp_tx(ppd, 0);
+			release_chip_resource(dd, qsfp_resource(dd));
+		} else {
+			/* not fatal, but should warn */
+			ppd_dev_err(ppd,
+				    "Unable to acquire lock to turn off QSFP TX\n");
+		}
+	}
+
+	/*
+	 * Wait for the offline.Quiet transition if it hasn't happened yet. It
+	 * can take a while for the link to go down.
+	 */
+	if (offline_state_ret != PLS_OFFLINE_QUIET) {
+		ret = wait_physical_linkstate(ppd, PLS_OFFLINE, 30000);
+		if (ret < 0)
+			return ret;
+	}
+
+	/*
+	 * Now in charge of LCB - must be after the physical state is
+	 * offline.quiet and before host_link_state is changed.
+	 */
+	set_host_lcb_access(dd);
+	write_csr(dd, DC_LCB_ERR_EN, ~0ull); /* watch LCB errors */
+
+	/* make sure the logical state is also down */
+	ret = wait_logical_linkstate(ppd, IB_PORT_DOWN, 1000);
+	if (ret)
+		force_logical_link_state_down(ppd);
+
+	ppd->host_link_state = HLS_LINK_COOLDOWN; /* LCB access allowed */
+	update_statusp(ppd, IB_PORT_DOWN);
+
+	/*
+	 * The LNI has a mandatory wait time after the physical state
+	 * moves to Offline.Quiet.  The wait time may be different
+	 * depending on how the link went down.  The 8051 firmware
+	 * will observe the needed wait time and only move to ready
+	 * when that is completed.  The largest of the quiet timeouts
+	 * is 6s, so wait that long and then at least 0.5s more for
+	 * other transitions, and another 0.5s for a buffer.
+	 */
+	ret = wait_fm_ready(dd, 7000);
+	if (ret) {
+		ppd_dev_err(ppd,
+			    "After going offline, timed out waiting for the 8051 to become ready to accept host requests\n");
+		/* state is really offline, so make it so */
+		ppd->host_link_state = HLS_DN_OFFLINE;
+		return ret;
+	}
+
+	/*
+	 * The state is now offline and the 8051 is ready to accept host
+	 * requests.
+	 *	- change our state
+	 *	- notify others if we were previously in a linkup state
+	 */
+	ppd->host_link_state = HLS_DN_OFFLINE;
+	if (previous_state & HLS_UP) {
+		/* went down while link was up */
+		handle_linkup_change(ppd, 0);
+	} else if (previous_state
+			& (HLS_DN_POLL | HLS_VERIFY_CAP | HLS_GOING_UP)) {
+		/* went down while attempting link up */
+		check_lni_states(ppd);
+
+		/* The QSFP doesn't need to be reset on LNI failure */
+		ppd->qsfp_info.reset_needed = 0;
+	}
+
+	/* the active link width (downgrade) is 0 on link down */
+	ppd->link_width_active = 0;
+	ppd->link_width_downgrade_tx_active = 0;
+	ppd->link_width_downgrade_rx_active = 0;
+	ppd->current_egress_rate = 0;
+	return 0;
+}
+
+/* return the link state name */
+const char *link_state_name(u32 state)
+{
+	const char *name;
+	int n = ilog2(state);
+	static const char * const names[] = {
+		[__HLS_UP_INIT_BP]	 = "INIT",
+		[__HLS_UP_ARMED_BP]	 = "ARMED",
+		[__HLS_UP_ACTIVE_BP]	 = "ACTIVE",
+		[__HLS_DN_DOWNDEF_BP]	 = "DOWNDEF",
+		[__HLS_DN_POLL_BP]	 = "POLL",
+		[__HLS_DN_DISABLE_BP]	 = "DISABLE",
+		[__HLS_DN_OFFLINE_BP]	 = "OFFLINE",
+		[__HLS_VERIFY_CAP_BP]	 = "VERIFY_CAP",
+		[__HLS_GOING_UP_BP]	 = "GOING_UP",
+		[__HLS_GOING_OFFLINE_BP] = "GOING_OFFLINE",
+		[__HLS_LINK_COOLDOWN_BP] = "LINK_COOLDOWN"
+	};
+
+	name = n < ARRAY_SIZE(names) ? names[n] : NULL;
+	return name ? name : "unknown";
+}
+
+/* return the link state reason name */
+const char *link_state_reason_name(struct hfi2_pportdata *ppd, u32 state)
+{
+	if (state == HLS_UP_INIT) {
+		switch (ppd->linkinit_reason) {
+		case OPA_LINKINIT_REASON_LINKUP:
+			return "(LINKUP)";
+		case OPA_LINKINIT_REASON_FLAPPING:
+			return "(FLAPPING)";
+		case OPA_LINKINIT_OUTSIDE_POLICY:
+			return "(OUTSIDE_POLICY)";
+		case OPA_LINKINIT_QUARANTINED:
+			return "(QUARANTINED)";
+		case OPA_LINKINIT_INSUFIC_CAPABILITY:
+			return "(INSUFIC_CAPABILITY)";
+		default:
+			break;
+		}
+	}
+	return "";
+}
+
+/*
+ * driver_pstate - convert the driver's notion of a port's
+ * state (an HLS_*) into a physical state (a {IB,OPA}_PORTPHYSSTATE_*).
+ * Return -1 (converted to a u32) to indicate error.
+ */
+u32 driver_pstate(struct hfi2_pportdata *ppd)
+{
+	switch (ppd->host_link_state) {
+	case HLS_UP_INIT:
+	case HLS_UP_ARMED:
+	case HLS_UP_ACTIVE:
+		return IB_PORTPHYSSTATE_LINKUP;
+	case HLS_DN_POLL:
+		return IB_PORTPHYSSTATE_POLLING;
+	case HLS_DN_DISABLE:
+		return IB_PORTPHYSSTATE_DISABLED;
+	case HLS_DN_OFFLINE:
+		return OPA_PORTPHYSSTATE_OFFLINE;
+	case HLS_VERIFY_CAP:
+		return IB_PORTPHYSSTATE_TRAINING;
+	case HLS_GOING_UP:
+		return IB_PORTPHYSSTATE_TRAINING;
+	case HLS_GOING_OFFLINE:
+		return OPA_PORTPHYSSTATE_OFFLINE;
+	case HLS_LINK_COOLDOWN:
+		return OPA_PORTPHYSSTATE_OFFLINE;
+	case HLS_DN_DOWNDEF:
+	default:
+		ppd_dev_err(ppd, "invalid host_link_state 0x%x\n",
+			    ppd->host_link_state);
+		return  -1;
+	}
+}
+
+/*
+ * driver_lstate - convert the driver's notion of a port's
+ * state (an HLS_*) into a logical state (a IB_PORT_*). Return -1
+ * (converted to a u32) to indicate error.
+ */
+u32 driver_lstate(struct hfi2_pportdata *ppd)
+{
+	if (ppd->host_link_state && (ppd->host_link_state & HLS_DOWN))
+		return IB_PORT_DOWN;
+
+	switch (ppd->host_link_state & HLS_UP) {
+	case HLS_UP_INIT:
+		return IB_PORT_INIT;
+	case HLS_UP_ARMED:
+		return IB_PORT_ARMED;
+	case HLS_UP_ACTIVE:
+		return IB_PORT_ACTIVE;
+	default:
+		ppd_dev_err(ppd, "invalid host_link_state 0x%x\n",
+			    ppd->host_link_state);
+	return -1;
+	}
+}
+
+void set_link_down_reason(struct hfi2_pportdata *ppd, u8 lcl_reason,
+			  u8 neigh_reason, u8 rem_reason)
+{
+	if (ppd->local_link_down_reason.latest == 0 &&
+	    ppd->neigh_link_down_reason.latest == 0) {
+		ppd->local_link_down_reason.latest = lcl_reason;
+		ppd->neigh_link_down_reason.latest = neigh_reason;
+		ppd->remote_link_down_reason = rem_reason;
+	}
+}
+
+/**
+ * data_vls_operational() - Verify if data VL BCT credits and MTU
+ *			    are both set.
+ * @ppd: pointer to hfi2_pportdata structure
+ *
+ * Return: true - Ok, false -otherwise.
+ */
+static inline bool data_vls_operational(struct hfi2_pportdata *ppd)
+{
+	int i;
+	u64 reg;
+
+	if (!ppd->actual_vls_operational)
+		return false;
+
+	for (i = 0; i < ppd->vls_supported; i++) {
+		u32 off = ppd->dd->params->send_cm_credit_vl_reg + (8 * i);
+
+		reg = read_eport_csr(ppd->dd, ppd->hw_pidx, off);
+		if ((reg && !ppd->vld[i].mtu) ||
+		    (!reg && ppd->vld[i].mtu))
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * Change the physical and/or logical link state.
+ *
+ * Do not call this routine while inside an interrupt.  It contains
+ * calls to routines that can take multiple seconds to finish.
+ *
+ * Returns 0 on success, -errno on failure.
+ */
+int set_link_state(struct hfi2_pportdata *ppd, u32 state)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int ret1, ret = 0;
+	int orig_new_state, poll_bounce;
+
+	mutex_lock(&ppd->hls_lock);
+
+	orig_new_state = state;
+	if (state == HLS_DN_DOWNDEF)
+		state = HLS_DEFAULT;
+
+	/* interpret poll -> poll as a link bounce */
+	poll_bounce = ppd->host_link_state == HLS_DN_POLL &&
+		      state == HLS_DN_POLL;
+
+	ppd_dev_info(ppd, "%s: current %s, new %s %s%s\n", __func__,
+		     link_state_name(ppd->host_link_state),
+		     link_state_name(orig_new_state),
+		     poll_bounce ? "(bounce) " : "",
+		     link_state_reason_name(ppd, state));
+
+	/*
+	 * If we're going to a (HLS_*) link state that implies the logical
+	 * link state is neither of (IB_PORT_ARMED, IB_PORT_ACTIVE), then
+	 * reset is_sm_config_started to 0.
+	 */
+	if (!(state & (HLS_UP_ARMED | HLS_UP_ACTIVE)))
+		ppd->is_sm_config_started = 0;
+
+	/*
+	 * Do nothing if the states match.  Let a poll to poll link bounce
+	 * go through.
+	 */
+	if (ppd->host_link_state == state && !poll_bounce)
+		goto done;
+
+	switch (state) {
+	case HLS_UP_INIT:
+		if (ppd->host_link_state == HLS_DN_POLL &&
+		    quick_linkup) {
+			/*
+			 * Quick link up jumps from polling to here.
+			 * Accept that here.
+			 */
+			/* OK */
+		} else if (ppd->host_link_state != HLS_GOING_UP) {
+			goto unexpected;
+		}
+
+		/*
+		 * Wait for Link_Up physical state.
+		 * Physical and Logical states should already
+		 * be transitioned to LinkUp and LinkInit respectively.
+		 */
+		ret = wait_physical_linkstate(ppd, PLS_LINKUP, 1000);
+		if (ret) {
+			dd_dev_err(dd,
+				   "%s: physical state did not change to LINK-UP\n",
+				   __func__);
+			break;
+		}
+
+		ret = wait_logical_linkstate(ppd, IB_PORT_INIT, 1000);
+		if (ret) {
+			ppd_dev_err(ppd,
+				    "%s: logical state did not change to INIT\n",
+				    __func__);
+			break;
+		}
+
+		/* clear old transient LINKINIT_REASON code */
+		if (ppd->linkinit_reason >= OPA_LINKINIT_REASON_CLEAR)
+			ppd->linkinit_reason =
+				OPA_LINKINIT_REASON_LINKUP;
+
+		/* enable the port */
+		add_rcvctrl(ppd, RCV_CTRL_RCV_PORT_ENABLE_SMASK);
+
+		handle_linkup_change(ppd, 1);
+		pio_kernel_linkup(ppd);
+		/* tell engines to go running after a link bounce */
+		sdma_all_running(dd);
+
+		/*
+		 * After link up, a new link width will have been set.
+		 * Update the xmit counters with regards to the new
+		 * link width.
+		 */
+		update_xmit_counters(ppd, ppd->link_width_active);
+
+		ppd->host_link_state = HLS_UP_INIT;
+		update_statusp(ppd, IB_PORT_INIT);
+		break;
+	case HLS_UP_ARMED:
+		if (ppd->host_link_state != HLS_UP_INIT)
+			goto unexpected;
+
+		if (!data_vls_operational(ppd)) {
+			ppd_dev_err(ppd,
+				    "%s: Invalid data VL credits or mtu\n",
+				    __func__);
+			ret = -EINVAL;
+			break;
+		}
+
+		set_logical_state(dd, LSTATE_ARMED);
+		ret = wait_logical_linkstate(ppd, IB_PORT_ARMED, 1000);
+		if (ret) {
+			ppd_dev_err(ppd,
+				    "%s: logical state did not change to ARMED\n",
+				    __func__);
+			break;
+		}
+		ppd->host_link_state = HLS_UP_ARMED;
+		update_statusp(ppd, IB_PORT_ARMED);
+		break;
+	case HLS_UP_ACTIVE:
+		if (ppd->host_link_state != HLS_UP_ARMED)
+			goto unexpected;
+
+		set_logical_state(dd, LSTATE_ACTIVE);
+		ret = wait_logical_linkstate(ppd, IB_PORT_ACTIVE, 1000);
+		if (ret) {
+			ppd_dev_err(ppd,
+				    "%s: logical state did not change to ACTIVE\n",
+				    __func__);
+		} else {
+			ppd->host_link_state = HLS_UP_ACTIVE;
+			update_statusp(ppd, IB_PORT_ACTIVE);
+			go_port_active(ppd);
+		}
+		break;
+	case HLS_DN_POLL:
+		if ((ppd->host_link_state == HLS_DN_DISABLE ||
+		     ppd->host_link_state == HLS_DN_OFFLINE) &&
+		    dd->dc_shutdown)
+			dc_start(dd);
+		/* Hand LED control to the DC */
+		write_csr(dd, DCC_CFG_LED_CNTRL, 0);
+
+		if (ppd->host_link_state != HLS_DN_OFFLINE) {
+			u8 tmp = ppd->link_enabled;
+
+			ret = goto_offline(ppd, ppd->remote_link_down_reason);
+			if (ret) {
+				ppd->link_enabled = tmp;
+				break;
+			}
+			ppd->remote_link_down_reason = 0;
+
+			if (ppd->driver_link_ready)
+				ppd->link_enabled = 1;
+		}
+
+		set_all_slowpath(ppd);
+		ret = set_local_link_attributes(ppd);
+		if (ret)
+			break;
+
+		ppd->port_error_action = 0;
+
+		if (quick_linkup) {
+			/* quick linkup does not go into polling */
+			ret = do_quick_linkup(dd);
+		} else {
+			ret1 = set_physical_link_state(dd, PLS_POLLING);
+			if (!ret1)
+				ret1 = wait_phys_link_out_of_offline(ppd,
+								     3000);
+			if (ret1 != HCMD_SUCCESS) {
+				ppd_dev_err(ppd,
+					    "Failed to transition to Polling link state, return 0x%x\n",
+					    ret1);
+				ret = -EINVAL;
+			}
+		}
+
+		/*
+		 * Change the host link state after requesting DC8051 to
+		 * change its physical state so that we can ignore any
+		 * interrupt with stale LNI(XX) error, which will not be
+		 * cleared until DC8051 transitions to Polling state.
+		 */
+		ppd->host_link_state = HLS_DN_POLL;
+		ppd->offline_disabled_reason =
+			HFI2_ODR_MASK(OPA_LINKDOWN_REASON_NONE);
+		/*
+		 * If an error occurred above, go back to offline.  The
+		 * caller may reschedule another attempt.
+		 */
+		if (ret)
+			goto_offline(ppd, 0);
+		else
+			log_physical_state(ppd, PLS_POLLING);
+		break;
+	case HLS_DN_DISABLE:
+		/* link is disabled */
+		ppd->link_enabled = 0;
+
+		/* allow any state to transition to disabled */
+
+		/* must transition to offline first */
+		if (ppd->host_link_state != HLS_DN_OFFLINE) {
+			ret = goto_offline(ppd, ppd->remote_link_down_reason);
+			if (ret)
+				break;
+			ppd->remote_link_down_reason = 0;
+		}
+
+		if (!dd->dc_shutdown) {
+			ret1 = set_physical_link_state(dd, PLS_DISABLED);
+			if (ret1 != HCMD_SUCCESS) {
+				ppd_dev_err(ppd,
+					    "Failed to transition to Disabled link state, return 0x%x\n",
+					    ret1);
+				ret = -EINVAL;
+				break;
+			}
+			ret = wait_physical_linkstate(ppd, PLS_DISABLED, 10000);
+			if (ret) {
+				ppd_dev_err(ppd,
+					    "%s: physical state did not change to DISABLED\n",
+					    __func__);
+				break;
+			}
+			dc_shutdown(dd);
+		}
+		ppd->host_link_state = HLS_DN_DISABLE;
+		break;
+	case HLS_DN_OFFLINE:
+		if (ppd->host_link_state == HLS_DN_DISABLE)
+			dc_start(dd);
+
+		/* allow any state to transition to offline */
+		ret = goto_offline(ppd, ppd->remote_link_down_reason);
+		if (!ret)
+			ppd->remote_link_down_reason = 0;
+		break;
+	case HLS_VERIFY_CAP:
+		if (ppd->host_link_state != HLS_DN_POLL)
+			goto unexpected;
+		ppd->host_link_state = HLS_VERIFY_CAP;
+		log_physical_state(ppd, PLS_CONFIGPHY_VERIFYCAP);
+		break;
+	case HLS_GOING_UP:
+		if (ppd->host_link_state != HLS_VERIFY_CAP)
+			goto unexpected;
+
+		ret1 = set_physical_link_state(dd, PLS_LINKUP);
+		if (ret1 != HCMD_SUCCESS) {
+			ppd_dev_err(ppd,
+				    "Failed to transition to link up state, return 0x%x\n",
+				    ret1);
+			ret = -EINVAL;
+			break;
+		}
+		ppd->host_link_state = HLS_GOING_UP;
+		break;
+
+	case HLS_GOING_OFFLINE:		/* transient within goto_offline() */
+	case HLS_LINK_COOLDOWN:		/* transient within goto_offline() */
+	default:
+		ppd_dev_info(ppd, "%s: state 0x%x: not supported\n",
+			     __func__, state);
+		ret = -EINVAL;
+		break;
+	}
+
+	goto done;
+
+unexpected:
+	ppd_dev_err(ppd, "%s: unexpected state transition from %s to %s\n",
+		    __func__, link_state_name(ppd->host_link_state),
+		    link_state_name(state));
+	ret = -EINVAL;
+
+done:
+	mutex_unlock(&ppd->hls_lock);
+
+	return ret;
+}
+
+int hfi2_set_ib_cfg(struct hfi2_pportdata *ppd, int which, u32 val)
+{
+	u64 reg;
+	int ret = 0;
+
+	switch (which) {
+	case HFI2_IB_CFG_LIDLMC:
+		set_lidlmc(ppd);
+		break;
+	case HFI2_IB_CFG_VL_HIGH_LIMIT:
+		/*
+		 * The VL Arbitrator high limit is sent in units of 4k
+		 * bytes, while HFI stores it in units of 64 bytes.
+		 */
+		val *= 4096 / 64;
+		reg = ((u64)val & SEND_HIGH_PRIORITY_LIMIT_LIMIT_MASK)
+			<< SEND_HIGH_PRIORITY_LIMIT_LIMIT_SHIFT;
+		write_eport_csr(ppd->dd, ppd->hw_pidx,
+				ppd->dd->params->send_high_priority_limit_reg,
+				reg);
+		break;
+	case HFI2_IB_CFG_LINKDEFAULT: /* IB link default (sleep/poll) */
+		/* HFI only supports POLL as the default link down state */
+		if (val != HLS_DN_POLL)
+			ret = -EINVAL;
+		break;
+	case HFI2_IB_CFG_OP_VLS:
+		if (ppd->vls_operational != val) {
+			ppd->vls_operational = val;
+			if (!ppd->port)
+				ret = -EINVAL;
+		}
+		break;
+	/*
+	 * For link width, link width downgrade, and speed enable, always AND
+	 * the setting with what is actually supported.  This has two benefits.
+	 * First, enabled can't have unsupported values, no matter what the
+	 * SM or FM might want.  Second, the ALL_SUPPORTED wildcards that mean
+	 * "fill in with your supported value" have all the bits in the
+	 * field set, so simply ANDing with supported has the desired result.
+	 */
+	case HFI2_IB_CFG_LWID_ENB: /* set allowed Link-width */
+		ppd->link_width_enabled = val & ppd->link_width_supported;
+		break;
+	case HFI2_IB_CFG_LWID_DG_ENB: /* set allowed link width downgrade */
+		ppd->link_width_downgrade_enabled =
+				val & ppd->link_width_downgrade_supported;
+		break;
+	case HFI2_IB_CFG_SPD_ENB: /* allowed Link speeds */
+		ppd->link_speed_enabled = val & ppd->link_speed_supported;
+		break;
+	case HFI2_IB_CFG_OVERRUN_THRESH: /* IB overrun threshold */
+		/*
+		 * HFI does not follow IB specs, save this value
+		 * so we can report it, if asked.
+		 */
+		ppd->overrun_threshold = val;
+		break;
+	case HFI2_IB_CFG_PHYERR_THRESH: /* IB PHY error threshold */
+		/*
+		 * HFI does not follow IB specs, save this value
+		 * so we can report it, if asked.
+		 */
+		ppd->phy_error_threshold = val;
+		break;
+
+	case HFI2_IB_CFG_MTU:
+		set_send_length(ppd);
+		break;
+
+	case HFI2_IB_CFG_PKEYS:
+		if (HFI2_CAP_IS_KSET(PKEY_CHECK))
+			set_partition_keys(ppd);
+		break;
+
+	default:
+		if (HFI2_CAP_IS_KSET(PRINT_UNIMPL))
+			ppd_dev_info(ppd,
+				     "%s: which %s, val 0x%x: not implemented\n",
+				     __func__, ib_cfg_name(which), val);
+		break;
+	}
+	return ret;
+}
+
+/* begin functions related to vl arbitration table caching */
+static void init_vl_arb_caches(struct hfi2_pportdata *ppd)
+{
+	int i;
+
+	BUILD_BUG_ON(VL_ARB_TABLE_SIZE !=
+			VL_ARB_LOW_PRIO_TABLE_SIZE);
+	BUILD_BUG_ON(VL_ARB_TABLE_SIZE !=
+			VL_ARB_HIGH_PRIO_TABLE_SIZE);
+
+	/*
+	 * Note that we always return values directly from the
+	 * 'vl_arb_cache' (and do no CSR reads) in response to a
+	 * 'Get(VLArbTable)'. This is obviously correct after a
+	 * 'Set(VLArbTable)', since the cache will then be up to
+	 * date. But it's also correct prior to any 'Set(VLArbTable)'
+	 * since then both the cache, and the relevant h/w registers
+	 * will be zeroed.
+	 */
+
+	for (i = 0; i < MAX_PRIO_TABLE; i++)
+		spin_lock_init(&ppd->vl_arb_cache[i].lock);
+}
+
+/*
+ * vl_arb_lock_cache
+ *
+ * All other vl_arb_* functions should be called only after locking
+ * the cache.
+ */
+static inline struct vl_arb_cache *
+vl_arb_lock_cache(struct hfi2_pportdata *ppd, int idx)
+{
+	if (idx != LO_PRIO_TABLE && idx != HI_PRIO_TABLE)
+		return NULL;
+	spin_lock(&ppd->vl_arb_cache[idx].lock);
+	return &ppd->vl_arb_cache[idx];
+}
+
+static inline void vl_arb_unlock_cache(struct hfi2_pportdata *ppd, int idx)
+{
+	spin_unlock(&ppd->vl_arb_cache[idx].lock);
+}
+
+static void vl_arb_get_cache(struct vl_arb_cache *cache,
+			     struct ib_vl_weight_elem *vl)
+{
+	memcpy(vl, cache->table, VL_ARB_TABLE_SIZE * sizeof(*vl));
+}
+
+static void vl_arb_set_cache(struct vl_arb_cache *cache,
+			     struct ib_vl_weight_elem *vl)
+{
+	memcpy(cache->table, vl, VL_ARB_TABLE_SIZE * sizeof(*vl));
+}
+
+static int vl_arb_match_cache(struct vl_arb_cache *cache,
+			      struct ib_vl_weight_elem *vl)
+{
+	return !memcmp(cache->table, vl, VL_ARB_TABLE_SIZE * sizeof(*vl));
+}
+
+/* end functions related to vl arbitration table caching */
+
+static int set_vl_weights(struct hfi2_pportdata *ppd, u32 target,
+			  u32 size, struct ib_vl_weight_elem *vl)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+	unsigned int i, is_up = 0;
+	int drain, ret = 0;
+
+	/* only set the registers on WFR */
+	if (dd->params->chip_type != CHIP_WFR)
+		return 0;
+
+	mutex_lock(&ppd->hls_lock);
+
+	if (ppd->host_link_state & HLS_UP)
+		is_up = 1;
+
+	drain = !is_ax(dd) && is_up;
+
+	if (drain)
+		/*
+		 * Before adjusting VL arbitration weights, empty per-VL
+		 * FIFOs, otherwise a packet whose VL weight is being
+		 * set to 0 could get stuck in a FIFO with no chance to
+		 * egress.
+		 */
+		ret = stop_drain_data_vls(ppd);
+
+	if (ret) {
+		ppd_dev_err(ppd,
+			    "%s: cannot stop/drain VLs - refusing to change VL arbitration weights\n",
+			    __func__);
+		goto err;
+	}
+
+	for (i = 0; i < size; i++, vl++) {
+		/*
+		 * NOTE: The low priority shift and mask are used here, but
+		 * they are the same for both the low and high registers.
+		 */
+		reg = (((u64)vl->vl & SEND_LOW_PRIORITY_LIST_VL_MASK)
+				<< SEND_LOW_PRIORITY_LIST_VL_SHIFT)
+		      | (((u64)vl->weight
+				& SEND_LOW_PRIORITY_LIST_WEIGHT_MASK)
+				<< SEND_LOW_PRIORITY_LIST_WEIGHT_SHIFT);
+		write_eport_csr(dd, ppd->hw_pidx, target + (i * 8), reg);
+	}
+	pio_send_control(ppd, PSC_GLOBAL_VLARB_ENABLE);
+
+	if (drain)
+		open_fill_data_vls(ppd); /* reopen all VLs */
+
+err:
+	mutex_unlock(&ppd->hls_lock);
+
+	return ret;
+}
+
+/*
+ * Read one credit merge VL register.
+ */
+static void read_one_cm_vl(struct hfi2_pportdata *ppd, u32 csr,
+			   struct vl_limit *vll)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg = read_eport_csr(dd, ppd->hw_pidx, csr);
+
+	vll->dedicated = cpu_to_be16(
+		(reg >> SEND_CM_CREDIT_VL_DEDICATED_LIMIT_VL_SHIFT)
+		& SEND_CM_CREDIT_VL_DEDICATED_LIMIT_VL_MASK);
+	vll->shared = cpu_to_be16(
+		(reg >> SEND_CM_CREDIT_VL_SHARED_LIMIT_VL_SHIFT)
+		& SEND_CM_CREDIT_VL_SHARED_LIMIT_VL_MASK);
+}
+
+/*
+ * Read the current credit merge limits.
+ */
+static int get_buffer_control(struct hfi2_pportdata *ppd,
+			      struct buffer_control *bc, u16 *overall_limit)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+	int i;
+
+	/* not all entries are filled in */
+	memset(bc, 0, sizeof(*bc));
+
+	/* OPA and HFI have a 1-1 mapping */
+	for (i = 0; i < TXE_NUM_DATA_VL; i++)
+		read_one_cm_vl(ppd, dd->params->send_cm_credit_vl_reg + (8 * i), &bc->vl[i]);
+
+	/* NOTE: assumes that VL* and VL15 CSRs are bit-wise identical */
+	read_one_cm_vl(ppd, dd->params->send_cm_credit_vl15_reg, &bc->vl[15]);
+
+	reg = read_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg);
+	bc->overall_shared_limit = cpu_to_be16(
+		(reg >> SEND_CM_GLOBAL_CREDIT_SHARED_LIMIT_SHIFT)
+		& SEND_CM_GLOBAL_CREDIT_SHARED_LIMIT_MASK);
+	if (overall_limit)
+		*overall_limit = (reg
+			>> SEND_CM_GLOBAL_CREDIT_TOTAL_CREDIT_LIMIT_SHIFT)
+			& SEND_CM_GLOBAL_CREDIT_TOTAL_CREDIT_LIMIT_MASK;
+	return sizeof(struct buffer_control);
+}
+
+static int get_sc2vlnt(struct hfi2_devdata *dd, struct sc2vlnt *dp)
+{
+	u64 reg;
+	int i;
+
+	/* each register contains 16 SC->VLnt mappings, 4 bits each */
+	reg = read_csr(dd, DCC_CFG_SC_VL_TABLE_15_0);
+	for (i = 0; i < sizeof(u64); i++) {
+		u8 byte = *(((u8 *)&reg) + i);
+
+		dp->vlnt[2 * i] = byte & 0xf;
+		dp->vlnt[(2 * i) + 1] = (byte & 0xf0) >> 4;
+	}
+
+	reg = read_csr(dd, DCC_CFG_SC_VL_TABLE_31_16);
+	for (i = 0; i < sizeof(u64); i++) {
+		u8 byte = *(((u8 *)&reg) + i);
+
+		dp->vlnt[16 + (2 * i)] = byte & 0xf;
+		dp->vlnt[16 + (2 * i) + 1] = (byte & 0xf0) >> 4;
+	}
+	return sizeof(struct sc2vlnt);
+}
+
+static void get_vlarb_preempt(struct hfi2_devdata *dd, u32 nelems,
+			      struct ib_vl_weight_elem *vl)
+{
+	unsigned int i;
+
+	for (i = 0; i < nelems; i++, vl++) {
+		vl->vl = 0xf;
+		vl->weight = 0;
+	}
+}
+
+static void set_sc2vlnt(struct hfi2_devdata *dd, struct sc2vlnt *dp)
+{
+	write_csr(dd, DCC_CFG_SC_VL_TABLE_15_0,
+		  DC_SC_VL_VAL(15_0,
+			       0, dp->vlnt[0] & 0xf,
+			       1, dp->vlnt[1] & 0xf,
+			       2, dp->vlnt[2] & 0xf,
+			       3, dp->vlnt[3] & 0xf,
+			       4, dp->vlnt[4] & 0xf,
+			       5, dp->vlnt[5] & 0xf,
+			       6, dp->vlnt[6] & 0xf,
+			       7, dp->vlnt[7] & 0xf,
+			       8, dp->vlnt[8] & 0xf,
+			       9, dp->vlnt[9] & 0xf,
+			       10, dp->vlnt[10] & 0xf,
+			       11, dp->vlnt[11] & 0xf,
+			       12, dp->vlnt[12] & 0xf,
+			       13, dp->vlnt[13] & 0xf,
+			       14, dp->vlnt[14] & 0xf,
+			       15, dp->vlnt[15] & 0xf));
+	write_csr(dd, DCC_CFG_SC_VL_TABLE_31_16,
+		  DC_SC_VL_VAL(31_16,
+			       16, dp->vlnt[16] & 0xf,
+			       17, dp->vlnt[17] & 0xf,
+			       18, dp->vlnt[18] & 0xf,
+			       19, dp->vlnt[19] & 0xf,
+			       20, dp->vlnt[20] & 0xf,
+			       21, dp->vlnt[21] & 0xf,
+			       22, dp->vlnt[22] & 0xf,
+			       23, dp->vlnt[23] & 0xf,
+			       24, dp->vlnt[24] & 0xf,
+			       25, dp->vlnt[25] & 0xf,
+			       26, dp->vlnt[26] & 0xf,
+			       27, dp->vlnt[27] & 0xf,
+			       28, dp->vlnt[28] & 0xf,
+			       29, dp->vlnt[29] & 0xf,
+			       30, dp->vlnt[30] & 0xf,
+			       31, dp->vlnt[31] & 0xf));
+}
+
+static void nonzero_msg(struct hfi2_devdata *dd, int idx, const char *what,
+			u16 limit)
+{
+	if (limit != 0)
+		dd_dev_info(dd, "Invalid %s limit %d on VL %d, ignoring\n",
+			    what, (int)limit, idx);
+}
+
+/* change only the shared limit portion of SendCmGLobalCredit */
+static void set_global_shared(struct hfi2_pportdata *ppd, u16 limit)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+
+	reg = read_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg);
+	reg &= ~SEND_CM_GLOBAL_CREDIT_SHARED_LIMIT_SMASK;
+	reg |= (u64)limit << SEND_CM_GLOBAL_CREDIT_SHARED_LIMIT_SHIFT;
+	write_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg, reg);
+}
+
+/* change only the total credit limit portion of SendCmGLobalCredit */
+static void set_global_limit(struct hfi2_pportdata *ppd, u16 limit)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+
+	reg = read_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg);
+	reg &= ~SEND_CM_GLOBAL_CREDIT_TOTAL_CREDIT_LIMIT_SMASK;
+	reg |= (u64)limit << SEND_CM_GLOBAL_CREDIT_TOTAL_CREDIT_LIMIT_SHIFT;
+	write_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg, reg);
+}
+
+/* set the given per-VL shared limit */
+static void set_vl_shared(struct hfi2_pportdata *ppd, int vl, u16 limit)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+	u32 addr;
+
+	if (vl < TXE_NUM_DATA_VL)
+		addr = dd->params->send_cm_credit_vl_reg + (8 * vl);
+	else
+		addr = dd->params->send_cm_credit_vl15_reg;
+
+	reg = read_eport_csr(dd, ppd->hw_pidx, addr);
+	reg &= ~SEND_CM_CREDIT_VL_SHARED_LIMIT_VL_SMASK;
+	reg |= (u64)limit << SEND_CM_CREDIT_VL_SHARED_LIMIT_VL_SHIFT;
+	write_eport_csr(dd, ppd->hw_pidx, addr, reg);
+}
+
+/* set the given per-VL dedicated limit */
+static void set_vl_dedicated(struct hfi2_pportdata *ppd, int vl, u16 limit)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+	u32 addr;
+
+	if (vl < TXE_NUM_DATA_VL)
+		addr = dd->params->send_cm_credit_vl_reg + (8 * vl);
+	else
+		addr = dd->params->send_cm_credit_vl15_reg;
+
+	reg = read_eport_csr(dd, ppd->hw_pidx, addr);
+	reg &= ~SEND_CM_CREDIT_VL_DEDICATED_LIMIT_VL_SMASK;
+	reg |= (u64)limit << SEND_CM_CREDIT_VL_DEDICATED_LIMIT_VL_SHIFT;
+	write_eport_csr(dd, ppd->hw_pidx, addr, reg);
+}
+
+/* spin until the given per-VL status mask bits clear */
+static void wait_for_vl_status_clear(struct hfi2_pportdata *ppd, u64 mask,
+				     const char *which)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	unsigned long timeout;
+	u64 reg;
+
+	timeout = jiffies + msecs_to_jiffies(VL_STATUS_CLEAR_TIMEOUT);
+	while (1) {
+		reg = read_eport_csr(dd, ppd->hw_pidx,
+				     dd->params->send_cm_credit_used_status_reg)
+				     & mask;
+
+		if (reg == 0)
+			return;	/* success */
+		if (time_after(jiffies, timeout))
+			break;		/* timed out */
+		udelay(1);
+	}
+
+	ppd_dev_err(ppd,
+		    "%s credit change status not clearing after %dms, mask 0x%llx, not clear 0x%llx\n",
+		    which, VL_STATUS_CLEAR_TIMEOUT, mask, reg);
+	/*
+	 * If this occurs, it is likely there was a credit loss on the link.
+	 * The only recovery from that is a link bounce.
+	 */
+	ppd_dev_err(ppd,
+		    "Continuing anyway.  A credit loss may occur.  Suggest a link bounce\n");
+}
+
+/*
+ * The number of credits on the VLs may be changed while everything
+ * is "live", but the following algorithm must be followed due to
+ * how the hardware is actually implemented.  In particular,
+ * Return_Credit_Status[] is the only correct status check.
+ *
+ * if (reducing Global_Shared_Credit_Limit or any shared limit changing)
+ *     set Global_Shared_Credit_Limit = 0
+ *     use_all_vl = 1
+ * mask0 = all VLs that are changing either dedicated or shared limits
+ * set Shared_Limit[mask0] = 0
+ * spin until Return_Credit_Status[use_all_vl ? all VL : mask0] == 0
+ * if (changing any dedicated limit)
+ *     mask1 = all VLs that are lowering dedicated limits
+ *     lower Dedicated_Limit[mask1]
+ *     spin until Return_Credit_Status[mask1] == 0
+ *     raise Dedicated_Limits
+ * raise Shared_Limits
+ * raise Global_Shared_Credit_Limit
+ *
+ * lower = if the new limit is lower, set the limit to the new value
+ * raise = if the new limit is higher than the current value (may be changed
+ *	earlier in the algorithm), set the new limit to the new value
+ */
+int set_buffer_control(struct hfi2_pportdata *ppd,
+		       struct buffer_control *new_bc)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 changing_mask, ld_mask, stat_mask;
+	int change_count;
+	int i, use_all_mask;
+	int this_shared_changing;
+	int vl_count = 0, ret;
+	/*
+	 * A0: add the variable any_shared_limit_changing below and in the
+	 * algorithm above.  If removing A0 support, it can be removed.
+	 */
+	int any_shared_limit_changing;
+	struct buffer_control cur_bc;
+	u8 changing[OPA_MAX_VLS];
+	u8 lowering_dedicated[OPA_MAX_VLS];
+	u16 cur_total;
+	u32 new_total = 0;
+	const u64 all_mask =
+	SEND_CM_CREDIT_USED_STATUS_VL0_RETURN_CREDIT_STATUS_SMASK
+	 | SEND_CM_CREDIT_USED_STATUS_VL1_RETURN_CREDIT_STATUS_SMASK
+	 | SEND_CM_CREDIT_USED_STATUS_VL2_RETURN_CREDIT_STATUS_SMASK
+	 | SEND_CM_CREDIT_USED_STATUS_VL3_RETURN_CREDIT_STATUS_SMASK
+	 | SEND_CM_CREDIT_USED_STATUS_VL4_RETURN_CREDIT_STATUS_SMASK
+	 | SEND_CM_CREDIT_USED_STATUS_VL5_RETURN_CREDIT_STATUS_SMASK
+	 | SEND_CM_CREDIT_USED_STATUS_VL6_RETURN_CREDIT_STATUS_SMASK
+	 | SEND_CM_CREDIT_USED_STATUS_VL7_RETURN_CREDIT_STATUS_SMASK
+	 | SEND_CM_CREDIT_USED_STATUS_VL15_RETURN_CREDIT_STATUS_SMASK;
+
+#define valid_vl(idx) ((idx) < TXE_NUM_DATA_VL || (idx) == 15)
+#define NUM_USABLE_VLS 16	/* look at VL15 and less */
+
+	/* find the new total credits, do sanity check on unused VLs */
+	for (i = 0; i < OPA_MAX_VLS; i++) {
+		if (valid_vl(i)) {
+			new_total += be16_to_cpu(new_bc->vl[i].dedicated);
+			continue;
+		}
+		nonzero_msg(dd, i, "dedicated",
+			    be16_to_cpu(new_bc->vl[i].dedicated));
+		nonzero_msg(dd, i, "shared",
+			    be16_to_cpu(new_bc->vl[i].shared));
+		new_bc->vl[i].dedicated = 0;
+		new_bc->vl[i].shared = 0;
+	}
+	new_total += be16_to_cpu(new_bc->overall_shared_limit);
+
+	/* fetch the current values */
+	get_buffer_control(ppd, &cur_bc, &cur_total);
+
+	/*
+	 * Create the masks we will use.
+	 */
+	memset(changing, 0, sizeof(changing));
+	memset(lowering_dedicated, 0, sizeof(lowering_dedicated));
+	/*
+	 * NOTE: Assumes that the individual VL bits are adjacent and in
+	 * increasing order
+	 */
+	stat_mask =
+		SEND_CM_CREDIT_USED_STATUS_VL0_RETURN_CREDIT_STATUS_SMASK;
+	changing_mask = 0;
+	ld_mask = 0;
+	change_count = 0;
+	any_shared_limit_changing = 0;
+	for (i = 0; i < NUM_USABLE_VLS; i++, stat_mask <<= 1) {
+		if (!valid_vl(i))
+			continue;
+		this_shared_changing = new_bc->vl[i].shared
+						!= cur_bc.vl[i].shared;
+		if (this_shared_changing)
+			any_shared_limit_changing = 1;
+		if (new_bc->vl[i].dedicated != cur_bc.vl[i].dedicated ||
+		    this_shared_changing) {
+			changing[i] = 1;
+			changing_mask |= stat_mask;
+			change_count++;
+		}
+		if (be16_to_cpu(new_bc->vl[i].dedicated) <
+					be16_to_cpu(cur_bc.vl[i].dedicated)) {
+			lowering_dedicated[i] = 1;
+			ld_mask |= stat_mask;
+		}
+	}
+
+	/* bracket the credit change with a total adjustment */
+	if (new_total > cur_total)
+		set_global_limit(ppd, new_total);
+
+	/*
+	 * Start the credit change algorithm.
+	 */
+	use_all_mask = 0;
+	if ((be16_to_cpu(new_bc->overall_shared_limit) <
+	     be16_to_cpu(cur_bc.overall_shared_limit)) ||
+	    (is_ax(dd) && any_shared_limit_changing)) {
+		set_global_shared(ppd, 0);
+		cur_bc.overall_shared_limit = 0;
+		use_all_mask = 1;
+	}
+
+	for (i = 0; i < NUM_USABLE_VLS; i++) {
+		if (!valid_vl(i))
+			continue;
+
+		if (changing[i]) {
+			set_vl_shared(ppd, i, 0);
+			cur_bc.vl[i].shared = 0;
+		}
+	}
+
+	wait_for_vl_status_clear(ppd, use_all_mask ? all_mask : changing_mask,
+				 "shared");
+
+	if (change_count > 0) {
+		for (i = 0; i < NUM_USABLE_VLS; i++) {
+			if (!valid_vl(i))
+				continue;
+
+			if (lowering_dedicated[i]) {
+				set_vl_dedicated(ppd, i,
+						 be16_to_cpu(new_bc->
+							     vl[i].dedicated));
+				cur_bc.vl[i].dedicated =
+						new_bc->vl[i].dedicated;
+			}
+		}
+
+		wait_for_vl_status_clear(ppd, ld_mask, "dedicated");
+
+		/* now raise all dedicated that are going up */
+		for (i = 0; i < NUM_USABLE_VLS; i++) {
+			if (!valid_vl(i))
+				continue;
+
+			if (be16_to_cpu(new_bc->vl[i].dedicated) >
+					be16_to_cpu(cur_bc.vl[i].dedicated))
+				set_vl_dedicated(ppd, i,
+						 be16_to_cpu(new_bc->
+							     vl[i].dedicated));
+		}
+	}
+
+	/* next raise all shared that are going up */
+	for (i = 0; i < NUM_USABLE_VLS; i++) {
+		if (!valid_vl(i))
+			continue;
+
+		if (be16_to_cpu(new_bc->vl[i].shared) >
+				be16_to_cpu(cur_bc.vl[i].shared))
+			set_vl_shared(ppd, i, be16_to_cpu(new_bc->vl[i].shared));
+	}
+
+	/* finally raise the global shared */
+	if (be16_to_cpu(new_bc->overall_shared_limit) >
+	    be16_to_cpu(cur_bc.overall_shared_limit))
+		set_global_shared(ppd,
+				  be16_to_cpu(new_bc->overall_shared_limit));
+
+	/* bracket the credit change with a total adjustment */
+	if (new_total < cur_total)
+		set_global_limit(ppd, new_total);
+
+	/*
+	 * Determine the actual number of operational VLS using the number of
+	 * dedicated and shared credits for each VL.
+	 */
+	if (change_count > 0) {
+		for (i = 0; i < TXE_NUM_DATA_VL; i++)
+			if (be16_to_cpu(new_bc->vl[i].dedicated) > 0 ||
+			    be16_to_cpu(new_bc->vl[i].shared) > 0)
+				vl_count++;
+		ppd->actual_vls_operational = vl_count;
+		ret = sdma_map_init(ppd, vl_count ?
+				    ppd->actual_vls_operational :
+				    ppd->vls_operational,
+				    NULL);
+		if (ret == 0)
+			ret = pio_map_init(ppd, vl_count ?
+					   ppd->actual_vls_operational :
+					   ppd->vls_operational);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+/*
+ * Read the given fabric manager table. Return the size of the
+ * table (in bytes) on success, and a negative error code on
+ * failure.
+ */
+int fm_get_table(struct hfi2_pportdata *ppd, int which, void *t)
+
+{
+	int size;
+	struct vl_arb_cache *vlc;
+
+	switch (which) {
+	case FM_TBL_VL_HIGH_ARB:
+		size = 256;
+		/*
+		 * OPA specifies 128 elements (of 2 bytes each), though
+		 * HFI supports only 16 elements in h/w.
+		 */
+		vlc = vl_arb_lock_cache(ppd, HI_PRIO_TABLE);
+		vl_arb_get_cache(vlc, t);
+		vl_arb_unlock_cache(ppd, HI_PRIO_TABLE);
+		break;
+	case FM_TBL_VL_LOW_ARB:
+		size = 256;
+		/*
+		 * OPA specifies 128 elements (of 2 bytes each), though
+		 * HFI supports only 16 elements in h/w.
+		 */
+		vlc = vl_arb_lock_cache(ppd, LO_PRIO_TABLE);
+		vl_arb_get_cache(vlc, t);
+		vl_arb_unlock_cache(ppd, LO_PRIO_TABLE);
+		break;
+	case FM_TBL_BUFFER_CONTROL:
+		size = get_buffer_control(ppd, t, NULL);
+		break;
+	case FM_TBL_SC2VLNT:
+		size = get_sc2vlnt(ppd->dd, t);
+		break;
+	case FM_TBL_VL_PREEMPT_ELEMS:
+		size = 256;
+		/* OPA specifies 128 elements, of 2 bytes each */
+		get_vlarb_preempt(ppd->dd, OPA_MAX_VLS, t);
+		break;
+	case FM_TBL_VL_PREEMPT_MATRIX:
+		size = 256;
+		/*
+		 * OPA specifies that this is the same size as the VL
+		 * arbitration tables (i.e., 256 bytes).
+		 */
+		break;
+	default:
+		return -EINVAL;
+	}
+	return size;
+}
+
+/*
+ * Write the given fabric manager table.
+ */
+int fm_set_table(struct hfi2_pportdata *ppd, int which, void *t)
+{
+	int ret = 0;
+	struct vl_arb_cache *vlc;
+
+	switch (which) {
+	case FM_TBL_VL_HIGH_ARB:
+		vlc = vl_arb_lock_cache(ppd, HI_PRIO_TABLE);
+		if (vl_arb_match_cache(vlc, t)) {
+			vl_arb_unlock_cache(ppd, HI_PRIO_TABLE);
+			break;
+		}
+		vl_arb_set_cache(vlc, t);
+		vl_arb_unlock_cache(ppd, HI_PRIO_TABLE);
+		ret = set_vl_weights(ppd, ppd->dd->params->send_high_priority_list_reg,
+				     VL_ARB_HIGH_PRIO_TABLE_SIZE, t);
+		break;
+	case FM_TBL_VL_LOW_ARB:
+		vlc = vl_arb_lock_cache(ppd, LO_PRIO_TABLE);
+		if (vl_arb_match_cache(vlc, t)) {
+			vl_arb_unlock_cache(ppd, LO_PRIO_TABLE);
+			break;
+		}
+		vl_arb_set_cache(vlc, t);
+		vl_arb_unlock_cache(ppd, LO_PRIO_TABLE);
+		ret = set_vl_weights(ppd, ppd->dd->params->send_low_priority_list_reg,
+				     VL_ARB_LOW_PRIO_TABLE_SIZE, t);
+		break;
+	case FM_TBL_BUFFER_CONTROL:
+		ret = set_buffer_control(ppd, t);
+		break;
+	case FM_TBL_SC2VLNT:
+		set_sc2vlnt(ppd->dd, t);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+/*
+ * Disable all data VLs.
+ *
+ * Return 0 if disabled, non-zero if the VLs cannot be disabled.
+ */
+static int disable_data_vls(struct hfi2_pportdata *ppd)
+{
+	if (is_ax(ppd->dd))
+		return 1;
+
+	pio_send_control(ppd, PSC_DATA_VL_DISABLE);
+
+	return 0;
+}
+
+/*
+ * open_fill_data_vls() - the counterpart to stop_drain_data_vls().
+ * Just re-enables all data VLs (the "fill" part happens
+ * automatically - the name was chosen for symmetry with
+ * stop_drain_data_vls()).
+ *
+ * Return 0 if successful, non-zero if the VLs cannot be enabled.
+ */
+int open_fill_data_vls(struct hfi2_pportdata *ppd)
+{
+	if (is_ax(ppd->dd))
+		return 1;
+
+	pio_send_control(ppd, PSC_DATA_VL_ENABLE);
+
+	return 0;
+}
+
+/*
+ * drain_data_vls() - assumes that disable_data_vls() has been called,
+ * wait for occupancy (of per-VL FIFOs) for all contexts, and SDMA
+ * engines to drop to 0.
+ */
+static void drain_data_vls(struct hfi2_devdata *dd)
+{
+	sc_wait(dd);
+	sdma_wait(dd);
+	pause_for_credit_return(dd);
+}
+
+/*
+ * stop_drain_data_vls() - disable, then drain all per-VL fifos.
+ *
+ * Use open_fill_data_vls() to resume using data VLs.  This pair is
+ * meant to be used like this:
+ *
+ * stop_drain_data_vls(dd);
+ * // do things with per-VL resources
+ * open_fill_data_vls(dd);
+ */
+int stop_drain_data_vls(struct hfi2_pportdata *ppd)
+{
+	int ret;
+
+	ret = disable_data_vls(ppd);
+	if (ret == 0)
+		drain_data_vls(ppd->dd);
+
+	return ret;
+}
+
+/*
+ * Convert a nanosecond time to a cclock count.  No matter how slow
+ * the cclock, a non-zero ns will always have a non-zero result.
+ */
+u32 ns_to_cclock(struct hfi2_devdata *dd, u32 ns)
+{
+	u32 cclocks;
+
+	/* simulation pretends to be ASIC */
+	cclocks = (ns * 1000) / dd->params->asic_cclock_ps;
+	if (ns && !cclocks)	/* if ns nonzero, must be at least 1 */
+		cclocks = 1;
+	return cclocks;
+}
+
+/*
+ * Convert a cclock count to nanoseconds. No matter how slow
+ * the cclock, a non-zero cclocks will always have a non-zero result.
+ */
+u32 cclock_to_ns(struct hfi2_devdata *dd, u32 cclocks)
+{
+	u32 ns;
+
+	/* simulation pretends to be ASIC */
+	ns = (cclocks * dd->params->asic_cclock_ps) / 1000;
+	if (cclocks && !ns)
+		ns = 1;
+	return ns;
+}
+
+/*
+ * Dynamically adjust the receive interrupt timeout for a context based on
+ * incoming packet rate.
+ *
+ * NOTE: Dynamic adjustment does not allow rcv_intr_count to be zero.
+ */
+static void adjust_rcv_timeout(struct hfi2_ctxtdata *rcd, u32 npkts)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+	u32 timeout = rcd->rcvavail_timeout;
+
+	/*
+	 * This algorithm doubles or halves the timeout depending on whether
+	 * the number of packets received in this interrupt were less than or
+	 * greater equal the interrupt count.
+	 *
+	 * The calculations below do not allow a steady state to be achieved.
+	 * Only at the endpoints it is possible to have an unchanging
+	 * timeout.
+	 */
+	if (npkts < rcv_intr_count) {
+		/*
+		 * Not enough packets arrived before the timeout, adjust
+		 * timeout downward.
+		 */
+		if (timeout < 2) /* already at minimum? */
+			return;
+		timeout >>= 1;
+	} else {
+		/*
+		 * More than enough packets arrived before the timeout, adjust
+		 * timeout upward.
+		 */
+		if (timeout >= dd->rcv_intr_timeout_csr) /* already at max? */
+			return;
+		timeout = min(timeout << 1, dd->rcv_intr_timeout_csr);
+	}
+
+	rcd->rcvavail_timeout = timeout;
+	/*
+	 * timeout cannot be larger than rcv_intr_timeout_csr which has already
+	 * been verified to be in range
+	 */
+	write_kctxt_csr(dd, rcd->ctxt, dd->params->rcv_avail_time_out_reg,
+			(u64)timeout <<
+			RCV_AVAIL_TIME_OUT_TIME_OUT_RELOAD_SHIFT);
+}
+
+void update_usrhead(struct hfi2_ctxtdata *rcd, u32 hd, u32 updegr, u32 egrhd,
+		    u32 intr_adjust, u32 npkts)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+	u32 ctxt = rcd->ctxt;
+
+	/*
+	 * Need to write timeout register before updating RcvHdrHead to ensure
+	 * that a new value is used when the HW decides to restart counting.
+	 */
+	if (intr_adjust)
+		adjust_rcv_timeout(rcd, npkts);
+	update_usrhead_ctxt(dd, ctxt, hd, rcv_intr_count, updegr, egrhd);
+}
+
+void update_usrhead_ctxt(struct hfi2_devdata *dd, u16 ctxt, u32 hd, u32 intr_cnt,
+			 u32 updegr, u32 egrhd)
+{
+	u64 reg;
+
+	if (updegr) {
+		reg = (egrhd & RCV_EGR_INDEX_HEAD_HEAD_MASK)
+			<< RCV_EGR_INDEX_HEAD_HEAD_SHIFT;
+		write_uctxt_csr(dd, ctxt, dd->params->rcv_egr_index_head_reg, reg);
+	}
+	reg = ((u64)intr_cnt << RCV_HDR_HEAD_COUNTER_SHIFT) |
+		(((u64)hd & RCV_HDR_HEAD_HEAD_MASK)
+			<< RCV_HDR_HEAD_HEAD_SHIFT);
+	write_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_head_reg, reg);
+}
+
+u32 hdrqempty(struct hfi2_ctxtdata *rcd)
+{
+	u32 head, tail;
+
+	head = (read_uctxt_csr(rcd->dd, rcd->ctxt, rcd->dd->params->rcv_hdr_head_reg)
+		& RCV_HDR_HEAD_HEAD_SMASK) >> RCV_HDR_HEAD_HEAD_SHIFT;
+
+	if (hfi2_rcvhdrtail_kvaddr(rcd))
+		tail = get_rcvhdrtail(rcd);
+	else
+		tail = read_uctxt_csr(rcd->dd, rcd->ctxt, rcd->dd->params->rcv_hdr_tail_reg);
+
+	return head == tail;
+}
+
+/*
+ * Context Control and Receive Array encoding for buffer size:
+ *	0x0 invalid
+ *	0x1   4 KB
+ *	0x2   8 KB
+ *	0x3  16 KB
+ *	0x4  32 KB
+ *	0x5  64 KB
+ *	0x6 128 KB
+ *	0x7 256 KB
+ *	0x8 512 KB (Receive Array only)
+ *	0x9   1 MB (Receive Array only)
+ *	0xa   2 MB (Receive Array only)
+ *
+ *	0xB-0xF - reserved (Receive Array only)
+ *
+ *
+ * This routine assumes that the value has already been sanity checked.
+ */
+u32 hfi2_encoded_size(u32 size)
+{
+	switch (size) {
+	case   4 * 1024: return 0x1;
+	case   8 * 1024: return 0x2;
+	case  16 * 1024: return 0x3;
+	case  32 * 1024: return 0x4;
+	case  64 * 1024: return 0x5;
+	case 128 * 1024: return 0x6;
+	case 256 * 1024: return 0x7;
+	case 512 * 1024: return 0x8;
+	case   1 * 1024 * 1024: return 0x9;
+	case   2 * 1024 * 1024: return 0xa;
+	}
+	return 0x1;	/* if invalid, go with the minimum size */
+}
+
+/**
+ * encode_rcv_header_entry_size - return chip specific encoding for size
+ * @size: size in dwords
+ *
+ * Convert a receive header entry size that to the encoding used in the CSR.
+ *
+ * Return a zero if the given size is invalid, otherwise the encoding.
+ */
+u8 encode_rcv_header_entry_size(u8 size)
+{
+	/* there are only 3 valid receive header entry sizes */
+	if (size == 2)
+		return 1;
+	if (size == 16)
+		return 2;
+	if (size == 32)
+		return 4;
+	return 0; /* invalid */
+}
+
+/**
+ * hfi2_validate_rcvhdrcnt - validate hdrcnt
+ * @dd: the device data
+ * @thecnt: the header count
+ */
+int hfi2_validate_rcvhdrcnt(struct hfi2_devdata *dd, uint thecnt)
+{
+	if (thecnt <= HFI2_MIN_HDRQ_EGRBUF_CNT) {
+		dd_dev_err(dd, "Receive header queue count too small\n");
+		return -EINVAL;
+	}
+
+	if (thecnt > HFI2_MAX_HDRQ_EGRBUF_CNT) {
+		dd_dev_err(dd,
+			   "Receive header queue count cannot be greater than %u\n",
+			   HFI2_MAX_HDRQ_EGRBUF_CNT);
+		return -EINVAL;
+	}
+
+	if (thecnt % HDRQ_INCREMENT) {
+		dd_dev_err(dd, "Receive header queue count %d must be divisible by %lu\n",
+			   thecnt, HDRQ_INCREMENT);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void wfr_update_rcv_hdr_size(struct hfi2_pportdata *ppd, u16 ctxt, u32 size)
+{
+	u64 reg;
+
+	reg = ((u64)size & RCV_HDR_SIZE_HDR_SIZE_MASK) <<
+	      RCV_HDR_SIZE_HDR_SIZE_SHIFT;
+	write_kctxt_csr(ppd->dd, ctxt, RCV_HDR_SIZE, reg);
+}
+
+/**
+ * set_hdrq_regs - set header queue registers for context
+ * @dd: the device data
+ * @ctxt: the context
+ * @entsize: the dword entry size
+ * @hdrcnt: the number of header entries
+ * @kdeth_rcv_hdr: KDETH receive header size
+ */
+void set_hdrq_regs(struct hfi2_pportdata *ppd, u16 ctxt, u8 entsize, u16 hdrcnt,
+		   u8 kdeth_rcv_hdr)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+
+	reg = (((u64)hdrcnt >> HDRQ_SIZE_SHIFT) & RCV_HDR_CNT_CNT_MASK) <<
+	      RCV_HDR_CNT_CNT_SHIFT;
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_cnt_reg, reg);
+	reg = ((u64)encode_rcv_header_entry_size(entsize) &
+	       RCV_HDR_ENT_SIZE_ENT_SIZE_MASK) <<
+	      RCV_HDR_ENT_SIZE_ENT_SIZE_SHIFT;
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_ent_size_reg, reg);
+	dd->params->update_rcv_hdr_size(ppd, ctxt, kdeth_rcv_hdr);
+
+	/*
+	 * Program dummy tail address for every receive context
+	 * before enabling any receive context
+	 */
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_tail_addr_reg,
+			dd->rcvhdrtail_dummy_dma);
+}
+
+/* this is a type of kernel context */
+bool is_control_context(struct hfi2_ctxtdata *rcd)
+{
+	return rcd->ctxt == rcd->ppd->dd->rsrcs.ppr[rcd->ppd->hw_pidx].rcv_context_base +
+			    HFI2_CTRL_CTXT;
+}
+
+/* includes control context */
+bool is_kernel_context(struct hfi2_ctxtdata *rcd)
+{
+	/* assumes in sequential order from base */
+	return rcd->ctxt < rcd->ppd->dd->rsrcs.ppr[rcd->ppd->hw_pidx].first_dyn_alloc_ctxt;
+}
+
+/* includes user contexts */
+bool is_dynamic_context(struct hfi2_ctxtdata *rcd)
+{
+	struct hfi2_pportdata *ppd = rcd->ppd;
+	struct hfi2_devrsrcs *dr = &ppd->dd->rsrcs;
+	struct hfi2_portrsrcs *pr = &dr->ppr[ppd->hw_pidx];
+
+	return rcd->ctxt >= pr->first_dyn_alloc_ctxt &&
+	       rcd->ctxt < (pr->rcv_context_base + pr->num_rcv_contexts);
+}
+
+bool is_user_context(struct hfi2_ctxtdata *rcd)
+{
+	return is_dynamic_context(rcd);
+}
+
+/* WFR specific rcv context enable, disable */
+void wfr_enable_rcv_context(struct hfi2_pportdata *ppd, u16 ctxt,
+			    u64 *kctxt_ctrl, bool enable)
+{
+	/* nothing special needs to be done */
+}
+
+u64 rctxt_ctrl_op(struct hfi2_devdata *dd, u16 ctxt, unsigned int op)
+{
+	u64 rctxt_ctrl;
+
+	if (dd->is_vf)
+		return pf0_rctxt_ctrl_op(dd, ctxt, op);
+
+	rctxt_ctrl = read_rctxt_csr(dd, ctxt, dd->params->rcv_rctxt_ctrl_reg);
+	if (op & HFI2_RCVCTRL_INTRAVAIL_ENB)
+		rctxt_ctrl |= RCV_CTXT_CTRL_INTR_AVAIL_SMASK;
+	if (op & HFI2_RCVCTRL_INTRAVAIL_DIS)
+		rctxt_ctrl &= ~RCV_CTXT_CTRL_INTR_AVAIL_SMASK;
+	if (op & HFI2_RCVCTRL_TIDFLOW_ENB)
+		rctxt_ctrl |= RCV_CTXT_CTRL_TID_FLOW_ENABLE_SMASK;
+	if (op & HFI2_RCVCTRL_TIDFLOW_DIS)
+		rctxt_ctrl &= ~RCV_CTXT_CTRL_TID_FLOW_ENABLE_SMASK;
+	if (op & HFI2_RCVCTRL_NO_RHQ_DROP_ENB)
+		rctxt_ctrl |= RCV_CTXT_CTRL_DONT_DROP_RHQ_FULL_SMASK;
+	if (op & HFI2_RCVCTRL_NO_RHQ_DROP_DIS)
+		rctxt_ctrl &= ~RCV_CTXT_CTRL_DONT_DROP_RHQ_FULL_SMASK;
+	if (op & HFI2_RCVCTRL_NO_EGR_DROP_ENB)
+		rctxt_ctrl |= RCV_CTXT_CTRL_DONT_DROP_EGR_FULL_SMASK;
+	if (op & HFI2_RCVCTRL_NO_EGR_DROP_DIS)
+		rctxt_ctrl &= ~RCV_CTXT_CTRL_DONT_DROP_EGR_FULL_SMASK;
+	write_rctxt_csr(dd, ctxt, dd->params->rcv_rctxt_ctrl_reg, rctxt_ctrl);
+	return rctxt_ctrl;
+}
+
+void hfi2_rcvctrl(struct hfi2_devdata *dd, unsigned int op,
+		  struct hfi2_ctxtdata *rcd)
+{
+	u64 rcvctrl, reg;
+	u64 rctxt_ctrl;
+	int did_enable = 0;
+	u16 ctxt;
+
+	if (!rcd)
+		return;
+
+	ctxt = rcd->ctxt;
+
+	hfi2_cdbg(RCVCTRL, "ctxt %d op 0x%x", ctxt, op);
+
+	rcvctrl = read_kctxt_csr(dd, ctxt, dd->params->rcv_kctxt_ctrl_reg);
+	/* if the context already enabled, don't do the extra steps */
+	if ((op & HFI2_RCVCTRL_CTXT_ENB) &&
+	    !(rcvctrl & RCV_CTXT_CTRL_ENABLE_SMASK)) {
+		/* reset the tail and hdr addresses, and sequence count */
+		write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_addr_reg,
+				rcd->rcvhdrq_dma);
+		if (hfi2_rcvhdrtail_kvaddr(rcd))
+			write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_tail_addr_reg,
+					rcd->rcvhdrqtailaddr_dma);
+		if (dd->params->set_rheq_addr)
+			dd->params->set_rheq_addr(dd, ctxt, rcd->rheq_dma);
+		hfi2_set_seq_cnt(rcd, 1);
+
+		/* reset the cached receive header queue head value */
+		hfi2_set_rcd_head(rcd, 0);
+
+		/*
+		 * Zero the receive header queue so we don't get false
+		 * positives when checking the sequence number.  The
+		 * sequence numbers could land exactly on the same spot.
+		 * E.g. a rcd restart before the receive header wrapped.
+		 */
+		memset(rcd->rcvhdrq, 0, rcvhdrq_size(rcd));
+
+		/* starting timeout */
+		rcd->rcvavail_timeout = dd->rcv_intr_timeout_csr;
+
+		/* enable the context */
+		rcvctrl |= RCV_CTXT_CTRL_ENABLE_SMASK;
+
+		/* clean the egr buffer size first */
+		rcvctrl &= ~RCV_CTXT_CTRL_EGR_BUF_SIZE_SMASK;
+		rcvctrl |= ((u64)hfi2_encoded_size(rcd->egrbufs.rcvtid_size)
+				& RCV_CTXT_CTRL_EGR_BUF_SIZE_MASK)
+					<< RCV_CTXT_CTRL_EGR_BUF_SIZE_SHIFT;
+
+		/* zero RcvHdrHead - set RcvHdrHead.Counter after enable */
+		write_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_head_reg, 0);
+		did_enable = 1;
+
+		/* zero RcvEgrIndexHead */
+		write_uctxt_csr(dd, ctxt, dd->params->rcv_egr_index_head_reg, 0);
+
+		/* WFR only: direct VL15 packets to the control context */
+		if (is_control_context(rcd) && dd->params->chip_type == CHIP_WFR) {
+			write_iport_csr(dd, rcd->ppd->hw_pidx,
+					dd->params->rcv_vl15_reg, ctxt);
+		}
+
+		/* per-chip enable */
+		dd->params->enable_rcv_context(rcd->ppd, ctxt, &rcvctrl, true);
+	}
+	if (op & HFI2_RCVCTRL_CTXT_DIS) {
+		/*
+		 * When receive context is being disabled turn on tail
+		 * update with a dummy tail address and then disable
+		 * receive context.
+		 */
+		if (dd->rcvhdrtail_dummy_dma) {
+			write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_tail_addr_reg,
+					dd->rcvhdrtail_dummy_dma);
+			/* Enabling RcvCtxtCtrl.TailUpd is intentional. */
+			rcvctrl |= RCV_CTXT_CTRL_TAIL_UPD_SMASK;
+		}
+
+		rcvctrl &= ~RCV_CTXT_CTRL_ENABLE_SMASK;
+
+		/* per-chip disable */
+		dd->params->enable_rcv_context(rcd->ppd, ctxt, &rcvctrl, false);
+	}
+	if ((op & HFI2_RCVCTRL_TAILUPD_ENB) && hfi2_rcvhdrtail_kvaddr(rcd))
+		rcvctrl |= RCV_CTXT_CTRL_TAIL_UPD_SMASK;
+	if (op & HFI2_RCVCTRL_TAILUPD_DIS) {
+		/* See comment on RcvCtxtCtrl.TailUpd above */
+		if (!(op & HFI2_RCVCTRL_CTXT_DIS))
+			rcvctrl &= ~RCV_CTXT_CTRL_TAIL_UPD_SMASK;
+	}
+	if (op & HFI2_RCVCTRL_ONE_PKT_EGR_ENB) {
+		/*
+		 * In one-packet-per-eager mode, the size comes from
+		 * the RcvArray entry.
+		 */
+		rcvctrl &= ~RCV_CTXT_CTRL_EGR_BUF_SIZE_SMASK;
+		rcvctrl |= RCV_CTXT_CTRL_ONE_PACKET_PER_EGR_BUFFER_SMASK;
+	}
+	if (op & HFI2_RCVCTRL_ONE_PKT_EGR_DIS)
+		rcvctrl &= ~RCV_CTXT_CTRL_ONE_PACKET_PER_EGR_BUFFER_SMASK;
+	if (op & HFI2_RCVCTRL_URGENT_ENB)
+		set_intr_bits(dd, dd->params->is_rcvurgent_start + ctxt,
+			      dd->params->is_rcvurgent_start + ctxt, true);
+	if (op & HFI2_RCVCTRL_URGENT_DIS)
+		set_intr_bits(dd, dd->params->is_rcvurgent_start + ctxt,
+			      dd->params->is_rcvurgent_start + ctxt, false);
+
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_kctxt_ctrl_reg, rcvctrl);
+
+	if (op & HFI2_RCVCTRL_INTRAVAIL_ENB)
+		set_intr_bits(dd, dd->params->is_rcvavail_start + ctxt,
+			      dd->params->is_rcvavail_start + ctxt, true);
+	if (op & HFI2_RCVCTRL_INTRAVAIL_DIS)
+		set_intr_bits(dd, dd->params->is_rcvavail_start + ctxt,
+			      dd->params->is_rcvavail_start + ctxt, false);
+	rctxt_ctrl = rctxt_ctrl_op(dd, ctxt, op);
+	hfi2_cdbg(RCVCTRL, "ctxt %d kctrl 0x%llx rctrl 0x%llx", ctxt, rcvctrl, rctxt_ctrl);
+
+	/* work around sticky RcvCtxtStatus.BlockedRHQFull */
+	if (did_enable &&
+	    (rctxt_ctrl & RCV_CTXT_CTRL_DONT_DROP_RHQ_FULL_SMASK)) {
+		reg = read_ku_csr(dd, ctxt, dd->params->rcv_ctxt_status_reg);
+		if (reg != 0) {
+			dd_dev_info(dd, "ctxt %d status %lld (blocked)\n",
+				    ctxt, reg);
+			read_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_head_reg);
+			write_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_head_reg, 0x10);
+			write_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_head_reg, 0x00);
+			read_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_head_reg);
+			reg = read_ku_csr(dd, ctxt, dd->params->rcv_ctxt_status_reg);
+			dd_dev_info(dd, "ctxt %d status %lld (%s blocked)\n",
+				    ctxt, reg, reg == 0 ? "not" : "still");
+		}
+	}
+
+	if (did_enable) {
+		/*
+		 * The interrupt timeout and count must be set after
+		 * the context is enabled to take effect.
+		 */
+		/* set interrupt timeout */
+		write_kctxt_csr(dd, ctxt, dd->params->rcv_avail_time_out_reg,
+				(u64)rcd->rcvavail_timeout <<
+				RCV_AVAIL_TIME_OUT_TIME_OUT_RELOAD_SHIFT);
+
+		/* set RcvHdrHead.Counter, zero RcvHdrHead.Head (again) */
+		reg = (u64)rcv_intr_count << RCV_HDR_HEAD_COUNTER_SHIFT;
+		write_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_head_reg, reg);
+	}
+
+	if (op & (HFI2_RCVCTRL_TAILUPD_DIS | HFI2_RCVCTRL_CTXT_DIS))
+		/*
+		 * If the context has been disabled and the Tail Update has
+		 * been cleared, set the RCV_HDR_TAIL_ADDR CSR to dummy address
+		 * so it doesn't contain an address that is invalid.
+		 */
+		write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_tail_addr_reg,
+				dd->rcvhdrtail_dummy_dma);
+}
+
+/*
+ * Read the counters from the table, store the values read into results.
+ */
+static void read_counters(struct hfi2_devdata *dd,
+			  const struct cntr_entry *table,
+			  int table_size,
+			  void *context,
+			  u64 *results)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	const struct cntr_entry *entry;
+	u64 val;
+	int i, j;
+
+	/* fill in each counter from the table */
+	for (i = 0; i < table_size; i++) {
+		entry = &table[i];
+		hfi2_cdbg(CNTR, "reading %s", entry->name);
+		if (entry->flags & CNTR_DISABLED) {
+			/* Nothing */
+			hfi2_cdbg(CNTR, "\tDisabled");
+			continue;
+		}
+
+		if (entry->flags & CNTR_VL) {
+			hfi2_cdbg(CNTR, "\tPer VL");
+			for (j = 0; j < C_VL_COUNT; j++) {
+				val = entry->rw_cntr(entry, context, j,
+						     CNTR_MODE_R, 0);
+				hfi2_cdbg(CNTR, "\t\tRead 0x%llx for %d",
+					  val, j);
+				results[entry->offset + j] = val;
+			}
+		} else if (entry->flags & CNTR_SDMA) {
+			hfi2_cdbg(CNTR, "\tPer SDMA Engine");
+			for (j = dr->first_sdma_engine; j < dr->last_sdma_engine; j++) {
+				val = entry->rw_cntr(entry, context, j,
+						     CNTR_MODE_R, 0);
+				hfi2_cdbg(CNTR, "\t\tRead 0x%llx for %d",
+					  val, j);
+				results[entry->offset + j] = val;
+			}
+		} else if (entry->flags & CNTR_OVF) {
+			hfi2_cdbg(CNTR, "\tPer ctxt");
+			for (j = 0; j < dd->num_rcd; j++) {
+				if (test_bit(j, dd->ovf_disabled))
+					continue;
+				val = entry->rw_cntr(entry, context, j,
+						     CNTR_MODE_R, 0);
+				hfi2_cdbg(CNTR,
+					  "\t\tRead 0x%llx for %d",
+					  val, j);
+				results[entry->offset + dd->ovf_offset[j]] = val;
+			}
+		} else {
+			val = entry->rw_cntr(entry, context, CNTR_INVALID_VL,
+					     CNTR_MODE_R, 0);
+			results[entry->offset] = val;
+			hfi2_cdbg(CNTR, "\tRead 0x%llx", val);
+		}
+	}
+}
+
+/*
+ * Return device counter names or updated counter values.  Return buffer size.
+ * Used by sysfs and verbs.
+ */
+u32 hfi2_read_cntrs(struct hfi2_devdata *dd, char **namep, u64 **cntrp)
+{
+	if (namep) {
+		*namep = dd->cntrnames;
+		return dd->cntrnameslen;
+	}
+	if (dd->is_vf) {
+		goto skip;
+	}
+
+	read_counters(dd, shared_dev_cntrs, SHARED_DEV_CNTR_LAST,
+		      dd, dd->cntrs);
+	read_counters(dd, dd->params->chip_dev_cntrs,
+		      dd->params->chip_num_dev_cntrs,
+		      dd, dd->cntrs);
+skip:
+	*cntrp = dd->cntrs;
+	return dd->ndevcntrs * sizeof(u64);
+}
+
+/*
+ * Return port counter names or updated counter values.  Return buffer size.
+ * Used by sysfs and verbs.
+ */
+u32 hfi2_read_portcntrs(struct hfi2_pportdata *ppd, char **namep, u64 **cntrp)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+
+	if (namep) {
+		*namep = dd->portcntrnames;
+		return dd->portcntrnameslen;
+	}
+
+	read_counters(dd, shared_port_cntrs, SHARED_PORT_CNTR_LAST,
+		      ppd, ppd->cntrs);
+	read_counters(dd, dd->params->chip_port_cntrs,
+		      dd->params->chip_num_port_cntrs,
+		      ppd, ppd->cntrs);
+
+	*cntrp = ppd->cntrs;
+	return dd->nportcntrs * sizeof(u64);
+}
+
+static void free_cntrs(struct hfi2_devdata *dd)
+{
+	struct hfi2_pportdata *ppd;
+	int i;
+
+	if (dd->synth_stats_timer.function)
+		timer_delete_sync(&dd->synth_stats_timer);
+	if (dd->rcverr_timer.function)
+		timer_delete_sync(&dd->rcverr_timer);
+	cancel_work_sync(&dd->update_cntr_work);
+	cancel_work_sync(&dd->rcverr_work);
+	ppd = (struct hfi2_pportdata *)(dd + 1);
+	for (i = 0; i < dd->num_pports; i++, ppd++) {
+		kfree(ppd->cntrs);
+		kfree(ppd->scntrs);
+		free_percpu(ppd->ibport_data.rvp.rc_acks);
+		free_percpu(ppd->ibport_data.rvp.rc_qacks);
+		free_percpu(ppd->ibport_data.rvp.rc_delayed_comp);
+		ppd->cntrs = NULL;
+		ppd->scntrs = NULL;
+		ppd->ibport_data.rvp.rc_acks = NULL;
+		ppd->ibport_data.rvp.rc_qacks = NULL;
+		ppd->ibport_data.rvp.rc_delayed_comp = NULL;
+	}
+	kfree(dd->portcntrnames);
+	dd->portcntrnames = NULL;
+	kfree(dd->cntrs);
+	dd->cntrs = NULL;
+	kfree(dd->scntrs);
+	dd->scntrs = NULL;
+	kfree(dd->cntrnames);
+	dd->cntrnames = NULL;
+	if (dd->update_cntr_wq) {
+		destroy_workqueue(dd->update_cntr_wq);
+		dd->update_cntr_wq = NULL;
+	}
+}
+
+static u64 read_dev_port_cntr(struct hfi2_devdata *dd, struct cntr_entry *entry,
+			      u64 *psval, void *context, int vl)
+{
+	u64 val;
+	u64 sval = *psval;
+
+	if (entry->flags & CNTR_DISABLED) {
+		dd_dev_err(dd, "Counter %s not enabled", entry->name);
+		return 0;
+	}
+
+	hfi2_cdbg(CNTR, "cntr: %s vl %d psval 0x%llx", entry->name, vl, *psval);
+
+	val = entry->rw_cntr(entry, context, vl, CNTR_MODE_R, 0);
+
+	/* If its a synthetic counter there is more work we need to do */
+	if (entry->flags & CNTR_SYNTH) {
+		if (sval == CNTR_MAX) {
+			/* No need to read already saturated */
+			return CNTR_MAX;
+		}
+
+		if (entry->flags & CNTR_32BIT) {
+			/* 32bit counters can wrap multiple times */
+			u64 upper = sval >> 32;
+			u64 lower = (sval << 32) >> 32;
+
+			if (lower > val) { /* hw wrapped */
+				if (upper == CNTR_32BIT_MAX)
+					val = CNTR_MAX;
+				else
+					upper++;
+			}
+
+			if (val != CNTR_MAX)
+				val = (upper << 32) | val;
+
+		} else {
+			/* If we rolled we are saturated */
+			if ((val < sval) || (val > CNTR_MAX))
+				val = CNTR_MAX;
+		}
+	}
+
+	*psval = val;
+
+	hfi2_cdbg(CNTR, "\tNew val=0x%llx", val);
+
+	return val;
+}
+
+static u64 write_dev_port_cntr(struct hfi2_devdata *dd,
+			       struct cntr_entry *entry,
+			       u64 *psval, void *context, int vl, u64 data)
+{
+	u64 val;
+
+	if (entry->flags & CNTR_DISABLED) {
+		dd_dev_err(dd, "Counter %s not enabled", entry->name);
+		return 0;
+	}
+
+	hfi2_cdbg(CNTR, "cntr: %s vl %d psval 0x%llx", entry->name, vl, *psval);
+
+	if (entry->flags & CNTR_SYNTH) {
+		*psval = data;
+		if (entry->flags & CNTR_32BIT) {
+			val = entry->rw_cntr(entry, context, vl, CNTR_MODE_W,
+					     (data << 32) >> 32);
+			val = data; /* return the full 64bit value */
+		} else {
+			val = entry->rw_cntr(entry, context, vl, CNTR_MODE_W,
+					     data);
+		}
+	} else {
+		val = entry->rw_cntr(entry, context, vl, CNTR_MODE_W, data);
+	}
+
+	*psval = val;
+
+	hfi2_cdbg(CNTR, "\tNew val=0x%llx", val);
+
+	return val;
+}
+
+u64 read_dev_cntr(struct hfi2_devdata *dd, int index, int vl)
+{
+	struct cntr_entry *entry;
+	u64 *sval;
+
+	if (index < SHARED_DEV_CNTR_LAST) {
+		entry = &shared_dev_cntrs[index];
+	} else {
+		index -= dd->params->chip_dev_cntr_first;
+		if (index < 0 || index >= dd->params->chip_num_dev_cntrs) {
+			dd_dev_err(dd, "%s: invalid dev counter index 0x%x\n",
+				   __func__,
+				   index + dd->params->chip_dev_cntr_first);
+			return 0;
+		}
+		entry = &dd->params->chip_dev_cntrs[index];
+	}
+	sval = dd->scntrs + entry->offset;
+
+	if (vl != CNTR_INVALID_VL)
+		sval += vl;
+
+	return read_dev_port_cntr(dd, entry, sval, dd, vl);
+}
+
+u64 write_dev_cntr(struct hfi2_devdata *dd, int index, int vl, u64 data)
+{
+	struct cntr_entry *entry;
+	u64 *sval;
+
+	if (index < SHARED_DEV_CNTR_LAST) {
+		entry = &shared_dev_cntrs[index];
+	} else {
+		index -= dd->params->chip_dev_cntr_first;
+		if (index < 0 || index >= dd->params->chip_num_dev_cntrs) {
+			dd_dev_err(dd, "%s: invalid dev counter index 0x%x\n",
+				   __func__,
+				   index + dd->params->chip_dev_cntr_first);
+			return 0;
+		}
+		entry = &dd->params->chip_dev_cntrs[index];
+	}
+	sval = dd->scntrs + entry->offset;
+
+	if (vl != CNTR_INVALID_VL)
+		sval += vl;
+
+	return write_dev_port_cntr(dd, entry, sval, dd, vl, data);
+}
+
+/* return the counter entry for the given index, or NULL if invalid */
+static struct cntr_entry *get_port_entry(struct hfi2_devdata *dd,
+					 int index, const char *caller)
+{
+	if (index < SHARED_PORT_CNTR_LAST)
+		return &shared_port_cntrs[index];
+
+	index -= dd->params->chip_port_cntr_first;
+	if (index < 0 || index >= dd->params->chip_num_port_cntrs) {
+		dd_dev_err(dd, "%s: invalid port counter index 0x%x\n",
+			   caller,
+			   index + dd->params->chip_port_cntr_first);
+		return NULL;
+	}
+	return &dd->params->chip_port_cntrs[index];
+}
+
+/*
+ * Counters may be indexed by vl or (indirectly) context number.
+ *
+ * Return the actual index for this counter, as determined by parameter
+ * in_index and counter type.
+ */
+static int get_port_entry_index(struct hfi2_devdata *dd,
+				struct cntr_entry *entry,
+				int in_index)
+{
+	int out_index = 0;
+
+	if (entry->flags & CNTR_OVF) {
+		if (in_index >= 0 && in_index < dd->num_rcd) {
+			/* vl is really a context # */
+			out_index = dd->ovf_offset[in_index];
+		} else {
+			dd_dev_err(dd, "bad ovl ctxt %d\n", in_index);
+		}
+	} else {
+		if (in_index != CNTR_INVALID_VL)
+			out_index = in_index;
+	}
+	return out_index;
+}
+
+u64 read_port_cntr(struct hfi2_pportdata *ppd, int index, int vl)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct cntr_entry *entry;
+	u64 *sval;
+
+	entry = get_port_entry(dd, index, __func__);
+	if (!entry)
+		return 0;
+	sval = ppd->scntrs + entry->offset;
+
+	sval += get_port_entry_index(dd, entry, vl);
+
+	if (entry->flags & CNTR_DISABLED) {
+		/* skip disabled contexts */
+		return 0;
+	}
+
+	return read_dev_port_cntr(dd, entry, sval, ppd, vl);
+}
+
+u64 write_port_cntr(struct hfi2_pportdata *ppd, int index, int vl, u64 data)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct cntr_entry *entry;
+	u64 *sval;
+
+	entry = get_port_entry(dd, index, __func__);
+	if (!entry)
+		return 0;
+	sval = ppd->scntrs + entry->offset;
+
+	sval += get_port_entry_index(dd, entry, vl);
+
+	if (entry->flags & CNTR_DISABLED) {
+		/* skip disabled contexts */
+		return 0;
+	}
+
+	return write_dev_port_cntr(dd, entry, sval, ppd, vl, data);
+}
+
+/*
+ * Perform a WFR specific check on whether to update synthetic counters.
+ */
+bool wfr_check_synth_status(struct hfi2_devdata *dd)
+{
+	struct wfr_synth_data *sd = &dd->synth_data.wfr;
+	u64 cur_tx;
+	u64 cur_rx;
+	u64 total_flits;
+	bool update = false;
+
+	/*
+	 * Rather than keep beating on the CSRs pick a minimal set that we can
+	 * check to watch for potential roll over. We can do this by looking at
+	 * the number of flits sent/recv. If the total flits exceeds 32bits then
+	 * we have to iterate all the counters and update.
+	 */
+	cur_rx = read_dev_cntr(dd, C_DC_RCV_FLITS, CNTR_INVALID_VL);
+	cur_tx = read_dev_cntr(dd, C_DC_XMIT_FLITS, CNTR_INVALID_VL);
+
+	hfi2_cdbg(CNTR,
+		  "[%d] curr tx=0x%llx rx=0x%llx :: last tx=0x%llx rx=0x%llx",
+		  dd->unit, cur_tx, cur_rx, sd->last_tx, sd->last_rx);
+
+	if ((cur_tx < sd->last_tx) || (cur_rx < sd->last_rx)) {
+		/*
+		 * May not be strictly necessary to update but it won't hurt and
+		 * simplifies the logic here.
+		 */
+		update = true;
+		hfi2_cdbg(CNTR, "[%d] Tripwire counter rolled, updating",
+			  dd->unit);
+	} else {
+		total_flits = (cur_tx - sd->last_tx) + (cur_rx - sd->last_rx);
+		hfi2_cdbg(CNTR,
+			  "[%d] total flits 0x%llx limit 0x%llx", dd->unit,
+			  total_flits, (u64)CNTR_32BIT_MAX);
+		if (total_flits >= CNTR_32BIT_MAX) {
+			hfi2_cdbg(CNTR, "[%d] 32bit limit hit, updating",
+				  dd->unit);
+			update = true;
+		}
+	}
+
+	return update;
+}
+
+void wfr_update_synth_status(struct hfi2_devdata *dd)
+{
+	struct wfr_synth_data *sd = &dd->synth_data.wfr;
+
+	/*
+	 * We want the value in the register. The goal is to keep track
+	 * of the number of "ticks" not the counter value. In other
+	 * words if the register rolls we want to notice it and go ahead
+	 * and force an update.
+	 */
+	sd->last_tx = read_dev_cntr(dd, C_DC_XMIT_FLITS, CNTR_INVALID_VL);
+	sd->last_rx = read_dev_cntr(dd, C_DC_RCV_FLITS, CNTR_INVALID_VL);
+
+	hfi2_cdbg(CNTR, "[%d] setting last tx/rx to 0x%llx 0x%llx",
+		  dd->unit, sd->last_tx, sd->last_rx);
+}
+
+static void do_update_synth_timer(struct work_struct *work)
+{
+	bool update;
+	int i;
+	struct hfi2_pportdata *ppd;
+	struct hfi2_devdata *dd = container_of(work, struct hfi2_devdata,
+					       update_cntr_work);
+
+	update = dd->params->check_synth_status(dd);
+
+	if (update) {
+		hfi2_cdbg(CNTR, "[%d] Updating dd and ppd counters", dd->unit);
+		read_counters(dd, shared_dev_cntrs, SHARED_DEV_CNTR_LAST,
+			      dd, dd->scntrs);
+		read_counters(dd, dd->params->chip_dev_cntrs,
+			      dd->params->chip_num_dev_cntrs,
+			      dd, dd->scntrs);
+		ppd = (struct hfi2_pportdata *)(dd + 1);
+		for (i = 0; i < dd->num_pports; i++, ppd++) {
+			read_counters(dd, shared_port_cntrs,
+				      SHARED_PORT_CNTR_LAST,
+				      ppd, ppd->scntrs);
+			read_counters(dd, dd->params->chip_port_cntrs,
+				      dd->params->chip_num_port_cntrs,
+				      ppd, ppd->scntrs);
+		}
+		dd->params->update_synth_status(dd);
+	} else {
+		hfi2_cdbg(CNTR, "[%d] No update necessary", dd->unit);
+	}
+}
+
+static void update_synth_timer(struct timer_list *t)
+{
+	struct hfi2_devdata *dd = timer_container_of(dd, t, synth_stats_timer);
+
+	queue_work(dd->update_cntr_wq, &dd->update_cntr_work);
+	mod_timer(&dd->synth_stats_timer, jiffies + HZ * SYNTH_CNT_TIME);
+}
+
+static const char bit_type_32[] = ",32";
+static const int bit_type_32_sz = 3;
+#define C_MAX_NAME 16 /* 15 chars + one for /0 */
+
+/*
+ * Calculate and return the indexed name size.  Keep in sync with
+ * copy_indexed_name().
+ */
+static size_t size_indexed_name(const char *raw_name, int flags, int idx)
+{
+	char name[C_MAX_NAME];
+	size_t sz;
+
+	snprintf(name, C_MAX_NAME, "%s%d", raw_name, idx);
+	/* +1 for newline */
+	sz = strlen(name) + 1;
+	/* add ",32" for 32-bit counters */
+	if (flags & CNTR_32BIT)
+		sz += bit_type_32_sz;
+
+	return sz;
+}
+
+/*
+ * Copy indexed name into p.  Advance and return p.  Keep in sync with
+ * size_indexed_name().
+ */
+static char *copy_indexed_name(char *p, const char *raw_name, int flags,
+				int idx)
+{
+	char name[C_MAX_NAME];
+
+	snprintf(name, C_MAX_NAME, "%s%d", raw_name, idx);
+	memcpy(p, name, strlen(name));
+	p += strlen(name);
+	/* counter is 32 bits */
+	if (flags & CNTR_32BIT) {
+		memcpy(p, bit_type_32, bit_type_32_sz);
+		p += bit_type_32_sz;
+	}
+	*p++ = '\n';
+
+	return p;
+}
+
+/*
+ * Calculate and return the single name size.  Keep in sync with
+ * copy_single_name().
+ */
+static size_t size_single_name(const char *raw_name, int flags)
+{
+	size_t sz;
+
+	/* +1 for newline */
+	sz = strlen(raw_name) + 1;
+	/* add ",32" for 32-bit counters */
+	if (flags & CNTR_32BIT)
+		sz += bit_type_32_sz;
+
+	return sz;
+}
+
+/*
+ * Copy single name into p.  Advance and return p.  Keep in sync with
+ * size_single_name().
+ */
+static char *copy_single_name(char *p, const char *raw_name, int flags)
+{
+	memcpy(p, raw_name, strlen(raw_name));
+	p += strlen(raw_name);
+	/* counter is 32 bits */
+	if (flags & CNTR_32BIT) {
+		memcpy(p, bit_type_32, bit_type_32_sz);
+		p += bit_type_32_sz;
+	}
+	*p++ = '\n';
+
+	return p;
+}
+
+/*
+ * Walk through the table, increasing the calculated number of counters and
+ * name size.
+ */
+static void size_cntr_names(struct hfi2_devdata *dd,
+			   struct cntr_entry *table, int table_size,
+			   size_t *countp, size_t *szp)
+{
+	u32 sdma_engines = chip_sdma_engines(dd);
+	u32 num_rcv = chip_rcv_contexts(dd);
+	size_t count;
+	size_t sz;
+	int i, j;
+	u8 ovf_offset;
+
+	count = *countp;	/* need current count */
+	sz = 0;
+	ovf_offset = 0;
+	for (i = 0; i < table_size; i++) {
+		if (table[i].flags & CNTR_DISABLED) {
+			hfi2_dbg_early("\tSkipping %s\n", table[i].name);
+			continue;
+		}
+
+		table[i].offset = count;
+		if (table[i].flags & CNTR_VL) {
+			for (j = 0; j < C_VL_COUNT; j++) {
+				sz += size_indexed_name(table[i].name,
+							table[i].flags,
+							vl_from_idx(j));
+				count++;
+			}
+		} else if (table[i].flags & CNTR_SDMA) {
+			for (j = 0; j < sdma_engines; j++) {
+				sz += size_indexed_name(table[i].name,
+							table[i].flags,
+							j);
+				count++;
+			}
+		} else if (table[i].flags & CNTR_OVF) {
+			for (j = 0; j < num_rcv; j++) {
+				if (test_bit(j, dd->ovf_disabled))
+					continue;
+				dd->ovf_offset[j] = ovf_offset;
+				sz += size_indexed_name(table[i].name,
+							table[i].flags,
+							j);
+				count++;
+				ovf_offset++;
+			}
+		} else {
+			sz += size_single_name(table[i].name, table[i].flags);
+			count++;
+		}
+	}
+
+	/* return updated sizes */
+	*countp = count;
+	*szp += sz;
+}
+
+/*
+ * Fill the counter names into p.  Return p's final value.
+ */
+static char *fill_cntr_names(struct hfi2_devdata *dd,
+			     struct cntr_entry *table, int table_size, char *p)
+{
+	u32 sdma_engines = chip_sdma_engines(dd);
+	u32 num_rcv = chip_rcv_contexts(dd);
+	int i, j;
+
+	for (i = 0; i < table_size; i++) {
+		if (table[i].flags & CNTR_DISABLED) {
+			/* Nothing */
+		} else if (table[i].flags & CNTR_VL) {
+			for (j = 0; j < C_VL_COUNT; j++) {
+				p = copy_indexed_name(p, table[i].name,
+						      table[i].flags,
+						      vl_from_idx(j));
+			}
+		} else if (table[i].flags & CNTR_SDMA) {
+			for (j = 0; j < sdma_engines; j++) {
+				p = copy_indexed_name(p, table[i].name,
+						      table[i].flags,
+						      j);
+			}
+		} else if (table[i].flags & CNTR_OVF) {
+			for (j = 0; j < num_rcv; j++) {
+				if (test_bit(j, dd->ovf_disabled))
+					continue;
+				p = copy_indexed_name(p, table[i].name,
+						      table[i].flags,
+						      j);
+			}
+		} else {
+			p = copy_single_name(p, table[i].name, table[i].flags);
+		}
+	}
+
+	return p;
+}
+
+static int init_cntrs(struct hfi2_devdata *dd)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	int i, j;
+	size_t sz;
+	struct hfi2_pportdata *ppd;
+	char *p;
+
+	/* set up the stats timers; the add_timer calls are done at the end */
+	timer_setup(&dd->synth_stats_timer, update_synth_timer, 0);
+	timer_setup(&dd->rcverr_timer, update_rcverr_timer, 0);
+	/* Assume the hardware counter has been reset */
+	for (i = 0; i < dd->num_pports; i++)
+		dd->pport[i].rcv_ovfl_cnt = 0;
+
+	/***********************/
+	/* per device counters */
+	/***********************/
+
+	/* size names and determine how many we have */
+	dd->ndevcntrs = 0;
+	sz = 0;
+	size_cntr_names(dd, shared_dev_cntrs, SHARED_DEV_CNTR_LAST,
+			&dd->ndevcntrs, &sz);
+	size_cntr_names(dd, dd->params->chip_dev_cntrs,
+			dd->params->chip_num_dev_cntrs,
+			&dd->ndevcntrs, &sz);
+
+	/* allocate space for the counter values */
+	dd->cntrs = kcalloc(dd->ndevcntrs + num_driver_cntrs, sizeof(u64),
+			    GFP_KERNEL);
+	if (!dd->cntrs)
+		goto bail;
+
+	dd->scntrs = kcalloc(dd->ndevcntrs, sizeof(u64), GFP_KERNEL);
+	if (!dd->scntrs)
+		goto bail;
+
+	/* allocate space for the counter names */
+	dd->cntrnameslen = sz;
+	dd->cntrnames = kmalloc(sz, GFP_KERNEL);
+	if (!dd->cntrnames)
+		goto bail;
+
+	/* fill in the names */
+	p = fill_cntr_names(dd, shared_dev_cntrs, SHARED_DEV_CNTR_LAST,
+			    dd->cntrnames);
+	fill_cntr_names(dd, dd->params->chip_dev_cntrs,
+			dd->params->chip_num_dev_cntrs, p);
+
+	/*********************/
+	/* per port counters */
+	/*********************/
+
+	/*
+	 * Go through the counters for the overflows and disable the ones we
+	 * don't need. This varies based on platform so we need to do it
+	 * dynamically here.
+	 */
+	bitmap_fill(dd->ovf_disabled, MAX_CTXTS);
+	for (i = 0; i < dd->num_pports; i++) {
+		struct hfi2_portrsrcs *pr = &dr->ppr[i];
+
+		for (j = 0; j < pr->num_rcv_contexts; j++) {
+			u16 ctxt = pr->rcv_context_base + j;
+
+			clear_bit(ctxt, dd->ovf_disabled);
+		}
+	}
+
+	/* size port counter names and determine how many we have */
+	dd->nportcntrs = 0;
+	sz = 0;
+	size_cntr_names(dd, shared_port_cntrs, SHARED_PORT_CNTR_LAST,
+			&dd->nportcntrs, &sz);
+	size_cntr_names(dd, dd->params->chip_port_cntrs,
+			dd->params->chip_num_port_cntrs,
+			&dd->nportcntrs, &sz);
+
+	/* allocate space for the counter names */
+	dd->portcntrnameslen = sz;
+	dd->portcntrnames = kmalloc(sz, GFP_KERNEL);
+	if (!dd->portcntrnames)
+		goto bail;
+
+	/* fill in port cntr names */
+	p = fill_cntr_names(dd, shared_port_cntrs, SHARED_PORT_CNTR_LAST,
+			    dd->portcntrnames);
+	fill_cntr_names(dd, dd->params->chip_port_cntrs,
+			dd->params->chip_num_port_cntrs, p);
+
+	/* allocate per port storage for counter values */
+	ppd = (struct hfi2_pportdata *)(dd + 1);
+	for (i = 0; i < dd->num_pports; i++, ppd++) {
+		ppd->cntrs = kcalloc(dd->nportcntrs, sizeof(u64), GFP_KERNEL);
+		if (!ppd->cntrs)
+			goto bail;
+
+		ppd->scntrs = kcalloc(dd->nportcntrs, sizeof(u64), GFP_KERNEL);
+		if (!ppd->scntrs)
+			goto bail;
+	}
+
+	/* CPU counters need to be allocated and zeroed */
+	if (init_cpu_counters(dd))
+		goto bail;
+
+	dd->update_cntr_wq = alloc_ordered_workqueue("hfi2_update_cntr_%d",
+						     WQ_MEM_RECLAIM, dd->unit);
+	if (!dd->update_cntr_wq)
+		goto bail;
+
+	INIT_WORK(&dd->update_cntr_work, do_update_synth_timer);
+	INIT_WORK(&dd->rcverr_work, do_rcverr_timer);
+
+	mod_timer(&dd->synth_stats_timer, jiffies + HZ * SYNTH_CNT_TIME);
+	mod_timer(&dd->rcverr_timer, jiffies + HZ * RCVERR_CHECK_TIME);
+	return 0;
+bail:
+	free_cntrs(dd);
+	return -ENOMEM;
+}
+
+static u32 chip_to_opa_lstate(struct hfi2_devdata *dd, u32 chip_lstate)
+{
+	switch (chip_lstate) {
+	case LSTATE_DOWN:
+		return IB_PORT_DOWN;
+	case LSTATE_INIT:
+		return IB_PORT_INIT;
+	case LSTATE_ARMED:
+		return IB_PORT_ARMED;
+	case LSTATE_ACTIVE:
+		return IB_PORT_ACTIVE;
+	default:
+		dd_dev_err(dd,
+			   "Unknown logical state 0x%x, reporting IB_PORT_DOWN\n",
+			   chip_lstate);
+		return IB_PORT_DOWN;
+	}
+}
+
+u32 chip_to_opa_pstate(struct hfi2_devdata *dd, u32 chip_pstate)
+{
+	/* look at the HFI meta-states only */
+	switch (chip_pstate & 0xf0) {
+	case PLS_DISABLED:
+		return IB_PORTPHYSSTATE_DISABLED;
+	case PLS_OFFLINE:
+		return OPA_PORTPHYSSTATE_OFFLINE;
+	case PLS_POLLING:
+		return IB_PORTPHYSSTATE_POLLING;
+	case PLS_CONFIGPHY:
+		return IB_PORTPHYSSTATE_TRAINING;
+	case PLS_LINKUP:
+		return IB_PORTPHYSSTATE_LINKUP;
+	case PLS_PHYTEST:
+		return IB_PORTPHYSSTATE_PHY_TEST;
+	default:
+		dd_dev_err(dd, "Unexpected chip physical state of 0x%x\n",
+			   chip_pstate);
+		return IB_PORTPHYSSTATE_DISABLED;
+	}
+}
+
+/* return the OPA port physical state name */
+const char *opa_pstate_name(u32 pstate)
+{
+	static const char * const port_physical_names[] = {
+		"PHYS_NOP",
+		"reserved1",
+		"PHYS_POLL",
+		"PHYS_DISABLED",
+		"PHYS_TRAINING",
+		"PHYS_LINKUP",
+		"PHYS_LINK_ERR_RECOVER",
+		"PHYS_PHY_TEST",
+		"reserved8",
+		"PHYS_OFFLINE",
+		"PHYS_GANGED",
+		"PHYS_TEST",
+	};
+	if (pstate < ARRAY_SIZE(port_physical_names))
+		return port_physical_names[pstate];
+	return "unknown";
+}
+
+/**
+ * update_statusp - Update userspace status flag
+ * @ppd: Port data structure
+ * @state: port state information
+ *
+ * Actual port status is determined by the host_link_state value
+ * in the ppd.
+ *
+ * host_link_state MUST be updated before updating the user space
+ * statusp.
+ */
+void update_statusp(struct hfi2_pportdata *ppd, u32 state)
+{
+	/*
+	 * Set port status flags in the page mapped into userspace
+	 * memory. Do it here to ensure a reliable state - this is
+	 * the only function called by all state handling code.
+	 * Always set the flags due to the fact that the cache value
+	 * might have been changed explicitly outside of this
+	 * function.
+	 */
+	if (ppd->statusp) {
+		switch (state) {
+		case IB_PORT_DOWN:
+		case IB_PORT_INIT:
+			*ppd->statusp &= ~(HFI2_STATUS_IB_CONF |
+					   HFI2_STATUS_IB_READY);
+			break;
+		case IB_PORT_ARMED:
+			*ppd->statusp |= HFI2_STATUS_IB_CONF;
+			break;
+		case IB_PORT_ACTIVE:
+			*ppd->statusp |= HFI2_STATUS_IB_READY;
+			break;
+		}
+	}
+	ppd_dev_info(ppd, "logical state changed to %s (0x%x)\n",
+		     ib_port_state_to_str(state), state);
+}
+
+/**
+ * wait_logical_linkstate - wait for an IB link state change to occur
+ * @ppd: port device
+ * @state: the state to wait for
+ * @msecs: the number of milliseconds to wait
+ *
+ * Wait up to msecs milliseconds for IB link state change to occur.
+ * For now, take the easy polling route.
+ * Returns 0 if state reached, otherwise -ETIMEDOUT.
+ */
+static int wait_logical_linkstate(struct hfi2_pportdata *ppd, u32 state,
+				  int msecs)
+{
+	unsigned long timeout;
+	u32 new_state;
+
+	timeout = jiffies + msecs_to_jiffies(msecs);
+	while (1) {
+		new_state = chip_to_opa_lstate(ppd->dd,
+					       read_logical_state(ppd->dd));
+		if (new_state == state)
+			break;
+		if (time_after(jiffies, timeout)) {
+			ppd_dev_err(ppd,
+				   "timeout waiting for link state 0x%x\n",
+				   state);
+			return -ETIMEDOUT;
+		}
+		msleep(20);
+	}
+
+	return 0;
+}
+
+void log_state_transition(struct hfi2_pportdata *ppd, u32 state)
+{
+	u32 ib_pstate = chip_to_opa_pstate(ppd->dd, state);
+
+	ppd_dev_info(ppd,
+		     "physical state changed to %s (0x%x), phy 0x%x\n",
+		     opa_pstate_name(ib_pstate), ib_pstate, state);
+}
+
+/*
+ * Read the physical hardware link state and check if it matches host
+ * drivers anticipated state.
+ */
+static void log_physical_state(struct hfi2_pportdata *ppd, u32 state)
+{
+	u32 read_state = read_physical_state(ppd->dd);
+
+	if (read_state == state) {
+		log_state_transition(ppd, state);
+	} else {
+		ppd_dev_err(ppd,
+			   "anticipated phy link state 0x%x, read 0x%x\n",
+			   state, read_state);
+	}
+}
+
+/*
+ * wait_physical_linkstate - wait for an physical link state change to occur
+ * @ppd: port device
+ * @state: the state to wait for
+ * @msecs: the number of milliseconds to wait
+ *
+ * Wait up to msecs milliseconds for physical link state change to occur.
+ * Returns 0 if state reached, otherwise -ETIMEDOUT.
+ */
+static int wait_physical_linkstate(struct hfi2_pportdata *ppd, u32 state,
+				   int msecs)
+{
+	u32 read_state;
+	unsigned long timeout;
+
+	timeout = jiffies + msecs_to_jiffies(msecs);
+	while (1) {
+		read_state = read_physical_state(ppd->dd);
+		if (read_state == state)
+			break;
+		if (time_after(jiffies, timeout)) {
+			ppd_dev_err(ppd,
+				    "timeout waiting for phy link state 0x%x\n",
+				    state);
+			return -ETIMEDOUT;
+		}
+		usleep_range(1950, 2050); /* sleep 2ms-ish */
+	}
+
+	log_state_transition(ppd, state);
+	return 0;
+}
+
+/*
+ * wait_phys_link_offline_quiet_substates - wait for any offline substate
+ * @ppd: port device
+ * @msecs: the number of milliseconds to wait
+ *
+ * Wait up to msecs milliseconds for any offline physical link
+ * state change to occur.
+ * Returns 0 if at least one state is reached, otherwise -ETIMEDOUT.
+ */
+static int wait_phys_link_offline_substates(struct hfi2_pportdata *ppd,
+					    int msecs)
+{
+	u32 read_state;
+	unsigned long timeout;
+
+	timeout = jiffies + msecs_to_jiffies(msecs);
+	while (1) {
+		read_state = read_physical_state(ppd->dd);
+		if ((read_state & 0xF0) == PLS_OFFLINE)
+			break;
+		if (time_after(jiffies, timeout)) {
+			ppd_dev_err(ppd,
+				    "timeout waiting for phy link offline.quiet substates. Read state 0x%x, %dms\n",
+				    read_state, msecs);
+			return -ETIMEDOUT;
+		}
+		usleep_range(1950, 2050); /* sleep 2ms-ish */
+	}
+
+	log_state_transition(ppd, read_state);
+	return read_state;
+}
+
+/*
+ * wait_phys_link_out_of_offline - wait for any out of offline state
+ * @ppd: port device
+ * @msecs: the number of milliseconds to wait
+ *
+ * Wait up to msecs milliseconds for any out of offline physical link
+ * state change to occur.
+ * Returns 0 if at least one state is reached, otherwise -ETIMEDOUT.
+ */
+static int wait_phys_link_out_of_offline(struct hfi2_pportdata *ppd,
+					 int msecs)
+{
+	u32 read_state;
+	unsigned long timeout;
+
+	timeout = jiffies + msecs_to_jiffies(msecs);
+	while (1) {
+		read_state = read_physical_state(ppd->dd);
+		if ((read_state & 0xF0) != PLS_OFFLINE)
+			break;
+		if (time_after(jiffies, timeout)) {
+			ppd_dev_err(ppd,
+				    "timeout waiting for phy link out of offline. Read state 0x%x, %dms\n",
+				    read_state, msecs);
+			return -ETIMEDOUT;
+		}
+		usleep_range(1950, 2050); /* sleep 2ms-ish */
+	}
+
+	log_state_transition(ppd, read_state);
+	return read_state;
+}
+
+void hfi2_init_ctxt(struct send_context *sc)
+{
+	if (sc) {
+		priv_reg_op(sc->dd, sc->ppd->hw_pidx, sc->hw_context, sc->type,
+			    SC_CHK_INIT_OP, 0);
+	}
+}
+
+int hfi2_tempsense_rd(struct hfi2_devdata *dd, struct hfi2_temp *temp)
+{
+	int ret = 0;
+	u64 reg;
+
+	if (dd->icode != ICODE_RTL_SILICON) {
+		if (HFI2_CAP_IS_KSET(PRINT_UNIMPL))
+			dd_dev_info(dd, "%s: tempsense not supported by HW\n",
+				    __func__);
+		return -EINVAL;
+	}
+
+	if (dd->params->chip_type != CHIP_WFR)
+		return -EINVAL;
+
+	reg = read_csr(dd, ASIC_STS_THERM);
+	temp->curr = ((reg >> ASIC_STS_THERM_CURR_TEMP_SHIFT) &
+		      ASIC_STS_THERM_CURR_TEMP_MASK);
+	temp->lo_lim = ((reg >> ASIC_STS_THERM_LO_TEMP_SHIFT) &
+			ASIC_STS_THERM_LO_TEMP_MASK);
+	temp->hi_lim = ((reg >> ASIC_STS_THERM_HI_TEMP_SHIFT) &
+			ASIC_STS_THERM_HI_TEMP_MASK);
+	temp->crit_lim = ((reg >> ASIC_STS_THERM_CRIT_TEMP_SHIFT) &
+			  ASIC_STS_THERM_CRIT_TEMP_MASK);
+	/* triggers is a 3-bit value - 1 bit per trigger. */
+	temp->triggers = (u8)((reg >> ASIC_STS_THERM_LOW_SHIFT) & 0x7);
+
+	return ret;
+}
+
+/* ========================================================================= */
+
+/**
+ * read_mod_write() - Calculate the IRQ register index and set/clear the bits
+ * @dd: valid devdata
+ * @src: IRQ source to determine register index from
+ * @bits: the bits to set or clear
+ * @set: true == set the bits, false == clear the bits
+ *
+ */
+static void read_mod_write(struct hfi2_devdata *dd, u16 src, u64 bits,
+			   bool set)
+{
+	u64 reg;
+	u16 idx = src / BITS_PER_REGISTER;
+	u32 cce_int_mask_reg = dd->params->cce_int_mask_reg + (8 * idx);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dd->irq_src_lock, flags);
+	reg = read_csr(dd, cce_int_mask_reg);
+	if (set) {
+		reg |= bits;
+		dd->gi_mask[idx].cce_int_mask |= bits;
+	} else {
+		reg &= ~bits;
+		dd->gi_mask[idx].cce_int_mask &= ~bits;
+	}
+	write_csr(dd, cce_int_mask_reg, reg);
+	spin_unlock_irqrestore(&dd->irq_src_lock, flags);
+}
+
+/**
+ * set_intr_bits() - Enable/disable a range (one or more) IRQ sources
+ * @dd: valid devdata
+ * @first: first IRQ source to set/clear
+ * @last: last IRQ source (inclusive) to set/clear
+ * @set: true == set the bits, false == clear the bits
+ *
+ * If first == last, set the exact source.
+ */
+int set_intr_bits(struct hfi2_devdata *dd, u16 first, u16 last, bool set)
+{
+	u64 bits = 0;
+	u64 bit;
+	u16 src;
+
+	if (last > dd->params->is_last_source)
+		return -EINVAL;
+	if (last < first)
+		return -ERANGE;
+
+	for (src = first; src <= last; src++) {
+		bit = src % BITS_PER_REGISTER;
+		/* wrapped to next register? */
+		if (!bit && bits) {
+			read_mod_write(dd, src - 1, bits, set);
+			bits = 0;
+		}
+		bits |= BIT_ULL(bit);
+	}
+	read_mod_write(dd, last, bits, set);
+
+	return 0;
+}
+
+/*
+ * Clear all interrupt sources on the chip.
+ */
+void clear_all_interrupts(struct hfi2_devdata *dd)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	int i;
+	u32 cce_int_clear_reg = dd->params->cce_int_clear_reg;
+
+	for (i = 0; i < dd->params->num_int_csrs; i++)
+		write_csr(dd, cce_int_clear_reg + (8 * i), ~(u64)0);
+
+	write_csr(dd, dd->params->csr_err_clear_reg, ~(u64)0);
+	write_csr(dd, dd->params->send_pio_err_clear_reg, ~(u64)0);
+	write_csr(dd, dd->params->send_dma_err_clear_reg, ~(u64)0);
+	for (i = dr->c.first_send_context; i < dr->c.last_send_context; i++)
+		write_sctxt_csr(dd, i, dd->params->send_ctxt_err_clear_reg, ~(u64)0);
+	for (i = dr->first_sdma_engine; i < dr->last_sdma_engine; i++)
+		write_sdma_csr(dd, i, dd->params->send_dma_eng_err_clear_reg, ~(u64)0);
+
+	if (dd->params->chip_type == CHIP_WFR) {
+		/* CPORT is initializing these */
+		write_csr(dd, CCE_ERR_CLEAR, ~(u64)0);
+		for (i = 0; i < dd->num_pports; i++) {
+			write_iport_csr(dd, i, dd->params->rcv_err_clear_reg, ~(u64)0);
+			write_eport_csr(dd, i, dd->params->send_egress_err_clear_reg, ~(u64)0);
+		}
+
+		/* only WFR has these blocks */
+		write_csr(dd, MISC_ERR_CLEAR, ~(u64)0);
+		write_csr(dd, DCC_ERR_FLG_CLR, ~(u64)0);
+		write_csr(dd, DC_LCB_ERR_CLR, ~(u64)0);
+		write_csr(dd, DC_DC8051_ERR_CLR, ~(u64)0);
+	}
+}
+
+/*
+ * Remap the interrupt source from the general handler to the given MSI-X
+ * interrupt.
+ */
+void remap_intr(struct hfi2_devdata *dd, int isrc, int msix_intr)
+{
+	u64 reg;
+	int m, n;
+
+	/* clear from the handled mask of the general interrupt */
+	m = isrc / 64;
+	n = isrc % 64;
+	if (likely(m < dd->params->num_int_csrs)) {
+		dd->gi_mask[m].remap &= ~((u64)1 << n);
+	} else {
+		dd_dev_err(dd, "remap interrupt err\n");
+		return;
+	}
+
+	/* direct the chip source to the given MSI-X interrupt */
+	m = isrc / 8;
+	n = isrc % 8;
+	reg = read_csr(dd, dd->params->cce_msix_int_map_vec_reg + (8 * m));
+	reg &= ~((u64)0xff << (8 * n));
+	reg |= ((u64)msix_intr & 0xff) << (8 * n);
+	write_csr(dd, dd->params->cce_msix_int_map_vec_reg + (8 * m), reg);
+}
+
+void remap_sdma_interrupts(struct hfi2_devdata *dd, int engine, int msix_intr)
+{
+	/*
+	 * SDMA engine interrupt sources grouped by type, rather than
+	 * engine.  Per-engine interrupts are as follows:
+	 *	SDMA
+	 *	SDMAProgress
+	 *	SDMAIdle
+	 */
+	remap_intr(dd, dd->params->is_sdma_start + engine, msix_intr);
+	remap_intr(dd, dd->params->is_sdma_progress_start + engine, msix_intr);
+	remap_intr(dd, dd->params->is_sdma_idle_start + engine, msix_intr);
+}
+
+/*
+ * Set the general handler to accept all interrupts, remap all
+ * chip interrupts back to MSI-X 0.
+ */
+void reset_interrupts(struct hfi2_devdata *dd)
+{
+	int i;
+	u32 cce_int_mask_reg = dd->params->cce_int_mask_reg;
+
+	/* all interrupts handled by the general handler */
+	for (i = 0; i < dd->params->num_int_csrs; i++) {
+		dd->gi_mask[i].remap = ~(u64)0;
+		dd->gi_mask[i].cce_int_mask = read_csr(dd, cce_int_mask_reg + (8 * i));
+	}
+
+	/* all chip interrupts map to MSI-X 0 */
+	for (i = 0; i < dd->params->num_int_map_csrs; i++)
+		write_csr(dd, dd->params->cce_msix_int_map_vec_reg + (8 * i), 0);
+}
+
+/**
+ * set_up_interrupts() - Initialize the IRQ resources and state
+ * @dd: valid devdata
+ *
+ */
+static int set_up_interrupts(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	/* mask all interrupts */
+	set_intr_bits(dd, 0, dd->params->is_last_source, false);
+
+	/* clear all pending interrupts */
+	clear_all_interrupts(dd);
+
+	/* reset general handler mask, chip MSI-X mappings */
+	reset_interrupts(dd);
+
+	/* ask for MSI-X interrupts */
+	ret = msix_initialize(dd);
+	if (ret)
+		return ret;
+
+	ret = msix_early_request_irqs(dd);
+	if (ret)
+		msix_clean_up_interrupts(dd);
+
+	return ret;
+}
+
+static int late_set_up_interrupts(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	ret = msix_request_irqs(dd);
+	if (ret)
+		msix_clean_up_interrupts(dd);
+
+	return ret;
+}
+
+/*
+ * Reduce the total per-port user receive context counts by the given amount.
+ *
+ * Return 0 if success, -EINVAL if there is not enough extra.
+ */
+static int reduce_ctxts(struct hfi2_devdata *dd, u32 *counts, int amount)
+{
+	const u32 count_min = 0; /* do not allow count to go below this value */
+	int pidx;
+
+	/* remove one at a time, round robin */
+	while (amount > 0) {
+		bool adjusted = false;
+
+		for (pidx = 0; pidx < dd->num_pports && amount > 0; pidx++) {
+			if (counts[pidx] > count_min) {
+				counts[pidx]--;
+				amount--;
+				adjusted = true;
+			}
+		}
+
+		if (!adjusted)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int reduce_rcv_ctxts(struct hfi2_devdata *dd, u32 *counts, int amount,
+			    const char *why)
+{
+	int ret = reduce_ctxts(dd, counts, amount);
+
+	if (ret) {
+		dd_dev_err(dd, "Cannot reduce user receive contexts requested by %d [%s]\n",
+			   amount, why);
+	}
+	return ret;
+}
+
+/* return true if the fabric is reachable on the card */
+/* this function does not range validate pidx */
+static bool hardware_pidx_available(struct hfi2_devdata *dd, int pidx)
+{
+	/* only need to check JKR */
+	if (dd->params->chip_type != CHIP_JKR)
+		return true;
+
+	/* dual port JKR has all ports available */
+	if (dd->pcidev->subsystem_device == PCI_SUBDEVICE_CN5000_DUAL_PORT ||
+	    dd->pcidev->subsystem_device == PCI_SUBDEVICE_CN5000_DUAL_PORT_PS)
+		return true;
+
+	/* port swapped single port JKR only uses the first port */
+	if (dd->pcidev->subsystem_device == PCI_SUBDEVICE_CN5000_SINGLE_PORT_PS &&
+	    pidx == 0)
+		return true;
+
+	/* single port JKR only uses the second port */
+	if (dd->pcidev->subsystem_device == PCI_DEVICE_ID_CORNELIS_CN5000 &&
+	    pidx == 1)
+		return true;
+
+	return false;
+}
+
+/*
+ * Decide how to divide resources between ports.  Resources include
+ * receive contexts, RSM table, RcvArray, and send contexts.
+ *
+ * User context resources may be asymmetric across ports.
+ *
+ * Receive contexts allocated in order at each port base:
+ *	Control context
+ *	Kernel contexts
+ *	Dynamic context pool (user and netdev)
+ *
+ * These fields are set:
+ *
+ * dd->rsrcs.ppr[*]:
+ *   num_rcv_contexts	  - number of contexts being used for this port
+ *   n_krcv_queues	  - number of kernel contexts for each port
+ *			      (includes control context)
+ *   num_netdev_contexts  - number of reserved netdev contexts for each port
+ *   num_user_conexts	  - number of user contexts for this port
+ *   rcv_context_base	  - first context for this port
+ *   first_dyn_alloc_ctxt - first dynamically allocated (user) context for
+ *			    this port
+ * dd:
+ *   rcv_entries	  - details on RcvArray entries for each port
+ *   num_send_contexts	  - number of PIO send contexts being used
+ * ppd:
+ *   freectxts		  - number of free user contexts for this port
+ *   rcv_array_base	  - first RcvArray entry for this port
+ */
+static int set_up_context_variables(struct hfi2_devdata *dd)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	u32 num_kernel_contexts[LARGEST_NUM_PORTS];
+	u32 num_netdev_contexts[LARGEST_NUM_PORTS];
+	u32 def_kernel_contexts;
+	u32 def_netdev_contexts;
+	u32 num_usr_ctxts;
+	u32 num_netdev;
+	u32 num_kctxts;
+	int ret;
+	int pidx;
+	int base;
+	int rmt_count;
+	int rcv_pool_count;
+	int total_netdev;
+	int rcvarray_avail;
+	int max_eager_allowed;
+	int total_groups;
+	int over;
+	char *limited;
+	u32 total_rcv;
+	u32 n_usr_ctxts[LARGEST_NUM_PORTS];
+	u32 send_contexts = dr->c.last_send_context - dr->c.first_send_context;
+	u32 rcv_contexts = dr->c.last_rcv_context - dr->c.first_rcv_context;
+	bool recalculated = false;
+
+	/*
+	 * Calculate the default number of per-port kernel receive contexts.
+	 *
+	 * n_krcvqs is the sum of module parameter kernel receive contexts,
+	 * krcvqs[].  It does not include the control context, so add that.
+	 */
+	if (n_krcvqs)
+		def_kernel_contexts = n_krcvqs + 1;
+	else
+		def_kernel_contexts = DEFAULT_KRCVQS + 1;
+
+	def_netdev_contexts = hfi2_num_netdev_contexts(dd,
+						       HFI2_MAX_NETDEV_CTXTS,
+						       &node_affinity.real_cpu_mask);
+
+	/* obtain requested user context numbers from module parameters */
+	num_usr_ctxts = 0;
+	num_netdev = 0;
+	num_kctxts = 0;
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		int count = get_num_user_contexts(dd, pidx);
+		/*
+		 * Per-port user contexts defaults to negative if unset in
+		 * the module parameter.
+		 * - unavailable ports always have zero user contexts no
+		 *   matter what the parameter says
+		 * - default to 1 user context per real (non-HT) CPU core
+		 */
+		if (!hardware_pidx_available(dd, pidx))
+			count = 0;
+		if (count < 0)
+			count = cpumask_weight(&node_affinity.real_cpu_mask);
+		n_usr_ctxts[pidx] = count;
+
+		/* no user contexts implies no port */
+		if (count == 0) {
+			num_kernel_contexts[pidx] = 0;
+			num_netdev_contexts[pidx] = 0;
+		} else {
+			num_kernel_contexts[pidx] = def_kernel_contexts;
+			num_netdev_contexts[pidx] = def_netdev_contexts;
+			num_netdev += def_netdev_contexts;
+			num_kctxts += def_kernel_contexts;
+		}
+		num_usr_ctxts += n_usr_ctxts[pidx];
+	}
+	if (rcv_contexts < num_kctxts + num_usr_ctxts + num_netdev) {
+		dd_dev_warn(dd, "Disabling netdev on small configuration\n");
+		for (pidx = 0; pidx < dd->num_pports; pidx++)
+			num_netdev_contexts[pidx] = 0;
+	}
+
+do_recalc:
+	/*
+	 * Adjust the counts given a global max.
+	 */
+	total_rcv = 0;
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		total_rcv += num_kernel_contexts[pidx] +
+			     num_netdev_contexts[pidx] +
+			     n_usr_ctxts[pidx];
+	}
+
+	if (rcv_contexts < total_rcv) {
+		over = total_rcv - rcv_contexts;
+		ret = reduce_rcv_ctxts(dd, n_usr_ctxts, over, "available receive contexts");
+		if (ret)
+			return -EINVAL;
+		/* total_rcv is no longer valid */
+	}
+
+	/*
+	 * RMT entries are allocated as follows:
+	 * 1. QOS (0 to 128 entries)
+	 * 2. FECN (num_kernel_context - 1 [a] + num_user_contexts +
+	 *          num_netdev_contexts [b])
+	 * 3. netdev (NUM_NETDEV_MAP_ENTRIES)
+	 *
+	 * Notes:
+	 * [a] Kernel contexts (except control) are included in FECN if kernel
+	 *     TID_RDMA is active.
+	 * [b] Netdev and user contexts are randomly allocated from the same
+	 *     context pool, so FECN must cover all contexts in the pool.
+	 */
+	rmt_count = 0;
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		/* no RMT used if port is not available */
+		if (num_kernel_contexts[pidx] == 0)
+			continue;
+		rmt_count += (HFI2_CAP_IS_KSET(TID_RDMA)
+					? (num_kernel_contexts[pidx] - 1) : 0)
+			     + n_usr_ctxts[pidx]
+			     + num_netdev_contexts[pidx]
+			     + NUM_NETDEV_MAP_ENTRIES
+			     + qos_rmt_entries(num_kernel_contexts[pidx] - 1, NULL, NULL);
+	}
+
+	if (rmt_count > dd->params->rsm_map_table_entries) {
+		over = rmt_count - dd->params->rsm_map_table_entries;
+		ret = reduce_rcv_ctxts(dd, n_usr_ctxts, over, "available RMT entries");
+		if (ret)
+			return -EINVAL;
+	}
+
+	/*
+	 * For each port, the first N are kernel contexts, the rest are
+	 * user/netdev contexts
+	 */
+
+	dd_dev_info(dd, "rcv contexts: avail %d\n", rcv_contexts);
+	base = dr->c.first_rcv_context;
+	total_rcv = 0; /* recalculate */
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		struct hfi2_pportdata *ppd = &dd->pport[pidx];
+		struct hfi2_portrsrcs *pr = &dr->ppr[pidx];
+
+		pr->n_krcv_queues = num_kernel_contexts[pidx];
+		pr->num_netdev_contexts = num_netdev_contexts[pidx];
+		pr->num_rcv_contexts = num_kernel_contexts[pidx] +
+				       num_netdev_contexts[pidx] +
+				       n_usr_ctxts[pidx];
+		pr->num_user_contexts = n_usr_ctxts[pidx];
+		pr->rcv_context_base = base;
+		ppd->freectxts = pr->num_user_contexts;
+		pr->first_dyn_alloc_ctxt = pr->rcv_context_base +
+					   num_kernel_contexts[pidx];
+		ppd_dev_info(ppd,
+			     "  rcv ctxts: base %d, used %d (kernel %d, netdev %u, user %u)\n",
+			     pr->rcv_context_base,
+			     pr->num_rcv_contexts,
+			     pr->n_krcv_queues,
+			     pr->num_netdev_contexts,
+			     pr->num_user_contexts);
+
+		base += pr->num_rcv_contexts;
+		total_rcv += pr->num_rcv_contexts;
+	}
+
+	/*
+	 * Receive array allocation:
+	 *   Avoid first N RcvArray entries.
+	 *
+	 *   All RcvArray entries are divided into groups of 8. This
+	 *   is required by the hardware and will speed up writes to
+	 *   consecutive entries by using write-combining of the entire
+	 *   cacheline.
+	 *
+	 *   The number of groups are evenly divided among all contexts.
+	 */
+	dd->rcv_entries.group_size = RCV_INCREMENT;
+	rcvarray_avail = dr->c.last_rcvarray_entry - dr->c.first_rcvarray_entry;
+	total_groups = rcvarray_avail / dd->rcv_entries.group_size;
+	if (total_rcv)
+		dd->rcv_entries.ngroups = total_groups / total_rcv;
+	else
+		dd->rcv_entries.ngroups = 0; /* alternate: total_groups */
+	max_eager_allowed = dd->params->max_eager_entries * 2;
+	if (dd->rcv_entries.ngroups * dd->rcv_entries.group_size >
+	    max_eager_allowed) {
+		dd->rcv_entries.ngroups = max_eager_allowed /
+					  dd->rcv_entries.group_size;
+		limited = " (limited by max eager entries)";
+	} else {
+		limited = "";
+	}
+	dd_dev_info(dd, "RcvArray per-context groups %u%s, unused groups %u\n",
+		    dd->rcv_entries.ngroups, limited,
+		    total_groups - (dd->rcv_entries.ngroups * total_rcv));
+
+	base = dr->c.first_rcvarray_entry;
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		struct hfi2_portrsrcs *pr = &dr->ppr[pidx];
+
+		pr->rcv_array_base = base;
+		base += pr->num_rcv_contexts * (dd->rcv_entries.ngroups * dd->rcv_entries.group_size);
+	}
+
+	/*
+	 * PIO send contexts
+	 */
+	ret = init_sc_pools_and_sizes(dd);
+	if (ret < 0)
+		return ret;
+	dd->num_send_contexts = ret;
+
+	dd_dev_info(dd,
+		    "send contexts: avail %d, used %d (kernel %d, ack %d, user %d, vl15 %d)\n",
+		    send_contexts, dd->num_send_contexts,
+		    dd->sc_sizes[SC_KERNEL].count,
+		    dd->sc_sizes[SC_ACK].count,
+		    dd->sc_sizes[SC_USER].count,
+		    dd->sc_sizes[SC_VL15].count);
+
+	/*
+	 * There may be less PIO user send contexts available than user
+	 * receive contexts.  If so, reduce the requested user receive
+	 * context count and go back to re-calculate the resources.
+	 */
+	rcv_pool_count = 0;
+	total_netdev = 0;
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		struct hfi2_portrsrcs *pr = &dr->ppr[pidx];
+
+		rcv_pool_count += pr->num_netdev_contexts + pr->num_user_contexts;
+		total_netdev += pr->num_netdev_contexts;
+	}
+
+	if (rcv_pool_count > dd->sc_sizes[SC_USER].count) {
+		const char *action = recalculated ? "fail"
+						  : "recalculating";
+
+		dd_dev_info(dd, "too many user rc %d vs sc %d - %s",
+			    rcv_pool_count,
+			    dd->sc_sizes[SC_USER].count,
+			    action);
+		if (recalculated)
+			return -EINVAL;
+
+		/* netdev is required, enforce that many in the pool */
+		if (dd->sc_sizes[SC_USER].count < total_netdev) {
+			dd_dev_err(dd, "more pool rcv contexts required than available\n");
+			return -EINVAL;
+		}
+
+		over = rcv_pool_count - dd->sc_sizes[SC_USER].count;
+		ret = reduce_rcv_ctxts(dd, n_usr_ctxts, over, "available send contexts");
+		if (ret)
+			return -EINVAL;
+		dd_dev_info(dd, "reducing requested receive contexts by %d", over);
+		recalculated = true;
+		goto do_recalc;
+	}
+
+	return 0;
+}
+
+/*
+ * Set the device/port partition key table. The MAD code
+ * will ensure that, at least, the partial management
+ * partition key is present in the table.
+ */
+static void set_partition_keys(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg = 0;
+	int i;
+
+	/* cport controls setting the hardware pkey table on later hardware */
+	if (dd->params->chip_type != CHIP_WFR)
+		return;
+
+	ppd_dev_info(ppd, "Setting partition keys\n");
+	for (i = 0; i < hfi2_get_npkeys(dd); i++) {
+		reg |= (ppd->pkeys[i] &
+			RCV_PARTITION_KEY_PARTITION_KEY_A_MASK) <<
+			((i % 4) *
+			 RCV_PARTITION_KEY_PARTITION_KEY_B_SHIFT);
+		/* Each register holds 4 PKey values. */
+		if ((i % 4) == 3) {
+			write_iport_csr(dd, ppd->hw_pidx,
+					dd->params->rcv_partition_key_reg +
+					((i - 3) * 2), reg);
+			reg = 0;
+		}
+	}
+
+	/* Always enable HW pkeys check when pkeys table is set */
+	add_rcvctrl(ppd, RCV_CTRL_RCV_PARTITION_KEY_ENABLE_SMASK);
+}
+
+/*
+ * These CSRs and memories are uninitialized on reset and must be
+ * written before reading to set the ECC/parity bits.
+ *
+ * NOTE: All user context CSRs that are not mmaped write-only
+ * (e.g. the TID flows) must be initialized even if the driver never
+ * reads them.
+ */
+static void write_uninitialized_csrs_and_memories(struct hfi2_devdata *dd)
+{
+	u32 num_qp_table_regs = dd->params->qp_map_table_entries /
+				dd->params->qp_map_table_entries_per_csr;
+	int i, j;
+
+	/* CceIntMap */
+	for (i = 0; i < dd->params->num_int_map_csrs; i++)
+		write_csr(dd, dd->params->cce_msix_int_map_vec_reg + (8 * i), 0);
+
+	/* SendCtxtCreditReturnAddr */
+	for (i = 0; i < chip_send_contexts(dd); i++)
+		write_sctxt_csr(dd, i, dd->params->send_ctxt_credit_return_addr_reg, 0);
+
+	/* PIO Send buffers */
+	/* SDMA Send buffers */
+	/*
+	 * These are not normally read, and (presently) have no method
+	 * to be read, so are not pre-initialized
+	 */
+
+	/* RcvHdrAddr */
+	/* RcvHdrTailAddr */
+	/* RcvTidFlowTable */
+	for (i = 0; i < chip_rcv_contexts(dd); i++) {
+		write_kctxt_csr(dd, i, dd->params->rcv_hdr_addr_reg, 0);
+		write_kctxt_csr(dd, i, dd->params->rcv_hdr_tail_addr_reg, 0);
+		for (j = 0; j < RXE_NUM_TID_FLOWS; j++)
+			write_uctxt_csr(dd, i, dd->params->rcv_tid_flow_table_reg + (8 * j), 0);
+	}
+
+	/* RcvArray */
+	wfr_init_tids(dd);
+
+	/* RcvQPMapTable */
+	for (i = 0; i < dd->num_pports; i++) {
+		for (j = 0; j < num_qp_table_regs; j++) {
+			u32 off = dd->params->rcv_qp_map_table_reg + (8 * i);
+
+			write_iport_csr(dd, i, off, 0);
+		}
+	}
+}
+
+/*
+ * Use the ctrl_bits in CceCtrl to clear the status_bits in CceStatus.
+ */
+static void clear_cce_status(struct hfi2_devdata *dd, u64 status_bits,
+			     u64 ctrl_bits)
+{
+	unsigned long timeout;
+	u64 reg;
+
+	/* is the condition present? */
+	reg = read_csr(dd, CCE_STATUS);
+	if ((reg & status_bits) == 0)
+		return;
+
+	/* clear the condition */
+	write_csr(dd, CCE_CTRL, ctrl_bits);
+
+	/* wait for the condition to clear */
+	timeout = jiffies + msecs_to_jiffies(CCE_STATUS_TIMEOUT);
+	while (1) {
+		reg = read_csr(dd, CCE_STATUS);
+		if ((reg & status_bits) == 0)
+			return;
+		if (time_after(jiffies, timeout)) {
+			dd_dev_err(dd,
+				   "Timeout waiting for CceStatus to clear bits 0x%llx, remaining 0x%llx\n",
+				   status_bits, reg & status_bits);
+			return;
+		}
+		udelay(1);
+	}
+}
+
+/* set CCE CSRs to chip reset defaults */
+static void reset_cce_csrs(struct hfi2_devdata *dd)
+{
+	int i;
+	u32 cce_int_clear_reg = dd->params->cce_int_clear_reg;
+	u32 cce_int_mask_reg = dd->params->cce_int_mask_reg;
+
+	/* CCE_REVISION read-only */
+	/* CCE_REVISION2 read-only */
+	/* CCE_CTRL - bits clear automatically */
+	/* CCE_STATUS read-only, use CceCtrl to clear */
+	clear_cce_status(dd, ALL_FROZE, CCE_CTRL_SPC_UNFREEZE_SMASK);
+	clear_cce_status(dd, ALL_TXE_PAUSE, CCE_CTRL_TXE_RESUME_SMASK);
+	clear_cce_status(dd, ALL_RXE_PAUSE, CCE_CTRL_RXE_RESUME_SMASK);
+	for (i = 0; i < CCE_NUM_SCRATCH; i++)
+		write_csr(dd, CCE_SCRATCH + (8 * i), 0);
+	/* CCE_ERR_STATUS read-only */
+	write_csr(dd, CCE_ERR_MASK, 0);
+	write_csr(dd, CCE_ERR_CLEAR, ~0ull);
+	/* CCE_ERR_FORCE leave alone */
+	for (i = 0; i < CCE_NUM_32_BIT_COUNTERS; i++)
+		write_csr(dd, CCE_COUNTER_ARRAY32 + (8 * i), 0);
+	write_csr(dd, CCE_DC_CTRL, CCE_DC_CTRL_RESETCSR);
+	/* CCE_PCIE_CTRL leave alone */
+	for (i = 0; i < CCE_NUM_MSIX_VECTORS; i++) {
+		write_csr(dd, CCE_MSIX_TABLE_LOWER + (0x10 * i), 0);
+		write_csr(dd, CCE_MSIX_TABLE_UPPER + (0x10 * i),
+			  CCE_MSIX_TABLE_UPPER_RESETCSR);
+	}
+	for (i = 0; i < CCE_NUM_MSIX_PBAS; i++) {
+		/* CCE_MSIX_PBA read-only */
+		write_csr(dd, CCE_MSIX_INT_GRANTED, ~0ull);
+		write_csr(dd, CCE_MSIX_VEC_CLR_WITHOUT_INT, ~0ull);
+	}
+	for (i = 0; i < dd->params->num_int_map_csrs; i++)
+		write_csr(dd, dd->params->cce_msix_int_map_vec_reg + (8 * i), 0);
+	for (i = 0; i < dd->params->num_int_csrs; i++) {
+		/* CCE_INT_STATUS read-only */
+		write_csr(dd, cce_int_mask_reg + (8 * i), 0);
+		write_csr(dd, cce_int_clear_reg + (8 * i), ~0ull);
+		/* CCE_INT_FORCE leave alone */
+		/* CCE_INT_BLOCKED read-only */
+	}
+	for (i = 0; i < CCE_NUM_32_BIT_INT_COUNTERS; i++)
+		write_csr(dd, CCE_INT_COUNTER_ARRAY32 + (8 * i), 0);
+}
+
+/* set MISC CSRs to chip reset defaults */
+static void reset_misc_csrs(struct hfi2_devdata *dd)
+{
+	int i;
+
+	for (i = 0; i < 32; i++) {
+		write_csr(dd, MISC_CFG_RSA_R2 + (8 * i), 0);
+		write_csr(dd, MISC_CFG_RSA_SIGNATURE + (8 * i), 0);
+		write_csr(dd, MISC_CFG_RSA_MODULUS + (8 * i), 0);
+	}
+	/*
+	 * MISC_CFG_SHA_PRELOAD leave alone - always reads 0 and can
+	 * only be written 128-byte chunks
+	 */
+	/* init RSA engine to clear lingering errors */
+	write_csr(dd, MISC_CFG_RSA_CMD, 1);
+	write_csr(dd, MISC_CFG_RSA_MU, 0);
+	write_csr(dd, MISC_CFG_FW_CTRL, 0);
+	/* MISC_STS_8051_DIGEST read-only */
+	/* MISC_STS_SBM_DIGEST read-only */
+	/* MISC_STS_PCIE_DIGEST read-only */
+	/* MISC_STS_FAB_DIGEST read-only */
+	/* MISC_ERR_STATUS read-only */
+	write_csr(dd, MISC_ERR_MASK, 0);
+	write_csr(dd, MISC_ERR_CLEAR, ~0ull);
+	/* MISC_ERR_FORCE leave alone */
+}
+
+/* set TXE CSRs to chip reset defaults - only called on WFR */
+static void reset_txe_csrs(struct hfi2_devdata *dd)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	int i, j;
+
+	/*
+	 * TXE Kernel CSRs
+	 */
+	for (i = 0; i < dd->num_pports; i++) {
+		write_eport_csr(dd, i, dd->params->send_ctrl_reg, 0);
+		__cm_reset(&dd->pport[i], 0);	/* reset CM internal state */
+		/* SEND_CONTEXTS read-only */
+		/* SEND_DMA_ENGINES read-only */
+		/* SEND_PIO_MEM_SIZE read-only */
+		/* SEND_DMA_MEM_SIZE read-only */
+		write_eport_csr(dd, i, dd->params->send_high_priority_limit_reg, 0);
+		/* SEND_DMA_ERR_FORCE leave alone */
+		/* SEND_EGRESS_ERR_STATUS read-only */
+		write_eport_csr(dd, i, dd->params->send_egress_err_mask_reg, 0);
+		write_eport_csr(dd, i, dd->params->send_egress_err_clear_reg, ~0ull);
+		/* SEND_EGRESS_ERR_FORCE leave alone */
+		write_eport_csr(dd, i, dd->params->send_bth_qp_reg, 0);
+		write_eport_csr(dd, i, dd->params->send_static_rate_control_reg, 0);
+		write_eport_csr(dd, i, dd->params->send_sc2vlt0_reg, 0);
+		write_eport_csr(dd, i, dd->params->send_sc2vlt1_reg, 0);
+		write_eport_csr(dd, i, dd->params->send_sc2vlt2_reg, 0);
+		write_eport_csr(dd, i, dd->params->send_sc2vlt3_reg, 0);
+		write_eport_csr(dd, i, dd->params->send_len_check0_reg, 0);
+		write_eport_csr(dd, i, dd->params->send_len_check1_reg, 0);
+		for (j = 0; j < VL_ARB_LOW_PRIO_TABLE_SIZE; j++) {
+			write_eport_csr(dd, i,
+					dd->params->send_low_priority_list_reg + (8 * j),
+					0);
+		}
+		for (j = 0; j < VL_ARB_HIGH_PRIO_TABLE_SIZE; j++) {
+			write_eport_csr(dd, i,
+					dd->params->send_high_priority_list_reg + (8 * j),
+					0);
+		}
+		for (j = 0; j < TXE_NUM_32_BIT_COUNTER; j++) {
+			write_eport_csr(dd, i,
+					dd->params->send_counter_array32_reg + (8 * j),
+					0);
+		}
+		for (j = 0; j < TXE_NUM_64_BIT_COUNTER; j++) {
+			write_eport_csr(dd, i,
+					dd->params->send_counter_array64_reg + (8 * j),
+					0);
+		}
+		write_eport_csr(dd, i, dd->params->send_cm_ctrl_reg,
+				SEND_CM_CTRL_RESETCSR);
+		write_eport_csr(dd, i, dd->params->send_cm_global_credit_reg,
+				SEND_CM_GLOBAL_CREDIT_RESETCSR);
+		/* SEND_CM_CREDIT_USED_STATUS read-only */
+		write_eport_csr(dd, i, dd->params->send_cm_timer_ctrl_reg, 0);
+		if (dd->params->chip_type == CHIP_WFR) {
+			write_eport_csr(dd, i, dd->params->send_cm_local_au_table0_to3_reg, 0);
+			write_eport_csr(dd, i, dd->params->send_cm_local_au_table4_to7_reg, 0);
+			write_eport_csr(dd, i, dd->params->send_cm_remote_au_table0_to3_reg, 0);
+			write_eport_csr(dd, i, dd->params->send_cm_remote_au_table4_to7_reg, 0);
+		}
+		for (j = 0; j < TXE_NUM_DATA_VL; j++)
+			write_eport_csr(dd, i, dd->params->send_cm_credit_vl_reg + (8 * j), 0);
+		write_eport_csr(dd, i, dd->params->send_cm_credit_vl15_reg, 0);
+		/* SEND_CM_CREDIT_USED_VL read-only */
+		/* SEND_CM_CREDIT_USED_VL15 read-only */
+		/* SEND_EGRESS_CTXT_STATUS read-only */
+		/* SEND_EGRESS_SEND_DMA_STATUS read-only */
+		write_eport_csr(dd, i, dd->params->send_egress_err_info_reg, ~0ull);
+		/* SEND_EGRESS_ERR_SOURCE read-only */
+	}
+	pio_reset_all(dd);	/* SEND_PIO_INIT_CTXT */
+	/* SEND_PIO_ERR_STATUS read-only */
+	write_csr(dd, dd->params->send_pio_err_mask_reg, 0);
+	write_csr(dd, dd->params->send_pio_err_clear_reg, ~0ull);
+	/* SEND_PIO_ERR_FORCE leave alone */
+	/* SEND_DMA_ERR_STATUS read-only */
+	write_csr(dd, dd->params->send_dma_err_mask_reg, 0);
+	write_csr(dd, dd->params->send_dma_err_clear_reg, ~0ull);
+	/* SEND_ERR_STATUS read-only */
+	write_csr(dd, dd->params->csr_err_mask_reg, 0);
+	write_csr(dd, dd->params->csr_err_clear_reg, ~0ull);
+	/* SEND_ERR_FORCE read-only */
+	for (i = 0; i < chip_send_contexts(dd) / NUM_CONTEXTS_PER_SET; i++)
+		write_csr(dd, SEND_CONTEXT_SET_CTRL + (8 * i), 0);
+
+	/*
+	 * TXE Per-Context CSRs
+	 */
+	for (i = dr->c.first_send_context; i < dr->c.last_send_context; i++) {
+		write_tctxt_csr(dd, i, dd->params->send_ctxt_ctrl_reg, 0);
+		write_sctxt_csr(dd, i, dd->params->send_ctxt_credit_ctrl_reg, 0);
+		write_sctxt_csr(dd, i, dd->params->send_ctxt_credit_return_addr_reg, 0);
+		write_sctxt_csr(dd, i, dd->params->send_ctxt_credit_force_reg, 0);
+		write_sctxt_csr(dd, i, dd->params->send_ctxt_err_mask_reg, 0);
+		write_sctxt_csr(dd, i, dd->params->send_ctxt_err_clear_reg, ~0ull);
+		for (j = 0; j < dd->num_pports; j++) {
+			write_epsc_csr(dd, j, i, dd->params->send_ctxt_check_enable_reg, 0);
+			write_epsc_csr(dd, j, i, dd->params->send_ctxt_check_vl_reg, 0);
+			write_epsc_csr(dd, j, i, dd->params->send_ctxt_check_job_key_reg, 0);
+			write_epsc_csr(dd, j, i, dd->params->send_ctxt_check_partition_key_reg, 0);
+			write_epsc_csr(dd, j, i, dd->params->send_ctxt_check_slid_reg, 0);
+			write_epsc_csr(dd, j, i, dd->params->send_ctxt_check_opcode_reg, 0);
+		}
+	}
+
+	/*
+	 * TXE Per-SDMA CSRs
+	 */
+	for (i = 0; i < chip_sdma_engines(dd); i++) {
+		write_sdma_csr(dd, i, dd->params->send_dma_ctrl_reg, 0);
+		/* SEND_DMA_STATUS read-only */
+		write_sdma_csr(dd, i, dd->params->send_dma_base_addr_reg, 0);
+		write_sdma_csr(dd, i, dd->params->send_dma_len_gen_reg, 0);
+		write_sdma_csr(dd, i, dd->params->send_dma_tail_reg, 0);
+		/* SEND_DMA_HEAD read-only */
+		write_sdma_csr(dd, i, dd->params->send_dma_head_addr_reg, 0);
+		write_sdma_csr(dd, i, dd->params->send_dma_priority_thld_reg, 0);
+		/* SEND_DMA_IDLE_CNT read-only */
+		write_sdma_csr(dd, i, dd->params->send_dma_reload_cnt_reg, 0);
+		write_sdma_csr(dd, i, dd->params->send_dma_desc_cnt_reg, 0);
+		/* SEND_DMA_DESC_FETCHED_CNT read-only */
+		/* SEND_DMA_ENG_ERR_STATUS read-only */
+		write_sdma_csr(dd, i, dd->params->send_dma_eng_err_mask_reg, 0);
+		write_sdma_csr(dd, i, dd->params->send_dma_eng_err_clear_reg, ~0ull);
+		/* SEND_DMA_ENG_ERR_FORCE leave alone */
+		if (dd->params->chip_type == CHIP_WFR) {
+			/* SEND_DMA_CHECK_* are WFR only */
+			write_kctxt_csr(dd, i, SEND_DMA_CHECK_ENABLE, 0);
+			write_kctxt_csr(dd, i, SEND_DMA_CHECK_VL, 0);
+			write_kctxt_csr(dd, i, SEND_DMA_CHECK_JOB_KEY, 0);
+			write_kctxt_csr(dd, i, SEND_DMA_CHECK_PARTITION_KEY, 0);
+			write_kctxt_csr(dd, i, SEND_DMA_CHECK_SLID, 0);
+			write_kctxt_csr(dd, i, SEND_DMA_CHECK_OPCODE, 0);
+		}
+		write_sdmacfg_csr(dd, i, dd->params->send_dma_cfg_memory_reg, 0);
+	}
+}
+
+/*
+ * Expect on entry:
+ * o Packet ingress is disabled, i.e. RcvCtrl.RcvPortEnable == 0
+ */
+static void init_rbufs(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+	int count;
+	int pidx = ppd->hw_pidx;
+
+	/*
+	 * Wait for DMA to stop: RxRbufPktPending and RxPktInProgress are
+	 * clear.
+	 */
+	count = 0;
+	while (1) {
+		reg = read_iport_csr(dd, pidx, dd->params->rcv_iport_status_reg);
+		if ((reg & (RCV_STATUS_RX_RBUF_PKT_PENDING_SMASK
+			    | RCV_STATUS_RX_PKT_IN_PROGRESS_SMASK)) == 0)
+			break;
+		/*
+		 * Give up after 1ms - maximum wait time.
+		 *
+		 * RBuf size is 136KiB.  Slowest possible is PCIe Gen1 x1 at
+		 * 250MB/s bandwidth.  Lower rate to 66% for overhead to get:
+		 *	136 KB / (66% * 250MB/s) = 844us
+		 */
+		if (count++ > 500) {
+			ppd_dev_err(ppd,
+				    "%s: in-progress DMA not clearing: RcvStatus 0x%llx, continuing\n",
+				    __func__, reg);
+			break;
+		}
+		udelay(2); /* do not busy-wait the CSR */
+	}
+
+	/* start the init - expect RcvCtrl to be 0 */
+	write_iport_csr(dd, pidx, dd->params->rcv_iport_ctrl_reg,
+			RCV_CTRL_RX_RBUF_INIT_SMASK);
+
+	/*
+	 * Read to force the write of RcvCtrl.RxRbufInit.  There is a brief
+	 * period after the write before RcvStatus.RxRbufInitDone is valid.
+	 * The delay in the first run through the loop below is sufficient and
+	 * required before the first read of RcvStatus.RxRbufInitDone.
+	 */
+	read_iport_csr(dd, pidx, dd->params->rcv_iport_ctrl_reg);
+
+	/* wait for the init to finish */
+	count = 0;
+	while (1) {
+		/* delay is required first time through - see above */
+		udelay(2); /* do not busy-wait the CSR */
+		reg = read_iport_csr(dd, pidx, dd->params->rcv_iport_status_reg);
+		if (reg & (RCV_STATUS_RX_RBUF_INIT_DONE_SMASK))
+			break;
+
+		/* give up after 100us - slowest possible at 33MHz is 73us */
+		if (count++ > 50) {
+			ppd_dev_err(ppd,
+				    "%s: RcvStatus.RxRbufInit not set, continuing\n",
+				    __func__);
+			break;
+		}
+	}
+}
+
+/* set RXE CSRs to chip reset defaults */
+static void reset_rxe_csrs(struct hfi2_devdata *dd)
+{
+	u32 num_rmt_csrs = dd->params->rsm_map_table_entries /
+			   dd->params->rsm_map_table_entries_per_csr;
+	u32 num_qp_table_regs = dd->params->qp_map_table_entries /
+				dd->params->qp_map_table_entries_per_csr;
+	int i, j;
+
+	/*
+	 * RXE per-port Kernel CSRs
+	 */
+	for (i = 0; i < dd->num_pports; i++) {
+		struct hfi2_pportdata *ppd = dd->pport + i;
+		int pidx = ppd->hw_pidx;
+
+		write_iport_csr(dd, pidx, dd->params->rcv_iport_ctrl_reg, 0);
+		init_rbufs(ppd);
+		/* RCV_STATUS read-only */
+		/* RCV_CONTEXTS read-only */
+		/* RCV_ARRAY_CNT read-only */
+		/* RCV_BUF_SIZE read-only */
+		write_iport_csr(dd, pidx, dd->params->rcv_bth_qp_reg, 0);
+		write_iport_csr(dd, pidx, dd->params->rcv_multicast_reg, 0);
+		write_iport_csr(dd, pidx, dd->params->rcv_bypass_reg, 0);
+		write_iport_csr(dd, pidx, dd->params->rcv_vl15_reg, 0);
+		/* this is a clear-down */
+		write_iport_csr(dd, pidx, dd->params->rcv_err_info_reg,
+				RCV_ERR_INFO_RCV_EXCESS_BUFFER_OVERRUN_SMASK);
+		/* RCV_ERR_STATUS read-only */
+		write_iport_csr(dd, pidx, dd->params->rcv_err_mask_reg, 0);
+		write_iport_csr(dd, pidx, dd->params->rcv_err_clear_reg, ~0ull);
+		/* RCV_ERR_FORCE leave alone */
+		for (i = 0; i < num_qp_table_regs; i++)
+			write_iport_csr(dd, pidx,
+					dd->params->rcv_qp_map_table_reg + (8 * i), 0);
+		for (i = 0; i < 4; i++)
+			write_iport_csr(dd, pidx,
+					dd->params->rcv_partition_key_reg + (8 * i), 0);
+		for (i = 0; i < RXE_NUM_32_BIT_COUNTERS; i++)
+			write_iport_csr(dd, pidx, dd->params->rcv_counter_array32_reg +
+					(8 * i), 0);
+		for (i = 0; i < RXE_NUM_64_BIT_COUNTERS; i++)
+			write_iport_csr(dd, pidx, dd->params->rcv_counter_array64_reg +
+					(8 * i), 0);
+	}
+
+	/* FIXME: this should be from "rsm_rule_start", not zero
+	 * ...or not.  Is this called by JKR?
+	 */
+	for (i = 0; i < dd->params->rsm_rule_size; i++)
+		clear_rsm_rule(dd, i);
+	for (i = 0; i < num_rmt_csrs; i++)
+		write_csr(dd, dd->params->rcv_rsm_map_table_reg + (8 * i), 0);
+
+	/*
+	 * RXE Kernel and User Per-Context CSRs
+	 */
+	for (i = 0; i < chip_rcv_contexts(dd); i++) {
+		/* kernel */
+		write_kctxt_csr(dd, i, dd->params->rcv_kctxt_ctrl_reg, 0);
+		write_rctxt_csr(dd, i, dd->params->rcv_rctxt_ctrl_reg, 0);
+		/* RCV_CTXT_STATUS read-only */
+		write_rctxt_csr(dd, i, dd->params->rcv_egr_ctrl_reg, 0);
+		write_rctxt_csr(dd, i, dd->params->rcv_tid_ctrl_reg, 0);
+		for (j = 0; j < dd->num_pports; j++)
+			write_iprc_csr(dd, j, i, dd->params->rcv_jkey_ctrl_reg, 0);
+		write_kctxt_csr(dd, i, dd->params->rcv_hdr_addr_reg, 0);
+		if (dd->params->set_rheq_addr)
+			dd->params->set_rheq_addr(dd, i, 0);
+		write_kctxt_csr(dd, i, dd->params->rcv_hdr_cnt_reg, 0);
+		write_kctxt_csr(dd, i, dd->params->rcv_hdr_ent_size_reg, 0);
+		if (dd->params->chip_type == CHIP_WFR)
+			write_kctxt_csr(dd, i, RCV_HDR_SIZE, 0);
+		write_kctxt_csr(dd, i, dd->params->rcv_hdr_tail_addr_reg, 0);
+		write_kctxt_csr(dd, i, dd->params->rcv_avail_time_out_reg, 0);
+		write_kctxt_csr(dd, i, dd->params->rcv_hdr_ovfl_cnt_reg, 0);
+
+		/* user */
+		/* RCV_HDR_TAIL read-only */
+		write_uctxt_csr(dd, i, dd->params->rcv_hdr_head_reg, 0);
+		/* RCV_EGR_INDEX_TAIL read-only */
+		write_uctxt_csr(dd, i, dd->params->rcv_egr_index_head_reg, 0);
+		/* RCV_EGR_OFFSET_TAIL read-only */
+		for (j = 0; j < RXE_NUM_TID_FLOWS; j++) {
+			write_uctxt_csr(dd, i,
+					dd->params->rcv_tid_flow_table_reg + (8 * j), 0);
+		}
+	}
+}
+
+/*
+ * Set sc2vl tables.
+ *
+ * They power on to zeros, so to avoid send context errors
+ * they need to be set:
+ *
+ * SC 0-7 -> VL 0-7 (respectively)
+ * SC 15  -> VL 15
+ * otherwise
+ *        -> VL 0
+ */
+static void init_sc2vl_tables(struct hfi2_devdata *dd)
+{
+	int i;
+	int j;
+	/* init per architecture spec, constrained by hardware capability */
+
+	if (dd->params->chip_type != CHIP_WFR) {
+		if (dd->is_vf)
+			return;
+		/* cport is active - read the current sc2vlt */
+		for (i = 0; i < dd->num_pports; i++) {
+			struct hfi2_pportdata *ppd = &dd->pport[i];
+
+			get_sc2vlt_tables(ppd, ppd->sc2vl);
+		}
+
+		return;
+	}
+
+	/* HFI maps sent packets */
+	for (i = 0; i < dd->num_pports; i++) {
+		write_eport_csr(dd, i, dd->params->send_sc2vlt0_reg, SC2VL_VAL(
+				0,
+				0, 0, 1, 1,
+				2, 2, 3, 3,
+				4, 4, 5, 5,
+				6, 6, 7, 7));
+		write_eport_csr(dd, i, dd->params->send_sc2vlt1_reg, SC2VL_VAL(
+				1,
+				8, 0, 9, 0,
+				10, 0, 11, 0,
+				12, 0, 13, 0,
+				14, 0, 15, 15));
+		write_eport_csr(dd, i, dd->params->send_sc2vlt2_reg, SC2VL_VAL(
+				2,
+				16, 0, 17, 0,
+				18, 0, 19, 0,
+				20, 0, 21, 0,
+				22, 0, 23, 0));
+		write_eport_csr(dd, i, dd->params->send_sc2vlt3_reg, SC2VL_VAL(
+				3,
+				24, 0, 25, 0,
+				26, 0, 27, 0,
+				28, 0, 29, 0,
+				30, 0, 31, 0));
+	}
+
+	/* DC maps received packets */
+	write_csr(dd, DCC_CFG_SC_VL_TABLE_15_0, DC_SC_VL_VAL(15_0,
+		  0, 0, 1, 1,  2, 2,  3, 3,  4, 4,  5, 5,  6, 6,  7,  7,
+		  8, 0, 9, 0, 10, 0, 11, 0, 12, 0, 13, 0, 14, 0, 15, 15));
+	write_csr(dd, DCC_CFG_SC_VL_TABLE_31_16, DC_SC_VL_VAL(31_16,
+		  16, 0, 17, 0, 18, 0, 19, 0, 20, 0, 21, 0, 22, 0, 23, 0,
+		  24, 0, 25, 0, 26, 0, 27, 0, 28, 0, 29, 0, 30, 0, 31, 0));
+
+	/* initialize the cached sc2vl values consistently with h/w */
+	for (i = 0; i < dd->num_pports; i++) {
+		struct hfi2_pportdata *ppd = &dd->pport[i];
+
+		for (j = 0; j < 32; j++) {
+			if (j < 8 || j == 15)
+				*((u8 *)(ppd->sc2vl) + j) = (u8)j;
+			else
+				*((u8 *)(ppd->sc2vl) + j) = 0;
+		}
+	}
+}
+
+/*
+ * Read chip sizes and then reset parts to sane, disabled, values.  We cannot
+ * depend on the chip going through a power-on reset - a driver may be loaded
+ * and unloaded many times.
+ *
+ * Do not write any CSR values to the chip in this routine - there may be
+ * a reset following the (possible) FLR in this routine.
+ *
+ */
+static int init_chip(struct hfi2_devdata *dd)
+{
+	int i;
+	int ret = 0;
+	u32 cce_int_mask_reg = dd->params->cce_int_mask_reg;
+
+	/*
+	 * Put the HFI CSRs in a known state.
+	 * Combine this with a DC reset.
+	 *
+	 * Stop the device from doing anything while we do a
+	 * reset.  We know there are no other active users of
+	 * the device since we are now in charge.  Turn
+	 * off all outbound and inbound traffic and make sure
+	 * the device does not generate any interrupts.
+	 */
+
+	/* disable send contexts and SDMA engines */
+	for (i = 0; i < dd->num_pports; i++)
+		write_eport_csr(dd, i, dd->params->send_ctrl_reg, 0);
+	for (i = 0; i < chip_send_contexts(dd); i++)
+		write_tctxt_csr(dd, i, dd->params->send_ctxt_ctrl_reg, 0);
+	for (i = 0; i < chip_sdma_engines(dd); i++)
+		write_sdma_csr(dd, i, dd->params->send_dma_ctrl_reg, 0);
+	/* disable port (turn off RXE inbound traffic) and contexts */
+	for (i = 0; i < dd->num_pports; i++)
+		write_iport_csr(dd, i, dd->params->rcv_iport_ctrl_reg, 0);
+	for (i = 0; i < chip_rcv_contexts(dd); i++) {
+		write_kctxt_csr(dd, i, dd->params->rcv_kctxt_ctrl_reg, 0);
+		write_rctxt_csr(dd, i, dd->params->rcv_rctxt_ctrl_reg, 0);
+	}
+	/* mask all interrupt sources */
+	for (i = 0; i < dd->params->num_int_csrs; i++)
+		write_csr(dd, cce_int_mask_reg + (8 * i), 0ull);
+
+	/*
+	 * DC Reset: do a full DC reset before the register clear.
+	 * A recommended length of time to hold is one CSR read,
+	 * so reread the CceDcCtrl.  Then, hold the DC in reset
+	 * across the clear.
+	 */
+	write_csr(dd, CCE_DC_CTRL, CCE_DC_CTRL_DC_RESET_SMASK);
+	(void)read_csr(dd, CCE_DC_CTRL);
+
+	if (use_flr) {
+		/*
+		 * A FLR will reset the SPC core and part of the PCIe.
+		 * The parts that need to be restored have already been
+		 * saved.
+		 */
+		dd_dev_info(dd, "Resetting CSRs with FLR\n");
+
+		/* do the FLR, the DC reset will remain */
+		pcie_flr(dd->pcidev);
+
+		/* restore command and BARs */
+		ret = restore_pci_variables(dd);
+		if (ret) {
+			dd_dev_err(dd, "%s: Could not restore PCI variables\n",
+				   __func__);
+			return ret;
+		}
+
+		if (is_ax(dd)) {
+			dd_dev_info(dd, "Resetting CSRs with FLR\n");
+			pcie_flr(dd->pcidev);
+			ret = restore_pci_variables(dd);
+			if (ret) {
+				dd_dev_err(dd, "%s: Could not restore PCI variables\n",
+					   __func__);
+				return ret;
+			}
+		}
+	} else {
+		dd_dev_info(dd, "Resetting CSRs with writes\n");
+		reset_cce_csrs(dd);
+		reset_txe_csrs(dd);
+		reset_rxe_csrs(dd);
+		reset_misc_csrs(dd);
+	}
+	/* clear the DC reset */
+	write_csr(dd, CCE_DC_CTRL, 0);
+
+	/* Turn off LEDs */
+	for (i = 0; i < dd->num_pports; i++)
+		dd->params->setextled(&dd->pport[i], 0);
+
+	/*
+	 * Clear the QSFP reset.
+	 * An FLR enforces a 0 on all out pins. The driver does not touch
+	 * ASIC_QSFPn_OUT otherwise.  This leaves RESET_N low and
+	 * anything plugged constantly in reset, if it pays attention
+	 * to RESET_N.
+	 * Prime examples of this are optical cables. Set all pins high.
+	 * I2CCLK and I2CDAT will change per direction, and INT_N and
+	 * MODPRS_N are input only and their value is ignored.
+	 */
+	write_csr(dd, ASIC_QSFP1_OUT, 0x1f);
+	write_csr(dd, ASIC_QSFP2_OUT, 0x1f);
+	init_chip_resources(dd);
+	return ret;
+}
+
+void init_early_variables(struct hfi2_devdata *dd)
+{
+	int i;
+
+	/* assign link credit variables */
+	dd->vau = CM_VAU;
+	dd->link_credits = CM_GLOBAL_CREDITS;
+	if (is_ax(dd))
+		dd->link_credits--;
+	dd->vcu = cu_to_vcu(hfi2_cu);
+	/* enough room for 8 MAD packets plus header - 17K */
+	dd->vl15_init = (8 * (2048 + 128)) / vau_to_au(dd->vau);
+	if (dd->vl15_init > dd->link_credits)
+		dd->vl15_init = dd->link_credits;
+
+	if (HFI2_CAP_IS_KSET(PKEY_CHECK))
+		for (i = 0; i < dd->num_pports; i++) {
+			struct hfi2_pportdata *ppd = &dd->pport[i];
+
+			set_partition_keys(ppd);
+		}
+	init_sc2vl_tables(dd);
+}
+
+void init_kdeth_qp(struct hfi2_devdata *dd)
+{
+	u64 val;
+	int i;
+
+	if (dd->is_vf)
+		return; /* Only PF0 does this */
+
+	for (i = 0; i < dd->num_pports; i++) {
+		val = (RVT_KDETH_QP_PREFIX & SEND_BTH_QP_KDETH_QP_MASK) <<
+		      SEND_BTH_QP_KDETH_QP_SHIFT;
+		write_eport_csr(dd, i, dd->params->send_bth_qp_reg, val);
+		if (dd->is_sriov)
+			write_eport_csr(dd, loopback_pidx_dd(dd, i),
+					dd->params->send_bth_qp_reg, val);
+
+		val = (RVT_KDETH_QP_PREFIX & RCV_BTH_QP_KDETH_QP_MASK) <<
+		      RCV_BTH_QP_KDETH_QP_SHIFT;
+		write_iport_csr(dd, i, dd->params->rcv_bth_qp_reg, val);
+		if (dd->is_sriov)
+			write_iport_csr(dd, loopback_pidx_dd(dd, i),
+					dd->params->rcv_bth_qp_reg, val);
+	}
+}
+
+/**
+ * hfi2_get_qp_map - get qp map entry
+ * @dd: device data
+ * @idx: index to read (will be masked to table size)
+ */
+u16 hfi2_get_qp_map(struct hfi2_pportdata *ppd, u16 idx)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 tbl_idx;
+	u32 reg_idx;
+	u32 entry_idx;
+	u32 off;
+	u64 reg;
+
+	if (dd->is_vf)
+		return vf2pf_get_qp_map(dd, ppd->hw_pidx, idx);
+
+	tbl_idx = idx & (dd->params->qp_map_table_entries - 1);
+	reg_idx = tbl_idx / dd->params->qp_map_table_entries_per_csr;
+	entry_idx = tbl_idx % dd->params->qp_map_table_entries_per_csr;
+
+	off = dd->params->rcv_qp_map_table_reg + (reg_idx * 8);
+	reg = read_iport_csr(dd, ppd->hw_pidx, off);
+
+	return (reg >> (entry_idx * dd->params->qp_map_table_entry_shift))
+		& dd->params->qp_map_table_entry_mask;
+}
+
+/**
+ * init_qpmap_table - init qp map
+ * @dd: device data
+ * @first_ctxt: first context
+ * @last_ctxt: first context
+ *
+ * This return sets the qpn mapping table that
+ * is indexed by qpn[8:1].
+ *
+ * The routine will round robin the 256 settings
+ * from first_ctxt to last_ctxt.
+ *
+ * The first/last looks ahead to having specialized
+ * receive contexts for mgmt and bypass.  Normal
+ * verbs traffic will assumed to be on a range
+ * of receive contexts.
+ *
+ * Assumes loopback QP map is identical to fabric port QP map.
+ */
+static void init_qpmap_table(struct hfi2_pportdata *ppd,
+			     u32 first_ctxt,
+			     u32 last_ctxt)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg = 0;
+	u64 ctxt = first_ctxt;
+	u32 regno = dd->params->rcv_qp_map_table_reg;
+	u32 entry_shift = dd->params->qp_map_table_entry_shift;
+	u32 entry_top = dd->params->qp_map_table_entries_per_csr - 1;
+	int count = dd->params->qp_map_table_entries;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		u32 entry_idx = i % dd->params->qp_map_table_entries_per_csr;
+
+		reg |= ctxt << (entry_shift * entry_idx);
+		ctxt++;
+		if (ctxt > last_ctxt)
+			ctxt = first_ctxt;
+		if (entry_idx == entry_top) {
+			write_iport_csr(dd, ppd->hw_pidx, regno, reg);
+			if (dd->is_sriov)
+				write_iport_csr(dd, loopback_pidx(ppd), regno, reg);
+			reg = 0;
+			regno += 8;
+		}
+	}
+
+	add_rcvctrl(ppd, RCV_CTRL_RCV_QP_MAP_ENABLE_SMASK
+		    | RCV_CTRL_RCV_BYPASS_ENABLE_SMASK);
+}
+
+/*
+ * Assumes loopback QP map is identical to fabric port QP map.
+ */
+static void init_qpmap_table_range(struct hfi2_pportdata *ppd,
+				   u32 start_idx, u32 end_idx,
+				   u32 first_ctxt, u32 last_ctxt)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg = 0;
+	u32 regno;
+	int i;
+	u64 ctxt = first_ctxt;
+	bool valid = false;
+
+	regno = dd->params->rcv_qp_map_table_reg + (start_idx & ~7);
+	for (i = start_idx; i < end_idx; i++) {
+		if (!valid) {
+			reg = read_iport_csr(dd, ppd->hw_pidx, regno);
+			valid = true;
+		}
+		reg &= ~(0xffull << (8 * (i % 8)));
+		reg |= ctxt << (8 * (i % 8));
+		ctxt++;
+		if (ctxt > last_ctxt)
+			ctxt = first_ctxt;
+		if (i % 8 == 7) {
+			write_iport_csr(dd, ppd->hw_pidx, regno, reg);
+			if (dd->is_sriov)
+				write_iport_csr(dd, loopback_pidx(ppd), regno, reg);
+			reg = 0;
+			regno += 8;
+			valid = false;
+		}
+	}
+	if (valid) {
+		write_iport_csr(dd, ppd->hw_pidx, regno, reg);
+		if (dd->is_sriov)
+			write_iport_csr(dd, loopback_pidx(ppd), regno, reg);
+	}
+}
+
+struct rsm_map_table {
+	unsigned int used;
+	u64 map[];
+};
+
+static void set_rmt_entry(struct hfi2_devdata *dd, struct rsm_map_table *rmt,
+			  u16 idx, u16 value);
+
+struct rsm_rule_data {
+	u16 offset;
+	u8 pkt_type;
+	u8 pidx_mask;
+	u32 field1_off;
+	u32 field2_off;
+	u32 index1_off;
+	u32 index1_width;
+	u32 index2_off;
+	u32 index2_width;
+	u32 mask1;
+	u32 value1;
+	u32 mask2;
+	u32 value2;
+};
+
+/*
+ * Return an initialized RMT map table for users to fill in.  OK if it
+ * returns NULL, indicating no table.
+ */
+static struct rsm_map_table *alloc_rsm_map_table(struct hfi2_devdata *dd)
+{
+	struct rsm_map_table *rmt;
+	u32 num_rmt_csrs = dd->params->rsm_map_table_entries /
+			   dd->params->rsm_map_table_entries_per_csr;
+	/* 0 is default if a0 version */
+	u16 rxcontext = is_ax(dd) ? 0 : dd->params->rsm_map_table_entry_mask;
+	u32 i;
+
+	rmt = kmalloc(sizeof(*rmt) + (sizeof(rmt->map[0]) * num_rmt_csrs), GFP_KERNEL);
+	if (rmt) {
+		for (i = 0; i < dd->params->rsm_map_table_entries; ++i)
+			set_rmt_entry(dd, rmt, i, rxcontext);
+		rmt->used = 0;
+		/* FIXME: This should be from a "resource start" point. */
+	}
+
+	return rmt;
+}
+
+/*
+ * Write the final RSM map table to the chip and enable RSM on each port.
+ */
+static void complete_rsm_map_table(struct hfi2_devdata *dd,
+				   struct rsm_map_table *rmt)
+{
+	u32 num_rmt_csrs = dd->params->rsm_map_table_entries /
+			   dd->params->rsm_map_table_entries_per_csr;
+	int i;
+
+	/* write table to chip */
+	for (i = 0; i < num_rmt_csrs; i++)
+		write_csr(dd, dd->params->rcv_rsm_map_table_reg + (8 * i), rmt->map[i]);
+
+	/* enable RSM on each port */
+	for (i = 0; i < dd->num_pports; i++)
+		add_rcvctrl(dd->pport + i, RCV_CTRL_RCV_RSM_ENABLE_SMASK);
+}
+
+/*
+ * Add a receive side mapping rule.
+ */
+static void add_rsm_rule(struct hfi2_devdata *dd, u8 rule_index,
+			 struct rsm_rule_data *rrd)
+{
+	write_csr(dd, dd->params->rcv_rsm_cfg_reg + (8 * rule_index),
+		  (u64)rrd->offset << dd->params->rsm_rule_offset_shift |
+		  (u64)rrd->pidx_mask << 40 | /* port enable mask (non WFR) */
+		  1ull << (rule_index % 4) | /* enable bit, no chain */
+		  (u64)rrd->pkt_type << RCV_RSM_CFG_PACKET_TYPE_SHIFT);
+	write_csr(dd, dd->params->rcv_rsm_select_reg + (8 * rule_index),
+		  (u64)rrd->field1_off << RCV_RSM_SELECT_FIELD1_OFFSET_SHIFT |
+		  (u64)rrd->field2_off << RCV_RSM_SELECT_FIELD2_OFFSET_SHIFT |
+		  (u64)rrd->index1_off << RCV_RSM_SELECT_INDEX1_OFFSET_SHIFT |
+		  (u64)rrd->index1_width << RCV_RSM_SELECT_INDEX1_WIDTH_SHIFT |
+		  (u64)rrd->index2_off << RCV_RSM_SELECT_INDEX2_OFFSET_SHIFT |
+		  (u64)rrd->index2_width << RCV_RSM_SELECT_INDEX2_WIDTH_SHIFT);
+	write_csr(dd, dd->params->rcv_rsm_match_reg + (8 * rule_index),
+		  (u64)rrd->mask1 << RCV_RSM_MATCH_MASK1_SHIFT |
+		  (u64)rrd->value1 << RCV_RSM_MATCH_VALUE1_SHIFT |
+		  (u64)rrd->mask2 << RCV_RSM_MATCH_MASK2_SHIFT |
+		  (u64)rrd->value2 << RCV_RSM_MATCH_VALUE2_SHIFT);
+}
+
+/*
+ * Clear a receive side mapping rule.
+ */
+static void clear_rsm_rule(struct hfi2_devdata *dd, int rule_index)
+{
+	if (rule_index < 0 || rule_index >= dd->params->rsm_rule_size)
+		return;
+
+	write_csr(dd, dd->params->rcv_rsm_cfg_reg + (8 * rule_index), 0);
+	write_csr(dd, dd->params->rcv_rsm_select_reg + (8 * rule_index), 0);
+	write_csr(dd, dd->params->rcv_rsm_match_reg + (8 * rule_index), 0);
+	if (test_and_clear_bit(rule_index, dd->rsm_rule_bitmap) == 0) {
+		dd_dev_err(dd, "%s: rule_index %d not set\n", __func__,
+			   rule_index);
+	}
+}
+
+/*
+ * Release all allocated rules.
+ * Expect to be called at driver unload time.
+ */
+void release_rsm_rules(struct hfi2_devdata *dd)
+{
+	int i;
+
+	if (!dd->rsm_rule_init)
+		return;
+
+	for (i = dd->first_rsm_rule; i < dd->params->rsm_rule_size; i++) {
+		if (test_bit(i, dd->rsm_rule_bitmap))
+			clear_rsm_rule(dd, i);
+	}
+	dd->rsm_rule_init = false;
+}
+
+/*
+ * Allocate a RSM rule index.
+ * Returns >=0 rule index, or -ENOSPC if no room
+ */
+static int alloc_rsm_rule(struct hfi2_devdata *dd, int type)
+{
+	unsigned long rule_index;
+
+	/* loop in case there is an allocate race */
+	while (1) {
+		rule_index = find_first_zero_bit(dd->rsm_rule_bitmap,
+						 dd->params->rsm_rule_size);
+		if (rule_index >= dd->params->rsm_rule_size) {
+			dd_dev_err(dd, "Unable to allocate rule for type %d\n",
+			           type);
+			return -ENOSPC;
+		}
+
+		if (test_and_set_bit(rule_index, dd->rsm_rule_bitmap) == 0)
+			break;
+	}
+	return (int)rule_index;
+}
+
+/* return the number of RSM map table entries that will be used for QOS */
+static int qos_rmt_entries(unsigned int n_krcv_queues, unsigned int *mp,
+			   unsigned int *np)
+{
+	int i;
+	unsigned int m, n;
+	uint max_by_vl = 0;
+
+	/* is QOS active at all? */
+	if (n_krcv_queues < MIN_KERNEL_KCTXTS ||
+	    num_vls == 1 ||
+	    krcvqsset <= 1)
+		goto no_qos;
+
+	/* determine bits for qpn */
+	for (i = 0; i < min_t(unsigned int, num_vls, krcvqsset); i++)
+		if (krcvqs[i] > max_by_vl)
+			max_by_vl = krcvqs[i];
+	if (max_by_vl > 32)
+		goto no_qos;
+	m = ilog2(__roundup_pow_of_two(max_by_vl));
+
+	/* determine bits for vl */
+	n = ilog2(__roundup_pow_of_two(num_vls));
+
+	/* reject if too much is used */
+	if ((m + n) > 7)
+		goto no_qos;
+
+	if (mp)
+		*mp = m;
+	if (np)
+		*np = n;
+
+	return 1 << (m + n);
+
+no_qos:
+	if (mp)
+		*mp = 0;
+	if (np)
+		*np = 0;
+	return 0;
+}
+
+/**
+ * init_qos_port - initialize RX QOS for a single port
+ * @ppd: port data
+ * @rmt: RSM map table
+ *
+ * This routine initializes a rule and the RSM map table to implement
+ * quality of service (qos) for this port.
+ *
+ * If all of the limit tests succeed, qos is applied based on the array
+ * interpretation of krcvqs where entry 0 is VL0.
+ *
+ * The number of vl bits (n) and the number of qpn bits (m) are computed to
+ * feed both the RSM map table and the single rule.
+ */
+static void init_qos_port(struct hfi2_pportdata *ppd, struct rsm_map_table *rmt)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	struct hfi2_portrsrcs *pr = &dr->ppr[ppd->hw_pidx];
+	unsigned int rcb = pr->rcv_context_base;
+	struct rsm_rule_data rrd;
+	unsigned int qpns_per_vl, extended_vl, ctxt, i, qpn, n, m;
+	unsigned int rmt_entries;
+	int rule_index;
+
+	if (!rmt)
+		goto bail;
+	if (!pr->n_krcv_queues)
+		goto bail;
+	rmt_entries = qos_rmt_entries(pr->n_krcv_queues - 1, &m, &n);
+	if (rmt_entries == 0)
+		goto bail;
+	qpns_per_vl = 1 << m;
+	extended_vl = 1 << n;
+
+	/* enough room in the map table? */
+	if (rmt->used + rmt_entries > dd->params->rsm_map_table_entries)
+		goto bail;
+
+	/* allocate a rule */
+	rule_index = alloc_rsm_rule(dd, RSM_TYPE_VERBS);
+	if (rule_index < 0)
+		goto bail;
+
+	/* fill block in RMT with this port's control context */
+	ctxt = rcb + HFI2_CTRL_CTXT;
+	for (i = 0; i < rmt_entries; i++)
+		set_rmt_entry(dd, rmt, rmt->used + i, ctxt);
+
+	/* overwrite applicable qos entries */
+	ctxt = rcb + FIRST_KERNEL_KCTXT;
+	for (i = 0; i < num_vls; i++) {
+		unsigned int tctxt;
+		unsigned int idx;
+
+		for (qpn = 0, tctxt = ctxt;
+		     krcvqs[i] && qpn < qpns_per_vl; qpn++) {
+			/* generate the index the hardware will produce */
+			idx = rmt->used + ((qpn << n) ^ i);
+			set_rmt_entry(dd, rmt, idx, tctxt);
+			tctxt++;
+			if (tctxt == ctxt + krcvqs[i])
+				tctxt = ctxt;
+		}
+		ctxt += krcvqs[i];
+	}
+
+	/*
+	 * Create a rule to extract an index using the formula:
+	 *	idx = qpn[m+n+1:1] ^ VL[n-1:0]
+	 *
+	 * The "qos_shift" setting will ensure the bottom n+1 bits of the QPN
+	 * will always be zero (except for GSI QPN=1).
+	 */
+	rrd.offset = rmt->used;
+	rrd.pkt_type = RHF_RCV_TYPE_IB;
+	rrd.pidx_mask = 1 << ppd->hw_pidx;
+	rrd.field1_off = LRH_BTH_MATCH_OFFSET;
+	rrd.field2_off = LRH_SC_MATCH_OFFSET;
+	rrd.index1_off = LRH_SC_SELECT_OFFSET;
+	rrd.index1_width = n;
+	rrd.index2_off = QPN_SELECT_OFFSET;
+	rrd.index2_width = m + n;
+	rrd.mask1 = LRH_BTH_MASK;
+	rrd.value1 = LRH_BTH_VALUE;
+	rrd.mask2 = LRH_SC_MASK;
+	rrd.value2 = LRH_SC_VALUE;
+
+	/* add rule */
+	add_rsm_rule(dd, rule_index, &rrd);
+
+	/* mark RSM map entries as used */
+	rmt->used += rmt_entries;
+
+	ppd->qos_shift = n + 1;
+
+	/* map everything else to this port's mcast/err/vl15 context */
+	init_qpmap_table(ppd, rcb + HFI2_CTRL_CTXT, rcb + HFI2_CTRL_CTXT);
+	return;
+bail:
+	ppd->qos_shift = 1;
+
+	if (pr->n_krcv_queues) {
+		/* map everything to this port's kernel contexts (excl. HFI2_CTRL_CTXT) */
+		ctxt = rcb + FIRST_KERNEL_KCTXT;
+		init_qpmap_table(ppd, ctxt,
+				 ctxt + pr->n_krcv_queues - FIRST_KERNEL_KCTXT - 1);
+	}
+}
+
+void restore_qpmap_table(struct hfi2_devdata *dd)
+{
+	struct hfi2_pportdata *ppd;
+	struct hfi2_portrsrcs *pr;
+	int i;
+	unsigned int rcb, ctxt;
+
+	for (i = 0; i < dd->num_pports; i++) {
+		pr = &dd->rsrcs.ppr[i];
+		if (!pr->n_krcv_queues)
+			continue;
+		ppd = &dd->pport[i];
+		rcb = pr->rcv_context_base;
+		if (ppd->qos_shift == 1) {
+			ctxt = rcb + FIRST_KERNEL_KCTXT;
+			init_qpmap_table(ppd, ctxt,
+					 ctxt + pr->n_krcv_queues - FIRST_KERNEL_KCTXT - 1);
+		} else {
+			init_qpmap_table(ppd, rcb + HFI2_CTRL_CTXT, rcb + HFI2_CTRL_CTXT);
+		}
+	}
+}
+
+static void init_qos(struct hfi2_devdata *dd, struct rsm_map_table *rmt)
+{
+	int i;
+
+	for (i = 0; i < dd->num_pports; i++)
+		init_qos_port(&dd->pport[i], rmt);
+}
+
+/* set a single RSM Map Table (RMT) entry in the given map */
+static void set_rmt_entry(struct hfi2_devdata *dd, struct rsm_map_table *rmt,
+			  u16 idx, u16 value)
+{
+	u64 reg;
+	int regoff, regidx;
+	u32 entries_per_csr = dd->params->rsm_map_table_entries_per_csr;
+	u32 entry_mask = dd->params->rsm_map_table_entry_mask;
+	u32 entry_shift = dd->params->rsm_map_table_entry_shift;
+
+	regoff = ((int)idx % entries_per_csr) * entry_shift;
+	regidx = (int)idx / entries_per_csr;
+	reg = rmt->map[regidx];
+	reg &= ~((u64)entry_mask << regoff);
+	reg |= ((u64)(value & entry_mask) << regoff);
+	rmt->map[regidx] = reg;
+}
+
+static void init_fecn_handling(struct hfi2_pportdata *ppd,
+			       struct rsm_map_table *rmt)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	struct hfi2_portrsrcs *pr = &dr->ppr[ppd->hw_pidx];
+	struct rsm_rule_data rrd;
+	int i, idx, start, end;
+	u16 offset;
+	u32 total_cnt;
+	int rule_index;
+
+	/* do nothing if port is not available */
+	if (!port_available_ppd(ppd))
+		return;
+
+	if (HFI2_CAP_IS_KSET(TID_RDMA))
+		/* Exclude control context */
+		start = pr->rcv_context_base + 1;
+	else
+		start = pr->first_dyn_alloc_ctxt;
+	end = pr->rcv_context_base + pr->num_rcv_contexts;
+
+	total_cnt = end - start;
+
+	/* there needs to be enough room in the map table */
+	if (rmt->used + total_cnt > dd->params->rsm_map_table_entries) {
+		ppd_dev_err(ppd, "FECN handling disabled - too many contexts allocated\n");
+		return;
+	}
+
+	rule_index = alloc_rsm_rule(dd, RSM_TYPE_FECN);
+	if (rule_index < 0)
+		return;
+
+	/*
+	 * RSM will extract the destination context as an index into the
+	 * map table.  The destination contexts are a sequential block
+	 * in the range start..end-1 (inclusive).
+	 * Map entries are accessed as offset + extracted value.  Adjust
+	 * the added offset so this sequence can be placed anywhere in
+	 * the table - as long as the entries themselves do not wrap.
+	 * There are only enough bits in offset for the table size, so
+	 * start with that to allow for a "negative" offset.
+	 */
+	offset = (dd->params->rsm_map_table_entries + rmt->used - start) &
+		 dd->params->rsm_map_table_entry_mask;
+
+	for (i = start, idx = rmt->used; i < end; i++, idx++) {
+		/* replace with identity mapping */
+		set_rmt_entry(dd, rmt, idx, i);
+	}
+
+	/*
+	 * For RSM intercept of Expected FECN packets:
+	 * o packet type 0 - expected
+	 * o match on F (bit 95), using select/match 1, and
+	 * o match on SH (bit 133), using select/match 2.
+	 *
+	 * Use index 1 to extract the 8-bit receive context from DestQP
+	 * (start at bit 64).  Use that as the RSM map table index.
+	 */
+	rrd.offset = offset;
+	rrd.pkt_type = RHF_RCV_TYPE_EXPECTED;
+	rrd.pidx_mask = 1 << ppd->hw_pidx;
+	rrd.field1_off = 95;
+	rrd.field2_off = 133;
+	rrd.index1_off = 64;
+	rrd.index1_width = 8;
+	rrd.index2_off = 0;
+	rrd.index2_width = 0;
+	rrd.mask1 = 1;
+	rrd.value1 = 1;
+	rrd.mask2 = 1;
+	rrd.value2 = 1;
+
+	add_rsm_rule(dd, rule_index, &rrd);
+
+	rmt->used += total_cnt;
+}
+
+static inline int hfi2_netdev_set_free_rmt_idx(struct hfi2_pportdata *ppd,
+					       struct rsm_map_table *rmt)
+{
+	if (rmt->used + NUM_NETDEV_MAP_ENTRIES > ppd->dd->params->rsm_map_table_entries) {
+		ppd_dev_err(ppd, "Not enough RMT entries, used = %d\n",
+			    rmt->used);
+		return -ENOSPC;
+	}
+	ppd->netdev_rx->rmt_start = rmt->used;
+	rmt->used += NUM_NETDEV_MAP_ENTRIES;
+	return 0;
+}
+
+static void hfi2_netdev_update_rmt(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int i, j;
+	int ctx_id = 0;
+	u8 left_shift;
+	u64 reg;
+	u32 regoff;
+	int rmt_start = hfi2_netdev_get_free_rmt_idx(ppd);
+	int ctxt_count = hfi2_netdev_ctxt_count(ppd);
+	u32 entries_per_csr = ppd->dd->params->rsm_map_table_entries_per_csr;
+	u32 entry_mask = ppd->dd->params->rsm_map_table_entry_mask;
+	u32 entry_shift = ppd->dd->params->rsm_map_table_entry_shift;
+	u32 ctxt;
+
+	dev_dbg(&(dd)->pcidev->dev, "RMT start = %d, end %d\n",
+		rmt_start,
+		rmt_start + NUM_NETDEV_MAP_ENTRIES);
+
+	/* Update RSM mapping table */
+	regoff = dd->params->rcv_rsm_map_table_reg + ((rmt_start / entries_per_csr) * 8);
+	reg = read_csr(dd, regoff);
+	for (i = 0; i < NUM_NETDEV_MAP_ENTRIES; i++) {
+		/* Update map register with netdev context */
+		j = (rmt_start + i) % entries_per_csr;
+		left_shift = j * entry_shift;
+		ctxt = hfi2_netdev_get_ctxt(ppd, ctx_id++)->ctxt;
+		reg &= ~((u64)entry_mask << left_shift);
+		reg |= ((u64)(ctxt & entry_mask) << left_shift);
+		/* Wrap up netdev ctx index */
+		ctx_id %= ctxt_count;
+
+		/* Write back map register */
+		if ((j == entries_per_csr - 1) || ((i + 1) == NUM_NETDEV_MAP_ENTRIES)) {
+			dev_dbg(&(dd)->pcidev->dev,
+				"RMT[%d] = 0x%llx\n",
+				(regoff - dd->params->rcv_rsm_map_table_reg) /
+					entries_per_csr,
+				reg);
+
+			write_csr(dd, regoff, reg);
+			if (i < (NUM_NETDEV_MAP_ENTRIES - 1)) {
+				regoff += 8;
+				reg = read_csr(dd, regoff);
+			}
+		}
+	}
+}
+
+static void hfi2_enable_rsm_rule(struct hfi2_pportdata *ppd,
+				 int type, struct rsm_rule_data *rrd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int rule_index;
+
+	if (dd->is_vf) {
+		ppd_dev_err(ppd, "VFs can't yet setup RSM rules\n");
+		return;
+	}
+	/* lock is for setting netdev_rsm_rule */
+	mutex_lock(&hfi2_mutex);
+	if (ppd->netdev_rsm_rule >= 0) {
+		ppd_dev_info(ppd, "Netdev contexts are already mapped in RMT\n");
+		goto done;
+	}
+
+	rule_index = alloc_rsm_rule(dd, type);
+	if (rule_index < 0)
+		goto done;
+
+	hfi2_netdev_update_rmt(ppd);
+
+	ppd->netdev_rsm_rule = rule_index;
+	add_rsm_rule(dd, rule_index, rrd);
+	add_rcvctrl(ppd, RCV_CTRL_RCV_RSM_ENABLE_SMASK);
+
+done:
+	mutex_unlock(&hfi2_mutex);
+}
+
+void hfi2_init_aip_rsm(struct hfi2_pportdata *ppd)
+{
+	/*
+	 * go through with the initialisation only if this rule actually doesn't
+	 * exist yet
+	 */
+	if (atomic_fetch_inc(&ppd->ipoib_rsm_usr_num) == 0) {
+		int rmt_start = hfi2_netdev_get_free_rmt_idx(ppd);
+		struct rsm_rule_data rrd = {
+			.offset = rmt_start,
+			.pkt_type = RHF_RCV_TYPE_IB,
+			.pidx_mask = 1 << ppd->hw_pidx,
+			.field1_off = LRH_BTH_MATCH_OFFSET,
+			.mask1 = LRH_BTH_MASK,
+			.value1 = LRH_BTH_VALUE,
+			.field2_off = BTH_DESTQP_MATCH_OFFSET,
+			.mask2 = BTH_DESTQP_MASK,
+			.value2 = BTH_DESTQP_VALUE,
+			.index1_off = DETH_AIP_SQPN_SELECT_OFFSET +
+					ilog2(NUM_NETDEV_MAP_ENTRIES),
+			.index1_width = ilog2(NUM_NETDEV_MAP_ENTRIES),
+			.index2_off = DETH_AIP_SQPN_SELECT_OFFSET,
+			.index2_width = ilog2(NUM_NETDEV_MAP_ENTRIES)
+		};
+
+		hfi2_enable_rsm_rule(ppd, RSM_TYPE_AIP, &rrd);
+	}
+}
+
+void hfi2_deinit_aip_rsm(struct hfi2_pportdata *ppd)
+{
+	/* only actually clear the rule if it's the last user asking to do so */
+	if (atomic_fetch_add_unless(&ppd->ipoib_rsm_usr_num, -1, 0) == 1) {
+		mutex_lock(&hfi2_mutex);
+		clear_rsm_rule(ppd->dd, ppd->netdev_rsm_rule);
+		ppd->netdev_rsm_rule = -1;
+		mutex_unlock(&hfi2_mutex);
+	}
+}
+
+/*
+ * RSM match rules for ports.
+ *
+ * RSM match bits are numbered little-endian by QWORD.  Take this into account
+ * when deciding bit offsets.
+ */
+static const struct rsm_rule_data mad_response_rules[] = {
+	/* 9B Response MAD packets */
+	{
+		.offset = 0,		/* filled in */
+		.pidx_mask = 0,		/* filled in */
+		.pkt_type = RHF_RCV_TYPE_IB,
+		.field1_off = 60,	/* LRH.VL offset */
+		.mask1 = 0x0f,		/*   4 bits */
+		.value1 = 0x0f,		/*  match LRH.VL=15 */
+		.field2_off = 199,	/* MAD.R offset */
+		.mask2 = 0x01,		/*   1 bit */
+		.value2 = 0x01,		/*   match MAD.R=1 */
+		.index1_off = 0,	/* do not index off of offset */
+		.index1_width = 0,
+		.index2_off = 0,
+		.index2_width = 0,
+	},
+	/* 9B TRAP MAD packets */
+	{
+		.offset = 0,		/* filled in */
+		.pidx_mask = 0,		/* filled in */
+		.pkt_type = RHF_RCV_TYPE_IB,
+		.field1_off = 60,	/* LRH.VL offset */
+		.mask1 = 0x0f,		/*   4 bits */
+		.value1 = 0x0f,		/*   match LRH.VL=15 */
+		.field2_off = 192,	/* MAD.Method offset */
+		.mask2 = 0x7f,		/*   7 bits */
+		.value2 = 0x05,		/*   match MAD.Method=TRAP */
+		.index1_off = 0,	/* do not index off of offset */
+		.index1_width = 0,
+		.index2_off = 0,
+		.index2_width = 0,
+	},
+};
+
+/*
+ * 16B (bypass) Packets (STL Mgmt L4 Header version, aka L4_FM)
+ * --------------------
+ * A 16B L4_FM type MAD packet starts with headers
+ *     16B LRH (16 bytes)
+ *     Mgmt L4 (8 bytes)
+ *     MAD
+ *
+ * Match vl15 in 16B.SC (5 bits)
+ * 16B.SC is bits 56:52 in the first QWORD.
+ *     offset = 52		bit offset
+ *     mask   = 0x1f		bits to check
+ *     value  = 0x0f		value to compare
+ *
+ * Match MAD.R (1 bit)
+ * MAD.R is the 4th byte on the wire of the MAD header, bit 7.
+ *     Preceding headers:      24 bytes  = 192 bits
+ *     Preceding bytes of MAD:  3 bytes  =  24 bits
+ *     Bit 7:                            =   7 bits
+ *     Total: 192 + 24 + 7 = 223
+ *
+ *     offset = 223		bit offset
+ *     mask   = 0x01		bits to check
+ *     value  = 0x00		value to compare
+ */
+static const struct rsm_rule_data mad_action_rules[] = {
+	{
+		.offset = 0,		/* filled in */
+		.pidx_mask = 0,		/* filled in */
+		.pkt_type = RHF_RCV_TYPE_BYPASS,
+		.field1_off = 52,	/* 16B.SC offset */
+		.mask1 = 0x1f,		/*   5 bits */
+		.value1 = 0x0f,		/*   match 16B.SC=15 */
+		.field2_off = 223,	/* MAD.R offset */
+		.mask2 = 0x01,		/*   1 bit */
+		.value2 = 0x00,		/*   match MAD.R=0 */
+		.index1_off = 0,	/* do not index off of offset */
+		.index1_width = 0,
+		.index2_off = 0,
+		.index2_width = 0,
+	},
+};
+
+/*
+ * Set up a rule for all entries in mmr_tbl to go to the target context.
+ */
+static int do_port_mapping(struct hfi2_pportdata *ppd,
+			   struct rsm_map_table *rmt,
+			   const struct rsm_rule_data *rrd_tbl,
+			   int rrd_len,
+			   int target_ctxt,
+			   int rule_type)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct rsm_rule_data rrd;
+	int rmt_index;
+	int rule_index;
+	int row;
+
+	/* check for room in RMT - need 1 entry */
+	if (rmt->used >= dd->params->rsm_map_table_entries) {
+		ppd_dev_err(ppd, "%s: out of RMT entries\n", __func__);
+		return -ENOSPC;
+	}
+	/* allocate the RMT index */
+	rmt_index = rmt->used++;
+
+	/* update the RSM Map Table entry with the target context */
+	set_rmt_entry(dd, rmt, rmt_index, target_ctxt);
+
+	/* assign the rules */
+	for (row = 0; row < rrd_len; row++) {
+		/* copy to a writable structure */
+		rrd = rrd_tbl[row];
+
+		/* fill in variable fields */
+		rrd.offset = rmt_index;		   /* lookup dest here... */
+		rrd.pidx_mask = 1 << ppd->hw_pidx; /* ...on this port */
+
+		/* allocate a rule index */
+		rule_index = alloc_rsm_rule(dd, rule_type);
+		if (rule_index < 0)
+			return rule_index; /* this is a -ERRNO */
+
+		/* set the rule registers */
+		add_rsm_rule(dd, rule_index, &rrd);
+	}
+
+	return 0;
+}
+
+/*
+ * Add port-specific mappings to the RSM Map Table.
+ */
+static int init_port_mapping(struct hfi2_pportdata *ppd,
+			     struct rsm_map_table *rmt)
+{
+	struct hfi2_portrsrcs *pr = &ppd->dd->rsrcs.ppr[ppd->hw_pidx];
+	int ret;
+
+	/* no port mapping for WFR */
+	if (ppd->dd->params->chip_type == CHIP_WFR)
+		return 0;
+
+	/*
+	 * Redirect MAD responses and traps to the driver. Use this port's
+	 * receive control context.
+	 */
+	ret = do_port_mapping(ppd, rmt, mad_response_rules,
+			      ARRAY_SIZE(mad_response_rules),
+			      pr->rcv_context_base + HFI2_CTRL_CTXT,
+			      RSM_TYPE_MAD_RSP);
+	if (ret)
+		return ret;
+
+	/*
+	 * Redirect MAD actions to the cport.  Cport owns the same receive
+	 * context as the port index.
+	 */
+	ret = do_port_mapping(ppd, rmt, mad_action_rules,
+			      ARRAY_SIZE(mad_action_rules),
+			      ppd->hw_pidx,
+			      RSM_TYPE_MAD_ACTION);
+	return ret;
+}
+
+/*
+ * This might be called on behalf of a VF to setup RSM rules and any
+ * associated RMT entries. This means it is no longer called only once
+ * at driver load.
+ *
+ * 'dr' is NULL when called for PF0 init.
+ */
+int init_rxe_rsm(struct hfi2_devdata *dd, struct hfi2_devrsrcs *dr)
+{
+	struct rsm_map_table *rmt;
+	int i;
+	int ret;
+
+	if (dr) {
+		/* working on behalf of VF */
+		struct hfi2_pportdata *ppd;
+		u16 rc0, rcn;
+
+		for (i = 0; i < dd->num_pports; ++i) {
+			ppd = &dd->pport[i];
+			if (ppd->qos_shift != 1) {
+				ppd_dev_err(ppd, "QOS not supported for SRIOV\n");
+				return -EINVAL;
+			}
+			/* map our QPNs to port's kernel contexts (excl. HFI2_CTRL_CTXT) */
+			rc0 = dr->ppr[i].rcv_context_base + FIRST_KERNEL_KCTXT;
+			rcn = rc0 + dr->ppr[i].n_krcv_queues - FIRST_KERNEL_KCTXT - 1;
+			init_qpmap_table_range(ppd,
+					       dr->c.first_rcv_context, /* our QPN range */
+					       dr->c.last_rcv_context,
+					       rc0, rcn);
+		}
+		dd_dev_warn(dd, "SRIOV: additional RSM/RMT setup for SI %d\n",
+			    dr->si_idx);
+		return 0;
+	}
+	/*
+	 * CSRs and determine rmt->used. After chip reset, CSRs are all
+	 * zero (a valid ctxt number) but we use 0xff to mark unused
+	 * entries after first pass (complete_rsm_map_table()).
+	 */
+	rmt = alloc_rsm_map_table(dd);
+	if (!rmt)
+		return -ENOMEM;
+
+	/*
+	 * need to be done differently. For example, MAD responses
+	 * will probably require an array of target contexts indexed
+	 * by something like QPN.
+	 */
+
+	/* set up QOS, including the QPN map table */
+	init_qos(dd, rmt);
+	for (i = 0; i < dd->num_pports; i++) {
+		ret = init_port_mapping(dd->pport + i, rmt);
+		if (ret)
+			goto done;
+		init_fecn_handling(dd->pport + i, rmt);
+	}
+	complete_rsm_map_table(dd, rmt);
+	/* reserve RMT entries for netdev */
+	for (i = 0; i < dd->num_pports; i++) {
+		ret = hfi2_netdev_set_free_rmt_idx(&dd->pport[i], rmt);
+		if (ret < 0)
+			goto done;
+	}
+	ret = 0;
+done:
+	kfree(rmt);
+	return ret;
+}
+
+/*
+ * Adjust RcvIportCtrl.RcvWcb, the write coalescing boundary for RX_DMA.
+ *
+ * Use the module parameter as a starting point.  Tune this setting to the
+ * largest size <= PCIe Max Payload Size (MPS).  It is invalid to have
+ * RcvWcb > MPS.
+ *
+ * It is expected that PCIe MPS is not adjusted after this function is called,
+ * both internally and externally.
+ */
+static void adjust_wcb(struct hfi2_devdata *dd)
+{
+	int mps = pcie_get_mps(dd->pcidev);
+	int local_wcb = rcvwcb;
+	int top;
+	int def;
+	int pidx;
+
+	/* WFR has a different default and range */
+	if (dd->params->chip_type == CHIP_WFR) {
+		def = 0;
+		top = 2;
+	} else {
+		def = 3;
+		top = 3;
+	}
+
+	/* force this instance of rcvwcb in the range 0..top, inclusive */
+	if (local_wcb < 0 || local_wcb > top)
+		local_wcb = def;
+	/* reduce local_wcb until it is <= MPS */
+	while (local_wcb != 0) {
+		int sz = 64 << local_wcb; /* convert to a size */
+
+		if (sz <= mps)
+			break;
+		local_wcb--;
+	}
+
+	/* wcb is required to be the same on all ports */
+	for (pidx = 0; pidx < dd->num_pports; pidx++)
+		set_wcb(&dd->pport[pidx], local_wcb);
+}
+
+static int init_rxe(struct hfi2_devdata *dd)
+{
+	u64 val;
+	int i;
+	int ret;
+
+	if (dd->is_vf) {
+		for (i = 0; i < dd->num_pports; i++)
+			dd->pport[i].qos_shift = 1; /* otherwise won't happen */
+		return vf2pf_init_rxe_rsm(dd);
+	}
+
+	/* enable all receive errors */
+	for (i = 0; i < dd->num_pports; i++) {
+		write_iport_csr(dd, i, dd->params->rcv_err_mask_reg, ~0ull);
+		if (dd->is_sriov)
+			write_iport_csr(dd, loopback_pidx_dd(dd, i),
+					dd->params->rcv_err_mask_reg, ~0ull);
+	}
+
+	ret = init_rxe_rsm(dd, NULL);
+	if (ret)
+		goto done;
+
+	/* set the DMA receive coalesce size */
+	adjust_wcb(dd);
+
+	for (i = 0; i < dd->num_pports; i++) {
+		struct hfi2_portrsrcs *pr = &dd->rsrcs.ppr[i];
+
+		u64 control = pr->rcv_context_base + HFI2_CTRL_CTXT;
+
+		/* set 16 bytes (4 DW) header available in header queue */
+		/* set bypass context to the port control context */
+		val = (4ull << RCV_BYPASS_HDR_SIZE_SHIFT) | control;
+		write_iport_csr(dd, i, dd->params->rcv_bypass_reg, val);
+
+		write_iport_csr(dd, i, dd->params->rcv_multicast_reg, control);
+		if (dd->is_sriov) {
+			write_iport_csr(dd, loopback_pidx_dd(dd, i),
+					dd->params->rcv_bypass_reg, val);
+			write_iport_csr(dd, loopback_pidx_dd(dd, i),
+					dd->params->rcv_multicast_reg, control);
+		}
+	}
+	ret = 0;
+
+done:
+	return ret;
+}
+
+void init_other(struct hfi2_devdata *dd)
+{
+	/* enable all CCE errors */
+	write_csr(dd, CCE_ERR_MASK, ~0ull);
+	/* enable *some* Misc errors */
+	write_csr(dd, MISC_ERR_MASK, DRIVER_MISC_MASK);
+	/* enable all DC errors, except LCB */
+	write_csr(dd, DCC_ERR_FLG_EN, ~0ull);
+	write_csr(dd, DC_DC8051_ERR_EN, ~0ull);
+}
+
+/*
+ * Fill out the given AU table using the given CU.  A CU is defined in terms
+ * AUs.  The table is a an encoding: given the index, how many AUs does that
+ * represent?
+ *
+ * NOTE: Assumes that the register layout is the same for the
+ * local and remote tables.
+ */
+static void assign_cm_au_table(struct hfi2_pportdata *ppd, u32 cu,
+			       u32 csr0to3, u32 csr4to7)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int pidx = ppd->hw_pidx;
+
+	if (dd->params->chip_type != CHIP_WFR)
+		return;
+
+	write_eport_csr(dd, pidx, csr0to3,
+			0ull << SEND_CM_LOCAL_AU_TABLE0_TO3_LOCAL_AU_TABLE0_SHIFT |
+			1ull << SEND_CM_LOCAL_AU_TABLE0_TO3_LOCAL_AU_TABLE1_SHIFT |
+			2ull * cu << SEND_CM_LOCAL_AU_TABLE0_TO3_LOCAL_AU_TABLE2_SHIFT |
+			4ull * cu << SEND_CM_LOCAL_AU_TABLE0_TO3_LOCAL_AU_TABLE3_SHIFT);
+	write_eport_csr(dd, pidx, csr4to7,
+			8ull * cu << SEND_CM_LOCAL_AU_TABLE4_TO7_LOCAL_AU_TABLE4_SHIFT |
+			16ull * cu << SEND_CM_LOCAL_AU_TABLE4_TO7_LOCAL_AU_TABLE5_SHIFT |
+			32ull * cu << SEND_CM_LOCAL_AU_TABLE4_TO7_LOCAL_AU_TABLE6_SHIFT |
+			64ull * cu << SEND_CM_LOCAL_AU_TABLE4_TO7_LOCAL_AU_TABLE7_SHIFT);
+}
+
+static void assign_local_cm_au_table(struct hfi2_pportdata *ppd, u8 vcu)
+{
+	assign_cm_au_table(ppd, vcu_to_cu(vcu), ppd->dd->params->send_cm_local_au_table0_to3_reg,
+			   ppd->dd->params->send_cm_local_au_table4_to7_reg);
+}
+
+void assign_remote_cm_au_table(struct hfi2_pportdata *ppd, u8 vcu)
+{
+	assign_cm_au_table(ppd, vcu_to_cu(vcu), ppd->dd->params->send_cm_remote_au_table0_to3_reg,
+			   ppd->dd->params->send_cm_remote_au_table4_to7_reg);
+}
+
+static void init_txe(struct hfi2_devdata *dd)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	int i;
+
+	/* enable all PIO, SDMA, general, and Egress errors */
+	write_csr(dd, dd->params->send_pio_err_mask_reg, ~0ull);
+	write_csr(dd, dd->params->send_dma_err_mask_reg, ~0ull);
+	write_csr(dd, dd->params->csr_err_mask_reg, ~0ull);
+	if (!dd->is_vf)
+		for (i = 0; i < dd->num_pports; i++) {
+			write_eport_csr(dd, i, dd->params->send_egress_err_mask_reg,
+					~0ull);
+			if (dd->is_sriov)
+				write_eport_csr(dd, loopback_pidx_dd(dd, i),
+						dd->params->send_egress_err_mask_reg,
+						~0ull);
+		}
+
+	/* enable all per-context and per-SDMA engine errors */
+	for (i = dr->c.first_send_context; i < dr->c.last_send_context; i++)
+		write_sctxt_csr(dd, i, dd->params->send_ctxt_err_mask_reg, ~0ull);
+	for (i = dr->first_sdma_engine; i < dr->last_sdma_engine; i++)
+		write_sdma_csr(dd, i, dd->params->send_dma_eng_err_mask_reg, ~0ull);
+
+	if (dd->params->chip_type == CHIP_WFR) {
+		/* set the local CU to AU mapping */
+		for (i = 0; i < dd->num_pports; i++)
+			assign_local_cm_au_table(dd->pport + i, dd->vcu);
+
+		/*
+		 * Set reasonable default for Credit Return Timer
+		 */
+		for (i = 0; i < dd->num_pports; i++) {
+			write_eport_csr(dd, i,
+					dd->params->send_cm_timer_ctrl_reg,
+					HFI2_CREDIT_RETURN_RATE);
+		}
+	}
+}
+
+int hfi2_set_ctxt_jkey(struct hfi2_devdata *dd, struct hfi2_ctxtdata *rcd,
+		       u16 jkey)
+{
+	int pidx;
+	u16 hw_ctxt;
+	u64 reg;
+
+	if (!rcd || !rcd->sc)
+		return -EINVAL;
+
+	pidx = rcd->ppd->hw_pidx;
+	hw_ctxt = rcd->sc->hw_context;
+	reg = SEND_CTXT_CHECK_JOB_KEY_MASK_SMASK | /* mask is always 1's */
+		((jkey & SEND_CTXT_CHECK_JOB_KEY_VALUE_MASK) <<
+		 SEND_CTXT_CHECK_JOB_KEY_VALUE_SHIFT);
+	/* JOB_KEY_ALLOW_PERMISSIVE is not allowed by default */
+	if (HFI2_CAP_KGET_MASK(rcd->flags, ALLOW_PERM_JKEY))
+		reg |= SEND_CTXT_CHECK_JOB_KEY_ALLOW_PERMISSIVE_SMASK;
+	priv_reg_op(dd, pidx, hw_ctxt | (rcd->ctxt << 16), rcd->sc->type,
+		    SC_CHK_JKEY_OP, reg);
+
+	return 0;
+}
+
+int hfi2_clear_ctxt_jkey(struct hfi2_devdata *dd, struct hfi2_ctxtdata *rcd)
+{
+	int pidx;
+	u16 hw_ctxt;
+
+	if (!rcd || !rcd->sc)
+		return -EINVAL;
+
+	pidx = rcd->ppd->hw_pidx;
+	hw_ctxt = rcd->sc->hw_context;
+	priv_reg_op(dd, pidx, hw_ctxt | (rcd->ctxt << 16), rcd->sc->type,
+		    SC_CHK_JKEY_OP, 0);
+
+	return 0;
+}
+
+int hfi2_set_ctxt_pkey(struct hfi2_devdata *dd, struct hfi2_ctxtdata *rcd,
+		       u16 pkey)
+{
+	int pidx;
+	u16 hw_ctxt;
+	u64 reg;
+
+	if (!rcd || !rcd->sc)
+		return -EINVAL;
+
+	pidx = rcd->ppd->hw_pidx;
+	hw_ctxt = rcd->sc->hw_context;
+	reg = ((u64)pkey & SEND_CTXT_CHECK_PARTITION_KEY_VALUE_MASK) <<
+		SEND_CTXT_CHECK_PARTITION_KEY_VALUE_SHIFT;
+	priv_reg_op(dd, pidx, hw_ctxt, rcd->sc->type, SC_CHK_PKEY_OP, reg);
+
+	return 0;
+}
+
+int hfi2_clear_ctxt_pkey(struct hfi2_devdata *dd, struct hfi2_ctxtdata *ctxt)
+{
+	int pidx;
+	u16 hw_ctxt;
+
+	if (!ctxt || !ctxt->sc)
+		return -EINVAL;
+
+	pidx = ctxt->ppd->hw_pidx;
+	hw_ctxt = ctxt->sc->hw_context;
+	priv_reg_op(dd, pidx, hw_ctxt, ctxt->sc->type, SC_CHK_PKEY_OP, 0);
+
+	return 0;
+}
+
+/*
+ * Start doing the clean up the chip. Our clean up happens in multiple
+ * stages and this is just the first.
+ */
+void hfi2_start_cleanup(struct hfi2_devdata *dd)
+{
+	aspm_exit(dd);
+	free_cntrs(dd);
+	finish_chip_resources(dd);
+}
+
+#define HFI_BASE_GUID(dev) \
+	((dev)->base_guid & ~(1ULL << GUID_HFI_INDEX_SHIFT))
+
+/*
+ * Information can be shared between the two HFIs on the same ASIC
+ * in the same OS.  This function finds the peer device and sets
+ * up a shared structure.
+ */
+static int init_asic_data(struct hfi2_devdata *dd)
+{
+	unsigned long index;
+	struct hfi2_devdata *peer;
+	struct hfi2_asic_data *asic_data;
+	int ret = 0;
+
+	/* pre-allocate the asic structure in case we are the first device */
+	asic_data = kzalloc_obj(dd->asic_data, GFP_KERNEL);
+	if (!asic_data)
+		return -ENOMEM;
+
+	xa_lock_irq(&hfi2_dev_table);
+	/* Find our peer device */
+	xa_for_each(&hfi2_dev_table, index, peer) {
+		if ((HFI_BASE_GUID(dd) == HFI_BASE_GUID(peer)) &&
+		    dd->unit != peer->unit)
+			break;
+	}
+
+	if (peer) {
+		/* use already allocated structure */
+		dd->asic_data = peer->asic_data;
+		kfree(asic_data);
+	} else {
+		dd->asic_data = asic_data;
+		mutex_init(&dd->asic_data->asic_resource_mutex);
+	}
+	dd->asic_data->dds[dd->hfi2_id] = dd; /* self back-pointer */
+	xa_unlock_irq(&hfi2_dev_table);
+
+	/* first one through - set up i2c devices */
+	if (!peer)
+		ret = set_up_i2c(dd, dd->asic_data);
+
+	return ret;
+}
+
+/*
+ * Set dd->boardname.  Use a generic name if a name is not returned from
+ * EFI variable space.
+ *
+ * Return 0 on success, -ENOMEM if space could not be allocated.
+ */
+static int obtain_boardname(struct hfi2_devdata *dd)
+{
+	unsigned long size;
+	int ret;
+
+	ret = read_hfi2_efi_var(dd, "description", &size,
+				(void **)&dd->boardname);
+	if (ret) {
+		dd_dev_info(dd, "Board description not found\n");
+		/* use generic description */
+		dd->boardname = kstrdup(dd->params->generic_boardname,
+					GFP_KERNEL);
+		if (!dd->boardname)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+/*
+ * Check the interrupt registers to make sure that they are mapped correctly.
+ * It is intended to help user identify any mismapping by VMM when the driver
+ * is running in a VM. This function should only be called before interrupt
+ * is set up properly.
+ *
+ * Return 0 on success, -EINVAL on failure.
+ */
+static int check_int_registers(struct hfi2_devdata *dd)
+{
+	u64 reg;
+	u64 all_bits = ~(u64)0;
+	u64 mask;
+	u32 cce_int_mask_reg = dd->params->cce_int_mask_reg;
+	u32 cce_int_clear_reg = dd->params->cce_int_clear_reg;
+	u32 cce_int_status_reg = dd->params->cce_int_status_reg;
+
+	/* Clear CceIntMask[0] to avoid raising any interrupts */
+	mask = read_csr(dd, cce_int_mask_reg);
+	write_csr(dd, cce_int_mask_reg, 0ull);
+	reg = read_csr(dd, cce_int_mask_reg);
+	if (reg)
+		goto err_exit;
+
+	/* Clear all interrupt status bits */
+	write_csr(dd, cce_int_clear_reg, all_bits);
+	reg = read_csr(dd, cce_int_status_reg);
+	if (reg)
+		goto err_exit;
+
+	/* Set all interrupt status bits */
+	write_csr(dd, dd->params->cce_int_force_reg, all_bits);
+	reg = read_csr(dd, cce_int_status_reg);
+	if (reg != all_bits)
+		goto err_exit;
+
+	/* Restore the interrupt mask */
+	write_csr(dd, cce_int_clear_reg, all_bits);
+	write_csr(dd, cce_int_mask_reg, mask);
+
+	return 0;
+err_exit:
+	write_csr(dd, cce_int_mask_reg, mask);
+	dd_dev_err(dd, "Interrupt registers not properly mapped by VMM\n");
+	return -EINVAL;
+}
+
+int wfr_find_used_resources(struct hfi2_devdata *dd)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+
+	/* set resource allocation start values */
+	dr->pfunit = dd->unit;
+	dr->c.first_rcvarray_entry = 0;
+	dr->c.last_rcvarray_entry = chip_rcv_array_count(dd);
+	dr->c.first_pio_block = 1; /* do not use block 0, HAS entry 291585 */
+	dr->c.last_pio_block = chip_pio_mem_size(dd) / PIO_BLOCK_SIZE;
+	dr->c.first_rcv_context = 0;
+	dr->c.last_rcv_context = chip_rcv_contexts(dd);
+	dr->c.first_send_context = 0;
+	dr->c.last_send_context = chip_send_contexts(dd);
+	dd->rsm_rule_init = true;
+
+	return 0;
+}
+
+/* early WFR specific chip init */
+int wfr_early_per_chip_init(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	/* set up shared ASIC data with peer device */
+	ret = init_asic_data(dd);
+	if (ret)
+		return ret;
+
+	/* obtain chip sizes, reset chip CSRs */
+	ret = init_chip(dd);
+	if (ret)
+		return ret;
+
+	/* read in the PCIe link speed information */
+	ret = pcie_speeds(dd);
+	if (ret)
+		return ret;
+
+	/* call before get_platform_config(), after init_chip_resources() */
+	ret = eprom_init(dd);
+	if (ret)
+		return ret;
+
+	/* Needs to be called before hfi2_firmware_init */
+	get_platform_config(&dd->pport[HFI2_PORT_IDX]);
+
+	/* read in firmware */
+	ret = hfi2_firmware_init(dd);
+	if (ret)
+		return ret;
+
+	/*
+	 * In general, the PCIe Gen3 transition must occur after the
+	 * chip has been idled (so it won't initiate any PCIe transactions
+	 * e.g. an interrupt) and before the driver changes any registers
+	 * (the transition will reset the registers).
+	 *
+	 * In particular, place this call after:
+	 * - init_chip()     - the chip will not initiate any PCIe transactions
+	 * - pcie_speeds()   - reads the current link speed
+	 * - hfi2_firmware_init() - the needed firmware is ready to be
+	 *			    downloaded
+	 */
+	ret = do_pcie_gen3_transition(dd);
+	if (ret)
+		return ret;
+
+	/*
+	 * This should probably occur in hfi2_pcie_init(), but historically
+	 * occurs after the do_pcie_gen3_transition() code.
+	 */
+	tune_pcie_caps(dd);
+
+	/* start setting dd values and adjusting CSRs */
+	init_early_variables(dd);
+
+	write_uninitialized_csrs_and_memories(dd);
+
+	parse_platform_config(&dd->pport[HFI2_PORT_IDX]);
+
+	return 0;
+}
+
+int wfr_mid_per_chip_init(struct hfi2_devdata *dd)
+{
+	return 0;
+}
+
+int wfr_late_per_chip_init(struct hfi2_devdata *dd)
+{
+	/* set up LCB access - must be after set_up_interrupts() */
+	init_lcb_access(dd);
+
+	return load_firmware(dd); /* asymmetric with dispose_firmware() */
+}
+
+/**
+ * hfi2_init_dd() - Initialize most of the dd structure.
+ * @dd: the dd device
+ *
+ * This is global, and is called directly at init to set up the
+ * chip-specific function pointers for later use.
+ */
+int hfi2_init_dd(struct hfi2_devdata *dd)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	struct pci_dev *pdev = dd->pcidev;
+	struct hfi2_pportdata *ppd;
+	u64 reg;
+	int i, ret;
+	static const char * const inames[] = { /* implementation names */
+		"RTL silicon",
+		"RTL VCS simulation",
+		"RTL FPGA emulation",
+		"Functional simulator"
+	};
+	struct pci_dev *parent = pdev->bus->self;
+
+	/*
+	 * Do remaining PCIe setup.  Error messaging is done by the callee.
+	 * On return, the BAR is mapped and register access is enabled.
+	 */
+	ret = hfi2_pcie_ddinit(dd, pdev);
+	if (ret < 0)
+		goto bail;
+
+	/* do this at earliest opportunity - CSRs accessible */
+	dd->rctxt_mask = (1 << fls(chip_rcv_contexts(dd))) - 1;
+	dd->sctxt_mask = (1 << fls(chip_send_contexts(dd))) - 1;
+
+	ret = vf2pf_early_init(dd);
+	if (ret)
+		goto bail_cleanup;
+	/*
+	 * Only VFs can/must init VF2PF this early.
+	 * The PF must wait until CPORT f/w has reset all
+	 * resources in start_cport().
+	 */
+	if (dd->is_vf) {
+		/* This must also set the SI */
+		ret = vf2pf_init(dd);
+		if (ret)
+			goto bail_cleanup;
+	}
+
+	/*
+	 * must be done before dd->params->find_used_resources()
+	 * but after hfi2_pcie_ddinit() (BARs enabled).
+	 * After this call, dd->rsrcs should have basic data needed
+	 * to initialize the driver resources.
+	 */
+	ret = hfi2_sriov_set_cfg(dd);
+	if (ret)
+		goto bail;
+
+	if (num_vls < HFI2_MIN_VLS_SUPPORTED ||
+	    num_vls > HFI2_MAX_VLS_SUPPORTED) {
+		dd_dev_err(dd, "Invalid num_vls %u, using %u VLs\n",
+			   num_vls, HFI2_MAX_VLS_SUPPORTED);
+		num_vls = HFI2_MAX_VLS_SUPPORTED;
+	}
+
+	/*
+	 * Decide on number of SDMA engines to use based on hardware
+	 * availability, number of VLs, and module parameter.
+	 */
+	if (HFI2_CAP_IS_KSET(SDMA)) {
+		u32 sdma_engines = chip_sdma_engines(dd);
+
+		/* insure num_vls isn't larger than number of sdma engines */
+		if (num_vls > sdma_engines) {
+			dd_dev_err(dd, "num_vls %u too large, using %u VLs\n",
+				   num_vls, sdma_engines);
+			num_vls = sdma_engines;
+		}
+
+		/*
+		 * should revisit whether this is supported at all.
+		 * It is not being factored into SRIOV SDMA assignment.
+		 */
+		if (mod_num_sdma &&
+		    /* can't exceed chip support */
+		    mod_num_sdma <= sdma_engines &&
+		    /* count must be >= vls */
+		    mod_num_sdma >= num_vls)
+			sdma_engines = mod_num_sdma;
+
+		dd->num_sdma = sdma_engines;
+		if (dr->num_vfs) {
+			int num_sde = dr->last_sdma_engine - dr->first_sdma_engine;
+
+			/* resources already setup by hfi2_sriov_set_cfg() */
+			if (num_vls > num_sde) {
+				dd_dev_err(dd, "SI%d: num_vls %u too large, using %u VLs\n",
+					   dr->si_idx, num_vls, num_sde);
+				num_vls = num_sde;
+			}
+		} else {
+			dr->first_sdma_engine = 0;
+			dr->last_sdma_engine = dd->num_sdma;
+		}
+	} else {
+		HFI2_CAP_CLEAR(SDMA_AHG);
+		dd->num_sdma = 0;
+	}
+
+	ppd = dd->pport;
+	for (i = 0; i < dd->num_pports; i++, ppd++) {
+		int vl;
+		/* init common fields */
+		hfi2_init_pportdata(pdev, ppd, dd, i, i + 1);
+		/* DC supports 4 link widths */
+		ppd->link_width_supported =
+			OPA_LINK_WIDTH_1X | OPA_LINK_WIDTH_2X |
+			OPA_LINK_WIDTH_3X | OPA_LINK_WIDTH_4X;
+		ppd->link_width_downgrade_supported =
+			ppd->link_width_supported;
+		/* start out enabling only 4X */
+		ppd->link_width_enabled = OPA_LINK_WIDTH_4X;
+		ppd->link_width_downgrade_enabled =
+					ppd->link_width_downgrade_supported;
+		/* link width active is 0 when link is down */
+		/* link width downgrade active is 0 when link is down */
+
+		ppd->vls_supported = num_vls;
+		ppd->vls_operational = ppd->vls_supported;
+		/* Set the default MTU. */
+		for (vl = 0; vl < num_vls; vl++)
+			ppd->vld[vl].mtu = hfi2_max_mtu;
+		ppd->vld[15].mtu = MAX_MAD_PACKET;
+
+		/*
+		 * Set the initial values to reasonable default, will be set
+		 * for real when link is up.
+		 */
+		ppd->overrun_threshold = 0x4;
+		ppd->phy_error_threshold = 0xf;
+		ppd->port_crc_mode_enabled = link_crc_mask;
+		/* initialize supported LTP CRC mode */
+		ppd->port_ltp_crc_mode = cap_to_port_ltp(link_crc_mask) << 8;
+		/* initialize enabled LTP CRC mode */
+		ppd->port_ltp_crc_mode |= cap_to_port_ltp(link_crc_mask) << 4;
+		/* start in offline */
+		ppd->host_link_state = HLS_DN_OFFLINE;
+		init_vl_arb_caches(ppd);
+
+		/* speeds the hardware can support */
+		ppd->link_speed_supported = dd->params->link_speed_supported;
+		/* speeds allowed to run at */
+		ppd->link_speed_enabled = ppd->link_speed_supported;
+		/* give a reasonable active value, will be set on link up */
+		ppd->link_speed_active = dd->params->link_speed_active;
+	}
+
+	/* Save PCI space registers to rewrite after device reset */
+	ret = save_pci_variables(dd);
+	if (ret < 0)
+		goto bail_cleanup;
+
+	dd->majrev = (dd->revision >> CCE_REVISION_CHIP_REV_MAJOR_SHIFT)
+			& CCE_REVISION_CHIP_REV_MAJOR_MASK;
+	dd->minrev = (dd->revision >> CCE_REVISION_CHIP_REV_MINOR_SHIFT)
+			& CCE_REVISION_CHIP_REV_MINOR_MASK;
+
+	/*
+	 * Check interrupt registers mapping if the driver has no access to
+	 * the upstream component. In this case, it is likely that the driver
+	 * is running in a VM.
+	 */
+	if (!parent) {
+		ret = check_int_registers(dd);
+		if (ret)
+			goto bail_cleanup;
+	}
+
+	/*
+	 * Obtain the hardware ID - NOT related to unit, which is a
+	 * software enumeration. VFs can't access CSR directly and
+	 * already got this from PF0 via vf2pf_get_config().
+	 */
+	if (!dd->is_vf) {
+		reg = read_csr(dd, CCE_REVISION2);
+		dd->hfi2_id = (reg >> CCE_REVISION2_HFI_ID_SHIFT) &
+			      CCE_REVISION2_HFI_ID_MASK;
+		/* the variable size will remove unwanted bits */
+		dd->icode = reg >> CCE_REVISION2_IMPL_CODE_SHIFT;
+		dd->irev = reg >> CCE_REVISION2_IMPL_REVISION_SHIFT;
+	}
+	dd_dev_info(dd, "Implementation: %s, revision 0x%x\n",
+		    dd->icode < ARRAY_SIZE(inames) ?
+		    inames[dd->icode] : "unknown", (int)dd->irev);
+
+	/*
+	 * Convert the ns parameter to the 64 * cclocks used in the CSR.
+	 * Limit the max if larger than the field holds.  If timeout is
+	 * non-zero, then the calculated field will be at least 1.
+	 *
+	 * Must be after icode is set up - the cclock rate depends
+	 * on knowing the hardware being used.
+	 */
+	dd->rcv_intr_timeout_csr = ns_to_cclock(dd, rcv_intr_timeout) / 64;
+	if (dd->rcv_intr_timeout_csr >
+			RCV_AVAIL_TIME_OUT_TIME_OUT_RELOAD_MASK)
+		dd->rcv_intr_timeout_csr =
+			RCV_AVAIL_TIME_OUT_TIME_OUT_RELOAD_MASK;
+	else if (dd->rcv_intr_timeout_csr == 0 && rcv_intr_timeout)
+		dd->rcv_intr_timeout_csr = 1;
+
+	/* find resources already consumed */
+	ret = dd->params->find_used_resources(dd);
+	if (ret)
+		goto bail_cleanup;
+
+	ret = set_up_context_variables(dd);
+	if (ret)
+		goto bail_cleanup;
+
+	ret = dd->params->early_per_chip_init(dd);
+	if (ret)
+		goto bail_cleanup;
+
+	ret = set_up_interrupts(dd);
+	if (ret)
+		goto bail_cleanup;
+
+	/*
+	 * This does a STOP which will reset many things,
+	 * particularly the PF contexts needed for VF2PF.
+	 * The PF must not initialize VF2PF until after this.
+	 */
+	ret = start_cport(dd);
+	if (ret)
+		goto bail_clean_early_intr;
+	if (!dd->is_vf) {
+		/* The PF can safely init resources now */
+		ret = vf2pf_init(dd);
+		if (ret)
+			goto bail_clean_early_intr;
+		ret = vf2pf_init_irq(dd);
+		if (ret)
+			goto bail_clean_early_intr;
+	}
+
+	/* needs to be done before we look for the peer device */
+	dd->params->read_guid(dd);
+	dd_dev_info(dd, "GUID %llx",
+		    (unsigned long long)dd->base_guid);
+
+	ret = dd->params->mid_per_chip_init(dd);
+	if (ret)
+		goto bail_clean_early_intr;
+
+	ret = obtain_boardname(dd);
+	if (ret)
+		goto bail_clean_early_intr;
+
+	snprintf(dd->boardversion, BOARD_VERS_MAX,
+		 "ChipABI %u.%u, ChipRev %u.%u, SW Compat %llu\n",
+		 HFI2_CHIP_VERS_MAJ, HFI2_CHIP_VERS_MIN,
+		 (u32)dd->majrev,
+		 (u32)dd->minrev,
+		 (dd->revision >> CCE_REVISION_SW_SHIFT)
+		    & CCE_REVISION_SW_MASK);
+
+	/* alloc AIP rx data */
+	ret = hfi2_alloc_rx(dd);
+	if (ret)
+		goto bail_free_boardname;
+
+	/* set initial RXE CSRs */
+	ret = init_rxe(dd);
+	if (ret)
+		goto bail_free_rx;
+
+	/* set initial TXE CSRs */
+	init_txe(dd);
+	/* set initial non-RXE, non-TXE CSRs */
+	dd->params->init_other(dd);
+	/* set up KDETH QP prefix in both RX and TX CSRs */
+	init_kdeth_qp(dd);
+
+	ret = hfi2_dev_affinity_init(dd);
+	if (ret)
+		goto bail_free_rx;
+
+	/* send contexts must be set up before receive contexts */
+	ret = init_send_contexts(dd);
+	if (ret)
+		goto bail_free_rx;
+
+	ret = hfi2_create_kctxts(dd);
+	if (ret)
+		goto bail_free_rx;
+
+	/*
+	 * Initialize aspm, to be done after gen3 transition and setting up
+	 * contexts and before enabling interrupts
+	 */
+	aspm_init(dd);
+
+	/* per-vl send context and sdma init */
+	for (i = 0; i < dd->num_pports; ++i) {
+		ret = init_pervl_scs(dd->pport + i);
+		if (ret)
+			goto bail_free_rx;
+	}
+	ret = sdma_init(dd);
+	if (ret)
+		goto bail_free_rx;
+
+	/* use contexts created by hfi2_create_kctxts */
+	ret = late_set_up_interrupts(dd);
+	if (ret)
+		goto bail_free_rx;
+
+	ret = hfi2_comp_vectors_set_up(dd);
+	if (ret)
+		goto bail_clear_comp_vectors;
+
+	ret = dd->params->late_per_chip_init(dd);
+	if (ret)
+		goto bail_clear_comp_vectors;
+
+	/*
+	 * Serial number is created from the base guid:
+	 * [27:24] = base guid [38:35]
+	 * [23: 0] = base guid [23: 0]
+	 */
+	snprintf(dd->serial, SERIAL_MAX, "0x%08llx\n",
+		 (dd->base_guid & 0xFFFFFF) |
+		     ((dd->base_guid >> 11) & 0xF000000));
+
+	dd->oui1 = dd->base_guid >> 56 & 0xFF;
+	dd->oui2 = dd->base_guid >> 48 & 0xFF;
+	dd->oui3 = dd->base_guid >> 40 & 0xFF;
+
+	thermal_init(dd);
+
+	ret = init_cntrs(dd);
+	if (ret)
+		goto bail_clear_comp_vectors;
+
+	init_completion(&dd->user_comp);
+
+	/* The user refcount starts with one to inidicate an active device */
+	refcount_set(&dd->user_refcount, 1);
+
+	goto bail;
+
+bail_clear_comp_vectors:
+	hfi2_comp_vectors_clean_up(dd);
+bail_free_rx:
+	hfi2_sriov_free_rsrcs(dd, &dd->rsrcs);
+	hfi2_free_rx(dd);
+bail_free_boardname:
+	kfree(dd->boardname);
+	dd->boardname = NULL;
+bail_clean_early_intr:
+	msix_clean_up_interrupts(dd);
+bail_cleanup:
+	hfi2_pcie_ddcleanup(dd);
+bail:
+	return ret;
+}
+
+static u16 delay_cycles(struct hfi2_pportdata *ppd, u32 desired_egress_rate,
+			u32 dw_len)
+{
+	u32 delta_cycles;
+	u32 current_egress_rate = ppd->current_egress_rate;
+	/* rates here are in units of 10^6 bits/sec */
+
+	if (desired_egress_rate == -1)
+		return 0; /* shouldn't happen */
+
+	if (desired_egress_rate >= current_egress_rate)
+		return 0; /* we can't help go faster, only slower */
+
+	delta_cycles = egress_cycles(dw_len * 4, desired_egress_rate) -
+			egress_cycles(dw_len * 4, current_egress_rate);
+
+	return (u16)delta_cycles;
+}
+
+/**
+ * wfr_create_pbc - build a pbc for transmission
+ * @ppd: info of physical Hfi port
+ * @loopback: ignored for WFR
+ * @flags: special case flags or-ed in built pbc
+ * @srate_mbs: static rate
+ * @vl: vl
+ * @dw_len: dword length (header words + data words + pbc words)
+ * @l2: L2 header field - determines type
+ * @dlid: destination LID - unused
+ * @sctxt: send context number - unused
+ *
+ * Create a PBC with the given flags, rate, VL, and length.
+ *
+ * NOTE: The PBC created will not insert any HCRC - all callers but one are
+ * for verbs, which does not use this PSM feature.  The lone other caller
+ * is for the diagnostic interface which calls this if the user does not
+ * supply their own PBC.
+ */
+u64 wfr_create_pbc(struct hfi2_pportdata *ppd, bool loopback, u64 flags, int srate_mbs,
+		   u32 vl, u32 dw_len, u32 l2, u32 dlid, u32 sctxt)
+{
+	u64 pbc, delay = 0;
+
+	if (unlikely(srate_mbs))
+		delay = delay_cycles(ppd, srate_mbs, dw_len);
+
+	/* on WFR, non-9B are always bypass */
+	if (l2 != PBC_L2_9B)
+		flags |= PBC_PACKET_BYPASS | PBC_INSERT_BYPASS_ICRC;
+
+	pbc = flags
+		| (delay << PBC_STATIC_RATE_CONTROL_COUNT_SHIFT)
+		| ((u64)PBC_IHCRC_NONE << PBC_INSERT_HCRC_SHIFT)
+		| (vl & PBC_VL_MASK) << PBC_VL_SHIFT
+		| (dw_len & PBC_LENGTH_DWS_MASK)
+			<< PBC_LENGTH_DWS_SHIFT;
+
+	return pbc;
+}
+
+#define SBUS_THERMAL    0x4f
+#define SBUS_THERM_MONITOR_MODE 0x1
+
+#define THERM_FAILURE(dev, ret, reason) \
+	dd_dev_err((dev),						\
+		   "Thermal sensor initialization failed: %s (%d)\n",	\
+		   (reason), (ret))
+
+/*
+ * Initialize the thermal sensor.
+ *
+ * After initialization, enable polling of thermal sensor through
+ * SBus interface. In order for this to work, the SBus Master
+ * firmware has to be loaded due to the fact that the HW polling
+ * logic uses SBus interrupts, which are not supported with
+ * default firmware. Otherwise, no data will be returned through
+ * the ASIC_STS_THERM CSR.
+ */
+static int thermal_init(struct hfi2_devdata *dd)
+{
+	int ret = 0;
+
+	if (dd->params->chip_type != CHIP_WFR)
+		return ret;
+	if (dd->icode != ICODE_RTL_SILICON ||
+	    dd->params->chip_type != CHIP_WFR ||
+	    check_chip_resource(dd, CR_THERM_INIT, NULL))
+		return ret;
+
+	ret = acquire_chip_resource(dd, CR_SBUS, SBUS_TIMEOUT);
+	if (ret) {
+		THERM_FAILURE(dd, ret, "Acquire SBus");
+		return ret;
+	}
+
+	dd_dev_info(dd, "Initializing thermal sensor\n");
+	/* Disable polling of thermal readings */
+	write_csr(dd, ASIC_CFG_THERM_POLL_EN, 0x0);
+	msleep(100);
+	/* Thermal Sensor Initialization */
+	/*    Step 1: Reset the Thermal SBus Receiver */
+	ret = sbus_request_slow(dd, SBUS_THERMAL, 0x0,
+				RESET_SBUS_RECEIVER, 0);
+	if (ret) {
+		THERM_FAILURE(dd, ret, "Bus Reset");
+		goto done;
+	}
+	/*    Step 2: Set Reset bit in Thermal block */
+	ret = sbus_request_slow(dd, SBUS_THERMAL, 0x0,
+				WRITE_SBUS_RECEIVER, 0x1);
+	if (ret) {
+		THERM_FAILURE(dd, ret, "Therm Block Reset");
+		goto done;
+	}
+	/*    Step 3: Write clock divider value (100MHz -> 2MHz) */
+	ret = sbus_request_slow(dd, SBUS_THERMAL, 0x1,
+				WRITE_SBUS_RECEIVER, 0x32);
+	if (ret) {
+		THERM_FAILURE(dd, ret, "Write Clock Div");
+		goto done;
+	}
+	/*    Step 4: Select temperature mode */
+	ret = sbus_request_slow(dd, SBUS_THERMAL, 0x3,
+				WRITE_SBUS_RECEIVER,
+				SBUS_THERM_MONITOR_MODE);
+	if (ret) {
+		THERM_FAILURE(dd, ret, "Write Mode Sel");
+		goto done;
+	}
+	/*    Step 5: De-assert block reset and start conversion */
+	ret = sbus_request_slow(dd, SBUS_THERMAL, 0x0,
+				WRITE_SBUS_RECEIVER, 0x2);
+	if (ret) {
+		THERM_FAILURE(dd, ret, "Write Reset Deassert");
+		goto done;
+	}
+	/*    Step 5.1: Wait for first conversion (21.5ms per spec) */
+	msleep(22);
+
+	/* Enable polling of thermal readings */
+	write_csr(dd, ASIC_CFG_THERM_POLL_EN, 0x1);
+
+	/* Set initialized flag */
+	ret = acquire_chip_resource(dd, CR_THERM_INIT, 0);
+	if (ret)
+		THERM_FAILURE(dd, ret, "Unable to set thermal init flag");
+
+done:
+	release_chip_resource(dd, CR_SBUS);
+	return ret;
+}
+
+void handle_temp_err(struct hfi2_devdata *dd)
+{
+	struct hfi2_pportdata *ppd;
+	int pidx;
+	/*
+	 * Thermal Critical Interrupt
+	 * Put the device into forced freeze mode, take link down to
+	 * offline, and put DC into reset.
+	 */
+	dd_dev_emerg(dd,
+		     "Critical temperature reached! Forcing device into freeze mode!\n");
+	dd->flags |= HFI2_FORCED_FREEZE;
+
+	start_freeze_handling(dd, FREEZE_SELF | FREEZE_ABORT);
+	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
+		ppd = dd->pport + pidx;
+
+		/*
+		 * Shut DC down as much and as quickly as possible.
+		 *
+		 * Step 1: Iterate over the ports and take the links down to OFFLINE.
+		 *	   This will cause the 8051 to put the Serdes in reset. However,
+		 *	   we don't want to go through the entire link state machine since
+		 *	   we want to shutdown ASAP. Furthermore, this is not a graceful
+		 *	   shutdown but rather an attempt to save the chip.
+		 *         Code below is almost the same as quiet_serdes() but avoids
+		 *         all the extra work and the sleeps.
+		 */
+		ppd->driver_link_ready = 0;
+		ppd->link_enabled = 0;
+	}
+
+	set_physical_link_state(dd, (OPA_LINKDOWN_REASON_SMA_DISABLED << 8) |
+				PLS_OFFLINE);
+	/*
+	 * Step 2: Shutdown LCB and 8051
+	 *         After shutdown, do not restore DC_CFG_RESET value.
+	 */
+	dc_shutdown(dd);
+}
diff --git a/drivers/infiniband/hw/hfi2/chip_gen.c b/drivers/infiniband/hw/hfi2/chip_gen.c
new file mode 100644
index 000000000000..ae8ec17ccc01
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/chip_gen.c
@@ -0,0 +1,1093 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ *
+ * Generalized (parameterized) chip specific functions and variables.
+ */
+
+#include "hfi2.h"
+#include "chip_gen.h"
+#include "chip_jkr.h"
+#include "cport_traps.h"
+#include "vf2pf.h"
+#include "sriov.h"
+
+#undef DEBUG_CPORT_TRAP
+
+#define SC(name) SEND_CTXT_##name
+
+/*
+ * Control the port LED state.  Cancel with gen_shutdown_led_override().
+ */
+void gen_setextled(struct hfi2_pportdata *ppd, u32 on)
+{
+	ppd_dev_warn(ppd, "%s: on %d, not implemented\n", __func__, on);
+}
+
+/*
+ * Make the port LED blink in pattern.  Parameters timeon and timeoff are
+ * in milliseconds.  Cancel with gen_shutdown_led_override().
+ */
+void gen_start_led_override(struct hfi2_pportdata *ppd, unsigned int timeon,
+			    unsigned int timeoff)
+{
+	ppd_dev_warn(ppd, "%s: not implemented\n", __func__);
+
+	/* used by the subnet manager to know if it set beaconing */
+	atomic_set(&ppd->led_override_timer_active, 1);
+	/* ensure the atomic_set is visible to all CPUs */
+	smp_wmb();
+}
+
+/*
+ * Return to normal LED operation.  This cancels overrides started with
+ * gen_setextled() or gen_start_led_override().
+ */
+void gen_shutdown_led_override(struct hfi2_pportdata *ppd)
+{
+	ppd_dev_warn(ppd, "%s: not implemented\n", __func__);
+
+	/* used by the subnet manager to know if it set beaconing */
+	atomic_set(&ppd->led_override_timer_active, 0);
+	/* ensure the atomic_set is visible to all CPUs */
+	smp_wmb();
+}
+
+void gen_read_guid(struct hfi2_devdata *dd)
+{
+	dd_dev_warn(dd, "%s: not implemented\n", __func__);
+
+	dd->base_guid = 0xabcd;
+}
+
+int gen_late_per_chip_init(struct hfi2_devdata *dd)
+{
+	return 0;
+}
+
+void gen_start_port(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 guid;
+
+	/* FIXME: this is copied from bringup_serdes(). However, I don't
+	 * see the point.  No one has set ppd->guids[] this early.
+	 */
+	guid = ppd->guids[HFI2_PORT_GUID_INDEX];
+	if (!guid) {
+		/* OPA spec says bits 34:32 are port number, 1-7 */
+		if (dd->base_guid)
+			guid = (dd->base_guid & ~(7ULL << 32)) | ((u64)ppd->port << 32);
+		ppd->guids[HFI2_PORT_GUID_INDEX] = guid;
+		pr_warn("%s: ppd->guids[HFI2_PORT_GUID_INDEX] = 0x%llx",
+			__func__, guid);
+	}
+}
+
+void gen_stop_port(struct hfi2_pportdata *ppd)
+{
+	ppd_dev_warn(ppd, "%s: pidx %d, not implemented\n", __func__, ppd->hw_pidx);
+}
+
+void gen_set_port_max_mtu(struct hfi2_pportdata *ppd, u32 maxvlmtu)
+{
+	ppd_dev_warn(ppd, "%s: pidx %d, not implemented\n", __func__, ppd->hw_pidx);
+}
+
+u64 gen_create_pbc_pidx(u8 pidx, u64 flags, int srate_mbs,
+			u32 vl, u32 dw_len, u32 l2, u32 dlid, u32 sctxt)
+{
+	/* always add ICRC for non 9B packets */
+	if (l2 != PBC_L2_9B)
+		flags |= PBC_INSERT_BYPASS_ICRC; /* AKA PbcInsertNon9bIcrc */
+
+	return (u64)sctxt << PBC_SEND_CTXT_SHIFT |
+	       (u64)dlid << PBC_DLID_SHIFT |
+	       /* lower 32 bits */
+	       flags |
+	       PBC_IHCRC_NONE << PBC_INSERT_HCRC_SHIFT |
+	       l2 << PBC_L2_TYPE_SHIFT |
+	       pidx << PBC_PORT_IDX_SHIFT |
+	       (vl & PBC_VL_MASK) << PBC_VL_SHIFT |
+	       (dw_len & PBC_LENGTH_DWS_MASK) << PBC_LENGTH_DWS_SHIFT;
+}
+
+/**
+ * gen_create_pbc - build a pbc for transmission
+ * @ppd: info of physical Hfi port
+ * @loopback: whether to use loopback port
+ * @flags: special case flags or-ed in built pbc
+ * @srate_mbs: static rate - unused
+ * @vl: vl
+ * @dw_len: dword length (header words + data words + pbc words)
+ * @l2: L2 header field - determines type
+ * @dlid: destination LID
+ * @sctxt: send context number
+ *
+ * Create a PBC with the given flags, rate, VL, and length.
+ *
+ * NOTE: The PBC created will not insert any HCRC.
+ */
+u64 gen_create_pbc(struct hfi2_pportdata *ppd, bool loopback, u64 flags, int srate_mbs,
+		   u32 vl, u32 dw_len, u32 l2, u32 dlid, u32 sctxt)
+{
+	u8 pidx = loopback ? loopback_pidx(ppd) : ppd->hw_pidx;
+
+	return gen_create_pbc_pidx(pidx, flags, srate_mbs, vl, dw_len, l2, dlid, sctxt);
+}
+
+/*
+ * Construct a OPA MAD for sending to CPORT.
+ */
+static struct opa_smp *build_cport_mad(int meth, int attr)
+{
+	struct opa_smp *mad;
+
+	mad = kzalloc_obj(mad, GFP_KERNEL);
+	if (!mad)
+		return mad;
+	mad->base_version = OPA_MGMT_BASE_VERSION;
+	mad->mgmt_class = IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE;
+	mad->class_version = OPA_SM_CLASS_VERSION;
+	mad->method = meth;
+	mad->attr_id = attr;
+	return mad;
+}
+
+/*
+ * Send a GET PORT_INFO OPA MAD to CPORT to get details on port.
+ * Caller must kfree() the buffer returned (if not IS_ERR()).
+ */
+static struct opa_smp *cport_get_portinfo(struct hfi2_devdata *dd, int port)
+{
+	u8 sb = port; /* 1.. */
+	struct opa_smp *mad;
+	struct opa_smp *rsp;
+	size_t rsp_len;
+	int ret;
+
+	mad = build_cport_mad(IB_MGMT_METHOD_GET, IB_SMP_ATTR_PORT_INFO);
+	if (!mad)
+		return ERR_PTR(-ENOMEM);
+	/*
+	 * Set port in attribute modifier field, for PORT_INFO.
+	 */
+	mad->attr_mod = cpu_to_be32(0x1000000 | port);
+#ifdef DEBUG_CPORT_TRAP
+	pr_warn("hfi2_%d: %s: send: %02x %02x %02x %02x - %04x %04x %08x\n",
+		dd->unit, __func__,
+		mad->base_version, mad->mgmt_class, mad->class_version, mad->method,
+		be16_to_cpu(mad->status), be16_to_cpu(mad->attr_id),
+		be32_to_cpu(mad->attr_mod));
+#endif
+	rsp_len = sizeof(*rsp);
+	rsp = kzalloc(rsp_len, GFP_KERNEL);
+	if (!rsp) {
+		kfree(mad);
+		return ERR_PTR(-ENOMEM);
+	}
+	ret = cport_send_recv_mad(dd, sb, mad, sizeof(*mad) - OPA_SMP_DR_DATA_SIZE,
+				  rsp, &rsp_len);
+	kfree(mad);
+	if (ret) {
+		kfree(rsp);
+		if (ret > 0)
+			ret = -EINVAL;
+		return ERR_PTR(ret);
+	}
+#ifdef DEBUG_CPORT_TRAP
+	pr_warn("hfi2_%d: %s: resp: %02x %02x %02x %02x - %04x %04x %08x\n",
+		dd->unit, __func__,
+		rsp->base_version, rsp->mgmt_class, rsp->class_version, rsp->method,
+		be16_to_cpu(rsp->status), be16_to_cpu(rsp->attr_id), be32_to_cpu(rsp->attr_mod));
+#endif
+	return rsp;
+}
+
+/*
+ * Called on PF0 after all new VFs appear.
+ */
+int hfi2_sriov_sync_ports(struct hfi2_devdata *dd, int si_mask)
+{
+	struct opa_smp *mad;
+	struct opa_port_info *pi;
+	int pidx;
+	int ret = 0;
+
+	if (dd->is_vf)
+		return -EINVAL;
+	for (pidx = 0; pidx < dd->params->num_ports; ++pidx) {
+		mad = cport_get_portinfo(dd, pidx + 1);
+		if (IS_ERR(mad)) {
+			ret = PTR_ERR(mad);
+		} else {
+			pi = (struct opa_port_info *)opa_get_smp_data(mad);
+			ret = pf2vf_push_portinfo(&dd->pport[pidx], mad, pi, si_mask);
+			kfree(mad);
+		}
+		if (!ret)
+			ret = pf2vf_push_sc2vlt(&dd->pport[pidx], si_mask);
+	}
+	return ret;
+}
+
+#ifdef DEBUG_CPORT_TRAP
+static const char *ps_state_name(struct opa_port_states *ps)
+{
+	static const char * const state_name[] = {
+		[IB_PORT_NOP]		= "NOP",
+		[IB_PORT_DOWN]		= "DOWN",
+		[IB_PORT_INIT]		= "INIT",
+		[IB_PORT_ARMED]		= "ARMED",
+		[IB_PORT_ACTIVE]	= "ACTIVE",
+		[IB_PORT_ACTIVE_DEFER]	= "ACTIVE_DEFER"
+	};
+	u8 ls = port_states_to_logical_state(ps);
+
+	if (ls > IB_PORT_ACTIVE_DEFER)
+		return "???";
+	return state_name[ls];
+}
+#endif
+
+static void check_cport_state(struct work_struct *work)
+{
+	struct hfi2_cport *cport = container_of(work, struct hfi2_cport, psc.work);
+	struct hfi2_devdata *dd = cport->dd;
+	struct opa_smp *mad;
+	struct opa_port_info *pi;
+	int ret;
+	int pidx;
+
+	/*
+	 * There should be only one running. Others could abort except for
+	 * the race between checking states and releasing semaphore.
+	 */
+	ret = down_killable(&dd->cport->psc.wait);
+	if (ret) {
+		atomic_dec(&dd->cport->psc.nq);
+		return;
+	}
+#ifdef DEBUG_CPORT_TRAP
+	pr_warn("hfi2_%d: %s: starting port_info loop\n", dd->unit, __func__);
+#endif
+
+	for (pidx = 0; pidx < dd->params->num_ports; ++pidx) {
+		if (!port_available_pidx(dd, pidx)) {
+			ppd_dev_info(&dd->pport[pidx], "Skipping port state check - port not available\n");
+			continue;
+		}
+		mad = cport_get_portinfo(dd, pidx + 1);
+		if (IS_ERR(mad)) {
+			ret = PTR_ERR(mad);
+		} else {
+			pi = (struct opa_port_info *)opa_get_smp_data(mad);
+#ifdef DEBUG_CPORT_TRAP
+			pr_warn("hfi2_%d: %s: PORTINFO %d: %s %08x (%x)\n",
+				dd->unit, __func__,
+				pidx + 1, ps_state_name(&pi->port_states),
+				be32_to_cpu(mad->attr_mod),
+				be16_to_cpu(mad->status));
+#endif
+			ret = update_from_opa_portinfo(&dd->pport[pidx], mad, pi);
+			kfree(mad);
+		}
+		if (ret)
+			dd_dev_warn(dd, "Failed to update PORT_INFO on port %d (%d)\n",
+				    pidx + 1, ret);
+	}
+#ifdef DEBUG_CPORT_TRAP
+	pr_warn("hfi2_%d: %s: finished port_info loop\n", dd->unit, __func__);
+#endif
+	atomic_dec(&dd->cport->psc.nq);
+	up(&dd->cport->psc.wait);
+}
+
+static void handle_cport_trap128(struct hfi2_devdata *dd, struct cport_trap_status traps)
+{
+	/* note: traps are already repressed */
+#ifdef DEBUG_CPORT_TRAP
+	pr_warn("hfi2_%d: %s: TRAP128 psc=%d\n", dd->unit, __func__, traps.psc);
+#endif
+
+	if (atomic_read(&dd->cport->psc.nq) > 1) {
+#ifdef DEBUG_CPORT_TRAP
+		pr_warn("hfi2_%d: %s: TRAP128(s) pending: %d\n",
+			dd->unit, __func__, atomic_read(&dd->cport->psc.nq));
+#endif
+		return;
+	}
+	atomic_inc(&dd->cport->psc.nq);
+	queue_work(dd->hfi2_wq, &dd->cport->psc.work);
+}
+
+/*
+ * This initializes everything necessary to receive and process Port
+ * State Change TRAPs from CPORT. It also kicks off the initial gathering
+ * of port states from CPORT.
+ */
+int init_cport_trap128(struct hfi2_devdata *dd)
+{
+	struct cport_trap_status traps = {0};
+	int ret = 0;
+
+	if (!dd->cport)
+		return 0;
+
+	atomic_set(&dd->cport->psc.nq, 0);
+	sema_init(&dd->cport->psc.wait, 1);
+	INIT_WORK(&dd->cport->psc.work, check_cport_state);
+	traps.psc = 1;	/* Trap 128 Port State Change */
+	ret = register_cport_trap(dd, traps, handle_cport_trap128);
+	if (ret)
+		dd_dev_warn(dd, "Failed to register for CPORT TRAP 128: %d\n", ret);
+	else if (!dd->cport->traps_act.psc)
+		dd_dev_warn(dd, "CPORT TRAP128 not supported\n");
+	/* Fake a TRAP-128 to gather initial port states even if register fails */
+	handle_cport_trap128(dd, traps);
+	return ret;
+}
+
+int deinit_cport_trap128(struct hfi2_devdata *dd)
+{
+	if (!dd->cport || !dd->cport->traps.psc)
+		return 0;
+	return deregister_cport_trap(dd, handle_cport_trap128);
+}
+
+static void handle_cport_overtemp(struct hfi2_devdata *dd, struct cport_trap_status traps)
+{
+	/* note: traps are already repressed */
+	hfi2_overtemp(dd);
+}
+
+/* no deinit_ - clearall_cport_trap() unregisters this */
+int init_cport_overtemp(struct hfi2_devdata *dd)
+{
+	struct cport_trap_status traps = {0};
+	int ret = 0;
+
+	if (!dd->cport)
+		return 0;
+
+	traps.ovtm = 1;	/* Over Temp emergency */
+	ret = register_cport_trap(dd, traps, handle_cport_overtemp);
+	if (ret)
+		dd_dev_warn(dd, "Failed to register for CPORT Over Temp: %d\n", ret);
+	else if (!dd->cport->traps_act.ovtm)
+		dd_dev_warn(dd, "CPORT Over-Temp notification not supported\n");
+	return ret;
+}
+
+static int cport_goto_offline(struct hfi2_pportdata *ppd, struct opa_port_info *pi,
+			      u8 rem_reason)
+{
+	u32 previous_state;
+
+	previous_state = ppd->host_link_state;
+	ppd->host_link_state = HLS_GOING_OFFLINE;
+
+	/* start offline transition */
+	if (ppd->offline_disabled_reason ==
+	    HFI2_ODR_MASK(OPA_LINKDOWN_REASON_NONE))
+		ppd->offline_disabled_reason = HFI2_ODR_MASK(OPA_LINKDOWN_REASON_TRANSIENT);
+
+	update_statusp(ppd, IB_PORT_DOWN);
+
+	/*
+	 * The state in CPORT is now offline.
+	 *	- change our state
+	 *	- notify others if we were previously in a linkup state
+	 */
+	ppd->host_link_state = HLS_DN_OFFLINE;
+	if (previous_state & HLS_UP) {
+		/* went down while link was up */
+		cport_handle_linkup_change(ppd, pi, 0);
+	}
+
+	/* the active link width (downgrade) is 0 on link down */
+	ppd->link_width_active = 0;
+	ppd->link_width_downgrade_tx_active = 0;
+	ppd->link_width_downgrade_rx_active = 0;
+	ppd->current_egress_rate = 0;
+	return 0;
+}
+
+/* set_link_state() for CPORT-based systems. Only update local data. */
+int cport_set_link_state(struct hfi2_pportdata *ppd, struct opa_port_info *pi, u32 state)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int ret = 0;
+	int orig_new_state, poll_bounce;
+
+	mutex_lock(&ppd->hls_lock);
+
+	orig_new_state = state;
+	if (state == HLS_DN_DOWNDEF)
+		state = HLS_DEFAULT;
+
+	/* interpret poll -> poll as a link bounce */
+	poll_bounce = ppd->host_link_state == HLS_DN_POLL &&
+		      state == HLS_DN_POLL;
+
+	ppd_dev_info(ppd, "%s: current %s, new %s %s%s\n", __func__,
+		     link_state_name(ppd->host_link_state),
+		     link_state_name(orig_new_state),
+		     poll_bounce ? "(bounce) " : "",
+		     link_state_reason_name(ppd, state));
+
+	/*
+	 * If we're going to a (HLS_*) link state that implies the logical
+	 * link state is neither of (IB_PORT_ARMED, IB_PORT_ACTIVE), then
+	 * reset is_sm_config_started to 0.
+	 */
+	if (!(state & (HLS_UP_ARMED | HLS_UP_ACTIVE)))
+		ppd->is_sm_config_started = 0;
+
+	/*
+	 * Do nothing if the states match.  Let a poll to poll link bounce
+	 * go through.
+	 */
+	if (ppd->host_link_state == state && !poll_bounce)
+		goto done;
+
+	switch (state) {
+	case HLS_UP_INIT:
+		log_state_transition(ppd, PLS_LINKUP);
+
+		/* clear old transient LINKINIT_REASON code */
+		if (ppd->linkinit_reason >= OPA_LINKINIT_REASON_CLEAR)
+			ppd->linkinit_reason = OPA_LINKINIT_REASON_LINKUP;
+
+		cport_handle_linkup_change(ppd, pi, 1);
+		pio_kernel_linkup(ppd);
+
+		/*
+		 * After link up, a new link width will have been set.
+		 * Update the xmit counters with regards to the new
+		 * link width.
+		 */
+		update_xmit_counters(ppd, ppd->link_width_active);
+
+		ppd->host_link_state = HLS_UP_INIT;
+		update_statusp(ppd, IB_PORT_INIT);
+		break;
+	case HLS_UP_ARMED:
+		if (ppd->host_link_state != HLS_UP_INIT)
+			dd_dev_err(dd, "%s %d: allowing unexpected state transition from %s to %s\n",
+				   __func__, ppd->port,
+				   link_state_name(ppd->host_link_state),
+				   link_state_name(state));
+
+		ppd->host_link_state = HLS_UP_ARMED;
+		update_statusp(ppd, IB_PORT_ARMED);
+		break;
+	case HLS_UP_ACTIVE:
+		if (ppd->host_link_state != HLS_UP_ARMED)
+			dd_dev_err(dd, "%s %d: allowing unexpected state transition from %s to %s\n",
+				   __func__, ppd->port,
+				   link_state_name(ppd->host_link_state),
+				   link_state_name(state));
+
+		ppd->host_link_state = HLS_UP_ACTIVE;
+		update_statusp(ppd, IB_PORT_ACTIVE);
+		go_port_active(ppd);
+		break;
+	case HLS_DN_POLL:
+
+		if (ppd->host_link_state != HLS_DN_OFFLINE) {
+			u8 tmp = ppd->link_enabled;
+
+			ret = cport_goto_offline(ppd, pi, ppd->remote_link_down_reason);
+			if (ret) {
+				ppd->link_enabled = tmp;
+				break;
+			}
+			ppd->remote_link_down_reason = 0;
+
+			if (ppd->driver_link_ready)
+				ppd->link_enabled = 1;
+		}
+
+		set_all_slowpath(ppd);
+
+		ppd->port_error_action = 0;
+
+		ppd->host_link_state = HLS_DN_POLL;
+		ppd->offline_disabled_reason =
+			HFI2_ODR_MASK(OPA_LINKDOWN_REASON_NONE);
+		log_state_transition(ppd, PLS_POLLING);
+		break;
+	case HLS_DN_DISABLE:
+		/* link is disabled */
+		ppd->link_enabled = 0;
+
+		/* allow any state to transition to disabled */
+
+		/* must transition to offline first */
+		if (ppd->host_link_state != HLS_DN_OFFLINE) {
+			ret = cport_goto_offline(ppd, pi, ppd->remote_link_down_reason);
+			if (ret)
+				break;
+			ppd->remote_link_down_reason = 0;
+		}
+
+		ppd->host_link_state = HLS_DN_DISABLE;
+		break;
+	case HLS_DN_OFFLINE:
+		/* allow any state to transition to offline */
+		ret = cport_goto_offline(ppd, pi, ppd->remote_link_down_reason);
+		if (!ret)
+			ppd->remote_link_down_reason = 0;
+		break;
+	case HLS_GOING_UP:		/* never seen by driver */
+	case HLS_VERIFY_CAP:		/* never seen by driver */
+	case HLS_GOING_OFFLINE:		/* transient within goto_offline() */
+	case HLS_LINK_COOLDOWN:		/* transient within goto_offline() */
+	default:
+		dd_dev_info(dd, "%s %d: state 0x%x: not supported\n",
+			    __func__, ppd->port, state);
+		ret = -EINVAL;
+		break;
+	}
+
+done:
+	mutex_unlock(&ppd->hls_lock);
+
+	return ret;
+}
+
+int cport_start_link(struct hfi2_pportdata *ppd, struct opa_port_info *pi)
+{
+	/*
+	 * FULL_MGMT_P_KEY is cleared from the pkey table, so that the
+	 * pkey table can be configured properly if the HFI unit is connected
+	 * to switch port with MgmtAllowed=NO
+	 */
+	/* this writes CSRs... clear_full_mgmt_pkey(ppd); so do: */
+	if (ppd->pkeys[2] != 0) {
+		ppd->pkeys[2] = 0;
+		/* avoid hfi2_set_ib_cfg(HFI2_IB_CFG_PKEYS) */
+		hfi2_event_pkey_change(ppd->dd, ppd->port);
+	}
+
+	return cport_set_link_state(ppd, pi, HLS_DN_POLL);
+}
+
+/**
+ * Ask cport firmware for the temperature.
+ *
+ * @gen_temp: temperature output.
+ *
+ * Return: 0 on success, -EINVAL on invalid reply from CPORT,
+ * -EOPNOTSUPP on reply from CPORT but ASIC temperature not
+ * valid/supported.
+ */
+int cport_read_temp(struct hfi2_devdata *dd, struct cport_temp *gen_temp)
+{
+	struct cport_how_payload *how = NULL;
+	int resp_len = 0;
+	int ret;
+
+	/* Don't trust the caller; assume invalid */
+	gen_temp->asic_valid = 0;
+	gen_temp->qsfp1_valid = 0;
+	gen_temp->qsfp2_valid = 0;
+
+	ret = cport_send_req(dd, CH_OP_HOW, 0, NULL, 0, (void **)&how, &resp_len,
+			     cport_adm_to * HZ);
+	if (ret) {
+		dd_dev_err(dd, "CPORT how failed %d\n", ret);
+		goto done;
+	}
+	if (resp_len != sizeof(*how)) {
+		dd_dev_err(dd, "CPORT how invalid response length %d (expected %ld)\n",
+			   resp_len, sizeof(*how));
+		ret = -EINVAL;
+		goto done;
+	}
+	if (!how->temp_valid) {
+		ret = -EOPNOTSUPP;
+		goto done;
+	}
+	gen_temp->asic_valid = 1;
+	gen_temp->asic = (s16)how->temp;
+
+	gen_temp->qsfp1_valid = how->qsfp1_temp_valid;
+	if (how->qsfp1_temp_valid)
+		gen_temp->qsfp1 = (s16)how->qsfp1_temp;
+
+	gen_temp->qsfp2_valid = how->qsfp2_temp_valid;
+	if (how->qsfp2_temp_valid)
+		gen_temp->qsfp2 = (s16)how->qsfp2_temp;
+done:
+	kfree(how);
+	return ret;
+}
+
+static void gen_reset_rcvarray(struct hfi2_devdata *dd, u16 ctxt, u32 ra_cnt)
+{
+	u8 __iomem *ra;
+	u32 off;
+	u32 idx;
+
+	ra = dd->bar_maps[ctxt_bar_idx(ctxt)].rcvarray_wc;
+	ctxt = ctxt_bar_ctxt(ctxt);
+	for (idx = 0; idx < ra_cnt; ++idx) {
+		off = (ctxt << JKR_RCV_ARRAY_RCV_CTXT_IDX_SHIFT) |
+		      (idx << JKR_RCV_ARRAY_CSR_INDEX_SHIFT);
+		writeq(RCV_ARRAY_RT_WRITE_ENABLE_SMASK, ra + off);
+	}
+	flush_wc();
+}
+
+/*
+ * Called on PF0 before VFs are created.
+ * Context will be used for Eager only (no TID).
+ * Initialize all CSRs that can only be accessed by PF0.
+ * May be called to reset context for re-use.
+ */
+int gen_init_rctxt_egr(struct hfi2_devdata *dd, u8 pidx, int si, u16 ctxt,
+		       u32 ra_base, u32 ra_cnt, u32 hdr_size)
+{
+	u64 reg, kreg;
+
+	/* might need to reclaim context in PF0 */
+	if (si)
+		write_rctxt_csr(dd, ctxt, JKR_RCV_SI_IDX, 0);
+
+	/* reset eager head/tail by enabling ctxt after write of 0 to heads */
+	kreg = read_kctxt_csr(dd, ctxt, dd->params->rcv_kctxt_ctrl_reg);
+
+	/* disable context, in case it was previously used */
+	jkr_ena_rcv_ctxt(dd, pidx, ctxt, false);
+	/* remove RCV_CTXT_CTRL_ENABLE_SMASK (disable) */
+	kreg &= ~RCV_CTXT_CTRL_ENABLE_SMASK;
+	/* force these bits */
+	kreg |= RCV_CTXT_CTRL_ONE_PACKET_PER_EGR_BUFFER_SMASK |
+		JKR_RCV_KCTXT_CTRL_RECEIVE_CUT_THROUGH_DISABLE_SMASK;
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_kctxt_ctrl_reg, kreg);
+
+	dd->params->set_port_tid_config(dd, pidx, ctxt, ra_base, ra_cnt, 0, 0);
+	jkr_upd_rcv_hdr_size(dd, pidx, ctxt, hdr_size);
+
+	reg = RCV_CTXT_CTRL_INTR_AVAIL_SMASK;
+	write_rctxt_csr(dd, ctxt, dd->params->rcv_rctxt_ctrl_reg, reg);
+
+	write_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_head_reg, 0);
+	write_uctxt_csr(dd, ctxt, dd->params->rcv_egr_index_head_reg, 0);
+
+	gen_reset_rcvarray(dd, ctxt, ra_cnt);
+
+	/* (re-)enable context */
+	jkr_ena_rcv_ctxt(dd, pidx, ctxt, true);
+	kreg |= RCV_CTXT_CTRL_ENABLE_SMASK;
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_kctxt_ctrl_reg, kreg);
+
+	/* must be done after enable */
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_avail_time_out_reg,
+			RCV_AVAIL_TIME_OUT_TIME_OUT_RELOAD_MASK <<
+			RCV_AVAIL_TIME_OUT_TIME_OUT_RELOAD_SHIFT);
+	update_usrhead_ctxt(dd, ctxt, 0, 1, 0, 0);	/* needed for interrupts */
+
+	/*
+	 * Leave something for the VF to probe on.
+	 * Set any non-zero value, will be changed by VF later.
+	 */
+	reg = ((u64)encode_rcv_header_entry_size(32) & RCV_HDR_ENT_SIZE_ENT_SIZE_MASK) <<
+	      RCV_HDR_ENT_SIZE_ENT_SIZE_SHIFT;
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_ent_size_reg, reg);
+
+	/* finally, assign context to VF */
+	if (si)
+		write_rctxt_csr(dd, ctxt, JKR_RCV_SI_IDX, si);
+	return 0;
+}
+
+void gen_deinit_rctxt(struct hfi2_devdata *dd, u8 pidx, int si, u16 ctxt)
+{
+	u32 ra_cnt;
+
+	/* first, assign context back to PF0 */
+	if (si)
+		write_rctxt_csr(dd, ctxt, JKR_RCV_SI_IDX, 0);
+
+	ra_cnt = ((read_rctxt_csr(dd, ctxt, dd->params->rcv_egr_ctrl_reg) >>
+		   RCV_EGR_CTRL_EGR_CNT_SHIFT) &
+		  RCV_EGR_CTRL_EGR_CNT_MASK) << RCV_SHIFT;
+	jkr_ena_rcv_ctxt(dd, pidx, ctxt, false);
+
+	gen_reset_rcvarray(dd, ctxt, ra_cnt);
+
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_kctxt_ctrl_reg, 0);
+	write_rctxt_csr(dd, ctxt, dd->params->rcv_rctxt_ctrl_reg, 0);
+	write_rctxt_csr(dd, ctxt, dd->params->rcv_egr_ctrl_reg, 0);
+
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_cnt_reg, 0);
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_ent_size_reg, 0);
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_addr_reg, 0);
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_tail_addr_reg, 0);
+}
+
+/*
+ * Called by VFs before first VF-PF message.
+ */
+int gen_start_rctxt_egr(struct hfi2_devdata *dd, u8 pidx, u16 ctxt,
+			struct hfi2_ctxtbufs *bufs)
+{
+	u8 __iomem *ra;
+	u16 order;
+	u32 off;
+	u64 reg;
+	u32 r_each, r_size, etail;
+	dma_addr_t r_dma;
+	int idx;
+
+	/* cleanup from anything sent while no driver */
+	etail = read_uctxt_csr(dd, ctxt, JKR_RCV_EGR_INDEX_TAIL) & 0xffff;
+	if (etail)
+		update_usrhead_ctxt(dd, ctxt, 0, 1, 1, etail);
+	/* just clear overflow coount - can't do anything else */
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_ovfl_cnt_reg, 0);
+
+	/* assumes RCV_CTXT_CTRL_ONE_PACKET_PER_EGR_BUFFER_SMASK is set */
+	r_each = bufs->egr_buf_size;
+	r_dma = bufs->egr.dma;
+	r_size = bufs->egr.size;
+	idx = 0;
+	order = hfi2_encoded_size(r_each);
+	ra = dd->bar_maps[ctxt_bar_idx(ctxt)].rcvarray_wc;
+	while (r_size >= r_each) {
+		off = (ctxt_bar_ctxt(ctxt) << JKR_RCV_ARRAY_RCV_CTXT_IDX_SHIFT) |
+		      (idx << JKR_RCV_ARRAY_CSR_INDEX_SHIFT);
+		reg = RCV_ARRAY_RT_WRITE_ENABLE_SMASK |
+		      ((u64)order << JKR_RCV_ARRAY_EGR_RT_BUF_SIZE_SHIFT) |
+		      (r_dma >> RT_ADDR_SHIFT);
+		writeq(reg, ra + off);
+		++idx;
+		r_size -= r_each;
+		r_dma += r_each;
+	}
+	flush_wc();
+	if (!idx)	/* none allocated */
+		return -ENOSPC;
+
+	reg = (((u64)bufs->rhq_cnt >> HDRQ_SIZE_SHIFT) & RCV_HDR_CNT_CNT_MASK) <<
+	      RCV_HDR_CNT_CNT_SHIFT;
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_cnt_reg, reg);
+	reg = ((u64)encode_rcv_header_entry_size(bufs->rhq_ent_size) &
+	       RCV_HDR_ENT_SIZE_ENT_SIZE_MASK) << RCV_HDR_ENT_SIZE_ENT_SIZE_SHIFT;
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_ent_size_reg, reg);
+
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_addr_reg, bufs->rhq.dma);
+	if (dd->params->set_rheq_addr)
+		dd->params->set_rheq_addr(dd, ctxt, bufs->rheq.dma);
+
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_tail_addr_reg,
+			dd->rcvhdrtail_dummy_dma);
+
+	return 0;
+}
+
+/*
+ * Called on PF0 before VFs are created.
+ * Context is used for PIO only (no SDMA).
+ * Initialize all CSRs that can only be accessed by PF0.
+ */
+int gen_init_sctxt_pio(struct hfi2_devdata *dd, u8 pidx, int si, u16 ctxt,
+		       u32 cr_base, u32 cr_cnt)
+{
+	u64 reg;
+	int ret;
+
+	/* might need to reclaim context in PF0 */
+	if (si)
+		write_csr(dd, JKR_SEND_CTXT_SI_IDX + (8 * ctxt), 0);
+
+	/* first, ensure context is disabled - to ensure reset */
+	ret = priv_reg_op(dd, pidx, ctxt, SC_KERNEL, SC_DISABLE_OP, 0);
+	if (ret)
+		return ret;
+
+	reg = ((u64)cr_cnt << SEND_CTXT_CTRL_CTXT_DEPTH_SHIFT) |
+	      ((u64)cr_base << dd->params->pio_base_shift);
+	write_tctxt_csr(dd, ctxt, dd->params->send_ctxt_ctrl_reg, reg);
+	/* or: dd->params->set_pio_integrity(dd, pidx, ctxt, SC_KERNEL, SPI_INIT) */
+	write_epsc_csr(dd, pidx, ctxt,
+		       dd->params->send_ctxt_check_enable_reg,
+		       JKR_SEND_CTXT_CHECK_ENABLE_L2_TYPE9BALLOWED_SMASK);
+	write_epsc_csr(dd, pidx, ctxt,
+		       dd->params->send_ctxt_check_partition_key_reg,
+		       (SEND_CTXT_CHECK_PARTITION_KEY_VALUE_MASK & DEFAULT_PKEY) <<
+		       SEND_CTXT_CHECK_PARTITION_KEY_VALUE_SHIFT);
+	write_epsc_csr(dd, pidx, ctxt,
+		       dd->params->send_ctxt_check_opcode_reg,
+		       ((u64)OPCODE_CHECK_MASK_DISABLED <<
+			SEND_CTXT_CHECK_OPCODE_MASK_SHIFT) |
+		       ((u64)OPCODE_CHECK_VAL_DISABLED <<
+			SEND_CTXT_CHECK_OPCODE_VALUE_SHIFT));
+
+	write_sctxt_csr(dd, ctxt, dd->params->send_ctxt_err_mask_reg, 0);
+	write_sctxt_csr(dd, ctxt, dd->params->send_ctxt_credit_return_addr_reg, 0);
+
+	reg = 1 << SEND_CTXT_CREDIT_CTRL_THRESHOLD_SHIFT;
+	write_sctxt_csr(dd, ctxt, dd->params->send_ctxt_credit_ctrl_reg, reg);
+	/* send_ctxt_check_vl_reg stays 0? */
+
+	/* this does a PIO init on the context */
+	ret = priv_reg_op(dd, pidx, ctxt, SC_KERNEL, SC_ENABLE_OP, 0);
+	if (ret)
+		return ret;
+
+	/* finally, assign context to VF */
+	if (si)
+		write_csr(dd, JKR_SEND_CTXT_SI_IDX + (8 * ctxt), si);
+
+	return 0;
+}
+
+void gen_deinit_sctxt(struct hfi2_devdata *dd, u8 pidx, int si, u16 ctxt)
+{
+	/* first, assign context back to PF0 */
+	if (si)
+		write_csr(dd, JKR_SEND_CTXT_SI_IDX + (8 * ctxt), 0);
+
+	write_tctxt_csr(dd, ctxt, dd->params->send_ctxt_ctrl_reg, 0);
+	write_epsc_csr(dd, pidx, ctxt, dd->params->send_ctxt_check_enable_reg, 0);
+	write_epsc_csr(dd, pidx, ctxt, dd->params->send_ctxt_check_partition_key_reg, 0);
+	write_epsc_csr(dd, pidx, ctxt, dd->params->send_ctxt_check_opcode_reg, 0);
+	write_sctxt_csr(dd, ctxt, dd->params->send_ctxt_err_mask_reg, 0);
+	write_sctxt_csr(dd, ctxt, dd->params->send_ctxt_credit_return_addr_reg, 0);
+	write_sctxt_csr(dd, ctxt, dd->params->send_ctxt_credit_ctrl_reg, 0);
+}
+
+/*
+ * Called by VFs before first VF-PF message.
+ */
+int gen_start_sctxt(struct hfi2_devdata *dd, u8 pidx, u16 ctxt, struct hfi2_ctxtbufs *bufs)
+{
+	write_sctxt_csr(dd, ctxt, dd->params->send_ctxt_err_mask_reg, (u64)-1);
+	write_sctxt_csr(dd, ctxt, dd->params->send_ctxt_credit_return_addr_reg, bufs->cr.dma);
+	return 0;
+}
+
+static void set_sc_check(struct hfi2_devdata *dd, u8 pidx, u32 ctxt, int type)
+{
+	u8 opval, opmask;
+
+	/* set the default partition key */
+	write_epsc_csr(dd, pidx, ctxt,
+		       dd->params->send_ctxt_check_partition_key_reg,
+		       (SC(CHECK_PARTITION_KEY_VALUE_MASK) &
+		       DEFAULT_PKEY) <<
+		       SC(CHECK_PARTITION_KEY_VALUE_SHIFT));
+	/* per context type checks */
+	if (type == SC_USER) {
+		opval = USER_OPCODE_CHECK_VAL;
+		opmask = USER_OPCODE_CHECK_MASK;
+	} else {
+		opval = OPCODE_CHECK_VAL_DISABLED;
+		opmask = OPCODE_CHECK_MASK_DISABLED;
+	}
+	/* set the send context check opcode mask and value */
+	write_epsc_csr(dd, pidx, ctxt, dd->params->send_ctxt_check_opcode_reg,
+		       ((u64)opmask << SC(CHECK_OPCODE_MASK_SHIFT)) |
+		       ((u64)opval << SC(CHECK_OPCODE_VALUE_SHIFT)));
+	/* User send contexts should not allow sending on VL15 */
+	if (type == SC_USER) {
+		write_epsc_csr(dd, pidx, ctxt, dd->params->send_ctxt_check_vl_reg,
+			       1ULL << 15);
+	}
+}
+
+/*
+ * Read a CSR based on type
+ *
+ * type - CSR_TYPE_*
+ * off - base offset of CSR
+ * ctxt - conext number, if type requires one
+ * pidx_eng - port index or SDMA engine number, depending on type
+ */
+u64 read_csr_type(struct hfi2_devdata *dd, enum csr_type type, u32 off,
+		  u16 ctxt, u8 pidx_eng)
+{
+	u64 reg = ~0ull;
+
+	switch (type) {
+	case CSR_TYPE_IPORT:
+		reg = read_iport_csr(dd, pidx_eng, off);
+		break;
+	case CSR_TYPE_IPRC:
+		reg = read_iprc_csr(dd, pidx_eng, ctxt, off);
+		break;
+	case CSR_TYPE_RCTXT:
+		reg = read_rctxt_csr(dd, ctxt, off);
+		break;
+	case CSR_TYPE_KCTXT:
+		reg = read_kctxt_csr(dd, ctxt, off);
+		break;
+	case CSR_TYPE_KU:
+		reg = read_ku_csr(dd, ctxt, off);
+		break;
+	case CSR_TYPE_UCTXT:
+		reg = read_uctxt_csr(dd, ctxt, off);
+		break;
+	case CSR_TYPE_SCTXT:
+		reg = read_sctxt_csr(dd, ctxt, off);
+		break;
+	case CSR_TYPE_TCTXT:
+		reg = read_tctxt_csr(dd, ctxt, off);
+		break;
+	case CSR_TYPE_SDMA:
+		reg = read_sdma_csr(dd, pidx_eng, off);
+		break;
+	case CSR_TYPE_SDMACFG:
+		reg = read_sdmacfg_csr(dd, pidx_eng, off);
+		break;
+	case CSR_TYPE_EPORT:
+		reg = read_eport_csr(dd, pidx_eng, off);
+		break;
+	case CSR_TYPE_EPSC:
+		reg = read_epsc_csr(dd, pidx_eng, ctxt, off);
+		break;
+	case CSR_TYPE_EPSCARR:
+		reg = read_epsc_csr(dd, pidx_eng, ctxt, off);
+		break;
+	}
+	return reg;
+}
+
+int priv_reg_op(struct hfi2_devdata *dd, int pidx, u32 ctxt, int type,
+		enum preg_op op, u64 arg)
+{
+	u16 rctxt;
+	int ret = 0;
+
+	rctxt = ctxt >> 16;
+	ctxt &= 0xffff;
+
+	if (dd->is_vf) {
+		ret = vf2pf_priv_reg_op(dd, pidx, ctxt, type, op, arg);
+		if (ret)
+			dd_dev_err(dd, "vf2pf_priv_reg_op(%d) failed %d\n", op, ret);
+		return ret;
+	}
+
+	/* Only PF0 has access to these CSRs */
+	switch (op) {
+	case SC_CHK_ALLOC_OP: /* 'arg' is send_ctxt_ctrl_reg value */
+		write_tctxt_csr(dd, ctxt, dd->params->send_ctxt_ctrl_reg, arg);
+		dd->params->set_pio_integrity(dd, pidx, ctxt, type, SPI_DEFAULT);
+		set_sc_check(dd, pidx, ctxt, type);
+		if (dd->is_sriov)
+			set_sc_check(dd, loopback_pidx_dd(dd, pidx), ctxt, type);
+		break;
+	case SC_CHK_FREE_OP: /* 'arg' not used */
+		write_tctxt_csr(dd, ctxt, dd->params->send_ctxt_ctrl_reg, 0);
+		write_epsc_csr(dd, pidx, ctxt,
+			       dd->params->send_ctxt_check_enable_reg, 0);
+		write_epsc_csr(dd, pidx, ctxt,
+			       dd->params->send_ctxt_check_partition_key_reg, 0);
+		write_epsc_csr(dd, pidx, ctxt,
+			       dd->params->send_ctxt_check_opcode_reg, 0);
+		if (dd->is_sriov) {
+			pidx = loopback_pidx_dd(dd, pidx);
+			write_epsc_csr(dd, pidx, ctxt,
+				       dd->params->send_ctxt_check_enable_reg, 0);
+			write_epsc_csr(dd, pidx, ctxt,
+				       dd->params->send_ctxt_check_partition_key_reg, 0);
+			write_epsc_csr(dd, pidx, ctxt,
+				       dd->params->send_ctxt_check_opcode_reg, 0);
+		}
+		break;
+	case SC_CHK_VL_MASK_OP: /* 'arg' is send_ctxt_check_vl_reg value */
+		write_epsc_csr(dd, pidx, ctxt, dd->params->send_ctxt_check_vl_reg, arg);
+		if (dd->is_sriov)
+			write_epsc_csr(dd, loopback_pidx_dd(dd, pidx), ctxt,
+				       dd->params->send_ctxt_check_vl_reg, arg);
+		break;
+	case SC_CHK_SLID_OP: /* 'arg' is send_ctxt_check_slid_reg value */
+		write_epsc_csr(dd, pidx, ctxt, dd->params->send_ctxt_check_slid_reg, arg);
+		if (dd->is_sriov)
+			write_epsc_csr(dd, loopback_pidx_dd(dd, pidx), ctxt,
+				       dd->params->send_ctxt_check_slid_reg, arg);
+		break;
+	case SC_CHK_JKEY_OP: /* 'arg' is send_ctxt_check_job_key_reg val, 'ctxt' incl rcv */
+		write_epsc_csr(dd, pidx, ctxt, dd->params->send_ctxt_check_job_key_reg, arg);
+		if (dd->is_sriov)
+			write_epsc_csr(dd, loopback_pidx_dd(dd, pidx), ctxt,
+				       dd->params->send_ctxt_check_job_key_reg, arg);
+		if (!is_ax(dd)) {
+			dd->params->set_pio_integrity(dd, pidx, ctxt, type,
+				arg ? SPI_SET_JKEY : SPI_CLEAR_JKEY);
+		}
+		/* Enable/clear J_KEY check on receive context. */
+		if (arg) {
+			/* convert sctxt jkey to rctxt */
+			arg = (arg >> SEND_CTXT_CHECK_JOB_KEY_VALUE_SHIFT) &
+				SEND_CTXT_CHECK_JOB_KEY_VALUE_MASK;
+			arg = RCV_KEY_CTRL_JOB_KEY_ENABLE_SMASK |
+				((arg & RCV_KEY_CTRL_JOB_KEY_VALUE_MASK) <<
+				 RCV_KEY_CTRL_JOB_KEY_VALUE_SHIFT);
+		}
+		write_iprc_csr(dd, pidx, rctxt, dd->params->rcv_jkey_ctrl_reg, arg);
+		if (dd->is_sriov)
+			write_iprc_csr(dd, loopback_pidx_dd(dd, pidx), rctxt,
+				       dd->params->rcv_jkey_ctrl_reg, arg);
+		break;
+	case SC_CHK_PKEY_OP: /* 'arg' is send_ctxt_check_partition_key_reg value */
+		if (!arg)
+			dd->params->set_pio_integrity(dd, pidx, ctxt, type, SPI_CLEAR_PKEY);
+		write_epsc_csr(dd, pidx, ctxt, dd->params->send_ctxt_check_partition_key_reg, arg);
+		if (dd->is_sriov)
+			write_epsc_csr(dd, loopback_pidx_dd(dd, pidx), ctxt,
+				       dd->params->send_ctxt_check_partition_key_reg, arg);
+		if (arg)
+			dd->params->set_pio_integrity(dd, pidx, ctxt, type, SPI_SET_PKEY);
+		break;
+	case SC_CHK_ADJ_OP: /* 'arg' is enable flag (do SC_CHK_INIT_OP also) */
+		dd->params->set_pio_integrity(dd, pidx, ctxt, type, SPI_DEFAULT);
+		if (!arg)
+			break;
+		fallthrough;
+	case SC_CHK_INIT_OP: /* 'arg' not used */
+		dd->params->set_pio_integrity(dd, pidx, ctxt, type, SPI_INIT);
+		break;
+	case SC_ENABLE_OP: /* 'arg' not used as input, 'pidx' not used */
+		ret = pio_reset_one(dd, ctxt);
+		if (ret)
+			break;
+
+		/*
+		 * All is well. Enable the context.
+		 */
+		arg = read_tctxt_csr(dd, ctxt, dd->params->send_ctxt_ctrl_reg);
+		arg |= SC(CTRL_CTXT_ENABLE_SMASK);
+		write_tctxt_csr(dd, ctxt, dd->params->send_ctxt_ctrl_reg, arg);
+		/*
+		 * Read SendCtxtCtrl to force the write out and prevent a timing
+		 * hazard where a PIO write may reach the context before the enable.
+		 */
+		read_tctxt_csr(dd, ctxt, dd->params->send_ctxt_ctrl_reg);
+		break;
+	case SC_DISABLE_OP: /* 'arg' not used as input, 'pidx' not used */
+		arg = read_tctxt_csr(dd, ctxt, dd->params->send_ctxt_ctrl_reg);
+		arg &= ~SC(CTRL_CTXT_ENABLE_SMASK);
+		write_tctxt_csr(dd, ctxt, dd->params->send_ctxt_ctrl_reg, arg);
+		break;
+	case RC_ENABLE_OP: /* 'arg' is enable flag */
+		jkr_ena_rcv_ctxt(dd, pidx, ctxt, arg);
+		if (dd->is_sriov)
+			jkr_ena_rcv_ctxt(dd, loopback_pidx_dd(dd, pidx), ctxt, arg);
+		break;
+	case RC_HEADER_OP: /* 'arg' is size */
+		jkr_upd_rcv_hdr_size(dd, pidx, ctxt, arg);
+		if (dd->is_sriov)
+			jkr_upd_rcv_hdr_size(dd, loopback_pidx_dd(dd, pidx), ctxt, arg);
+		break;
+	case LINK_BOUNCE_OP: /* 'arg' is not used */
+		queue_work(dd->pport[pidx].link_wq, &dd->pport[pidx].link_bounce_work);
+		break;
+	}
+	return ret;
+}
diff --git a/drivers/infiniband/hw/hfi2/chip_jkr.c b/drivers/infiniband/hw/hfi2/chip_jkr.c
new file mode 100644
index 000000000000..06b578215622
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/chip_jkr.c
@@ -0,0 +1,989 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#include "hfi2.h"
+#include "trace.h"
+#include "chip_jkr.h"
+#include "cport.h"
+#include "sriov.h"
+#include "vf2pf.h"
+
+int jkr_find_used_resources(struct hfi2_devdata *dd)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	u64 val;
+	bool found_first_unused;
+	int i;
+
+	/*
+	 * This sets up boundaries only. PF0 must initialize all and
+	 * assign to SI(s), as well as avoid CPORT ones.
+	 */
+	if (dr->num_vfs) {
+		/* resources already setup by hfi2_sriov_set_cfg() */
+		if (dd->is_vf)
+			goto out;
+	} else {
+		dr->pfunit = dd->unit;
+		dr->c.first_send_context = 0;
+		dr->c.last_send_context = chip_send_contexts(dd);
+		dr->c.first_rcv_context = 0;
+		dr->c.last_rcv_context = chip_rcv_contexts(dd);
+		dr->c.first_rcvarray_entry = 0;
+		dr->c.last_rcvarray_entry = chip_rcv_array_count(dd);
+		dr->c.first_pio_block = 0;
+		dr->c.last_pio_block = chip_pio_mem_size(dd) / PIO_BLOCK_SIZE;
+	}
+
+	/*
+	 * Find reserved resources.  Expectations:  All used resources are
+	 * at the front of the resource.  If this is not the case, there
+	 * will be wasted resources.
+	 */
+
+	/*
+	 * Look for send reserved.
+	 */
+	found_first_unused = false;
+	for (i = 0; i < dr->c.last_send_context; i++) {
+		val = read_ctxt_csr(dd, JKR_SEND_CTXT_SI_IDX, i, 8);
+		if (val == 0) {		/* 0 means pf0 */
+			/* this context is for the driver */
+			if (!found_first_unused) {
+				found_first_unused = true;
+				dr->c.first_send_context = i;
+			}
+		} else {
+			u32 base;	/* in blocks */
+			u32 size;	/* in blocks */
+
+			/* this context is non-driver */
+			if (found_first_unused) {
+				/*
+				 * Expect an initial set of non-driver
+				 * contexts, then all driver after that.
+				 */
+				return -EINVAL;
+			}
+			/* read PIO send resources for this context */
+			val = read_tctxt_csr(dd, i, dd->params->send_ctxt_ctrl_reg);
+			base = (val >> JKR_SEND_CTXT_CTRL_CTXT_BASE_SHIFT) &
+				MASK_ULL(dd->params->pio_base_bits);
+			size = (val >> SEND_CTXT_CTRL_CTXT_DEPTH_SHIFT) &
+				SEND_CTXT_CTRL_CTXT_DEPTH_MASK;
+			dd_dev_info(dd, "Non driver send ctxt %d: base 0x%x, size 0x%x\n",
+				    i, base, size);
+			/*
+			 * Expect the non-driver contexts to use the blocks in
+			 * increasing groups.  Warn otherwise.  This is a simple
+			 * attempt to warn if there may be wasted reserved
+			 * blocks.  I.e. no holes.  Doing this right would
+			 * involve much more complicated range lists that are
+			 * not worth doing.
+			 */
+			if (dr->c.first_pio_block != base) {
+				dd_dev_warn(dd, "%s: WARNING: unexpected PIO blocks used\n",
+					    __func__);
+			}
+			/* adjust top used */
+			if (dr->c.first_pio_block < base + size)
+				dr->c.first_pio_block = base + size;
+		}
+	}
+	if (dr->c.first_send_context >= dr->c.last_send_context)
+		return -ENOSPC;
+
+	/*
+	 * Look for receive reserved.
+	 */
+	found_first_unused = false;
+	for (i = 0; i < dr->c.last_rcv_context; i++) {
+		val = read_rctxt_csr(dd, i, JKR_RCV_SI_IDX);
+		if (val == 0) {		/* 0 means pf0 */
+			/* this context is for the driver */
+			if (!found_first_unused) {
+				found_first_unused = true;
+				dr->c.first_rcv_context = i;
+			}
+		} else {
+			u32 egr_base;
+			u32 egr_count;
+			u32 tid_base;
+			u32 tid_count;
+
+			/* this context is non-driver */
+			if (found_first_unused) {
+				/*
+				 * Expect an initial set of non-driver
+				 * contexts, then all driver after that.
+				 */
+				return -EINVAL;
+			}
+
+			/* read resources for this context */
+			/* RcvEgrCtrl RcvTidCtrl */
+			val = read_rctxt_csr(dd, i, dd->params->rcv_egr_ctrl_reg);
+			egr_base = (val >> JKR_RCV_EGR_CTRL_EGR_BASE_INDEX_SHIFT) &
+					JKR_RCV_EGR_CTRL_EGR_BASE_INDEX_MASK;
+			egr_count = (val >> JKR_RCV_EGR_CTRL_EGR_CNT_SHIFT) &
+					JKR_RCV_EGR_CTRL_EGR_CNT_MASK;
+			val = read_rctxt_csr(dd, i, dd->params->rcv_tid_ctrl_reg);
+			tid_base = (val >> JKR_RCV_TID_CTRL_TID_BASE_INDEX_SHIFT) &
+					JKR_RCV_TID_CTRL_TID_BASE_INDEX_MASK;
+			tid_count = (val >> JKR_RCV_TID_CTRL_TID_PAIR_CNT_SHIFT) &
+					JKR_RCV_TID_CTRL_TID_PAIR_CNT_MASK;
+			dd_dev_info(dd, "Non driver rcv ctxt %d: egr_base 0x%x, egr_count 0x%x, tid_base 0x%x, tid_count 0x%x\n",
+				    i, egr_base, egr_count, tid_base,
+				    tid_count);
+			/* expect no TID resources used */
+			if (tid_count != 0)
+				return -EINVAL;
+
+			/* convert from group to individual counts */
+			egr_base *= RCV_INCREMENT;
+			egr_count *= RCV_INCREMENT;
+
+			/*
+			 * Expect the non-driver contexts to use the entries in
+			 * increasing groups.  Warn otherwise.  This is a simple
+			 * attempt to warn if there may be wasted reserved
+			 * blocks.  I.e. no holes.  Doing this right would
+			 * involve much more complicated range lists that are
+			 * not worth doing.
+			 */
+			if (dr->c.first_rcvarray_entry != egr_base) {
+				dd_dev_warn(dd, "%s: WARNING: unexpected RcvArray entries used\n",
+					    __func__);
+			}
+
+			if (dr->c.first_rcvarray_entry < egr_base + egr_count)
+				dr->c.first_rcvarray_entry = egr_base + egr_count;
+		}
+	}
+	if (dr->c.first_rcv_context >= dr->c.last_rcv_context)
+		return -ENOSPC;
+
+	/*
+	 * Look for RSM rules being used.
+	 */
+	for (i = 0; i < dd->params->rsm_rule_size; i++) {
+		val = read_csr(dd, JKR_RCV_RSM_CFG + (8 * i));
+		if (val == 0)
+			break;
+	}
+	if (i == dd->params->rsm_rule_size) {
+		dd_dev_err(dd, "All %d RSM rules used\n",
+			   dd->params->rsm_rule_size);
+		return -EINVAL;
+	}
+	dd->first_rsm_rule = i;
+	/* mark these as used */
+	for (i = 0; i < dd->first_rsm_rule; i++)
+		set_bit(i, dd->rsm_rule_bitmap);
+	dd->rsm_rule_init = true;
+
+out:
+	dd_dev_info(dd, "Resource starts: send ctxt %d, pio block %d, rcv ctxt %d, RcvArray %d, rsm rule %d\n",
+		    dr->c.first_send_context, dr->c.first_pio_block,
+		    dr->c.first_rcv_context, dr->c.first_rcvarray_entry,
+		    dd->first_rsm_rule);
+
+	return 0;
+}
+
+void jkr_read_guid(struct hfi2_devdata *dd)
+{
+	/* This should get refactored into early_per_chip_init() for all */
+}
+
+int jkr_early_per_chip_init(struct hfi2_devdata *dd)
+{
+	tune_pcie_caps(dd);
+	init_early_variables(dd);
+
+	return hfi2_sriov_assign_rsrcs(dd, &dd->rsrcs);
+}
+
+int jkr_mid_per_chip_init(struct hfi2_devdata *dd)
+{
+	struct cport_who_payload *who = NULL;
+	int resp_len = 0;
+	int ret = 0;
+
+	if (dd->is_vf)
+		goto skip_guid; /* guid obtained earlier via hfi2_sriov_set_cfg */
+
+	dd->base_guid = 0xabcd;	/* on success, a valid value is set */
+	ret = cport_send_req(dd, CH_OP_WHO, 0, NULL, 0, (void **)&who, &resp_len,
+			     cport_adm_to * HZ);
+	if (ret) {
+		dd_dev_err(dd, "CPORT who failed %d\n", ret);
+	} else if (resp_len == sizeof(*who)) {
+		struct ib_device *ibdev = &dd->verbs_dev.rdi.ibdev;
+		char v_str[IB_FW_VERSION_NAME_MAX] = {};
+
+		dd->base_guid = who->node_guid;
+		if (!ib_hfi2_sys_image_guid)
+			ib_hfi2_sys_image_guid = cpu_to_be64(dd->base_guid);
+		dd->cport_ver = who->vers.vers;
+		cport_get_dev_fw_str(ibdev, v_str);
+		dd_dev_info(dd, "CPORT firmware version %s\n",
+			    v_str);
+	} else
+		dd_dev_err(dd, "CPORT who invalid resp %d\n", resp_len);
+
+	kfree(who);
+skip_guid:
+	/* additional mid-init here */
+	return ret;
+}
+
+static void set_si_int_enable_range(struct hfi2_devdata *dd, u64 *csrs, u32 start, u32 end)
+{
+	int i;
+	u32 idx;
+	u32 bit;
+
+	for (i = start; i < end; ++i) {
+		idx = i / 64;
+		bit = i % 64;
+		csrs[idx] |= (1ull << bit);
+	}
+}
+
+static void write_si_int_enable(struct hfi2_devdata *dd, int si, u64 *csrs)
+{
+	int i;
+	u32 base;
+
+	base = JKR_CCE_SI_INT_ENABLES + JKR_C_CCE_SI_INT_ENABLES_STRIDE * si;
+	for (i = 0; i < dd->params->num_int_csrs; ++i)
+		write_csr(dd, base + (i * 8), csrs[i]);
+}
+
+/* non-RXE, non-TXE, csr init */
+void jkr_init_other(struct hfi2_devdata *dd)
+{
+	struct hfi2_devrsrcs dr;
+	int si, nsi;
+	u64 csrs[LARGEST_NUM_INT_CSRS];
+	u32 is_base;
+
+	if (dd->is_vf)
+		return; /* VFs can't access these CSRs */
+
+	nsi = dd->rsrcs.num_vfs + 1; /* #VFs + PF0 */
+
+	/* Enable interrupts for each SI according to allocated resources */
+	for (si = 0; si < nsi; ++si) {
+		if (si)
+			sriov_get_config(dd, &dr, si);
+		else
+			dr = dd->rsrcs;
+		memset(csrs, 0, sizeof(csrs));
+		if (!si) {
+			set_si_int_enable_range(dd, csrs, JKR_IS_GENERAL_ERR_START,
+						JKR_ASIC_ERR_INT + 1);
+			set_si_int_enable_range(dd, csrs, JKR_MCTXT_CPORT_TO_PCIE_INT,
+						JKR_MCTXT_CPORT_TO_PCIE_INT + 1);
+		}
+		is_base = dd->params->is_sdmaeng_err_start;
+		set_si_int_enable_range(dd, csrs,
+					is_base + dr.first_sdma_engine,
+					is_base + dr.last_sdma_engine);
+		is_base = JKR_IS_SENDCTXT_ERR_START;
+		set_si_int_enable_range(dd, csrs,
+					is_base + dr.c.first_send_context,
+					is_base + dr.c.last_send_context);
+		is_base = dd->params->is_sdma_start;
+		set_si_int_enable_range(dd, csrs,
+					is_base + dr.first_sdma_engine,
+					is_base + dr.last_sdma_engine);
+		is_base = dd->params->is_sdma_progress_start;
+		set_si_int_enable_range(dd, csrs,
+					is_base + dr.first_sdma_engine,
+					is_base + dr.last_sdma_engine);
+		is_base = dd->params->is_sdma_idle_start;
+		set_si_int_enable_range(dd, csrs,
+					is_base + dr.first_sdma_engine,
+					is_base + dr.last_sdma_engine);
+		is_base = dd->params->is_rcvavail_start;
+		set_si_int_enable_range(dd, csrs,
+					is_base + dr.c.first_rcv_context,
+					is_base + dr.c.last_rcv_context);
+		is_base = dd->params->is_rcvurgent_start;
+		set_si_int_enable_range(dd, csrs,
+					is_base + dr.c.first_rcv_context,
+					is_base + dr.c.last_rcv_context);
+		is_base = JKR_IS_SENDCREDIT_START;
+		set_si_int_enable_range(dd, csrs,
+					is_base + dr.c.first_send_context,
+					is_base + dr.c.last_send_context);
+		is_base = JKR_IS_PBC_START;
+		set_si_int_enable_range(dd, csrs,
+					is_base + dr.c.first_send_context,
+					is_base + dr.c.last_send_context);
+		is_base = JKR_IS_PIO_ERR_START;
+		set_si_int_enable_range(dd, csrs,
+					is_base + si,
+					is_base + si + 1);
+		is_base = JKR_IS_SDMA_ERR_SI_START;
+		set_si_int_enable_range(dd, csrs,
+					is_base + si,
+					is_base + si + 1);
+		is_base = JKR_IS_CSR_ERR_START;
+		set_si_int_enable_range(dd, csrs,
+					is_base + si,
+					is_base + si + 1);
+		vf2pf_set_si_enables(dd, si, csrs, set_si_int_enable_range);
+		write_si_int_enable(dd, si, csrs);
+	}
+}
+
+/* all "misc" interrupt source names */
+static const char * const jkr_misc_names[] = {
+	"CceErrInt",		/* 0 */
+	"CceSpcFreezeInt",	/* 1 */
+	"AsicErrInt",		/* 2 */
+	"cfg_vpd_int",		/* 3 */
+	"MctxtCportToPcieInt",	/* 4 */
+	"MctxtPcieToCportInt",	/* 5 */
+	"CportVdmRxInt",	/* 6 */
+	"CportVdmTxInt",	/* 7 */
+	"FlrInt0",		/* 8 */
+	"FlrInt1",		/* 9 */
+	"FlrInt2",		/* 10 */
+	"FlrInt3",		/* 11 */
+	"FlrInt4",		/* 12 */
+	"FlrInt5",		/* 13 */
+	"FlrInt6",		/* 14 */
+	"FlrInt7",		/* 15 */
+};
+
+/* all "various" interrupt source names */
+static const char * const jkr_various_names[] = {
+	"GpioAssertInt",
+	"PcoreResetInt",
+	"app_ltssm_enable_int",
+	"TCritInt",
+};
+
+/* generic routine for returning names from a table */
+static void gen_name(char *buf, size_t bsize, unsigned int source,
+		     const char * const *names, size_t nsize,
+		     const char *detail)
+{
+	if (source < nsize)
+		strscpy(buf, names[source], bsize);
+	else
+		snprintf(buf, bsize, "%s%u (invalid)", detail, source);
+}
+
+static char *jkr_is_misc_name(char *buf, size_t bsize, unsigned int source)
+{
+	gen_name(buf, bsize, source, jkr_misc_names,
+		 ARRAY_SIZE(jkr_misc_names), "MiscInt");
+	return buf;
+}
+
+static char *jkr_is_various_name(char *buf, size_t bsize, unsigned int source)
+{
+	gen_name(buf, bsize, source, jkr_various_names,
+		 ARRAY_SIZE(jkr_various_names), "VariousInt");
+	return buf;
+}
+
+static char *jkr_is_port_name(char *buf, size_t bsize, unsigned int source)
+{
+	/* ports have 8 interrupts each */
+	snprintf(buf, bsize, "Port%uInt%u", source / 8, source % 8);
+	return buf;
+}
+
+static char *jkr_is_pcb_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "PbcInt%u", source);
+	return buf;
+}
+
+static char *jkr_is_pio_err_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "PioErrInt%u", source);
+	return buf;
+}
+
+static char *jkr_is_sdma_err_si_name(char *buf, size_t bsize,
+				     unsigned int source)
+{
+	snprintf(buf, bsize, "SdmaErrSiInt%u", source);
+	return buf;
+}
+
+static char *jkr_is_csr_err_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "CsrErrInt%u", source);
+	return buf;
+}
+
+static char *jkr_is_reserved_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "Reserved%u", source + JKR_IS_RESERVED_START);
+	return buf;
+}
+
+static void jkr_handle_cce_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	dd_dev_warn(dd, "%s: unhandled 0x%016llx\n", __func__, reg);
+}
+
+static void jkr_handle_spc_freeze(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	dd_dev_warn(dd, "%s: unhandled 0x%016llx\n", __func__, reg);
+}
+
+static void jkr_handle_asic_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	dd_dev_warn(dd, "%s: unhandled 0x%016llx\n", __func__, reg);
+}
+
+static void jkr_handle_csr_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	dd_dev_warn(dd, "%s: unhandled 0x%016llx\n", __func__, reg);
+}
+
+/* misc errs that need a clear down are also the first 3 */
+static const struct err_reg_info jkr_misc_errs[] = {
+	EE_N(JKR_CCE_ERR,            jkr_handle_cce_err,    "CceErr"),
+	EE_N(JKR_CCE_SPC_FREEZE_INT, jkr_handle_spc_freeze, "CceSpcFreeze"),
+	EE_N(JKR_ASIC_ERR,           jkr_handle_asic_err,   "AsicErr"),
+};
+
+static const struct err_reg_info jkr_sdma_eng_err =
+	EE_S(JKR_SEND_DMA_ENG_ERR, handle_sdma_eng_err, "SDmaEngErr");
+
+static const struct err_reg_info jkr_send_pio_err =
+	EE_N(JKR_SEND_PIO_ERR, handle_pio_err, "SendPioErr");
+
+static const struct err_reg_info jkr_send_dma_err =
+	EE_N(JKR_SEND_DMA_ERR, handle_sdma_err, "SendDmaErr");
+
+static const struct err_reg_info jkr_csr_err =
+	EE_N(JKR_CSR_ERR, jkr_handle_csr_err, "CsrErr");
+
+static const struct err_reg_info jkr_send_egress_err =
+	EE_E(JKR_SEND_EGRESS_ERR, handle_egress_err, "SendEgressErr");
+
+static const struct err_reg_info jkr_rcv_err =
+	EE_I(JKR_RCV_ERR, handle_rxe_err, "RcvErr");
+
+static void jkr_is_misc_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	char name[64];
+
+	/* jkr_misc_errs[] has all interrupts that need a clear down */
+	if (source < ARRAY_SIZE(jkr_misc_errs)) {
+		interrupt_clear_down(dd, 0, &jkr_misc_errs[source]);
+		return;
+	}
+
+	if (source == JKR_MCTXT_CPORT_TO_PCIE_INT - JKR_IS_GENERAL_ERR_START) {
+		is_cport_int(dd, source);
+		return;
+	}
+
+	dd_dev_err(dd, "unhandled misc interrupt %s\n",
+		   jkr_is_misc_name(name, sizeof(name), source));
+}
+
+static void jkr_is_sdma_eng_err_int(struct hfi2_devdata *dd,
+				    unsigned int source)
+{
+	interrupt_clear_down(dd, source, &jkr_sdma_eng_err);
+}
+
+static void jkr_is_various_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	char name[64];
+
+	if (source == 3) { /* "TCritInt" */
+		handle_temp_err(dd);
+		return;
+	}
+
+	/* not expecting any other various interrupts */
+	dd_dev_err(dd, "unhandled various interrupt %s\n",
+		   jkr_is_various_name(name, sizeof(name), source));
+}
+
+static void jkr_is_port_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	char name[64];
+	u32 pidx = source / 8; /* port interrupts are in groups of 8 */
+	u32 which = source % 8;
+
+	if (which == 4) { /* send egress errors */
+		interrupt_clear_down(dd, pidx, &jkr_send_egress_err);
+		return;
+	}
+	if (which == 5) { /* receive errors */
+		interrupt_clear_down(dd, pidx, &jkr_rcv_err);
+		return;
+	}
+
+	dd_dev_err(dd, "unhandled port interrupt %s\n",
+		   jkr_is_port_name(name, sizeof(name), source));
+}
+
+static void jkr_is_pcb_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	char name[64];
+
+	/*
+	 * This is a per-send context interrupt.  It is called if the PbcIntr
+	 * bit is set on a context's PIO PBC and the packet has completely
+	 * cleared the send buffer.
+	 *
+	 * Presently, the PbcIntr bit is never set.
+	 */
+	dd_dev_err(dd, "unhandled pcb interrupt %s\n",
+		   jkr_is_pcb_name(name, sizeof(name), source));
+}
+
+static void jkr_is_pio_err_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	/* this is a per-SI interrupt */
+	interrupt_clear_down(dd, 0, &jkr_send_pio_err);
+}
+
+static void jkr_is_sdma_err_si_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	/* this is a per-SI interrupt */
+	interrupt_clear_down(dd, 0, &jkr_send_dma_err);
+}
+
+static void jkr_is_csr_err_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	/* this is a per-SI interrupt */
+	interrupt_clear_down(dd, 0, &jkr_csr_err);
+}
+
+static void jkr_is_reserved_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	char name[64];
+
+	dd_dev_err(dd, "unhandled reserved interrupt %s\n",
+		   jkr_is_reserved_name(name, sizeof(name), source));
+}
+
+const struct is_table jkr_is_table[] = {
+/*
+ * start			end
+ *		name func			interrupt func
+ */
+{ JKR_IS_GENERAL_ERR_START,	JKR_IS_GENERAL_ERR_END,
+		jkr_is_misc_name,		jkr_is_misc_int },
+{ JKR_IS_SDMAENG_ERR_START,	JKR_IS_SDMAENG_ERR_END,
+		is_sdma_eng_err_name,		jkr_is_sdma_eng_err_int },
+{ JKR_IS_SENDCTXT_ERR_START,	JKR_IS_SENDCTXT_ERR_END,
+		is_sendctxt_err_name,		is_sendctxt_err_int },
+{ JKR_IS_SDMA_START,		JKR_IS_SDMA_IDLE_END,
+		is_sdma_eng_name,		is_sdma_eng_int },
+{ JKR_IS_VARIOUS_START,		JKR_IS_VARIOUS_END,
+		jkr_is_various_name,		jkr_is_various_int },
+{ JKR_IS_PORT_START,		JKR_IS_PORT_END,
+		jkr_is_port_name,		jkr_is_port_int },
+{ JKR_IS_RCVAVAIL_START,	JKR_IS_RCVAVAIL_END,
+		is_rcv_avail_name,		is_rcv_avail_int },
+{ JKR_IS_RCVURGENT_START,	JKR_IS_RCVURGENT_END,
+		is_rcv_urgent_name,		is_rcv_urgent_int },
+{ JKR_IS_SENDCREDIT_START,	JKR_IS_SENDCREDIT_END,
+		is_send_credit_name,		is_send_credit_int},
+{ JKR_IS_PBC_START,		JKR_IS_PBC_END,
+		jkr_is_pcb_name,		jkr_is_pcb_int},
+{ JKR_IS_PIO_ERR_START,		JKR_IS_PIO_ERR_END,
+		jkr_is_pio_err_name,		jkr_is_pio_err_int},
+{ JKR_IS_SDMA_ERR_SI_START,	JKR_IS_SDMA_ERR_SI_END,
+		jkr_is_sdma_err_si_name,	jkr_is_sdma_err_si_int},
+{ JKR_IS_CSR_ERR_START,		JKR_IS_CSR_ERR_END,
+		jkr_is_csr_err_name,		jkr_is_csr_err_int},
+{ JKR_IS_RESERVED_START,	JKR_IS_RESERVED_END,
+		jkr_is_reserved_name,		jkr_is_reserved_int},
+{ 0, 0, 0, 0 } /* terminator */
+};
+
+/*
+ * General interrupt sources to enable.  This is all sources but SDMA
+ * (SdmaEngErr, Sdma, SdmaProgress, SdmaIdle), and Receive (RcvAvail,
+ * RcvUrgent). MctxtCportToPcieInt is enabled separately.
+ */
+const struct gi_enable_entry jkr_gi_enable_table[] = {
+	{ JKR_IS_GENERAL_ERR_START, JKR_ASIC_ERR_INT },
+	{ JKR_IS_SENDCTXT_ERR_START, JKR_IS_SENDCTXT_ERR_END },
+	{ JKR_IS_VARIOUS_START, JKR_IS_VARIOUS_END },
+	{ JKR_IS_PORT_START, JKR_IS_PORT_END },
+	{ JKR_IS_SENDCREDIT_START, JKR_IS_SENDCREDIT_END },
+	{ JKR_IS_PBC_START, JKR_IS_PBC_END },
+	{ JKR_IS_PIO_ERR_START, JKR_IS_PIO_ERR_END },
+	{ JKR_IS_SDMA_ERR_SI_START, JKR_IS_SDMA_ERR_SI_END },
+	{ JKR_IS_CSR_ERR_START, JKR_IS_CSR_ERR_END },
+	{ 1, 0 } /* terminator */
+};
+
+void jkr_set_port_tid_config(struct hfi2_devdata *dd, int pidx, u16 ctxt,
+			     u32 eager_base, u16 alloced,
+			     u32 expected_base, u32 expected_count)
+{
+	u64 reg;
+
+	if (dd->is_vf) {
+		vf2pf_tid_config(dd, pidx, ctxt, eager_base, alloced,
+				 expected_base, expected_count);
+		return;
+	}
+	/* set eager count and base index */
+	reg = ((u64)(alloced >> RCV_SHIFT) << RCV_EGR_CTRL_EGR_CNT_SHIFT) |
+	      ((eager_base >> RCV_SHIFT) << RCV_EGR_CTRL_EGR_BASE_INDEX_SHIFT);
+	write_rctxt_csr(dd, ctxt, dd->params->rcv_egr_ctrl_reg, reg);
+
+	/*
+	 * Set TID (expected) count and base index.
+	 * rcd->expected_count is set to individual RcvArray entries,
+	 * not pairs, and the CSR takes a pair-count in groups of
+	 * four, so divide by 8.
+	 */
+	reg = ((u64)(expected_count >> RCV_SHIFT) << RCV_TID_CTRL_TID_PAIR_CNT_SHIFT) |
+	      ((expected_base >> RCV_SHIFT) << RCV_TID_CTRL_TID_BASE_INDEX_SHIFT);
+	write_rctxt_csr(dd, ctxt, dd->params->rcv_tid_ctrl_reg, reg);
+
+	/*
+	 * Value must match value written into RcvTidCtrl.TidPairCnt.  See
+	 * hfi2_rcvctrl() write to rcv_tid_ctrl_reg.
+	 */
+	reg = (u64)(expected_count >> RCV_SHIFT);
+	write_iprc_csr(dd, pidx, ctxt, JKR_RCV_TID_PAIR_COUNT, reg);
+	if (dd->is_sriov && pidx < dd->num_pports)
+		write_iprc_csr(dd, loopback_pidx_dd(dd, pidx),
+			       ctxt, JKR_RCV_TID_PAIR_COUNT, reg);
+}
+
+static inline u32 rcvarray_offset(u32 ctxt, u32 index, u32 type)
+{
+	return (type == PT_EAGER ? 0 : BIT(JKR_RCV_ARRAY_EGR_TID_SELECT_SHIFT))
+	       | (ctxt_bar_ctxt(ctxt) << JKR_RCV_ARRAY_RCV_CTXT_IDX_SHIFT)
+	       | (index << JKR_RCV_ARRAY_CSR_INDEX_SHIFT);
+}
+
+static inline u8 __iomem *rcvarray_addr(struct hfi2_devdata *dd, u32 ctxt,
+					u32 index, u32 type)
+{
+	return dd->bar_maps[ctxt_bar_idx(ctxt)].rcvarray_wc + rcvarray_offset(ctxt, index, type);
+}
+
+/*
+ * Update a TID entry of a given receive context.
+ *
+ * @rcd	  Receive context being updated.
+ * @index When type is PT_EAGER or PT_EXPECTED, index is the index into the
+ *	  receive array _relative_ to how the context is set up.
+ * @pa	  Physical DMA address.  If invalidating, this should be zero.
+ * @order Order of map.  If invalidating, this should be zero.
+ * @flush Forced flush.  Otherwise, will flush on eager or on 32-byte boundary.
+ */
+void jkr_put_tid(struct hfi2_ctxtdata *rcd, u32 index,
+		 u32 type, unsigned long pa, u16 order, bool flush)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+	u64 reg;
+	u8 __iomem *addr;
+
+	if (!(dd->flags & HFI2_PRESENT))
+		return;
+
+	trace_hfi2_put_tid(dd, index, type, pa, order);
+	addr = rcvarray_addr(dd, rcd->ctxt, index, type);
+
+#define RT_ADDR_SHIFT 12	/* 4KB kernel address boundary */
+	/* eager and expected have the same layout */
+	reg =   RCV_ARRAY_RT_WRITE_ENABLE_SMASK
+	      | ((u64)order << JKR_RCV_ARRAY_EGR_RT_BUF_SIZE_SHIFT)
+	      | (pa >> RT_ADDR_SHIFT);
+	trace_hfi2_write_rcvarray(addr, reg);
+	writeq(reg, addr);
+
+	if (type == PT_EAGER || flush || (index & 3) == 3)
+		flush_wc();
+}
+
+/*
+ * Write an "no-op" RcvArray entry.
+ *
+ * Called by the TID registration code to write to unused/unneeded RcvArray
+ * entries to fill out a write-combining buffer line.  The HFI will ignore this
+ * write to the RcvArray entry.
+ */
+void jkr_rcv_array_wc_fill(struct hfi2_ctxtdata *rcd, u32 index, u32 type)
+{
+	u8 __iomem *addr = rcvarray_addr(rcd->dd, rcd->ctxt, index, type);
+
+	writeq(0, addr);
+	if ((index & 3) == 3)
+		flush_wc();
+}
+
+void jkr_ena_rcv_ctxt(struct hfi2_devdata *dd, u8 pidx, u16 ctxt, bool enable)
+{
+	u64 bits = JKR_RCV_PKT_CTRL_RCV_PORT_ENABLE_SMASK |
+		   JKR_RCV_PKT_CTRL_CONTEXT_ENABLED_SMASK;
+	u64 reg;
+
+	reg = read_iprc_csr(dd, pidx, ctxt, JKR_RCV_PKT_CTRL);
+	/* always clear the L2TypeEnable field */
+	reg &= ~JKR_RCV_PKT_CTRL_L2_TYPE_ENABLE_MASK_SMASK;
+	if (enable) {
+		/* allow 16B and 9B L2 */
+		reg |= bits |
+		       (0xcull << JKR_RCV_PKT_CTRL_L2_TYPE_ENABLE_MASK_SHIFT);
+	} else {
+		reg &= ~bits;
+	}
+	write_iprc_csr(dd, pidx, ctxt, JKR_RCV_PKT_CTRL, reg);
+}
+
+void jkr_upd_rcv_hdr_size(struct hfi2_devdata *dd, u8 pidx, u16 ctxt, u32 size)
+{
+	u64 reg;
+
+	reg = read_iprc_csr(dd, pidx, ctxt, JKR_RCV_PKT_CTRL);
+	reg &= ~JKR_RCV_PKT_CTRL_HDR_SIZE_SMASK;
+	reg |= (u64)size << JKR_RCV_PKT_CTRL_HDR_SIZE_SHIFT;
+	write_iprc_csr(dd, pidx, ctxt, JKR_RCV_PKT_CTRL, reg);
+}
+
+/* chip specific rcv context enable, disable */
+void jkr_enable_rcv_context(struct hfi2_pportdata *ppd, u16 ctxt,
+			    u64 *kctxt_ctrl, bool enable)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+
+	priv_reg_op(dd, ppd->hw_pidx, ctxt, 0, RC_ENABLE_OP, enable);
+
+	/* adjustments to KctxtCtrl */
+	if (enable)
+		*kctxt_ctrl |= JKR_RCV_KCTXT_CTRL_RECEIVE_CUT_THROUGH_DISABLE_SMASK;
+}
+
+void jkr_update_rcv_hdr_size(struct hfi2_pportdata *ppd, u16 ctxt, u32 size)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+
+	priv_reg_op(dd, ppd->hw_pidx, ctxt, 0, RC_HEADER_OP, size);
+}
+
+void jkr_set_rheq_addr(struct hfi2_devdata *dd, u16 ctxt, u64 dma_addr)
+{
+	write_kctxt_csr(dd, ctxt, JKR_RCV_ERR_ADDR, dma_addr);
+}
+
+bool jkr_check_synth_status(struct hfi2_devdata *dd)
+{
+	return false;
+}
+
+void jkr_update_synth_status(struct hfi2_devdata *dd)
+{
+}
+
+#define FLAG_ENTRY1(flag, str) { flag, str, 0 }
+const struct flag_table jkr_egress_err_info_flags[] = {
+	FLAG_ENTRY1(BIT_ULL(62), "PbcTestErr"),
+	FLAG_ENTRY1(BIT_ULL(61), "RawIPv6Err"),
+	FLAG_ENTRY1(BIT_ULL(60), "RawErr"),
+	FLAG_ENTRY1(BIT_ULL(59), "AgeCspecErr9B"),
+	FLAG_ENTRY1(BIT_ULL(58), "AgeCspecErr16B"),
+	FLAG_ENTRY1(BIT_ULL(57), "GRHErr9B"),
+	FLAG_ENTRY1(BIT_ULL(56), "GRHErr16B"),
+	FLAG_ENTRY1(BIT_ULL(55), "SdmaMemSpaceErr9B"),
+	FLAG_ENTRY1(BIT_ULL(54), "SdmaMemSpaceErr16B"),
+	FLAG_ENTRY1(BIT_ULL(53), "SdmaMemSpaceErr10B"),
+	FLAG_ENTRY1(BIT_ULL(52), "SdmaMemSpaceErr8B"),
+	FLAG_ENTRY1(BIT_ULL(51), "DisallowedPortErr9B"),
+	FLAG_ENTRY1(BIT_ULL(50), "DisallowedPortErr16B"),
+	FLAG_ENTRY1(BIT_ULL(49), "DisallowedPortErr10B"),
+	FLAG_ENTRY1(BIT_ULL(48), "DisallowedPortErr8B"),
+	FLAG_ENTRY1(BIT_ULL(47), "BadPktLenErr9B"),
+	FLAG_ENTRY1(BIT_ULL(46), "BadPktLenErr16B"),
+	FLAG_ENTRY1(BIT_ULL(45), "BadPktLenErr10B"),
+	FLAG_ENTRY1(BIT_ULL(44), "BadPktLenErr8B"),
+	FLAG_ENTRY1(BIT_ULL(43), "NonKDETHPacketErr9B"),
+	FLAG_ENTRY1(BIT_ULL(42), "NonKDETHPacketErr16B"),
+	FLAG_ENTRY1(BIT_ULL(41), "NonKDETHPacketErr10B"),
+	FLAG_ENTRY1(BIT_ULL(40), "NonKDETHPacketErr8B"),
+	FLAG_ENTRY1(BIT_ULL(39), "KDETHPacketErr9B"),
+	FLAG_ENTRY1(BIT_ULL(38), "KDETHPacketErr16B"),
+	FLAG_ENTRY1(BIT_ULL(37), "KDETHPacketErr10B"),
+	FLAG_ENTRY1(BIT_ULL(36), "KDETHPacketErr8B"),
+	FLAG_ENTRY1(BIT_ULL(35), "TooLongPacketErr9B"),
+	FLAG_ENTRY1(BIT_ULL(34), "TooLongPacketErr16B"),
+	FLAG_ENTRY1(BIT_ULL(33), "TooLongPacketErr10B"),
+	FLAG_ENTRY1(BIT_ULL(32), "TooLongPacketErr8B"),
+	FLAG_ENTRY1(BIT_ULL(31), "TooSmallPacketErr9B"),
+	FLAG_ENTRY1(BIT_ULL(30), "TooSmallPacketErr16B"),
+	FLAG_ENTRY1(BIT_ULL(29), "TooSmallPacketErr10B"),
+	FLAG_ENTRY1(BIT_ULL(28), "TooSmallPacketErr8B"),
+	FLAG_ENTRY1(BIT_ULL(27), "VLMappingErr9B"),
+	FLAG_ENTRY1(BIT_ULL(26), "VLMappingErr16B"),
+	FLAG_ENTRY1(BIT_ULL(25), "VLMappingErr10B"),
+	FLAG_ENTRY1(BIT_ULL(24), "VLMappingErr8B"),
+	FLAG_ENTRY1(BIT_ULL(23), "OpcodeErr9B"),
+	FLAG_ENTRY1(BIT_ULL(22), "OpcodeErr16B"),
+	FLAG_ENTRY1(BIT_ULL(21), "OpcodeErr10B"),
+	FLAG_ENTRY1(BIT_ULL(20), "OpcodeErr8B"),
+	FLAG_ENTRY1(BIT_ULL(19), "SLIDErr9B"),
+	FLAG_ENTRY1(BIT_ULL(18), "SLIDErr16B"),
+	FLAG_ENTRY1(BIT_ULL(17), "SLIDErr10B"),
+	FLAG_ENTRY1(BIT_ULL(16), "SLIDErr8B"),
+	FLAG_ENTRY1(BIT_ULL(15), "PartitionKeyErr9B"),
+	FLAG_ENTRY1(BIT_ULL(14), "PartitionKeyErr16B"),
+	FLAG_ENTRY1(BIT_ULL(13), "PartitionKeyErr10B"),
+	FLAG_ENTRY1(BIT_ULL(12), "PartitionKeyErr8B"),
+	FLAG_ENTRY1(BIT_ULL(11), "JobKeyErr9B"),
+	FLAG_ENTRY1(BIT_ULL(10), "JobKeyErr16B"),
+	FLAG_ENTRY1(BIT_ULL(9), "JobKeyErr10B"),
+	FLAG_ENTRY1(BIT_ULL(8), "JobKeyErr8B"),
+	FLAG_ENTRY1(BIT_ULL(7), "VLErr9B"),
+	FLAG_ENTRY1(BIT_ULL(6), "VLErr16B"),
+	FLAG_ENTRY1(BIT_ULL(5), "VLErr10B"),
+	FLAG_ENTRY1(BIT_ULL(4), "VLErr8B"),
+	FLAG_ENTRY1(BIT_ULL(3), "L2TypeErr9B"),
+	FLAG_ENTRY1(BIT_ULL(2), "L2TypeErr16B"),
+	FLAG_ENTRY1(BIT_ULL(1), "L2TypeErr10B"),
+	FLAG_ENTRY1(BIT_ULL(0), "L2TypeErr8B"),
+};
+
+const struct flag_data jkr_egress_err_info_data = {
+	.table = jkr_egress_err_info_flags,
+	.size = ARRAY_SIZE(jkr_egress_err_info_flags),
+};
+
+/* send context base integrity checks */
+#define SC_BASE_CHECKS (0 \
+	/* 9B */ \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BTOO_LONG_PACKET_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BTOO_SMALL_PACKETS_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BBAD_PKT_LEN_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BRAW_IPV6_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BRAW_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BPBC_TEST_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BVL_MAPPING_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BOPCODE_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BSLID_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BJOB_KEY_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BVL_SMASK \
+	/* 16B */ \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BTOO_LONG_PACKET_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BTOO_SMALL_PACKETS_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BBAD_PKT_LEN_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BRAW_IPV6_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BRAW_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BPBC_TEST_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BVL_MAPPING_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BSLID_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BJOB_KEY_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BVL_SMASK \
+	)
+
+/* send context user integrity checks */
+#define SC_USER_CHECKS (0 \
+	/* 9B */ \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BNON_KDETH_PACKETS_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BGRH_SMASK \
+	/* 16B */ \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BNON_KDETH_PACKETS_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BGRH_SMASK \
+	)
+
+/* send context kernel integrity checks */
+#define SC_KERNEL_CHECKS (0 \
+	/* 9B */ \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BKDETH_PACKETS_SMASK \
+	/* 16B */ \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BKDETH_PACKETS_SMASK \
+	)
+
+static void jkr_set_pio_integ(struct hfi2_devdata *dd, u32 pidx, u32 hw_context, int type,
+			      enum spi_cmds cmd)
+{
+	u64 val;
+
+	/* DEFAULT does not do a read-modify-write */
+	if (cmd == SPI_DEFAULT) {
+		/* allow 9B and 16B packets, no checking */
+		val =   JKR_SEND_CTXT_CHECK_ENABLE_L2_TYPE9BALLOWED_SMASK
+		      | JKR_SEND_CTXT_CHECK_ENABLE_L2_TYPE16BALLOWED_SMASK;
+	} else {
+		val = read_epsc_csr(dd, pidx, hw_context,
+				    dd->params->send_ctxt_check_enable_reg);
+	}
+
+	switch (cmd) {
+	case SPI_DEFAULT:
+		/* No integrity checks if HFI2_CAP_NO_INTEGRITY is set */
+		if (HFI2_CAP_IS_KSET(NO_INTEGRITY))
+			break;
+		val |= SC_BASE_CHECKS;
+		if (type == SC_USER)
+			val |= SC_USER_CHECKS;
+		else if (type != SC_KERNEL)
+			val |= SC_KERNEL_CHECKS;
+		break;
+	case SPI_INIT:
+		/* no checks to set/clear */
+		break;
+	case SPI_SET_JKEY:
+		val |= JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BJOB_KEY_SMASK |
+			JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BJOB_KEY_SMASK;
+		break;
+	case SPI_CLEAR_JKEY:
+		val &= ~(JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BJOB_KEY_SMASK |
+		         JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BJOB_KEY_SMASK);
+		break;
+	case SPI_SET_PKEY:
+		val |= JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BPARTITION_KEY_SMASK |
+		       JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BPARTITION_KEY_SMASK;
+
+		val &= ~(JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BKDETH_PACKETS_SMASK |
+			 JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BKDETH_PACKETS_SMASK);
+		break;
+	case SPI_CLEAR_PKEY:
+		val &= ~(JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BPARTITION_KEY_SMASK |
+			 JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BPARTITION_KEY_SMASK);
+		break;
+	}
+	write_epsc_csr(dd, pidx, hw_context,
+		       dd->params->send_ctxt_check_enable_reg, val);
+
+}
+
+void jkr_set_pio_integrity(struct hfi2_devdata *dd, u32 pidx, u32 hw_context, int type,
+			   enum spi_cmds cmd)
+{
+	jkr_set_pio_integ(dd, pidx, hw_context, type, cmd);
+	if (dd->is_sriov)
+		jkr_set_pio_integ(dd, loopback_pidx_dd(dd, pidx), hw_context, type, cmd);
+}
+
+void jkr_read_link_quality(struct hfi2_pportdata *ppd, u8 *link_quality)
+{
+	*link_quality = 5; /* best */
+}
+
+void jkr_handle_link_bounce(struct work_struct *work)
+{
+	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
+							link_bounce_work);
+	struct hfi2_devdata *dd = ppd->dd;
+
+	dd_dev_warn(dd, "%s: not implemented\n", __func__);
+}
diff --git a/drivers/infiniband/hw/hfi2/sriov.c b/drivers/infiniband/hw/hfi2/sriov.c
new file mode 100644
index 000000000000..3a937a81f07d
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/sriov.c
@@ -0,0 +1,440 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ *
+ * SR-IOV related functions and variables.
+ */
+
+#include <linux/pci.h>
+
+#include "hfi2.h"
+#include "sriov.h"
+#include "chip_jkr.h"
+#include "chip_gen.h"
+#include "vf2pf.h"
+
+#define HFI_SRIOV_DEBUG
+#define HFI_SRIOV_BRINGUP
+#define HFI_SRIOV_MOD_PARAMS	/* use module params to define SRIOV config */
+#undef HFI_SRIOV_AUTO_CONF	/* automatically enable SRIOV if max_num_vfs > 0 */
+
+bool sriov_auto; /* might default to 'true' in the future */
+module_param_named(sriov_auto, sriov_auto, bool, 0644);
+MODULE_PARM_DESC(sriov_auto, "Start SRIOV automatically, default N (off)");
+
+#ifdef HFI_SRIOV_BRINGUP
+bool vf_test;
+module_param_named(vf_test, vf_test, bool, 0644);
+MODULE_PARM_DESC(vf_test, "Enable host VF PCI device, default N (off)");
+
+bool vf_claim;
+module_param_named(vf_claim, vf_claim, bool, 0644);
+MODULE_PARM_DESC(vf_claim, "Claim VF PCI devices on host");
+#endif
+
+#ifdef HFI_SRIOV_MOD_PARAMS
+static uint si_idx;
+static uint max_num_vfs;
+static uint ctxt_per_vf; /* send/recv use same number */
+static uint sdma_per_vf;
+static uint rcv_per_vf;
+static uint pio_per_vf;
+
+/* all of these are fixed at driver load */
+module_param_named(si_idx, si_idx, uint, 0444);
+module_param_named(max_num_vfs, max_num_vfs, uint, 0444);
+module_param_named(ctxt_per_vf, ctxt_per_vf, uint, 0444);
+module_param_named(sdma_per_vf, sdma_per_vf, uint, 0444);
+module_param_named(rcv_per_vf, rcv_per_vf, uint, 0444);
+module_param_named(pio_per_vf, pio_per_vf, uint, 0444);
+
+MODULE_PARM_DESC(si_idx, "The SiIdx that this driver represents");
+MODULE_PARM_DESC(max_num_vfs, "Allow SRIOV and specify max num VFs");
+MODULE_PARM_DESC(ctxt_per_vf, "Number of send/recv contexts per VF");
+MODULE_PARM_DESC(sdma_per_vf, "Number of SEDMA engines per VF");
+MODULE_PARM_DESC(rcv_per_vf, "Number of RcvArray blocks per VF");
+MODULE_PARM_DESC(pio_per_vf, "Number of PIO blocks (credits) per VF");
+#endif
+
+#define HFI_MIN_PF0_CONTEXTS	32	/* includes max used by CPORT */
+#define HFI_MIN_PF0_SDE		2
+
+/*
+ * Only called on PF0, but possibly on behalf of VF.
+ *
+ * 'dd' is the PF0, 'out' is the target based on 'si'.
+ * 'out' is assumed to be uninitialized.
+ */
+int sriov_get_config(struct hfi2_devdata *dd, struct hfi2_devrsrcs *out, int si)
+{
+	u32 num_ctxt, pf0_ctxts, vf2pf_ctxts;
+	u32 num_sdma;
+	u32 num_rcvary;
+	u32 num_pio;
+	int num_vfs = 0;
+	int num;
+
+#ifdef HFI_SRIOV_MOD_PARAMS
+	num_vfs = max_num_vfs;
+#endif
+	/* TODO: other methods of SRIOV config... */
+
+	if (!num_vfs)
+		return -ENODEV;
+
+	if (si > JKR_C_CCE_NUM_VFS || num_vfs > JKR_C_CCE_NUM_VFS)
+		return -EINVAL;
+
+#ifdef HFI_SRIOV_MOD_PARAMS
+	/*
+	 * Assumes #send contexts == #recv contexts, uses #recv
+	 * as the limit since #send might be larger in the future.
+	 */
+	vf2pf_ctxts = vf2pf_num_ctxts(dd);
+	num_ctxt = chip_rcv_contexts(dd) - vf2pf_ctxts;
+	num_sdma = chip_sdma_engines(dd);
+	num_rcvary = chip_rcv_array_count(dd) - HFI_MIN_PF0_RCVARY(vf2pf_ctxts);
+	num_pio = chip_pio_mem_size(dd) / PIO_BLOCK_SIZE - HFI_MIN_PF0_PIO(vf2pf_ctxts);
+
+	/*
+	 * Automatically adjust excessive values and set defaults for '0'.
+	 * This may not work well if adapters of different architecture are
+	 * installed (and having SRIOV capability).
+	 */
+	if (!ctxt_per_vf)
+		ctxt_per_vf = (num_ctxt - HFI_MIN_PF0_CONTEXTS) / max_num_vfs;
+	if (ctxt_per_vf * max_num_vfs > num_ctxt - HFI_MIN_PF0_CONTEXTS) {
+		ctxt_per_vf = (num_ctxt - HFI_MIN_PF0_CONTEXTS) / max_num_vfs;
+		dd_dev_info(dd, "Reducing ctxt_per_vf to %d\n", ctxt_per_vf);
+	}
+	pf0_ctxts = num_ctxt - ctxt_per_vf * max_num_vfs;
+
+	if (!sdma_per_vf)
+		sdma_per_vf = (num_sdma - HFI_MIN_PF0_SDE) / max_num_vfs;
+	if (!rcv_per_vf)
+		rcv_per_vf = (num_rcvary - HFI_MIN_PF0_RCVARY(pf0_ctxts)) / max_num_vfs;
+	if (!pio_per_vf)
+		pio_per_vf = (num_pio - HFI_MIN_PF0_PIO(pf0_ctxts)) / max_num_vfs;
+
+	if (sdma_per_vf * max_num_vfs > num_sdma - HFI_MIN_PF0_SDE) {
+		sdma_per_vf = (num_sdma - HFI_MIN_PF0_SDE) / max_num_vfs;
+		dd_dev_info(dd, "Reducing sdma_per_vf to %d\n", sdma_per_vf);
+	}
+	if (rcv_per_vf * max_num_vfs > num_rcvary - HFI_MIN_PF0_RCVARY(pf0_ctxts)) {
+		rcv_per_vf = (num_rcvary - HFI_MIN_PF0_RCVARY(pf0_ctxts)) / max_num_vfs;
+		dd_dev_info(dd, "Reducing rcv_per_vf to %d\n", rcv_per_vf);
+	}
+	if (pio_per_vf * max_num_vfs > num_pio - HFI_MIN_PF0_PIO(pf0_ctxts)) {
+		pio_per_vf = (num_pio - HFI_MIN_PF0_PIO(pf0_ctxts)) / max_num_vfs;
+		dd_dev_info(dd, "Reducing pio_per_vf to %d\n", pio_per_vf);
+	}
+
+	out->num_vfs = max_num_vfs;
+	out->si_idx = si;
+	out->pfunit = dd->unit;
+	/* si_idx == 0 implies PF0, which decides all VF resources */
+
+	num = si ? si : max_num_vfs + 1; /* never 0 */
+	out->c.first_send_context = si ? num_ctxt - num * ctxt_per_vf : 0;
+	out->c.last_send_context = num_ctxt - (num - 1) * ctxt_per_vf;
+	out->c.first_rcv_context = si ? num_ctxt - num * ctxt_per_vf : 0;
+	out->c.last_rcv_context = num_ctxt - (num - 1) * ctxt_per_vf;
+	out->first_sdma_engine = si ? num_sdma - num * sdma_per_vf : 0;
+	out->last_sdma_engine = num_sdma - (num - 1) * sdma_per_vf;
+	out->c.first_rcvarray_entry = si ? num_rcvary - num * rcv_per_vf : 0;
+	out->c.last_rcvarray_entry = num_rcvary - (num - 1) * rcv_per_vf;
+	out->c.first_pio_block = si ? num_pio - num * pio_per_vf : 0;
+	out->c.last_pio_block = num_pio - (num - 1) * pio_per_vf;
+#endif
+	return 0;
+}
+
+/*
+ * If SRIOV is allowed (max_num_vfs > 0) then divide up
+ * resources according to heuristics or limits. The rest of the driver
+ * init should use these parameters, if available (dd->rsrcs.num_vfs != 0).
+ * Note that the driver can no longer assume a resource begins at "0".
+ */
+int hfi2_sriov_set_cfg(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	if (dd->params->chip_type == CHIP_WFR)
+		return 0;
+	/* prior call to hfi2_sriov_set_si() must have succeeded */
+	if (dd->is_vf) {
+		ret = vf2pf_get_config(dd, &dd->rsrcs, dd->rsrcs.si_idx);
+		return ret;
+	}
+	if (!sriov_is_enabled())
+		return 0;
+
+	ret = sriov_get_config(dd, &dd->rsrcs, 0);
+	return ret;
+}
+
+int hfi2_sriov_set_si(struct hfi2_devdata *dd)
+{
+	int si = 0; /* assume PF0 to start */
+
+	if (!dd->is_vf)
+		goto out_set;
+
+	si = si_idx;
+	if (!si) {
+		if (dd->is_vm)
+			si = vf2pf_probe_si(dd); /* hope for the best */
+		else
+			/* TODO: need to adjust for CYR? does pci_iov already do that? */
+			si = pci_iov_vf_id(dd->pcidev) + 1;
+	}
+	if (!si) {
+		dd_dev_err(dd, "Cannot determine device SI\n");
+		return -ENXIO;
+	}
+out_set:
+	dd->rsrcs.si_idx = si;
+	return 0;
+}
+
+/*
+ * Sets the SiIdx CSRs of contrexts and SDMA engines for
+ * VF1..VFn based on data passed in 'dr'.
+ *
+ * Only PF0 can access the SiIdx CSRS, so any other callers
+ * just return success.
+ *
+ * Called on behalf of a VF when it makes first contact with PF0.
+ */
+int hfi2_sriov_assign_rsrcs(struct hfi2_devdata *dd, struct hfi2_devrsrcs *dr)
+{
+	int x;
+
+	if (dd->is_vf)
+		return vf2pf_assign_rsrcs(dd, dr);
+
+	/* Only valid on PF0, if SRIOV is allowed */
+	if (!dd->rsrcs.num_vfs || dd->rsrcs.si_idx)
+		return 0;
+
+	/*
+	 * In theory, resources allocated to PF0 never need to have their
+	 * SiIdx written.
+	 */
+	if (!dr->si_idx)
+		return 0;
+
+	for (x = dr->c.first_send_context; x < dr->c.last_send_context; ++x)
+		write_tctxt_csr(dd, x, JKR_SEND_CTXT_SI_IDX, dr->si_idx);
+	for (x = dr->c.first_rcv_context; x < dr->c.last_rcv_context; ++x)
+		write_rctxt_csr(dd, x, JKR_RCV_SI_IDX, dr->si_idx);
+	for (x = dr->first_sdma_engine; x < dr->last_sdma_engine; ++x)
+		write_sdmacfg_csr(dd, x, JKR_SEND_DMA_CFG_SI_IDX, dr->si_idx);
+	return 0;
+}
+
+/*
+ * Resets the SiIdx CSRs of contrexts and SDMA engines for
+ * VF1..VFn back to PF0.
+ *
+ * Only PF0 can access the SiIdx CSRS, so any other callers
+ * just return success.
+ *
+ * Called on behalf of a VF when it disconnects with PF0.
+ */
+void hfi2_sriov_free_rsrcs(struct hfi2_devdata *dd, struct hfi2_devrsrcs *dr)
+{
+	int x;
+
+	if (dd->is_vf) {
+		vf2pf_free_rsrcs(dd, dr);
+		return;
+	}
+	/* Only valid on PF0, if SRIOV is allowed */
+	if (!dd->rsrcs.num_vfs || dd->rsrcs.si_idx)
+		return;
+
+	/*
+	 * In theory, resources allocated to PF0 never need to have their
+	 * SiIdx written.
+	 */
+	if (!dr->si_idx)
+		return;
+
+	for (x = dr->c.first_send_context; x < dr->c.last_send_context; ++x)
+		write_tctxt_csr(dd, x, JKR_SEND_CTXT_SI_IDX, 0);
+	for (x = dr->c.first_rcv_context; x < dr->c.last_rcv_context; ++x)
+		write_rctxt_csr(dd, x, JKR_RCV_SI_IDX, 0);
+	for (x = dr->first_sdma_engine; x < dr->last_sdma_engine; ++x)
+		write_sdmacfg_csr(dd, x, JKR_SEND_DMA_CFG_SI_IDX, 0);
+}
+
+/*
+ * Free all SRIOV configuration resources. Called during
+ * driver unload.
+ *
+ * Resets SiIdx CSRs as well as freeing memory.
+ */
+void hfi2_sriov_free_cfg(struct hfi2_devdata *dd)
+{
+	/* On PF0, set all SiIdx back to 0 */
+	hfi2_sriov_free_rsrcs(dd, &dd->rsrcs);
+}
+
+/* NOTE:
+ * There are three types of PCI devices when using SRIOV and VMs:
+ *	in host OS, there is the PF0 pci_dev (pdev->is_physfn != 0)
+ *	in host OS, there is the VFx pci_dev (pdev->is_virtfn != 0)
+ *		(this will never have a 'dd'?)
+ *	in guest OS, there is the VFx pci_dev (PCI_FUNC(pdev->devfn) != 0?)
+ *		(what do pdev->is_physfn and pdev->is_virtfn mean?
+ *		since pdev->physfn cannot be valid - nor pdev->sriov?)
+ *		(this needs to have a 'dd' but handled different)
+ *
+ * TODO: how to determine whether we're host or guest?!
+ *	PCI_FUNC(pdev->devfn) != 0 && !pdev->is_virtfn for guest VFs?
+ *
+ * TODO: does PCI_FUNC() need to be something different if ARI is active?
+ */
+
+int sriov_is_enabled(void)
+{
+#ifdef HFI_SRIOV_MOD_PARAMS
+	return max_num_vfs > 0;
+#else
+	/* TODO: how to determine SRIOV is allowed */
+	return 0;
+#endif
+}
+
+/*
+ * This initializes the host VF PCI device - not SRIOV from PF0.
+ *
+ * Normally, the VF devices will be pass-through to VMs, in which
+ * case the host driver does not want to claim the device.
+ * TODO: Does KVM (virtsh) tolerate the driver claiming the VF,
+ * by calling the remove_one() function when assigning the device
+ * to the guest? If so, we can go ahead and claim the device here,
+ * however that will cause a complete setup (and tear-down) of a 'dd' for it.
+ *
+ * pdev is the VF. Only called from host driver.
+ */
+int hfi2_sriov_init(struct pci_dev *pdev)
+{
+	int ret;
+
+#ifdef CONFIG_HFI_L8SIM
+	ret = sim_sriov_fixup(pdev);
+	if (ret)
+		dev_warn(&pdev->dev, "SRIOV simpci fixup failed %d\n", ret);
+		/* continue, even though it probably won't work */
+#endif
+#ifdef HFI_SRIOV_BRINGUP
+	if (vf_test) {
+		ret = pci_enable_device(pdev);
+		if (ret) {
+			dev_err(&pdev->dev, "SRIOV pci enable failed %d\n", ret);
+			return ret;
+		}
+		pci_set_master(pdev);
+	}
+	ret = vf_claim ? 0 : -ENODEV;
+#else
+	ret = -ENODEV;
+#endif
+	/*
+	 * If not claimed then remove_one()/hfi2_sriov_remove() will never be called.
+	 */
+
+	/* pci_num_vf(pdev->physfn) is not valid until later, so can't use it */
+#ifdef HFI_SRIOV_DEBUG
+	dev_info(&pdev->dev, "probing VF%d (%d)\n", pci_iov_vf_id(pdev) + 1, ret);
+	dev_warn(&pdev->dev, "is_vm=%d is_vf=%d is_physfn=%d is_virtfn=%d physfn=%p\n",
+#if defined(CONFIG_X86)
+		 boot_cpu_has(X86_FEATURE_HYPERVISOR),
+#else
+		 -1,
+#endif
+		 !pdev->pm_cap, pdev->is_physfn, pdev->is_virtfn, pdev->physfn);
+#endif
+
+	return ret;
+}
+
+void hfi2_sriov_remove(struct pci_dev *pdev)
+{
+#ifdef HFI_SRIOV_DEBUG
+	dev_info(&pdev->dev, "removing VF%d\n", pci_iov_vf_id(pdev) + 1);
+#endif
+}
+
+/*
+ * This disables SRIOV from PF0, if it was enabled.
+ *
+ * pdev is PF0. The driver is about to release this PF0.
+ */
+int hfi2_sriov_disable(struct pci_dev *pdev)
+{
+	pci_disable_sriov(pdev);
+	return 0;
+}
+
+/*
+ * Deconfigure SRIOV on PF0. The driver may continue to run on PF0.
+ */
+static int hfi2_sriov_deconfigure(struct hfi2_devdata *dd)
+{
+	/* TODO: do paranoid cleanup? */
+	pci_disable_sriov(dd->pcidev);
+	hfi2_pf0_cleanup(dd);
+	return 0;
+}
+
+/* TODO: any setup required for RPMSG, etc.
+ *
+ * pdev is PF0.
+ */
+int hfi2_sriov_configure(struct pci_dev *pdev, int nvf)
+{
+	struct hfi2_devdata *dd = pci_get_drvdata(pdev);
+	int ret;
+
+	if (!nvf)
+		return hfi2_sriov_deconfigure(dd);
+
+	if (nvf > max_num_vfs)
+		return -EINVAL;
+
+	/* prepare VF resources (contexts) for creation of VFs */
+	ret = vf2pf_prep(dd);
+	if (ret)
+		return ret;
+
+	ret = pci_enable_sriov(pdev, nvf);
+	if (ret < 0) {
+		hfi2_sriov_deconfigure(dd);
+		return ret;
+	}
+	return nvf;
+}
+
+/*
+ * Enables SRIOV if max_num_vfs > 0.
+ *
+ * Called at the very end of PF0 initialization (init_one()).
+ */
+int hfi2_sriov_auto_conf(struct hfi2_devdata *dd)
+{
+	int ret = 0;
+
+	if (!max_num_vfs)
+		return ret;
+
+	if (sriov_auto) {
+		ret = hfi2_sriov_configure(dd->pcidev, max_num_vfs);
+		if (ret)
+			dd_dev_err(dd, "hfi2_sriov_configure(%d) failed (%d).\n",
+				   max_num_vfs, ret);
+	}
+	return ret;
+}
diff --git a/drivers/infiniband/hw/hfi2/vf2pf.c b/drivers/infiniband/hw/hfi2/vf2pf.c
new file mode 100644
index 000000000000..09860e98f9f5
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/vf2pf.c
@@ -0,0 +1,1111 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ *
+ * SRIOV support for VFs making requests to PF0.
+ */
+
+#include "hfi2.h"
+#include "chip.h"
+#include "chip_gen.h"
+#include "mad.h"
+#include "sriov.h"
+#include "vf2pf_int.h"
+
+#ifdef HFI_VF2PF_LOOPBACK
+#include "vf2pf_lb.h"
+#define HFI_VF2PF_LOOPBACK_CONFIG
+#endif
+
+bool vf2pf_lb = true;
+module_param_named(vf2pf_lb, vf2pf_lb, bool, 0644);
+MODULE_PARM_DESC(vf2pf_lb,
+		 "Enable use of loopback port for VF-PF, default Y (on)");
+
+uint vf2pf_to = 1;
+module_param_named(vf2pf_to, vf2pf_to, uint, 0644);
+MODULE_PARM_DESC(vf2pf_to, "Timeout for vf2pf responses, seconds, default 1");
+
+#define VF2PF_FORCE_LB /* set to force use of loopback vf2pf even if VFs are local */
+
+#ifdef VF2PF_FORCE_LB
+#define IS_LOCAL_VF(dd) (!vf2pf_lb && !(dd)->is_vm)
+#define IS_LOCAL_VDD(vdd) (!vf2pf_lb && (vdd))
+#else
+#define IS_LOCAL_VF(dd) (!(dd)->is_vm)
+#define IS_LOCAL_VDD(vdd) (vdd)
+#endif
+
+static struct vf2pf_devops vf2pf_nodev = {};
+
+static struct vf2pf_devops *vf2pf_dev = &vf2pf_nodev;
+
+/* for additional output to "hw_resources" */
+int vf2pf_sysfs_emit_at(struct hfi2_devdata *dd, char *buf, int at)
+{
+	int off = at;
+
+	/*
+	 * Anything for vf2pf core goes here.
+	 */
+
+	if (vf2pf_dev->sysfs_emit_at)
+		off += vf2pf_dev->sysfs_emit_at(dd, buf, off);
+
+	return off - at;
+}
+
+/*
+ * Allocate memory for a vf2pf message to transmit.
+ * Returns pointer to allocation, to be used in kfree() and
+ * passing to vf2pf_devops.send().
+ *
+ * On success,
+ * 'msg' is set to struct vf2pf_hdr (vf2pf payload) part of allocation,
+ *
+ * buffer contents/structure:
+ *
+ * ret->	struct vf2pf_prefix
+ *		-align u64-
+ *		[opt: implimentation headers]
+ * msg->	struct vf2pf_hdr
+ *		variable payload...
+ */
+static void *msg_alloc(struct hfi2_devdata *dd, struct vf2pf_hdr **msg)
+{
+	if (!vf2pf_dev->msg_alloc)
+		return NULL;
+
+	return vf2pf_dev->msg_alloc(dd, msg);
+}
+
+/*
+ * Send a message to 'si'.
+ *
+ * 'buf' is opaque pointer returned by msg_alloc().
+ * header part (vf2pf_dev->get_msg(dd, buf)) must have been filled out.
+ * caller may kfree on return.
+ */
+static int vf2pf_send(struct hfi2_devdata *dd, u8 si, void *buf)
+{
+	if (!vf2pf_dev->send)
+		return -ENXIO;
+
+	return vf2pf_dev->send(dd, si, buf);
+}
+
+/*
+ * overwrites 'buf' with response.
+ * caller acquired 'buf' via msg_alloc().
+ * on success, 'buf' contains the response (caller kfrees when done).
+ */
+static int vf2pf_send_recv(struct hfi2_devdata *dd, u8 si, void *buf, long to)
+{
+	struct vf2pf_prefix *pfx = buf;
+	struct vf2pf_hdr *hdr;
+	int ret;
+
+	if (!vf2pf_dev->set_tid || !vf2pf_dev->get_msg)
+		return -EINVAL;
+
+	if (to > 0) {
+		pfx->type = VF2PF_PFX_TYPE_WAIT;
+		init_waitqueue_head(&pfx->wait);
+	} else {
+		to = -to;
+		pfx->type = VF2PF_PFX_TYPE_SEMA;
+		sema_init(&pfx->sema, 0);
+	}
+	hdr = vf2pf_dev->get_msg(dd, buf);
+	hdr->tid = vf2pf_dev->set_tid(dd, buf);
+
+	ret = vf2pf_send(dd, si, buf);
+	if (ret) {
+		vf2pf_dev->get_tid(dd, hdr->tid); /* discard tid */
+		return ret;
+	}
+
+	if (pfx->type == VF2PF_PFX_TYPE_WAIT) {
+		if (vf2pf_dev->rcv_wait) {
+			ret = vf2pf_dev->rcv_wait(dd, buf, to);
+		} else {
+			ret = wait_event_timeout(pfx->wait,
+						 (hdr->op & VF2PF_OP_RESP), to);
+			ret = ret ? 0 :
+				    -ETIME; /* convert residual time  to error */
+		}
+	} else {
+		ret = down_timeout(&pfx->sema, to);
+	}
+	if (ret) /* timeout or other error */
+		vf2pf_dev->get_tid(dd, hdr->tid); /* discard tid */
+
+	return ret;
+}
+
+/*
+ * VF call to PF0 to setup dd->rsrcs.
+ */
+int vf2pf_get_config(struct hfi2_devdata *dd, struct hfi2_devrsrcs *out, int si)
+{
+	struct vf2pf_hdr *hdr;
+	struct vf2pf_getcfg_msg *msg;
+	void *mem;
+	int ret;
+
+	if (!dd->is_vf)
+		return -EINVAL;
+	if (IS_LOCAL_VF(
+		    dd)) { /* VF and PF0 are using the same driver/OS instance */
+		struct hfi2_devdata *pdd = pci_get_drvdata(dd->pcidev->physfn);
+
+		ret = sriov_get_config(pdd, out, si);
+		if (ret)
+			return ret;
+		dd->base_guid = pdd->base_guid;
+		dd->revision = pdd->revision;
+		dd->hfi2_id = pdd->hfi2_id;
+		dd->icode = pdd->icode;
+		dd->irev = pdd->irev;
+		dd->cport_ver = pdd->cport_ver;
+		return 0;
+	}
+	mem = msg_alloc(dd, &hdr);
+	if (!mem)
+		return -ENOMEM;
+	msg = (struct vf2pf_getcfg_msg *)hdr;
+	msg->hdr.op = VF2PF_GET_CFG;
+	msg->hdr.len = sizeof(*msg) - sizeof(*hdr);
+	msg->si = si;
+	ret = vf2pf_send_recv(dd, 0, mem, vf2pf_to * HZ);
+	if (!ret)
+		ret = hdr->status;
+	if (ret)
+		goto out;
+	memcpy(out, &msg->rsrcs, sizeof(*out));
+	dd->base_guid = msg->base_guid;
+	dd->revision = msg->revision;
+	dd->hfi2_id = msg->hfi2_id;
+	dd->icode = msg->icode;
+	dd->irev = msg->irev;
+	dd->cport_ver = msg->cport_ver;
+out:
+	kfree(mem);
+	return ret;
+}
+
+static int do_asgnrs_msg(struct hfi2_devdata *dd, u8 op,
+			 struct hfi2_devrsrcs *vfr)
+{
+	struct vf2pf_hdr *hdr;
+	struct vf2pf_asgnrs_msg *msg;
+	void *mem;
+	int ret;
+
+	mem = msg_alloc(dd, &hdr);
+	if (!mem)
+		return -ENOMEM;
+	msg = (struct vf2pf_asgnrs_msg *)hdr;
+	msg->hdr.op = op;
+	msg->hdr.len = sizeof(*msg) - sizeof(*hdr);
+	memcpy(&msg->rsrcs, vfr, sizeof(msg->rsrcs));
+	ret = vf2pf_send_recv(dd, 0, mem, vf2pf_to * HZ);
+	if (!ret)
+		ret = hdr->status;
+	kfree(mem);
+	return ret;
+}
+
+/*
+ * VF call to PF0 to assign chip resources to this SI.
+ * May include additional early setup.
+ */
+int vf2pf_assign_rsrcs(struct hfi2_devdata *dd, struct hfi2_devrsrcs *vfr)
+{
+	if (!dd->is_vf)
+		return -EINVAL;
+	if (IS_LOCAL_VF(
+		    dd)) { /* VF and PF0 are using the same driver/OS instance */
+		struct hfi2_devdata *pdd = pci_get_drvdata(dd->pcidev->physfn);
+
+		return hfi2_sriov_assign_rsrcs(pdd, vfr);
+	}
+	return do_asgnrs_msg(dd, VF2PF_ASGN_RES, vfr);
+}
+
+/*
+ * VF call to PF0 to release chip resources.
+ * May include other late shutdown.
+ */
+int vf2pf_free_rsrcs(struct hfi2_devdata *dd, struct hfi2_devrsrcs *vfr)
+{
+	if (!dd->is_vf)
+		return -EINVAL;
+	if (IS_LOCAL_VF(
+		    dd)) { /* VF and PF0 are using the same driver/OS instance */
+		struct hfi2_devdata *pdd = pci_get_drvdata(dd->pcidev->physfn);
+
+		hfi2_sriov_free_rsrcs(pdd, vfr);
+		return 0;
+	}
+	return do_asgnrs_msg(dd, VF2PF_FREE_RES, vfr);
+}
+
+int vf2pf_priv_reg_op(struct hfi2_devdata *dd, int pidx, u32 ctxt, int type,
+		      enum preg_op op, u64 arg)
+{
+	struct vf2pf_hdr *hdr;
+	struct vf2pf_pregop_msg *msg;
+	void *mem;
+	int ret;
+
+	if (!dd->is_vf)
+		return -EINVAL;
+	if (IS_LOCAL_VF(
+		    dd)) { /* VF and PF0 are using the same driver/OS instance */
+		struct hfi2_devdata *pdd = pci_get_drvdata(dd->pcidev->physfn);
+
+		return priv_reg_op(pdd, pidx, ctxt, type, op, arg);
+	}
+	mem = msg_alloc(dd, &hdr);
+	if (!mem)
+		return -ENOMEM;
+	msg = (struct vf2pf_pregop_msg *)hdr;
+	msg->hdr.op = VF2PF_PREG_OP;
+	msg->hdr.len = sizeof(*msg) - sizeof(*hdr);
+	msg->pidx = pidx;
+	msg->ctxt = ctxt;
+	msg->type = type;
+	msg->op = op;
+	msg->arg = arg;
+	ret = vf2pf_send_recv(dd, 0, mem, vf2pf_to * HZ);
+	if (!ret)
+		ret = hdr->status;
+	kfree(mem);
+	return ret;
+}
+
+/* Called for PF0 and VFs */
+u64 pf0_read_csr(struct hfi2_devdata *dd, enum csr_type type, u32 off, u16 ctxt,
+		 u8 pidx_eng)
+{
+	struct vf2pf_hdr *hdr;
+	struct vf2pf_readcsr_msg *msg;
+	void *mem;
+	u64 reg = ~(u64)0; /* error */
+	int ret;
+
+	if (!dd->is_vf)
+		return read_csr(dd, off);
+	if (IS_LOCAL_VF(
+		    dd)) { /* VF and PF0 are using the same driver/OS instance */
+		struct hfi2_devdata *pdd = pci_get_drvdata(dd->pcidev->physfn);
+
+		return read_csr_type(pdd, type, off, ctxt, pidx_eng);
+	}
+	mem = msg_alloc(dd, &hdr);
+	if (!mem)
+		return -ENOMEM;
+	msg = (struct vf2pf_readcsr_msg *)hdr;
+	msg->hdr.op = VF2PF_RCSR_OP;
+	msg->hdr.len = sizeof(*msg) - sizeof(*hdr);
+	msg->off = off;
+	ret = vf2pf_send_recv(dd, 0, mem, vf2pf_to * HZ);
+	if (!ret)
+		ret = hdr->status;
+	if (!ret)
+		reg = msg->reg;
+	kfree(mem);
+	return reg;
+}
+
+/* Only called for VFs */
+u64 pf0_rctxt_ctrl_op(struct hfi2_devdata *dd, u16 ctxt, unsigned int op)
+{
+	struct vf2pf_hdr *hdr;
+	struct vf2pf_rcctrl_msg *msg;
+	void *mem;
+	u64 reg = ~(u64)0; /* error */
+	int ret;
+
+	if (IS_LOCAL_VF(
+		    dd)) { /* VF and PF0 are using the same driver/OS instance */
+		struct hfi2_devdata *pdd = pci_get_drvdata(dd->pcidev->physfn);
+
+		return rctxt_ctrl_op(pdd, ctxt, op);
+	}
+	mem = msg_alloc(dd, &hdr);
+	if (!mem)
+		return -ENOMEM;
+	msg = (struct vf2pf_rcctrl_msg *)hdr;
+	msg->hdr.op = VF2PF_RCCTRL_OP;
+	msg->hdr.len = sizeof(*msg) - sizeof(*hdr);
+	msg->ctxt = ctxt;
+	msg->op = op;
+	ret = vf2pf_send_recv(dd, 0, mem, vf2pf_to * HZ);
+	if (!ret)
+		ret = hdr->status;
+	if (!ret)
+		reg = msg->reg;
+	kfree(mem);
+	return reg;
+}
+
+void vf2pf_tid_config(struct hfi2_devdata *dd, int pidx, u16 ctxt,
+		      u32 eager_base, u16 alloced, u32 expected_base,
+		      u32 expected_count)
+{
+	struct vf2pf_hdr *hdr;
+	struct vf2pf_tidcfg_msg *msg;
+	void *mem;
+
+	if (!dd->is_vf)
+		return; /*should never happen */
+	if (IS_LOCAL_VF(
+		    dd)) { /* VF and PF0 are using the same driver/OS instance */
+		struct hfi2_devdata *pdd = pci_get_drvdata(dd->pcidev->physfn);
+
+		pdd->params->set_port_tid_config(pdd, pidx, ctxt, eager_base,
+						 alloced, expected_base,
+						 expected_count);
+		return;
+	}
+	mem = msg_alloc(dd, &hdr);
+	if (!mem) {
+		dd_dev_err(
+			dd,
+			"Failed to allocate vf2pf message buffer for tid_config\n");
+		return;
+	}
+	msg = (struct vf2pf_tidcfg_msg *)hdr;
+	msg->hdr.op = VF2PF_TIDCFG_OP;
+	msg->hdr.len = sizeof(*msg) - sizeof(*hdr);
+	msg->pidx = pidx;
+	msg->ctxt = ctxt;
+	msg->alloced = alloced;
+	msg->egr_base = eager_base;
+	msg->exp_base = expected_base;
+	msg->exp_cnt = expected_count;
+	vf2pf_send_recv(dd, 0, mem, vf2pf_to * HZ);
+	kfree(mem);
+}
+
+int vf2pf_init_rxe_rsm(struct hfi2_devdata *dd)
+{
+	if (IS_LOCAL_VF(
+		    dd)) { /* VF and PF0 are using the same driver/OS instance */
+		struct hfi2_devdata *pdd = pci_get_drvdata(dd->pcidev->physfn);
+
+		return init_rxe_rsm(pdd, &dd->rsrcs);
+	}
+	return do_asgnrs_msg(dd, VF2PF_RXERSM_OP, &dd->rsrcs);
+}
+
+u16 vf2pf_get_qp_map(struct hfi2_devdata *dd, int pidx, u16 idx)
+{
+	struct vf2pf_hdr *hdr;
+	struct vf2pf_qpmap_msg *msg;
+	void *mem;
+	u16 res = 0; /* guaranteed error */
+	int ret;
+
+	if (IS_LOCAL_VF(
+		    dd)) { /* VF and PF0 are using the same driver/OS instance */
+		struct hfi2_devdata *pdd = pci_get_drvdata(dd->pcidev->physfn);
+
+		return hfi2_get_qp_map(pdd->pport + pidx, idx);
+	}
+	mem = msg_alloc(dd, &hdr);
+	if (!mem)
+		return -ENOMEM;
+	msg = (struct vf2pf_qpmap_msg *)hdr;
+	msg->hdr.op = VF2PF_QPMAP_OP;
+	msg->hdr.len = sizeof(*msg) - sizeof(*hdr);
+	msg->pidx = pidx;
+	msg->idx = idx;
+	ret = vf2pf_send_recv(dd, 0, mem, vf2pf_to * HZ);
+	if (!ret)
+		ret = hdr->status;
+	if (!ret)
+		res = msg->res;
+	kfree(mem);
+	return res;
+}
+
+/*
+ * called on PF0 to distribute port_info to all VFs.
+ */
+int pf2vf_push_portinfo(struct hfi2_pportdata *ppd, struct opa_smp *smp,
+			struct opa_port_info *pi, int si_mask)
+{
+	struct hfi2_devdata *dd = ppd->dd, *vdd;
+	struct pci_dev *pdev, *vpdev;
+	struct vf2pf_hdr *hdr;
+	struct pf0_pushpi_msg *msg;
+	void *mem;
+	int id;
+	int ret;
+
+	if (dd->is_vf)
+		return -EINVAL;
+
+	if (si_mask == VF2PF_SI_ALL)
+		si_mask = dd->rsrcs.sync_done;
+	if (!si_mask)
+		return 0;
+
+	pdev = dd->pcidev;
+	/*
+	 * However, it is possible that some VFs may be local and some in VMs,
+	 * so might need to have each VF differently. At least, though, we can
+	 * only allocate message buffer once.
+	 */
+	/*
+	 * 'pi' is always opa_get_smp_data(smp) so we only
+	 * need to send 'smp' (the whole MAD).
+	 */
+	mem = msg_alloc(dd, &hdr);
+	if (!mem)
+		return -ENOMEM;
+	msg = (struct pf0_pushpi_msg *)hdr;
+	msg->hdr.op = PF0_PUSH_PI;
+	msg->hdr.len = sizeof(*msg) - sizeof(*hdr);
+	msg->pidx = ppd->hw_pidx;
+	memcpy(&msg->smp, smp, sizeof(*smp));
+	for (id = 0; id < dd->rsrcs.num_vfs; ++id) {
+		if (!(si_mask & (1 << (id + 1))))
+			continue;
+		/*
+		 * pci/iov.c uses pci_iov_virtfn_bus(pdev, id) but we don't have that,
+		 * will pdev->bus->number work?
+		 */
+		vpdev = pci_get_domain_bus_and_slot(
+			pci_domain_nr(pdev->bus), pdev->bus->number,
+			pci_iov_virtfn_devfn(pdev, id));
+		if (!vpdev)
+			continue; /* error or just skip? */
+		vdd = pci_get_drvdata(vpdev);
+		if (IS_LOCAL_VDD(vdd)) { /* must not be in VM... */
+			ret = update_from_opa_portinfo(
+				&vdd->pport[ppd->hw_pidx], smp, pi);
+		} else {
+			ret = vf2pf_send(dd, id + 1, mem);
+			if (ret)
+				dd_dev_warn(
+					dd,
+					"Failed to push portinfo to %d (%d)\n",
+					id + 1, ret);
+		}
+		if (ret)
+			break;
+	}
+	kfree(mem);
+	return ret;
+}
+
+/*
+ * called on PF0 to distribute sc2vlt to all VFs.
+ */
+int pf2vf_push_sc2vlt(struct hfi2_pportdata *ppd, int si_mask)
+{
+	struct hfi2_devdata *dd = ppd->dd, *vdd;
+	struct pci_dev *pdev, *vpdev;
+	struct vf2pf_hdr *hdr;
+	struct pf0_pushvlt_msg *msg;
+	void *mem;
+	int id;
+	int ret = 0;
+
+	if (dd->is_vf)
+		return -EINVAL;
+
+	if (si_mask == VF2PF_SI_ALL)
+		si_mask = dd->rsrcs.sync_done;
+	if (!si_mask)
+		return 0;
+
+	pdev = dd->pcidev;
+	/*
+	 * However, it is possible that some VFs may be local and some in VMs,
+	 * so might need to have each VF differently. At least, though, we can
+	 * only allocate message buffer once.
+	 */
+	/*
+	 * 'pi' is always opa_get_smp_data(smp) so we only
+	 * need to send 'smp' (the whole MAD).
+	 */
+	mem = msg_alloc(dd, &hdr);
+	if (!mem)
+		return -ENOMEM;
+	msg = (struct pf0_pushvlt_msg *)hdr;
+	msg->hdr.op = PF0_PUSH_VLT;
+	msg->hdr.len = sizeof(*msg) - sizeof(*hdr);
+	msg->pidx = ppd->hw_pidx;
+	memcpy(msg->sc2vl, ppd->sc2vl, sizeof(msg->sc2vl));
+	for (id = 0; id < dd->rsrcs.num_vfs; ++id) {
+		if (!(si_mask & (1 << (id + 1))))
+			continue;
+		/*
+		 * pci/iov.c uses pci_iov_virtfn_bus(pdev, id) but we don't have that,
+		 * will pdev->bus->number work?
+		 */
+		vpdev = pci_get_domain_bus_and_slot(
+			pci_domain_nr(pdev->bus), pdev->bus->number,
+			pci_iov_virtfn_devfn(pdev, id));
+		if (!vpdev)
+			continue; /* error or just skip? */
+		vdd = pci_get_drvdata(vpdev);
+		if (IS_LOCAL_VDD(vdd)) { /* must not be in VM... */
+			hfi2_update_sc2vlt(&vdd->pport[ppd->hw_pidx],
+					   ppd->sc2vl, false);
+		} else {
+			ret = vf2pf_send(dd, id + 1, mem);
+			if (ret)
+				dd_dev_warn(
+					dd,
+					"Failed to push sc2vlt to %d (%d)\n",
+					id + 1, ret);
+		}
+		if (ret)
+			break;
+	}
+	kfree(mem);
+	return ret;
+}
+
+int vf2pf_send_only_mad(struct hfi2_devdata *dd, u8 sb, const void *mad,
+			int len)
+{
+	struct vf2pf_hdr *hdr;
+	struct vf2pf_mad *msg;
+	void *mem;
+	int ret;
+
+	if (IS_LOCAL_VF(
+		    dd)) { /* VF and PF0 are using the same driver/OS instance */
+		struct hfi2_devdata *pdd = pci_get_drvdata(dd->pcidev->physfn);
+
+		return cport_send_only_mad(pdd, sb, mad, len);
+	}
+	mem = msg_alloc(dd, &hdr);
+	if (!mem)
+		return -ENOMEM;
+	msg = (struct vf2pf_mad *)hdr;
+	msg->hdr.op = VF2PF_MAD_SND;
+	msg->hdr.len = len + VF2PF_MAD_OVERHEAD;
+	msg->sb = sb;
+	memcpy(&msg->mad, mad, len);
+	ret = vf2pf_send(dd, 0, mem);
+	if (!ret)
+		ret = hdr->status;
+	kfree(mem);
+	return ret;
+}
+
+int vf2pf_send_recv_mad(struct hfi2_devdata *dd, u8 sb, const void *mad,
+			int len, void *omad, size_t *omad_len, long to)
+{
+	struct vf2pf_hdr *hdr;
+	struct vf2pf_mad *msg;
+	void *mem;
+	int ret;
+
+	if (IS_LOCAL_VF(
+		    dd)) { /* VF and PF0 are using the same driver/OS instance */
+		struct hfi2_devdata *pdd = pci_get_drvdata(dd->pcidev->physfn);
+
+		return cport_send_recv_mad(pdd, sb, mad, len, omad, omad_len);
+	}
+	mem = msg_alloc(dd, &hdr);
+	if (!mem)
+		return -ENOMEM;
+	msg = (struct vf2pf_mad *)hdr;
+	msg->hdr.op = VF2PF_MAD_SNDRCV;
+	msg->hdr.len = len + VF2PF_MAD_OVERHEAD;
+	msg->sb = sb;
+	memcpy(&msg->mad, mad, len);
+	ret = vf2pf_send_recv(dd, 0, mem, -to); /* -to: signal use semaphore */
+	if (!ret)
+		ret = hdr->status;
+	if (!ret) {
+		int olen = msg->hdr.len - VF2PF_MAD_OVERHEAD;
+
+		if (olen > *omad_len) {
+			dd_dev_warn(
+				dd,
+				"VF2PF MAD resp length 0x%x > 0x%lx, truncating\n",
+				olen, *omad_len);
+			olen = *omad_len;
+		}
+		memcpy(omad, &msg->mad, olen);
+	}
+	kfree(mem);
+	return ret;
+}
+
+static void vf2pf_syncup(struct hfi2_devdata *dd, int si)
+{
+	atomic_or(1 << si, &dd->rsrcs.sync_pending);
+	queue_work(dd->hfi2_wq, &dd->sync_vf_work);
+}
+
+static void vf2pf_sync_fn(struct work_struct *work)
+{
+	int ret;
+
+	struct hfi2_devdata *dd =
+		container_of(work, struct hfi2_devdata, sync_vf_work);
+	int sync_pending = atomic_fetch_and(0, &dd->rsrcs.sync_pending);
+
+	if (!sync_pending)
+		return;
+
+	dd_dev_info(dd, "syncing VFs %02x\n", sync_pending);
+	dd->rsrcs.sync_done |= sync_pending;
+	ret = hfi2_sriov_sync_ports(dd, sync_pending);
+	if (ret)
+		dd_dev_err(dd, "Failed to sync ports to %02x (%d)\n",
+			   sync_pending, ret);
+}
+
+/*
+ * received responses handled elsewhere.
+ * 'buf' (and 'hdr') are allocated memory.
+ * must be safe to destroy 'buf' on return.
+ */
+void vf2pf_rcv_msg(struct hfi2_devdata *dd, struct vf2pf_hdr *hdr, void *buf)
+{
+	int ret = 0;
+
+	/* hdr == vf2pf_dev->get_msg(dd, buf) */
+	switch (hdr->op) {
+	case VF2PF_OP_PING: {
+		struct vf2pf_ping_msg *ping = (struct vf2pf_ping_msg *)hdr;
+
+		dd_dev_info(dd, "vf2pf ping-pong with %u \"%.*s\"\n", hdr->si,
+			    hdr->len, ping->data);
+		if (hdr->len >= sizeof(ping->data))
+			hdr->len = sizeof(ping->data) - 1;
+		ping->data[hdr->len++] = '!';
+		break;
+	}
+
+	/* only received on PF0 */
+	case VF2PF_GET_CFG: {
+		struct vf2pf_getcfg_msg *msg = (struct vf2pf_getcfg_msg *)hdr;
+
+		ret = sriov_get_config(dd, &msg->rsrcs, msg->si);
+		/* copy these even if error */
+		msg->base_guid = dd->base_guid;
+		msg->revision = dd->revision;
+		msg->hfi2_id = dd->hfi2_id;
+		msg->icode = dd->icode;
+		msg->irev = dd->irev;
+		msg->cport_ver = dd->cport_ver;
+		break;
+	}
+	case VF2PF_ASGN_RES: {
+		struct vf2pf_asgnrs_msg *msg = (struct vf2pf_asgnrs_msg *)hdr;
+
+		ret = hfi2_sriov_assign_rsrcs(dd, &msg->rsrcs);
+		break;
+	}
+	case VF2PF_FREE_RES: {
+		struct vf2pf_asgnrs_msg *msg = (struct vf2pf_asgnrs_msg *)hdr;
+
+		hfi2_sriov_free_rsrcs(dd, &msg->rsrcs);
+		break;
+	}
+	case VF2PF_PREG_OP: {
+		struct vf2pf_pregop_msg *msg = (struct vf2pf_pregop_msg *)hdr;
+
+		ret = priv_reg_op(dd, msg->pidx, msg->ctxt, msg->type, msg->op,
+				  msg->arg);
+		break;
+	}
+	case VF2PF_RCSR_OP: {
+		struct vf2pf_readcsr_msg *msg = (struct vf2pf_readcsr_msg *)hdr;
+
+		msg->reg = read_csr(dd, msg->off);
+		break;
+	}
+	case VF2PF_RCCTRL_OP: {
+		struct vf2pf_rcctrl_msg *msg = (struct vf2pf_rcctrl_msg *)hdr;
+
+		ret = rctxt_ctrl_op(dd, msg->ctxt, msg->op);
+		break;
+	}
+	case VF2PF_TIDCFG_OP: {
+		struct vf2pf_tidcfg_msg *msg = (struct vf2pf_tidcfg_msg *)hdr;
+
+		dd->params->set_port_tid_config(dd, msg->pidx, msg->ctxt,
+						msg->egr_base, msg->alloced,
+						msg->exp_base, msg->exp_cnt);
+		break;
+	}
+	case VF2PF_RXERSM_OP: {
+		struct vf2pf_asgnrs_msg *msg = (struct vf2pf_asgnrs_msg *)hdr;
+
+		ret = init_rxe_rsm(dd, &msg->rsrcs);
+		break;
+	}
+	case VF2PF_QPMAP_OP: {
+		struct vf2pf_qpmap_msg *msg = (struct vf2pf_qpmap_msg *)hdr;
+
+		msg->res = hfi2_get_qp_map(dd->pport + msg->pidx, msg->idx);
+		break;
+	}
+	case VF2PF_STOP: {
+		if (vf2pf_dev->deinit)
+			vf2pf_dev->deinit(dd, hdr->si);
+		return; /* no response */
+	}
+	case VF2PF_MAD_SND: {
+		struct vf2pf_mad *msg = (struct vf2pf_mad *)hdr;
+
+		ret = cport_send_only_mad(dd, msg->sb, &msg->mad,
+					  msg->hdr.len - VF2PF_MAD_OVERHEAD);
+		if (ret)
+			dd_dev_err(dd, "Failed to send MAD to CPORT (%d)\n",
+				   ret);
+		return; /* no response */
+	}
+	case VF2PF_MAD_SNDRCV: {
+		struct vf2pf_mad *msg = (struct vf2pf_mad *)hdr;
+		size_t olen = sizeof(msg->mad);
+
+		ret = cport_send_recv_mad(dd, msg->sb, &msg->mad,
+					  msg->hdr.len - VF2PF_MAD_OVERHEAD,
+					  &msg->mad, &olen);
+		if (!ret)
+			msg->hdr.len = olen;
+		break;
+	}
+	case VF2PF_READY: {
+		vf2pf_syncup(dd, hdr->si);
+		return; /* no response */
+	}
+
+	/* only received on VFs */
+	case PF0_PUSH_PI: {
+		struct pf0_pushpi_msg *msg = (struct pf0_pushpi_msg *)hdr;
+		struct opa_port_info *pi =
+			(struct opa_port_info *)opa_get_smp_data(&msg->smp);
+
+		ret = update_from_opa_portinfo(dd->pport + msg->pidx, &msg->smp,
+					       pi);
+		if (ret)
+			dd_dev_err(dd,
+				   "Failed to process port_info update (%d)\n",
+				   ret);
+		return; /* no response */
+	}
+	case PF0_PUSH_VLT: {
+		struct pf0_pushvlt_msg *msg = (struct pf0_pushvlt_msg *)hdr;
+
+		hfi2_update_sc2vlt(dd->pport + msg->pidx, msg->sc2vl, false);
+		return; /* no response */
+	}
+	default:
+		dd_dev_err(dd, "Unknown vf2pf msg op %u from %u\n", hdr->op,
+			   hdr->si);
+		return;
+	}
+
+	/* reaching here means response is to be sent */
+	hdr->op |= VF2PF_OP_RESP;
+	hdr->status = ret;
+	vf2pf_send(dd, hdr->si, buf);
+}
+
+/*
+ * 'buf' may point to h/w recv buffer.
+ * called from intr context: must expedite handling.
+ * hdr->op has VF2PF_OP_RESP set, in order to reach here.
+ */
+void vf2pf_rsp_msg(struct hfi2_devdata *dd, void *buf)
+{
+	struct vf2pf_hdr *hdr = buf;
+	struct vf2pf_prefix *wpfx; /* msg object waiting for response */
+	struct vf2pf_hdr *whdr; /* hdr waiting for response */
+	void *wbuf;
+
+	wpfx = vf2pf_dev->get_tid(dd, hdr->tid);
+	if (!wpfx) {
+		dd_dev_err(dd, "vf2pf response op %x has no waiter\n", hdr->op);
+		return;
+	}
+	whdr = vf2pf_dev->get_msg(dd, wpfx);
+	wbuf = whdr;
+	/*
+	 * need to avoid race by setting VF2PF_OP_RESP in whdr->op last (after barrier).
+	 * this requires that VF2PF_OP_RESP is cleared in 'op' before the memcpy,
+	 * then set after in the destination.
+	 */
+	hdr->op &= ~VF2PF_OP_RESP;
+	memcpy(wbuf, buf, hdr->len + sizeof(*hdr));
+	smp_wmb(); /* needed? */
+	whdr->op |= VF2PF_OP_RESP; /* to trigger wakeup condition */
+	if (wpfx->type == VF2PF_PFX_TYPE_WAIT)
+		wake_up(&wpfx->wait);
+	else
+		up(&wpfx->sema);
+}
+
+/*
+ * Return number of special contexts needed by implementation.
+ * Should be either 0 or JKR_C_CCE_NUM_VFS + 1.
+ */
+int vf2pf_num_ctxts(struct hfi2_devdata *dd)
+{
+	if (dd->params->chip_type == CHIP_WFR || !dd->is_sriov)
+		return 0;
+	return vf2pf_dev->num_ctxts;
+}
+
+int vf2pf_num_irq(struct hfi2_devdata *dd)
+{
+	if (dd->params->chip_type == CHIP_WFR || !dd->is_sriov)
+		return 0;
+	return vf2pf_dev->num_irq;
+}
+
+/* returns 0 on error (invalid VF SI) */
+int vf2pf_probe_si(struct hfi2_devdata *dd)
+{
+	if (vf2pf_dev->probe_si)
+		return vf2pf_dev->probe_si(dd);
+	return 0;
+}
+
+static ssize_t vf2pf_ping_store(struct device *device,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct hfi2_ibdev *dev =
+		rdma_device_to_drv_device(device, struct hfi2_ibdev, rdi.ibdev);
+	struct hfi2_devdata *dd = dd_from_dev(dev);
+	void *mem;
+	struct vf2pf_hdr *hdr;
+	struct vf2pf_ping_msg *ping;
+	size_t len = count;
+	int ret;
+
+	if (count > sizeof(ping->data))
+		return -EINVAL;
+
+	/* trim one newline if present */
+	if (buf[len - 1] == '\n')
+		--len;
+
+	mem = msg_alloc(dd, &hdr);
+	if (!mem)
+		return -ENOMEM;
+
+	ping = (struct vf2pf_ping_msg *)hdr;
+	ping->hdr.op = VF2PF_OP_PING;
+	ping->hdr.len = len;
+	memcpy(ping->data, buf, len);
+
+	dd_dev_info(dd, "vf2pf ping 0 \"%.*s\"\n", ping->hdr.len, buf);
+	ret = vf2pf_send_recv(dd, 0, mem, vf2pf_to * HZ);
+	if (ret)
+		dd_dev_warn(dd, "vf2pf ping send failed (%d)\n", ret);
+	else
+		dd_dev_info(dd, "vf2pf ping resp from %u \"%.*s\"\n",
+			    ping->hdr.si, ping->hdr.len, (char *)ping->data);
+	kfree(mem);
+	return count;
+}
+
+static DEVICE_ATTR_WO(vf2pf_ping);
+
+static ssize_t vf2pf_sync_store(struct device *device,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct hfi2_ibdev *dev =
+		rdma_device_to_drv_device(device, struct hfi2_ibdev, rdi.ibdev);
+	struct hfi2_devdata *dd = dd_from_dev(dev);
+	unsigned long sync_mask;
+	int ret;
+
+	/* allow 0 mask and trigger work func anyway */
+	ret = kstrtoul(buf, 0, &sync_mask);
+	if (ret || (sync_mask & ~0b011111110))
+		return -EINVAL;
+
+	atomic_or(sync_mask, &dd->rsrcs.sync_pending);
+	queue_work(dd->hfi2_wq, &dd->sync_vf_work);
+
+	return count;
+}
+
+static DEVICE_ATTR_WO(vf2pf_sync);
+
+void vf2pf_set_si_enables(struct hfi2_devdata *dd, int si, u64 *csrs,
+			  void (*si_enables)(struct hfi2_devdata *dd, u64 *csrs,
+					     u32 start, u32 end))
+{
+	if (!vf2pf_dev->set_si_enables)
+		return;
+	vf2pf_dev->set_si_enables(dd, si, csrs, si_enables);
+}
+
+void vf2pf_ready(struct hfi2_devdata *dd)
+{
+	struct vf2pf_hdr *hdr;
+	void *mem;
+	int ret;
+
+	if (!dd->is_vf)
+		return;
+
+	if (IS_LOCAL_VF(
+		    dd)) { /* VF and PF0 are using the same driver/OS instance */
+		struct hfi2_devdata *pdd = pci_get_drvdata(dd->pcidev->physfn);
+
+		vf2pf_syncup(pdd, dd->rsrcs.si_idx);
+		return;
+	}
+	mem = msg_alloc(dd, &hdr);
+	if (!mem) {
+		dd_dev_err(dd, "Failed to signal ready to PF0 (msg_alloc)\n");
+		return;
+	}
+	hdr->op = VF2PF_READY;
+	hdr->len = 0;
+	ret = vf2pf_send(dd, 0, mem);
+	kfree(mem);
+	if (ret)
+		dd_dev_err(dd, "Failed to signal ready to PF0 (%d)\n", ret);
+}
+
+void vf2pf_init_sysfs(struct hfi2_devdata *dd, struct device *class_dev)
+{
+	struct vf2pf_lbdata *lbd = dd->vf2pf;
+	int ret;
+
+	if (!lbd)
+		return;
+
+	if (dd->is_vf) {
+		ret = sysfs_create_file(&class_dev->kobj,
+					&dev_attr_vf2pf_ping.attr);
+		if (ret)
+			dd_dev_warn(dd, "failed to create sysfs attr %s (%d)\n",
+				    dev_attr_vf2pf_ping.attr.name, ret);
+	} else {
+		ret = sysfs_create_file(&class_dev->kobj,
+					&dev_attr_vf2pf_sync.attr);
+		if (ret)
+			dd_dev_warn(dd, "failed to create sysfs attr %s (%d)\n",
+				    dev_attr_vf2pf_sync.attr.name, ret);
+	}
+	if (vf2pf_dev->init_sysfs)
+		vf2pf_dev->init_sysfs(dd, class_dev);
+}
+
+int vf2pf_init_irq(struct hfi2_devdata *dd)
+{
+	if (!vf2pf_dev->init_irq)
+		return 0;
+	return vf2pf_dev->init_irq(dd);
+}
+
+void vf2pf_deinit_irq(struct hfi2_devdata *dd)
+{
+	if (!vf2pf_dev->deinit_irq)
+		return;
+	vf2pf_dev->deinit_irq(dd);
+}
+
+/*
+ * This is called on PF0 only, just before creation of VFs.
+ *
+ * This may be called multiple times throughout the life of the PF0
+ * driver, if VFs are destroyed and recreated.
+ */
+int vf2pf_prep(struct hfi2_devdata *dd)
+{
+	if (!vf2pf_dev->init)
+		return 0;
+	return vf2pf_dev->init(dd, VF2PF_INIT_ALL);
+}
+
+/*
+ * This is called early in the initialization.
+ * It must not depend on any SRIOV configuration being setup,
+ * but may call into the sriov module to decide if SRIOV is allowed.
+ */
+int vf2pf_early_init(struct hfi2_devdata *dd)
+{
+	if (dd->params->chip_type == CHIP_WFR || !dd->is_sriov)
+		return 0;
+
+	if (!dd->is_vf) {
+		INIT_WORK(&dd->sync_vf_work, vf2pf_sync_fn);
+		atomic_set(&dd->rsrcs.sync_pending, 0);
+		dd->rsrcs.sync_done = 0;
+	}
+
+#ifdef HFI_VF2PF_LOOPBACK
+#ifndef HFI_VF2PF_LOOPBACK_CONFIG
+	if (vf2pf_lb)
+#endif
+		vf2pf_dev = get_lb_devops();
+#endif
+	/* this may require BARs, must have been mapped by now */
+	return hfi2_sriov_set_si(dd);
+}
+
+/*
+ * This does the actual vf2pf implementation init,
+ * which may need to be done later.
+ */
+int vf2pf_init(struct hfi2_devdata *dd)
+{
+	if (dd->params->chip_type == CHIP_WFR || !dd->is_sriov)
+		return 0;
+
+	if (!vf2pf_dev->init)
+		return 0;
+	return vf2pf_dev->init(dd, dd->rsrcs.si_idx);
+}
+
+/*
+ * On VFs, this only sends a notification to PF0.
+ * On PF0, this does a full de-initialization.
+ */
+void vf2pf_deinit(struct hfi2_devdata *dd)
+{
+	struct vf2pf_hdr *hdr;
+	void *mem;
+	int ret;
+
+	if (dd->is_vf) {
+		if (IS_LOCAL_VF(
+			    dd)) { /* VF and PF0 are using the same driver/OS instance */
+			struct hfi2_devdata *pdd =
+				pci_get_drvdata(dd->pcidev->physfn);
+
+			if (vf2pf_dev->deinit)
+				vf2pf_dev->deinit(pdd, dd->rsrcs.si_idx);
+			goto out;
+		}
+		mem = msg_alloc(dd, &hdr);
+		if (!mem) {
+			dd_dev_err(dd, "Failed to notify PF0 (msg_alloc)\n");
+			return;
+		}
+		hdr->op = VF2PF_STOP;
+		hdr->len = 0;
+		ret = vf2pf_send(dd, 0, mem);
+		kfree(mem);
+		if (ret)
+			dd_dev_err(dd, "Failed to notify PF0 (%d)\n", ret);
+	}
+out:
+	if (vf2pf_dev->deinit)
+		vf2pf_dev->deinit(dd, dd->rsrcs.si_idx);
+}
diff --git a/drivers/infiniband/hw/hfi2/vf2pf_lb.c b/drivers/infiniband/hw/hfi2/vf2pf_lb.c
new file mode 100644
index 000000000000..944c0a9e0670
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/vf2pf_lb.c
@@ -0,0 +1,966 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ *
+ * SRIOV support for VFs making requests to PF0 over loopback.
+ */
+
+#include "hfi2.h"
+#include "chip_jkr.h"
+#include "chip_gen.h"
+#include "exp_rcv.h"
+#include "sriov.h"
+#include "vf2pf_int.h"
+#include "vf2pf_lb.h"
+
+static uint vf2pf_lb_port;
+module_param(vf2pf_lb_port, uint, 0444);
+MODULE_PARM_DESC(vf2pf_lb_port, "VF2PF loopback port");
+
+#undef VF2PF_LB_DEBUG
+#define LB_RCV_CANT_SLEEP
+
+#define LB_IN_INTR 0
+#define LB_IN_THREAD 1
+#define LB_IN_POLL 2
+#define LB_IN_SHUTDOWN 3
+
+#define LB_RHQ_ENT_SIZE 32 /* same as default for hfi2_hdrq_entsize */
+#define LB_MAX_RCV_MSG PAGE_SIZE
+#define LB_DEFAULT_RCVHDRSIZE 2 /* get split-point right */
+
+static void lb_deinit(struct hfi2_devdata *dd, u8 si);
+static struct vf2pf_hdr *lb_get_msg(struct hfi2_devdata *dd, void *buf);
+static void *lb_msg_alloc(struct hfi2_devdata *dd, struct vf2pf_hdr **msg);
+
+static struct vf2pf_devops vf2pf_lb_dev;
+
+/*
+ * Get vf2pf_lb context resources for specific SI.
+ * These should be valid early, as soon as CSRs are accessible.
+ * Only called by PF0.
+ */
+static void lb_set_si_ctxtrsrcs(struct hfi2_devdata *dd, int si,
+				struct hfi2_ctxtrsrcs *lbr)
+{
+	int nctxt = vf2pf_lb_dev.num_ctxts;
+
+	lbr->first_rcv_context = chip_rcv_contexts(dd) - nctxt + si;
+	lbr->last_rcv_context = lbr->first_rcv_context + 1;
+	lbr->first_send_context = chip_send_contexts(dd) - nctxt + si;
+	lbr->last_send_context = lbr->first_send_context + 1;
+	lbr->first_rcvarray_entry = chip_rcv_array_count(dd) -
+				    HFI_MIN_PF0_RCVARY(nctxt) +
+				    HFI_MIN_PF0_RCVARY(si);
+	lbr->last_rcvarray_entry =
+		lbr->first_rcvarray_entry + HFI_MIN_PF0_RCVARY(1);
+	lbr->first_pio_block = chip_pio_mem_size(dd) / PIO_BLOCK_SIZE -
+			       HFI_MIN_PF0_PIO(nctxt) + HFI_MIN_PF0_PIO(si);
+	lbr->last_pio_block = lbr->first_pio_block + HFI_MIN_PF0_PIO(1);
+}
+
+static void lb_rcv_msg(struct work_struct *work)
+{
+	struct vf2pf_lb_msg *msg =
+		container_of(work, struct vf2pf_lb_msg, pfx.work);
+	struct hfi2_devdata *dd = msg->pfx.dd;
+
+	vf2pf_rcv_msg(dd, &msg->hdr, msg);
+	kfree(msg);
+}
+
+/*
+ * 'buf' is struct vf2pf_hdr plus payload, in h/w recv buffer (eager buf).
+ * copy out and spawn to kworker thread.
+ */
+static void lb_queue_rcv_work(struct hfi2_devdata *dd, void *buf)
+{
+	struct vf2pf_hdr *hdr = buf;
+	struct vf2pf_lb_msg *msg;
+	void *out;
+
+	out = lb_msg_alloc(dd, NULL);
+	if (!out) {
+		dd_dev_err(dd, "vf2pf no memory for rcv work\n");
+		return;
+	}
+	msg = out;
+	INIT_WORK(&msg->pfx.work, lb_rcv_msg);
+	msg->pfx.dd = dd;
+	msg->pfx.len = hdr->len + sizeof(*hdr);
+	memcpy(out + offsetof(struct vf2pf_lb_msg, hdr), buf, msg->pfx.len);
+	queue_work(dd->hfi2_wq, &msg->pfx.work);
+}
+
+static inline u32 rhf_egr_index(u64 rhf)
+{
+	/* NOTE: RHF.EgrIndex is 14 bits but RcvEgrIndexHead has 16 bits */
+	return (rhf >> 16) & 0x3fff;
+}
+
+/* returns 0 if queue was emptied */
+static int lb_do_rcv(struct hfi2_devdata *dd, int thread)
+{
+	struct vf2pf_lbdata *lbd = dd->vf2pf;
+	u16 ctxt = lbd->c.first_rcv_context;
+	u32 head, tail;
+	u32 rhqoff, etail;
+	u32 rhq_max;
+	u64 rhf, rhe;
+	bool bad;
+	void *buf;
+	u32 len;
+
+	if (!lbd ||
+	    ((lbd->flags & VF2PF_LB_FL_SHUTDOWN) && thread != LB_IN_SHUTDOWN))
+		return RCV_PKT_DONE;
+
+	rhq_max = lbd->b.rhq_cnt * lbd->b.rhq_ent_size;
+	/*
+	 * process receive:
+	 *
+	 * (hdrq)TAIL is set by HFI to the next hdr ent to be used on next pkt recvd.
+	 * (hdrq)HEAD is used by driver to pull packet hdrs off queue (DMA memory).
+	 * units are DW, incr by RcvHdrEntSize.
+	 *
+	 * RHEQ entry is same index as RHQ (diff element size).
+	 *
+	 * RHF contains index/offset for payload in eager buffer.
+	 */
+	head = (u32)read_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_head_reg);
+	tail = (u32)read_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_tail_reg);
+	rhqoff = head; /* always multiple of rcvhdrqentsize, units dwords */
+	while (rhqoff != tail) {
+		rhf = rhf_to_cpu((__le32 *)lbd->b.rhq.va + rhqoff +
+				 LB_RHQ_ENT_SIZE - sizeof(u64) / sizeof(u32));
+		rhe = *((u64 *)lbd->b.rheq.va + rhqoff / LB_RHQ_ENT_SIZE);
+		etail = rhf_egr_index(rhf); /* RHF.EgrIndex */
+#ifdef VF2PF_LB_DEBUG
+		dd_dev_info(dd,
+			    "%s: head=%04x tail=%04x rhf=%016llx rhe=%016llx\n",
+			    __func__, rhqoff, tail, rhf, rhe);
+#endif
+		len = rhf_pkt_len(rhf); /* in bytes */
+		bad = true;
+		if (rhe & RHF_ERROR_SMASK)
+			goto drop;
+		if (rhf_rcv_type(rhf) != RHF_RCV_TYPE_EAGER)
+			goto drop;
+		if (rhf_use_egr_bfr(rhf))
+			buf = lbd->b.egr.va +
+			      rhf_egr_index(rhf) * lbd->b.egr_buf_size +
+			      rhf_egr_buf_offset(rhf) * RCV_BUF_BLOCK_SIZE;
+		else
+			buf = lbd->b.rhq.va +
+			      (rhqoff + rhf_hdrq_offset(rhf)) * sizeof(u32) +
+			      sizeof(struct vf2pf_lb_hdr);
+#ifdef VF2PF_LB_DEBUG
+		dd_dev_info(dd, "LB_PKT @ %p idx=%u off=%u\n", buf,
+			    rhf_egr_index(rhf), rhf_egr_buf_offset(rhf));
+		print_hex_dump(KERN_INFO, "LB_PKT ", DUMP_PREFIX_OFFSET, 16, 1,
+			       buf, len - sizeof(struct vf2pf_lb_hdr), false);
+#endif
+
+		/* divert responses now (do not use WQ) */
+		if (((struct vf2pf_hdr *)buf)->op & VF2PF_OP_RESP) {
+			vf2pf_rsp_msg(dd, buf);
+			goto next;
+		}
+		lb_queue_rcv_work(dd, buf);
+next:
+		bad = false;
+drop:
+		if (bad)
+			dd_dev_err(
+				dd,
+				"Recv error ctxt %u rhq=%04x rhf=%016llx rhe=%016llx\n",
+				ctxt, rhqoff, rhf, rhe);
+		rhqoff += LB_RHQ_ENT_SIZE;
+		if (rhqoff >= rhq_max)
+			rhqoff = 0;
+#ifdef VF2PF_LB_DEBUG
+		dd_dev_info(dd, "%s: update_usrhead_ctxt(%u, %04x, 1, %04x)\n",
+			    __func__, ctxt, rhqoff, etail);
+#endif
+		update_usrhead_ctxt(dd, ctxt, rhqoff, 1, 1, etail);
+	}
+	return RCV_PKT_DONE;
+}
+
+static inline int lb_rsp_wait(struct vf2pf_prefix *pfx, struct vf2pf_hdr *hdr,
+			      long timeout)
+{
+	int ret;
+
+#ifdef LB_RCV_CANT_SLEEP
+	unsigned long expire;
+
+	if (timeout > 0 && timeout != MAX_SCHEDULE_TIMEOUT)
+		expire = timeout + jiffies;
+	else
+		expire = 0;
+	ret = 0;
+	while (!(hdr->op & VF2PF_OP_RESP)) {
+		udelay(100);
+		if (expire && time_after_eq(jiffies, expire))
+			return -ETIME;
+	}
+#else
+	ret = wait_event_timeout(pfx->wait, (hdr->op & VF2PF_OP_RESP), timeout);
+	ret = ret ? 0 : -ETIME; /* convert residual time  to error */
+#endif
+
+	return ret;
+}
+
+static int lb_rcv_wait(struct hfi2_devdata *dd, void *buf, long timeout)
+{
+	struct vf2pf_lbdata *lbd = dd->vf2pf;
+	struct vf2pf_prefix *pfx = buf;
+	struct vf2pf_hdr *hdr;
+	int ret = 0;
+
+	if (!lbd)
+		return -EINVAL;
+
+	hdr = lb_get_msg(dd, buf);
+	if (lbd->rcv_irq) {
+		ret = lb_rsp_wait(pfx, hdr, timeout);
+	} else {
+		u32 head, tail;
+		unsigned long expire;
+		u16 ctxt = lbd->c.first_rcv_context;
+
+		/* interrupts not setup yet, poll for recv. */
+		if (timeout > 0 && timeout != MAX_SCHEDULE_TIMEOUT)
+			expire = timeout + jiffies;
+		else
+			expire = 0;
+		while (!(hdr->op & VF2PF_OP_RESP)) {
+			spin_lock(&lbd->rcv_lock);
+			head = (u32)read_uctxt_csr(
+				dd, ctxt, dd->params->rcv_hdr_head_reg);
+			tail = (u32)read_uctxt_csr(
+				dd, ctxt, dd->params->rcv_hdr_tail_reg);
+			if (head != tail) {
+				lb_do_rcv(dd, LB_IN_POLL);
+				spin_unlock(&lbd->rcv_lock);
+			} else {
+				spin_unlock(&lbd->rcv_lock);
+				udelay(100);
+				if (expire && time_after_eq(jiffies, expire))
+					return -ETIME;
+			}
+		}
+	}
+	return ret;
+}
+
+/*
+ * This is like __hfi2_rcd_eoi_intr() except not dependent on hfi2_ctxtdata.
+ */
+static void __hfi2_rctxt_eoi_intr(struct hfi2_devdata *dd, u16 ctxt)
+{
+	u32 src = dd->params->is_rcvavail_start + ctxt;
+	u32 off = sizeof(u64) * (src / 64);
+	u64 bit = 1ull << (src % 64);
+	u32 head, tail;
+
+	write_csr(dd, dd->params->cce_int_clear_reg + off, bit);
+
+	/* these also force the previous write */
+	head = (u32)read_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_head_reg);
+	tail = (u32)read_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_tail_reg);
+	if (head != tail)
+		write_csr(dd, dd->params->cce_int_force_reg + off, bit);
+}
+
+static irqreturn_t lb_rcv_intr(int irq, void *arg)
+{
+	struct hfi2_devdata *dd = arg;
+	struct vf2pf_lbdata *lbd = dd->vf2pf;
+
+	if (!lbd)
+		return IRQ_HANDLED;
+
+	this_cpu_inc(*dd->int_counter);
+
+#ifdef VF2PF_LB_DEBUG
+	dd_dev_info(dd, "Receive vf2pf interrupt on %u\n",
+		    lbd->c.first_rcv_context);
+#endif
+	if (lb_do_rcv(dd, LB_IN_INTR) == RCV_PKT_LIMIT)
+		return IRQ_WAKE_THREAD;
+
+	__hfi2_rctxt_eoi_intr(dd, lbd->c.first_rcv_context);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t lb_rcv_thrd(int irq, void *arg)
+{
+	struct hfi2_devdata *dd = arg;
+	struct vf2pf_lbdata *lbd = dd->vf2pf;
+
+	if (!lbd)
+		return IRQ_HANDLED;
+#ifdef VF2PF_LB_DEBUG
+	dd_dev_info(dd, "Receive vf2pf thread on %u\n",
+		    lbd->c.first_rcv_context);
+#endif
+	lb_do_rcv(dd, LB_IN_THREAD);
+
+	__hfi2_rctxt_eoi_intr(dd, lbd->c.first_rcv_context);
+	return IRQ_HANDLED;
+}
+
+#define lb_tid_limit XA_LIMIT(0, 255) /* must fit in u16 */
+
+static u16 lb_set_tid(struct hfi2_devdata *dd, void *tok)
+{
+	struct vf2pf_lbdata *lbd = dd->vf2pf;
+	u32 idx;
+	int ret;
+
+	if (!lbd)
+		return ~(u16)0;
+	ret = xa_alloc_cyclic(&lbd->tid_xa, &idx, tok, lb_tid_limit,
+			      &lbd->tid_next, GFP_KERNEL);
+	if (ret < 0)
+		return ~(u16)0;
+	return (u16)idx;
+}
+
+/* destructive lookup... */
+static void *lb_get_tid(struct hfi2_devdata *dd, u16 tid)
+{
+	struct vf2pf_lbdata *lbd = dd->vf2pf;
+
+	if (!lbd)
+		return NULL;
+	return xa_erase(&lbd->tid_xa, (u32)tid);
+}
+
+static int lb_init_irq(struct hfi2_devdata *dd)
+{
+	struct vf2pf_lbdata *lbd = dd->vf2pf;
+	char name[MAX_NAME_SIZE];
+	int ret;
+	u16 ctxt;
+
+	if (!lbd)
+		return 0;
+	ctxt = lbd->c.first_rcv_context;
+
+	snprintf(name, sizeof(name), DRIVER_NAME "_%dsi%d", dd->rsrcs.pfunit,
+		 dd->rsrcs.si_idx);
+	/*
+	 * Use IRQ_GENERAL even though this is IRQ_RCVCTXT, to avoid
+	 * doing affinity work that is not possible for this ctxt
+	 * (no struct hfi2_ctxtdata *rcd exists).
+	 */
+	ret = msix_request_irq_remap(dd, ctxt, IRQ_GENERAL,
+				     dd->params->is_rcvavail_start + ctxt,
+				     lb_rcv_intr, lb_rcv_thrd, dd, name);
+	if (ret < 0)
+		return ret;
+	if (!ret) {
+		/* must not take intr 0 */
+		msix_free_irq(dd, (u8)ret);
+		return -ENOSPC;
+	}
+	lbd->rcv_irq = ret;
+	set_intr_bits(dd, dd->params->is_rcvavail_start + ctxt,
+		      dd->params->is_rcvavail_start + ctxt, true);
+	return 0;
+}
+
+static void lb_deinit_irq(struct hfi2_devdata *dd)
+{
+	struct vf2pf_lbdata *lbd = dd->vf2pf;
+	u16 ctxt;
+	u8 irq;
+
+	if (!lbd)
+		return;
+	irq = lbd->rcv_irq;
+	if (lbd->rcv_irq <= 0)
+		return;
+	lbd->rcv_irq = 0; /* trigger polling */
+
+	ctxt = lbd->c.first_rcv_context;
+	/* tear-down our interrupt */
+	set_intr_bits(dd, dd->params->is_rcvavail_start + ctxt,
+		      dd->params->is_rcvavail_start + ctxt, false);
+	msix_free_irq(dd, irq);
+#ifdef VF2PF_LB_DEBUG
+	dd_dev_info(dd, "Calling lb_do_rcv() in shutdown\n");
+#endif
+	lb_do_rcv(dd, LB_IN_SHUTDOWN); /* pre-emptive flushing of receives */
+}
+
+/*
+ * Only called on PF0.
+ *
+ * Initialize or reset (reinit) contexts.
+ */
+static int lb_init_ctxts(struct hfi2_devdata *dd, u8 si)
+{
+	struct vf2pf_lbdata *lbd = dd->vf2pf;
+	struct hfi2_ctxtrsrcs lbr;
+	int ret;
+
+	lb_set_si_ctxtrsrcs(dd, si, &lbr);
+	ret = gen_init_sctxt_pio(dd, lbd->pidx, si, lbr.first_send_context,
+				 lbr.first_pio_block,
+				 lbr.last_pio_block - lbr.first_pio_block);
+	if (ret)
+		goto out;
+	ret = gen_init_rctxt_egr(dd, lbd->pidx, si, lbr.first_rcv_context,
+				 lbr.first_rcvarray_entry,
+				 lbd->b.rhq_cnt, /* all must be the same! */
+				 LB_DEFAULT_RCVHDRSIZE);
+out:
+	return ret;
+}
+
+static int lb_start_ctxts(struct hfi2_devdata *dd, u8 si)
+{
+	struct vf2pf_lbdata *lbd = dd->vf2pf;
+	int ret;
+
+	ret = gen_start_sctxt(dd, lbd->pidx, lbd->c.first_send_context,
+			      &lbd->b);
+	if (ret)
+		goto out;
+	ret = gen_start_rctxt_egr(dd, lbd->pidx, lbd->c.first_rcv_context,
+				  &lbd->b);
+out:
+	return ret;
+}
+
+/*
+ * Only called on PF0.
+ *
+ * Prepare VF contexts for use. This may require reset/shutdown/disable
+ * since contexts might still be "up" from previous run of SRIOV.
+ */
+static int lb_init_vfs(struct hfi2_devdata *dd)
+{
+	int si, nsi;
+	int ret = 0;
+
+	nsi = dd->rsrcs.num_vfs + 1;
+	for (si = 1; si < nsi; ++si) {
+		ret = lb_init_ctxts(dd, si);
+		if (ret)
+			goto err_out;
+	}
+err_out:
+	return ret;
+}
+
+/* final deinit (PF0 shutdown) */
+static void lb_deinit_ctxts(struct hfi2_devdata *dd, u8 si)
+{
+	struct vf2pf_lbdata *lbd = dd->vf2pf;
+	struct hfi2_ctxtrsrcs lbr;
+
+	lb_set_si_ctxtrsrcs(dd, si, &lbr);
+	gen_deinit_sctxt(dd, lbd->pidx, si, lbr.first_send_context);
+	gen_deinit_rctxt(dd, lbd->pidx, si, lbr.first_rcv_context);
+}
+
+/*
+ * dd->rsrcs has not been setup yet, cannot depend on it.
+ */
+static int lb_init(struct hfi2_devdata *dd, u8 si)
+{
+	struct vf2pf_lbdata *lbd;
+	u16 ctxt;
+	int ret;
+
+	if (si == VF2PF_INIT_ALL)
+		return lb_init_vfs(dd);
+
+	lbd = kzalloc_obj(lbd, GFP_KERNEL);
+	if (!lbd)
+		return -ENOMEM;
+
+	spin_lock_init(&lbd->pio_lock);
+	spin_lock_init(&lbd->rcv_lock);
+	lbd->dd = dd;
+	dd->vf2pf = lbd;
+	/*
+	 * This is problematic because loopback ports are numbered
+	 * differently depending on the number of fabric ports, and
+	 * that varies with different chips.
+	 */
+	if (vf2pf_lb_port < dd->num_pports)
+		lbd->pidx = loopback_pidx_dd(dd, vf2pf_lb_port);
+	else if (vf2pf_lb_port < 2 * dd->num_pports)
+		lbd->pidx = vf2pf_lb_port;
+	else
+		lbd->pidx = loopback_pidx_dd(dd, 0); /* hope it's functional */
+	lb_set_si_ctxtrsrcs(dd, si, &lbd->c);
+
+	xa_init_flags(&lbd->tid_xa, XA_FLAGS_ALLOC);
+	lbd->pf0_ctxt = lbd->c.first_rcv_context - si;
+
+	lbd->b.cr.va = dma_alloc_coherent(&dd->pcidev->dev,
+					  sizeof(*lbd->b.cr.va), &lbd->b.cr.dma,
+					  GFP_KERNEL);
+	if (!lbd->b.cr.va) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	/*
+	 * rhq_cnt, rhq_ent drives the sizes of all receive allocations.
+	 * For PF0, a larger size is justified since there might be
+	 * several VFs communicating with PF0 at once. It is also possible
+	 * that a VF might have a couple messages to PF0 outstanding at
+	 * once, and thus need more than one receive buffer set. For now,
+	 * just use the number of VFs (actually, SIs) for all cases.
+	 * For gen_init_rctxt_egr(), we require that all SIs use identical
+	 * eager buffer counts.
+	 */
+	lbd->b.rhq_cnt = round_up(JKR_C_CCE_NUM_VFS + 1, HDRQ_INCREMENT);
+	lbd->b.egr_buf_size = PAGE_SIZE;
+	lbd->b.rhq_ent_size = LB_RHQ_ENT_SIZE;
+	lbd->b.egr.size = PAGE_ALIGN(lbd->b.rhq_cnt * lbd->b.egr_buf_size);
+	lbd->b.rhq.size =
+		PAGE_ALIGN(lbd->b.rhq_cnt * lbd->b.rhq_ent_size * sizeof(u32));
+	lbd->b.rheq.size = PAGE_ALIGN(lbd->b.rhq_cnt * sizeof(u64));
+
+	lbd->b.egr.va = dma_alloc_coherent(&dd->pcidev->dev, lbd->b.egr.size,
+					   &lbd->b.egr.dma, GFP_KERNEL);
+	lbd->b.rhq.va = dma_alloc_coherent(&dd->pcidev->dev, lbd->b.rhq.size,
+					   &lbd->b.rhq.dma, GFP_KERNEL);
+	lbd->b.rheq.va = dma_alloc_coherent(&dd->pcidev->dev, lbd->b.rheq.size,
+					    &lbd->b.rheq.dma, GFP_KERNEL);
+	if (!lbd->b.egr.va || !lbd->b.rhq.va || !lbd->b.rheq.va) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	ctxt = lbd->c.first_send_context;
+	lbd->pio_mem = dd->bar_maps[ctxt_bar_idx(ctxt)].piobase +
+		       ((ctxt_bar_ctxt(ctxt) & PIO_ADDR_CONTEXT_MASK)
+			<< PIO_ADDR_CONTEXT_SHIFT);
+	lbd->pio_wrap = lbd->pio_mem +
+			(lbd->c.last_pio_block - lbd->c.first_pio_block) *
+				PIO_BLOCK_SIZE;
+	lbd->pio_next = lbd->pio_mem;
+
+	/* now setup contexts as required */
+	if (!dd->is_vf) {
+		ret = lb_init_ctxts(dd, si);
+		if (ret)
+			goto err_out;
+	}
+	ret = lb_start_ctxts(dd, si);
+	if (ret)
+		goto err_out;
+	return 0;
+
+err_out:
+	lb_deinit(dd, si);
+	return ret;
+}
+
+/*
+ * Called on PF0 on behalf of 'si', or for final shutdown (si == 0).
+ * Called on VFs only to free local resources.
+ */
+static void lb_deinit(struct hfi2_devdata *dd, u8 si_idx)
+{
+	struct vf2pf_lbdata *lbd = dd->vf2pf;
+
+	if (!lbd)
+		return;
+
+	if (dd->rsrcs.si_idx != si_idx) {
+		int ret;
+
+		/* PF0 performing on behalf of VF - VF2PF_STOP */
+		ret = lb_init_ctxts(dd, si_idx); /* re-init */
+		if (ret)
+			dd_dev_err(
+				dd,
+				"Failed to restart vf2pf contexts for SI %u (%d)\n",
+				si_idx, ret);
+		return;
+	}
+	lbd->flags |= VF2PF_LB_FL_SHUTDOWN;
+	smp_rmb(); /* ensure flags are updated before continuing */
+
+	lb_deinit_irq(dd); /* in case not already done */
+	/*
+	 * On VFs, can't stop contexts since we've already sent the STOP
+	 * message to PF0 and it has likely taken ownership of them. This
+	 * means the lb_deinit_ctxts() routines must also do the stop
+	 * function. Only PF0 does the lb_deinit_ctxts() here.
+	 */
+	if (!dd->is_vf)
+		lb_deinit_ctxts(dd, dd->rsrcs.si_idx);
+
+	if (lbd->b.cr.va)
+		dma_free_coherent(&dd->pcidev->dev, sizeof(*lbd->b.cr.va),
+				  lbd->b.cr.va, lbd->b.cr.dma);
+	if (lbd->b.egr.va)
+		dma_free_coherent(&dd->pcidev->dev, lbd->b.egr.size,
+				  lbd->b.egr.va, lbd->b.egr.dma);
+	if (lbd->b.rhq.va)
+		dma_free_coherent(&dd->pcidev->dev, lbd->b.rhq.size,
+				  lbd->b.rhq.va, lbd->b.rhq.dma);
+	if (lbd->b.rheq.va)
+		dma_free_coherent(&dd->pcidev->dev, lbd->b.rheq.size,
+				  lbd->b.rheq.va, lbd->b.rheq.dma);
+	if (!dd->is_vf) {
+		/* PF0 must de-init all contexts even if already done */
+		int si, nsi;
+
+		nsi = dd->rsrcs.num_vfs + 1;
+		for (si = 0; si < nsi; ++si)
+			lb_deinit_ctxts(dd, si); /* final deinit */
+	}
+
+	xa_destroy(&lbd->tid_xa);
+	dd->vf2pf = NULL;
+	kfree(lbd);
+}
+
+static struct vf2pf_hdr *lb_get_msg(struct hfi2_devdata *dd, void *buf)
+{
+	struct vf2pf_lb_msg *mem = buf;
+
+	return &mem->hdr;
+}
+
+/*
+ * Allocate a unified message structure for use with loopback implementation.
+ *
+ * Rounds total length up to qword multiple (for PIO CSR granularity).
+ * 'pfx' must be qword multiple to maintain memory alignment.
+ */
+static void *lb_msg_alloc(struct hfi2_devdata *dd, struct vf2pf_hdr **msg)
+{
+	struct vf2pf_lb_msg *mem;
+
+	mem = kzalloc_obj(*mem, GFP_KERNEL);
+	if (mem && msg)
+		*msg = lb_get_msg(dd, mem);
+	return mem;
+}
+
+#ifdef LB_EGRESS_WAIT
+/*
+ * Returns number of credits outstanding for ctxt.
+ */
+static u32 lb_sc_crleft(struct hfi2_devdata *dd, u16 ctxt)
+{
+	u64 reg;
+	u32 curr, last;
+
+	reg = read_sctxt_csr(dd, ctxt, dd->params->send_ctxt_credit_status_reg);
+	curr = (reg >> SEND_CTXT_CREDIT_STATUS_CURRENT_FREE_COUNTER_SHIFT) &
+	       SEND_CTXT_CREDIT_STATUS_CURRENT_FREE_COUNTER_MASK;
+	last = reg & SEND_CTXT_CREDIT_STATUS_LAST_RETURNED_COUNTER_SMASK;
+	return (curr - last) &
+	       SEND_CTXT_CREDIT_STATUS_LAST_RETURNED_COUNTER_SMASK;
+}
+
+static bool is_sc_halted(struct hfi2_devdata *dd, u32 hw_context)
+{
+	return !!(read_sctxt_csr(dd, hw_context,
+				 dd->params->send_ctxt_status_reg) &
+		  SEND_CTXT_STATUS_CTXT_HALTED_SMASK);
+}
+#endif
+
+/*
+ * Send 'msg' ('len') to 'si', do not wait for response.
+ *
+ * The opaque 'msg' has a wait_queue_head_t preceding vf2pf_lb_hdr.
+ */
+static int lb_send(struct hfi2_devdata *dd, u8 si, void *buf)
+{
+	struct vf2pf_lbdata *lbd = dd->vf2pf;
+	struct vf2pf_lb_msg *msg = buf;
+	struct vf2pf_lb_hdr *lbh = &msg->lbh;
+	struct vf2pf_hdr *hdr = &msg->hdr;
+	u64 *qw = (u64 *)lbh;
+	u64 __iomem *dst;
+	u32 dw_len, pbc_dw_len;
+	u32 qw_len, qw_wrt = 0;
+	u64 pbc;
+	u8 vl = 15;
+	int ret = 0;
+	int len;
+
+	if (hdr->len > VF2PF_LB_MAX_MSG)
+		return -EINVAL;
+	if (!lbd || (lbd->flags & VF2PF_LB_FL_SHUTDOWN))
+		return -ENXIO;
+
+	len = hdr->len + sizeof(struct vf2pf_hdr) + sizeof(struct vf2pf_lb_hdr);
+	dw_len = DIV_ROUND_UP(len, sizeof(u32));
+	pbc_dw_len = dw_len + (sizeof(u64) / sizeof(u32));
+	qw_len = DIV_ROUND_UP(dw_len, sizeof(u64) / sizeof(u32)) +
+		 1; /* include PBC */
+
+	spin_lock(&lbd->pio_lock);
+
+#ifdef LB_EGRESS_WAIT
+	u32 loop = 0;
+	/* wait for (any) previous send to complete... (reset credits?) */
+	while (lb_sc_crleft(dd, lbd->c.first_send_context)) {
+		if (is_sc_halted(dd, lbd->c.first_send_context)) {
+			ret = -EIO;
+			goto out;
+		}
+		if (loop > 100) {
+			ret = -ETIME;
+			goto out;
+		}
+		++loop;
+		mdelay(1);
+	}
+#endif
+	dst = lbd->pio_next + SOP_DISTANCE;
+	lbd->pio_next +=
+		round_up(len + sizeof(u64), PIO_BLOCK_SIZE); /* incl. PBC */
+	if (lbd->pio_next >= lbd->pio_wrap)
+		lbd->pio_next -= (lbd->pio_wrap - lbd->pio_mem);
+	spin_unlock(&lbd->pio_lock);
+
+	/* force these to legit value */
+	hdr->si = dd->rsrcs.si_idx;
+
+	lbh->lrh[0] = cpu_to_be16(HFI2_LRH_BTH | (vl << 12));
+	lbh->lrh[1] = cpu_to_be16(IB_LID_PERMISSIVE);
+	lbh->lrh[2] = cpu_to_be16(dw_len + SIZE_OF_CRC);
+	lbh->lrh[3] = cpu_to_be16(IB_LID_PERMISSIVE);
+	lbh->bth[0] = cpu_to_be32(IB_OPCODE_UD_SEND_ONLY << 24); /* used? */
+	lbh->bth[1] =
+		cpu_to_be32((RVT_KDETH_QP_PREFIX << RCV_BTH_QP_KDETH_QP_SHIFT) |
+			    (lbd->pf0_ctxt + si));
+	lbh->bth[2] = cpu_to_be32(0 /*loopback_dst_vf_index*/); /* PSN 0 */
+	;
+	lbh->ver_tid_offset = (1 << KDETH_KVER_SHIFT);
+	/* lbh->jkey should be dont-care since checking is OFF */
+	/* lbh->hcrc generated by h/w */
+
+	pbc = gen_create_pbc_pidx(lbd->pidx, 0, 0, vl, pbc_dw_len, PBC_L2_9B,
+				  OPA_LID_PERMISSIVE,
+				  lbd->c.first_send_context);
+	pbc &= ~PBC_INSERT_HCRC_SMASK;
+	pbc |= (u64)PBC_IHCRC_LKDETH << PBC_INSERT_HCRC_SHIFT;
+
+	/*
+	 * First block (8 qwords) written with SOP_DISTANCE set,
+	 * the rest with SOP_DISTANCE clear. Must write whole blocks.
+	 * First block (SOP) never requires wrap.
+	 */
+	writeq(pbc, dst++);
+	++qw_wrt;
+	while (qw_wrt < qw_len) {
+		writeq(*qw++, dst++);
+		++qw_wrt;
+		if (qw_wrt >= 8) {
+			if (qw_wrt == 8)
+				dst = (void *)dst - SOP_DISTANCE;
+			if ((void *)dst >= lbd->pio_wrap)
+				dst = lbd->pio_mem; /* never needs SOP_DISTANCE */
+		}
+	}
+	while (qw_wrt & 7) {
+		writeq(0, dst++);
+		++qw_wrt;
+	}
+	return ret;
+}
+
+/*
+ * Only called for VFs.
+ * Returns 0 on error (invalid VF SI).
+ * Must not depend on any setup (vf2pf_init() has not been called).
+ * BARs have been mapped.
+ */
+static int lb_probe_si(struct hfi2_devdata *dd)
+{
+	int nctxt;
+	u64 reg;
+	u16 pf0_ctxt;
+	int si;
+
+	nctxt = vf2pf_lb_dev.num_ctxts;
+	if (!nctxt)
+		return 0;
+
+	pf0_ctxt = chip_rcv_contexts(dd) - nctxt;
+	/*
+	 * Except for SI 1, this will cause CSR Access Violations
+	 * so we need to clear that after - regardless of the result.
+	 */
+	for (si = 1; si <= JKR_C_CCE_NUM_VFS; ++si) {
+		reg = read_kctxt_csr(dd, pf0_ctxt + si,
+				     dd->params->rcv_hdr_ent_size_reg);
+		if (reg) {
+			dd_dev_info(dd, "Probed SI index %d\n", si);
+			goto found;
+		}
+	}
+	si = 0; /* not found */
+found:
+	/* clear any access violations */
+	write_csr(dd, JKR_CCE_ERR_INFO_ACCESS_VIOLATION,
+		  JKR_CCE_ERR_INFO_ACCESS_VIOLATION_VALID_SMASK);
+	return si;
+}
+
+static ssize_t vf2pf_lb_debug_show(struct device *device,
+				   struct device_attribute *attr, char *buf)
+{
+	struct hfi2_ibdev *dev =
+		rdma_device_to_drv_device(device, struct hfi2_ibdev, rdi.ibdev);
+	struct hfi2_devdata *dd = dd_from_dev(dev);
+	struct vf2pf_lbdata *lbd = dd->vf2pf;
+	ssize_t off = 0;
+
+	if (!lbd)
+		return 0;
+	off += sysfs_emit_at(buf, off,
+			     "rctxt   %u\n"
+			     "sctxt   %u\n"
+			     "rcvary  %u-%u\n"
+			     "pio     %u-%u\n",
+			     lbd->c.first_rcv_context,
+			     lbd->c.first_send_context,
+			     lbd->c.first_rcvarray_entry,
+			     lbd->c.last_rcvarray_entry - 1,
+			     lbd->c.first_pio_block, lbd->c.last_pio_block - 1);
+	off += sysfs_emit_at(buf, off,
+			     "pidx %u\n"
+			     "pf0_ctxt %u\n"
+			     "tid_next %u\n"
+			     "CR %p %016llx\n"
+			     "PIO mem %p wrap %p next %p\n",
+			     lbd->pidx, lbd->pf0_ctxt, lbd->tid_next,
+			     lbd->b.cr.va, lbd->b.cr.dma, lbd->pio_mem,
+			     lbd->pio_wrap, lbd->pio_next);
+	off += sysfs_emit_at(buf, off,
+			     "rcv_irq %u\n"
+			     "egr size %lu va %p dma %016llx\n"
+			     "rhq size %lu va %p dma %016llx\n"
+			     "rheq size %lu va %p dma %016llx\n",
+			     lbd->rcv_irq, lbd->b.egr.size, lbd->b.egr.va,
+			     lbd->b.egr.dma, lbd->b.rhq.size, lbd->b.rhq.va,
+			     lbd->b.rhq.dma, lbd->b.rheq.size, lbd->b.rheq.va,
+			     lbd->b.rheq.dma);
+
+	if (off >= PAGE_SIZE) {
+		dd_dev_warn(dd, "%s exceeds PAGE_SIZE.\n", attr->attr.name);
+		return -EFBIG;
+	}
+	return off;
+}
+
+static DEVICE_ATTR_RO(vf2pf_lb_debug);
+
+static ssize_t vf2pf_lb_reset_store(struct device *device,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct hfi2_ibdev *dev =
+		rdma_device_to_drv_device(device, struct hfi2_ibdev, rdi.ibdev);
+	struct hfi2_devdata *dd = dd_from_dev(dev);
+	unsigned long si;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &si);
+	if (ret || !si || si > dd->rsrcs.num_vfs)
+		return -EINVAL;
+
+	lb_deinit(dd, (u8)si);
+	return count;
+}
+
+static DEVICE_ATTR_WO(vf2pf_lb_reset);
+
+static void lb_init_sysfs(struct hfi2_devdata *dd, struct device *class_dev)
+{
+	int ret;
+
+	ret = sysfs_create_file(&class_dev->kobj,
+				&dev_attr_vf2pf_lb_debug.attr);
+	if (ret)
+		dd_dev_warn(dd, "failed to create sysfs attr %s (%d)\n",
+			    dev_attr_vf2pf_lb_debug.attr.name, ret);
+	if (!dd->is_vf) {
+		ret = sysfs_create_file(&class_dev->kobj,
+					&dev_attr_vf2pf_lb_reset.attr);
+		if (ret)
+			dd_dev_warn(dd, "failed to create sysfs attr %s (%d)\n",
+				    dev_attr_vf2pf_lb_reset.attr.name, ret);
+	}
+}
+
+/* for additional output to "hw_resources" */
+static int lb_sysfs_emit_at(struct hfi2_devdata *dd, char *buf, int at)
+{
+	struct vf2pf_lbdata *lbd = dd->vf2pf;
+	int off = at;
+
+	if (!lbd)
+		return 0;
+
+	off += sysfs_emit_at(buf, off,
+			     "lb.rctxt  %u\n"
+			     "lb.sctxt  %u\n"
+			     "lb.rcvary %u-%u\n"
+			     "lb.pio    %u-%u\n",
+			     lbd->c.first_rcv_context,
+			     lbd->c.first_send_context,
+			     lbd->c.first_rcvarray_entry,
+			     lbd->c.last_rcvarray_entry - 1,
+			     lbd->c.first_pio_block, lbd->c.last_pio_block - 1);
+
+	return off - at;
+}
+
+static void lb_set_si_enables(struct hfi2_devdata *dd, int si, u64 *csrs,
+			      void (*si_enables)(struct hfi2_devdata *dd,
+						 u64 *csrs, u32 start, u32 end))
+{
+	struct hfi2_ctxtrsrcs lbr;
+
+	lb_set_si_ctxtrsrcs(dd, si, &lbr);
+	si_enables(dd, csrs,
+		   dd->params->is_rcvavail_start + lbr.first_rcv_context,
+		   dd->params->is_rcvavail_start + lbr.last_rcv_context);
+}
+
+static struct vf2pf_devops vf2pf_lb_dev = {
+	.num_ctxts = JKR_C_CCE_NUM_VFS + 1,
+	.num_irq = 1,
+	.init = lb_init,
+	.deinit = lb_deinit,
+	.send = lb_send,
+	.msg_alloc = lb_msg_alloc,
+	.set_tid = lb_set_tid,
+	.get_tid = lb_get_tid,
+	.get_msg = lb_get_msg,
+	.probe_si = lb_probe_si,
+	.init_sysfs = lb_init_sysfs,
+	.sysfs_emit_at = lb_sysfs_emit_at,
+	.init_irq = lb_init_irq,
+	.deinit_irq = lb_deinit_irq,
+	.rcv_wait = lb_rcv_wait,
+	.set_si_enables = lb_set_si_enables,
+};
+
+struct vf2pf_devops *get_lb_devops(void)
+{
+	return &vf2pf_lb_dev;
+}



