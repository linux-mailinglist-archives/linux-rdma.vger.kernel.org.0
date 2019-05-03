Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F47B13117
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2019 17:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfECPYC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 3 May 2019 11:24:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:45797 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfECPYB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 May 2019 11:24:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 08:23:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,426,1549958400"; 
   d="scan'208";a="321166102"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga005.jf.intel.com with ESMTP; 03 May 2019 08:23:00 -0700
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 3 May 2019 08:23:00 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.175]) by
 fmsmsx122.amr.corp.intel.com ([169.254.5.42]) with mapi id 14.03.0415.000;
 Fri, 3 May 2019 08:22:59 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Gal Pressman <galpress@amazon.com>
Subject: RE: [PATCH v2 rdma-next 1/5] RDMA/umem: Add API to find best driver
 supported page size in an MR
Thread-Topic: [PATCH v2 rdma-next 1/5] RDMA/umem: Add API to find best
 driver supported page size in an MR
Thread-Index: AQHU9rYQO5bZsKMgfk2PmawyTIYosKZNbYeAgAaoBrCAAXDXgP//m1jggACVloCAAslQsA==
Date:   Fri, 3 May 2019 15:22:59 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A5AD1514@fmsmsx124.amr.corp.intel.com>
References: <20190419134353.12684-1-shiraz.saleem@intel.com>
 <20190419134353.12684-2-shiraz.saleem@intel.com>
 <20190425142559.GA5388@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5AC3A8C@fmsmsx124.amr.corp.intel.com>
 <20190430180503.GB8101@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5ACCB03@fmsmsx124.amr.corp.intel.com>
 <20190430210011.GA9059@ziepe.ca>
In-Reply-To: <20190430210011.GA9059@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
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
>On Tue, Apr 30, 2019 at 07:54:24PM +0000, Saleem, Shiraz wrote:
>> >Subject: Re: [PATCH v2 rdma-next 1/5] RDMA/umem: Add API to find best
>> >driver supported page size in an MR
>> >
>> >On Tue, Apr 30, 2019 at 01:36:14PM +0000, Saleem, Shiraz wrote:
>> >
>> >> >If we make a MR with VA 0x6400FFF and length 2M-4095 I expect the
>> >> >2M page size with the NIC.
>> >> >
>> >> >We will have dma_addr_start = 0x2600000 and sg_dma_len = 0x200000
>> >> >as the SGL is always rounded to pages
>> >>
>> >> why isn't it the sg_dma_len 2M-4095? Is it because we compute
>> >> npages in ib_umem_get() to build the SGL? Could using (addr &
>> >> PAGE_MASK) and then adding dma_len help take care of this?
>> >
>> >We always round to page sizes when building the SGL, so the start is
>> >rounded down and the end remains the same.
>> >
>> >> >I have a feeling the uvirt_addr should be computed more like
>> >> >
>> >> >  if (flags & IB_UMEM_VA_BASED_OFFSET)
>> >> >        mask |= uvirt_addr ^ umem->addr;
>> >>
>> >> I am not following.
>> >>
>> >> For a case like below where uvirt_addr = umem_addr, mask = 0 and we
>> >> run rdma_find_pgbit on it we ll pick 4K instead of 2M which is wrong.
>> >
>> >> uvirt_addr [0x7f2b98200000]
>> >> best_pgsz [0x201000]
>> >> umem->address [0x7f2b98200000]
>> >> dma_addr_start [0x130e200000]
>> >> dma_addr_end [0x130e400000]
>> >> sg_dma_len [2097152]
>> >
>> >??
>> >
>> >0x7f2b98200000 ^ 0x7f2b98200000 = 0
>> >
>> >So mask isn't altered by the requested VA and you get 2M pages.
>
>> I am still missing the point. mask was initialized to 0 and if we just
>> do "mask |= uvirt_addr ^ umem->addr" for the first SGE, then you ll
>> always get 0 for mask (and one page size) when uvirt_addr = umem->addr
>> irrespective of their values.
>
>This is because mask shouldn't start as zero - the highest possible mask is
>something like log2_ru(umem length)
>
>ie absent other considerations the page size at the NIC should be the size of the
>umem.
>
>Then we scan the sgl and reduce that value based on the physical address
>layout
>
>Then we reduce it again based on the uvirt vs address difference
>
>Oring a '0' into the mask means that step contributes no restriction.
>
>..
>
>So I think the algorithm is just off as is, it should be more like
>
> // Page size can't be larger than the length of the MR mask = log2_ru(umem
>length);
>
> // offset into the first SGL for umem->addr pgoff = umem->address &
>PAGE_MASK;  va = uvirt_addr;
>

Did you mean pgoff = umem->address & ~PAGE_MASK?

> for_each_sgl()
>   mask |= (sgl->dma_addr + pgoff) ^ va
>   if (not first or last)
>       // Interior SGLs limit by the length as well
>       mask |= sgl->length;
>   va += sgl->length - pgoff;
>   pgoff = 0;
>
>The key is the xor of the VA to the PA at every step because that is really the
>restriction we are looking at. If any VA/PA bits differ for any address in the MR
>that immediately reduces the max page size.
>
>Remember what the HW does is
>  PA = MR_PAGE[VA] | (VA & PAGE_MASK)
>
>So any situation where PA & PAGE_MASK != VA is a violation - this is the
>calculation the XOR is doing.
>
>Jason
