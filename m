Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11137B86D8
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Oct 2023 19:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjJDRna (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Oct 2023 13:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjJDRn3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Oct 2023 13:43:29 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB30C1;
        Wed,  4 Oct 2023 10:43:24 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1c61acd1285so17877295ad.2;
        Wed, 04 Oct 2023 10:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696441404; x=1697046204;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJKK67XdDJnWMIawgaJp1SNND6qPELIXbFpREx31IAQ=;
        b=YGaLkshz71rpnsBYLdtLfJCwWhcsmQcoBeznjyYjCjMVhaQeUr3es/ShG2RRiyCjWL
         G/SC7VduzwbsXtTfNU6H3Ko+AXu1K87g7mn8PKaZpc8A0pUD26YEiB12tQLrGMZhkpy8
         BgC3r5O79k/PYpjHi7qjQyxOYVaXwMp+s2vIacneYqEgaam8rEslpIv/vPKbsV5Cl5ZI
         9JllHsbVLAKy4hXUOom9FNqdXK4Z0NME6KryrBhv0ACYa9m9rzv0hsZn5yJXw6ZpZV06
         m9OjuVAIQEj4fXHI62iW9guUQgzzbg5LGT+zgB/4dzpZLsHsiOw6x0ht6mvO1FHEWHqo
         1a4w==
X-Gm-Message-State: AOJu0YxrbkdUNTwxZDb9ChZFabBCKyvnjkiNeyjlAw7aSrAVdzuFHTBp
        HCbDD/6yMqyktPCAAX+vdSk=
X-Google-Smtp-Source: AGHT+IFpPi4xetyPbGBA3KWF/Sj6KfQb7Ej3zHvtkHUqbvFilmO7u0DQoNyvyZjImIRoRGIgHveP/Q==
X-Received: by 2002:a17:902:c40a:b0:1c7:5a63:43bb with SMTP id k10-20020a170902c40a00b001c75a6343bbmr3958783plk.8.1696441403646;
        Wed, 04 Oct 2023 10:43:23 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:969d:167a:787c:a6c7? ([2620:15c:211:201:969d:167a:787c:a6c7])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b001c74df14e72sm3981235plb.212.2023.10.04.10.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 10:43:23 -0700 (PDT)
Message-ID: <552f2342-e800-43bc-b859-d73297ce940f@acm.org>
Date:   Wed, 4 Oct 2023 10:43:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Content-Language: en-US
To:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        matsuda-daisuke@fujitsu.com, shinichiro.kawasaki@wdc.com,
        linux-scsi@vger.kernel.org, Zhu Yanjun <yanjun.zhu@intel.com>
References: <20230922163231.2237811-1-yanjun.zhu@intel.com>
 <169572143704.2702191.3921040309512111011.b4-ty@kernel.org>
 <20230926140656.GM1642130@unreal>
 <d3c05064-a88b-4719-a390-6bf9ae01fba5@acm.org>
 <b7b365e3-dd11-bc66-dace-05478766bf41@gmail.com>
 <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
 <2fcef3c8-808e-8e6a-b23d-9f1b3f98c1f9@linux.dev>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2fcef3c8-808e-8e6a-b23d-9f1b3f98c1f9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/3/23 20:41, Zhu Yanjun wrote:
> 在 2023/9/27 4:24, Bart Van Assche 写道:
>> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c 
>> b/drivers/infiniband/sw/rxe/rxe_task.c
>> index 1501120d4f52..6cd5d5a7a316 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_task.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
>> @@ -10,7 +10,7 @@ static struct workqueue_struct *rxe_wq;
>>
>>   int rxe_alloc_wq(void)
>>   {
>> -       rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
>> +       rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, 1);
>>          if (!rxe_wq)
>>                  return -ENOMEM;
> 
> Hi, Bart
> 
> With the above commit, I still found a similar problem. But the problem 
> occurs very rarely. With the following, to now, the problem does not occur.
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c 
> b/drivers/infiniband/sw/rxe/rxe_task.c
> index 1501120d4f52..3189c3705295 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -10,7 +10,7 @@ static struct workqueue_struct *rxe_wq;
> 
>   int rxe_alloc_wq(void)
>   {
> -       rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
> +       rxe_wq = alloc_workqueue("rxe_wq", WQ_HIGHPRI | WQ_UNBOUND, 1);
>          if (!rxe_wq)
>                  return -ENOMEM;
> 
> 
> And with the tasklet, this problem also does not occur.
> 
> With "alloc_workqueue("rxe_wq", WQ_HIGHPRI | WQ_UNBOUND, 1);", an 
> ordered workqueue with high priority is allocated.
> 
> To the same number of work item, the ordered workqueue has the same 
> runing time with the tasklet. But the tasklet is based on softirq. Its 
> overhead on scheduling is less than workqueue. So in theory, tasklet's 
> performance should be better than the ordered workqueue.

Hi Zhu,

Thank you for having reported this. I'm OK with integrating the above 
change in my patch. However, code changes must be motivated. Do you 
perhaps have an explanation of why WQ_HIGHPRI makes the issue disappear 
that you observed?

Regarding tasklets: tasklets are a nightmare from the point of view of
the Linux kernel scheduler. As an example, these may make it impossible
for the scheduler to schedule real-time threads in time.

Thanks,

Bart.

