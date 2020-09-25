Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68176278749
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Sep 2020 14:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgIYMdU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Sep 2020 08:33:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:41361 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIYMdU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Sep 2020 08:33:20 -0400
IronPort-SDR: zxeEcLuD26RXFPXzqq0VS8/6NeA+SNljkQqBY/c0fsxwNv3pjaSnG3FB4bypcXJQL9b9wP4qz+
 WhBIuDegfLyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="149165680"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="149165680"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 05:33:19 -0700
IronPort-SDR: hAAv+KjG+5EErAYnMJaScqJ3YYAs2Mc/2dUArWSDmx65J8EzpBWhcriotwbsqsU6JaoLkiPuAa
 UlmbgTVp8fFA==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="455809154"
Received: from mlevy2-mobl.ger.corp.intel.com (HELO [10.251.176.131]) ([10.251.176.131])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 05:33:15 -0700
Subject: Re: [Intel-gfx] [PATCH rdma-next v3 1/2] lib/scatterlist: Add support
 in dynamic allocation of SG table from pages
To:     Maor Gottlieb <maorg@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Roland Scheidegger <sroland@vmware.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Maor Gottlieb <maorg@mellanox.com>
References: <20200922083958.2150803-1-leon@kernel.org>
 <20200922083958.2150803-2-leon@kernel.org>
 <118a03ef-d160-e202-81cc-16c9c39359fc@linux.intel.com>
 <20200925071330.GA2280698@unreal> <20200925115544.GY9475@nvidia.com>
 <65ca566b-7a5e-620f-13a4-c59eb836345a@nvidia.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <33942b10-8eef-9180-44c5-b7379b92b824@linux.intel.com>
Date:   Fri, 25 Sep 2020 13:33:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <65ca566b-7a5e-620f-13a4-c59eb836345a@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 25/09/2020 13:18, Maor Gottlieb wrote:
> On 9/25/2020 2:55 PM, Jason Gunthorpe wrote:
>> On Fri, Sep 25, 2020 at 10:13:30AM +0300, Leon Romanovsky wrote:
>>>>> diff --git a/tools/testing/scatterlist/main.c 
>>>>> b/tools/testing/scatterlist/main.c
>>>>> index 0a1464181226..4899359a31ac 100644
>>>>> +++ b/tools/testing/scatterlist/main.c
>>>>> @@ -55,14 +55,13 @@ int main(void)
>>>>>        for (i = 0, test = tests; test->expected_segments; test++, 
>>>>> i++) {
>>>>>            struct page *pages[MAX_PAGES];
>>>>>            struct sg_table st;
>>>>> -        int ret;
>>>>> +        struct scatterlist *sg;
>>>>>
>>>>>            set_pages(pages, test->pfn, test->num_pages);
>>>>>
>>>>> -        ret = __sg_alloc_table_from_pages(&st, pages, 
>>>>> test->num_pages,
>>>>> -                          0, test->size, test->max_seg,
>>>>> -                          GFP_KERNEL);
>>>>> -        assert(ret == test->alloc_ret);
>>>>> +        sg = __sg_alloc_table_from_pages(&st, pages, 
>>>>> test->num_pages, 0,
>>>>> +                test->size, test->max_seg, NULL, 0, GFP_KERNEL);
>>>>> +        assert(PTR_ERR_OR_ZERO(sg) == test->alloc_ret);
>>>> Some test coverage for relatively complex code would be very 
>>>> welcomed. Since
>>>> the testing framework is already there, even if it bit-rotted a bit, 
>>>> but
>>>> shouldn't be hard to fix.
>>>>
>>>> A few tests to check append/grow works as expected, in terms of how 
>>>> the end
>>>> table looks like given the initial state and some different page 
>>>> patterns
>>>> added to it. And both crossing and not crossing into sg chaining 
>>>> scenarios.
>>> This function is basic for all RDMA devices and we are pretty confident
>>> that the old and new flows are tested thoroughly.
>> Well, since 0-day is reporting that __i915_gem_userptr_alloc_pages is
>> crashing on this, it probably does need some tests :\
>>
>> Jason
> 
> It is crashing in the regular old flow which already tested.
> However, I will add more tests.

Do you want to take some of the commits from 
git://people.freedesktop.org/~tursulin/drm-intel sgtest? It would be 
fine by me. I can clean up the commit messages if you want.

https://cgit.freedesktop.org/~tursulin/drm-intel/commit/?h=sgtest&id=79102f4d795c4769431fc44a6cf7ed5c5b1b5214 
- this one undoes the bit rot and makes the test just work on the 
current kernel.

https://cgit.freedesktop.org/~tursulin/drm-intel/commit/?h=sgtest&id=b09bfe80486c4d93ee1d8ae17d5b46397b1c6ee1 
- this one you probably should squash in your patch. Minus the zeroing 
of struct sg_stable since that would hide the issue.

https://cgit.freedesktop.org/~tursulin/drm-intel/commit/?h=sgtest&id=97f5df37e612f798ced90541eece13e2ef639181 
- final commit is optional but I guess handy for debugging.

Regards,

Tvrtko
