Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684554369AA
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 19:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhJURtc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 13:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbhJURt3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Oct 2021 13:49:29 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA07C061348
        for <linux-rdma@vger.kernel.org>; Thu, 21 Oct 2021 10:46:51 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id v77so1854710oie.1
        for <linux-rdma@vger.kernel.org>; Thu, 21 Oct 2021 10:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A8WxfEdfrJRK6ZMkEzw4+OqBFSv6lriy4DRHbeTIqIM=;
        b=HoA9Y7KKwtNwLDjcAvN63BPaJnQjslu2n+OTtOaG6koJhvRysSJAE64EzPxE14QrCb
         EBflgQjZOTWRGBsHyD45n4x99F6v8y/gCCQpLC33+VYRy27DgJBfLq7iMeMb4rRYEj7J
         nxEnsltQRgJgcgX4mK0gcA5LgoLKB1muBAq370wMrrbS81h0PSDETj2fTWjmh+zJXvzq
         YUQMlvM1e5E8zkAwYR0BVOoGuRNl+FOPYpr3jBH+xkPI5zgp3wSzz9otgsHaIVvMgDEZ
         TPcYXCl5SNveHOp4l64SPAzxG1vuOflzdmVEGELgTF4AUhO9YDkdUPCdx3h+Lv3jmdjn
         E/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A8WxfEdfrJRK6ZMkEzw4+OqBFSv6lriy4DRHbeTIqIM=;
        b=VJWyUUzrM0Ci5G5UIuRIZoYgIRrHoWh4Y/zrLeUpbNOMEXX1UxOX2geM62tGTtlJN1
         nNiwB0H4D49f7BHJlk1nHeS94ASBmyNgS72d1mh+YyLYLPKoz1nnnhpHl6EeyEZ/t+nP
         0rbIp5rpuSKjF94yy0NeCrOhiJHGNAqEbcL2aK0DVLPyNiYGxK6BP2GBhBRHucOlFb4+
         D0mswK2S8amujZeIxVbpnedCsRv/9CfBZ+p1Yk5xdIrjlmhHThW5I86KFdYthV9KceaL
         7y0Q7twYqkmVKmr+zj/WODi/vy2bdu9O0mAExnlg5CvPWmf8cQEC7X4EpLBQO1pe2MDu
         bvFw==
X-Gm-Message-State: AOAM533Ysn0egn3nYGCbM3saWsWzP/6J8s7mHiGj7jfUIbJHnFmZbrOQ
        GTC2uQW6Yh00Yqf935maS7U+hHfk3wc=
X-Google-Smtp-Source: ABdhPJyaMJMFMayIqqTfGhe7r71Fh6266tvOnyRS+gWkeqIWfRFxjWeNT9PC7n7XT433KDcAWx4jvg==
X-Received: by 2002:a05:6808:10d5:: with SMTP id s21mr6044890ois.23.1634838410969;
        Thu, 21 Oct 2021 10:46:50 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:604c:7dbe:eb8:ab92? (2603-8081-140c-1a00-604c-7dbe-0eb8-ab92.res6.spectrum.com. [2603:8081:140c:1a00:604c:7dbe:eb8:ab92])
        by smtp.gmail.com with ESMTPSA id w20sm1155408otj.23.2021.10.21.10.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 10:46:50 -0700 (PDT)
Subject: Re: [PATCH for-next 1/6] RDMA/rxe: Make rxe_alloc() take pool lock
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
 <20211010235931.24042-2-rpearsonhpe@gmail.com>
 <20211020231653.GA28428@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <21346584-a27f-323b-e932-042fa7cd94b5@gmail.com>
Date:   Thu, 21 Oct 2021 12:46:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211020231653.GA28428@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/20/21 6:16 PM, Jason Gunthorpe wrote:
> On Sun, Oct 10, 2021 at 06:59:26PM -0500, Bob Pearson wrote:
>> In rxe there are two separate pool APIs for creating a new object
>> rxe_alloc() and rxe_alloc_locked(). Currently they are identical.
>> Make rxe_alloc() take the pool lock which is in line with the other
>> APIs in the library.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>  drivers/infiniband/sw/rxe/rxe_pool.c | 21 ++++-----------------
>>  1 file changed, 4 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
>> index ffa8420b4765..7a288ebacceb 100644
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>> @@ -352,27 +352,14 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
>>  
>>  void *rxe_alloc(struct rxe_pool *pool)
>>  {
>> -	struct rxe_type_info *info = &rxe_type_info[pool->type];
>> -	struct rxe_pool_entry *elem;
>> +	unsigned long flags;
>>  	u8 *obj;
>>  
>> -	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
>> -		goto out_cnt;
>> -
>> -	obj = kzalloc(info->size, GFP_KERNEL);
>> -	if (!obj)
>> -		goto out_cnt;
>> -
>> -	elem = (struct rxe_pool_entry *)(obj + info->elem_offset);
>> -
>> -	elem->pool = pool;
>> -	kref_init(&elem->ref_cnt);
>> +	write_lock_irqsave(&pool->pool_lock, flags);
>> +	obj = rxe_alloc_locked(pool);
>> +	write_unlock_irqrestore(&pool->pool_lock, flags);
> 
> But why? This just makes a GFP_KERNEL allocation into a GFP_ATOMIC
> allocation, which is bad.
> 
> Jason
> 
how bad? It only has to happen once in the driver for mcast group elements where
currently I have (to avoid the race when two QPs try to join the same mcast grp
on different CPUs at the same time)

	spin_lock()
	grp = rxe_get_key_locked(pool, mgid)
	if !grp
		grp = rxe_alloc_locked(pool)
	spin_unlock()

Here the kzalloc has to be GFP_ATOMIC. But I could write after fixing things to
move the kzalloc out of the lock in rxe_alloc().

	newgrp = rxe_alloc(pool)	/* using GFP_KERNEL */
	spin_lock()
	grp = rxe_get_key_locked(pool, mgid)
	if (grp)
		kfree(newgrp)
	else {
		grp = newgrp
		<set key in grp>
	}
	spin_unlock()

A typical use case would be for a bunch of QPs to join a mcast group and most of the
time the key lookup succeeds. The trade off is between extra malloc/free and occasional
bad behavior from GFP_ATOMIC.

The majority of uses for rxe_alloc() do not have these issues and I can move the kzalloc
outside of the lock and use GFP_KERNEL.

Bob
