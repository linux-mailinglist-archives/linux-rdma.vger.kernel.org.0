Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9E17B0AA8
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Sep 2023 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjI0QvV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Sep 2023 12:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0QvT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Sep 2023 12:51:19 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1E091;
        Wed, 27 Sep 2023 09:51:17 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57b72cef02bso4983604eaf.2;
        Wed, 27 Sep 2023 09:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695833477; x=1696438277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=coeKn5XKG2XiITtG+Yo8/G2lfovjELvfvnxZtt4gVZE=;
        b=eIM1FCSPNwsw+HqZgndM3JVxRKiWsbR1OBJqtyVg0sBet9Rw6BCtXF8Bzpffflj9Mq
         exC8/+nS0Lc26RjJQm3waWCRaD0xwBfN48gQHphE0Y3Gbj8yPe3PYr3xmeUfmhypxHlP
         R6yv5Z7Rc+KX2XaWMWyTWns8mzx1E1ddTp4uGA/8SMWwa0cgsgX6ZiFej5v0FznaLZ9A
         B20NW52q8mqdqR4VvO31jxbC/M1nKlfGy3U+HukBXuqenMAVhMUvZUw+Mo+w2H8PLIuG
         Wrt7YJRi/paXy7VuMioDWy/qBadOCbzEzgMJxu9wh3ciXY0rNCJUDUeRIN4qXibTFo+V
         UbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695833477; x=1696438277;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coeKn5XKG2XiITtG+Yo8/G2lfovjELvfvnxZtt4gVZE=;
        b=S6SKzgEghHW+4OGyEuULZPBwvkEU7gLqouF3eVn07yS9it7TYOv6ZjDYEZ130oMHhO
         t5FU0yhBn4GWvG+laok9vDF5EXeaqstVg+uKv59mh9RsSZn7yPO/nmLjGVqVF7s3NmiG
         2Bmb+zRFIdN/yDTSB0m1PCSTyv4IUdFsPXJDUNOfhb8LL4g/cq/VAwWKW4LPu6OgG1cJ
         ZwnYeZV0HMedZgJvsNubdQ7R0dbPfVwxRSFVTt11rtD6MYWpQKD5/xVR64oAp6CBq2xC
         xMyDcl3U6WW3CQiKxVIipDyuQRMiBWaptB7mpaMgvgTyKhs64Xs8Lym1+ge9nEpQtlvC
         +ILQ==
X-Gm-Message-State: AOJu0YysfDUayJJOdiC8QrNem4rrALSBZZZSIkcpFx1zio1xa50qvjpB
        c7FZn8x1cN/kOYFrzIrIhyQ=
X-Google-Smtp-Source: AGHT+IF947ld2FwwpJoboIpx6kYze4GN8RJdaJrIaSG53mUSJyuE8D5CI4EtXoeYiG2HsVVz40LinA==
X-Received: by 2002:a4a:6219:0:b0:57b:cbc2:79ff with SMTP id x25-20020a4a6219000000b0057bcbc279ffmr2587900ooc.4.1695833477052;
        Wed, 27 Sep 2023 09:51:17 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:78f5:97a9:4cba:5728? (2603-8081-1405-679b-78f5-97a9-4cba-5728.res6.spectrum.com. [2603:8081:1405:679b:78f5:97a9:4cba:5728])
        by smtp.gmail.com with ESMTPSA id v18-20020a4a8c52000000b0055975f57993sm2834414ooj.42.2023.09.27.09.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 09:51:16 -0700 (PDT)
Message-ID: <6d9aaf05-c4cb-2b8e-c3dd-899e0360b6a1@gmail.com>
Date:   Wed, 27 Sep 2023 11:51:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Content-Language: en-US
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
> Did you try to understand the report that I shared? My conclusion from
> the report is that when using tasklets rxe_completer() only runs after
> rxe_requester() has finished and also that when using work queues that
> rxe_completer() may run concurrently with rxe_requester(). This patch
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

The workqueue doc says

Some users depend on the strict execution ordering of ST wq. The combination of @max_active of 1 and WQ_UNBOUND
is used to achieve this behavior. Work items on such wq are always queued to the unbound worker-pools and only
one work item can be active at any given time thus achieving the same ordering property as ST wq.

When I have tried this setting I see very low performance compared to 512. It seems that only one item at a time
can run on all the CPUs even though it also says that max_active is the number of threads per cpu.

Nevertheless this is a good hint since it seems to imply that there is a race between the requester and
completer which is certainly possible.

Bob


