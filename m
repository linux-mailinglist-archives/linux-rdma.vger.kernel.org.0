Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C347A4FB234
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Apr 2022 05:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241315AbiDKDPa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Apr 2022 23:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241552AbiDKDPa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Apr 2022 23:15:30 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EE22F3AE;
        Sun, 10 Apr 2022 20:13:17 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id o20-20020a9d7194000000b005cb20cf4f1bso10436636otj.7;
        Sun, 10 Apr 2022 20:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=VNJB7GSgI++flqJ/Poc6dwmZSl59SRvhL+rxI8N6WNs=;
        b=JylgToIBko0q4h5eaejYQ9IvPRyFlxcND7gd6TqAToN/n7XtjxbnTH9B3ason7DDtM
         bjWiZPenoMvqB5KIwGTSUhC1KPEGsPeTPq7AWVsWY5xN8fqOFH56Hwtk5wIJr1VamvaD
         IXNW62mRcRqek/eqdRz/sa0XlehJJhLqJ8bzTELvZw3Wc7S1eleCExtizi7nsqhNi0Vn
         uAfswydtg5t8uCZ18daD6w0Kjp0eCnhWBa+PsDAh5Y7pgl30UmFqyEBZDs/a6MLKrYJI
         tM8dIdT+rXNkrbMTKrpdszuDmcRK/2J3ik71AkgqR6g9XdmTqcJchenU51EL9OvW8sc9
         3OAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VNJB7GSgI++flqJ/Poc6dwmZSl59SRvhL+rxI8N6WNs=;
        b=h0FgQ7mtLHCROPddQ81eWuf6qGh1yKKTum2xJel0uNLTEDzT0et0Sp+dO4s2U6sjnF
         NR8HI5vS6mxqWDd/PrCs7rOxXoGKzwQXKN8p+VKSLSCc4GAXGM9LqA9RLKMQqVdi7MIk
         12lps24rFgQBHblgzAEGt9XOWncMaH+Kp/YJq7DaelroTt0n6e7mO+n1k3t1kWIpIhJm
         Gr89AgbxApfG3YmsqpxfCRMU3PeXfW5guq92cLoc1FNK+V+1zaVQ32Lkb9n/IQU/5Fj9
         O6/eWPPKl5TIUUlqSAzLvxQRuZkgmXitn9h9uLQsf7ExPjt0ikItM+XOqRWeVw/VH/Xq
         iMRw==
X-Gm-Message-State: AOAM533BJp2FOwR8nJc4us6t7coimEhLlWDjkFan62Hvw0FdGw+H9/EY
        vYrsy5EoduU4n6lxT8WoE6o=
X-Google-Smtp-Source: ABdhPJzDV/q5cw9wMWOVrDbIWtUEWwM4BD2c5QmvMXBt89Lbgjps1ONcNJkUz4A4DbVsNR6jgaclOg==
X-Received: by 2002:a9d:77d7:0:b0:5b2:29b0:70cb with SMTP id w23-20020a9d77d7000000b005b229b070cbmr10269505otl.276.1649646797282;
        Sun, 10 Apr 2022 20:13:17 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:8884:2210:b4d7:3f81? (2603-8081-140c-1a00-8884-2210-b4d7-3f81.res6.spectrum.com. [2603:8081:140c:1a00:8884:2210:b4d7:3f81])
        by smtp.gmail.com with ESMTPSA id h8-20020a056830400800b005cdceb42261sm11904481ots.66.2022.04.10.20.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 20:13:17 -0700 (PDT)
Message-ID: <6296dc52-1298-6a52-a4fb-2c6fe04ab151@gmail.com>
Date:   Sun, 10 Apr 2022 22:13:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH for-next] RDMA/rxe: Fix "Replace red-black trees by
 xarrays"
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, yi.zhang@redhat.com
References: <20220410223939.3769-1-rpearsonhpe@gmail.com>
 <ec1de70c-aa84-7c3a-af6c-4a04c5002d1e@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ec1de70c-aa84-7c3a-af6c-4a04c5002d1e@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/10/22 22:06, Bart Van Assche wrote:
> On 4/10/22 15:39, Bob Pearson wrote:
>> Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by carrays")
>                                                              ^^^^^^^
>                                                              xarrays?
> 
>> @@ -138,8 +140,10 @@ void *rxe_alloc(struct rxe_pool *pool)
>>       elem->obj = obj;
>>       kref_init(&elem->ref_cnt);
>>   -    err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>> +    xa_lock_irqsave(xa, flags);
>> +    err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>>                     &pool->next, GFP_KERNEL);
>> +    xa_unlock_irqrestore(xa, flags);
> 
> Please take a look at the xas_unlock_type() and xas_lock_type() calls in __xas_nomem(). I think that the above change will trigger a GFP_KERNEL allocation with interrupts disabled. My understanding is that GFP_KERNEL allocations may sleep and hence that the above code may cause __xas_nomem() to sleep with interrupts disabled. I don't think that is allowed.
> 
> Thanks,
> 
> Bart.

You're right. I missed that. Zhu wants to write the patch so hopefully he's on top of that.
For now we could use GFP_ATOMIC.

Bob
