Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA1775FA43
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jul 2023 16:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjGXO5U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jul 2023 10:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGXO5T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jul 2023 10:57:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F8310C9
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jul 2023 07:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690210593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qyDhIAIIOkviYuugYW1Y2WwDIHyMCteZyLgKjPu6Mk8=;
        b=bLHOtEixW62mJrsbgtte/mDJCkb+34c3NJYiX19Jc21ABP/NmiQK7U/uWRT3xfnwZH/0mI
        2SzEvWoJD9zgdCHKZ9z7aW11VPXckxyvQ6aJj7fYunrrszQ4NMobg3DxfzkUjMF+AcDo3q
        oOsjrlh0BqU4/GaSiA+p4m85l9ZmoaA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-tQmyln17NtadvvM7MhvJ7w-1; Mon, 24 Jul 2023 10:56:32 -0400
X-MC-Unique: tQmyln17NtadvvM7MhvJ7w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-997c891a88dso368994966b.3
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jul 2023 07:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690210591; x=1690815391;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyDhIAIIOkviYuugYW1Y2WwDIHyMCteZyLgKjPu6Mk8=;
        b=SluZANEnJGMrUraGxJamQq3ZVqJJ3vb1EXoRYGVJEXk2udYge+L0AUz6TA5+e+H/KO
         sVdXkux+kmfDLpmCpNuwcJWstnEEHlC8T1bW53ivVHy6PHEGAojBP3zqlT+yFITq3ISe
         r6UhGt/5u2aP9vGjD/tWoobq9Sx/cQqVw2b3nJL6kaYeTlR0BnAH7kC9NTpramaeb+0L
         bc0ZB5GDKQjrP4tEsdl76nCoV3lNsnsRwZuIltzanhFU2Y49uj8b41ULRwcSfAphQy+W
         w8YFOwUsutA/S7Fyf0DlxkCqVHYni2wxHP75B66eiCI5Vq4+WZKkaJ5CGErwdg9hcV2g
         B+WA==
X-Gm-Message-State: ABy/qLY8ekaHVyGvOXHk92zCXwZuHM8bkqzZFV/5y5leudxuPo4J/lVq
        KPp5yBdU2fHrLqGo1RdDmsthCWCsWYksHIWdDpx+PNjuxER3bgUg/ehf2BuXSRxzXed9ZcB9KFK
        l3v6imNbbE9wWLc44ZYKOKg==
X-Received: by 2002:a17:906:142:b0:99b:4378:a5aa with SMTP id 2-20020a170906014200b0099b4378a5aamr10932493ejh.49.1690210590813;
        Mon, 24 Jul 2023 07:56:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGew8ZfxpMg1IPHgdW+P4N+fJj23+LIyZEInwx4n2Bho+JUbvzjjxmxPJwDcIJS99FXO2fHEg==
X-Received: by 2002:a17:906:142:b0:99b:4378:a5aa with SMTP id 2-20020a170906014200b0099b4378a5aamr10932446ejh.49.1690210590470;
        Mon, 24 Jul 2023 07:56:30 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id dt15-20020a170906b78f00b00991bba473e1sm6867427ejb.3.2023.07.24.07.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 07:56:29 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <a2569132-393e-0149-f76c-f6de282e1c96@redhat.com>
Date:   Mon, 24 Jul 2023 16:56:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Hari Ramakrishnan <rharix@google.com>,
        David Ahern <dsahern@kernel.org>,
        Samiullah Khawaja <skhawaja@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
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
        Jason Gunthorpe <jgg@ziepe.ca>
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
In-Reply-To: <CAHS8izNMB-H3w0CE9kj6hT5q_F6_XJy_X_HtZwmisOEDhp31yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 17/07/2023 03.53, Mina Almasry wrote:
> On Fri, Jul 14, 2023 at 8:55 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>> On Fri, Jul 14, 2023 at 07:55:15AM -0700, Mina Almasry wrote:
>>
>>> Once the skb frags with struct new_abstraction are in the TCP stack,
>>> they will need some special handling in code accessing the frags. But
>>> my RFC already addressed that somewhat because the frags were
>>> inaccessible in that case. In this case the frags will be both
>>> inaccessible and will not be struct pages at all (things like
>>> get_page() will not work), so more special handling will be required,
>>> maybe.
>>
>> It seems sort of reasonable, though there will be interesting concerns
>> about coherence and synchronization with generial purpose DMABUFs that
>> will need tackling.
>>
>> Still it is such a lot of churn and weridness in the netdev side, I
>> think you'd do well to present an actual full application as
>> justification.
>>
>> Yes, you showed you can stick unordered TCP data frags into GPU memory
>> sort of quickly, but have you gone further with this to actually show
>> it is useful for a real world GPU centric application?
>>
>> BTW your cover letter said 96% utilization, the usual server
>> configuation is one NIC per GPU, so you were able to hit 1500Gb/sec of
>> TCP BW with this?
>>
> 
> I do notice that the number of NICs is missing from our public
> documentation so far, so I will refrain from specifying how many NICs
> are on those A3 VMs until the information is public. But I think I can
> confirm that your general thinking is correct, the perf that we're
> getting is 96.6% line rate of each GPU/NIC pair, 

