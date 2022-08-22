Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1111259C7C9
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 21:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbiHVTCq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 15:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbiHVTCY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 15:02:24 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170EA5F70
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 12:01:17 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id j5so13312076oih.6
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=0ZCoFceewPQBXdXcK3xAuGH4lG4gWXe4JFRGcp9Lb94=;
        b=hZmCbaUxYbEOrOnoHo74L/SdG2tQ6A187afo/7+cQXc5qBU15I/DZGGGrjY2QfV73V
         ii2/QwRFe0+LbRSJov9a1cCt7Lg/D3jgmWEWurEelFNga5ILpO5E0ygaHVIXeuXxmOFh
         BHUVC2aCVX/uLEhKcaRGZnDNXHLo8esSZWaSxZCO2I4HqHOhm1K/4FmF+56tjcbFNjP8
         4lJDzF3gCQ1w6URg/K4+CLeWNVcSixt7/K4rU/80sCo44fDYG1kcTgLe245pfVatXf76
         VmzV9PbS5sIf90a3YaZN/jiyJ+wsph5Bel9wFbSLbag3c9qBHheTI0mpKsue0RKHXD5x
         2JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=0ZCoFceewPQBXdXcK3xAuGH4lG4gWXe4JFRGcp9Lb94=;
        b=7gnI/tmDXkfqoVhUDj4QNuS/DRUe4j+OvWk9uGuKYWgWnrMEZhQABivhaNmEU49AT3
         RE3bzkalkng//dvg9QDG8cfHUUhhavkIoRHZDsc3m+AAp2XNfoQ1VIZ55+Ap3kCz8ckN
         DBM0ka5DkfdoofFN0UXEMpERF4ETiPTsDVvcq7owsIYtd4mr6KWm+0zEdH7njSccI9x1
         vZgJpPy01e/IesBU8sLTHvUD3XpO3wbx4XrFACY9pGbWlwBOgh/USxTRVUbaiRu2HS1n
         PHeRpSWQc6JWc3ULmaXItupk9PQKzXTlJ5j3WOr0KoMUflwrHjLoRE3j12I9CMYY0m1T
         VLGg==
X-Gm-Message-State: ACgBeo0tFQnXdzWijXHSA+uV/oApJWUd1gML20Qvfl8mCXx2W1r++Lwl
        /Au+5IyQNEtKj/InApBvV64=
X-Google-Smtp-Source: AA6agR7Ypg/6wBkEqjzqNkxSbCi7CtGOiHc3SDwRL0SPMsA9r1evVfJ4S97/niMaYIMMhJSAtO4GiA==
X-Received: by 2002:a05:6808:3:b0:343:7d5c:ac50 with SMTP id u3-20020a056808000300b003437d5cac50mr9985691oic.108.1661194876385;
        Mon, 22 Aug 2022 12:01:16 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:fd1d:d13f:3b8b:5104? (2603-8081-140c-1a00-fd1d-d13f-3b8b-5104.res6.spectrum.com. [2603:8081:140c:1a00:fd1d:d13f:3b8b:5104])
        by smtp.gmail.com with ESMTPSA id t26-20020a0568080b3a00b003434b221a17sm2742739oij.52.2022.08.22.12.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 12:01:15 -0700 (PDT)
Message-ID: <8038c20c-37e6-bd39-54d0-be56bd88c1f9@gmail.com>
Date:   Mon, 22 Aug 2022 14:01:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] RDMA/rxe: Fix the error caused by qp->sk
Content-Language: en-US
To:     yanjun.zhu@linux.dev, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
References: <20220822011615.805603-1-yanjun.zhu@linux.dev>
 <20220822011615.805603-3-yanjun.zhu@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220822011615.805603-3-yanjun.zhu@linux.dev>
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

On 8/21/22 20:16, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> When sock_create_kern in the function rxe_qp_init_req fails,
> qp->sk is set to NULL.
> 
> Then the function rxe_create_qp will call rxe_qp_do_cleanup
> to handle allocated resource.
> 
> Before handling qp->sk, this variable should be checked.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index f10b461b9963..b229052ae91a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -835,8 +835,10 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
>  
>  	free_rd_atomic_resources(qp);
>  
> -	kernel_sock_shutdown(qp->sk, SHUT_RDWR);
> -	sock_release(qp->sk);
> +	if (qp->sk) {
> +		kernel_sock_shutdown(qp->sk, SHUT_RDWR);
> +		sock_release(qp->sk);
> +	}
>  }
>  
>  /* called when the last reference to the qp is dropped */

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
