Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5A07606FA
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 06:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjGYEEk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 00:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjGYEEi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 00:04:38 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D810118
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jul 2023 21:04:36 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-79a41b1bccfso47694241.0
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jul 2023 21:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690257875; x=1690862675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWdSnIWQun0ashRbVT0OVUHEFVk8YYt5YaTXkv+Xkhc=;
        b=uq3iusBbqJPc2CTRePG/0p4dDkjSLOvhrrfGgfOLYLE2ZyESAHXdxhgqjslHldiAD6
         KLS/+wOLV71DZZb66aAvhvUbMCL1h01kRKYqujKDJeqnbLgjKMuBP1hmu/ZpXTG5oEUY
         v+nnlclvWIOsOSs1i6/Qvgamieqnw6PyyfWKkqnuxKkZNGk8te+LsMcTcwd7Slkyut33
         U39fhEDDpT7VIRm7piZhgyZZjgVbgjwCyc+h7gaudDhk84zIddYfWkC/cKc2oYL8VFuu
         Q4qw8p47aAlVu+L+Nc0nxK0ZpOisK99ykmC1j5w4fVigBs13/OxIKhF4VB+7i+Pjo23Z
         gJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690257875; x=1690862675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWdSnIWQun0ashRbVT0OVUHEFVk8YYt5YaTXkv+Xkhc=;
        b=fTyuIf3cUZMeMC0vkpa1zTEiuRYav+Bggz6pIOFpfvcSjHUvDqM2bUkYgPovn4wCXD
         N8BvqzVZrbjKYCPhS74cj4/Y6abFg7y5gHGRyKS5c5ARbZxW3CtFmejBhepuEEvXuj5R
         KIvRLLegJ/SQbP87rtLjZC1IcVmMbHDcTdYA8WpXBDcdhFJfc2KnSc1jWWEkK92QmsUo
         21kiTiTvN/+R1VJgaocToYvsh3cs2g+9B4SokAoe8+5/JIqrBPRnSGUbDRmyVJ99HdK8
         CM4FmQXbUOeVs5U2TM1lsxH2n/taNMFomZCSAENlXT8H2OTPwbxAjMPsRz49cD5R5i7r
         b4gg==
X-Gm-Message-State: ABy/qLYffi5mTAMiH7qxbjcG5RgduiwHugxanfAcJf9GKHwWsjuecyIU
        mvQsi8KC/c+coISnSPtbr17vWjUpsyfsi+FTv5F3cg==
X-Google-Smtp-Source: APBJJlH/rW02PNpLqFVAY3arLeMZJp58yKGRcc9g2NPQgHNQe1NBThAjBeX+q2qlifKktq+mF/RhIhIg5OW6qVs6rHo=
X-Received: by 2002:a67:cf43:0:b0:443:7e93:641f with SMTP id
 f3-20020a67cf43000000b004437e93641fmr3945436vsm.9.1690257875137; Mon, 24 Jul
 2023 21:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
 <20230711093224.1bf30ed5@kernel.org> <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
 <20230711133915.03482fdc@kernel.org> <2263ae79-690e-8a4d-fca2-31aacc5c9bc6@kernel.org>
 <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
 <ZK6kOBl4EgyYPtaD@ziepe.ca> <CAHS8izNuda2DXKTFAov64F7J2_BbMPaqJg1NuMpWpqGA20+S_Q@mail.gmail.com>
 <143a7ca4-e695-db98-9488-84cf8b78cf86@amd.com> <CAHS8izPm6XRS54LdCDZVd0C75tA1zHSu6jLVO8nzTLXCc=H7Nw@mail.gmail.com>
 <ZLFv2PIgdeH8gKmh@ziepe.ca> <CAHS8izNMB-H3w0CE9kj6hT5q_F6_XJy_X_HtZwmisOEDhp31yg@mail.gmail.com>
 <a2569132-393e-0149-f76c-f6de282e1c96@redhat.com>
