Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB240474B36
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Dec 2021 19:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbhLNSux (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 13:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237152AbhLNSux (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Dec 2021 13:50:53 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20639C061574
        for <linux-rdma@vger.kernel.org>; Tue, 14 Dec 2021 10:50:53 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id kl7so1273882qvb.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Dec 2021 10:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DCeLnoA1njzUX5ahu7HTaihUtMGjpFJs4dHPYJ6halY=;
        b=FLqZMqhVeWJiw7EWozo3uG9eb+oB4EhUHsw+sbNNgaLA5MSut2FdqATsQBe+cQ1zoi
         Fa3N4Rz/kJRpTZRQz50AbMDNFa94UB0UQg1yLN5wBxjsQW0azziL3k5VZEPRygNlJYOq
         0Nr+6ZL3cAoWiN6qVNt9a1NHQ8Yv84GDEwX+ZmYL6xozYatj5KmNf2VPE6DI1GlOWiD6
         VaRHGcWpfugpH76FwdKrrb1ibxkVOOrs7X0mMMcpwjHBrdGg0cwLkf+0ska7sDBYg6MV
         7LJAxD+BqLAsgm/wnEGedH6IDDLatC1vE0etTbqLjGdVJkjZDAPtyNHH7O8vUrFhagjI
         rcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DCeLnoA1njzUX5ahu7HTaihUtMGjpFJs4dHPYJ6halY=;
        b=vOeauqd7FsF73mfmlYlIf93KxD571ZAXOgcRh8atVo2HPzx7z4IqyMP49RGGsYCmvl
         eq7uKWIWWTwY8Hd4fWN9QOYkXBPsW0G+XeIRtY2doNJNuV7pgZ4EsXvTRNqIcn+25rSz
         du1o6saNn/8ucb1aMnrPwJHgI5VlRe8q3tmViCkS8OppGTqgQZ7UHsyRmpIkfKiTw/c5
         N9flE+17WqzykacItqWzjNxj1JOiR/oFGIgP0C1xcv1Nhpb+p4XrudI2Qntq+9LDDv5I
         tVNu59dREpklHKlzVmK/cQcR7UHnZ6ZZumBmDv8tarJsrsy5dhIOAss36sN5BII1fdEB
         SHRQ==
X-Gm-Message-State: AOAM531IzkH8fKQ05Lrxx5UjFIyDJ05wGhr0Jz0geLkFSdd7YRH+XCiS
        Z5Elg1drrZ+GhVC/R0QazIbKou4yP0K3XQ==
X-Google-Smtp-Source: ABdhPJxErQqXn/Q/kLln8MKb2wvPuCChaVUP9DhAU4+qJApWnPZMqdhE28lzv6Pwxvbmo0ExUvz8Ug==
X-Received: by 2002:ad4:4d08:: with SMTP id l8mr2411497qvl.81.1639507852025;
        Tue, 14 Dec 2021 10:50:52 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id k1sm392501qkh.53.2021.12.14.10.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 10:50:51 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mxCt0-003of2-7K; Tue, 14 Dec 2021 14:50:50 -0400
Date:   Tue, 14 Dec 2021 14:50:50 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Talpey <tom@talpey.com>
Cc:     yanjun.zhu@linux.dev, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/irdma: Make the source udp port vary
Message-ID: <20211214185050.GJ6467@ziepe.ca>
References: <20211214054227.1071338-1-yanjun.zhu@linux.dev>
 <b80a409d-3404-75d2-449e-7b8f41296f26@talpey.com>
 <20211214172951.GI6467@ziepe.ca>
 <22f9f724-380c-978c-fc4d-729006c12a5b@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22f9f724-380c-978c-fc4d-729006c12a5b@talpey.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 14, 2021 at 01:09:01PM -0500, Tom Talpey wrote:
> On 12/14/2021 12:29 PM, Jason Gunthorpe wrote:
> > On Tue, Dec 14, 2021 at 12:27:24PM -0500, Tom Talpey wrote:
> > > On 12/14/2021 12:42 AM, yanjun.zhu@linux.dev wrote:
> > > > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > > 
> > > > Based on the link https://www.spinics.net/lists/linux-rdma/msg73735.html,
> > > > get the source udp port number for a QP based on the local QPN. This
> > > > provides a better spread of traffic across NIC RX queues.  The method in
> > > > the commit d3c04a3a6870 ("IB/rxe: vary the source udp port for receive
> > > > scaling") is stable. So it is also adopted in this commit.
> > > > 
> > > > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > >    drivers/infiniband/hw/irdma/verbs.c | 7 ++++++-
> > > >    1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> > > > index 102dc9342f2a..2697b40a539e 100644
> > > > +++ b/drivers/infiniband/hw/irdma/verbs.c
> > > > @@ -690,6 +690,11 @@ static int irdma_cqp_create_qp_cmd(struct irdma_qp *iwqp)
> > > >    	return status ? -ENOMEM : 0;
> > > >    }
> > > > +static inline u16 irdma_get_src_port(struct irdma_qp *iwqp)
> > > > +{
> > > > +	return 0xc000 + (hash_32_generic(iwqp->ibqp.qp_num, 14) & 0x3fff);
> > > > +}
> > > 
> > > How do you ensure the resulting port number is not already in use?
> > 
> > It doesn't matter, it is never used by anything, the receiver captures
> > all data with the roce dport and ignores the sport
> 
> It still violates core networking addressing principles, and will
> mightily confuse a network capture that's filtering on source ports.
> Firewalls, ICMP, and similar fabric behaviors may also interfere.

Maybe, but most of that stuff doesn't work with roce anyhow.

> SoftRoCE is forced to register/reserve the source port, isn't it?

Logically it has to register the dest port, it receives from any
source port.

Due to the way the netstack works softroce can't do this trick either,
IIRC.

Jason
