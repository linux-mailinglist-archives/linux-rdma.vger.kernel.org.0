Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A0F705BF7
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 02:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjEQAcj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 May 2023 20:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEQAci (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 May 2023 20:32:38 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6526E58
        for <linux-rdma@vger.kernel.org>; Tue, 16 May 2023 17:32:37 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6ab113d8589so236022a34.3
        for <linux-rdma@vger.kernel.org>; Tue, 16 May 2023 17:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684283557; x=1686875557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ArSfdNjpAkbE266wvUjE5B/qNou8MR8mejAQVO4/4Hw=;
        b=pfJ8fnUQt9gZe+7EAz8P1cileJLYQZYASyeIpRaNIB2HZhTL3ujyF6jYIV7oisgwhZ
         Ot0n+gr/70BO9ar5FFNT1c62vO9tIcBczm0K1LD/hwrBV4v9yHoyd7XuOH1h9iUq2VhF
         6A8k4oToe1I2o/SXgZDzj70HJpB7fftqxagFSQ1/ea2uM3ugjcWyf+SDUjLHrMKPGES5
         1uww6iHZrmza+bQSDqnJmIZyOgTM5GQ9iNo+p+utDT9qQmYKPU/ldhuTMBTdkC0agyWR
         DN4jfC2AoR5V4xpV+gv1a6nJLYQhXsaYkMs3B8yoLSWbc3y3cRTfCj6iZ9Y15Ll3RRnp
         ChEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684283557; x=1686875557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ArSfdNjpAkbE266wvUjE5B/qNou8MR8mejAQVO4/4Hw=;
        b=dQuqyb4Q+7Gf4k1ngtF/DvdEyzKdpUCfv0Ve0yqBzxcpo3vr5b4ademJIlPNfvTI04
         Sjd4nBktqdsfKyeUO9Iej825p5dRPB0lQv0nsvXAiYx6w5Ct6+bP6osgRqjyh/aGAwnH
         jE5voy632UKF/QCrzZ53lxdwq/YrEWqfGY3koRHo8vwkXPjRAqH3ZBmcnwXr2BcEusoz
         eBOKSabonVzs78vIs0MhU8Avi1DFuvUOkgTzyJB1529cllkutcoWRObXu9ZdTA7BLtc1
         8kw6J2EW8C5j6FC4/G5+h8wBG+3NyG2VcJMwHMQVGdFSaWTCl7IZwmvVbP34+pLnGMqb
         U+nQ==
X-Gm-Message-State: AC+VfDwCLnrNdANoNckHFFhkancL9olcToMcJJ+lNwcO2YWWczjhrzeb
        tczHkLg5wQ5x/0/x0TBsr9M=
X-Google-Smtp-Source: ACHHUZ7xHqPAKDrx1xWeTvyzsdMcFVZeXth+WDCmQG86vl84V7Ss3SOJxHMskbeN9+3XSoNgRIZF+A==
X-Received: by 2002:a9d:5e84:0:b0:6ac:8bf5:1f47 with SMTP id f4-20020a9d5e84000000b006ac8bf51f47mr7235896otl.5.1684283556961;
        Tue, 16 May 2023 17:32:36 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:6756:74e8:3efd:d9c5? (2603-8081-140c-1a00-6756-74e8-3efd-d9c5.res6.spectrum.com. [2603:8081:140c:1a00:6756:74e8:3efd:d9c5])
        by smtp.gmail.com with ESMTPSA id c14-20020a9d480e000000b0069f9203967bsm8500424otf.76.2023.05.16.17.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 17:32:36 -0700 (PDT)
Message-ID: <5d1aa20f-2cd0-5400-69e9-057ede404ae4@gmail.com>
Date:   Tue, 16 May 2023 19:32:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] RDMA/rxe: Convert spin_{lock_bh,unlock_bh} to
 spin_{lock_irqsave,unlock_irqrestore}
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org
References: <20230510035056.881196-1-guoqing.jiang@linux.dev>
 <ZGQbwBeIqk6YMKuf@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZGQbwBeIqk6YMKuf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/16/23 19:11, Jason Gunthorpe wrote:
> On Wed, May 10, 2023 at 11:50:56AM +0800, Guoqing Jiang wrote:
>> We need to call spin_lock_irqsave/spin_unlock_irqrestore for state_lock
>> in rxe, otherwsie the callchain
>>
>> ib_post_send_mad
>> 	-> spin_lock_irqsave
>> 	-> ib_post_send -> rxe_post_send
>> 				-> spin_lock_bh
>> 				-> spin_unlock_bh
>> 	-> spin_unlock_irqrestore
>>
>> caused below traces during run block nvmeof-mp/001 test.
> ..
>  
>> Fixes: f605f26ea196 ("RDMA/rxe: Protect QP state with qp->state_lock")
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_comp.c  | 26 +++++++++++--------
>>  drivers/infiniband/sw/rxe/rxe_net.c   |  7 +++---
>>  drivers/infiniband/sw/rxe/rxe_qp.c    | 36 +++++++++++++++++----------
>>  drivers/infiniband/sw/rxe/rxe_recv.c  |  9 ++++---
>>  drivers/infiniband/sw/rxe/rxe_req.c   | 30 ++++++++++++----------
>>  drivers/infiniband/sw/rxe/rxe_resp.c  | 14 ++++++-----
>>  drivers/infiniband/sw/rxe/rxe_verbs.c | 25 ++++++++++---------
>>  7 files changed, 86 insertions(+), 61 deletions(-)
> 
> Applied to for-rc, thanks
> 
> Jason

You didn't mention it but this shouldn't have applied/compiled without
fixing the overlap of these two patches. ??

Bob
