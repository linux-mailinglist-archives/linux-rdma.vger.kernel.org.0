Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37004C104F
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 11:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbiBWKbN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 05:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiBWKbM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 05:31:12 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D11A8C7DA
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 02:30:44 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id l1-20020a7bcf01000000b0037f881182a8so1222121wmg.2
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 02:30:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d+z/tj64j31nPU7P3+AdyRvXbl+BzXO/CxZqxssuHe4=;
        b=TxPSMUa1fknQlzgGehIo8JPdgz5ZEf2QCjoeJFE5Og+fOnIvV9twa4HjUWEQnua7XX
         xuG0xqZVSEjbFDamlr6SDGfHjZWXrxvNfWEStkHFUlenviNbzknhXRx4FR0oMogkholW
         YvILoGOkTToqWDGMANwbHCOvj7lu/sYr1W7Y0lg09Jl+tnyhR4g9Is0pieDqgMUf7DmV
         vXGKwZoUjzjHYqbM67H/5Rmm4h8wA21vykRTjwDksoRbbe0hS+6kxFvhhboj9rEKrQmb
         lBB8JWf3o/H+8uqQhUpq2tvnQ5JrOFTXbQyJEidaCpL5DAl1EKN5UtyRubW2FYPNzseE
         q49w==
X-Gm-Message-State: AOAM530n9nWv9F+mgPC8oo8B5vanKeZLur3vt/59nYZhz4xnZrcYFeui
        G3HpoB2dLPlwZsdwS5o8UWc=
X-Google-Smtp-Source: ABdhPJwgRPPywPIzZRKBXDJLsLty7vXfYZga5/x2cjtzDLv5Qw2nUqaP1kQfwrbN6siZJpO3t9M+qQ==
X-Received: by 2002:a7b:c04e:0:b0:380:ead9:254a with SMTP id u14-20020a7bc04e000000b00380ead9254amr2505870wmc.58.1645612242833;
        Wed, 23 Feb 2022 02:30:42 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il. [46.117.116.119])
        by smtp.gmail.com with ESMTPSA id d14sm50347618wri.93.2022.02.23.02.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 02:30:42 -0800 (PST)
Message-ID: <06a6c0ec-3d8b-75b0-7522-bfc10c3813e3@grimberg.me>
Date:   Wed, 23 Feb 2022 12:30:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, Yi Zhang <yi.zhang@redhat.com>
Cc:     Haakon Bugge <haakon.bugge@oracle.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
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
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <6347079f-ec3b-c2e5-bb3b-43b539d6d3f1@nvidia.com>
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


> Hi Yi Zhang,
> 
> thanks for testing the patches.
> 
> Can you provide more info on the time it took with both kernels ?
> 
> The patches don't intend to decrease this time but re-start the KA in 
> early stage - as soon as we create the AQ.

Still not sure why this addresses the problem, because every io queue
connect should reset the keep alive timer in the target.

But if at all, just move the keep alive start to nvme_init_ctrl_finish
don't expose it to drivers...
