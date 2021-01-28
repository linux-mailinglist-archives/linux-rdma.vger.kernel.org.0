Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A8E307C9B
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 18:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhA1RdS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 12:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhA1RdJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 12:33:09 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A91C061574
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jan 2021 09:32:28 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id n127so1602794ooa.13
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jan 2021 09:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bFU0l5C0UI6XAqyWy64SPJ8hfdoZts6uncoMrXDr1Vo=;
        b=X6KNe60RGsq7w/m5YL2ndSZ+PyAO0vkU4k9/pCFSbKXQsdzpnkmqq8edgRBWkRLZrH
         nQkxRKWc56/90Z3wYeXY3p8fgt3RHHLmStCawIXwt/sHDqDn7jytkF4GY8UQcsUwtgq5
         hn/+lK5noQV5JHNevL8l/enjcc5SyOA/Li8thgvDe8V5BEhr4irM1H2sqaR4NUeaiNRq
         BQFNNbD0nzWYbwbVYZ4uIqba9yMmwwyxOXJ2wHWCPFP0OyQKtIBlcp1IxWQnfnzkrkdM
         hRKihRe9M18M8lRCZLTZZbvNc7LzISgYF0SE72eGyKFvbmCrpsyzGQCzRpzlIWz3eRnZ
         aOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bFU0l5C0UI6XAqyWy64SPJ8hfdoZts6uncoMrXDr1Vo=;
        b=CkTqBDtEvazFufAj/rYxxL1ap+U3lLPTr77uZPk39GQnTijcNHkDjCzEhTcgfhofHA
         Wp7X6PjSE663pMZhjb1fOt1mFQnbv7yc3tNDevwmGUGFnAlsePSS+29Ld0b6INQ7BOzR
         acK8h071H5SoNTrskCzSjJm7h8vFvxqmB7GMZNJgo94rhZ3y9obqXHKAhv2WIqEytAo0
         /f81SYSTg1AYwPhK+vEbIW0XW0mTF6OUROZrQt/hnGvtGa74sQwE1LKbpPpoTcfpI60I
         RsP8Xrco6joZf3z+Cn+AXWPkpSfSIeebXM2p6Z8UetAyNyMgKuYhCKJUJBl/WQ3Fenmz
         1oUg==
X-Gm-Message-State: AOAM530UgieIUKnutA63he1nyMRy+RYg6wuSwgTIyOVrWRKiMMXUYr0V
        HbFQBUu0GrJmZkfPSpjOJzw=
X-Google-Smtp-Source: ABdhPJx5Rt9f71cOWq89zJjLgkgzjAr8AuA7RFPgKc5b68Z+qSZuH2NnPLzoLA7kKP9WIFal8GqjGA==
X-Received: by 2002:a4a:a5cc:: with SMTP id k12mr426255oom.33.1611855148343;
        Thu, 28 Jan 2021 09:32:28 -0800 (PST)
Received: from ?IPv6:2603:8081:140c:1a00:ed32:ab84:718a:cacc? (2603-8081-140c-1a00-ed32-ab84-718a-cacc.res6.spectrum.com. [2603:8081:140c:1a00:ed32:ab84:718a:cacc])
        by smtp.gmail.com with ESMTPSA id k65sm1188743oia.19.2021.01.28.09.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 09:32:25 -0800 (PST)
Subject: Re: [PATCH for-next] RDMA/rxe: Fix coding error in rxe_rcv_mcast_pkt
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
References: <20210128011226.3096-1-rpearson@hpe.com>
 <CAD=hENeWJKzs03D7x5=wXZ6mhiKJBrB-y3GOBAsWpfnKfX+Q4A@mail.gmail.com>
 <643809c8-7740-7373-2975-cac9aeb4e111@gmail.com>
 <ad2e12fb-9d38-197b-c842-06bb68fe3be3@gmail.com>
 <20210128125724.GD5097@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <201d9976-674d-3022-46d2-104a6a8e2535@gmail.com>
