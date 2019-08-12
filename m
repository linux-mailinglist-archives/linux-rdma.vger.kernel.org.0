Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39F5B89DBA
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 14:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfHLML1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 08:11:27 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42623 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLML1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Aug 2019 08:11:27 -0400
Received: by mail-qt1-f194.google.com with SMTP id t12so13905536qtp.9
        for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2019 05:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FMIYztXFKkl4SKTYna0rjSXYBwn+KInzfbM7bzWxNRw=;
        b=UbGO6yDlekknZcxgkoyEnp8VTkTABCYfNpfYZDSVqXys1a0tQlHlWjy5lpoeALLPv+
         ELiU99ZSZuh9WQho07Km1IMIYxjiH2TyYRBpOmSpzb0LfcRRDQ6W+/paBQhCGfPO/U3E
         1uax7g3eQw3wn5iwt/aU5WNG5Azp2zF/0IIgur2M/4Eaq8ZgDFUFrZpojvrS9CpbXYFT
         pVrsr8xy5xnAGGPITKMlBa5G+iFNUqoV1F3tA7cZPsQhuZuoO60xcXrSu0JhGAMpmFg/
         6Nk9AvIvwRZIghWB3c5CNOJNuTXDDiR7UjGF2VUa60RaVnAmCBndcVB/9vL1/84fxcdh
         EE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FMIYztXFKkl4SKTYna0rjSXYBwn+KInzfbM7bzWxNRw=;
        b=sJuIk+zdG8rDv5sXZ3RwXFSNh6LqWQECf/6ed9GS5uBOoLY7LupknEKWlPgAjetYhm
         +2HKxDDOsCIHuwpxkoE/m7xW1r+zZ63DbG0Tvf26X+XInJ9LGfk7esaGKnvPfWLLnkZk
         9nHOv5WXM3bwnq3FihR0UJyvjWDkdymYQ/wF1nNh71qv141Udaw50XPsP0GUCbXa3ITP
         gf/Vi15u8//c76dfqFwlkbMdLbACImz3AnDsrHSZJ0QnwVkbhfP3be3ES9wCbmQh/LNQ
         /W0qafjMjfvJKhhR2sdPcWqF6IKBTFuOPeZI3U9SglawpWyMqrb4QQyI7ClK0E90q+kF
         zngw==
X-Gm-Message-State: APjAAAWlHFb5X/rBaagKKcTsJYeBcQnR0kB1Zm4Zzt6Lnf09ncgWE/s9
        HB0ZIr5hVxxE3BwhXibFA0PkFA==
X-Google-Smtp-Source: APXvYqyavzdi9S02K/TZtgSFRDCbXCAV9o3aFCSBqsc2NPbeIZZprtnK89SA3AaOjt9KEvJm2kCtiw==
X-Received: by 2002:a0c:9695:: with SMTP id a21mr30070157qvd.24.1565611885797;
        Mon, 12 Aug 2019 05:11:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id d123sm48628699qkb.94.2019.08.12.05.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 05:11:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hx9Aa-0006zo-NH; Mon, 12 Aug 2019 09:11:24 -0300
Date:   Mon, 12 Aug 2019 09:11:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next 2/6] RDMA/umem: Add ODP type indicator within
 ib_umem_odp
Message-ID: <20190812121124.GA24457@ziepe.ca>
References: <20190807103403.8102-1-leon@kernel.org>
 <20190807103403.8102-3-leon@kernel.org>
 <20190807114406.GC1571@mellanox.com>
 <20190807121335.GC32366@mtr-leonro.mtl.com>
 <20190807123510.GF1557@ziepe.ca>
 <20190807131239.GF32366@mtr-leonro.mtl.com>
 <20190812105324.GA29138@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812105324.GA29138@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 12, 2019 at 01:53:24PM +0300, Leon Romanovsky wrote:
> On Wed, Aug 07, 2019 at 04:12:39PM +0300, Leon Romanovsky wrote:
> > On Wed, Aug 07, 2019 at 09:35:10AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Aug 07, 2019 at 03:13:35PM +0300, Leon Romanovsky wrote:
> > > > On Wed, Aug 07, 2019 at 11:44:16AM +0000, Jason Gunthorpe wrote:
> > > > > On Wed, Aug 07, 2019 at 01:33:59PM +0300, Leon Romanovsky wrote:
> > > > > > From: Erez Alfasi <ereza@mellanox.com>
> > > > > >
> > > > > > ODP type can be divided into 2 subclasses:
> > > > > > Explicit and Implicit ODP.
> > > > > >
> > > > > > Adding a type enums and an odp type flag within
> > > > > > ib_umem_odp will give us an indication whether a
> > > > > > given MR is ODP implicit/explicit registered.
> > > > > >
> > > > > > Signed-off-by: Erez Alfasi <ereza@mellanox.com>
> > > > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > > > >  drivers/infiniband/core/umem.c    |  1 +
> > > > > >  include/rdma/ib_umem_odp.h        | 14 ++++++++++++++
> > > > > >  include/uapi/rdma/ib_user_verbs.h |  5 +++++
> > > > > >  3 files changed, 20 insertions(+)
> > > > >
> > > > > No for this patch, I've got a series cleaning up this
> > > > > implicit/explicit nonsense, and the result is much cleaner than this.
> > > >
> > > > It doesn't really clean anything, just stores implicit/explicit information.
> > > >
> > > > >
> > > > > This series will have to wait.
> > > >
> > > > The information exposed in this series is already available in uverbs,
> > > > so whatever cleanup will come, we still need to expose ODP MR type.
> > > >
> > > > This patch is tiny part of whole series, why should we block whole
> > > > series and iproute2?
> > >
> > > This whole approach is really ugly, I even object to the very idea of
> > > patch #1
> >
> > How did patch #1 relate? It simply removed same code from drivers and
> > put it in one place.
> >
> > >
> > > The umem is an internal detail and should not be exposed out of the
> > > driver for nldev to use.
> >
> > We are exporting ODP MR property, users are not aware of umem thing
> > underneath at all.
> 
> Jason ???
> 
> I don't want to send iproute2 and make noise if the kernel part is
> put on hold.

Like I said, this is layered wrong and does not support the direction
I want to go in with the ODP code, needs respin.

Jason
