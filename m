Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356EE7AF500
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 22:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbjIZUZD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 16:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbjIZUZA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 16:25:00 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157AF121;
        Tue, 26 Sep 2023 13:24:54 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3af3ed2dd67so137893b6e.3;
        Tue, 26 Sep 2023 13:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695759893; x=1696364693;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cU74TS179GJt0pPgtbUbL/V0drzltNAHypNDNZGJGAc=;
        b=nVHW8UUkNyCrNoPPirm+WVAUu1UZZKh5NaeC5MXEW8miGgl0SLqbygrU77k/O3ITkS
         R70RkmAK9zCXHgdahuDGuW4Z46FughaQ7kk2GzYH9p8KOro29wK3cnycSKW7cqwH3Aax
         XQau9ij4yuLtmGXHBGBd7tRUUp2K9RcVs9lxjDR1T45ZJi3meqCn4wUIZ24QMTCHGteb
         sP6u4escfgH5mk8OM+xrYj6DzreIJQb47cVou5TRATUaL4ngDnJpKsiJvCJDxhUt5OEt
         3HKsrA44eBlBycW3UYOxOG5ImCXYgEVSoh+nJ5LkHmYgg+baSGt9agKHQPn+A7FpBp2i
         szfw==
X-Gm-Message-State: AOJu0YzhjsP+q8L+dACXMMlPVy3cYhnpnt1uL61B6wS418UKgjTWtX5U
        hn8Tbv9BqgfBd9ONTSFjK+M=
X-Google-Smtp-Source: AGHT+IGSMtZwmsq/24kwkgoUCSLR/DOOMhr5Qy2ouQzm+s5MPqcWodTK+sTp0VoWVeXVn1DM+xQGSg==
X-Received: by 2002:a54:4390:0:b0:3af:4f82:2337 with SMTP id u16-20020a544390000000b003af4f822337mr74677oiv.32.1695759893177;
        Tue, 26 Sep 2023 13:24:53 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a80d:6f65:53d4:d1bf? ([2620:15c:211:201:a80d:6f65:53d4:d1bf])
        by smtp.gmail.com with ESMTPSA id fn1-20020a056a002fc100b00692e9bf82fcsm4331881pfb.182.2023.09.26.13.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 13:24:52 -0700 (PDT)
Message-ID: <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
Date:   Tue, 26 Sep 2023 13:24:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
To:     Bob Pearson <rpearsonhpe@gmail.com>,
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
Content-Language: en-US
In-Reply-To: <b7b365e3-dd11-bc66-dace-05478766bf41@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/26/23 11:34, Bob Pearson wrote:
> I am working to try to reproduce the KASAN warning. Unfortunately,
> so far I am not able to see it in Ubuntu + Linus' kernel (as you 
> described) on metal. The config file is different but copies the 
> CONFIG_KASAN_xxx exactly as yours. With KASAN enabled it hangs on 
> every iteration of srp/002 but without a KASAN warning. I am now 
> building an openSuSE VM for qemu and will see if that causes the 
> warning.

Hi Bob,

Did you try to understand the report that I shared? My conclusion from
the report is that when using tasklets rxe_completer() only runs after
rxe_requester() has finished and also that when using work queues that
rxe_completer() may run concurrently with rxe_requester(). This patch
seems to fix all issues that I ran into with the rdma_rxe workqueue
patch (I have not tried to verify the performance implications of this
patch):

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c 
b/drivers/infiniband/sw/rxe/rxe_task.c
index 1501120d4f52..6cd5d5a7a316 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -10,7 +10,7 @@ static struct workqueue_struct *rxe_wq;

  int rxe_alloc_wq(void)
  {
-       rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
+       rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, 1);
         if (!rxe_wq)
                 return -ENOMEM;

Thanks,

Bart.
