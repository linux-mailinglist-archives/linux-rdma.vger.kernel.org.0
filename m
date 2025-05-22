Return-Path: <linux-rdma+bounces-10520-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEEBAC072D
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 10:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47EE49E6266
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 08:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD932620C1;
	Thu, 22 May 2025 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orGVwneq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C6714C5B0;
	Thu, 22 May 2025 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747902783; cv=none; b=O/y4jvOmbR90AxfJJmdNBJc1ISh+BiW2//Wjtf6Ew6yIC9QD2i9sUEeJ/5YJAr/OE8ZvhPzRdbNcf4ui9yhH/YHNCMTHvs6L7XjkcZJixoaGEzKOHUptpcgIDp9nj3Dh+R5mgh+cb6G1EXkQlj3sp+Xbv3xDAwJjdk1trThbeUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747902783; c=relaxed/simple;
	bh=mXbhWyS1mjT2KItIhUBn53eeSB+wWL+KJl+0kC+EQis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/LcYwvQEk0X8vUQwQb8SFlTEGVRcXC6m+lTPKkxxNourVC3Wsj7blSFigHAj9LpWRmM0L6DfExuPxfHob9YQ9zbHY10LGWly9FbWfRGNYUjA8WFxQNq8zNFI9koPCRe6LtlEcL9OF/fkkleGr2PlVu48wMEll4NyD0mlf7/TSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orGVwneq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5FBC4CEE4;
	Thu, 22 May 2025 08:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747902783;
	bh=mXbhWyS1mjT2KItIhUBn53eeSB+wWL+KJl+0kC+EQis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=orGVwneqxYABDC4dNPfoyduP8fccw37UQufgyBMtmkvpQZTw13fO0eX36SRhAdcCO
	 VI6B6Dh/Hb8AjiSdNQ/hhZid5/ptd1wJa7agxATub80sjWrvGwzJCuNYnZsVN3rikC
	 C8tVpHk1i9l0Mhagkg2KG9X5n9adbhX3ZPsOIkAHBi32pdy+/VQidWFLy3TozONvgz
	 tBmrP/+Z77Uq5StmYY29AQ4dT2bjj29pZYfNpeuwIUplScjbljojtcF6lahHIyXWV6
	 rnbUm8zFfgMfTR1AD/Uc3W/PcUCQFMKE6rR4Picm3ufKAMFZo1ZfEEmsGuYc9ZdbH3
	 iRTG8s2OQSOsQ==
Date: Thu, 22 May 2025 11:32:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Daisuke Matsuda <dskmtsd@gmail.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Subject: Re: [bug report] [rdma] RXE ODP test hangs with new DMA map API
Message-ID: <20250522083257.GM7435@unreal>
References: <3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com>

On Wed, May 21, 2025 at 09:48:27PM +0900, Daisuke Matsuda wrote:
> Hi,
> 
> After these two patches are merged to the for-next tree, RXE ODP test always hangs:
>   RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page linkage
>   RDMA/umem: Store ODP access mask information in PFN
> cf. https://lore.kernel.org/linux-rdma/cover.1745831017.git.leon@kernel.org/
> 
> Here is the console log:
> ```
> $ ./build/bin/run_tests.py -v -k odp
> test_odp_dc_traffic (tests.test_mlx5_dc.DCTest.test_odp_dc_traffic) ... skipped 'Can not run the test over non MLX5 device'
> test_devx_rc_qp_odp_traffic (tests.test_mlx5_devx.Mlx5DevxRcTrafficTest.test_devx_rc_qp_odp_traffic) ... skipped 'Can not run the test over non MLX5 device'
> test_odp_mkey_list_new_api (tests.test_mlx5_mkey.Mlx5MkeyTest.test_odp_mkey_list_new_api)
> Create Mkeys above ODP MR, configure it with memory layout using the new API and ... skipped 'Could not open mlx5 context (This is not an MLX5 device)'
> test_odp_async_prefetch_rc_traffic (tests.test_odp.OdpTestCase.test_odp_async_prefetch_rc_traffic) ...
> 
> 
> ```
> 
> It looks that the python process is somehow stuck in uverbs_destroy_ufile_hw():
> ```
> $ sudo cat /proc/1845/task/1845/stack
> [<0>] uverbs_destroy_ufile_hw+0x24/0x100 [ib_uverbs]
> [<0>] ib_uverbs_close+0x1b/0xc0 [ib_uverbs]
> [<0>] __fput+0xea/0x2d0
> [<0>] ____fput+0x15/0x20
> [<0>] task_work_run+0x5d/0xa0
> [<0>] do_exit+0x316/0xa50
> [<0>] make_task_dead+0x81/0x160
> [<0>] rewind_stack_and_make_dead+0x16/0x20
> ```
> 
> I am not sure about the root cause but hope we can fix this before the next merge window.

Can you please try this fix?

diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index a1416626f61a5..0f67167ddddd1 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -137,7 +137,7 @@ static inline bool rxe_check_pagefault(struct ib_umem_odp *umem_odp,
        while (addr < iova + length) {
                idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
 
-               if (!(umem_odp->map.pfn_list[idx] & perm)) {
+               if (!(umem_odp->map.pfn_list[idx] & HMM_PFN_VALID)) {
                        need_fault = true;
                        break;
               

> 
> Thanks,
> Daisuke

