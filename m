Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041A46BBBAE
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Mar 2023 19:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjCOSH7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Mar 2023 14:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCOSH6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Mar 2023 14:07:58 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964F114201;
        Wed, 15 Mar 2023 11:07:57 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id bd36so3947277oib.12;
        Wed, 15 Mar 2023 11:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678903677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bswk4wkeUv+Xxd0NDqkMooJeA4YdJa/+8yZXmuwomxg=;
        b=JybN+y1Hx2ekfETb9GZtFLZVRJwjs8YyEYEyo2vnyLZNjX6kxF+Fdc/jxQmibdaZRq
         mevgnjWdpUMGpXX9jzaPMz2iyX3RpVh0+ef2WQf4TPWUe/azYdCh/h20E3J5oPFD7LBb
         WFBMOvywJCylytgjg4IA832CjBej+EraoiuONBAv4gAk2hdF449Xur6t8IJz1EIhoqoA
         6aSaghwrfTycG54OWtIF6dcrdEYGEox8Jiq8H7wCPAVzfuP1rBoI5nSrhPm5u4fvIuqO
         DvLgl6Lj6LAOQaU4co6aRiWmbhWCocDHL8lkUXpE9wVKzG/7uPj0uX7KQT9pov6xivJO
         KpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678903677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bswk4wkeUv+Xxd0NDqkMooJeA4YdJa/+8yZXmuwomxg=;
        b=UFeJv97H7ILH75TOS1dvthx5V6jtrG0/9CpwK8Sozw0YrT39aEA/B+CE3TZqBNJo7U
         9A5VR4AD+rYeAmSNJC0F0msmHYoQEJe20P354//2yJwlDefug1bKFJij4a1iM97ISFb2
         40QbEYWLJwFMF0ooAzS7x5yokU+TR7CIaSDSBo9P39HakdwZyROEwur5njBEj6IkF9Ua
         FWdSse666V4tUC6tn9xWwRT+ZZ029AS8W8i+1WOcAWufR/ms5I5iJdNabaDL5dkMKbsI
         sDTreqet4fWEZmRXMj6c9e9GD/SF5VxUJPO6NGhY7SZXQOJpmkXexAu94o6MrPLi6rl8
         TFNw==
X-Gm-Message-State: AO0yUKWqIBaHh15tyCPJmh1eNl0WqQ5dy7mASK0Jk9FS1lR292Wr8QJ1
        PpWpkMcoy5nmqyVK9BBR+2o=
X-Google-Smtp-Source: AK7set9vKCFoc3Wv5kWXBT9PoDc+xloD8ch3irDduMkdfZlsgouZZIXNaKHiCFuige8aJlPteUtctw==
X-Received: by 2002:a05:6808:280d:b0:383:c6f1:306c with SMTP id et13-20020a056808280d00b00383c6f1306cmr1326182oib.42.1678903675393;
        Wed, 15 Mar 2023 11:07:55 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:ebd0:e160:a3dd:fe9a? (2603-8081-140c-1a00-ebd0-e160-a3dd-fe9a.res6.spectrum.com. [2603:8081:140c:1a00:ebd0:e160:a3dd:fe9a])
        by smtp.gmail.com with ESMTPSA id p130-20020acaf188000000b00383ebc74edasm2488540oih.7.2023.03.15.11.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 11:07:54 -0700 (PDT)
Message-ID: <d5453f77-1e23-003b-6706-ce1f9c71a668@gmail.com>
Date:   Wed, 15 Mar 2023 13:07:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 07/13] RDMA/rxe: Rename kfree_rcu() to
 kfree_rcu_mightsleep()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-8-urezki@gmail.com> <ZAnjnRC1wY3RIFhM@pc636>
 <ZAnpdKV/VvvX0TZz@pc636> <20230310005529.GA339498@google.com>
 <67fbe385-3682-be4e-15fe-f26cc56fd56b@gmail.com>
 <20230315115053.GA3784687@google.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230315115053.GA3784687@google.com>
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

