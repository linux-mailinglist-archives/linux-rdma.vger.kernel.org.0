Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7362C9F344
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 21:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfH0TZR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 15:25:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46995 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfH0TZR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 15:25:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so19924244wru.13
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2019 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8uxOvUS0CLmC08brbnOrY7MLibuZbjpCkI2EXp2DOCE=;
        b=Wm5iTTJF9PuqueSrM/raVJtGwSYZMvFcbLspZTAnym//7tJdPfOr1MGq/DSP4how1w
         6Uq0QXlVbWK9ksniI7lqgD81AkHUM1+yfUjUynPoFJ5KO9FxnAKv+WsygefbeQ2QeKSR
         LnIMUGDA+A6vNUaGOFsuXxAhYFAypIxJ0uFr4r+iwXw5+sTgvcqXVs5j5jNLdNSSmxio
         /28WnHnnAu2qdIOyt7xI2/0EPcO/zPgjZFv74SK9twosldYeU1k+ukH+FpoLAzCaMeus
         AIFE/oAKhE3P0o1FsA6OwhUgqqHwKosGPoQR4tH4v+Vhk1Wsy2tCk3JavvTtVSg3iK74
         K9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8uxOvUS0CLmC08brbnOrY7MLibuZbjpCkI2EXp2DOCE=;
        b=KsyaB1vHufKZ3TqyI11KTJ7DRlA6bs3W0dH+X1VWfTPKjZtcGX2S8Ucz8KkpclnzeA
         Ky4WQZsbY4VMYqqKMV4Y12NvHyUoN8cdFv4VjuUjFbbzHH3XebWVAQhFUDc/TC0Qs0fT
         s0phRycxT1W2q91U24yjr202L4NXEtfJmNstt7TTzppbIKIAwp1dOoifkYyv30LXOJSl
         wRnyje3a/4rt0ffFlUOuqfcPxP0XPyJ+PE/G2h15zOz0VOh55FM3OAB2CIdFaSI1NJBD
         rYendUJN3xQNXpHeEF6TIXw5o1HtfukBAN0+/Jq1tnfEOPiuyD2y3Gb3ldMcsUxReE5V
         86Tg==
X-Gm-Message-State: APjAAAWnAAdwVk/k7M6JTtz8bX9I/skCDmFOPyHRszs6stN1KAwtv4qy
        ezjvG+Sn6NGMF8c8sYa9wr1dtVYruTXgVQ==
X-Google-Smtp-Source: APXvYqyOAPDZGDXVkUPBRL2lhBq6HPYN6axfbP+igp8asO042Rbsb+9XQ78t0akDAmRRuBwBP+dZGg==
X-Received: by 2002:a5d:4946:: with SMTP id r6mr33063917wrs.266.1566933915177;
        Tue, 27 Aug 2019 12:25:15 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id g7sm160229wmh.1.2019.08.27.12.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 12:25:14 -0700 (PDT)
Date:   Tue, 27 Aug 2019 12:25:13 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "Guy Levi(SW)" <guyle@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Philip Li <philip.li@intel.com>,
        Rong Chen <rong.a.chen@intel.com>
Subject: Re: [PATCH rdma-next 08/12] RDMA/odp: Check for overflow when
 computing the umem_odp end
Message-ID: <20190827192513.GA24496@archlinux-threadripper>
References: <20190819111710.18440-1-leon@kernel.org>
 <20190819111710.18440-9-leon@kernel.org>
 <20190826164223.GA122752@archlinux-threadripper>
 <20190826165539.GF27031@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826165539.GF27031@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 26, 2019 at 04:55:45PM +0000, Jason Gunthorpe wrote:
> On Mon, Aug 26, 2019 at 09:42:23AM -0700, Nathan Chancellor wrote:
> > On Mon, Aug 19, 2019 at 02:17:06PM +0300, Leon Romanovsky wrote:
> > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > 
> > > Since the page size can be extended in the ODP case by IB_ACCESS_HUGETLB
> > > the existing overflow checks done by ib_umem_get() are not
> > > sufficient. Check for overflow again.
> > > 
> > > Further, remove the unchecked math from the inlines and just use the
> > > precomputed value stored in the interval_tree_node.
> > > 
> > > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > >  drivers/infiniband/core/umem_odp.c | 25 +++++++++++++++++++------
> > >  include/rdma/ib_umem_odp.h         |  5 ++---
> > >  2 files changed, 21 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> > > index 2575dd783196..46ae9962fae3 100644
> > > +++ b/drivers/infiniband/core/umem_odp.c
> > > @@ -294,19 +294,32 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
> > >  
> > >  	umem_odp->umem.is_odp = 1;
> > >  	if (!umem_odp->is_implicit_odp) {
> > > -		size_t pages = ib_umem_odp_num_pages(umem_odp);
> > > -
> > > +		size_t page_size = 1UL << umem_odp->page_shift;
> > > +		size_t pages;
> > > +
> > > +		umem_odp->interval_tree.start =
> > > +			ALIGN_DOWN(umem_odp->umem.address, page_size);
> > > +		if (check_add_overflow(umem_odp->umem.address,
> > > +				       umem_odp->umem.length,
> > > +				       &umem_odp->interval_tree.last))
> > > +			return -EOVERFLOW;
> > 
> > This if statement causes a warning on 32-bit ARM:
> > 
> > drivers/infiniband/core/umem_odp.c:295:7: warning: comparison of distinct
> > pointer types ('typeof (umem_odp->umem.address) *' (aka 'unsigned long *')
> > and 'typeof (umem_odp->umem.length) *' (aka 'unsigned int *'))
> > [-Wcompare-distinct-pointer-types]
> >                 if (check_add_overflow(umem_odp->umem.address,
> >                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/linux/overflow.h:59:15: note: expanded from macro 'check_add_overflow'
> >         (void) (&__a == &__b);                  \
> >                 ~~~~ ^  ~~~~
> > 1 warning generated.
> 
> Hum, I'm pretty sure 0-day has stopped running 32 bit builds or
> something :\
> 
> Jason

My report was with clang but GCC reports the same type of warning:

In file included from ../include/linux/slab.h:16,
                 from ../drivers/infiniband/core/umem_odp.c:38:
../drivers/infiniband/core/umem_odp.c: In function 'ib_init_umem_odp':
../include/linux/overflow.h:59:15: warning: comparison of distinct pointer types lacks a cast
   59 |  (void) (&__a == &__b);   \
      |               ^~
../drivers/infiniband/core/umem_odp.c:220:7: note: in expansion of macro 'check_add_overflow'
  220 |   if (check_add_overflow(umem_odp->umem.address,
      |       ^~~~~~~~~~~~~~~~~~

Adding Philip and Rong as I believe that they are the current 0-day
maintainers.

Cheers,
Nathan
