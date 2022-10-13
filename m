Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B01C5FDEC6
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Oct 2022 19:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJMRRw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Oct 2022 13:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJMRRu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Oct 2022 13:17:50 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D198FD25B4
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 10:17:49 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id p127so1782070oih.9
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAJbCkDilMBxukjPuJ+10gXj4BnrryqJ690otd7Rbvc=;
        b=Aq6WGcFnnOHjfA9G+92Eeu42LMvF2zBmdjGthxN2asYrsnb/pTD9EjBkTqlU61QjEz
         7txNuHjrm3qtGPdEo6idw/wZ7hJQSeKZ0Zf+tKwq/FXycim4CwTQUx8B3hA39QM7NrS4
         FO/8ODFyccvMKmePuXzv+nqG/KLIRx/v5nyimvAHsFh5W+oj+WjRCyhR7sz4+EIuU95M
         KbUgQGholdco3AXyXEmRk58mJOwMfnCI/9YinmuKV1+Rs/pEfE1BBJl2j9Q+txAaPbTw
         jrWe0IvO3F2Hv+M1lr6m2VBi4RFWOTtyoXdNI12vwyqbyo4MMpsg16zPwnprnxsDe9oX
         bHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAJbCkDilMBxukjPuJ+10gXj4BnrryqJ690otd7Rbvc=;
        b=SkzX84+zg8DGUpA9FrMv92OjvlLa6bQgJ6TLgvxPTdPcU/ZQS7QkXaeuJ2IPxGdADD
         vw/h1cc5ABA+EyzSryVkEg2zwojWoOTKdBxtPip4SGOX90L03Op8XwygBg4CmaUN6Ikj
         AXudJnHQmPMu061H/XSkac5L+GYLeYFKs0JremTkgNnGaf1fIBldeXk6v1CUIJ1YX0ji
         i5ED13eartSz7vy9uBF1EKxCIgTAzkYcV/5deaS02a9QS+Gxdfo4DgwPCna1KsbZ4DMq
         InTvhNWuOfTng0zEMoOdMWc7WNtTVbryLi0xwbGC0LIrYOPpcLsH73cV55tbeEot1J2n
         Z1Cg==
X-Gm-Message-State: ACrzQf1IKwXdwDlYlsaqrEpRyGNUEWuM8VGjrna7AfmfMsowCKkC61wO
        FGUcRuwqzEiMsNmG0/gczDQ=
X-Google-Smtp-Source: AMsMyM6bjWZiorkIfpSfcBdqZmRPjuAXxX4Yfp9n2HdYC6jACYUN2XldVCnWEBC2UcrjxIu2XDgoxw==
X-Received: by 2002:aca:bbd4:0:b0:353:f167:6fd3 with SMTP id l203-20020acabbd4000000b00353f1676fd3mr402538oif.287.1665681469098;
        Thu, 13 Oct 2022 10:17:49 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:2ba6:2a0:8249:dec6? (2603-8081-140c-1a00-2ba6-02a0-8249-dec6.res6.spectrum.com. [2603:8081:140c:1a00:2ba6:2a0:8249:dec6])
        by smtp.gmail.com with ESMTPSA id v81-20020aca6154000000b0034fc91dbd7bsm27345oib.58.2022.10.13.10.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 10:17:48 -0700 (PDT)
Message-ID: <8a5dc704-5f10-fa59-6db8-f4e684121233@gmail.com>
Date:   Thu, 13 Oct 2022 12:17:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH for-next 00/13] Implement the xrc transport
Content-Language: en-US
To:     "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>,
        'Jason Gunthorpe' <jgg@nvidia.com>
Cc:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220917031104.21222-1-rpearsonhpe@gmail.com>
 <YzIyHsRUy4gNeJL8@nvidia.com>
 <TYCPR01MB84557734DE313F81A10D30B1E5559@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <2d0420d9-b2b2-1a23-084c-6104bac18838@gmail.com>
 <TYCPR01MB8455C2E2DCD507C32051E929E5579@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <TYCPR01MB84554785DE728A68EFF385C1E5229@TYCPR01MB8455.jpnprd01.prod.outlook.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <TYCPR01MB84554785DE728A68EFF385C1E5229@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/12/22 02:41, matsuda-daisuke@fujitsu.com wrote:
> Hi Bob,
> 
> I am ready and willing to review your workqueue implementation.
> Could you inform me of the current status of the patch series?
> Are you having trouble rebasing it? 
> 
> Daisuke
> 
>>>> The ODP patch series is the one I posted for rxe this month:
>>>>   [RFC PATCH 0/7] RDMA/rxe: On-Demand Paging on SoftRoCE
>>>>   https://lore.kernel.org/lkml/cover.1662461897.git.matsuda-daisuke@fujitsu.com/
>>>>   https://patchwork.kernel.org/project/linux-rdma/list/?series=674699&state=%2A&archive=both
>>>>
>>>> We had an argument about the way to use workqueues instead of tasklets.
>>>> Some prefer to get rid of tasklets, but others prefer finding a way to switch
>>>> between the bottom halves for performance reasons. I am currently taking
>>>> some data to continue the discussion while waiting for Bob to post their(HPE's)
>>>> implementation that enables the switching. I think I can resend the ODP patches
>>>> without an RFC tag once we reach an agreement on this point.
>>>
>>> I tried to get Ian Ziemba, who wrote the patch series, to send it in but he is very busy
>>> and finally after a long while he asked me to do that. I have to rebase it from
>>> an older kernel to head of tree. I hope to have that done in a day or two.
>>>
>>> Bob
>>
>> Thank you for the update.
>> I am glad to hear your work is in progress just now.
>> I am looking forward to seeing your work!
>>
>> Daisuke
> 

I know. Thanks. It's ready to send in. I am testing the performance and was surprised that the tasklet performance has gotten better in 6.0. Not sure why. I'll send it today.

Bob
