Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D92D60B17A
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 18:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiJXQZz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 12:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiJXQZV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 12:25:21 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183417295B;
        Mon, 24 Oct 2022 08:11:45 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-13b103a3e5dso12207702fac.2;
        Mon, 24 Oct 2022 08:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+Yuvpt1GSZqGdrT4ZNMksu/TT2o+vLhvUeXJWl+juA=;
        b=G3hjXjpuTgIb1v0BBsl9aKj1EeJjNNdnxPSboKpkfA2YaDukveKgRQdCoDEpf0GYZi
         uEBqCEoDdFXNFRwdPo/nxG/fxBaDRGUIGi6hSsN+WwMCoB45wT5VVuSfG/PROayYWmar
         OLJqwR8SDBiTYgxsfuzaPIreO7LOXSSdqkmF1dWM2+0eJrALq6ZmxpUTPJMUPFpBks2P
         7RoV7oDfDNGsHRzCTR0xTQd/OyUKY+L3eoWjo697xELzT3PdFI2XpaglgiWlfOwGvEh1
         TyLvXFLu4r07xyGrNxgrY6FUzgEU11lz9nGGDDAO671FPgmJOTlfCVO/5LQi1VlFxPCX
         okIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+Yuvpt1GSZqGdrT4ZNMksu/TT2o+vLhvUeXJWl+juA=;
        b=56rM6zyUcOahViMCT9WnS1P0EKCuOZUGdt9xnPXh3LcKB1ldTMvGHC5YcVhO0s6th+
         FBQ0ZN5jB8ZsNb+jMPmdH6M9+KMHEMk1qvOqwxOXKL1DVcaBqyXd+IQkQyQOiESeAx+2
         ZcuqhsAlX1rkCo/AlwAmP/XE5Y1/hVexNchUpjzAiE9Twz7V1aZsg/KRemZXD9RJrjIq
         nB1qI8FlVlmDtUmCtvuWzgrOlNC9k7nvy0SquOxChyp0YGZeBux8o14XThmohJ0ZWPxL
         KIlWVHgKwUAxE3FpxFMYeeUaSBw3PSboeOdhNddotZw//us8MLeUti3n62Npnnaf5vqi
         MR8g==
X-Gm-Message-State: ACrzQf2ZdsJCfowBPuTPM+RTvcrI2vrYrT18kVARR+RP/jI06ZtxZ3Zj
        P/hW5bMvgYO2B+zOJL9RT02XbUYQMDo=
X-Google-Smtp-Source: AMsMyM5UPuATp0U6GswxRNGFVsyX6hVuubEeKJjtgK1rqAC7YNJAZLcqV4sonzcmR32W9vmIqZ9vmA==
X-Received: by 2002:a54:4001:0:b0:355:385e:c07b with SMTP id x1-20020a544001000000b00355385ec07bmr20006904oie.36.1666620617164;
        Mon, 24 Oct 2022 07:10:17 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:1e0:e60:c33:b344? (2603-8081-140c-1a00-01e0-0e60-0c33-b344.res6.spectrum.com. [2603:8081:140c:1a00:1e0:e60:c33:b344])
        by smtp.gmail.com with ESMTPSA id a5-20020a05680802c500b0034fd36e95bfsm3960219oid.31.2022.10.24.07.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:10:16 -0700 (PDT)
Message-ID: <fe897b45-b556-1a4b-d3db-e674f76e5234@gmail.com>
Date:   Mon, 24 Oct 2022 09:10:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH for-next v3 1/2] RDMA/rxe: Remove unnecessary mr testing
Content-Language: en-US
To:     Li Zhijian <lizhijian@fujitsu.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1666582315-2-1-git-send-email-lizhijian@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <1666582315-2-1-git-send-email-lizhijian@fujitsu.com>
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

On 10/23/22 22:31, Li Zhijian wrote:
> Before the testing, we already passed it to rxe_mr_copy() where mr could
> be dereferenced. so this checking is not needed.
> 
> The only way that mr is NULL is when it reaches below line 780 with
>  'qp->resp.mr = NULL', which is not possible in Bob's explanation[1].
> 
>  778         if (res->state == rdatm_res_state_new) {
>  779                 if (!res->replay) {
>  780                         mr = qp->resp.mr;
>  781                         qp->resp.mr = NULL;
>  782                 } else {
> 
> [1] https://lore.kernel.org/lkml/30ff25c4-ce66-eac4-eaa2-64c0db203a19@gmail.com/
> 
> CC: Bob Pearson <rpearsonhpe@gmail.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V3: remove WARN_ON # Yanjun and Bob
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index ed5a09e86417..b02639cf8cba 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -811,8 +811,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>  
>  	rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>  		    payload, RXE_FROM_MR_OBJ);
> -	if (mr)
> -		rxe_put(mr);
> +	rxe_put(mr);
>  
>  	if (bth_pad(&ack_pkt)) {
>  		u8 *pad = payload_addr(&ack_pkt) + payload;

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
