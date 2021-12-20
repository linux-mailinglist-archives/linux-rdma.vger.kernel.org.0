Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF41847B287
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Dec 2021 19:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240339AbhLTSDy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Dec 2021 13:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240344AbhLTSDw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Dec 2021 13:03:52 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D174EC061756;
        Mon, 20 Dec 2021 10:03:51 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso13605422otf.0;
        Mon, 20 Dec 2021 10:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cKZsIJDWWTwCIgi/2NihvVcIBzyaJLdAfiGfAj1Uxuo=;
        b=dIs6ErdXWcyhQgra2IgIOLuDQxBQ1KkMK1FwYx+LYxqeyyIQwxgzeh/gzDo2BeJMSL
         n/2iUcZiDmkj3oohOSdk9OBjvHcK7oocP7otYQwCn4Dkk7XIbnex74LYSUIVA3x/iZNY
         XR/m16otuPILqnyQW0V1odQ1ogCqTcF2IUblxzVQjgErN4rc/MbxFlOVDJjXghbFJvTm
         AmKmYvVa0xSSqUqg5deti56HzZ2m89IJdL7Vdd2jdUlsTTT/T0snmeWzBd7UyqzQ/53P
         qmAe3bgZ1lFVvx7dHpcTJ9LA2EVKpwCy47ySUwpmWw9VLZDjKI0u7X9aob7fm6BIpghT
         CNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cKZsIJDWWTwCIgi/2NihvVcIBzyaJLdAfiGfAj1Uxuo=;
        b=bRnOaE4uCoIC6hImMzB1Ow8vyOCylrOJuFimIlIaOprUyi5J0mcegibDXpyW3hPUm9
         +SmuJNJNltJd9JQk8GUZBSjY6BIIevFJnsQrtLC7W5pgSiefXq8uYkOmYYmnm54N9Bqt
         2BOebl+miBv3T+3r5U+Rx++Uu9ZfyNvFO2H4t6Vq2o2VDhb6A2X2DWFZQ9Ji0nWY3BRs
         TrU2B5O7FlUM6jRw2EnWUeFwEYGrPEP/PWkET+BLnzLWemJV3/gQQhjoVVBMSnhSyP8K
         1obknB5e+h2NIJGCTV/PrM+5NLZ7BDLb3aHi+I4mZv2g9yGjZZvHAsWJdfEG+OuXcnPd
         GyYQ==
X-Gm-Message-State: AOAM53365wRYK3RAHLt0OiXkmu1MacG/wFJQljTzhSPyTO+8wPPARnUn
        +sbpN2Yvm0T9WpCQ39+Lw2XUZdt9jgc=
X-Google-Smtp-Source: ABdhPJzC6fVrBcFBEQYb88Z1X3S3GiAEZvPUdZxWo1kHcbCWZn1uhA3Z2NMcoSbq3Lp/5IreErTY0Q==
X-Received: by 2002:a9d:5549:: with SMTP id h9mr12372501oti.36.1640023431269;
        Mon, 20 Dec 2021 10:03:51 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:5ca2:d0f7:3dc4:a0f8? (2603-8081-140c-1a00-5ca2-d0f7-3dc4-a0f8.res6.spectrum.com. [2603:8081:140c:1a00:5ca2:d0f7:3dc4:a0f8])
        by smtp.gmail.com with ESMTPSA id y17sm3414201ote.48.2021.12.20.10.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 10:03:50 -0800 (PST)
Message-ID: <e5d50502-7adc-d773-2a18-307f8d0592e7@gmail.com>
Date:   Mon, 20 Dec 2021 12:03:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] RDMA/rxe: fix a typo in opcode name
Content-Language: en-US
To:     Chengguang Xu <cgxu519@mykernel.net>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211218112320.3558770-1-cgxu519@mykernel.net>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20211218112320.3558770-1-cgxu519@mykernel.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/18/21 05:23, Chengguang Xu wrote:
> There is a redundant ']' in the name of opcode IB_OPCODE_RC_SEND_MIDDLE,
> so just fix it.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  drivers/infiniband/sw/rxe/rxe_opcode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
> index 3ef5a10a6efd..47ebaac8f475 100644
> --- a/drivers/infiniband/sw/rxe/rxe_opcode.c
> +++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
> @@ -117,7 +117,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
>  		}
>  	},
>  	[IB_OPCODE_RC_SEND_MIDDLE]		= {
> -		.name	= "IB_OPCODE_RC_SEND_MIDDLE]",
> +		.name	= "IB_OPCODE_RC_SEND_MIDDLE",
>  		.mask	= RXE_PAYLOAD_MASK | RXE_REQ_MASK | RXE_SEND_MASK
>  				| RXE_MIDDLE_MASK,
>  		.length = RXE_BTH_BYTES,
> 

Looks good

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