What do you mean by 96.6% "line rate".
Is is the Ethernet line-rate?

Is the measured throughput the measured TCP data "goodput"?
Assuming
  - MTU 1500 bytes (1514 on wire).
  - Ethernet header 14 bytes
  - IP header 20 bytes
  - TCP header 20 bytes

Due to header overhead the goodput will be approx 96.4%.
  - (1514-(14+20+20))/1514 = 0.9643
  - (Not taking Ethernet interframe gap into account).

Thus, maybe you have hit Ethernet wire line-rate already?

> and scales linearly
> for each NIC/GPU pair we've tested with so far. Line rate of each
> NIC/GPU pair is 200 Gb/sec.
> 
> So if we have 8 NIC/GPU pairs we'd be hitting 96.6% * 200 * 8 = 1545 GB/sec.

Lets keep our units straight.
Here you mean 1545 Gbit/sec, which is 193 GBytes/s

> If we have, say, 2 NIC/GPU pairs, we'd be hitting 96.6% * 200 * 2 = 384 GB/sec

Here you mean 384 Gbit/sec, which is 48 GBytes/sec.

> ...
> etc.
> 

These massive throughput numbers are important, because they *exceed*
the physical host RAM/DIMM memory speeds.

This is the *real argument* why software cannot afford to do a single
copy of the data from host-RAM into GPU-memory, because the CPU memory
throughput to DRAM/DIMM are insufficient.

My testlab CPU E5-1650 have 4 DIMM slots DDR4
  - Data Width: 64 bits (= 8 bytes)
  - Configured Memory Speed: 2400 MT/s
  - Theoretical maximum memory bandwidth: 76.8 GBytes/s (2400*8*4)

Even the theoretical max 76.8 GBytes/s (614 Gbit/s) is not enough for
the 193 GBytes/s or 1545 Gbit/s (8 NIC/GPU pairs).

When testing this with lmbench tool bw_mem, the results (below
signature) are in the area 14.8 GBytes/sec (118 Gbit/s), as soon as
exceeding L3 cache size.  In practice it looks like main memory is
limited to reading 118 Gbit/s *once*. (Mina's NICs run at 200 Gbit/s)

Given DDIO can deliver network packets into L3, I also tried to figure
out what the L3 read bandwidth, which I measured to be 42.4 GBits/sec
(339 Gbit/s), in hopes that it would be enough, but it was not.


--Jesper
(data below signature)

CPU under test:

  $ cat /proc/cpuinfo | egrep -e 'model name|cache size' | head -2
  model name	: Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz
  cache size	: 15360 KB


Providing some cmdline outputs from lmbench "bw_mem" tool.
(Output format is "%0.2f %.2f\n", megabytes, megabytes_per_second)

$ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 256M rd
256.00 14924.50

$ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 256M wr
256.00 9895.25

$ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 256M rdwr
256.00 9737.54

$ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 256M bcopy
256.00 12462.88

$ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 256M bzero
256.00 14869.89


Next output shows reducing size below L3 cache size, which shows an
increase in speed, likely the L3 bandwidth.

$ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 64M rd
64.00 14840.58

$ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 32M rd
32.00 14823.97

$ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 16M rd
16.00 24743.86

$ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 8M rd
8.00 40852.26

$ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 4M rd
4.00 42545.65

$ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 2M rd
2.00 42447.82

$ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 1M rd
1.00 42447.82

