Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 046ED13132A
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2020 14:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgAFNmb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jan 2020 08:42:31 -0500
Received: from mga05.intel.com ([192.55.52.43]:44680 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgAFNmb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jan 2020 08:42:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 05:42:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,402,1571727600"; 
   d="scan'208";a="253353317"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jan 2020 05:42:30 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 006DgUT9037352;
        Mon, 6 Jan 2020 06:42:30 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 006DgSIR119729;
        Mon, 6 Jan 2020 08:42:28 -0500
Subject: [PATCH for-next 8/9] IB/hfi1: Add software counter for ctxt0 seq
 drop
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 06 Jan 2020 08:42:28 -0500
Message-ID: <20200106134228.119356.96828.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200106133845.119356.20115.stgit@awfm-01.aw.intel.com>
References: <20200106133845.119356.20115.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

All other code paths increment some form of drop counter.

This was missed in the original implementation.

Fixes: 82c2611daaf0 ("staging/rdma/hfi1: Handle packets with invalid RHF on context 0")
Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/chip.c   |   10 ++++++++++
 drivers/infiniband/hw/hfi1/chip.h   |    1 +
 drivers/infiniband/hw/hfi1/driver.c |    1 +
 drivers/infiniband/hw/hfi1/hfi.h    |    2 ++
 4 files changed, 14 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 9e2bf99..012f333 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -1685,6 +1685,14 @@ static u64 access_sw_pio_drain(const struct cntr_entry *entry,
 	return dd->verbs_dev.n_piodrain;
 }
 
+static u64 access_sw_ctx0_seq_drop(const struct cntr_entry *entry,
+				   void *context, int vl, int mode, u64 data)
+{
+	struct hfi1_devdata *dd = context;
+
+	return dd->ctx0_seq_drop;
+}
+
 static u64 access_sw_vtx_wait(const struct cntr_entry *entry,
 			      void *context, int vl, int mode, u64 data)
 {
@@ -4249,6 +4257,8 @@ static u64 access_dc_rcv_err_cnt(const struct cntr_entry *entry,
 			    access_sw_cpu_intr),
 [C_SW_CPU_RCV_LIM] = CNTR_ELEM("RcvLimit", 0, 0, CNTR_NORMAL,
 			    access_sw_cpu_rcv_limit),
+[C_SW_CTX0_SEQ_DROP] = CNTR_ELEM("SeqDrop0", 0, 0, CNTR_NORMAL,
+			    access_sw_ctx0_seq_drop),
 [C_SW_VTX_WAIT] = CNTR_ELEM("vTxWait", 0, 0, CNTR_NORMAL,
 			    access_sw_vtx_wait),
 [C_SW_PIO_WAIT] = CNTR_ELEM("PioWait", 0, 0, CNTR_NORMAL,
diff --git a/drivers/infiniband/hw/hfi1/chip.h b/drivers/infiniband/hw/hfi1/chip.h
index 05b7130..93c9c8c 100644
--- a/drivers/infiniband/hw/hfi1/chip.h
+++ b/drivers/infiniband/hw/hfi1/chip.h
@@ -932,6 +932,7 @@ enum {
 	C_DC_PG_STS_TX_MBE_CNT,
 	C_SW_CPU_INTR,
 	C_SW_CPU_RCV_LIM,
+	C_SW_CTX0_SEQ_DROP,
 	C_SW_VTX_WAIT,
 	C_SW_PIO_WAIT,
 	C_SW_PIO_DRAIN,
diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index 0b9fbfa..049d15b 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -732,6 +732,7 @@ static noinline int skip_rcv_packet(struct hfi1_packet *packet, int thread)
 {
 	int ret;
 
+	packet->rcd->dd->ctx0_seq_drop++;
 	/* Set up for the next packet */
 	packet->rhqoff += packet->rsize;
 	if (packet->rhqoff >= packet->maxcnt)
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index 752dc08..6365e8f 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1159,6 +1159,8 @@ struct hfi1_devdata {
 
 	char *boardname; /* human readable board info */
 
+	u64 ctx0_seq_drop;
+
 	/* reset value */
 	u64 z_int_counter;
 	u64 z_rcv_limit;

