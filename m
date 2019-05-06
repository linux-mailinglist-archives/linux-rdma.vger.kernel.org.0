Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2772A151DC
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 18:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfEFQqV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 12:46:21 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46421 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfEFQqV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 12:46:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id i31so15439306qti.13
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2019 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eKl3pRvpBbK7BXJJ/Qiefg5coqREI36pcR8y8LRfQQg=;
        b=N9SZSLY9tOQnLzEquqwt9hsDwEXA7RMikqXPDOz1o1uvNqT7cCxP5dwNARm3dhD8yR
         YbkNSmt7rzoObhuqnfhXgzNzjxTV2NSsAR5JP65qTgsQx/KUeRD0WqwysIdzv3VbWIFk
         XzT2AJlzqgivdCGYCgZMFCDKXfd+2prgwAcSm6MzVida+j2QX82BTqdEtC6Tbwmn8BeR
         liA9i8vJZmGMHh3JGh82UdI4p3pHalYImZT4ejX8zmo2Ijs6fD7D/I/hZtzIQxlee8bP
         57ehFzZ2T9ed6isjRslZM1mDWE38xwxm1Jc7T/3pfjh/WuQrrIl7SbsAJu0axaaFqUEE
         pQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eKl3pRvpBbK7BXJJ/Qiefg5coqREI36pcR8y8LRfQQg=;
        b=PV6m6Rf7SKN7L9BEKZI+/HmhmGDTx7P+HJKWSGrh1RlxfuuEcjbN5CO9txXtQrx1Wi
         eAZFRLAILN2CZRAl+RF+BQIZ3oP6Vyh4IO+82nXXzFSBKW5L2jo1Dl61upWFfeaUjmzq
         upGYeZqz9zQge//Ouxpyv1qLLhE7uwzVHlj1g6TulssK+F+A98Q4S7oaclsGSZIZ32F5
         IJvFBBxoYcl6lExp8Lnz01lw67h4d6gQpvj4yIgX+hseWNQ6Ka6CezmSGOY/qVtz9CvX
         T+ukMS4IQFzZhxZZJHbF80nKpNaQRbhlOLoARjiEii5EKxLETVQxMJK3sZnnm1/Zduhg
         KUlw==
X-Gm-Message-State: APjAAAWm2RHdUn0umcVCkqdXabKQzVdlsmZTl6uYXyepV+7pIrnycf5O
        fOU+E8z9uA1iujV0t3P2+W5txQ==
X-Google-Smtp-Source: APXvYqxUgj5j6Hiw7SD7CcVdPU/XxELn28sE8IZFW9ytCidYB+zHAUldYLiUJqZCDTK4uql8un1iDw==
X-Received: by 2002:a0c:b204:: with SMTP id x4mr4482402qvd.150.1557161179838;
        Mon, 06 May 2019 09:46:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id p6sm5615944qkc.13.2019.05.06.09.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 09:46:18 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hNgks-0006HM-4Z; Mon, 06 May 2019 13:46:18 -0300
