Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9D82789C9
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Sep 2020 15:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgIYNkL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Sep 2020 09:40:11 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1414 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgIYNkL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Sep 2020 09:40:11 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6df32e0000>; Fri, 25 Sep 2020 06:39:58 -0700
Received: from [172.27.1.66] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 25 Sep
 2020 13:39:56 +0000
Subject: Re: [Intel-gfx] [PATCH rdma-next v3 1/2] lib/scatterlist: Add support
 in dynamic allocation of SG table from pages
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
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
 <65ca566b-7a5e-620f-13a4-c59eb836345a@nvidia.com>
 <33942b10-8eef-9180-44c5-b7379b92b824@linux.intel.com>
From:   Maor Gottlieb <maorg@nvidia.com>
Message-ID: <9d69d68d-7868-609b-c703-dfe9fec93a0f@nvidia.com>
Date:   Fri, 25 Sep 2020 16:39:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <33942b10-8eef-9180-44c5-b7379b92b824@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601041198; bh=I3MevVq0rfThlib9stYezAlO6VoXyq/abMk8uS5Rf30=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=cT03BzeJw3AnIIrmEndxMyFxZGs1x1e+luerBaV6utLXOQpxqyHE0J35I/xDt+xhQ
         nR5XsHMTcB0Sg+P7pyDrtOk1sPUxKgkwNxDjh5LrmwZNkflEO0B+KyIXAPtShuGdZp
         BAkM4kyDxQzdIawJgqR//5croKMPwX5+yyb7UibsGX7XYCgs5+KQQNnOr3xu1koFWo
         l66mYjr0hXJexrdgIiX4ZJXsHGEllajD/0UevEWQGSQk7XBJszxIYwaFw0yubCntpL
         oG5dpHOEhdPi1skYh5ja8JQdJ+bII9s7XSD/ihYM9L8T/rsdj8ZZifbMGapnVBN7QJ
         rq56RmEyRwkhA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 9/25/2020 3:33 PM, Tvrtko Ursulin wrote:
>
> On 25/09/2020 13:18, Maor Gottlieb wrote:
>> On 9/25/2020 2:55 PM, Jason Gunthorpe wrote:
>>> On Fri, Sep 25, 2020 at 10:13:30AM +0300, Leon Romanovsky wrote:
>>>>>> diff --git a/tools/testing/scatterlist/main.c=20
>>>>>> b/tools/testing/scatterlist/main.c
>>>>>> index 0a1464181226..4899359a31ac 100644
>>>>>> +++ b/tools/testing/scatterlist/main.c
>>>>>> @@ -55,14 +55,13 @@ int main(void)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0, test =3D tests; t=
est->expected_segments; test++,=20
>>>>>> i++) {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct =
page *pages[MAX_PAGES];
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct =
sg_table st;
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct scatterlist *sg;
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_pag=
es(pages, test->pfn, test->num_pages);
>>>>>>
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D __sg_alloc_table=
_from_pages(&st, pages,=20
>>>>>> test->num_pages,
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0, test->size, test->max_seg,
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 GFP_KERNEL);
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(ret =3D=3D test->=
alloc_ret);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sg =3D __sg_alloc_table_=
from_pages(&st, pages,=20
>>>>>> test->num_pages, 0,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 test->size, test->max_seg, NULL, 0, GFP_KERNEL);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(PTR_ERR_OR_ZERO(s=
g) =3D=3D test->alloc_ret);
>>>>> Some test coverage for relatively complex code would be very=20
>>>>> welcomed. Since
>>>>> the testing framework is already there, even if it bit-rotted a=20
>>>>> bit, but
>>>>> shouldn't be hard to fix.
>>>>>
>>>>> A few tests to check append/grow works as expected, in terms of=20
>>>>> how the end
>>>>> table looks like given the initial state and some different page=20
>>>>> patterns
>>>>> added to it. And both crossing and not crossing into sg chaining=20
>>>>> scenarios.
>>>> This function is basic for all RDMA devices and we are pretty=20
>>>> confident
>>>> that the old and new flows are tested thoroughly.
>>> Well, since 0-day is reporting that __i915_gem_userptr_alloc_pages is
>>> crashing on this, it probably does need some tests :\
>>>
>>> Jason
>>
>> It is crashing in the regular old flow which already tested.
>> However, I will add more tests.
>
> Do you want to take some of the commits from=20
> git://people.freedesktop.org/~tursulin/drm-intel sgtest? It would be=20
> fine by me. I can clean up the commit messages if you want.

I will very appreciate it. Thanks
>
> https://cgit.freedesktop.org/~tursulin/drm-intel/commit/?h=3Dsgtest&id=3D=
79102f4d795c4769431fc44a6cf7ed5c5b1b5214=20
> - this one undoes the bit rot and makes the test just work on the=20
> current kernel.
>
> https://cgit.freedesktop.org/~tursulin/drm-intel/commit/?h=3Dsgtest&id=3D=
b09bfe80486c4d93ee1d8ae17d5b46397b1c6ee1=20
> - this one you probably should squash in your patch. Minus the zeroing=20
> of struct sg_stable since that would hide the issue.
>
> https://cgit.freedesktop.org/~tursulin/drm-intel/commit/?h=3Dsgtest&id=3D=
97f5df37e612f798ced90541eece13e2ef639181=20
> - final commit is optional but I guess handy for debugging.
>
> Regards,
>
> Tvrtko
