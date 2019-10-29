Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88868E8F3D
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 19:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbfJ2S0K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 14:26:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33446 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbfJ2S0K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Oct 2019 14:26:10 -0400
Received: by mail-qt1-f194.google.com with SMTP id y39so16279954qty.0
        for <linux-rdma@vger.kernel.org>; Tue, 29 Oct 2019 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rfZZw30h4oCsSsXkEhNAO+n+JUKLTQw0OoVDhD7/ZRs=;
        b=OgkJLSzKcpYSmn8MbB4MSgJvQgWFu/d4qF1hDVuyhmIT+9a65v/1Fkyaz0MDV/DLr6
         vXemCri4Bijtl24ljhU38C/JbjKMK9/6Jgu7dedcDuewz9NZSOS/AzwdJMweolI1m+Oj
         +n0Q3g1bjqNQc1Vq/kdOwxRxOaaxFFcW5VG3WBWsNWfDDQr+DK/qV6iJlok1e90/1r8s
         NOn58VYQQ8xiWMb9AOzdoy9b0Ec6cbYzbKbl5D2C3F9sf3aNmxO2Ohp4VVLp8vlJBnlU
         1gcDv2Zyn0ZVzk8uHj/C94xYvQIFdYZFKYbahcQ/I+tS4IncoPfLGORBY/3TH9fPO+ja
         lzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rfZZw30h4oCsSsXkEhNAO+n+JUKLTQw0OoVDhD7/ZRs=;
        b=XbFBniUQRC4+UmXtFpSzXKjJcvcuKWMdZbL4Kaapi3lHawsZdJbhd+4bjwPp5J7TF9
         gmvRTOKncYGnt1h7qM/D+aijAQT3u96Qpj7Bvixu+r7lhPHeMEFVCqKxnyDqqskwWkUZ
         bvCaso+BXM7Tc/PGPiKSsOrHUstotHtXO4x6hSkqqE1eTtIw1cF8CmqEKApSKTACc17C
         F4BjzsrjhpBkEHAZUwQhx1MY7wNK8vvdbsmM/+eUicMxw/WfR7qwkNd+pzbe6fDzXJh+
         mk94uV/yCAsSMRfpQCsqcG1Rtr830t5poD1knfa9gmsqsTe+w7hxMcj3TOjehmyCSEU5
         SZvQ==
X-Gm-Message-State: APjAAAXIwJMwfAMT90OC678yWDBWgb+JL0ypXdkM5KdVrWnuLU2KsfwI
        15oFRag7ejAVga79X55sZKYEbQ==
X-Google-Smtp-Source: APXvYqwUAbXIkD2RKyy7r6b+KKtXwbRYtHfwZ/L3HeedHofdqxD/KLPVC5Ci0XDwd2Ptrf61G8NwVQ==
X-Received: by 2002:a0c:fb48:: with SMTP id b8mr4981750qvq.125.1572373567727;
        Tue, 29 Oct 2019 11:26:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id b1sm6652150qtr.17.2019.10.29.11.26.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 11:26:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPWBy-00024s-EI; Tue, 29 Oct 2019 15:26:06 -0300
Date:   Tue, 29 Oct 2019 15:26:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>
Subject: Re: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cache
 update events
Message-ID: <20191029182606.GG6128@ziepe.ca>
References: <20191029115327.16589-1-leon@kernel.org>
 <20191029115327.16589-2-leon@kernel.org>
 <20191029152419.GL22766@mellanox.com>
 <AM0PR05MB4866B01D2F20B82D341361BDD1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191029153345.GN22766@mellanox.com>
 <AM0PR05MB48668ED6420D4DC6385ADE13D1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191029155454.GF6128@ziepe.ca>
 <AM0PR05MB486695150B0FEE97AC3E6CECD1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR05MB486695150B0FEE97AC3E6CECD1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 29, 2019 at 06:11:01PM +0000, Parav Pandit wrote:
> 
> 
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Tuesday, October 29, 2019 10:55 AM
> > To: Parav Pandit <parav@mellanox.com>
> > Cc: Leon Romanovsky <leon@kernel.org>; Doug Ledford
> > <dledford@redhat.com>; Leon Romanovsky <leonro@mellanox.com>; RDMA
> > mailing list <linux-rdma@vger.kernel.org>; Daniel Jurgens
> > <danielj@mellanox.com>
> > Subject: Re: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cache
> > update events
> > 
> > On Tue, Oct 29, 2019 at 03:47:42PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > > Sent: Tuesday, October 29, 2019 10:34 AM
> > > > To: Parav Pandit <parav@mellanox.com>
> > > > Cc: Leon Romanovsky <leon@kernel.org>; Doug Ledford
> > > > <dledford@redhat.com>; Leon Romanovsky <leonro@mellanox.com>;
> > RDMA
> > > > mailing list <linux-rdma@vger.kernel.org>; Daniel Jurgens
> > > > <danielj@mellanox.com>
> > > > Subject: Re: [PATCH rdma-next v1 1/2] IB/core: Let IB core
> > > > distribute cache update events
> > > >
> > > > On Tue, Oct 29, 2019 at 03:32:46PM +0000, Parav Pandit wrote:
> > > >
> > > > > > > +/**
> > > > > > > + * ib_dispatch_event - Dispatch an asynchronous event
> > > > > > > + * @event:Event to dispatch
> > > > > > > + *
> > > > > > > + * Low-level drivers must call ib_dispatch_event() to
> > > > > > > +dispatch the
> > > > > > > + * event to all registered event handlers when an
> > > > > > > +asynchronous event
> > > > > > > + * occurs.
> > > > > > > + */
> > > > > > > +void ib_dispatch_event(struct ib_event *event) {
> > > > > > > +	ib_enqueue_cache_update_event(event);
> > > > > > > +}
> > > > > > >  EXPORT_SYMBOL(ib_dispatch_event);
> > > > > >
> > > > > > Why not just move this into cache.c?
> > > > > >
> > > > > Same thought same to me when I had to add one liner call.
> > > > > However the issue was device.c has the code for the event
> > > > registration/unregistration and calling the handlers unrelated to cache.
> > > > > So moving ib_dispatch_event() to cache.c looked incorrect to me.
> > > >
> > > > Well, maybe we can move the wq code from the cache.c into here?
> > >
> > > I prefer to keep all cache specific code in cache.c because there is
> > > where we flush the ib_wq, queue work there.
> > 
> > I think that is because the cache is not subscribing to a notifier, it really should,
> > then things order properly and the flush is not needed.
> > 
> Cache shouldn't subscribe to the notifier, that is the race
> condition issue.

Notifiers are ordered, as long as the cache subscribes first to the
notifier list it is not a 'race condition'.

This is still somewhat problematic because 'ib_dispatch_event' still
calls the handlers under a spinlock (ie the handlers are still
non-blocking contexts)

I'm suggesting to swap it for a normal blocking notifier chain and
guarentee the cache is the first entry in the chain.

Jason
