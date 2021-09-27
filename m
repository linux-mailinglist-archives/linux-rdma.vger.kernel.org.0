Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E714193C2
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 13:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhI0MAx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 08:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbhI0MAx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Sep 2021 08:00:53 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6AAC061575
        for <linux-rdma@vger.kernel.org>; Mon, 27 Sep 2021 04:59:15 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id dk4so1733804qvb.2
        for <linux-rdma@vger.kernel.org>; Mon, 27 Sep 2021 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OO+222/P86uXwx2DUL7XFhBRQH7h34PJA8Pu8TuCXwk=;
        b=ZL/JBEgooXnyCrC3PZPifhJMY7c0Spp/pZ7ZbJcxAvO4SqqgAZ72SQw1SpsFOhGJik
         r6kco9u/CEuUQUy1UXj0T5NAMwNNub1UrY8miVFHVNQOaPOum8mmcUmWyEvd2tUY6wJZ
         QORuXO0DHVZ8UTLk/gsT3RRecjE0wI/1WdxQ/ruAihzgIKEkc+tUFVaXQfpeT+ybnk58
         Xl8qE1C6CZsFTQ2e+Mg7qtIeT3Soxdg2aqFveBi5376gcp+Rm9rX3sXEoCH5Q7E/2gpy
         ubMVSOSLdSn3zBhjY6WAI/wlkpGYskTbOdp/Sh7j3/9pEQ/Bk4Epm3qeK+LDMKtKsawt
         QbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OO+222/P86uXwx2DUL7XFhBRQH7h34PJA8Pu8TuCXwk=;
        b=Obc6Fum00byle3QOcmSyqqDOqxFMPl3UkPrf0xf/BD8RKoS1PDpPuPEe6nx3mPeYbP
         F8eGve7t7pvAqAoDtH4mz76YH5hJRjMUOd4SNxsSrMHBkQgB0gERI05slYChYfsD0Y5b
         RzL5HFsFcfnrrugv2sdfIa0A0lw+JffmF2wb8MbQGIzDbmKL+iriUnLc5U+FdoL1uM8K
         7uHUU99MgLSYqyHbSB4+gn1A3pOtEpWOvpIAhqSg2rwC9TCMrbVzpcDuscowfeRGSz6g
         weqYP3RfX5kUtJ4d5a1aREnaK+3HXMK2pPXGCxKlrLD3VYxp/7Bb/4t1ubhLBPxsxmnM
         yX0g==
X-Gm-Message-State: AOAM5334outxCvEyhgSNKYKc7nNxUQrZBD4X/AF0oy4g3WRwTP9rZoP0
        dD1hIJf9VOLsVmclTaalqRoECA==
X-Google-Smtp-Source: ABdhPJy3nOQ3FNSGsukLYBHcPm8UPLE6M0Y1cB5a2QVacqIcovnXcQS6o3l+I0S/lrqxiR2fF31wkw==
X-Received: by 2002:a0c:cb10:: with SMTP id o16mr23618362qvk.57.1632743954338;
        Mon, 27 Sep 2021 04:59:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id q24sm12708403qkj.77.2021.09.27.04.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 04:59:13 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mUpHt-006Ivp-6R; Mon, 27 Sep 2021 08:59:13 -0300
Date:   Mon, 27 Sep 2021 08:59:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Lijun Ou <oulijun@huawei.com>, Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Use dma_alloc_coherent() instead of
 kmalloc/dma_map_single()
Message-ID: <20210927115913.GA3544071@ziepe.ca>
References: <20210926061116.282-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926061116.282-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 26, 2021 at 02:11:15PM +0800, Cai Huoqing wrote:
> Replacing kmalloc/kfree/dma_map_single/dma_unmap_single()
> with dma_alloc_coherent/dma_free_coherent() helps to reduce
> code size, and simplify the code, and coherent DMA will not
> clear the cache every time.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)

Given I don't see any dma_sync_single calls for this mapping, isn't
this a correctness fix too?

Jason
