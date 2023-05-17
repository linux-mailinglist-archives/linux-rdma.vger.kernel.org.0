Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8126B706F44
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 19:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjEQRXm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 May 2023 13:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjEQRXi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 May 2023 13:23:38 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE53676A9
        for <linux-rdma@vger.kernel.org>; Wed, 17 May 2023 10:23:25 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ab113d8589so958645a34.3
        for <linux-rdma@vger.kernel.org>; Wed, 17 May 2023 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684344205; x=1686936205;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IM00/3pkyE9ZnQLAEJtuk3k2Lek9Z+HFh75VZdkhBuA=;
        b=iJQL9ONcQCooLisO7bKTY+4T68aJYOBTMrUjzptku8hG7RtKZFn+cpevLx2KvTw/8W
         Xv+ek5AgjncxXQLDmrWSjL/9H/C3WwQaXkcNqErSBmk0LKLkixz1nfNe58zoc5myCeJW
         CuXjsCZJzaYr1K7XXOUBgU6Eh1UQpdydKdT466RJlg4N9NV5t0ljaEmLgjdt9leXd031
         MpyPTmf39lD3FEcwpe9FnZt09NcBVmk2zfGk4HPcM5UCVkQ1HsGv/3cb1ywtnhncioA+
         78exqKkbc3L+nSl+LiVdpRl26m7/d57vNFIOOGRPWda+d07wgXSweUdxU9qoK5yIZAHT
         Izxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684344205; x=1686936205;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IM00/3pkyE9ZnQLAEJtuk3k2Lek9Z+HFh75VZdkhBuA=;
        b=cROdKxKka6D/Em0r8LRR4aD+SeBnHf5BnmUKgowJQ0p2K12GpA9ySRYnZKq86CsVP8
         opnTaw7eo7IUKfuXIfbdXT3+H4VJJ9DC4SIWbpc+0mLJGbcZTNUEhNmyQEnTovDyFV6z
         m/Fo1iTbcbRBq//9F6j90TtyxA4londKxgHOF7wNFaWO+WIa8Y8ajCm7nkMYXZbIBRJO
         QtUY79XvkHdz5gNlfm7kTnXli+4upsvv4tGJOTkKvzLk/xxab7VBy10YOcxfUvtq1Wu5
         4UsDQ3Pg8Bjo4JBXHEzEnRCO9nGA2vhxXOetr4GlmSMrTTiqdL8lSsPPYcA4GVLvZhBZ
         F0Wg==
X-Gm-Message-State: AC+VfDw9/fY8mhxdFFjs0yfA2EPbxaJlRsUmw35lTjG7FLfrOmxpBsEV
        zYTyabCuDLPLHDf+hDr/Jpc9ke9g6U37Ng==
X-Google-Smtp-Source: ACHHUZ5ljL1w7SnyR5gnISO8Cm0wDXyQfGssn15RDAIECd1oRXLHcPG6wgDgh0GFaUkr5n7Qx1HmTA==
X-Received: by 2002:a05:6830:10d0:b0:6ad:e389:ca6c with SMTP id z16-20020a05683010d000b006ade389ca6cmr5238881oto.29.1684344205210;
        Wed, 17 May 2023 10:23:25 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e2d1:92d9:dfd0:d039? (2603-8081-140c-1a00-e2d1-92d9-dfd0-d039.res6.spectrum.com. [2603:8081:140c:1a00:e2d1:92d9:dfd0:d039])
        by smtp.gmail.com with ESMTPSA id c17-20020a9d75d1000000b006a64043ed69sm5695904otl.56.2023.05.17.10.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 10:23:24 -0700 (PDT)
Message-ID: <33fba83e-79ae-eea3-2218-366fe56b786a@gmail.com>
Date:   Wed, 17 May 2023 12:23:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] RDMA/rxe: Fix packet length checks
Content-Language: en-US
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
References: <20230517172037.1806288-1-rpearsonhpe@gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230517172037.1806288-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/17/23 12:20, Bob Pearson wrote:
> In rxe_net.c a received packet, from udp or loopback, is passed
> to rxe_rcv() in rxe_recv.c as a udp packet. I.e. skb->data is
> pointing at the udp header. But rxe_rcv() makes length checks
> to verify the packet is long enough to hold the roce headers as
> if it were a roce packet. I.e. skb->data pointing at the bth
> header. A runt packet would appear to have 8 more bytes than it
> actually does which may lead to incorrect behavior.
> 
> This patch calls skb_pull() to adjust the skb to point at the
> bth header before calling rxe_rcv() which fixes this error.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 2bc7361152ea..26b90b8607ef 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -159,6 +159,9 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>  	pkt->mask = RXE_GRH_MASK;
>  	pkt->paylen = be16_to_cpu(udph->len) - sizeof(*udph);
>  
> +	/* remove udp header */
> +	skb_pull(skb, sizeof(struct udphdr));
> +
>  	rxe_rcv(skb);
>  
>  	return 0;
> @@ -401,6 +404,9 @@ static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>  		return -EIO;
>  	}
>  
> +	/* remove udp header */
> +	skb_pull(skb, sizeof(struct udphdr));
> +
>  	rxe_rcv(skb);
>  
>  	return 0;

Ignore this. Should have been for-next.
