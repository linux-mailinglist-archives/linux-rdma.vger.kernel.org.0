Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCDE39BF21
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jun 2021 19:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhFDRz5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Jun 2021 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDRz4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Jun 2021 13:55:56 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07489C061766
        for <linux-rdma@vger.kernel.org>; Fri,  4 Jun 2021 10:53:54 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so9875373oth.8
        for <linux-rdma@vger.kernel.org>; Fri, 04 Jun 2021 10:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7LeXXT1RW1BwfNpnG+btI3GYyebavdUVApqSterkHtE=;
        b=kDwNQ4cDj3WeIbYgEgeWgJGmZGGOgKN/cXH0wL+IHHjCdhe7Kt/p91qXkyG2p/FYEz
         ES3EG+YX+r9JNuSNVh13IaF4jPtV55c58rKZdRwwjp2toD68/uz445LEAuoL1wBXftlq
         TLSV2Cz9nzihXWX2jTb0Wepwlbnq7RkDyjsCy9tIBnyNit0bES7Xith7efS93qEAIbbg
         ElImZhDUnfnViDalcgeMPcU6sZl0pSM8wbtIqUlU+Oqy/D5RYUyEF4CWFOYy+davHr3z
         vpbxbsFMUbMiUBodf0ag21rSoIjy9mScbD559GvD5zuJxfgvCXrIuOI4bEnDceTi1PYL
         y2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7LeXXT1RW1BwfNpnG+btI3GYyebavdUVApqSterkHtE=;
        b=n16cBxsbcIjRmoYg/JR68MxDyJ7ivgOqzcLDZwTFPpkDMJxHysOPNkJsasWQO6NGEX
         QD2cE28dA6y95IVdS9ZDqoWhvcXWBhZ/afxpwm0VBaCyl/qteLKhO/v/gRfmuPMuSZWT
         LE87Ogv6FG4W3rUZQ8OmKnqziKoEmdhMHNDJ8Uc9DmWGbuxGLelWe5F3z/Y5ahzjkmfp
         nWrb39mdChG46uROfTZDppVu1rLMKgHlreAECoAp4CeKTG0+L2TtYhOCrBrjCNTd546F
         AaFYr4ZOyGVzTQUG9/Kk4RF6/avB2CYb9iWhT8DqI0VAcBON2JncMmc3rrrMGKMAZ2+i
         bNpw==
X-Gm-Message-State: AOAM532kYsDpruX0K8dlBR7bqp4kWQzN2E0Tmxd2PU/EQ0sNhtJ53PyM
        f4XKboRsY8YtJKHrUlvef1a3cpLUnxo=
X-Google-Smtp-Source: ABdhPJxzQ2Awyk0o2NHKweWXuv7WzhrsAFKvJSd9gf6UE0raujv82Mqqc7JqtHT8MBAW2v4vpkSCWg==
X-Received: by 2002:a9d:62c9:: with SMTP id z9mr4651844otk.55.1622829233097;
        Fri, 04 Jun 2021 10:53:53 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:81b6:accf:d415:6279? (2603-8081-140c-1a00-81b6-accf-d415-6279.res6.spectrum.com. [2603:8081:140c:1a00:81b6:accf:d415:6279])
        by smtp.gmail.com with ESMTPSA id b3sm607490otk.54.2021.06.04.10.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 10:53:52 -0700 (PDT)
Subject: Re: [PATCH for-next v8 00/10] RDMA/rxe: Implement memory windows
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyj2000@gmail.com, RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210525213751.629017-1-rpearsonhpe@gmail.com>
 <20210603185804.GA317620@nvidia.com>
 <CAD=hENeqZrtLbJF2J-HuetJec8MNfAVDHmcwkWmMNAfeX4-vng@mail.gmail.com>
 <0c9c8709-8816-6083-59ef-c8d664ba382c@gmail.com>
Message-ID: <8ae22b01-51e0-4115-31a5-ff9c1378efb6@gmail.com>
Date:   Fri, 4 Jun 2021 12:53:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <0c9c8709-8816-6083-59ef-c8d664ba382c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/4/2021 11:22 AM, Pearson, Robert B wrote:
>
> On 6/4/2021 12:37 AM, Zhu Yanjun wrote:
>>
>> After I added a rxe device on the netdev, then run rdma-core test tools.
>> Then I remove rxe device, in the end, I unloaded rdma_rxe kernel 
>> modules.
>> I found the above logs.
>> "
>> [ 1249.651921] rdma_rxe: rxe-pd pool destroyed with unfree'd elem
>> [ 1249.651927] rdma_rxe: rxe-qp pool destroyed with unfree'd elem
>> [ 1249.651929] rdma_rxe: rxe-cq pool destroyed with unfree'd elem
>> "
>>
>> It seems that  some resources leak.
>>
>> I will make further investigations.
>>
>> Zhu Yanjun
>
> Zhu,
>
> I suspect this is an older error. I traced all the add and drop ref 
> calls for PDs, then ran the full suite of Python tests and also 
> test_mr which includes the memory window tests by itself and then 
> counted the adds and drops. For test_mr alone I get 85 adds and 85 
> drops but when I run the whole suite I get 384 adds and 380 drops. 
> Since the memory window code is only exercised in test_mr I think it 
> is OK. Somewhere else there are missing drops. I will try to isolate 
> them.
>
> Bob
>
Zhu,

In rdma_core/tests/test_qpex.py test_qp_ex_rc_atomic_cmp_swp and 
test_qp_ex_rc_atomic_fetch_add each have two missing drops of PDs. This 
is either a test bug or a bug in the rxe driver but it has nothing to do 
with the MW code. We should treat it as a separate error. For some 
reason these test cases are not cleaning up all resources.

The cleanup code in all these Python tests is very implicit. It just 
happens by magic so it is hard to figure out where an ibv_destroy_qp or 
ibv_destroy_cq went missing. It would help if someone who is familiar 
with these tests could look at it.

Bob

