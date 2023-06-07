Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF3072638D
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jun 2023 16:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbjFGO73 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jun 2023 10:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjFGO7Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jun 2023 10:59:25 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BBF10D5
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 07:59:23 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3f604176322so13279735e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jun 2023 07:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686149962; x=1688741962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+4xPUwHvVelzfYLHlCNeAJmR4fuqXl559NZ4EWZ/qY=;
        b=PtRwDIxWK8ZfVhtJbNHWedYmpu8vezw0ksxiuMyeOysB/0Nhst4bjfhEi+gH1oRmwy
         6a6ZjOj992LHgSMnk5+5Ax6LdBVRui3RDqqiMJOL9BqFvYcCFUKA2yOIvLgX24pB08Ei
         zYUhcc5ux6BXnie84e3LYCb2Z0v6na0KUKzsHOxoFz6WoDjbqhwet7EpZVMHKRzVNKKy
         y1S6LlTjLol3n2V/Z1OD7fhdUWJdh8d/P5vkBMJdhPrfMvCWJBRGcGDgjO/T9lL+DiHj
         08N2PzdxZeLm8keLV5hgv4treUU4nJ2NGEJXeEHWxXO3TYbKbXYdkQaWb75zXWpsXUP7
         yIjQ==
X-Gm-Message-State: AC+VfDwrh8Dw1ptH1QNeoA0/TnJA/kdr26LUc3gQDbgdtdLJv3PS1kby
        eossIk06sC2WFyQMQIAwh9M=
X-Google-Smtp-Source: ACHHUZ4Vbf2qZbr6TlCePHTLQ1lzWxp7vPcSd2Cj3IyTfa8ywzwxD6V4KUK8Bw0Th0viKNFMZQzjBA==
X-Received: by 2002:a05:600c:34c5:b0:3f7:369c:c640 with SMTP id d5-20020a05600c34c500b003f7369cc640mr2093960wmq.1.1686149962164;
        Wed, 07 Jun 2023 07:59:22 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f7f4b7f286sm755774wml.12.2023.06.07.07.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 07:59:21 -0700 (PDT)
Message-ID: <15fad8d4-1620-e39e-a506-65747f1857a7@grimberg.me>
Date:   Wed, 7 Jun 2023 17:59:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Revert "IB/core: Fix use workqueue without
 WQ_MEM_RECLAIM"
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Maurizio Lombardi <mlombard@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, parav@mellanox.com
References: <20230523155408.48594-1-mlombard@redhat.com>
 <20230523182815.GA2384059@unreal>
 <CAFL455m3T4qrk0Uf5qK7-57Oh6L6AKionfs0mF-imUMYpbqBOg@mail.gmail.com>
 <ZHebeWlpn68Xa1Hd@ziepe.ca>
 <09504ea7-186d-9ede-e01f-87849673b9b2@grimberg.me>
 <ZH9wv6UNZtxhxrfw@ziepe.ca>
Content-Language: en-US
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZH9wv6UNZtxhxrfw@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>>>>> workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_rdma_reconnect_ctrl_work
>>>>>> [nvme_rdma] is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib_core]
>>>>>
>>>>> And why does nvme-wq need WQ_MEM_RECLAIM flag? I wonder if it is really
>>>>> needed.
>>>>
>>>> Adding Sagi Grimberg to cc, he probably knows and can explain it better than me.
>>>
>>> We already allocate so much memory on these paths it is pretty
>>> nonsense to claim they are a reclaim context. One allocation on the WQ
>>> is not going to be the problem.
>>>
>>> Probably this nvme stuff should not be re-using a reclaim marke dWQ
>>> for memory allocating work like this, it is kind of nonsensical.
>>
>> A controller reset runs on this workqueue, which should succeed to allow
>> for pages to be flushed to the nvme disk. So I'd say its kind of
>> essential that this sequence has a rescuer thread.
> 
> So don't run the CM stuff on the same WQ, go to another one without
> the reclaim mark?

That is not trivial. teardown works won't need a rescuer, but
they will need to fence async work elements that are a part
of the bringup that do need a rescuer (for example a scan work).

So it requires more thought how it would be possible to untangle
any dependency between work elements that make use of a rescuer
and others that don't, and vice-versa.
