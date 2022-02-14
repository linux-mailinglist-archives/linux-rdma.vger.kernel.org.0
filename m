Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5E84B5C38
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Feb 2022 22:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiBNVDw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Feb 2022 16:03:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiBNVDv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Feb 2022 16:03:51 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396E7F7444
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 13:03:43 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id t199so18745014oie.10
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 13:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sVI+GbjbTYZO5FKhKt95QGhnp0j7CCGsEgtsCc/Mgd0=;
        b=e5wSKCaK0d+OiJVAYa9hsBTQebH+cmW5jr19DL6XrhKf7dw2bTsJV5HmWyFhwwUNlY
         Mad7GKYPNtb3LkxxpTAFqRxz7dhYBuMkDzQC04QgptzLIPRp2zRSxiBeoVUhU/KWsHf2
         2LC64rbdyhEjtyqvEspJmw+2VAcFgvU4qsGIqDO/ChhxKgqa/UlmpU1OWLcLXUbNbkfp
         zmp3RrAKBsi8ex8Pk9M4OCdS1LuLetF0xQqAOITdqVoPMKgMT6Rmc0GITB+WjPEUoWqR
         bBQ8IQCvz5T13RdFjtqJUX966FC0iDW+tx8nlpm7YWtyQA8AIo82TLcyv/YRHr82cEGC
         uDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sVI+GbjbTYZO5FKhKt95QGhnp0j7CCGsEgtsCc/Mgd0=;
        b=ethPScawQg3jk7+kOpXvTUSk3UGaCbGyK/K1YuP9dXZ5bepf50QIVmO/ozLumQyCkC
         roozo6+ORln2jiFVOnpbBcsf5mPTNA58Wd6aceojYkA4ivpfcYpI0Rh4WZjMCVGVpPDL
         n6RHsMAIj1jql4lMw5A18fxM6r4IM/S8NUufO6essrzPnjb5qvWwr0oSh5H8IxAE/qC3
         pYNfIZfnRDhAay+IozXqRowLlZ5xcHuXpKXN5K3aMOm5bFJMhpjXr1HIizyJn0keVZdQ
         /2j4U6lXdwZf+xHmS0ZPTbMIspn7i0eVdvtLZIub2z9RcKUizb8hWAMbMyTtTjkOKcxE
         UGCQ==
X-Gm-Message-State: AOAM532Nam3YpLMMpzKvxY4/Vy2pdbduhl43xzt6+JHNbnfhq8bqcuyL
        gNtHNPkpjLkMnffxpulCoOjxMVP5nXM=
X-Google-Smtp-Source: ABdhPJxjqmw3aHbkDs4XHkdU08SPoseUkryG5nILouI9lwfNR06n/jRoepPDkIvCUwOu2axxn5CpGw==
X-Received: by 2002:a05:6808:2189:: with SMTP id be9mr288895oib.78.1644870336353;
        Mon, 14 Feb 2022 12:25:36 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:6e69:6a60:fe6d:5371? (2603-8081-140c-1a00-6e69-6a60-fe6d-5371.res6.spectrum.com. [2603:8081:140c:1a00:6e69:6a60:fe6d:5371])
        by smtp.gmail.com with ESMTPSA id n24sm15488020oao.40.2022.02.14.12.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 12:25:36 -0800 (PST)
Message-ID: <04a372ee-cb82-2cbe-b303-d958af5e47f5@gmail.com>
Date:   Mon, 14 Feb 2022 14:25:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Inconsistent lock state warning for rxe_poll_cq()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <8f9fe1da-c302-0c45-8df8-2905c630daad@acm.org>
 <a300f716-718d-9cfe-a95f-870660b92434@gmail.com>
 <89e17cc9-6c90-2132-95e4-4e9ce65a9b08@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <89e17cc9-6c90-2132-95e4-4e9ce65a9b08@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/14/22 13:55, Bart Van Assche wrote:
> On 2/14/22 11:51, Bob Pearson wrote:
>> On 2/14/22 12:01, Bart Van Assche wrote:
>>> If I run the SRP tests against Jason's rdma/for-next branch then
>>> these tests pass if I use the siw driver but not if I use the
>>> rdma_rxe driver. Can you please take a look at the output triggered
>>> by running blktests? If I run blktests as follows: ./check -q srp,
>>> the following output appears: 5.17.0-rc1+
>>
>> You are running kernel 5.17.0-rc1-dbg+ I have 5.17.0-rc1+. I assume
>> they are different. How do I make the same kernel you are running?
> 
> The -dbg suffix comes from the following kernel configuration option:
> CONFIG_LOCALVERSION="-dbg"
> 
> The rdma/for-next commit I used in my tests is as follows: 2f1b2820b546
> ("Merge branch 'irdma_dscp' into rdma.git for-next").
> 
> Does this answer your question?
> 
> Bart.

It helps. I am trying to run blktests -q srp but I need to install xfs first it seems. Do I need two nodes or can I
run it with just one? 
