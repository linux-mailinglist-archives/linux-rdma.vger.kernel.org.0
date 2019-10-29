Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E3E8C31
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 16:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389960AbfJ2Py4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 11:54:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33328 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389829AbfJ2Py4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Oct 2019 11:54:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id y39so15554017qty.0
        for <linux-rdma@vger.kernel.org>; Tue, 29 Oct 2019 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eTLkezsC0s9BqEiN1Latf6J4eEMcxzvw664fcv6tT6I=;
        b=TfqG/dqaAkkh1Vd6cnMsjMQHeJQIU+vlt+WawLCIJKULL/U7nwXTLM1J8sfmYNUyX3
         +fsptRbrAYWhwYyXUtS8b+viuklcc9PE1bCulr4zinuzKSIyWH/J1FFJHRXE87tn1z9h
         VNdqkyqHA2/WfbV//PMnmlkr0w/hmAAdHSmdb48t6Ahi9AXLlEEYviAnJQFEs2rbDnl2
         QH9fSIQ76evubzvqUgDusY6M32fm5PbEFGRycCQJJNt+7HC59RDyalrVjCo2/wvlf8UZ
         2hzrrgKxY2xoSKJlf/F2zFiUaXenJ05vTHsTuiBrosC6+gpAxH+sL+RYjuBJzka44bZI
         4WGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eTLkezsC0s9BqEiN1Latf6J4eEMcxzvw664fcv6tT6I=;
        b=mtQLFhVoPKNgaN7G1V+jNu+F3pD3gMiPgrxDOv3edJS2AJn96/Y2Y+1PmFtM84MBjo
         tP555uGEQmQ4LppDRasBDP55iqT2dlxkV30UvOjjj9Y43F1pBrTc10ioi91hpfZkc7JY
         SXnj53IvKMJMBxNUg22Mb5hjYM4G2sOIjL2luuDmucK78TUE6yJLscIlRZ4zTY8u/l6d
         pNSWDH6jZBooKqPAt/3220TEvkGQPpWELOW3cLxiPSAhJwzD5EYZ40G6PMXqwmZhdhTZ
         r1GXgsIcerHyWEsRBjPBs3IixB5HAnoy/l6zm7U9B5hWT6Ky/syuGwqT1qDPOpNDWK5L
         Bu6w==
X-Gm-Message-State: APjAAAV2JngnOuN6RlcYjz0BMPyjiMHeUme44fCwz6VCd8yv8TK7F7Mz
        M1EvpSJUM7XASMWEBj2sii6gcQE9kWc=
X-Google-Smtp-Source: APXvYqwBp8C7opk9ChLxr22TTWRxovV6yfNFhvlEMvltrnJ846S8pjSHfZcYt/f0Po/DdCyHoD9MeQ==
X-Received: by 2002:a0c:d645:: with SMTP id e5mr24232393qvj.176.1572364495138;
        Tue, 29 Oct 2019 08:54:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 189sm7614252qki.10.2019.10.29.08.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 08:54:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPTpe-0007lV-3T; Tue, 29 Oct 2019 12:54:54 -0300
Date:   Tue, 29 Oct 2019 12:54:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>
Subject: Re: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cache
 update events
Message-ID: <20191029155454.GF6128@ziepe.ca>
References: <20191029115327.16589-1-leon@kernel.org>
 <20191029115327.16589-2-leon@kernel.org>
 <20191029152419.GL22766@mellanox.com>
 <AM0PR05MB4866B01D2F20B82D341361BDD1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191029153345.GN22766@mellanox.com>
 <AM0PR05MB48668ED6420D4DC6385ADE13D1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR05MB48668ED6420D4DC6385ADE13D1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 29, 2019 at 03:47:42PM +0000, Parav Pandit wrote:
> 
> 
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > Sent: Tuesday, October 29, 2019 10:34 AM
> > To: Parav Pandit <parav@mellanox.com>
> > Cc: Leon Romanovsky <leon@kernel.org>; Doug Ledford
> > <dledford@redhat.com>; Leon Romanovsky <leonro@mellanox.com>; RDMA
> > mailing list <linux-rdma@vger.kernel.org>; Daniel Jurgens
> > <danielj@mellanox.com>
> > Subject: Re: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cache
> > update events
> > 
> > On Tue, Oct 29, 2019 at 03:32:46PM +0000, Parav Pandit wrote:
> > 
> > > > > +/**
> > > > > + * ib_dispatch_event - Dispatch an asynchronous event
> > > > > + * @event:Event to dispatch
> > > > > + *
> > > > > + * Low-level drivers must call ib_dispatch_event() to dispatch the
> > > > > + * event to all registered event handlers when an asynchronous event
> > > > > + * occurs.
> > > > > + */
> > > > > +void ib_dispatch_event(struct ib_event *event) {
> > > > > +	ib_enqueue_cache_update_event(event);
> > > > > +}
> > > > >  EXPORT_SYMBOL(ib_dispatch_event);
> > > >
> > > > Why not just move this into cache.c?
> > > >
> > > Same thought same to me when I had to add one liner call.
> > > However the issue was device.c has the code for the event
> > registration/unregistration and calling the handlers unrelated to cache.
> > > So moving ib_dispatch_event() to cache.c looked incorrect to me.
> > 
> > Well, maybe we can move the wq code from the cache.c into here?
> 
> I prefer to keep all cache specific code in cache.c because there is
> where we flush the ib_wq, queue work there.

I think that is because the cache is not subscribing to a notifier, it
really should, then things order properly and the flush is not needed.

> > It looks just as incorrect to have the one line call
> 
> No, its not incorrect. Because device.c provides functionality to
> register/unregister handler and dispatch event.  While cache layer
> deals with cache updates etc, and uses wq service provided device.c
> If we rename ib_dispatch_event() to ib_dispatch_cache_event() it
> make sense to move to cache.c However we have non cache specific
> events there too, so current code split between cache.c and device.c
> looks appropriate.

It always looks bad to have a single line function call like that,
especially just for spurious reasons like file placement or
functioning naming. It shows something is being done wrong

Jason
