Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6223F340D
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 20:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbhHTSoy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 14:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhHTSox (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Aug 2021 14:44:53 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF83C061575
        for <linux-rdma@vger.kernel.org>; Fri, 20 Aug 2021 11:44:15 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so16034893oti.0
        for <linux-rdma@vger.kernel.org>; Fri, 20 Aug 2021 11:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XsigljT68BQQolze4oypxgLjdWh/wlC4MSo9hi+b9uA=;
        b=izKzUISxuyc9tbb1fJIFN6nn5Xs445qR4AEq3NpJq07uWBJJUCeKOSzR/OUUjFFuT5
         4uH9p1GY3yOo2XJfw430MjcHWYgUiRtcwUszDjDhh7KtzlVZ1uy39atGlGW7y4Oq+YVC
         Y3A3k26cVOgg2s7rP/Q7geQkOaEIzdhjP5UlgCaGfQe20gyvmarniStxMYw9UubcuWXP
         zPBkIlrS/ocX1N+EmW98kYgrrHc8WR2QbEKKWUKMNPbRG5sBhwswaBiayvUCSa5Sr8dg
         O0VClOvUCitK3t/2jPnf7jrckIQIV1imb3WMphlYeAaTTOSNjPgNCE8Wwa+opGsnJogw
         +3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XsigljT68BQQolze4oypxgLjdWh/wlC4MSo9hi+b9uA=;
        b=eQitq39q8FgH8jjAOja/DdO6jYicfmOFvBuvZCC+4quKexZGACjfm0HTESFfFYBlKf
         zgJA9BTX3qCZfaArBFcN6U9O0t0SNfaD8yxkyifRHWnii2ViIuyFAbikbO+xzsAc2K0H
         6w6I1WXcIcm523ew0xBxzKYBXruIDNBkSCJBz/p+HSUS98tp9VYdvmdFTX46Vjp/hU5L
         UhPcwH4BGL4mwsHHpUMb7aF7uE0QYu516VGLCRbwsFhe7CU1AMX7F3SlPxIpNviwAFi2
         JgHTvoiXJYAVvi3g39PCct7d2SXwb6BKNzST+OElaUBMCNmLWiQ/ulh5SPkn8bPrsGa2
         BkNQ==
X-Gm-Message-State: AOAM533FAz12CwtW7nsEAbHByPhLmlSIS7R1CQdbRyBFhFte5B8jUGTF
        yBGw1LWDEi1NKENbfmap8ro=
X-Google-Smtp-Source: ABdhPJzrFYG9tJ29eT+CXVrd9mxoc5adjHbM1lWjSg9tjAkEPcx07uz/Kej/1OH9wRB2MEjUyajJmw==
X-Received: by 2002:a05:6830:1f59:: with SMTP id u25mr18466423oth.321.1629485054530;
        Fri, 20 Aug 2021 11:44:14 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:18a5:8e2a:9f3f:746c? (2603-8081-140c-1a00-18a5-8e2a-9f3f-746c.res6.spectrum.com. [2603:8081:140c:1a00:18a5:8e2a:9f3f:746c])
        by smtp.gmail.com with ESMTPSA id j70sm1651930otj.38.2021.08.20.11.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 11:44:14 -0700 (PDT)
Subject: Re: [PATCH] RDMA/rxe: Zero out index member of struct rxe_queue
To:     Xiao Yang <yangx.jy@fujitsu.com>, linux-rdma@vger.kernel.org
Cc:     aglo@umich.edu, zyjzyj2000@gmail.com, jgg@nvidia.com,
        leon@kernel.org
References: <20210820111509.172500-1-yangx.jy@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <9302c160-5905-0bf3-5e1c-98d673aaa2fc@gmail.com>
Date:   Fri, 20 Aug 2021 13:44:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210820111509.172500-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/20/21 6:15 AM, Xiao Yang wrote:
> 1) New index member of struct rxe_queue is introduced but not zeroed
>    so the initial value of index may be random.
> 2) Current index is not masked off to index_mask.
> In such case, producer_addr() and consumer_addr() will get an invalid
> address by the random index and then accessing the invalid address
> triggers the following panic:
> "BUG: unable to handle page fault for address: ffff9ae2c07a1414"
> 
> Fix the issue by using kzalloc() to zero out index member.
> 
> Fixes: 5bcf5a59c41e ("RDMA/rxe: Protext kernel index from user space")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
> index 85b812586ed4..72d95398e604 100644
> --- a/drivers/infiniband/sw/rxe/rxe_queue.c
> +++ b/drivers/infiniband/sw/rxe/rxe_queue.c
> @@ -63,7 +63,7 @@ struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
>  	if (*num_elem < 0)
>  		goto err1;
>  
> -	q = kmalloc(sizeof(*q), GFP_KERNEL);
> +	q = kzalloc(sizeof(*q), GFP_KERNEL);
>  	if (!q)
>  		goto err1;
>  
> 

Thanks for this!! I am happy to take the blame but this has been there from the original 2016 rxe commit. Its a good catch.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
