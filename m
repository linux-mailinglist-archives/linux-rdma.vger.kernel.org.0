Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5363B34D6
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 19:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhFXRfh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 13:35:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:50610 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232300AbhFXRfg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 13:35:36 -0400
IronPort-SDR: fRtc21APspthfnf+ujFHn+Z7r8s/hPFczoRqrRYMbVKCqitlo5zmbwXv3weoMNyXC6BE/eK0Ri
 FyBJWdBdhulw==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="205697915"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="205697915"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 10:33:17 -0700
IronPort-SDR: T6QP3XGN0GQuKz7CwDHdgLZdYc95SClxGqWxQZA7qhlHbbtFltF92CQTLciwnWNeGWyRBYphVO
 gmQpbDbrMwuA==
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="455151445"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 10:33:17 -0700
Date:   Thu, 24 Jun 2021 10:33:16 -0700
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
Subject: Re: [PATCH V3] RDMA/siw: Convert siw_tx_hdt() to kmap_local_page()
Message-ID: <20210624173316.GA2799309@iweiny-DESK2.sc.intel.com>
References: <20210623221543.2799198-1-ira.weiny@intel.com>
 <20210622203432.2715659-1-ira.weiny@intel.com>
 <OF739F2480.B35209F8-ON002586FE.00569A1A-002586FE.00569A24@ch.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF739F2480.B35209F8-ON002586FE.00569A1A-002586FE.00569A24@ch.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 24, 2021 at 03:45:55PM +0000, Bernard Metzler wrote:
> 
> >@@ -593,7 +601,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
> >struct socket *s)
> > 	} else {
> > 		rv = kernel_sendmsg(s, &msg, iov, seg + 1,
> > 				    hdr_len + data_len + trl_len);
> >-		siw_unmap_pages(page_array, kmap_mask);
> >+		siw_unmap_pages(iov, kmap_mask, seg+1);
> 
> seg+1 is one to many, since the last segment references the iWarp
> trailer (CRC). There are 2 reason for this multi-segment processing
> in the transmit path. (1) efficiency and (2) MTU based packet framing.
> The iov contains the complete iWarp frame with header, (potentially
> multiple) data fragments, and the CRC. It gets pushed to TCP in one
> go, praying for iWarp framing stays intact (which most time works).
> So the code can collect data form multiple SGE's of a WRITE or
> SEND and tries putting those into one frame, if MTU allows, and
> adds header and trailer. 
>
> The last segment (seg + 1) references the CRC, which is never kmap'ed.

siw_unmap_pages() take a length and seg is the index...

But ok so a further optimization...

Fair enough.

> 
> I'll try the code next days, but it looks good otherwise!
 
I believe this will work though.

Ira

> Thanks very much!
> > 	}
> > 	if (rv < (int)hdr_len) {
> > 		/* Not even complete hdr pushed or negative rv */
> >-- 
> >2.28.0.rc0.12.gb6a658bd00c9
> >
> >
