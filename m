Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93FCA1563B6
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2020 10:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgBHJ6y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Feb 2020 04:58:54 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:37446 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgBHJ6y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 8 Feb 2020 04:58:54 -0500
Received: by mail-wm1-f42.google.com with SMTP id f129so5336398wmf.2
        for <linux-rdma@vger.kernel.org>; Sat, 08 Feb 2020 01:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0SNz3xOFOw70jH0YqsiRt3NYGtppX0XjI4mIazVeGbQ=;
        b=oc9UeVuQCulOhWwpT2JJwJDSm/lcgejy6LSnYBpxsHu7WCKjznB/B2jcUsUvxW1oqx
         Yj6qwO4whzsudt7C11K6Y+1EgJrx6RnaBeOSfcCi031dVqFHdfNmTqnQyVfoqwEunrMD
         FmqdiisFu7VPYwVFGlJVSKSrXUU3RIti6VHJ7e/+eO8jQ31i9nu45GcSe/+sCo5hF6U5
         sXJyoLhFpEac6lDhgwb3BcJTroq/GmPVWHtBY7v/UjbPsGLaWFE71rg6dXh/fqCkM12N
         jSNYqPfJ+5ZBHfrvLIoPrDjMRf29y/pKXSo0vMeW2EMzbE2oHn4na6Gqo+fBqKD+N7VN
         Ra4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0SNz3xOFOw70jH0YqsiRt3NYGtppX0XjI4mIazVeGbQ=;
        b=D0alfiQ4kyu4tVQzGDP+LQx6uPArGVXp35ub3bUEVIQi5CZ7d2s/P4xk+fI5DBJgP6
         c6Oz/7ueuHT0Q8eWpXVdwtngJCgKRxzaFgVi5BifNRWfEs0NzHp4SfbtSJYWsX7I7Gpp
         iOiVsQKSBbGiogTFsdW1l1z4iJcx/cLGlWc/eKzraYxkuxXZmfv40gPUAGV7Yjo1oiiW
         eJHBD1YwHdymf59LJspSzq1ZKMeW4fipon5bN/9iKFjgkIzqB3TLCQeozTT9MMySJO6J
         v+JD4TlGQMpH572WWfdsAsiz//c64ePboVeabbsxCLqO1ON2WGEKQSUEzt6S94myYl8c
         VgvA==
X-Gm-Message-State: APjAAAVZVAWNPyJYt4lBTzUGolHxqxegnvPyvOBXaOrFIPNPhUJe5H5v
        cA91NyPW5kj4jd83nOfaf6rjY5qtHaEuB5fdb4krN0yShMw=
X-Google-Smtp-Source: APXvYqwZF0RF/ckzQ/nBHIfKSRtcHivlzkVYY8hCI+ZFTp3JjeW9HX5ODcJXblm2IUtOJtg/8kp52GjFMccfuijob6k=
X-Received: by 2002:a1c:610a:: with SMTP id v10mr3738749wmb.44.1581155931512;
 Sat, 08 Feb 2020 01:58:51 -0800 (PST)
MIME-Version: 1.0
References: <CAFgAxU8ArpoL9fMpJY5v-UZS5AMXom+TJ8HS57XeEOsCFFov8Q@mail.gmail.com>
 <63a56c06-57bf-6e31-6ca8-043f9d3b72f3@talpey.com> <CAFgAxU80+feEEtaRYFYTHwTMSE6Edjq0t0siJ0W06WSyD+Cy3A@mail.gmail.com>
 <b0414c43-c035-aa90-9f89-7ec6bba9e119@talpey.com>
In-Reply-To: <b0414c43-c035-aa90-9f89-7ec6bba9e119@talpey.com>
From:   Alex Rosenbaum <rosenbaumalex@gmail.com>
Date:   Sat, 8 Feb 2020 11:58:38 +0200
Message-ID: <CAFgAxU-LW+t17frRnNOYgoaqJEwffRPfFDasOPjbyVmuxj8AXA@mail.gmail.com>
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

