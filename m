Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24B03B0EEF
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 22:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFVUmN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 16:42:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:38061 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhFVUmN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 16:42:13 -0400
IronPort-SDR: EOp02E+TEUuQg+dxE6t8AsEUzHj/iGAFgUaQy+yZchfHq+75abJpPgJKv/zd3Y5YKSHJU7Eka+
 rPypCV1+nNAg==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="186828461"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="186828461"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 13:39:56 -0700
IronPort-SDR: kuDSAiKrot5bo6d+zqvd7xPwRbBxg4+04ZW6TQ6ikhrRJlavR5uqbWbehPqKA7jgQGyZhLGDCF
 L4IGtYo+ji9w==
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="556744132"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 13:39:54 -0700
Date:   Tue, 22 Jun 2021 13:39:54 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Kamal Heib <kheib@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] RDMA/siw: Convert siw_tx_hdt() to kmap_local_page()
Message-ID: <20210622203954.GM1905674@iweiny-DESK2.sc.intel.com>
References: <20210622061422.2633501-5-ira.weiny@intel.com>
 <20210622061422.2633501-1-ira.weiny@intel.com>
 <OF400EF61E.38060C6A-ON002586FC.005B421A-002586FC.005BCFB3@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF400EF61E.38060C6A-ON002586FC.005B421A-002586FC.005BCFB3@notes.na.collabserv.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 22, 2021 at 04:42:49PM +0000, Bernard Metzler wrote:
> -----ira.weiny@intel.com wrote: -----
> 
> >To: "Jason Gunthorpe" <jgg@ziepe.ca>
> >From: ira.weiny@intel.com
> >Date: 06/22/2021 08:14AM
> >Cc: "Ira Weiny" <ira.weiny@intel.com>, "Mike Marciniszyn"
> ><mike.marciniszyn@cornelisnetworks.com>, "Dennis Dalessandro"
> ><dennis.dalessandro@cornelisnetworks.com>, "Doug Ledford"
> ><dledford@redhat.com>, "Faisal Latif" <faisal.latif@intel.com>,
> >"Shiraz Saleem" <shiraz.saleem@intel.com>, "Bernard Metzler"
> ><bmt@zurich.ibm.com>, "Kamal Heib" <kheib@redhat.com>,
> >linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
> >Subject: [EXTERNAL] [PATCH 4/4] RDMA/siw: Convert siw_tx_hdt() to
> >kmap_local_page()
> >
> >From: Ira Weiny <ira.weiny@intel.com>
> >
> >kmap() is being deprecated and will break uses of device dax after
> >PKS
> >protection is introduced.[1]
> >
> >The use of kmap() in siw_tx_hdt() is all thread local therefore
> >kmap_local_page() is a sufficient replacement and will work with
> >pgmap
> >protected pages when those are implemented.
> >
> >kmap_local_page() mappings are tracked in a stack and must be
> >unmapped
> >in the opposite order they were mapped in.
> >
> >siw_tx_hdt() tracks pages used in a page_array.  It uses that array
> >to
> >unmap pages which were mapped on function exit.  Not all entries in
> >the
> >array are mapped and this is tracked in kmap_mask.
> >
> >kunmap_local() takes a mapped address rather than a page.  Declare a
> >mapped address array, page_array_addr, of the same size as the page
> >array to be used for unmapping.
> >
> 
> Hi Ira, thanks for taking care of that!
> 
> I think we can avoid introducing another 'page_array_addr[]' array
> here, which must be zeroed first and completely searched for
> valid mappings during unmap, and also further bloats the
> stack size of siw_tx_hdt(). I think we can go away with the
> already available iov[].iov_base addresses array, masking addresses
> with PAGE_MASK during unmapping to mask any first byte offset.
> All kmap_local_page() mapping end up at that list. For unmapping
> we can still rely on the kmap_mask bit field, which is more
> efficient to initialize and search for valid mappings. Ordering
> during unmapping can be guaranteed if we parse the bitmask
> in reverse order. Let me know if you prefer me to propose
> a change -- that siw_tx_hdt() thing became rather complex I
> have to admit!

Seems not too bad, V2 sent.

I was concerned with the additional stack size but only 28 pointers (If I did
my math right) did not seem too bad.  It is redundant though so lets see if
I've gotten V2 right.

Thanks!
Ira

