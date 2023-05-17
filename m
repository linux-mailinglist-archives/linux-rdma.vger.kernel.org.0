Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA88B705BF1
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 02:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjEQAbP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 May 2023 20:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEQAbO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 May 2023 20:31:14 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676BC40EB
        for <linux-rdma@vger.kernel.org>; Tue, 16 May 2023 17:31:13 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6ac8ede63ccso203303a34.2
        for <linux-rdma@vger.kernel.org>; Tue, 16 May 2023 17:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684283472; x=1686875472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SsN3EP+KVXZ5x6rZYuud2A5kkRYFqhrwyRd11hbw6cw=;
        b=pOBvauF8GHHuVpVSL7uNL8wofZYS04tMEJTp9sYeJkT7D+Jc+M29R/MjqXK7FUK2xv
         vz571+MfalUqBadUEr4uvOU1cGSUaiHXxIjv85QjYsIjTKnwtHGxLuGR+xRFelSMfjKm
         pTEqmk1S6K+2TAA7k6KLA+9P3gENCDf9oe1uAkKxpMAE0z3Et18NTbj4ilrViCWEQ71f
         qk97MDGEyyxRxUMbOC5BdJjnxpXsRzkOVphrq3A+n6nwTo4aU7HmMl+BBAYRSeMvePsk
         lN19j2MlsmblIVIq/3AdDvArDfQ5Vslm0PFoM1HDZaKY2xRNB2Pz/OMNin+eHU0ySxGv
         Eq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684283472; x=1686875472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsN3EP+KVXZ5x6rZYuud2A5kkRYFqhrwyRd11hbw6cw=;
        b=dTya3+NodjBmmcvfv/ltB6cBlX0Aav1OCp0cjjANBGidJt4Mph0fj42cjKHZTqU24x
         hHcmOUPeedRAmpxWCZYCN0qZ8EIKQfklnGXHcLXWZN+p0F4PNmGr8gUCzEPTiZR1pImq
         FwWSPZqLABcqhidT33d/h2LwmLhgWcTU2dKNrMCFQhC3dJGb9ptCydTIYHQhQgwDYlHg
         ioG21aBieo9jdfHZl2kc0o4/SWxwBzU5b3hfHo8cbA3C5/enT/RKltbA4cy/qRA8PbWT
         jLyx338IOWH2her1XJXfkIeqfJFd7zRUvHtL5sb6k66w+g+sBFxzmRCILT+vpyDRm1aL
         K5uQ==
X-Gm-Message-State: AC+VfDyitv5HWDGRshs3mPdv338oR+UYDzTV4Rpcxr44MRsO3j6fH5tr
        oRqy3zwVm971qhv5oU+cojY=
X-Google-Smtp-Source: ACHHUZ5jM3ScrLJC92qNZVQx7t6Yq0FsLGZx5ESwpFhu2+euvMSlSTWlBXJpgwjfjoGTzU/ryIXxrg==
X-Received: by 2002:aca:1e18:0:b0:38d:ed6f:536 with SMTP id m24-20020aca1e18000000b0038ded6f0536mr12448679oic.42.1684283472670;
        Tue, 16 May 2023 17:31:12 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:6756:74e8:3efd:d9c5? (2603-8081-140c-1a00-6756-74e8-3efd-d9c5.res6.spectrum.com. [2603:8081:140c:1a00:6756:74e8:3efd:d9c5])
        by smtp.gmail.com with ESMTPSA id i84-20020acaea57000000b0038ec2b341c2sm9409411oih.12.2023.05.16.17.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 17:31:12 -0700 (PDT)
Message-ID: <7cea94d6-b3b4-eb86-c118-47912de371fe@gmail.com>
Date:   Tue, 16 May 2023 19:31:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-next] RDMA/rxe: Fix double free in rxe_qp.c
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dan.carpenter@linaro.org, leon@kernel.org, guoqing.jiang@linux.dev,
        zyjzyj2000@gmail.com, jhack@hpe.com, linux-rdma@vger.kernel.org
References: <20230515201056.1591140-1-rpearsonhpe@gmail.com>
 <ZGQbpzl0cGHMwGEX@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZGQbpzl0cGHMwGEX@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/16/23 19:11, Jason Gunthorpe wrote:
> On Mon, May 15, 2023 at 03:10:57PM -0500, Bob Pearson wrote:
>> A recent patch can cause a double spin_unlock_bh() in rxe_qp_to_attr()
>> at line 715 in rxe_qp.c. This patch corrects that behavior.
>>
>> A newer patch from Guoqing Jiang recommends replacing all spin_lock
>> calls for qp->state_lock to spin_(un)lock_irqsave(restore)() since
>> apparently the blktests test suite can call the kernel verbs APIs
>> while in hard interrupt state. This patch needs to be applied first
>> and Guoqing's patch modified to accommodate this small change.
>>
>> Fixes: f605f26ea196 ("RDMA/rxe: Protect QP state with qp->state_lock")
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/linux-rdma/27773078-40ce-414f-8b97-781954da9f25@kili.mountain/
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_qp.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Applied to for-rc, thanks
> 
> Jason

Thanks
