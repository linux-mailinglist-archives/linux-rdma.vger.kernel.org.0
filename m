Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F4D205872
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 19:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbgFWRXY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 13:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgFWRXY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jun 2020 13:23:24 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFC5C061573
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 10:23:24 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t7so1182362qvl.8
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gw8psqz+LsdrQykbanEcSIZrUl30WUVM4eD6OVwcjMI=;
        b=DAKuPd7qO7XZ8um/Zh8jdfigims3lKCWHHkVOvR8gOxvCwuxxhM4+CgFwTEwzxhXMS
         dH+ugBNS8/MTeDx/VaPb1fSwN3CyWlGQpnAfaDGVEWTIH53ooIwS3Nv3+dxcRPBO9kHZ
         vpDX+YAQMZ6ZBuDEUNzMknpmNe9X4qE219JmF6a78vNVp5LVn22wBwhH92TmrwNQCMF4
         FWfYZ6K+UBR89Y+1AhBFYG3JOdYLiEIWbWeciM5OYSICF08QeL8kEaxJcf8MxO6JpKP+
         XYFiWVjMNQYJ5V4aJOPpZyaPKvjaNsvd6vAZNbwMAaS9+cIIfxtRRd8RDyOT/UWjzzu+
         a96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gw8psqz+LsdrQykbanEcSIZrUl30WUVM4eD6OVwcjMI=;
        b=U5CKsqIoG2uKzpTeVwzPUafqRQHh5YaNhWOXa39wBF3JNlicQn0L+jX/lXkYlo6ocy
         kNJ86PD9eK+TH6JQXfM6XSH5GiKOYEjh7oBcQ14+xLRrvofmZQxbJSMTGPT38/015f15
         3zZnOn/X//Lr4YzFZhUzIUY+FRrnghS7UHo6uZdy6W97hH7SXmJEXtLKc15lpwojeMdF
         s0SQWkiO36dEYNyb4qZCkKGYnjpdD0Z3JnEL8A6yY82I3ntZSrFx3IH7Ik0ATnk0PGq4
         bVf/gPJfZhHNdR5eMFetMwAsLuDoDqF/1Z9700a0NdYwlGEkg8UiDXs/BvsDe+Tiyhan
         foGw==
X-Gm-Message-State: AOAM531cNJ1sUGMvrTSBasW4ZEmihR3kwapMV1hDFwiC5Wlc6VK65JHP
        RugsJ7D4Vu3Bgqq2W1A/e76VOQ==
X-Google-Smtp-Source: ABdhPJzTDOZeKHcl2foVCoytl0us5md/Z1N3AYXOx/ECHpEq5TE1o7N9efFhag5/TNMwYua5UWRxlg==
X-Received: by 2002:ad4:49aa:: with SMTP id u10mr28418798qvx.162.1592933003146;
        Tue, 23 Jun 2020 10:23:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id m26sm1280405qtm.73.2020.06.23.10.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 10:23:22 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jnmdl-00Cxwy-Ih; Tue, 23 Jun 2020 14:23:21 -0300
Date:   Tue, 23 Jun 2020 14:23:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Haris Iqbal <haris.iqbal@cloud.ionos.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>, dledford@redhat.com,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH] Delay the initialization of rnbd_server module to
 late_initcall level
Message-ID: <20200623172321.GC6578@ziepe.ca>
References: <20200617182046.GI6578@ziepe.ca>
 <20200617190756.GA2721989@unreal>
 <20200617192642.GL6578@ziepe.ca>
 <CAJpMwygeJ7uaNUKxhsF-bx=ufchkx7M6G0E237=-0C7GwJ3yog@mail.gmail.com>
 <CAJpMwyjJSu4exkTAoFLhY-ubzNQLp6nWqq83k6vWn1Uw3eaK_Q@mail.gmail.com>
 <CAJpMwygqz20=H7ovSL0nSWLbVpMv-KLOgYO=nRCLv==OC8sgHw@mail.gmail.com>
 <20200623121721.GZ6578@ziepe.ca>
 <CAJpMwyj_Fa6AhYXcGh4kS79Vd2Dy3N7B5-9XhKHn4qWDo-HVjw@mail.gmail.com>
 <20200623142400.GB6578@ziepe.ca>
 <CAJpMwygDGpzmhzeYcy=14sBneSriBcRT6B2sO1rubkQLRKnOjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwygDGpzmhzeYcy=14sBneSriBcRT6B2sO1rubkQLRKnOjA@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 23, 2020 at 05:05:51PM +0530, Haris Iqbal wrote:
