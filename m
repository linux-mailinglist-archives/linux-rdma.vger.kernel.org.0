Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 072EB1342A5
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 13:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgAHM5E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 07:57:04 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:39520 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgAHM5E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 07:57:04 -0500
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id nowz2100E5USYZQ01owzo3; Wed, 08 Jan 2020 13:57:01 +0100
Received: from geert (helo=localhost)
        by ramsan with local-esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ipAtP-0006Id-27; Wed, 08 Jan 2020 13:56:59 +0100
Date:   Wed, 8 Jan 2020 13:56:58 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Leon Romanovsky <leon@kernel.org>
cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH rdma-rc 3/3] IB/core: Fix ODP with IB_ACCESS_HUGETLB
 handling
In-Reply-To: <20191219134646.413164-4-leon@kernel.org>
Message-ID: <alpine.DEB.2.21.2001081352560.23971@ramsan.of.borg>
References: <20191219134646.413164-1-leon@kernel.org> <20191219134646.413164-4-leon@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

 	Hi Leon,

On Thu, 19 Dec 2019, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@mellanox.com>
>
> As VMAs for a given range might not be available as part of the
> registration phase in ODP, IB_ACCESS_HUGETLB/page_shift must be checked
> as part of the page fault flow.
>
> If the application didn't mmap the backed memory with huge pages or
> released part of that hugepage area, an error will be set as part of the
> page fault flow once be detected.
>
> Fixes: 0008b84ea9af ("IB/umem: Add support to huge ODP")
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
> Reviewed-by: Aviad Yehezkel <aviadye@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

Thanks for your patch!

> --- a/drivers/infiniband/core/umem_odp.c
> +++ b/drivers/infiniband/core/umem_odp.c
> @@ -241,22 +241,10 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_udata *udata, unsigned long addr,
> 	umem_odp->umem.owning_mm = mm = current->mm;
> 	umem_odp->notifier.ops = ops;
>
> -	umem_odp->page_shift = PAGE_SHIFT;
> -	if (access & IB_ACCESS_HUGETLB) {
> -		struct vm_area_struct *vma;
> -		struct hstate *h;
> -
> -		down_read(&mm->mmap_sem);
> -		vma = find_vma(mm, ib_umem_start(umem_odp));
> -		if (!vma || !is_vm_hugetlb_page(vma)) {
> -			up_read(&mm->mmap_sem);
> -			ret = -EINVAL;
> -			goto err_free;
> -		}
> -		h = hstate_vma(vma);
> -		umem_odp->page_shift = huge_page_shift(h);
> -		up_read(&mm->mmap_sem);
> -	}
> +	if (access & IB_ACCESS_HUGETLB)
> +		umem_odp->page_shift = HPAGE_SHIFT;
> +	else
> +		umem_odp->page_shift = PAGE_SHIFT;
>
> 	umem_odp->tgid = get_task_pid(current->group_leader, PIDTYPE_PID);
> 	ret = ib_init_umem_odp(umem_odp, ops);

noreply@ellerman.id.au reports for linux-next/m68k-allmodconfig/m68k:

     drivers/infiniband/core/umem_odp.c:245:26: error: 'HPAGE_SHIFT' undeclared (first use in this function); did you mean 'PAGE_SHIFT'?

Should this depend on some HUGETLBFS option?

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