On Thu, Feb 6, 2020 at 5:19 PM Tom Talpey <tom@talpey.com> wrote:
>
> On 2/6/2020 9:39 AM, Alex Rosenbaum wrote:
> > On Thu, Feb 6, 2020 at 4:18 PM Tom Talpey <tom@talpey.com> wrote:
> >>
> >> On 1/8/2020 9:26 AM, Alex Rosenbaum wrote:
> >>> A combination of the flow_label field in the IPv6 header and UDP source port
> >>> field in RoCE v2.0 are used to identify a group of packets that must be
> >>> delivered in order by the network, end-to-end.
> >>> These fields are used to create entropy for network routers (ECMP), load
> >>> balancers and 802.3ad link aggregation switching that are not aware of RoCE IB
> >>> headers.
> >>>
> >>> The flow_label field is defined by a 20 bit hash value. CM based connections
> >>> will use a hash function definition based on the service type (QP Type) and
> >>> Service ID (SID). Where CM services are not used, the 20 bit hash will be
> >>> according to the source and destination QPN values.
> >>> Drivers will derive the RoCE v2.0 UDP src_port from the flow_label result.
> >>>
> >>> UDP source port selection must adhere IANA port allocation ranges. Thus we will
> >>> be using IANA recommendation for Ephemeral port range of: 49152-65535, or in
> >>> hex: 0xC000-0xFFFF.
> >>>
> >>> The below calculations take into account the importance of producing a symmetric
> >>> hash result so we can support symmetric hash calculation of network elements.
> >>>
> >>> Hash Calculation for RDMA IP CM Service
> >>> =======================================
> >>> For RDMA IP CM Services, based on QP1 iMAD usage and connected RC QPs using the
> >>> RDMA IP CM Service ID, the flow label will be calculated according to IBTA CM
> >>> REQ private data info and Service ID.
> >>>
> >>> Flow label hash function calculations definition will be defined as:
> >>> Extract the following fields from the CM IP REQ:
> >>>     CM_REQ.ServiceID.DstPort [2 Bytes]
> >>>     CM_REQ.PrivateData.SrcPort [2 Bytes]
> >>>     u32 hash = DstPort * SrcPort;
> >>>     hash ^= (hash >> 16);
> >>>     hash ^= (hash >> 8);
> >>>     AH_ATTR.GRH.flow_label = hash AND IB_GRH_FLOWLABEL_MASK;
> >>>
> >>>     #define IB_GRH_FLOWLABEL_MASK  0x000FFFFF
> >>
> >> Sorry it took me a while to respond to this, and thanks for looking
> >> into it since my comments on the previous proposal. I have a concern
> >> with an aspect of this one.
> >>
> >> The RoCEv2 destination port is a fixed value, 4791. Therefore the
> >> term
> >>
> >>          u32 hash = DstPort * SrcPort;
> >>
> >> adds no entropy beyond the value of SrcPort.
> >>
> >
> > we're talking about the CM service ports, taken from the
> > rdma_resolve_route(mca_id, <ip:SrcPort>, <ip:DstPort>, to_msec);
> > these are the CM level port-space and not the RoCE UDP L4 ports.
> > we want to use both as these will allow different client instance and
> > server instance on same nodes will use differen CM ports and hopefully
> > generate different hash results for multi-flows between these two
> > servers.
>
> Aha, ok I guess I missed that, and ok.
>
> >> In turn, the subsequent
> >>
> >>          hash ^= (hash >> 16);
> >>          hash ^= (hash >> 8);
> >>
> >> are re-mashing the bits with one another, again, adding no entropy.
>
> I still wonder about this one. It's attempting to reduce the 32-bit
> product to 20 bits, but a second xor with the "middle" 16 bits seems
> really strange. Mathematically, wouldn't it be better to just take
> the modulus of 2^20? If not, are you expecting some behavior in the
> hash values that makes the double-xor approach better (in which case
> it should be called out)?
>
> Tom.

The function takes into account creating a symmetric hash, so both
active and passive can reconstruct the same flow label results. That's
why we multiply the two CM Port values (16 bit * 16 bit). The results
is a 32 bit value, and we don't want to lose any of of the MSB bit's
by modulus or masking. So we need some folding function from 32 bit to
the 20 bit flow label.

