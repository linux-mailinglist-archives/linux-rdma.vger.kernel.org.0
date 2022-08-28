Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9845A3E2F
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Aug 2022 16:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiH1O5w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Aug 2022 10:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiH1O5v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Aug 2022 10:57:51 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371842CE1D
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 07:57:50 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso3215709wmb.2
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 07:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=68N5DycOpL4Rg4o9EfqAhk52NzjvSEM+u5OY5hUdLlo=;
        b=b1FZh0JZ0Hj3ZGIpXJfLTt8FxHe8I0PZ3KySOJyUCrpo7023RGLcrfKejBrhHO1dLk
         yZJNqSnUowQPzK5eDDuZh1hBxbTKe34kxp05ZT1O9Z4Uz+yfXO1cQmk2HUrNI97Btl6Q
         xD6tYjiGfVNbZeGDEzjyrX9d2OCNSeVD+szKmz7OnYYrJsPNe21XTcsfRShNObT8uEL9
         GQdWpXYEkuefQXHKARAU/3btRgkYqe/7ImMVglBnR/Rk9nbFBH7iQxQBKzACBIIJcLdu
         c/l7NyzohHCSGH6gT8Uounz9ymmM+3gJ63QHdWUmdFuJbX40IummruAc8sVfWo/dW3wV
         mvPg==
X-Gm-Message-State: ACgBeo2LQ+QmSl45UuiTIblhL1Frz+CP6gbSPbuGX5NA5VkxO88cv/rv
        DMBZQCc/5/FY67dqUZCgt0o=
X-Google-Smtp-Source: AA6agR4E0LIUJ3MaoGtSq0VPJXKTeWI3G/89eKZvRW86JQwICUgESC4oRIxMDrYPoeFUEaNdrkBw2w==
X-Received: by 2002:a05:600c:3541:b0:3a6:28e4:c458 with SMTP id i1-20020a05600c354100b003a628e4c458mr4703627wmq.188.1661698668776;
        Sun, 28 Aug 2022 07:57:48 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d59c5000000b002257fd37877sm4884686wry.6.2022.08.28.07.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 07:57:46 -0700 (PDT)
Message-ID: <fbee7c67-fd7b-12c8-5685-066b1974aadb@grimberg.me>
Date:   Sun, 28 Aug 2022 17:57:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-rdma: set ack timeout of RoCE to 262ms
Content-Language: en-US
To:     Chao Leng <lengchao@huawei.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220819075825.21231-1-lengchao@huawei.com>
 <20220821062016.GA26553@lst.de>
 <83992e8f-b18a-ccd3-e0ee-a5802043f161@huawei.com>
 <86e9fc3b-aded-220d-1ee0-4d5928097104@nvidia.com>
 <f7254cc2-88e0-e91f-e4f1-788c5889fcf1@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f7254cc2-88e0-e91f-e4f1-788c5889fcf1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>> On 2022/8/21 14:20, Christoph Hellwig wrote:
>>>> On Fri, Aug 19, 2022 at 03:58:25PM +0800, Chao Leng wrote:
>>>>> Now the ack timeout of RoCE is 2 second(2^(18+1)*4us=2 second). In the
>>>>> case of low concurrency, if some packets lost due to network abnormal
>>>>> such as network rerouting, Optical fiber signal interference, etc,
>>>>> it will wait 2 second to try retransmitting the lost packets.
>>>>> As a result, the I/O latency is greater than 2 seconds.
>>>>> The I/O latency is so long for real-time transaction service. 
>>>>> Indeed we
>>>>> do not have to wait so long time to make sure that packets are lost.
>>>>> Setting the ack timeout to 262ms(2^(15+1)*4us=262ms) is sufficient.
>>>>
>>>> I'll leave people more familar with RoCE to judge the merits of this
>>>> change, but I really want a comment explaining the choice in the
>>>> source code.
>>> Now the TCP retransmission timeout interval is 250ms, and this setting
>>> has been maintained for many years.
>>> The network quality of rdma is better than that of common Ethernet.
>>> That is the reason to set 262ms as the default ack timeout.
>>> Adding a module parameter may be a better option.
>>
>> Are you solving a real issue you encountered ?
> There is a low probability that this occurs in real scenarios.
> The issue occurs in fault simulation test.
> In the core-leaf fabrics,simulate a fiber fault between the core switch
> and the leaf switch.
> In the case of low concurrency, There is a high probability that the
> I/O latency is greater than 2 seconds.
> This patch can reduce the I/O latency to less than 1 second.
>>
>> If so, which devices did you use ?
> The host HBA is Mellanox Technologies MT27800 Family [ConnectX-5];
> The switch and storage are huawei equipments.
> In principle, switches and storage devices from other vendors
> have the same problem.
> If you think it is necessary, we can test the other vendor switchs
> and linux target.

Why is the 2s default chosen, what is the downside for a 250ms seconds 
ack timeout? and why is nvme-rdma different than all other kernel rdma
consumers that it needs to set this explicitly?

Adding linux-rdma folks.
