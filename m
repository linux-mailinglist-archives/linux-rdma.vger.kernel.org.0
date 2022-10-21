Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE24606E5A
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 05:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJUDkL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Oct 2022 23:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJUDkI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Oct 2022 23:40:08 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDDF57543
        for <linux-rdma@vger.kernel.org>; Thu, 20 Oct 2022 20:40:04 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id y67so1913297oiy.1
        for <linux-rdma@vger.kernel.org>; Thu, 20 Oct 2022 20:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=51MoTd+JXs341nlXZS4lK1bwIfUO9xNsfHcl5t1RX8E=;
        b=TKxry/p09n3xwjQQ75Am6jSvwTrGAWspzwbDqDD2vAXEp+c59uxxiVaxAx5ncIDF5n
         1zOssaSPJ52tYNT3rWjPL/7QSP3p3F8+FqyFRsEuMd5HSYaGo6ooaBxXUzLSdCyFuKyk
         4FQyEfUSJPT5yJ4yWTZIKUlpGLPPUMai3SDVbsee2+InVJjVPFgsNU7/J18NrsoieA14
         FmK6rZ1jdJxE8DeetdmBsX2L5zBY2ypPQmYNESxcEYYiSrUFCYdpQf0EwWDeok98bJQw
         tO3QRZaJdwYS2xAlKyU0EQIdagmbVW+QQx/TDcrgu17ABchxeUx2phowe3x9j9sljGYh
         gO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51MoTd+JXs341nlXZS4lK1bwIfUO9xNsfHcl5t1RX8E=;
        b=l7sr2EQfDw0Te5SoyDmnRhZjHninxNtnBKEp2Z1jCtyPjHGzJcj7Atb1nAlhRwRceW
         q846cS7KxyD9g+TOEzKCLTo0Jf8Ll6RE8CJ4qhVkINQNjfJPa3QUb+d2HiT1dNiOwxhX
         Xzth2hq7dzhilmGEkiDaMqh8l+g3zQhTymuj1Tazww6P6LmjKbZDu4fh5nz7bgbuMNr/
         nEnrjprmZ/2Kj6917ts2PcXH826XyKMOZT63C5BWzWGNWkRHK8ES6zXisG46oInfwJgM
         52gnqfjbRbrkKKmRT3koKApZOZWl77vcQn84oK2y9ICF93o5Q0NnkD39yrpHskFX7HLh
         QPBg==
X-Gm-Message-State: ACrzQf208xwSc6a0OxoyEM82hGQMyBbWPLX2YJQTRYYYuGXKH+pp3of/
        o3ZJlZ/2744KdGwDJupprK8eOWlxLu3zgw==
X-Google-Smtp-Source: AMsMyM5tSW4+B7NOV7j1jEIDC1r3VjNKjCiwj8CHy/dBD33g5o6TOg952SiiuMLz1OUwpyzqPijX+Q==
X-Received: by 2002:a05:6808:603:b0:354:948f:f045 with SMTP id y3-20020a056808060300b00354948ff045mr23031554oih.268.1666323603900;
        Thu, 20 Oct 2022 20:40:03 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:6dfb:79f8:bd:7aa5? (2603-8081-140c-1a00-6dfb-79f8-00bd-7aa5.res6.spectrum.com. [2603:8081:140c:1a00:6dfb:79f8:bd:7aa5])
        by smtp.gmail.com with ESMTPSA id 42-20020a9d02ad000000b0066194e0e1casm598183otl.75.2022.10.20.20.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 20:40:03 -0700 (PDT)
Message-ID: <0131622f-aa8b-fba8-adb2-2480656a3e76@gmail.com>
Date:   Thu, 20 Oct 2022 22:40:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH for-next 00/16] Implement work queues for rdma_rxe
Content-Language: en-US
To:     "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>,
        'haris iqbal' <haris.phnx@gmail.com>
Cc:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jenny.hack@hpe.com" <jenny.hack@hpe.com>,
        "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>
References: <20221018043345.4033-1-rpearsonhpe@gmail.com>
 <CAE_WKMz8kTWY_-BCheuqj+szpS9rkSrE+NFGLa-0-WXcKr5Sug@mail.gmail.com>
 <OSZPR01MB845136BC247B6D253E070457E52D9@OSZPR01MB8451.jpnprd01.prod.outlook.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <OSZPR01MB845136BC247B6D253E070457E52D9@OSZPR01MB8451.jpnprd01.prod.outlook.com>
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

