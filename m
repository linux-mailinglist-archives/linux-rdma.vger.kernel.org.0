Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CC13F68BD
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Aug 2021 20:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbhHXSF0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Aug 2021 14:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbhHXSFX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Aug 2021 14:05:23 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF678C0612A4
        for <linux-rdma@vger.kernel.org>; Tue, 24 Aug 2021 11:04:35 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so48479915oti.0
        for <linux-rdma@vger.kernel.org>; Tue, 24 Aug 2021 11:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=btctbxIgFCPk3/Mfha+orcCK9e78yGFdwvBfDeR/8Wk=;
        b=qWhdkZ8R3dhblO23yOm0C8nJgiDOvDIq4awmYY9inqiBE+eVxaCeFmuqQA2wqy47dp
         HocttklgAboiL9CZsoIBwAWLlJsmThAKeZdhKwbXhliYyGugTD+A0UOzB9+sIRC+a0E+
         1cThp9tbSXemgUl26nsvaTJJX8hZcDL9Xz8pdnJHsi7C7gLL3g9qqe9ILQ/l0JKpkXKP
         UitlFHor5hQrakzOuYRLji3aht0TT3klPzaDWYw8Ce53TQ6NrTEhFbwBJRRVq01/sxES
         vpwLjKkqU+/EmtCT3MXgNamZ4t/8i5a1VZ/d6EjL/7XPNYSZf5M/5/AD8yi8IB2OHH4/
         rXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=btctbxIgFCPk3/Mfha+orcCK9e78yGFdwvBfDeR/8Wk=;
        b=c2eDBBfe2wZbigPmkQc4fix7dbfqD/dtUJb5HIatB0QTSUoAkVVXdK6pLUf6xQYNqG
         7BsmWR1Sy5YAdpJp73gpYKf/EUG6lir2wR2jrUKjiB3B88GkZOPDLh4njb56c2JfNZPM
         ZBvD68Yn8WN/KQp63EFlPsiPDMXds9+fEjuY6G8Lnzo2Nn3BySwM0Yfm3jg0zVGrG10w
         Gc2pJM+6V2RbcW+Vr4K2EdVM02icFkfppWV4uPljq932dI4oMkUs627T+aeV3NXVHemi
         JM3RTA2pvBayCUiwG/gb4JEAwzgbdlBvDNxjm+QATJVhxp7UDzjmydmCkZic0d2bGFq3
         j0Yg==
X-Gm-Message-State: AOAM53391gr/k4ANS2AUBH79t4woxf2QyuaoyRRVicxKmxAF6W0q3O9P
        Zd9qV9oqJsDCuDTHVdXROEQ=
X-Google-Smtp-Source: ABdhPJwss0qHkKGjiBfW5qAmrb6ycX3W8U0JUmMDHa/WGaL1wGhL9W2QVVPQCaNbKS5HqURUEVeZ9Q==
X-Received: by 2002:a05:6808:1494:: with SMTP id e20mr3660893oiw.122.1629828275045;
        Tue, 24 Aug 2021 11:04:35 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:4562:ad09:2e63:bf2d? (2603-8081-140c-1a00-4562-ad09-2e63-bf2d.res6.spectrum.com. [2603:8081:140c:1a00:4562:ad09:2e63:bf2d])
        by smtp.gmail.com with ESMTPSA id j4sm1091622oom.10.2021.08.24.11.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 11:04:34 -0700 (PDT)
Subject: Re: [PATCH] RDMA/rxe: Zero out index member of struct rxe_queue
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
References: <20210820111509.172500-1-yangx.jy@fujitsu.com>
 <9302c160-5905-0bf3-5e1c-98d673aaa2fc@gmail.com>
 <6120F8D5.6050408@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <0d52f152-9c70-57c2-c95f-da434c66dfd7@gmail.com>
Date:   Tue, 24 Aug 2021 13:04:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6120F8D5.6050408@fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/21/21 8:00 AM, yangx.jy@fujitsu.com wrote:
> On 2021/8/21 2:44, Bob Pearson wrote:
>> On 8/20/21 6:15 AM, Xiao Yang wrote:
>>> 1) New index member of struct rxe_queue is introduced but not zeroed
>>>     so the initial value of index may be random.
>>> 2) Current index is not masked off to index_mask.
>>> In such case, producer_addr() and consumer_addr() will get an invalid
>>> address by the random index and then accessing the invalid address
>>> triggers the following panic:
>>> "BUG: unable to handle page fault for address: ffff9ae2c07a1414"
>>>
>>> Fix the issue by using kzalloc() to zero out index member.
>>>
>>> Fixes: 5bcf5a59c41e ("RDMA/rxe: Protext kernel index from user space")
>>> Signed-off-by: Xiao Yang<yangx.jy@fujitsu.com>
>>> ---
>>>   drivers/infiniband/sw/rxe/rxe_queue.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
>>> index 85b812586ed4..72d95398e604 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_queue.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_queue.c
>>> @@ -63,7 +63,7 @@ struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
>>>   	if (*num_elem<  0)
>>>   		goto err1;
>>>
>>> -	q = kmalloc(sizeof(*q), GFP_KERNEL);
>>> +	q = kzalloc(sizeof(*q), GFP_KERNEL);
>>>   	if (!q)
>>>   		goto err1;
>>>
>>>
>> Thanks for this!! I am happy to take the blame but this has been there from the original 2016 rxe commit. Its a good catch.
> Hi Bob,
> 
> The original 2016 rxe commit actually introduced kmalloc() but it 
> initialized all members of struct rxe_queue at subsequent steps.
> When the new index member of struct rxe_queue was added, it didn't 
> initialized at subsequent steps.  So I think the issue was caused by 
> your patch.
Yup. My comment was really that if it was an old one I was guilty either way most likely. But this is a good catch.
> I use kzalloc() to fix the issue because I want to avoid the same issue 
> when another new member will be added in future.
> 
> Best Regards,
> Xiao Yang
>> Reviewed-by: Bob Pearson<rpearsonhpe@gmail.com>

