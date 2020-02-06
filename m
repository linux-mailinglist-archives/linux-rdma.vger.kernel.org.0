Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6C915464A
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2020 15:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgBFOfY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Feb 2020 09:35:24 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:46028 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFOfY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Feb 2020 09:35:24 -0500
Received: by mail-qv1-f68.google.com with SMTP id l14so2906855qvu.12
        for <linux-rdma@vger.kernel.org>; Thu, 06 Feb 2020 06:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=avfNjln6b7xuPcVW0haeQ9+4lo1S28iczH4bYKVLoSo=;
        b=XZqqHy+FsYYUaFerW0XXVbQDKTkJIi2WR6NPqP+FcMUa37VErMbI4O7+wfQu7X0/sa
         CK3mjGcgEB9jMpxfBB43Oz/gHxttEBjQieBda+e89/WPSmkdnpvgCQEKrPjLIJi3FIh/
         hOA3+qiz4Rz0V7I1upapgblIRbukesxoKoe2LJWuQ7fIHJRXR6u8nTO2DWsMuQFngOrO
         ia9nRCVFhy46V5fWJS/HRvm8jNz2FS/kEinY7S1aXXjLxVRmG9nleZuxHSxR5RaUJLU2
         nPweKjP5HlAF2eUAi79AU4d2N9tji2ygM0zlf61nJGEFvWQ48F3b27vzT3x1hVHh3vpZ
         DzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=avfNjln6b7xuPcVW0haeQ9+4lo1S28iczH4bYKVLoSo=;
        b=l4PWA0R029i9pP1Qs/0KJFzrOEW9xINY7EfI6tSQPHDt7F2vRdfAQM7LPaAvxr9reX
         87VpEZgBRys7eYVH7DmaK1UNZi5L+8PatoacMOPpDCGbh1BhuxDenrCajV3RQS7iVUjY
         mGIoqPBVPBpB0MSnUet7/azR+glwS+TnNlwwVkrdzXUtQOH/RUS/5vOisXQ+Nc5Wc0Ce
         mVruJej7indYIGX+TV69S+lH3IHV3EY2uz5yT9RtXgmmYOka2cTiWJVH9MJDxET02Zgf
         vljNQAiUcpSvBkzLfXSiVaQA450BcHzWsFX2zDqM/l5iTZjKhjE7QXjiB4vDvGr0Yzio
         F3YA==
X-Gm-Message-State: APjAAAWmLN9Kyh1R6kA9JeIiWouDwsj4csLgtQqAaGaDwO//iuDLc/5Z
        l9JItu4dEyg7Lls8fNYfzZNozg==
X-Google-Smtp-Source: APXvYqxUaE8kOUs70WV5In8fAUaiLBBSZ00RXqXbPYPa/xLIdKPZPahHHhEXFQ9Fprr5QIXUXsv35w==
X-Received: by 2002:a0c:e150:: with SMTP id c16mr2595086qvl.51.1580999723212;
        Thu, 06 Feb 2020 06:35:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id m23sm1691798qtp.6.2020.02.06.06.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Feb 2020 06:35:22 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iziFV-0005uL-OA; Thu, 06 Feb 2020 10:35:21 -0400
Date:   Thu, 6 Feb 2020 10:35:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Talpey <tom@talpey.com>
Cc:     Alex Rosenbaum <rosenbaumalex@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        "Alex @ Mellanox" <alexr@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [RFC v2] RoCE v2.0 Entropy - IPv6 Flow Label and UDP Source Port
Message-ID: <20200206143521.GG25297@ziepe.ca>
References: <CAFgAxU8ArpoL9fMpJY5v-UZS5AMXom+TJ8HS57XeEOsCFFov8Q@mail.gmail.com>
 <63a56c06-57bf-6e31-6ca8-043f9d3b72f3@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63a56c06-57bf-6e31-6ca8-043f9d3b72f3@talpey.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 06, 2020 at 09:18:38AM -0500, Tom Talpey wrote:
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

I read the above as using the destination port of the IP contained
within the CM REQ, not as the destination port of the RoCE UDP header?

So it can be different..

Jason
