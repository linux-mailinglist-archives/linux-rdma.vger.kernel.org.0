Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98606D68F8
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Apr 2023 18:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjDDQgE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Apr 2023 12:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjDDQgD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Apr 2023 12:36:03 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BCF3C15
        for <linux-rdma@vger.kernel.org>; Tue,  4 Apr 2023 09:36:02 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id bl22so10647141oib.11
        for <linux-rdma@vger.kernel.org>; Tue, 04 Apr 2023 09:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680626161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAEzRHnBs+hyoqf2APhp7UDPIt8emIYqAQVQYx2SWks=;
        b=bGTpU/AbszlBhHWs7K9hMcvxRYI+u81EmQy7obIMD5Q3GAaLJkQ0c1PeVipEz+NJ8V
         ynZWZaCSU89fsahutwOy264MCMiAh5L6MXqNUAwZTmTGNNvI+ijA0Nkf0DK+P8kPtu41
         99Wn4W9d1S28JKVhuNCUxsa2cXrmFW81gWBF6IWX96RbY7wTzXwBESwrNYrXhdf4MESD
         vtwWX5lhxFqCHqc714z9ABk2IekxbjQa98UhZUnjP79Y3kK4vdTM0mtB0saCXNk/62Lt
         +tPjDsCcJIIhxZmDA4SeM+I9RIdjlfrcdf+b6giBwwwoHZhV9Jqg+lYKgJI14ECZyQiM
         9qzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680626161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAEzRHnBs+hyoqf2APhp7UDPIt8emIYqAQVQYx2SWks=;
        b=HnEDOV9tGEkFSOEZy6rPCxp4RGagiKgY2H+6OzGDhLrdUVW8lEKLtQmhDcpQoskUKJ
         dNh+SxXzRkLDlU9TTm3jn6ia3+DWCzSo1YQbaJMY0wC2oknBfDQGfG4Rw+GyCNFQehP5
         FippKHJa1cG6Lka6y7diyGWSL6vEKaHmu9M7h4iVX7fLyrFv+B1HTzqTNh7RRKdBCui7
         hs9w9xGdi60kfpUGb3/7GPeq2OeewTAAwl46WDMHqMc2uUFtBCW8HVceCJU0Z3mz9oqN
         BjSWNjA1NplHlywTQYFZJCDfhzXES8+VmXPH8IuadyQA8g61a/uUK/0K4n2qBd/Npf7v
         B7Cw==
X-Gm-Message-State: AAQBX9fW7qb3JFO8Tt/aXtnFccdJx1V9jQaN3AybteLpEhByg+pF7XUY
        ic26pKapah85wjXInscznjc=
X-Google-Smtp-Source: AKy350aftWmDqXPna2CrDI4hggmvYou3zF4GWHQnnDK2o0f3sdpXtDN0m2D5ZRMJNr8dz7vI/+/iMQ==
X-Received: by 2002:a54:488f:0:b0:389:5351:a170 with SMTP id r15-20020a54488f000000b003895351a170mr1653111oic.21.1680626161513;
        Tue, 04 Apr 2023 09:36:01 -0700 (PDT)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id n6-20020a4a4006000000b0052a77e38722sm5606514ooa.26.2023.04.04.09.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 09:36:01 -0700 (PDT)
Message-ID: <a74126b4-b527-af72-f23e-c9d6711e5285@gmail.com>
Date:   Tue, 4 Apr 2023 11:36:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] RDMA/rxe: Fix error in rxe_task.c
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     error27@gmail.com, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
References: <20230329193308.7489-1-rpearsonhpe@gmail.com>
 <727cd25c-7d8f-73d0-8867-836da29c54b2@gmail.com>
 <20230404045850.GE4514@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230404045850.GE4514@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/3/23 23:58, Leon Romanovsky wrote:
> On Mon, Apr 03, 2023 at 03:38:13PM -0500, Bob Pearson wrote:
>> On 3/29/23 14:33, Bob Pearson wrote:
>>> In a previous patch TASKLET_STATE_SCHED was used as a bit but it
>>> is a bit position instead. This patch corrects that error.
>>>
>>> Reported-by: Dan Carpenter <error27@gmail.com>
>>> Link: https://lore.kernel.org/linux-rdma/8a054b78-6d50-4bc6-8d8a-83f85fbdb82f@kili.mountain/
>>> Fixes: d94671632572 ("RDMA/rxe: Rewrite rxe_task.c")
>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>> ---
>>>  drivers/infiniband/sw/rxe/rxe_task.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
>>> index fea9a517c8d9..fb9a6bc8e620 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_task.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
>>> @@ -21,7 +21,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
>>>  {
>>>  	WARN_ON(rxe_read(task->qp) <= 0);
>>>  
>>> -	if (task->tasklet.state & TASKLET_STATE_SCHED)
>>> +	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
>>>  		return false;
>>>  
>>>  	if (task->state == TASK_STATE_IDLE) {
>>> @@ -46,7 +46,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
>>>   */
>>>  static bool __is_done(struct rxe_task *task)
>>>  {
>>> -	if (task->tasklet.state & TASKLET_STATE_SCHED)
>>> +	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
>>>  		return false;
>>>  
>>>  	if (task->state == TASK_STATE_IDLE ||
>>
>> This patch fixes a bug in rxe_task.c introduced by the earlier patch (d94671632572 RDMA/rxe: Rewrite rxe_task.c)
>> which is in for-next. The bug actually has minimal effects because TASKLET_STATE_SCHED is zero and in testing
>> so far it doesn't seem to make a difference.
>>
>> There is a second patch currently in patchworks ([for-next,v6] RDMA/rxe: Add workqueue support for tasks
>> [for-next,v6] RDMA/rxe: Add workqueue support for tasks 	- - - 	--- 	2023-03-02 	Bob Pearson New)
>> which is ahead of this one and replaces the tasklet implementation by work queues. This second patch replaces the
>> lines lines containing the error with a workqueue specific equivalent.
>>
>> There are two ways forward here. We could fix the tasklet version by applying this patch first or ignore the
>> error and apply the workqueue patch first. My desire is to get rid of tasklets altogether so I prefer the
>> second choice. If we choose the first choice then we need to reorder the two patches in patchworks and
>> rebase the workqueue patch to match the fixed tasklet code.
>>
>> Please suggest how you would like me to proceed.
> 
> I prefer to have small fix first as it is unclear when "RDMA/rxe: Add workqueue support for tasks"
> will be merged.
> https://lore.kernel.org/all/20230330053933.GJ831478@unreal
> 
> Thanks
> 
>>
>> Bob

Leon,

Then drop the workqueue patch and apply the fix rxe_task.c patch and I will resubmit the workqueue patch.

Thanks

Bob
