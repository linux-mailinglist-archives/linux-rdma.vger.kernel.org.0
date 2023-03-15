Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2426B6BBCEC
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Mar 2023 20:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjCOTFX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Mar 2023 15:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjCOTFW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Mar 2023 15:05:22 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694331A95E;
        Wed, 15 Mar 2023 12:05:21 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id bk32so14896897oib.10;
        Wed, 15 Mar 2023 12:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678907120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Rhd/PoCtRS3xld7hjN2P5Ii6U/1uGjajKi2JdR+/80=;
        b=a5KzBt+YoRPTkD4KoOxh7CLSAcdZvV1JiaL3oLJhLk1ZqSpd+nm54kbQAt7UPRSTfi
         OP+XIJIaZqE3aOA7kyQbJufyb6zL8GyQvQZ6D2jVOcvYddgNZjbGw1sLJeVVTd722hS2
         qJZ6L/DfLVG8RufSLGdO7OTOhLnZjdhNDqXbu/XoDkQcCSEijwDJ+hkX/Dk0ss097sLI
         +6WWc1kfmmacTTQ3TwcKRgS54mak1GUxmeqmAmIet3JPLFj9y+slpujqY00tWUo95WWn
         zzS6KY9s2ghvkcuMOjhGLEAYQbatU9mShGSgepCRKrJQgVr4mqD/Aa84DnKhoQghR10i
         +yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678907120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Rhd/PoCtRS3xld7hjN2P5Ii6U/1uGjajKi2JdR+/80=;
        b=pqEfGbnwLt9IlYbmHu0IKpU4026pfzrLm09cjCJ00IXHHkFdcT5T32AR/P6OwsGy3N
         JQwlYpaXcVPNSYxAUYIWhl15LOcIIaQTBZcdCHkREAm5Ri9JmGtcGW076UF2d7zb+yX8
         CVaejqMBsKqXAlQlHtTVpk/5Y76vkX6+D7x/l5i35GoLX1A5+AT9uSzlSlsB5hIAaVrQ
         pFGn8a9koGxeo5v7vAcOPrQg+gPVom/KJyBpb98ZYHQcgtQdCA+x4Blnj80aFLhpirGg
         xz5KrUJLPrakSqfAS1Bm6KpUVuUCA/q6IOUkw/DZH8z7YEBfovsLPDmIIzjf/4jXcviD
         GWHQ==
X-Gm-Message-State: AO0yUKU+9nhR9w0pMsS7V6Tye7/6DwGuGgs5JISopgWe19/zBxdHQgv3
        WM6ub2Z89CVG4X7RU1Bzzmk=
X-Google-Smtp-Source: AK7set/O/LbiF0BFl+Ww3tGtiUjBSXrTCIH0j/tB2pAmRiCw51zPMc9o8FFTkod4D70JMxQBIpT5/g==
X-Received: by 2002:a05:6808:346:b0:386:b9a2:55ac with SMTP id j6-20020a056808034600b00386b9a255acmr117976oie.4.1678907120762;
        Wed, 15 Mar 2023 12:05:20 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:ebd0:e160:a3dd:fe9a? (2603-8081-140c-1a00-ebd0-e160-a3dd-fe9a.res6.spectrum.com. [2603:8081:140c:1a00:ebd0:e160:a3dd:fe9a])
        by smtp.gmail.com with ESMTPSA id r64-20020acada43000000b003646062e83bsm2507862oig.29.2023.03.15.12.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 12:05:20 -0700 (PDT)
Message-ID: <7a0dfc9f-6d21-fce4-4b83-72bb171454d3@gmail.com>
Date:   Wed, 15 Mar 2023 14:05:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 13/14] RDMA/rxe: Rename kfree_rcu() to
 kvfree_rcu_mightsleep()
Content-Language: en-US
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Devesh Sharma <devesh.s.sharma@oracle.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230315181902.4177819-1-joel@joelfernandes.org>
 <20230315181902.4177819-13-joel@joelfernandes.org>
 <e704127e-1bfe-f351-db95-bfea6916e8f9@gmail.com>
 <CAEXW_YTB+LBG+oL02c0JfmAzoGSkZDM=QW1EXKbO3f-g0i4ddA@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAEXW_YTB+LBG+oL02c0JfmAzoGSkZDM=QW1EXKbO3f-g0i4ddA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/15/23 13:41, Joel Fernandes wrote:
> On Wed, Mar 15, 2023 at 2:38 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> On 3/15/23 13:19, Joel Fernandes (Google) wrote:
>>> The k[v]free_rcu() macro's single-argument form is deprecated.
>>> Therefore switch to the new k[v]free_rcu_mightsleep() variant. The goal
>>> is to avoid accidental use of the single-argument forms, which can
>>> introduce functionality bugs in atomic contexts and latency bugs in
>>> non-atomic contexts.
>>>
>>> There is no functionality change with this patch.
>>>
>>> Link: https://lore.kernel.org/rcu/20230201150815.409582-1-urezki@gmail.com
>>> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
>>> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
>>> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>>> Fixes: 72a03627443d ("RDMA/rxe: Remove rxe_alloc()")
>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>> ---
>>>  drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>>> index b10aa1580a64..ae3a100e18fb 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>>> @@ -731,7 +731,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>>>               return -EINVAL;
>>>
>>>       rxe_cleanup(mr);
>>> -     kfree_rcu(mr);
>>> +     kfree_rcu_mightsleep(mr);
>>>       return 0;
>>>  }
>>>
>> Please replace kfree_rcu_mightsleep() by kfree(). There is no need to delay the kfree(mr).
> 
> I thought you said either was Ok, but yeah that's fine with me. I was
> trying to play it safe ;-). An extra GP may not hurt, but not having
> one when it is needed might. I will update it to just be kfree.

Thanks. The reason to not add the pause is that it really isn't required and will just make
people think that it is. With the current state of the driver the mr cleanup code will disable
looking up the mr from its rkey or lkey and then wait until all the references to the mr are dropped
before calling kfree. This will always work (unless a new bug is introduced) so no reason to
add the rcu delay.

Bob
> 
> <quote>
>>   rxe_cleanup(mr);
>> - kfree_rcu(mr);
>> + kfree_rcu_mightsleep(mr);
>>   return 0;
>>  }
>>
> 
> I would prefer just
> - kfree_rcu(mr);
> + kfree(mr);
> 
> but either one will work.
> Bob
> </quote>
> 
>  - Joel

