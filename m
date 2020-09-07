Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1DD25F3C0
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 09:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgIGHSY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 03:18:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgIGHSY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 03:18:24 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AC36206B8;
        Mon,  7 Sep 2020 07:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599463103;
        bh=XFe807ZuQgw2AlO0jWYmd5bH47skGeiqW9xl+UUwguc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UZ7lNYt0y4OdYvOc/WXrr4ZDt2sxJMvJbJz2zpjHHWz2lLT9E9+YReaTEJY9LhgBL
         /sJZEtnpfLh1N4bRkDT6FKjWV/B/qp7JXg+7Hfa0eUJVV55MPTRO0gIiVbQG7ThIRf
         Qr55RzuIH6PkZegI595a9Gx8ggp2tiPpMyEGvIH8=
Date:   Mon, 7 Sep 2020 10:18:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: Finding the namespace of a struct ib_device
Message-ID: <20200907071819.GL55261@unreal>
References: <5fa7f367-49df-fb1d-22d0-9f1dd1b76915@oracle.com>
 <20200903173910.GO24045@ziepe.ca>
 <a5899aa9-4553-1307-0688-f07f3a919ce8@oracle.com>
 <20200904113244.GP24045@ziepe.ca>
 <be812cb4-4b80-5ee5-4ed8-9d44f0a06edd@oracle.com>
 <20200906074442.GE55261@unreal>
 <9f8984ec-31e4-d71e-d55e-5cf115066e96@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f8984ec-31e4-d71e-d55e-5cf115066e96@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 11:33:38AM +0800, Ka-Cheong Poon wrote:
> On 9/6/20 3:44 PM, Leon Romanovsky wrote:
> > On Fri, Sep 04, 2020 at 10:02:10PM +0800, Ka-Cheong Poon wrote:
> > > On 9/4/20 7:32 PM, Jason Gunthorpe wrote:
> > > > On Fri, Sep 04, 2020 at 12:01:12PM +0800, Ka-Cheong Poon wrote:
> > > > > On 9/4/20 1:39 AM, Jason Gunthorpe wrote:
> > > > > > On Thu, Sep 03, 2020 at 10:02:01PM +0800, Ka-Cheong Poon wrote:
> > > > > > > When a struct ib_client's add() function is called. is there a
> > > > > > > supported method to find out the namespace of the passed in
> > > > > > > struct ib_device?  There is rdma_dev_access_netns() but it does
> > > > > > > not return the namespace.  It seems that it needs to have
> > > > > > > something like the following.
> > > > > > >
> > > > > > > struct net *rdma_dev_to_netns(struct ib_device *ib_dev)
> > > > > > > {
> > > > > > >           return read_pnet(&ib_dev->coredev.rdma_net);
> > > > > > > }
> > > > > > >
> > > > > > > Comments?
> > > > > >
> > > > > > I suppose, but why would something need this?
> > > > >
> > > > >
> > > > > If the client needs to allocate stuff for the namespace
> > > > > related to that device, it needs to know the namespace of
> > > > > that device.  Then when that namespace is deleted, the
> > > > > client can clean up those related stuff as the client's
> > > > > namespace exit function can be called before the remove()
> > > > > function is triggered in rdma_dev_exit_net().  Without
> > > > > knowing the namespace of that device, coordination cannot
> > > > > be done.
> > > >
> > > > Since each device can only be in one namespace, why would a client
> > > > ever need to allocate at a level more granular than a device?
> > >
> > >
> > > A client wants to have namespace specific info.  If the
> > > device belongs to a namespace, it wants to associate those
> > > info with that device.  When a namespace is deleted, the
> > > info will need to be deleted.  You can consider the info
> > > as associated with both a namespace and a device.
> >
> > Can you be more specific about which info you are talking about?
>
>
> Actually, a lot of info can be both namespace and device specific.
> For example, a client wants to have a different PD allocation policy
> with a device when used in different namespaces.
>
>
> > And what is the client that is net namespace-aware from one side,
> > but from another separate data between them "manually"?
>
>
> Could you please elaborate what is meant by "namespace aware from
> one side but from another separate data between them manually"?
> I understand what namespace aware means.  But it is not clear what
> is meant by "separating data manually".  Do you mean having different
> behavior in different namespaces?  If this is the case, there is
> nothing special here.  An admin may choose to have different behavior
> in different namespaces.  There is nothing manual going on in the
> client code.

We are talking about net-namespaces, and as we wrote above, the ib_device
that supports such namespace can exist only in a single one

The client that implemented such support can check its namespace while
"client->add" is called. It should be equal to be seen by ib_device.

See:
 rdma_dev_change_netns ->
 	enable_device_and_get ->
		add_client_context ->
			client->add(device)


"Manual" means that client will store results of first client->add call
(in init_net NS) and will use globally stored data for other NS, which
is not netdev way to work with namespaces. The expectation that they are
separated without shared data between.

Thanks

>
>
> --
> K. Poon
> ka-cheong.poon@oracle.com
>
>
