Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362EF59F4DA
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Aug 2022 10:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiHXIQB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 04:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiHXIQA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 04:16:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376A37AC25;
        Wed, 24 Aug 2022 01:15:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b44so784504edf.9;
        Wed, 24 Aug 2022 01:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=t+aZeiVlAe5lh3K/X4ugpJOclmyPgg9VuIl3dEAp86Y=;
        b=RwDOce9fW9ntXysRk36Zwo/dNQgieL4D1Psds2402Ua9G612KbPfZ3ywrawVqJ1LG9
         BoR61Fd7PcYWIU7t9kei0WDtZ7GFA98MqONFcnkWXf8/WoM9NvZNZpuiukjkP9z31xFd
         poQ3TPC8/YnhKDMUBPb2NH/eKgwBpvrFjZGuAptTXvdDt9yGyypjFl+nXQGYCL6TodmB
         SCRfQZ5Ll0QReowdWBRx27ySciQegCzT8pq4b3oR2OEX3Z8jCSfMnkX7Flm/826/VB8i
         vjt1jVPgPXGRyRTT9PRL0fN1VpRAe99IpnzK7AkQGn/iSw4EF6/dR8dsindF52H6qrBD
         0B/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=t+aZeiVlAe5lh3K/X4ugpJOclmyPgg9VuIl3dEAp86Y=;
        b=HepzZuca/tU//pWSWA+V1DeynOurr/PH9kyx8xw1+1eiYAXOVfjjY58U/BTJzygADm
         23GNJyTzlWVLFKqN6g1uYpHgUyCNfki4/gVgCYbfLBbqM3z3p3v9hQoUtUQCZ3Byt69o
         sC8Un8JWp3iEEtFwxtGb17F6ZN3o1wvkpsnkU6IT8gkpAWI/lA1V3ZLQxQB3wxUvKISx
         /Hl3QQY0R73b3lJG2S9uaemiF4HuoYoanzYvk0iQA9CKfXEGiWaGFZVBDGZZBpA5l/Kx
         FduafUH0pjM8zxpRQMpUglrobPoFfWdDUZkh40p3YgUOk3LyFPdAvibyBrMFh1ChTVxb
         0TKw==
X-Gm-Message-State: ACgBeo1s+AHDdDao+7NGXmWx8f20PeJUWX+qCBU4L3outYOBIMrBX66F
        Gx5eMYqd+TDRXWKTKOA46zM=
X-Google-Smtp-Source: AA6agR5WH9cs54GXa7c0sIrJtFNUOlFjguUIT6fJ54OYlQdQkrAW01KvKXoTr/lw8ix8/uTgzgKCRg==
X-Received: by 2002:a05:6402:e98:b0:441:a982:45bc with SMTP id h24-20020a0564020e9800b00441a98245bcmr6471619eda.239.1661328957691;
        Wed, 24 Aug 2022 01:15:57 -0700 (PDT)
Received: from [172.17.235.233] (nata195.ugent.be. [157.193.240.195])
        by smtp.gmail.com with ESMTPSA id f14-20020a170906c08e00b00711edab7622sm839529ejz.40.2022.08.24.01.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 01:15:57 -0700 (PDT)
Message-ID: <1ce29a1e-2db7-2953-b71e-c0408559ecff@gmail.com>
Date:   Wed, 24 Aug 2022 10:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] infiniband: remove unnecessary null check
Content-Language: en-US
To:     cgel.zte@gmail.com, dennis.dalessandro@cornelisnetworks.com
Cc:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220824080503.221680-1-chi.minghao@zte.com.cn>
From:   Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <20220824080503.221680-1-chi.minghao@zte.com.cn>
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

On 8/24/22 10:05, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> container_of is never null, so this null check is
> unnecessary.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/infiniband/sw/rdmavt/vt.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
> index 59481ae39505..b2d83b4958fc 100644
> --- a/drivers/infiniband/sw/rdmavt/vt.c
> +++ b/drivers/infiniband/sw/rdmavt/vt.c
> @@ -50,8 +50,6 @@ struct rvt_dev_info *rvt_alloc_device(size_t size, int nports)
>  	struct rvt_dev_info *rdi;
>  
>  	rdi = container_of(_ib_alloc_device(size), struct rvt_dev_info, ibdev);
> -	if (!rdi)
> -		return rdi;
>  
>  	rdi->ports = kcalloc(nports, sizeof(*rdi->ports), GFP_KERNEL);
>  	if (!rdi->ports)

I believe this patch is incorrect because "_ib_alloc_device" may return a null pointer.
Note that the first member of "rvt_dev_info" is "ib_device", so the check on container_of effectively checks if the allocation failed, which is necessary to check.
