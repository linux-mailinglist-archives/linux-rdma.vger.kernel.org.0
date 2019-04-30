Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44CB010076
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 21:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfD3TyZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 30 Apr 2019 15:54:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:36588 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfD3TyY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Apr 2019 15:54:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 12:54:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="147186868"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga007.fm.intel.com with ESMTP; 30 Apr 2019 12:54:24 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 30 Apr 2019 12:54:24 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.175]) by
 FMSMSX126.amr.corp.intel.com ([169.254.1.19]) with mapi id 14.03.0415.000;
 Tue, 30 Apr 2019 12:54:24 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Gal Pressman <galpress@amazon.com>
Subject: RE: [PATCH v2 rdma-next 1/5] RDMA/umem: Add API to find best driver
 supported page size in an MR
Thread-Topic: [PATCH v2 rdma-next 1/5] RDMA/umem: Add API to find best
 driver supported page size in an MR
Thread-Index: AQHU9rYQO5bZsKMgfk2PmawyTIYosKZNbYeAgAaoBrCAAXDXgP//m1jg
Date:   Tue, 30 Apr 2019 19:54:24 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A5ACCB03@fmsmsx124.amr.corp.intel.com>
References: <20190419134353.12684-1-shiraz.saleem@intel.com>
 <20190419134353.12684-2-shiraz.saleem@intel.com>
 <20190425142559.GA5388@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5AC3A8C@fmsmsx124.amr.corp.intel.com>
 <20190430180503.GB8101@ziepe.ca>
In-Reply-To: <20190430180503.GB8101@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.1.200.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>Subject: Re: [PATCH v2 rdma-next 1/5] RDMA/umem: Add API to find best driver
>supported page size in an MR
>
>On Tue, Apr 30, 2019 at 01:36:14PM +0000, Saleem, Shiraz wrote:
>
>> >If we make a MR with VA 0x6400FFF and length 2M-4095 I expect the 2M
>> >page size with the NIC.
>> >
>> >We will have dma_addr_start = 0x2600000 and sg_dma_len = 0x200000 as
>> >the SGL is always rounded to pages
>>
>> why isn't it the sg_dma_len 2M-4095? Is it because we compute npages
>> in ib_umem_get() to build the SGL? Could using (addr & PAGE_MASK) and
>> then adding dma_len help take care of this?
>
>We always round to page sizes when building the SGL, so the start is rounded
>down and the end remains the same.
>
>> >I have a feeling the uvirt_addr should be computed more like
>> >
>> >  if (flags & IB_UMEM_VA_BASED_OFFSET)
>> >        mask |= uvirt_addr ^ umem->addr;
>>
>> I am not following.
>>
>> For a case like below where uvirt_addr = umem_addr, mask = 0 and we
>> run rdma_find_pgbit on it we ll pick 4K instead of 2M which is wrong.
>
>> uvirt_addr [0x7f2b98200000]
>> best_pgsz [0x201000]
>> umem->address [0x7f2b98200000]
>> dma_addr_start [0x130e200000]
>> dma_addr_end [0x130e400000]
>> sg_dma_len [2097152]
>
>??
>
>0x7f2b98200000 ^ 0x7f2b98200000 = 0
>
>So mask isn't altered by the requested VA and you get 2M pages.
I am still missing the point. mask was initialized to 0 and if we just do
"mask |= uvirt_addr ^ umem->addr" for the first SGE, then you ll
always get 0 for mask (and one page size) when uvirt_addr = umem->addr
irrespective of their values.

Maybe 'mask' is a wrong variable name to use but the intention of the algo is to
OR together the dma_addr_start for every sg but the first, and the dma_addr_end
of every sg but the last. mask is initialized to 0 and tracks the computed value after
running through all SG's. Basically mask will track the lowest set bit from the entire set
and running rdma_find_pg_bit gets the best page size to use.


