Return-Path: <linux-rdma+bounces-22515-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5F5JJoX5P2qSawkAu9opvQ
	(envelope-from <linux-rdma+bounces-22515-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 18:25:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0F46D23FD
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 18:25:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cornelisnetworks.com header.s=selector1 header.b=gcN2CPA6;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22515-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22515-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cornelisnetworks.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C9583010265
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FECA2BEC5F;
	Sat, 27 Jun 2026 16:25:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021084.outbound.protection.outlook.com [52.101.57.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F182F0661
	for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2026 16:25:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782577535; cv=fail; b=PTCOuf/ljTt1IuRi74quRGRz9HMbEgaF7+N6UFtNFNx6dhdmYwBuRPfg2O6/kBZtub+Ap9K8XSprs1P9/MiNljVVuJNnGdCFRYd97tDpBByG5Wy94SnzTqCAwlhmd74ArERq1V/shHf8OPnbnmf2nJdCsjs4AzwLc/prj9FGywo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782577535; c=relaxed/simple;
	bh=+yTtC9j6lXqeW85WEy6o76by3cNBkoVHqcui3DIYSwo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rT6JFTlTdNhYV3mkPcCJhz4IiLtoISBUeZLg0daNHCZTD6SgF8sbEGFBYy3qdHx76uudqtzZ3oYvhrIg+J55N8EEUM8UX1oPmBFEpoUCSTbqftvIzmLvXnI2Gk3QUfAcP3roJk5R9MN6obkqhz1uF3DZqNBzCTWoZ8G+v4eSezk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=gcN2CPA6; arc=fail smtp.client-ip=52.101.57.84
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLuU731zlD6jf7cEZp2JaN0t6uscbRUdqFAqsHQB/TC862eQ6fq4d9aTzNBQST7bAMR9agyvZO0x5/40WepqDT73H5x5uQdaXq6aE3vBhFl+tHQN/XyFiSi4jGB0e1dPoxV3OgcQXUCY7PtQoPRTv2icijo0W5oZWbooUqkuPfJqygDT757Q9QHEMe0bhJlg4v30Kmt/6aJmzciJ53OrO1msS40GAXa441NS7sYX/P23vbiD8QHBUzhjmMQYM9IZ78PK1oiVqrR4yeDvRJji9FqJDhr3oUfXhTLFrwVYnbrT0WV9LNqXdNTVS0HR8IHm2nADhzOILdmcdTJlYUrgJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gJaRONJwCuN3oS63ZcSo1hxvf0nFXc5JWxlHjqnjbI=;
 b=UCDAH04qS8ygbk07bjtEFZDUc89KAktuO+NRFftE2FZjB/WDjHl5SDf8xfWgOOPXjkHQRPeXgebP7jjMdqkoxN2e6VyYoD5su8rP8BTuKpBPtRl1TCZrm/UippYqPAOs72odoCTm/kc5aJQJ1y/S5fsnm0zhF0adqeq5xyEw+BIJT3id6G96n8qoEgfcfevy0+K4lH7J0vF1cLSdqqjbAJddu+ZmgA9ASlAkt4Ul9BL6ggqGinnFrbmFb+lzEJpP+a6DXtiF6zu+mDl711PJCmnGRzaAuWyd2btthI6uW8jwjXwsplVQaQy6KwAJWUCK+udezGbbQZ4riq0ZMB96/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.148.235.34) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gJaRONJwCuN3oS63ZcSo1hxvf0nFXc5JWxlHjqnjbI=;
 b=gcN2CPA6lCmFT1eDSuEgf6XM/sxL3x5kQiU5wxeAHCWGQaBLl8fWzEBNA2JHEhr1THBP9x3qUmfHbboFPcyUOS5L1a9iFnMlhnMK3If/fOvxejx1r+yeTL4ArDu90UxanhlqLD56HR1Y7oKZCtErfsOneRRd94eJ+8UI/6XZ7DVrnUgBjNMcRwphs2e9W6iIu+2QedW+ua3EmGwS2hQbhHRtKhQ4Bm+GI7IusFIfleteVZs2TTBDguoB/j8E1eSraOa5wUm8pVTZX18ObRRuvNHVm+JDqK8nmGt0V7XCfGfgPTA68OxB5UKIlKbRDuXoosZtR/7haoKHUApn/LrpBg==
Received: from BY3PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:39a::19)
 by DS0PR01MB8036.prod.exchangelabs.com (2603:10b6:8:14c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Sat, 27 Jun 2026 16:25:26 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::3) by BY3PR03CA0014.outlook.office365.com
 (2603:10b6:a03:39a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Sat,
 27 Jun 2026 16:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.148.235.34)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=cornelisnetworks.com;
