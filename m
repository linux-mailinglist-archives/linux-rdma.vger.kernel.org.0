Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0109E3BF7
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 21:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfJXTTy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 15:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfJXTTy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 15:19:54 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C8B020684;
        Thu, 24 Oct 2019 19:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571944792;
        bh=/JKFC12Gqrc916wY700u2NCGwqIEi4gXaFCx49B0QMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QC+YP/47XyfJRYGc9iX2MInRU7EeNyYlvfyNp/qN0Vszbkt6Dtv9BRbGUKuQgk15q
         ylwfjXv2nE6zxsjW7vaWo/mjasaM0h7xB27CWGgr0IcGu0vq2p01K3UIOQ88XrEl/7
         e+9iO3NdDAP2juqDxgSELHTZw5NJ5ZTAx93XOnPI=
Date:   Thu, 24 Oct 2019 22:19:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Parav Pandit <parav@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] IB/core: Avoid deadlock during netlink message
 handling
Message-ID: <20191024191947.GV4853@unreal>
References: <20191015080733.18625-1-leon@kernel.org>
 <20191024131743.GA24174@ziepe.ca>
 <20191024132607.GR4853@unreal>
 <20191024135017.GT23952@ziepe.ca>
 <20191024160252.GS4853@unreal>
 <20191024160810.GV23952@ziepe.ca>
 <20191024161305.GU4853@unreal>
 <AM0PR05MB4866029667184FC06C427E3BD16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191024183639.GA23952@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024183639.GA23952@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 24, 2019 at 03:36:39PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 24, 2019 at 06:28:35PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Sent: Thursday, October 24, 2019 11:13 AM
> > > To: Jason Gunthorpe <jgg@ziepe.ca>
> > > Cc: Doug Ledford <dledford@redhat.com>; Parav Pandit
> > > <parav@mellanox.com>; RDMA mailing list <linux-rdma@vger.kernel.org>
> > > Subject: Re: [PATCH rdma-next] IB/core: Avoid deadlock during netlink message
> > > handling
> > >
> > > On Thu, Oct 24, 2019 at 01:08:10PM -0300, Jason Gunthorpe wrote:
> > > > On Thu, Oct 24, 2019 at 07:02:52PM +0300, Leon Romanovsky wrote:
> > > > > On Thu, Oct 24, 2019 at 10:50:17AM -0300, Jason Gunthorpe wrote:
> > > > > > On Thu, Oct 24, 2019 at 04:26:07PM +0300, Leon Romanovsky wrote:
> > > > > > > On Thu, Oct 24, 2019 at 10:17:43AM -0300, Jason Gunthorpe wrote:
> > > > > > > > On Tue, Oct 15, 2019 at 11:07:33AM +0300, Leon Romanovsky wrote:
> > > > > > > >
> > > > > > > > > diff --git a/drivers/infiniband/core/netlink.c
> > > > > > > > > b/drivers/infiniband/core/netlink.c
> > > > > > > > > index 81dbd5f41bed..a3507b8be569 100644
> > > > > > > > > +++ b/drivers/infiniband/core/netlink.c
> > > > > > > > > @@ -42,9 +42,12 @@
> > > > > > > > >  #include <linux/module.h>
> > > > > > > > >  #include "core_priv.h"
> > > > > > > > >
> > > > > > > > > -static DEFINE_MUTEX(rdma_nl_mutex);  static struct {
> > > > > > > > > -	const struct rdma_nl_cbs   *cb_table;
> > > > > > > > > +	const struct rdma_nl_cbs __rcu *cb_table;
> > > > > > > > > +	/* Synchronizes between ongoing netlink commands and
> > > netlink client
> > > > > > > > > +	 * unregistration.
> > > > > > > > > +	 */
> > > > > > > > > +	struct srcu_struct unreg_srcu;
> > > > > > > >
> > > > > > > > A srcu in every index is serious overkill for this. Lets just
> > > > > > > > us a
> > > > > > > > rwsem:
> > > > > > >
> > > > > > > I liked previous variant more than rwsem, but it is Parav's patch.
> > > > > >
> > > > > > Why? srcu is a huge data structure and slow on unregister
> > > > >
> > > > > The unregister time is not so important for those IB/core modules.
> > > > > I liked SRCU because it doesn't have *_ONCE() macros and smb_* calls.
> > > >
> > > > It does, they are just hidden under other macros..
>
> > Its better that they are hidden. So that we don't need open code
> > them.
>
> I wouldn't call swapping one function call for another 'open coding'
>
> > Also with srcu, we don't need lock annotations in get_cb_table()
> > which releases and acquires semaphore.
>
> You don't need lock annoations for that.
>
> > Additionally lock nesting makes overall more complex.
>
> SRCU nesting is just as complicated! Don't think SRCU magically hides
> that issue, it is still proposing to nest SRCU read side sections.
>
> > Given that there are only 3 indices, out of which only 2 are outside
> > of the ib_core module and unlikely to be unloaded, I also prefer
> > srcu version.
>
> Why? It isn't faster, it uses more memory, it still has the same
> complex concurrency arrangement..

Jason,

It doesn't worth arguing, both Parav and I prefer SRCU variant, you
prefer rwsem, so go for it, take rwsem, it is not important.

Thanks

>
> Jason
