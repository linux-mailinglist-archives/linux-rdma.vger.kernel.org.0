Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D58C1901C2
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2020 00:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCWXP6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Mar 2020 19:15:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:43410 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgCWXP6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Mar 2020 19:15:58 -0400
IronPort-SDR: EIH5/gfUUTK+zET0yY5s+4b0x0K8iS7LE1zyV+UiAVocfK2E6qWbVh6aT8DRSO+pY3efYOFP1D
 jYTiHKjetdjw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 16:15:58 -0700
IronPort-SDR: mlr8DxL528ab+rLIz5uUV1B7AB6l54uLr7JHBdBfsPYTuK8SqnHbCPXXVidFVdNqvk2LnCcK5z
 K1zjNT8KrHSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="393075939"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga004.jf.intel.com with ESMTP; 23 Mar 2020 16:15:57 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 02NNFufN014104;
        Mon, 23 Mar 2020 16:15:57 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 02NNFtax064540;
        Mon, 23 Mar 2020 19:15:55 -0400
Subject: [PATCH v2 for-next 14/16] IB/hfi1: Add packet histogram trace event
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 23 Mar 2020 19:15:55 -0400
Message-ID: <20200323231555.64035.39661.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200323231152.64035.19274.stgit@awfm-01.aw.intel.com>
References: <20200323231152.64035.19274.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>

Add a simple trace event taking context number and building simple
histogram to print packets distribution between contexts.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/driver.c      |    1 +
 drivers/infiniband/hw/hfi1/trace.c       |   32 ++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/trace_ctxts.h |   11 +++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index 60ff6de..a40701a 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -1706,6 +1706,7 @@ static void hfi1_ipoib_ib_rcv(struct hfi1_packet *packet)
 		goto drop_no_nd;
 
 	trace_input_ibhdr(rcd->dd, packet, !!(rhf_dc_info(packet->rhf)));
+	trace_ctxt_rsm_hist(rcd->ctxt);
 
 	/* handle congestion notifications */
 	do_work = hfi1_may_ecn(packet);
diff --git a/drivers/infiniband/hw/hfi1/trace.c b/drivers/infiniband/hw/hfi1/trace.c
index c8a9988..b219ea9 100644
--- a/drivers/infiniband/hw/hfi1/trace.c
+++ b/drivers/infiniband/hw/hfi1/trace.c
@@ -520,6 +520,38 @@ u16 hfi1_trace_get_tid_idx(u32 ent)
 	return EXP_TID_GET(ent, IDX);
 }
 
+struct hfi1_ctxt_hist {
+	atomic_t count;
+	atomic_t data[255];
+};
+
+struct hfi1_ctxt_hist hist = {
+	.count = ATOMIC_INIT(0)
+};
+
+const char *hfi1_trace_print_rsm_hist(struct trace_seq *p, unsigned int ctxt)
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
 __hfi1_trace_fn(AFFINITY);
 __hfi1_trace_fn(PKT);
 __hfi1_trace_fn(PROC);
diff --git a/drivers/infiniband/hw/hfi1/trace_ctxts.h b/drivers/infiniband/hw/hfi1/trace_ctxts.h
index b5fc5c6..d8c168d 100644
--- a/drivers/infiniband/hw/hfi1/trace_ctxts.h
+++ b/drivers/infiniband/hw/hfi1/trace_ctxts.h
@@ -1,5 +1,5 @@
 /*
-* Copyright(c) 2015, 2016 Intel Corporation.
+* Copyright(c) 2015 - 2020 Intel Corporation.
 *
 * This file is provided under a dual BSD/GPLv2 license.  When using or
 * redistributing this file, you may do so under either license.
@@ -138,6 +138,15 @@
 		      )
 );
 
+const char *hfi1_trace_print_rsm_hist(struct trace_seq *p, unsigned int ctxt);
+TRACE_EVENT(ctxt_rsm_hist,
+	    TP_PROTO(unsigned int ctxt),
+	    TP_ARGS(ctxt),
+	    TP_STRUCT__entry(__field(unsigned int, ctxt)),
+	    TP_fast_assign(__entry->ctxt = ctxt;),
+	    TP_printk("%s", hfi1_trace_print_rsm_hist(p, __entry->ctxt))
+);
+
 #endif /* __HFI1_TRACE_CTXTS_H */
 
 #undef TRACE_INCLUDE_PATH