On 10/20/22 21:46, matsuda-daisuke@fujitsu.com wrote:
> On Fri, Oct 21, 2022 12:02 AM haris Iqbal wrote:
>>
>> On Tue, Oct 18, 2022 at 6:39 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>
>>> This patch series implements work queues as an alternative for
>>> the main tasklets in the rdma_rxe driver. The first few patches
>>> perform some cleanups of the current tasklet code followed by a
>>> patch that makes the internal API for task execution pluggable and
>>> implements an inline and a tasklet based set of functions.
>>> The remaining patches cleanup the qp reset and error code in the
>>> three tasklets and modify the locking logic to prevent making
>>> multiple calls to the tasklet scheduling routine. Finally after
>>> this preparation the work queue equivalent set of functions is
>>> added and module parameters are implemented to allow tuning the
>>> task types.
>>>
>>> The advantages of the work queue version of deferred task execution
>>> is mainly that the work queue variant has much better scalability
>>> and overall performance than the tasklet variant. The tasklet
>>> performance saturates with one connected queue pair and stays constant.
>>> The work queue performance is slightly better for one queue pair but
>>> scales up with the number of connected queue pairs. The perftest
>>> microbenchmarks in local loopback mode (not a very realistic test
>>> case) can reach approximately 100Gb/sec with work queues compared to
>>> about 16Gb/sec for tasklets.
>>>
>>> This patch series is derived from an earlier patch set developed by
>>> Ian Ziemba at HPE which is used in some Lustre storage clients attached
>>> to Lustre servers with hard RoCE v2 NICs.
>>>
>>> Bob Pearson (16):
>>>   RDMA/rxe: Remove init of task locks from rxe_qp.c
>>>   RDMA/rxe: Removed unused name from rxe_task struct
>>>   RDMA/rxe: Split rxe_run_task() into two subroutines
>>>   RDMA/rxe: Make rxe_do_task static
>>>   RDMA/rxe: Rename task->state_lock to task->lock
>>>   RDMA/rxe: Make task interface pluggable
>>>   RDMA/rxe: Simplify reset state handling in rxe_resp.c
>>>   RDMA/rxe: Split rxe_drain_resp_pkts()
>>>   RDMA/rxe: Handle qp error in rxe_resp.c
>>>   RDMA/rxe: Cleanup comp tasks in rxe_qp.c
>>>   RDMA/rxe: Remove __rxe_do_task()
>>>   RDMA/rxe: Make tasks schedule each other
>>>   RDMA/rxe: Implement disable/enable_task()
>>>   RDMA/rxe: Replace TASK_STATE_START by TASK_STATE_IDLE
>>>   RDMA/rxe: Add workqueue support for tasks
>>>   RDMA/rxe: Add parameters to control task type
>>>
>>>  drivers/infiniband/sw/rxe/rxe.c       |   9 +-
>>>  drivers/infiniband/sw/rxe/rxe_comp.c  |  35 ++-
>>>  drivers/infiniband/sw/rxe/rxe_net.c   |   4 +-
>>>  drivers/infiniband/sw/rxe/rxe_qp.c    |  87 +++----
>>>  drivers/infiniband/sw/rxe/rxe_req.c   |  10 +-
>>>  drivers/infiniband/sw/rxe/rxe_resp.c  |  75 ++++--
>>>  drivers/infiniband/sw/rxe/rxe_task.c  | 354 ++++++++++++++++++++------
>>>  drivers/infiniband/sw/rxe/rxe_task.h  |  76 +++---
>>>  drivers/infiniband/sw/rxe/rxe_verbs.c |   8 +-
>>>  9 files changed, 451 insertions(+), 207 deletions(-)
>>>
>>>
>>> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
>>
>> The patch series is not applying cleanly over the mentioned commit for
>> me. Patch 'PATCH for-next 05/16] RDMA/rxe: Rename task->state_lock to
>> task->lock.' fails at "drivers/infiniband/sw/rxe/rxe_task.c:103".
>> I corrected that manually, then it fails in the next commit. Didn't
>> check after that. Is it the same for others or is it just me?
> 
> There is a problem with the 4th patch. Its subject is different from other patches,
> so probably it was not generated at the same time with them. I could apply the rest
> after adding the following change to the 4th:
> ===

I messed up the subject and resent it just after the other ones.

> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> index 097ddb16c230..a7203b93e5cc 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -28,7 +28,7 @@ int __rxe_do_task(struct rxe_task *task)
>   * a second caller finds the task already running
>   * but looks just after the last call to func
>   */
> -static void rxe_do_task(struct tasklet_struct *t)
> +static void do_task(struct tasklet_struct *t)
>  {
>         int cont;
>         int ret;
> @@ -100,7 +100,7 @@ int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *))
>         task->func      = func;
>         task->destroyed = false;
> 
> -       tasklet_setup(&task->tasklet, rxe_do_task);
> +       tasklet_setup(&task->tasklet, do_task);
> 
>         task->state = TASK_STATE_START;
>         spin_lock_init(&task->state_lock);
> @@ -132,7 +132,7 @@ void rxe_run_task(struct rxe_task *task)
>         if (task->destroyed)
>                 return;
> 
> -       rxe_do_task(&task->tasklet);
> +       do_task(&task->tasklet);
>  }
> 
>  void rxe_sched_task(struct rxe_task *task)
> ===
> 
> Daisuke
> 
>>
>>> --
>>> 2.34.1
>>>

