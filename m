Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 871E8154659
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2020 15:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgBFOjy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Feb 2020 09:39:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37293 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgBFOjy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Feb 2020 09:39:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so7500217wru.4
        for <linux-rdma@vger.kernel.org>; Thu, 06 Feb 2020 06:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xH3422RlY86Ou6/ZiHXMnZcmaIPKDdeo6+H/EMV9ixk=;
        b=aZ+fDBk/SRBuEUl1aUwUk9oN16YHUkZiV/TfDapfGxjmMLMaHjGMO0rVVDpC/wTnui
         zS+BNpfrVGIgVXnkstodWUv6f46eqvXeDR1e8OScPEpv/1+fA0/Xequ+/nAONBSH3D/w
         +ISxuOMSaf7xZzso3pM8bREJaskREKS984iqB0CviidQ1ULkUoACI3OB+xphzTA+VsQP
         XVdg1f5Z5iKO8Z+zCjiMwK4h57eQJJjZKliasp9RmCbWq59fhnlXDUgrxA0tNb0QNwXr
         So9Vww3XiZO1Wm4DZTFNB3OYfH/rTCi1/JXJ9MU55Z4OBZanYo0XP2m3JhLNs46IFpWP
         XkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xH3422RlY86Ou6/ZiHXMnZcmaIPKDdeo6+H/EMV9ixk=;
        b=WNCGJsHgkVfzKC5fkzAQdapvqxTYurXU3Jgcqb/XoqGVSwLiNeeUc/9UtwMXgSdeWO
         ZQpbS0NnPwaZJhQ71DMUStrJkN8HzATBLGsfg1NmBNuG3fFqosGSirCd9Fahkd3db9NC
         jgOUnTC1448MEyOsqQ26sW/YAVykNm6GHaZkFJ8CCB+bprnslFTZJdnUONe+rEqqnKsi
         XzUXUsR6QWlgrcdF5ZNYCWOahUKCTpcmdZXyiOocys1IKTokBUava3YtWTha2UmFYoJa
         GTfblZ9yypA8TvbNfRkOMjzC2Vu2nFYPOW6D3E88BlZDNwV7vwRqAHBd/Gdo+3LsZGe4
         2Obg==
X-Gm-Message-State: APjAAAVQk+aAjD5IkbFon0fGYg/ioATIYDL/JI2W0RWJ9rYG7hCyMqqH
        Obd7bkdDXpZL+XqtLSG5h7ykJx6jjv1Fwu/ceiY=
X-Google-Smtp-Source: APXvYqzPBw7zv9Dv1luYMDDeSDzFoGCSrm7cpJ85Thv/N/05/55jRc/y9otPXnO93Vkvmt0yN+2orOHYW5Zehjj2Z+I=
X-Received: by 2002:adf:e70d:: with SMTP id c13mr4095119wrm.248.1580999991369;
 Thu, 06 Feb 2020 06:39:51 -0800 (PST)
MIME-Version: 1.0
References: <CAFgAxU8ArpoL9fMpJY5v-UZS5AMXom+TJ8HS57XeEOsCFFov8Q@mail.gmail.com>
 <63a56c06-57bf-6e31-6ca8-043f9d3b72f3@talpey.com>
In-Reply-To: <63a56c06-57bf-6e31-6ca8-043f9d3b72f3@talpey.com>
From:   Alex Rosenbaum <rosenbaumalex@gmail.com>
Date:   Thu, 6 Feb 2020 16:39:39 +0200
Message-ID: <CAFgAxU80+feEEtaRYFYTHwTMSE6Edjq0t0siJ0W06WSyD+Cy3A@mail.gmail.com>
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

On Thu, Feb 6, 2020 at 4:18 PM Tom Talpey <tom@talpey.com> wrote:
>
> On 1/8/2020 9:26 AM, Alex Rosenbaum wrote:
> > A combination of the flow_label field in the IPv6 header and UDP source port
> > field in RoCE v2.0 are used to identify a group of packets that must be
> > delivered in order by the network, end-to-end.
> > These fields are used to create entropy for network routers (ECMP), load
> > balancers and 802.3ad link aggregation switching that are not aware of RoCE IB
> > headers.
> >
> > The flow_label field is defined by a 20 bit hash value. CM based connections
> > will use a hash function definition based on the service type (QP Type) and
> > Service ID (SID). Where CM services are not used, the 20 bit hash will be
> > according to the source and destination QPN values.
> > Drivers will derive the RoCE v2.0 UDP src_port from the flow_label result.
> >
> > UDP source port selection must adhere IANA port allocation ranges. Thus we will
> > be using IANA recommendation for Ephemeral port range of: 49152-65535, or in
> > hex: 0xC000-0xFFFF.
> >
> > The below calculations take into account the importance of producing a symmetric
> > hash result so we can support symmetric hash calculation of network elements.
> >
> > Hash Calculation for RDMA IP CM Service
> > =======================================
> > For RDMA IP CM Services, based on QP1 iMAD usage and connected RC QPs using the
> > RDMA IP CM Service ID, the flow label will be calculated according to IBTA CM
> > REQ private data info and Service ID.
> >
> > Flow label hash function calculations definition will be defined as:
> > Extract the following fields from the CM IP REQ:
> >    CM_REQ.ServiceID.DstPort [2 Bytes]
> >    CM_REQ.PrivateData.SrcPort [2 Bytes]
> >    u32 hash = DstPort * SrcPort;
> >    hash ^= (hash >> 16);
> >    hash ^= (hash >> 8);
> >    AH_ATTR.GRH.flow_label = hash AND IB_GRH_FLOWLABEL_MASK;
> >
> >    #define IB_GRH_FLOWLABEL_MASK  0x000FFFFF
>
> Sorry it took me a while to respond to this, and thanks for looking
> into it since my comments on the previous proposal. I have a concern
> with an aspect of this one.
>
> The RoCEv2 destination port is a fixed value, 4791. Therefore the
> term
>
>         u32 hash = DstPort * SrcPort;
>
> adds no entropy beyond the value of SrcPort.
>

