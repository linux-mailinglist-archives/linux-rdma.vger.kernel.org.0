Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CABED14B3D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 15:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfEFNwr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 6 May 2019 09:52:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:17892 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfEFNwr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 09:52:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 06:52:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="146843481"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga008.fm.intel.com with ESMTP; 06 May 2019 06:52:46 -0700
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 6 May 2019 06:52:45 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.175]) by
 fmsmsx121.amr.corp.intel.com ([169.254.6.250]) with mapi id 14.03.0415.000;
 Mon, 6 May 2019 06:52:45 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Gal Pressman <galpress@amazon.com>
Subject: RE: [PATCH v2 rdma-next 1/5] RDMA/umem: Add API to find best driver
 supported page size in an MR
Thread-Topic: [PATCH v2 rdma-next 1/5] RDMA/umem: Add API to find best
 driver supported page size in an MR
Thread-Index: AQHU9rYQO5bZsKMgfk2PmawyTIYosKZNbYeAgAaoBrCAAXDXgP//m1jggACVloCAAslQsIABkQmA//+LWjCAAQDZgIADmmWw
Date:   Mon, 6 May 2019 13:52:45 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A5AD45F7@fmsmsx124.amr.corp.intel.com>
References: <20190419134353.12684-1-shiraz.saleem@intel.com>
 <20190419134353.12684-2-shiraz.saleem@intel.com>
 <20190425142559.GA5388@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5AC3A8C@fmsmsx124.amr.corp.intel.com>
 <20190430180503.GB8101@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5ACCB03@fmsmsx124.amr.corp.intel.com>
 <20190430210011.GA9059@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5AD1514@fmsmsx124.amr.corp.intel.com>
 <20190503152835.GB31165@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5AD161A@fmsmsx124.amr.corp.intel.com>
 <20190503235023.GA6660@ziepe.ca>
In-Reply-To: <20190503235023.GA6660@ziepe.ca>
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
>On Fri, May 03, 2019 at 04:01:27PM +0000, Saleem, Shiraz wrote:
>> >Subject: Re: [PATCH v2 rdma-next 1/5] RDMA/umem: Add API to find best
>> >driver supported page size in an MR
>> >
>> >On Fri, May 03, 2019 at 03:22:59PM +0000, Saleem, Shiraz wrote:
>> >> >This is because mask shouldn't start as zero - the highest
>> >> >possible mask is something like log2_ru(umem length)
>> >> >
>> >> >ie absent other considerations the page size at the NIC should be
>> >> >the size of the umem.
>> >> >
>> >> >Then we scan the sgl and reduce that value based on the physical
>> >> >address layout
>> >> >
>> >> >Then we reduce it again based on the uvirt vs address difference
>> >> >
>> >> >Oring a '0' into the mask means that step contributes no restriction.
>> >> >
>> >> >..
>> >> >
>> >> >So I think the algorithm is just off as is, it should be more like
>> >> >
>> >> > // Page size can't be larger than the length of the MR mask =
>> >> >log2_ru(umem length);
>> >> >
>> >> > // offset into the first SGL for umem->addr pgoff = umem->address
>> >> >& PAGE_MASK;  va = uvirt_addr;
>> >> >
>> >>
>> >> Did you mean pgoff = umem->address & ~PAGE_MASK?
>> >
>> >Yes...
>>
>> OK. Don't we need something like this for zero based VA?
>> va = uvirt_addr ?  uvirt_addr :  umem->addr;
>
>Every MR is created with an IOVA (here called VA). Before we get here the caller
>should figure out the IOVA and it should either be 0 or
>umem->address in the cases we implement today *however* it can really
>be anything and this code shouldn't care..
>
>> Also can we do this for all HW?
>
>All hardware has to support an arbitary IOVA.
>
>> Or do we keep the IB_UMEM_VA_BASED_OFFSET flag and OR in the
>> dma_addr_end (for first SGL) and dma_addr_start (for last SGL) to the
>> mask when the flag is not set?
>
>I wasn't totally sure what that flag did..
>
>If we don't have any drivers that need something different today then I would
>focus entirely on the:
>
> PA = MR_PAGE_TABLE[IOVA/PAGE_SIZE] | (IOVA & PAGE_MASK)
>

OK. Agreed.

Shiraz
