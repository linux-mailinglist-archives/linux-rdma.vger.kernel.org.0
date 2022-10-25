Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD49460CF89
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 16:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiJYOty (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 10:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiJYOtu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 10:49:50 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D05F122756
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 07:49:49 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13bef14ea06so2036920fac.3
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=959EaTBcqwQoZYHb9ekwOs44XubvfzAsv+oxKIaqDZM=;
        b=UeTrQC4bm6z6eQeEn5dpuuyXbz1api5eWaUEPAk5Kh4sUMJODC3NMWTXkko8YR+cBc
         isDNdC0obBMbm8/PhDK+oG3Gbj18rHiYerMyEpwCc6Q5xzYMbv+Mxks84V72IpeHxs/b
         gK/XWKSvyzfYvJDO9uSNktK6Vkoco3wSrjwBJVxmJIYE7Jn0Q592zssiTE/5x4yxurN3
         0LD69T/oMoJpvrwt71o6RAkNgFw7y3y5E0XEaHvUa8lfAySsU9e1+/qgWFUDtnBXnKpg
         zBkibDXookU9LnYmEXwclvJiYvtIktgJ6N5jVa40gO6L0TFcbF8pjf3Fkod/G/N3WbV7
         RIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=959EaTBcqwQoZYHb9ekwOs44XubvfzAsv+oxKIaqDZM=;
        b=k0aiqdFhDSVN19KgNw0l6GLX6mb3xfw+Yza/cHFTtllJQtTNBtI9uGYXvdWd4F5VNy
         jJkCil4PQLbFeD8HE7+xV+2m9hkA2+MPn6NbRksOTXMd7sLzk5J+l4GfTouKJ5CZ156k
         ycykfwHaeZ8ch+gpPIweB2pUo4ccsIJasYIrLM6q5/pMvo/MMczjOnP9EsBN3r6zXfGO
         z6aTPuJstiAe2cclx69BvB0sp0uF/KLWXNygapKXn6N82v7WNmxOOB2k3lgjjyRt8lea
         sqz8r58vxx3miQsKg0ifWfaA3EOcki5/QVAJO4pKPcld57RMqQsiz0yj4jGvuxX6VbuA
         FjfQ==
X-Gm-Message-State: ACrzQf37x0+XrP8qDNEMKGJxlkch+K2e6DD3hVzQD2AoC4NJuufw3XL9
        zaKjxc9FCz0g2qpsmQ1Xc8w=
X-Google-Smtp-Source: AMsMyM674EGnZ9cQoWD0GwEsYz5xeSPTA1+Z3oeAWFrC2joaSM/U4wC3TxfI1ldiNgVUNhFMEyXlpQ==
X-Received: by 2002:a05:6870:b507:b0:132:6bb5:77c4 with SMTP id v7-20020a056870b50700b001326bb577c4mr23657409oap.91.1666709389011;
        Tue, 25 Oct 2022 07:49:49 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:5979:2555:99aa:7129? (2603-8081-140c-1a00-5979-2555-99aa-7129.res6.spectrum.com. [2603:8081:140c:1a00:5979:2555:99aa:7129])
        by smtp.gmail.com with ESMTPSA id j10-20020a4aab4a000000b004762a830156sm1183532oon.32.2022.10.25.07.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 07:49:48 -0700 (PDT)
Message-ID: <33654e21-1693-cbee-6dd1-bca690547c33@gmail.com>
Date:   Tue, 25 Oct 2022 09:49:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH for-next v2 18/18] RDMA/rxe: Add parameters to control
 task type
Content-Language: en-US
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "haris.phnx@gmail.com" <haris.phnx@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
 <20221021200118.2163-19-rpearsonhpe@gmail.com>
 <TYCPR01MB845563BB1E56CFB317D4409BE5319@TYCPR01MB8455.jpnprd01.prod.outlook.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <TYCPR01MB845563BB1E56CFB317D4409BE5319@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/25/22 04:35, Daisuke Matsuda (Fujitsu) wrote:
> On Sat, Oct 22, 2022 5:01 AM Bob Pearson:
>>
>> Add modparams to control the task types for req, comp, and resp
>> tasks.
>>
>> It is expected that the work queue version will take the place of
>> the tasklet version once this patch series is accepted and moved
>> upstream. However, for now it is convenient to keep the option of
>> easily switching between the versions to help benchmarking and
>> debugging.
>>
>> Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_qp.c   | 6 +++---
>>  drivers/infiniband/sw/rxe/rxe_task.c | 8 ++++++++
>>  drivers/infiniband/sw/rxe/rxe_task.h | 4 ++++
>>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> <...>
> 
>> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
>> index 9b8c9d28ee46..4568c4a05e85 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_task.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
>> @@ -6,6 +6,14 @@
>>
>>  #include "rxe.h"
>>
>> +int rxe_req_task_type = RXE_TASK_TYPE_TASKLET;
>> +int rxe_comp_task_type = RXE_TASK_TYPE_TASKLET;
>> +int rxe_resp_task_type = RXE_TASK_TYPE_TASKLET;
> 
> As the tasklet version is to be eliminated in near future, why
> don't we make the workqueue version default now?
> 
> 
>> +
>> +module_param_named(req_task_type, rxe_req_task_type, int, 0664);
>> +module_param_named(comp_task_type, rxe_comp_task_type, int, 0664);
>> +module_param_named(resp_task_type, rxe_resp_task_type, int, 0664);
> 
> As I have commented to the 7th patch, users would not benefit from
> specifying the 'inline' type directly. It is OK to have the mode internally
> to keep the source code simple, but RXE_TASK_TYPE_INLINE should
> not be exposed to users.
> 
> I suggest that these module parameters be bool type and task types
> be like this:
> === rxe_task.h===
> enum rxe_task_type {
>         RXE_TASK_TYPE_WORKQUEUE = 0,
>         RXE_TASK_TYPE_TASKLET   = 1,
>         RXE_TASK_TYPE_INLINE    = 2,
> };
> =============
> In this case, while we can preserve the 'inline' type internally,
> we can prohibit users from specifying any value other than
> 'workqueue' or 'tasklet'; modprobe fails if non-boolean values
> are passed.

I don't know if you have noticed this but the tasks that handle incoming packets
already process them inline if the queues are empty which is most of the time.
The difference between this and inline always is not major. The NAPI thread is
already deferred once so we're not running at hw interrupt level.

What you say makes sense in a multi-user environment but that is not always the case.
HPC jobs typically have the node dedicated to a single user and it seems best to let
them figure out what works best. In any case it takes root to make this change.

Bob
> 
> If you still want to keep the parameters int type, then you need
> to add some code to perform value check. We can specify an 
> arbitrary int value with the current implementation.
> 
> Thanks,
> Daisuke
> 
>> +
>>  static struct workqueue_struct *rxe_wq;
>>
>>  int rxe_alloc_wq(void)
>> diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
>> index d1156b935635..5a2ac7ada05b 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_task.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_task.h
>> @@ -7,6 +7,10 @@
>>  #ifndef RXE_TASK_H
>>  #define RXE_TASK_H
>>
>> +extern int rxe_req_task_type;
>> +extern int rxe_comp_task_type;
>> +extern int rxe_resp_task_type;
>> +
>>  struct rxe_task;
>>
>>  struct rxe_task_ops {
>> --
>> 2.34.1
> 

