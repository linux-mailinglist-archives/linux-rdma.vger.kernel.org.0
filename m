Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30286366441
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 06:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhDUEKK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 00:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhDUEKJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Apr 2021 00:10:09 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4527BC06174A
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 21:09:36 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so32740919otf.12
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 21:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pm6vYSJ+ug47sMD1T/ClnvNXan+Gipr3TYLUSDpgN3c=;
        b=nTC7qidU+q6O7zFmfR/AhpQCMgClHZBy0guucFnBQnGatP1tTt2DPXvB269U9DSbC3
         wdeVbbj0OY4Q2j3OnAn+rJiMo8nfl8PrrWjggiOvKhHDj9BbLFSDFd+RmZdr5o44mvMB
         qkkeSQyaDWF8ANK/VBd5jziU09NRhLIBkulxe2K8jlrFR5l5Wckba71fHhzlxYY1K8Rf
         0Ct301j6mPAMhy2xb/AkQegSFKd304o6gCbi6V80hpjznO3lH6YfxZyQm+OyGmDs3+OB
         d0cHo1JZHelfPqURdJXQ5HCLn0NPZ1AohKb/+CoE1POcoR7sVO83okZO3oRi8Kyz6hT4
         Vi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pm6vYSJ+ug47sMD1T/ClnvNXan+Gipr3TYLUSDpgN3c=;
        b=R6mxKWn2S72K2xtezBtjEVDk+f6ABDEflhH4ezJ76yfOu1aVU4vCFWr9kSVvw1jXRN
         KNnrjInE1XpwecJi+lIXE/rEpdcZ7nIZObq825Xw3BGjH7GHboXdZ59EKZXpY2IUldbH
         /ohtPH9HZKQrOec/uqassDKPegKidBifKETMKk7VAZj65MBxap8gBl2Zlzch4PzYeHJM
         qHj55wJfkH6OoMzb4zMUbVrcm+7I6oVBazD66TgO4V9EsQ8YGI+ZVplPgZg9tmL3hu1I
         h2fuYZoxoBdqht+dGhHAoHW3/HerE0gZVelhtarDHatcTttsamS8yn00z2+/YTuERu+o
         g2YA==
X-Gm-Message-State: AOAM532EFXlJYw2mlNkcazGK4oeADT9tX2aARMI5eLVOCturRHQyChbW
        q9snrbi9JWlCygM10JJ2dw0=
X-Google-Smtp-Source: ABdhPJxKseilvleQfTwa8Km2jfmyEXbLXERmhd+at7ZrMdkS1a8TFV0BoO/FIvv8p0cfMYylBCNZJw==
X-Received: by 2002:a9d:4713:: with SMTP id a19mr20844806otf.71.1618978175709;
        Tue, 20 Apr 2021 21:09:35 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:b446:281e:a20a:b0d2? (2603-8081-140c-1a00-b446-281e-a20a-b0d2.res6.spectrum.com. [2603:8081:140c:1a00:b446:281e:a20a:b0d2])
        by smtp.gmail.com with ESMTPSA id z25sm277442oth.36.2021.04.20.21.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 21:09:35 -0700 (PDT)
Subject: Re: [PATCH for-next v2 9/9] RDMA/rxe: Implement memory access through
 MWs
To:     Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
References: <20210415025429.11053-1-rpearson@hpe.com>
 <20210415025429.11053-10-rpearson@hpe.com>
 <CAD=hENfnffpYsxVNFUXDEedcGJ5oq3x-SrhKT23Y=6wiYYa3Tg@mail.gmail.com>
 <20210420120402.GY1370958@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <ca5565ac-6957-791a-f3c3-dda5d31d2802@gmail.com>
Date:   Tue, 20 Apr 2021 23:09:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210420120402.GY1370958@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/20/21 7:04 AM, Jason Gunthorpe wrote:
> On Tue, Apr 20, 2021 at 02:34:07PM +0800, Zhu Yanjun wrote:
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>> index b286a14ec282..9f35e2c042d0 100644
>>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>> @@ -183,6 +183,7 @@ struct rxe_resp_info {
>>>
>>>         /* RDMA read / atomic only */
>>>         u64                     va;
>>> +       u64                     offset;
>>>         struct rxe_mr           *mr;
>>>         u32                     resid;
>>>         u32                     rkey;
>>> @@ -470,6 +471,16 @@ static inline u32 mr_rkey(struct rxe_mr *mr)
>>>         return mr->ibmr.rkey;
>>>  }
>>>
>>> +static inline struct rxe_pd *mw_pd(struct rxe_mw *mw)
>>
>> inline
>> Can we remove inline keyword and let the compile to decide it?
> 
> Not in a header
> 
> Jason
> 
I think this is the cleanest way to add these trivial functions. They don't really generate any code
just a different offset from the pointer.

Bob
