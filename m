Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA093B1DAE
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 17:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhFWPhl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 11:37:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:41948 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhFWPhl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Jun 2021 11:37:41 -0400
IronPort-SDR: 5R0YjPbfnam1ka79dpZLE3E2iC6/1CgsfiNb6svrlCm+U6M4CgijBDUrj7fcpre0f0Ai4OeVZ9
 iwI7guBcVVzQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="268427698"
X-IronPort-AV: E=Sophos;i="5.83,294,1616482800"; 
   d="scan'208";a="268427698"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 08:34:38 -0700
IronPort-SDR: Ic+vQ/72rh0752HjI3D182s5di1XZZ7LJCwJJMEdDhjv+PSx0YXGbpbY2D68Ezz1sQqUgrxic1
 vrslBJTFw63Q==
X-IronPort-AV: E=Sophos;i="5.83,294,1616482800"; 
   d="scan'208";a="487358319"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 08:34:37 -0700
Date:   Wed, 23 Jun 2021 08:34:37 -0700
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
Subject: Re: [PATCH V2] RDMA/siw: Convert siw_tx_hdt() to kmap_local_page()
Message-ID: <20210623153437.GR1905674@iweiny-DESK2.sc.intel.com>
References: <20210622203432.2715659-1-ira.weiny@intel.com>
 <20210622061422.2633501-5-ira.weiny@intel.com>
 <OF951DAF0B.941A938D-ON002586FD.003F1610-002586FD.00504522@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF951DAF0B.941A938D-ON002586FD.003F1610-002586FD.00504522@notes.na.collabserv.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 23, 2021 at 02:36:45PM +0000, Bernard Metzler wrote:
> -----ira.weiny@intel.com wrote: -----
> 
> >@@ -506,11 +513,12 @@ static int siw_tx_hdt(struct siw_iwarp_tx
> >*c_tx, struct socket *s)
> > 				page_array[seg] = p;
> > 
> > 				if (!c_tx->use_sendpage) {
> >-					iov[seg].iov_base = kmap(p) + fp_off;
> >-					iov[seg].iov_len = plen;
> >+					void *kaddr = kmap_local_page(page_array[seg]);
> 
> we can use 'kmap_local_page(p)' here

Yes but I actually did this on purpose as it makes the code read clearly that
the mapping is 'seg' element of the array.  Do you prefer 'p' because this is a
performant path?

> > 
> > 					/* Remember for later kunmap() */
> > 					kmap_mask |= BIT(seg);
> >+					iov[seg].iov_base = kaddr + fp_off;
> >+					iov[seg].iov_len = plen;
> > 
> > 					if (do_crc)
> > 						crypto_shash_update(
> >@@ -518,7 +526,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
> >struct socket *s)
> > 							iov[seg].iov_base,
> > 							plen);
> 
> This patch does not apply for me. Would I have to install first
> your [Patch 3/4] -- since the current patch references kmap_local_page()
> already? Maybe it is better to apply if it would be just one siw
> related patch in that series?

Yes the other patch goes first.  I split it out to make this more difficult
change more reviewable.  I could squash them as it is probably straight forward
enough but I've been careful with this in other subsystems.

Jason, do you have any issue with squashing the 2 patches?

> 
> 
> 
> > 				} else if (do_crc) {
> >-					kaddr = kmap_local_page(p);
> >+					kaddr = kmap_local_page(page_array[seg]);
> 
> using 'kmap_local_page(p)' as you had it is straightforward
> and I would prefer it.

OK.  I think this reads cleaner but I can see 'p' being more performant.

> 
> > 					crypto_shash_update(c_tx->mpa_crc_hd,
> > 							    kaddr + fp_off,
> > 							    plen);
> >@@ -542,7 +550,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
> >struct socket *s)
> > 
> > 			if (++seg > (int)MAX_ARRAY) {
> > 				siw_dbg_qp(tx_qp(c_tx), "to many fragments\n");
> >-				siw_unmap_pages(page_array, kmap_mask);
> >+				siw_unmap_pages(iov, kmap_mask, MAX_ARRAY);
> 
> to minimize the iterations over the byte array in 'siw_unmap_pages()',
> we may pass seg-1 instead of MAX_ARRAY

Sounds good.

> 
> 
> > 				wqe->processed -= c_tx->bytes_unsent;
> > 				rv = -EMSGSIZE;
> > 				goto done_crc;
> >@@ -593,7 +601,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
> >struct socket *s)
> > 	} else {
> > 		rv = kernel_sendmsg(s, &msg, iov, seg + 1,
> > 				    hdr_len + data_len + trl_len);
> >-		siw_unmap_pages(page_array, kmap_mask);
> >+		siw_unmap_pages(iov, kmap_mask, MAX_ARRAY);
> 
> to minimize the iterations over the byte array in 'siw_unmap_pages()',
> we may pass seg instead of MAX_ARRAY

Will do.

Thanks for the review!  :-D
Ira
