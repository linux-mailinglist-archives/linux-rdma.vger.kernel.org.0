Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF76109FC5
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2019 15:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfKZODc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Nov 2019 09:03:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:13355 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbfKZODc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 Nov 2019 09:03:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 06:03:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="217168152"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2019 06:03:31 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id xAQE3U5V038526;
        Tue, 26 Nov 2019 07:03:30 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id xAQE3TXu057813;
        Tue, 26 Nov 2019 09:03:29 -0500
Subject: [PATCH for-next 03/11] IB/hfi1: Move chip specific functions to
 chip.c
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.alessandro@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Tue, 26 Nov 2019 09:03:29 -0500
Message-ID: <20191126140329.57492.20128.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20191126140020.57492.67772.stgit@awfm-01.aw.intel.com>
References: <20191126140020.57492.67772.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

Move routines and defines associated with hdrq size validation
to a chip specific routine since the limits are specific to
the device.

Fix incorrect value for min size 2 -> 32

CSR writes should also be in chip.c.

Create a chip routine to write the hdrq specific CSRs and call as
appropriate.

Reviewed-by: Dennis Dalessandro <dennis.alessandro@intel.com>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/chip.c |   78 +++++++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/chip.h |    6 +++
 drivers/infiniband/hw/hfi1/init.c |   72 +---------------------------------
 3 files changed, 87 insertions(+), 69 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index b4fe37a..860615d 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -11858,6 +11858,84 @@ static u32 encoded_size(u32 size)
 	return 0x1;	/* if invalid, go with the minimum size */
 }
 
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
+ * hfi1_validate_rcvhdrcnt - validate hdrcnt
+ * @dd: the device data
+ * @thecnt: the header count
+ */
+int hfi1_validate_rcvhdrcnt(struct hfi1_devdata *dd, uint thecnt)
+{
+	if (thecnt <= HFI1_MIN_HDRQ_EGRBUF_CNT) {
+		dd_dev_err(dd, "Receive header queue count too small\n");
+		return -EINVAL;
+	}
+
+	if (thecnt > HFI1_MAX_HDRQ_EGRBUF_CNT) {
+		dd_dev_err(dd,
+			   "Receive header queue count cannot be greater than %u\n",
+			   HFI1_MAX_HDRQ_EGRBUF_CNT);
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
+/**
+ * set_hdrq_regs - set header queue registers for context
+ * @dd: the device data
+ * @ctxt: the context
+ * @entsize: the dword entry size
+ * @hdrcnt: the number of header entries
+ */
+void set_hdrq_regs(struct hfi1_devdata *dd, u8 ctxt, u8 entsize, u16 hdrcnt)
+{
+	u64 reg;
+
+	reg = (((u64)hdrcnt >> HDRQ_SIZE_SHIFT) & RCV_HDR_CNT_CNT_MASK) <<
+	      RCV_HDR_CNT_CNT_SHIFT;
+	write_kctxt_csr(dd, ctxt, RCV_HDR_CNT, reg);
+	reg = ((u64)encode_rcv_header_entry_size(entsize) &
+	       RCV_HDR_ENT_SIZE_ENT_SIZE_MASK) <<
+	      RCV_HDR_ENT_SIZE_ENT_SIZE_SHIFT;
+	write_kctxt_csr(dd, ctxt, RCV_HDR_ENT_SIZE, reg);
+	reg = ((u64)DEFAULT_RCVHDRSIZE & RCV_HDR_SIZE_HDR_SIZE_MASK) <<
+	      RCV_HDR_SIZE_HDR_SIZE_SHIFT;
+	write_kctxt_csr(dd, ctxt, RCV_HDR_SIZE, reg);
+
+	/*
+	 * Program dummy tail address for every receive context
+	 * before enabling any receive context
+	 */
+	write_kctxt_csr(dd, ctxt, RCV_HDR_TAIL_ADDR,
+			dd->rcvhdrtail_dummy_dma);
+}
+
 void hfi1_rcvctrl(struct hfi1_devdata *dd, unsigned int op,
 		  struct hfi1_ctxtdata *rcd)
 {
diff --git a/drivers/infiniband/hw/hfi1/chip.h b/drivers/infiniband/hw/hfi1/chip.h
index 4ca5ac8..05b7130 100644
--- a/drivers/infiniband/hw/hfi1/chip.h
+++ b/drivers/infiniband/hw/hfi1/chip.h
@@ -358,6 +358,8 @@
 #define MAX_EAGER_BUFFER       (256 * 1024)
 #define MAX_EAGER_BUFFER_TOTAL (64 * (1 << 20)) /* max per ctxt 64MB */
 #define MAX_EXPECTED_BUFFER    (2048 * 1024)
+#define HFI1_MIN_HDRQ_EGRBUF_CNT 32
+#define HFI1_MAX_HDRQ_EGRBUF_CNT 16352
 
 /*
  * Receive expected base and count and eager base and count increment -
@@ -699,6 +701,10 @@ static inline u32 chip_rcv_array_count(struct hfi1_devdata *dd)
 	return read_csr(dd, RCV_ARRAY_CNT);
 }
 
+u8 encode_rcv_header_entry_size(u8 size);
+int hfi1_validate_rcvhdrcnt(struct hfi1_devdata *dd, uint thecnt);
+void set_hdrq_regs(struct hfi1_devdata *dd, u8 ctxt, u8 entsize, u16 hdrcnt);
+
 u64 create_pbc(struct hfi1_pportdata *ppd, u64 flags, int srate_mbs, u32 vl,
 	       u32 dw_len);
 
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index f547a17..821e6fe 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -78,8 +78,6 @@
  */
 #define HFI1_MIN_USER_CTXT_BUFCNT 7
 
-#define HFI1_MIN_HDRQ_EGRBUF_CNT 2
-#define HFI1_MAX_HDRQ_EGRBUF_CNT 16352
 #define HFI1_MIN_EAGER_BUFFER_SIZE (4 * 1024) /* 4KB */
 #define HFI1_MAX_EAGER_BUFFER_SIZE (256 * 1024) /* 256KB */
 
@@ -122,8 +120,6 @@
 module_param(user_credit_return_threshold, uint, S_IRUGO);
 MODULE_PARM_DESC(user_credit_return_threshold, "Credit return threshold for user send contexts, return when unreturned credits passes this many blocks (in percent of allocated blocks, 0 is off)");
 
-static inline u64 encode_rcv_header_entry_size(u16 size);
-
 DEFINE_XARRAY_FLAGS(hfi1_dev_table, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
 
 static int hfi1_create_kctxt(struct hfi1_devdata *dd,
@@ -511,23 +507,6 @@ void hfi1_free_ctxt(struct hfi1_ctxtdata *rcd)
 }
 
 /*
- * Convert a receive header entry size that to the encoding used in the CSR.
- *
- * Return a zero if the given size is invalid.
- */
-static inline u64 encode_rcv_header_entry_size(u16 size)
-{
-	/* there are only 3 valid receive header entry sizes */
-	if (size == 2)
-		return 1;
-	if (size == 16)
-		return 2;
-	else if (size == 32)
-		return 4;
-	return 0; /* invalid */
-}
-
-/*
  * Select the largest ccti value over all SLs to determine the intra-
  * packet gap for the link.
  *
@@ -1612,29 +1591,6 @@ static void postinit_cleanup(struct hfi1_devdata *dd)
 	hfi1_free_devdata(dd);
 }
 
-static int init_validate_rcvhdrcnt(struct hfi1_devdata *dd, uint thecnt)
-{
-	if (thecnt <= HFI1_MIN_HDRQ_EGRBUF_CNT) {
-		dd_dev_err(dd, "Receive header queue count too small\n");
-		return -EINVAL;
-	}
-
-	if (thecnt > HFI1_MAX_HDRQ_EGRBUF_CNT) {
-		dd_dev_err(dd,
-			   "Receive header queue count cannot be greater than %u\n",
-			   HFI1_MAX_HDRQ_EGRBUF_CNT);
-		return -EINVAL;
-	}
-
-	if (thecnt % HDRQ_INCREMENT) {
-		dd_dev_err(dd, "Receive header queue count %d must be divisible by %lu\n",
-			   thecnt, HDRQ_INCREMENT);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	int ret = 0, j, pidx, initfail;
@@ -1662,7 +1618,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	/* Validate some global module parameters */
-	ret = init_validate_rcvhdrcnt(dd, rcvhdrcnt);
+	ret = hfi1_validate_rcvhdrcnt(dd, rcvhdrcnt);
 	if (ret)
 		goto bail;
 
@@ -1843,7 +1799,6 @@ static void shutdown_one(struct pci_dev *pdev)
 int hfi1_create_rcvhdrq(struct hfi1_devdata *dd, struct hfi1_ctxtdata *rcd)
 {
 	unsigned amt;
-	u64 reg;
 
 	if (!rcd->rcvhdrq) {
 		gfp_t gfp_flags;
@@ -1875,30 +1830,9 @@ int hfi1_create_rcvhdrq(struct hfi1_devdata *dd, struct hfi1_ctxtdata *rcd)
 				goto bail_free;
 		}
 	}
-	/*
-	 * These values are per-context:
-	 *	RcvHdrCnt
-	 *	RcvHdrEntSize
-	 *	RcvHdrSize
-	 */
-	reg = ((u64)(rcd->rcvhdrq_cnt >> HDRQ_SIZE_SHIFT)
-			& RCV_HDR_CNT_CNT_MASK)
-		<< RCV_HDR_CNT_CNT_SHIFT;
-	write_kctxt_csr(dd, rcd->ctxt, RCV_HDR_CNT, reg);
-	reg = (encode_rcv_header_entry_size(rcd->rcvhdrqentsize)
-			& RCV_HDR_ENT_SIZE_ENT_SIZE_MASK)
-		<< RCV_HDR_ENT_SIZE_ENT_SIZE_SHIFT;
-	write_kctxt_csr(dd, rcd->ctxt, RCV_HDR_ENT_SIZE, reg);
-	reg = ((u64)DEFAULT_RCVHDRSIZE & RCV_HDR_SIZE_HDR_SIZE_MASK)
-		<< RCV_HDR_SIZE_HDR_SIZE_SHIFT;
-	write_kctxt_csr(dd, rcd->ctxt, RCV_HDR_SIZE, reg);
 
-	/*
-	 * Program dummy tail address for every receive context
-	 * before enabling any receive context
-	 */
-	write_kctxt_csr(dd, rcd->ctxt, RCV_HDR_TAIL_ADDR,
-			dd->rcvhdrtail_dummy_dma);
+	set_hdrq_regs(rcd->dd, rcd->ctxt, rcd->rcvhdrqentsize,
+		      rcd->rcvhdrq_cnt);
 
 	return 0;
 

