Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6679F15BD49
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 12:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgBMLDv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 06:03:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38950 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbgBMLDv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Feb 2020 06:03:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so6108976wrt.6
        for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2020 03:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kg7/1Mc2/X7I/OxOgN7JrlU19iBoDb0PIJlZTQWiBXI=;
        b=AcIamtmAKIkPdrJ7RPjBwbIkzQx2rdWMSFQvCdIKyN3MxRKsQK+ZXzRmfrVe+Qvscv
         d8P0Ps8uMhKFcBaLCvc/I27cFli+CefdZL7upFq3bbkXYMa+zZ9u4kcVx2h4f4SaxrZH
         /mvKR5vbjGvzPhOo1KUO2hXPWtFFxyJ7CFGyfimLA8WcY4StkCoNERWfXARAaZIyYhHY
         Ueiuu+QNVZgk4wcqD3Mdeiyqy9DEXtcbps9zB7h5g1UGUuXEHNjJsvbmKccFoevTS6AK
         i+mS6nI0cOIeXOICRC9eTNaoUWYQl2PASo6lRe+sgg/whz7bbAeEodX4JRkUqxgbLN8S
         Olrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kg7/1Mc2/X7I/OxOgN7JrlU19iBoDb0PIJlZTQWiBXI=;
        b=Vbe0NzalI74/LCx6Bzn1tlXe0noPggI0GacYznEQXvd8PbMptenUJDyDXNddkIIDXs
         /1EZ6UrAUcgnZhLDPQQdxi+ENYehCIjC+Pd/VvslOwIDIjgG0vM8c3iNutS0+MEVVjOS
         snK9Y1Kq2rC9rdFkew0t+uDkxIFLFoA9VzH70dJ0IhuoIYSeAWErQ2vY1I8T4iwHaFwt
         H8M9Q8vsQAqSAE5MtbJam8tnmpQy+YGwvnpTqds6UzfNb7v1bjHlQS1mYoLsrWsCoMg+
         H0jXKKNQDRjya0o2IZHYwdFSkiE2E6kQBh+JGiOaX/2JhyuEYTQhh+JKt+jS1AN8g8Uk
         zzBw==
X-Gm-Message-State: APjAAAWeH+IwFrDepye7G2yjxUAV86m/rlynkSQGEOHGYsakrP/RQnkZ
        z4qVIOYGUA0gOqOLCfS31rD4yHqdvnnMx44ufVOpEGWZ7Ko=
X-Google-Smtp-Source: APXvYqzt2THI/xF1iS/taiVH9U29Dh1FCtn3dUr7QBCViwyjnFFQhN7dIHBzbeD5m05B/ZsSKmWDJzFAPgApiEnp3Mw=
X-Received: by 2002:a5d:498f:: with SMTP id r15mr20803508wrq.284.1581591828327;
 Thu, 13 Feb 2020 03:03:48 -0800 (PST)
MIME-Version: 1.0
References: <CAFgAxU8ArpoL9fMpJY5v-UZS5AMXom+TJ8HS57XeEOsCFFov8Q@mail.gmail.com>
 <63a56c06-57bf-6e31-6ca8-043f9d3b72f3@talpey.com> <CAFgAxU80+feEEtaRYFYTHwTMSE6Edjq0t0siJ0W06WSyD+Cy3A@mail.gmail.com>
 <b0414c43-c035-aa90-9f89-7ec6bba9e119@talpey.com> <CAFgAxU-LW+t17frRnNOYgoaqJEwffRPfFDasOPjbyVmuxj8AXA@mail.gmail.com>
 <09478db9-28ca-65fe-1424-b0229a514bbb@talpey.com>
