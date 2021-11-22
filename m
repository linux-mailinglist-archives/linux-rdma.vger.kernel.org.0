Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE18F458D0F
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 12:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhKVLNQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 06:13:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhKVLNQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Nov 2021 06:13:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0602560524;
        Mon, 22 Nov 2021 11:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637579409;
        bh=EtY4uAKi7XxUTSqdpH5QJTfffi2zQ1BFCuFDFldxY2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pgLQmtwr4bdugMkDpH216HVGT3TOIbND6q6AytRzXuNxAWeCdEn0XzJGyfz180yFF
         o9glQfGWKcR9CEkeCw8Oq1zpnr/ToM1fmSVj0g8wdeXsnksinFohTqN73SXnT0Uawz
         qkz8OxH6N/yAamD7DZXC4xxw4wh9N+GZ+hOKg2d8Ez+HkPJSzqZyRVjyKE75ZG9Ydb
         wbngr3QsOvv0j+t+OP33oAutHiAcdgiw1E+qokXw+8/tMEx7qlwlfHmK1LMjW9zju9
         76G0yG1u8eednka3DlKmmvfh6N0+nL0AR4Ien2LsggoJvbw99NuKrnBRKDJuXUZYZk
         WJYTRX2iHFAuQ==
Date:   Mon, 22 Nov 2021 13:10:05 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v4 for-next 1/1] RDMA/hns: Support direct wqe of userspace
Message-ID: <YZt6jQDzNLw7Zn1r@unreal>
References: <20211122033801.30807-1-liangwenpeng@huawei.com>
 <20211122033801.30807-2-liangwenpeng@huawei.com>
 <YZtboTThVCL7xs5s@unreal>
 <10bbb3f3-600c-1db7-4859-47bd6850969f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10bbb3f3-600c-1db7-4859-47bd6850969f@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 22, 2021 at 05:28:31PM +0800, Wenpeng Liang wrote:
> 
> 
> On 2021/11/22 16:58, Leon Romanovsky wrote:
> >>  	entry = to_hns_mmap(rdma_entry);
> >>  	pfn = entry->address >> PAGE_SHIFT;
> >> -	prot = vma->vm_page_prot;
> >>  
> >> -	if (entry->mmap_type != HNS_ROCE_MMAP_TYPE_TPTR)
> >> -		prot = pgprot_noncached(prot);
> >> +	switch (entry->mmap_type) {
> >> +	case HNS_ROCE_MMAP_TYPE_DB:
> >> +		prot = pgprot_noncached(vma->vm_page_prot);
> >> +		break;
> >> +	case HNS_ROCE_MMAP_TYPE_TPTR:
> >> +		prot = vma->vm_page_prot;
> >> +		break;
> >> +	case HNS_ROCE_MMAP_TYPE_DWQE:
> >> +		prot = pgprot_device(vma->vm_page_prot);
> > Everything fine, except this pgprot_device(). You probably need to check
> > WC internally in your driver and use or pgprot_writecombine() or
> > pgprot_noncached() explicitly.
> > 
> > Thanks
> > .
> > 
> 
> This issue is also discussed in the v2 version, direct wqe uses
> this prot on HIP09 can achieve better performance than NC.
> 
> v2 link: https://patchwork.kernel.org/project/linux-rdma/patch/1622705834-19353-3-git-send-email-liweihang@huawei.com/

But isn't it specific to ARM model that behaves such? Will it be the case
when you move to upgrade your ARM core?

Thanks

> 
> Thanks
> Wenpeng
