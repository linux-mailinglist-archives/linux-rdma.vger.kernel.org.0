Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DDA57E6F8
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 21:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiGVTE2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jul 2022 15:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGVTE2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jul 2022 15:04:28 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652C9A6FA2
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 12:04:27 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id j70so6533505oih.10
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 12:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JdZ+4soRyQ1GdkJaRq9jpmNvajAvvZ4zhQv2Tal96r4=;
        b=ExJW5kCZUiAgk1LH0F0p8wUkALGOayQ3x/8Pbbjn+QYfrHdmGmwd7bHd8eWKxIuu/U
         4GDKy4oeuI4z9EHZizZZTy7cuMvdF2gebZcIqqWvYt5nHfSv/4hjzu1BNU1QAG7Bvbsg
         6IaNBDFzMqqTJL8qWR9vfm3gZmQWiFnbFdW8wYfcO5B3bzOqWuu/u+DPZRWERQdcpoVl
         JwIheR1nCj13+owtkkPa738c8eAmq/fxaxICPOePRwk+Ydmha5ga4/4XNEqxuB3URwAX
         QMEYi8ME7Gi7eA427CbFE3N+ypEUfrjgO7Vw+1uCx0FXF4V3INNLIz72pfPjGDbtRbMn
         3BKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JdZ+4soRyQ1GdkJaRq9jpmNvajAvvZ4zhQv2Tal96r4=;
        b=2+2gu8ov40RCxHj2NDgseS8tvkjR/APA+IKi9/tJg98E55nGOgN+3aFPTfjyEpd55Z
         reMLVY7s4W8zGESmeCzK/ol2YkeO1rS2oFLJ2+sft34tNV8p7YmgWMyTAJUYAqLoDnTF
         yKqCAeHwigKyHns3p3TMGvl+2/6A5PfZXyB8OeG4/9AEvq7cb+pkcgcUCkxszegTAExQ
         ZDy/Oeukz9uBCT1lSUjDJY+MSEM04ovNAl5xX+6uczfY8GQTwOgGbb6Lcgjy5txqydG/
         rPg3QsyJfnn25GdNC6/FyFYu/WgztW8IbnfstZI8jd/hlVKnRXIZzDtUYmynYXykdEX9
         uXqQ==
X-Gm-Message-State: AJIora9hEEDskN4zec4RupV4NJDhozT1rn9e3iqLS24zsCjlm2jIEuOU
        k4W93WsbDHJizgAueC/shFOwPyvJp40=
X-Google-Smtp-Source: AGRyM1unz60purO2ob1eO/B4sQP2po3OfdpVGLtxYVdYkddtweFJIdmL3Z+pQu1j1O4rEbs36Rtz/Q==
X-Received: by 2002:a05:6808:20a9:b0:33a:91a9:4846 with SMTP id s41-20020a05680820a900b0033a91a94846mr7481010oiw.65.1658516666786;
        Fri, 22 Jul 2022 12:04:26 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:3468:481b:4662:887c? (2603-8081-140c-1a00-3468-481b-4662-887c.res6.spectrum.com. [2603:8081:140c:1a00:3468:481b:4662:887c])
        by smtp.gmail.com with ESMTPSA id i17-20020a9d68d1000000b0061c4d5a5616sm2259227oto.63.2022.07.22.12.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 12:04:26 -0700 (PDT)
Message-ID: <54b69af7-689e-eff5-baee-18ee038b5687@gmail.com>
Date:   Fri, 22 Jul 2022 14:04:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/rxe: For invalidate compare according to set keys in
 mr
Content-Language: en-US
To:     haris iqbal <haris.phnx@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        Leon Romanovsky <leon@kernel.org>, haris.iqbal@ionos.com,
        Jinpu Wang <jinpu.wang@ionos.com>, aleksei.marov@ionos.com
