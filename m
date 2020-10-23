Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415D32976C7
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Oct 2020 20:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464893AbgJWSUK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 14:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750606AbgJWSUI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Oct 2020 14:20:08 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1193CC0613D2
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 11:20:08 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j62so1684621qtd.0
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 11:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d/+MlewygeiienB2mRVhuu6CHgxoRL3d5SyiUrYkbUk=;
        b=P4s3di/PHximFnEKCWi0KnwrrxyUpqpcmCQy2Nth1PVvkNCVxwt8YTbQ+cWCzJ+rnD
         f5u7no5HH802n8lLR852ZUhFFg0kr2kfshpdHDx1axKHrq58MWe8ZN93rEE/Dhi4yduP
         +lWucSf+1tTgEBWpz9UaUW9nYQXFF0grtVVrH19T4mCRSk6URpMvHyVqPBsiQK5IJ7Qi
         BTlV57OclczClDMZu+PXRkkPJmwtdeJaX4kTqMOGVWlzaWL8V+y7I7BDKV/C3C3VckhR
         ai8VK0aBvsufYBiH7tqeJHT+Q1RpyA+lNbgwb8D9agAm9SxQHuzaNf8S6fnpZmRb4p5I
         tI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d/+MlewygeiienB2mRVhuu6CHgxoRL3d5SyiUrYkbUk=;
        b=EyQJpex9rmk7s1gt05dXp7bla+wh2aWRYPoLe6VOJW4c4vICsxk8/XujYZy+ydDJiE
         UspRwS1Y+M2rvL1SXuoTzOl6DWiGroJFki2RyUPlSlx4DsfQBRDVRWT0rQt9XBPtypQL
         C7NT9W/p2I54S0IQ2FFqRHijeCuZnxnmbbD01QHoKN5PB3Fohg0E+sz/S3YzlNHN5+m3
         sNniErGwch0CRJJ+GZaI75PaSruhbaFB1iyihGDX1XDeOUNebx8STPtRCEgbRS3T1rZ4
         2uDkuVXhb7yjgteOjGp5YbQ6O3iHMSRYyw0L1VbuStPKqrfI/PR65eSRlfas851Q96Vi
         UsLA==
X-Gm-Message-State: AOAM530PQ32J6h8/mSub9Xt1ywSe7EsEKjWaRlmZskgKbCRRkOAN3dug
        nbkPcwQCGJazaPI2G2h+sp3dQw==
X-Google-Smtp-Source: ABdhPJzEK0E5cN3UuD9k/y/M+Nvpt4LbYO1AelIkz6dEQYGwBH4YhcUAmfE4fNEeUt7dggHiEbURCg==
X-Received: by 2002:ac8:13c9:: with SMTP id i9mr3275402qtj.89.1603477207177;
        Fri, 23 Oct 2020 11:20:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v5sm1242273qkv.89.2020.10.23.11.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 11:20:06 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kW1fZ-006OVO-L8; Fri, 23 Oct 2020 15:20:05 -0300
Date:   Fri, 23 Oct 2020 15:20:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH v6 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201023182005.GP36674@ziepe.ca>
References: <1603471201-32588-1-git-send-email-jianxin.xiong@intel.com>
 <1603471201-32588-2-git-send-email-jianxin.xiong@intel.com>
 <20201023164911.GF401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023164911.GF401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 23, 2020 at 06:49:11PM +0200, Daniel Vetter wrote:
> > +struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> > +				   unsigned long offset, size_t size,
> > +				   int fd, int access,
> > +				   const struct dma_buf_attach_ops *ops)
> > +{
> > +	struct dma_buf *dmabuf;
> > +	struct ib_umem_dmabuf *umem_dmabuf;
> > +	struct ib_umem *umem;
> > +	unsigned long end;
> > +	long ret;
> > +
> > +	if (check_add_overflow(offset, (unsigned long)size, &end))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (unlikely(PAGE_ALIGN(end) < PAGE_SIZE))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (unlikely(!ops || !ops->move_notify))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +#ifdef CONFIG_DMA_VIRT_OPS
> > +	if (device->dma_device->dma_ops == &dma_virt_ops)
> > +		return ERR_PTR(-EINVAL);
> > +#endif
> 
> Maybe I'm confused, but should we have this check in dma_buf_attach, or at
> least in dma_buf_dynamic_attach? The p2pdma functions use that too, and I
> can't imagine how zerocopy should work (which is like the entire point of
> dma-buf) when we have dma_virt_ops.

The problem is we have RDMA drivers that assume SGL's have a valid
struct page, and these hacky/wrong P2P sgls that DMABUF creates cannot
be passed into those drivers.

But maybe this is just a 'drivers are using it wrong' if they call
this function and expect struct pages..

The check in the p2p stuff was done to avoid this too, but it was on a
different flow.

Jason
