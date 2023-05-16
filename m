Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B717056A5
	for <lists+linux-rdma@lfdr.de>; Tue, 16 May 2023 21:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjEPTDx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 May 2023 15:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEPTDw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 May 2023 15:03:52 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B030A5C5
        for <linux-rdma@vger.kernel.org>; Tue, 16 May 2023 12:03:03 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1967cd396a1so4704423fac.0
        for <linux-rdma@vger.kernel.org>; Tue, 16 May 2023 12:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684263783; x=1686855783;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dSdNU9fvK7CEP/CabFoUFcUl5Azc6p0eKKpUJm37ADA=;
        b=VCwrUo1CvZCIBxcUYEgX73Dm2TiDHPGkh8M85Bl9eip24zKpTHFdmKhFMDCDgOPIxz
         d2jWuoYy58T1eIc6maq02JsUarKvMrpaT5lwMS1nzkbcDJA8dFI+p5iBA8W2zYRDocl0
         RTeoFklEKL/lqM54o+aVM6L8HJRy+jtLqEwwcXRUAampIJ/h04S3nlx6ttads7xCYTC7
         LePDC3kzDD0lx+hsZdhnnpAERkLPHEQOoGGDO0zISaMN3puj37itc+V1gm13ddC8r4Of
         AOK0anRhYHNSMO/I2nU26zzqBY1s3xbVyJJrZEBe3OKqsLk4GDlOsvDcwZBGumk8Hw9E
         h+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263783; x=1686855783;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSdNU9fvK7CEP/CabFoUFcUl5Azc6p0eKKpUJm37ADA=;
        b=CxH4WkjgUhyG4kI6Y/bFuKa9T//PBAWrw2hMcytCzzobJIAOlikYWe83ddaHRvb6zI
         5l/87USfI8uh18pCcQaz1j1NUDe1cumaL1OXFMJ28cgbtvTyXyTe7MmRdu/Puey0I4gu
         oIoNElITMQkNlQmuGt3f+cQTasN1YHOUpd8xkYHGD38RnJn/rC7fBR8PAdJ5tZ/KtfjP
         aiARv9NNEs/g+oDTpzlxGt9x7GpANHNFDYHOrLImETzNzFPTRITTk5owU//vSOBRHKpD
         n1HZYnw+d5wvwJHZVm1JEG463Xznopx6S+Z7RG9uoo7J3VyB6r5SjgZwds0pR4tdv8D2
         +5Ng==
X-Gm-Message-State: AC+VfDwWoGkivgdNKjdLr21t9oY2SnaOkcLRzEilJvWxXJV1CBFcXl0W
        cxRwzBwxHxXm7MqGanbJ/Ek=
X-Google-Smtp-Source: ACHHUZ6jCDYE8eWwa4axVCxd0+YzDZRUCxlQgjToaHiygCe6vUSjhAOjo/n9z9CoMvFilfdeLz5obA==
X-Received: by 2002:a05:6870:b0e4:b0:196:957:6f96 with SMTP id u36-20020a056870b0e400b0019609576f96mr15308429oag.30.1684263783292;
        Tue, 16 May 2023 12:03:03 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:6756:74e8:3efd:d9c5? (2603-8081-140c-1a00-6756-74e8-3efd-d9c5.res6.spectrum.com. [2603:8081:140c:1a00:6756:74e8:3efd:d9c5])
        by smtp.gmail.com with ESMTPSA id n40-20020a056870822800b00199c3a06f7esm2671991oae.51.2023.05.16.12.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 12:03:02 -0700 (PDT)
Message-ID: <e34a7e02-8a26-f611-4ebe-ba77bca07b84@gmail.com>
Date:   Tue, 16 May 2023 14:03:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-next] RDMA/rxe: Fix double free in rxe_qp.c
Content-Language: en-US
To:     Guoqing Jiang <guoqing.jiang@linux.dev>, dan.carpenter@linaro.org,
        leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
References: <20230515201056.1591140-1-rpearsonhpe@gmail.com>
 <b2d643f7-210f-dad8-ae4b-486b46f20a1e@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <b2d643f7-210f-dad8-ae4b-486b46f20a1e@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/15/23 21:10, Guoqing Jiang wrote:
> Hello,
> 
> On 5/16/23 04:10, Bob Pearson wrote:
>> A recent patch can cause a double spin_unlock_bh() in rxe_qp_to_attr()
>> at line 715 in rxe_qp.c. This patch corrects that behavior.
>>
>> A newer patch from Guoqing Jiang recommends replacing all spin_lock
>> calls for qp->state_lock to spin_(un)lock_irqsave(restore)() since
>> apparently the blktests test suite can call the kernel verbs APIs
>> while in hard interrupt state. This patch needs to be applied first
>> and Guoqing's patch modified to accommodate this small change.
> 
> If you don't mind, I will send a patch set with your patch as first one, then
> refresh mine. Which means we don't need to keep the second paragraph
> in commit message, what do you think?
> 
>> Fixes: f605f26ea196 ("RDMA/rxe: Protect QP state with qp->state_lock")
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/linux-rdma/27773078-40ce-414f-8b97-781954da9f25@kili.mountain/
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_qp.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>> index c5451a4488ca..245dd36638c7 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>> @@ -712,8 +712,9 @@ int rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask)
>>       if (qp->attr.sq_draining) {
>>           spin_unlock_bh(&qp->state_lock);
>>           cond_resched();
>> +    } else {
>> +        spin_unlock_bh(&qp->state_lock);
>>       }
>> -    spin_unlock_bh(&qp->state_lock);
>>         return 0;
>>   }
> 
> Looks good, Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> 
> Thanks,
> Guoqing

Guoqing,

I don't care how we do it. Perhaps we should leave it up to the maintainers.
Just needs to be done.

Bob
