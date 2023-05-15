Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6BC703A5F
	for <lists+linux-rdma@lfdr.de>; Mon, 15 May 2023 19:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244803AbjEORuu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 May 2023 13:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244876AbjEORua (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 May 2023 13:50:30 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308968A64
        for <linux-rdma@vger.kernel.org>; Mon, 15 May 2023 10:48:37 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ab13810da6so3413032a34.2
        for <linux-rdma@vger.kernel.org>; Mon, 15 May 2023 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684172906; x=1686764906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjbEpQ2B/k+LQq9faBzDtfwxBE95sp9D9p6qcKSoopE=;
        b=gyZM+cFSWJdbLz9033JszyEFIz9KZsis1nUcEV7jsGNL/15qpC0VwVo9pIzcomd2e2
         ERN7SDxQrgbgVZ8lgmyspWfGWmNonwZEWCYWZvxe/z2ZqeIJDNpHuJ5UTpuuBZ6HgpSe
         vtunW3eFxXHfLFqquP7I+th5LybKc8yIzXio+uU7ZkcylpdqphN1HyO5C03vyZKI13JR
         ADhA5DxhlHy9olxfuJ99QEbL13JJRfRnTVfsb/ezmzEKFtGj1O091jRN+4novw8PU+po
         +gtVifGlfu4M23r8QUi2kLWO1zVWtOo7uopNhVir6w+Q7GVItvF0xDd5CfQuTTGbY2JP
         Dlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684172906; x=1686764906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjbEpQ2B/k+LQq9faBzDtfwxBE95sp9D9p6qcKSoopE=;
        b=kQqGIWpRwFha+HniGNZCtI7zwoXYvI1GyaDdt692VI0MCAgCh5fOjncvzkO8/mL2jk
         FPS5BFdMK0b1EgcGw7DR4waTMkf8RtmOEk7FT11pqY874hvf4g4cnf1cQk4INutw8AKM
         B7obotR5PkqLRfeNDNL9jGY+udC4HwQVFCcTbR6IyjlYMC6a4DoUwORDmYkpPJviQbl6
         wXxBzZk0DBX6ydGsdHlU9jhfazP+myCHjm3S3XULbTdh6Ol1rIAfXxVee4i7VKbBDb34
         834X/yEfVBmkstyl7ZAzi9ah9XNgedpdMGeb1xwzu5j7ViPvSMWKiEf8Yc6lx2uPgF4Q
         DpwQ==
X-Gm-Message-State: AC+VfDxBNEG9mp44+wNNKqfHShovDmMWeIs9z0ywHcW4f2IgGlnGitU+
        Diu7FyhfOxBPAOlFuZ9p6Jk=
X-Google-Smtp-Source: ACHHUZ4RDQwgGukLtYa6/qUst1za91r8aKXkx3IFMdr6jcN29C70b9mWChXsWvStZ65J64dn2QZj6A==
X-Received: by 2002:a9d:6c05:0:b0:6ab:6f9:462f with SMTP id f5-20020a9d6c05000000b006ab06f9462fmr11043799otq.36.1684172905907;
        Mon, 15 May 2023 10:48:25 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:ce2:a301:d348:5f68? (2603-8081-140c-1a00-0ce2-a301-d348-5f68.res6.spectrum.com. [2603:8081:140c:1a00:ce2:a301:d348:5f68])
        by smtp.gmail.com with ESMTPSA id e21-20020a056830201500b006ac75cff491sm4318281otp.3.2023.05.15.10.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 10:48:25 -0700 (PDT)
Message-ID: <75123f67-23ea-a8c7-9fc4-d85fbdf90d03@gmail.com>
Date:   Mon, 15 May 2023 12:48:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [bug report] RDMA/rxe: Protect QP state with qp->state_lock
To:     Leon Romanovsky <leon@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-rdma@vger.kernel.org, Guoqing Jiang <guoqing.jiang@linux.dev>
References: <27773078-40ce-414f-8b97-781954da9f25@kili.mountain>
 <20230504080731.GT525452@unreal>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230504080731.GT525452@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/4/23 03:07, Leon Romanovsky wrote:
> On Thu, May 04, 2023 at 10:28:59AM +0300, Dan Carpenter wrote:
>> Hello Bob Pearson,
>>
>> The patch f605f26ea196: "RDMA/rxe: Protect QP state with
>> qp->state_lock" from Apr 4, 2023, leads to the following Smatch
>> static checker warning:
>>
>> 	drivers/infiniband/sw/rxe/rxe_qp.c:716 rxe_qp_to_attr()
>> 	error: double unlocked '&qp->state_lock' (orig line 713)
>>
>> drivers/infiniband/sw/rxe/rxe_qp.c
>>     705         rxe_av_to_attr(&qp->pri_av, &attr->ah_attr);
>>     706         rxe_av_to_attr(&qp->alt_av, &attr->alt_ah_attr);
>>     707 
>>     708         /* Applications that get this state typically spin on it.
>>     709          * Yield the processor
>>     710          */
>>     711         spin_lock_bh(&qp->state_lock);
>>     712         if (qp->attr.sq_draining) {
>>     713                 spin_unlock_bh(&qp->state_lock);
>>                              ^^^^^^
>> Unlock
>>
>>     714                 cond_resched();
>>     715         }
> 
> Arguably, lines 708-716 should be deleted.
> 
> Thanks
> 
>> --> 716         spin_unlock_bh(&qp->state_lock);

Bad fix as you suggest. Should have been

       715         } else {
       716                spin_unlock_bh(...);
       717         }

Fortunately I have never seen anyone using the SQD 'state' (which includes sq_draining) for anything, but
it is in the IBA spec. I was trying to protect all references to qp 'state' by the spinlock which provides
smp safe accesses. The cond_resched() call was already there so I didn't want to mix gratuitous changes
in with the spinlock changes.

I think we should fix this, as above, and if it makes sense drop the cond_resched() call in a separate
patch.

There is another patch changing all these to _irqsave/irqrestore spinlocks from Guoqing Jiang which fixes a bug
in blktests so one of these has to go in first and then the other. Which ever one is easier.

Bob
>>                      ^^^^^^
>> Double unlock
>>
>>     717 
>>     718         return 0;
>>     719 }
>>
>> regards,
>> dan carpenter