Date:   Mon, 6 May 2019 13:46:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 rdma-next 0/6] Introduce a DMA block iterator
Message-ID: <20190506164618.GA20945@ziepe.ca>
References: <20190506135337.11324-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506135337.11324-1-shiraz.saleem@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 06, 2019 at 08:53:31AM -0500, Shiraz Saleem wrote:
> From: "Saleem, Shiraz" <shiraz.saleem@intel.com>
> 
> This patch set is aiming to allow drivers to leverage a new DMA
> block iterator to get contiguous aligned memory blocks within
> their HW supported page sizes. The motivation for this work comes
> from the discussion in [1].
> 
> The first patch introduces a new umem API that allows drivers to find a
> best supported page size to use for the MR, from a bitmap of HW supported
> page sizes.
> 
> The second patch introduces a new DMA block iterator that returns allows
> drivers to get aligned DMA addresses within a supplied best page size.
> 
> The third patch and fouth patch removes the dependency of i40iw and bnxt_re
> drivers on the hugetlb flag. The new core APIs are called in these drivers to
> get huge page size aligned addresses if the MR is backed by huge pages.
> 
> The fifth patch removes the hugetlb flag from IB core.
> 
> The sixth patch extends the DMA block itertaor for HW that can support mixed
> block sizes. This patch is untested.
> 
> [1] https://patchwork.kernel.org/patch/10499753/
> 
> RFC-->v0:
> ---------
> * Add to scatter table by iterating a limited sized page list.
> * Updated driver call sites to use the for_each_sg_page iterator
>   variant where applicable.
> * Tweaked algorithm in ib_umem_find_single_pg_size and ib_umem_next_phys_iter
>   to ignore alignment of the start of first SGE and end of the last SGE.
> * Simplified ib_umem_find_single_pg_size on offset alignments checks for
>   user-space virtual and physical buffer.
> * Updated ib_umem_start_phys_iter to do some pre-computation
>   for the non-mixed page support case.
> * Updated bnxt_re driver to use the new core APIs and remove its
>   dependency on the huge tlb flag.
> * Fixed a bug in computation of sg_phys_iter->phyaddr in ib_umem_next_phys_iter.
> * Drop hugetlb flag usage from RDMA subsystem.
> * Rebased on top of for-next.
> 
> v0-->v1:
> --------
> * Remove the patches that update driver to use for_each_sg_page variant
>   to iterate in the SGE. This is sent as a seperate series using
>   the for_each_sg_dma_page variant.
> * Tweak ib_umem_add_sg_table API defintion based on maintainer feedback.
> * Cache number of scatterlist entries in umem.
> * Update function headers for ib_umem_find_single_pg_size and ib_umem_next_phys_iter.
> * Add sanity check on supported_pgsz in ib_umem_find_single_pg_size.
> 
> v1-->v2:
> --------
> *Removed page combining patch as it was sent stand alone.
> *__fls on pgsz_bitmap as opposed to fls64 since it's an unsigned long.
> *rename ib_umem_find_pg_bit() --> rdma_find_pg_bit() and moved to ib_verbs.h
> *rename ib_umem_find_single_pg_size() --> ib_umem_find_best_pgsz()
> *New flag IB_UMEM_VA_BASED_OFFSET for ib_umem_find_best_pgsz API for HW that uses least significant bits
>   of VA to indicate start offset into DMA list.
> *rdma_find_pg_bit() logic is re-written and simplified. It can support input of 0 or 1 dma addr cases.
> *ib_umem_find_best_pgsz() optimized to be less computationally expensive running rdma_find_pg_bit() only once.
> *rdma_for_each_block() is the new re-designed DMA block iterator which is more in line with for_each_sg_dma_page()iterator.
> *rdma_find_mixed_pg_bit() logic for interior SGE's accounting for start and end dma address. 
> *remove i40iw specific enums for supported page size
> *remove vma_list form ib_umem_get()
> 
> v2-->v3:
> ---------
> *Check VA/PA bits misalignment to restrict max page size for all SGL address in ib_umem_find_best_pgsz()
> *ib_umem_find_best_pgsz() extended to work with any IOVA
> *IB_UMEM_VA_BASED_OFFSET flag removed.
> *DMA block iterator API split into 2 patches. One for HW that supports single blocks and
> second which extends the API to support HW that can do mixed block sizes.
> 
> Shiraz Saleem (6):
>   RDMA/umem: Add API to find best driver supported page size in an MR
>   RDMA/verbs: Add a DMA iterator to return aligned contiguous memory
>     blocks
>   RDMA/i40iw: Use core helpers to get aligned DMA address within a
>     supported page size
>   RDMA/bnxt_re: Use core helpers to get aligned DMA address
>   RDMA/umem: Remove hugetlb flag

Applied to for-next except for:

>   RDMA/verbs: Extend DMA block iterator support for mixed block sizes

Thanks,
Jason
