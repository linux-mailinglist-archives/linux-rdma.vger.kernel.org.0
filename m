Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B574C1EB3
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 23:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiBWWkw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 17:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiBWWkv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 17:40:51 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C1328D
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 14:40:20 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so775592oov.3
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 14:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DYGvQ7o575mS/LsuRvQRiq0LIH+nocTWATMTP5a9hNo=;
        b=AW2dv1TmLnPfmU5oKPGKzuGVPMiKU8c0CLTwkME/kpA2We9Mq7KmS/cEChQSNrpl0W
         8OSwLq0GU4iD/eXmqv2WiJZbF5DdeC6SWYhDN6yozj2Kuug9KMtqP/MQ4jcEpjEP/1bm
         KZrpI1lTKGERsf9uWjPDq9IOJrB8xjx4quN9zxWqCnmR59f9AomiomENuU6f0TC9KP7G
         4cw8XHB03m6pQqKUu7eO173chh5MS/Ixn2Bqj2jVR6MoS4k+gAGgvQyUFo8kTFcA9c44
         tKqbqIUwo6cvaQztYojqcgMrgF2aTS/70bNG3rvPpWTW7QDVQ8Z+G0ezLnJUVd6qWnjN
         IeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DYGvQ7o575mS/LsuRvQRiq0LIH+nocTWATMTP5a9hNo=;
        b=KHvxbTF6rGLpulnXL6W/lHA3e90FZ/XeVU01bDoPvJi7ItKZEIhQvNeUQY/KbTrQoU
         9wuRQQ/d0KOd7ujNFS1kJXMFwuvTiAPiZGOE+SPRNhqOs9bDLOqRLjCovbrWU3UFkr7l
         lExsTR+LOt7i6NIjOZ2EoHdOkhQV4TEhMJo5hahxWw4u4Y51c6Dae94FhEvw9YRcNRti
         44GMYoqXAeBSD/YbV1bKwQf9X/dcuSyu+p9VfCH9guiHphVuuz1WTljyH4azfGbcxegW
         CWxMyTokym8WtgqcCcAhR+0Yfj+LJyoJZQiYEtM+FRAN5gHsZjGAiwHNxQAs3LMEH9XH
         1OIA==
X-Gm-Message-State: AOAM531trL8dObnt72pVCNf3aUJRXjiXpEunHtTZUcJt82k6Mr79wSbo
        TRTzOF8PqhBr+KGxrf4Sgjv0V2CiAC8=
X-Google-Smtp-Source: ABdhPJx5sYZnHoR3oj3jyOfMhDKTxIPhxMK6Vnhe+bID7VjjnBF4hrRjFKIZVkxOP2Cl2Rjxmt1pyA==
X-Received: by 2002:a05:6870:d99a:b0:d3:13ae:6530 with SMTP id gn26-20020a056870d99a00b000d313ae6530mr906154oab.310.1645656020179;
        Wed, 23 Feb 2022 14:40:20 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:2cee:5c5:defb:ee71? (2603-8081-140c-1a00-2cee-05c5-defb-ee71.res6.spectrum.com. [2603:8081:140c:1a00:2cee:5c5:defb:ee71])
        by smtp.gmail.com with ESMTPSA id s14sm529446oae.21.2022.02.23.14.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 14:40:19 -0800 (PST)
Message-ID: <34b05c41-c674-7120-8d0c-0ceedab50b50@gmail.com>
Date:   Wed, 23 Feb 2022 16:40:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH for-next v12 6/6] RDMA/rxe: Convert mca read locking to
 RCU
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220218003543.205799-1-rpearsonhpe@gmail.com>
 <20220218003543.205799-7-rpearsonhpe@gmail.com>
 <20220223195222.GA420650@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220223195222.GA420650@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/23/22 13:52, Jason Gunthorpe wrote:
> On Thu, Feb 17, 2022 at 06:35:44PM -0600, Bob Pearson wrote:
>> Replace spinlock with rcu read locks for read side operations
>> on mca in rxe_recv.c and rxe_mcast.c.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>  drivers/infiniband/sw/rxe/rxe_mcast.c | 97 +++++++++++++++++----------
>>  drivers/infiniband/sw/rxe/rxe_recv.c  |  6 +-
>>  drivers/infiniband/sw/rxe/rxe_verbs.h |  2 +
>>  3 files changed, 67 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
>> index 349a6fac2fcc..2bfec3748e1e 100644
>> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
>> @@ -17,6 +17,12 @@
>>   * mca is created. It holds a pointer to the qp and is added to a list
>>   * of qp's that are attached to the mcg. The qp_list is used to replicate
>>   * mcast packets in the rxe receive path.
>> + *
>> + * The highest performance operations are mca list traversal when
>> + * processing incoming multicast packets which need to be fanned out
>> + * to the attached qp's. This list is protected by RCU locking for read
>> + * operations and a spinlock in the rxe_dev struct for write operations.
>> + * The red-black tree is protected by the same spinlock.
>>   */
>>  
>>  #include "rxe.h"
>> @@ -288,7 +294,7 @@ static void rxe_destroy_mcg(struct rxe_mcg *mcg)
>>  }
>>  
>>  /**
>> - * __rxe_init_mca - initialize a new mca holding lock
>> + * __rxe_init_mca_rcu - initialize a new mca holding lock
>>   * @qp: qp object
>>   * @mcg: mcg object
>>   * @mca: empty space for new mca
>> @@ -298,8 +304,8 @@ static void rxe_destroy_mcg(struct rxe_mcg *mcg)
>>   *
>>   * Returns: 0 on success else an error
>>   */
>> -static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
>> -			  struct rxe_mca *mca)
>> +static int __rxe_init_mca_rcu(struct rxe_qp *qp, struct rxe_mcg *mcg,
>> +			      struct rxe_mca *mca)
>>  {
> 
> This isn't really 'rcu', it still has to hold the write side lock
> 
>>  	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
>>  	int n;
>> @@ -322,7 +328,10 @@ static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
>>  	rxe_add_ref(qp);
>>  	mca->qp = qp;
>>  
>> -	list_add_tail(&mca->qp_list, &mcg->qp_list);
>> +	kref_get(&mcg->ref_cnt);
>> +	mca->mcg = mcg;
>> +
>> +	list_add_tail_rcu(&mca->qp_list, &mcg->qp_list);
> 
> list_add_tail gets to be called rcu because it is slower than the
> non-rcu safe version.
> 
>> -static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
>> +static void __rxe_destroy_mca(struct rcu_head *head)
>>  {
>> -	list_del(&mca->qp_list);
>> +	struct rxe_mca *mca = container_of(head, typeof(*mca), rcu);
>> +	struct rxe_mcg *mcg = mca->mcg;
>>  
>>  	atomic_dec(&mcg->qp_num);
>>  	atomic_dec(&mcg->rxe->mcg_attach);
>> @@ -394,6 +404,19 @@ static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
>>  	kfree(mca);
> 
>> +/**
>> + * __rxe_cleanup_mca_rcu - cleanup mca object holding lock
>> + * @mca: mca object
>> + * @mcg: mcg object
>> + *
>> + * Context: caller must hold a reference to mcg and rxe->mcg_lock
>> + */
>> +static void __rxe_cleanup_mca_rcu(struct rxe_mca *mca, struct rxe_mcg *mcg)
>> +{
>> +	list_del_rcu(&mca->qp_list);
>> +	call_rcu(&mca->rcu, __rxe_destroy_mca);
>> +}
> 
> I think this is OK now..
> 
>> +
>>  /**
>>   * rxe_detach_mcg - detach qp from mcg
>>   * @mcg: mcg object
>> @@ -404,31 +427,35 @@ static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
>>  static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
>>  {
>>  	struct rxe_dev *rxe = mcg->rxe;
>> -	struct rxe_mca *mca, *tmp;
>> -	unsigned long flags;
>> +	struct rxe_mca *mca;
>> +	int ret;
>>  
>> -	spin_lock_irqsave(&rxe->mcg_lock, flags);
>> -	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
>> -		if (mca->qp == qp) {
>> -			__rxe_cleanup_mca(mca, mcg);
>> -
>> -			/* if the number of qp's attached to the
>> -			 * mcast group falls to zero go ahead and
>> -			 * tear it down. This will not free the
>> -			 * object since we are still holding a ref
>> -			 * from the caller
>> -			 */
>> -			if (atomic_read(&mcg->qp_num) <= 0)
>> -				__rxe_destroy_mcg(mcg);
>> -
>> -			spin_unlock_irqrestore(&rxe->mcg_lock, flags);
>> -			return 0;
>> -		}
>> +	spin_lock_bh(&rxe->mcg_lock);
>> +	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
>> +		if (mca->qp == qp)
>> +			goto found;
>>  	}
>>  
>>  	/* we didn't find the qp on the list */
>> -	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
>> -	return -EINVAL;
>> +	ret = -EINVAL;
>> +	goto done;
>> +
>> +found:
>> +	__rxe_cleanup_mca_rcu(mca, mcg);
>> +
>> +	/* if the number of qp's attached to the
>> +	 * mcast group falls to zero go ahead and
>> +	 * tear it down. This will not free the
>> +	 * object since we are still holding a ref
>> +	 * from the caller
>> +	 */
> 
> Fix the word wrap
> 
> Would prefer to avoid the found label in the middle of the code.
> 
>> +	rcu_read_lock();
>> +	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
>>  		/* protect the qp pointers in the list */
>>  		rxe_add_ref(mca->qp);
> 
> The other approach you could take is to als kref_free the qp and allow
> its kref to become zero here. But this is fine, I think.
> 
> Jason

OK I looked at this again. Here is what happens.

without the complete()/wait_for_completion() fix the test passes but the (private i.e. not visible to rdma-core)
mca object is holding a reference on qp which will be freed after the call_rcu() subroutine takes place.
Meanwhile the ib_detach_mcast() call returns to rdma-core and since there is nothing left to do the test is over
and the python code closes the device. But this generates a warning (rdma_core.c line 940) since not all the
user objects (i.e. the qp) were freed. In other contexts we are planning on putting complete()/wait...()'s
in all the other verbs calls which ref count objects for the same reason. I think it applies here too.

Bob
