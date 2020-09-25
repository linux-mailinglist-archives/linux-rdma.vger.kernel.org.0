Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D893827873E
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Sep 2020 14:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbgIYM36 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Sep 2020 08:29:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:29934 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIYM36 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Sep 2020 08:29:58 -0400
IronPort-SDR: S13Rs3MywnsojtvA43xI5ULhDA5vmklcFPsojsBXEEbTvBvUnTI+WJQqhLohqSqbaozjCQefrl
 Lq1qWdRzDQyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="140926049"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="140926049"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 05:29:58 -0700
IronPort-SDR: OatOg+mI2cktpFK85pdpyPjv0iQQ+N/4tqSMOhX/do3enQSWt2VmuP8C841vmZkqHsUfbL0sie
 MthwJq7tkFmA==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="455808533"
Received: from mlevy2-mobl.ger.corp.intel.com (HELO [10.251.176.131]) ([10.251.176.131])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 05:29:53 -0700
Subject: Re: [Intel-gfx] [PATCH rdma-next v3 1/2] lib/scatterlist: Add support
 in dynamic allocation of SG table from pages
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Roland Scheidegger <sroland@vmware.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Maor Gottlieb <maorg@mellanox.com>
References: <20200922083958.2150803-1-leon@kernel.org>
 <20200922083958.2150803-2-leon@kernel.org>
 <118a03ef-d160-e202-81cc-16c9c39359fc@linux.intel.com>
 <20200925071330.GA2280698@unreal>
 <adff5752-582c-2065-89e2-924ef732911a@linux.intel.com>
 <20200925115833.GZ9475@nvidia.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <c5956163-1769-ee40-e4ed-45532d8c4e19@linux.intel.com>
Date:   Fri, 25 Sep 2020 13:29:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925115833.GZ9475@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 25/09/2020 12:58, Jason Gunthorpe wrote:
> On Fri, Sep 25, 2020 at 12:41:29PM +0100, Tvrtko Ursulin wrote:
>>
>> On 25/09/2020 08:13, Leon Romanovsky wrote:
>>> On Thu, Sep 24, 2020 at 09:21:20AM +0100, Tvrtko Ursulin wrote:
>>>>
>>>> On 22/09/2020 09:39, Leon Romanovsky wrote:
>>>>> From: Maor Gottlieb <maorg@mellanox.com>
>>>>>
>>>>> Extend __sg_alloc_table_from_pages to support dynamic allocation of
>>>>> SG table from pages. It should be used by drivers that can't supply
>>>>> all the pages at one time.
>>>>>
>>>>> This function returns the last populated SGE in the table. Users should
>>>>> pass it as an argument to the function from the second call and forward.
>>>>> As before, nents will be equal to the number of populated SGEs (chunks).
>>>>
>>>> So it's appending and growing the "list", did I get that right? Sounds handy
>>>> indeed. Some comments/questions below.
>>>
>>> Yes, we (RDMA) use this function to chain contiguous pages.
>>
>> I will eveluate if i915 could start using it. We have some loops which build
>> page by page and coalesce.
> 
> Christoph H doesn't like it, but if there are enough cases we should
> really have a pin_user_pages_to_sg() rather than open code this all
> over the place.
> 
> With THP the chance of getting a coalescing SG is much higher, and
> everything is more efficient with larger SGEs.

Right, I was actually referring to i915 sites where we build sg tables 
out of shmem and plain kernel pages. In those areas we have some open 
coded coalescing loops (see for instance our shmem_get_pages). Plus a 
local "trim" to discard the unused entries, since we allocate 
pessimistically not knowing how coalescing will pan out. This kind of 
core function which appends pages could replace some of that. Maybe it 
would be slightly less efficient but I will pencil in to at least 
evaluate it.

Otherwise I do agree that coalescing is a win and in the past I have 
measured savings in a few MiB range just for struct scatterlist storage.

Regards,

Tvrtko