References: <20220707073006.328737-1-haris.phnx@gmail.com>
 <CAE_WKMzj3i6bKrHN_GuBpjoEzuQBXLoEZrXpsqKjtkxvM+ZbfA@mail.gmail.com>
 <CAE_WKMz9G8BYVA=pbNyZv7RdM0gvjDo15EzdgtgEAXcRpjjOmA@mail.gmail.com>
 <20220722151416.GB55077@ziepe.ca>
 <CAE_WKMxqyB7_d-x5AFFqfN00K85cjWRex9LNxXiEKCgNuC=+eg@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAE_WKMxqyB7_d-x5AFFqfN00K85cjWRex9LNxXiEKCgNuC=+eg@mail.gmail.com>
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

On 7/22/22 11:50, haris iqbal wrote:
> On Fri, Jul 22, 2022 at 5:14 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>> On Fri, Jul 22, 2022 at 05:10:46PM +0200, haris iqbal wrote:
>>> On Fri, Jul 15, 2022 at 11:21 AM haris iqbal <haris.phnx@gmail.com> wrote:
>>>>
>>>> On Thu, Jul 7, 2022 at 9:30 AM Md Haris Iqbal <haris.phnx@gmail.com> wrote:
>>>>>
>>>>> The 'rkey' input can be an lkey or rkey, and in rxe the lkey or rkey have
>>>>> the same value, including the variant bits.
>>>>>
>>>>> So, if mr->rkey is set, compare the invalidate key with it, otherwise
>>>>> compare with the mr->lkey.
>>>>>
>>>>> Since we already did a lookup on the non-varient bits to get this far,
>>>>> the check's only purpose is to confirm that the wqe has the correct
>>>>> variant bits.
>>>>>
>>>>> Fixes: 001345339f4c ("RDMA/rxe: Separate HW and SW l/rkeys")
>>>>> Cc: rpearsonhpe@gmail.com
>>>>> Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
>>>>> ---
>>>>>  drivers/infiniband/sw/rxe/rxe_loc.h |  2 +-
>>>>>  drivers/infiniband/sw/rxe/rxe_mr.c  | 12 ++++++------
>>>>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>>>>> index 0e022ae1b8a5..37484a559d20 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>>>>> @@ -77,7 +77,7 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>>>>>                          enum rxe_mr_lookup_type type);
>>>>>  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
>>>>>  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
>>>>> -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
>>>>> +int rxe_invalidate_mr(struct rxe_qp *qp, u32 key);
>>>>>  int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
>>>>>  int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
>>>>>  int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>>>>> index fc3942e04a1f..3add52129006 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>>>>> @@ -576,22 +576,22 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>>>>>         return mr;
>>>>>  }
>>>>>
>>>>> -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
>>>>> +int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
>>>>>  {
>>>>>         struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
>>>>>         struct rxe_mr *mr;
>>>>>         int ret;
>>>>>
>>>>> -       mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
>>>>> +       mr = rxe_pool_get_index(&rxe->mr_pool, key >> 8);
>>>>>         if (!mr) {
>>>>> -               pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
>>>>> +               pr_err("%s: No MR for key %#x\n", __func__, key);
>>>>>                 ret = -EINVAL;
>>>>>                 goto err;
>>>>>         }
>>>>>
>>>>> -       if (rkey != mr->rkey) {
>>>>> -               pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
>>>>> -                       __func__, rkey, mr->rkey);
>>>>> +       if (mr->rkey ? (key != mr->rkey) : (key != mr->lkey)) {
>>>>> +               pr_err("%s: wr key (%#x) doesn't match mr key (%#x)\n",
>>>>> +                       __func__, key, (mr->rkey ? mr->rkey : mr->lkey));
>>>>>                 ret = -EINVAL;
>>>>>                 goto err_drop_ref;
>>>>>         }
>>>>
>>>> Ping.
>>>
>>> Ping.
>>>
>>> Does this need more discussions or changes?
>>
>> I was hoping Bob would say something but I am happy with it..
> 
> Thanks Jason for the response.
> We can wait for Bob to share his thoughts.
> 
>>
>> JasonFine by me

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