Date:   Thu, 28 Jan 2021 11:32:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210128125724.GD5097@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/28/21 6:57 AM, Leon Romanovsky wrote:
> On Wed, Jan 27, 2021 at 10:23:53PM -0600, Bob Pearson wrote:
>> On 1/27/21 9:53 PM, Bob Pearson wrote:
>>> On 1/27/21 9:50 PM, Zhu Yanjun wrote:
>>>> On Thu, Jan 28, 2021 at 9:12 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>>>
>>>>> rxe_rcv_mcast_pkt() in rxe_recv.c can leak SKBs in error path
>>>>> code. The loop over the QPs attached to a multicast group
>>>>> creates new cloned SKBs for all but the last QP in the list
>>>>> and passes the SKB and its clones to rxe_rcv_pkt() for further
>>>>> processing. Any QPs that do not pass some checks are skipped.
>>>>> If the last QP in the list fails the tests the SKB is leaked.
>>>>> This patch checks if the SKB for the last QP was used and if
>>>>> not frees it. Also removes a redundant loop invariant assignment.
>>>>>
>>>>> Fixes: 8700e3e7c4857 ("Soft RoCE driver")
>>>>> Fixes: 71abf20b28ff8 ("RDMA/rxe: Handle skb_clone() failure in rxe_recv.c")
>>>>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>>>>> ---
>>>>>  drivers/infiniband/sw/rxe/rxe_recv.c | 18 +++++++++++-------
>>>>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
>>>>> index c9984a28eecc..57cc25e3b4ad 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
>>>>> @@ -252,7 +252,6 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>>>>>
>>>>>         list_for_each_entry(mce, &mcg->qp_list, qp_list) {
>>>>>                 qp = mce->qp;
>>>>> -               pkt = SKB_TO_PKT(skb);
>>>>>
>>>>>                 /* validate qp for incoming packet */
>>>>>                 err = check_type_state(rxe, pkt, qp);
>>>>> @@ -264,12 +263,18 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>>>>>                         continue;
>>>>>
>>>>>                 /* for all but the last qp create a new clone of the
>>>>> -                * skb and pass to the qp.
>>>>> +                * skb and pass to the qp. If an error occurs in the
>>>>> +                * checks for the last qp in the list we need to
>>>>> +                * free the skb since it hasn't been passed on to
>>>>> +                * rxe_rcv_pkt() which would free it later.
>>>>>                  */
>>>>> -               if (mce->qp_list.next != &mcg->qp_list)
>>>>> +               if (mce->qp_list.next != &mcg->qp_list) {
>>>>>                         per_qp_skb = skb_clone(skb, GFP_ATOMIC);
>>>>> -               else
>>>>> +               } else {
>>>>>                         per_qp_skb = skb;
>>>>> +                       /* show we have consumed the skb */
>>>>> +                       skb = NULL;
>>>>> +               }
>>>>>
>>>>>                 if (unlikely(!per_qp_skb))
>>>>>                         continue;
>>>>> @@ -284,10 +289,9 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>>>>>
>>>>>         rxe_drop_ref(mcg);      /* drop ref from rxe_pool_get_key. */
>>>>>
>>>>> -       return;
>>>>> -
>>>>>  err1:
>>>>> -       kfree_skb(skb);
>>>>> +       if (skb)
>>>>> +               kfree_skb(skb);
>>>>
>>>> "if (skb)" is not needed here.
>>>>
>>>> The implemetation of kfree_skb:
>>>>
>>>> void kfree_skb(struct sk_buff *skb)
>>>> {
>>>> if (unlikely(!skb))
>>>> return;
>>>> if (likely(atomic_read(&skb->users) == 1))
>>>> smp_rmb();
>>>> else if (likely(!atomic_dec_and_test(&skb->users)))
>>>> return;
>>>> trace_kfree_skb(skb, __builtin_return_address(0));
>>>> __kfree_skb(skb);
>>>> }
>>>>
>>>> Zhu Yanjun
>>>>>  }
>>>>>
>>>>>  /**
>>>>> --
>>>>> 2.27.0
>>>>>
>>> Agreed but the reason I wrote that was to make it obvious why I set skb to NULL above. But as long as it is clear without it I can remove the test.
>>>
>> Actually I should have written
>>
>> if (unlikely(skb))
>> 	kfree_skb(skb);
> 
> Please don't put "if (a) kfree(a);" constructions unless you want to
> deal with daily flux of patches with attempt to remove "if".
> 
> Thanks
> 
>>
>>
Yes I get it. Thanks. -- bob
