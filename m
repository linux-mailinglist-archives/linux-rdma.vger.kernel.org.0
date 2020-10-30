Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9BA2A0532
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 13:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgJ3MRe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 08:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3MRe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Oct 2020 08:17:34 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50274C0613CF
        for <linux-rdma@vger.kernel.org>; Fri, 30 Oct 2020 05:17:34 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i7so3867288qti.6
        for <linux-rdma@vger.kernel.org>; Fri, 30 Oct 2020 05:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0uJRysI61WEdLrS5C4Q1hZMy1+DjjCVH3OzvJe5W2MA=;
        b=BhN3vbNmMEmwLT4dx78cHcGq7t0flbI5mJ8/haaHgW3lbm6p5ruWgHWHviPINK7tl7
         PRcSO8u9YXQUH1o/LD54+dzgDM//IhiJMAktGZji80FQRYXbjp5Lq7wc99QVroKc3fZ9
         oVZJPc8en/d4r8pP1F+Ja0BG/5X3OHkwZjBagcliR//O4wsmXJLSI5axM3ycrQlAXyQS
         JdSB1DPSRUnQf+oyp9S41K49KEuj9FE+aNMC1e6EiG0FrXBIq3rzVl7Z/t/9YR581dto
         R4FCQ/F0iV6yPvIHc/kNlUNRsUfOVSKHfx2EettsZxvMyEgYTsZCbYBW0gECUWie/+RG
         yo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0uJRysI61WEdLrS5C4Q1hZMy1+DjjCVH3OzvJe5W2MA=;
        b=E+3RYJQJmMj1v01zT0MIqyJ6l/bosPOcBfYVF03X+CKrc9P50u0o3oK4HoT+aQVpkc
         uLKHeUxPbi7KZ6MZ7ZVJ5dQpRbTwQaRHhB2pcAQHVH4hbMGnLSBW5rlRDjs9emLeGYHu
         6/Zo9wrWloHNeozmSu/Q8DuvmSNyFUsZ81Cmf2hiRkwAzz+eS/YpIeLucCMhG3MxyOXk
         PHnPcOL4+QoAwPiYiHa1OKCJxexXnVNZ1o0ALnIKOpD9fX/VN8sQc5tIE28Oqt5ecukO
         uwa2fse5Tva/XLjI0vwHrGm7vWaaxV2J/mG2ejIrtVAj3CT7+ICdOA463DEgje6ucGVq
         dkTw==
X-Gm-Message-State: AOAM530JG7/JtQ9P/WknUP8t4/BpZI2cAWHGrjwAGZHT9bYF5Bp1BUGp
        FLOc5x5Ryb/Vi8YYJj1AnPvGjw==
X-Google-Smtp-Source: ABdhPJxIADmzeBOA9PnnAgeCvRW58Faq5kKa0HyWkT4Ec5rHm1LwbB7c4TJXLcj/faEyomA8dhLSIQ==
X-Received: by 2002:a05:622a:8a:: with SMTP id o10mr1815900qtw.274.1604060253543;
        Fri, 30 Oct 2020 05:17:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id b12sm1604296qkk.71.2020.10.30.05.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 05:17:32 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kYTLX-00CwsD-U8; Fri, 30 Oct 2020 09:17:31 -0300
Date:   Fri, 30 Oct 2020 09:17:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Parav Pandit <parav@nvidia.com>
Cc:     dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        yanjunz@nvidia.com, bmt@zurich.ibm.com, linux-rdma@vger.kernel.org,
        hch@lst.de, syzbot+34dc2fea3478e659af01@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA: Fix software RDMA drivers for dma mapping error
Message-ID: <20201030121731.GA36674@ziepe.ca>
References: <20201030093803.278830-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030093803.278830-1-parav@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 30, 2020 at 11:38:03AM +0200, Parav Pandit wrote:
> @@ -1140,7 +1141,10 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
>  			    rxe->ndev->dev_addr);
>  	dev->dev.dma_parms = &rxe->dma_parms;
>  	dma_set_max_seg_size(&dev->dev, UINT_MAX);
> -	dma_set_coherent_mask(&dev->dev, dma_get_required_mask(&dev->dev));
> +	dma_mask = IS_ENABLED(CONFIG_64BIT) ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32);
> +	err = dma_coerce_mask_and_coherent(&dev->dev, dma_mask);

Since this mask doesn't actually do anything, what is the reason to
have the 64/32?

Jason
