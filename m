Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15DB759876
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 16:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjGSOfR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jul 2023 10:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGSOeq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jul 2023 10:34:46 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809ACC7
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 07:34:45 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1bac8445e06so1018412fac.1
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 07:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689777285; x=1692369285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Na27NwBvd6f/ZJ3US8o2hFH7DfwG/0t8m0Qr2AhKy90=;
        b=Bjr09v+wNulB1inONi/lLs9dt3kWZhd/V7KgdZ9GQYJCKB55Ok247m1ql7B0b2II1y
         xCwr+8J+v2vM6MD2Eea58EvhE96IW7enw3vuWyw6ckykay2WSmdrHN7VWEDUVcKrd4Pu
         6Jk0iEEKHplmbUOLdBhGawSQRdTJ0FAbPsz3dXjio+mQcUelYWyC7X0FXoAA6HMbyj7W
         +m4YSJDRWzV8Pw6lR/+yj9OHNnVQzsYimNM9pi7jvi6v60Rvn1hqX9sSsmwDjPyxNfm3
         91Dk7TCwCbx612W4m+wmwqdbwD0SnU9TOKNk2Pr1Vw+DpxHH2Duh0jw26ZN/86eDScj3
         nXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689777285; x=1692369285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Na27NwBvd6f/ZJ3US8o2hFH7DfwG/0t8m0Qr2AhKy90=;
        b=N5FHxQFIcBtqmF+QsIUtKCi4lT8JFlOmv+3PaoOkSa+7EzC3wE0RFxcAz11/ndP0mX
         mFzWZWlN64vVLWC9ZjWiaS4d5siuA1t/86HyI2E7EwkPjnxB5dJlMpJWxEkxDUlOIxSb
         x5gMil+strd2/EULPxyV+44DtHqmYOjNNJQt2JwHYogCWc8nCyuN5TEJFI3u2/7UGgjB
         lHUEFXDQXCfoX4oRmSIxZoKAz62lb261O+V0VXSX9cvAJ3A2ZMvKNEwiVp0C6+uEFJX3
         pd/1eM2w5u+1jT2lg9IpJO8Wlfh8EPYvIsycwdozeoAjBUYZPCoTaU3vvZjWI7RxBhq6
         mdiw==
X-Gm-Message-State: ABy/qLYZhJPaOzdXvRj+k47wqXEjbQPqjFkjQ7bdmUGPjglj/dFccodL
        QxzQRMy3oFxyPbf7YlajNGY=
X-Google-Smtp-Source: APBJJlEV5sOtV4fNT2eXwQIlI4gqrfViday1Cr+5oV6u9ur0kf/TdzkfbTetRHlMmSVb6YT8ldqlVA==
X-Received: by 2002:a05:6870:8192:b0:1ba:66c1:da53 with SMTP id k18-20020a056870819200b001ba66c1da53mr12418625oae.22.1689777284729;
        Wed, 19 Jul 2023 07:34:44 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:6b28:6b74:44a5:2cfa? (2603-8081-140c-1a00-6b28-6b74-44a5-2cfa.res6.spectrum.com. [2603:8081:140c:1a00:6b28:6b74:44a5:2cfa])
        by smtp.gmail.com with ESMTPSA id x21-20020a05687031d500b001b02a3426ddsm1979496oac.14.2023.07.19.07.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 07:34:44 -0700 (PDT)
Message-ID: <5a036610-a51e-98ec-5319-1d7ce01b15a9@gmail.com>
Date:   Wed, 19 Jul 2023 09:34:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-next 2/2] RDMA/rxe: Enable rcu locking of indexed
 objects
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jhack@hpe.com
References: <20230718175943.16734-1-rpearsonhpe@gmail.com>
 <20230718175943.16734-3-rpearsonhpe@gmail.com>
 <CAD=hENcA5aUJQ0H_ufqpeHp=4KHBae=5K5GnaNDPSz+eFxk__w@mail.gmail.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAD=hENcA5aUJQ0H_ufqpeHp=4KHBae=5K5GnaNDPSz+eFxk__w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/19/23 00:38, Zhu Yanjun wrote:
> On Wed, Jul 19, 2023 at 2:00 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> Make rcu_read locking of critical sections with the indexed
>> verbs objects be protected from early freeing of those objects.
>> The AH, QP, MR and MW objects are looked up from their indices
>> contained in received packets or WQEs during I/O processing.
>> Make these objects be freed using kfree_rcu to avoid races.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_pool.h  | 1 +
>>  drivers/infiniband/sw/rxe/rxe_verbs.c | 6 +++++-
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
>> index b42e26427a70..ef2f6f88e254 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_pool.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.h
>> @@ -25,6 +25,7 @@ struct rxe_pool_elem {
>>         struct kref             ref_cnt;
>>         struct list_head        list;
>>         struct completion       complete;
>> +       struct rcu_head         rcu;
>>         u32                     index;
>>  };
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> index 903f0b71447e..b899924b81eb 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> @@ -1395,7 +1395,7 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>>         if (cleanup_err)
>>                 rxe_err_mr(mr, "cleanup failed, err = %d", cleanup_err);
>>
>> -       kfree_rcu_mightsleep(mr);
>> +       kfree_rcu(mr, elem.rcu);
>>         return 0;
>>
>>  err_out:
>> @@ -1494,6 +1494,10 @@ static const struct ib_device_ops rxe_dev_ops = {
>>         INIT_RDMA_OBJ_SIZE(ib_srq, rxe_srq, ibsrq),
>>         INIT_RDMA_OBJ_SIZE(ib_ucontext, rxe_ucontext, ibuc),
>>         INIT_RDMA_OBJ_SIZE(ib_mw, rxe_mw, ibmw),
>> +
>> +       .rcu_offset_ah = offsetof(struct rxe_ah, elem.rcu),
>> +       .rcu_offset_qp = offsetof(struct rxe_qp, elem.rcu),
>> +       .rcu_offset_mw = offsetof(struct rxe_mw, elem.rcu),
> 
> In your commits, you mentioned that ah, qp, mw and mr will be
> protected. But here, only ah, qp and mw are set.
> Not sure if mr is also protected and set in other place.
> Except that, I am fine with it.
> 
> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> 
> Zhu Yanjun
> 
>>  };
>>
>>  int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
>> --
>> 2.39.2
>>

All of the verbs objects except MR are allocated and freed by rdma-core. MR is allocated
and freed by the drivers. So for MR the kfree_rcu call is made in rxe_dereg_mr().
I changed it from kfree_rcu_mightsleep to the kfree_rcu variant to match the three others.

Bob
