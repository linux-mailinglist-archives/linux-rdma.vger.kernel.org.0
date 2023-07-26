Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757ED763DC9
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jul 2023 19:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjGZRhO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jul 2023 13:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjGZRhN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jul 2023 13:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03702685
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690392981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/f5ZYK6Qdq6oPQFm6eVsYofjkfhjCCfthHwtoz2obRA=;
        b=bCpQvkToFj2rb0ad8E5MXXP7YsHTU+KqyNnDP1xhGo2s8O0rDZW8/+Tzq2QcyarHLi8VZR
        IHONbTzBoLz5XVd6M7Nd50Wb7JegGEczW8P2cqXb71xlhYaV+91BkOxvB3AIWFguOyH71m
        9Oairi+wcXdhUe6hvj6QBEzXM8Fg3Xk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-_yuTCx6xOGCI26Pzt24PLg-1; Wed, 26 Jul 2023 13:36:20 -0400
X-MC-Unique: _yuTCx6xOGCI26Pzt24PLg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b70c44b5fdso66184811fa.1
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 10:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690392979; x=1690997779;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/f5ZYK6Qdq6oPQFm6eVsYofjkfhjCCfthHwtoz2obRA=;
        b=fSzsaxZvwv1Zs0t3RYNAd40yhfQhceAWp9ARpTU8eHkKFu5KFqJ6Aeodv8SJGXuXrS
         DLQFQBGlfxqv+IYL9DYa191eaLW/PRuAbuTs2HF5bdMuU4yOHA5PFXV7hlemd+PPChGH
         FswqRZfZsin/dw/pzAGC50oPiHS3UMdj1N35Of5ehk1sw1fHYwWWrhrY5bIkfusT/6A6
         fZzAsHkwMiHuzi69owc9yHDQ3Lw6RTMPLqBYx9dR0hVlWmFnAss0xBlTSr50QbhvwBHt
         xv6ElM3JZEntS+yWt3YfvYuTDa6YdKVJvavYiMGSSbBCsVPeauYHMFgJL9UqPg1twzOw
         H/Qg==
X-Gm-Message-State: ABy/qLaaawubx3gTtPFi4Z/O6dd6Bpqye1iJULlGIU3wMEWgZ60Fd93q
        HA7a58gJcjIxc6MtnUfDHGFTel9Y8YtKNRNsU4rQUPs3QAy74VFKiD3YN2halxI/3AlGz8K9wmK
        RScTOsNWFOkevozSZw941Cw==
X-Received: by 2002:ac2:5f48:0:b0:4fb:820a:f87f with SMTP id 8-20020ac25f48000000b004fb820af87fmr1883735lfz.10.1690392979040;
        Wed, 26 Jul 2023 10:36:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEhQEgRdGA3gSirOGkFIMDdgPxdsFypQuLsH5xgM0N2RktG6NRLxv6T8Whuei4QCRMKkbvEEw==
X-Received: by 2002:ac2:5f48:0:b0:4fb:820a:f87f with SMTP id 8-20020ac25f48000000b004fb820af87fmr1883677lfz.10.1690392978507;
        Wed, 26 Jul 2023 10:36:18 -0700 (PDT)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id f3-20020ac251a3000000b004fba759bf3asm3406979lfk.281.2023.07.26.10.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 10:36:17 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <5cb84d01-d5fa-76fa-4bd4-ce331784ad5b@redhat.com>
Date:   Wed, 26 Jul 2023 19:36:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com, Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Hari Ramakrishnan <rharix@google.com>,
        David Ahern <dsahern@kernel.org>,
        Samiullah Khawaja <skhawaja@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Jonathan Lemon <jonathan.lemon@gmail.com>, logang@deltatee.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
 <20230711093224.1bf30ed5@kernel.org>
 <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
 <20230711133915.03482fdc@kernel.org>
 <2263ae79-690e-8a4d-fca2-31aacc5c9bc6@kernel.org>
 <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
 <ZK6kOBl4EgyYPtaD@ziepe.ca>
 <CAHS8izNuda2DXKTFAov64F7J2_BbMPaqJg1NuMpWpqGA20+S_Q@mail.gmail.com>
 <143a7ca4-e695-db98-9488-84cf8b78cf86@amd.com>
 <CAHS8izPm6XRS54LdCDZVd0C75tA1zHSu6jLVO8nzTLXCc=H7Nw@mail.gmail.com>
 <ZLFv2PIgdeH8gKmh@ziepe.ca>
 <CAHS8izNMB-H3w0CE9kj6hT5q_F6_XJy_X_HtZwmisOEDhp31yg@mail.gmail.com>
 <a2569132-393e-0149-f76c-f6de282e1c96@redhat.com>
 <CAHS8izP5DiHy9NpeMKM4QpXwmx0rw+7oavfQfQsbtiWz10MhOw@mail.gmail.com>
