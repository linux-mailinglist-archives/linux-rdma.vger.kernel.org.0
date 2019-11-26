Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22050109FF8
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2019 15:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfKZOMY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Nov 2019 09:12:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:61779 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfKZOMY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 Nov 2019 09:12:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 06:12:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="211424223"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga006.jf.intel.com with ESMTP; 26 Nov 2019 06:12:22 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id xAQECLWS042029;
        Tue, 26 Nov 2019 07:12:22 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id xAQECK6h059044;
        Tue, 26 Nov 2019 09:12:20 -0500
Subject: [PATCH for-next v2 02/11] IB/hfi1: List all receive contexts from
 debugfs
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Tue, 26 Nov 2019 09:12:20 -0500
Message-ID: <20191126141220.58836.41480.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20191126141055.58836.79452.stgit@awfm-01.aw.intel.com>
References: <20191126141055.58836.79452.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

The current debugfs output for receive contexts (rcds), stops after
the kernel receive contexts have been displayed.  This is not enough
information.

Display all of the receive contexts.

Augment the output with some more context information.

Limit the ring buffer header output to 5 entries to avoid
overextending they sequential file output.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/debugfs.c |    2 +-
 drivers/infiniband/hw/hfi1/driver.c  |   12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/debugfs.c b/drivers/infiniband/hw/hfi1/debugfs.c
index d268bf9..4633a0c 100644
--- a/drivers/infiniband/hw/hfi1/debugfs.c
+++ b/drivers/infiniband/hw/hfi1/debugfs.c
@@ -379,7 +379,7 @@ static void *_rcds_seq_next(struct seq_file *s, void *v, loff_t *pos)
 	struct hfi1_devdata *dd = dd_from_dev(ibd);
 
 	++*pos;
-	if (!dd->rcd || *pos >= dd->n_krcv_queues)
+	if (!dd->rcd || *pos >= dd->num_rcv_contexts)
 		return NULL;
 	return pos;
 }
diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index cbc5219..8374922 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -1726,23 +1726,29 @@ static int process_receive_invalid(struct hfi1_packet *packet)
 	return RHF_RCV_CONTINUE;
 }
 
+#define HFI1_RCVHDR_DUMP_MAX	5
+
 void seqfile_dump_rcd(struct seq_file *s, struct hfi1_ctxtdata *rcd)
 {
 	struct hfi1_packet packet;
 	struct ps_mdata mdata;
+	int i;
 
-	seq_printf(s, "Rcd %u: RcvHdr cnt %u entsize %u %s head %llu tail %llu\n",
+	seq_printf(s, "Rcd %u: RcvHdr cnt %u entsize %u %s ctrl 0x%08llx status 0x%08llx, head %llu tail %llu  sw head %u\n",
 		   rcd->ctxt, get_hdrq_cnt(rcd), get_hdrqentsize(rcd),
 		   get_dma_rtail_setting(rcd) ?
 		   "dma_rtail" : "nodma_rtail",
+		   read_kctxt_csr(rcd->dd, rcd->ctxt, RCV_CTXT_CTRL),
+		   read_kctxt_csr(rcd->dd, rcd->ctxt, RCV_CTXT_STATUS),
 		   read_uctxt_csr(rcd->dd, rcd->ctxt, RCV_HDR_HEAD) &
 		   RCV_HDR_HEAD_HEAD_MASK,
-		   read_uctxt_csr(rcd->dd, rcd->ctxt, RCV_HDR_TAIL));
+		   read_uctxt_csr(rcd->dd, rcd->ctxt, RCV_HDR_TAIL),
+		   rcd->head);
 
 	init_packet(rcd, &packet);
 	init_ps_mdata(&mdata, &packet);
 
-	while (1) {
+	for (i = 0; i < HFI1_RCVHDR_DUMP_MAX; i++) {
 		__le32 *rhf_addr = (__le32 *)rcd->rcvhdrq + mdata.ps_head +
 					 rcd->rhf_offset;
 		struct ib_header *hdr;

