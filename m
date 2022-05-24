Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0BA53300F
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 20:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbiEXSHh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 14:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbiEXSHg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 14:07:36 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB8F6AA73
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 11:07:35 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-edeb6c3642so23239575fac.3
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4UQLj9nZMe/piEs6Qs/au14TDlF3M1m1CLeKyubuPuk=;
        b=MXdJOxwAn4gBdB36VVPfLx14jaBgOdIMFLR8aFolt0B1FVAAMfvn5dh6/MI81pXGsR
         //8XgJveAvMohczLriykEwnuZZCP1TFrActDKR2KjxCbc3SHFe32Fcsh3aUaCFaerUFp
         PYI5s54dZxABOzl1COsepDsv8AxORuaebmqCOU5u9RTf1E0i19AyYsEe5r69m1VUOE78
         K4D7AskwOrcNmtUG2NihealCduVtAraEOBjdNaeiL1+mMure5pR1Mz5iIJk3YUmQj5O/
         VHoeZbChS2XqmgKZ2gcUjBuGzF92e26feC5y4P/LkG7kKniIRnnWnnzXR6hsN83cyY40
         Nzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4UQLj9nZMe/piEs6Qs/au14TDlF3M1m1CLeKyubuPuk=;
        b=tZSk8PxCdXIjruxyn1tbvfKmc/B9uwIHBPaN/C1SYRBdxg8c1xgAQr40B3peeUZsbb
         MJ7+P1YFFjz4FpY6Flb/N6lvamzv+90Pzp8Y1A2xh1oGTwu3m2w2tteFjsNFVSZnuthC
         zAF2gMrLtjrw8HpjGKwHihdu4ZYFz7LompnSF8TYBgHQNPqGQMQYBbIv0Xx9xZa4c3e4
         2JeK3Sd0PAZ/p4Clc8rA0JMjsAIBcupESP/v6VhBYO8shmh8zU8ywQ+crDX9dZeuj8Rt
         88CgjbE04TP1nAaLxufD5LsSOYl5W8rrPQgAishUpgoYn8Bj1euyUva7j66R8BYkaB/E
         2asw==
X-Gm-Message-State: AOAM531aLbddqp3UbPx0/aafzsU+7y8yXxfNdSsO7VYfXNOnnAufsSYw
        IqbeZLWotfoqq7dSPkvlqC4=
X-Google-Smtp-Source: ABdhPJzaP7j438MGYj9qX8u/i7pTfR0Ys1kM8P9yCtyh3MJddhq8BPJXCFZA39C9VzvQoCCTzrJRjQ==
X-Received: by 2002:a05:6870:ecac:b0:f1:a98e:f2ed with SMTP id eo44-20020a056870ecac00b000f1a98ef2edmr3085340oab.159.1653415654773;
        Tue, 24 May 2022 11:07:34 -0700 (PDT)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id s16-20020a4aa550000000b0035eb4e5a6c8sm5605143oom.30.2022.05.24.11.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 11:07:34 -0700 (PDT)
Message-ID: <0ddfb667-87cb-47b0-539f-51a20125abf3@gmail.com>
Date:   Tue, 24 May 2022 13:07:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: null pointer in rxe_mr_copy()
Content-Language: en-US
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <1b0ae089-ff3f-7e84-4c07-a5d97554e3c0@gmail.com>
 <CAD=hENdM=VEF4MM_L=W1PtiX=x2s_kucMLc41WWmK-6c6s2Nrg@mail.gmail.com>
 <CAD=hENet+KQe35eqXabM+EpucHh3mYypUo4H8S-XmwNPcOv4+A@mail.gmail.com>
 <84888208-ac2e-115c-43d5-2ef211948c78@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <84888208-ac2e-115c-43d5-2ef211948c78@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/24/22 08:18, yangx.jy@fujitsu.com wrote:
> On 2022/4/11 13:34, Zhu Yanjun wrote:
>>   738         if (res->state == rdatm_res_state_new) {
>>   739                 mr = qp->resp.mr;
>> <----It seems that mr is from here.
>>   740                 qp->resp.mr = NULL;
>>   741
> 
> Hi Bob and Yanjun
> 
> I wonder if the following patch has fixed the null pointer issue in 
> rxe_mr_copy().
> 
> commit 570a4bf7440e9fb2a4164244a6bf60a46362b627
> Author: Bob Pearson <rpearsonhpe@gmail.com>
> Date:   Mon Apr 18 12:41:04 2022 -0500
> 
>      RDMA/rxe: Recheck the MR in when generating a READ reply
> 
> Best Regards,
> Xiao Yang

Correct.

Bob
