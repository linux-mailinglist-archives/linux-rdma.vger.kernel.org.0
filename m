Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43AD57523F
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 17:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbiGNPzX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 11:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236976AbiGNPzW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 11:55:22 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC6D43E64
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 08:55:21 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10c0d96953fso3009227fac.0
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VtEYPwlC7Zn/3kmA2mVhNKeM5TiON7GnygFhE6Rq7tQ=;
        b=WSlgzGn+RQBJBiu3AO9oAfonBAUtdYc4i8WXDlTzUn98Le12MvRlbH3rLWkZmOaCdq
         n15vOCxmXntw1eCgFcqlnBODExIB1CBL9XPPcsMqZyidhogUFyVqWx0rIOAgJyx039Av
         3eP60AH540AZrzJMEWc6nC13NCUIsF+8nhGEYN0ncOoTFp2zfHOjgrsl63Br9xYqjZF1
         D101CiHjbeE75RmnTNp4ITX9ECqN/SAr6QiV2+njqnuJkjoAd7PEuuqnN/D5pKhaOVV0
         Gm5SXTBNK7NkVuZwYItQ2ywB7lSK+EI1n8RQGi0XC/riY4w2qQMC1p8SCLAr+cXy4x+0
         ZXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VtEYPwlC7Zn/3kmA2mVhNKeM5TiON7GnygFhE6Rq7tQ=;
        b=EzGnTD87MeWlKdhitF5S1kZkkcBhXHknFpFpwOw79FcPGMBh/EGSU/xHX+cu/OxbC2
         dHcakJnYY8Qsk3JdpFpdM0vdmOVRbv2IkP5v1wEAGTJcc0OuxhgMmqFIZvWqrW5kUJMe
         urkrM2SFvpGQU0gCzLWsRpFWXVtjZ7Hw4nh+YblvQdTceLhkDSWx6Wp4a93U8SGC+16V
         UBMTrPWdJa6JT23vJ0SVehHCmkLrxeAfL/BqO3hYKE7mpXwepac3VyItJk/XXan4HihV
         kQF5HF1DAYrzio0yJ171y3qRJiHnSuODmYjvVDggnXytQP8VCkJW+nC7Jwpwu5fZN/ei
         VgTw==
X-Gm-Message-State: AJIora8+WMqjPLqj6Y9wDnneefMBfZEDesYQjK4NlHbM3rbNa+AML+aV
        8ZRlHxEF4ELnrnzdV7LUZ0orT8BeA/8=
X-Google-Smtp-Source: AGRyM1vuWyfMdtPstgoFpwGjb2WemJ3h1GETjtBx0IDjrVgHpdzVV7cjGID5l0upJVEyC2QevVfx+A==
X-Received: by 2002:a05:6870:1705:b0:10c:c22:3dc5 with SMTP id h5-20020a056870170500b0010c0c223dc5mr4941592oae.55.1657814121109;
        Thu, 14 Jul 2022 08:55:21 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e02a:9936:8f26:4598? (2603-8081-140c-1a00-e02a-9936-8f26-4598.res6.spectrum.com. [2603:8081:140c:1a00:e02a:9936:8f26:4598])
        by smtp.gmail.com with ESMTPSA id y24-20020a0568301d9800b00616929b93d6sm803638oti.14.2022.07.14.08.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 08:55:20 -0700 (PDT)
Message-ID: <d9790ed0-266e-d2a1-9968-d83ca0a43f65@gmail.com>
Date:   Thu, 14 Jul 2022 10:55:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/rxe: Use correct ATOMIC Acknowledge opcode in BTH
Content-Language: en-US
To:     Xiao Yang <yangx.jy@fujitsu.com>, linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com
References: <20220705155705.21094-1-yangx.jy@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220705155705.21094-1-yangx.jy@fujitsu.com>
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

On 7/5/22 10:57, Xiao Yang wrote:
> When responder processed an Atomic requeset and got a NAK,
> the opcode field in BTH should be ATOMIC Acknowledge instead
> of Acknowledge.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 265e46fe050f..592d73c37d48 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -1080,10 +1080,10 @@ static enum resp_states acknowledge(struct rxe_qp *qp,
>  	if (qp_type(qp) != IB_QPT_RC)
>  		return RESPST_CLEANUP;
>  
> -	if (qp->resp.aeth_syndrome != AETH_ACK_UNLIMITED)
> +	if (pkt->mask & RXE_ATOMIC_MASK)
> +		send_atomic_ack(qp, qp->resp.aeth_syndrome, pkt->psn);
> +	else if (qp->resp.aeth_syndrome != AETH_ACK_UNLIMITED)
>  		send_ack(qp, qp->resp.aeth_syndrome, pkt->psn);
> -	else if (pkt->mask & RXE_ATOMIC_MASK)
> -		send_atomic_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
>  	else if (bth_ack(pkt))
>  		send_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
>  

Xaio,

Just saw this. The difference between the two opcodes tells if there is an 
AtomicAckETH present. If the operation fails there is no data to send back
so there is only an AETH in the reply packet and Acknowledge is the correct
opcode. When the packet is parsed if you use AtomicAcknowledge for a failed
atomic operation you will get the wrong offsets when you lookup the header
offsets in rxe_opcode[] which not surprisingly leads to problems.

Bob
