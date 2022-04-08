Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE304F9C47
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 20:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiDHSNb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 14:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiDHSNa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 14:13:30 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADF413E0D
        for <linux-rdma@vger.kernel.org>; Fri,  8 Apr 2022 11:11:26 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-de3ca1efbaso10534087fac.9
        for <linux-rdma@vger.kernel.org>; Fri, 08 Apr 2022 11:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ke1S7+CQrTKjvvFjlLRBVjMTz0hS+sn6haq+HbtG08k=;
        b=oKzkRtHa5cYNcjjwI33FUZl2FS5itRaLXQmnzXOypxo/DS7V/o32qYF/9oDofijRjX
         8IAYmNSMxQx0pBH5gu2zgu1UMhqTpcr4e+8ppmCh8AlJweRguhVK8szh0bAtdhj1WVjk
         +A9E7KFBiFoTb8LtaWnLMkEF0XbAMptFIl1QxtP6GcViCveeV1RkfIQc+2tjMULiJSWO
         NH5RxiihjVyHCCyw/fQNv3GKHz8/PCoZQ1rppjeNwHwM/lEDN/uWJoJhUgdLHrIRZQZ5
         N7GreF7bDmptSPh2hfYynHm2uxqdTknAs1GJN5lnA0sjHMAVW1Kcu5v2IBXNby58As26
         b39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ke1S7+CQrTKjvvFjlLRBVjMTz0hS+sn6haq+HbtG08k=;
        b=OV2LDxdgWCeFrzy3x/uU0iY81A883PH4V0RCgiIIgwhgx0LK3If+vcmH1jFHvCWG0N
         3vMAcSMmanVFCN0EkwqOhZPIBo/JpnejepsleYvf1QVjJaeVQPdsOrmmGl4+oWwTTB5A
         yB/MvwwQxZcX8L4wW1hO5Ph9lswaFrp8fcocE8Kje4F09zRJD3rcQYXJ929gIcYazffJ
         pj0WavQF0FukT30Ebc3/2Yq6V6yWP4L9TISWb5+dcNWNo+ppq3dGEKG+mocacgWxe+FU
         0JoFrgCFkym6Jvyhb7py51vvhG1ZnHkFgkFXi/HC4PA/DfWN8JhyM02bsvFle/8+lJvS
         0sbg==
X-Gm-Message-State: AOAM533P3IDwyKw3FXdrnRKl1yezffAJzCCzKFqs33vbPswXyWMVdAnL
        kCR3jDWjDl2FPgwopDC3w3ml3ikNbnM=
X-Google-Smtp-Source: ABdhPJwC696Y9sekDFf4fBaCesoXNNYhXZZ6ESasC7bA/5an4t2WacnskChjzwyvusF8h1hwu0t+qA==
X-Received: by 2002:a05:6871:a1:b0:de:c379:77c3 with SMTP id u33-20020a05687100a100b000dec37977c3mr8888775oaa.150.1649441485470;
        Fri, 08 Apr 2022 11:11:25 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:d36a:c09a:7579:af8a? (2603-8081-140c-1a00-d36a-c09a-7579-af8a.res6.spectrum.com. [2603:8081:140c:1a00:d36a:c09a:7579:af8a])
        by smtp.gmail.com with ESMTPSA id p8-20020a0568301cc800b005b2259500e2sm9178441otg.25.2022.04.08.11.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 11:11:25 -0700 (PDT)
Message-ID: <382365f2-3a26-e2e4-a866-2a32799c90a1@gmail.com>
Date:   Fri, 8 Apr 2022 13:11:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] RDMA/rxe: Generate a completion for unsupported/invalid
 opcode
Content-Language: en-US
To:     Xiao Yang <yangx.jy@fujitsu.com>, leon@kernel.org, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org
References: <20220408033029.4789-1-yangx.jy@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220408033029.4789-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/7/22 22:30, Xiao Yang wrote:
> Current rxe_requester() doesn't generate a completion when processing an
> unsupported/invalid opcode. If rxe driver doesn't support a new opcode
> (e.g. RDMA Atomic Write) and RDMA library supports it, an application
> using the new opcode can reproduce this issue. Fix the issue by calling
> "goto err;".
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index ae5fbc79dd5c..8a1cff80a68e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -661,7 +661,7 @@ int rxe_requester(void *arg)
>  	opcode = next_opcode(qp, wqe, wqe->wr.opcode);
>  	if (unlikely(opcode < 0)) {
>  		wqe->status = IB_WC_LOC_QP_OP_ERR;
> -		goto exit;
> +		goto err;
>  	}
>  
>  	mask = rxe_opcode[opcode].mask;

Much better! This looks correct.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
