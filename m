Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 086E798162
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 19:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfHURfy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 13:35:54 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38074 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfHURfx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 13:35:53 -0400
Received: by mail-qk1-f195.google.com with SMTP id u190so2568376qkh.5
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2019 10:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5SGlmSszeLTNVBIQkCte7gmMS+gGVZAG5fqsUFhHdhg=;
        b=Izdrdzg7/5xVMefI+Ea0ALNM3ICeOPIS7T23zeWeLtCUr+mi7O168CqKqCZDFWaZrm
         H4KIDiryQEbrBK+XkxhePzWwFcB84D8pgmY3xtj60aQQEAupWVakIEHnUd1SCVQzZsX4
         LrOFi789J6dkSplvC8PqHIdwPa6l6ugXgb2RCpOytiXvqH73pVfAmveZOgeQCqAifFun
         Z3bWQFRSCIBgi7tnhPbvzWQEBN9h0fnZhggN8T88fEZuuhIxw+tflv/s37ZC+za9h6R+
         AmOTogaQrBPwM10HAfoXOt9rscSIrwp6NF/Dt6cl8O3NGSiIvhZqNaGgBkgKhQVE/RyN
         AaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5SGlmSszeLTNVBIQkCte7gmMS+gGVZAG5fqsUFhHdhg=;
        b=RY5xLmi2avDW4wIF7fmKdYg+cOK3LNNuJsIF67iR1bKrR6cC1P6QPopH/p9tI8hfv/
         PdgBcZ1qwcLcGoYxG/J7ZY8K4wV3BtZ+x2pD/Bp6Tni6SU26dzn+OQ4Pbm76Ix8CgsaC
         VdAEPiyhX76bwfRnAXCrglUX57pxisJlRnAEEIO6jsKuj6Qn53yJPmIUUExMXvW2Mk5x
         uxRjHl1S6vHhM1ZTWEhJal4MlrrteBS5dELkHhGZc6oGTcfOocxD9VKwUo02eZ9CrIiH
         jKsw6irqKEADTt+Bedi93J0ykpqkJnrCDJ+Oa6xW1YRkYAQuJ274ztHvb3aWWfXNmu94
         hWcg==
X-Gm-Message-State: APjAAAWlJqQMrfWkNI4rUPzX1NmUdVBOFMwAWpjXkUXS/lrjCwiMCKiV
        i6BV2hjac+TQFHwBGvzr/LG3eQ==
X-Google-Smtp-Source: APXvYqxaCMki7JpuV8iDKMsCkGSVxQOCIFmxdiSPjOI+VVKzKZOSlcfLOc0v5wrlMJWpLU+KtkMlaQ==
X-Received: by 2002:ae9:eb4e:: with SMTP id b75mr31672245qkg.478.1566408952898;
        Wed, 21 Aug 2019 10:35:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r4sm12280187qta.93.2019.08.21.10.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 10:35:52 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i0UWW-0006Tq-0j; Wed, 21 Aug 2019 14:35:52 -0300
Date:   Wed, 21 Aug 2019 14:35:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Moni Shoua <monis@mellanox.com>
Subject: Re: [PATCH rdma-next 02/12] RDMA/odp: Iterate over the whole rbtree
 directly
Message-ID: <20190821173551.GF8653@ziepe.ca>
References: <20190819111710.18440-1-leon@kernel.org>
 <20190819111710.18440-3-leon@kernel.org>
 <20190821171502.GA23022@ziepe.ca>
 <20190821172735.GC27741@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821172735.GC27741@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 08:27:35PM +0300, Leon Romanovsky wrote:
> On Wed, Aug 21, 2019 at 02:15:02PM -0300, Jason Gunthorpe wrote:
> > On Mon, Aug 19, 2019 at 02:17:00PM +0300, Leon Romanovsky wrote:
> > > From: Jason Gunthorpe <jgg@mellanox.com>
> > >
> > > Instead of intersecting a full interval, just iterate over every element
> > > directly. This is faster and clearer.
> > >
> > > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > >  drivers/infiniband/core/umem_odp.c | 51 ++++++++++++++++--------------
> > >  drivers/infiniband/hw/mlx5/odp.c   | 41 +++++++++++-------------
> > >  2 files changed, 47 insertions(+), 45 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> > > index 8358eb8e3a26..b9bebef00a33 100644
> > > +++ b/drivers/infiniband/core/umem_odp.c
> > > @@ -72,35 +72,41 @@ static void ib_umem_notifier_end_account(struct ib_umem_odp *umem_odp)
> > >  	mutex_unlock(&umem_odp->umem_mutex);
> > >  }
> > >
> > > -static int ib_umem_notifier_release_trampoline(struct ib_umem_odp *umem_odp,
> > > -					       u64 start, u64 end, void *cookie)
> > > -{
> > > -	/*
> > > -	 * Increase the number of notifiers running, to
> > > -	 * prevent any further fault handling on this MR.
> > > -	 */
> > > -	ib_umem_notifier_start_account(umem_odp);
> > > -	umem_odp->dying = 1;
> >
> > This patch was not applied on top of the commit noted in the cover
> > letter
> 
> Strange: git log --oneline on my submission queue.
> ....
> 39c10977a728 RDMA/odp: Iterate over the whole rbtree directly
> 779c1205d0e0 RDMA/odp: Use the common interval tree library instead of generic
> 25705cc22617 RDMA/mlx5: Fix MR npages calculation for IB_ACCESS_HUGETLB

But that patch has to apply on top of rc, which has the other commit
that deleted dying

Jason
