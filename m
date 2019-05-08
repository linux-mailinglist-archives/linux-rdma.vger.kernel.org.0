Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A5016F68
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 05:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfEHDJE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 7 May 2019 23:09:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:38432 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfEHDJE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 May 2019 23:09:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 20:03:02 -0700
X-ExtLoop1: 1
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga001.jf.intel.com with ESMTP; 07 May 2019 20:03:01 -0700
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 7 May 2019 20:03:01 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.175]) by
 FMSMSX152.amr.corp.intel.com ([169.254.6.135]) with mapi id 14.03.0415.000;
 Tue, 7 May 2019 20:03:00 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v3 rdma-next 6/6] RDMA/verbs: Extend DMA block iterator
 support for mixed block sizes
Thread-Topic: [PATCH v3 rdma-next 6/6] RDMA/verbs: Extend DMA block iterator
 support for mixed block sizes
Thread-Index: AQHVBBM1V1fCbGIZhE6HVinKKyGD66Zeme6AgAHu26A=
Date:   Wed, 8 May 2019 03:03:00 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A5AD7E78@fmsmsx124.amr.corp.intel.com>
References: <20190506135337.11324-1-shiraz.saleem@intel.com>
 <20190506135337.11324-7-shiraz.saleem@intel.com>
 <20190506141659.GA6201@ziepe.ca>
In-Reply-To: <20190506141659.GA6201@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>Subject: Re: [PATCH v3 rdma-next 6/6] RDMA/verbs: Extend DMA block iterator
>support for mixed block sizes
>
>On Mon, May 06, 2019 at 08:53:37AM -0500, Shiraz Saleem wrote:
>> Extend the DMA block iterator for HW that can support mixed block
>> sizes. A bitmap of HW supported page sizes are provided to block
>> iterator which returns contiguous aligned memory blocks within a HW
>> supported page size.
>>
>> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
>> drivers/infiniband/core/verbs.c | 38
>++++++++++++++++++++++++++++++++++++--
>>  include/rdma/ib_verbs.h         | 18 ++++++++++++++----
>>  2 files changed, 50 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/verbs.c
>> b/drivers/infiniband/core/verbs.c index 3806038..fa9725d 100644
>> +++ b/drivers/infiniband/core/verbs.c
>> @@ -2712,16 +2712,47 @@ int rdma_init_netdev(struct ib_device *device,
>> u8 port_num,  }  EXPORT_SYMBOL(rdma_init_netdev);
>>
>> +static unsigned int rdma_find_mixed_pg_bit(struct ib_block_iter
>> +*biter) {
>> +	if (biter->__sg == biter->__sgl_head) {
>> +		return rdma_find_pg_bit(sg_dma_address(biter->__sg) +
>> +					sg_dma_len(biter->__sg),
>> +					biter->pgsz_bitmap);
>> +	} else if (sg_is_last(biter->__sg)) {
>> +		return rdma_find_pg_bit(sg_dma_address(biter->__sg),
>> +					biter->pgsz_bitmap);
>> +	} else {
>> +		unsigned int remaining =
>> +			sg_dma_address(biter->__sg) + sg_dma_len(biter->__sg)
>-
>> +			biter->__dma_addr;
>> +		unsigned int pg_bit = rdma_find_pg_bit(biter->__dma_addr,
>> +						       biter->pgsz_bitmap);
>> +		if (remaining < BIT_ULL(biter->__pg_bit))
>> +			pg_bit = rdma_find_pg_bit(remaining,
>> +						  biter->pgsz_bitmap);
>
>I think this needs to follow the same basic algorithm as the single bit case,
>considering the IOVA/etc.
>
>But there is no user, so let us just drop this patch until a user appears..
>
Sure. Let's wait for a user. Updating the algo to consider IOVA is do-able.

Shiraz
