Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903B56E1B0C
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Apr 2023 06:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDNEZH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Apr 2023 00:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDNEZG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Apr 2023 00:25:06 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9783C33;
        Thu, 13 Apr 2023 21:25:04 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id g26-20020a4adc9a000000b0053b9059edd5so2548942oou.3;
        Thu, 13 Apr 2023 21:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681446303; x=1684038303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19g9/pvpnVHbWIQ9BxIFg6NNjkawpnCHoJzxZVkKCKA=;
        b=gwkIf39aeBQQqbxfUKFbwYSNtLRTtFcBRweWxRZRDgs/oPc+qyyqVYjgwiplb95bkT
         H1+bsvUJtTJ7LS6g2LMputo4CIBiezec2GrDeRQclkjdVOHeXuZn0nhjFfBbL448EIao
         ZzuPj/8oLvmRMm/OvPjGcZCEiSlfS8X6DKsCQHSV6fl+4Q8j6oc/o1YQdH4gfCvQsxJN
         Rt4LwOqkyj064z1w5xOwFB+LuwWomeTf7KrZe0jqT0KjOaJHl/QTSuMGyZ43o+43kRux
         S2MwvttdRA70GSjwpYYCnRRHtkVukgrzppRWIcq7i0obvI+B6/J2yURXxG4yHaebKzwp
         jLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681446303; x=1684038303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19g9/pvpnVHbWIQ9BxIFg6NNjkawpnCHoJzxZVkKCKA=;
        b=hc3TD2rzpo3Ft0nWYIGoAkdILeTDetPzdvTxIr1miGTCsT8I5yyG6wxMzmcvU8mrPE
         yPPAK4Jobs9J9UlewG227Dc52Nn8U4x2vK7ROBbKqknziBrPs+VfBeFSY2ZQ1R2KyLeN
         Q1NqP9obNEjHvG8mkdS+cvgy4nszB2yfJRI/q/KFyaqHQhJP8OgJMQJ3JyBarHodnOJ1
         m0Q5ZQlB4aANSTQtAq8DRripPA+zpytIw8kqoTzOe2Mpqy173I5mVSXAyUh4bLN0zjIw
         TpXUF3rB+VaeNsHaRg1C5OHij/FRkylXkziqgb9CAfKZBHVQacyQ8o4D8Sjp6uAjnSY7
         XtIg==
X-Gm-Message-State: AAQBX9e/s8Uq7/1MkHqe0qO8wheRcVQnpSPwu8htlSLo1o0WlYVUAt56
        buYd4T3iOFXb/CGQVrN1Ay7DCzayLME=
X-Google-Smtp-Source: AKy350Zd2vlwSwLy7s+V5ErfW7LyPpM1u5rDzsAfC0KNN6dp0TReEF9/uobaNKWMrdb43iyztrUTsg==
X-Received: by 2002:a4a:4f04:0:b0:525:36b1:86dd with SMTP id c4-20020a4a4f04000000b0052536b186ddmr1843493oob.7.1681446303274;
        Thu, 13 Apr 2023 21:25:03 -0700 (PDT)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id g3-20020a056870e1c300b0017e7052ed84sm1414759oab.41.2023.04.13.21.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 21:25:02 -0700 (PDT)
Message-ID: <9225b221-6f21-96b3-4d21-c3ac477df6de@gmail.com>
Date:   Thu, 13 Apr 2023 23:25:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Content-Language: en-US
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
 <1681108984-2-3-git-send-email-lizhijian@fujitsu.com>
 <20230410120809.GN182481@unreal>
 <0d9c57db-bca3-adb4-71fd-7362e4842917@linux.dev>
 <85323eb2-cfc7-d1b8-3a75-3fa63dde29db@fujitsu.com>
 <20230411122651.GV182481@unreal>
 <aa43746f-77f9-8592-5370-2a5042506ee5@fujitsu.com>
 <8fe62e38-e43d-3d6c-624f-1c8ce5859788@linux.dev>
 <f85cdaaa-b1d6-bc89-e963-8b611ae3667d@fujitsu.com>
 <230b310a-26ef-34f1-4c3b-c2360088ce04@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <230b310a-26ef-34f1-4c3b-c2360088ce04@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/13/23 22:40, Guoqing Jiang wrote:
