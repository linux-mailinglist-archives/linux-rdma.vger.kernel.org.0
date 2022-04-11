Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3967F4FB225
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Apr 2022 05:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbiDKDIs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Apr 2022 23:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiDKDIq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Apr 2022 23:08:46 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2399922529;
        Sun, 10 Apr 2022 20:06:34 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id t13so13002230pgn.8;
        Sun, 10 Apr 2022 20:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=domZZIKjyhx+caLkFPkY4sKrKeocGZV3+QmnNHtfeto=;
        b=6CeTirDdXMcjKUQC/Tb0Ci23b82OJpsPMXv9nFy7ZtfK6mm+sS5Z07CEwOAlkDnx6g
         7W/vYIw+PxklAe9WpsBbeOwQx7HiZetRXwItSKEoe7a/wEwMb/uc+rF8/E4xy91N3aAI
         PzXBlN+58BemKVaxt2x8o0ajCURgDzU0FPJyeKAcU8fe8NKRSdpn6f1EDFSRqoblM8kx
         pKGEy8oTfvLkzHVBHGcoyYa7+3Usaoa9EUnd6r5H4hQrfKBIjXIC6RdLAdvijc7PEPuE
         hafvjpJOcMAQYwY7aucxqLXv09lxWquBYH79TyEx+lVLwj3zJuNzW70TgiIzPRs7gNDs
         MCbw==
X-Gm-Message-State: AOAM530yJWbJgVRcIOt61MWdLrnRwc7uwBzw4i9QZcUD/l7KISib85t5
        pkOpxKLpgfV4mOpMsLVgS5s=
X-Google-Smtp-Source: ABdhPJxQ7kbPxPtDlt+MvQ9s3thMf95nrhH39WXR/TZSjmeNVFUQWQELEwuDW9Ub3UTpyYGjIL5qkQ==
X-Received: by 2002:a05:6a00:2148:b0:4fa:92f2:bae3 with SMTP id o8-20020a056a00214800b004fa92f2bae3mr30813831pfk.69.1649646393209;
        Sun, 10 Apr 2022 20:06:33 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id a27-20020aa795bb000000b00505a7541d7asm4549324pfk.35.2022.04.10.20.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 20:06:32 -0700 (PDT)
Message-ID: <ec1de70c-aa84-7c3a-af6c-4a04c5002d1e@acm.org>
Date:   Sun, 10 Apr 2022 20:06:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH for-next] RDMA/rxe: Fix "Replace red-black trees by
 xarrays"
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, yi.zhang@redhat.com
References: <20220410223939.3769-1-rpearsonhpe@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220410223939.3769-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/10/22 15:39, Bob Pearson wrote:
> Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by carrays")
                                                              ^^^^^^^
                                                              xarrays?

> @@ -138,8 +140,10 @@ void *rxe_alloc(struct rxe_pool *pool)
>   	elem->obj = obj;
>   	kref_init(&elem->ref_cnt);
>   
> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> +	xa_lock_irqsave(xa, flags);
> +	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>   			      &pool->next, GFP_KERNEL);
> +	xa_unlock_irqrestore(xa, flags);

Please take a look at the xas_unlock_type() and xas_lock_type() calls in 
__xas_nomem(). I think that the above change will trigger a GFP_KERNEL 
allocation with interrupts disabled. My understanding is that GFP_KERNEL 
allocations may sleep and hence that the above code may cause 
__xas_nomem() to sleep with interrupts disabled. I don't think that is 
allowed.

Thanks,

Bart.