> On Tue, Jun 23, 2020 at 7:54 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Jun 23, 2020 at 07:15:03PM +0530, Haris Iqbal wrote:
> > > On Tue, Jun 23, 2020 at 5:47 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Tue, Jun 23, 2020 at 03:20:27PM +0530, Haris Iqbal wrote:
> > > > > Hi Jason and Leon,
> > > > >
> > > > > Did you get a chance to look into my previous email?
> > > >
> > > > Was there a question?
> > >
> > > Multiple actually :)
> > >
> > > >
> > > > Jason
> > >
> > > In response to your emails,
> > >
> > > > Somehow nvme-rdma works:
> > >
> > > I think that's because the callchain during the nvme_rdma_init_module
> > > initialization stops at "nvmf_register_transport()". Here only the
> > > "struct nvmf_transport_ops nvme_rdma_transport" is registered, which
> > > contains the function "nvme_rdma_create_ctrl()". I tested this in my
> > > local setup and during kernel boot, that's the extent of the
> > > callchain.
> > > The ".create_ctrl"; which now points to "nvme_rdma_create_ctrl()" is
> > > called later from "nvmf_dev_write()". I am not sure when this is
> > > called, probably when the "discover" happens from the client side or
> > > during the server config.
> > >
> > > It seems that the "rdma_bind_addr()" is called by the nvme rdma
> > > module; but during the following events
> > > 1) When a discover happens from the client side. Call trace for that looks like,
> > > [ 1098.409398] nvmf_dev_write
> > > [ 1098.409403] nvmf_create_ctrl
> > > [ 1098.414568] nvme_rdma_create_ctrl
> > > [ 1098.415009] nvme_rdma_setup_ctrl
> > > [ 1098.415010] nvme_rdma_configure_admin_queue
> > > [ 1098.415010] nvme_rdma_alloc_queue
> > > [ 1098.415032] rdma_resolve_addr
> > > [ 1098.415032] cma_bind_addr
> > > [ 1098.415033] rdma_bind_addr
> > >
> > > 2) When a connect happens from the client side. Call trace is the same
> > > as above, plus "nvme_rdma_alloc_queue()" is called n number of times;
> > > n being the number of IO queues being created.
> > >
> > > On the server side, when an nvmf port is enabled, that also triggers a
> > > call to "rdma_bind_addr()", but that is not from the nvme rdma module.
> > > may be nvme target rdma? (not sure).
> > >
> > > Does this make sense or am I missing something here?
> >
> > It make sense, delaying creating and CM ID's until user space starts
> > will solve this init time problme
> 
> Right, and the patch is trying to achieve the delay by changing the
> init level to "late_initcall()"

It should not be done with initcall levels

> > Right rdma_create_id() must precede anything that has problems, and it
> > should not be done from module_init.
> 
> I understand this, but I am not sure why that is; as in why it should
> not be done from module_init?

Because that is how our module ordering scheme works

> > It is not OK to create RDMA CM IDs outside
> > a client - CM IDs are supposed to be cleaned up when the client is
> > removed.
> >
> > Similarly they are supposed to be created from the client attachment.
> 
> This again is a little confusing to me, since what I've observed in
> nvmt is, when a server port is created, the "rdma_bind_addr()"
> function is called.
> And this goes well with the server/target and client/initiator model,
> where the server has to get ready and start listening before a client
> can initiate a connection.
> What am I missing here?

client means a struct ib_client

Jason

> 
> >
> > Jason
> 
