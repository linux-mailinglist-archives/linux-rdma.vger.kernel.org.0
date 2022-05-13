Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C405525902
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 02:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbiEMAlQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 May 2022 20:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359744AbiEMAlG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 May 2022 20:41:06 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FDC4E3B5
        for <linux-rdma@vger.kernel.org>; Thu, 12 May 2022 17:41:03 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id s18-20020a056830149200b006063fef3e17so3906485otq.12
        for <linux-rdma@vger.kernel.org>; Thu, 12 May 2022 17:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=v1vAnqmDLT+ULtohUBKZ7GKKS3Xwy9I/JdYLHNUkKC8=;
        b=MkySlyWKnoMeSu8uvA00Gf26GgWWZgnT1yoGQpaGAwZ0/FI/kzhCXTvTP59HBVx73k
         WFn7wOav4zGK0sXxbdO0WWEMePLC2BTpMzJ4QBgROYFFDhpDSpuSw3bfgpaYYi/f2EDs
         5Q06Z6xDJWhiOePgk1U0ANMpP7QVTqljbD+7ZHeUaZBF/bdSAEeZEmZc1EnPYqrxb1E3
         mPS5K9zEVn6B6A+ipP5tiBSktdDdZWl3jLHYGzSBmCp2P2SglF5V0so5QpKFRmDHVoec
         lWozc2LND3g+UKmAzFPkPWP71GzARNYyoaBjP0mHjKxAEew2UORyBYg6nOniBsP6MUsN
         Owtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v1vAnqmDLT+ULtohUBKZ7GKKS3Xwy9I/JdYLHNUkKC8=;
        b=xYAgfyHugHe0UjFM42UMf52+XfHwxoPX4aJtQQynMsTiBiBCuoDpIPJjq+XcBQlONl
         5EvSlFeKVqPsfe/fd8z9xXEKZhAuda++PkLKPYvTcUH6/8OK0REN2XIpoJs2UpmnNpqa
         ldFd7vXmOaP+K9ezHTYfrQ1kfc0uYquYR427E59JBowEQyA7Kj4b9Pwrl0xvy/8ePuy+
         2FG7dvqlepNC9Nf+YoaUJ1pTeTwi0YAWL7GaaQsBLG8cKcSX9T8LehdOwP45D1S0kAjZ
         GnW5RpoiSSKujSKaNP3lVJmauLFtcokTMH/C7hGJOijvaK5nysAFa1ENULs3ml/DHNan
         DQaQ==
X-Gm-Message-State: AOAM533to9pw9nRlhb6weX8qKs2EsUQtAJHpbnkfaNsz9PKyEI0GPUN0
        KF22mP1DdptjYajL9dv6DkY=
X-Google-Smtp-Source: ABdhPJwi17WX+u4QMl2Fcj56kfO+ECK1F8YhL3+rxDdLXn4EmaLC7fZt4a2EfC4SJ3sZCkqS4fq79A==
X-Received: by 2002:a9d:6316:0:b0:606:9578:ffe with SMTP id q22-20020a9d6316000000b0060695780ffemr964841otk.256.1652402462362;
        Thu, 12 May 2022 17:41:02 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:7f98:64fc:d1b4:c63a? (2603-8081-140c-1a00-7f98-64fc-d1b4-c63a.res6.spectrum.com. [2603:8081:140c:1a00:7f98:64fc:d1b4:c63a])
        by smtp.gmail.com with ESMTPSA id t205-20020acaaad6000000b00325cda1ffb5sm469096oie.52.2022.05.12.17.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 17:41:01 -0700 (PDT)
Message-ID: <66379f8e-c7ab-1daf-b2a8-19d0368e229f@gmail.com>
Date:   Thu, 12 May 2022 19:41:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Apparent regression in blktests since 5.18-rc1+
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
References: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
 <cf8b9980-3965-a4f6-07e0-d4b25755b0db@acm.org>
 <4b0153c7-a8e9-98de-26ae-d421434a116d@linux.dev>
 <20220507012952.GH49344@nvidia.com>
 <81571bbb-c5d2-9b68-765d-f004eb7ba6fd@linux.dev>
 <43c2fed8-699f-19fe-81fa-c5f5b4af646f@gmail.com>
 <4c3439c3-6279-804f-63b2-99d8529e5d3d@acm.org>
 <b2908c39-636a-1cba-db22-838640385d84@gmail.com>
 <529dbb0a-0b75-9752-62a3-a1235565aa1a@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <529dbb0a-0b75-9752-62a3-a1235565aa1a@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/12/22 17:25, Bart Van Assche wrote:
> On 5/12/22 14:57, Bob Pearson wrote:
>> I am trying to reproduce your result. What version of Linus' tree did you use?
>> rdma for-next is 5.18-rc1+
>> rdma for-rc is 5.18-rc6 (as of earlier today) which is an official tag. Not sure if there is an advanced one from that.
> 
> Hi Bob,
> 
> That must have been one of the most recent versions at the time I wrote my email. Does the exact version matter? The test results I reported should be identical for Linus' latest master branch.
> 
> Thanks,
> 
> Bart.
> 

OK thanks. I don't exactly know how to merge "the latest master branch". I did merge the tag v5.18-rc2 and am now trying
v5.18-rc4. As far as I can tell rc6 is the latest branch. When I tried to merge the git repo it didn't work.

Bob
