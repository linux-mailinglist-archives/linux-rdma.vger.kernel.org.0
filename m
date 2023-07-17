Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58268756FD3
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jul 2023 00:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjGQWbS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jul 2023 18:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjGQWbR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jul 2023 18:31:17 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F298121;
        Mon, 17 Jul 2023 15:31:12 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a3790a0a48so3778953b6e.1;
        Mon, 17 Jul 2023 15:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689633071; x=1692225071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHDp8nB7O1cUSk6u+dkygi1nw20zAJ2ZKhqLuBxI790=;
        b=G5n13dJeXmTKv6yojdScom21ZyYUXIm+6JbNUjHBnCqk3Tjh9BDMM8zwsNi+zNqM1M
         d3BXYtSzETH0Rd90iFhzBoVsQ9ItI+wukpzw87SPGkn1nqIGTpio+Im2KsmqpSwZoexV
         SczTZWml4H1sSJA4fQMcn3BCyvyaPJMC/RJHFegzT3pvCZSl8TdQYKC4+iLc7kp/2sWe
         yOYRxtM3Q+ZQTf3W1YqphCY/ogoETWQy1UOqPdWl/DNiKGHb8MekjHzleFExMpCSf4YL
         T5lA7L1qVsU+YmDmdqL4rURyEbstAkvRzTmBdEpXSJ1C8NLzOaxDk1qoEcaG4XAl+nSw
         kjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689633071; x=1692225071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHDp8nB7O1cUSk6u+dkygi1nw20zAJ2ZKhqLuBxI790=;
        b=iCwGp8qtxWBpj+NPWwxlV4bcFg6VsSY3EMxahkG+SwgG5yWpwX9iGmWI0nloSDoDsm
         Juwg512PWILQqtRv9IR3Vw1EAdLlFeC+qCl4gQqDG7+XVvpl1G30dpK5dvUGdEdxP/Th
         tqDM1DMRJiZKtaca9uiKztFMiqmbtAwkzM9z2bNkVFepWhyFqun3X+HtoE6y0yIzjHFV
         Eo+jNAwfHpFQldUrwzgQqxZp4U0P9YpQzcLzRWITvYILkCBiXZC+6e7flfN5zsNL2/ki
         vHRIC5+Vp/IaM300PY5n/mSTWguab36tm3COCG/z+6DqzXowkxQE/Tw1+wBLvUdiWaW3
         QfdQ==
X-Gm-Message-State: ABy/qLaaXiY991fs5fdcPn3asy5SWCQ2hpmqq4Ix9E1ZyWtSTUhtITga
        Y7UXql0v1OUeMRYkR1pIYiw=
X-Google-Smtp-Source: APBJJlFBdYyBQNo03MuUiEg0P4y5KzZsEf+U7+d/55pz5eYo/yLMgvdrot/jg88363nARNsMAPiFgg==
X-Received: by 2002:a05:6808:1384:b0:3a4:1f76:bdfb with SMTP id c4-20020a056808138400b003a41f76bdfbmr15020079oiw.14.1689633071269;
        Mon, 17 Jul 2023 15:31:11 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:2f8:ff69:16db:1c31? (2603-8081-140c-1a00-02f8-ff69-16db-1c31.res6.spectrum.com. [2603:8081:140c:1a00:2f8:ff69:16db:1c31])
        by smtp.gmail.com with ESMTPSA id a14-20020a056808128e00b003a44b425c18sm184398oiw.43.2023.07.17.15.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 15:31:10 -0700 (PDT)
Message-ID: <b5880a47-aaa4-cb5e-e1f6-00f17695efe8@gmail.com>
Date:   Mon, 17 Jul 2023 17:31:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] RDMA/rxe: Fix an error handling path in rxe_bind_mw()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <43698d8a3ed4e720899eadac887427f73d7ec2eb.1689623735.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <43698d8a3ed4e720899eadac887427f73d7ec2eb.1689623735.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/17/23 14:55, Christophe JAILLET wrote:
> All errors go to the error handling path, except this one. Be consistent
> and also branch to it.
> 
> Fixes: 02ed253770fb ("RDMA/rxe: Introduce rxe access supported flags")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> /!\ Speculative /!\
> 
>    This patch is based on analysis of the surrounding code and should be
>    reviewed with care !
> 
> /!\ Speculative /!\
> ---
>  drivers/infiniband/sw/rxe/rxe_mw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
> index d8a43d87de93..d9312b5c9d20 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mw.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mw.c
> @@ -199,7 +199,8 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
>  
>  	if (access & ~RXE_ACCESS_SUPPORTED_MW) {
>  		rxe_err_mw(mw, "access %#x not supported", access);
> -		return -EOPNOTSUPP;
> +		ret = -EOPNOTSUPP;
> +		goto err_drop_mr;
>  	}
>  
>  	spin_lock_bh(&mw->lock);
Christophe,
Good catch. Thanks. Probably should go to for-next.
Bob

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
