Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69355EF9A2
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 17:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbiI2P6p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 11:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbiI2P6g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 11:58:36 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813891CE14A
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 08:58:34 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id g130so2006139oia.13
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=k8mJV/+N2RjkQU+1v7GIhv44CbzIi+LAdXXNIV+CGOc=;
        b=gGWlumIC72iuZdUpYqsC3glZGpKUQhEulz5+BRvder7ogv7QUx3pjrl0sfOeiqZuBt
         jjznEEwVNf/Y3VOx28L1dgRIEjDKIvBfcM6Q3J0vX+Iue7kVCRTsr3klv1QejYoXVIV6
         KhfW0QAMsE/o1GW54Zd7qkHVAL1Xmr8X8YJY1TNU8yBfTNpUgvttweFwSYyx3f+2Lm7d
         LgXYkNZ27c5zxAdbfYj3I3CoGx269hWLSA9c7EWfkkcUzxg31yoEDI4+nbthsvzXM10q
         xNLU4ywHdTSeZmcEGjPpJiXDNniKgvnorR1wdlKIUT3XCzzudmjxhSNvaSXRT5sZkdsk
         CzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=k8mJV/+N2RjkQU+1v7GIhv44CbzIi+LAdXXNIV+CGOc=;
        b=kduE2WttMWi7LgIWTsPL0nI5LuoYcICa//8XxEDWkEQ3X1Qn2EF65WW3H7vxltQuRX
         rJAqpfMUl/FeQz/6P4xxUbmI4pAJO7jD/RS1EgyqHUyivYi9EkpTrHnAlTwg+DmcQnqo
         3KwCGZwE9DBBmDZE9O0i40bAQ0cwc4wsb1CthGtlRXS4aayfGDbSa1JGTD4KhZpmISTG
         b+7QBn0YogO772t6rsW0jhu4M2peqUuh8aXh1v+mSU3xD4OnvXz3ocUvp0IJmexvmMdj
         M7r5thnfkSjj3CUjj+DMJKbfVXeTjx1J92uHaAntmrcYqCPDbXuGaqrpopbbgpQiKJ3d
         HROw==
X-Gm-Message-State: ACrzQf26bGSBxl5okLZ/AfQOc/aQYb4l/ToX/p6oKwGrlOqxbaQzks0/
        jMawX1s6avUlfknTpyKRMh4=
X-Google-Smtp-Source: AMsMyM6Lmxeqv8p4Oh8siXArRXAVUi1I6l6cSZJntNszNOHkq85/0fsimBQ5hDK23MoCo8f5svYGPg==
X-Received: by 2002:a05:6808:23c1:b0:350:4d8a:cbc2 with SMTP id bq1-20020a05680823c100b003504d8acbc2mr7391117oib.167.1664467113834;
        Thu, 29 Sep 2022 08:58:33 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:6c9b:432a:3a95:bcf1? (2603-8081-140c-1a00-6c9b-432a-3a95-bcf1.res6.spectrum.com. [2603:8081:140c:1a00:6c9b:432a:3a95:bcf1])
        by smtp.gmail.com with ESMTPSA id l11-20020a056870204b00b0012796e8033dsm2992oad.57.2022.09.29.08.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 08:58:33 -0700 (PDT)
Message-ID: <2d0420d9-b2b2-1a23-084c-6104bac18838@gmail.com>
Date:   Thu, 29 Sep 2022 10:58:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
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
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <TYCPR01MB84557734DE313F81A10D30B1E5559@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/26/22 20:38, matsuda-daisuke@fujitsu.com wrote:
> On Tue, Sep 27, 2022 8:14 AM, Jason Gunthorpe wrote:
>> On Fri, Sep 16, 2022 at 10:10:51PM -0500, Bob Pearson wrote:
>>> This patch series implements the xrc transport for the rdma_rxe driver.
>>> It is based on the current for-next branch of rdma-linux.
>>> The first two patches in the series do some cleanup which is helpful
>>> for this effort. The remaining patches implement the xrc functionality.
>>> There is a matching patch set for the user space rxe provider driver.
>>> The communications between these is accomplished without making an
>>> ABI change by taking advantage of the space freed up by a recent
>>> patch called "Remove redundant num_sge fields" which is a reprequisite
>>> for this patch series.
>>>
>>> The two patch sets have been tested with the pyverbs regression test
>>> suite with and without each set installed. This series enables 5 of
>>> the 6 xrc test cases in pyverbs. The ODP case does is currently skipped
>>> but should work once the ODP patch series is accepted.
>>
>> The ODP patch isn't even on patchworks any more, so it needs
>> resending. I can't remember why it needed respin now.
> 
> The ODP patch series is the one I posted for rxe this month:
>   [RFC PATCH 0/7] RDMA/rxe: On-Demand Paging on SoftRoCE
>   https://lore.kernel.org/lkml/cover.1662461897.git.matsuda-daisuke@fujitsu.com/
>   https://patchwork.kernel.org/project/linux-rdma/list/?series=674699&state=%2A&archive=both
> 
> We had an argument about the way to use workqueues instead of tasklets.
> Some prefer to get rid of tasklets, but others prefer finding a way to switch
> between the bottom halves for performance reasons. I am currently taking
> some data to continue the discussion while waiting for Bob to post their(HPE's)
> implementation that enables the switching. I think I can resend the ODP patches
> without an RFC tag once we reach an agreement on this point.

I tried to get Ian Ziemba, who wrote the patch series, to send it in but he is very busy
and finally after a long while he asked me to do that. I have to rebase it from
an older kernel to head of tree. I hope to have that done in a day or two.

Bob
> 
> Thanks,
> Daisuke Matsuda
> 
>>
>> I'm inclined to apply this without really looking closely at the rxe
>> code. If someone has other ideas please chime in. It looks like it
>> needs rebasing, yes?
>>
>> Jason