> 
> Best,
> Bernard.
> 
> >Use kmap_local_page() instead of kmap() to map pages in the
> >page_array.
> >
> >Because segments are mapped into the page array in increasing index
> >order, modify siw_unmap_pages() to unmap pages in decreasing order.
> >
> >The kmap_mask is no longer needed as the lack of an address in the
> >address array can indicate no unmap is required.
> >
> >[1]
> >INVALID URI REMOVED
> >lkml_20201009195033.3208459-2D59-2Dira.weiny-40intel.com_&d=DwIDAg&c=
> >jf_iaSHvJObTbx-siA1ZOg&r=2TaYXQ0T-r8ZO1PP1alNwU_QJcRRLfmYTAgd3QCvqSc&
> >m=wnRcc-qyXV_X7kyQfFYL6XPgmmakQxmo44BmjIon-w0&s=Y0aiKJ4EHZY8FJlI-uiPr
> >xcBE95kmgn3iEz3p8d5VF4&e= 
> >
> >Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >---
> > drivers/infiniband/sw/siw/siw_qp_tx.c | 35
> >+++++++++++++++------------
> > 1 file changed, 20 insertions(+), 15 deletions(-)
> >
> >diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c
> >b/drivers/infiniband/sw/siw/siw_qp_tx.c
> >index db68a10d12cd..e70aba23f6e7 100644
> >--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
> >+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
> >@@ -396,13 +396,17 @@ static int siw_0copy_tx(struct socket *s,
> >struct page **page,
> > 
> > #define MAX_TRAILER (MPA_CRC_SIZE + 4)
> > 
> >-static void siw_unmap_pages(struct page **pp, unsigned long
> >kmap_mask)
> >+static void siw_unmap_pages(void **addrs, int len)
> > {
> >-	while (kmap_mask) {
> >-		if (kmap_mask & BIT(0))
> >-			kunmap(*pp);
> >-		pp++;
> >-		kmap_mask >>= 1;
> >+	int i;
> >+
> >+	/*
> >+	 * Work backwards through the array to honor the kmap_local_page()
> >+	 * ordering requirements.
> >+	 */
> >+	for (i = (len-1); i >= 0; i--) {
> >+		if (addrs[i])
> >+			kunmap_local(addrs[i]);
> > 	}
> > }
> > 
> >@@ -427,13 +431,15 @@ static int siw_tx_hdt(struct siw_iwarp_tx
> >*c_tx, struct socket *s)
> > 	struct siw_sge *sge = &wqe->sqe.sge[c_tx->sge_idx];
> > 	struct kvec iov[MAX_ARRAY];
> > 	struct page *page_array[MAX_ARRAY];
> >+	void *page_array_addr[MAX_ARRAY];
> > 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_EOR };
> > 
> > 	int seg = 0, do_crc = c_tx->do_crc, is_kva = 0, rv;
> > 	unsigned int data_len = c_tx->bytes_unsent, hdr_len = 0, trl_len =
> >0,
> > 		     sge_off = c_tx->sge_off, sge_idx = c_tx->sge_idx,
> > 		     pbl_idx = c_tx->pbl_idx;
> >-	unsigned long kmap_mask = 0L;
> >+
> >+	memset(page_array_addr, 0, sizeof(page_array_addr));
> > 
> > 	if (c_tx->state == SIW_SEND_HDR) {
> > 		if (c_tx->use_sendpage) {
> >@@ -498,7 +504,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
> >struct socket *s)
> > 					p = siw_get_upage(mem->umem,
> > 							  sge->laddr + sge_off);
> > 				if (unlikely(!p)) {
> >-					siw_unmap_pages(page_array, kmap_mask);
> >+					siw_unmap_pages(page_array_addr, MAX_ARRAY);
> > 					wqe->processed -= c_tx->bytes_unsent;
> > 					rv = -EFAULT;
> > 					goto done_crc;
> >@@ -506,11 +512,10 @@ static int siw_tx_hdt(struct siw_iwarp_tx
> >*c_tx, struct socket *s)
> > 				page_array[seg] = p;
> > 
> > 				if (!c_tx->use_sendpage) {
> >-					iov[seg].iov_base = kmap(p) + fp_off;
> >-					iov[seg].iov_len = plen;
> >+					page_array_addr[seg] = kmap_local_page(page_array[seg]);
> > 
> >-					/* Remember for later kunmap() */
> >-					kmap_mask |= BIT(seg);
> >+					iov[seg].iov_base = page_array_addr[seg] + fp_off;
> >+					iov[seg].iov_len = plen;
> > 
> > 					if (do_crc)
> > 						crypto_shash_update(
> >@@ -518,7 +523,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
> >struct socket *s)
> > 							iov[seg].iov_base,
> > 							plen);
> > 				} else if (do_crc) {
> >-					kaddr = kmap_local_page(p);
> >+					kaddr = kmap_local_page(page_array[seg]);
> > 					crypto_shash_update(c_tx->mpa_crc_hd,
> > 							    kaddr + fp_off,
> > 							    plen);
> >@@ -542,7 +547,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
> >struct socket *s)
> > 
> > 			if (++seg > (int)MAX_ARRAY) {
> > 				siw_dbg_qp(tx_qp(c_tx), "to many fragments\n");
> >-				siw_unmap_pages(page_array, kmap_mask);
> >+				siw_unmap_pages(page_array_addr, MAX_ARRAY);
> > 				wqe->processed -= c_tx->bytes_unsent;
> > 				rv = -EMSGSIZE;
> > 				goto done_crc;
> >@@ -593,7 +598,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
> >struct socket *s)
> > 	} else {
> > 		rv = kernel_sendmsg(s, &msg, iov, seg + 1,
> > 				    hdr_len + data_len + trl_len);
> >-		siw_unmap_pages(page_array, kmap_mask);
> >+		siw_unmap_pages(page_array_addr, MAX_ARRAY);
> > 	}
> > 	if (rv < (int)hdr_len) {
> > 		/* Not even complete hdr pushed or negative rv */
> >-- 
> >2.28.0.rc0.12.gb6a658bd00c9
> >
> >
> 
