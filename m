Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE424FEFAB
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Apr 2022 08:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiDMGVO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Apr 2022 02:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiDMGVN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Apr 2022 02:21:13 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0446233885
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 23:18:52 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso572185otj.0
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 23:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KkUKfQAA8BOuZT/J4IbRbMP1S9TQBAVowpNYXNdV36E=;
        b=iHTQqJZ8OlAvsxHcTY1benbYaFV55pbX0WcesL8mQKnW9wyluyfwfnQt/EfvV1oKcY
         OFn45R989O0HKZXV9UavqKisvRcr9cLNnumKXyThBmFudG8xqM2YHQx+emBFvM7u6v4E
         Exze4EIZ2O14K+vLZpFRaO+jczWa6GqIpwzrd4jqkoh4ZCh4WDR08pn6Cvdn9iuuM618
         9ur5lnKc1quUxMgepo/lXtS+YsLVwR+zB5g7IJ7OEkguk8Cj+toOUcs8EIYAgq1aV8q9
         CuIBTMQ8To47MWLvbJJlV8Sp0dz5Z5rIxRQC4X4XRAv9IV9um+DGk0E+gSso86gC/3LH
         Bm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KkUKfQAA8BOuZT/J4IbRbMP1S9TQBAVowpNYXNdV36E=;
        b=FhbSSduG/VbAv0r2rUbBoz8KsYp9aqyKu67bcpheSdRpNJBSg32SJ6anWV8yBPpvFf
         BRPNKch5P7GqlaYwgX5GWb92eOt6uZkEnwz0vU6H9ehyN7Ya7naeh0eKFHOWTF3fjcQO
         zmuHaq4fBOkCPiP+/yJjMNHEylNVPEWBdA01yZ5MgaUyxvX6MlGOC94BxORQPVpSH0jM
         H2NWmoD6GfUb2s59NpD2VWBpkI8eBf8lwunYlvl5J5UjFu13agXuEKo5Yvj+Ij3SP6X5
         ggjZLrn+8r7xLEtIamhnUOuZAncBlXuvVcMr91RwZSV3/1Z3pUC0Ynzcbb1LmuAjB20W
         Np/g==
X-Gm-Message-State: AOAM533LBUjAT92Sm3Mx/SWk50MOxun59AfDmhFB4oXg8/GM/5a9QIfB
        cYQEb3VOH5LxhK1JT3XiK9e2l/3/PD4=
X-Google-Smtp-Source: ABdhPJzNpJMyqArZAYWUsbbjA2m7QQcBqhcZ5CjhbmxJlKh89XvZIg2V3KZmUra71xdu1Ge0UMkDWQ==
X-Received: by 2002:a9d:62c:0:b0:5e6:b611:ff6b with SMTP id 41-20020a9d062c000000b005e6b611ff6bmr9800170otn.210.1649830731309;
        Tue, 12 Apr 2022 23:18:51 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:bf31:a7ee:4751:fd2f? (2603-8081-140c-1a00-bf31-a7ee-4751-fd2f.res6.spectrum.com. [2603:8081:140c:1a00:bf31:a7ee:4751:fd2f])
        by smtp.gmail.com with ESMTPSA id x21-20020a9d6d95000000b005e982651684sm257206otp.55.2022.04.12.23.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 23:18:51 -0700 (PDT)
Message-ID: <2c558990-c39d-6a52-eede-9e0a920f4a6e@gmail.com>
Date:   Wed, 13 Apr 2022 01:18:50 -0500
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
 <c465659d-66df-12da-05ea-45ac04b3d4e3@gmail.com>
 <CAD=hENdeGGHmdGoziDz6z5mGMY=0S-v19i+wrbwzE1f8eEvhcA@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAD=hENdeGGHmdGoziDz6z5mGMY=0S-v19i+wrbwzE1f8eEvhcA@mail.gmail.com>
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

