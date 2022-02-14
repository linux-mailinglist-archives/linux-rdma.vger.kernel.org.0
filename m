Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1094B5C0D
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Feb 2022 22:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiBNVK4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Feb 2022 16:10:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiBNVKx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Feb 2022 16:10:53 -0500
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529231216B0
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 13:10:38 -0800 (PST)
Received: by mail-pf1-f171.google.com with SMTP id d187so31341803pfa.10
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 13:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3rXzzUZACfMndxoxyQ/JNJBHZ2CwwktegFSpzWN3Pvw=;
        b=d5/6eY9h+FX+v7oL4Gm9RfxCLPVERJjQmv4OOWRd052WZ1wABtr70ChuQStEGffb7k
         W+vs66pvK1yTUaNzcsQobnE6xiJRZtdMtV/ed3AJdE8ZJnd/5E7F3ud/ozz7Vb4owPCb
         tX6zESm3Pevba17OgYoSFOc/5g65Ydu7O63vHVv11TknxAEmL5DeCsRVoqdLlAG7v6lz
         Svo5uee2n+LW39oSmuElt4GamCxbitVZtwrtLnv6Ll0c0e40eVVzRveoX5pFYaeVo9HY
         s8PzOO8K/lUtirWq/FsNv2F6+KiIXOvyTXrtzv+teE/oADO11Vh1/bCvxa9JOuXGZuQ7
         etsw==
X-Gm-Message-State: AOAM532fjIQwkV8b/xsVPw6AII842NIxiWKyE5wSt5mnGbRAO4hnfuyz
        Jl7KnrPTgZCK5ybsuDDz6RzL1AEQkNs=
X-Google-Smtp-Source: ABdhPJwl8FL/NGI3Uc0hLneQO8asRrEF+W5dwuxLlD3mgi1mBe2crgVqcHR7I28J7GGXjXsYhglqQg==
X-Received: by 2002:a63:ec56:: with SMTP id r22mr524643pgj.229.1644868515635;
        Mon, 14 Feb 2022 11:55:15 -0800 (PST)
Received: from ?IPV6:2600:1010:b05a:bf8:cd06:5464:d61e:f6b4? ([2600:1010:b05a:bf8:cd06:5464:d61e:f6b4])
        by smtp.gmail.com with ESMTPSA id j12sm320831pgf.63.2022.02.14.11.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 11:55:15 -0800 (PST)
Message-ID: <89e17cc9-6c90-2132-95e4-4e9ce65a9b08@acm.org>
Date:   Mon, 14 Feb 2022 11:55:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Inconsistent lock state warning for rxe_poll_cq()
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <8f9fe1da-c302-0c45-8df8-2905c630daad@acm.org>
 <a300f716-718d-9cfe-a95f-870660b92434@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a300f716-718d-9cfe-a95f-870660b92434@gmail.com>
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

On 2/14/22 11:51, Bob Pearson wrote:
> On 2/14/22 12:01, Bart Van Assche wrote:
>> If I run the SRP tests against Jason's rdma/for-next branch then
>> these tests pass if I use the siw driver but not if I use the
>> rdma_rxe driver. Can you please take a look at the output triggered
>> by running blktests? If I run blktests as follows: ./check -q srp,
>> the following output appears: 5.17.0-rc1+
> 
> You are running kernel 5.17.0-rc1-dbg+ I have 5.17.0-rc1+. I assume
> they are different. How do I make the same kernel you are running?

The -dbg suffix comes from the following kernel configuration option:
CONFIG_LOCALVERSION="-dbg"

The rdma/for-next commit I used in my tests is as follows: 2f1b2820b546
("Merge branch 'irdma_dscp' into rdma.git for-next").

Does this answer your question?

Bart.
