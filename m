Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7B6288C3E
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 17:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389206AbgJIPID (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 11:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388736AbgJIPIC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 11:08:02 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A69C0613D2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Oct 2020 08:08:00 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ev17so4907645qvb.3
        for <linux-rdma@vger.kernel.org>; Fri, 09 Oct 2020 08:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R9aaBLk/u+1KAORjhK2ErMlFURKDY1YrT8QM4YAs2Kc=;
        b=DZWC9zQ0qmkDVmEWeiwDfRkPKy2fz5bUTPwHnLGLDFfexUItuN8ZtqKhO6lkWxztxF
         u+TvnqsOekahII4vHw9mkW/w9ytXCfp45BuH6J9SSVdykMxusqoN/lUBOcp4rvLjnOD/
         vMj9/JwCwh77KurgLaBmr729IfsRV9oC8vCBHM0kbzB+Hz1xqXXEmeTQStWlybXy2BVa
         NLSxAWGXDqLIBgEo9Ogjby2P0Mymb1qWg0tgHVFUUXMW4b4sWrnPgon7aljalmYAFenk
         2t93U2xsiiR3hHQGbwIF/iJ0CpGz6g0cJQLw2b+QjNivNXROUoFvdmiv8WnSgee7ECB/
         4T7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R9aaBLk/u+1KAORjhK2ErMlFURKDY1YrT8QM4YAs2Kc=;
        b=cbMKjJpsFjEzIFkAjN9oI/BelrT6Xad8EKekA0Xz7XZX6ertzgHXVHaL5QB2o2ZFzz
         ocYTIXH2EPcsFLAU7kbaWCLZimrw+iY9AFjJX7BQ2HoM8W5hv3l5EQ0WyjUJmGSYnxx6
         Med8P1anehl7eMMxUg1T1dCDARGwh6Q0JLCB5Ikg545yRudTlPf0ph4i5LtY2M3eWgNj
         XZm4rFkv6W6mxyFNh4VTk7hir5FT+oGnWKG9VEKEDcRp85Gas/JCDzUhcbS3eIJ8qg/D
         3OPKdnbPELBE9w9XUw0mFhmeyQfw1MB+FGokUNwf7NXP/58uAVK8fj9k5kYnF7lM+XFm
         gtKg==
X-Gm-Message-State: AOAM5331efOeho5m2FXNNiiYxK0ipipK/9CsrrSPFmLJ9u4GxWlh2Cla
        KHXYX6OdM5gFaoMNYGT7Q/411w==
X-Google-Smtp-Source: ABdhPJwjbMTUGSFGPkGIWia3g70IqBT+y5eFylR+0vfzwkiBT454k6clUsjb07UpmWbBZUsOZcv0yg==
X-Received: by 2002:a0c:abc7:: with SMTP id k7mr12817780qvb.45.1602256079962;
        Fri, 09 Oct 2020 08:07:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 129sm2976480qkf.62.2020.10.09.08.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:07:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQtzy-0020QR-M4; Fri, 09 Oct 2020 12:07:58 -0300
Date:   Fri, 9 Oct 2020 12:07:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chucklever@gmail.com>
Cc:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
Message-ID: <20201009150758.GV5177@ziepe.ca>
References: <20201007111636.GD3678159@unreal>
 <4d29915c-3ed7-0253-211b-1b97f5f8cfdf@oracle.com>
 <20201008103641.GM13580@unreal>
 <aec6906d-7be5-b489-c7dc-0254c4538723@oracle.com>
 <20201008160814.GF5177@ziepe.ca>
 <727de097-4338-c1d8-73a0-1fce0854f8af@oracle.com>
 <20201009143940.GT5177@ziepe.ca>
 <0E82FB51-244C-4134-8F74-8C365259DCD5@gmail.com>
 <20201009145706.GU5177@ziepe.ca>
 <EC7EE276-3529-4374-9F90-F061AAC3B952@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EC7EE276-3529-4374-9F90-F061AAC3B952@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 09, 2020 at 11:00:22AM -0400, Chuck Lever wrote:
> 
> 
> > On Oct 9, 2020, at 10:57 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Fri, Oct 09, 2020 at 10:48:55AM -0400, Chuck Lever wrote:
> >> Hi Jason-
> >> 
> >>> On Oct 9, 2020, at 10:39 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >>> 
> >>> On Fri, Oct 09, 2020 at 12:49:30PM +0800, Ka-Cheong Poon wrote:
> >>>> As I mentioned before, this is a very serious restriction on how
> >>>> the RDMA subsystem can be used in a namespace environment by kernel
> >>>> module.  The reason given for this restriction is that any kernel
> >>>> socket without a corresponding user space file descriptor is "rogue".
> >>>> All Internet protocol code create a kernel socket without user
> >>>> interaction.  Are they all "rogue"?
> >>> 
> >>> You should work with Chuck to make NFS use namespaces properly and
> >>> then you can propose what changes might be needed with a proper
> >>> justification.
> >> 
> >> The NFS server code already uses namespaces for creating listener
> >> endpoints, already has a user space component that drives the
> >> creation of listeners, and already passes an appropriate struct
> >> net to rdma_create_id. As far as I am aware, it is namespace-aware
> >> and -friendly all the way down to rdma_create_id().
> >> 
> >> What more needs to be done?
> > 
> > I have no idea, if you are able to pass a namespace all the way down
> > to the listening cm_id and everything works right (I'm skeptical) then
> > there is nothing more to worry about - why are we having this thread?
> 
> The thread is about RDS, not NFS. NFS has some useful examples to
> crib, but it's not the main point.
> 
> I don't think NFS/RDMA namespacing works today, but it's not because
> NFS isn't ready. I agree that is another thread.

Exactly, so instead of talking about RDS stuff without any patches,
let's talk about NFS with patches - if you can make NFS work then I
assume RDS will be happy.

NFS has an established model for using namespaces that the other
transports uses, so I'd rather focus on this.

> >>> The rules for lifetime on IB clients are tricky, and the interaction
> >>> with namespaces makes it all a lot more murky.
> >> 
> >> I think what Ka-cheong is asking is for a detailed explanation of
> >> these lifetime rules so we can understand why rdma_create_id bumps
> >> the namespace reference count.
> > 
> > It is because the CM has no code to revoke a CM ID before the
> > namespace goes away and the pointer becomes invalid.
> 
> Is it just a question of "no-one has yet written this code" or is
> there a deeper technical reason why this has not been done?

It is hard to know without spending a big deep look at this
stuff.

Jason