On 4/13/22 01:11, Zhu Yanjun wrote:
> On Wed, Apr 13, 2022 at 2:03 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> On 4/13/22 00:58, Zhu Yanjun wrote:
>>> On Wed, Apr 13, 2022 at 1:31 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>>
>>>> rxe_mcast.c currently uses _irqsave spinlocks for rxe->mcg_lock
>>>> while rxe_recv.c uses _bh spinlocks for the same lock. Adding
>>>> tracing shows that the code in rxe_mcast.c is all executed in_task()
>>>> context while the code in rxe_recv.c that refers to the lock
>>>> executes in softirq context. This causes a lockdep warning in code
>>>> that executes multicast I/O including blktests check srp.
>>>>
>>>> Change the locking of rxe->mcg_lock in rxe_mcast.c to use
>>>> spin_(un)lock_bh().
>>>
>>> Now RXE is not stable. We should focus on the problem of RXE.
>>>
>>> Zhu Yanjun
>>
>> This a real bug and triggers lockdep warnings when I run blktests srp.
>> The blktests test suite apparently uses multicast. It is obviously wrong
>> you can't use both _bh and _irqsave locks and pass lockdep checking.
>>
>> What tests are not running correctly for you?
> 
> The crash related with mr is resolved?

I am pursuing getting everything to pass with the rcu_read_lock() patch.
Currently I have blktests, perftests and pyverbs tests all passing.
I have rping running but it hangs. I have WARN_ON's for mr = 0 but I
am not seeing them show up so there absolutely no trace output from rping.
It just hangs after a few minutes with no dmesg. I have lockdep turned on and
as just mentioned WARN_ON's for mr = 0. My suspicion is that this is
related to a race during shutdown but I haven't traced it to the root cause
yet. I don't trust the responder resources code at all.

I am done for today here though.

