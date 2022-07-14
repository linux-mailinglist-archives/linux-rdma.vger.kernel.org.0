Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DAF5753C4
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 19:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiGNRKn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 13:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240242AbiGNRKm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 13:10:42 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B46A4C60E
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 10:10:41 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id i126so3141688oih.4
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 10:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=prO+eAXi4GRWJIM1VuUFR3yBDnfSGov/+q+UedLQEwg=;
        b=G6QVZ3hZuXYTKi8JhGv+d/8j8Ss6PxOg0QxArZllMskbn+EyEC3Fbl+q5MLG7QTVP5
         uxi6fk8vX6eZixBuh4W500NieFvCpf1FE1Xh5aMCt577sOE2ZYCbTTRn4pfmyvxO0q7t
         rs8HA8rVgSsGgdHfF9lgqHT5KCkD9yh9IOQ/XEteLBZoqKW4MfGmWPpj5l9wZrOjkmMS
         9Vz8UQF3VmVg2a7VpAC3VYkIyXrfPx5Ql62hC23Fq73QsnlmAtl6gjuCIf/ZxdU5svqX
         Spp4f+ToX1o0nrkSxuwGsFSYvjV098nz38xiUFXEkuBW0YHs26J/MLFK4/OeCim3hQYM
         /TTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=prO+eAXi4GRWJIM1VuUFR3yBDnfSGov/+q+UedLQEwg=;
        b=q5omOOvpcWu08Hq+V1y1bLCV/FwV2bWFR5PRE9vSGcv0EC1qYeGYzPANBM8W4hVP2G
         iyWAacgsj4wEWXiSiys8sRyb2OE0tnIhUbpJTmbswz6kx56Xnl3oaSZKuC34yDDUL0EY
         7siHnRBW0NTKUi0AEFIs0jxfLHi9DIg98YLIhgf4dCDTfrwbdDPMQjPcpdn3+BGGkrB8
         YHEUakDkXzw7jFzhthJyUeJe2pC3+0cGucQHl8tr/1S3YOOM4OOCKkJdwHd4EkOZjdFX
         yXlcCjAmE6+TfZDDqm3nwOLwuxXaS0gQa/9amP51pcBeQOAhfS5oAVPIm7xAo7asCmxP
         d+lg==
X-Gm-Message-State: AJIora8sHsTyrA4xBU4zxT2yWp1K/cUwpZD+liTuSjNK2M8LIyXgDe8h
        Vg9eLzb8zCImlizttlolzzg=
X-Google-Smtp-Source: AGRyM1tRqdZCERUH9ic6CpC8zHi4kYL3Es4pEUN8mqUkZIrwfklDcybr8RLcBGv1403w9RFUYhfSkA==
X-Received: by 2002:a05:6808:e88:b0:337:9676:ddd4 with SMTP id k8-20020a0568080e8800b003379676ddd4mr4650548oil.9.1657818640735;
        Thu, 14 Jul 2022 10:10:40 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e02a:9936:8f26:4598? (2603-8081-140c-1a00-e02a-9936-8f26-4598.res6.spectrum.com. [2603:8081:140c:1a00:e02a:9936:8f26:4598])
        by smtp.gmail.com with ESMTPSA id d3-20020a05680813c300b00339fd59cfc8sm803258oiw.46.2022.07.14.10.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 10:10:39 -0700 (PDT)
Message-ID: <c6b089f0-9f50-923a-526c-af41b9a81bbc@gmail.com>
Date:   Thu, 14 Jul 2022 12:10:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 4/4] RDMA/rxe: Fix typo in comment
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     Cheng Xu <chengyou@linux.alibaba.com>
References: <20220704060806.1622849-1-lizhijian@fujitsu.com>
 <20220704060806.1622849-5-lizhijian@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220704060806.1622849-5-lizhijian@fujitsu.com>
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

On 7/4/22 01:00, lizhijian@fujitsu.com wrote:
> Fix a spelling mistake
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_task.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> index 0c4db5bb17d7..c9b80410cd5b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -67,7 +67,7 @@ void rxe_do_task(struct tasklet_struct *t)
>  				cont = 1;
>  			break;
>  
> -		/* soneone tried to run the task since the last time we called
> +		/* someone tried to run the task since the last time we called
>  		 * func, so we will call one more time regardless of the
>  		 * return value
>  		 */

I think I snuck this in recently in something else but it is correct.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