The specific bit shift is something I took from the bond driver:
https://elixir.bootlin.com/linux/latest/source/drivers/net/bonding/bond_main.c#L3407
This proved very good in spreading the flow label in our internal
testing. Other alternative can be suggested, as long as it considers
all bits in the conversion 32->20 bits.

Alex

>
> >> Can you describe how, mathematically, this is not different from simply
> >> using the SrcPort field, and if so, how it contributes to the entropy
> >> differentiation of the incoming streams?
> >>
> >> Tom.
> >>
> >>> Result of the above hash will be kept in the CM's route path record connection
> >>> context and will be used all across its vitality for all preceding CM messages
> >>> on both ends of the connection (including REP, REJ, DREQ, DREP, ..).
> >>> Once connection is established, the corresponding Connected RC QPs, on both
> >>> ends of the connection, will update their context with the calculated RDMA IP
> >>> CM Service based flow_label and UDP src_port values at the Connect phase of
> >>> the active side and Accept phase of the passive side of the connection.
> >>>
> >>> CM will provide to the calculated value of the flow_label hash (20 bit) result
> >>> in the 'uint32_t flow_label' field of 'struct ibv_global_route' in 'struct
> >>> ibv_ah_attr'.
> >>> The 'struct ibv_ah_attr' is passed by the CM to the provider library when
> >>> modifying a connected QP's (e.g.: RC) state by calling 'ibv_modify_qp(qp,
> >>> ah_attr, attr_mask |= IBV_QP_AV)' or when create a AH for working with
> >>> datagram QP's (e.g.: UD) by calling ibv_create_ah(ah_attr).
> >>>
> >>> Hash Calculation for non-RDMA CM Service ID
> >>> ===========================================
> >>> For non CM QP's, the application can define the flow_label value in the
> >>> 'struct ibv_ah_attr' when modifying the connected QP's (e.g.: RC) or creating
> >>> a AH for the datagram QP's (e.g.: UD).
> >>>
> >>> If the provided flow_label value is zero, not set by the application (e.g.:
> >>> legacy cases), then verbs providers should use the src.QP[24bit] and
> >>> dst.QP[24bit] as input arguments for flow_label calculation.
> >>> As QPN's are an array of 3 bytes, the multiplication will result in 6 bytes
> >>> value. We'll define a flow_label value as:
> >>>     DstQPn [3 Bytes]
> >>>     SrcQPn [3 Bytes]
> >>>     u64 hash = DstQPn * SrcQPn;
> >>>     hash ^= (hash >> 20);
> >>>     hash ^= (hash >> 40);
> >>>     AH_ATTR.GRH.flow_label = hash AND IB_GRH_FLOWLABEL_MASK;
> >>>
> >>> Hash Calculation for UDP src_port
> >>> =================================
> >>> Providers supporting RoCEv2 will use the 'flow_label' value as input to
> >>> calculate the RoCEv2 UDP src_port, which will be used in the QP context or the
> >>> AH context.
> >>>
> >>> UDP src_port calculations from flow label:
> >>> [while considering the 14 bits UDP port range according to IANA recommendation]
> >>>     AH_ATTR.GRH.flow_label [20 bits]
> >>>     u32 fl_low  = fl & 0x03FFF;
> >>>     u32 fl_high = fl & 0xFC000;
> >>>     u16 udp_sport = fl_low XOR (fl_high >> 14);
> >>>     RoCE.UDP.src_port = udp_sport OR IB_ROCE_UDP_ENCAP_VALID_PORT
> >>>
> >>>     #define IB_ROCE_UDP_ENCAP_VALID_PORT 0xC000
> >>>
> >>> This is a v2 follow-up on "[RFC] RoCE v2.0 UDP Source Port Entropy" [1]
> >>>
> >>> [1] https://www.spinics.net/lists/linux-rdma/msg73735.html
> >>>
> >>> Signed-off-by: Alex Rosenbaum <alexr@mellanox.com>
> >>>
> >>>
> >
> >
