Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40229DEEEA
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 16:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfJUOKl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 10:10:41 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44894 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfJUOKl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 10:10:41 -0400
Received: by mail-qk1-f193.google.com with SMTP id u22so12693711qkk.11
        for <linux-rdma@vger.kernel.org>; Mon, 21 Oct 2019 07:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lzOJbf8063YmYyr/xZfG3QeViSrUEJkbxsnBeGw4HNA=;
        b=jadw+nHsUg0xfCMwD6tMDMZzkPOKiHvUhy/aK3VsyIoZkndbDxsBIMHVfZF5gJZyKO
         GU7w+8Jb0R4Y67ImLouzYKPLbSCJ9JEK6Xmzq9la391Xx4aZ7j5NbDVBXdWadfaNiqbQ
         TdUl0NiWx1+lJtKBXQm6gE5Epgk9GQY370L9XXgjjI/ipd72aCIjbOxswtWYuK1KviSB
         bnQ2C4HWSeqbIWjPUnBUbAxtrIg58WIAHAa8gV+KFgCQwbNo2MH3aOkKCbibLa0pJMR3
         0FsI5p16CHCv4J6Gi39E3CqIrrEIaCWArTi1zvwdfr7WFNHB8Rb6Ha51WqoLcgM4cXI1
         Tazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lzOJbf8063YmYyr/xZfG3QeViSrUEJkbxsnBeGw4HNA=;
        b=A0Ss8+CGxqnfExQMUMfdN0wdLwHQ9afowtj0mj2Q5WmkMUCWlEGsXiEyTPphal4rwJ
         nzo3FbpAGhznHGauZReUIpi7NwqwqudeWiZ5uHcbkBf8kSus942ZU5qbMFuBVGp48wtL
         pJu9BlN2D9KXVLCNHnf+2EIhp9GK4a+BGLd2IdLzIj1noNeOEGotd2GAx7ILXBLL9YtC
         TKLYcqJOd0/d0oyM72VYDEeHcZu4Xy8pqf75dg3DNGvXnGLrOhRxWil74ssZQN3G5k/K
         O07cYc7VVewFTdTwHfsuRju/p1X83iQTdHKq+TP+KdYKSklokjh/HvOcplnZLeJhg+kw
         dHNA==
X-Gm-Message-State: APjAAAUHWfrPVFbH9tiYhjItveR2FSMsk7WHvn3WS7gngXVLGuwRh5Vg
        LGeyJkFlzNNFryvVekXH0PeAQA==
X-Google-Smtp-Source: APXvYqy/BTIMyuZrsZAjf2ZEKRTmieoEjFlfYx822IVFeMCWCAEXhNcaUnTyxHQBdfiu/TIMwwraRg==
X-Received: by 2002:ae9:ed89:: with SMTP id c131mr17775144qkg.187.1571667040450;
        Mon, 21 Oct 2019 07:10:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id c126sm8706155qkd.13.2019.10.21.07.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 07:10:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMYON-00084E-Fl; Mon, 21 Oct 2019 11:10:39 -0300
Date:   Mon, 21 Oct 2019 11:10:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Adit Ranadive <aditr@vmware.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH 2/4] RDMA/core: Set DMA parameters correctly
Message-ID: <20191021141039.GC25178@ziepe.ca>
References: <20191021021030.1037-1-bvanassche@acm.org>
 <20191021021030.1037-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021021030.1037-3-bvanassche@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 20, 2019 at 07:10:28PM -0700, Bart Van Assche wrote:
> The effect of the dma_set_max_seg_size() call in setup_dma_device() is
> as follows:
> - If device->dev.dma_parms is NULL, that call has no effect at all.
> - If device->dev.dma_parms is not NULL, since that pointer points at
>   the DMA parameters of the parent device, modify the DMA limits of the
>   parent device.
> 
> Both actions are wrong. Instead of changing the DMA parameters of the
> parent device, use the DMA parameters of the parent device if these
> parameters are available.
> 
> Compile-tested only.
> 
> Cc: Michael J. Ruhl <michael.j.ruhl@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Adit Ranadive <aditr@vmware.com>
> Cc: Shiraz Saleem <shiraz.saleem@intel.com>
> Cc: Gal Pressman <galpress@amazon.com>
> Cc: Selvin Xavier <selvin.xavier@broadcom.com>
> Fixes: d10bcf947a3e ("RDMA/umem: Combine contiguous PAGE_SIZE regions in SGEs")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>  drivers/infiniband/core/device.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 536310fb6510..b33d684a2a99 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -1199,9 +1199,18 @@ static void setup_dma_device(struct ib_device *device)
>  		WARN_ON_ONCE(!parent);
>  		device->dma_device = parent;
>  	}
> -	/* Setup default max segment size for all IB devices */
> -	dma_set_max_seg_size(device->dma_device, SZ_2G);
>  
> +	if (!device->dev.dma_parms) {
> +		if (parent) {
> +			/*
> +			 * The caller did not provide DMA parameters. Use the
> +			 * DMA parameters of the parent device.
> +			 */
> +			device->dev.dma_parms = parent->dma_parms;
> +		} else {
> +			WARN_ON_ONCE(true);
> +		}
> +	}
>  }

We really do want to, by default, increase the max_seg_size above 64k
though, so this approach doesn't seem right either.

Jason
