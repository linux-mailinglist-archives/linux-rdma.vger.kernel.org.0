Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 457B946440
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 18:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbfFNQdT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 12:33:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:48891 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfFNQdT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 12:33:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 09:33:18 -0700
X-ExtLoop1: 1
Received: from sedona.ch.intel.com ([10.2.136.157])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2019 09:33:18 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5EGXH1o060999;
        Fri, 14 Jun 2019 09:33:17 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5EGX6uM045079;
        Fri, 14 Jun 2019 12:33:16 -0400
Subject: [PATCH for-rc 7/7] IB/hfi1: Handle port down properly in pio
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Date:   Fri, 14 Jun 2019 12:33:06 -0400
Message-ID: <20190614163306.44927.33843.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190614163146.44927.95985.stgit@awfm-01.aw.intel.com>
References: <20190614163146.44927.95985.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

The call to sc_buffer_alloc currently returns NULL (no buffer) or
a buffer descriptor.

There is a third case when the port is down.  Currently that
returns NULL and this prevents the caller from properly handling the
sc_buffer_alloc() failure.  A verbs code link test after the call is
racy so the indication needs to come from the state check inside the allocation
routine to be valid.

Fix by encoding the ECOMM failure like SDMA.   IS_ERR_OR_NULL() tests
are added at all call sites.  For verbs send, this needs to treat any
error by returning a completion without any MMIO copy.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/pio.c   |    5 +++--
 drivers/infiniband/hw/hfi1/rc.c    |    2 +-
 drivers/infiniband/hw/hfi1/ud.c    |    4 ++--
 drivers/infiniband/hw/hfi1/verbs.c |    4 ++--
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
index 2f32d53..79126b2 100644
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -1443,7 +1443,8 @@ void sc_stop(struct send_context *sc, int flag)
  * @cb: optional callback to call when the buffer is finished sending
  * @arg: argument for cb
  *
- * Return a pointer to a PIO buffer if successful, NULL if not enough room.
+ * Return a pointer to a PIO buffer, NULL if not enough room, -ECOMM
+ * when link is down.
  */
 struct pio_buf *sc_buffer_alloc(struct send_context *sc, u32 dw_len,
 				pio_release_cb cb, void *arg)
@@ -1459,7 +1460,7 @@ struct pio_buf *sc_buffer_alloc(struct send_context *sc, u32 dw_len,
 	spin_lock_irqsave(&sc->alloc_lock, flags);
 	if (!(sc->flags & SCF_ENABLED)) {
 		spin_unlock_irqrestore(&sc->alloc_lock, flags);
-		goto done;
+		return ERR_PTR(-ECOMM);
 	}
 
 retry:
diff --git a/drivers/infiniband/hw/hfi1/rc.c b/drivers/infiniband/hw/hfi1/rc.c
index 4532d3c..0477c14 100644
--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -1432,7 +1432,7 @@ void hfi1_send_rc_ack(struct hfi1_packet *packet, bool is_fecn)
 	pbc = create_pbc(ppd, pbc_flags, qp->srate_mbps,
 			 sc_to_vlt(ppd->dd, sc5), plen);
 	pbuf = sc_buffer_alloc(rcd->sc, plen, NULL, NULL);
-	if (!pbuf) {
+	if (IS_ERR_OR_NULL(pbuf)) {
 		/*
 		 * We have no room to send at the moment.  Pass
 		 * responsibility for sending the ACK to the send engine
diff --git a/drivers/infiniband/hw/hfi1/ud.c b/drivers/infiniband/hw/hfi1/ud.c
index bee6011..e804af7 100644
--- a/drivers/infiniband/hw/hfi1/ud.c
+++ b/drivers/infiniband/hw/hfi1/ud.c
@@ -683,7 +683,7 @@ void return_cnp_16B(struct hfi1_ibport *ibp, struct rvt_qp *qp,
 	pbc = create_pbc(ppd, pbc_flags, qp->srate_mbps, vl, plen);
 	if (ctxt) {
 		pbuf = sc_buffer_alloc(ctxt, plen, NULL, NULL);
-		if (pbuf) {
+		if (!IS_ERR_OR_NULL(pbuf)) {
 			trace_pio_output_ibhdr(ppd->dd, &hdr, sc5);
 			ppd->dd->pio_inline_send(ppd->dd, pbuf, pbc,
 						 &hdr, hwords);
@@ -738,7 +738,7 @@ void return_cnp(struct hfi1_ibport *ibp, struct rvt_qp *qp, u32 remote_qpn,
 	pbc = create_pbc(ppd, pbc_flags, qp->srate_mbps, vl, plen);
 	if (ctxt) {
 		pbuf = sc_buffer_alloc(ctxt, plen, NULL, NULL);
-		if (pbuf) {
+		if (!IS_ERR_OR_NULL(pbuf)) {
 			trace_pio_output_ibhdr(ppd->dd, &hdr, sc5);
 			ppd->dd->pio_inline_send(ppd->dd, pbuf, pbc,
 						 &hdr, hwords);
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 1241ea6..182fa67 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1039,10 +1039,10 @@ int hfi1_verbs_send_pio(struct rvt_qp *qp, struct hfi1_pkt_state *ps,
 	if (cb)
 		iowait_pio_inc(&priv->s_iowait);
 	pbuf = sc_buffer_alloc(sc, plen, cb, qp);
-	if (unlikely(!pbuf)) {
+	if (unlikely(IS_ERR_OR_NULL(pbuf))) {
 		if (cb)
 			verbs_pio_complete(qp, 0);
-		if (ppd->host_link_state != HLS_UP_ACTIVE) {
+		if (IS_ERR(pbuf)) {
 			/*
 			 * If we have filled the PIO buffers to capacity and are
 			 * not in an active state this request is not going to

