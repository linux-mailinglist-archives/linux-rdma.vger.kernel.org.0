Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3124E7B86DE
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Oct 2023 19:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbjJDRoU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Oct 2023 13:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbjJDRoU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Oct 2023 13:44:20 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A7F9E;
        Wed,  4 Oct 2023 10:44:17 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1c61acd1285so17882385ad.2;
        Wed, 04 Oct 2023 10:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696441457; x=1697046257;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJgkrq7GmiJ8unsP5pb6TucMJYlIfTg12gaa15YTSuo=;
        b=ttaK46vclASeCrrvs2KLrr4jcctxQJGWhmyerEsDpbWHdx7RFz4gx4m2hxh/mMj6if
         Qfkkpqrn4dG8xP8a2aIDkkfTSHhvrj4hOxeXCcThLo80k9F/R2LoJB1V3yGpV3QMBnxF
         ebB+k4i9XIZ8DoKUcB3ndzDOZJ1FyHud4Gjtb/nLwsBrNiRhb7uXLVMbDnsGSYcDzmLS
         5IyGhI9aARtjj4Jyew5wYWiXg1AgqbuTUhUxTGySeRu7XSQ0igbP5qKSexz8NzWolouV
         JEPYi+G5IjO2bivLKxtpZtoLxnZZOEhuVLC37F/OVZByAdLPX+o4/UXL0ORI69CGV94g
         3uxA==
X-Gm-Message-State: AOJu0Ywe29IWNIHb0Ro+zBs64IX3FPdNweXkqEY0J4ljKA8OZGZSDrrt
        Z3rOFfzIQizm8WbePF0C9Ys=
X-Google-Smtp-Source: AGHT+IH1Pe5GsASFzbSuo3PiMX1xlLFCxSD1HTklY6kEj1h3nf1HLLXg44ha6f3AXi+ihjqHxplOhw==
X-Received: by 2002:a17:902:e88f:b0:1c5:cfd6:9e82 with SMTP id w15-20020a170902e88f00b001c5cfd69e82mr3486774plg.18.1696441456652;
        Wed, 04 Oct 2023 10:44:16 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:969d:167a:787c:a6c7? ([2620:15c:211:201:969d:167a:787c:a6c7])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b001c74df14e72sm3981235plb.212.2023.10.04.10.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 10:44:16 -0700 (PDT)
Message-ID: <eb16cea2-d727-4799-b857-e872d7855909@acm.org>
Date:   Wed, 4 Oct 2023 10:44:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        matsuda-daisuke@fujitsu.com, shinichiro.kawasaki@wdc.com,
        linux-scsi@vger.kernel.org, Zhu Yanjun <yanjun.zhu@intel.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>
References: <20230922163231.2237811-1-yanjun.zhu@intel.com>
 <169572143704.2702191.3921040309512111011.b4-ty@kernel.org>
 <20230926140656.GM1642130@unreal>
 <d3c05064-a88b-4719-a390-6bf9ae01fba5@acm.org>
 <b7b365e3-dd11-bc66-dace-05478766bf41@gmail.com>
 <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
 <6d9aaf05-c4cb-2b8e-c3dd-899e0360b6a1@gmail.com>
 <20231001063048.GA6351@unreal>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231001063048.GA6351@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/30/23 23:30, Leon Romanovsky wrote:
> On Wed, Sep 27, 2023 at 11:51:12AM -0500, Bob Pearson wrote:
>> On 9/26/23 15:24, Bart Van Assche wrote:
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
>>> index 1501120d4f52..6cd5d5a7a316 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_task.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
>>> @@ -10,7 +10,7 @@ static struct workqueue_struct *rxe_wq;
>>>
>>>   int rxe_alloc_wq(void)
>>>   {
>>> -       rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
>>> +       rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, 1);
>>>          if (!rxe_wq)
>>>                  return -ENOMEM;
>>>
>>> Thanks,
>>>
>>> Bart.
> 
> <...>
> 
>> Nevertheless this is a good hint since it seems to imply that there is a race between the requester and
>> completer which is certainly possible.
> 
> Bob, Bart
> 
> Can you please send this change as a formal patch?
> As we prefer workqueue with bad performance implementation over tasklets.

Hi Bob,

Do you perhaps have a preference for who posts the formal patch?

Thanks,

Bart.

