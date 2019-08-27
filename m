Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC89E73C
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 14:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfH0MAN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 08:00:13 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:33201 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbfH0MAN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 08:00:13 -0400
Received: by mail-qk1-f171.google.com with SMTP id w18so16745226qki.0
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2019 05:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vsvQjIvdq7jMAzxWonzQpHpcP+/3nHqOZGjdJPYNDb0=;
        b=S7yUNIMkju6OO0Mtnk2vWasRPeZo0FebBki2RyjsbpmcFQfA6eErfuqutdZ7Y9WYSM
         TRVF93k7nS0qTeN+sQMh/aRXxnA2OQcAbF3IMCPMDeuRTECSNKUHxSk2U6v7qU+k3KU3
         XY0UeKqULKn1WcehP7fX4pW1H/fVXOdsBZ4xLOUaoyXNtgI3xJ0Mp/ULxLGNiFQkeqJi
         oImQVbuJPvnbr9rPjq2dAVM1NR1+MNz5SlBEDTmj9Cii+LU7BMqgBmd879K87wZDvYAb
         L9Fv94v3EAT26geruzwnZRUa7Mo7lsRw2UaBZJWMGh9JfePMKr02VFOgTgSS5pftdPrW
         pStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vsvQjIvdq7jMAzxWonzQpHpcP+/3nHqOZGjdJPYNDb0=;
        b=gqYBOYr3awmpUF17GPXmdC1YdOuGoVc5Rk5iyX1N0JLXf9DyHJZ/BZxSra1MhKKoEF
         FuOnpwOBzLg0qKYL03MxjKhobZXp6286QmFOh1zvXwrbvKH37PP2BJe+CbEfvC0i433i
         FP1ZIGBj6GP5ChUrLgFHglJuLRRWgbFywXB0s8A9wVfuvVytp9BRrKFgwPmwdRg+ix0j
         TUeWr3wP1As21dVCWFXCGDQ1XgalujDqZpldOFe9VpcbnGu4EsDI16soE6NkzcKlkZVH
         bbg7PGS9CR9Kiv+TouDei2L6sH+yINsg7ImEWHeI/Wcxr3oEuflFqPrLPGDUGWLKUcTJ
         v8ig==
X-Gm-Message-State: APjAAAUGlASCx34tmuuFUAHi7mMi8FaxLVbdXAWe02CwHMRIAl4ZSUVB
        2pRXP0rF0UKO0Lq2c7wXBYinAQ==
X-Google-Smtp-Source: APXvYqymCyO9hMDfJ7QJpkfnqWFND2RB/u36lOqGI04wOXKLBOoF7scbgLn5g4c0SAzpo45ViNg13g==
X-Received: by 2002:a37:ae42:: with SMTP id x63mr20822217qke.41.1566907212608;
        Tue, 27 Aug 2019 05:00:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id i9sm1821600qkk.82.2019.08.27.05.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 05:00:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2a8x-0001w5-E3; Tue, 27 Aug 2019 09:00:11 -0300
Date:   Tue, 27 Aug 2019 09:00:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: ib_umem_get and DMA_API_DEBUG question
Message-ID: <20190827120011.GA7149@ziepe.ca>
References: <526c5b18-5853-c8dc-e112-31287a46e707@amazon.com>
 <9bae7550-35cf-b183-1e1c-fd1f8e01ef79@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bae7550-35cf-b183-1e1c-fd1f8e01ef79@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 27, 2019 at 11:28:20AM +0300, Gal Pressman wrote:
> On 26/08/2019 17:05, Gal Pressman wrote:
> > Hi all,
> > 
> > Lately I've been seeing DMA-API call traces on our automated testing runs which
> > complain about overlapping mappings of the same cacheline [1].
> > The problem is (most likely) caused due to multiple calls to ibv_reg_mr with the
> > same address, which as a result DMA maps the same physical addresses more than 7
> > (ACTIVE_CACHELINE_MAX_OVERLAP) times.
> 
> BTW, on rare occasions I'm seeing the boundary check in check_sg_segment [1]
> fail as well. I don't have a stable repro for it though.
> 
> Is this a known issue as well? The comment there states it might be a bug in the
> DMA API implementation, but I'm not sure.
> 
> [1] https://elixir.bootlin.com/linux/v5.3-rc3/source/kernel/dma/debug.c#L1230

Maybe we are missing a dma_set_seg_boundary ?

PCI uses low defaults:

	dma_set_max_seg_size(&dev->dev, 65536);
	dma_set_seg_boundary(&dev->dev, 0xffffffff);

Jason
