Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 129C2E3B19
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 20:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437081AbfJXSgm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 14:36:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40477 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437068AbfJXSgl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 14:36:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id o49so31504967qta.7
        for <linux-rdma@vger.kernel.org>; Thu, 24 Oct 2019 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EVxnABB2t2oocCUylCsnWoWiP74Ko+2AG7H4+TsSKeA=;
        b=dAcDBXav31bsEgRRKlRAqX1M+J2bpmx4DF+CZRTysoVVbzrBkB3s7doMCwfZLCLDOT
         02hjvn0E7GWrry7oTMdC90AMiPgiJkz7L9DIX019yZJlRjtrK4xvhRHsABdo82W26uJY
         jKG0edybKlGJKaA8aEMUPyWzh4uPQ0FmN3ux/A0zMob0sn7cFETs2JQpbpvAsooltmAS
         d5NRstiFVG+Vl61jwP3YMrmYZ3X9cjrW1rnnNfr9jDn5vdHKzP6hgDTJx7RfJ5226bhh
         FqhfqSZOuJhRzjzdMYsHwPDlb/7BdEPWt0spyghVEeXf7xUsKOh+tYBb61YBywsWfF0X
         Lohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EVxnABB2t2oocCUylCsnWoWiP74Ko+2AG7H4+TsSKeA=;
        b=MO6tD9OJhdaUt3AZYZbAgpYGXbwiNVpM0LVfgaN0GpqfOhERNqEw0ww7vHz71QNraJ
         lzHIqC4gIwPuW9gVyjHjfmMdTYtIfSWPrr2k2G9+hzQEeYphpdiE+6LHESwwZ+g52qq4
         cQ99ev4FDfVZyAC4PzmjOTf3XzuPm4sZPG6XWlHJAQ8e6lOjA6Q1a30rVfMz0GR5ozjd
         p/485o1a1c3dEuJez+F3uFARThRJoq7LX+dzyA51OLty1fNNBCN5O/Fu0fZZo7MTgR8o
         jqP6jJg5m1R6vMO+x1xe+Dopzg53UcndfcrHna1ImTNSS8008owseHsR8/9wdnaJ4gGT
         9UIQ==
X-Gm-Message-State: APjAAAW17hK95xHtMe+dv2oBjlsVNedJbtRfuMPZ9pMUW3lZJiwAK5kr
        FJrzDrxL8muMcvTvKBhJNA4aHrfqupU=
X-Google-Smtp-Source: APXvYqwIJ4Olb6EOChvNzDEOthzJHr4jpf41jFKsj6yJ7keZv7tYTFgrs3T/hpqTH2tuPpuoz64NAw==
X-Received: by 2002:a0c:e708:: with SMTP id d8mr8713004qvn.225.1571942200640;
        Thu, 24 Oct 2019 11:36:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id u9sm1785174qkk.34.2019.10.24.11.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 11:36:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNhyR-0001kl-49; Thu, 24 Oct 2019 15:36:39 -0300
Date:   Thu, 24 Oct 2019 15:36:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] IB/core: Avoid deadlock during netlink message
 handling
Message-ID: <20191024183639.GA23952@ziepe.ca>
References: <20191015080733.18625-1-leon@kernel.org>
 <20191024131743.GA24174@ziepe.ca>
 <20191024132607.GR4853@unreal>
 <20191024135017.GT23952@ziepe.ca>
 <20191024160252.GS4853@unreal>
 <20191024160810.GV23952@ziepe.ca>
 <20191024161305.GU4853@unreal>
 <AM0PR05MB4866029667184FC06C427E3BD16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR05MB4866029667184FC06C427E3BD16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 24, 2019 at 06:28:35PM +0000, Parav Pandit wrote:
> 
> 
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Thursday, October 24, 2019 11:13 AM
> > To: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Doug Ledford <dledford@redhat.com>; Parav Pandit
> > <parav@mellanox.com>; RDMA mailing list <linux-rdma@vger.kernel.org>
> > Subject: Re: [PATCH rdma-next] IB/core: Avoid deadlock during netlink message
> > handling
> > 
> > On Thu, Oct 24, 2019 at 01:08:10PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Oct 24, 2019 at 07:02:52PM +0300, Leon Romanovsky wrote:
> > > > On Thu, Oct 24, 2019 at 10:50:17AM -0300, Jason Gunthorpe wrote:
> > > > > On Thu, Oct 24, 2019 at 04:26:07PM +0300, Leon Romanovsky wrote:
> > > > > > On Thu, Oct 24, 2019 at 10:17:43AM -0300, Jason Gunthorpe wrote:
> > > > > > > On Tue, Oct 15, 2019 at 11:07:33AM +0300, Leon Romanovsky wrote:
> > > > > > >
> > > > > > > > diff --git a/drivers/infiniband/core/netlink.c
> > > > > > > > b/drivers/infiniband/core/netlink.c
> > > > > > > > index 81dbd5f41bed..a3507b8be569 100644
> > > > > > > > +++ b/drivers/infiniband/core/netlink.c
> > > > > > > > @@ -42,9 +42,12 @@
> > > > > > > >  #include <linux/module.h>
> > > > > > > >  #include "core_priv.h"
> > > > > > > >
> > > > > > > > -static DEFINE_MUTEX(rdma_nl_mutex);  static struct {
> > > > > > > > -	const struct rdma_nl_cbs   *cb_table;
> > > > > > > > +	const struct rdma_nl_cbs __rcu *cb_table;
> > > > > > > > +	/* Synchronizes between ongoing netlink commands and
> > netlink client
> > > > > > > > +	 * unregistration.
> > > > > > > > +	 */
> > > > > > > > +	struct srcu_struct unreg_srcu;
> > > > > > >
> > > > > > > A srcu in every index is serious overkill for this. Lets just
> > > > > > > us a
> > > > > > > rwsem:
> > > > > >
> > > > > > I liked previous variant more than rwsem, but it is Parav's patch.
> > > > >
> > > > > Why? srcu is a huge data structure and slow on unregister
> > > >
> > > > The unregister time is not so important for those IB/core modules.
> > > > I liked SRCU because it doesn't have *_ONCE() macros and smb_* calls.
> > >
> > > It does, they are just hidden under other macros..
 
> Its better that they are hidden. So that we don't need open code
> them.

I wouldn't call swapping one function call for another 'open coding'

> Also with srcu, we don't need lock annotations in get_cb_table()
> which releases and acquires semaphore.

You don't need lock annoations for that.

> Additionally lock nesting makes overall more complex.

SRCU nesting is just as complicated! Don't think SRCU magically hides
that issue, it is still proposing to nest SRCU read side sections.

> Given that there are only 3 indices, out of which only 2 are outside
> of the ib_core module and unlikely to be unloaded, I also prefer
> srcu version.

Why? It isn't faster, it uses more memory, it still has the same
complex concurrency arrangement..

Jason