In-Reply-To: <09478db9-28ca-65fe-1424-b0229a514bbb@talpey.com>
From:   Alex Rosenbaum <rosenbaumalex@gmail.com>
Date:   Thu, 13 Feb 2020 13:03:36 +0200
Message-ID: <CAFgAxU8XmoOheJ29s7r7J23V1x0QcagDgUDVGSyfKyaWSEzRzg@mail.gmail.com>
Subject: Re: [RFC v2] RoCE v2.0 Entropy - IPv6 Flow Label and UDP Source Port
To:     Tom Talpey <tom@talpey.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        "Alex @ Mellanox" <alexr@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Mark Zhang <markz@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 12, 2020 at 5:47 PM Tom Talpey <tom@talpey.com> wrote:
>
> On 2/8/2020 4:58 AM, Alex Rosenbaum wrote:
> > On Thu, Feb 6, 2020 at 5:19 PM Tom Talpey <tom@talpey.com> wrote:
> >>
> >> On 2/6/2020 9:39 AM, Alex Rosenbaum wrote:
> >>> On Thu, Feb 6, 2020 at 4:18 PM Tom Talpey <tom@talpey.com> wrote:
> >>>>
> >>>> On 1/8/2020 9:26 AM, Alex Rosenbaum wrote:
> >>>>> A combination of the flow_label field in the IPv6 header and UDP source port
> >>>>> field in RoCE v2.0 are used to identify a group of packets that must be
> >>>>> delivered in order by the network, end-to-end.
> >>>>> These fields are used to create entropy for network routers (ECMP), load
> >>>>> balancers and 802.3ad link aggregation switching that are not aware of RoCE IB
> >>>>> headers.
> >>>>>
> >>>>> The flow_label field is defined by a 20 bit hash value. CM based connections
> >>>>> will use a hash function definition based on the service type (QP Type) and
> >>>>> Service ID (SID). Where CM services are not used, the 20 bit hash will be
> >>>>> according to the source and destination QPN values.
> >>>>> Drivers will derive the RoCE v2.0 UDP src_port from the flow_label result.
> >>>>>
> >>>>> UDP source port selection must adhere IANA port allocation ranges. Thus we will
> >>>>> be using IANA recommendation for Ephemeral port range of: 49152-65535, or in
> >>>>> hex: 0xC000-0xFFFF.
> >>>>>
> >>>>> The below calculations take into account the importance of producing a symmetric
> >>>>> hash result so we can support symmetric hash calculation of network elements.
> >>>>>
> >>>>> Hash Calculation for RDMA IP CM Service
> >>>>> =======================================
> >>>>> For RDMA IP CM Services, based on QP1 iMAD usage and connected RC QPs using the
> >>>>> RDMA IP CM Service ID, the flow label will be calculated according to IBTA CM
> >>>>> REQ private data info and Service ID.
> >>>>>
> >>>>> Flow label hash function calculations definition will be defined as:
> >>>>> Extract the following fields from the CM IP REQ:
> >>>>>      CM_REQ.ServiceID.DstPort [2 Bytes]
> >>>>>      CM_REQ.PrivateData.SrcPort [2 Bytes]
> >>>>>      u32 hash = DstPort * SrcPort;
> >>>>>      hash ^= (hash >> 16);
> >>>>>      hash ^= (hash >> 8);
> >>>>>      AH_ATTR.GRH.flow_label = hash AND IB_GRH_FLOWLABEL_MASK;
> >>>>>
> >>>>>      #define IB_GRH_FLOWLABEL_MASK  0x000FFFFF
> >>>>
> >>>> Sorry it took me a while to respond to this, and thanks for looking
> >>>> into it since my comments on the previous proposal. I have a concern
> >>>> with an aspect of this one.
> >>>>
> >>>> The RoCEv2 destination port is a fixed value, 4791. Therefore the
> >>>> term
> >>>>
> >>>>           u32 hash = DstPort * SrcPort;
> >>>>
> >>>> adds no entropy beyond the value of SrcPort.
> >>>>
> >>>
> >>> we're talking about the CM service ports, taken from the
> >>> rdma_resolve_route(mca_id, <ip:SrcPort>, <ip:DstPort>, to_msec);
> >>> these are the CM level port-space and not the RoCE UDP L4 ports.
> >>> we want to use both as these will allow different client instance and
> >>> server instance on same nodes will use differen CM ports and hopefully
> >>> generate different hash results for multi-flows between these two
> >>> servers.
> >>
> >> Aha, ok I guess I missed that, and ok.
> >>
> >>>> In turn, the subsequent
> >>>>
> >>>>           hash ^= (hash >> 16);
> >>>>           hash ^= (hash >> 8);
> >>>>
> >>>> are re-mashing the bits with one another, again, adding no entropy.
> >>
> >> I still wonder about this one. It's attempting to reduce the 32-bit
> >> product to 20 bits, but a second xor with the "middle" 16 bits seems
> >> really strange. Mathematically, wouldn't it be better to just take
> >> the modulus of 2^20? If not, are you expecting some behavior in the
> >> hash values that makes the double-xor approach better (in which case
> >> it should be called out)?
> >>
> >> Tom.
> >
> > The function takes into account creating a symmetric hash, so both
> > active and passive can reconstruct the same flow label results. That's
> > why we multiply the two CM Port values (16 bit * 16 bit). The results
> > is a 32 bit value, and we don't want to lose any of of the MSB bit's
> > by modulus or masking. So we need some folding function from 32 bit to
> > the 20 bit flow label.
> >
> > The specific bit shift is something I took from the bond driver:
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/bonding/bond_main.c#L3407
> > This proved very good in spreading the flow label in our internal
> > testing. Other alternative can be suggested, as long as it considers
> > all bits in the conversion 32->20 bits.
>
> I'm ok with it, but I still don't fully understand why the folding
> is necessary. The multiplication is the important part, and it is
> the operation that combines the two entropic inputs. The folding just
> flips bits from what's basically the same entropy source.
>
> IOW, I think that
>
>         u32 hash = (DstPort * SrcPort) & IB_GRH_FLOWLABEL_MASK;
>
> would produce a completely equal benefit, mathematically.
> Tom.
>

If both src & dst ports are in the high value range you loss those
hash bits in the masking.
If src & dst port are both 0xE000, your masked hash equals 0. You'll
get the same hash if both ports are equal 0xF000.

The idea with the bit shift is to take the MSB hash bits (left from
the 0XFFFFF mask) and fold them with the LSB in some way.

Alex
