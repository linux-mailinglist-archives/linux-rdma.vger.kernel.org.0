Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F89A7071E4
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 21:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjEQTUy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 May 2023 15:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjEQTUx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 May 2023 15:20:53 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06B883
        for <linux-rdma@vger.kernel.org>; Wed, 17 May 2023 12:20:52 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-38eda4ef362so754140b6e.2
        for <linux-rdma@vger.kernel.org>; Wed, 17 May 2023 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684351252; x=1686943252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ilba/k+nMUboPFIaqNuO+5G//5/8Xul3qY+cFE1P81k=;
        b=WgsovN85Hpfvaa+pfPCK9Uq0juf4O0hbuj2sFFe+DL85fawXpc8jn0++/zKgcE/lNW
         xi77V1UoGTDW+9wKgHSNC7KoXJiY9OlcXHO1jd7K02KRE4zVGSRwRhfOw+oOdd7eLVUj
         z41dmHqSqkL35bXnN+ZFdI2MS5I+adxE9Ru19vMYVJGzzyeaGY4wE47dakUi88gw7NTz
         NinDZn237j+K9fFU7pAuk9TKPUsSyHQh+f+J1hFQwJqZE1+SBg+vDgOLFD+IRUHovUmR
         oBrBNXGMC5E3SPCvaSQkHow5P4f1CXmVsd742t7w6dWzkRpRwAEtXRg7RPETdHeFnI+F
         15Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684351252; x=1686943252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilba/k+nMUboPFIaqNuO+5G//5/8Xul3qY+cFE1P81k=;
        b=Ti7E7AuQ3mSvBUfybZuj4w3VaWcD2er/dyoayyGqqnK+5/jPqa8gu0NHfuvuozfdQO
         ey0AuAipiwjLRm4L+fv6RPWJPNM5TxZOlEmOCKhkdm3caofWNbk3g8M9x708kjKn9sNf
         rYceDRSTtMFFwIYxof141k1yd8xuZQ7Ml/L+wjhoVFEvLu05BjrQB8S5X4i9Oxsg0kSg
         iJ0lAd+uKZFm6yNaMoGxkpuvy4pixvNEfdyNKANtWaXgscnc6DZ3BI5czFRW9px9jMoD
         Z0CIStes4uConagvJL6gfSrN65uVrJ9Whur1FmiDUmrMiun0PeUjM54EFQWHfAw1yd87
         tbNw==
X-Gm-Message-State: AC+VfDyj4t/iAuqPvC2hsU1M4EWjeBsS5g0Jm5uL9O5lwgV5dPYi0Orp
        X4Z0nnwqtRMzc7VigmwGI4g=
X-Google-Smtp-Source: ACHHUZ7gQqk/1oPp/41ZPZ6J6iu3MduDXqbI+PJPYXVW0N7DDwyHTT12XHd9D6KDmk8cDT2eDnAOUw==
X-Received: by 2002:a05:6808:2209:b0:394:c7bd:19dc with SMTP id bd9-20020a056808220900b00394c7bd19dcmr13243054oib.48.1684351252115;
        Wed, 17 May 2023 12:20:52 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e2d1:92d9:dfd0:d039? (2603-8081-140c-1a00-e2d1-92d9-dfd0-d039.res6.spectrum.com. [2603:8081:140c:1a00:e2d1:92d9:dfd0:d039])
        by smtp.gmail.com with ESMTPSA id y16-20020a4ade10000000b005251f71250dsm7423873oot.37.2023.05.17.12.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 12:20:51 -0700 (PDT)
Message-ID: <6e94fba4-106c-1cfc-6ede-ae65623e922f@gmail.com>
Date:   Wed, 17 May 2023 14:20:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 for-next] RDMA/rxe: Add workqueue support for tasks
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     matsuda-daisuke@fujitsu.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, Ian Ziemba <ian.ziemba@hpe.com>
References: <20230428171321.5774-1-rpearsonhpe@gmail.com>
 <ZGUfHp6+RF5iO2O8@nvidia.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZGUfHp6+RF5iO2O8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/17/23 13:38, Jason Gunthorpe wrote:
> On Fri, Apr 28, 2023 at 12:13:22PM -0500, Bob Pearson wrote:
>> Replace tasklets by work queues for the three main rxe tasklets:
>> rxe_requester, rxe_completer and rxe_responder.
>>
>> Rebased to current for-next branch with changes, below, applied.
>>
>> Link: https://lore.kernel.org/linux-rdma/20230329193308.7489-1-rpearsonhpe@gmail.com/
>> Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
>> Tested-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
>> ---
>> v8:
>>   Corrected a soft cpu lockup by testing return value from task->func
>>   for all task states.
>>   Removed WQ_CPU_INTENSIVE flag from alloc_workqueue() since documentation
>>   shows that this has no effect if WQ_UNBOUND is set.
>>   Removed work_pending() call in __reserve_if_idle() since by design
>>   a task cannot be pending and idle at the same time.
>>   Renamed __do_task() to do_work() per a comment by Diasuke Matsuda.
>> v7:
>>   Adjusted so patch applies after changes to rxe_task.c.
>> v6:
>>   Fixed left over references to tasklets in the comments.
>>   Added WQ_UNBOUND to the parameters for alloc_workqueue(). This shows
>>   a significant performance improvement.
>> v5:
>>   Based on corrected task logic for tasklets and simplified to only
>>   convert from tasklets to workqueues and not provide a flexible
>>   interface.
>> ---
>>  drivers/infiniband/sw/rxe/rxe.c      |   9 ++-
>>  drivers/infiniband/sw/rxe/rxe_task.c | 108 +++++++++++++++------------
>>  drivers/infiniband/sw/rxe/rxe_task.h |   6 +-
>>  3 files changed, 75 insertions(+), 48 deletions(-)
> 
> Applied to for-next, thanks
> 
> Jason
Thanks!!

Bob
