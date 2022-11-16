Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D753162AFE5
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 01:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiKPALF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 19:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiKPALB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 19:11:01 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6292A716;
        Tue, 15 Nov 2022 16:10:59 -0800 (PST)
Message-ID: <c1fa0a0c-d8f3-f6c4-7964-3bb31ac936ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668557458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JvPn6Ns2hZ82F1x4tzt3EH9pCuqXBb8Xskbp9KbDexI=;
        b=CkKtpHcBA8Jp61hlsJmIuHBy5U08VG7cJU2r189KoSbfvo0I4GAWAZpjhAiGwkdYNL6+js
        +FUfihWSm8/iUZnhAUzvNcn9nY/MmuQILi/p7vuExm2z+JpGNBViaMKpoJhJgRNvRqfEQX
        zirpltS9GTN69xs30ZaHxDdLNHy9Ec4=
Date:   Wed, 16 Nov 2022 08:10:52 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix mr->map double free
To:     Li Zhijian <lizhijian@fujitsu.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>, linux-kernel@vger.kernel.org
References: <1667099073-2-1-git-send-email-lizhijian@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <1667099073-2-1-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/10/30 11:04, Li Zhijian 写道:
> rxe_mr_cleanup() which tries to free mr->map again will be called
> when rxe_mr_init_user() fails.
> 
> [43895.939883] CPU: 0 PID: 4917 Comm: rdma_flush_serv Kdump: loaded Not tainted 6.1.0-rc1-roce-flush+ #25
> [43895.942341] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [43895.945208] Call Trace:
> [43895.946130]  <TASK>
> [43895.946931]  dump_stack_lvl+0x45/0x5d
> [43895.948049]  panic+0x19e/0x349
> [43895.949010]  ? panic_print_sys_info.part.0+0x77/0x77
> [43895.950356]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> [43895.952589]  ? preempt_count_sub+0x14/0xc0
> [43895.953809]  end_report.part.0+0x54/0x7c
> [43895.954993]  ? rxe_mr_cleanup+0x9d/0xf0 [rdma_rxe]
> [43895.956406]  kasan_report.cold+0xa/0xf
> [43895.957668]  ? rxe_mr_cleanup+0x9d/0xf0 [rdma_rxe]
> [43895.959090]  rxe_mr_cleanup+0x9d/0xf0 [rdma_rxe]
> [43895.960502]  __rxe_cleanup+0x10a/0x1e0 [rdma_rxe]
> [43895.961983]  rxe_reg_user_mr+0xb7/0xd0 [rdma_rxe]
> [43895.963456]  ib_uverbs_reg_mr+0x26a/0x480 [ib_uverbs]
> [43895.964921]  ? __lock_acquire+0x876/0x31e0
> [43895.966182]  ? ib_uverbs_ex_create_wq+0x630/0x630 [ib_uverbs]
> [43895.967739]  ? uverbs_fill_udata+0x1c6/0x330 [ib_uverbs]
> [43895.969204]  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x1a2/0x250 [ib_uverbs]
> [43895.971126]  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0x1a0/0x1a0 [ib_uverbs]
> [43895.973094]  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0x1a0/0x1a0 [ib_uverbs]
> [43895.975096]  ? uverbs_fill_udata+0x25f/0x330 [ib_uverbs]
> [43895.976466]  ib_uverbs_cmd_verbs+0x1397/0x15a0 [ib_uverbs]
> [43895.977930]  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0x1a0/0x1a0 [ib_uverbs]
> [43895.979937]  ? uverbs_fill_udata+0x330/0x330 [ib_uverbs]
> 
> This issue was fistrly exposed since
> commit: b18c7da63fcb ("RDMA/rxe: Fix memory leak in error path code")
> and then we fixed it in
> commit: 8ff5f5d9d8cf ("RDMA/rxe: Prevent double freeing rxe_map_set()")
> but this fix was reverted together at last by
> commit: 1e75550648da (Revert "RDMA/rxe: Create duplicate mapping tables for FMRs")
> 
> Fixes: 1e75550648da (Revert "RDMA/rxe: Create duplicate mapping tables for FMRs")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_mr.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index d4f10c2d1aa7..7c99d1591580 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -99,6 +99,7 @@ static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
>   		kfree(mr->map[i]);
>   
>   	kfree(mr->map);
> +	mr->map = NULL;
>   err1:
>   	return -ENOMEM;
>   }
> @@ -122,7 +123,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>   	int			num_buf;
>   	void			*vaddr;
>   	int err;
> -	int i;
>   
>   	umem = ib_umem_get(&rxe->ib_dev, start, length, access);
>   	if (IS_ERR(umem)) {
> @@ -163,9 +163,8 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>   				pr_warn("%s: Unable to get virtual address\n",
>   						__func__);
>   				err = -ENOMEM;
> -				goto err_cleanup_map;
> +				goto err_release_umem;

This call trace results from page_address's returning NULL, then goto 
err_cleanup_map where mr->map[i] and mr->map are freed.

And finally rxe_reg_user_mr gets an error from rxe_mr_init_user, the 
function rxe_mr_cleanup is called to handle mr to free mr->map[i] and 
mr->map again.

So mr->map[i] and mr->map are double freed.

As such, this commit is reasonable.

But why page_address will return NULL?

Zhu Yanjun

>   			}
> -
>   			buf->addr = (uintptr_t)vaddr;
>   			buf->size = PAGE_SIZE;
>   			num_buf++;
> @@ -182,10 +181,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>   
>   	return 0;
>   
> -err_cleanup_map:
> -	for (i = 0; i < mr->num_map; i++)
> -		kfree(mr->map[i]);
> -	kfree(mr->map);
>   err_release_umem:
>   	ib_umem_release(umem);
>   err_out:

