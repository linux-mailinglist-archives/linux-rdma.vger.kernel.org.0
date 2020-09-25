Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA642786E1
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Sep 2020 14:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgIYMS3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Sep 2020 08:18:29 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8254 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbgIYMS2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Sep 2020 08:18:28 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6ddfe40001>; Fri, 25 Sep 2020 05:17:40 -0700
Received: from [172.27.0.140] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 25 Sep
 2020 12:18:12 +0000
Subject: Re: [Intel-gfx] [PATCH rdma-next v3 1/2] lib/scatterlist: Add support
 in dynamic allocation of SG table from pages
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <intel-gfx@lists.freedesktop.org>,
        "Roland Scheidegger" <sroland@vmware.com>,
        <dri-devel@lists.freedesktop.org>,
        "David Airlie" <airlied@linux.ie>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Maor Gottlieb <maorg@mellanox.com>
References: <20200922083958.2150803-1-leon@kernel.org>
 <20200922083958.2150803-2-leon@kernel.org>
 <118a03ef-d160-e202-81cc-16c9c39359fc@linux.intel.com>
 <20200925071330.GA2280698@unreal> <20200925115544.GY9475@nvidia.com>
From:   Maor Gottlieb <maorg@nvidia.com>
Message-ID: <65ca566b-7a5e-620f-13a4-c59eb836345a@nvidia.com>
Date:   Fri, 25 Sep 2020 15:18:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200925115544.GY9475@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601036260; bh=PMnHYOYqjgs1PwtSNIWsbxOtg5iE8X/aiPFJUpcU5V0=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=DpDz1d9nESDG1eppD1ezYbAW19jnYA71JSnUSM406RR0/qiXp6SdNkONM2RkGFmxR
         z809qiyeJJXZwac0oCZ4Wf3q3gfAmTwEqeMvEpea71FAyd53bBckUhLT8cR5zti+9E
         CTy3lI/gI8x+iULRyBlzZgrgzXEKZvJg2MoKLecKkjDEUMsI9y2BUYDEfvKkrs99YS
         rNzwBYYNls5yYHZDV37CT34wH4O9xpNx3ZP+DqRODUFwQ2CWVTJbd9DqjZV7lL2xoW
         scGS6YX9BQTlf8Uyo2D08lAerpW/0CDPTV2jXcKSEstyGhSHp2mVIkliG6zdteaxo5
         syBHDDeICgOqA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 9/25/2020 2:55 PM, Jason Gunthorpe wrote:
> On Fri, Sep 25, 2020 at 10:13:30AM +0300, Leon Romanovsky wrote:
>>>> diff --git a/tools/testing/scatterlist/main.c b/tools/testing/scatterlist/main.c
>>>> index 0a1464181226..4899359a31ac 100644
>>>> +++ b/tools/testing/scatterlist/main.c
>>>> @@ -55,14 +55,13 @@ int main(void)
>>>>    	for (i = 0, test = tests; test->expected_segments; test++, i++) {
>>>>    		struct page *pages[MAX_PAGES];
>>>>    		struct sg_table st;
>>>> -		int ret;
>>>> +		struct scatterlist *sg;
>>>>
>>>>    		set_pages(pages, test->pfn, test->num_pages);
>>>>
>>>> -		ret = __sg_alloc_table_from_pages(&st, pages, test->num_pages,
>>>> -						  0, test->size, test->max_seg,
>>>> -						  GFP_KERNEL);
>>>> -		assert(ret == test->alloc_ret);
>>>> +		sg = __sg_alloc_table_from_pages(&st, pages, test->num_pages, 0,
>>>> +				test->size, test->max_seg, NULL, 0, GFP_KERNEL);
>>>> +		assert(PTR_ERR_OR_ZERO(sg) == test->alloc_ret);
>>> Some test coverage for relatively complex code would be very welcomed. Since
>>> the testing framework is already there, even if it bit-rotted a bit, but
>>> shouldn't be hard to fix.
>>>
>>> A few tests to check append/grow works as expected, in terms of how the end
>>> table looks like given the initial state and some different page patterns
>>> added to it. And both crossing and not crossing into sg chaining scenarios.
>> This function is basic for all RDMA devices and we are pretty confident
>> that the old and new flows are tested thoroughly.
> Well, since 0-day is reporting that __i915_gem_userptr_alloc_pages is
> crashing on this, it probably does need some tests :\
>
> Jason

It is crashing in the regular old flow which already tested.
However, I will add more tests.
