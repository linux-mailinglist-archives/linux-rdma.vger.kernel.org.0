Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125A4297A34
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Oct 2020 03:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758556AbgJXBpV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 21:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758589AbgJXBpV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Oct 2020 21:45:21 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D44AC0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 18:45:21 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id b2so2575311ots.5
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 18:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGsi5YcxzQ7stG6G1DguJ+xZk2RUvzGBT2tUgkec1Ic=;
        b=FW8l6rNcPlkkHIxYAmxn2I5AzqFraX97UvSo6j5QaiD9JXDr9IgTqtrzGcVywpJMDS
         LUJn1/A1JOpYsDnjZG/w6zhkz6kqFQM84bEoADT/E2GPcuaDij8HZqkWlMO7VFktz7hl
         GAV2MM0PnpX7OmivnkLoLLZP2ZffvuNGVt47E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGsi5YcxzQ7stG6G1DguJ+xZk2RUvzGBT2tUgkec1Ic=;
        b=nVadrQ2HjNdQB8xAXYP0KRr6S6UY0wN8q0sy6xhe2hVF9NSxfDKpwQIhjO/NjbHndH
         IUQklTfn6gMKrqeBPZepcmGjwIcEYP4F/F2htRkMAHEcnRc7GKePTvfRghPUcwJLHGE5
         8FRzuuVj+vDKI0RhonOsH0Ur+uL0baJbDQg0cylY2qhNeULGaEDBmjwDuVgxMduBgvdW
         NMDBc5Skk2Tli+/lFLx6jsgPnlZRWmUprjKqi1mEb3W/ip3YPHiSK2LqaZPbmHdYzYt3
         /MhqNu9WLWSk8b/RDhQhcVhw29sW3bndTkNFbx962f6bgS38aEVqSGhqLtgWlt3eBAgu
         g0YQ==
X-Gm-Message-State: AOAM532OZ2iiHlxmHSwVdH+H+f0BbJvvMW65PWKETZwRu33p0PzH2vo3
        N/X6mFBSO17IKENFHVPChJdnmbKuTAmbyh68yWWLyA==
X-Google-Smtp-Source: ABdhPJxFEVvckOn8TMXbpUybEsH7El0kXpT+Js80avNLpe6rV/n5sIRCcmCgObpEiyOiSTQf0HfPhdVAvC4QMJ8TNC0=
X-Received: by 2002:a05:6830:1647:: with SMTP id h7mr4466267otr.281.1603503920944;
 Fri, 23 Oct 2020 18:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <1603471201-32588-1-git-send-email-jianxin.xiong@intel.com>
 <1603471201-32588-2-git-send-email-jianxin.xiong@intel.com>
 <20201023164911.GF401619@phenom.ffwll.local> <20201023182005.GP36674@ziepe.ca>
In-Reply-To: <20201023182005.GP36674@ziepe.ca>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Sat, 24 Oct 2020 03:45:09 +0200
Message-ID: <CAKMK7uEZYdtwHKchNwiFjuYJDjA+F+qDgw64TNkchjp4uYUr6g@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 23, 2020 at 8:20 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Oct 23, 2020 at 06:49:11PM +0200, Daniel Vetter wrote:
> > > +struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> > > +                              unsigned long offset, size_t size,
> > > +                              int fd, int access,
> > > +                              const struct dma_buf_attach_ops *ops)
> > > +{
> > > +   struct dma_buf *dmabuf;
> > > +   struct ib_umem_dmabuf *umem_dmabuf;
> > > +   struct ib_umem *umem;
> > > +   unsigned long end;
> > > +   long ret;
> > > +
> > > +   if (check_add_overflow(offset, (unsigned long)size, &end))
> > > +           return ERR_PTR(-EINVAL);
> > > +
> > > +   if (unlikely(PAGE_ALIGN(end) < PAGE_SIZE))
> > > +           return ERR_PTR(-EINVAL);
> > > +
> > > +   if (unlikely(!ops || !ops->move_notify))
> > > +           return ERR_PTR(-EINVAL);
> > > +
> > > +#ifdef CONFIG_DMA_VIRT_OPS
> > > +   if (device->dma_device->dma_ops == &dma_virt_ops)
> > > +           return ERR_PTR(-EINVAL);
> > > +#endif
> >
> > Maybe I'm confused, but should we have this check in dma_buf_attach, or at
> > least in dma_buf_dynamic_attach? The p2pdma functions use that too, and I
> > can't imagine how zerocopy should work (which is like the entire point of
> > dma-buf) when we have dma_virt_ops.
>
> The problem is we have RDMA drivers that assume SGL's have a valid
> struct page, and these hacky/wrong P2P sgls that DMABUF creates cannot
> be passed into those drivers.
>
> But maybe this is just a 'drivers are using it wrong' if they call
> this function and expect struct pages..
>
> The check in the p2p stuff was done to avoid this too, but it was on a
> different flow.

Yeah definitely don't call dma_buf_map_attachment and expect a page
back. In practice you'll get a page back fairly often, but I don't
think we want to bake that in, maybe we eventually get to non-hacky
dma_addr_t only sgl.

What I'm wondering is whether dma_buf_attach shouldn't reject such
devices directly, instead of each importer having to do that.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
