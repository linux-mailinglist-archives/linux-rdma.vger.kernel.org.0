Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C61D8395E5
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 21:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfFGTj5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 15:39:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37712 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbfFGTj5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 15:39:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id d15so1997991qkl.4
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v5PuEzRCYukWCZO7VXmHdZiC17djxNHawIgWZJ3C3rI=;
        b=SAtTDMFwUmHIu49ip5MvvV585/FJuArUH6e+7qtqGRge4Po4xGdF9mVWCB0X/LfcDZ
         S8k2EUayAT/XyINgUH3TIe/wXyoHbb9DFckpgvIyY/0/q3Ii0Co5gDrul9aKC4OKk20W
         aHokMp9l9jU2YuHq9oePc3nIazjf1Zzt/8VIYFXOd+z+D8CBo2rWiHRA+Z3w2pAHQgxi
         coNiAQZJYT5BweEOPNk1ChYd4KC/kMJQSqMc53F6JyrSUVaBkqVmwfuh6vyWs++p37xR
         IXPalW63NH2kpn4cw3UD+fCEyK3p1JBU8J3vmnxDsZ2ZdorBeINpEQ7o7qHIwYNDmk1h
         AbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v5PuEzRCYukWCZO7VXmHdZiC17djxNHawIgWZJ3C3rI=;
        b=I8fE87PtPREaUquBoxpQVvRLiJ1PXMWuv42xlZ25u3fjc6Ru4l9lvhD5YEpvNY1NF5
         dZdK3R5ZhcS4bXbyL5RfXsQihihnjg+K6bwiomfAKJiq4QyQZmC+2vUmzadXSc4+HHw6
         nJLbu+IbKU1IY1i5W4VcZQH5TGZRs1iwCM/cnSMw1L0A/1CJa7j+dhCvdxGaXY6RKKXA
         Mriv1uIHPZ4QHj5WLXnyRmlnWSmii79euaydNopFSWIteWbz9Es/IhMmW3h6sdA6/UTV
         16oYou1oP0XwbNkuu5MeT2uZDcBiD3X7dld2T9jSAMuxIeTlb97d7oLn8M104t5+nczI
         x9VQ==
X-Gm-Message-State: APjAAAWlswD/CDqWo3HHWBDZNYVEWNO6pj5Q+MmTBuyb63Q/lPeBBSY0
        Ym7TJ2oXCITXyo+KzI9z/hdLWg==
X-Google-Smtp-Source: APXvYqxGWrYqN4UNN4o5aR4HOkmObWEddG1b3Np+uajVbZa2p3YdBOe1UPksd0tTWtPwZyGUbFZPeg==
X-Received: by 2002:a37:a110:: with SMTP id k16mr25061800qke.97.1559936396611;
        Fri, 07 Jun 2019 12:39:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id g5sm1140002qta.77.2019.06.07.12.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 12:39:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZKiR-0005LL-KT; Fri, 07 Jun 2019 16:39:55 -0300
Date:   Fri, 7 Jun 2019 16:39:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 08/11] mm/hmm: Use lockdep instead of comments
Message-ID: <20190607193955.GT14802@ziepe.ca>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190523153436.19102-9-jgg@ziepe.ca>
 <CAFqt6zakL282X2SMh7E9kHDLnT9nW5ifbN2p1OKTXY4gaU=qkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zakL282X2SMh7E9kHDLnT9nW5ifbN2p1OKTXY4gaU=qkA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 08, 2019 at 01:03:48AM +0530, Souptick Joarder wrote:
> On Thu, May 23, 2019 at 9:05 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >
> > So we can check locking at runtime.
> >
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> >  mm/hmm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index 2695925c0c5927..46872306f922bb 100644
> > +++ b/mm/hmm.c
> > @@ -256,11 +256,11 @@ static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
> >   *
> >   * To start mirroring a process address space, the device driver must register
> >   * an HMM mirror struct.
> > - *
> > - * THE mm->mmap_sem MUST BE HELD IN WRITE MODE !
> >   */
> >  int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
> >  {
> > +       lockdep_assert_held_exclusive(mm->mmap_sem);
> > +
> 
> Gentle query, does the same required in hmm_mirror_unregister() ?

No.. The unregistration path does its actual work in the srcu
callback, which is in a different context than this function. So any
locking held by the caller of unregister will not apply.

The hmm_range_free SRCU callback obtains the write side of mmap_sem to
protect the same data that the write side above in register is
touching, mostly &mm->hmm.

Jason
