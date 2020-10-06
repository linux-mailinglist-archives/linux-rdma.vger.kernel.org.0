Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FBA285008
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 18:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgJFQkH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 12:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgJFQkH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 12:40:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630B2C061755
        for <linux-rdma@vger.kernel.org>; Tue,  6 Oct 2020 09:40:05 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so14244441wrv.1
        for <linux-rdma@vger.kernel.org>; Tue, 06 Oct 2020 09:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZsPNJIjvNk27l9e6IRSgWxSSWsE0wBm8OBEV4hcMxXc=;
        b=Iqfbi6CKnuvSQxjB03HZ4vRrlfqEbYqmT00izVAFcfJLRsJehnZqhJARX5zeQN363R
         uTdPAGuZhaiwWS19ruS2UwlQuPIb47ITjlPjaoMk637c+jEN2NQjGUsuScTX19GsvJd2
         6oGK0MLiWGBS9Ug4zfK4TPR2Sv6bQ39U0lJpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZsPNJIjvNk27l9e6IRSgWxSSWsE0wBm8OBEV4hcMxXc=;
        b=YrlFWp1fEW4zMOUS0R0bGqNVRt42/ilTzerfDpeOZTwv85x/YJi54t0CKASB/8cSkf
         5LklblhNqnXHGG9aSy7OzSdrwF7hLuHZjsCr0EboaC3CLmLn4GmCjx77Ycmou7t4uARv
         DnfLAwGgXbQkVi9ss4oeyolsZemAdcw171p0WsHuwCOLcs9Y83Ru4YhRlLxO13uJn36M
         3v2X1oq+Ax3o3QpDwSiT8Y6tuzWeHNIdqrOfr4u1eUyRp0OAMn8QQ1XmCA8dBFzc2kFq
         S7k+nqLY6utuOZwDU7lPbqem1hmbsipVeJz+o76A4jTPBsa1sATpT7I3Izk32X898e7k
         548A==
X-Gm-Message-State: AOAM533811UwzWeF2tS9/7pZHhLBkBogSkhxygfrjwz2c6IoS4RXwNGN
        wc3s9EDGN8Si5XEY3EUjAdirGKc1TDODYHLt
X-Google-Smtp-Source: ABdhPJz2vI6bXNWd6Sg6wvngP1zncgquhSVWOeY4NtQDV4K8yPv9FirIlCqiemWN3xzycuoqi2pp+Q==
X-Received: by 2002:adf:f903:: with SMTP id b3mr6180717wrr.142.1602002404051;
        Tue, 06 Oct 2020 09:40:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v18sm5068485wrs.95.2020.10.06.09.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:40:03 -0700 (PDT)
