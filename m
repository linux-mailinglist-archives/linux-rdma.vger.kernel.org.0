Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D7A293A1E
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Oct 2020 13:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393428AbgJTLi0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Oct 2020 07:38:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:46470 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393425AbgJTLiZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Oct 2020 07:38:25 -0400
IronPort-SDR: dKhLs88e6rG10orFCPfF2uV5bvxi5eAqpJ76ogS0sYPE6gAmtqHYJtJvXJkmsUI9lDhfW8O/Wc
 4GCPzKSFetJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="164582834"
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="164582834"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 04:38:24 -0700
IronPort-SDR: ydD/Axmc4Tui3nH3aoa4MafQd26XXNXwc3SVSwefzIH9ebXtGuYT7ExQykXs3SlwQHiSapFD8e
 taO7vVdyrhwg==
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="533026907"
Received: from bszymanx-mobl.ger.corp.intel.com (HELO [10.252.55.244]) ([10.252.55.244])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 04:38:22 -0700
Subject: Re: dynamic-sg patch has broken rdma_rxe
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Gal Pressman <galpress@amazon.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
References: <20201014225125.GC5316@nvidia.com>
 <e2763434-2f4f-9971-ae9d-62bab62b2e93@nvidia.com>
 <63997d02-827c-5a0d-c6a1-427cbeb4ef27@amazon.com>
 <8cf4796d-4dcb-ef5a-83ac-e11134eac99b@nvidia.com>
 <20201016003127.GD6219@nvidia.com>
 <796ca31aed8f469c957cb850385b9d09@intel.com>
 <20201016115831.GI6219@nvidia.com>
 <9fa38ed1-605e-f0f6-6cb6-70b800a1831a@linux.intel.com>
 <20201019121211.GC6219@nvidia.com>
 <29ab34c2-0ca3-b3c0-6196-829e31d507c8@linux.intel.com>
 <20201019124822.GD6219@nvidia.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <03541c89-92d0-2dc8-5e40-03f3fe527fef@linux.intel.com>
Date:   Tue, 20 Oct 2020 12:37:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019124822.GD6219@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 19/10/2020 13:48, Jason Gunthorpe wrote:
> On Mon, Oct 19, 2020 at 01:29:42PM +0100, Tvrtko Ursulin wrote:
>> On 19/10/2020 13:12, Jason Gunthorpe wrote:
>>> On Mon, Oct 19, 2020 at 10:50:14AM +0100, Tvrtko Ursulin wrote:
>>>>> overshoot the max_segment if it is not a multiple of PAGE_SIZE. Simply fix
>>>>> the alignment before starting and don't expose this implementation detail
>>>>> to the callers.
>>>>
>>>> What does not make complete sense to me is the statement that input
>>>> alignment requirement makes it impossible to connect to DMA layer, but then
>>>> the patch goes to align behind the covers anyway.
>>>>
>>>> At minimum the kerneldoc should explain that max_segment will still be
>>>> rounded down. But wouldn't it be better for the API to be more explicit and
>>>> just require aligned anyway?
>>>
>>> Why?
>>>
>>> The API is to not produce sge's with a length longer than max_segment,
>>> it isn't to produce sge's of exactly max_segment.
>>>
>>> Everything else is an internal detail
>>
>> (Half-)pretending it is disconnected from PAGE_SIZE, when it really isn't,
>> isn't the most obvious API design in my view.
> 
> It is not information the callers need to care about

Unless they want a 1024 byte segment - then they do need to care. The 
patch just changes the rules from "any non-zero aligned" to "any greater 
or equal than PAGE_SIZE". I am simply asking why in more specific terms.

>> In other words, if you let users pass in 4097 and it just works by rounding
>> down to 4096, but you don't let them pass 4095, I just find this odd.
> 
> That is also an implementation detail, there is nothing preventing
> smaller than page size other than complexity of implementing the
> algorithm. If something ever needed it, it could be done.

But does non aligned segment size make sense? Is there any current or 
future platform which will need to to warrant changing the API in this way?

>> My question was why not have callers pass in page aligned max segment like
>> today which makes it completely transparent.
> 
> Why put this confusing code in every caller? Especially for something
> a driver is supposed to call. Will just make bugs

For max_segment to be aligned is a requirement today so callers are 
ready. I still don't understand why change that, what will it help with? 
Is it just about the desire to be able to pass in UINT_MAX?

Regards,

Tvrtko
