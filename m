Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 758811639C1
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 03:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgBSCBx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 21:01:53 -0500
Received: from p3plsmtpa11-04.prod.phx3.secureserver.net ([68.178.252.105]:41135
        "EHLO p3plsmtpa11-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727811AbgBSCBx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Feb 2020 21:01:53 -0500
Received: from [192.168.0.78] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id 4EgRjpZOZilGc4EgRjfQb2; Tue, 18 Feb 2020 19:01:52 -0700
X-CMAE-Analysis: v=2.3 cv=CubBjUwD c=1 sm=1 tr=0
 a=ugQcCzLIhEHbLaAUV45L0A==:117 a=ugQcCzLIhEHbLaAUV45L0A==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=uPZiAMpXAAAA:8
 a=US7-Rng0AAAA:8 a=hm3lfIpQmTSrtjT96BEA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=QEXdDO2ut3YA:10 a=RCpFSEPCRiHwXyn-TuLs:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [RFC v2] RoCE v2.0 Entropy - IPv6 Flow Label and UDP Source Port
To:     Mark Zhang <markz@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alex Rosenbaum <rosenbaumalex@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Alex Rosenbaum <alexr@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
References: <CAFgAxU8ArpoL9fMpJY5v-UZS5AMXom+TJ8HS57XeEOsCFFov8Q@mail.gmail.com>
 <63a56c06-57bf-6e31-6ca8-043f9d3b72f3@talpey.com>
 <CAFgAxU80+feEEtaRYFYTHwTMSE6Edjq0t0siJ0W06WSyD+Cy3A@mail.gmail.com>
 <b0414c43-c035-aa90-9f89-7ec6bba9e119@talpey.com>
 <CAFgAxU-LW+t17frRnNOYgoaqJEwffRPfFDasOPjbyVmuxj8AXA@mail.gmail.com>
 <09478db9-28ca-65fe-1424-b0229a514bbb@talpey.com>
 <CAFgAxU8XmoOheJ29s7r7J23V1x0QcagDgUDVGSyfKyaWSEzRzg@mail.gmail.com>
 <62f4df50-b50d-29e2-a0f4-eccaf81bd8d9@talpey.com>
 <20200213154110.GJ31668@ziepe.ca>
 <3be3b3ff-a901-b716-827a-6b1019fa1924@mellanox.com>
 <de3aeeb7-41ef-fadc-7865-e3e9fc005476@mellanox.com>
 <55e8c9cf-cd64-27b2-1333-ac4849f5e3ff@talpey.com>
 <e758da0d-94a3-a22f-c2aa-3d13714c4ed3@talpey.com>
 <4fc5590f-727c-2395-7de0-afb1d83f546b@mellanox.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <91155305-10f0-22b5-b93b-2953c53dfc46@talpey.com>
Date:   Tue, 18 Feb 2020 21:01:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <4fc5590f-727c-2395-7de0-afb1d83f546b@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPT4qlsFW2nDO+F+HDSFlVa11oeWKUXzxr7s8kjphGLrCs4oNY7zfs6W1Bwc8jWn+QkQwwcRG6J7CmynPDeaFHyGeXS31dZbKtkvIFRLsxdVU3OUQIL/
 +NlSvIfoDZgXT73+MlRTioClpUjJZ0w71FHbrQVt/ynxl1D97Mn9LqSZ01G/MbBUe/p7jl5JhrYKJNBgmAfsLGz8WN5VvEjGbNASuOqkwBFUFzWhhoyfq9/V
 jkB9VLvvjeMezm8T7RZ1DyWBQjqXulgi7Y+EiAJr6IN/izoMNsLLeLAaJMPMln/LqP7ZyEMsYelQipylTswnV/5jT6jSCYY9F4WodWyGs61SEBntVX44yvfK
 eCFeHOCrBhNagjiYIrQL/X9lvGXR8dNLXU8fvu2EG598FtBT96tWck4Qix85ZZzmQz8k08no
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/18/2020 8:51 PM, Mark Zhang wrote:
> On 2/19/2020 1:41 AM, Tom Talpey wrote:
>> On 2/18/2020 9:16 AM, Tom Talpey wrote:
>>> On 2/15/2020 1:27 AM, Mark Zhang wrote:
>>>> On 2/14/2020 10:23 PM, Mark Zhang wrote:
>>>>> On 2/13/2020 11:41 PM, Jason Gunthorpe wrote:
>>>>>> On Thu, Feb 13, 2020 at 10:26:09AM -0500, Tom Talpey wrote:
>>>>>>
>>>>>>>> If both src & dst ports are in the high value range you loss those
>>>>>>>> hash bits in the masking.
>>>>>>>> If src & dst port are both 0xE000, your masked hash equals 0. You'll
>>>>>>>> get the same hash if both ports are equal 0xF000.
>>>>>>>
>>>>>>> Sure, but this is because it's a 20-bit hash of a 32-bit object.
>>>>>>> There
>>>>>>> will always be collisions, this is just one example. My concern is
>>>>>>> the
>>>>>>> statistical spread of the results. I argue it's not changed by the
>>>>>>> proposed bit-folding, possibly even damaged.
>>>>>>
>>>>>> I've always thought that 'folding' by modulo results in an abnormal
>>>>>> statistical distribution
>>>>>>
>>>>>> The point here is not collisions but to have a hash distribution which
>>>>>> is generally uniform for the input space.
>>>>>>
>>>>>> Alex, it would be good to make a quick program to measure the
>>>>>> uniformity of the distribution..
>>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> I did some tests with a quick program (hope it's not buggy...),
>>>>> seems the hash without "folding" has a better distribution than hash
>>>>> with fold. The "hash quality" is reflected by the "total_access"[1]
>>>>> below.
>>>>>
>>>>> I tested only with cma_dport from 18515 (ib_write_bw default) to
>>>>> 18524. I can do more tests if required, for example use multiple
>>>>> cma_dport in one statistic.
>>>>>
>>>>>
>>>>> [1]
>>>>> https://stackoverflow.com/questions/24729730/measuring-a-hash-functions-quality-for-use-with-maps-assosiative-arrays
>>>>>
>>>>>
>>>>> $ ./a
>>>>>
>>>>> max: Say for slot x there are tb[x] items, then 'max = max(tb[x])';
>>>>> Lower is better;
>>>>> min: Say for slot x there are tb[x] items, then 'min = min(tb[x])';
>>>>> Likely min is always 0
>>>>> total_access: The sum of all 'accesses' (for each slot:
>>>>> accesses=n*(n+1)/2); Lower is better
>>>>> n[X]: How many slots that has X items
>>>>>
>>>>> cm source port range [32768, 65534], dest port 18515:
>>>>> Hash with folding:
>>>>>       flow_label: max 2 min 0 total_access 32766  n[1] = 32514 n[2] =
>>>>> 126
>>>>>       udp_sport: max 10 min 0 total_access 51740  n[1] = 4420  n[2] =
>>>>> 4670  n[3] = 3112  n[4] = 1433  n[5] = 535   n[6] = 163   n[7] = 31
>>>>> n[8] = 5     n[9] = 2     n[10] = 1
>>>>> Hash without folding:
>>>>>       flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>>>>>       udp_sport: max 4 min 0 total_access 48618   n[1] = 532   n[2] =
>>>>> 7926  n[3] = 530   n[4] = 3698
>>>>>
>>>>>
>>>>> cm source port range [32768, 65534], dest port 18516:
>>>>> Hash with folding:
>>>>>       flow_label: max 3 min 0 total_access 32774  n[1] = 31214 n[2] =
>>>>> 770    n[3] = 4
>>>>>       udp_sport: max 8 min 0 total_access 50808   n[1] = 4406  n[2] =
>>>>> 4873  n[3] = 3157  n[4] = 1413  n[5] = 509   n[6] = 129   n[7] = 20
>>>>> n[8] = 4
>>>>> Hash without folding:
>>>>>       flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>>>>>       udp_sport: max 2 min 1 total_access 32766   n[1] = 2     n[2] =
>>>>> 16382
>>>>>
>>>>>
>>>>> cm source port range [32768, 65534], dest port 18517:
>>>>> Hash with folding:
>>>>>       flow_label: max 2 min 0 total_access 32766  n[1] = 32250 n[2] =
>>>>> 258
>>>>>       udp_sport: max 10 min 0 total_access 54916  n[1] = 4536  n[2] =
>>>>> 4170  n[3] = 2817  n[4] = 1445  n[5] = 622   n[6] = 275   n[7] = 94
>>>>> n[8] = 22    n[9] = 5     n[10] = 2
>>>>> Hash without folding:
>>>>>       flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>>>>>       udp_sport: max 3 min 1 total_access 38402   n[1] = 2820  n[2] =
>>>>> 10746 n[3] = 2818
>>>>>
>>>>>
>>>>> cm source port range [32768, 65534], dest port 18518:
>>>>> Hash with folding:
>>>>>       flow_label: max 2 min 0 total_access 32766  n[1] = 32066 n[2] =
>>>>> 350
>>>>>       udp_sport: max 8 min 0 total_access 50018   n[1] = 4435  n[2] =
>>>>> 4970  n[3] = 3294  n[4] = 1376  n[5] = 465   n[6] = 92    n[7] = 16
>>>>> n[8] = 2
>>>>> Hash without folding:
>>>>>       flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>>>>>       udp_sport: max 2 min 1 total_access 32766   n[1] = 2     n[2] =
>>>>> 16382
>>>>>
>>>>>
>>>>> cm source port range [32768, 65534], dest port 18519:
>>>>> Hash with folding:
>>>>>       flow_label: max 3 min 0 total_access 32774  n[1] = 31816 n[2] =
>>>>> 469    n[3] = 4
>>>>>       udp_sport: max 8 min 0 total_access 51462   n[1] = 4414  n[2] =
>>>>> 4734  n[3] = 3088  n[4] = 1466  n[5] = 508   n[6] = 160   n[7] = 32
>>>>> n[8] = 4
>>>>> Hash without folding:
>>>>>       flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>>>>>       udp_sport: max 4 min 0 total_access 45490   n[1] = 3662  n[2] =
>>>>> 6360  n[3] = 3660  n[4] = 1351
>>>>>
>>>>>
>>>>> cm source port range [32768, 65534], dest port 18520:
>>>>> Hash with folding:
>>>>>       flow_label: max 6 min 0 total_access 34618  n[1] = 20349 n[2] =
>>>>> 5027  n[3] = 550   n[4] = 164   n[5] = 9     n[6] = 2
>>>>>       udp_sport: max 13 min 0 total_access 82542  n[1] = 549   n[2] =
>>>>> 1167  n[3] = 1635  n[4] = 1706  n[5] = 1341  n[6] = 836   n[7] = 483
>>>>> n[8] = 223   n[9] = 87    n[10] = 27
>>>>> Hash without folding:
>>>>>       flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>>>>>       udp_sport: max 4 min 0 total_access 65530 n[3] = 2     n[4] = 8190
>>>>>
>>>>>
>>>>> cm source port range [32768, 65534], dest port 18521:
>>>>> Hash with folding:
>>>>>       flow_label: max 2 min 0 total_access 32766  n[1] = 31924 n[2] =
>>>>> 421
>>>>>       udp_sport: max 9 min 0 total_access 51864   n[1] = 4505  n[2] =
>>>>> 4645  n[3] = 3038  n[4] = 1464  n[5] = 542   n[6] = 154   n[7] = 43
>>>>> n[8] = 6     n[9] = 2
>>>>> Hash without folding:
>>>>>       flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>>>>>       udp_sport: max 3 min 1 total_access 32810   n[1] = 24    n[2] =
>>>>> 16338 n[3] = 22
>>>>>
>>>>>
>>>>> cm source port range [32768, 65534], dest port 18522:
>>>>> Hash with folding:
>>>>>       flow_label: max 3 min 0 total_access 32768  n[1] = 32197 n[2] =
>>>>> 283    n[3] = 1
>>>>>       udp_sport: max 9 min 0 total_access 50850   n[1] = 4561  n[2] =
>>>>> 4756  n[3] = 3187  n[4] = 1452  n[5] = 453   n[6] = 137   n[7] = 29
>>>>> n[8] = 2     n[9] = 2
>>>>> Hash without folding:
>>>>>       flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>>>>>       udp_sport: max 2 min 1 total_access 32766   n[1] = 2     n[2] =
>>>>> 16382
>>>>>
>>>>>
>>>>> cm source port range [32768, 65534], dest port 18523:
>>>>> Hash with folding:
>>>>>       flow_label: max 2 min 0 total_access 32766  n[1] = 32514 n[2] =
>>>>> 126
>>>>>       udp_sport: max 8 min 0 total_access 52208   n[1] = 4426  n[2] =
>>>>> 4609  n[3] = 3069  n[4] = 1435  n[5] = 533   n[6] = 180   n[7] = 50
>>>>> n[8] = 10
>>>>> Hash without folding:
>>>>>       flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>>>>>       udp_sport: max 4 min 0 total_access 46062   n[1] = 3096  n[2] =
>>>>> 6640  n[3] = 3094  n[4] = 1777
>>>>>
>>>>>
>>>>> cm source port range [32768, 65534], dest port 18524:
>>>>> Hash with folding:
>>>>>       flow_label: max 3 min 0 total_access 32774  n[1] = 31362 n[2] =
>>>>> 696    n[3] = 4
>>>>>       udp_sport: max 8 min 0 total_access 49490   n[1] = 4440  n[2] =
>>>>> 5148  n[3] = 3240  n[4] = 1413  n[5] = 394   n[6] = 97    n[7] = 14
>>>>> n[8] = 1
>>>>> Hash without folding:
>>>>>       flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>>>>>       udp_sport: max 2 min 1 total_access 32766   n[1] = 2     n[2] =
>>>>> 16382
>>>>>
>>>>>
>>>>
>>>> Another finding is, when cma_dport is multiple of 0x200 (i.e., 0x600,
>>>> 0x800, ... 0xFE00), the hash distribution is tens of times worse then
>>>> others. For examples when dport is 18431 and 18432:
>>>>
>>>> cm source port range [32768, 65534], dest port 18431:
>>>> Hash with folding:
>>>>       flow_label: max 2 min 0 total_access 32766
>>>>       udp_sport:  max 8 min 0 total_access 50410
>>>> Hash without folding:
>>>>       flow_label: max 1 min 0 total_access 32766
>>>>       udp_sport:  max 4 min 0 total_access 48126
>>>>
>>>> cm source port range [32768, 65534], dest port 18432(0x4800):
>>>> Hash with folding:
>>>>       flow_label: max 133 min 0 total_access 1072938
>>>>
>>>>       udp_sport:  max 203 min 0 total_access 2126644
>>>>
>>>> Hash without folding:
>>>>       flow_label: max 64 min 0   total_access 1048450
>>>>
>>>>       udp_sport:  max 1024 min 0 total_access 16775170
>>>
>>> Good data! It certainly indicates an issue with the simple
>>> binary modulus for treuncating 32->20 bits. But the extremely
>>> narrow testing range limits the conclusions considerably:
>>>
>>>   >> I tested only with cma_dport from 18515 (ib_write_bw default) to
>>>   >> 18524. I can do more tests if required, for example use multiple
>>>   >> cma_dport in one statistic.
>>>
>>> This hash is intended to provide entropy across the entire port
>>> range and we should evaluate it as such. At a minimum, the source
>>> port can vary much more widely, from Alex's original message it's
>>> 0xC000 - 0xFFFF.
>>>
>>>> UDP source port selection must adhere IANA port allocation ranges.
>>>> Thus we will
>>>> be using IANA recommendation for Ephemeral port range of:
>>>> 49152-65535, or in
>>>> hex: 0xC000-0xFFFF.
>>>
>>> I'm not certain what the range of the destination port might be, but
>>> as a Service ID, a good assumption is the full range of 0x1 - 0xBFFF.
>>>
>>> Any chance you could scale up your test, to measure the original
>>> proposed hash across these broader ranges?
>>>
>>>>    u32 hash = DstPort * SrcPort;
>>>>    hash ^= (hash >> 16);
>>>>    hash ^= (hash >> 8);
>>>>    AH_ATTR.GRH.flow_label = hash AND IB_GRH_FLOWLABEL_MASK;
>>
>> I did an even quicker-and-dirtier test, with the attached. Both
>> the folding and non-folding methods display, to me, pretty much
>> the same behavior. And there's a fairly significant periodicity
>> with a doubling of the hash collision rate, every 8 or so buckets.
>>
>> The "folding" version has higher spikes at these points than the
>> non-folding, in fact. As you mentioned, there are a few more "zero"
>> hashes, but that's expected, and not that different for both.
>>
>> Assuming you agree with my C000-FFFF and 1-BFFF port ranges, there
>> are 800M possible permutations, and of course 1M hash buckets. So,
>> an 800:1 collision rate is expected. But the numbers range from
>> the mid-300's to several-1000's. That variance seems high to me.
>>
>> I really think there needs to be a flatter spectrum, here. These
>> collisions can cause significant congestion effects at scale. I
>> suggested trying a CRC-20 of the 32-bit src<<16|dst, but it's going
>> to take me a little time to find that.
>>
> 
> I did tests with range cma_sport [0xC000, 0xFFFF] and cma_dport [1025,
> 0xFFFF] (but each test with one dport), and found:
> 
> 1. The folding and non-folding results are similar;
> 2. When dport is multiple of 0x200 the result is very bad. I also tested
>      with your hashtest.c, there are much more "zero" hashes when sport or
>      dport is multiple of 0x200.
> 
> For the hash one of the original goal is symmetry, i.e.:
>       f(sport, dport) = f(dport, sport)

I'm very curious why this is a requirement. The hash is used to map
to a packet queue, which enforces ordering as well as providing a
congestion throttle point. These queues are one-way, and therefore
the same value has no effect when used symmetrically - it only works
one-way, the reverse flow is completely independent.

Am I missing something?

> If that's not important I feel "sport * 31 + dport" [1] has a better result.
> 
> [1] https://www.strchr.com/hash_functions

Well, that'd be simple!

Tom.
