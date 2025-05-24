Return-Path: <linux-rdma+bounces-10664-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA874AC2FDB
	for <lists+linux-rdma@lfdr.de>; Sat, 24 May 2025 15:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC369E480E
	for <lists+linux-rdma@lfdr.de>; Sat, 24 May 2025 13:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA751E47A3;
	Sat, 24 May 2025 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hc7Bewia"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6127261A;
	Sat, 24 May 2025 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748092800; cv=none; b=H4J+o7oWbLvZtsZ9bVXLH2R83jQPDGPA4Ql8mf2xXfggWjAG3xKFOi/3r6jcwncWzWZ35gXgEMDykIrwNt7Spq9J0YK/vDbS76T3tek3pcU6yw5F+NykPYKRZDgGpyuTgAjLLY7g63Crkw33Ux1bpji9JIWq7cD/ZmkslOiwoUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748092800; c=relaxed/simple;
	bh=M0/xS0AFYmtov4bwJ8ApqaeiOVA7jV54N54Wgf8jJTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoOv7RWIZn5jd+3+yJ2mRoAzoe67eVnrc3S34U2dh/yfOiQatEaVbMa6cLGYwa3Pub0klTvA+dJfkObBxcyXdS0lCH+O/jj1YQTl0qV/mBNMQPEfaKVv9di/eg6clpCifRjZEGom+oTrxfN82eIKArkDp8n+tnxQnxHoMvXV+lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hc7Bewia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCF7C4CEE4;
	Sat, 24 May 2025 13:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748092799;
	bh=M0/xS0AFYmtov4bwJ8ApqaeiOVA7jV54N54Wgf8jJTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hc7Bewia+fk+4P20IMXK40vB2eY6bRtqz5YOsGlaNFcGQtZcED23DvvB+so5JX4xQ
	 6xWFojMxcbfx0Ltaf/CX0g36z1xCesLFnp4JPL8tZfLGQ8ju8pFEnZ8Ql0fgDTCXkO
	 WWVdWfbot21w749b+qKZQBEwOv+ozX8Lagr4RwHciuYBKwN/qV/B2bCMRU0XnuwZo8
	 87I/3zjXUC7Iosd2/riZc0VNX2yUhiMQJzGx+RzzP0RJsxtKQfsk5UFHn1Z5mcEVCE
	 TnaOHKMKBNOWWJi0kc7vi8huURjvMSWd0kdjyri2xpdHG5FMz3kq2sZK6Y+dgkJxax
	 MQvyDMBGHXgBA==
Date: Sat, 24 May 2025 16:19:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Daisuke Matsuda <dskmtsd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, jgg@ziepe.ca,
	zyjzyj2000@gmail.com, hch@infradead.org
Subject: Re: [PATCH for-next v1] RDMA/core: Avoid hmm_dma_map_alloc() for
 virtual DMA devices
Message-ID: <20250524131955.GU7435@unreal>
References: <20250523184701.11004-1-dskmtsd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523184701.11004-1-dskmtsd@gmail.com>