In-Reply-To: <CAHS8izP5DiHy9NpeMKM4QpXwmx0rw+7oavfQfQsbtiWz10MhOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 25/07/2023 06.04, Mina Almasry wrote:
> On Mon, Jul 24, 2023 at 7:56 AM Jesper Dangaard Brouer
> <jbrouer@redhat.com> wrote:
>>
>>
>>
>> On 17/07/2023 03.53, Mina Almasry wrote:
>>> On Fri, Jul 14, 2023 at 8:55 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>>
>>>> On Fri, Jul 14, 2023 at 07:55:15AM -0700, Mina Almasry wrote:
>>>>
>>>>> Once the skb frags with struct new_abstraction are in the TCP stack,
>>>>> they will need some special handling in code accessing the frags. But
>>>>> my RFC already addressed that somewhat because the frags were
>>>>> inaccessible in that case. In this case the frags will be both
>>>>> inaccessible and will not be struct pages at all (things like
>>>>> get_page() will not work), so more special handling will be required,
>>>>> maybe.
>>>>
>>>> It seems sort of reasonable, though there will be interesting concerns
>>>> about coherence and synchronization with generial purpose DMABUFs that
>>>> will need tackling.
>>>>
>>>> Still it is such a lot of churn and weridness in the netdev side, I
>>>> think you'd do well to present an actual full application as
>>>> justification.
>>>>
>>>> Yes, you showed you can stick unordered TCP data frags into GPU memory
>>>> sort of quickly, but have you gone further with this to actually show
>>>> it is useful for a real world GPU centric application?
>>>>
>>>> BTW your cover letter said 96% utilization, the usual server
>>>> configuation is one NIC per GPU, so you were able to hit 1500Gb/sec of
>>>> TCP BW with this?
>>>>
>>>
>>> I do notice that the number of NICs is missing from our public
>>> documentation so far, so I will refrain from specifying how many NICs
>>> are on those A3 VMs until the information is public. But I think I can
>>> confirm that your general thinking is correct, the perf that we're
>>> getting is 96.6% line rate of each GPU/NIC pair,
>>
>> What do you mean by 96.6% "line rate".
>> Is is the Ethernet line-rate?
>>
> 
> Yes I believe this is the ethernet line-rate. I.e. the 200 Gbits/sec
> that my NICs run.
> 
>> Is the measured throughput the measured TCP data "goodput"?
> 
> Yes, it is goodput. Roughly I believe we add up the return values of
> recvmsg() and divide that number by time (very roughly, I think).
> 
>> Assuming
>>    - MTU 1500 bytes (1514 on wire).
>>    - Ethernet header 14 bytes
>>    - IP header 20 bytes
>>    - TCP header 20 bytes
>>
>> Due to header overhead the goodput will be approx 96.4%.
>>    - (1514-(14+20+20))/1514 = 0.9643
>>    - (Not taking Ethernet interframe gap into account).
>>
>> Thus, maybe you have hit Ethernet wire line-rate already?
> 
> My MTU is 8244 actually, which gives me 8192 mss/payload for my
> connections. By my math the theoretical max would be 1 - 52/8244 =
> ~99.3%. So it looks like I'm dropping ~3% line rate somewhere in the
> implementation.
> 

Close enough, my math I would have added the 4 byte FCS checksum
(1-56/8244), but it makes no real difference at MTU 8244.


