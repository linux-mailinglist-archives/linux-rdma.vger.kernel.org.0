Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F7A76A08E
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjGaSma (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjGaSmW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:42:22 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D352101
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:42:11 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bca7d82d54so736312a34.3
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690828930; x=1691433730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xsxM0lFmBzURYMGkKkeSxOAK6r9PDir7Z5KElCvqpI=;
        b=NbVU2V+3Yu6dvLPHk6mQgcBQdb6pJilbJ7icvh11HFPglOEVIsXcmtV46MqaqgUIrs
         HMF9xEXzu/R/EROcIE2ai1i8nrb87pkXn9avjUqZgLwwfrGJRYwzWq2VFfxXNSQgjbN9
         lHI39Tlcyo6CS+MAhTD5llIPXCU3/XNwez9hvJ7HLWfYRn8JAMe51j8VdF0zTV2qW20s
         063gk1EhGWiPzcZKczmMdum73bSXoCpZqOUNsvMNJxYHuEPkbGL8as2AlSt7qyR53FO+
         NY4TyUOEX54oLLBQyFY9Q8ouGEacuvjqlVVQTZMA5Fr1n30QpccYmpLJnmT2WtYqg3j+
         9RtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690828930; x=1691433730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xsxM0lFmBzURYMGkKkeSxOAK6r9PDir7Z5KElCvqpI=;
        b=cXLNhNju7ADfnIkYeiVpsUHe9bFHD2F2Zw0bnoXs0Vb9poAGfIvoP3FG/o7hxjiMbp
         qc3ziqJTIK+Qz50jFOEhcSUyUTPgd9B3uO3uQeZyyvHUo+rveC/d6AnqYU6Q+VEvSS2x
         FJSef653DAy1WZo+RCYASr0llmNdM/F0ssxQ10JoaSiuiRRjDHQTWKmtySCsl7dQKu0R
         xbGaA3BlZbRWX/WHYVKW+AAsH4m6s6dDnT4fC1HvpFjwYU2sGXBoNuUTUq6SjOGgnwBq
         LCyyjb4xoZ3/CeqUj9lnn2wd8GxWMw3QvmjiZurbmS4fsLXTvrJF7hd4r+wwZUstL5ZM
         U6zA==
X-Gm-Message-State: ABy/qLZRBVcW0FWIE3lMQKFy3sycRHPpbfzdKL35cOh6ij8JZR+26cHd
        ffGyw8blF1ThH+BvO8eyrvM=
X-Google-Smtp-Source: APBJJlGI2EMEpY1dS+1XYEjlYbWlYttCUzd6EC2PRG/+nYZSdZZvgL8DOKylEZX8GsGLj2gr+4WzEg==
X-Received: by 2002:a05:6830:1557:b0:6b9:cba6:b246 with SMTP id l23-20020a056830155700b006b9cba6b246mr9786552otp.9.1690828930585;
        Mon, 31 Jul 2023 11:42:10 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:8206:c67a:f41a:8567? (2603-8081-140c-1a00-8206-c67a-f41a-8567.res6.spectrum.com. [2603:8081:140c:1a00:8206:c67a:f41a:8567])
        by smtp.gmail.com with ESMTPSA id e15-20020a9d6e0f000000b006b94904baf5sm4283630otr.74.2023.07.31.11.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 11:42:10 -0700 (PDT)
Message-ID: <4aeec08f-bd31-9cac-d121-12da5a20c2ee@gmail.com>
Date:   Mon, 31 Jul 2023 13:42:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-next 8/9] RDMA/rxe: Report leaked objects
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-9-rpearsonhpe@gmail.com> <ZMf6XBIAD0A25csR@nvidia.com>
 <ecd82fc6-0a2d-7dff-496e-5a92d115da8c@gmail.com>
 <ZMf987OeXm7bdBDP@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZMf987OeXm7bdBDP@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/31/23 13:31, Jason Gunthorpe wrote:
> On Mon, Jul 31, 2023 at 01:23:59PM -0500, Bob Pearson wrote:
>> On 7/31/23 13:15, Jason Gunthorpe wrote:
>>> On Fri, Jul 21, 2023 at 03:50:21PM -0500, Bob Pearson wrote:
>>>> This patch gives a more detailed list of objects that are not
>>>> freed in case of error before the module exits.
>>>>
>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>> ---
>>>>  drivers/infiniband/sw/rxe/rxe_pool.c | 12 +++++++++++-
>>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
>>>> index cb812bd969c6..3249c2741491 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>>>> @@ -113,7 +113,17 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
>>>>  
>>>>  void rxe_pool_cleanup(struct rxe_pool *pool)
>>>>  {
>>>> -	WARN_ON(!xa_empty(&pool->xa));
>>>> +	unsigned long index;
>>>> +	struct rxe_pool_elem *elem;
>>>> +
>>>> +	xa_lock(&pool->xa);
>>>> +	xa_for_each(&pool->xa, index, elem) {
>>>> +		rxe_err_dev(pool->rxe, "%s#%d: Leaked", pool->name,
>>>> +				elem->index);
>>>> +	}
>>>> +	xa_unlock(&pool->xa);
>>>> +
>>>> +	xa_destroy(&pool->xa);
>>>>  }
>>>
>>> Is this why? Just count the number of unfinalized objects and report
>>> if there is difference, don't mess up the xarray.
>>>
>>> Jason
>> This is why I made the last change but I really didn't like that there was no
>> way to lookup the qp from its index since we were using a NULL xarray entry to
>> indicate the state of the qp. Making it explicit, i.e. a variable in the struct
>> seems much more straight forward. Not sure why you hated the last
>> change.
> 
> Because if you don't call finalize abort has to be deterministic, and
> abort can't be that if it someone else can access the poitner and, eg,
> take a reference.

rxe_pool_get_index() is the only 'correct' way to look up the pointer and
it checks the valid state (now). Scanning the xarray or just looking up
the qp is something outside the scope of the normal flows. Like listing
orphan objects on module exit.

Memory ownership didn't change. It is still the same. The only change is
how we mark whether the object is valid for lookup.

Bob
> 
> It breaks the entire model of how the memory ownership works during creation.
> 
> Jason