On 3/15/23 06:50, Joel Fernandes wrote:
> On Mon, Mar 13, 2023 at 02:43:43PM -0500, Bob Pearson wrote:
>> On 3/9/23 18:55, Joel Fernandes wrote:
>>> On Thu, Mar 09, 2023 at 03:13:08PM +0100, Uladzislau Rezki wrote:
>>>>> On Wed, Feb 01, 2023 at 04:08:13PM +0100, Uladzislau Rezki (Sony) wrote:
>>>>>> The kfree_rcu()'s single argument name is deprecated therefore
>>>>>> rename it to kfree_rcu_mightsleep() variant. The goal is explicitly
>>>>>> underline that it is for sleepable contexts.
>>>>>>
>>>>>> Please check the RXE driver in a way that a single argument can
>>>>>> be used. Briefly looking at it and rcu_head should be embed to
>>>>>> free an obj over RCU-core. The context might be atomic.
>>>>>>
>>>>>> Cc: Bob Pearson <rpearsonhpe@gmail.com>
>>>>>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>>>>>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>>>>> ---
>>>>>>  drivers/infiniband/sw/rxe/rxe_pool.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>> Could you please add you reviwed-by or Acked-by tags so we can bring
>>>>> our series with renaming for the next merge window?
>>>>>
>>>>> Thanks!
>>>>>
>>>> __rxe_cleanup() can be called in two contexts, sleepable and not.
>>>> Therefore usage of a single argument of the kvfree_rcu() is not correct
>>>> here.
>>>>
>>>> Could you please fix and check your driver? If my above statement
>>>> is not correct, please provide Acked-by or Reviwed-by tags to the
>>>> path that is in question.
>>>>
>>>> Otherwise please add an rcu_head in your data to free objects over
>>>> kvfree_rcu() using double argument API.
>>>>
>>>> Could you please support?
>>>
>>> Also this one needs renaming? It came in because of the commit in 6.3-rc1:
>>> 72a03627443d ("RDMA/rxe: Remove rxe_alloc()")
>>>
>>> It could be squashed into this patch itself since it is infiniband related.
>>>
>>> Paul noticed that this breaks dropping the old API on -next, so it is
>>> blocking the renaming.
>>>
>>> ---8<-----------------------
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>>> index b10aa1580a64..ae3a100e18fb 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>>> @@ -731,7 +731,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>>>  		return -EINVAL;
>>>  
>>>  	rxe_cleanup(mr);
>>> -	kfree_rcu(mr);
>>> +	kfree_rcu_mightsleep(mr);
>>>  	return 0;
>>>  }
>>>  
>> I just got back from a 1 week vacation and missed all this.
>>
>> The "RDMA/rxe: Remove rxe_alloc()" patch just moved the memory allocation
>> for MR (verbs) objects outside of the rxe_pool code since it only applied
>> to MRs and not the other verbs objects (AH, QP, CQ, ...).  That code has to
>> handle a unique situation for AH objects which can be created or destroyed
>> by connection manager code in atomic context while all the other ones
>> including MRs are always created/destroyed in process context. All objects
>> other than MR's are created/destroyed in the rdma-core code
>> (drivers/infiniband/core).
>>
>> The rxe driver keeps xarray's of pointers to the various objects which are
>> protected by rcu locking and so it made sense to use kfree_rcu to delete
>> the object with a delay. In the MR case ..._mightsleep seems harmless and
>> should not be an issue.
>>
>> However on reflection, all the references to the MR objects are ref counted
>> and they have been dropped before reaching the kfree and so there really
>> never was a good reason to use kfree_rcu in the first place. So a better
>> solution would be to replace kfree_rcu with kfree. There is a timeout in
>> completion_done() that triggers a WARN_ON() and this is only seen if the
>> driver is broken for some reason but that is equivalent to getting a seg
>> fault so no reason to further delay the kfree.
>>
>> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
> 
> Thanks, I am planning to send the following patch for 6.4 consideration,
> please let me know if you disagree. Still testing it.
> 
> ----8<---
> 
> From: Joel Fernandes (Google) <joel@joelfernandes.org>
> Subject: [PATCH] RDMA/rxe: Rename kfree_rcu() to kvfree_rcu_mightsleep()
> 
> The k[v]free_rcu() macro's single-argument form is deprecated.
> Therefore switch to the new k[v]free_rcu_mightsleep() variant. The goal
> is to avoid accidental use of the single-argument forms, which can
> introduce functionality bugs in atomic contexts and latency bugs in
> non-atomic contexts.
> 
> There is no functionality change with this patch.
> 
> Link: https://lore.kernel.org/rcu/20230201150815.409582-1-urezki@gmail.com
> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Fixes: 72a03627443d ("RDMA/rxe: Remove rxe_alloc()")
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index b10aa1580a64..ae3a100e18fb 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -731,7 +731,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>  		return -EINVAL;
>  
>  	rxe_cleanup(mr);
> -	kfree_rcu(mr);
> +	kfree_rcu_mightsleep(mr);
>  	return 0;
>  }
>  

I would prefer just

-	kfree_rcu(mr);
+	kfree(mr);

but either one will work.

Bob