Date:   Tue, 6 Oct 2020 18:40:01 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [RFC PATCH v3 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201006164001.GC438822@phenom.ffwll.local>
References: <1601838751-148544-1-git-send-email-jianxin.xiong@intel.com>
 <1601838751-148544-2-git-send-email-jianxin.xiong@intel.com>
 <20201005131302.GQ9916@ziepe.ca>
 <MW3PR11MB455572267489B3F6B1C5F8C5E50C0@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB455572267489B3F6B1C5F8C5E50C0@MW3PR11MB4555.namprd11.prod.outlook.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 05, 2020 at 04:18:11PM +0000, Xiong, Jianxin wrote:
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Monday, October 05, 2020 6:13 AM
> > To: Xiong, Jianxin <jianxin.xiong@intel.com>
> > Cc: linux-rdma@vger.kernel.org; dri-devel@lists.freedesktop.org; Doug Ledford <dledford@redhat.com>; Leon Romanovsky
> > <leon@kernel.org>; Sumit Semwal <sumit.semwal@linaro.org>; Christian Koenig <christian.koenig@amd.com>; Vetter, Daniel
> > <daniel.vetter@intel.com>
> > Subject: Re: [RFC PATCH v3 1/4] RDMA/umem: Support importing dma-buf as user memory region
> > 
> > On Sun, Oct 04, 2020 at 12:12:28PM -0700, Jianxin Xiong wrote:
> > > Dma-buf is a standard cross-driver buffer sharing mechanism that can
> > > be used to support peer-to-peer access from RDMA devices.
> > >
> > > Device memory exported via dma-buf is associated with a file descriptor.
> > > This is passed to the user space as a property associated with the
> > > buffer allocation. When the buffer is registered as a memory region,
> > > the file descriptor is passed to the RDMA driver along with other
> > > parameters.
> > >
> > > Implement the common code for importing dma-buf object and mapping
> > > dma-buf pages.
> > >
> > > Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> > > Reviewed-by: Sean Hefty <sean.hefty@intel.com>
> > > Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> > > ---
> > >  drivers/infiniband/core/Makefile      |   2 +-
> > >  drivers/infiniband/core/umem.c        |   4 +
> > >  drivers/infiniband/core/umem_dmabuf.c | 291
> > > ++++++++++++++++++++++++++++++++++
> > >  drivers/infiniband/core/umem_dmabuf.h |  14 ++
> > >  drivers/infiniband/core/umem_odp.c    |  12 ++
> > >  include/rdma/ib_umem.h                |  19 ++-
> > >  6 files changed, 340 insertions(+), 2 deletions(-)  create mode
> > > 100644 drivers/infiniband/core/umem_dmabuf.c
> > >  create mode 100644 drivers/infiniband/core/umem_dmabuf.h
> > 
> > I think this is using ODP too literally, dmabuf isn't going to need fine grained page faults, and I'm not sure this locking scheme is OK - ODP is
> > horrifically complicated.
> > 
> 
> > If this is the approach then I think we should make dmabuf its own stand alone API, reg_user_mr_dmabuf()
> 
> That's the original approach in the first version. We can go back there.
> 
> > 
> > The implementation in mlx5 will be much more understandable, it would just do dma_buf_dynamic_attach() and program the XLT exactly
> > the same as a normal umem.
> > 
> > The move_notify() simply zap's the XLT and triggers a work to reload it after the move. Locking is provided by the dma_resv_lock. Only a
> > small disruption to the page fault handler is needed.
> > 
> 
> We considered such scheme but didn't go that way due to the lack of notification when the move is done and thus the work wouldn't know when it can reload.
> 
> Now I think it again, we could probably signal the reload in the page fault handler. 
> 
> > > +	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
> > > +	sgt = dma_buf_map_attachment(umem_dmabuf->attach,
> > > +				     DMA_BIDIRECTIONAL);
> > > +	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
> > 
> > This doesn't look right, this lock has to be held up until the HW is programmed
> 
> The mapping remains valid until being invalidated again. There is a sequence number checking before programming the HW. 
> 
> > 
> > The use of atomic looks probably wrong as well.
> 
> Do you mean umem_dmabuf->notifier_seq? Could you elaborate the concern?
> 
> > 
> > > +	k = 0;
> > > +	total_pages = ib_umem_odp_num_pages(umem_odp);
> > > +	for_each_sg(umem->sg_head.sgl, sg, umem->sg_head.nents, j) {
> > > +		addr = sg_dma_address(sg);
> > > +		pages = sg_dma_len(sg) >> page_shift;
> > > +		while (pages > 0 && k < total_pages) {
> > > +			umem_odp->dma_list[k++] = addr | access_mask;
> > > +			umem_odp->npages++;
> > > +			addr += page_size;
> > > +			pages--;
> > 
> > This isn't fragmenting the sg into a page list properly, won't work for unaligned things
> 
> I thought the addresses are aligned, but will add explicit alignment here.

Everyone's working under the assumption that dma_buf sg lists are fully
PAGE aligned. Lots of stuff can break otherwise all over the place. You
might get more than that, especially for p2p since many gpus work on 64kb
pages for the vram, but system pages are 4k aligned.

I think we need a patch to clarify this in the kerneldoc, bot for
dma_buf_map_attachment for importers and the dma_buf_ops callback for
exporters.

Also I think it'd be good to verify that when dma api debugging is
enabled, i.e. when dma_buf_map_attachment succeeds, walk the entire sg
list and validate that all dma_addr_t segments are page aligned. And if
not, WARN loudly and fail.
-Daniel

 
> > 
> > And really we don't need the dma_list for this case, with a fixed whole mapping DMA SGL a normal umem sgl is OK and the normal umem
> > XLT programming in mlx5 is fine.
> 
> The dma_list is used by both "polulate_mtt()" and "mlx5_ib_invalidate_range", which are used for XLT programming and invalidating (zapping), respectively.
> 
> > 
> > Jason
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
