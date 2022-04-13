Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA2C4FEF31
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Apr 2022 08:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiDMGGF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Apr 2022 02:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiDMGGC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Apr 2022 02:06:02 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8969451328
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 23:03:42 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id q189so1032986oia.9
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 23:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TxF9Tejs2yTl8XeRSuS2LSqP0ygYZidcLNCBHb9vAOw=;
        b=Rqrx7gjAER/IFS9wD4L90zqkaMknH1HRERQioqR+ZWuvkmXUb1GHi4+0Vml0IXyD8C
         jvTDVrXNEWYUCpdSU8R9eUuKyEppoURKU5ST1Y5xvLQ6+WDFO2RvacD1GKpqOZRYIahx
         cRIIlctUKOxsofEuF34s5a1erG4syyVe5/6vhF1lCIxRNZrtCSRIQMYntCoKoEOWQOs5
         m3K6h2UHuytEq1hbAw79+PwIcO6Eez1s8YVFq9U8JTqdeLeaFYGtFOpIQM8R38kbE2tj
         XBv9G//c4uGDX4nacODnU5Nou1ID9Tv7uN2ZYXtlKU5aGideZ84vByLtiffUGWhXUacQ
         ophA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TxF9Tejs2yTl8XeRSuS2LSqP0ygYZidcLNCBHb9vAOw=;
        b=HMVNAFKKA9oxuX070mZ0AMFoe0hbcfOKuVcgBqdnNq6IvDQqsUS5b/GUzc1whsh23H
         6HiAK/JERX7GIQXlEPKvRX2PCyuOLHlzMFArQWkSoEBICAIKvE1SGDNCL5Tf1BwCfXhe
         2A6Oxu48M7OLJItJHD2McxgwBlXhvBFJgI5vT6YLPEQfDu2dzWPZkZEPDUtREn5aqg6n
         JA3aFXBUmcdjUvABn4edO+t83rWXFarwkyCSdQaCZOuJhoPtuaS9qCpa2GoIp1xTxgyF
         Ol+zRHXI3Mxy3O5HX6COrCAywEY/DmBWNYPOwuXCFhu2mIJGyuIusdXCGOoMBR5H1MXv
         U8nQ==
X-Gm-Message-State: AOAM5336oDE4Da6uVOBWUFl53iWlnnRfPmG6uTegY+Ky0a0Oc97beSiB
        jBDAwupLCBdOAQYW+zHiSU8=
X-Google-Smtp-Source: ABdhPJzMgk4Mm2p6qKAbfCwnxLX80IvE4tXymIzdhJ0VGFD3s/8JCl44C7vnK68MppF6RQwk/QP2Tw==
X-Received: by 2002:aca:6705:0:b0:2ec:f48f:8933 with SMTP id z5-20020aca6705000000b002ecf48f8933mr3401227oix.20.1649829821700;
        Tue, 12 Apr 2022 23:03:41 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:bf31:a7ee:4751:fd2f? (2603-8081-140c-1a00-bf31-a7ee-4751-fd2f.res6.spectrum.com. [2603:8081:140c:1a00:bf31:a7ee:4751:fd2f])
        by smtp.gmail.com with ESMTPSA id r6-20020a0568301ac600b005cdbc6e62a9sm14028412otc.39.2022.04.12.23.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 23:03:41 -0700 (PDT)
Message-ID: <c465659d-66df-12da-05ea-45ac04b3d4e3@gmail.com>
Date:   Wed, 13 Apr 2022 01:03:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH for-next] RDMA/rxe: Fix "RDMA/rxe: Cleanup rxe_mcast.c"
Content-Language: en-US
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20220413052937.92713-1-rpearsonhpe@gmail.com>
 <CAD=hENfro+0=Euk=Ja6uUxVXcOhCdT9vbeubm4=VehHa5tgF5A@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAD=hENfro+0=Euk=Ja6uUxVXcOhCdT9vbeubm4=VehHa5tgF5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/13/22 00:58, Zhu Yanjun wrote:
> On Wed, Apr 13, 2022 at 1:31 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> rxe_mcast.c currently uses _irqsave spinlocks for rxe->mcg_lock
>> while rxe_recv.c uses _bh spinlocks for the same lock. Adding
>> tracing shows that the code in rxe_mcast.c is all executed in_task()
>> context while the code in rxe_recv.c that refers to the lock
>> executes in softirq context. This causes a lockdep warning in code
>> that executes multicast I/O including blktests check srp.
>>
>> Change the locking of rxe->mcg_lock in rxe_mcast.c to use
>> spin_(un)lock_bh().
> 
> Now RXE is not stable. We should focus on the problem of RXE.
> 
> Zhu Yanjun

This a real bug and triggers lockdep warnings when I run blktests srp.
The blktests test suite apparently uses multicast. It is obviously wrong
you can't use both _bh and _irqsave locks and pass lockdep checking.

What tests are not running correctly for you?

