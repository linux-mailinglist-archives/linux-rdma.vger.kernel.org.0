Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841BA27501C
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 06:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgIWEya (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 00:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgIWEya (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Sep 2020 00:54:30 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4B7C061755
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 21:54:30 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id u25so17811421otq.6
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 21:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tk4pFd/EfueG7o6H8nODBkC1oHO+UxTScrSIShRIeLs=;
        b=f2mp8QKPKxMGQFeefHzRDhtqKwTvOvpXc5ChJO4Jl0WPHpzVf5uKY8ueIhDsAQpptt
         KmR+UBvhrh7DsvIBcErbmIT2dSkeeAL7GLbqgc39PhPxySbKkdSMge8IiC5l66hbBpCH
         DxJE1HUSVywCf9eCvMiycbWF3oYWoVDWsG3p4aaA3076NBotuOPgRlXlKLtpN2n8XtH2
         FyQFT5X3iMupH9SjFHqC0OIFqIF/TNGAZcQwzhu6OVmjBi5FDsTPd7AxytHAnK0spDGV
         xkb67nyKZgxGV/4IfUVUA6+jmTuWze8oD0hiwRZ4Bx8UlH1Rg0Mf9jIzLy5la7YlwNNH
         TQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tk4pFd/EfueG7o6H8nODBkC1oHO+UxTScrSIShRIeLs=;
        b=YNOs+Ar6Y1t3igTzLb8HdsTKtsVUk8FPoIBgPOzbdNZoSNZl6XtaVeUjJWNOFinu5U
         mzf8lSsK3KY9gl3bloR1aSgagCwAqw9IR3ejwW6KaTz5y9XHahjozjJfmzwJKSiXmxAc
         GWyuDL4/tIViRh3izt9azZQ4ZEYeOyH/2gIC4Tju0BF4gp9DddLGLr9JcWS10n8cZybl
         I+0b5QW2qQKAhvebZldyPz5KbIQSxHKlk1HyJcyakl/NpUh2Ul53/sF6A8TXigag9sud
         tLjzpsM88rxBSUWr0l9VBtVpBfMNtQqKbakj9gFbQN9KMyCmHlFXcWvwNaujcHOkelw2
         /QwA==
X-Gm-Message-State: AOAM531M9d/u473QxWN7Awt3XlGJD3P5TR9JZBLX4p0bYQYPQyvKP1fh
        7HeP8cGK3lDm5hgaoMZF5gQ=
X-Google-Smtp-Source: ABdhPJwZGOkOroXQa7cGZqWpVfL+LsHYC0t/cDxSQCrwvJ88XNMB4riF6qh+byNTVeN519v9pY9fmg==
X-Received: by 2002:a05:6830:196:: with SMTP id q22mr4780721ota.221.1600836869452;
        Tue, 22 Sep 2020 21:54:29 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:5c29:d7ed:87d4:2fcf? ([2605:6000:8b03:f000:5c29:d7ed:87d4:2fcf])
        by smtp.gmail.com with ESMTPSA id w4sm7333440otm.57.2020.09.22.21.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 21:54:29 -0700 (PDT)
Subject: Re: [PATCH for-next v6 04/12] rdma_rxe: Add alloc_mw and dealloc_mw
 verbs
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, jgg@nvidia.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
References: <20200921200356.8627-1-rpearson@hpe.com>
 <20200921200356.8627-5-rpearson@hpe.com>
 <dc472bbf-95ea-0a14-47f5-54964e4046db@gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <958147d6-0697-17cd-a851-185cb4405d10@gmail.com>
Date:   Tue, 22 Sep 2020 23:54:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dc472bbf-95ea-0a14-47f5-54964e4046db@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/22/20 11:05 PM, Zhu Yanjun wrote:
> On 9/22/2020 4:03 AM, Bob Pearson wrote:
>>   - Add a new file focused on memory windows, rxe_mw.c.
>>   - Add alloc_mw and dealloc_mw verbs and added them to
>>     the list of supported user space verbs.
>>
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>> ---
>>   drivers/infiniband/sw/rxe/Makefile    |  1 +
>>   drivers/infiniband/sw/rxe/rxe_loc.h   |  8 +++
>>   drivers/infiniband/sw/rxe/rxe_mr.c    | 77 ++++++++++-----------
>>   drivers/infiniband/sw/rxe/rxe_mw.c    | 98 +++++++++++++++++++++++++++
>>   drivers/infiniband/sw/rxe/rxe_pool.c  | 33 +++++----
>>   drivers/infiniband/sw/rxe/rxe_pool.h  |  2 +-
>>   drivers/infiniband/sw/rxe/rxe_req.c   | 24 +++----
>>   drivers/infiniband/sw/rxe/rxe_resp.c  |  4 +-
>>   drivers/infiniband/sw/rxe/rxe_verbs.c | 52 +++++++++-----
>>   drivers/infiniband/sw/rxe/rxe_verbs.h |  8 +++
>>   include/uapi/rdma/rdma_user_rxe.h     | 10 +++
>>   11 files changed, 232 insertions(+), 85 deletions(-)
>>   create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c
>>
>> diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
>> index 66af72dca759..1e24673e9318 100644
>> --- a/drivers/infiniband/sw/rxe/Makefile
>> +++ b/drivers/infiniband/sw/rxe/Makefile
>> @@ -15,6 +15,7 @@ rdma_rxe-y := \
>>       rxe_qp.o \
>>       rxe_cq.o \
>>       rxe_mr.o \
>> +    rxe_mw.o \
>>       rxe_opcode.o \
>>       rxe_mmap.o \
>>       rxe_icrc.o \
>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>> index 9ec6bff6863f..65f2e4a94956 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>> @@ -109,6 +109,14 @@ void rxe_mr_cleanup(struct rxe_pool_entry *arg);
>>     int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
>>   +/* rxe_mw.c */
>> +struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
>> +               struct ib_udata *udata);
>> +
>> +int rxe_dealloc_mw(struct ib_mw *ibmw);
>> +
>> +void rxe_mw_cleanup(struct rxe_pool_entry *arg);
>> +
>>   /* rxe_net.c */
>>   void rxe_loopback(struct sk_buff *skb);
>>   int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>> index 368012904879..4c53badfa4e9 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>> @@ -7,21 +7,18 @@
>>   #include "rxe.h"
>>   #include "rxe_loc.h"
>>   -/*
>> - * lfsr (linear feedback shift register) with period 255
>> +/* choose a unique non zero random number for lkey
>> + * use high order bit to indicate MR vs MW
>>    */
>> -static u8 rxe_get_key(void)
>> +static void rxe_set_mr_lkey(struct rxe_mr *mr)
>>   {
>> -    static u32 key = 1;
>> -
>> -    key = key << 1;
>> -
>> -    key |= (0 != (key & 0x100)) ^ (0 != (key & 0x10))
>> -        ^ (0 != (key & 0x80)) ^ (0 != (key & 0x40));
>> -
>> -    key &= 0xff;
>> -
>> -    return key;
>> +    u32 lkey;
>> +again:
>> +    get_random_bytes(&lkey, sizeof(lkey));
>> +    lkey &= ~IS_MW;
>> +    if (likely(lkey && (rxe_add_key(mr, &lkey) == 0)))
>> +        return;
>> +    goto again;
>>   }
>>     int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
>> @@ -49,36 +46,19 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
>>     static void rxe_mr_init(int access, struct rxe_mr *mr)
>>   {
>> -    u32 lkey = mr->pelem.index << 8 | rxe_get_key();
>> -    u32 rkey = (access & IB_ACCESS_REMOTE) ? lkey : 0;
>> -
>> -    if (mr->pelem.pool->type == RXE_TYPE_MR) {
>> -        mr->ibmr.lkey        = lkey;
>> -        mr->ibmr.rkey        = rkey;
>> -    }
>> -
>> -    mr->lkey        = lkey;
>> -    mr->rkey        = rkey;
>> +    rxe_add_index(mr);
>> +    rxe_set_mr_lkey(mr);
>> +    if (access & IB_ACCESS_REMOTE)
>> +        mr->ibmr.rkey = mr->ibmr.lkey;
>> +
>> +    /* TODO should not have two copies of lkey and rkey in mr */
>> +    mr->lkey        = mr->ibmr.lkey;
>> +    mr->rkey        = mr->ibmr.rkey;
>>       mr->state        = RXE_MEM_STATE_INVALID;
>>       mr->type        = RXE_MR_TYPE_NONE;
>>       mr->map_shift        = ilog2(RXE_BUF_PER_MAP);
>>   }
>>   -void rxe_mr_cleanup(struct rxe_pool_entry *arg)
>> -{
>> -    struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
>> -    int i;
>> -
>> -    ib_umem_release(mr->umem);
>> -
>> -    if (mr->map) {
>> -        for (i = 0; i < mr->num_map; i++)
>> -            kfree(mr->map[i]);
>> -
>> -        kfree(mr->map);
>> -    }
>> -}
>> -
>>   static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
>>   {
>>       int i;
>> @@ -541,9 +521,8 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>>   {
>>       struct rxe_mr *mr;
>>       struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
>> -    int index = key >> 8;
>>   -    mr = rxe_pool_get_index(&rxe->mr_pool, index);
>> +    mr = rxe_pool_get_key(&rxe->mr_pool, &key);
>>       if (!mr)
>>           return NULL;
>>   @@ -558,3 +537,21 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>>         return mr;
>>   }
>> +
>> +void rxe_mr_cleanup(struct rxe_pool_entry *arg)
>> +{
>> +    struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
>> +    int i;
>> +
>> +    ib_umem_release(mr->umem);
>> +
>> +    if (mr->map) {
>> +        for (i = 0; i < mr->num_map; i++)
>> +            kfree(mr->map[i]);
>> +
>> +        kfree(mr->map);
>> +    }
>> +
>> +    rxe_drop_index(mr);
>> +    rxe_drop_key(mr);
>> +}
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
>> new file mode 100644
>> index 000000000000..b818f1e869da
>> --- /dev/null
>> +++ b/drivers/infiniband/sw/rxe/rxe_mw.c
>> @@ -0,0 +1,98 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>> +/*
>> + * Copyright (c) 2020 Hewlett Packard Enterprise, Inc. All rights reserved.
>> + */
>> +
>> +#include "rxe.h"
>> +#include "rxe_loc.h"
>> +
>> +/* choose a unique non zero random number for rkey
>> + * use high order bit to indicate MR vs MW
>> + */
>> +static void rxe_set_mw_rkey(struct rxe_mw *mw)
>> +{
>> +    u32 rkey;
>> +again:
>> +    get_random_bytes(&rkey, sizeof(rkey));
>> +    rkey |= IS_MW;
>> +    if (likely((rkey & ~IS_MW) &&
>> +       (rxe_add_key(mw, &rkey) == 0)))
>> +        return;
>> +    goto again;
>> +}
>> +
>> +struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
>> +               struct ib_udata *udata)
>> +{
>> +    struct rxe_pd *pd = to_rpd(ibpd);
>> +    struct rxe_dev *rxe = to_rdev(ibpd->device);
>> +    struct rxe_mw *mw;
>> +    struct rxe_alloc_mw_resp __user *uresp = NULL;
>> +
>> +    if (udata) {
>> +        if (udata->outlen < sizeof(*uresp))
>> +            return ERR_PTR(-EINVAL);
>> +        uresp = udata->outbuf;
>> +    }
>> +
>> +    if (unlikely((type != IB_MW_TYPE_1) &&
>> +             (type != IB_MW_TYPE_2)))
>> +        return ERR_PTR(-EINVAL);
>> +
>> +    rxe_add_ref(pd);
>> +
>> +    mw = rxe_alloc(&rxe->mw_pool);
>> +    if (unlikely(!mw)) {
>> +        rxe_drop_ref(pd);
>> +        return ERR_PTR(-ENOMEM);
>> +    }
>> +
>> +    rxe_add_index(mw);
>> +    rxe_set_mw_rkey(mw);    /* sets mw->ibmw.rkey */
>> +
>> +    spin_lock_init(&mw->lock);
>> +    mw->qp            = NULL;
>> +    mw->mr            = NULL;
>> +    mw->addr        = 0;
>> +    mw->length        = 0;
>> +    mw->ibmw.pd        = ibpd;
>> +    mw->ibmw.type        = type;
>> +    mw->state        = (type == IB_MW_TYPE_2) ?
>> +                    RXE_MEM_STATE_FREE :
>> +                    RXE_MEM_STATE_VALID;
>> +
>> +    if (uresp) {
>> +        if (copy_to_user(&uresp->index, &mw->pelem.index,
>> +                 sizeof(uresp->index))) {
>> +            rxe_drop_ref(mw);
>> +            rxe_drop_ref(pd);
>> +            return ERR_PTR(-EFAULT);
>> +        }
>> +    }
>> +
>> +    return &mw->ibmw;
>> +}
>> +
>> +int rxe_dealloc_mw(struct ib_mw *ibmw)
>> +{
>> +    struct rxe_mw *mw = to_rmw(ibmw);
>> +    struct rxe_pd *pd = to_rpd(ibmw->pd);
>> +    unsigned long flags;
>> +
>> +    spin_lock_irqsave(&mw->lock, flags);
>> +    mw->state = RXE_MEM_STATE_INVALID;
> 
> To this mw->state, can we use bit operations, such as set _bit, test_bit?
> 
> Thanks
> 
> Zhu Yanjun
> 

I don't think that would work. Per the IBA there are 3 states for MRs and MWs: invalid, free and valid.
You can only be in one at a time. The current MR implementation uses a fourth state zombie. I am not
convinced that is necessary and am going to try to get rid of it. The MW implementation in this patch series
uses a spinlock to protect state transitions for MWs and related parameter settings. This lock appears once
in the performance critical path when converting an MW rkey to its bound MR. I'm thinking that MR state
transitions can have the same races as MW and that I should add a lock to mr as well for the same purpose.
This should make zombie unnecessary. Will probably convert both locks to rwlocks (now that I know how they work :-))

Bob