In-Reply-To: <a2569132-393e-0149-f76c-f6de282e1c96@redhat.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 24 Jul 2023 21:04:23 -0700
Message-ID: <CAHS8izP5DiHy9NpeMKM4QpXwmx0rw+7oavfQfQsbtiWz10MhOw@mail.gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, brouer@redhat.com,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 24, 2023 at 7:56=E2=80=AFAM Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:
>
>
>
> On 17/07/2023 03.53, Mina Almasry wrote:
> > On Fri, Jul 14, 2023 at 8:55=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> >>
> >> On Fri, Jul 14, 2023 at 07:55:15AM -0700, Mina Almasry wrote:
> >>
> >>> Once the skb frags with struct new_abstraction are in the TCP stack,
> >>> they will need some special handling in code accessing the frags. But
> >>> my RFC already addressed that somewhat because the frags were
> >>> inaccessible in that case. In this case the frags will be both
> >>> inaccessible and will not be struct pages at all (things like
> >>> get_page() will not work), so more special handling will be required,
> >>> maybe.
> >>
> >> It seems sort of reasonable, though there will be interesting concerns
> >> about coherence and synchronization with generial purpose DMABUFs that
> >> will need tackling.
> >>
> >> Still it is such a lot of churn and weridness in the netdev side, I
> >> think you'd do well to present an actual full application as
> >> justification.
> >>
> >> Yes, you showed you can stick unordered TCP data frags into GPU memory
> >> sort of quickly, but have you gone further with this to actually show
> >> it is useful for a real world GPU centric application?
> >>
> >> BTW your cover letter said 96% utilization, the usual server
> >> configuation is one NIC per GPU, so you were able to hit 1500Gb/sec of
> >> TCP BW with this?
> >>
> >
> > I do notice that the number of NICs is missing from our public
> > documentation so far, so I will refrain from specifying how many NICs
> > are on those A3 VMs until the information is public. But I think I can
> > confirm that your general thinking is correct, the perf that we're
> > getting is 96.6% line rate of each GPU/NIC pair,
>
> What do you mean by 96.6% "line rate".
> Is is the Ethernet line-rate?
>

Yes I believe this is the ethernet line-rate. I.e. the 200 Gbits/sec
that my NICs run.

> Is the measured throughput the measured TCP data "goodput"?

Yes, it is goodput. Roughly I believe we add up the return values of
recvmsg() and divide that number by time (very roughly, I think).

> Assuming
>   - MTU 1500 bytes (1514 on wire).
>   - Ethernet header 14 bytes
>   - IP header 20 bytes
>   - TCP header 20 bytes
>
> Due to header overhead the goodput will be approx 96.4%.
>   - (1514-(14+20+20))/1514 =3D 0.9643
>   - (Not taking Ethernet interframe gap into account).
>
> Thus, maybe you have hit Ethernet wire line-rate already?

My MTU is 8244 actually, which gives me 8192 mss/payload for my
connections. By my math the theoretical max would be 1 - 52/8244 =3D
~99.3%. So it looks like I'm dropping ~3% line rate somewhere in the
implementation.

>
> > and scales linearly
> > for each NIC/GPU pair we've tested with so far. Line rate of each
> > NIC/GPU pair is 200 Gb/sec.
> >
> > So if we have 8 NIC/GPU pairs we'd be hitting 96.6% * 200 * 8 =3D 1545 =
GB/sec.
>
> Lets keep our units straight.
> Here you mean 1545 Gbit/sec, which is 193 GBytes/s
>

Yes! Sorry! I definitely meant 1545 Gbits/sec, sorry!

> > If we have, say, 2 NIC/GPU pairs, we'd be hitting 96.6% * 200 * 2 =3D 3=
84 GB/sec
>
> Here you mean 384 Gbit/sec, which is 48 GBytes/sec.
>