Bob
> 
>>
>> With this change the following locks in rdma_rxe which are all _bh
>> show no lockdep warnings.
>>
>>         atomic_ops_lock
>>         mw->lock
>>         port->port_lock
>>         qp->state_lock
>>         rxe->mcg_lock
>>         rxe->mmap_offset_lock
>>         rxe->pending_lock
>>         task->state_lock
>>
>> The only other remaining lock is pool->xa.xa_lock which
>> must either be some combination of _bh and _irq types depending
>> on the object type (== ah or not) or plain spin_lock if
>> the read side operations are converted to use rcu_read_lock().
>>
>> Fixes: 6090a0c4c7c6 ("RDMA/rxe: Cleanup rxe_mcast.c")
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_mcast.c | 36 +++++++++++----------------
>>  1 file changed, 15 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
>> index ae8f11cb704a..7f50566b8d89 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mcast.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
>> @@ -143,11 +143,10 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
>>  struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>>  {
>>         struct rxe_mcg *mcg;
>> -       unsigned long flags;
>>
>> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
>> +       spin_lock_bh(&rxe->mcg_lock);
>>         mcg = __rxe_lookup_mcg(rxe, mgid);
>> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
>> +       spin_unlock_bh(&rxe->mcg_lock);
>>
>>         return mcg;
>>  }
>> @@ -198,7 +197,6 @@ static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
>>  static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>>  {
>>         struct rxe_mcg *mcg, *tmp;
>> -       unsigned long flags;
>>         int err;
>>
>>         if (rxe->attr.max_mcast_grp == 0)
>> @@ -214,7 +212,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>>         if (!mcg)
>>                 return ERR_PTR(-ENOMEM);
>>
>> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
>> +       spin_lock_bh(&rxe->mcg_lock);
>>         /* re-check to see if someone else just added it */
>>         tmp = __rxe_lookup_mcg(rxe, mgid);
>>         if (tmp) {
>> @@ -232,12 +230,12 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>>         if (err)
>>                 goto err_dec;
>>  out:
>> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
>> +       spin_unlock_bh(&rxe->mcg_lock);
>>         return mcg;
>>
>>  err_dec:
>>         atomic_dec(&rxe->mcg_num);
>> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
>> +       spin_unlock_bh(&rxe->mcg_lock);
>>         kfree(mcg);
>>         return ERR_PTR(err);
>>  }
>> @@ -280,11 +278,9 @@ static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
>>   */
>>  static void rxe_destroy_mcg(struct rxe_mcg *mcg)
>>  {
>> -       unsigned long flags;
>> -
>> -       spin_lock_irqsave(&mcg->rxe->mcg_lock, flags);
>> +       spin_lock_bh(&mcg->rxe->mcg_lock);
>>         __rxe_destroy_mcg(mcg);
>> -       spin_unlock_irqrestore(&mcg->rxe->mcg_lock, flags);
>> +       spin_unlock_bh(&mcg->rxe->mcg_lock);
>>  }
>>
>>  /**
>> @@ -339,25 +335,24 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>>  {
>>         struct rxe_dev *rxe = mcg->rxe;
>>         struct rxe_mca *mca, *tmp;
>> -       unsigned long flags;
>>         int err;
>>
>>         /* check to see if the qp is already a member of the group */
>> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
>> +       spin_lock_bh(&rxe->mcg_lock);
>>         list_for_each_entry(mca, &mcg->qp_list, qp_list) {
>>                 if (mca->qp == qp) {
>> -                       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
>> +                       spin_unlock_bh(&rxe->mcg_lock);
>>                         return 0;
>>                 }
>>         }
>> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
>> +       spin_unlock_bh(&rxe->mcg_lock);
>>
>>         /* speculative alloc new mca without using GFP_ATOMIC */
>>         mca = kzalloc(sizeof(*mca), GFP_KERNEL);
>>         if (!mca)
>>                 return -ENOMEM;
>>
>> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
>> +       spin_lock_bh(&rxe->mcg_lock);
>>         /* re-check to see if someone else just attached qp */
>>         list_for_each_entry(tmp, &mcg->qp_list, qp_list) {
>>                 if (tmp->qp == qp) {
>> @@ -371,7 +366,7 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>>         if (err)
>>                 kfree(mca);
>>  out:
>> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
>> +       spin_unlock_bh(&rxe->mcg_lock);
>>         return err;
>>  }
>>
>> @@ -405,9 +400,8 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>>  {
>>         struct rxe_dev *rxe = mcg->rxe;
>>         struct rxe_mca *mca, *tmp;
>> -       unsigned long flags;
>>
>> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
>> +       spin_lock_bh(&rxe->mcg_lock);
>>         list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
>>                 if (mca->qp == qp) {
>>                         __rxe_cleanup_mca(mca, mcg);
>> @@ -421,13 +415,13 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>>                         if (atomic_read(&mcg->qp_num) <= 0)
>>                                 __rxe_destroy_mcg(mcg);
>>
>> -                       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
>> +                       spin_unlock_bh(&rxe->mcg_lock);
>>                         return 0;
>>                 }
>>         }
>>
>>         /* we didn't find the qp on the list */
>> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
>> +       spin_unlock_bh(&rxe->mcg_lock);
>>         return -EINVAL;
>>  }
>>
>> --
>> 2.32.0
>>

