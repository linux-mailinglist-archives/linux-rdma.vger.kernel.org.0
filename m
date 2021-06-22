Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD563AFCED
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 08:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFVGQn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 02:16:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:25148 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhFVGQm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 02:16:42 -0400
IronPort-SDR: 1K3gL1TO7zDnPtEpcLNggr5f503xc8yhKaMvHMEdlIcxDrsGZK7Tdm0Q95CSXUwdIJDcQQ2BYj
 7SaKCeqAs+7Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="187373709"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="187373709"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 23:14:26 -0700
IronPort-SDR: c+Ww4MZiipEi0JDqxxgKOk/xYwedidZVHzAQB5QLE+sk8Nr8/tbdDAkMiS2QDtZnMFNjW3sgfB
 awj2dy9vx7/g==
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="641551763"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 23:14:26 -0700
From:   ira.weiny@intel.com
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kheib@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] RDMA/siw: Convert siw_tx_hdt() to kmap_local_page()
Date:   Mon, 21 Jun 2021 23:14:22 -0700
Message-Id: <20210622061422.2633501-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210622061422.2633501-1-ira.weiny@intel.com>
References: <20210622061422.2633501-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

kmap() is being deprecated and will break uses of device dax after PKS
protection is introduced.[1]

The use of kmap() in siw_tx_hdt() is all thread local therefore
kmap_local_page() is a sufficient replacement and will work with pgmap
protected pages when those are implemented.

kmap_local_page() mappings are tracked in a stack and must be unmapped
in the opposite order they were mapped in.

siw_tx_hdt() tracks pages used in a page_array.  It uses that array to
unmap pages which were mapped on function exit.  Not all entries in the
array are mapped and this is tracked in kmap_mask.

kunmap_local() takes a mapped address rather than a page.  Declare a
mapped address array, page_array_addr, of the same size as the page
array to be used for unmapping.

Use kmap_local_page() instead of kmap() to map pages in the page_array.

Because segments are mapped into the page array in increasing index
order, modify siw_unmap_pages() to unmap pages in decreasing order.

The kmap_mask is no longer needed as the lack of an address in the
address array can indicate no unmap is required.

[1] https://lore.kernel.org/lkml/20201009195033.3208459-59-ira.weiny@intel.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 35 +++++++++++++++------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index db68a10d12cd..e70aba23f6e7 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -396,13 +396,17 @@ static int siw_0copy_tx(struct socket *s, struct page **page,
 
 #define MAX_TRAILER (MPA_CRC_SIZE + 4)
 
-static void siw_unmap_pages(struct page **pp, unsigned long kmap_mask)
+static void siw_unmap_pages(void **addrs, int len)
 {
-	while (kmap_mask) {
-		if (kmap_mask & BIT(0))
-			kunmap(*pp);
-		pp++;
-		kmap_mask >>= 1;
+	int i;
+
+	/*
+	 * Work backwards through the array to honor the kmap_local_page()
+	 * ordering requirements.
+	 */
+	for (i = (len-1); i >= 0; i--) {
+		if (addrs[i])
+			kunmap_local(addrs[i]);
 	}
 }
 
@@ -427,13 +431,15 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 	struct siw_sge *sge = &wqe->sqe.sge[c_tx->sge_idx];
 	struct kvec iov[MAX_ARRAY];
 	struct page *page_array[MAX_ARRAY];
+	void *page_array_addr[MAX_ARRAY];
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_EOR };
 
 	int seg = 0, do_crc = c_tx->do_crc, is_kva = 0, rv;
 	unsigned int data_len = c_tx->bytes_unsent, hdr_len = 0, trl_len = 0,
 		     sge_off = c_tx->sge_off, sge_idx = c_tx->sge_idx,
 		     pbl_idx = c_tx->pbl_idx;
-	unsigned long kmap_mask = 0L;
+
+	memset(page_array_addr, 0, sizeof(page_array_addr));
 
 	if (c_tx->state == SIW_SEND_HDR) {
 		if (c_tx->use_sendpage) {
@@ -498,7 +504,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 					p = siw_get_upage(mem->umem,
 							  sge->laddr + sge_off);
 				if (unlikely(!p)) {
-					siw_unmap_pages(page_array, kmap_mask);
+					siw_unmap_pages(page_array_addr, MAX_ARRAY);
 					wqe->processed -= c_tx->bytes_unsent;
 					rv = -EFAULT;
 					goto done_crc;
@@ -506,11 +512,10 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 				page_array[seg] = p;
 
 				if (!c_tx->use_sendpage) {
-					iov[seg].iov_base = kmap(p) + fp_off;
-					iov[seg].iov_len = plen;
+					page_array_addr[seg] = kmap_local_page(page_array[seg]);
 
-					/* Remember for later kunmap() */
-					kmap_mask |= BIT(seg);
+					iov[seg].iov_base = page_array_addr[seg] + fp_off;
+					iov[seg].iov_len = plen;
 
 					if (do_crc)
 						crypto_shash_update(
@@ -518,7 +523,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 							iov[seg].iov_base,
 							plen);
 				} else if (do_crc) {
-					kaddr = kmap_local_page(p);
+					kaddr = kmap_local_page(page_array[seg]);
 					crypto_shash_update(c_tx->mpa_crc_hd,
 							    kaddr + fp_off,
 							    plen);
@@ -542,7 +547,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 
 			if (++seg > (int)MAX_ARRAY) {
 				siw_dbg_qp(tx_qp(c_tx), "to many fragments\n");
-				siw_unmap_pages(page_array, kmap_mask);
+				siw_unmap_pages(page_array_addr, MAX_ARRAY);
 				wqe->processed -= c_tx->bytes_unsent;
 				rv = -EMSGSIZE;
 				goto done_crc;
@@ -593,7 +598,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 	} else {
 		rv = kernel_sendmsg(s, &msg, iov, seg + 1,
 				    hdr_len + data_len + trl_len);
-		siw_unmap_pages(page_array, kmap_mask);
+		siw_unmap_pages(page_array_addr, MAX_ARRAY);
 	}
 	if (rv < (int)hdr_len) {
 		/* Not even complete hdr pushed or negative rv */
-- 
2.28.0.rc0.12.gb6a658bd00c9

