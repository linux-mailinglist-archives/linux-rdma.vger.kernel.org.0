Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0A5606FC4
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 08:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJUGCj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 02:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJUGCi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 02:02:38 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAD92347BE
        for <linux-rdma@vger.kernel.org>; Thu, 20 Oct 2022 23:02:36 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id p24-20020a9d6958000000b00661c528849eso1216600oto.9
        for <linux-rdma@vger.kernel.org>; Thu, 20 Oct 2022 23:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMfNveDa/y2Cv+o0kmPrXzbBpr9iL/WIY+LEU2FX5Jo=;
        b=UID6ZjAqNSsYc+QG76Rkobjyr2fd/SI9RL4/r1DSfN1YAZfLMKNMHdGiNIqYBrWkoI
         HTzgynnVuYX1tnTa56bYuO8JPOx7LP0fJXcSuDgFwZZHtU9aVkDW+Rf6Kwy+tQ/6sLnd
         oam1kXDrBQGhUGGdKBpW72xMQqXqAdFaX4///s3AXollbkxmkSgngXxnpqSDa1LY9JHo
         91LeqJa+NAc3Ros5/UaK+KYVKvO7DRRrNQf5AfwdeE9C49c2kqUjDnKQvbvtgeJwAX8v
         L15L20X8oVa0qEoFGGLJKjxa5M3wWh1f5JpGFqK6RzddFs0em9JEnl/7ainAnmWvop8K
         fnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMfNveDa/y2Cv+o0kmPrXzbBpr9iL/WIY+LEU2FX5Jo=;
        b=hJTCwEe1JSBT/GsBFEnvmdPb31JP4s4BHUBrP+Oa4IFUSQujHhqWBeK8Vag/1sHD8b
         peg77N/fueSmXUBecceyqjX+aN2TSS80lv0hYnPRHU+layvf5bhmx1SIEPkXBONCJvzi
         b2WlM35eF7AWCheojjxQ4wR6fF1GPjTyspEdnUevx6b4frxRYI77x0A7TOnwX12zVan3
         2vSCa9Yhjv5VtYzfJfe42r+YlS5hCFqzrzqIuZr2LsLR2JFqNwjAa1H/6DPah1pO8L9G
         lC/KseZAQA3brhXHVaq1hlf8AmytZWEW9vCVsxBJVD+4CHK8/YdIseRYfIjxY4iq2B+7
         gBZQ==
X-Gm-Message-State: ACrzQf1rHRhIXDSPgG2WJM1JNh4YLHhMyxwIxK5JfMWkjCD1idcftPtE
        k3DRBn4xvGzm5lgdgsLOY0Spluy6do8Rtw==
X-Google-Smtp-Source: AMsMyM504+Wam4zmsNhuzcz9UvLM2S7YDK9nIlr9znfPcw+iS0Ce7fB+nWzamognz0TrWuhacYF/pQ==
X-Received: by 2002:a9d:4e7:0:b0:65b:e537:5a75 with SMTP id 94-20020a9d04e7000000b0065be5375a75mr8853168otm.138.1666332156078;
        Thu, 20 Oct 2022 23:02:36 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:6dfb:79f8:bd:7aa5? (2603-8081-140c-1a00-6dfb-79f8-00bd-7aa5.res6.spectrum.com. [2603:8081:140c:1a00:6dfb:79f8:bd:7aa5])
        by smtp.gmail.com with ESMTPSA id e2-20020a05680809a200b00350a8b0637asm740498oig.47.2022.10.20.23.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 23:02:35 -0700 (PDT)
Message-ID: <c149759d-5cee-5447-c00e-ea38a6951e84@gmail.com>
Date:   Fri, 21 Oct 2022 01:02:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH for-next 00/16] Implement work queues for rdma_rxe
Content-Language: en-US
To:     haris iqbal <haris.phnx@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
References: <20221018043345.4033-1-rpearsonhpe@gmail.com>
 <CAE_WKMz8kTWY_-BCheuqj+szpS9rkSrE+NFGLa-0-WXcKr5Sug@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAE_WKMz8kTWY_-BCheuqj+szpS9rkSrE+NFGLa-0-WXcKr5Sug@mail.gmail.com>
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

