Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183FB1E878F
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2020 21:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgE2TSA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 May 2020 15:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgE2TR7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 May 2020 15:17:59 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B59C08C5C8
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 12:17:59 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id dp10so1593185qvb.10
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 12:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WgYG8o4kupKbQe3K5BaY+jyrwJvNDrJeU9+LGFN8Iq8=;
        b=IQ/UxcLCGyEyana5y/Ptgwr/S0blR94p1wf3kPfSwKNsVGGoNClwe83zRkkZEkBTZs
         V0HhsPXrO/5laY8QXHCoxXu3Ad1As+mfHkp46Raym24OCGaZyXDbgo9lBNsgf59c3pQq
         AygcplRo5cv0mEgx9ZKk91v0Jj9gRWHnDMxvpx492Itp1c2G3Wh9GmhCiTMQsVk4UyJj
         iJ2laUtY/4RLYKtsPjGJ62Yw2d2Ptptq2No+xr3EwmQLCiYpA+DmeAGYVPKTy2h1wuZz
         BcurnaxBdsHAqdrCvBuC7xtDxpc+9i5ZjBeiDl3mVLePjaRZnGYwjaNlkiEIy/Ywaa4t
         H7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WgYG8o4kupKbQe3K5BaY+jyrwJvNDrJeU9+LGFN8Iq8=;
        b=CQbFTUu21i0TaUoTezBBhM3j20TI4N51qzOzZtL4sTxxNtOqYHGWuHmTnhu/Xt7ZBd
         mVCtjKXMntczGbCr0gxFu7w2zRp5rP/zAC4K0QvB6IAwQ7QsH380T/DhBWwvEi92fyNm
         KdLwTakJ9NsGE3F79JaeRNqWoXYNJfYPhVjL5UeCKm5maeF8TN4E8X2tE4I3SIfdsqc6
         pGklByTyBq0duDHtkretp7X5NjuSpxcV+y0oXp9H78lUnTlOc2BitANEy48FqQTICY+f
         5j+oGi5jcYY3LFEKvlQq4EvSaxWxj2Gyy3ywRwnV+ik7JXz+Yq7UZ28gIsA6PlphMWwV
         WDKQ==
X-Gm-Message-State: AOAM531/gYkr0+WnHTckaTKmApApePS3M/3buoOvGf/DWYlgd/IMi+/m
        5bTxj+24unywCU6msOrjMXyDkQ8OIfc=
X-Google-Smtp-Source: ABdhPJzWeND+zqBLmykAhUrooiACl2eWqWjGN/72wzf4HmafPoIbHjrqdB96MtB3rEfyiPZOxRPRKQ==
X-Received: by 2002:ad4:4c4f:: with SMTP id cs15mr9355458qvb.117.1590779878460;
        Fri, 29 May 2020 12:17:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v14sm9315369qtj.31.2020.05.29.12.17.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 12:17:58 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jekVx-0003Dj-Ha; Fri, 29 May 2020 16:17:57 -0300
Date:   Fri, 29 May 2020 16:17:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Cc:     Ariel Elior <aelior@marvell.com>, aron.silverton@oracle.com,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Israel Rukshin <israelr@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Michal Kalderon <mkalderon@marvell.com>, oren@mellanox.com,
        Sagi Grimberg <sagi@grimberg.me>, santosh.shilimkar@oracle.com,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>, shlomin@mellanox.com,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        vladimirk@mellanox.com, Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH v3 00/13] Remove FMR support from RDMA drivers
Message-ID: <20200529191757.GA12325@ziepe.ca>
References: <0-v3-f58e6669d5d3+2cf-fmr_removal_jgg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v3-f58e6669d5d3+2cf-fmr_removal_jgg@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 28, 2020 at 04:45:42PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> This series removes the support for FMR mode to register memory. This
> ancient mode is unsafe (rkeys that are usually exposed for caching
> purposes and the API is limited to page granularity mappings) and not
> maintained/tested in the last few years. It also doesn't have any
> reasonable advantage over other memory registration methods such as
> FRWR (that is implemented in all the recent RDMA adapters). This series
> should be reviewed and approved by the maintainer of the effected drivers
> and I suggest to test it as well.
> 
> Changes from V2:
>  - Removed more occurances of _fmr
>  - Remove max_map_per_fmr device attribute
>  - Remove max_fmr device attribute
>  - Remove additional dead code from bnxt_re and i40iw
>  - Revised RDS to not use ib_fmr_attr or other fmr things
>  - Rebased on RDMA for-next
> Changes from V1:
>  https://lore.kernel.org/linux-rdma/20200527094634.24240-1-maxg@mellanox.com/
>  - added "RDMA/mlx5: Remove FMR leftovers" (from GalP)
>  - rebased on top of "Linux 5.7-rc7"
>  - added "Reviewed-by" Bart signature for SRP
> 
> Cc: shlomin@mellanox.com
> Cc: vladimirk@mellanox.com
> Cc: oren@mellanox.com
> 
> Gal Pressman (1):
>   RDMA/mlx5: Remove FMR leftovers
> 
> Israel Rukshin (1):
>   RDMA/iser: Remove support for FMR memory registration
> 
> Jason Gunthorpe (4):
>   RDMA/bnxt_re: Remove FMR leftovers
>   RDMA/i40iw: Remove FMR leftovers
>   RDMA: Remove 'max_fmr'
>   RDMA: Remove 'max_map_per_fmr'
> 
> Max Gurtovoy (7):
>   RDMA/srp: Remove support for FMR memory registration
>   RDMA/rds: Remove FMR support for memory registration
>   RDMA/core: Remove FMR pool API
>   RDMA/mlx4: Remove FMR support for memory registration
>   RDMA/mthca: Remove FMR support for memory registration
>   RDMA/rdmavt: Remove FMR memory registration
>   RDMA/core: Remove FMR device ops

Applied to for-next

Jason
