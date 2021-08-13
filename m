Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A589A3EBCE3
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Aug 2021 21:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhHMT6A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Aug 2021 15:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhHMT57 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Aug 2021 15:57:59 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A533C061756
        for <linux-rdma@vger.kernel.org>; Fri, 13 Aug 2021 12:57:32 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id r5so17534597oiw.7
        for <linux-rdma@vger.kernel.org>; Fri, 13 Aug 2021 12:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mbgUZ+Z6Y///A0q/kKjZB1lZrHxnpDT836P5OsBe+0k=;
        b=K9QmmgP2JOjZBhfqYojOi2wS0tTl1UlQzG3BMcYR6LHPITHIMsCp+3ISk5xZ+0Jukz
         WXcXdqhlFhLoETb9C789mgjuAKFc7NY/Jj5rUvi6lc4jEZCHkfokbA4jGwQIpuIbLPka
         PP11Az8PTUA+fgVW5zMF7jea4iORZfxBtQwjkGpN5rz0yst0bl25QDye2U/RM5+x/Oq+
         /3Uq6YQ19gwoKRf0bGHse7gUzkCSKyxsQtEo43qPrudBdZVBmHSJKlG5ZCOdhBCVbDhj
         nhDY9uh0CBtUn4Uxlff6q+5xnQZct4FqWZTnXV+c/vMPlMldAotn2qa6zCm+Ua5joito
         rQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mbgUZ+Z6Y///A0q/kKjZB1lZrHxnpDT836P5OsBe+0k=;
        b=j7qinXRnziBeXX8Zxp5Hgn1xPbQ7ilk3545dp6IVhxSDFtbFZI00f99N+jTRjrHs+X
         aWjpeWkKZ2KVJFfWcbpnanrpf+2RT5JL5zRF08lxD9WM5AoLddN+nRe6LbxbQbnqToph
         n4ki/i1o0Kz+wT845l5pgRYCko32X5A+Gek9G2udevBSM17ES/CHp3o2Yu2owzckexB6
         k3/Fod8RrecixEeLiNIEeqDYmMhvE/8oJ9a4u4ffv8WOVoT/4vIcPzeZXEkuJtmgkvVZ
         gkBq3/XGDfZLYI/Xbb9wjyA1RgvaztdsxRcYP/ws6oUdWL76zhAzzqaMFaSDNOBw9nfP
         VF0w==
X-Gm-Message-State: AOAM530ClxJsFYUUFALd/jLqYc2C+LS7Apv+MNHJPqeEvAXe702m26Ge
        gsK7BYg3jvtzn6JiSyKtoz2gO1YYjWI=
X-Google-Smtp-Source: ABdhPJx5c9PDflkhcjQneuHzzdj6qKpwUVL/IYryEWLa4GOasVcN5qXdFVyHr85D7MPQuuS505AGuQ==
X-Received: by 2002:aca:4587:: with SMTP id s129mr3400686oia.64.1628884650910;
        Fri, 13 Aug 2021 12:57:30 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:5f86:1d06:aef7:df6b? (2603-8081-140c-1a00-5f86-1d06-aef7-df6b.res6.spectrum.com. [2603:8081:140c:1a00:5f86:1d06:aef7:df6b])
        by smtp.gmail.com with ESMTPSA id u18sm448183ooi.40.2021.08.13.12.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 12:57:30 -0700 (PDT)
Subject: Re: [bug report] RDMA/rxe: Remove RXE_POOL_ATOMIC
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-rdma@vger.kernel.org
References: <20210811085441.GA20866@kili>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <d01036e9-da12-5d19-0c07-73b6fd8e8c79@gmail.com>
Date:   Fri, 13 Aug 2021 14:57:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811085441.GA20866@kili>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/11/21 3:54 AM, Dan Carpenter wrote:
> Hello Bob Pearson,
> 
> The patch 4276fd0dddc9: "RDMA/rxe: Remove RXE_POOL_ATOMIC" from Jan
> 25, 2021, leads to the following
> Smatch static checker warning:
> 
> 	drivers/infiniband/sw/rxe/rxe_pool.c:362 rxe_alloc()
> 	warn: sleeping in atomic context
> 
> drivers/infiniband/sw/rxe/rxe_pool.c
>     353 void *rxe_alloc(struct rxe_pool *pool)
>     354 {
>     355 	struct rxe_type_info *info = &rxe_type_info[pool->type];
>     356 	struct rxe_pool_entry *elem;
>     357 	u8 *obj;
>     358 
>     359 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
>     360 		goto out_cnt;
>     361 
> --> 362 	obj = kzalloc(info->size, GFP_KERNEL);
>                                           ^^^^^^^^^^
> It's possible the patch just exposed a bug instead of introducing it,
> but rxe_mcast_add_grp_elem() calls rxe_alloc() with spin_locks held so
> we can't sleep.
> 
>     363 	if (!obj)
>     364 		goto out_cnt;
>     365 
>     366 	elem = (struct rxe_pool_entry *)(obj + info->elem_offset);
>     367 
>     368 	elem->pool = pool;
>     369 	kref_init(&elem->ref_cnt);
>     370 
>     371 	return obj;
>     372 
>     373 out_cnt:
>     374 	atomic_dec(&pool->num_elem);
>     375 	return NULL;
>     376 }
> 
> regards,
> dan carpenter
> 

Dan,

That should have been rxe_alloc_locked() which uses the GFP_ATOMIC flag. Slowly but surely the rxe object allocations have been moving into rdma/core so there are only 3 left, mcast groups, elements and MRs of which only the first two happen in IRQs or have locks. I'll submit a fix. Thanks for finding this.

Bob