On 10/20/22 10:02, haris iqbal wrote:
> On Tue, Oct 18, 2022 at 6:39 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> This patch series implements work queues as an alternative for
>> the main tasklets in the rdma_rxe driver. The first few patches
>> perform some cleanups of the current tasklet code followed by a
>> patch that makes the internal API for task execution pluggable and
>> implements an inline and a tasklet based set of functions.
>> The remaining patches cleanup the qp reset and error code in the
>> three tasklets and modify the locking logic to prevent making
>> multiple calls to the tasklet scheduling routine. Finally after
>> this preparation the work queue equivalent set of functions is
>> added and module parameters are implemented to allow tuning the
>> task types.
>>
>> The advantages of the work queue version of deferred task execution
>> is mainly that the work queue variant has much better scalability
>> and overall performance than the tasklet variant. The tasklet
>> performance saturates with one connected queue pair and stays constant.
>> The work queue performance is slightly better for one queue pair but
>> scales up with the number of connected queue pairs. The perftest
>> microbenchmarks in local loopback mode (not a very realistic test
>> case) can reach approximately 100Gb/sec with work queues compared to
>> about 16Gb/sec for tasklets.
>>
>> This patch series is derived from an earlier patch set developed by
>> Ian Ziemba at HPE which is used in some Lustre storage clients attached
>> to Lustre servers with hard RoCE v2 NICs.
>>
>> Bob Pearson (16):
>>   RDMA/rxe: Remove init of task locks from rxe_qp.c
>>   RDMA/rxe: Removed unused name from rxe_task struct
>>   RDMA/rxe: Split rxe_run_task() into two subroutines
>>   RDMA/rxe: Make rxe_do_task static
>>   RDMA/rxe: Rename task->state_lock to task->lock
>>   RDMA/rxe: Make task interface pluggable
>>   RDMA/rxe: Simplify reset state handling in rxe_resp.c
>>   RDMA/rxe: Split rxe_drain_resp_pkts()
>>   RDMA/rxe: Handle qp error in rxe_resp.c
>>   RDMA/rxe: Cleanup comp tasks in rxe_qp.c
>>   RDMA/rxe: Remove __rxe_do_task()
>>   RDMA/rxe: Make tasks schedule each other
>>   RDMA/rxe: Implement disable/enable_task()
>>   RDMA/rxe: Replace TASK_STATE_START by TASK_STATE_IDLE
>>   RDMA/rxe: Add workqueue support for tasks
>>   RDMA/rxe: Add parameters to control task type
>>
>>  drivers/infiniband/sw/rxe/rxe.c       |   9 +-
>>  drivers/infiniband/sw/rxe/rxe_comp.c  |  35 ++-
>>  drivers/infiniband/sw/rxe/rxe_net.c   |   4 +-
>>  drivers/infiniband/sw/rxe/rxe_qp.c    |  87 +++----
>>  drivers/infiniband/sw/rxe/rxe_req.c   |  10 +-
>>  drivers/infiniband/sw/rxe/rxe_resp.c  |  75 ++++--
>>  drivers/infiniband/sw/rxe/rxe_task.c  | 354 ++++++++++++++++++++------
>>  drivers/infiniband/sw/rxe/rxe_task.h  |  76 +++---
>>  drivers/infiniband/sw/rxe/rxe_verbs.c |   8 +-
>>  9 files changed, 451 insertions(+), 207 deletions(-)
>>
>>
>> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
> 
> The patch series is not applying cleanly over the mentioned commit for
> me. Patch 'PATCH for-next 05/16] RDMA/rxe: Rename task->state_lock to
> task->lock.' fails at "drivers/infiniband/sw/rxe/rxe_task.c:103".
> I corrected that manually, then it fails in the next commit. Didn't
> check after that. Is it the same for others or is it just me?
> 
>> --
>> 2.34.1
>>

This worked for me. There was the botched 4/16 which I resent just after the other ones.
You may need to delete the first 4/16 and use the second one. I am going to resend it
tomorrow. There are a couple of things folks have pointed out that I want to address.

Bob
