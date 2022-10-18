Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C83D602F77
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 17:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJRPSQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 11:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJRPSQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 11:18:16 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349859AC2C
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 08:18:15 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso7797835otb.6
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 08:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cH1rJdQN2/54ci0CZHsjNF2d5JHGV/6Na/lvI7+2M1s=;
        b=GeDooyH2FXOAZjZrxSR5D2mBZ0HCTqjIGs9XI//m8AVsn238CWViqKsTzXq2ysHa5f
         Q1iP94W/m93S3YrK1vZm1SFzrc/H+/aIEYjdUkDMzwPO7Y6zhie5BuBSglK7VIGhPheU
         DY4v9wn7+uqhMei8aASkrExiYlp8+CvzMYieeKYJf5cj8uipNLa6wNZKGmx0scVuT4fS
         hNTptDsPlkitlU3MMJot2FRR77vy/q7C9zpT8eMXtQ0OVMfjof/LIplu/0AyfXkcON57
         kiZoJFX1zAJ8qxfgixhYYvYMrScUWWgcCoB4pHll2tRAF9aYipHIBsY/HRVUMaBfhEjC
         tOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cH1rJdQN2/54ci0CZHsjNF2d5JHGV/6Na/lvI7+2M1s=;
        b=jMb9VIzV42l8OdgHPC/SKYk7J7SwVAGE5LBv2F10EfxKPt6CuE3i7aei8MRhyyupcj
         /2z9C6+ejhvp07kk4qkgll+bnLqAh+AFlpJmHzH40LywuBz8QPG6do5tUUQYsezaIiW2
         OiI0FbjXp3/46ELCr1Iirfq4QDKsOTJMUFyGry5D7qbTqAVX4JKQHZ3SpBZ7gVrDVIvG
         b737kMdG25XOlEIfs7buAdhA4eQZOw4l0G1sEy0R8LFXSxjYsiS71+efq9NTn5rLf9Ud
         CP1YRqWqNrDI+sgLbhOMsVF0t9ZvMpwLwyTmjaxNGEZh7BXPqCZwy738Nqq+dV2Ig1wD
         V1/Q==
X-Gm-Message-State: ACrzQf0DvQ3ORMP0mmPfI7fYvM0dqHV9T+UHc4FflRCwiPvNWe6uSJ9P
        72hyz4e4EQhCBHJNAcSlLjY=
X-Google-Smtp-Source: AMsMyM4E/769F870hd/auIiWkskV/B6bfgR4Oc4/g25XJavi9ZTNYZBKhHGZvyq5G5d/GC8QM9LyuA==
X-Received: by 2002:a9d:7012:0:b0:661:9481:7ac4 with SMTP id k18-20020a9d7012000000b0066194817ac4mr1544087otj.135.1666106294541;
        Tue, 18 Oct 2022 08:18:14 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:c2cf:2de0:3c3c:e52c? (2603-8081-140c-1a00-c2cf-2de0-3c3c-e52c.res6.spectrum.com. [2603:8081:140c:1a00:c2cf:2de0:3c3c:e52c])
        by smtp.gmail.com with ESMTPSA id h7-20020a9d61c7000000b00661c3846b4csm6069385otk.27.2022.10.18.08.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 08:18:14 -0700 (PDT)
Message-ID: <0d612d5f-8faa-0e65-a820-ffaf886b32ca@gmail.com>
Date:   Tue, 18 Oct 2022 10:18:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH for-next 15/16] RDMA/rxe: Add workqueue support for tasks
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
References: <20221018043345.4033-1-rpearsonhpe@gmail.com>
 <20221018043345.4033-16-rpearsonhpe@gmail.com> <Y05rCgMya/D7VBV9@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y05rCgMya/D7VBV9@unreal>
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

On 10/18/22 03:59, Leon Romanovsky wrote:
> On Mon, Oct 17, 2022 at 11:33:46PM -0500, Bob Pearson wrote:
>> Add a third task type RXE_TASK_TYPE_WORKQUEUE to rxe_task.c.
> 
> Why do you need an extra type and not instead of RXE_TASK_TYPE_TASKLET?

It performs much better in some settings.
> 
>>
>> Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe.c      |  9 ++-
>>  drivers/infiniband/sw/rxe/rxe_task.c | 84 ++++++++++++++++++++++++++++
>>  drivers/infiniband/sw/rxe/rxe_task.h | 10 +++-
>>  3 files changed, 101 insertions(+), 2 deletions(-)
> 
> <...>
> 
>> +static struct workqueue_struct *rxe_wq;
>> +
>> +int rxe_alloc_wq(void)
>> +{
>> +	rxe_wq = alloc_workqueue("rxe_wq", WQ_MEM_RECLAIM |
>> +				WQ_HIGHPRI | WQ_CPU_INTENSIVE |
>> +				WQ_SYSFS, WQ_MAX_ACTIVE);
> 
> Are you sure that all these flags can be justified? WQ_MEM_RECLAIM?

Not really. CPU intensive is most likely correct. The rest not so much.
> 
>> +
>> +	if (!rxe_wq)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
> 
> <...>
> 
>> +static void work_sched(struct rxe_task *task)
>> +{
>> +	if (!task->valid)
>> +		return;
>> +
>> +	queue_work(rxe_wq, &task->work);
>> +}
>> +
>> +static void work_do_task(struct work_struct *work)
>> +{
>> +	struct rxe_task *task = container_of(work, typeof(*task), work);
>> +
>> +	if (!task->valid)
>> +		return;
> 
> How can it be that submitted task is not valid? Especially without any
> locking.

This and a similar subroutine for tasklets are called deferred and can have a significant
delay before being called. In the mean time someone could have tried to destroy the QP. The valid
flag is only cleared by QP destroy code and is not turned back on. Perhaps a rmb().
> 
>> +
>> +	do_task(task);
>> +}
> 
> Thanks
> 
>> +

