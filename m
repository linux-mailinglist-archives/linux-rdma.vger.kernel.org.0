Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BB8306BEB
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 05:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhA1EH4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 23:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhA1EGg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jan 2021 23:06:36 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D82C0617AA
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jan 2021 19:53:31 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id w8so4676346oie.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jan 2021 19:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gz0xY2wMsaZaNhSJ9Z2KU6y7+5j9+tGKmlkcBI7uFTM=;
        b=UMvIVmyCfKNUa/8k6atNs0GobCkLxNNOOGNOMbVPWGLfIf8aLuFPjT2h21+K4ySYPA
         /cteV20Dv+6RWgHJ87WHxde6cP+/IM4rG3MVDOE+nZ5heuHn0MKdNcvXT08hiK5nvEyE
         p0cp1Bpxnw/+z8+T86v810+cbTESgDM/eWYOJbqud6zxXSTF8atFOhRc+35JPRRqqLig
         PKA+9ziYyQoXWUzpssSdBQnbRXjJzb7y8HW9bYUBdtM8R68G+7EUjpfVlV8Bpfo0w3Sv
         tOozs2fhsX+LGSkokGn0lprMrVIXi4XKNNbWZbWm4/xbh5l3SnhOGWcrUwr+BKTxg31A
         nRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gz0xY2wMsaZaNhSJ9Z2KU6y7+5j9+tGKmlkcBI7uFTM=;
        b=uiR/qVId5BhIYKAoF4sLGSvKOzrNKjX9f/qJJ7oXCoS1SDvWRlWQPkPscaGoVXDf5L
         BCEpwKcn3c2FAoww5xW7U+fCXIK7BMfgI6xLlQyTTICc3KvFEP14o6RP3no2u/8fFPFD
         OosMZJl8PS89Cqn/eRkDX33X7HRv4bWGtlLEWfEBvDvgpbDiyTnq5X224nTE+embWp5F
         lpGlJymP9wVTpq+IYiBbnJkFTm+44Tp2PiVsXehQHIwrs0IF/pIyl2DpMeeH72z0n9sc
         wfqJV0OrNv3J/vAeDk3xeHjy76SZBgJb45t6RxXpLTyDbeIRum4vnNTwVmeaI2SZQ97L
         4PlA==
X-Gm-Message-State: AOAM530ZhbrOkoHt/aYRZbHASqTT4Nk/u/4GwK5GEGaPOhmpef+HEqr/
        Q47zmNjvjWczF+GqQ9X5wdA=
X-Google-Smtp-Source: ABdhPJxitEEatdJ+5WWMj5p4UsjFfelRvT2lNgJRIq+bN4HAG7mUOSAYelITLEJto9vzW3H9P7teyA==
X-Received: by 2002:aca:47ce:: with SMTP id u197mr456302oia.101.1611806010834;
        Wed, 27 Jan 2021 19:53:30 -0800 (PST)
Received: from ?IPv6:2603:8081:140c:1a00:ed32:ab84:718a:cacc? (2603-8081-140c-1a00-ed32-ab84-718a-cacc.res6.spectrum.com. [2603:8081:140c:1a00:ed32:ab84:718a:cacc])
        by smtp.gmail.com with ESMTPSA id m10sm863740oim.42.2021.01.27.19.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 19:53:30 -0800 (PST)
Subject: Re: [PATCH for-next] RDMA/rxe: Fix coding error in rxe_rcv_mcast_pkt
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
References: <20210128011226.3096-1-rpearson@hpe.com>
 <CAD=hENeWJKzs03D7x5=wXZ6mhiKJBrB-y3GOBAsWpfnKfX+Q4A@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <643809c8-7740-7373-2975-cac9aeb4e111@gmail.com>
Date:   Wed, 27 Jan 2021 21:53:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAD=hENeWJKzs03D7x5=wXZ6mhiKJBrB-y3GOBAsWpfnKfX+Q4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/27/21 9:50 PM, Zhu Yanjun wrote:
> On Thu, Jan 28, 2021 at 9:12 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> rxe_rcv_mcast_pkt() in rxe_recv.c can leak SKBs in error path
>> code. The loop over the QPs attached to a multicast group
>> creates new cloned SKBs for all but the last QP in the list
>> and passes the SKB and its clones to rxe_rcv_pkt() for further
>> processing. Any QPs that do not pass some checks are skipped.
>> If the last QP in the list fails the tests the SKB is leaked.
>> This patch checks if the SKB for the last QP was used and if
>> not frees it. Also removes a redundant loop invariant assignment.
>>
>> Fixes: 8700e3e7c4857 ("Soft RoCE driver")
>> Fixes: 71abf20b28ff8 ("RDMA/rxe: Handle skb_clone() failure in rxe_recv.c")
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_recv.c | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
>> index c9984a28eecc..57cc25e3b4ad 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
>> @@ -252,7 +252,6 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>>
>>         list_for_each_entry(mce, &mcg->qp_list, qp_list) {
>>                 qp = mce->qp;
>> -               pkt = SKB_TO_PKT(skb);
>>
>>                 /* validate qp for incoming packet */
>>                 err = check_type_state(rxe, pkt, qp);
>> @@ -264,12 +263,18 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>>                         continue;
>>
>>                 /* for all but the last qp create a new clone of the
>> -                * skb and pass to the qp.
>> +                * skb and pass to the qp. If an error occurs in the
>> +                * checks for the last qp in the list we need to
>> +                * free the skb since it hasn't been passed on to
>> +                * rxe_rcv_pkt() which would free it later.
>>                  */
>> -               if (mce->qp_list.next != &mcg->qp_list)
>> +               if (mce->qp_list.next != &mcg->qp_list) {
>>                         per_qp_skb = skb_clone(skb, GFP_ATOMIC);
>> -               else
>> +               } else {
>>                         per_qp_skb = skb;
>> +                       /* show we have consumed the skb */
>> +                       skb = NULL;
>> +               }
>>
>>                 if (unlikely(!per_qp_skb))
>>                         continue;
>> @@ -284,10 +289,9 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>>
>>         rxe_drop_ref(mcg);      /* drop ref from rxe_pool_get_key. */
>>
>> -       return;
>> -
>>  err1:
>> -       kfree_skb(skb);
>> +       if (skb)
>> +               kfree_skb(skb);
> 
> "if (skb)" is not needed here.
> 
> The implemetation of kfree_skb:
> 
> void kfree_skb(struct sk_buff *skb)
> {
> if (unlikely(!skb))
> return;
> if (likely(atomic_read(&skb->users) == 1))
> smp_rmb();
> else if (likely(!atomic_dec_and_test(&skb->users)))
> return;
> trace_kfree_skb(skb, __builtin_return_address(0));
> __kfree_skb(skb);
> }
> 
> Zhu Yanjun
>>  }
>>
>>  /**
>> --
>> 2.27.0
>>
Agreed but the reason I wrote that was to make it obvious why I set skb to NULL above. But as long as it is clear without it I can remove the test.