>>
>>> and scales linearly
>>> for each NIC/GPU pair we've tested with so far. Line rate of each
>>> NIC/GPU pair is 200 Gb/sec.
>>>
>>> So if we have 8 NIC/GPU pairs we'd be hitting 96.6% * 200 * 8 = 1545 GB/sec.
>>
>> Lets keep our units straight.
>> Here you mean 1545 Gbit/sec, which is 193 GBytes/s
>>
> 
> Yes! Sorry! I definitely meant 1545 Gbits/sec, sorry!
> 
>>> If we have, say, 2 NIC/GPU pairs, we'd be hitting 96.6% * 200 * 2 = 384 GB/sec
>>
>> Here you mean 384 Gbit/sec, which is 48 GBytes/sec.
>>
> 
> Correct again!
> 
>>> ...
>>> etc.
>>>
>>
>> These massive throughput numbers are important, because they *exceed*
>> the physical host RAM/DIMM memory speeds.
>>
>> This is the *real argument* why software cannot afford to do a single
>> copy of the data from host-RAM into GPU-memory, because the CPU memory
>> throughput to DRAM/DIMM are insufficient.
>>
>> My testlab CPU E5-1650 have 4 DIMM slots DDR4
>>    - Data Width: 64 bits (= 8 bytes)
>>    - Configured Memory Speed: 2400 MT/s
>>    - Theoretical maximum memory bandwidth: 76.8 GBytes/s (2400*8*4)
>>
>> Even the theoretical max 76.8 GBytes/s (614 Gbit/s) is not enough for
>> the 193 GBytes/s or 1545 Gbit/s (8 NIC/GPU pairs).
>>
>> When testing this with lmbench tool bw_mem, the results (below
>> signature) are in the area 14.8 GBytes/sec (118 Gbit/s), as soon as
>> exceeding L3 cache size.  In practice it looks like main memory is
>> limited to reading 118 Gbit/s *once*. (Mina's NICs run at 200 Gbit/s)
>>

Some more insights.  I couldn't believe this (single CPU) test was so
far from the theoretical max (76.8 vs. 14.8 GBytes/s).
This smells like a per CPU core limitation. The lmbench tool bw_mem have
an option for parallelism (-P) for testing this.
My testlab CPU only have 6 cores (as I have disabled HT).

Testing on more CPU cores show an increase in scaling mem bandwidth:

  Cores 1 = 15.0 GB/s - scale: 1.00 (one core as scale point)
  Cores 2 = 26.9 GB/s - scale: 1.79
  Cores 3 = 36.3 GB/s - scale: 2.42
  Cores 4 = 44.0 GB/s - scale: 2.93
  Cores 5 = 48.9 GB/s - scale: 3.26
  Cores 6 = 49.4 GB/s - scale: 3.29

Thus, the practical test show CPU memory DIMM read bandwidth scales to
49.4 GB/s (395.2 Gbit/s), so there is still hope of 400Gbit/s devices,
when utilizing more CPU cores.

I don't have a clear explanation why there is a limit per core.

The [toplev] tool with (bw_mem -P2) says:
  Backend_Bound = 90.7% of the time.
  Backend_Bound.Memory_Bound = 71.8% of these 90.7%
  Backend_Bound.Core_Bound = remaining 18.9%

Backend_Bound.Memory_Bound is split into two main "stalls":
  Backend_Bound.Memory_Bound.L3_Bound = 7.9%
  Backend_Bound.Memory_Bound.DRAM_Bound = 58.5%

[toplev] https://github.com/andikleen/pmu-tools

>> Given DDIO can deliver network packets into L3, I also tried to figure
>> out what the L3 read bandwidth, which I measured to be 42.4 GBits/sec
>> (339 Gbit/s), in hopes that it would be enough, but it was not.
>>

The memory bandwidth to L3 cache scales up per CPU core:

  Cores 1 =  42.35 GB/s = scale: 1.00 (one core as scale point)
  Cores 2 =  86.38 GB/s = scale: 2.04
  Cores 3 = 126.96 GB/s = scale: 3.00
  Cores 4 = 168.48 GB/s = scale: 3.98
  Cores 5 = 211.77 GB/s = scale: 5.00
  Cores 6 = 244.95 GB/s = scale: 5.78

Nice to see how well this scales up per core.
Fairly impressive total max L3 bandwidth of 244.95 GB/s (1959.6 Gbit/s).

>>
> 
> Yes, avoiding any memory speed bottleneck as you note is important,
> but the second point mentioned in my cover letter is also impactful:
> 
> " Alleviate PCIe BW pressure, by limiting data transfer to the lowest level
>    of the PCIe tree, compared to traditional path which sends data through the
>    root complex."
> 

This is a good and important point.

> Depending on the hardware, this is a bottleneck that we avoid with
> device memory TCP. NIC/GPU copies occupy the PCIe link bandwidth. In a
> hierarchy like this:
> 
>            root complex
>                    | (uplink)
>            PCIe switch
>             /             \
>         NIC           GPU
> 
> I believe the uplink from the PCIe switch to the root complex is used
> up 2 times for TX and 2 times for RX if the data needs to go through
> host memory:
> 
> RX: NIC -> root complex -> GPU
> TX: GPU -> root complex -> NIC
> 
> With device memory TCP, and enabling PCI P2P communication between the
> devices under the same PCIe switch, the payload flows directly from/to
> the NIC/GPU through the PCIe switch, and the payload never goes to the
> root complex, alleviating pressure/bottleneck on that link between the
> PCIe switch/root complex. I believe this is a core reason we're able
> to scale throughput linearly with NIC/GPU pairs, because we don't
> stress share uplink connections and all the payload data transfer
> happens beneath the PCIe switch.
> 

Good points, and I guess this is what Jason was hinting to.
And illustrated in this picture[1] (I googled):

  [1] 
https://www.servethehome.com/wp-content/uploads/2022/08/HC34-NVIDIA-DGX-H100-Data-network-configuration.jpg

The GPUs "internally" have switched nvlink connections. As Jason said,
these nvlinks have an impressive bandwidth[2] of 900GB/s (7200 Gbit/s).

  [2] https://www.nvidia.com/en-us/data-center/nvlink/

>> --Jesper
>> (data below signature)
>>

Added raw commands and data below.

>> CPU under test:
>>
>>    $ cat /proc/cpuinfo | egrep -e 'model name|cache size' | head -2
>>    model name    : Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz
>>    cache size    : 15360 KB
>>
>>
>> Providing some cmdline outputs from lmbench "bw_mem" tool.
>> (Output format is "%0.2f %.2f\n", megabytes, megabytes_per_second)
>>

Running bw_mem with parallelism utilizing more cores:

$ /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem -W2 -N4 -P1 256m rd
268.44 15015.69

$ /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem -W2 -N4 -P2 256m rd
268.44 26896.42

$ /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem -W2 -N4 -P3 256m rd
268.44 36347.36

$ /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem -W2 -N4 -P4 256m rd
268.44 44073.72

$ /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem -W2 -N4 -P5 256m rd
268.44 48872.02

$ /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem -W2 -N4 -P6 256m rd
268.44 49426.76



>> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 256M rd
>> 256.00 14924.50
>>
>> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 256M wr
>> 256.00 9895.25
>>
>> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 256M rdwr
>> 256.00 9737.54
>>
>> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 256M bcopy
>> 256.00 12462.88
>>
>> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 256M bzero
>> 256.00 14869.89
>>
>>
>> Next output shows reducing size below L3 cache size, which shows an
>> increase in speed, likely the L3 bandwidth.
>>
>> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 64M rd
>> 64.00 14840.58
>>
>> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 32M rd
>> 32.00 14823.97
>>
>> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 16M rd
>> 16.00 24743.86
>>
>> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 8M rd
>> 8.00 40852.26
>>
>> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 4M rd
>> 4.00 42545.65
>>
>> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 2M rd
>> 2.00 42447.82
>>
>> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 1M rd
>> 1.00 42447.82
>>
> 

Tests for testing L3 per core scaling.

$ taskset -c 0   /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem -W2 -N4 
-P1  512K rd
0.512000 42357.43

$ taskset -c 0-1 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem -W2 -N4 
-P2  512K rd
0.512000 86380.09

$ taskset -c 0-2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem -W2 -N4 
-P3  512K rd
0.512000 126960.94

$ taskset -c 0-3 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem -W2 -N4 
-P4  512K rd
0.512000 168485.49

$ taskset -c 0-4 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem -W2 -N4 
-P5  512K rd
0.512000 211770.67

$ taskset -c 0-5 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem -W2 -N4 
-P6  512K rd
0.512000 244959.35

