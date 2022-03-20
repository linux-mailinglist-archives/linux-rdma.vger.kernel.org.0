Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881434E1BC8
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Mar 2022 14:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245109AbiCTNFZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Mar 2022 09:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiCTNFY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Mar 2022 09:05:24 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61EE88B01
        for <linux-rdma@vger.kernel.org>; Sun, 20 Mar 2022 06:04:01 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id t11so17500804wrm.5
        for <linux-rdma@vger.kernel.org>; Sun, 20 Mar 2022 06:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h2PA4z0FvXsiavjaFX/VT0itkc8E/SPjmrJLcKy5rdU=;
        b=rpoIKtFdjT5wcRAL2vPRESOFqQ8lUXRU7xm2HzdOIApTKWucQ7Zqs76jX57aMphcWh
         6oaGr3cD3YIfeO8WSlBfGnqEQa03+WzuslE9+Ag0zxYKIeHORMsuO/gnHPr6AserU0mr
         aGSYDKrl0WS+HA9hg/zaEQaX3Cx5+Rq2QYwMTfg5P3cTS8wcqHTcMVDdDwYXE+89LEOa
         DeZluYjrvrulr9NneylcOHC5btcPfxo+67ZgMO1oakjmAinjp8AalXA0Bc02mTh5UMo7
         kpRXh+tuCIGBVUd19o4+cNlFLajad1rYpMRVSpD8RbIzFbf2bGAV1Txq6gXaUMNOYjBE
         omtg==
X-Gm-Message-State: AOAM532hN2eu8EzOg+bY2QAeVY6pKPUXMgcTQv45pot0t9qVq8LS0UQ2
        4dB3ufW38aLG3MQmCcYkdyI=
X-Google-Smtp-Source: ABdhPJyLAOH8RUz7OO8GYD30PObK8sfst9LEjL1xlm0ZUGbMzBYi/cbWdgUOnlXWQ33x4sDtf4W51g==
X-Received: by 2002:a5d:4204:0:b0:203:d794:93e0 with SMTP id n4-20020a5d4204000000b00203d79493e0mr14824113wrq.136.1647781440130;
        Sun, 20 Mar 2022 06:04:00 -0700 (PDT)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il. [46.117.116.119])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm436857wrs.26.2022.03.20.06.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 06:03:59 -0700 (PDT)
Message-ID: <7e0abcac-791a-bd71-38c3-4a5490b7f209@grimberg.me>
Date:   Sun, 20 Mar 2022 15:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, Yi Zhang <yi.zhang@redhat.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com>
 <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com>
 <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
 <a2fabeb3-5f19-11b6-8c00-a479e3759182@grimberg.me>
 <bdb675e4-1de8-400b-9d43-9f0c18147dc4@nvidia.com>
 <CAHj4cs_C=pCz41hg1AnQcEZPBRK78WTUq8HE3n_28t56iN1FuA@mail.gmail.com>
 <fe9842f1-e5c7-7569-426e-9029662bb4f3@nvidia.com>
 <CAHj4cs8fNmj2Mn7Srs547ji51x7mQ8ZWKzFOuJaENe=vKpBJ-A@mail.gmail.com>
 <6347079f-ec3b-c2e5-bb3b-43b539d6d3f1@nvidia.com>
 <CAHj4cs_ir917u7Up5PBfwWpZtnVLey69pXXNjFNAjbqQ5vwU0w@mail.gmail.com>
 <6d8f4525-f663-18cc-8644-bfddd7d86bd0@grimberg.me>
 <CAHj4cs_ff3TGnD2QJSzx3QJQKc1HkF=TJkh_MokqGK3n8NWyQQ@mail.gmail.com>
 <3d3f7b64-1c74-d41c-4c60-055e9fa79080@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3d3f7b64-1c74-d41c-4c60-055e9fa79080@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


>>> These are very long times for a non-debug kernel...
>>> Max, do you see the root cause for this?
>>>
>>> Yi, does this happen with rxe/siw as well?
>> Hi Sagi
>>
>> rxe/siw will take less than 1s
>> with rdma_rxe
>> # time nvme reset /dev/nvme0
>> real 0m0.094s
>> user 0m0.000s
>> sys 0m0.006s
>>
>> with siw
>> # time nvme reset /dev/nvme0
>> real 0m0.097s
>> user 0m0.000s
>> sys 0m0.006s
>>
>> This is only reproducible with mlx IB card, as I mentioned before, the
>> reset operation time changed from 3s to 12s after the below commit,
>> could you check this commit?
>>
>> commit 5ec5d3bddc6b912b7de9e3eb6c1f2397faeca2bc
>> Author: Max Gurtovoy <maxg@mellanox.com>
>> Date:   Tue May 19 17:05:56 2020 +0300
>>
>>      nvme-rdma: add metadata/T10-PI support
>>
> I couldn't repro these long reset times.

It appears to be when setting up a controller with lots of queues
maybe?

> Nevertheless, the above commit added T10-PI offloads.
> 
> In this commit, for supported devices we create extra resources in HW 
> (more memory keys per task).
> 
> I suggested doing this configuration as part of the "nvme connect" 
> command and save this resource allocation by default but during the 
> review I was asked to make it the default behavior.

Don't know if I gave you this feedback or not, but it probably didn't
occur to the commenter that it will make the connection establishment
take tens of seconds.

> Sagi/Christoph,
> 
> WDYT ? should we reconsider the "nvme connect --with_metadata" option ?

Maybe you can make these lazily allocated?
