Return-Path: <linux-rdma+bounces-3860-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FD29309E3
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jul 2024 14:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891E31F215CE
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jul 2024 12:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4C46D1C7;
	Sun, 14 Jul 2024 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Utcrhdtl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-210.smtpout.orange.fr [193.252.23.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB749647;
	Sun, 14 Jul 2024 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720959347; cv=none; b=dgwABBO6RSB7Oybp50HxVBYslVAnq8ZDQPs5XmVXGav4+QkfmnM502vjXahW9banJnuH6np6JGyVpEYg+EMLfrf2ivsqhDmGpjNXsCsJVIPE8pBQiShsy+5OOu5w1o9NHN5bQvC878siFbN1BqgRGMd/S+3RKlR0WNQq+5OyMcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720959347; c=relaxed/simple;
	bh=wemadaPaF5tYj2gDESeIMIx0Xn4/NfVv5MLoAteFeac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7ScIerPyfGSE823O7fznl/gJUbCqUvXkJ4NFZ1l2tL57wdJWtmUxOSTEiu2NCRaIHHU2I0PTXetkVKp5BRzadk1gX+ajSIU48fS3U6t5oQbgbsBz8437JZ3G1bLxGdVZ11XdvX4QZ71BNenj12BGWuyGO4q6qNT8OkNJLGg0Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Utcrhdtl; arc=none smtp.client-ip=193.252.23.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id Sy8aseahrEfqMSy8asZxKO; Sun, 14 Jul 2024 14:15:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720959336;
	bh=Ib9jUMmVKMUmOCzzj+eKpdb7WVSo4L1l4Cu4ds83SNs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UtcrhdtlKRnx7p4YDJGKQVifbW5vaTGFLxGBUU6tbNtnme/AAY5U35n1NiGGeMhTd
	 AdouoG7UHfUpMrEK+e2fIt1N0BAvSF5XO7EkqoslfTHPdwd5gabMw9NGfDHHmXr+s7
	 SMN3aqhY22JfwqSANXtdYMIOxR3FnE5jeFeBzSpM1wh+CUTH1ktDpcTKyJaWRVa1Vr
	 VGHEtroAshKuK/G3tuJYBgxcDxPLbMQ59dBRHl3QzuO5wYHPTNeIQu2tWQO0EW7AyM
	 QqRxgn4PXwAhMSxy0r3Lz8F6ui3dndE1yOgviUH8TCXGDZH9BAFttqpynWR78ZWpwZ
	 7NDko9UJC7wYA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Jul 2024 14:15:36 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-rdma@vger.kernel.org
Subject: [PATCH] IB/hfi1: Constify struct flag_table
Date: Sun, 14 Jul 2024 14:15:25 +0200
Message-ID: <782b6a648bfbbf2bb83f81a73c0460b5bb7642a1.1720959310.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct flag_table' are not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
 302932	  40271	    112	 343315	  53d13	drivers/infiniband/hw/hfi1/chip.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
 311636	  31567	    112	 343315	  53d13	drivers/infiniband/hw/hfi1/chip.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/infiniband/hw/hfi1/chip.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 78f27f7b4203..c52e6b2c9914 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -251,7 +251,7 @@ struct flag_table {
 /*
  * CCE Error flags.
  */
-static struct flag_table cce_err_status_flags[] = {
+static const struct flag_table cce_err_status_flags[] = {
 /* 0*/	FLAG_ENTRY0("CceCsrParityErr",
 		CCE_ERR_STATUS_CCE_CSR_PARITY_ERR_SMASK),
 /* 1*/	FLAG_ENTRY0("CceCsrReadBadAddrErr",
@@ -341,7 +341,7 @@ static struct flag_table cce_err_status_flags[] = {
  * Misc Error flags
  */
 #define MES(text) MISC_ERR_STATUS_MISC_##text##_ERR_SMASK
-static struct flag_table misc_err_status_flags[] = {
+static const struct flag_table misc_err_status_flags[] = {
 /* 0*/	FLAG_ENTRY0("CSR_PARITY", MES(CSR_PARITY)),
 /* 1*/	FLAG_ENTRY0("CSR_READ_BAD_ADDR", MES(CSR_READ_BAD_ADDR)),
 /* 2*/	FLAG_ENTRY0("CSR_WRITE_BAD_ADDR", MES(CSR_WRITE_BAD_ADDR)),
@@ -360,7 +360,7 @@ static struct flag_table misc_err_status_flags[] = {
 /*
  * TXE PIO Error flags and consequences
  */
-static struct flag_table pio_err_status_flags[] = {
+static const struct flag_table pio_err_status_flags[] = {
 /* 0*/	FLAG_ENTRY("PioWriteBadCtxt",
 	SEC_WRITE_DROPPED,
 	SEND_PIO_ERR_STATUS_PIO_WRITE_BAD_CTXT_ERR_SMASK),
@@ -502,7 +502,7 @@ static struct flag_table pio_err_status_flags[] = {
 /*
  * TXE SDMA Error flags
  */
-static struct flag_table sdma_err_status_flags[] = {
+static const struct flag_table sdma_err_status_flags[] = {
 /* 0*/	FLAG_ENTRY0("SDmaRpyTagErr",
 		SEND_DMA_ERR_STATUS_SDMA_RPY_TAG_ERR_SMASK),
 /* 1*/	FLAG_ENTRY0("SDmaCsrParityErr",
@@ -530,7 +530,7 @@ static struct flag_table sdma_err_status_flags[] = {
  * TXE Egress Error flags
  */
 #define SEES(text) SEND_EGRESS_ERR_STATUS_##text##_ERR_SMASK
-static struct flag_table egress_err_status_flags[] = {
+static const struct flag_table egress_err_status_flags[] = {
 /* 0*/	FLAG_ENTRY0("TxPktIntegrityMemCorErr", SEES(TX_PKT_INTEGRITY_MEM_COR)),
 /* 1*/	FLAG_ENTRY0("TxPktIntegrityMemUncErr", SEES(TX_PKT_INTEGRITY_MEM_UNC)),
 /* 2 reserved */
@@ -631,7 +631,7 @@ static struct flag_table egress_err_status_flags[] = {
  * TXE Egress Error Info flags
  */
 #define SEEI(text) SEND_EGRESS_ERR_INFO_##text##_ERR_SMASK
-static struct flag_table egress_err_info_flags[] = {
+static const struct flag_table egress_err_info_flags[] = {
 /* 0*/	FLAG_ENTRY0("Reserved", 0ull),
 /* 1*/	FLAG_ENTRY0("VLErr", SEEI(VL)),
 /* 2*/	FLAG_ENTRY0("JobKeyErr", SEEI(JOB_KEY)),
@@ -680,7 +680,7 @@ static struct flag_table egress_err_info_flags[] = {
  * TXE Send error flags
  */
 #define SES(name) SEND_ERR_STATUS_SEND_##name##_ERR_SMASK
-static struct flag_table send_err_status_flags[] = {
+static const struct flag_table send_err_status_flags[] = {
 /* 0*/	FLAG_ENTRY0("SendCsrParityErr", SES(CSR_PARITY)),
 /* 1*/	FLAG_ENTRY0("SendCsrReadBadAddrErr", SES(CSR_READ_BAD_ADDR)),
 /* 2*/	FLAG_ENTRY0("SendCsrWriteBadAddrErr", SES(CSR_WRITE_BAD_ADDR))
@@ -689,7 +689,7 @@ static struct flag_table send_err_status_flags[] = {
 /*
  * TXE Send Context Error flags and consequences
  */
-static struct flag_table sc_err_status_flags[] = {
+static const struct flag_table sc_err_status_flags[] = {
 /* 0*/	FLAG_ENTRY("InconsistentSop",
 		SEC_PACKET_DROPPED | SEC_SC_HALTED,
 		SEND_CTXT_ERR_STATUS_PIO_INCONSISTENT_SOP_ERR_SMASK),
@@ -712,7 +712,7 @@ static struct flag_table sc_err_status_flags[] = {
  * RXE Receive Error flags
  */
 #define RXES(name) RCV_ERR_STATUS_RX_##name##_ERR_SMASK
-static struct flag_table rxe_err_status_flags[] = {
+static const struct flag_table rxe_err_status_flags[] = {
 /* 0*/	FLAG_ENTRY0("RxDmaCsrCorErr", RXES(DMA_CSR_COR)),
 /* 1*/	FLAG_ENTRY0("RxDcIntfParityErr", RXES(DC_INTF_PARITY)),
 /* 2*/	FLAG_ENTRY0("RxRcvHdrUncErr", RXES(RCV_HDR_UNC)),
@@ -847,7 +847,7 @@ static struct flag_table rxe_err_status_flags[] = {
  * DCC Error Flags
  */
 #define DCCE(name) DCC_ERR_FLG_##name##_SMASK
-static struct flag_table dcc_err_flags[] = {
+static const struct flag_table dcc_err_flags[] = {
 	FLAG_ENTRY0("bad_l2_err", DCCE(BAD_L2_ERR)),
 	FLAG_ENTRY0("bad_sc_err", DCCE(BAD_SC_ERR)),
 	FLAG_ENTRY0("bad_mid_tail_err", DCCE(BAD_MID_TAIL_ERR)),
@@ -900,7 +900,7 @@ static struct flag_table dcc_err_flags[] = {
  * LCB error flags
  */
 #define LCBE(name) DC_LCB_ERR_FLG_##name##_SMASK
-static struct flag_table lcb_err_flags[] = {
+static const struct flag_table lcb_err_flags[] = {
 /* 0*/	FLAG_ENTRY0("CSR_PARITY_ERR", LCBE(CSR_PARITY_ERR)),
 /* 1*/	FLAG_ENTRY0("INVALID_CSR_ADDR", LCBE(INVALID_CSR_ADDR)),
 /* 2*/	FLAG_ENTRY0("RST_FOR_FAILED_DESKEW", LCBE(RST_FOR_FAILED_DESKEW)),
@@ -943,7 +943,7 @@ static struct flag_table lcb_err_flags[] = {
  * DC8051 Error Flags
  */
 #define D8E(name) DC_DC8051_ERR_FLG_##name##_SMASK
-static struct flag_table dc8051_err_flags[] = {
+static const struct flag_table dc8051_err_flags[] = {
 	FLAG_ENTRY0("SET_BY_8051", D8E(SET_BY_8051)),
 	FLAG_ENTRY0("LOST_8051_HEART_BEAT", D8E(LOST_8051_HEART_BEAT)),
 	FLAG_ENTRY0("CRAM_MBE", D8E(CRAM_MBE)),
@@ -962,7 +962,7 @@ static struct flag_table dc8051_err_flags[] = {
  *
  * Flags in DC8051_DBG_ERR_INFO_SET_BY_8051.ERROR field.
  */
-static struct flag_table dc8051_info_err_flags[] = {
+static const struct flag_table dc8051_info_err_flags[] = {
 	FLAG_ENTRY0("Spico ROM check failed",  SPICO_ROM_FAILED),
 	FLAG_ENTRY0("Unknown frame received",  UNKNOWN_FRAME),
 	FLAG_ENTRY0("Target BER not met",      TARGET_BER_NOT_MET),
@@ -986,7 +986,7 @@ static struct flag_table dc8051_info_err_flags[] = {
  *
  * Flags in DC8051_DBG_ERR_INFO_SET_BY_8051.HOST_MSG field.
  */
-static struct flag_table dc8051_info_host_msg_flags[] = {
+static const struct flag_table dc8051_info_host_msg_flags[] = {
 	FLAG_ENTRY0("Host request done", 0x0001),
 	FLAG_ENTRY0("BC PWR_MGM message", 0x0002),
 	FLAG_ENTRY0("BC SMA message", 0x0004),
@@ -5275,7 +5275,7 @@ static int append_str(char *buf, char **curp, int *lenp, const char *s)
  * the buffer.  End in '*' if the buffer is too short.
  */
 static char *flag_string(char *buf, int buf_len, u64 flags,
-			 struct flag_table *table, int table_size)
+			 const struct flag_table *table, int table_size)
 {
 	char extra[32];
 	char *p = buf;
-- 
2.45.2


