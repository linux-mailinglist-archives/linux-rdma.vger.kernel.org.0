Return-Path: <linux-rdma+bounces-17995-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OmNI22ssWmzEQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17995-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:54:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDF22684BE
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2516130263DB
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6323644DD;
	Wed, 11 Mar 2026 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="QENW0O/L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020126.outbound.protection.outlook.com [52.101.201.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2653E6395
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251691; cv=fail; b=LFvKUMvsIzqjKtFElva2sPa2F/fRbuWhHN0SzXe2WsIa1740yunig9nNnM2AI0ns3MIYVZXL9AMhGImflGIlNJxIaYl42bca2ExcCYbbUUq7Z1U/Fvx78VJoAWFhz6sQh4uUQjRjgQmMTCBHfWD0RadBuvwiy43fyWJPH7Xwdmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251691; c=relaxed/simple;
	bh=5sK9cgxLtRv5AahubCpAlvcEJ2urjVOzPURpFc20w3M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmIO+LU4nQLzN8Aw1u7aO4ZpDnGJub5Dfv7GTpuJYbCeaEIBfBxjX9Xoa38kqxeAtkezuwUze9CvFDj7nbtcGk65lldBIGrNn75xYTRbTrt+fXbNlNIbkELJ3GqFXA+J9MruB7zVD3zE1d5jbKE3/9Gc9Bj5LoJUbEpz3tyczwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=QENW0O/L; arc=fail smtp.client-ip=52.101.201.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wq5ljK2qjoPsjIsEfCRZ5Eoe4QkafzrnNsKbpCOOn81kNOtHohFH/GhSmARIGmzo+u8ZQvfCwZsRyXFD7ZKCn+ORTeQ1bSed9v1NLThMwXN7+/+ncdiC6UU3RrTXTE0moFL73BiBE1FzHonoVp6UuVOY3LrtplcLk1IUgNkNnAJpuCfAxkbDEKDNkyM4khrDM/IskHuUgJM5Sd7U7+ZjetZ18GKTln1IKI0VsfK1eXRqHDZLBAOzVLZZ81H7I/qg7EZ54rOkKgj/SNrgeovPFJMAh/p8IgJtFuWeljmafnT0HDAicJ4oVPwjJX42NL8HVA4CSw8ipaTm+OHrrxHTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUXn2P6qwDfTbWzFP5TbtYWVpBbnnrh/mukDTsLVlng=;
 b=SPjLjvU7Nrl/0dzBxRN9CHsSUzOVjA3snGgjYvh/N182xJlaXBJQSumXY39FMhkaPOEK02QJyXb7H2iwn3dP6gD0kfYocnd28wTPH5oQNXrVirhRmHs891iT4P3ZkjPYnUCKEGW4qRwcXSz01YWj3VDstaFX4vnxnYW2MENk3HV+Wu8AZMQLMFYa/4dVdnEN/Ux10BjqD2v8zeoWuRUg5rSoxHwvtkWQYwKm41vIYHFYEU8ts9qe6LMU7vuME72bvUC5ur9jl8ROAEo9900lJxbPxeSOoTBg9LfG1EyPcK9O3CIeyqvR05Q7+qsM9IW8styCqnlbP8p/lSCex4l9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.148.235.34) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUXn2P6qwDfTbWzFP5TbtYWVpBbnnrh/mukDTsLVlng=;
 b=QENW0O/LVVxqMz1YJc8l6fUv3B+DpKKnncr9ZuG82JPdXZxpttKgmJ5aAO26wi2Q7wCeIB81bI4NIVDDRc2YL68iRsASssBaJavljlGQQh9twsQ6BsDqen00xzQ2s1rwO/fkvnqURo/yg5A4xy7cHuzIW5e1T8Gmlh2zeIrGQunLzuTuV8bnyUbknxPErVa5wAfrPnEi9avIB/Ugqr3ApFWNQP23pm2VnTRQjJvX9AyRUOc8jhEFzZJEBntGhGNOr/2t4N2idDqbGHz3pneU8yf4E8MZYqXYzAJ8xnqBvS4bdMMkgAsERcXR0Qj77M1FDsfOFDOW/6y6gNqPZz8HNQ==
Received: from BN9PR03CA0808.namprd03.prod.outlook.com (2603:10b6:408:13f::33)
 by CYYPR01MB8565.prod.exchangelabs.com (2603:10b6:930:c8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Wed, 11 Mar 2026 17:54:42 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:13f:cafe::a) by BN9PR03CA0808.outlook.office365.com
 (2603:10b6:408:13f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 17:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.148.235.34)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=cornelisnetworks.com;
