Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D363B4598
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 16:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhFYOeY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 10:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhFYOeX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Jun 2021 10:34:23 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0624C061574;
        Fri, 25 Jun 2021 07:32:02 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id b2so9128933oiy.6;
        Fri, 25 Jun 2021 07:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dx2H69bQZWe4QiR6B44Q6ulGDcDSCCRcTocULSn2htk=;
        b=IYBd5p6Lf/paDH3Nzq0LPbYINT+V98oPEOhAQ198Pivg2bPy/LCmX18r7p3YFHWXps
         HQJkk2DFgEl+bG8eyHgoT6Et5j6E5HjN139h8wxrj7iaoJqjPr98aOiOrnSka0Qgdv8M
         oqy/VVz4Y+XZyYDvezOvU5knakwkudzN5huY6w3yb9/lmftLYmhbHcpl2bxLQZMJ7i+v
         LxI36moJKTG0MniQkzGkn4PCtkKSV/VhsLps/V5bgkBYWlXpIFg8+8CjWtkaFM1bR3kf
         pOEdedCbTjDyYGtxee0KaJG/dgY/kW8z4LRVCFt3Z2s/MJjeemggEGyO4tAfAuFrMEZi
         C5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dx2H69bQZWe4QiR6B44Q6ulGDcDSCCRcTocULSn2htk=;
        b=fytmBMVPctjBafdlgMXyabmHdtlHjkLBt1Fr5Pr5KLJqgZzZjmuCMQB4naBc1wyFvu
         OO7GWxx59d8Y8xa4iqZdXHWSaGKP4nOQ/WxTushvgIA6uJGg+SNOBZFMC9IWG8WS/kB5
         bWVcpAQp+uwg5bizqfGHotDsxbcIrd2oJxf8ackcoxLswqTjx2xdCInypuAYi54D7srK
         i9atOvnayXUGRU04q+NBvuwTAlpMDiK6UdNCUsjTUsy8q6VWchFy/xS0P2Q9EOa8Hjj8
         lhyoRI2iD8LZ1KijgnBuL9VtmttQehuRd26CGh63oul0QEBX8k0dgeF1fp1SYdCGLNGQ
         CjaQ==
X-Gm-Message-State: AOAM531++5DdmUFkHwShPc/GyhKgZRfDNJ7JbJAZ64pTWsZKT5iDX3vv
        vHGqgnRFId/7JKEH/FJ+4Sk4J7aKQOQ=
X-Google-Smtp-Source: ABdhPJxRQQi4HSht8EfIzGo6t/SKJBBGSEk7sACVLFy9k35pOMatUdJkXD5aIDw5sv6EPO4/ExTJxA==
X-Received: by 2002:aca:cf0a:: with SMTP id f10mr9303456oig.167.1624631522165;
        Fri, 25 Jun 2021 07:32:02 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:8bf2:41e6:f3a9:1be4? (2603-8081-140c-1a00-8bf2-41e6-f3a9-1be4.res6.spectrum.com. [2603:8081:140c:1a00:8bf2:41e6:f3a9:1be4])
        by smtp.gmail.com with ESMTPSA id f6sm40833oop.31.2021.06.25.07.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 07:32:01 -0700 (PDT)
Subject: Re: [PATCH] RDMA/rxe: missing unlock on error in get_srq_wqe()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <YNXUCmnPsSkPyhkm@mwanda>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <3e04bfeb-708e-d636-bf81-82dc2076db6c@gmail.com>
Date:   Fri, 25 Jun 2021 09:32:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNXUCmnPsSkPyhkm@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/25/21 8:03 AM, Dan Carpenter wrote:
> This error path needs to unlock before returning.
> 
> Fixes: ec0fa2445c18 ("RDMA/rxe: Fix over copying in get_srq_wqe")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I'm sort of surprised this one wasn't caught in testing...
> 
>  drivers/infiniband/sw/rxe/rxe_resp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 72cdb170b67b..3743dc39b60c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -314,6 +314,7 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
>  
>  	/* don't trust user space data */
>  	if (unlikely(wqe->dma.num_sge > srq->rq.max_sge)) {
> +		spin_unlock_bh(&srq->rq.consumer_lock);
>  		pr_warn("%s: invalid num_sge in SRQ entry\n", __func__);
>  		return RESPST_ERR_MALFORMED_WQE;
>  	}
> 

This is correct. Thanks.
Bob Pearson 
