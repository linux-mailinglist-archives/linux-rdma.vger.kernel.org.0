Return-Path: <linux-rdma+bounces-22520-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ic/ZIp35P2qaawkAu9opvQ
	(envelope-from <linux-rdma+bounces-22520-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 18:26:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A206D2415
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 18:26:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cornelisnetworks.com header.s=selector1 header.b=gX3glhoB;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22520-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22520-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cornelisnetworks.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55B58301912E
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 16:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D078A2EEE90;
	Sat, 27 Jun 2026 16:25:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022073.outbound.protection.outlook.com [52.101.43.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372722EBBAF
	for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2026 16:25:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782577554; cv=fail; b=bvNV/eZh1IBUtS2bidUk+I3OBVREcrQj+uQ5Kxea46u4ydX3OS4ExQ43lXjlv0+3SYI3odEUXbQ/eGSJPcmYhJZuD/CLFi51FIDgJnCrixkpJj47kc3vrIIPoGAGEP4ddLI55dialTbAdof9Kffikjw1fxkhW3Z0TvD39+Y9cMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782577554; c=relaxed/simple;
	bh=ApC7UyGdDqrwEcbzefesFUnhh7UCk8wwF0viyD7ybxw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOUmWTv0KmA3Jisn2HbiH0IujLmjPKbh5NrHHwMJ+L1auMaFTx1bFJjQ/ytBcghqS/zKDowJztteIYdV4MeHF7XMrmrH6h71rJNt5LqxjovnYhTX8NX5VWZb9IQ4FBDapxxxQzSbxpetvtmb8ySXKjXxbwByY3eKYkn2qyhtl+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=gX3glhoB; arc=fail smtp.client-ip=52.101.43.73
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJFBwehCnKEfQwxU+fq7usEwAv75iQK1p7mT52He7l6RZWp/Sld7vQ23h79dJt9WWl/Bjq+yW31QEVbxs/glblCcuJsAJSY7zDdw7oVJ7LITEAsDgOqLdftGeu+GyAjRDDNBmPDiwRW+dxqZ54pIAnq1yL3VIQIKMHwpaeiVCmYggTwJa6Xc0AxO4+TUfbaFhWiTls4rC/2EWXP69WRsysoirMFK0dbmT0DR0HAtO3+a9j0ts8CBG9UEzZB/ez4l/R70/+13QLM1hTMIZxsvUGHGOn0zUf8sDu/LvxFX3c+xKOcEknA15YDfYf2S9biS0ZkUczpOYY+7rEbKT9ggWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5yY/Ku3DjsQsNDMjgSb1b4s9MVIEUO+ZeBZ/qdZvCA=;
 b=ko5pzR7/9w5o2OfpHn3jzdY2t//1czTXhsYAyf/b+K0lSCMnnrxI1qnggQWrtZ6sGx5ZMkF8g5eQRlnWTyeoRc1JREHvTsE/NtLILXhvqqWXpUFVbH7WbVYpJSOPNUfHE4enIWx+N3MkbY7zcLUHJX+X1PVA0Svw99vIi30kVu0xoWyYviQmV9W2JjeQF8RhepQR5k6cbbYANHatNscLIOdSlLdiwidqV0XwJPxWMulf47OR5VGeRWvQBnCUBKNO5IH+BqnZi+a45FLu01V/LkA8V+4FyN3HVmXntZMoGftNvKYQr4z6hqGECvA2foE0UHRU8IsKOv2ciZbNqbq2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5yY/Ku3DjsQsNDMjgSb1b4s9MVIEUO+ZeBZ/qdZvCA=;
 b=gX3glhoBdy1CeKEjmdAzLvETlYN1vdXwFNjHEMKkwdwhxlxH1zNRL/HdEBVnMlyKncHD1nMhur6Z7X9DluxpB/pTLgEPnooP6gHgx686/fZZsV8rqt5DR7pUqrutytlzd6IqYuEq5Hhb4Hw/A+FQolI56F5vEvQtxunWjUjLGwf3rD4NQJ7nZL3TBlULXz7+zCJz2SpoB3e5cgdBHQSZZ2ddQPPh/R+hQmBsfv5WsE1VwLNR2uDyTglYdJYrN2CVeuxgBiZugqvNFVsrPtxf6vD6/2i9UoJWLX5/gNrCNHNCOlhItksaem/SY/rpqbE+zfTAGmPnzsXGFu2Owo92Zw==
Received: from SA1P222CA0192.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::13)
 by BN0PR01MB7135.prod.exchangelabs.com (2603:10b6:408:152::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Sat, 27 Jun 2026 16:25:46 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::57) by SA1P222CA0192.outlook.office365.com
 (2603:10b6:806:3c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Sat,
 27 Jun 2026 16:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Sat, 27 Jun 2026 16:25:45 +0000
Received: from awdrv-04.localdomain (unknown [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 0DFE6146565;
	Sat, 27 Jun 2026 12:25:45 -0400 (EDT)
Received: from [10.228.212.218] (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 0A1121810D6C7;
	Sat, 27 Jun 2026 12:25:45 -0400 (EDT)
Subject: [PATCH v2 for-next 10/24] RDMA/hfi2: Add in MAD handling related
 headers
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Sat, 27 Jun 2026 12:25:45 -0400
Message-ID: <178257754500.371918.6760670069683583211.stgit@awdrv-04>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|BN0PR01MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: e648c5e7-6439-4804-ee4d-08ded468bdae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|55112099003|22082099003|18002099003|3023799007|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	B4BHPsuNuDnHiK6IgwVZKJuWtkavA5xnRxEK1QwRcQNZWgQBVMf8fcfD2qzJUOdvCNmpcZo1DJA605aq2oZaOPS4sQC40KH0XV66C5iOfxO76eLx0f/Jh4uRpqmVQKUSyJQ2xiwWhscwatA4IC4WmZF3YmR4BAX7BLP6DaxA6NXOEOnqdIRek9SGJ+bGzbQ5Cbp0z8QTPtKDUa62bOGqYsesjETD9wRRQhae08v6h17El2F1OHCgt7wJFBhNTzRg0Aexxw14BEwOUHvytdXXpuZSyXAKIJMfWmWgf3r6iBi4rek381Y17MMAd6BoamzIHCizmOi3Zgs8tFPbL7ql/QS+bYPGtzQj4uplc16gWZP/YMJQwxWbeFTDcs0qkVFebACZJuTWT9FNV9EsjXrMammmeMF9wyLHXBLHKdFvbY51MFTGfRMQBql/vGUey4Ut0ueKaP0gYfxN8Nr4xCQLYHy7h5VftKBfI6wfOmW2n+uz+zSXO2/E6q2jnIuvCPjETrDbHy/uF/A7VH0hdcurTZejv/Eo+IZWJtelRYNT/qUuHRXBOpQXMmcuOHjCzqUXwQU+tx70+qZsa/1Z45DFOoGoZFqfCS4CP8NKuGVzoOMHrUT8PvWaErHpMGX7oSGZ2q87pHVW3/YCNKcXtJIa99tW0Rf+7j0WChyCpVN/Cx3cIW07GniekYS36HW7oqPmXrL77lKNCo/jpz7Qr+PNYQ==
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(55112099003)(22082099003)(18002099003)(3023799007)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/IJPQrtPl0518nrPt6Lc8FTKHHCMIvj/P40Yjw4Pcb+yG1vDE6He80u4AyFXPQ7g7VFfDgGGD0DoEQI0N8PEJl7fqJ9xTCwgeT/y5+1sGuR7xXPcsJg7KWHI43ueqaPn8h/edi6PbGzLeQzKzJclU2XdtZhcvqQ6cNn+llbvDp+lea+Jr1bp5rQ+5Cp2IlrMlUJCrNRDsj4oadhGSJOVSgksMvM2kouHLcbEwpJBIkFVv2Edlz66oU52PV6Rn22jQzqVBWCjnD88V+I0CGTL25G9Q5Yv0IyTA1YjxS/DVSQgwob12YLZccldm9d/iii6Eyil3wcfS4h6XoYCkm1WOy0rLgNxkEqqxxIjGONIwP1BzZ9wDdS+I4KRfiAccdLaUBTFr+X/OTE+aCY0ZWufFoVz+010wJKbyESkLxbyQsqkKZCHddDs98FjS8yXWzuz
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 16:25:45.5488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e648c5e7-6439-4804-ee4d-08ded468bdae
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7135
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
	TAGGED_FROM(0.00)[bounces-22520-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dean.luick@cornelisnetworks.com,m:doug.miller@cornelisnetworks.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[awdrv-04:mid,vger.kernel.org:from_smtp,cornelisnetworks.com:dkim,cornelisnetworks.com:email,cornelisnetworks.com:from_mime];
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
X-Rspamd-Queue-Id: 26A206D2415

In the new HW there is an embedded micro on the card which manages a lot of
what used to be done in sw as far as the MAD layer is concerned. We do
still need to support MADs in SW for the older generation HW so those
definitions move as well.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

---
  Changes since v1:
    - Address Arnd Bergmann's feedback (Re: hfi2 v1, Mar 23 2026):
      replace C bitfield-based hardware/firmware payload structs in
      cport.h (cport_options, cport_trap_status, cport_fw_ver,
      cport_who_payload, cport_how_payload, cport_start_payload,
      cport_stop_payload) with plain integer fields plus SHIFT/MASK
      accessor macros. Bitfield layout is implementation defined and
      not portable across compilers/endianness, which makes them
      unsuitable for describing fixed-format messages exchanged with
      CPORT firmware.
    - Drop __packed from struct ib_cc_table_attr_shadow and
      struct cc_table_shadow in mad.h. These are software-internal
      shadow structures whose contents are naturally aligned, so
      __packed only forces unnecessary unaligned accesses.
---
 drivers/infiniband/hw/hfi2/cport.h       |  275 +++++++++++++++++++
 drivers/infiniband/hw/hfi2/cport_traps.h |   43 +++
 drivers/infiniband/hw/hfi2/mad.h         |  441 ++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/opa_compat.h  |   87 ++++++
 4 files changed, 846 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/cport.h
 create mode 100644 drivers/infiniband/hw/hfi2/cport_traps.h
 create mode 100644 drivers/infiniband/hw/hfi2/mad.h
 create mode 100644 drivers/infiniband/hw/hfi2/opa_compat.h

diff --git a/drivers/infiniband/hw/hfi2/cport.h b/drivers/infiniband/hw/hfi2/cport.h
new file mode 100644
index 000000000000..5a591305fe7d
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/cport.h
@@ -0,0 +1,275 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#ifndef _CPORT_H
+#define _CPORT_H
+
+/*****************************************************
+ * "Public" software interfaces (inside driver only).
+ */
+
+extern uint hfi2_cport_adm_to;
+
+/*
+ * Op-codes for requests (and associated responses).
+ * CPORT firmware must have the same definitions.
+ */
+#define CH_OP_PING 0 /* simple ping/echo command */
+#define CH_OP_WHO 1
+#define CH_OP_HOW 2
+#define CH_OP_START 3 /* driver start/options */
+#define CH_OP_STOP 4 /* driver stop (unload) */
+#define CH_OP_TRAP 5 /* notification of TRAP condition */
+#define CH_OP_TRAP_REPRESS 6 /* TRAP acknowledge */
+#define CH_OP_MAD_9B 7 /* Local MAD packets 9B */
+#define CH_OP_MAD_16B 8 /* Local MAD packets 16B */
+#define CH_OP_UMAD_9B 9 /* User MAD packets 9B */
+#define CH_OP_UMAD_16B 10 /* User MAD packets 16B */
+
+/*
+ * Error codes for responses.
+ * CPORT firmware must have the same definitions.
+ */
+#define MSG_RSP_STATUS_OK 0
+#define MSG_RSP_STATUS_SEQ_NO_ERROR 1
+#define MSG_RSP_STATUS_OPCODE_UNSUPPORTED 2
+#define MSG_RSP_STATUS_INVALID_STATE 3
+#define MSG_RSP_STATUS_RETRY 4
+#define MSG_RSP_STATUS_DENIED 5
+
+/*
+ * The structures below describe payloads exchanged with CPORT firmware
+ * over a fixed-size message protocol. Use plain integer fields (rather
+ * than C bitfields) so the layout is portable across compilers and
+ * architectures, and access sub-fields through the SHIFT/MASK macros
+ * below.
+ */
+
+/* cport_options.flags bits */
+#define CPORT_OPT_BARE_METAL BIT(0)
+#define CPORT_OPT_GSI BIT(1)
+#define CPORT_OPT_FLR BIT(2)
+#define CPORT_OPT_SPI_WE BIT(3)
+#define CPORT_OPT_LOCAL_MAD BIT(4)
+/* bits 5-15 reserved */
+
+struct cport_options {
+	u16 flags;
+};
+
+/* cport_trap_status.flags bits */
+#define CPORT_TRAP_PSC BIT(0) /* Port State Change */
+#define CPORT_TRAP_LI BIT(1) /* Link Integrity */
+#define CPORT_TRAP_BO BIT(2) /* Buffer Overrun */
+#define CPORT_TRAP_FW BIT(3) /* Flow Watchdog */
+#define CPORT_TRAP_CC BIT(4) /* Capability Change */
+#define CPORT_TRAP_SIC BIT(5) /* System Image Change */
+#define CPORT_TRAP_BMK BIT(6) /* Bad M Key */
+#define CPORT_TRAP_BQK BIT(7) /* Bad Q Key */
+#define CPORT_TRAP_LWC BIT(8) /* Link Width Change */
+#define CPORT_TRAP_QSFP BIT(9) /* QSFP Fault */
+#define CPORT_TRAP_OVTM BIT(10) /* Over-temp */
+/* bits 11-31 reserved */
+
+struct cport_trap_status {
+	u32 flags;
+};
+
+/* CPORT firmware version sub-field accessors (operate on the u64 value) */
+#define CPORT_FW_VER_BLD(v) ((u32)((v) & 0xffffffffULL))
+#define CPORT_FW_VER_PAT(v) ((u32)(((v) >> 32) & 0xfULL))
+#define CPORT_FW_VER_QLT(v) ((u32)(((v) >> 36) & 0xfULL))
+#define CPORT_FW_VER_MNT(v) ((u32)(((v) >> 40) & 0xffULL))
+#define CPORT_FW_VER_MIN(v) ((u32)(((v) >> 48) & 0xffULL))
+#define CPORT_FW_VER_MAJ(v) ((u32)(((v) >> 56) & 0xffULL))
+
+/* Fields in 4-qword payload of WHO response */
+struct cport_who_payload {
+	/* qword 1: low byte reserved, next byte interop, then options */
+	u16 introp; /* low 8 bits reserved, high 8 bits interop level */
+	struct cport_options fixed;
+	struct cport_options suppt;
+	u16 max_msg; /* max cport msg length */
+	/* qword 2 */
+	u64 vers; /* fw version; see CPORT_FW_VER_* accessors */
+	/* qword 3 */
+	u64 node_guid;
+	/* qword 4 */
+	struct cport_trap_status trap_sup;
+	u16 _resv2;
+	u16 max_aux; /* max cport aux length */
+};
+
+/*
+ * HOW response payload sub-field accessors. Logical and physical state
+ * fields are packed into qword 1; temperature and validity flags occupy
+ * qword 4.
+ */
+#define CPORT_HOW_LOG_ST(qw1, port) (((qw1) >> ((port) * 4)) & 0x7)
+#define CPORT_HOW_PHY_ST(phy, port) \
+	(((phy)[(port) / 2] >> (((port) % 2) * 8)) & 0xff)
+#define CPORT_HOW_INTEROP_LEVEL(qw3) ((u8)((qw3) & 0xff))
+#define CPORT_HOW_STARTED(qw4) ((u8)((qw4) & 0xff))
+#define CPORT_HOW_TEMP_VALID(qw4) (((qw4) >> 8) & 0x1)
+#define CPORT_HOW_QSFP1_TEMP_VALID(qw4) (((qw4) >> 9) & 0x1)
+#define CPORT_HOW_QSFP2_TEMP_VALID(qw4) (((qw4) >> 10) & 0x1)
+#define CPORT_HOW_TEMP(qw4) ((u16)(((qw4) >> 16) & 0xffff))
+#define CPORT_HOW_QSFP1_TEMP(qw4) ((u16)(((qw4) >> 32) & 0xffff))
+#define CPORT_HOW_QSFP2_TEMP(qw4) ((u16)(((qw4) >> 48) & 0xffff))
+
+/* Fields in 4-qword payload of HOW response */
+struct cport_how_payload {
+	/* qword 1 */
+	u16 log_st; /* per-port logical state, 4 bits each */
+	struct cport_options opts_ena;
+	u16 phy_st[2]; /* phy state, two ports per u16 */
+	/* qword 2 */
+	struct cport_trap_status trap_ena;
+	struct cport_trap_status trap_sts;
+	/* qword 3: low byte holds interoperability level; rest reserved */
+	u64 interop;
+	/* qword 4: temperature/qsfp data; see CPORT_HOW_* accessors */
+	u64 temps;
+};
+
+/* START payload sub-field accessors */
+#define CPORT_START_SIDX(s) ((u16)((s) & 0x7))
+#define CPORT_START_INTEROP(s) ((u8)(((s) >> 8) & 0xff))
+
+/* Fields in 1-qword payload of START request/response */
+struct cport_start_payload {
+	u16 sidx; /* low 3 bits sidx, high byte interop */
+	struct cport_options opts_ena;
+	struct cport_trap_status trap_ena;
+};
+
+/* Fields in 1-qword payload of STOP request/response */
+struct cport_stop_payload {
+	u64 sidx; /* low 3 bits sidx, rest reserved */
+};
+
+/* Fields in 1-qword payload of TRAP or TRAP_REPRESS request */
+struct cport_trap_payload {
+	struct cport_trap_status trap_sts;
+	u32 _resv1;
+};
+
+/*
+ * Non-blocking request interface.
+ *
+ * hfi2_cport_send_req_nb() returns 'handle' (or IS_ERR(handle)).
+ * Caller supplies 'wait' which will be "upped" when the matching response
+ * is received.  Caller also supplies a timeout for the OUTBOX_EMPTY wait.
+ * This is generally needed if the caller will be using a timeout when waiting
+ * for completion, to ensure that the send kworker also times out and exits.
+ * Timeouts, etc, use hfi2_cport_send_cancel() to terminate without receiving response.
+ *
+ * Payload is always copied to internal buffer, so caller
+ * may dispose of their buffer immediately on return.
+ *
+ * Timeout value of MAX_SCHEDULE_TIMEOUT causes infinite wait for OUTBOX_EMPTY.
+ *
+ * One of hfi2_cport_send_comp() or hfi2_cport_send_cancel() must be called in order
+ * to fully release 'handle'.
+ *
+ * Response payload and length is provided in 'rsp_pld' and 'rsp_len',
+ * which has been kalloc'ed and must be kfree'ed by caller.
+ *
+ * hfi2_cport_send_comp() returns the status (error code) from the response.
+ */
+void *hfi2_cport_send_req_nb(struct hfi2_devdata *dd, u8 op, u8 sideband,
+			void *payload, int len, struct semaphore *wait,
+			long timeout);
+int hfi2_cport_send_comp(struct hfi2_devdata *dd, void *handle, void **rsp_pld,
+		    int *rsp_len);
+void hfi2_cport_send_cancel(struct hfi2_devdata *dd, void *handle);
+
+/*
+ * Blocking request interface with timeout.
+ *
+ * The caller may dispose of 'payload' immediately on return.
+ * Response payload and length is provided in 'rsp_pld' and 'rsp_len',
+ * which has been kalloc'ed and must be kfree'ed by caller.
+ *
+ * Timeout value of MAX_SCHEDULE_TIMEOUT causes infinite wait for response
+ * and OUTBOX_EMPTY.
+ *
+ * Returns the status (error code) from the response.
+ */
+int hfi2_cport_send_req(struct hfi2_devdata *dd, u8 op, u8 sideband, void *payload,
+		   int len, void **rsp_pld, int *rsp_len, long timeout);
+
+/*
+ * CPORT Notification interface.
+ *
+ * A notification is defined as a request that has no response.
+ * This is implicitly non-blocking. timeout is applied to the
+ * send wait for OUTBOX_EMPTY.
+ *
+ * The caller may dispose of 'payload' immediately on return.
+ *
+ * Returns 0 if the request was successfully queued.
+ */
+int hfi2_cport_send_notif(struct hfi2_devdata *dd, u8 op, u8 sideband, void *payload,
+		     int len, long timeout);
+
+/**************************************
+ * API for notifications from CPORT
+ */
+
+/*
+ * Handler prototype for callbacks.
+ *
+ * Returns response status (error) value. Must setup response payload
+ * if appropriate. Whether or not a response is actually sent depends on
+ * whether the request asked for one. Default is no payload (0 length).
+ *
+ * The semantics for responses are defined by the op-code. Error responses
+ * may have different payloads than successful responses (or no payload at all).
+ * Payloads may even be optional.
+ */
+typedef int (*cport_handler)(struct hfi2_devdata *dd, u8 op, u8 sideband,
+			     void *payload, int len, void *handle);
+
+/*
+ * Register a callback for a range of op-codes. Only one callback may be
+ * registered for a given op-code. Returns 0 on success (valid op-code range).
+ */
+int hfi2_cport_register_cb(struct hfi2_devdata *dd, u8 op_start, u8 op_end,
+		      cport_handler func);
+
+/*
+ * Set static buffer for response payload of 'len' bytes from callback.
+ *
+ * Buffer may be disposed of immediately on return. If 'len' exceeds
+ * maximum allowed, returns -EINVAL.
+ */
+int hfi2_cport_resp_set(void *handle, void *payload, int len);
+
+/*
+ * Interrupt handler for MctxtCportToPcieInt
+ */
+void hfi2_is_cport_int(struct hfi2_devdata *dd, unsigned int source);
+
+/*
+ * Start a CPORT ping for count iterations.
+ */
+int hfi2_cport_ping_start(struct hfi2_devdata *dd, unsigned int count);
+
+/*
+ * Initialize the CPORT communication facility.
+ *
+ * If the device does not have a CPORT, this returns 0.
+ */
+int hfi2_cport_init(struct hfi2_devdata *dd);
+
+/*
+ * Shutdown the CPORT communication facility.
+ *
+ * If the device has no CPORT, this does nothing.
+ */
+int hfi2_cport_exit(struct hfi2_devdata *dd);
+
+#endif /* _CPORT_H */
diff --git a/drivers/infiniband/hw/hfi2/cport_traps.h b/drivers/infiniband/hw/hfi2/cport_traps.h
new file mode 100644
index 000000000000..ddf2af083e87
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/cport_traps.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#ifndef _CPORT_TRAPS_H
+#define _CPORT_TRAPS_H
+
+#include "cport.h"
+
+/*
+ * Facility to handle CPORT "TRAPS".
+ */
+
+/*
+ * Handler prototype for callbacks.
+ *
+ * @traps indicates which traps are being reported, and is not restricted
+ * to the trap(s) registered to this callback. At least one of the traps
+ * that was requested will be set.
+ */
+typedef void (*cport_trap_handler)(struct hfi2_devdata *dd,
+				   struct cport_trap_status traps);
+
+/*
+ * Register for a callback when certain CPORT TRAPs occur.
+ *
+ * @traps indicates the TRAPs to be detected.
+ * @func will be called when at least one of @traps is set.
+ */
+int hfi2_register_cport_trap(struct hfi2_devdata *dd, struct cport_trap_status traps,
+			cport_trap_handler func);
+
+/*
+ * Deregister for a callback on CPORT TRAPs.
+ *
+ * @func All registered callbacks using this function will be removed.
+ *
+ * On return, @func will not be called for any traps.
+ */
+int hfi2_deregister_cport_trap(struct hfi2_devdata *dd, cport_trap_handler func);
+
+#endif /* _CPORT_TRAPS_H */
diff --git a/drivers/infiniband/hw/hfi2/mad.h b/drivers/infiniband/hw/hfi2/mad.h
new file mode 100644
index 000000000000..34afc89ad4ca
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/mad.h
@@ -0,0 +1,441 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015 - 2017 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#ifndef _HFI2_MAD_H
+#define _HFI2_MAD_H
+
+#include <rdma/ib_pma.h>
+#include <rdma/opa_smi.h>
+#include <rdma/opa_port_info.h>
+#include "opa_compat.h"
+
+/*
+ * OPA Traps
+ */
+#define OPA_TRAP_GID_NOW_IN_SERVICE cpu_to_be16(64)
+#define OPA_TRAP_GID_OUT_OF_SERVICE cpu_to_be16(65)
+#define OPA_TRAP_ADD_MULTICAST_GROUP cpu_to_be16(66)
+#define OPA_TRAL_DEL_MULTICAST_GROUP cpu_to_be16(67)
+#define OPA_TRAP_UNPATH cpu_to_be16(68)
+#define OPA_TRAP_REPATH cpu_to_be16(69)
+#define OPA_TRAP_PORT_CHANGE_STATE cpu_to_be16(128)
+#define OPA_TRAP_LINK_INTEGRITY cpu_to_be16(129)
+#define OPA_TRAP_EXCESSIVE_BUFFER_OVERRUN cpu_to_be16(130)
+#define OPA_TRAP_FLOW_WATCHDOG cpu_to_be16(131)
+#define OPA_TRAP_CHANGE_CAPABILITY cpu_to_be16(144)
+#define OPA_TRAP_CHANGE_SYSGUID cpu_to_be16(145)
+#define OPA_TRAP_BAD_M_KEY cpu_to_be16(256)
+#define OPA_TRAP_BAD_P_KEY cpu_to_be16(257)
+#define OPA_TRAP_BAD_Q_KEY cpu_to_be16(258)
+#define OPA_TRAP_SWITCH_BAD_PKEY cpu_to_be16(259)
+#define OPA_SMA_TRAP_DATA_LINK_WIDTH cpu_to_be16(2048)
+
+/*
+ * Generic trap/notice other local changes flags (trap 144).
+ */
+#define OPA_NOTICE_TRAP_LWDE_CHG \
+	0x08 /* Link Width Downgrade Enable
+					      * changed
+					      */
+#define OPA_NOTICE_TRAP_LSE_CHG 0x04 /* Link Speed Enable changed */
+#define OPA_NOTICE_TRAP_LWE_CHG 0x02 /* Link Width Enable changed */
+#define OPA_NOTICE_TRAP_NODE_DESC_CHG 0x01
+
+struct opa_mad_notice_attr {
+	u8 generic_type;
+	u8 prod_type_msb;
+	__be16 prod_type_lsb;
+	__be16 trap_num;
+	__be16 toggle_count;
+	__be32 issuer_lid;
+	__be32 reserved1;
+	union ib_gid issuer_gid;
+
+	union {
+		struct {
+			u8 details[64];
+		} raw_data;
+
+		struct {
+			union ib_gid gid;
+		} __packed ntc_64_65_66_67;
+
+		struct {
+			__be32 lid;
+		} __packed ntc_128;
+
+		struct {
+			__be32 lid; /* where violation happened */
+			u8 port_num; /* where violation happened */
+		} __packed ntc_129_130_131;
+
+		struct {
+			__be32 lid; /* LID where change occurred */
+			__be32 new_cap_mask; /* new capability mask */
+			__be16 reserved2;
+			__be16 cap_mask3;
+			__be16 change_flags; /* low 4 bits only */
+		} __packed ntc_144;
+
+		struct {
+			__be64 new_sys_guid;
+			__be32 lid; /* lid where sys guid changed */
+		} __packed ntc_145;
+
+		struct {
+			__be32 lid;
+			__be32 dr_slid;
+			u8 method;
+			u8 dr_trunc_hop;
+			__be16 attr_id;
+			__be32 attr_mod;
+			__be64 mkey;
+			u8 dr_rtn_path[30];
+		} __packed ntc_256;
+
+		struct {
+			__be32 lid1;
+			__be32 lid2;
+			__be32 key;
+			u8 sl; /* SL: high 5 bits */
+			u8 reserved3[3];
+			union ib_gid gid1;
+			union ib_gid gid2;
+			__be32 qp1; /* high 8 bits reserved */
+			__be32 qp2; /* high 8 bits reserved */
+		} __packed ntc_257_258;
+
+		struct {
+			__be16 flags; /* low 8 bits reserved */
+			__be16 pkey;
+			__be32 lid1;
+			__be32 lid2;
+			u8 sl; /* SL: high 5 bits */
+			u8 reserved4[3];
+			union ib_gid gid1;
+			union ib_gid gid2;
+			__be32 qp1; /* high 8 bits reserved */
+			__be32 qp2; /* high 8 bits reserved */
+		} __packed ntc_259;
+
+		struct {
+			__be32 lid;
+		} __packed ntc_2048;
+	};
+};
+
+#define IB_VLARB_LOWPRI_0_31 1
+#define IB_VLARB_LOWPRI_32_63 2
+#define IB_VLARB_HIGHPRI_0_31 3
+#define IB_VLARB_HIGHPRI_32_63 4
+
+#define OPA_MAX_PREEMPT_CAP 32
+#define OPA_VLARB_LOW_ELEMENTS 0
+#define OPA_VLARB_HIGH_ELEMENTS 1
+#define OPA_VLARB_PREEMPT_ELEMENTS 2
+#define OPA_VLARB_PREEMPT_MATRIX 3
+
+#define IB_PMA_PORT_COUNTERS_CONG cpu_to_be16(0xFF00)
+#define LINK_SPEED_25G 1
+#define LINK_SPEED_12_5G 2
+#define LINK_WIDTH_DEFAULT 4
+#define DECIMAL_FACTORING 1000
+/*
+ * The default link width is multiplied by 1000
+ * to get accurate value after division.
+ */
+#define FACTOR_LINK_WIDTH (LINK_WIDTH_DEFAULT * DECIMAL_FACTORING)
+
+struct ib_pma_portcounters_cong {
+	u8 reserved;
+	u8 reserved1;
+	__be16 port_check_rate;
+	__be16 symbol_error_counter;
+	u8 link_error_recovery_counter;
+	u8 link_downed_counter;
+	__be16 port_rcv_errors;
+	__be16 port_rcv_remphys_errors;
+	__be16 port_rcv_switch_relay_errors;
+	__be16 port_xmit_discards;
+	u8 port_xmit_constraint_errors;
+	u8 port_rcv_constraint_errors;
+	u8 reserved2;
+	u8 link_overrun_errors; /* LocalLink: 7:4, BufferOverrun: 3:0 */
+	__be16 reserved3;
+	__be16 vl15_dropped;
+	__be64 port_xmit_data;
+	__be64 port_rcv_data;
+	__be64 port_xmit_packets;
+	__be64 port_rcv_packets;
+	__be64 port_xmit_wait;
+	__be64 port_adr_events;
+} __packed;
+
+#define IB_SMP_UNSUP_VERSION cpu_to_be16(0x0004)
+#define IB_SMP_UNSUP_METHOD cpu_to_be16(0x0008)
+#define IB_SMP_UNSUP_METH_ATTR cpu_to_be16(0x000C)
+#define IB_SMP_INVALID_FIELD cpu_to_be16(0x001C)
+
+#define OPA_MAX_PREEMPT_CAP 32
+#define OPA_VLARB_LOW_ELEMENTS 0
+#define OPA_VLARB_HIGH_ELEMENTS 1
+#define OPA_VLARB_PREEMPT_ELEMENTS 2
+#define OPA_VLARB_PREEMPT_MATRIX 3
+
+#define HFI2_XMIT_RATE_UNSUPPORTED 0x0
+#define HFI2_XMIT_RATE_PICO 0x7
+/* number of 4nsec cycles equaling 2secs */
+#define HFI2_CONG_TIMER_PSINTERVAL 0x1DCD64EC
+
+#define IB_CC_SVCTYPE_RC 0x0
+#define IB_CC_SVCTYPE_UC 0x1
+#define IB_CC_SVCTYPE_RD 0x2
+#define IB_CC_SVCTYPE_UD 0x3
+
+/*
+ * There should be an equivalent IB #define for the following, but
+ * I cannot find it.
+ */
+#define OPA_CC_LOG_TYPE_HFI 2
+
+struct opa_hfi2_cong_log_event_internal {
+	u32 lqpn;
+	u32 rqpn;
+	u8 sl;
+	u8 svc_type;
+	u32 rlid;
+	u64 timestamp; /* wider than 32 bits to detect 32 bit rollover */
+};
+
+struct opa_hfi2_cong_log_event {
+	u8 local_qp_cn_entry[3];
+	u8 remote_qp_number_cn_entry[3];
+	u8 sl_svc_type_cn_entry; /* 5 bits SL, 3 bits svc type */
+	u8 reserved;
+	__be32 remote_lid_cn_entry;
+	__be32 timestamp_cn_entry;
+} __packed;
+
+#define OPA_CONG_LOG_ELEMS 96
+
+struct opa_hfi2_cong_log {
+	u8 log_type;
+	u8 congestion_flags;
+	__be16 threshold_event_counter;
+	__be32 current_time_stamp;
+	u8 threshold_cong_event_map[OPA_MAX_SLS / 8];
+	struct opa_hfi2_cong_log_event events[OPA_CONG_LOG_ELEMS];
+} __packed;
+
+#define IB_CC_TABLE_CAP_DEFAULT 31
+
+/* Port control flags */
+#define IB_CC_CCS_PC_SL_BASED 0x01
+
+struct opa_congestion_setting_entry {
+	u8 ccti_increase;
+	u8 reserved;
+	__be16 ccti_timer;
+	u8 trigger_threshold;
+	u8 ccti_min; /* min CCTI for cc table */
+} __packed;
+
+struct opa_congestion_setting_entry_shadow {
+	u8 ccti_increase;
+	u8 reserved;
+	u16 ccti_timer;
+	u8 trigger_threshold;
+	u8 ccti_min; /* min CCTI for cc table */
+} __packed;
+
+struct opa_congestion_setting_attr {
+	__be32 control_map;
+	__be16 port_control;
+	struct opa_congestion_setting_entry entries[OPA_MAX_SLS];
+} __packed;
+
+struct opa_congestion_setting_attr_shadow {
+	u32 control_map;
+	u16 port_control;
+	struct opa_congestion_setting_entry_shadow entries[OPA_MAX_SLS];
+} __packed;
+
+#define IB_CC_TABLE_ENTRY_INCREASE_DEFAULT 1
+#define IB_CC_TABLE_ENTRY_TIMER_DEFAULT 1
+
+/* 64 Congestion Control table entries in a single MAD */
+#define IB_CCT_ENTRIES 64
+#define IB_CCT_MIN_ENTRIES (IB_CCT_ENTRIES * 2)
+
+struct ib_cc_table_entry {
+	__be16 entry; /* shift:2, multiplier:14 */
+};
+
+struct ib_cc_table_entry_shadow {
+	u16 entry; /* shift:2, multiplier:14 */
+};
+
+struct ib_cc_table_attr {
+	__be16 ccti_limit; /* max CCTI for cc table */
+	struct ib_cc_table_entry ccti_entries[IB_CCT_ENTRIES];
+} __packed;
+
+struct ib_cc_table_attr_shadow {
+	u16 ccti_limit; /* max CCTI for cc table */
+	struct ib_cc_table_entry_shadow ccti_entries[IB_CCT_ENTRIES];
+};
+
+#define CC_TABLE_SHADOW_MAX (IB_CC_TABLE_CAP_DEFAULT * IB_CCT_ENTRIES)
+
+struct cc_table_shadow {
+	u16 ccti_limit; /* max CCTI for cc table */
+	struct ib_cc_table_entry_shadow entries[CC_TABLE_SHADOW_MAX];
+};
+
+/*
+ * struct cc_state combines the (active) per-port congestion control
+ * table, and the (active) per-SL congestion settings. cc_state data
+ * may need to be read in code paths that we want to be fast, so it
+ * is an RCU protected structure.
+ */
+struct cc_state {
+	struct rcu_head rcu;
+	struct cc_table_shadow cct;
+	struct opa_congestion_setting_attr_shadow cong_setting;
+};
+
+/*
+ * OPA BufferControl MAD
+ */
+
+/* attribute modifier macros */
+#define OPA_AM_NPORT_SHIFT 24
+#define OPA_AM_NPORT_MASK 0xff
+#define OPA_AM_NPORT_SMASK (OPA_AM_NPORT_MASK << OPA_AM_NPORT_SHIFT)
+#define OPA_AM_NPORT(am) (((am) >> OPA_AM_NPORT_SHIFT) & OPA_AM_NPORT_MASK)
+
+#define OPA_AM_NBLK_SHIFT 24
+#define OPA_AM_NBLK_MASK 0xff
+#define OPA_AM_NBLK_SMASK (OPA_AM_NBLK_MASK << OPA_AM_NBLK_SHIFT)
+#define OPA_AM_NBLK(am) (((am) >> OPA_AM_NBLK_SHIFT) & OPA_AM_NBLK_MASK)
+
+#define OPA_AM_START_BLK_SHIFT 0
+#define OPA_AM_START_BLK_MASK 0xff
+#define OPA_AM_START_BLK_SMASK (OPA_AM_START_BLK_MASK << OPA_AM_START_BLK_SHIFT)
+#define OPA_AM_START_BLK(am) \
+	(((am) >> OPA_AM_START_BLK_SHIFT) & OPA_AM_START_BLK_MASK)
+
+#define OPA_AM_PORTNUM_SHIFT 0
+#define OPA_AM_PORTNUM_MASK 0xff
+#define OPA_AM_PORTNUM_SMASK (OPA_AM_PORTNUM_MASK << OPA_AM_PORTNUM_SHIFT)
+#define OPA_AM_PORTNUM(am) \
+	(((am) >> OPA_AM_PORTNUM_SHIFT) & OPA_AM_PORTNUM_MASK)
+
+#define OPA_AM_ASYNC_SHIFT 12
+#define OPA_AM_ASYNC_MASK 0x1
+#define OPA_AM_ASYNC_SMASK (OPA_AM_ASYNC_MASK << OPA_AM_ASYNC_SHIFT)
+#define OPA_AM_ASYNC(am) (((am) >> OPA_AM_ASYNC_SHIFT) & OPA_AM_ASYNC_MASK)
+
+#define OPA_AM_START_SM_CFG_SHIFT 9
+#define OPA_AM_START_SM_CFG_MASK 0x1
+#define OPA_AM_START_SM_CFG_SMASK \
+	(OPA_AM_START_SM_CFG_MASK << OPA_AM_START_SM_CFG_SHIFT)
+#define OPA_AM_START_SM_CFG(am) \
+	(((am) >> OPA_AM_START_SM_CFG_SHIFT) & OPA_AM_START_SM_CFG_MASK)
+
+#define OPA_AM_CI_ADDR_SHIFT 19
+#define OPA_AM_CI_ADDR_MASK 0xfff
+#define OPA_AM_CI_ADDR_SMASK (OPA_AM_CI_ADDR_MASK << OPA_CI_ADDR_SHIFT)
+#define OPA_AM_CI_ADDR(am) \
+	(((am) >> OPA_AM_CI_ADDR_SHIFT) & OPA_AM_CI_ADDR_MASK)
+
+#define OPA_AM_CI_LEN_SHIFT 13
+#define OPA_AM_CI_LEN_MASK 0x3f
+#define OPA_AM_CI_LEN_SMASK (OPA_AM_CI_LEN_MASK << OPA_CI_LEN_SHIFT)
+#define OPA_AM_CI_LEN(am) (((am) >> OPA_AM_CI_LEN_SHIFT) & OPA_AM_CI_LEN_MASK)
+
+/* error info macros */
+#define OPA_EI_STATUS_SMASK 0x80
+#define OPA_EI_CODE_SMASK 0x0f
+
+struct vl_limit {
+	__be16 dedicated;
+	__be16 shared;
+};
+
+struct buffer_control {
+	__be16 reserved;
+	__be16 overall_shared_limit;
+	struct vl_limit vl[OPA_MAX_VLS];
+};
+
+struct sc2vlnt {
+	u8 vlnt[32]; /* 5 bit VL, 3 bits reserved */
+};
+
+/*
+ * The PortSamplesControl.CounterMasks field is an array of 3 bit fields
+ * which specify the N'th counter's capabilities. See ch. 16.1.3.2.
+ * We support 5 counters which only count the mandatory quantities.
+ */
+#define COUNTER_MASK(q, n) (q << ((9 - n) * 3))
+#define COUNTER_MASK0_9                                       \
+	cpu_to_be32(COUNTER_MASK(1, 0) | COUNTER_MASK(1, 1) | \
+		    COUNTER_MASK(1, 2) | COUNTER_MASK(1, 3) | \
+		    COUNTER_MASK(1, 4))
+
+void hfi2_event_pkey_change(struct hfi2_devdata *dd, u32 port);
+void hfi2_handle_trap_timer(struct timer_list *t);
+u16 hfi2_tx_link_width(u16 link_width);
+u64 hfi2_get_xmit_wait_counters(struct hfi2_pportdata *ppd, u16 link_width,
+			   u16 link_speed, int vl);
+void hfi2_update_sc2vlt(struct hfi2_pportdata *ppd, void *data, bool filter);
+int hfi2_mad_init(struct hfi2_devdata *dd);
+int hfi2_mad_deinit(struct hfi2_devdata *dd);
+int hfi2_get_sc2vlt_tables(struct hfi2_pportdata *ppd, void *data);
+
+int hfi2_cport_send_only_mad(struct hfi2_devdata *dd, u8 sb, const void *mad,
+			int len);
+int hfi2_cport_send_recv_mad(struct hfi2_devdata *dd, u8 sb, const void *mad,
+			int len, void *omad, size_t *omad_len);
+int hfi2_update_from_opa_portinfo(struct hfi2_pportdata *ppd, struct opa_smp *smp,
+			     struct opa_port_info *pi);
+
+/**
+ * get_link_speed - determine whether 12.5G or 25G speed
+ * @link_speed: the speed of active link
+ * @return: Return 2 if link speed identified as 12.5G
+ * or return 1 if link speed is 25G.
+ *
+ * The function indirectly calculate required link speed
+ * value for convert_xmit_counter function. If the link
+ * speed is 25G, the function return as 1 as it is required
+ * by xmit counter conversion formula :-( 25G / link_speed).
+ * This conversion will provide value 1 if current
+ * link speed is 25G or 2 if 12.5G.This is done to avoid
+ * 12.5 float number conversion.
+ */
+static inline u16 get_link_speed(u16 link_speed)
+{
+	return (link_speed == 1) ? LINK_SPEED_12_5G : LINK_SPEED_25G;
+}
+
+/**
+ * convert_xmit_counter - calculate flit times for given xmit counter
+ * value
+ * @xmit_wait_val: current xmit counter value
+ * @link_width: width of active link
+ * @link_speed: speed of active link
+ * @return: return xmit counter value in flit times.
+ */
+static inline u64 convert_xmit_counter(u64 xmit_wait_val, u16 link_width,
+				       u16 link_speed)
+{
+	return (xmit_wait_val * 2 * (FACTOR_LINK_WIDTH / link_width) *
+		link_speed) /
+	       DECIMAL_FACTORING;
+}
+#endif /* _HFI2_MAD_H */
diff --git a/drivers/infiniband/hw/hfi2/opa_compat.h b/drivers/infiniband/hw/hfi2/opa_compat.h
new file mode 100644
index 000000000000..8e8b7f62082a
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/opa_compat.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015, 2016 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#ifndef _LINUX_H
+#define _LINUX_H
+/*
+ * This header file is for OPA-specific definitions which are
+ * required by the HFI driver, and which aren't yet in the Linux
+ * IB core. We'll collect these all here, then merge them into
+ * the kernel when that's convenient.
+ */
+
+/* OPA SMA attribute IDs */
+#define OPA_ATTRIB_ID_CONGESTION_INFO		cpu_to_be16(0x008b)
+#define OPA_ATTRIB_ID_HFI_CONGESTION_LOG	cpu_to_be16(0x008f)
+#define OPA_ATTRIB_ID_HFI_CONGESTION_SETTING	cpu_to_be16(0x0090)
+#define OPA_ATTRIB_ID_CONGESTION_CONTROL_TABLE	cpu_to_be16(0x0091)
+
+/* OPA PMA attribute IDs */
+#define OPA_PM_ATTRIB_ID_PORT_STATUS		cpu_to_be16(0x0040)
+#define OPA_PM_ATTRIB_ID_CLEAR_PORT_STATUS	cpu_to_be16(0x0041)
+#define OPA_PM_ATTRIB_ID_DATA_PORT_COUNTERS	cpu_to_be16(0x0042)
+#define OPA_PM_ATTRIB_ID_ERROR_PORT_COUNTERS	cpu_to_be16(0x0043)
+#define OPA_PM_ATTRIB_ID_ERROR_INFO		cpu_to_be16(0x0044)
+
+/* OPA status codes */
+#define OPA_PM_STATUS_REQUEST_TOO_LARGE		cpu_to_be16(0x100)
+
+static inline u8 port_states_to_logical_state(struct opa_port_states *ps)
+{
+	return ps->portphysstate_portstate & OPA_PI_MASK_PORT_STATE;
+}
+
+static inline u8 port_states_to_phys_state(struct opa_port_states *ps)
+{
+	return ((ps->portphysstate_portstate &
+		  OPA_PI_MASK_PORT_PHYSICAL_STATE) >> 4) & 0xf;
+}
+
+/*
+ * OPA port physical states
+ * IB Volume 1, Table 146 PortInfo/IB Volume 2 Section 5.4.2(1) PortPhysState
+ * values are the same in OmniPath Architecture. OPA leverages some of the same
+ * concepts as InfiniBand, but has a few other states as well.
+ *
+ * When writing, only values 0-3 are valid, other values are ignored.
+ * When reading, 0 is reserved.
+ *
+ * Returned by the ibphys_portstate() routine.
+ */
+enum opa_port_phys_state {
+	/* Values 0-7 have the same meaning in OPA as in InfiniBand. */
+
+	IB_PORTPHYSSTATE_NOP = 0,
+	/* 1 is reserved */
+	IB_PORTPHYSSTATE_POLLING = 2,
+	IB_PORTPHYSSTATE_DISABLED = 3,
+	IB_PORTPHYSSTATE_TRAINING = 4,
+	IB_PORTPHYSSTATE_LINKUP = 5,
+	IB_PORTPHYSSTATE_LINK_ERROR_RECOVERY = 6,
+	IB_PORTPHYSSTATE_PHY_TEST = 7,
+	/* 8 is reserved */
+
+	/*
+	 * Offline: Port is quiet (transmitters disabled) due to lack of
+	 * physical media, unsupported media, or transition between link up
+	 * and next link up attempt
+	 */
+	OPA_PORTPHYSSTATE_OFFLINE = 9,
+
+	/* 10 is reserved */
+
+	/*
+	 * Phy_Test: Specific test patterns are transmitted, and receiver BER
+	 * can be monitored. This facilitates signal integrity testing for the
+	 * physical layer of the port.
+	 */
+	OPA_PORTPHYSSTATE_TEST = 11,
+
+	OPA_PORTPHYSSTATE_MAX = 11,
+	/* values 12-15 are reserved/ignored */
+};
+
+#endif /* _LINUX_H */



