Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA494DA8C3
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 04:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241944AbiCPDHK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Mar 2022 23:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbiCPDHJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Mar 2022 23:07:09 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3875C354
        for <linux-rdma@vger.kernel.org>; Tue, 15 Mar 2022 20:05:56 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id v75so1327134oie.1
        for <linux-rdma@vger.kernel.org>; Tue, 15 Mar 2022 20:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Iu+GUflbu58TKbXwm7+IbJNpzgvRm62JwWN3Zieb5J8=;
        b=B3fq0FrFv+XZwyQVDTDd1hPJnso413dSOViHtZOzHseNd55QWIJRN9DduPvdSz2JwR
         A1VssBGTEZ6jmFYvo0IapsIGS5x8BAP5NPe8+NTJM2T/PpTQ6D5LqHdwuuOySzqUIJkd
         5lIB7XNTLGLLOu3h70SzXp/AIlRjgI8LuXF7J9jOX0l/KhVyYN5EsP3eGDpUbn0KqLqm
         UA4aM3LI9H7XYalbVh1ehm1UOyRY4egPBBBcKXzjSGcI8gMzCtzGjLRSJpXlMJIwYIYh
         qKRwW/LFNJJmigjAR5iWkKdSN0nUqLtnxTP/eN01TTzz0TORGnXBg4/5Og4n304E4THU
         LJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Iu+GUflbu58TKbXwm7+IbJNpzgvRm62JwWN3Zieb5J8=;
        b=iuZR0KFlNEGdHcO411f4QPZvzEV/OfdvDpIIsN/xLtFv0CrFkLmTwhJuInAqo5yQDn
         gBq4IjgCp9OtzjUVQ3hk/41nD04c78Ubd8NKlqatejzSDDcEzH/TAEw+c3w8ElX2+8fu
         qo9wyxbW/GZfeZrKk0K3jBdHpc7YHa5ZfUjtSUc3ZwyX8S2RBbu33t5/+YNTg00ZXR7n
         0QlgDYvMblF48eKRbGtN0+DzuN+Se0hirFxv5S2AzUbtb2Tb5yucpjwMb9U0I64m1tMY
         Y3kFM0hBLjkWLfO1Q78PFG8koJTiQcPWUVaY49trRLuL0xEtavRh3g6oqCuV5LeJ9kS6
         k3dA==
X-Gm-Message-State: AOAM530JbpXJQHAz+WNKMXYN6pwyhxUlVuhhWU55BMDWqsaNtWNeZiSW
        msugmCDlO9mCC2//uT/gwG5StqYBCro=
X-Google-Smtp-Source: ABdhPJwz9DFXRc0LIqEUIUjZ+48HPjmmJr1Ak5nTg1PNKGElKGVtOhoh1XOpDl4mTRYkTSV1fLvHmg==
X-Received: by 2002:a05:6808:198:b0:2ec:d0f4:2388 with SMTP id w24-20020a056808019800b002ecd0f42388mr3081032oic.215.1647399955444;
        Tue, 15 Mar 2022 20:05:55 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:744:9605:b0bf:1b15? (2603-8081-140c-1a00-0744-9605-b0bf-1b15.res6.spectrum.com. [2603:8081:140c:1a00:744:9605:b0bf:1b15])
        by smtp.gmail.com with ESMTPSA id w25-20020a4a6d59000000b003208276963esm393638oof.14.2022.03.15.20.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 20:05:54 -0700 (PDT)
Message-ID: <d7e5ae35-0c27-73cb-fab9-b9ab8c452a6b@gmail.com>
Date:   Tue, 15 Mar 2022 22:05:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH for-next v11 08/13] RDMA/rxe: Replace red-black trees by
 xarrays
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
 <20220304000808.225811-9-rpearsonhpe@gmail.com>
 <20220315234509.GU11336@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220315234509.GU11336@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/15/22 18:45, Jason Gunthorpe wrote:
> On Thu, Mar 03, 2022 at 06:08:04PM -0600, Bob Pearson wrote:
>>  void rxe_pool_cleanup(struct rxe_pool *pool)
>>  {
>>  	struct rxe_pool_elem *elem;
>> +	struct xarray *xa = &pool->xa;
>> +	unsigned long index = 0;
>> +	unsigned long max = ULONG_MAX;
>> +	unsigned int elem_count = 0;
>> +	unsigned int obj_count = 0;
>> +
>> +	do {
>> +		elem = xa_find(xa, &index, max, XA_PRESENT);
>> +		if (elem) {
>> +			elem_count++;
>> +			xa_erase(xa, index);
>> +			if (pool->flags & RXE_POOL_ALLOC) {
>> +				kfree(elem->obj);
>> +				obj_count++;
>> +			}
>>  		}
>> +	} while (elem);
>>  
>> +	if (WARN_ON(elem_count || obj_count))
>> +		pr_debug("Freed %d indices and %d objects from pool %s\n",
>> +			elem_count, obj_count, pool->name);
> 
> Can this just be 
> 
> WARN_ON(!xa_empty(xa));
> 
> ?
> 
> Freeing memory that is still in use upgrades a resource leak to a UAF
> security bug, so that is usually not good.
> 
> Jason

FWIW rxe_pool_cleanup() gets called in rxe_dealloc() which is the .dealloc_driver member in ib_device_ops.
In other words not until you are unloading the driver and only MRs are freed and the memory will never get used again. I have found it useful when debugging ref count mistakes.

OTOH, I can save the hunk and apply it when I need it so I don't really care if it goes upstream. So feel free
to go ahead and change it. The one line should go into rxe_dealloc() in rxe.c.

Bob