Bob
> 
> Zhu Yanjun
> 
>>
>> Bob
>>>
>>>>
>>>> With this change the following locks in rdma_rxe which are all _bh
>>>> show no lockdep warnings.
>>>>
>>>>         atomic_ops_lock
>>>>         mw->lock
>>>>         port->port_lock
>>>>         qp->state_lock
>>>>         rxe->mcg_lock
>>>>         rxe->mmap_offset_lock
>>>>         rxe->pending_lock
>>>>         task->state_lock
>>>>
>>>> The only other remaining lock is pool->xa.xa_lock which
>>>> must either be some combination of _bh and _irq types depending
>>>> on the object type (== ah or not) or plain spin_lock if
>>>> the read side operations are converted to use rcu_read_lock().
>>>>
>>>> Fixes: 6090a0c4c7c6 ("RDMA/rxe: Cleanup rxe_mcast.c")
>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>> ---
>>>>  drivers/infiniband/sw/rxe/rxe_mcast.c | 36 +++++++++++----------------
>>>>  1 file changed, 15 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
>>>> index ae8f11cb704a..7f50566b8d89 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_mcast.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
>>>> @@ -143,11 +143,10 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
>>>>  struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>>>>  {
>>>>         struct rxe_mcg *mcg;
>>>> -       unsigned long flags;
>>>>
>>>> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
>>>> +       spin_lock_bh(&rxe->mcg_lock);
>>>>         mcg = __rxe_lookup_mcg(rxe, mgid);
>>>> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
>>>> +       spin_unlock_bh(&rxe->mcg_lock);
>>>>
>>>>         return mcg;
>>>>  }
>>>> @@ -198,7 +197,6 @@ static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
>>>>  static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>>>>  {
>>>>         struct rxe_mcg *mcg, *tmp;
>>>> -       unsigned long flags;
>>>>         int err;
>>>>
>>>>         if (rxe->attr.max_mcast_grp == 0)
>>>> @@ -214,7 +212,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>>>>         if (!mcg)
>>>>                 return ERR_PTR(-ENOMEM);
>>>>
>>>> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
>>>> +       spin_lock_bh(&rxe->mcg_lock);
>>>>         /* re-check to see if someone else just added it */
>>>>         tmp = __rxe_lookup_mcg(rxe, mgid);
>>>>         if (tmp) {
>>>> @@ -232,12 +230,12 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>>>>         if (err)
>>>>                 goto err_dec;
>>>>  out:
>>>> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
>>>> +       spin_unlock_bh(&rxe->mcg_lock);
>>>>         return mcg;
>>>>
>>>>  err_dec:
>>>>         atomic_dec(&rxe->mcg_num);
>>>> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
>>>> +       spin_unlock_bh(&rxe->mcg_lock);
>>>>         kfree(mcg);
>>>>         return ERR_PTR(err);
>>>>  }
>>>> @@ -280,11 +278,9 @@ static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
>>>>   */
>>>>  static void rxe_destroy_mcg(struct rxe_mcg *mcg)
>>>>  {
>>>> -       unsigned long flags;
>>>> -
>>>> -       spin_lock_irqsave(&mcg->rxe->mcg_lock, flags);
>>>> +       spin_lock_bh(&mcg->rxe->mcg_lock);
>>>>         __rxe_destroy_mcg(mcg);
>>>> -       spin_unlock_irqrestore(&mcg->rxe->mcg_lock, flags);
>>>> +       spin_unlock_bh(&mcg->rxe->mcg_lock);
>>>>  }
>>>>
>>>>  /**
>>>> @@ -339,25 +335,24 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>>>>  {
>>>>         struct rxe_dev *rxe = mcg->rxe;
>>>>         struct rxe_mca *mca, *tmp;
>>>> -       unsigned long flags;
>>>>         int err;
>>>>
>>>>         /* check to see if the qp is already a member of the group */
>>>> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
>>>> +       spin_lock_bh(&rxe->mcg_lock);
>>>>         list_for_each_entry(mca, &mcg->qp_list, qp_list) {
>>>>                 if (mca->qp == qp) {
>>>> -                       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
>>>> +                       spin_unlock_bh(&rxe->mcg_lock);
>>>>                         return 0;
>>>>                 }
>>>>         }
>>>> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
>>>> +       spin_unlock_bh(&rxe->mcg_lock);
>>>>
>>>>         /* speculative alloc new mca without using GFP_ATOMIC */
>>>>         mca = kzalloc(sizeof(*mca), GFP_KERNEL);
>>>>         if (!mca)
>>>>                 return -ENOMEM;
>>>>
>>>> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
>>>> +       spin_lock_bh(&rxe->mcg_lock);
>>>>         /* re-check to see if someone else just attached qp */
>>>>         list_for_each_entry(tmp, &mcg->qp_list, qp_list) {
>>>>                 if (tmp->qp == qp) {
>>>> @@ -371,7 +366,7 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>>>>         if (err)
>>>>                 kfree(mca);
>>>>  out:
>>>> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
>>>> +       spin_unlock_bh(&rxe->mcg_lock);
>>>>         return err;
>>>>  }
>>>>
>>>> @@ -405,9 +400,8 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>>>>  {
>>>>         struct rxe_dev *rxe = mcg->rxe;
>>>>         struct rxe_mca *mca, *tmp;
>>>> -       unsigned long flags;
>>>>
>>>> -       spin_lock_irqsave(&rxe->mcg_lock, flags);
>>>> +       spin_lock_bh(&rxe->mcg_lock);
>>>>         list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
>>>>                 if (mca->qp == qp) {
>>>>                         __rxe_cleanup_mca(mca, mcg);
>>>> @@ -421,13 +415,13 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>>>>                         if (atomic_read(&mcg->qp_num) <= 0)
>>>>                                 __rxe_destroy_mcg(mcg);
>>>>
>>>> -                       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
>>>> +                       spin_unlock_bh(&rxe->mcg_lock);
>>>>                         return 0;
>>>>                 }
>>>>         }
>>>>
>>>>         /* we didn't find the qp on the list */
>>>> -       spin_unlock_irqrestore(&rxe->mcg_lock, flags);
>>>> +       spin_unlock_bh(&rxe->mcg_lock);
>>>>         return -EINVAL;
>>>>  }
>>>>
>>>> --
>>>> 2.32.0
>>>>
>>

