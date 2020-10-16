Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6DE290BF4
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 20:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403859AbgJPS6c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 14:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403821AbgJPS6c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Oct 2020 14:58:32 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10141C061755
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 11:58:32 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id j17so3854526ilr.2
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PD8XO9XeSIfAUH4+p8E5ji377Y5OQ/ZRdOb9h9Q0AUY=;
        b=YtyCEDh49p27bnAfFJx7DthiAK2A2II8HT9mP8sz6ky0RhZKMz46wlhv7PTXt4CCfT
         x9TsxyGnWiaW/KuMpRVJOz2FmQnKMxcXvyN7FNUPyvc35O3oY4/FS9XN7a3EDAsIIIPC
         lA1WYfa/gDRz4UPQT8IAMjlpvIv9vntPyN6Z+y1YVL4N6gYy4V5TfuVuu6sI1QfgoFAJ
         M5IsACs8IfR+q2viWS8zddkmDBLfiSUbMZty5/j+9TkDwVPkGnr8WxbCwD/kp7tyjpME
         fgHQ/SIV3qdTg0ezy98YNoVbY2icJh/V1K9RVmD1Ti5bI3fcRZ5T9BjZJzeRzN8/s+bv
         tFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PD8XO9XeSIfAUH4+p8E5ji377Y5OQ/ZRdOb9h9Q0AUY=;
        b=Lkk9S6UQTo5Z6EGhq8Ruzqep8YyeYMLOM/yVWi33N67FgHi64VKFc5JcjpITyGXFH0
         spQGcj3GVLwEkTIkbuiFxmUwIIoZzv8pJpwwa4XlReW6qEax1iXoGkGERIHwvIsmBh8j
         fRAnL7dhzWAhfsd4Uy8RMNYptN9Ze71O5DxADm8P8pTUaEKJ6a9ztfv/xma0rF7pWe6w
         CLqknZRAtvXHL22oWFHYLDfzYluyftxbx4asSt2yVr55MZVqD318kf0UEmaCNEmKu1W1
         nbvKPbvtmiBaXgaNFxITRu8ZvBypphE5beHEim/8mC+A9ZQK29NnNKqShT/Sg4ar7o/q
         sTqQ==
X-Gm-Message-State: AOAM533FR83BEk8hkcBODyghRQwNJ+VJJCd1FXgL2l/w1VZD1EAVVGTf
        737u2SZQQF86XdR5RDqlROBZ4g==
X-Google-Smtp-Source: ABdhPJwiBX4Osl3JVvSb7eq9FwPz+BgohwF2rr/Q2EiwqYCIHAy9f0KFOYs+A197ZIgy6r7hv4TlHg==
X-Received: by 2002:a92:2003:: with SMTP id j3mr3882945ile.28.1602874711401;
        Fri, 16 Oct 2020 11:58:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id t10sm2759362iog.49.2020.10.16.11.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 11:58:30 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kTUvt-000yoy-VK; Fri, 16 Oct 2020 15:58:29 -0300
Date:   Fri, 16 Oct 2020 15:58:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: Re: [PATCH v5 4/5] RDMA/mlx5: Support dma-buf based userspace memory
 region
Message-ID: <20201016185829.GB37159@ziepe.ca>
References: <1602799378-138316-1-git-send-email-jianxin.xiong@intel.com>
 <20201016005419.GA36674@ziepe.ca>
 <MW3PR11MB4555528000D39F35A47C5F8CE5030@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB4555528000D39F35A47C5F8CE5030@MW3PR11MB4555.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 16, 2020 at 06:40:01AM +0000, Xiong, Jianxin wrote:
> > > +	if (!mr)
> > > +		return -EINVAL;
> > > +
> > > +	return mlx5_ib_update_xlt(mr, 0, mr->npages, PAGE_SHIFT, flags); }
> > > +
> > > +static struct ib_umem_dmabuf_ops mlx5_ib_umem_dmabuf_ops = {
> > > +	.init = mlx5_ib_umem_dmabuf_xlt_init,
> > > +	.update = mlx5_ib_umem_dmabuf_xlt_update,
> > > +	.invalidate = mlx5_ib_umem_dmabuf_xlt_invalidate,
> > > +};
> > 
> > I'm not really convinced these should be ops, this is usually a bad design pattern.
> > 
> > Why do I need so much code to extract the sgl from the dma_buf? I would prefer the dma_buf layer simplify this, not by adding a wrapper
> > around it in the IB core code...
> > 
> 
> We just need a way to call a device specific function to update the NIC's translation
> table.  I considered three ways: (1) ops registered with ib_umem_get_dmabuf; 
> (2) a single function pointer registered with ib_umem_get_dmabuf; (3) a method 
> in 'struct ib_device'. Option (1) was chosen here with no strong reason. We could
> consolidate the three functions of the ops into one, but then we will need to 
> define commands or flags for different update operations.   

I'd rather the driver directly provide the dma_buf ops.. Inserting
layers that do nothing be call other layers is usually a bad idea. I
didn't look carefully yet at how that would be arranged.

> > > +	ncont = npages;
> > > +	order = ilog2(roundup_pow_of_two(ncont));
> > 
> > We still need to deal with contiguity here, this ncont/npages is just obfuscation.
> 
> Since the pages can move, we can't take advantage of contiguity here. This handling
> is similar to the ODP case. The variables 'ncont' and 'page_shift' here are not necessary.
> They are kept just for the sake of signifying the semantics of the following functions that
> use them.

Well, in this case we can manage it, and the performance boost is high
enough we need to. The work on mlx5 to do it is a bit inovlved though.
 
> > > +	err = ib_umem_dmabuf_init_mapping(umem, mr);
> > > +	if (err) {
> > > +		dereg_mr(dev, mr);
> > > +		return ERR_PTR(err);
> > > +	}
> > 
> > Did you test the page fault path at all? Looks like some xarray code is missing here, and this is also missing the related complex teardown
> > logic.
> > 
> > Does this mean you didn't test the pagefault_dmabuf_mr() at all?
> 
> Thanks for the hint. I was unable to get the test runs reaching the
> pagefault_dmabuf_mr() function. Now I have found the reason. Along
> the path of all the page fault handlers, the array "odp_mkeys" is checked
> against the mr key. Since the dmabuf mr keys are not in the list the
> handler is never called.
>
> On the other hand, it seems that pagefault_dmabuf_mr() is not needed at all.
> The pagefault is gracefully handled by retrying until the work thread finished
> programming the NIC.

This is a bug of some kind, pagefaults that can't find a mkey in the
xarray should cause completion with error.

Jason
