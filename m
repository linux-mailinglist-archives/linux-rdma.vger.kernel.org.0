Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52E9913132B
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2020 14:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgAFNmh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jan 2020 08:42:37 -0500
Received: from mga02.intel.com ([134.134.136.20]:37265 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgAFNmh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jan 2020 08:42:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 05:42:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,402,1571727600"; 
   d="scan'208";a="422125505"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jan 2020 05:42:36 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 006DgaWe037356;
        Mon, 6 Jan 2020 06:42:36 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 006DgZmE119744;
        Mon, 6 Jan 2020 08:42:35 -0500
Subject: [PATCH for-next 9/9] IB/hfi1: Add RcvShortLengthErrCnt to hfi1stats
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 06 Jan 2020 08:42:35 -0500
Message-ID: <20200106134235.119356.29123.stgit@awfm-01.aw.intel.com>
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

This counter, RxShrErr,  is required for error analysis and debug.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/chip.c           |    1 +
 drivers/infiniband/hw/hfi1/chip.h           |    1 +
 drivers/infiniband/hw/hfi1/chip_registers.h |    1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 012f333..e0b1238 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -4114,6 +4114,7 @@ static u64 access_dc_rcv_err_cnt(const struct cntr_entry *entry,
 static struct cntr_entry dev_cntrs[DEV_CNTR_LAST] = {
 [C_RCV_OVF] = RXE32_DEV_CNTR_ELEM(RcvOverflow, RCV_BUF_OVFL_CNT, CNTR_SYNTH),
 [C_RX_LEN_ERR] = RXE32_DEV_CNTR_ELEM(RxLenErr, RCV_LENGTH_ERR_CNT, CNTR_SYNTH),
+[C_RX_SHORT_ERR] = RXE32_DEV_CNTR_ELEM(RxShrErr, RCV_SHORT_ERR_CNT, CNTR_SYNTH),
 [C_RX_ICRC_ERR] = RXE32_DEV_CNTR_ELEM(RxICrcErr, RCV_ICRC_ERR_CNT, CNTR_SYNTH),
 [C_RX_EBP] = RXE32_DEV_CNTR_ELEM(RxEbpCnt, RCV_EBP_CNT, CNTR_SYNTH),
 [C_RX_TID_FULL] = RXE32_DEV_CNTR_ELEM(RxTIDFullEr, RCV_TID_FULL_ERR_CNT,
diff --git a/drivers/infiniband/hw/hfi1/chip.h b/drivers/infiniband/hw/hfi1/chip.h
index 93c9c8c..7255092 100644
--- a/drivers/infiniband/hw/hfi1/chip.h
+++ b/drivers/infiniband/hw/hfi1/chip.h
@@ -865,6 +865,7 @@ static inline int idx_from_vl(int vl)
 enum {
 	C_RCV_OVF = 0,
 	C_RX_LEN_ERR,
+	C_RX_SHORT_ERR,
 	C_RX_ICRC_ERR,
 	C_RX_EBP,
 	C_RX_TID_FULL,
diff --git a/drivers/infiniband/hw/hfi1/chip_registers.h b/drivers/infiniband/hw/hfi1/chip_registers.h
index ab3589d..fb3ec9b 100644
--- a/drivers/infiniband/hw/hfi1/chip_registers.h
+++ b/drivers/infiniband/hw/hfi1/chip_registers.h
@@ -381,6 +381,7 @@
 #define DC_LCB_STS_LINK_TRANSFER_ACTIVE (DC_LCB_CSRS + 0x000000000468)
 #define DC_LCB_STS_ROUND_TRIP_LTP_CNT (DC_LCB_CSRS + 0x0000000004B0)
 #define RCV_LENGTH_ERR_CNT 0
+#define RCV_SHORT_ERR_CNT 2
 #define RCV_ICRC_ERR_CNT 6
 #define RCV_EBP_CNT 9
 #define RCV_BUF_OVFL_CNT 10