Received-SPF: Fail (protection.outlook.com: domain of cornelisnetworks.com
 does not designate 50.148.235.34 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.148.235.34;
 helo=cn-mailer-00.localdomain;
Received: from cn-mailer-00.localdomain (50.148.235.34) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.1
 via Frontend Transport; Wed, 11 Mar 2026 17:54:41 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id F147B14D817;
	Wed, 11 Mar 2026 13:54:40 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id EE6801810D6C5;
	Wed, 11 Mar 2026 13:54:40 -0400 (EDT)
Subject: [PATCH for-next resend 11/24] RDMA/hfi2: Add cport management
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Wed, 11 Mar 2026 13:54:40 -0400
Message-ID:
 <177325168095.57064.960114751944528155.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|CYYPR01MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: c6978e6b-6bab-4a2c-6b61-08de7f97459a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|34020700016|376014|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KLllj90sfNdB97Owus4+k3F3aD2BDCpLuyMEKhzni9/ox7akYDFqPl68Y3Q455/KEdDWHekMsnWnI8acYBJJc3SLuZ4+sNuzyr9bIhySdY8jefmB9xO5SUTlgS6HBf6iMEAr84DODYgS3/DunbK7Fm4wRZjYHzq5JLj8ZuWIfWtp3CUxqkqgkLtCVZPWyBuMA1LPRR21aQEOgUK/1aC/jKO8FgveYfOSgmCqrvp32k03uTupv4Y3hBLYNXo55dx36HX2T7N4ISJC1R19Du29kA1HZ0YtSUfxm2nP0+nvdQsJf32BILJou3zyMaNrok8Am6ENAdk6xzX04z4gmP73CpoXKbIrX2uJuYNmjupeovYTuOcbwQK5G3ooz5iDLZ0gnPgFK9jDZ7sT4ZZC77fKq2mHDfmVjSoUBbCWuVFDaCMHJhTck5kNhAm4DwNRfHlUOA6Itv/3MhadeYo1+dYjn6vUko8+fdKgxCmglA75Jhu5oRgeYqJo9hZohAvS4ATw5pNBw13FxrbztNn0vBWZFwwtFYeZMRZXGb7GQ/oAO1SIMH8/P9O7BEB9itwSLaMkgoD8eKGfT94+tvHerG2ZpDsQbk+QHp0Sbp52k2nb5MVx0zIOzobYnPpD/1L9gKflYQ55YJxROB8rbFUCW5fzpcQ6117k6p7uZLa3Mwi+r+otx+zk4ipL9aSu5NZ2Zo7G5R/IrpGxJpQVK94ojN/6jtZB7K1V8PtUDgGSNa8ihYSz4pR2J/FYZJ8P437jxvonuoU16o0Bji2B4kDlhabehg==
X-Forefront-Antispam-Report:
	CIP:50.148.235.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:c-50-148-235-34.hsd1.mn.comcast.net;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(34020700016)(376014)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L5i2c6NQ4GHIIV/dbsOxD9HI66igwnYYtsOW/jDvW9OwTdDdgWBmgSFuZowtDEJ3iq+qobfmmnI+UDWnTpEPJcvgi+aZdgNdZpCyM8MPxiSVhxR7BIb4r9VOsS2jq0kwrcRiu/bJhoVdx9nEaPCXrWG+jm8JPWOCfAlp2jgmcFO59ZaBGqfGAi6/oG725d3tbCktrHMvyq9D8zR01MSDV+2Q9/kb+VEiJaSJjUPjib3x50luZW/YukINp1Qrq9OPeML2Cb16wycxF/kNZeI+MGUf0bqXhqqL+bj9wKTRlSKZbGh3mScET/4Awb9G3lksxAHNrmhE4K340Ae5Prjh2MsqhhS0JPUVczgJ9l2sD9McpkUe4T4GN0gpwUv4vFYs22IlfjmmCjZFwLVMGxi/QpsoiaYJvbKUR68HP5iunsWkKP9reiHDnt7V0RvtXoHY
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:54:41.3715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6978e6b-6bab-4a2c-6b61-08de7f97459a
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[50.148.235.34];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8565
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17995-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cornelisnetworks.com:dkim,cornelisnetworks.com:email,awdrv-04.cornelisnetworks.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4BDF22684BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the cport.c file which implements communication with the embedded
micro controller on the chip for port management operations.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/cport.c | 1037 ++++++++++++++++++++++++++++++++++++
 1 file changed, 1037 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/cport.c

diff --git a/drivers/infiniband/hw/hfi2/cport.c b/drivers/infiniband/hw/hfi2/cport.c
new file mode 100644
index 000000000000..026374a6e9fa
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/cport.c
@@ -0,0 +1,1037 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+/*
+ * Implementation details of CPORT communications.
+ */
+
+#include <linux/semaphore.h>
+#include <linux/io.h>
+
+#include "hfi2.h"
+#include "chip_jkr.h"
+#include "cport.h"
+
+static uint cport_ping_to;
+module_param_named(cport_ping_to, cport_ping_to, uint, 0644);
+MODULE_PARM_DESC(cport_ping_to, "ping timeout, seconds (0 = infinite)");
+
+uint cport_adm_to = 1;
+module_param_named(cport_adm_to, cport_adm_to, uint, 0644);
+MODULE_PARM_DESC(cport_adm_to, "cport admin msg timeout, seconds (0 = infinite)");
+
+static bool cport_mctxt_recovery = true;
+module_param_named(cport_mctxt_recovery, cport_mctxt_recovery, bool, 0644);
+MODULE_PARM_DESC(cport_mctxt_recovery, "Attempt recovery of MCTXT state");
+
+static void cport_send_req_fn(struct work_struct *work);
+static void cport_send_rsp_fn(struct work_struct *work);
+
+#undef CPORT_XA_DEBUG	/* every tid assigned from xarray */
+#undef CPORT_RCV_DEBUG	/* every message (header) received, and outbox empty */
+#undef CPORT_SND_DEBUG	/* every message (header) sent */
+#undef CPORT_INT_DEBUG	/* every interrupt processed, and status in timeouts */
+#define LOST_INT_DEBUG	/* print if lost intr detected */
+
+static int lost_int_set(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+	unsigned int *arg = kp->arg;
+	unsigned int old = *arg;
+	unsigned long index;
+	struct hfi2_devdata *dd;
+
+	ret = param_set_uint(val, kp);
+	if (ret)
+		return ret;
+
+	if (!old && *arg) {
+		xa_for_each(&hfi2_dev_table, index, dd) {
+			if (!dd->cport)
+				continue;
+			mod_timer(&dd->cport->lost_int_timer, jiffies + *arg);
+		}
+	}
+	return 0;
+}
+
+static const struct kernel_param_ops lost_int_ops = {
+	.set = lost_int_set,
+	.get = param_get_uint,
+};
+
+static unsigned int cport_lost_int = 1 * HZ;
+module_param_cb(cport_lost_int, &lost_int_ops, &cport_lost_int, 0644);
+MODULE_PARM_DESC(cport_lost_int, "Time period for MCTXT lost int check, jiffies");
+
+/*
+ * This limit needs to balance memory consuption against
+ * the need to ensure tids don't repeat during periods of
+ * CPORT stall and message timeout.
+ *
+ * Also note that the limit parameter passed to xa_alloc*()
+ * gets modified, so we cannot use a static structure here.
+ */
+#define cport_tid_limit	XA_LIMIT(0, 255)
+
+/*
+ * The "header" (first qword) of a message to/from CPORT.
+ */
+union cport_header {
+	struct {
+		u64 len:15;
+		u64 _resv1:1;
+		u64 is_req:1;
+		u64 no_rsp:1;
+		u64 seq_no:6;
+		u64 sts:8;
+		u64 tid:16;
+		u64 sideband:8;
+		u64 op_code:8;
+	};
+	u64 qw;
+};
+
+#define CPORT_SEQNO_MASK 0x3f
+
+#define CPORT_HDR_DEF	0x0000007ec0000000ul
+#define CPORT_HDR_LEN	48	/* bit position of length in CPORT_HDR_DEF */
+#define CPORT_HDR_SEQ	28	/* bit position of SEQ_NO */
+#define CPORT_HDR_EOM	30	/* bit position of EOM */
+#define CPORT_HDR_SOM	31	/* bit position of SOM */
+
+#define CPORT_IN_SCRATCH	(JKR_ASIC_CFG_SCRATCH + 0)
+#define CPORT_OUT_SCRATCH	(JKR_ASIC_CFG_SCRATCH + sizeof(u64))
+
+/*
+ * Assignment of bits in JKR_MCTXT_CPORT_INT_STATUS and
+ * JKR_MCTXT_PF0_INT_STATUS.
+ */
+#define JKR_MCTXT_INT_OUTBOX_EMPTY	0b00000001
+#define JKR_MCTXT_INT_INBOX_FULL	0b00000010
+
+/*
+ * The remainder is private to the host driver.
+ * CPORT firmware has no need of this interface.
+ */
+
+/*
+ * How the MCTXT CSRs are interpreted.
+ */
+union mctxt_mem {
+	union cport_header hdr;
+	u64 qw[JKR_C_MCTXT_MEM_SIZE_IN_QWORDS];
+};
+
+/*
+ * The common structure used to implement CPORT messages in hfi2.
+ */
+struct cport_work {
+	struct work_struct work;
+	struct kref kref;
+	int flags;
+	u8 n_mctxts; /* len of mctxt_mem req/rsp arrays */
+	u8 mctxts_done; /* number of mctxs sent/received */
+	long timeout;
+	struct semaphore *sem; /* only valid in send, if request w/response */
+	struct hfi2_devdata *dd; /* only valid in recv context */
+	union mctxt_mem *req;
+	union mctxt_mem *rsp;	/* only used for request w/response */
+};
+
+#define CW_FLAG_SEND		0x01	/* struct originated in send */
+#define CW_FLAG_RECV		0x02	/* struct originated in receive */
+
+/*
+ * Suspected lost interrupt, try to recover if possible.
+ */
+static void lost_mctxt_intr(struct hfi2_devdata *dd)
+{
+	u64 ints;
+
+	spin_lock(&dd->irq_src_lock); /* a compatible use of the lock */
+	ints = read_csr(dd, JKR_MCTXT_PF0_INT_STATUS_ENABLED);
+	/* if bits set, assume lost interrupt and attempt recovery. */
+	if (ints) {
+#ifdef LOST_INT_DEBUG
+		dd_dev_info(dd, "%s forcing int for %llx\n", __func__, ints);
+#endif
+		force_intr(dd, JKR_MCTXT_CPORT_TO_PCIE_INT);
+	}
+	spin_unlock(&dd->irq_src_lock);
+}
+
+static void cport_lost_int_chk(struct timer_list *t)
+{
+	struct hfi2_cport *cport = timer_container_of(cport, t, lost_int_timer);
+
+	if (cport_lost_int) {
+		lost_mctxt_intr(cport->dd);
+		mod_timer(&cport->lost_int_timer, jiffies + cport_lost_int);
+	}
+}
+
+/*
+ * Acquire a reference to the message structure
+ */
+static inline void cwget(struct cport_work *cw)
+{
+	kref_get(&cw->kref);
+}
+
+/*
+ * Locate and remove the 'id' message in the xarray and atomically
+ * acquire a reference to the message structure.
+ */
+static inline struct cport_work *cwget_xa(struct hfi2_devdata *dd, u32 id)
+{
+	struct cport_work *cw;
+
+	xa_lock(&dd->cport->tid_xa);
+	cw = __xa_erase(&dd->cport->tid_xa, id);
+	if (cw)
+		cwget(cw);
+	xa_unlock(&dd->cport->tid_xa);
+	return cw;
+}
+
+static void cwrelease(struct kref *kref)
+{
+	struct cport_work *cw = container_of(kref, struct cport_work, kref);
+
+	kfree(cw->req);
+	kfree(cw->rsp);
+
+	kfree(cw);
+}
+
+static void cwput(struct cport_work *cw)
+{
+	kref_put(&cw->kref, cwrelease);
+}
+
+static struct cport_work *cwalloc(int flag)
+{
+	struct cport_work *cw = kzalloc(sizeof(*cw), GFP_KERNEL);
+
+	if (!cw)
+		return NULL;
+
+	cw->flags = flag;
+	cw->n_mctxts = 1;
+	cw->req = kzalloc_obj(cw->req, GFP_KERNEL);
+	if (!cw->req) {
+		kfree(cw);
+		return NULL;
+	}
+
+	cw->rsp = kzalloc(sizeof(*cw->rsp), GFP_KERNEL);
+	if (!cw->rsp) {
+		kfree(cw->req);
+		kfree(cw);
+		return NULL;
+	}
+
+	kref_init(&cw->kref);
+	return cw;
+}
+
+/* set "external" (non-alloc) response payload */
+static void pld_rsp_set(struct cport_work *cw, void *pld, int len)
+{
+	memcpy(&cw->rsp->qw[1], pld, len);
+	cw->rsp->hdr.len = len + sizeof(cw->rsp->hdr);
+}
+
+static int cw_pad_size(struct cport_work *msg, u32 size)
+{
+	union mctxt_mem *new_reqs, *new_rsps;
+	u8 new_ctxts;
+
+	/* already large enough */
+	if (size <= msg->n_mctxts * (sizeof(*new_reqs)))
+		return 0;
+
+	/* round up to next mctxt buffer len */
+	new_ctxts = (size + (sizeof(*new_reqs) - 1)) / sizeof(*new_reqs);
+	new_reqs = krealloc(msg->req, new_ctxts * sizeof(*new_reqs),
+			    GFP_KERNEL);
+	if (!new_reqs)
+		return -ENOMEM;
+	msg->req = new_reqs;
+
+	new_rsps = krealloc(msg->rsp, new_ctxts * sizeof(*new_reqs),
+			    GFP_KERNEL);
+	if (!new_rsps)
+		return -ENOMEM;
+
+	msg->rsp = new_rsps;
+	msg->n_mctxts = new_ctxts;
+
+	return 0;
+}
+
+static int cwcopy(struct cport_work *msg, void *from, u32 offset,
+		  u32 len, bool req)
+{
+	union mctxt_mem *mc;
+	int ret;
+
+	ret = cw_pad_size(msg, offset + len);
+	if (ret)
+		return ret;
+
+	mc = req ? msg->req : msg->rsp;
+	memcpy(((u8 *)mc) + offset, from, len);
+
+	return 0;
+}
+
+/*
+ * Send request, non-blocking, with timeout for OUTBOX_EMPTY wait.
+ * Caller must watch 'wait' semaphore for completion, and
+ * then call cport_send_comp() or cport_send_cancel() to finalize everything.
+ * Returns handle for cport_send_comp()/_cancel(), or ERR_PTR().
+ *
+ * See cport_send_req() for example usage.
+ */
+void *cport_send_req_nb(struct hfi2_devdata *dd, u8 op, u8 sideband, void *payload,
+			int len, struct semaphore *wait, long timeout)
+{
+	int ret;
+	struct cport_work *msg;
+	u32 idx;
+
+	if (!dd->cport)
+		return ERR_PTR(-EINVAL);
+
+	msg = cwalloc(CW_FLAG_SEND);
+	if (!msg)
+		return ERR_PTR(-ENOMEM);
+	msg->dd = dd;
+	msg->timeout = timeout;
+	ret = cwcopy(msg, payload, sizeof(union cport_header), len, true);
+	if (ret) {
+		cwput(msg);
+		return ERR_PTR(ret);
+	}
+	ret = xa_alloc_cyclic(&dd->cport->tid_xa, &idx, msg, cport_tid_limit,
+			      &dd->cport->tid_next, GFP_KERNEL);
+	if (ret < 0) {
+		cwput(msg);
+		return ERR_PTR(ret);
+	}
+#ifdef CPORT_XA_DEBUG
+	dd_dev_info(dd, "CPORT tid is %04x\n", idx);
+#endif
+	msg->req->hdr.op_code = op;
+	msg->req->hdr.sideband = sideband;
+	msg->req->hdr.is_req = 1;
+	msg->req->hdr.no_rsp = 0;
+	msg->req->hdr.tid = idx;
+	msg->req->hdr.len = len + sizeof(msg->req->hdr);
+	msg->sem = wait;
+	cwget(msg);	/* extra ref so not freed after send */
+	INIT_WORK(&msg->work, cport_send_req_fn);
+	queue_work(dd->hfi2_wq, &msg->work);
+	return msg;
+}
+
+/*
+ * Extract results from response and drop (last) reference to structure.
+ * Returns status from response header.
+ * Must never be called twice for the same message (message has been freed).
+ * Must never be called on a message that has not received response (up'ed wait).
+ */
+int cport_send_comp(struct hfi2_devdata *dd, void *handle,
+		    void **rsp_pld, int *rsp_len)
+{
+	struct cport_work *msg = handle;
+	void *ptr;
+	int ret;
+	int len;
+
+	*rsp_len = len = msg->rsp->hdr.len - sizeof(msg->rsp->hdr);
+	if (rsp_pld) {
+		ptr = kzalloc(len, GFP_KERNEL);
+		if (!ptr)
+			return -ENOMEM;
+		memcpy(ptr, &msg->rsp[0].qw[1], len);
+		*rsp_pld = ptr;
+	}
+	ret = msg->rsp->hdr.sts;
+	cwput(msg);
+	return ret;
+}
+
+/*
+ * Cleanup aborted wait for response.
+ * Only called for requests w/responses.
+ * Must never be called twice for the same message (message has been freed).
+ */
+void cport_send_cancel(struct hfi2_devdata *dd, void *handle)
+{
+	struct cport_work *msg = handle;
+
+	cancel_work(&msg->work);	/* cport_send() drops ref on all paths */
+	xa_erase(&dd->cport->tid_xa, msg->req->hdr.tid);
+	cwput(msg);
+}
+
+/*
+ * Send request and wait for response, with timeout.
+ * Caller must be able to sleep.
+ * Returns status from response header, and response payload data, on success.
+ * Response payload was from k[z]alloc() and caller must kfree().
+ * On error, returns -errno (response status is always 0-15).
+ */
+int cport_send_req(struct hfi2_devdata *dd, u8 op, u8 sideband, void *payload, int len,
+		   void **rsp_pld, int *rsp_len, long timeout)
+{
+	int ret;
+	struct cport_work *msg;
+	struct semaphore comp;
+
+	sema_init(&comp, 0);
+
+	might_sleep();
+
+	msg = cport_send_req_nb(dd, op, sideband, payload, len, &comp, timeout);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+	if (timeout > 0 && timeout != MAX_SCHEDULE_TIMEOUT)
+		ret = down_timeout(&comp, timeout);
+	else
+		ret = down_killable(&comp);
+	if (ret) {
+#ifdef CPORT_INT_DEBUG
+		u64 ints;
+
+		ints = read_csr(dd, JKR_MCTXT_PF0_INT_STATUS);
+		dd_dev_err(dd, "CPORT request wait interrupted %016llx (%d) [%02llx]\n",
+			   msg->req->hdr.qw, ret, ints);
+#else
+		dd_dev_err(dd, "CPORT request wait interrupted %016llx (%d)\n",
+			   msg->req->hdr.qw, ret);
+#endif
+		cport_send_cancel(dd, msg);
+		lost_mctxt_intr(dd); /* attempt recovery */
+		return ret;
+	}
+	return cport_send_comp(dd, msg, rsp_pld, rsp_len);
+}
+
+int cport_send_notif(struct hfi2_devdata *dd, u8 op, u8 sideband, void *payload, int len,
+		     long timeout)
+{
+	struct cport_work *msg;
+	int ret;
+
+	if (!dd->cport)
+		return -EINVAL;
+
+	msg = cwalloc(CW_FLAG_SEND);
+	if (!msg)
+		return -ENOMEM;
+	msg->dd = dd;
+	msg->timeout = timeout;
+	ret = cwcopy(msg, payload, sizeof(union cport_header), len, true);
+	if (ret) {
+		cwput(msg);
+		return ret;
+	}
+	msg->req->hdr.len = len + sizeof(msg->req->hdr);
+	msg->req->hdr.op_code = op;
+	msg->req->hdr.sideband = sideband;
+	msg->req->hdr.is_req = 1;
+	msg->req->hdr.no_rsp = 1;
+	INIT_WORK(&msg->work, cport_send_req_fn);
+	queue_work(dd->hfi2_wq, &msg->work);
+	return 0;
+}
+
+/*
+ ********************************************************************
+ * Internal routines.
+ */
+
+/*
+ * Send a response to CPORT's request.
+ *
+ * Re-uses message structure from request. Queues to send workqueue.
+ */
+static int cport_send_rsp(struct cport_work *msg, int sts)
+{
+	struct hfi2_devdata *dd = msg->dd;
+
+	/* rsp.hdr.len and rsp.qw[1..] already setup, also rsp.op_code/rsp.tid */
+	msg->rsp->hdr.is_req = 0;
+	msg->rsp->hdr.sts = sts;
+	INIT_WORK(&msg->work, cport_send_rsp_fn);
+	queue_work(dd->hfi2_wq, &msg->work);
+	return 0;
+}
+
+static void cport_send(struct cport_work *msg, bool req)
+{
+	union mctxt_mem *mc = req ? msg->req : msg->rsp;
+	struct hfi2_devdata *dd = msg->dd;
+	u32 csr_i, tot_len, len_sent;
+	u64 cport_hdr;
+	u8 seq_no;
+	u64 *ptr;
+	int ret, mcxt_len;
+
+
+	/* sleep until OutboxEmpty... */
+	if (msg->timeout > 0 && msg->timeout != MAX_SCHEDULE_TIMEOUT)
+		ret = down_timeout(&dd->cport->outbox, msg->timeout);
+	else
+		ret = down_killable(&dd->cport->outbox);
+	if (ret) {
+		dd_dev_err(dd, "CPORT Send OUTBOX_EMPTY killed %016llx (%d)\n",
+			   msg->req->hdr.qw, ret);
+		cwput(msg);
+		lost_mctxt_intr(dd); /* attempt recovery */
+		return;	/* no way to report error to caller */
+	}
+
+	/* sequential under lock, check if there are unfinished messages */
+	if (dd->cport->incomplete_mctxt_msg_tx &&
+	    dd->cport->incomplete_mctxt_msg_tx != msg) {
+		/* give up empty outbox, the incomplete msg must finish next */
+		up(&dd->cport->outbox);
+		/* reschedule this work until next time */
+		queue_work(dd->hfi2_wq, &msg->work);
+		return;
+	}
+
+#ifdef CPORT_SND_DEBUG
+	dd_dev_info(dd, "MCTXT sent %016llx\n", mc->hdr.qw);
+#endif
+	tot_len = mc->hdr.len;
+	len_sent = msg->mctxts_done * sizeof(union mctxt_mem);
+	ptr = &mc[msg->mctxts_done].qw[0];
+	seq_no = msg->mctxts_done;
+	mcxt_len = min_t(int, (int)(tot_len - len_sent), sizeof(union mctxt_mem));
+	/* NOTE: "CPORT IN" is our output */
+	csr_i = JKR_MCTXT_CPORT_IN;
+	cport_hdr = CPORT_HDR_DEF;
+	cport_hdr |= ((u64)mcxt_len << CPORT_HDR_LEN);
+
+	cport_hdr |= (((u64)seq_no & 0x3) << CPORT_HDR_SEQ);
+
+	/* CPORT_HDR_DEF sets SOM/EOM, clear if not */
+	if (msg->mctxts_done)
+		cport_hdr &= ~((u64)1 << CPORT_HDR_SOM);
+	else
+		mc->hdr.seq_no = atomic_fetch_inc(&dd->cport->seqno);
+
+	if (msg->mctxts_done + 1 < msg->n_mctxts)
+		cport_hdr &= ~((u64)1 << CPORT_HDR_EOM);
+
+	write_csr(dd, CPORT_IN_SCRATCH, cport_hdr);
+	while (mcxt_len > 0) {
+		write_csr(dd, csr_i, *ptr++);
+		csr_i += sizeof(u64);
+		mcxt_len -= sizeof(u64);
+	}
+	write_csr(dd, JKR_MCTXT_CPORT_INT_STATUS, JKR_MCTXT_INT_INBOX_FULL);
+
+	/* did we complete the message? */
+	if (++msg->mctxts_done < msg->n_mctxts) {
+		dd->cport->incomplete_mctxt_msg_tx = msg;
+		queue_work(dd->hfi2_wq, &msg->work); /* reschedule the remaining sends */
+
+		return;
+	}
+
+	dd->cport->incomplete_mctxt_msg_tx = NULL;
+	/* reset mctxts_done for response parsing */
+	if (req)
+		msg->mctxts_done = 0;
+	cwput(msg); /* may or may not free memory */
+}
+
+/*
+ * Low-level send to CPORT via MCTXT.
+ *
+ * Interfaces with MCTXT.
+ */
+static void cport_send_req_fn(struct work_struct *work)
+{
+	struct cport_work *msg = container_of(work, struct cport_work, work);
+
+	cport_send(msg, true);
+}
+
+static void cport_send_rsp_fn(struct work_struct *work)
+{
+	struct cport_work *msg = container_of(work, struct cport_work, work);
+
+	cport_send(msg, false);
+}
+
+static int echo_req(struct hfi2_devdata *dd, u8 op, u8 sideband,
+		    void *pld, int pll, void *handle)
+{
+	struct cport_work *msg = handle;
+
+	dd_dev_info(msg->dd, "cport ping %02x (%d)\n", sideband, pll);
+	/* Leave payload in-tact (echo). */
+	pld_rsp_set(msg, pld, pll);
+	return MSG_RSP_STATUS_OK;
+}
+
+static int inval_req(struct hfi2_devdata *dd, u8 op, u8 sideband,
+		     void *pld, int pll, void *handle)
+{
+	return MSG_RSP_STATUS_OPCODE_UNSUPPORTED;
+}
+
+/*
+ * Process a request from CPORT.
+ *
+ * May be dispatched to external function from handlers[].
+ */
+static void cport_req_fn(struct work_struct *work)
+{
+	struct cport_work *msg = container_of(work, struct cport_work, work);
+	cport_handler func;
+	int ret = MSG_RSP_STATUS_OK;
+	void *pld;
+	int pll;
+
+	pll = msg->req->hdr.len - sizeof(msg->req->hdr);
+	pld = &msg->req->qw[1];
+	msg->rsp->hdr.qw = msg->req->hdr.qw;
+	/* default to no payload in response (if any) */
+	msg->rsp->hdr.len = sizeof(msg->req->hdr);
+	func = msg->dd->cport->handlers[msg->req->hdr.op_code];
+	if (func)
+		ret = func(msg->dd, msg->req->hdr.op_code, msg->req->hdr.sideband,
+			   pld, pll, msg);
+	else
+		ret = inval_req(msg->dd, msg->req->hdr.op_code, msg->req->hdr.sideband,
+				pld, pll, msg);
+	if (msg->req->hdr.no_rsp) {
+		cwput(msg);
+		if (ret)
+			dd_dev_err(msg->dd, "Op %d %02x failed (%d)\n",
+				   msg->req->hdr.op_code, msg->req->hdr.sideband, ret);
+	} else {
+		/* msg->rsp->qw[*] and msg->rsp->hdr.len have been updated */
+		ret = cport_send_rsp(msg, ret);
+		if (ret)
+			dd_dev_err(msg->dd, "Response send failed (%d)\n", ret);
+	}
+}
+
+/*
+ * Handler for MCTXT Inbox Full interrupt.
+ *
+ * Only one can be queued/run until JKR_MCTXT_INT_OUTBOX_EMPTY is cleared.
+ * Run in a workqueue (not interrupt context).
+ */
+static void cport_mctxt_fn(struct work_struct *work)
+{
+	struct hfi2_cport *cport = container_of(work, struct hfi2_cport, mctxt_work);
+	struct hfi2_devdata *dd = cport->dd;
+	int ret = 0;
+	u8 is_start, is_end;
+	int len;
+	u64 *ptr;
+	u64 mhdr;
+	u32 i;
+	struct cport_work *msg;
+	union cport_header hdr;
+
+	/*
+	 * CPORT output MCTXT is our input.
+	 */
+	i = JKR_MCTXT_CPORT_OUT;
+
+	mhdr = read_csr(dd, CPORT_OUT_SCRATCH);
+	len = (mhdr >> CPORT_HDR_LEN) & 0xfff;
+	len = min_t(int, len, sizeof(union mctxt_mem));
+	is_start = (mhdr >> CPORT_HDR_SOM) & 1;
+	is_end = (mhdr >> CPORT_HDR_EOM) & 1;
+	if (is_start) {
+		hdr.qw = read_csr(dd, i);
+	} else if (cport->incomplete_mctxt_msg_rx) {
+		msg = cport->incomplete_mctxt_msg_rx;
+		if (msg->flags & CW_FLAG_RECV) {
+			ptr = &msg->req[msg->mctxts_done++].qw[0];
+			hdr.qw = msg->req->hdr.qw;
+		} else {
+			ptr = &msg->rsp[msg->mctxts_done++].qw[0];
+			hdr.qw = msg->rsp->hdr.qw;
+		}
+		dd_dev_info(dd, "%s: got continuation of %u\n",
+			    __func__, hdr.seq_no);
+		/* skip all the start-message parsing/allocation */
+		goto copy;
+	} else {
+		/* this is bad, just skip the message */
+		dd_dev_warn(dd, "cport sent unexpected non-start packet\n");
+		goto fail;
+	}
+#ifdef CPORT_RCV_DEBUG
+	dd_dev_info(dd, "%s() %016llx\n", __func__, hdr.qw);
+#endif
+	if (hdr.len < sizeof(hdr)) {
+		/* assume message is invalid  - cannot be processed */
+		ret = -EDOM;
+		goto fail;
+	}
+	i += sizeof(u64);
+	/* No need for atomics here, we are single threaded */
+	if (hdr.seq_no != cport->rseqno) {
+		dd_dev_info(dd, "Recv out of sequence: %d -> %d\n", cport->rseqno, hdr.seq_no);
+		cport->rseqno = hdr.seq_no;
+	}
+	cport->rseqno = (cport->rseqno + 1) & CPORT_SEQNO_MASK;
+	if (hdr.is_req) {
+		/* Request from CPORT, has no existing message context */
+		msg = cwalloc(CW_FLAG_RECV);
+		if (!msg) {
+			ret = -ENOMEM;
+			goto fail; /* drop message, with error */
+		}
+		ret = cw_pad_size(msg, hdr.len);
+		if (ret)
+			goto fail;
+		ptr = &msg->req->qw[msg->mctxts_done++];
+	} else {
+		/*
+		 * Responses already have a 'msg', extra ref was already taken.
+		 * Take an additional ref against possible race with timeout
+		 * (cport_send_cancel()) between here and the up().
+		 */
+		msg = cwget_xa(dd, hdr.tid);
+		if (!msg) {
+			ret = -ESRCH;
+			goto fail; /* drop message, with error */
+		}
+		ret = cw_pad_size(msg, hdr.len);
+		if (ret)
+			goto fail;
+		ptr = &msg->rsp->qw[msg->mctxts_done++];
+		/* assert msg->req->hdr ~= hdr */
+	}
+	*ptr++ = hdr.qw;
+	len -= sizeof(hdr);
+copy:
+	/* now copy payload into chosen buffer */
+	while (len > 0) {
+		*ptr++ = read_csr(dd, i);
+		i += sizeof(u64);
+		len -= sizeof(u64);
+	}
+	/*
+	 * We are finished with the dd->cport->mctxt_work struct,
+	 * and the MCTXT, so it can all be re-used now.
+	 */
+	write_csr(dd, JKR_MCTXT_CPORT_INT_STATUS, JKR_MCTXT_INT_OUTBOX_EMPTY);
+#ifdef CPORT_RCV_DEBUG
+	dd_dev_info(dd, "%s() set CPORT OUTBOX_EMPTY\n", __func__);
+#endif
+	/*
+	 * if we do not contain the end of the message then we need to wait
+	 * until next mailbox
+	 */
+	if (!is_end) {
+		cport->incomplete_mctxt_msg_rx = msg;
+		dd_dev_info(dd, "%s: expecting continuation of %u\n",
+			    __func__, hdr.seq_no);
+		return;
+	}
+	cport->incomplete_mctxt_msg_rx = NULL;
+
+	/* responses don't require any more work here - just wakeup requester */
+	if (!hdr.is_req) {
+		up(msg->sem);
+		cwput(msg);
+		return;
+	}
+	msg->dd = dd;
+
+	/* reset mctxts for response parsing */
+	msg->mctxts_done = 0;
+
+	/* dispatch 'msg' request */
+	INIT_WORK(&msg->work, cport_req_fn);
+	/* don't care about locality */
+	queue_work(dd->hfi2_wq, &msg->work);
+	return;
+fail:
+	write_csr(dd, JKR_MCTXT_CPORT_INT_STATUS, JKR_MCTXT_INT_OUTBOX_EMPTY);
+	dd_dev_err(dd, "Dropping incoming CPORT message %016llx (%d)\n", hdr.qw, ret);
+}
+
+/*
+ * Handler for PF0 MCTXT interrupts.
+ *
+ * Called when one of the enabled MCTXT_PF0 conditions occurs.
+ * 'source' is always 0. Called in interrupt context.
+ *
+ * Since this interrupt is exclusive to MCTXT, there is no doubt
+ * about which transport to use (always is MCTXT).
+ */
+void is_cport_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	u64 ints;
+	const int limit = 100; /* arbitrary */
+	int count;
+
+	if (!dd->cport)
+		return;
+
+	/*
+	 * MctxtCportToPcieInt is a "one shot" merged interrupt.  To ensure
+	 * nothing is missed, ensure that its source, MctxtPf0IntStatusEnabled,
+	 * is cleared and reads as zero.
+	 */
+	ints = 0;
+	for (count = 0; count < limit; count++) {
+		u64 temp;
+
+		temp = read_csr(dd, JKR_MCTXT_PF0_INT_STATUS_ENABLED);
+		if (temp == 0)
+			break;
+		ints |= temp;
+		write_csr(dd, JKR_MCTXT_PF0_INT_ACK, temp);
+	}
+	if (count == limit)
+		dd_dev_warn(dd, "MCTXT interrupt too many loops\n");
+	if (!ints) {
+		dd_dev_warn(dd, "MCTXT interrupt, but no status bits set\n");
+		return;
+	}
+
+#ifdef CPORT_INT_DEBUG
+	dd_dev_info(dd, "%s() %02llx\n", __func__, ints);
+#endif
+	if (ints & JKR_MCTXT_INT_INBOX_FULL)
+		queue_work(dd->hfi2_wq, &dd->cport->mctxt_work);
+	if (ints & JKR_MCTXT_INT_OUTBOX_EMPTY)
+		up(&dd->cport->outbox);
+}
+
+/***************************************************
+ * API for handling notifications from CPORT
+ */
+
+int cport_resp_set(void *handle, void *payload, int len)
+{
+	struct cport_work *msg = handle;
+
+	if (!msg || !payload || len <= 0)
+		return -EINVAL;
+	msg->rsp->hdr.len = len + sizeof(msg->rsp->hdr);
+	memcpy(&msg->rsp->qw[1], payload, len);
+	return 0;
+}
+
+int cport_register_cb(struct hfi2_devdata *dd, u8 op_start, u8 op_end, cport_handler func)
+{
+	int x;
+
+	if (op_start > op_end || op_start < 0 || op_end >= 256)
+		return -ERANGE;
+	if (!dd->cport)
+		return -EINVAL;
+
+	/* 'func' may be NULL, to unregister */
+	for (x = op_start; x <= op_end; ++x) {
+		dd->cport->handlers[x] = func;
+	}
+	return 0;
+}
+
+static int cport_ping(void *data)
+{
+	struct hfi2_devdata *dd = data;
+	char buf[16];
+	int len;
+	unsigned int num;
+	void *rspbuf;
+	int rsplen;
+	int rc;
+
+	while (!kthread_should_stop() && (num = atomic_read(&dd->cport->nping)) > 0) {
+		len = snprintf(buf, sizeof(buf), "ping %u", num);
+		rspbuf = NULL;
+		rc = cport_send_req(dd, CH_OP_PING, 0, buf, len,
+				    &rspbuf, &rsplen,
+				    cport_ping_to ? cport_ping_to * HZ :
+						    MAX_SCHEDULE_TIMEOUT);
+		if (rc < 0) {
+			dd_dev_info(dd, "CPORT \"%s\" error %d\n", buf, rc);
+			if (!cport_ping_to)
+				break;
+		} else {
+			dd_dev_info(dd, "CPORT \"%s\" -> %d \"%.*s\"\n",
+				    buf, rc, rsplen, (char *)rspbuf);
+		}
+		kfree(rspbuf);
+		atomic_dec(&dd->cport->nping);
+	}
+	dd->cport->ping_th = NULL;
+	atomic_set(&dd->cport->nping, 0);
+	return 0;
+}
+
+int cport_ping_start(struct hfi2_devdata *dd, unsigned int count)
+{
+	int rc;
+
+	if (!count) {
+		if (dd->cport->ping_th)
+			kthread_stop(dd->cport->ping_th);
+			/* kthread will zero count when exiting */
+		else
+			atomic_set(&dd->cport->nping, 0);
+		return 0;
+	}
+	atomic_set(&dd->cport->nping, count);
+	if (dd->cport->ping_th)
+		return 0;
+
+	dd->cport->ping_th = kthread_create_on_node(cport_ping, dd, dd->node, "cport_ping");
+	if (IS_ERR(dd->cport->ping_th)) {
+		rc = PTR_ERR(dd->cport->ping_th);
+		dd->cport->ping_th = NULL;
+		dd_dev_err(dd, "Failed to create CPORT ping thread %d\n", rc);
+		return rc;
+	}
+	wake_up_process(dd->cport->ping_th);
+	return 0;
+}
+
+#ifdef CONFIG_HFI_CPORT_POLLING
+static int cport_poll(void *data)
+{
+	struct hfi2_devdata *dd = data;
+	u64 v;
+
+	while (!kthread_should_stop()) {
+		v = read_csr(dd, JKR_MCTXT_PF0_INT_STATUS);
+		if (v & 0xff)
+			is_cport_int(dd, 0);
+		fsleep(30);
+	}
+	return 0;
+}
+#endif
+
+/*
+ * Initialization/setup of MCTXT CPORT communications channel.
+ */
+int cport_init(struct hfi2_devdata *dd)
+{
+	struct hfi2_cport *cport;
+
+	if (dd->params->chip_type == CHIP_WFR || dd->is_vf)
+		return 0;
+
+	cport = kzalloc_obj(cport, GFP_KERNEL);
+	if (!cport)
+		goto err1;
+
+	INIT_WORK(&cport->mctxt_work, cport_mctxt_fn);
+	xa_init_flags(&cport->tid_xa, XA_FLAGS_ALLOC);
+	xa_init_flags(&cport->trap_xa, XA_FLAGS_ALLOC);
+
+	/*
+	 * Setting initial state can be problematic.
+	 * We require that CPORT set JKR_MCTXT_INT_OUTBOX_EMPTY in
+	 * JKR_MCTXT_PF0_INT_STATUS or we will never start sending.
+	 * We also require that CPORT never set JKR_MCTXT_INT_OUTBOX_EMPTY
+	 * gratuitously, or we get a semaphore count > 1 and will
+	 * start overrunning MCTXT. Essentially, CPORT must set this
+	 * exactly once when entering the "ready to receive" state
+	 * (initially and after processing each message).
+	 */
+	sema_init(&cport->outbox, 0);
+
+	cport->dd = dd;
+	dd->cport = cport;
+
+	cport_register_cb(dd, CH_OP_PING, CH_OP_PING, echo_req);
+
+	if (cport_mctxt_recovery) {
+		u64 is, ie;
+
+		is = read_csr(dd, JKR_MCTXT_PF0_INT_STATUS);
+		ie = read_csr(dd, JKR_MCTXT_PF0_INT_ENABLE);
+		if (!(is & JKR_MCTXT_INT_OUTBOX_EMPTY) && ie) {
+			dd_dev_warn(dd, "recovering CPORT MCTXT state\n");
+			write_csr(dd, JKR_MCTXT_PF0_INT_ENABLE, 0);
+			write_csr(dd, JKR_MCTXT_PF0_INT_STATUS, JKR_MCTXT_INT_OUTBOX_EMPTY);
+		}
+	}
+
+#ifdef CONFIG_HFI_CPORT_POLLING
+	cport->poll_th = kthread_create_on_node(cport_poll, dd, dd->node, "cport_poll");
+	if (!cport->poll_th)
+		dd_dev_err(dd, "Failed to create CPORT polling thread\n");
+	else
+		wake_up_process(dd->cport->poll_th);
+#else
+	/* Enable intr source for MCTXT from CPORT (to PF0) */
+	write_csr(dd, JKR_MCTXT_PF0_INT_ENABLE,
+		  JKR_MCTXT_INT_INBOX_FULL | JKR_MCTXT_INT_OUTBOX_EMPTY);
+	set_intr_bits(dd, JKR_MCTXT_CPORT_TO_PCIE_INT, JKR_MCTXT_CPORT_TO_PCIE_INT, true);
+	timer_setup(&cport->lost_int_timer, cport_lost_int_chk, 0);
+	if (cport_lost_int)
+		mod_timer(&cport->lost_int_timer, jiffies + cport_lost_int);
+#endif
+
+	/*
+	 * Must reset/resync sequence numbers as CPORT is strictly enforcing
+	 * sequence number order. Use a timeout to allow easier cleanup should
+	 * init fail.
+	 */
+	cport_send_notif(dd, CH_OP_PING, 0, NULL, 0, cport_adm_to * HZ);
+	return 0;
+
+err1:
+	return -ENOMEM;
+}
+
+/*
+ * Deinitialization of MCTXT CPORT communications channel.
+ */
+int cport_exit(struct hfi2_devdata *dd)
+{
+	if (!dd->cport)
+		return 0;
+
+	timer_delete_sync(&dd->cport->lost_int_timer);
+	/* flush all cport queued tasks (plus anything else on this queue) */
+	flush_workqueue(dd->hfi2_wq);
+
+	/* Disable intr source for MCTXT from CPORT (to PF0) */
+	set_intr_bits(dd, JKR_MCTXT_CPORT_TO_PCIE_INT, JKR_MCTXT_CPORT_TO_PCIE_INT, false);
+	write_csr(dd, JKR_MCTXT_PF0_INT_ENABLE, 0);
+	/* leave JKR_MCTXT_INT_OUTBOX_EMPTY set so that future users are ready-to-go */
+	write_csr(dd, JKR_MCTXT_PF0_INT_STATUS, JKR_MCTXT_INT_OUTBOX_EMPTY);
+#ifdef CONFIG_HFI_CPORT_POLLING
+	if (dd->cport->poll_th)
+		kthread_stop(dd->cport->poll_th);
+#endif
+	if (dd->cport->ping_th)
+		kthread_stop(dd->cport->ping_th);
+
+	cancel_work(&dd->cport->mctxt_work);
+
+	xa_destroy(&dd->cport->tid_xa);
+	xa_destroy(&dd->cport->trap_xa);
+	kfree(dd->cport);
+	dd->cport = NULL;
+
+	return 0;
+}



