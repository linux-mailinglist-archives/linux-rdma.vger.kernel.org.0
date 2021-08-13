Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7161D3EBE2E
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Aug 2021 00:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhHMWMH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Aug 2021 18:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbhHMWMF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Aug 2021 18:12:05 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D9FC061756
        for <linux-rdma@vger.kernel.org>; Fri, 13 Aug 2021 15:11:38 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bj40so18080005oib.6
        for <linux-rdma@vger.kernel.org>; Fri, 13 Aug 2021 15:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1pXOCraI0IjiVBAoX/ENihETzPEdkebs8/XD/9SkjFE=;
        b=H1VgK2YHlrnfOjB4rZAkFlJNDoehOnd2/wZEfksg7xcv82g5ghjX06kGr29hjJDfNZ
         jssqxT811Fcxx5kyiJ2mFbuZzw2uqcZaJx6pP+7b4QiLfpNQTRZxGBLZweKTgqfbz/lz
         bi9NSlvxMXqnw9c1LO6eVcXTM83s71bS7eKf4AecnxUH7A80bBwSa+WYelOKtpciFi44
         2ebIAEL7xiVcNAo6TBrXo5i71trpAwJcp9qO5bECmXSVpYo7xHf6UAZiiHrdtqlckQXS
         P1yVr9fkHNKhLwjW6eOkG4V3z1bbV6SxFYWkawLABRtVP5om8t+FHCdJZup2SwRZgNF8
         HftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1pXOCraI0IjiVBAoX/ENihETzPEdkebs8/XD/9SkjFE=;
        b=Ph5IyqKoXaXSNX1ZKJdHAjBDo1NqjYOo/EhNN4aZ7ZOKBSIynwG9KmF6iC4teuAX9e
         FJl4Y/tJ1clLMIv9s1RuqwMSs+uRtAWWdKev+MehNaCyCImQYcUx0ybWxXoGqrZ0HDId
         He4gr8hax6sOwP2SxQ2uCc3ZZn1pLZQqVjirVZWw+p1ETLsF/JPwtZTjBxEZbdbh10Fn
         aFePiAvMI7BJnRdxoaWOH940zeqTLzBFfZRBtqNO0xRbN6t0MDUUWPChKG0F+ENce1hF
         /Q3SHmNjp/NbSjZ8DJ1/rVQBoHYKu+VEHCVTMAiAkmSto8IrNKIYF50nYTKzFC+pz1sW
         /mWw==
X-Gm-Message-State: AOAM531Y70/I6dw1pFVVjnED++lep+q9PssVRpao+y0SJfPaoZz82Gcj
        ryZ2w5gmrNS1bA20XBcH2kU=
X-Google-Smtp-Source: ABdhPJwqurORjXc2wGdSfeGBuXfeHFs9oyDU/wU+4i+pne4paslHnwmLV/buOHfZ07E3yD3QB3iG0g==
X-Received: by 2002:aca:be04:: with SMTP id o4mr4000317oif.152.1628892697662;
        Fri, 13 Aug 2021 15:11:37 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:5f86:1d06:aef7:df6b? (2603-8081-140c-1a00-5f86-1d06-aef7-df6b.res6.spectrum.com. [2603:8081:140c:1a00:5f86:1d06:aef7:df6b])
        by smtp.gmail.com with ESMTPSA id bg9sm628092oib.26.2021.08.13.15.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 15:11:37 -0700 (PDT)
Subject: Re: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
To:     Xiao Yang <yangx.jy@fujitsu.com>, linux-rdma@vger.kernel.org,
        leon@kernel.org
Cc:     zyjzyj2000@gmail.com, jgg@nvidia.com
References: <20210809150738.150596-1-yangx.jy@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <7279c618-d373-d7ce-c67c-97e519b48e94@gmail.com>
Date:   Fri, 13 Aug 2021 17:11:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809150738.150596-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/9/21 10:07 AM, Xiao Yang wrote:
> Resid indicates the residual length of transmitted bytes but current
> rxe sets it to zero for inline data at the beginning.  In this case,
> request will transmit zero byte to responder wrongly.
> 
> Resid should be set to the total length of transmitted bytes at the
> beginning.
> 
> Note:
> Just remove the useless setting of resid in init_send_wqe().
> 
> Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
> Fixes: 8337db5df125 ("Providers/rxe: Implement memory windows")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  providers/rxe/rxe.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
> index 3c3ea8bb..3533a325 100644
> --- a/providers/rxe/rxe.c
> +++ b/providers/rxe/rxe.c
> @@ -1004,7 +1004,7 @@ static void wr_set_inline_data(struct ibv_qp_ex *ibqp, void *addr,
>  
>  	memcpy(wqe->dma.inline_data, addr, length);
>  	wqe->dma.length = length;
> -	wqe->dma.resid = 0;
> +	wqe->dma.resid = length;
>  }
>  
>  static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
> @@ -1035,6 +1035,7 @@ static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
>  	}
>  
>  	wqe->dma.length = tot_length;
> +	wqe->dma.resid = tot_length;
>  }
>  
>  static void wr_set_sge(struct ibv_qp_ex *ibqp, uint32_t lkey, uint64_t addr,
> @@ -1473,8 +1474,6 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
>  	if (ibwr->send_flags & IBV_SEND_INLINE) {
>  		uint8_t *inline_data = wqe->dma.inline_data;
>  
> -		wqe->dma.resid = 0;
> -
>  		for (i = 0; i < num_sge; i++) {
>  			memcpy(inline_data,
>  			       (uint8_t *)(long)ibwr->sg_list[i].addr,
> 

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
