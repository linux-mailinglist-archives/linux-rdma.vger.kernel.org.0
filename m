Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5A22A8122
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 15:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgKEOlZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 09:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbgKEOlZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 09:41:25 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D826C0613D2
        for <linux-rdma@vger.kernel.org>; Thu,  5 Nov 2020 06:41:25 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id i21so1308321qka.12
        for <linux-rdma@vger.kernel.org>; Thu, 05 Nov 2020 06:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BRRBZT8ySKIFRsUMyPGRaPv+NMBfsy6kK0WAjQoESxI=;
        b=BYnwWa1P88rlA3UDi6FSzwBMdDQPUUwP2XaWTm1vxRuPg19YVq+UV3c+8KvPaFJPIz
         I0Z2FL/+WwSfaeV1hcTdPGRCiVmcZcu9Vr6A+4aRK6zpSsBA9FFB/5iDEny9p6YTU/Kz
         KJb6K0ZjPjOHN6tbjYQNfYKmKJdjd06oWTwaPqk0oT/kG3E7yL+ouGO/Mbbb6T/60H4Z
         nww6Q0xXCcrq4NEWGdEP01YUsw66Bxu7ZDq7ag5N1uvRx+p5RCTCCQbjS8dIvcGfTj6X
         MVft2KMHswtIvmE7epRbA4kA1JJld+WMHXuCd3I4t29jX4TrD9Hi4HHQvuI0v7qWW1jz
         O+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BRRBZT8ySKIFRsUMyPGRaPv+NMBfsy6kK0WAjQoESxI=;
        b=iTwPIOFH6UEz+OhDrA7TrbBt/RUsXxHGd54ToJxYHc0PZg8W+1atOx0aBqE52hlrqo
         CUBvghaLfoDCkX75e5rlHv9sdbMj0+ERL49jpQj1aL53Y1DBLXJNS6rEPQup1HeFABJu
         qFtSo2abbC9AqEdhG4kWLBBUcTbE5y//2jOtwGBB6Il5bBu0Tm3sEYGaFxmhmOK/hzY0
         KCu4nilc3i8vY5A4IsJqM2l/T0IS0Gr3rks3WZMYCDkptBdlw355CjShx5xmAje/Y6mc
         3fZir0sKwgs/2XVdAZHXoooRiFGm/00nEpmxFeDInTE2+/G92oZIyONcHcfwBDBf9okN
         LYEA==
X-Gm-Message-State: AOAM533/u4q3jG4h+dZepmsEWiDXbcWlQFYQL3w2tXQStXdmzyLvopuj
        tOPiXM/3HCDr38zI7z8Rin2CIA==
X-Google-Smtp-Source: ABdhPJwFColY0yT1w1m9snQuiX4vEjEAvWqS1IYW9nZwAHU7eHJgA48cXdx+o3zYeJbmlaWlKFEdKw==
X-Received: by 2002:a37:a903:: with SMTP id s3mr2319716qke.391.1604587284369;
        Thu, 05 Nov 2020 06:41:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 9sm1162119qkv.110.2020.11.05.06.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:41:23 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kagS3-00HNt1-1F; Thu, 05 Nov 2020 10:41:23 -0400
Date:   Thu, 5 Nov 2020 10:41:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 1/6] RMDA/sw: don't allow drivers using dma_virt_ops on
 highmem configs
Message-ID: <20201105144123.GB4142106@ziepe.ca>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105074205.1690638-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 08:42:00AM +0100, Christoph Hellwig wrote:
> dma_virt_ops requires that all pages have a kernel virtual address.
> Introduce a INFINIBAND_VIRT_DMA Kconfig symbol that depends on !HIGHMEM
> and a large enough dma_addr_t, and make all three driver depend on the
> new symbol.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  drivers/infiniband/Kconfig           | 6 ++++++
>  drivers/infiniband/sw/rdmavt/Kconfig | 3 ++-
>  drivers/infiniband/sw/rxe/Kconfig    | 2 +-
>  drivers/infiniband/sw/siw/Kconfig    | 1 +
>  4 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> index 32a51432ec4f73..81acaf5fb5be67 100644
> +++ b/drivers/infiniband/Kconfig
> @@ -73,6 +73,12 @@ config INFINIBAND_ADDR_TRANS_CONFIGFS
>  	  This allows the user to config the default GID type that the CM
>  	  uses for each device, when initiaing new connections.
>  
> +config INFINIBAND_VIRT_DMA
> +	bool
> +	default y

Oh, I haven't seen this kconfig trick with default before..

> +	depends on !HIGHMEM
> +	depends on !64BIT || ARCH_DMA_ADDR_T_64BIT
> +
>  if INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
>  source "drivers/infiniband/hw/mthca/Kconfig"
>  source "drivers/infiniband/hw/qib/Kconfig"
> diff --git a/drivers/infiniband/sw/rdmavt/Kconfig b/drivers/infiniband/sw/rdmavt/Kconfig
> index 9ef5f5ce1ff6b0..c8e268082952b0 100644
> +++ b/drivers/infiniband/sw/rdmavt/Kconfig
> @@ -1,7 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config INFINIBAND_RDMAVT
>  	tristate "RDMA verbs transport library"
> -	depends on X86_64 && ARCH_DMA_ADDR_T_64BIT
> +	depends on INFINIBAND_VIRT_DMA

Usually I would expect a non-menu item to be used with select not
'depends on' - is the use of default avoiding that?

This looks nice

Jason
