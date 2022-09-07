Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6515B0843
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 17:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiIGPQN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 11:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiIGPQM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 11:16:12 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937E13F1EC
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 08:16:10 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id t7so15887240wrm.10
        for <linux-rdma@vger.kernel.org>; Wed, 07 Sep 2022 08:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wdxkeHabC29y5AfIfcjoOgzOsAWMffB0uGCrc134Hfc=;
        b=ZoCzLiUvdV2N63WbXfTPFSfLriWqE2d5BUq6kflQ6WIoD0SFJ63OeBcJoKrAeLt03W
         U85Be6FXKg7pMpwBGIPwjU+sqz096+75fMmRh7aJ5ElNzI/jjBalixio66S+9KNTssyc
         i/OMbVRjwQb66tkjWbWy9oWqHgWvnRvddwGDfhDdskSIkEtVSBes0yQxIcXS4LyXSupo
         lbrhHeMm+xGRJm8T+XzlU2RWUgkUzrlk035ehrxQyDUeWAVFkoCT9XC6DCqK2gceI3vP
         OP699VQNwdQOO4XdMaVxsVHro4TAdv04sAN8NraVDnvgxUuxsLhY4eIXUgbE18ypW/Pi
         nDAw==
X-Gm-Message-State: ACgBeo2NbmJpRfuOz6eschyybeKfzhXKASXESjYh4g09AFMRcK9g9Jr5
        E1QDXVGH/TC/hJ5MjysRQfA=
X-Google-Smtp-Source: AA6agR7di1Q19WYP57o0sDLPEfWUEB8+RzbUcBjs2uJRQTZXVH5M8Hy0Y9DjfCZN74IqRAE8kFU1Xw==
X-Received: by 2002:a05:6000:696:b0:226:f89d:55b2 with SMTP id bo22-20020a056000069600b00226f89d55b2mr2443264wrb.133.1662563769184;
        Wed, 07 Sep 2022 08:16:09 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm21582801wmq.48.2022.09.07.08.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 08:16:08 -0700 (PDT)
Message-ID: <ac268c86-c013-5cc5-5e1c-71ee90111d8f@grimberg.me>
Date:   Wed, 7 Sep 2022 18:16:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rdma-next 4/4] nvme-rdma: add more error details when a QP
 moves to an error state
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Israel Rukshin <israelr@nvidia.com>,
        Linux-nvme <linux-nvme@lists.infradead.org>,
        linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20220907113800.22182-1-phaddad@nvidia.com>
 <20220907113800.22182-5-phaddad@nvidia.com>
 <facc31c4-955e-c82e-191b-150313e73f6a@grimberg.me> <YxiTxJvDWPaB9iMf@unreal>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YxiTxJvDWPaB9iMf@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>> From: Israel Rukshin <israelr@nvidia.com>
>>>
>>> Add debug prints for fatal QP events that are helpful for finding the
>>> root cause of the errors. The ib_get_qp_err_syndrome is called at
>>> a work queue since the QP event callback is running on an
>>> interrupt context that can't sleep.
>>>
>>> Signed-off-by: Israel Rukshin <israelr@nvidia.com>
>>> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>>
>> What makes nvme-rdma special here? Why do you get this in
>> nvme-rdma and not srp/iser/nfs-rdma/rds/smc/ipoib etc?
>>
>> This entire code needs to move to the rdma core instead
>> of being leaked to ulps.
> 
> We can move, but you will lose connection between queue number,
> caller and error itself.

That still doesn't explain why nvme-rdma is special.

In any event, the ulp can log the qpn so the context can be interrogated
if that is important.
