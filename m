Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D28C2C2D93
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 17:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbgKXQ63 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 11:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgKXQ63 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Nov 2020 11:58:29 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA08C0613D6
        for <linux-rdma@vger.kernel.org>; Tue, 24 Nov 2020 08:58:29 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id m65so16522297qte.11
        for <linux-rdma@vger.kernel.org>; Tue, 24 Nov 2020 08:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fddjU/4HSPzFNEnV0vUK3Hg4ZN54TRVTD2cIUhZFQhU=;
        b=JAvv/k0v1mSyKhCcZhARJ9j8RUdYDClFyAAGOLydMVq2omVpjCKc7Ce5/fO98Efz4p
         gzQaPGxNFu140IBHSpaA5+yD6/FR0h2gQxOQaDhzjSmQKNM6L9dnNKilLffe4gi7KeGx
         cb5Wsmkt+144jaIi85mCp3froyaAgcK/UPTQYcNSpZW7sRuu6F/yfYBAzJVEDweHsEE+
         yCZnHyTYj/rKvoefExTO/EX68WufJJNEJrjC5x5hnfR15KdrlNwX4EjBlABnzgWpu1lC
         R+yMqCRcml8kqmBps5n9L9JpQPsjk/y1vva1s8w+Rm1nLMZNDHNJC/lcfLGmh69x1c7r
         se+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fddjU/4HSPzFNEnV0vUK3Hg4ZN54TRVTD2cIUhZFQhU=;
        b=dwHRDCS/Pwovpawzhr8gSDAav8Jv7qTgaK64ZrGi7pOpmb1jNF59xrDaDJ0+L9e8R/
         RG99igtALvqGUT7zY95mGrF6Xrl2ti7+Qhe1L7f43bcIwu9A2UN0G6LnE1F+Lv6NVUwE
         qqUnNaN0LXgBF0bKVpH/O68a0Q/EjDE6ERZHTtANhfWuNE+jKSOTAd1hUvWGQtl8gJcQ
         3T6FWBTCwNaYtkT30gWMVogbuCw7exXUxy/YhUQahfBB0YLdvjzfPTTP3dIh6D/gHUJB
         NMc8DcWyMuxzcIyu6eAThF6aV4RmBO9MXSCbFVM0pHo5Wxi1EP9cW2CBw3dJKNQLRotn
         Yraw==
X-Gm-Message-State: AOAM533mvA/FMgCtaH/UVOdBJ/GXJyb9g3Z/8pLgktE2VJl3OywlDbKk
        uwhcjfgwmzuUDruj8CGotadpkg==
X-Google-Smtp-Source: ABdhPJycp18ssHWseJIGbxiBsn4oarPMAEKiUWprW4blYpVq6N6aKiFYYMYXfNcPVs1y7tC9PPX1vA==
X-Received: by 2002:ac8:41d4:: with SMTP id o20mr5082150qtm.313.1606237108320;
        Tue, 24 Nov 2020 08:58:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id j19sm13460394qkk.119.2020.11.24.08.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 08:58:27 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1khbe6-000sKp-Ja; Tue, 24 Nov 2020 12:58:26 -0400
Date:   Tue, 24 Nov 2020 12:58:26 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org, stable@kernel.org,
        Di Zhu <zhudi21@huawei.com>
Subject: Re: [PATCH] RDMA/i40iw: Address an mmap handler exploit in i40iw
Message-ID: <20201124165826.GI5487@ziepe.ca>
References: <20201123225625.1556-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123225625.1556-1-shiraz.saleem@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 23, 2020 at 04:56:24PM -0600, Shiraz Saleem wrote:
> i40iw_mmap manipulates the vma->vm_pgoff to differentiate a push page
> mmap vs a doorbell mmap, and uses it to compute the pfn in remap_pfn_range
> without any validation. This is vulnerable to an mmap exploit as
> described in [1].
> 
> Push feature is disabled in the driver currently and therefore no push
> mmaps are issued from user-space. The feature does not work as expected
> in the x722 product. So remove it along with the VMA attribute
> manipulations for it in i40iw_mmap.
> 
> Update i40iw_mmap to only allow DB user mmapings at offset = 0.
> Check vm_pgoff for zero and if the mmaps are bound to a single page.
> 
> [1] https://lore.kernel.org/linux-rdma/20201119093523.7588-1-zhudi21@huawei.com/raw
> 
> Fixes: d37498417947 ("i40iw: add files for iwarp interface")
> Cc: stable@kernel.org
> Reported-by: Di Zhu <zhudi21@huawei.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw.h        |    1 -
>  drivers/infiniband/hw/i40iw/i40iw_ctrl.c   |   52 +------------
>  drivers/infiniband/hw/i40iw/i40iw_d.h      |   35 +++-----
>  drivers/infiniband/hw/i40iw/i40iw_main.c   |    5 -
>  drivers/infiniband/hw/i40iw/i40iw_status.h |    1 -
>  drivers/infiniband/hw/i40iw/i40iw_type.h   |   18 ----
>  drivers/infiniband/hw/i40iw/i40iw_uk.c     |   41 +--------
>  drivers/infiniband/hw/i40iw/i40iw_user.h   |    8 --
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c  |  123 ++--------------------------
>  9 files changed, 26 insertions(+), 258 deletions(-)

