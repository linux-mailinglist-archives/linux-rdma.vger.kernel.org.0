Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDEEE707DB
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 19:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfGVRuE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 13:50:04 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42735 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfGVRuE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 13:50:04 -0400
Received: by mail-vs1-f65.google.com with SMTP id 190so26795935vsf.9
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2019 10:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6cBllQGcEKModlTaJZmEJLl5dcsz8QJsd8eQJPVORY0=;
        b=fzbePSB/dk7wXqCJUR+1NXvp+VB/MvF/FXlrgdEfnFbOC3ihzrSp+c1OFnBgs/OksJ
         Axvifd2wxwGigNWAL5zWK+QaQ4GnqjDqKJl3RZKSMrhpRVp2Lz1cCu6wJBBn+ra7GUmY
         emoHOht9ksw+N889pKJkgu5EgdVAwgtxKa1VN1uxP1k0sKmcrA7fkq2kAFASNIO4RKtJ
         enMyZxmKtQlXutKdw7xppb+EyUWRR5gQrkD0IL4/LhXIa87gAnN+vkRbU56KqhghswOI
         NoEZXkBngV58R44cJA0+iUSUtoh1YO19GeI02ryLeHENp0dlwYjZYtXW2QglBRO2UUNv
         edXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6cBllQGcEKModlTaJZmEJLl5dcsz8QJsd8eQJPVORY0=;
        b=P6K0PQP8bCETrQQvdl6cJMIpJ4NjbU8hhqCCFaFZ1Rc2+emcJoUvQsXrXsOKPDOGWh
         wbY/8RO1Hrh8ypdoShW/c+m66Po69mprVhre8EW6st2/KuSP1zMeBS4+np0Lq4FKZEE5
         EZLjVvGsN2HwtU+76VUiZhSWSWaHjwreQHjIyJUQPQD9hDlAwon+axNW6aTCvUH9c/fu
         dcyKOb1AcH3tP4BOzb/FBvjBYSRJ1jNBS6Jv7o0kM2q2DWVxb3pzaj8o3pj0T9EI7Evo
         HM7HgJWHf4BtcUWXNsbbRKXRB9Q/Zhd8OE/Ohe6Ra3YJzfhoUzHG2/uK0f2rI3gMbPef
         3PtQ==
X-Gm-Message-State: APjAAAUEvRud/yeHQ4BRzqgUPkJquRjF7ktl/Hdwj2xABN0ASvlkvLk7
        ZGBsqCBtn7pAT0kSAnFLjLDXlQ==
X-Google-Smtp-Source: APXvYqzWROtX9HQVrZ5RYkXlecRLlgz439t3U8kv6878RomiBAdLqoacGV+xO/M9HlPmbvIV/9nNag==
X-Received: by 2002:a67:7c92:: with SMTP id x140mr44772793vsc.229.1563817803644;
        Mon, 22 Jul 2019 10:50:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y18sm12818683vkb.35.2019.07.22.10.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 10:50:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpcRl-0001fs-Hy; Mon, 22 Jul 2019 14:50:01 -0300
Date:   Mon, 22 Jul 2019 14:50:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-rc] RDMA/hns: Fix sg offset non-zero issue
Message-ID: <20190722175001.GA6365@ziepe.ca>
References: <1562808737-45723-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562808737-45723-1-git-send-email-oulijun@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 11, 2019 at 09:32:17AM +0800, Lijun Ou wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> When run perftest in many times, the system will report a BUG as follows:
> 
> [ 2312.559759] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
> [ 2312.574803] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
> 
> We tested with different kernel version and found it started from the the
> following commit:
> 
> commit d10bcf947a3e ("RDMA/umem: Combine contiguous PAGE_SIZE regions in
> SGEs")
> 
> In this commit, the sg->offset is always 0 when sg_set_page() is called in
> ib_umem_get() and the drivers are not allowed to change the sgl, otherwise
> it will get bad page descriptor when unfolding SGEs in __ib_umem_release()
> as sg_page_count() will get wrong result while sgl->offset is not 0.
> 
> However, there is a weird sgl usage in the current hns driver, the driver
> modified sg->offset after calling ib_umem_get(), which caused we iterate
> past the wrong number of pages in for_each_sg_page iterator.
> 
> This patch fixes it by correcting the non-standard sgl usage found in the
> hns_roce_db_map_user() function.
> 
> Fixes: 0425e3e6e0c7 ("RDMA/hns: Support flush cqe for hip08 in kernel space")
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_db.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

This looks like the right fix to the reported problem
 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_db.c b/drivers/infiniband/hw/hns/hns_roce_db.c
> index 0c6c1fe..d60453e 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_db.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_db.c
> @@ -12,13 +12,15 @@ int hns_roce_db_map_user(struct hns_roce_ucontext *context,
>  			 struct ib_udata *udata, unsigned long virt,
>  			 struct hns_roce_db *db)
>  {
> +	unsigned long page_addr = virt & PAGE_MASK;
>  	struct hns_roce_user_db_page *page;
> +	unsigned int offset;
>  	int ret = 0;
>  
>  	mutex_lock(&context->page_mutex);
>  
>  	list_for_each_entry(page, &context->page_list, list)
> -		if (page->user_virt == (virt & PAGE_MASK))
> +		if (page->user_virt == page_addr)
>  			goto found;
>  
>  	page = kmalloc(sizeof(*page), GFP_KERNEL);
> @@ -28,8 +30,8 @@ int hns_roce_db_map_user(struct hns_roce_ucontext *context,
>  	}
>  
>  	refcount_set(&page->refcount, 1);
> -	page->user_virt = (virt & PAGE_MASK);
> -	page->umem = ib_umem_get(udata, virt & PAGE_MASK, PAGE_SIZE, 0, 0);
> +	page->user_virt = page_addr;
> +	page->umem = ib_umem_get(udata, page_addr, PAGE_SIZE, 0, 0);
>  	if (IS_ERR(page->umem)) {
>  		ret = PTR_ERR(page->umem);
>  		kfree(page);
> @@ -39,10 +41,9 @@ int hns_roce_db_map_user(struct hns_roce_ucontext *context,
>  	list_add(&page->list, &context->page_list);
>  
>  found:
> -	db->dma = sg_dma_address(page->umem->sg_head.sgl) +
> -		  (virt & ~PAGE_MASK);
> -	page->umem->sg_head.sgl->offset = virt & ~PAGE_MASK;
> -	db->virt_addr = sg_virt(page->umem->sg_head.sgl);
> +	offset = virt - page_addr;
> +	db->dma = sg_dma_address(page->umem->sg_head.sgl) + offset;
> +	db->virt_addr = sg_virt(page->umem->sg_head.sgl) + offset;

However the use of sg_virt here is wrong. Please send a patch fixing
it.

You need to store the struct page * in the db and use kmap when you
want to access it.

Better would have been to create a shared kernel/user page via mmap
like the other drivers do.

Jason
