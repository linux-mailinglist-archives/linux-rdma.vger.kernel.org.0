Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9178D5A162C
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 17:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242308AbiHYPzx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 11:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiHYPzu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 11:55:50 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FB4A3D4B
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 08:55:50 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id r124so8226926oig.11
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=j4raTDWjHLuuS07in2tmp//eqfbR4qdt1Uhlb1U+3Bc=;
        b=aTh6wpuiuxRUDsx2eG7bUHyTzFM9a0Tsciy4qwE+MpLdmWXGJJNBGgvByC5qt0sSKa
         2zuqCzUjKr95Te4uG1HgAA3YcYvq/26a1GAJnDZPqLh0110lBsrqRD7VIkJ5LdVFEpr8
         VfkbESVRLtMU7qUnxmknfNpK07oB9XaGQaWaltBKoXQMR/d+sSOKHKgw4AtNWfwqohHY
         rh+1izWE5INVSOwVeoTEBrz2eMk7HxuX+ZqYNTciomX2p2fVAGDgdzSQFqUJTcYn4kKI
         WzpHqMD3p1RTMUed/RAaPG0CDD0VNrWiFsGkkvDcjZE9BwS0IJEsZbFYklkJM3S0w7j8
         VNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=j4raTDWjHLuuS07in2tmp//eqfbR4qdt1Uhlb1U+3Bc=;
        b=ogbsZdfTtCKLH1aKq6mb3TPrCB1114K0XZc88NWfjWo0/Ry4KRzCOdq0CE51/qAzSr
         V4eMlLGg9LUpyjCbQ7Qr4E1S9p+VcoRFGxOd6Tmmt8HF8Z8BSYkez/y3vXRrBmtrH4ux
         Z4WzvD7vRy2rC/S2KkrshE/iRJBD2nPdChFTbsfdP15fAWuS3cjv3aeIH+25w+3IgzN7
         DXHwf/HPbWl1ZRIuebZLeViw6RZ4S9zMcHiIEhs+7pjq8/gpIlC7ZqinLc4tQ8QSV0RW
         j0mkk3GW8F5iHehPmesxEgQBFojXFcSwzkxFZU80IpxTSn7W5GcBF81SnBF8Z1DIH/tf
         5aqA==
X-Gm-Message-State: ACgBeo1z02SZg3OqpCmhQCV8jjcyk+5oxB5KsbzcB9G/pgn8u1AAoBhL
        KqHalFdh2KZiGKeRT6oRGAhnnwnqsFM=
X-Google-Smtp-Source: AA6agR69/6MEk/BSId9sX+aLvw5n8AsDlDM6VphjXhIdy/qy3gVsJYnwQ5SAtC/b/MtWsmEr3KntnA==
X-Received: by 2002:aca:4189:0:b0:344:d96f:4635 with SMTP id o131-20020aca4189000000b00344d96f4635mr5406983oia.131.1661442949388;
        Thu, 25 Aug 2022 08:55:49 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:7131:3a1c:71e2:864? (2603-8081-140c-1a00-7131-3a1c-71e2-0864.res6.spectrum.com. [2603:8081:140c:1a00:7131:3a1c:71e2:864])
        by smtp.gmail.com with ESMTPSA id 127-20020a4a1b85000000b0044b47bb023fsm1042011oop.37.2022.08.25.08.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 08:55:48 -0700 (PDT)
Message-ID: <25051057-e077-a470-5998-6456e2467232@gmail.com>
Date:   Thu, 25 Aug 2022 10:55:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/rxe: Ratelimit error messages of read_reply()
Content-Language: en-US
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>, leonro@nvidia.com,
        jgg@nvidia.com, zyjzyj2000@gmail.com
Cc:     linux-rdma@vger.kernel.org
References: <20220825110255.658706-1-matsuda-daisuke@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220825110255.658706-1-matsuda-daisuke@fujitsu.com>
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

On 8/25/22 06:02, Daisuke Matsuda wrote:
> When responder cannot copy data from a user MR, error messages overflow.
> This is because an incoming RDMA Read request can results in multiple Read
> responses. If the target MR is somehow unavailable, then the error message
> is generated for every Read response.
> 
> For the same reason, the error message for packet transmission should also
> be ratelimited.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index b36ec5c4d5e0..f9e9679b5e32 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -812,7 +812,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>  	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>  			  payload, RXE_FROM_MR_OBJ);
>  	if (err)
> -		pr_err("Failed copying memory\n");
> +		pr_err_ratelimited("Failed copying memory\n");
>  	if (mr)
>  		rxe_put(mr);
>  
> @@ -824,7 +824,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>  
>  	err = rxe_xmit_packet(qp, &ack_pkt, skb);
>  	if (err) {
> -		pr_err("Failed sending RDMA reply.\n");
> +		pr_err_ratelimited("Failed sending RDMA reply.\n");
>  		return RESPST_ERR_RNR;
>  	}
>  

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
