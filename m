Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4665438B04
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Oct 2021 19:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhJXRdK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Oct 2021 13:33:10 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:56806 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbhJXRdJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Oct 2021 13:33:09 -0400
Received: from [192.168.1.18] ([92.140.161.106])
        by smtp.orange.fr with ESMTPA
        id ehKYmagBidmYbehKYmLaLH; Sun, 24 Oct 2021 19:30:47 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 24 Oct 2021 19:30:47 +0200
X-ME-IP: 92.140.161.106
Subject: Re: [PATCH 2/2] RDMA/rxe: Use 'bitmap_zalloc()' when applicable
To:     zyjzyj2000@gmail.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <2c42065049bb2b99bededdc423a9babf4a98adee.1635093628.git.christophe.jaillet@wanadoo.fr>
 <4a3e11d45865678d570333d1962820eb13168848.1635093628.git.christophe.jaillet@wanadoo.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <32a3bd0e-7dd1-26fe-eedd-f6b8e673324d@wanadoo.fr>
Date:   Sun, 24 Oct 2021 19:30:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4a3e11d45865678d570333d1962820eb13168848.1635093628.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Le 24/10/2021 à 18:43, Christophe JAILLET a écrit :
> 'index.table' is a bitmap. So use 'bitmap_zalloc()' to simplify code,
> improve the semantic and avoid some open-coded arithmetic in allocator
> arguments.
> 
> Using 'bitmap_zalloc()' also allows the removal of a now useless
> 'bitmap_zero()'.
> 
> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> consistency.
> 
> Finally, while at it, axe the useless 'bitmap' variable and use
> 'mem->bitmap' directly.

This last sentence should not be there (cut'n'paste error)
It should be removed when the patch is applied, or I can resend if needed.

CJ

> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/infiniband/sw/rxe/rxe_pool.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 271d4ac0e0aa..ed2427369c2c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -96,7 +96,6 @@ static inline const char *pool_name(struct rxe_pool *pool)
>   static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
>   {
>   	int err = 0;
> -	size_t size;
>   
>   	if ((max - min + 1) < pool->max_elem) {
>   		pr_warn("not enough indices for max_elem\n");
> @@ -107,15 +106,12 @@ static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
>   	pool->index.max_index = max;
>   	pool->index.min_index = min;
>   
> -	size = BITS_TO_LONGS(max - min + 1) * sizeof(long);
> -	pool->index.table = kmalloc(size, GFP_KERNEL);
> +	pool->index.table = bitmap_zalloc(max - min + 1, GFP_KERNEL);
>   	if (!pool->index.table) {
>   		err = -ENOMEM;
>   		goto out;
>   	}
>   
> -	bitmap_zero(pool->index.table, max - min + 1);
> -
>   out:
>   	return err;
>   }
> @@ -167,7 +163,7 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
>   		pr_warn("%s pool destroyed with unfree'd elem\n",
>   			pool_name(pool));
>   
> -	kfree(pool->index.table);
> +	bitmap_free(pool->index.table);
>   }
>   
>   static u32 alloc_index(struct rxe_pool *pool)
> 