Received-SPF: Fail (protection.outlook.com: domain of cornelisnetworks.com
 does not designate 50.148.235.34 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.148.235.34;
 helo=cn-mailer-00.localdomain;
Received: from cn-mailer-00.localdomain (50.148.235.34) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Sat, 27 Jun 2026 16:25:25 +0000
Received: from awdrv-04.localdomain (unknown [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id CD605146565;
	Sat, 27 Jun 2026 12:25:24 -0400 (EDT)
Received: from [10.228.212.218] (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id C92261810D6C7;
	Sat, 27 Jun 2026 12:25:24 -0400 (EDT)
Subject: [PATCH v2 for-next 06/24] RDMA/hfi2: Add in trace support
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org
Date: Sat, 27 Jun 2026 12:25:24 -0400
Message-ID: <178257752478.371918.5568861705468714220.stgit@awdrv-04>
In-Reply-To: <178257721001.371918.6610421101075283586.stgit@awdrv-04>
References: <178257721001.371918.6610421101075283586.stgit@awdrv-04>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|DS0PR01MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c36b8fa-62fd-4492-3c5d-08ded468b1c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|55112099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OiOKZ8vqlabfKWew/bjZ2x9XwBEFltNwjO93FSxsBXHBnhpzTzVWc1oGcabFTAMlshezxlk3gNQW2awDlPzKpOmUDzFdsS8Sd2MCLtO49PS4rBoeEmAuzcMMVtH5W0G72FR4IarAMIIOEQGoVeBiqKLd/N9WKyMwVQHMB9w+qce5IHtthy60IkzFy7VWi/v/O+vEnNYx46rwLEI93w8hoEoA4GuC26x8TJANo7TY4pPlrTVolnEB0NrLxKIrqV3D0taksa0yEhqIP9SYAM1JUxgolBTy1iKzUYNgjqts0ACC14aOA3y/n7tPOoT4cKDd+P1D2LTa8/26TV2fRx/M9OjlvOPYCxl1w/4ueAT0TSCfO+ItGoShoKw1sIBx1QhRMOnUwuyT9HmrvRCm7mdGzgsUCxw4MVeKYK7Z7o639LUTtOvntYxGjomIKK/XzA4QfufBG5yJo2NvgQRg+h58DIvTKjkZBanb8Ipbl76XVm7yhhM+Zg+1BNU0CTaCWMvwLUR0pDgJeXi5boX0ImeQQcaEuR09NL1xojjS4JGJk3OIet2lCUf62ZzLT46iuiJiqIU1nvGspbkJfVTQgAjFpmyNKSsR3fggy4T4PUENL9vC0RBbpVUjesV7Frji87/ECrrB0vCjVFCmdBWMlZ/JFhn4BB3upIkxqYCZqRUD9l3pyOn+8flanAHqAVmHUg3VVBN2ghyamnG7O+tRsmroeg==
X-Forefront-Antispam-Report:
	CIP:50.148.235.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(55112099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FlElosxdQxLIcekBsMi1tjZoKTp/JdLRHleGMsOBTcukMxvxPXpUXIYqpbff79KHpq/Br5FJ4JFDpA4oQQ2RqPz/L8pRETfTFUzpJIRnyKl+cD0C5JlH4FU9ioGEPLE3xmFC81af08wDJ3EQpLdB4rGx+HKap4hnrA5ldrAFlx1Ci5gHd7m6lDEnZoHmt10SvH8/t5cJV36IXDussU4TzAZVMAHAHyl+eRCKHOBiSbZHB6r4CuAGRmzXft3mfhk3TA6QigoYt4x+rGn6HYksyIl0IW0dr0oSxXoIq/PnxFDDDX+wiPPvaRt+Xu5o9Kj/jsB1E5j93GBFRvoQ98T1zR8s52OMqz8cqNrF6Q9wQ4k5UDblm/r4b9kZYbbAgw+SxjpTP2rkm4X2EppXfOkxGM+Acqw9ciew19WXJwrI0WG+TtKIn3X73nYQEOlilI/p
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 16:25:25.5712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c36b8fa-62fd-4492-3c5d-08ded468b1c8
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[50.148.235.34];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR01MB8036
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22515-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dean.luick@cornelisnetworks.com,m:brendan.cunningham@cornelisnetworks.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[awdrv-04:mid,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB0F46D23FD

Adds the base trace event support for the driver.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/trace.c |  536 ++++++++++++++++++++++++++++++++++++
 1 file changed, 536 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/trace.c

diff --git a/drivers/infiniband/hw/hfi2/trace.c b/drivers/infiniband/hw/hfi2/trace.c
new file mode 100644
index 000000000000..c9c5e8687a60
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/trace.c
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+#include "exp_rcv.h"
+#include "ipoib.h"
+
+static u8 __get_ib_hdr_len(struct ib_header *hdr)
+{
+	struct ib_other_headers *ohdr;
+	u8 opcode;
+
+	if (ib_get_lnh(hdr) == HFI2_LRH_BTH)
+		ohdr = &hdr->u.oth;
+	else
+		ohdr = &hdr->u.l.oth;
+	opcode = ib_bth_get_opcode(ohdr);
+	return hfi2_hdr_len_by_opcode[opcode] == 0 ?
+	       0 : hfi2_hdr_len_by_opcode[opcode] - (12 + 8);
+}
+
+static u8 __get_16b_hdr_len(struct hfi2_16b_header *hdr)
+{
+	struct ib_other_headers *ohdr = NULL;
+	u8 opcode;
+	u8 l4 = hfi2_16B_get_l4(hdr);
+
+	if (l4 == OPA_16B_L4_FM) {
+		opcode = IB_OPCODE_UD_SEND_ONLY;
+		return (8 + 8); /* No BTH */
+	}
+
+	if (l4 == OPA_16B_L4_IB_LOCAL)
+		ohdr = &hdr->u.oth;
+	else
+		ohdr = &hdr->u.l.oth;
+
+	opcode = ib_bth_get_opcode(ohdr);
+	return hfi2_hdr_len_by_opcode[opcode] == 0 ?
+	       0 : hfi2_hdr_len_by_opcode[opcode] - (12 + 8 + 8);
+}
+
+u8 hfi2_trace_packet_hdr_len(struct hfi2_packet *packet)
+{
+	if (packet->etype != RHF_RCV_TYPE_BYPASS)
+		return __get_ib_hdr_len(packet->hdr);
+	else
+		return __get_16b_hdr_len(packet->hdr);
+}
+
+u8 hfi2_trace_opa_hdr_len(struct hfi2_opa_header *opa_hdr)
+{
+	if (!opa_hdr->hdr_type)
+		return __get_ib_hdr_len(&opa_hdr->ibh);
+	else
+		return __get_16b_hdr_len(&opa_hdr->opah);
+}
+
+const char *hfi2_trace_get_packet_l4_str(u8 l4)
+{
+	if (l4)
+		return "16B";
+	else
+		return "9B";
+}
+
+const char *hfi2_trace_get_packet_l2_str(u8 l2)
+{
+	switch (l2) {
+	case 0:
+		return "0";
+	case 1:
+		return "1";
+	case 2:
+		return "16B";
+	case 3:
+		return "9B";
+	}
+	return "";
+}
+
+#define IMM_PRN  "imm:%d"
+#define RETH_PRN "reth vaddr:0x%.16llx rkey:0x%.8x dlen:0x%.8x"
+#define AETH_PRN "aeth syn:0x%.2x %s msn:0x%.8x"
+#define DETH_PRN "deth qkey:0x%.8x sqpn:0x%.6x"
+#define DETH_ENTROPY_PRN "deth qkey:0x%.8x sqpn:0x%.6x entropy:0x%.2x"
+#define IETH_PRN "ieth rkey:0x%.8x"
+#define ATOMICACKETH_PRN "origdata:%llx"
+#define ATOMICETH_PRN "vaddr:0x%llx rkey:0x%.8x sdata:%llx cdata:%llx"
+#define TID_RDMA_KDETH "kdeth0 0x%x kdeth1 0x%x"
+#define TID_RDMA_KDETH_DATA "kdeth0 0x%x: kver %u sh %u intr %u tidctrl %u tid %x offset %x kdeth1 0x%x: jkey %x"
+#define TID_READ_REQ_PRN "tid_flow_psn 0x%x tid_flow_qp 0x%x verbs_qp 0x%x"
+#define TID_READ_RSP_PRN "verbs_qp 0x%x"
+#define TID_WRITE_REQ_PRN "original_qp 0x%x"
+#define TID_WRITE_RSP_PRN "tid_flow_psn 0x%x tid_flow_qp 0x%x verbs_qp 0x%x"
+#define TID_WRITE_DATA_PRN "verbs_qp 0x%x"
+#define TID_ACK_PRN "tid_flow_psn 0x%x verbs_psn 0x%x tid_flow_qp 0x%x verbs_qp 0x%x"
+#define TID_RESYNC_PRN "verbs_qp 0x%x"
+
+#define OP(transport, op) IB_OPCODE_## transport ## _ ## op
+
+static const char *parse_syndrome(u8 syndrome)
+{
+	switch (syndrome >> 5) {
+	case 0:
+		return "ACK";
+	case 1:
+		return "RNRNAK";
+	case 3:
+		return "NAK";
+	}
+	return "";
+}
+
+void hfi2_trace_parse_9b_bth(struct ib_other_headers *ohdr,
+			     u8 *ack, bool *becn, bool *fecn, u8 *mig,
+			     u8 *se, u8 *pad, u8 *opcode, u8 *tver,
+			     u16 *pkey, u32 *psn, u32 *qpn)
+{
+	*ack = ib_bth_get_ackreq(ohdr);
+	*becn = ib_bth_get_becn(ohdr);
+	*fecn = ib_bth_get_fecn(ohdr);
+	*mig = ib_bth_get_migreq(ohdr);
+	*se = ib_bth_get_se(ohdr);
+	*pad = ib_bth_get_pad(ohdr);
+	*opcode = ib_bth_get_opcode(ohdr);
+	*tver = ib_bth_get_tver(ohdr);
+	*pkey = ib_bth_get_pkey(ohdr);
+	*psn = mask_psn(ib_bth_get_psn(ohdr));
+	*qpn = ib_bth_get_qpn(ohdr);
+}
+
+void hfi2_trace_parse_16b_bth(struct ib_other_headers *ohdr,
+			      u8 *ack, u8 *mig, u8 *opcode,
+			      u8 *pad, u8 *se, u8 *tver,
+			      u32 *psn, u32 *qpn)
+{
+	*ack = ib_bth_get_ackreq(ohdr);
+	*mig = ib_bth_get_migreq(ohdr);
+	*opcode = ib_bth_get_opcode(ohdr);
+	*pad = ib_bth_get_pad(ohdr);
+	*se = ib_bth_get_se(ohdr);
+	*tver = ib_bth_get_tver(ohdr);
+	*psn = mask_psn(ib_bth_get_psn(ohdr));
+	*qpn = ib_bth_get_qpn(ohdr);
+}
+
+void hfi2_trace_parse_9b_hdr(struct ib_header *hdr, bool sc5,
+			     u8 *lnh, u8 *lver, u8 *sl, u8 *sc,
+			     u16 *len, u32 *dlid, u32 *slid)
+{
+	*lnh = ib_get_lnh(hdr);
+	*lver = ib_get_lver(hdr);
+	*sl = ib_get_sl(hdr);
+	*sc = ib_get_sc(hdr) | (sc5 << 4);
+	*len = ib_get_len(hdr);
+	*dlid = ib_get_dlid(hdr);
+	*slid = ib_get_slid(hdr);
+}
+
+void hfi2_trace_parse_16b_hdr(struct hfi2_16b_header *hdr,
+			      u8 *age, bool *becn, bool *fecn,
+			      u8 *l4, u8 *rc, u8 *sc,
+			      u16 *entropy, u16 *len, u16 *pkey,
+			      u32 *dlid, u32 *slid)
+{
+	*age = hfi2_16B_get_age(hdr);
+	*becn = hfi2_16B_get_becn(hdr);
+	*fecn = hfi2_16B_get_fecn(hdr);
+	*l4 = hfi2_16B_get_l4(hdr);
+	*rc = hfi2_16B_get_rc(hdr);
+	*sc = hfi2_16B_get_sc(hdr);
+	*entropy = hfi2_16B_get_entropy(hdr);
+	*len = hfi2_16B_get_len(hdr);
+	*pkey = hfi2_16B_get_pkey(hdr);
+	*dlid = hfi2_16B_get_dlid(hdr);
+	*slid = hfi2_16B_get_slid(hdr);
+}
+
+#define LRH_PRN "len:%d sc:%d dlid:0x%.4x slid:0x%.4x "
+#define LRH_9B_PRN "lnh:%d,%s lver:%d sl:%d"
+#define LRH_16B_PRN "age:%d becn:%d fecn:%d l4:%d " \
+		    "rc:%d sc:%d pkey:0x%.4x entropy:0x%.4x"
+const char *hfi2_trace_fmt_lrh(struct trace_seq *p, bool bypass,
+			       u8 age, bool becn, bool fecn, u8 l4,
+			       u8 lnh, const char *lnh_name, u8 lver,
+			       u8 rc, u8 sc, u8 sl, u16 entropy,
+			       u16 len, u16 pkey, u32 dlid, u32 slid)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	trace_seq_printf(p, LRH_PRN, len, sc, dlid, slid);
+
+	if (bypass)
+		trace_seq_printf(p, LRH_16B_PRN,
+				 age, becn, fecn, l4, rc, sc, pkey, entropy);
+
+	else
+		trace_seq_printf(p, LRH_9B_PRN,
+				 lnh, lnh_name, lver, sl);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+#define BTH_9B_PRN \
+	"op:0x%.2x,%s se:%d m:%d pad:%d tver:%d pkey:0x%.4x " \
+	"f:%d b:%d qpn:0x%.6x a:%d psn:0x%.8x"
+#define BTH_16B_PRN \
+	"op:0x%.2x,%s se:%d m:%d pad:%d tver:%d " \
+	"qpn:0x%.6x a:%d psn:0x%.8x"
+#define L4_FM_16B_PRN \
+	"op:0x%.2x,%s dest_qpn:0x%.6x src_qpn:0x%.6x"
+const char *hfi2_trace_fmt_rest(struct trace_seq *p, bool bypass, u8 l4,
+				u8 ack, bool becn, bool fecn, u8 mig,
+				u8 se, u8 pad, u8 opcode, const char *opname,
+				u8 tver, u16 pkey, u32 psn, u32 qpn,
+				u32 dest_qpn, u32 src_qpn)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	if (bypass)
+		if (l4 == OPA_16B_L4_FM)
+			trace_seq_printf(p, L4_FM_16B_PRN,
+					 opcode, opname, dest_qpn, src_qpn);
+		else
+			trace_seq_printf(p, BTH_16B_PRN,
+					 opcode, opname,
+					 se, mig, pad, tver, qpn, ack, psn);
+
+	else
+		trace_seq_printf(p, BTH_9B_PRN,
+				 opcode, opname,
+				 se, mig, pad, tver, pkey, fecn, becn,
+				 qpn, ack, psn);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+const char *hfi2_parse_everbs_hdrs(
+	struct trace_seq *p,
+	u8 opcode, u8 l4, u32 dest_qpn, u32 src_qpn,
+	void *ehdrs)
+{
+	union ib_ehdrs *eh = ehdrs;
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	if (l4 == OPA_16B_L4_FM) {
+		trace_seq_printf(p, "mgmt pkt");
+		goto out;
+	}
+
+	switch (opcode) {
+	/* imm */
+	case OP(RC, SEND_LAST_WITH_IMMEDIATE):
+	case OP(UC, SEND_LAST_WITH_IMMEDIATE):
+	case OP(RC, SEND_ONLY_WITH_IMMEDIATE):
+	case OP(UC, SEND_ONLY_WITH_IMMEDIATE):
+	case OP(RC, RDMA_WRITE_LAST_WITH_IMMEDIATE):
+	case OP(UC, RDMA_WRITE_LAST_WITH_IMMEDIATE):
+		trace_seq_printf(p, IMM_PRN,
+				 be32_to_cpu(eh->imm_data));
+		break;
+	/* reth + imm */
+	case OP(RC, RDMA_WRITE_ONLY_WITH_IMMEDIATE):
+	case OP(UC, RDMA_WRITE_ONLY_WITH_IMMEDIATE):
+		trace_seq_printf(p, RETH_PRN " " IMM_PRN,
+				 get_ib_reth_vaddr(&eh->rc.reth),
+				 be32_to_cpu(eh->rc.reth.rkey),
+				 be32_to_cpu(eh->rc.reth.length),
+				 be32_to_cpu(eh->rc.imm_data));
+		break;
+	/* reth */
+	case OP(RC, RDMA_READ_REQUEST):
+	case OP(RC, RDMA_WRITE_FIRST):
+	case OP(UC, RDMA_WRITE_FIRST):
+	case OP(RC, RDMA_WRITE_ONLY):
+	case OP(UC, RDMA_WRITE_ONLY):
+		trace_seq_printf(p, RETH_PRN,
+				 get_ib_reth_vaddr(&eh->rc.reth),
+				 be32_to_cpu(eh->rc.reth.rkey),
+				 be32_to_cpu(eh->rc.reth.length));
+		break;
+	case OP(RC, RDMA_READ_RESPONSE_FIRST):
+	case OP(RC, RDMA_READ_RESPONSE_LAST):
+	case OP(RC, RDMA_READ_RESPONSE_ONLY):
+	case OP(RC, ACKNOWLEDGE):
+		trace_seq_printf(p, AETH_PRN, be32_to_cpu(eh->aeth) >> 24,
+				 parse_syndrome(be32_to_cpu(eh->aeth) >> 24),
+				 be32_to_cpu(eh->aeth) & IB_MSN_MASK);
+		break;
+	case OP(TID_RDMA, WRITE_REQ):
+		trace_seq_printf(p, TID_RDMA_KDETH " " RETH_PRN " "
+				 TID_WRITE_REQ_PRN,
+				 le32_to_cpu(eh->tid_rdma.w_req.kdeth0),
+				 le32_to_cpu(eh->tid_rdma.w_req.kdeth1),
+				 ib_u64_get(&eh->tid_rdma.w_req.reth.vaddr),
+				 be32_to_cpu(eh->tid_rdma.w_req.reth.rkey),
+				 be32_to_cpu(eh->tid_rdma.w_req.reth.length),
+				 be32_to_cpu(eh->tid_rdma.w_req.verbs_qp));
+		break;
+	case OP(TID_RDMA, WRITE_RESP):
+		trace_seq_printf(p, TID_RDMA_KDETH " " AETH_PRN " "
+				 TID_WRITE_RSP_PRN,
+				 le32_to_cpu(eh->tid_rdma.w_rsp.kdeth0),
+				 le32_to_cpu(eh->tid_rdma.w_rsp.kdeth1),
+				 be32_to_cpu(eh->tid_rdma.w_rsp.aeth) >> 24,
+				 parse_syndrome(/* aeth */
+					 be32_to_cpu(eh->tid_rdma.w_rsp.aeth)
+					 >> 24),
+				 (be32_to_cpu(eh->tid_rdma.w_rsp.aeth) &
+				  IB_MSN_MASK),
+				 be32_to_cpu(eh->tid_rdma.w_rsp.tid_flow_psn),
+				 be32_to_cpu(eh->tid_rdma.w_rsp.tid_flow_qp),
+				 be32_to_cpu(eh->tid_rdma.w_rsp.verbs_qp));
+		break;
+	case OP(TID_RDMA, WRITE_DATA_LAST):
+	case OP(TID_RDMA, WRITE_DATA):
+		trace_seq_printf(p, TID_RDMA_KDETH_DATA " " TID_WRITE_DATA_PRN,
+				 le32_to_cpu(eh->tid_rdma.w_data.kdeth0),
+				 KDETH_GET(eh->tid_rdma.w_data.kdeth0, KVER),
+				 KDETH_GET(eh->tid_rdma.w_data.kdeth0, SH),
+				 KDETH_GET(eh->tid_rdma.w_data.kdeth0, INTR),
+				 KDETH_GET(eh->tid_rdma.w_data.kdeth0, TIDCTRL),
+				 KDETH_GET(eh->tid_rdma.w_data.kdeth0, TID),
+				 KDETH_GET(eh->tid_rdma.w_data.kdeth0, OFFSET),
+				 le32_to_cpu(eh->tid_rdma.w_data.kdeth1),
+				 KDETH_GET(eh->tid_rdma.w_data.kdeth1, JKEY),
+				 be32_to_cpu(eh->tid_rdma.w_data.verbs_qp));
+		break;
+	case OP(TID_RDMA, READ_REQ):
+		trace_seq_printf(p, TID_RDMA_KDETH " " RETH_PRN " "
+				 TID_READ_REQ_PRN,
+				 le32_to_cpu(eh->tid_rdma.r_req.kdeth0),
+				 le32_to_cpu(eh->tid_rdma.r_req.kdeth1),
+				 ib_u64_get(&eh->tid_rdma.r_req.reth.vaddr),
+				 be32_to_cpu(eh->tid_rdma.r_req.reth.rkey),
+				 be32_to_cpu(eh->tid_rdma.r_req.reth.length),
+				 be32_to_cpu(eh->tid_rdma.r_req.tid_flow_psn),
+				 be32_to_cpu(eh->tid_rdma.r_req.tid_flow_qp),
+				 be32_to_cpu(eh->tid_rdma.r_req.verbs_qp));
+		break;
+	case OP(TID_RDMA, READ_RESP):
+		trace_seq_printf(p, TID_RDMA_KDETH_DATA " " AETH_PRN " "
+				 TID_READ_RSP_PRN,
+				 le32_to_cpu(eh->tid_rdma.r_rsp.kdeth0),
+				 KDETH_GET(eh->tid_rdma.r_rsp.kdeth0, KVER),
+				 KDETH_GET(eh->tid_rdma.r_rsp.kdeth0, SH),
+				 KDETH_GET(eh->tid_rdma.r_rsp.kdeth0, INTR),
+				 KDETH_GET(eh->tid_rdma.r_rsp.kdeth0, TIDCTRL),
+				 KDETH_GET(eh->tid_rdma.r_rsp.kdeth0, TID),
+				 KDETH_GET(eh->tid_rdma.r_rsp.kdeth0, OFFSET),
+				 le32_to_cpu(eh->tid_rdma.r_rsp.kdeth1),
+				 KDETH_GET(eh->tid_rdma.r_rsp.kdeth1, JKEY),
+				 be32_to_cpu(eh->tid_rdma.r_rsp.aeth) >> 24,
+				 parse_syndrome(/* aeth */
+					 be32_to_cpu(eh->tid_rdma.r_rsp.aeth)
+					 >> 24),
+				 (be32_to_cpu(eh->tid_rdma.r_rsp.aeth) &
+				  IB_MSN_MASK),
+				 be32_to_cpu(eh->tid_rdma.r_rsp.verbs_qp));
+		break;
+	case OP(TID_RDMA, ACK):
+		trace_seq_printf(p, TID_RDMA_KDETH " " AETH_PRN " "
+				 TID_ACK_PRN,
+				 le32_to_cpu(eh->tid_rdma.ack.kdeth0),
+				 le32_to_cpu(eh->tid_rdma.ack.kdeth1),
+				 be32_to_cpu(eh->tid_rdma.ack.aeth) >> 24,
+				 parse_syndrome(/* aeth */
+					 be32_to_cpu(eh->tid_rdma.ack.aeth)
+					 >> 24),
+				 (be32_to_cpu(eh->tid_rdma.ack.aeth) &
+				  IB_MSN_MASK),
+				 be32_to_cpu(eh->tid_rdma.ack.tid_flow_psn),
+				 be32_to_cpu(eh->tid_rdma.ack.verbs_psn),
+				 be32_to_cpu(eh->tid_rdma.ack.tid_flow_qp),
+				 be32_to_cpu(eh->tid_rdma.ack.verbs_qp));
+		break;
+	case OP(TID_RDMA, RESYNC):
+		trace_seq_printf(p, TID_RDMA_KDETH " " TID_RESYNC_PRN,
+				 le32_to_cpu(eh->tid_rdma.resync.kdeth0),
+				 le32_to_cpu(eh->tid_rdma.resync.kdeth1),
+				 be32_to_cpu(eh->tid_rdma.resync.verbs_qp));
+		break;
+	/* aeth + atomicacketh */
+	case OP(RC, ATOMIC_ACKNOWLEDGE):
+		trace_seq_printf(p, AETH_PRN " " ATOMICACKETH_PRN,
+				 be32_to_cpu(eh->at.aeth) >> 24,
+				 parse_syndrome(be32_to_cpu(eh->at.aeth) >> 24),
+				 be32_to_cpu(eh->at.aeth) & IB_MSN_MASK,
+				 ib_u64_get(&eh->at.atomic_ack_eth));
+		break;
+	/* atomiceth */
+	case OP(RC, COMPARE_SWAP):
+	case OP(RC, FETCH_ADD):
+		trace_seq_printf(p, ATOMICETH_PRN,
+				 get_ib_ateth_vaddr(&eh->atomic_eth),
+				 eh->atomic_eth.rkey,
+				 get_ib_ateth_swap(&eh->atomic_eth),
+				 get_ib_ateth_compare(&eh->atomic_eth));
+		break;
+	/* deth */
+	case OP(UD, SEND_ONLY):
+		trace_seq_printf(p, DETH_ENTROPY_PRN,
+				 be32_to_cpu(eh->ud.deth[0]),
+				 be32_to_cpu(eh->ud.deth[1]) & RVT_QPN_MASK,
+				 be32_to_cpu(eh->ud.deth[1]) >>
+					     HFI2_IPOIB_ENTROPY_SHIFT);
+		break;
+	case OP(UD, SEND_ONLY_WITH_IMMEDIATE):
+		trace_seq_printf(p, DETH_PRN,
+				 be32_to_cpu(eh->ud.deth[0]),
+				 be32_to_cpu(eh->ud.deth[1]) & RVT_QPN_MASK);
+		break;
+	/* ieth */
+	case OP(RC, SEND_LAST_WITH_INVALIDATE):
+	case OP(RC, SEND_ONLY_WITH_INVALIDATE):
+		trace_seq_printf(p, IETH_PRN,
+				 be32_to_cpu(eh->ieth));
+		break;
+	}
+out:
+	trace_seq_putc(p, 0);
+	return ret;
+}
+
+const char *hfi2_parse_sdma_flags(struct trace_seq *p, u64 *qw, u8 first, u8 last)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	char flags[5] = { 'x', 'x', 'x', 'x', 0 };
+
+	flags[0] = (qw[1] & SDMA_DESC1_INT_REQ_FLAG) ? 'I' : '-';
+	flags[1] = (qw[1] & SDMA_DESC1_HEAD_TO_HOST_FLAG) ?  'H' : '-';
+	flags[2] = first ? 'F' : '-';
+	flags[3] = last ? 'L' : '-';
+	trace_seq_printf(p, "%s", flags);
+	if (first)
+		trace_seq_printf(p, " amode:%u aidx:%u alen:%u",
+				 (u8)((qw[1] >> SDMA_DESC1_HEADER_MODE_SHIFT) &
+				      SDMA_DESC1_HEADER_MODE_MASK),
+				 (u8)((qw[1] >> SDMA_DESC1_HEADER_INDEX_SHIFT) &
+				      SDMA_DESC1_HEADER_INDEX_MASK),
+				 (u8)((qw[1] >> SDMA_DESC1_HEADER_DWS_SHIFT) &
+				      SDMA_DESC1_HEADER_DWS_MASK));
+	return ret;
+}
+
+const char *hfi2_print_u32_array(
+	struct trace_seq *p,
+	u32 *arr, int len)
+{
+	int i;
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	for (i = 0; i < len ; i++)
+		trace_seq_printf(p, "%s%#x", i == 0 ? "" : " ", arr[i]);
+	trace_seq_putc(p, 0);
+	return ret;
+}
+
+u8 hfi2_trace_get_tid_ctrl(u32 ent)
+{
+	return EXP_TID_GET(ent, CTRL);
+}
+
+u16 hfi2_trace_get_tid_len(u32 ent)
+{
+	return EXP_TID_GET(ent, LEN);
+}
+
+u16 hfi2_trace_get_tid_idx(u32 ent)
+{
+	return EXP_TID_GET(ent, IDX);
+}
+
+struct hfi2_ctxt_hist {
+	atomic_t count;
+	atomic_t data[255];
+};
+
+static struct hfi2_ctxt_hist hist = {
+	.count = ATOMIC_INIT(0)
+};
+
+const char *hfi2_trace_print_rsm_hist(struct trace_seq *p, unsigned int ctxt)
+{
+	int i, len = ARRAY_SIZE(hist.data);
+	const char *ret = trace_seq_buffer_ptr(p);
+	unsigned long packet_count = atomic_fetch_inc(&hist.count);
+
+	trace_seq_printf(p, "packet[%lu]", packet_count);
+	for (i = 0; i < len; ++i) {
+		unsigned long val;
+		atomic_t *count = &hist.data[i];
+
+		if (ctxt == i)
+			val = atomic_fetch_inc(count);
+		else
+			val = atomic_read(count);
+
+		if (val)
+			trace_seq_printf(p, "(%d:%lu)", i, val);
+	}
+	trace_seq_putc(p, 0);
+	return ret;
+}
+
+const char *hfi2_memtype_str(unsigned int mt)
+{
+	switch (mt) {
+	case HFI2_MEMINFO_TYPE_SYSTEM:
+		return "System";
+	}
+
+	return "<unknown>";
+}
+
+__hfi2_trace_fn(AFFINITY);
+__hfi2_trace_fn(PKT);
+__hfi2_trace_fn(PROC);
+__hfi2_trace_fn(SDMA);
+__hfi2_trace_fn(LINKVERB);
+__hfi2_trace_fn(DEBUG);
+__hfi2_trace_fn(SNOOP);
+__hfi2_trace_fn(CNTR);
+__hfi2_trace_fn(PIO);
+__hfi2_trace_fn(DC8051);
+__hfi2_trace_fn(FIRMWARE);
+__hfi2_trace_fn(RCVCTRL);
+__hfi2_trace_fn(TID);
+__hfi2_trace_fn(MMU);
+__hfi2_trace_fn(IOCTL);