This is great, but it is too big for a single security patch stable
back port. Please split it to two patches

> diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
> index 2408b27..584932d 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_main.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
> @@ -54,10 +54,6 @@
>  #define DRV_VERSION	__stringify(DRV_VERSION_MAJOR) "."		\
>  	__stringify(DRV_VERSION_MINOR) "." __stringify(DRV_VERSION_BUILD)
>  
> -static int push_mode;
> -module_param(push_mode, int, 0644);
> -MODULE_PARM_DESC(push_mode, "Low latency mode: 0=disabled (default), 1=enabled)");

The first should delete this module param (so push_mode == 0), and
then this:

> diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> index 581ecba..26dac09 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> @@ -167,111 +167,18 @@ static void i40iw_dealloc_ucontext(struct ib_ucontext *context)
>   */
>  static int i40iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
>  {
> -	struct i40iw_ucontext *ucontext;
> -	u64 db_addr_offset, push_offset, pfn;
> -
> -	ucontext = to_ucontext(context);
> -	if (ucontext->iwdev->sc_dev.is_pf) {
> -		db_addr_offset = I40IW_DB_ADDR_OFFSET;
> -		push_offset = I40IW_PUSH_OFFSET;
> -		if (vma->vm_pgoff)
> -			vma->vm_pgoff += I40IW_PF_FIRST_PUSH_PAGE_INDEX - 1;
> -	} else {
> -		db_addr_offset = I40IW_VF_DB_ADDR_OFFSET;
> -		push_offset = I40IW_VF_PUSH_OFFSET;
> -		if (vma->vm_pgoff)
> -			vma->vm_pgoff += I40IW_VF_FIRST_PUSH_PAGE_INDEX - 1;
> -	}
> +	struct i40iw_ucontext *ucontext = to_ucontext(context);
> +	u64 dbaddr_pgoff, pfn;
>  
> -	vma->vm_pgoff += db_addr_offset >> PAGE_SHIFT;
> -
> -	if (vma->vm_pgoff == (db_addr_offset >> PAGE_SHIFT)) {
> -		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -	} else {
> -		if ((vma->vm_pgoff - (push_offset >> PAGE_SHIFT)) % 2)
> -			vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -		else
> -			vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> -	}
> +	if (vma->vm_pgoff || vma->vm_end - vma->vm_start != PAGE_SIZE)
> +		return -EINVAL;
>  
> -	pfn = vma->vm_pgoff +
> -	      (pci_resource_start(ucontext->iwdev->ldev->pcidev, 0) >>
> -	       PAGE_SHIFT);
> +	dbaddr_pgoff = I40IW_DB_ADDR_OFFSET >> PAGE_SHIFT;
> +	pfn = dbaddr_pgoff + (pci_resource_start(ucontext->iwdev->ldev->pcidev, 0)
> +			      >> PAGE_SHIFT);
>  
>  	return rdma_user_mmap_io(context, vma, pfn, PAGE_SIZE,
> -				 vma->vm_page_prot, NULL);
> -}

Which should fix the bug and is a reasonable security backport

I would also write the math as 

        dbaddr = pci_resource_start(ucontext->iwdev->ldev->pcidev, 0) + I40IW_DB_ADDR_OFFSET
 	return rdma_user_mmap_io(context, vma, dbaddr >> PAGE_SHIFT, PAGE_SIZE,
				 vma->vm_page_prot, NULL);

Which is easier to understand

Then the 2nd patch is all the purging

Jason
