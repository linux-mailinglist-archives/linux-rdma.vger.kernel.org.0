Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F0A40A464
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 05:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbhIND2O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 23:28:14 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:33361 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238591AbhIND2O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Sep 2021 23:28:14 -0400
Received: by mail-pl1-f174.google.com with SMTP id t4so1647927plo.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 Sep 2021 20:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B+uyBjDRNlyBs3hQi9r1PYbJgCvTKLdr34SkfamlkSg=;
        b=ZQWC5uOMbjJRhwBbN6obfoFf4VemI+qpM9PnWIhinmq3z3n0sowplYN+l4ZdbmdX9U
         Gy0kgKA6nDVNeBRFbRXLG1o3hyAc7loOvDDGC3d7YvRzN4AOA9Wz+f9+zxg46cXvuA0F
         bTpyX2vNzxIRweIgWbYvlaGOBIJafR81S9+NIezcZg0prs9YXRN9aPVHOSt/YTNRAzCT
         ZuZ4/ko93AhJnunaxzoTsb5f4DSiRAqyhM7f6YHmimY8IImUJEDvqOJNC6eieuJ062e0
         sy9x74hnvX8q2Xv4OjeGYzFXKHQNOeOnYtAkHm+E9gdykn99bPiAJarp7IyD/saETLp0
         mpPg==
X-Gm-Message-State: AOAM533lmDZHT7+rX7nvBMO+7VyCTd6LQjNrlbZA5HFpjV/wW1KocXHX
        EjwfBt1bji8y3ppZGFhd62E=
X-Google-Smtp-Source: ABdhPJz0Po3iPCE6tCilPqBjjQrNqCDTkgXh2UoYy5vAGPdcuLD9U5UV93GgXIrWuC18cdSlRyOlvg==
X-Received: by 2002:a17:90b:3ec7:: with SMTP id rm7mr3154398pjb.124.1631590017065;
        Mon, 13 Sep 2021 20:26:57 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:e47e:ab85:4d9e:deba? ([2601:647:4000:d7:e47e:ab85:4d9e:deba])
        by smtp.gmail.com with ESMTPSA id y7sm3751212pjt.40.2021.09.13.20.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 20:26:56 -0700 (PDT)
Message-ID: <4d4cdf11-a073-75ce-7bf3-cf07cc205227@acm.org>
Date:   Mon, 13 Sep 2021 20:26:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH for-rc v3 0/6] RDMA/rxe: Various bug fixes.
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "Pearson, Robert B" <robert.pearson2@hpe.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "mie@igel.co.jp" <mie@igel.co.jp>, Xiao Yang <yangx.jy@fujitsu.com>
References: <20210909204456.7476-1-rpearsonhpe@gmail.com>
 <f0d96a3c-d49d-651d-93e0-a33a5eca9f1b@acm.org>
 <CS1PR8401MB10777EEC9CF95C00D1BA62ABBCD69@CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM>
 <2cb4e1cb-4552-9391-164a-88f638dd3acf@acm.org>
 <cf358367-5cb8-0482-28e6-993a4f6bb047@gmail.com>
 <918787c7-de06-ef67-80ac-ae2e7643dd61@acm.org>
 <557a5fd9-2a30-5752-d09b-05183ab3c43b@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <557a5fd9-2a30-5752-d09b-05183ab3c43b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/12/21 07:41, Bob Pearson wrote:
> Fixes: 5bcf5a59c41e ("RDMA/rxe: Protext kernel index from user space")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_queue.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
> index 85b812586ed4..72d95398e604 100644
> --- a/drivers/infiniband/sw/rxe/rxe_queue.c
> +++ b/drivers/infiniband/sw/rxe/rxe_queue.c
> @@ -63,7 +63,7 @@ struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
>   	if (*num_elem < 0)
>   		goto err1;
>   
> -	q = kmalloc(sizeof(*q), GFP_KERNEL);
> +	q = kzalloc(sizeof(*q), GFP_KERNEL);
>   	if (!q)
>   		goto err1;

Hi Bob,

If I rebase this patch series on top of kernel v5.15-rc1 then the srp 
tests from the blktests suite pass. Kernel v5.15-rc1 includes the above 
patch. Feel free to add the following to this patch series:

Tested-by: Bart Van Assche <bvanassche@acm.org>

Thanks,

Bart.
