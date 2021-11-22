Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB406458AED
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 09:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhKVJBV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 04:01:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232383AbhKVJBT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Nov 2021 04:01:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C09F56023F;
        Mon, 22 Nov 2021 08:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637571493;
        bh=vJM39Yp9q0rTPDFqBZcwqyP8WSxz+sAOvweUbsFiLg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PFeWhG7F8RB8xyTL/V0OcuJLcU7eQUdy5SLCCzJOS1BjwN3nBesvoeaVWZSZAqVv5
         J61Kcx9Ni10yKhSmJ1YldeXH1Giq7G17he+NHPDT/ygnsZUcI551YQidb077OMTuYU
         lIrOAkpbbfiKLQnUvCg/E8PlpCmTfqrqgYPgjeJRghMDTETB4FHRhlLvpYGATQwk1i
         Y0KXWZBcIxWP3wGhnwze3J5CrzZgGB25McS/Sd+zWgzNv3cWMg7urEWkdmtgr2bQvx
         PMfQyVx4k5Yf9nPE+IxS6mF+A7trAP45UinTwreV0iv+Y0o0YGwOSJHR+26NhtbzbP
         wQXnPzMXgrRcQ==
Date:   Mon, 22 Nov 2021 10:58:09 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v4 for-next 1/1] RDMA/hns: Support direct wqe of userspace
Message-ID: <YZtboTThVCL7xs5s@unreal>
References: <20211122033801.30807-1-liangwenpeng@huawei.com>
 <20211122033801.30807-2-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122033801.30807-2-liangwenpeng@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 22, 2021 at 11:38:01AM +0800, Wenpeng Liang wrote:
> From: Yixing Liu <liuyixing1@huawei.com>
> 
> Add direct wqe enable switch and address mapping.
> 
> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  8 +--
>  drivers/infiniband/hw/hns/hns_roce_main.c   | 38 ++++++++++++---
>  drivers/infiniband/hw/hns/hns_roce_pd.c     |  3 ++
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 54 ++++++++++++++++++++-
>  include/uapi/rdma/hns-abi.h                 |  2 +
>  5 files changed, 94 insertions(+), 11 deletions(-)

<...>

>  	entry = to_hns_mmap(rdma_entry);
>  	pfn = entry->address >> PAGE_SHIFT;
> -	prot = vma->vm_page_prot;
>  
> -	if (entry->mmap_type != HNS_ROCE_MMAP_TYPE_TPTR)
> -		prot = pgprot_noncached(prot);
> +	switch (entry->mmap_type) {
> +	case HNS_ROCE_MMAP_TYPE_DB:
> +		prot = pgprot_noncached(vma->vm_page_prot);
> +		break;
> +	case HNS_ROCE_MMAP_TYPE_TPTR:
> +		prot = vma->vm_page_prot;
> +		break;
> +	case HNS_ROCE_MMAP_TYPE_DWQE:
> +		prot = pgprot_device(vma->vm_page_prot);

Everything fine, except this pgprot_device(). You probably need to check
WC internally in your driver and use or pgprot_writecombine() or
pgprot_noncached() explicitly.

Thanks
