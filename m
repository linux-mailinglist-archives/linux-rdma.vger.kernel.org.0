Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFA2E3770
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 18:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407757AbfJXQIM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 12:08:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36512 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405863AbfJXQIM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 12:08:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id d17so24039472qto.3
        for <linux-rdma@vger.kernel.org>; Thu, 24 Oct 2019 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s1fj8fwhXASvA5BcSEnuaym+AEP5F8vrCX6CqSoSzHE=;
        b=ipLcj3vqSRvDkawQ84nEhQUdYOuFWhl+8+r4w/t271R3CMRcMqmd3xDKgI0v3RUIfw
         0pZuoTB/6uXIbjMQnS22Mf4xeguRF7l5tiofGMv5nuDLnSGFHPVZO/y+9vxjd5Id0eek
         2H1vArZabODJZDFiPOD6ihIpZGVcl9WnJxmYhSdbGU2IJwmJm94kE2C12ySZ2DeOqMJh
         5XeeAWa4yDubLdRoBlzXBGlC9n6jiFuNO8It+eXFEVgZk1YYkrndG81IzTi/4l8fi8tw
         RiMgn/erpd7vq6rkfjg3VsdFJRU70QXce+y/9Yk4W33KJPMSqvOIicC7GX7sfiNgTq+L
         EIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s1fj8fwhXASvA5BcSEnuaym+AEP5F8vrCX6CqSoSzHE=;
        b=USvxdCOrwckWoo19+mHTdnBKzYJOKYysSUdURdzDO9s0DgXMb0I3WCICQxfZPC2sin
         siYmg46IzH0kbf6HE7TQMHZ/MbSDbkfN1sIvn1JoqMqMIS0KbSkzxVK2D1AYQO7A+EvA
         51UaHmrgL1mMlIfoOCCVu5k67feMBsrp1CqY85q7x8YuHyUWL6PJfcTTS9H+XDI9sqCT
         YcSjxdX5vlGP5GyFOt0/s10Y+ZRCNOp/sLjybBDQaC5LBYfNpxQd1OSQD1i1pPJhiaqM
         PTl+YsZnK1fbEV8cPNB5mApVTkmiw6u+6jskUep58mxCHYDu/zK5WzlibOqeimqQyYkC
         dYLA==
X-Gm-Message-State: APjAAAVdcNH5tDMY/OQGHspgH92WEJO6Awa5z5Qk9K1GJvhaa5na6NNX
        P6nZm8zI60zmly1c9z1B2BLaEUGHVBg=
X-Google-Smtp-Source: APXvYqxWKpcpuF7L6UlbLq/uff1A34fMdUx/u0mXPi6YKIBzvhtfZB+gMw1Kvmu6HEbnImc9BdXlUg==
X-Received: by 2002:aed:2907:: with SMTP id s7mr4108459qtd.265.1571933291109;
        Thu, 24 Oct 2019 09:08:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id k17sm21683561qtk.7.2019.10.24.09.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 09:08:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNfek-0008Kl-1A; Thu, 24 Oct 2019 13:08:10 -0300
Date:   Thu, 24 Oct 2019 13:08:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] IB/core: Avoid deadlock during netlink message
 handling
Message-ID: <20191024160810.GV23952@ziepe.ca>
References: <20191015080733.18625-1-leon@kernel.org>
 <20191024131743.GA24174@ziepe.ca>
 <20191024132607.GR4853@unreal>
 <20191024135017.GT23952@ziepe.ca>
 <20191024160252.GS4853@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024160252.GS4853@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 24, 2019 at 07:02:52PM +0300, Leon Romanovsky wrote:
> On Thu, Oct 24, 2019 at 10:50:17AM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 24, 2019 at 04:26:07PM +0300, Leon Romanovsky wrote:
> > > On Thu, Oct 24, 2019 at 10:17:43AM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Oct 15, 2019 at 11:07:33AM +0300, Leon Romanovsky wrote:
> > > >
> > > > > diff --git a/drivers/infiniband/core/netlink.c b/drivers/infiniband/core/netlink.c
> > > > > index 81dbd5f41bed..a3507b8be569 100644
> > > > > +++ b/drivers/infiniband/core/netlink.c
> > > > > @@ -42,9 +42,12 @@
> > > > >  #include <linux/module.h>
> > > > >  #include "core_priv.h"
> > > > >
> > > > > -static DEFINE_MUTEX(rdma_nl_mutex);
> > > > >  static struct {
> > > > > -	const struct rdma_nl_cbs   *cb_table;
> > > > > +	const struct rdma_nl_cbs __rcu *cb_table;
> > > > > +	/* Synchronizes between ongoing netlink commands and netlink client
> > > > > +	 * unregistration.
> > > > > +	 */
> > > > > +	struct srcu_struct unreg_srcu;
> > > >
> > > > A srcu in every index is serious overkill for this. Lets just us a
> > > > rwsem:
> > >
> > > I liked previous variant more than rwsem, but it is Parav's patch.
> >
> > Why? srcu is a huge data structure and slow on unregister
> 
> The unregister time is not so important for those IB/core modules.
> I liked SRCU because it doesn't have *_ONCE() macros and smb_* calls.

It does, they are just hidden under other macros..

> Maybe wrong here, but the extra advantage of SRCU is that we are already
> using that mechanism in uverbs and my assumption that SRCU will greatly
> enjoy shared grace period.

Hm, I'm not sure it works like that, the grace periods would be consecutive

Jason
