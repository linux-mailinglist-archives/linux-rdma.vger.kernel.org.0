Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6992786C3
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Sep 2020 14:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgIYMNt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Sep 2020 08:13:49 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6791 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbgIYMNt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Sep 2020 08:13:49 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6dde9b0000>; Fri, 25 Sep 2020 05:12:11 -0700
Received: from [172.27.0.140] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 25 Sep
 2020 12:13:30 +0000
Subject: Re: [Intel-gfx] [PATCH rdma-next v3 1/2] lib/scatterlist: Add support
 in dynamic allocation of SG table from pages
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <intel-gfx@lists.freedesktop.org>,
        Roland Scheidegger <sroland@vmware.com>,
        <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
        "VMware Graphics" <linux-graphics-maintainer@vmware.com>,
        Maor Gottlieb <maorg@mellanox.com>
References: <20200922083958.2150803-1-leon@kernel.org>
 <20200922083958.2150803-2-leon@kernel.org>
 <118a03ef-d160-e202-81cc-16c9c39359fc@linux.intel.com>
 <20200925071330.GA2280698@unreal>
 <adff5752-582c-2065-89e2-924ef732911a@linux.intel.com>
From:   Maor Gottlieb <maorg@nvidia.com>
Message-ID: <a8cca9f0-58ec-654d-939e-8568d17d4c60@nvidia.com>
Date:   Fri, 25 Sep 2020 15:13:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <adff5752-582c-2065-89e2-924ef732911a@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601035931; bh=OOxZYaeyrnTeUKolTNHANplbexAqSviLCY+bHC09/Hg=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=HYmkm8xCiVsEWw4dyNi+Djz5rk4y7teGKYpjvtAVH5SihKKT0eSxXfGiZvQTX7iWg
         PFvEwPjW3jL84//v1jjMU/5QXGHzXMlfUxFOMxDqiqj94VsaICGmdRPFU7DPO4TC7/
         ZpdnfqdNWnZFfhZuNM7NRq/BTnoKS1U8DVwRpUNEO5+FmGLfl9nK53ra2MXnsu5N3K
         YVPYZmtU/YqjUpm1Fr5Eafxu7TaMR+d+aym6WkJWJJDnhtc9efmBxR0gDQNKBzwU6n
         Xb+2y4LNG3tJx/NqWDyygyZD7GluQjDlpYoQWZS22uuls+E52NaLCCDjA9zY0UzJPd
         ZID+Pru1blUYA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 9/25/2020 2:41 PM, Tvrtko Ursulin wrote:
>
> On 25/09/2020 08:13, Leon Romanovsky wrote:
>> On Thu, Sep 24, 2020 at 09:21:20AM +0100, Tvrtko Ursulin wrote:
>>>
>>> On 22/09/2020 09:39, Leon Romanovsky wrote:
>>>> From: Maor Gottlieb <maorg@mellanox.com>
>>>>
>>>> Extend __sg_alloc_table_from_pages to support dynamic allocation of
>>>> SG table from pages. It should be used by drivers that can't supply
>>>> all the pages at one time.
>>>>
>>>> This function returns the last populated SGE in the table. Users=20
>>>> should
>>>> pass it as an argument to the function from the second call and=20
>>>> forward.
>>>> As before, nents will be equal to the number of populated SGEs=20
>>>> (chunks).
>>>
>>> So it's appending and growing the "list", did I get that right?=20
>>> Sounds handy
>>> indeed. Some comments/questions below.
>>
>> Yes, we (RDMA) use this function to chain contiguous pages.
>
> I will eveluate if i915 could start using it. We have some loops which=20
> build page by page and coalesce.
>
> [snip]
>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(ret))
>>>> diff --git a/tools/testing/scatterlist/main.c=20
>>>> b/tools/testing/scatterlist/main.c
>>>> index 0a1464181226..4899359a31ac 100644
>>>> --- a/tools/testing/scatterlist/main.c
>>>> +++ b/tools/testing/scatterlist/main.c
>>>> @@ -55,14 +55,13 @@ int main(void)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0, test =3D tests; tes=
t->expected_segments; test++,=20
>>>> i++) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pa=
ge *pages[MAX_PAGES];
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sg=
_table st;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct scatterlist *sg;
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_pages=
(pages, test->pfn, test->num_pages);
>>>>
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D __sg_alloc_table_f=
rom_pages(&st, pages,=20
>>>> test->num_pages,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0, test->size, test->max_seg,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 GFP_KERNEL);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(ret =3D=3D test->al=
loc_ret);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sg =3D __sg_alloc_table_fr=
om_pages(&st, pages,=20
>>>> test->num_pages, 0,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 test->size, test->max_seg, NULL, 0, GFP_KERNEL);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(PTR_ERR_OR_ZERO(sg)=
 =3D=3D test->alloc_ret);
>>>
>>> Some test coverage for relatively complex code would be very=20
>>> welcomed. Since
>>> the testing framework is already there, even if it bit-rotted a bit,=20
>>> but
>>> shouldn't be hard to fix.
>>>
>>> A few tests to check append/grow works as expected, in terms of how=20
>>> the end
>>> table looks like given the initial state and some different page=20
>>> patterns
>>> added to it. And both crossing and not crossing into sg chaining=20
>>> scenarios.
>>
>> This function is basic for all RDMA devices and we are pretty confident
>> that the old and new flows are tested thoroughly.
>>
>> We will add proper test in next kernel cycle.
>
> Patch seems to be adding a requirement that all callers of=20
> (__)sg_alloc_table_from_pages pass in zeroed struct sg_table, which=20
> wasn't the case so far.
>
> Have you audited all the callers and/or fixed them? There seems to be=20
> quite a few. Gut feel says problem would probably be better solved in=20
> lib/scatterlist.c and not by making all the callers memset. Should be=20
> possible if you make sure you only read st->nents if prev was passed in?
>
> I've fixed the unit test and with this change the existing tests do=20
> pass. But without zeroing it does fail on the very first, single page,=20
> test scenario.
>
> You can pull the unit test hacks from=20
> git://people.freedesktop.org/~tursulin/drm-intel sgtest.
>
> Regards,
>
> Tvrtko

Thanks for finding this issue.=C2=A0 In the regular flow,=20
__sg_alloc_table_from_pages memset the sg_table struct, but currently=20
the code access this struct before. Will be fixed internally in scatterlist=
.

