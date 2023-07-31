Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9B876A0AC
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGaSwH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjGaSwG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:52:06 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAE7101
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:52:03 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bc9254a1baso1820999a34.2
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690829523; x=1691434323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OZhwtb/+nN7UmsoXYUc9FO06Q6gOSy4YNvHnGRdqg4M=;
        b=NUzHjfbF9PPW7ls5cWiKDQ6Mp6IYWsglgzorF0Yj+krgIvAzFfpZBSnrK08Doi0BWD
         hOkdcGMUW5ES36pk97WYHM5aALyZ6+YM8lQWg4gw0Qa/EqTQH2BhSIZKXd1bc22RxYj4
         J1c7Q7RsllR5sFznEOw3qxDenfDcn1o/cEzeeJKfQlXkN1eUp2Gwc5cB5d+POY2mo7Nk
         tToX1ZYzkV2poHRmELHQOidebRid17kggJiz5+C89iIHpdhxCKep7A6Q6RQYRHuGV1R0
         J6LuaQiwdf6Jd60KYcsy/ZoYHVu4+SpG0daromI77P2d9hvU2Y//sltUqYmWcT0ridCS
         XUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690829523; x=1691434323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZhwtb/+nN7UmsoXYUc9FO06Q6gOSy4YNvHnGRdqg4M=;
        b=g2IonffM2GFq7ftOW/NN+PGAwI5Lst6zh7dKpxHsJicw2YvAAqRrfMsYl+LpAwUfoq
         gD8Ibn+B524uhNevV+ZBQ0m+dP1BQMm//YuBu8pL1oY8cIDYS/vKZSf2GZGCWPJ3koCc
         qWK/bkEP60A8gHNry67cGT64mnmrOJvW6QVVx5EnghnJHqtBLgdE1e1qELjbj2dnP742
         DfpNnMc1Dtj/EzLGNJwLcvtkr9faf2jnH2alcKq1CwUJDQCEiVeZIOE8sFYjK+nuTXif
         V+iALRmn7a6c/J0+Eoojv7n67o+4zirzavDE774KJ22G5v5nnCRiv8SFaF4rjl5G096a
         R5Hg==
X-Gm-Message-State: ABy/qLbZ5KQUir+ZHu+AIDmTNbrA9P5UeF3fDt9AlZyueGM9l60L8vlo
        B90wfS4zD6aK8hEEhTKacGE=
X-Google-Smtp-Source: APBJJlERd8cVSZdVVhcZuy/3SnpwqUp+OReTYbB6X+WjJRVd2oAaDtYl/kFYEBCi/+pd4edlpUOgCg==
X-Received: by 2002:a05:6830:20d8:b0:6b9:57cb:8c42 with SMTP id z24-20020a05683020d800b006b957cb8c42mr11620606otq.13.1690829522972;
        Mon, 31 Jul 2023 11:52:02 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:8206:c67a:f41a:8567? (2603-8081-140c-1a00-8206-c67a-f41a-8567.res6.spectrum.com. [2603:8081:140c:1a00:8206:c67a:f41a:8567])
        by smtp.gmail.com with ESMTPSA id w2-20020a9d77c2000000b006b71deb7809sm4320334otl.14.2023.07.31.11.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 11:52:02 -0700 (PDT)
Message-ID: <394e5205-4bec-3a92-7c89-8966d2329946@gmail.com>
Date:   Mon, 31 Jul 2023 13:51:59 -0500
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
 <4aeec08f-bd31-9cac-d121-12da5a20c2ee@gmail.com>
 <ZMgA4mNoJ9ZhunZP@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZMgA4mNoJ9ZhunZP@nvidia.com>
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

On 7/31/23 13:43, Jason Gunthorpe wrote:
> On Mon, Jul 31, 2023 at 01:42:09PM -0500, Bob Pearson wrote:
>> On 7/31/23 13:31, Jason Gunthorpe wrote:
>>> On Mon, Jul 31, 2023 at 01:23:59PM -0500, Bob Pearson wrote:
>>>> On 7/31/23 13:15, Jason Gunthorpe wrote:
>>>>> On Fri, Jul 21, 2023 at 03:50:21PM -0500, Bob Pearson wrote:
>>>>>> This patch gives a more detailed list of objects that are not
>>>>>> freed in case of error before the module exits.
>>>>>>
>>>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>>>> ---
>>>>>>  drivers/infiniband/sw/rxe/rxe_pool.c | 12 +++++++++++-
>>>>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
>>>>>> index cb812bd969c6..3249c2741491 100644
>>>>>> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
>>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>>>>>> @@ -113,7 +113,17 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
>>>>>>  
>>>>>>  void rxe_pool_cleanup(struct rxe_pool *pool)
>>>>>>  {
>>>>>> -	WARN_ON(!xa_empty(&pool->xa));
>>>>>> +	unsigned long index;
>>>>>> +	struct rxe_pool_elem *elem;
>>>>>> +
>>>>>> +	xa_lock(&pool->xa);
>>>>>> +	xa_for_each(&pool->xa, index, elem) {
>>>>>> +		rxe_err_dev(pool->rxe, "%s#%d: Leaked", pool->name,
>>>>>> +				elem->index);
>>>>>> +	}
>>>>>> +	xa_unlock(&pool->xa);
>>>>>> +
>>>>>> +	xa_destroy(&pool->xa);
>>>>>>  }
>>>>>
>>>>> Is this why? Just count the number of unfinalized objects and report
>>>>> if there is difference, don't mess up the xarray.
>>>>>
>>>>> Jason
>>>> This is why I made the last change but I really didn't like that there was no
>>>> way to lookup the qp from its index since we were using a NULL xarray entry to
>>>> indicate the state of the qp. Making it explicit, i.e. a variable in the struct
>>>> seems much more straight forward. Not sure why you hated the last
>>>> change.
>>>
>>> Because if you don't call finalize abort has to be deterministic, and
>>> abort can't be that if it someone else can access the poitner and, eg,
>>> take a reference.
>>
>> rxe_pool_get_index() is the only 'correct' way to look up the pointer and
>> it checks the valid state (now). Scanning the xarray or just looking up
>> the qp is something outside the scope of the normal flows. Like listing
>> orphan objects on module exit.
> 
> Maybe at this instance, but people keep changing this and it is
> fundamentally wrong to store a pointer to an incompletely initialized
> memory for other threads to see.
> 
> Especially for some minor debugging feature.

Maybe warning comments would help. There are lots of ways to break the code, sigh.
The typical one is someone makes a change that breaks reference counting.
> 
> Jason

