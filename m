Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54FC3B8080
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2019 19:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391157AbfISRzt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Sep 2019 13:55:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44434 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389717AbfISRzt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Sep 2019 13:55:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id u40so5301662qth.11
        for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2019 10:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9mYeKm9SmK87m0uI361r0iFMOP3ETemOfx14kMWEAKM=;
        b=VLJLg86eAPzJ4JEeSacLcYJGMCZDe8qt4CF6mi6LwK69tuIdV77wZ+bQWRgQYXQNq3
         5s/fJ5QarewnqcNlD1yEW+iXfreCxByYx4C1ukjgNrDNiIZnIscjvT4R59d8aS/z/G3M
         3nHo+56NVNW2dI/1YbQacZC5xd7ujBQSfrMXb8N+ubZfXAnXTHQoqN8NOn9UR+znyLuz
         BDjZRzBUlBHo4ptjJy1/4ZJV6MeQg1dEsFDwCF3LgMxinOu7Tg66BCkKTl2rKdD4mNwi
         /5hcfym83NiEqaCnlDzBEltEe5jVIBvWjUmOylaEUyLGVRWxCktbYeJ6YwCqLdxabHEZ
         0cBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9mYeKm9SmK87m0uI361r0iFMOP3ETemOfx14kMWEAKM=;
        b=HxUX1N5zBRfXsTui0sRR9T9VAJFSz+Bjwt6dCJa3G7ChU7GhWYwzSdXdfIWZ/V3Dtd
         x0683PXzu9J8hasJTWwqWyGxsB9ipkIdAGspL/GVnIDY1X2HKFuEWomCTUyVlnV1XFfy
         9As16ri3Dtwf0bGU0ruGhHZSNmGwiDknVs4lAn3+VIQYUy7ELSNqXuLjYZZWWiIXdeX0
         OzIj+nbc/sKbJZ2slCsrSZ2HC+qYcU7yBGbK6iM0LPqZZgm78cYXUql8xSYRzA67Bm6p
         PUboFV5EcEAy5UzxB0yZBM1B1XS0qOjBfScTnl0Krn5VW98SpmmmKuqLOpBje0Q65/t+
         3lLw==
X-Gm-Message-State: APjAAAWEAnDyj3Y+Ixg6BiEkxAlTZuL3LQBMR5kQcSg+h5sAHDMkGIWU
        SnU0yKN6ep/jLawvBLNp7h0pAA==
X-Google-Smtp-Source: APXvYqxTE9dX6WdExl4I8vRaDoCsHBEH2CO2M3jX2fp10LUzNN6AU2D3tMhr/EANwFv0BKyhzwi1WA==
X-Received: by 2002:ac8:47d6:: with SMTP id d22mr4409404qtr.54.1568915747574;
        Thu, 19 Sep 2019 10:55:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id f11sm4317359qkk.76.2019.09.19.10.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Sep 2019 10:55:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iB0eg-0002W1-C0; Thu, 19 Sep 2019 14:55:46 -0300
Date:   Thu, 19 Sep 2019 14:55:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        bmt@zurich.ibm.com, galpress@amazon.com, sleybo@amazon.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v11 rdma-next 5/7] RDMA/qedr: Use the common mmap API
Message-ID: <20190919175546.GD4132@ziepe.ca>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-6-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905100117.20879-6-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 05, 2019 at 01:01:15PM +0300, Michal Kalderon wrote:

> -int qedr_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
> +void qedr_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
>  {
> -	struct qedr_ucontext *ucontext = get_qedr_ucontext(context);
> -	struct qedr_dev *dev = get_qedr_dev(context->device);
> -	unsigned long phys_addr = vma->vm_pgoff << PAGE_SHIFT;
> -	unsigned long len = (vma->vm_end - vma->vm_start);
> -	unsigned long dpi_start;
> +	struct qedr_user_mmap_entry *entry = get_qedr_mmap_entry(rdma_entry);
>  
> -	dpi_start = dev->db_phys_addr + (ucontext->dpi * ucontext->dpi_size);
> -
> -	DP_DEBUG(dev, QEDR_MSG_INIT,
> -		 "mmap invoked with vm_start=0x%pK, vm_end=0x%pK,vm_pgoff=0x%pK; dpi_start=0x%pK dpi_size=0x%x\n",
> -		 (void *)vma->vm_start, (void *)vma->vm_end,
> -		 (void *)vma->vm_pgoff, (void *)dpi_start, ucontext->dpi_size);
> +	kfree(entry);
> +}

Huh. If you recall we did all this work with the XA and the free
callback because you said qedr was mmaping BAR pages that had some HW
lifetime associated with them, and the HW resource was not to be
reallocated until all users were gone.

I think it would be a better example of this API if you pulled the

 	dev->ops->rdma_remove_user(dev->rdma_ctx, ctx->dpi);

Into qedr_mmap_free().

Then the rdma_user_mmap_entry_remove() will call it naturally as it
does entry_put() and if we are destroying the ucontext we already know
the mmaps are destroyed.

Maybe the same basic comment for EFA, not sure. Gal?

Jason
