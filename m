Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816E1293BA0
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Oct 2020 14:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406033AbgJTMbe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Oct 2020 08:31:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:58698 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406030AbgJTMbd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Oct 2020 08:31:33 -0400
IronPort-SDR: ErN1SytBFJT956aWo+TKQlJvj3puZ5V+HKn55UAaEtNyij9sqx16hVGpFrvs1AgBKIEfb7r6x5
 WP+5jPVl8Xsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="163708157"
X-IronPort-AV: E=Sophos;i="5.77,397,1596524400"; 
   d="scan'208";a="163708157"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 05:31:32 -0700
IronPort-SDR: j3P/UPJM0tY39ZdLUFmRPJRzGBjZnuLSuYVYugG8e1AtHl9pRDVwWnHcKfFw8cLexa/A8epCbn
 0/aQbzuBFL7w==
X-IronPort-AV: E=Sophos;i="5.77,397,1596524400"; 
   d="scan'208";a="533041079"
Received: from bszymanx-mobl.ger.corp.intel.com (HELO [10.252.55.244]) ([10.252.55.244])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 05:31:29 -0700
Subject: Re: dynamic-sg patch has broken rdma_rxe
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Gal Pressman <galpress@amazon.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
References: <63997d02-827c-5a0d-c6a1-427cbeb4ef27@amazon.com>
 <8cf4796d-4dcb-ef5a-83ac-e11134eac99b@nvidia.com>
 <20201016003127.GD6219@nvidia.com>
 <796ca31aed8f469c957cb850385b9d09@intel.com>
 <20201016115831.GI6219@nvidia.com>
 <9fa38ed1-605e-f0f6-6cb6-70b800a1831a@linux.intel.com>
 <20201019121211.GC6219@nvidia.com>
 <29ab34c2-0ca3-b3c0-6196-829e31d507c8@linux.intel.com>
 <20201019124822.GD6219@nvidia.com>
 <03541c89-92d0-2dc8-5e40-03f3fe527fef@linux.intel.com>
 <20201020114710.GC6219@nvidia.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <c64bc07a-ed95-f462-a394-4191605c05b9@linux.intel.com>
Date:   Tue, 20 Oct 2020 13:31:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020114710.GC6219@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 20/10/2020 12:47, Jason Gunthorpe wrote:
> On Tue, Oct 20, 2020 at 12:37:05PM +0100, Tvrtko Ursulin wrote:
> 
>>> Why put this confusing code in every caller? Especially for something
>>> a driver is supposed to call. Will just make bugs
>>
>> For max_segment to be aligned is a requirement today so callers are
>> ready.
> 
> No, it turns out all the RDMA drivers were became broken when they
> converted to use the proper U32_MAX for their DMA max_segment size,
> then they couldn't form SGLs anymore.
> 
> I don't want to see nonsense code like this:
> 
>          dma_set_max_seg_size(dev->dev, min_t(unsigned int, U32_MAX & PAGE_MASK,
>                                               SCATTERLIST_MAX_SEGMENT));
> 
> In drivers.
> 
> dma_set_max_seg_size is the *hardware* capability, and mixing in
> things like PAG_MASK here is just nonsense.

Code was obviously a no-op non-sense.

So the crux of the argument is that U32_MAX is conceptually the right 
thing which defines the DMA max_segment size? Not some DMA define or 
anything, but really U32_MAX? And that all/some DMA hardware does not 
think in pages but really in bytes?

Regards,

Tvrtko
