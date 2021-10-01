Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D6541EFFE
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Oct 2021 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354648AbhJAOxz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Oct 2021 10:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhJAOxz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Oct 2021 10:53:55 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE32C061775
        for <linux-rdma@vger.kernel.org>; Fri,  1 Oct 2021 07:52:11 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 73so9372024qki.4
        for <linux-rdma@vger.kernel.org>; Fri, 01 Oct 2021 07:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RI3Un3whqlEWtr4aJFgQHeUC54CuvGWs6w3DnHGUv/4=;
        b=K55qbiVvd5XkUgYdEETZqf6R/YzC/428DzaLW2tQ1ko0WgHk0e5GqeISXC4mTcYwqh
         UFd6C9JUxe2nybzAsP25tvptN+Y6RaQ+NCnffnNO49sqE1hLj3z5Uw6w0YQFAd4nbEea
         oDOyJIqrPZDj/AC1nGV8aCIYfqOCBF3JErO6HP47SyFJ//VI1Q0Yoi9wz8NCz/yiN6Be
         spTum4L76krjx74lLmNv4MalFbk7YAYa1C9jH8DSsl59JyqT0d0nhZ9R8+D2ubHV7LUG
         7FtkXFWhqpEw2sHwMKMtp3v2vxCejLHIGS9AO5iY+0yD9mrJkQIINWWsLKd+4B7HFvWX
         xDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RI3Un3whqlEWtr4aJFgQHeUC54CuvGWs6w3DnHGUv/4=;
        b=lP8wwzwfjFFdp3/tiKNjTlWv4Ib7uZjhWMDrsKixjS+ccn0ym3FVV5xexZp5qPAAQ4
         a84YyNKGIFgsPiewKLB2LpvfcTKP7I8Px4WaKcDrmJHaiVrC/wO+rW8uNTzRWjBRb75b
         1lsuL3+VQadG71TfcNo9bvuMrMvxiV0rLT2R6uN7L8aRR0XvMiQreRgZ6VgPYdB3jv7K
         uE4Hju2mzU9SZ2Fh6fiazwtqhzOOrPNR0tTacQ816lvlwsgqwzGl+yeS5rNJAEI3bBje
         420fcFJLPEdGPSX0u5BLKAzpjXTqoAvjHhdjkdTBFa2uddMJL1toyzGNiUn7GHNRpT7N
         3n4w==
X-Gm-Message-State: AOAM531pvQm5DZeO/q7QAUXCebPLrOcnz1Nv5WtqvLui7ca8H9WImGwh
        76geqPhcKv12rvaLC7Aauge1Nw==
X-Google-Smtp-Source: ABdhPJzm/G5kJIBn6QfIwm7CMo9R8IxodH1fBoPXgsTIw67OxVDlKvoB7FSYpgEZCvPs9m2+kSO18w==
X-Received: by 2002:a37:a391:: with SMTP id m139mr9826820qke.186.1633099930416;
        Fri, 01 Oct 2021 07:52:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id q14sm3633839qtw.82.2021.10.01.07.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:52:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mWJtR-008cux-FC; Fri, 01 Oct 2021 11:52:09 -0300
Date:   Fri, 1 Oct 2021 11:52:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gal Pressman <galpress@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, Tomer Tayar <ttayar@habana.ai>
Subject: Re: [PATCH v6 2/2] habanalabs: add support for dma-buf exporter
Message-ID: <20211001145209.GP3544071@ziepe.ca>
References: <20210912165309.98695-1-ogabbay@kernel.org>
 <20210912165309.98695-3-ogabbay@kernel.org>
 <20210928173621.GG3544071@ziepe.ca>
 <CAFCwf10z-baRm8c-UD_=jcZYD0VAGrMiNo7Q5Fm-2txYmVWGcQ@mail.gmail.com>
 <CAFCwf110SPfqpjKO7e2W-MSs6iSdecCwS6CwKx4cL-DjqriT2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf110SPfqpjKO7e2W-MSs6iSdecCwS6CwKx4cL-DjqriT2Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 30, 2021 at 03:46:35PM +0300, Oded Gabbay wrote:

> After reading the kernel iommu code, I think this is not relevant
> here, and I'll add a comment appropriately but I'll also write it
> here, and please correct me if my understanding is wrong.
> 
> The memory behind this specific dma-buf has *always* resided on the
> device itself, i.e. it lives only in the 'device' domain (after all,
> it maps a PCI bar address which points to the device memory).
> Therefore, it was never in the 'CPU' domain and hence, there is no
> need to perform a sync of the memory to the CPU's cache, as it was
> never inside that cache to begin with.
> 
> This is not the same case as with regular memory which is dma-mapped
> and then copied into the device using a dma engine. In that case,
> the memory started in the 'CPU' domain and moved to the 'device'
> domain. When it is unmapped it will indeed be recycled to be used
> for another purpose and therefore we need to sync the CPU cache.
> 
> Is my understanding correct ?

It makes sense to me

Jason
