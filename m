Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A94AC20AF2
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 17:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfEPPTq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 11:19:46 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34875 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfEPPTq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 May 2019 11:19:46 -0400
Received: by mail-qk1-f195.google.com with SMTP id c15so2511196qkl.2
        for <linux-rdma@vger.kernel.org>; Thu, 16 May 2019 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8yzQG2JUhkeNWNSE4c3FZWE2OFZ5FLvRsBTIJLGCm5c=;
        b=dxwTn4nDyt+l2iubbp5hrHb1l0I4Ya1UuysVAIyqNnae0pZZdnFs+seQ9MMCnSlQAi
         A7+zPYONEdZ8KNdcj0GGIQbRj/hBLDRK9iehmEk/ECl2XOnHmzdzjEjI8J/Rj7D9gfZE
         42xSXPHz1u+drGBhVBLtVNxjvJhDxtK7iuFO8+u65e7+tlupJ+zrJiWBdP4qCWHXsjuh
         bnyN3XYX8v0BBVRUlMLriyjGzbOt642YjIBxCqMV1Nr1Nl9G9Hurk5L+rBe9hGSxqjtH
         Yoiy5zdwIkoDX5ZAT1UxsDxpHCCu5SMOtfRsPOeKFfTrdNr9MG0CERir5WxQqWZ0lHYf
         Ko5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8yzQG2JUhkeNWNSE4c3FZWE2OFZ5FLvRsBTIJLGCm5c=;
        b=KKjRYyoJXw29/0kJHi8RttZWqShJVBhqvqxPihq8daX3v4glzoevWbkOUUZb4V0hvm
         jvdsntpTgo36gewkLAG6/AHxKmgtNuM74ahW6InLNQK8h2I4+hkjEytPAJYXYEvPhyw+
         aU2ekaUGZ1+NKmEZ46SdR0NEU1OICascE+qLIk98WFwIOas5tnyPz/xd7YF1xTF/WaaT
         re78NgPPX/8+h/WnDd0zP69BQyT7wmt8lWAi9b1uUX7C3z6J5PZREUty0erF25y92aCT
         i0s9xjFcxJriao9dA8wz3mh9gWleOrYN38mdP2PPzT/836aXw33V8uDUCEFN7Y1/3phn
         hEQg==
X-Gm-Message-State: APjAAAVEXZB0iaPEMS9BPA2+oVXsPt27MnMkpkK8ZE7a34mFjmorPmD4
        q+0ivSOIiLUf/hV/6S0iEou5Aw==
X-Google-Smtp-Source: APXvYqyhjVrbxBn1nXzPnCAezdyEHItqrTFuEWqsJFLTdiFXl/jeVMS5qCKVhrwJsf5yw49q/tSVyg==
X-Received: by 2002:a37:a157:: with SMTP id k84mr39094925qke.250.1558019985426;
        Thu, 16 May 2019 08:19:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id v185sm2755683qkb.0.2019.05.16.08.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 08:19:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hRIAa-0001kA-69; Thu, 16 May 2019 12:19:44 -0300
Date:   Thu, 16 May 2019 12:19:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/providers: Simplify ib_modify_port for
 RoCE providers
Message-ID: <20190516151944.GC22587@ziepe.ca>
References: <20190516105308.29450-1-kamalheib1@gmail.com>
 <20190516111607.GA22587@ziepe.ca>
 <3c53c827f287df7f46b58c7f5e2fd23207a83683.camel@gmail.com>
 <20190516113750.GB22587@ziepe.ca>
 <8f4116c03236210e3481fae7e4ff51dfbad6c980.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f4116c03236210e3481fae7e4ff51dfbad6c980.camel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 16, 2019 at 02:52:48PM +0300, Kamal Heib wrote:
> On Thu, 2019-05-16 at 08:37 -0300, Jason Gunthorpe wrote:
> > On Thu, May 16, 2019 at 02:28:40PM +0300, Kamal Heib wrote:
> > > On Thu, 2019-05-16 at 08:16 -0300, Jason Gunthorpe wrote:
> > > > On Thu, May 16, 2019 at 01:53:08PM +0300, Kamal Heib wrote:
> > > > > For RoCE ports the call for ib_modify_port is not meaningful,
> > > > > so
> > > > > simplify the providers of RoCE by return OK in ib_core.
> > > > > 
> > > > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > > >  drivers/infiniband/core/device.c              | 23 ++++++-----
> > > > >  drivers/infiniband/hw/hns/hns_roce_main.c     |  7 ----
> > > > >  drivers/infiniband/hw/mlx4/main.c             |  8 ----
> > > > >  drivers/infiniband/hw/mlx5/main.c             |  6 ---
> > > > >  drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  1 -
> > > > >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  6 ---
> > > > >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  2 -
> > > > >  drivers/infiniband/hw/qedr/main.c             |  1 -
> > > > >  drivers/infiniband/hw/qedr/verbs.c            |  6 ---
> > > > >  drivers/infiniband/hw/qedr/verbs.h            |  2 -
> > > > >  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  1 -
> > > > >  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   | 38 ---------
> > > > >  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  2 -
> > > > >  drivers/infiniband/sw/rxe/rxe_verbs.c         | 18 ---------
> > > > >  14 files changed, 14 insertions(+), 107 deletions(-)
> > > > 
> > > > We have more roce only drivers than this, why isn't everything
> > > > changed?
> > > > 
> > > > Jason
> > > 
> > > Not all of them implements modify_port().
> > 
> > Then why didn't we just delete modify port from the other drivers?
> > 
> > Jason
> 
> This patch is doing that for all roce drivers that implement modify
> port, unless you mean none-roce drivers?

I mean just delete it without any change to the core code.. Here we
are now changing some roce drivers to have a working modify_port

It is confusing what the intention is

Jason
