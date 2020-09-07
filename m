Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BEE25F7E6
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 12:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgIGKWc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 06:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728453AbgIGKWa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 06:22:30 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CA01204FD;
        Mon,  7 Sep 2020 10:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599474149;
        bh=3P2Z+2V5DwnqRPwKxqu8Rf6Bzqpekt0TaGnSYMZL8BA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVHvRfPHsXan2YlBWsott8O/yo/lQfFCtGZr9b+z/3vOHX4sBD3GAmIjuXHkCNneE
         nTfOd1Gvrkae/vHhKrgnXO+2BswvOjfIKz3hgAh8k38vVqRR/rGYt9W+V298djeN4X
         7adHPwLdd+p5DbUcdnv3/pKnkZD5Khzk65FzhEJA=
Date:   Mon, 7 Sep 2020 13:22:25 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: Finding the namespace of a struct ib_device
Message-ID: <20200907102225.GA421756@unreal>
References: <20200903173910.GO24045@ziepe.ca>
 <a5899aa9-4553-1307-0688-f07f3a919ce8@oracle.com>
 <20200904113244.GP24045@ziepe.ca>
 <be812cb4-4b80-5ee5-4ed8-9d44f0a06edd@oracle.com>
 <20200906074442.GE55261@unreal>
 <9f8984ec-31e4-d71e-d55e-5cf115066e96@oracle.com>
 <20200907071819.GL55261@unreal>
 <69fdae5f-5824-9151-0a00-a7453382eee0@oracle.com>
 <20200907090438.GM55261@unreal>
 <27a60d6d-0e86-6fc6-f4e9-2893c824ba56@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27a60d6d-0e86-6fc6-f4e9-2893c824ba56@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 05:28:23PM +0800, Ka-Cheong Poon wrote:
> On 9/7/20 5:04 PM, Leon Romanovsky wrote:
> > On Mon, Sep 07, 2020 at 04:24:26PM +0800, Ka-Cheong Poon wrote:
> > > On 9/7/20 3:18 PM, Leon Romanovsky wrote:
> > > > On Mon, Sep 07, 2020 at 11:33:38AM +0800, Ka-Cheong Poon wrote:
> > > > > On 9/6/20 3:44 PM, Leon Romanovsky wrote:
> > > > > > On Fri, Sep 04, 2020 at 10:02:10PM +0800, Ka-Cheong Poon wrote:
> > > > > > > On 9/4/20 7:32 PM, Jason Gunthorpe wrote:
> > > > > > > > On Fri, Sep 04, 2020 at 12:01:12PM +0800, Ka-Cheong Poon wrote:
> > > > > > > > > On 9/4/20 1:39 AM, Jason Gunthorpe wrote:
> > > > > > > > > > On Thu, Sep 03, 2020 at 10:02:01PM +0800, Ka-Cheong Poon wrote:
> > > > > > > > > > > When a struct ib_client's add() function is called. is there a
> > > > > > > > > > > supported method to find out the namespace of the passed in
> > > > > > > > > > > struct ib_device?  There is rdma_dev_access_netns() but it does
> > > > > > > > > > > not return the namespace.  It seems that it needs to have
> > > > > > > > > > > something like the following.
> > > > > > > > > > >
> > > > > > > > > > > struct net *rdma_dev_to_netns(struct ib_device *ib_dev)
> > > > > > > > > > > {
> > > > > > > > > > >             return read_pnet(&ib_dev->coredev.rdma_net);
> > > > > > > > > > > }
> > > > > > > > > > >
> > > > > > > > > > > Comments?
> > > > > > > > > >
> > > > > > > > > > I suppose, but why would something need this?
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > If the client needs to allocate stuff for the namespace
> > > > > > > > > related to that device, it needs to know the namespace of
> > > > > > > > > that device.  Then when that namespace is deleted, the
> > > > > > > > > client can clean up those related stuff as the client's
> > > > > > > > > namespace exit function can be called before the remove()
> > > > > > > > > function is triggered in rdma_dev_exit_net().  Without
> > > > > > > > > knowing the namespace of that device, coordination cannot
> > > > > > > > > be done.
> > > > > > > >
> > > > > > > > Since each device can only be in one namespace, why would a client
> > > > > > > > ever need to allocate at a level more granular than a device?
> > > > > > >
> > > > > > >
> > > > > > > A client wants to have namespace specific info.  If the
> > > > > > > device belongs to a namespace, it wants to associate those
> > > > > > > info with that device.  When a namespace is deleted, the
> > > > > > > info will need to be deleted.  You can consider the info
> > > > > > > as associated with both a namespace and a device.
> > > > > >
> > > > > > Can you be more specific about which info you are talking about?
> > > > >
> > > > >
> > > > > Actually, a lot of info can be both namespace and device specific.
> > > > > For example, a client wants to have a different PD allocation policy
> > > > > with a device when used in different namespaces.
> > > > >
> > > > >
> > > > > > And what is the client that is net namespace-aware from one side,
> > > > > > but from another separate data between them "manually"?
> > > > >
> > > > >
> > > > > Could you please elaborate what is meant by "namespace aware from
> > > > > one side but from another separate data between them manually"?
> > > > > I understand what namespace aware means.  But it is not clear what
> > > > > is meant by "separating data manually".  Do you mean having different
> > > > > behavior in different namespaces?  If this is the case, there is
> > > > > nothing special here.  An admin may choose to have different behavior
> > > > > in different namespaces.  There is nothing manual going on in the
> > > > > client code.
> > > >
> > > > We are talking about net-namespaces, and as we wrote above, the ib_device
> > > > that supports such namespace can exist only in a single one
> > > >
> > > > The client that implemented such support can check its namespace while
> > > > "client->add" is called. It should be equal to be seen by ib_device.
> > > >
> > > > See:
> > > >    rdma_dev_change_netns ->
> > > >    	enable_device_and_get ->
> > > > 		add_client_context ->
> > > > 			client->add(device)
> > >
> > >
> > > This is the original question.  How does the client's add() function
> > > know the namespace of device?  What is your suggestion in finding
> > > the net namespace of device at add() time?
> >
> > As I wrote above, "It should be equal to be seen by ib_device.", check net
> > namespace of your client.
>
>
> Could you please be more specific?  A client calls ib_register_client() to
> register with the RDMA framework.  Then when a device is added, the client's
> add() function is called with the struct ib_device.  How does the client
> find out the namespace "seen by the ib_device"?  Do you mean that there is
> a variant of ib_register_client() which can take a net namespace as parameter?
> Or is there a variant of struct ib_client which has a net namespace field?
> Or?  Thanks.

"Do you mean that there is a variant of ib_register_client()
which can take a net namespace as parameter?"

No, it doesn't exist but it is easy to extend and IMHO the right
thing to do.

Thanks
