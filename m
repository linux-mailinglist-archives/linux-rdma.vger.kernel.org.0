Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A42012691C
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2019 19:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfLSSck (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Dec 2019 13:32:40 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45808 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfLSScj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Dec 2019 13:32:39 -0500
Received: by mail-qv1-f66.google.com with SMTP id l14so2593913qvu.12
        for <linux-rdma@vger.kernel.org>; Thu, 19 Dec 2019 10:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KxcAK175SXL4s98mUKxTuuJ7ApUPNEwbeHFqCNm/gdI=;
        b=c0z6n6wI2C7woz0UNzkhmPm0PQzVoP6JePPgWqUEQJp/GYy6Pr7Qt3gLsT1KXppodC
         2Q90ACexm58xXPm6CEdV4ZoxOxDlTl7Ybn/8wQ/8KkcPIil4E6OyGjIz56nkIsn+U6YI
         SXn8Ksce1W3RHcxY3HxAOMiYsqqAShluqVumGtJVLPDS3itUVXN4jpGUfCuwcTfJFXKU
         3LAEqaS2YHQmVaa/bGtia6dJVXhEqHD8yucH3TCrYpxmq3KtF0F8jlUEQYSCKV8jMhmf
         +B3YzHJqjuy/abeb1Fi+mZz3fdl5cciXDftUMHUOgWbKuiyO4ZN1ioXA4Ikjt1ZR4FYH
         N6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KxcAK175SXL4s98mUKxTuuJ7ApUPNEwbeHFqCNm/gdI=;
        b=YaI3GhizjetM2wkLD/PnnnWr+TfbbFdwK2A0x7pqIAcZL3ERzspa182ZKe4ZmWfbq3
         RqYoLYQBR5/jKTvWcZs3LxdbLuLDg5aymsTOfhNlVUGi1l3VdOZBAE8A1S8wTF3n44sW
         FbK4YQrhO87CKfw/Y4Gh3G/8pq+qx/RAscSWmtzTwsG7cUI/Heogggeuepz6zcvNUyTu
         y6aWLXO+Osp+SXADVaLbVxTjzwzVgU+pMKOSJ8isofai8LkRrjWAwS0I8VZRBSF13Y8n
         DWDOUB2Oqzijgb3/MMweKRcNV3J5qwouRIewo1QZTMXMTU2Wl2i6jgnfBn8Gfk4JFC90
         0xyg==
X-Gm-Message-State: APjAAAW5I5ScE/gGusnTVAaNBKiY370JKKeETg3yJ06MBTw3vo8t7Rrp
        IgnjJ6NxsoQqYMxyBEH4CwLaYg==
X-Google-Smtp-Source: APXvYqwq0vZcEKpwsnjKVJ+KNGjmOXo8T/Hj3JN0Hf2BVg5OetervvdcnHhSZLCFy3X8/01pKuL9TA==
X-Received: by 2002:a0c:8a93:: with SMTP id 19mr9084450qvv.157.1576780358913;
        Thu, 19 Dec 2019 10:32:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id s27sm1922474qkm.97.2019.12.19.10.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 10:32:38 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ii0bF-0007fP-W7; Thu, 19 Dec 2019 14:32:38 -0400
Date:   Thu, 19 Dec 2019 14:32:37 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc 3/3] IB/core: Fix ODP with IB_ACCESS_HUGETLB
 handling
Message-ID: <20191219183237.GJ17227@ziepe.ca>
References: <20191219134646.413164-1-leon@kernel.org>
 <20191219134646.413164-4-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219134646.413164-4-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 19, 2019 at 03:46:46PM +0200, Leon Romanovsky wrote:

> @@ -403,6 +390,7 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
>  	int j, k, ret = 0, start_idx, npages = 0;
>  	unsigned int flags = 0, page_shift;
>  	phys_addr_t p = 0;
> +	struct vm_area_struct **vmas;
>  
>  	if (access_mask == 0)
>  		return -EINVAL;
> @@ -415,6 +403,12 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
>  	if (!local_page_list)
>  		return -ENOMEM;
>  
> +	vmas = (struct vm_area_struct **)__get_free_page(GFP_KERNEL);
> +	if (!vmas) {
> +		ret = -ENOMEM;
> +		goto out_free_page_list;
> +	}

I'd rather not do this on the fast path

> +			if ((1 << page_shift) > vma_kernel_pagesize(vmas[j])) {
> +				ret = -EFAULT;
> +				break;
> +			}

And vma's cannot be de-refenced outside the mmap_sem

There is already logic checking for linear contiguous pages:

                        if (user_virt & ~page_mask) {
                                p += PAGE_SIZE;
                                if (page_to_phys(local_page_list[j]) != p) {
                                        ret = -EFAULT;
                                        break;
                                }

Why do we need to add the vma check?

Jason
