Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B248955EEF6
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 22:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiF1UNK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jun 2022 16:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiF1UMC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jun 2022 16:12:02 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4800EBA7
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jun 2022 13:04:16 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-101bb9275bcso18493175fac.8
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jun 2022 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=we3hGFudT9IHePxOt4PmGTmdgA1uxn5fDI+UMaLcmus=;
        b=csyRa4rvVCkRVarBGflyxxuTg0qzEAc8+Szp9HrHtCJW62rCvbQsEfrelXh/AcEUQb
         J+h8KJxzOuuh4AsecN7NId07ZFyr8R1omVIqm+869Q1c6vlE2A5Vl0825zkW1HcYSfzB
         9JDgjmZzhQt2BrrgTfIF74CfoYs6T+D6F7BrlVd0BJOTofyuBgFEyJtzQEkFxwL/QP3h
         guclMUbFN4ORTijFzzOcVI2A3itJ5bBKL5IisdtIg3YTth7sBCbyTB109tEBDFkKIPPC
         OuN8I3zPoQhlXVII4UFEUtCkoWKqPc/l2eZkN4akQIs5rrf2AOj9wnoWhhrMSpMCV0k3
         B05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=we3hGFudT9IHePxOt4PmGTmdgA1uxn5fDI+UMaLcmus=;
        b=wiEEtf9Y6w8Yc58YU1vUDEKTh3+lKAjIWrdSITVvEIyOhBvTytkGR3XTEPIh0xafrc
         X+sDmFnk8esq9fbl+vxR4nJ9aWSTPEYiEvROa6SNECLExaCXHASwnpfH4z8NJGqoNuf2
         Zw9c82qZu2sstWBaYSprKpuXzlCMRrq7xZcVBx8h/dl52x/N55skEcwUzCiE+dC+nPm6
         OhTFcDDkoq0d+Tkp+GY4W9KG5nP021QgT3irOeuW+dN3x3FgmSkGENxokMdKeqA+p1GF
         i0UZnWjBcfq2q5BI7Fi3Yu0ion4FiVdRneytH0cPB5seNR62W9Rw5rgIOMna1gMGGMml
         VIyA==
X-Gm-Message-State: AJIora9Qi0uE7rFbyvbEiRUnw1sUVh2+YJOOXMz7CcHO2MgJT9zcAY/N
        afYqX+Y+VyL5qwftb6l2gHk=
X-Google-Smtp-Source: AGRyM1t5A7nkwPB6xFeWq+j79tIki+I0PspeK7DCx/r+rzi7u98IDruo1bRc7CYvYDUJmqBEc/9cZA==
X-Received: by 2002:a05:6870:2053:b0:e9:3c2f:23d9 with SMTP id l19-20020a056870205300b000e93c2f23d9mr859372oad.158.1656446655139;
        Tue, 28 Jun 2022 13:04:15 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:207a:447b:2525:c16a? (2603-8081-140c-1a00-207a-447b-2525-c16a.res6.spectrum.com. [2603:8081:140c:1a00:207a:447b:2525:c16a])
        by smtp.gmail.com with ESMTPSA id v2-20020a056808004200b0032e7bd6557fsm7345927oic.50.2022.06.28.13.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 13:04:13 -0700 (PDT)
Message-ID: <fa0da24c-2cbf-6251-d0c6-9a7ac3add9ed@gmail.com>
Date:   Tue, 28 Jun 2022 15:04:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] RDMA/rxe: Split rxe_invalidate_mr into local and remote
 versions
Content-Language: en-US
To:     haris iqbal <haris.phnx@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "aleksei.marov@ionos.com" <aleksei.marov@ionos.com>
References: <20220609120322.144315-1-haris.phnx@gmail.com>
 <d4223faa-0ac4-707a-1323-3d3ad769706b@fujitsu.com>
 <CAE_WKMy-rGgh_6_=OY_77pXNmV73tmww18eb4+XLpp_DtyASdA@mail.gmail.com>
 <20220624232745.GF23621@ziepe.ca>
 <CAE_WKMwcV_QFyN1j8Mb74-Nxg7V7j1V9M+16OxphUWYAU9m9GA@mail.gmail.com>
 <20220628163446.GQ23621@ziepe.ca>
 <CAE_WKMz1XB19T9mXsSq+m0aUg9fKH0X4fTUYEoLtLR=NKZvKBg@mail.gmail.com>
 <20220628165047.GR23621@ziepe.ca>
 <CAE_WKMw9+XuRUyYhAwVVUv1exJQc13_7Vmnm0vQOX2FdCG1M8w@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAE_WKMw9+XuRUyYhAwVVUv1exJQc13_7Vmnm0vQOX2FdCG1M8w@mail.gmail.com>
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

On 6/28/22 12:05, haris iqbal wrote:
> On Tue, Jun 28, 2022 at 6:50 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>> On Tue, Jun 28, 2022 at 06:46:39PM +0200, haris iqbal wrote:
>>> On Tue, Jun 28, 2022 at 6:34 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>>
>>>> On Tue, Jun 28, 2022 at 06:21:09PM +0200, haris iqbal wrote:
>>>>
>>>>>> Yes, no driver in Linux suports a disjoint key space.
>>>>>
>>>>> If disjoint key space is not supported in Linux; does this mean
>>>>> irrespective of whether an MR is registered (IB_WR_REG_MR) for LOCAL
>>>>> or REMOTE access, both rkey and lkey should be set?
>>>>
>>>> No.. It means given any key the driver can always tell if it is a rkey
>>>> or a lkey. There is never any aliasing of key values. Thus the API
>>>> often doesn't have a away to tell if the given key is an rkey or lkey.
>>>>
>>>>> PS: This discussion started in the following thread,
>>>>> https://marc.info/?l=linux-rdma&m=165390868832428&w=2
>>>>
>>>> rxe is incorrect to not accept the lkey presented on the
>>>> invalidate_rkey input. invalidate_rkey is misnamed.
>>>
>>>
>>> Understood. So a better fix for rxe (as compared to the one I sent)
>>> would be one of the following (if I understand correctly).
>>>
>>> 1) The key sent in INV, is compared with lkey or rkey based on which
>>> one is set (non-zero).
>>
>> This one seems to match the spec
>>
>> However, it requires that keys don't alias, I don't know if rxe has
>> done this.
> 
> Rxe seems to be NOT aliasing for fast reg. Unsure about other cases.
> 
> Maybe Bob or Zhu can shed some light?
> 
>>
>>> OR,
>>> 2) The key sent in INV, is compared with lkey if the MR has only LOCAL
>>> access, and rkey if the MR has REMOTE access.
>>
>> That might make more sense if rxe has aliasing keys and you need to be
>> specific about r/l
>>
>> Jason

rxe always has lkey=rkey if rkey is asked for else rkey=0 and lkey is always set.

Bob
