Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE2B95FFF0
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2019 06:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbfGEEKI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Jul 2019 00:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfGEEKI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 5 Jul 2019 00:10:08 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC53A21852;
        Fri,  5 Jul 2019 04:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562299807;
        bh=o3nJicTy+Qjp7G09STgRNAO/lzLw5iVeuJIFKu6cNw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uxQMNM/AZcsCbdxpbp3iTVv59AZe9WzAV267s8w8FeqzB4qpzHnMfsWwyvaylHTxS
         NTFaOoU3gAihbyOE8cqchTWA8I7Bfbt7lMA7ZGrY3eAv8ZxfFZXUQbN9ovcR3HRCx/
         JTNiGdwc1QRvZv5pPJodfrmIIzWPs1nBVeWpJHO4=
Date:   Fri, 5 Jul 2019 07:09:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Parav Pandit <pandit.parav@gmail.com>
Cc:     Dag Moxnes <dag.moxnes@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA/core: Fix race when resolving IP address
Message-ID: <20190705040950.GO7212@mtr-leonro.mtl.com>
References: <1561711763-24705-1-git-send-email-dag.moxnes@oracle.com>
 <CAG53R5VQqqr0S6OU+13tcuxcvz922iuqoP-mWbaQERPc48964A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG53R5VQqqr0S6OU+13tcuxcvz922iuqoP-mWbaQERPc48964A@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 05, 2019 at 07:49:06AM +0530, Parav Pandit wrote:
> On Fri, Jun 28, 2019 at 2:20 PM Dag Moxnes <dag.moxnes@oracle.com> wrote:
> >
> > Use neighbour lock when copying MAC address from neighbour data struct
> > in dst_fetch_ha.
> >
> > When not using the lock, it is possible for the function to race with
> > neigh_update, causing it to copy an invalid MAC address.
> >
> > It is possible to provoke this error by calling rdma_resolve_addr in a
> > tight loop, while deleting the corresponding ARP entry in another tight
> > loop.
> >
> > Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>
> > Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> >
> > ---
> > v1 -> v2:
> >    * Modified implementation to improve readability
> > ---
> >  drivers/infiniband/core/addr.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> > index 2f7d141598..51323ffbc5 100644
> > --- a/drivers/infiniband/core/addr.c
> > +++ b/drivers/infiniband/core/addr.c
> > @@ -333,11 +333,14 @@ static int dst_fetch_ha(const struct dst_entry *dst,
> >         if (!n)
> >                 return -ENODATA;
> >
> > -       if (!(n->nud_state & NUD_VALID)) {
> > +       read_lock_bh(&n->lock);
> > +       if (n->nud_state & NUD_VALID) {
> > +               memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
> > +               read_unlock_bh(&n->lock);
> > +       } else {
> > +               read_unlock_bh(&n->lock);
> >                 neigh_event_send(n, NULL);
> >                 ret = -ENODATA;
> > -       } else {
> > -               memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
> >         }
> >
> >         neigh_release(n);
> > --
> > 2.20.1
> >
> Reviewed-by: Parav Pandit <parav@mellanox.com>
>
> A sample trace such as below in commit message would be good to have.
> Or the similar one that you noticed with ARP delete sequence.
>
> neigh_changeaddr()
>   neigh_flush_dev()
>    n->nud_state = NUD_NOARP;
>
> Having some issues with office outlook, so replying via gmail.

Your replies from gmail looks much better when you used Outlook - proper
spacing between quoted text and your reply.

Thanks
