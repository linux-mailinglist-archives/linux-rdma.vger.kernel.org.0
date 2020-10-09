Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64543288F86
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 19:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389925AbgJIRCf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 13:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390124AbgJIRC0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 13:02:26 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6325C0613D2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Oct 2020 10:02:25 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w141so10910246oia.2
        for <linux-rdma@vger.kernel.org>; Fri, 09 Oct 2020 10:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RXmh1815gmcuyH3oSthn/DLmPwnfHqh9vPpivqofqqQ=;
        b=q07yI61AKSwBiSMzGDvhkOEj2Si13Sk1E44G7wDhBHNgkd7ZAns17Z9NCb3FJe9IxA
         UHL5N41r344lh/sdLkFS7ObHC0sI4UWpCYSa+pGedad5w8LnZBK3TGYsSE9YjWpWNmBu
         vDPLSW5HxtowRAVgS1avtHUyScct5Fyy1vNyurPUx3N1h6+2dcf5ZgJ44muAZppQ2gVB
         /OrKhFP8SuT7sQW7Qe4FPOIGJC8hMSiVLatGbNznTIc8K96zLxqA+UsycLfzSMhkM4+a
         BugapD/O6jDQ52EEhGgm6kBelhUNVm2APGQi69XASz5WbfaMHz3ZJegNJbJuL4SW3kSW
         W1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RXmh1815gmcuyH3oSthn/DLmPwnfHqh9vPpivqofqqQ=;
        b=gluwuRFwquhMnu8AnEBF+wNSVTaeW/BMtveoQkxa1k8EWlSXZwth/pakEfZzQhA2ns
         J3X27pfxf7mfpSMJIqaTefPiI4+C0tjDrakZ7Qd7Q7BjbWPxpnX43OdQ7ThP/X9OGb0Q
         uf11ejTc71frJkRR5U90CSJv9Wa4rlfiUOaNEqWqXR1Rt6n9jEFxgpuX0kpTtuQFgatd
         TemngbvQdkz5wjnWfw32YEZObY/RORHxSWaCNRQC+YgSoiOD/vZs16VVd+ByV+RZgpKQ
         eYtsMki5jGFPmnkBSfJvQBD71osw0adGy8bvY6BtT7ZzqjAkZGdI52+h7grpWbs6WzDs
         cVRA==
X-Gm-Message-State: AOAM530gnxgjfTK8WytVpLtLKtYErFZGMmyTOjmeoYjnwWui7fEPDF1w
        a56LIxKEbi7iWRdbvPgWEo8=
X-Google-Smtp-Source: ABdhPJzgaby9CagBIV0Q3Isb/+Ax9yHMD3ThIgeglFhJgwgXFQd0XzUF/aneOjmDMg+EQoiC1eaX5g==
X-Received: by 2002:a54:4416:: with SMTP id k22mr1500403oiw.156.1602262945166;
        Fri, 09 Oct 2020 10:02:25 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:21af:60b5:ebc7:e8c6? ([2605:6000:8b03:f000:21af:60b5:ebc7:e8c6])
        by smtp.gmail.com with ESMTPSA id x13sm8197368oot.24.2020.10.09.10.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 10:02:24 -0700 (PDT)
Subject: Re: [PATCH 4/4] rdma_rxe: remove duplicate entries in struct rxe_mr
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
References: <20201008212818.265303-1-rpearson@hpe.com>
 <20201008231642.GA417448@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <60104d8d-04b7-d4cf-5aa3-7d2ff5d424cf@gmail.com>
Date:   Fri, 9 Oct 2020 12:02:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008231642.GA417448@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/8/20 6:16 PM, Jason Gunthorpe wrote:
> On Thu, Oct 08, 2020 at 04:28:18PM -0500, Bob Pearson wrote:
> 
> Subject should be of the form
> 
> RDMA/rxe: Some subject
> 
> RDMA convention is to capitalize the first letter ie 'Some'
> 
>> - Struct rxe_mem had pd, lkey and rkey values both in itself
>>     and in the struct ib_mr which is also included in rxe_mem.
>>   - Delete these entries and replace references with ones in ibmr.
>>   - Add mr_lkey and mr_rkey macros which extract these values from mr.
>>   - Added mr_pd macro which extracts pd from mr.
> 
> Commit body text should be paragraphs not point form
> 
>> @@ -333,6 +329,10 @@ struct rxe_mc_grp {
>>  	u16			pkey;
>>  };
>>  
>> +#define mr_pd(mr) to_rpd((mr)->ibmr.pd)
>> +#define mr_lkey(mr) ((mr)->ibmr.lkey)
>> +#define mr_rkey(mr) ((mr)->ibmr.rkey)
> 
> Try to avoid macros for implementing functions, I changed this to:
> 
> +static inline struct rxe_pd *mr_pd(struct rxe_mem *mr)
> +{
> +       return to_rpd(mr->ibmr.pd);
> +}
> +
> +static inline u32 mr_lkey(struct rxe_mem *mr)
> +{
> +       return mr->ibmr.lkey;
> +}
> +
> +static inline u32 mr_rkey(struct rxe_mem *mr)
> +{
> +       return mr->ibmr.rkey;
> +}
> +
> 
> and fixed the other stuff, applied to for-next
> 
> Thanks,
> Jason
> 
Thanks for the style hints and applying the patch. Just guessing but I assume that in RDMA/somthing RDMA refers to the entire drivers/infiniband tree. The equivalent for user space is RDMA-CORE or rdma-core ??

Bob
