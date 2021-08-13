Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F93C3EBCE2
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Aug 2021 21:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhHMT5r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Aug 2021 15:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhHMT5r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Aug 2021 15:57:47 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC04C061756
        for <linux-rdma@vger.kernel.org>; Fri, 13 Aug 2021 12:57:20 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id e13-20020a9d63cd0000b02904fa42f9d275so13419075otl.1
        for <linux-rdma@vger.kernel.org>; Fri, 13 Aug 2021 12:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mbgUZ+Z6Y///A0q/kKjZB1lZrHxnpDT836P5OsBe+0k=;
        b=nvq1vVZg7eV8We+U0Svc55AKufB2TkD6IKf6qwEQOhE6slBTxudWSLGAoK1Fy1BnCd
         MrvG0d0VAVu6heQLOX/ULZCDoqPaoj473/GVqEaa2Mdovp5i1/iHK+exOqmV9Y9TxDUS
         RsylMQCsmVEHoVYtN5+xKy+Iex8e2fLEPe2YEHPSjbUT232/2JCtGOYum4puIDkD2zLC
         Wszo5MiTgdhwypjFckkdDyYY1uVk+j09TUrl2olPDjrRQAz44edUe5C6HMK7r8x1bDu0
         ik3zmE/fIxjaS6jIsQ/SgESEMZMs3ghe40kgyg2QWvByUHe+OquVSt8WEYE28SPxtR2U
         937Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mbgUZ+Z6Y///A0q/kKjZB1lZrHxnpDT836P5OsBe+0k=;
        b=ap/k38zXF3s2t8sm6o+ltbZJdDPX3t6ZilkuHEhyomSGUowVYcBJFF6daWdDMXMBEE
         nRqiZi2bJxcl7jkg72uAnJXiGN2vpoD6oWPhZ4y+mqRpecU/9jCLL0uPuN/7XAZnrndq
         4iEIB66PWWCmgKoAmULr093utDTu0bLkzITxljWgRlUl7X3Aoy3S+ExOCr58O0MzvM7g
         oYcmkxoYsh9ggyLfzfaHaOXuHA6Mw+UuzJgoTdMMIXLiGZ7tTxGqq5ILtLOSxdw6Fpkc
         5IswcDrmkbglv8CeBrYcC2qU9b8DIJcYV2bcwIbLAse3SFHq6Uh1qT6kaJPhD213Xt+4
         43jA==
X-Gm-Message-State: AOAM533+jc/0afA3LJRAchBG0XPIRUSHCxMfJzTZbyj9KQZ2Vkwjsu5P
        XUnNDSex4f4u/o3SMFXxEc1X8dvOgjA=
X-Google-Smtp-Source: ABdhPJza4Z4A4JIwcewKP3Y4iY7ln9pXTq4oYu3ofuPmYiYz9F7qI4GALKDUugDsHlSDhPAiWnv5BQ==
X-Received: by 2002:a9d:68d4:: with SMTP id i20mr3468985oto.63.1628884639147;
        Fri, 13 Aug 2021 12:57:19 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:5f86:1d06:aef7:df6b? (2603-8081-140c-1a00-5f86-1d06-aef7-df6b.res6.spectrum.com. [2603:8081:140c:1a00:5f86:1d06:aef7:df6b])
        by smtp.gmail.com with ESMTPSA id n4sm438030ooe.10.2021.08.13.12.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 12:57:18 -0700 (PDT)
Subject: Re: [bug report] RDMA/rxe: Remove RXE_POOL_ATOMIC
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-rdma@vger.kernel.org
References: <20210811085441.GA20866@kili>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <c5aaf213-c931-f9fb-8cb4-a41dff71145e@gmail.com>
Date:   Fri, 13 Aug 2021 14:57:13 -0500
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
