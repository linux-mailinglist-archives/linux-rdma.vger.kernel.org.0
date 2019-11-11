Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6320DF6D3F
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Nov 2019 04:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfKKDVN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Nov 2019 22:21:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:22964 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbfKKDVN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 10 Nov 2019 22:21:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Nov 2019 19:21:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,291,1569308400"; 
   d="scan'208";a="207006324"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga006.jf.intel.com with ESMTP; 10 Nov 2019 19:21:11 -0800
Date:   Sun, 10 Nov 2019 19:21:11 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] IB/umem: use get_user_pages_fast() to pin DMA pages
Message-ID: <20191111032111.GA30123@iweiny-DESK2.sc.intel.com>
References: <20191109020434.389855-1-jhubbard@nvidia.com>
 <20191109020434.389855-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191109020434.389855-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 08, 2019 at 06:04:34PM -0800, John Hubbard wrote:
> And get rid of the mmap_sem calls, as part of that. Note
> that get_user_pages_fast() will, if necessary, fall back to
> __gup_longterm_unlocked(), which takes the mmap_sem as needed.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/infiniband/core/umem.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index 24244a2f68cc..3d664a2539eb 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -271,16 +271,13 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
>  	sg = umem->sg_head.sgl;
>  
>  	while (npages) {
> -		down_read(&mm->mmap_sem);
> -		ret = get_user_pages(cur_base,
> -				     min_t(unsigned long, npages,
> -					   PAGE_SIZE / sizeof (struct page *)),
> -				     gup_flags | FOLL_LONGTERM,
> -				     page_list, NULL);
> -		if (ret < 0) {
> -			up_read(&mm->mmap_sem);
> +		ret = get_user_pages_fast(cur_base,
> +					  min_t(unsigned long, npages,
> +						PAGE_SIZE /
> +						sizeof(struct page *)),
> +					  gup_flags | FOLL_LONGTERM, page_list);
> +		if (ret < 0)
>  			goto umem_release;
> -		}
>  
>  		cur_base += ret * PAGE_SIZE;
>  		npages   -= ret;
> @@ -288,8 +285,6 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
>  		sg = ib_umem_add_sg_table(sg, page_list, ret,
>  			dma_get_max_seg_size(context->device->dma_device),
>  			&umem->sg_nents);
> -
> -		up_read(&mm->mmap_sem);
>  	}
>  
>  	sg_mark_end(sg);
> -- 
> 2.24.0
> 
