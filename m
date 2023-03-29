Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0316CF456
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 22:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjC2URh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 16:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjC2URf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 16:17:35 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F164ED5
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 13:17:34 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-17683b570b8so17476525fac.13
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 13:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680121053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p01pm9hDQl4VgLhYzFiUWy8csT6aP4vChfPYlRyW8gM=;
        b=PF1UNHAj0KlcJ2+tVTHUBaEWVsVkFdB0qVyUR+IJ7JBS5ADuXM0dwWkodLmW1mF8kV
         FlbFoQneX+2kFexcta1/ZtPpft4ojlr/Q+YcnGA/NIGNg8LMlTvCYpssdfHg7NUUex5C
         hvNEbECtEj1LPC2hRRItvAC+wh/rPzLJ2jafeivBHTaCLlQasl9zfYVpYAdq+kgJC+ao
         5+oJ4EOI69DGbdM/Uo6ikARD+66AVcxond2xXfDpulP5nlxe33D/s/IHIAojZr4sDVh4
         7nbpFRSEBi+iCJLEbNhP+zEJaOd1x8GpsViwabUik9QrZHTOXVOzlyNskfvjfms24yF+
         8qGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680121053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p01pm9hDQl4VgLhYzFiUWy8csT6aP4vChfPYlRyW8gM=;
        b=nvDhRi7ySCtJkCFGugH+ojdHjctzSk/jkoy1qWcdsGc05d8X5NIG/fRQOmDLejW4zM
         T9bD55BXmrJOjKnY5MtLHxx2NyEuB6yXKhJMoR4z1B4POoFsUIvwpZV4XS3LU+fIJUzY
         RoK4Vli8PTiPEOCcRwzlljxqZZ7RmNW5TVYlFOR6Tr/5D3Y7j5yn0cmXuZzdNVu+OCn4
         CJcefdxKU5QSbH7RHnU1h5WE2BgegE5zcWxLyuo/jH4WG8jqnrPr4Yqq2HViycZswlMR
         0QAChrPOlsXb4G44MYEwPrE2KxWJW3AgcCaNf6cWTT+urd4vfPGikNZ+bFk+06rPzqXU
         2XWQ==
X-Gm-Message-State: AAQBX9fxP41xj/p9++xOVxXoGMlAQkT+llBfCInoozknw/ek/zo6eQPj
        5F4J4YaXSofdld3t6hoAhrZvUvDEbuQ=
X-Google-Smtp-Source: AK7set+x4F7HJAn/zHPtTaST3cGJcPAJ217MChQT72BCCC2aXNSfpPgFhqbvRhW5C/kOrdLe5oYgOA==
X-Received: by 2002:a05:6871:b1f:b0:17a:b12c:346b with SMTP id fq31-20020a0568710b1f00b0017ab12c346bmr13745955oab.37.1680121053379;
        Wed, 29 Mar 2023 13:17:33 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:5b9e:1cc2:c3f7:6f9c? (2603-8081-140c-1a00-5b9e-1cc2-c3f7-6f9c.res6.spectrum.com. [2603:8081:140c:1a00:5b9e:1cc2:c3f7:6f9c])
        by smtp.gmail.com with ESMTPSA id l3-20020a05683004a300b006a1394ea9f3sm4109420otd.30.2023.03.29.13.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 13:17:32 -0700 (PDT)
Message-ID: <96f2b386-a7f5-d2c9-a6e5-a2dabf769f5e@gmail.com>
Date:   Wed, 29 Mar 2023 15:17:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] RDMA/rxe: Pass a pointer to virt_to_page()
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma@vger.kernel.org
References: <20230324103252.712107-1-linus.walleij@linaro.org>
 <ZB2s3GeaN/FBpR5K@nvidia.com>
 <CACRpkdYTynQS3XwW8j_vamb7wcRwu0Ji1ZZ-HDDs0wQQy4SRzA@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CACRpkdYTynQS3XwW8j_vamb7wcRwu0Ji1ZZ-HDDs0wQQy4SRzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/29/23 09:28, Linus Walleij wrote:
> On Fri, Mar 24, 2023 at 3:00 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>> On Fri, Mar 24, 2023 at 11:32:52AM +0100, Linus Walleij wrote:
>>> Like the other calls in this function virt_to_page() expects
>>> a pointer, not an integer.
>>>
>>> However since many architectures implement virt_to_pfn() as
>>> a macro, this function becomes polymorphic and accepts both a
>>> (unsigned long) and a (void *).
>>>
>>> Fix this up with an explicit cast.
>>>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>>  drivers/infiniband/sw/rxe/rxe_mr.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>>> index b10aa1580a64..5c90d83002f0 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>>> @@ -213,7 +213,7 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
>>>  static int rxe_set_page(struct ib_mr *ibmr, u64 iova)
>>>  {
>>
>> All these functions have the wrong names, they are kva not IOVA.
> 
> This escalated quickly. :D
> 
> I'm trying to do the right thing, I try to fix the technical issues first,
> and I can follow up with a rename patch if you want.
> 
>>> @@ -288,7 +288,7 @@ static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 iova, void *addr,
>>>       u8 *va;
>>
>>>       while (length) {
>>> -             page = virt_to_page(iova & mr->page_mask);
>>> +             page = virt_to_page((void *)(iova & mr->page_mask));
>>>               bytes = min_t(unsigned int, length,
>>>                               PAGE_SIZE - page_offset);
>>
>> This is actually a bug, this function is only called on IB_MR_TYPE_DMA
>> and in that case 'iova' is actually a phys addr
>>
>> So iova should be called phys and the above should be:
>>
>>                 page = pfn_to_page(phys >> PAGE_SHIFT);
> 
> I tried to make a patch fixing all of these up and prepended to v2 of this
> patch (which also needed adjustments).
> 
> This is a bit tricky so bear with me, also I have no idea how to test this
> so hoping for some help there.
> 
> I'm a bit puzzled: could the above code (which exist in
> three instances in the driver) even work as it is? Or is it not used?
> Or is there some failover from DMA to something else that is constantly
> happening?
> 
> Yours,
> Linus Walleij

The driver is a software only emulation of an RDMA device. So there isn't any 'real' DMA going on
just a bunch of memcpy()s.

Bob