On Fri, May 23, 2025 at 06:47:01PM +0000, Daisuke Matsuda wrote:
> Drivers such as rxe, which use virtual DMA, must not call into the DMA
> mapping core since they lack physical DMA capabilities. Otherwise, a NULL
> pointer dereference is observed as shown below. This patch ensures the RDMA
> core handles virtual and physical DMA paths appropriately.
> 
> This fixes the following kernel oops:
> 
>  BUG: kernel NULL pointer dereference, address: 00000000000002fc
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 1028eb067 P4D 1028eb067 PUD 105da0067 PMD 0
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  CPU: 3 UID: 1000 PID: 1854 Comm: python3 Tainted: G        W           6.15.0-rc1+ #11 PREEMPT(voluntary)
>  Tainted: [W]=WARN
>  Hardware name: Trigkey Key N/Key N, BIOS KEYN101 09/02/2024
>  RIP: 0010:hmm_dma_map_alloc+0x25/0x100
>  Code: 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 49 89 d6 49 c1 e6 0c 41 55 41 54 53 49 39 ce 0f 82 c6 00 00 00 49 89 fc <f6> 87 fc 02 00 00 20 0f 84 af 00 00 00 49 89 f5 48 89 d3 49 89 cf
>  RSP: 0018:ffffd3d3420eb830 EFLAGS: 00010246
>  RAX: 0000000000001000 RBX: ffff8b727c7f7400 RCX: 0000000000001000
>  RDX: 0000000000000001 RSI: ffff8b727c7f74b0 RDI: 0000000000000000
>  RBP: ffffd3d3420eb858 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>  R13: 00007262a622a000 R14: 0000000000001000 R15: ffff8b727c7f74b0
>  FS:  00007262a62a1080(0000) GS:ffff8b762ac3e000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00000000000002fc CR3: 000000010a1f0004 CR4: 0000000000f72ef0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ib_init_umem_odp+0xb6/0x110 [ib_uverbs]
>   ib_umem_odp_get+0xf0/0x150 [ib_uverbs]
>   rxe_odp_mr_init_user+0x71/0x170 [rdma_rxe]
>   rxe_reg_user_mr+0x217/0x2e0 [rdma_rxe]
>   ib_uverbs_reg_mr+0x19e/0x2e0 [ib_uverbs]
>   ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xd9/0x150 [ib_uverbs]
>   ib_uverbs_cmd_verbs+0xd19/0xee0 [ib_uverbs]
>   ? mmap_region+0x63/0xd0
>   ? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uverbs]
>   ib_uverbs_ioctl+0xba/0x130 [ib_uverbs]
>   __x64_sys_ioctl+0xa4/0xe0
>   x64_sys_call+0x1178/0x2660
>   do_syscall_64+0x7e/0x170
>   ? syscall_exit_to_user_mode+0x4e/0x250
>   ? do_syscall_64+0x8a/0x170
>   ? do_syscall_64+0x8a/0x170
>   ? syscall_exit_to_user_mode+0x4e/0x250
>   ? do_syscall_64+0x8a/0x170
>   ? syscall_exit_to_user_mode+0x4e/0x250
>   ? do_syscall_64+0x8a/0x170
>   ? do_user_addr_fault+0x1d2/0x8d0
>   ? irqentry_exit_to_user_mode+0x43/0x250
>   ? irqentry_exit+0x43/0x50
>   ? exc_page_fault+0x93/0x1d0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  RIP: 0033:0x7262a6124ded
>  Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
>  RSP: 002b:00007fffd08c3960 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>  RAX: ffffffffffffffda RBX: 00007fffd08c39f0 RCX: 00007262a6124ded
>  RDX: 00007fffd08c3a10 RSI: 00000000c0181b01 RDI: 0000000000000007
>  RBP: 00007fffd08c39b0 R08: 0000000014107820 R09: 00007fffd08c3b44
>  R10: 000000000000000c R11: 0000000000000246 R12: 00007fffd08c3b44
>  R13: 000000000000000c R14: 00007fffd08c3b58 R15: 0000000014107960
>   </TASK>
> 
> Fixes: 1efe8c0670d6 ("RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page linkage")
> Closes: https://lore.kernel.org/all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com/
> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
> ---
>  drivers/infiniband/core/device.c   | 24 ++++++++++++++++++++++++
>  drivers/infiniband/core/umem_odp.c |  6 +++---
>  include/rdma/ib_verbs.h            | 12 ++++++++++++
>  3 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index b4e3e4beb7f4..8be4797c66ec 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2864,6 +2864,30 @@ int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
>  	return nents;
>  }
>  EXPORT_SYMBOL(ib_dma_virt_map_sg);
> +int ib_dma_virt_map_alloc(struct device *dev, struct hmm_dma_map *map,
> +			  size_t nr_entries, size_t dma_entry_size)
> +{
> +	if (!(nr_entries * PAGE_SIZE / dma_entry_size))
> +		return -EINVAL;
> +
> +	map->dma_entry_size = dma_entry_size;
> +	map->pfn_list = kvcalloc(nr_entries, sizeof(*map->pfn_list),
> +				 GFP_KERNEL | __GFP_NOWARN);
> +	if (!map->pfn_list)
> +		return -ENOMEM;

pfn_list is enough, virtual devices doesn't go through path which needs
dma_list. They use simple CPU address to DMA address translation.

> +
> +	map->dma_list = kvcalloc(nr_entries, sizeof(*map->dma_list),
> +				 GFP_KERNEL | __GFP_NOWARN);
> +	if (!map->dma_list)
> +		goto err_dma;
> +
> +	return 0;
> +
> +err_dma:
> +	kvfree(map->pfn_list);
> +	return -ENOMEM;
> +}
> +EXPORT_SYMBOL(ib_dma_virt_map_alloc);
>  #endif /* CONFIG_INFINIBAND_VIRT_DMA */
>  
>  static const struct rdma_nl_cbs ibnl_ls_cb_table[RDMA_NL_LS_NUM_OPS] = {
> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> index 51d518989914..aa03f3fc84d0 100644
> --- a/drivers/infiniband/core/umem_odp.c
> +++ b/drivers/infiniband/core/umem_odp.c
> @@ -75,9 +75,9 @@ static int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
>  	if (unlikely(end < page_size))
>  		return -EOVERFLOW;
>  
> -	ret = hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,
> -				(end - start) >> PAGE_SHIFT,
> -				1 << umem_odp->page_shift);
> +	ret = ib_dma_map_alloc(dev, &umem_odp->map,
> +			       (end - start) >> PAGE_SHIFT,
> +			       1 << umem_odp->page_shift);

There is no need in extra function, implement if(ib_uses_virt_dma...) here.

Thanks

