Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A0F7B0A75
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Sep 2023 18:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjI0QgO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Sep 2023 12:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjI0QgN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Sep 2023 12:36:13 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05345DD;
        Wed, 27 Sep 2023 09:36:07 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1dd54aca17cso3020168fac.3;
        Wed, 27 Sep 2023 09:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695832567; x=1696437367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iLvNdA6wNm+HQDFw0nR5s2Yug1qheJyO4Wo6kLd26Hk=;
        b=LNr/fg4/2i/qqbNSr0j7UYSVhWj5SJaLEWUDC27I6P2we4+s3EIdp6zMuBVRzajwdd
         yI+aYxP3jIzo5rLVicbutD+3y85NGqdeLj2m0x+IrpSSZxiUfMjofukIoXRAO/isqq2p
         Z9OxOlAc6yTFaBpwi/qHwGabMu2g/pqvcZAJb4iTDKZaaG0DiJ9Gr6ehT16EkEJRmVLQ
         1iGegeWVU1A4pCmHlO/pvoQU2UaWVmYgb+351goHFst9vDxCC4CXJ579CjtWXvZ64TIb
         XcjG+zVygV8n938fq5MhBu2afK5bOKA1Iu+E3eHv3s70emWBpTvFfkj+D+nBHtOMHYsb
         sxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695832567; x=1696437367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iLvNdA6wNm+HQDFw0nR5s2Yug1qheJyO4Wo6kLd26Hk=;
        b=v8O0oplpkQ1q9YVq7LY7yUbDZdzdVlw6Ywh6f/rqXSsUOII42A70rz3HySBChroEnA
         U98AeQkGQoxPKuQNWyyujho+ZkHXR/5iE00faxCiLlsDKreXkodu8tdl+34Oih0URzgl
         QbrJnWjXxpsjke93V40fDWfAeq+4mCl6ywhbfvCSeJAmFgCOkej1EBaA94j+sMZWXhXK
         0v1OV/IHjhLALXBgdriqgO7XfP8LxOaPNmCK5X6zLRky5KS6G44vGJ9ttsTNJAgSthCb
         C0AdozsZjSWXAghyY+g9EJKOyVxgZUh8Gbiz7fYSXC1I8502H0HaBonhhu1tnUqYuc4V
         DMsg==
X-Gm-Message-State: AOJu0YxEWmkrB/lSylDq6aIjxlp38sNnaRw5xCI18yk2otXZnwJtSkz4
        x6m4Z3vQeA8ZYyasGeOqYIo=
X-Google-Smtp-Source: AGHT+IFGI9LuyhBTFKnF8s3xo4FoEsv/yRaVA5SnA81GDyVsHNrqOd3IvFXcY41T8uKslD1qQhHXJA==
X-Received: by 2002:a05:6870:d24d:b0:1c1:12dc:70b1 with SMTP id h13-20020a056870d24d00b001c112dc70b1mr2809280oac.57.1695832566993;
        Wed, 27 Sep 2023 09:36:06 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:78f5:97a9:4cba:5728? (2603-8081-1405-679b-78f5-97a9-4cba-5728.res6.spectrum.com. [2603:8081:1405:679b:78f5:97a9:4cba:5728])
        by smtp.gmail.com with ESMTPSA id i5-20020a056870344500b001d4f1ec39b3sm3220649oah.23.2023.09.27.09.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 09:36:06 -0700 (PDT)
Message-ID: <6fe0a64c-704f-6c8b-6a24-d725e7629d3a@gmail.com>
Date:   Wed, 27 Sep 2023 11:36:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
To:     Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        matsuda-daisuke@fujitsu.com, shinichiro.kawasaki@wdc.com,
        linux-scsi@vger.kernel.org, Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
References: <20230922163231.2237811-1-yanjun.zhu@intel.com>
 <169572143704.2702191.3921040309512111011.b4-ty@kernel.org>
 <20230926140656.GM1642130@unreal>
 <d3c05064-a88b-4719-a390-6bf9ae01fba5@acm.org>
 <b7b365e3-dd11-bc66-dace-05478766bf41@gmail.com>
 <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/26/23 15:24, Bart Van Assche wrote:
> On 9/26/23 11:34, Bob Pearson wrote:
>> I am working to try to reproduce the KASAN warning. Unfortunately,
>> so far I am not able to see it in Ubuntu + Linus' kernel (as you described) on metal. The config file is different but copies the CONFIG_KASAN_xxx exactly as yours. With KASAN enabled it hangs on every iteration of srp/002 but without a KASAN warning. I am now building an openSuSE VM for qemu and will see if that causes the warning.
> 
> Hi Bob,
> 
> Did you try to understand the report that I shared? 

Looking at the three stack traces from KASAN (alloc, free, and use after free)
it appears that there was an ack packet (skb) created in rxe_responder (normal) and
then passed to rxe_completer which apparently successfully processed it and then
freed the skb (also normal). Then the same skb is enqueued on the response queue
in rxe_comp_queue_pkt(). This is very strange and hard to understand. The only way
the original packet could have been 'completed' would be for it to have been first
enqueued on qp->resp_pkts by skb_queue_tail() and then dequeued after the completer
task runs by skb_dequeue(). The skb queue routines are protected by an irqsave spinlock
so they should operate atomically. In other words the completer can't get the skb until
skb_queue_tail() is finished touching the skb. So it looks like the first pass through
rxe_comp_queue_pkt() shouldn't be to blame. There is no way I can imagine that the
packet could be queued twice on the local loopback path. One strange thing in the
trace is a "? rxe_recv_mcast_pkt" which seems unlikely to be true as all the packets
are rc and hence not mcast. Not sure how to interpret this. Perhaps the stack is
corrupted from scribbles which might cause the above impossibility.

My conclusion from
> the report is that when using tasklets rxe_completer() only runs after
> rxe_requester() has finished and also that when using work queues that
> rxe_completer() may run concurrently with rxe_requester(). 

The completer task was always intended to run in parallel with the requester
and responder tasks whether they are tasklets or workqueue items. Tasklets
tend to run sequentially but there is no reason whey they can't run in
parallel. The completer task is triggered by response packets from another
process's queue pair which is asynchronous from the requester task which
generated the request packets.

For unrelated reasons I am planning to merge the requester task and completer
task into a single task because in high scale situation with lots of qps
it performs better and allows removing some of the locking between them.

This patch
> seems to fix all issues that I ran into with the rdma_rxe workqueue
> patch (I have not tried to verify the performance implications of this
> patch):
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> index 1501120d4f52..6cd5d5a7a316 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -10,7 +10,7 @@ static struct workqueue_struct *rxe_wq;
> 
>  int rxe_alloc_wq(void)
>  {
> -       rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
> +       rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, 1);
>         if (!rxe_wq)
>                 return -ENOMEM;
> 
> Thanks,
> 
> Bart.

