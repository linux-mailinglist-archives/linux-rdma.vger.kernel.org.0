Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C50C611A91
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 20:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiJ1S6L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 14:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJ1S6K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 14:58:10 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB261D2B71
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 11:58:10 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id cy15-20020a056830698f00b0065c530585afso3485071otb.2
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 11:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RfFihFep4/0vwomWLeW76JAth9WMrEBhy7bfFGXASZs=;
        b=XUu9Lcy8tgYr6/QFp3IzgSLFhVEFfyYlurws3DiUCqXD9ZeKQHVNDWuUuFGUJhUGc1
         wRx+uo5IR4L6eQ9/sWgseNNmRPyZztqMg9MvlQPFT/Ea1WsjNgvy33SbFAHCVfkbLTLy
         +dPXZTPBJKo4/M9SB1t+UHZsAlVf9+1eFE5ZUfMCQ7JM5QFzjDXav8f6KXW0B2MsMNJw
         KSFWfjqSTSC4i0eYlNedMAMn3+EzlS2WtDW5ZjYSJE0s8MPgRZURwIufayk4zZ8FFp63
         YiS+c/CEdrbOCdCi34mAJ/duA0RiKgtRM8cUklG98cB8Lo1cejiougFv1Je2jkYm2dBL
         QC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RfFihFep4/0vwomWLeW76JAth9WMrEBhy7bfFGXASZs=;
        b=fRMcaLVUT3j7m0ObFnIomIxnb/y+etpWR+7weky/j2DJYPcWicLKqQGZg/2HgOcptg
         YNLbv1V78OOaS2YMMf5Dgz3JnczXgP1cd2cPC6gMmWhmJk79AUAPWgRdVwCVAR9q9cg4
         St1aEL/nfaA+A1+3ZZmPMIzH4lIYM0nd8RUOo7MziiKWhJxLPgsuZIRPpVU1stxG5b9b
         +43ruQeFTbbAQUYxyUeV81IIZcy9/jnjedP5rTPrKYDmwqZVP38mKR8BEYISqAFJh+8p
         xenK7wg41US3X4yJPjV2V71zMGLmWqY1jAahmvMh+B0cpiKlRfmF+VZnbmbHdR/CnLWs
         gQAA==
X-Gm-Message-State: ACrzQf3zrqCetJIWVaQIP68kISoNekRW7Azkn1/GemptCrZo4kGgT5AI
        XJj3UqBXMqkt1ssdA58vdaI=
X-Google-Smtp-Source: AMsMyM4+sLr0KQLZxKIhpnpu0NNUV1p8KRH3HhlliqLp8BIloPMJ/m8fFXuvxoI5B8AngRuc8Pur9A==
X-Received: by 2002:a9d:66d7:0:b0:661:9410:12f3 with SMTP id t23-20020a9d66d7000000b00661941012f3mr393038otm.306.1666983489408;
        Fri, 28 Oct 2022 11:58:09 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:ff6f:6a:59a:5162? (2603-8081-140c-1a00-ff6f-006a-059a-5162.res6.spectrum.com. [2603:8081:140c:1a00:ff6f:6a:59a:5162])
        by smtp.gmail.com with ESMTPSA id 9-20020a9d0c09000000b00661a05691fasm1971211otr.79.2022.10.28.11.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 11:58:08 -0700 (PDT)
Message-ID: <83d14def-32e3-41b6-31c6-786dc5059eea@gmail.com>
Date:   Fri, 28 Oct 2022 13:58:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 00/18] Implement work queues for rdma_rxe
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, jhack@hpe.com,
        ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
 <Y1wLi5lFAGeeS9T3@nvidia.com>
 <6696eff3-2558-6aba-2d62-47b9d4b73fc6@gmail.com>
 <Y1wcyzvH5gMNxpaZ@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y1wcyzvH5gMNxpaZ@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/28/22 13:17, Jason Gunthorpe wrote:
> On Fri, Oct 28, 2022 at 01:16:11PM -0500, Bob Pearson wrote:
>> On 10/28/22 12:04, Jason Gunthorpe wrote:
>>>> Bob Pearson (18):
>>>>   RDMA/rxe: Remove redundant header files
>>>>   RDMA/rxe: Remove init of task locks from rxe_qp.c
>>>>   RDMA/rxe: Removed unused name from rxe_task struct
>>>>   RDMA/rxe: Split rxe_run_task() into two subroutines
>>>>   RDMA/rxe: Make rxe_do_task static
>>>
>>> I took these patches into for-next, the rest will need reposting to
>>> address the 0-day and decide if we should strip out the work queue
>>> entirely
>>>
>>> Jason
>>
>> I'm guessing you meant tasklet??
> 
> yes
> 
> Jason

What do you mean by 0-day?? Sounds like a cpu bug we used to talk about. But not sure what it
has to do with work queue patches.

Bob
