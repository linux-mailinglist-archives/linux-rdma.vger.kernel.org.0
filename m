Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3463B34FC
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 19:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhFXRui (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 13:50:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:5533 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231878AbhFXRui (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 13:50:38 -0400
IronPort-SDR: pXPvStwiVrOuzd4iLw66/Av1vU6QQnUbTrfmL6whpSMvHKEzx9y4wRy+5J1eKQgvtyN6rsHfvf
 /K6lqPi5Ygmw==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="204519125"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="204519125"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 10:48:17 -0700
IronPort-SDR: 5uD0mUMXjivznVlfZbkscdPadzCBOaOAdkikCgAxQYCyj4wn0UMtX6l00gCoaKcABxHRAA7dtj
 z3BtgWzNkktQ==
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="453513319"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 10:48:16 -0700
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
Subject: [PATCH V4] RDMA/siw: Convert siw_tx_hdt() to kmap_local_page()
Date:   Thu, 24 Jun 2021 10:48:14 -0700
Message-Id: <20210624174814.2822896-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210623221543.2799198-1-ira.weiny@intel.com>
References: <20210623221543.2799198-1-ira.weiny@intel.com>
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

siw_tx_hdt() tracks pages used in a page_array.  It uses that array to
unmap pages which were mapped on function exit.  Not all entries in the
array are mapped and this is tracked in kmap_mask.

kunmap_local() takes a mapped address rather than a page.  Alter
siw_unmap_pages() to take the iov array to reuse the iov_base address of
each mapping.  Use PAGE_MASK to get the proper address for
kunmap_local().

kmap_local_page() mappings are tracked in a stack and must be unmapped
in the opposite order they were mapped in.  Because segments are mapped
into the page array in increasing index order, modify siw_unmap_pages()
to unmap pages in decreasing order.

Use kmap_local_page() instead of kmap() to map pages in the page_array.

[1] https://lore.kernel.org/lkml/20201009195033.3208459-59-ira.weiny@intel.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V4:
	From Bernard
		Further optimize siw_unmap_pages() by eliminating the
		CRC page from the iov array.

Changes for V3:
	From Bernard
		Use 'p' in kmap_local_page()
		Use seg as length to siw_unmap_pages()

Changes for V2:
	From Bernard
		Reuse iov[].iov_base rather than declaring another array
		of pointers and preserve the use of kmap_mask to know
		which iov's were kmapped.
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 30 +++++++++++++++++----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index db68a10d12cd..1f4e60257700 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -396,13 +396,20 @@ static int siw_0copy_tx(struct socket *s, struct page **page,
 
 #define MAX_TRAILER (MPA_CRC_SIZE + 4)
 
-static void siw_unmap_pages(struct page **pp, unsigned long kmap_mask)
+static void siw_unmap_pages(struct kvec *iov, unsigned long kmap_mask, int len)
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
+		if (kmap_mask & BIT(i)) {
+			unsigned long addr = (unsigned long)iov[i].iov_base;
+
+			kunmap_local((void *)(addr & PAGE_MASK));
+		}
 	}
 }
 
@@ -498,7 +505,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 					p = siw_get_upage(mem->umem,
 							  sge->laddr + sge_off);
 				if (unlikely(!p)) {
-					siw_unmap_pages(page_array, kmap_mask);
+					siw_unmap_pages(iov, kmap_mask, seg);
 					wqe->processed -= c_tx->bytes_unsent;
 					rv = -EFAULT;
 					goto done_crc;
@@ -506,11 +513,12 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 				page_array[seg] = p;
 
 				if (!c_tx->use_sendpage) {
-					iov[seg].iov_base = kmap(p) + fp_off;
-					iov[seg].iov_len = plen;
+					void *kaddr = kmap_local_page(p);
 
 					/* Remember for later kunmap() */
 					kmap_mask |= BIT(seg);
+					iov[seg].iov_base = kaddr + fp_off;
+					iov[seg].iov_len = plen;
 
 					if (do_crc)
 						crypto_shash_update(
@@ -542,7 +550,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 
 			if (++seg > (int)MAX_ARRAY) {
 				siw_dbg_qp(tx_qp(c_tx), "to many fragments\n");
-				siw_unmap_pages(page_array, kmap_mask);
+				siw_unmap_pages(iov, kmap_mask, seg-1);
 				wqe->processed -= c_tx->bytes_unsent;
 				rv = -EMSGSIZE;
 				goto done_crc;
@@ -593,7 +601,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 	} else {
 		rv = kernel_sendmsg(s, &msg, iov, seg + 1,
 				    hdr_len + data_len + trl_len);
-		siw_unmap_pages(page_array, kmap_mask);
+		siw_unmap_pages(iov, kmap_mask, seg);
 	}
 	if (rv < (int)hdr_len) {
 		/* Not even complete hdr pushed or negative rv */
-- 
2.28.0.rc0.12.gb6a658bd00c9