> 
> 
> On 4/13/23 16:12, Zhijian Li (Fujitsu) wrote:
>> On 13/04/2023 15:35, Guoqing Jiang wrote:
>>> Hi,
>>>
>>> I take a closer look today.
>>>
>>> On 4/12/23 09:15, Zhijian Li (Fujitsu) wrote:
>>>> On 11/04/2023 20:26, Leon Romanovsky wrote:
>>>>> On Tue, Apr 11, 2023 at 02:43:46AM +0000, Zhijian Li (Fujitsu) wrote:
>>>>>> On 10/04/2023 21:10, Guoqing Jiang wrote:
>>>>>>> On 4/10/23 20:08, Leon Romanovsky wrote:
>>>>>>>> On Mon, Apr 10, 2023 at 06:43:03AM +0000, Li Zhijian wrote:
>>>>>>>>> The warning occurs when destroying PD whose reference count is not zero.
>>>>>>>>>
>>>>>>>>> Precodition: clt_path->s.con_num is 2.
>>>>>>>>> So 2 cm connection will be created as below:
>>>>>>>>> CPU0                                              CPU1
>>>>>>>>> init_conns {                              |
>>>>>>>>>       create_cm() // a. con[0] created        |
>>>>>>>>>                                               |  a'. rtrs_clt_rdma_cm_handler() {
>>>>>>>>>                                               |    rtrs_rdma_addr_resolved()
>>>>>>>>>                                               |      create_con_cq_qp(con); << con[0]
>>>>>>>>>                                               |  }
>>>>>>>>>                                               | in this moment, refcnt of PD was increased to 2+
>>> What do you mean "refcnt of PD"? usecnt in struct ib_pd or dev_ref.
>> I mean usecnt in struct ib_pd
>>
>>
>>
>>>>>>>>>                                               |
>>>>>>>>>       create_cm() // b. cid = 1, failed       |
>>>>>>>>>         destroy_con_cq_qp()                   |
>>>>>>>>>           rtrs_ib_dev_put()                   |
>>>>>>>>>             dev_free()                        |
>>>>>>>>>               ib_dealloc_pd(dev->ib_pd) << PD |
>>>>>>>>>                is destroyed, but refcnt is    |
>>>>>>>>>                still greater than 0           |
>>> Assuming you mean "pd->usecnt". We only allocate pd in con[0] by rtrs_ib_dev_find_or_add,
>>> if con[1] failed to create cm, then alloc_path_reqs -> ib_alloc_mr -> atomic_inc(&pd->usecnt)
> 
> The above can't be invoked, right?
> 
>>> can't be triggered. Is there other places could increase the refcnt?
>> Yes, when create a qp, it will also associate to this PD, that also mean refcnt of PD will be increased.
>>
>> When con[0](create_con_cq_qp) succeeded, refcnt of PD will be 2. and then when con[1] failed, since
>> QP didn't create, refcnt of PD is still 2. con[1]'s cleanup will destroy the PD(ib_dealloc_pd) since dev_ref = 1, after that its
>> refcnt is still 1.
> 
> I can see the path increase usecnt to 1.
> 
> rtrs_cq_qp_create -> create_qp
>                     -> rdma_create_qp
>                         -> ib_create_qp
>                             -> create_qp
>                             -> ib_qp_usecnt_inc which increases pd->usecnt
> 
> Where is another place to increase usecnt to 2?
> 
>>> Then what is the appropriate time to call destroy_con_cq_qp for this scenario?
>>> Otherwise there could be memory leak.
>> we must ensure QP in con[0] is closed before destroying the PD.
>> Currently destroy_con_cq_qp() subroutine will close the opened QP first.
> 
> Let me try another way, with below change, rtrs_ib_dev_put can't be called
> from destroy_con_cq_qp, right?
> 
> +    if (!con->has_dev)
> +        return;
>      if (clt_path->s.dev_ref && !--clt_path->s.dev_ref) {
>          rtrs_ib_dev_put(clt_path->s.dev);
>          clt_path->s.dev = NULL;
> 
> Then when will you dealloc pd and free rtrs_ib_dev?
> 
> Thanks,
> Guoqing

I think that wondering into Leon's reference counting is a really bad idea. Currently the assumed rule
is that rdma-core keeps its ref counts and rxe keeps its. rxe defers the return from rxe_dealloc_pd()
until the rxe ref count drops to zero for that pd, sleeping if necessary. (There is a timeout value set
where rxe will return anyway but it will throw a WARN. If the timeout isn't long enough under heavy load
we could extend it.) If it doesn't happen, or it happens too soon, then there is a ref count bug in rxe
that needs to be fixed.

Fixing rxe ref count bugs is hard enough without entangling rdma-core ref counts into the mix.

Bob