Correct again!

> > ...
> > etc.
> >
>
> These massive throughput numbers are important, because they *exceed*
> the physical host RAM/DIMM memory speeds.
>
> This is the *real argument* why software cannot afford to do a single
> copy of the data from host-RAM into GPU-memory, because the CPU memory
> throughput to DRAM/DIMM are insufficient.
>
> My testlab CPU E5-1650 have 4 DIMM slots DDR4
>   - Data Width: 64 bits (=3D 8 bytes)
>   - Configured Memory Speed: 2400 MT/s
>   - Theoretical maximum memory bandwidth: 76.8 GBytes/s (2400*8*4)
>
> Even the theoretical max 76.8 GBytes/s (614 Gbit/s) is not enough for
> the 193 GBytes/s or 1545 Gbit/s (8 NIC/GPU pairs).
>
> When testing this with lmbench tool bw_mem, the results (below
> signature) are in the area 14.8 GBytes/sec (118 Gbit/s), as soon as
> exceeding L3 cache size.  In practice it looks like main memory is
> limited to reading 118 Gbit/s *once*. (Mina's NICs run at 200 Gbit/s)
>
> Given DDIO can deliver network packets into L3, I also tried to figure
> out what the L3 read bandwidth, which I measured to be 42.4 GBits/sec
> (339 Gbit/s), in hopes that it would be enough, but it was not.
>
>

Yes, avoiding any memory speed bottleneck as you note is important,
but the second point mentioned in my cover letter is also impactful:

" Alleviate PCIe BW pressure, by limiting data transfer to the lowest level
  of the PCIe tree, compared to traditional path which sends data through t=
he
  root complex."

Depending on the hardware, this is a bottleneck that we avoid with
device memory TCP. NIC/GPU copies occupy the PCIe link bandwidth. In a
hierarchy like this:

          root complex
                  | (uplink)
          PCIe switch
           /             \
       NIC           GPU

I believe the uplink from the PCIe switch to the root complex is used
up 2 times for TX and 2 times for RX if the data needs to go through
host memory:

RX: NIC -> root complex -> GPU
TX: GPU -> root complex -> NIC

With device memory TCP, and enabling PCI P2P communication between the
devices under the same PCIe switch, the payload flows directly from/to
the NIC/GPU through the PCIe switch, and the payload never goes to the
root complex, alleviating pressure/bottleneck on that link between the
PCIe switch/root complex. I believe this is a core reason we're able
to scale throughput linearly with NIC/GPU pairs, because we don't
stress share uplink connections and all the payload data transfer
happens beneath the PCIe switch.

> --Jesper
> (data below signature)
>
> CPU under test:
>
>   $ cat /proc/cpuinfo | egrep -e 'model name|cache size' | head -2
>   model name    : Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz
>   cache size    : 15360 KB
>
>
> Providing some cmdline outputs from lmbench "bw_mem" tool.
> (Output format is "%0.2f %.2f\n", megabytes, megabytes_per_second)
>
> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 256M rd
> 256.00 14924.50
>
> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 256M wr
> 256.00 9895.25
>
> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 256M rdwr
> 256.00 9737.54
>
> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 256M bcopy
> 256.00 12462.88
>
> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 256M bzero
> 256.00 14869.89
>
>
> Next output shows reducing size below L3 cache size, which shows an
> increase in speed, likely the L3 bandwidth.
>
> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 64M rd
> 64.00 14840.58
>
> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 32M rd
> 32.00 14823.97
>
> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 16M rd
> 16.00 24743.86
>
> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 8M rd
> 8.00 40852.26
>
> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 4M rd
> 4.00 42545.65
>
> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 2M rd
> 2.00 42447.82
>
> $ taskset -c 2 /usr/lib/lmbench/bin/x86_64-linux-gnu/bw_mem 1M rd
> 1.00 42447.82
>


--=20
Thanks,
Mina
