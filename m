Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68618606FBC
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 07:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJUF7A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 01:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJUF66 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 01:58:58 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5930A21464D
        for <linux-rdma@vger.kernel.org>; Thu, 20 Oct 2022 22:58:55 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-13b23e29e36so1607936fac.8
        for <linux-rdma@vger.kernel.org>; Thu, 20 Oct 2022 22:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grYrDopIYX2UevTpE8lfGDonvA8vvl3YCiQ8e7PLYnA=;
        b=keXqly2uN0yOTP8fzNj7GZQ418blzkt9623Bx9rx090DBeroDJNwO74pTx08a9WqYE
         Z9uWEcZDEZYHYxbkU59hs8V9g5XgpCfuY2+ytd+g3/on/ZCM8Aug5BhmXgtz3yFBfbv/
         4oqlJfOu2otmbPBWQ5tuith5L2zj64gTLFLnkshn8IsDRBzTeEz8ObL4fd+Ary8YFA52
         zL1LD1fNLpHkX9Dq2E/4CApuLJVy86IbIowUbr3F1AVfTCjw9Leot64B32LZkVh9isjR
         Mex0ZOwLjV1e80xIy4QaTA91KW7qQIW1S5xjwjqNVDBekIySBbfMzWC1JwszYbUpNAgc
         vAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grYrDopIYX2UevTpE8lfGDonvA8vvl3YCiQ8e7PLYnA=;
        b=lMkbk72VP0k0jL6utBmyxrRsJekQ1Oiux0NRehvBNcJyMiHA9/gbXafx4Jkslvyt2b
         V2rT8IoiS+y9p2tdgxS8gLzEYE1sQScl2p3t04UcME1+VMSXOscvSDx9/5x+9U737qZ3
         CBUmzODSYH9txJd74D4sSprZZbtX25yfg3T2lJc2zwjADEHys2IWHjgQ2WTtaR6EOqso
         mnytsWAY6TEa8KglnmkFc3rVDxkj9bOyjN7tIX+ua1yqsMXVeUrB15dsZuDerjh6qYpM
         cY/bK3H7q/nPPFr72h37JeW6BqoHeK5b1DouCkFW3JVYjgRaZ+SKubzCGCPvvaRLuzo3
         UVZg==
X-Gm-Message-State: ACrzQf15eDqLxv4Bpjs7XojlWYDCaVHYKj0SRRwT83v2QXlp2k665gtV
        Xw+LGTcMDpnfMNtYZLaqz8g=
X-Google-Smtp-Source: AMsMyM7JbPq0iH2rd3wh0E17EM5rdf/WiGXmBrD1Y6/K21q7S3W0lSp7VSVPrMdG3jYoRWUxmaPu3g==
X-Received: by 2002:a05:6870:56a7:b0:136:74fb:e6df with SMTP id p39-20020a05687056a700b0013674fbe6dfmr10559439oao.37.1666331934769;
        Thu, 20 Oct 2022 22:58:54 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:6dfb:79f8:bd:7aa5? (2603-8081-140c-1a00-6dfb-79f8-00bd-7aa5.res6.spectrum.com. [2603:8081:140c:1a00:6dfb:79f8:bd:7aa5])
        by smtp.gmail.com with ESMTPSA id g3-20020a9d6c43000000b00655c6b2655esm707537otq.68.2022.10.20.22.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 22:58:54 -0700 (PDT)
Message-ID: <2ead1fb9-853d-a326-0038-69122e0a0bbb@gmail.com>
Date:   Fri, 21 Oct 2022 00:58:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH for-next] RDMA/rxe: rxe_get_av always receives ahp hence
 no put is needed
Content-Language: en-US
To:     Md Haris Iqbal <haris.phnx@gmail.com>, linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com
References: <20221020151345.412731-1-haris.phnx@gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20221020151345.412731-1-haris.phnx@gmail.com>
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

On 10/20/22 10:13, Md Haris Iqbal wrote:
> The function rxe_get_av is only used by rxe_requester, and the ahp double
> pointer is always sent. Hence there is no need to do the check.
> rxe_requester also always performs the put for ah, hence that is also not
> needed.
> 
> Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_av.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
> index 3b05314ca739..0780ffcf24a6 100644
> --- a/drivers/infiniband/sw/rxe/rxe_av.c
> +++ b/drivers/infiniband/sw/rxe/rxe_av.c
> @@ -130,11 +130,7 @@ struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt, struct rxe_ah **ahp)
>  			rxe_put(ah);
>  			return NULL;
>  		}
> -
> -		if (ahp)
> -			*ahp = ah;
> -		else
> -			rxe_put(ah);
> +		*ahp = ah;
>  
>  		return &ah->av;
>  	}

That doesn't sound right. There are several cases depending on the version of the user library
and whether the QP is UD or RC/UC. The old driver/library computed the address vector in
user space and passed it back to the kernel in the WR. If both the kernel and user library are using
the new API the user space passes back the AH# in the WR for UD commands. In both cases for
connected QPs the AV is stored in the rxe_struct_qp and there is no AH. At the point where
rxe_get_av is called the requester needs the AV it gets it from one of the three places:
the QP, the WR (old), or the kernel AH after looking up the AH#. If the kernel AH was involved
its pointer is returned so the requester can continue to hold a reference to it until it
is through sending the packet and then it can drop the reference. This to protect from
someone calling destroy_ah in a race with the send queue. Hope this makes it clearer.

Bob
