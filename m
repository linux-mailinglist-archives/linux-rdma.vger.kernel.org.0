Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D786185EC
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 18:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiKCRNE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 13:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiKCRMn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 13:12:43 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3339C1F614
        for <linux-rdma@vger.kernel.org>; Thu,  3 Nov 2022 10:11:56 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-13bd19c3b68so2888564fac.7
        for <linux-rdma@vger.kernel.org>; Thu, 03 Nov 2022 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jCedUWR0WJD5zx0Q730hEIY7teF4tVYiYMC2pwT7hRA=;
        b=cUkMvya72a+WSFqeO6Esnw70Yp5mtaax7lV68AClHKwQQ6/99oAu2bM9zumml+5my/
         BFnZaEV/2P9+Q5qDQAfRnG/NJn2uSwUUqgEl44Y+px851b7Sri/f513sCX6w5R+OFIZq
         y/dZ5PB/PhxkpcHO5r5aLLGx5kXHBR1Y178mMzzNe/PCTsBXygYoy0QksVVDYnZZfB46
         FZUgfMtBOGVGSeJXoTpNsd+e8mHEfKFtJRTJPlQxgtUEyC4jiiBtCakx4rlRyyvur2Gn
         KjJV1NDHJ4XPnTEuCyGxQyWiqPREhGfRSKdFzPwDXKOHaccRWhcNDzDwoRVW5rIWTHcL
         yFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCedUWR0WJD5zx0Q730hEIY7teF4tVYiYMC2pwT7hRA=;
        b=KHqVRnYYuj2K4op5hiy/lx4l+pMhmxpuf2T/P6IqEzHdf7kUBwNNVi5kfIflqCLdJJ
         Kel4CJ5pIQqU3w96tyQ8IzuvKNXKAR8hvpKdwNrexTDgMEahIAHeOftzfWHKRbNw51Qs
         3caxudPRe+Z2IASopX0N9ds4z2XsBBOwH1Ab6XZ+/LanmKqOcsIj6gawAouIvQHUv9oE
         LFANp2pip83o+YshNQwToAoZoK6fs0wMu0887sGzU3RNV/hDD3AeD3tJO/uLIJV7m/e9
         Z4HL7norOVPCFdOnir+goOlUzQiYRE3M30OUHmlAI/Ihwgje5GQma44Qzt6gxTco2rEi
         IZJg==
X-Gm-Message-State: ACrzQf154ZoAP04H9dtJLClbK/a58dWcX1vjb9Vh1u1d+AhAtdGfiS8f
        YQngjKhMaHQKTXwhxE4lIV/5DjEyDkY=
X-Google-Smtp-Source: AMsMyM48wHmryYQebPru5o1txIdKDrM+8LgyR+gjqq5n6flzfdTiYpXcn20vX9ZzlnBgKA+8wW0edg==
X-Received: by 2002:a05:6870:f61a:b0:13b:9374:203e with SMTP id ek26-20020a056870f61a00b0013b9374203emr18486946oab.18.1667495515613;
        Thu, 03 Nov 2022 10:11:55 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:13df:ba12:73d1:1737? (2603-8081-140c-1a00-13df-ba12-73d1-1737.res6.spectrum.com. [2603:8081:140c:1a00:13df:ba12:73d1:1737])
        by smtp.gmail.com with ESMTPSA id m12-20020a05680806cc00b0035a2f3e423esm590633oih.32.2022.11.03.10.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 10:11:54 -0700 (PDT)
Message-ID: <1e0c5b92-caa3-19bc-3e96-974c85f860c6@gmail.com>
Date:   Thu, 3 Nov 2022 12:11:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH for-next 01/16] RDMA/rxe: Add ibdev_dbg macros for rxe
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
References: <20221101202238.32836-1-rpearsonhpe@gmail.com>
 <20221101202238.32836-2-rpearsonhpe@gmail.com> <Y2JpU2hJaTghhgAn@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y2JpU2hJaTghhgAn@nvidia.com>
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

On 11/2/22 07:57, Jason Gunthorpe wrote:
> On Tue, Nov 01, 2022 at 03:22:25PM -0500, Bob Pearson wrote:
>> Add macros borrowed from siw to call dynamic debug macro ibdev_dbg.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe.h | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
>> index 30fbdf3bc76a..1c5186c26bce 100644
>> --- a/drivers/infiniband/sw/rxe/rxe.h
>> +++ b/drivers/infiniband/sw/rxe/rxe.h
>> @@ -38,6 +38,25 @@
>>  
>>  #define RXE_ROCE_V2_SPORT		(0xc000)
>>  
>> +#define rxe_dbg(rxe, fmt, ...) ibdev_dbg(&rxe->ib_dev,			\
>> +		"%s: " fmt, __func__, ##__VA_ARGS__)
>> +#define rxe_dbg_uc(uc, fmt, ...) ibdev_dbg(uc->ibpd.device,		\
>> +		"uc#%d %s: " fmt, uc->elem.index, __func__, ##__VA_ARGS__)
>> +#define rxe_dbg_pd(pd, fmt, ...) ibdev_dbg(pd->ibpd.device,		\
>> +		"pd#%d %s: " fmt, pd->elem.index, __func__, ##__VA_ARGS__)
>> +#define rxe_dbg_ah(ah, fmt, ...) ibdev_dbg(ah->ibah.device,		\
>> +		"ah#%d %s: " fmt, ah->elem.index, __func__, ##__VA_ARGS__)
>> +#define rxe_dbg_srq(srq, fmt, ...) ibdev_dbg(srq->ibsrq.device,	\
>> +		"srq#%d %s: " fmt, srq->elem.index, __func__, ##__VA_ARGS__)
>> +#define rxe_dbg_qp(qp, fmt, ...) ibdev_dbg(qp->ibqp.device,		\
>> +		"qp#%d %s: " fmt, qp->elem.index, __func__, ##__VA_ARGS__)
>> +#define rxe_dbg_cq(cq, fmt, ...) ibdev_dbg(cq->ibcq.device,		\
>> +		"cq#%d %s: " fmt, cq->elem.index, __func__, ##__VA_ARGS__)
>> +#define rxe_dbg_mr(mr, fmt, ...) ibdev_dbg(mr->ibmr.device,		\
>> +		"mr#%d %s:  " fmt, mr->elem.index, __func__, ##__VA_ARGS__)
>> +#define rxe_dbg_mw(mw, fmt, ...) ibdev_dbg(mw->ibmw.device,		\
>> +		"mw#%d %s:  " fmt, mw->elem.index, __func__, ##__VA_ARGS__)
> 
> All the macro arguments here need to be enclosed in brackets if they
> are not a singular expression:
> 
>  #define rxe_dbg_mw(mw, fmt, ...) ibdev_dbg((mw)->ibmw.device,		\
>  		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
> 
> Jason

Thanks. I just sent v2 with this fix and a couple of others.

Bob
