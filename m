Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE14E6CF2C6
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 21:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjC2TJV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 15:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjC2TJU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 15:09:20 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2807FCD
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 12:09:19 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id m6-20020a4ae846000000b0053b9059edd5so2603244oom.3
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 12:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680116958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iTRImo5FJXrdtvjFg6pDeFus6BeQJR21d5ZrCiNDziU=;
        b=XhBzeHqUwmzCGKMpRHKbEWiAsUAO+ENUWLySfDhHetcMoAFE2C1zvxZlBlGL4apiqI
         m4U2tdp+zO2CjuB4GXrifWMl/Rm5gAQL/xN/YJKvOCcB3DPVtKXWkguscLf+DWncEeYI
         mR9yYFF1GTcmbHiCwCctL09HFoo1gdXShoetBMMWTOHdp9JXWhEHfb3Y6tgaKc793QhM
         u99SqMIi4F7fYjCd6EbWRfm/B9gMgiZa+McpG11eDVsz/EGLJ+KpKjdzGo9O5t2VymXL
         AVzPnFZzkF+dKjUlwxO0xMiWeflrhKDaUBmSyFpyXNo9ABmAp5q1Yp/opOrOgyzFi+xk
         +KMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680116958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTRImo5FJXrdtvjFg6pDeFus6BeQJR21d5ZrCiNDziU=;
        b=MhBELbNAqDc12LGo5An7SFn2WtgiXLs2Ejrr+dHlPuXfc3e5oy3eCKWZIuJstinOMW
         otlIQM+NHCjKmbbl3V6i3A3cJNTorPuHOzMEpP3uHY5gaa0tEYRvL6ebAfkL1QkwCoO3
         T/F+AUzXUtPuHNvIC6VJ/8mIhVOOfd9GgaPb3W+jALvUrm48EmdZeiJGwlDMymIF0gY+
         77OMWSS09G+TyV7XQ+20PfLP6NfKLRHegipHrvae6EiWK5E0U6cv2yCijxOag7rk7wb7
         6Q8QOVtrH0fFvwSqzkTLXJZ6x2oTS5vX6mQuxxZb5Rxti6L55HrKpo1f+EvzRpVlx37z
         Xw7A==
X-Gm-Message-State: AO0yUKUyU5pP16v0Tb+MDGFFXz/7fzvCK31na1vv5CGwzTS8n7jcbGeF
        1X04X1aKTaf+2VhWHDQxdAI4+p+KUic=
X-Google-Smtp-Source: AK7set/BDmkLw2mWpMxPzpmebHTgz5xD+ueCpGd0zxLP4oh3aXZpw4RZhFXvDOZV8CjSsCwyOLU5MQ==
X-Received: by 2002:a4a:4f16:0:b0:53b:54d1:b3d0 with SMTP id c22-20020a4a4f16000000b0053b54d1b3d0mr9681571oob.5.1680116958465;
        Wed, 29 Mar 2023 12:09:18 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:5b9e:1cc2:c3f7:6f9c? (2603-8081-140c-1a00-5b9e-1cc2-c3f7-6f9c.res6.spectrum.com. [2603:8081:140c:1a00:5b9e:1cc2:c3f7:6f9c])
        by smtp.gmail.com with ESMTPSA id s22-20020a4a2d56000000b00525240c6149sm14002817oof.31.2023.03.29.12.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 12:09:18 -0700 (PDT)
Message-ID: <ea0968af-4c12-dbc3-6b5d-67def5e039d0@gmail.com>
Date:   Wed, 29 Mar 2023 14:09:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [bug report] RDMA/rxe: Rewrite rxe_task.c
To:     Dan Carpenter <error27@gmail.com>
Cc:     linux-rdma@vger.kernel.org
References: <480b32b6-0f1c-4646-9ecc-e0760004cd24@kili.mountain>
 <8a054b78-6d50-4bc6-8d8a-83f85fbdb82f@kili.mountain>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <8a054b78-6d50-4bc6-8d8a-83f85fbdb82f@kili.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/29/23 01:48, Dan Carpenter wrote:
> On Wed, Mar 29, 2023 at 09:27:26AM +0300, Dan Carpenter wrote:
>> Hello Bob Pearson,
>>
>> The patch d94671632572: "RDMA/rxe: Rewrite rxe_task.c" from Mar 4,
>> 2023, leads to the following Smatch static checker warning:
>>
>> 	drivers/infiniband/sw/rxe/rxe_task.c:24 __reserve_if_idle()
>> 	warn: bitwise AND condition is false here
>>
>> drivers/infiniband/sw/rxe/rxe_task.c
>>     20 static bool __reserve_if_idle(struct rxe_task *task)
>>     21 {
>>     22         WARN_ON(rxe_read(task->qp) <= 0);
>>     23 
>> --> 24         if (task->tasklet.state & TASKLET_STATE_SCHED)
>>                                          ^^^^^^^^^^^^^^^^^^^
>> This is zero.  Should the check be == TASKLET_STATE_SCHED?
>>
> 
> The next function as well.
> 
> drivers/infiniband/sw/rxe/rxe_task.c:49 __is_done() warn: bitwise AND condition is false here
> 
> regards,
> dan carpenter
> 

Good catch. I was trying to open code the test in tasklet_schedule which was
test_and_set_bit(TASKLET_STATE_SCHED, &t->state). I should have typed

	if (task->tasklet.state & (1 << TASKLET_STATE_BIT)) or similar.

Thanks,

Bob
