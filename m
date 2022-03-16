Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E93C4DB4AF
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 16:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbiCPPR2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 11:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbiCPPR1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 11:17:27 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46636B082
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 08:16:12 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id h23so2827946wrb.8
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 08:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6mPbq8Nin+hCrDYZQyK8NYroPhFts3KarKSwfAyzCbo=;
        b=c/Fn+W1hwGoQMJA8t6otqIpIVO/eukAXvqsr//jUo4moe6M3eHKN77gmtGNUoeAnbJ
         E8cpKFSPYjXOmHUuPoBe6K1C3dvcIG8CssFEs+2ixRh/R82Z6IlM0qjQbRo7RbBhGisF
         /D1I/AaRAjBZSXdBjFXLjQB/cQcUbtVjAeyV0ihXNLn4T30iqxgba6ozs/YRSgEgKXUw
         3fRuWUx+nEZAMUagVnjQTHZBRvawMI8rOchBmRLyAs4HG/QLQlItcib/93KuJKH52L20
         hidTs4LuXAUZWDfwyOeumHO/WeghRC8cntY50ceagIMeekj1qyEBR4eK5HEJg03SAmbS
         uing==
X-Gm-Message-State: AOAM530RcBeSuqsWHxjHcW+C0LRZRFZe9RKeYGyjbFjBRjSAfVwymUHc
        KUVZXGQ8GjN1pOXmwfF75D4=
X-Google-Smtp-Source: ABdhPJzrbmh3oAxcez9ERJTBYQ4x3husP7HNLIoMmO5otBPZvg7WqhINAEjqe2PGdpRicVYuj87bHA==
X-Received: by 2002:a05:6000:381:b0:203:84bf:3faa with SMTP id u1-20020a056000038100b0020384bf3faamr367161wrf.324.1647443771358;
        Wed, 16 Mar 2022 08:16:11 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s2-20020a1cf202000000b0038977146b28sm1901897wmc.18.2022.03.16.08.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 08:16:10 -0700 (PDT)
Message-ID: <6d8f4525-f663-18cc-8644-bfddd7d86bd0@grimberg.me>
Date:   Wed, 16 Mar 2022 17:16:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Max Gurtovoy <maxg@mellanox.com>
Cc:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com>
 <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com>
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
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs_ir917u7Up5PBfwWpZtnVLey69pXXNjFNAjbqQ5vwU0w@mail.gmail.com>
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


>> Hi Yi Zhang,
>>
>> thanks for testing the patches.
>>
>> Can you provide more info on the time it took with both kernels ?
> 
> Hi Max
> Sorry for the late response, here are the test results/dmesg on
> debug/non-debug kernel with your patch:
> debug kernel: timeout
> # time nvme connect -t rdma -a 172.31.0.202 -s 4420 -n testnqn
> real    0m16.956s
> user    0m0.000s
> sys     0m0.237s
> # time nvme reset /dev/nvme0
> real    1m33.623s
> user    0m0.000s
> sys     0m0.024s
> # time nvme disconnect-all
> real    1m26.640s
> user    0m0.000s
> sys     0m9.969s
> 
> host dmesg:
> https://pastebin.com/8T3Lqtkn
> target dmesg:
> https://pastebin.com/KpFP7xG2
> 
> non-debug kernel: no timeout issue, but still 12s for reset, and 8s
> for disconnect
> host:
> # time nvme connect -t rdma -a 172.31.0.202 -s 4420 -n testnqn
> 
> real    0m4.579s
> user    0m0.000s
> sys     0m0.004s
> # time nvme reset /dev/nvme0
> 
> real    0m12.778s
> user    0m0.000s
> sys     0m0.006s
> # time nvme reset /dev/nvme0
> 
> real    0m12.793s
> user    0m0.000s
> sys     0m0.006s
> # time nvme reset /dev/nvme0
> 
> real    0m12.808s
> user    0m0.000s
> sys     0m0.006s
> # time nvme disconnect-all
> 
> real    0m8.348s
> user    0m0.000s
> sys     0m0.189s

These are very long times for a non-debug kernel...
Max, do you see the root cause for this?

Yi, does this happen with rxe/siw as well?
