Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DE160950F
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Oct 2022 19:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiJWRSs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Oct 2022 13:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiJWRSr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Oct 2022 13:18:47 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94065B736
        for <linux-rdma@vger.kernel.org>; Sun, 23 Oct 2022 10:18:46 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso3666680fac.13
        for <linux-rdma@vger.kernel.org>; Sun, 23 Oct 2022 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZNIt+VRPW+5B/aabyXso5kEgZJPaoMhGhXHf/DRIzGw=;
        b=hrlJowI+xO4i3HPnrmGkJjeQwnLK2WMiJuOCjbfPGkmdxziCcxW4AStXBxIWlaVpVw
         XKt5AoTXKPb9Zx4+qaqfwIPMpIRbNrpM3ooz9C+eL0rHU543lqMC6ktadJieqqfiCqB4
         MNVNI2Hpug8a/suWQbBFFz5q9l9/BneAoGyXAoJz+bB3VTaQ++07eAFsmSpmoHOuPx2O
         Y3HOAQLEGHc7y68dlx1kPjrM/bFcvnnvh3FsgKqEEeJTLVzPXEnrvr72qL3XtK50uq7C
         y9UFNH4ngj7x7X3CvvL4OThg4Qt3auklZlhaYdex4siQcPK/Cq5TOzIpjg+uDBRyXqb7
         23RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNIt+VRPW+5B/aabyXso5kEgZJPaoMhGhXHf/DRIzGw=;
        b=ggKvq9l6RHIDiz1aexXTcBX5v/BUC9KYQiL3zaq5iTXpIZ5spR7PM26pVU/jONL3u2
         3cfuQF+VDpp/6OZWV28LrN8MWUNUJeDRnYwZRHDG9ieaj42Xq7FL6qDRMlljest5hbBw
         Elc9tG2YGAUDbLukje1fUEm0/tnE7YeD479UMR4qRQ4zn687l9b74fNz3dFZ2HiRVhzd
         tZ88oOvyK985DLAO0mNJE0Un1vrstz0xBcIRhttxqDT2Z11Yus3CH4nXz3mU62ptrDBJ
         81knMdvzMvMVSpSYHKVpTrdqRHNIQ6UY4+ASOdCgRqj2wqAUlTRZbpzs1sKrrJeBFTeb
         6XCw==
X-Gm-Message-State: ACrzQf3Qp2Yn4IyQgQsLzOFeZ7kKOSeKViydeImuHVjI2I95/ZERn3Lt
        R9wpwDuu9sei2bBJXmYUm2M=
X-Google-Smtp-Source: AMsMyM7twLkgntQ/5cr4Q/XPuAj1P8c3hkAxNeFR2ORpmM94E70eAjgZ4NZHmSq9ic1C0Yfr04NNYw==
X-Received: by 2002:a05:6871:7a1:b0:12c:9b31:d1b1 with SMTP id o33-20020a05687107a100b0012c9b31d1b1mr17319236oap.275.1666545526107;
        Sun, 23 Oct 2022 10:18:46 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:1e0:e60:c33:b344? (2603-8081-140c-1a00-01e0-0e60-0c33-b344.res6.spectrum.com. [2603:8081:140c:1a00:1e0:e60:c33:b344])
        by smtp.gmail.com with ESMTPSA id q185-20020acaf2c2000000b00354b619a375sm3222609oih.0.2022.10.23.10.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 10:18:45 -0700 (PDT)
Message-ID: <e6972d29-738b-eb5c-693f-3f66dd874033@gmail.com>
Date:   Sun, 23 Oct 2022 12:18:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] RDMA/rxe: Remove the member 'type' of struct rxe_mr
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     "leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>
References: <20221021134513.17730-1-yangx.jy@fujitsu.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20221021134513.17730-1-yangx.jy@fujitsu.com>
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

On 10/21/22 08:45, yangx.jy@fujitsu.com wrote:
> The member 'type' is included in both struct rxe_mr and struct ib_mr
> so remove the duplicate one of struct rxe_mr.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 16 ++++++++--------
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 502e9ada99b3..d4f10c2d1aa7 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -26,7 +26,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
>  {
>  
>  
> -	switch (mr->type) {
> +	switch (mr->ibmr.type) {
>  	case IB_MR_TYPE_DMA:
>  		return 0;
>  
> @@ -39,7 +39,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
>  
>  	default:
>  		pr_warn("%s: mr type (%d) not supported\n",
> -			__func__, mr->type);
> +			__func__, mr->ibmr.type);
>  		return -EFAULT;
>  	}
>  }
> @@ -109,7 +109,7 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr)
>  
>  	mr->access = access;
>  	mr->state = RXE_MR_STATE_VALID;
> -	mr->type = IB_MR_TYPE_DMA;
> +	mr->ibmr.type = IB_MR_TYPE_DMA;
>  }
>  
>  int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
> @@ -178,7 +178,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>  	mr->access = access;
>  	mr->offset = ib_umem_offset(umem);
>  	mr->state = RXE_MR_STATE_VALID;
> -	mr->type = IB_MR_TYPE_USER;
> +	mr->ibmr.type = IB_MR_TYPE_USER;
>  
>  	return 0;
>  
> @@ -205,7 +205,7 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
>  
>  	mr->max_buf = max_pages;
>  	mr->state = RXE_MR_STATE_FREE;
> -	mr->type = IB_MR_TYPE_MEM_REG;
> +	mr->ibmr.type = IB_MR_TYPE_MEM_REG;
>  
>  	return 0;
>  
> @@ -304,7 +304,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>  	if (length == 0)
>  		return 0;
>  
> -	if (mr->type == IB_MR_TYPE_DMA) {
> +	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
>  		u8 *src, *dest;
>  
>  		src = (dir == RXE_TO_MR_OBJ) ? addr : ((void *)(uintptr_t)iova);
> @@ -547,8 +547,8 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
>  		goto err_drop_ref;
>  	}
>  
> -	if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
> -		pr_warn("%s: mr->type (%d) is wrong type\n", __func__, mr->type);
> +	if (unlikely(mr->ibmr.type != IB_MR_TYPE_MEM_REG)) {
> +		pr_warn("%s: mr type (%d) is wrong\n", __func__, mr->ibmr.type);
>  		ret = -EINVAL;
>  		goto err_drop_ref;
>  	}
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index 5f5cbfcb3569..22a299b0a9f0 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -304,7 +304,6 @@ struct rxe_mr {
>  	u32			lkey;
>  	u32			rkey;
>  	enum rxe_mr_state	state;
> -	enum ib_mr_type		type;
>  	u32			offset;
>  	int			access;
>  

Looks good to me.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
