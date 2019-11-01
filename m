Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51D53EC871
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 19:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKAS0P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Nov 2019 14:26:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45192 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfKAS0P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Nov 2019 14:26:15 -0400
Received: by mail-qt1-f194.google.com with SMTP id x21so14039664qto.12
        for <linux-rdma@vger.kernel.org>; Fri, 01 Nov 2019 11:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gf48vjpUJOI371bNO6wuyPSeEKQoVC5o/vcfCQf27GI=;
        b=JWQs9dhnB75sOXYZXe00Sx8Ycjn6wXVLJb4bA4loebrzhAwONRCd3M5hdaM0XcPXz1
         0pyWtlLrDj1njuvPs0zQ0ulMeEyYu9AvLupxmw9YV4Vil+0G3KASfmA7bMmkBjsVbLm0
         NwKPrT73FZLPw9yxM2LsvyNjyyW57QaAakB9IZRdrjquWCFH5qzR698e9e1ojGeAZOIU
         KBToGNUChheA/LNzlqzqO22UYmvZ00/yxcgviEIwglK7aIkeobtD5FAioyP3loLN1pgO
         xAWVbCdTVv2/yYYX7qXzDiZnl3pkn6y+wuJtS5dp5Cn2pGV9z3geaSwd6yE4+Biq0CTg
         qgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gf48vjpUJOI371bNO6wuyPSeEKQoVC5o/vcfCQf27GI=;
        b=rDUyi3d4/6Ity1JqdLkWhcfDqOXxXoew8VPnVGIMg4gCz99AjdRT6+VPpF1Scc+isG
         oBIBuxk2mPx5fcYTWZHD+S06lKkjD16fbhQsA0KaEJs3q+ot0cTz0d0kyEIKG5u1OwEt
         54yhGp5dNev/WR9N6bfjkhpP2lET/2LYZCuKgUNUsEIgqbI/PfYNO17OtekvicPNJ1rk
         yXrsFENdDkOMXD3r4+Mu8V4r9CUL/UjNq2bVvLnqc67e0VQ/VGbBaIJ56f5b7eMDYRDX
         kOldxsgInReChFKKe11BrzzQF3YnDxSb+ICW6oc4+sN/p92+9sqZ6K4m7WQSCRY7rZna
         4oMA==
X-Gm-Message-State: APjAAAUngcNQwOmvGHQEUvb8OQa8xIZHLt0Eqc0BOXFe39/2rqc4puRz
        OIexlNxUn3enZhMmzK2S9+fqag==
X-Google-Smtp-Source: APXvYqxlEpFiUQP9ickqdfrdsM0skeumHMpJp062tTi17mtiKR8bSsZEkpehUJ8EZgMrejKnz1agZQ==
X-Received: by 2002:a0c:8884:: with SMTP id 4mr11433684qvn.248.1572632773480;
        Fri, 01 Nov 2019 11:26:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id x10sm5932634qtj.25.2019.11.01.11.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Nov 2019 11:26:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iQbci-0008HC-0J; Fri, 01 Nov 2019 15:26:12 -0300
Date:   Fri, 1 Nov 2019 15:26:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        nouveau@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 08/15] xen/gntdev: Use select for DMA_SHARED_BUFFER
Message-ID: <20191101182611.GA31478@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-9-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028201032.6352-9-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 05:10:25PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> DMA_SHARED_BUFFER can not be enabled by the user (it represents a library
> set in the kernel). The kconfig convention is to use select for such
> symbols so they are turned on implicitly when the user enables a kconfig
> that needs them.
> 
> Otherwise the XEN_GNTDEV_DMABUF kconfig is overly difficult to enable.
> 
> Fixes: 932d6562179e ("xen/gntdev: Add initial support for dma-buf UAPI")
> Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: xen-devel@lists.xenproject.org
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/xen/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Juergen/Oleksandr/Xen Maintainers:

Would you take this patch through a xen related tree? The only reason
I had in this series is to make it easier to compile-test the gntdev
changes.

Since it is looking like the gntdev rework might not make it this
cycle it is probably best for you to take it.

Thanks,
Jason
