Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1464C76A04D
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjGaSYI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjGaSYG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:24:06 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509D9E3
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:24:02 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-56cd753b31cso516640eaf.1
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690827841; x=1691432641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NlTM4X4Ml13r9zYM7EN8ne1PeQwnQe7iXnnvR3I2UA=;
        b=QJe5Tzt7DeSj5t5qQJ+5CPSXoNFmh2JOAUQKICc6oxuVG7CL0GErAC3vAaFzcwzZKD
         LgoTJ+w2y4kzF4NK5BhRdZIiM4waf3L9uJCHLmY4ShHd5htSuxrLhDEJEHTVmzLJIbfr
         JvbBpUNlz/t4cwJPBhwzjti7a6243YHLHBsprLNZSJpIDbILKdtwp4iDQwDg+kxyFXj1
         VY30OLnbBzigbOgLtZoVKNfOM9Z6yLyfSn9Xv6Lkm7l3r8mw/8v/lbBtU1mhACbn1Z7k
         EghVsOAiRK9zLSQvfNgPTJS10zCtlh4t3cnNSNLXhCx/X5mOpJRGNzECCx5rmxiwhlE+
         yG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690827841; x=1691432641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NlTM4X4Ml13r9zYM7EN8ne1PeQwnQe7iXnnvR3I2UA=;
        b=MQu8Fnsr4CvsGIoJLQCd94hSQ+bfrb+nc0UJIT5o/p5zXEOUxVCRpmzBiKDK496zv6
         axWrTkX7cdLO9c+4xGtT0O8Owmus8bUU2emwxX3h1gcgPypB3KdsygjeClbZlf4pDf6V
         EQcfHDyJ0Iox6dyMIdcTsi2Vc0A8lxOAk92DIRZAE9EXfN/UIiX0aMv1tSEV8TcX3/R4
         12yDWIC3FNTcmXCth6BR34nRE5p6yHLyOwE8HAvOo3cnQSTJOBUpC9zS4mehA80ah9zf
         saLqbo6/VTKRI6QtG5J6+LYo/pdAvfTui3ngZumR+oBBjMBn4TpOSGoYBRzkV5B+F1bs
         ZxIg==
X-Gm-Message-State: ABy/qLaLpcvbSjQAknNK6TfMdunCKKvpYpx0BP6OGAzbrXcWf0ybBRR4
        SHVYzwaN15yUTlKODzHGwzDR2ROqptA=
X-Google-Smtp-Source: APBJJlFjdI2wHJpSjzqzEmpTb/YbPZEPPpTNn9ijnh/nFFdJD+46OcGTYeNPpMzaESmIkBcQ4AsDLg==
X-Received: by 2002:a4a:9c8d:0:b0:56c:a6ec:8e2d with SMTP id z13-20020a4a9c8d000000b0056ca6ec8e2dmr3710789ooj.8.1690827841194;
        Mon, 31 Jul 2023 11:24:01 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:8206:c67a:f41a:8567? (2603-8081-140c-1a00-8206-c67a-f41a-8567.res6.spectrum.com. [2603:8081:140c:1a00:8206:c67a:f41a:8567])
        by smtp.gmail.com with ESMTPSA id o4-20020a4a4404000000b00560b1febfdfsm4583026ooa.10.2023.07.31.11.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 11:24:00 -0700 (PDT)
Message-ID: <ecd82fc6-0a2d-7dff-496e-5a92d115da8c@gmail.com>
Date:   Mon, 31 Jul 2023 13:23:59 -0500
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
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZMf6XBIAD0A25csR@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/31/23 13:15, Jason Gunthorpe wrote:
> On Fri, Jul 21, 2023 at 03:50:21PM -0500, Bob Pearson wrote:
>> This patch gives a more detailed list of objects that are not
>> freed in case of error before the module exits.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_pool.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
>> index cb812bd969c6..3249c2741491 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>> @@ -113,7 +113,17 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
>>  
>>  void rxe_pool_cleanup(struct rxe_pool *pool)
>>  {
>> -	WARN_ON(!xa_empty(&pool->xa));
>> +	unsigned long index;
>> +	struct rxe_pool_elem *elem;
>> +
>> +	xa_lock(&pool->xa);
>> +	xa_for_each(&pool->xa, index, elem) {
>> +		rxe_err_dev(pool->rxe, "%s#%d: Leaked", pool->name,
>> +				elem->index);
>> +	}
>> +	xa_unlock(&pool->xa);
>> +
>> +	xa_destroy(&pool->xa);
>>  }
> 
> Is this why? Just count the number of unfinalized objects and report
> if there is difference, don't mess up the xarray.
> 
> Jason
This is why I made the last change but I really didn't like that there was no
way to lookup the qp from its index since we were using a NULL xarray entry to
indicate the state of the qp. Making it explicit, i.e. a variable in the struct
seems much more straight forward. Not sure why you hated the last change.

Bob