we're talking about the CM service ports, taken from the
rdma_resolve_route(mca_id, <ip:SrcPort>, <ip:DstPort>, to_msec);
these are the CM level port-space and not the RoCE UDP L4 ports.
we want to use both as these will allow different client instance and
server instance on same nodes will use differen CM ports and hopefully
generate different hash results for multi-flows between these two
servers.

> In turn, the subsequent
>
>         hash ^= (hash >> 16);
>         hash ^= (hash >> 8);
>
> are re-mashing the bits with one another, again, adding no entropy.
>
> Can you describe how, mathematically, this is not different from simply
> using the SrcPort field, and if so, how it contributes to the entropy
> differentiation of the incoming streams?
>
> Tom.
>
> > Result of the above hash will be kept in the CM's route path record connection
> > context and will be used all across its vitality for all preceding CM messages
> > on both ends of the connection (including REP, REJ, DREQ, DREP, ..).
> > Once connection is established, the corresponding Connected RC QPs, on both
> > ends of the connection, will update their context with the calculated RDMA IP
> > CM Service based flow_label and UDP src_port values at the Connect phase of
> > the active side and Accept phase of the passive side of the connection.
> >
> > CM will provide to the calculated value of the flow_label hash (20 bit) result
> > in the 'uint32_t flow_label' field of 'struct ibv_global_route' in 'struct
> > ibv_ah_attr'.
> > The 'struct ibv_ah_attr' is passed by the CM to the provider library when
> > modifying a connected QP's (e.g.: RC) state by calling 'ibv_modify_qp(qp,
> > ah_attr, attr_mask |= IBV_QP_AV)' or when create a AH for working with
> > datagram QP's (e.g.: UD) by calling ibv_create_ah(ah_attr).
> >
> > Hash Calculation for non-RDMA CM Service ID
> > ===========================================
> > For non CM QP's, the application can define the flow_label value in the
> > 'struct ibv_ah_attr' when modifying the connected QP's (e.g.: RC) or creating
> > a AH for the datagram QP's (e.g.: UD).
> >
> > If the provided flow_label value is zero, not set by the application (e.g.:
> > legacy cases), then verbs providers should use the src.QP[24bit] and
> > dst.QP[24bit] as input arguments for flow_label calculation.
> > As QPN's are an array of 3 bytes, the multiplication will result in 6 bytes
> > value. We'll define a flow_label value as:
> >    DstQPn [3 Bytes]
> >    SrcQPn [3 Bytes]
> >    u64 hash = DstQPn * SrcQPn;
> >    hash ^= (hash >> 20);
> >    hash ^= (hash >> 40);
> >    AH_ATTR.GRH.flow_label = hash AND IB_GRH_FLOWLABEL_MASK;
> >
> > Hash Calculation for UDP src_port
> > =================================
> > Providers supporting RoCEv2 will use the 'flow_label' value as input to
> > calculate the RoCEv2 UDP src_port, which will be used in the QP context or the
> > AH context.
> >
> > UDP src_port calculations from flow label:
> > [while considering the 14 bits UDP port range according to IANA recommendation]
> >    AH_ATTR.GRH.flow_label [20 bits]
> >    u32 fl_low  = fl & 0x03FFF;
> >    u32 fl_high = fl & 0xFC000;
> >    u16 udp_sport = fl_low XOR (fl_high >> 14);
> >    RoCE.UDP.src_port = udp_sport OR IB_ROCE_UDP_ENCAP_VALID_PORT
> >
> >    #define IB_ROCE_UDP_ENCAP_VALID_PORT 0xC000
> >
> > This is a v2 follow-up on "[RFC] RoCE v2.0 UDP Source Port Entropy" [1]
> >
> > [1] https://www.spinics.net/lists/linux-rdma/msg73735.html
> >
> > Signed-off-by: Alex Rosenbaum <alexr@mellanox.com>
> >
> >
