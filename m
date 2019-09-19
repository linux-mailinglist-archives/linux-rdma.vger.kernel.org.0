Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD43B7FCD
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2019 19:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389036AbfISROw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Sep 2019 13:14:52 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45414 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389030AbfISROw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Sep 2019 13:14:52 -0400
Received: by mail-qk1-f196.google.com with SMTP id z67so4117591qkb.12
        for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2019 10:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KJsT2Zz1VkJlTKibh5Tf2URZ9mfDuQWQSOyTg8h51OY=;
        b=Xx++2egRjUSRwOMiex1mOnJ3sdr+y63GXwLblwp85tZuVv48ciWO+Y4W4haWYuj96J
         OATYN0tDF6M3fFXpSfweUKDYS8X6ACo2uWO0hOj4oMARs8Ovhzso0xy0WJAhbi055Lw1
         P87+T9TpshQwW1AF1ypJM0GTejT9V2xKoKTsNfp2ZTmkVeiCrbnSyLBShZmfrM3EJiUS
         mLfRHGTHXSvG++VJvlNjVXLVyiyJLwAxke/nvUC9417Ua3WfFlyUOA/+h1+v2pC+uFB0
         gdeIqmJ6pqCxrFpH5chvfBbWhJolDxqB58ga/Hq0+CwZlA9Z5GZuF/t+a9ugZ/j0X8yt
         IKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KJsT2Zz1VkJlTKibh5Tf2URZ9mfDuQWQSOyTg8h51OY=;
        b=HgQmC44JpoZf/KkOT3L/9QZj/vBbQHOjH3z+SRXNUkX165vLJTYxm/IBqzg1pgPkQ6
         0CyBgmUkzIfbDtz0u9yw/Do7fgM6wmBaGfWsf7TiVVAAh7Ms99WZdJItpCXkjICdJjMQ
         02D2cWM7FW34pBkF+V+26a8CJZvETZKbFP3Ce5ohOIo1sJSYg3142gHNPmF4+vwqSbcp
         VrQ6fDdBkvrZAezrUaOg9L3BU0F34V9Ii0pk3PsrdfsnlSpbyEHpjNdrxcMPpeGVC0PX
         OdK6h2/LUGhtFV10QGjTPbnwyx/pI1vUvH3hxM/gVV4Ay2iCQD0u0Ssuwt+O528O7Lar
         IqBg==
X-Gm-Message-State: APjAAAWlHzX4GNY66iBck7VNZY0qseca7Uw+FMOvwAdnFFZO31kL2Ute
        KCJJ0UznkN/6Ekm1QtmO0cfG5A==
X-Google-Smtp-Source: APXvYqwcuz6mWeATE6/kZb0EUT+J/o7qIkGVj0ZhOO71lYjQoPqFMiVOpsvHz0RBF6jbbGKOe1Nheg==
X-Received: by 2002:a05:620a:7c8:: with SMTP id 8mr3777521qkb.299.1568913291503;
        Thu, 19 Sep 2019 10:14:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id e11sm3676211qkg.134.2019.09.19.10.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Sep 2019 10:14:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iB014-0002GF-Am; Thu, 19 Sep 2019 14:14:50 -0300
Date:   Thu, 19 Sep 2019 14:14:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        bmt@zurich.ibm.com, galpress@amazon.com, sleybo@amazon.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v11 rdma-next 2/7] RDMA/core: Create mmap database and
 cookie helper functions
Message-ID: <20190919171450.GA4132@ziepe.ca>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-3-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905100117.20879-3-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 05, 2019 at 01:01:12PM +0300, Michal Kalderon wrote:

>  int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
>  		      unsigned long pfn, unsigned long size, pgprot_t prot)
>  {
>  	struct ib_uverbs_file *ufile = ucontext->ufile;
> -	struct rdma_umap_priv *priv;
> +	int ret;
>  
>  	if (!(vma->vm_flags & VM_SHARED))
>  		return -EINVAL;
> @@ -57,17 +114,240 @@ int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
>  		return -EINVAL;
>  	lockdep_assert_held(&ufile->device->disassociate_srcu);
>  
> -	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;
> +	ret = rdma_umap_priv_init(vma, NULL);
> +	if (ret)
> +		return ret;
>  
>  	vma->vm_page_prot = prot;
>  	if (io_remap_pfn_range(vma, vma->vm_start, pfn, size, prot)) {
> -		kfree(priv);
> +		rdma_umap_priv_delete(ufile, vma->vm_private_data);
>  		return -EAGAIN;

This leaves vma->vm_private_data set to the priv after it has been
freed. This does not seem like such a good idea, can it use after
free? It looks like no, but still would not be a bad idea to null it
here.

Jason
