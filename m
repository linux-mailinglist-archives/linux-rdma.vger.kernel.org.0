Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDB039BD05
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jun 2021 18:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFDQZL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Jun 2021 12:25:11 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:42910 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFDQZL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Jun 2021 12:25:11 -0400
Received: by mail-ot1-f54.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so5194209oth.9
        for <linux-rdma@vger.kernel.org>; Fri, 04 Jun 2021 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rhn/HQuJz2n3Y5kLXNUHvbGoXcVE/cThQRFe5v2iY3M=;
        b=byvxv02ayB0TnUVgsmMb8qWP1eFA6jMszKCev9eHgG8eVxubqtF6/VTfOFNSrndG40
         JXjS2ikdHPOOiZc+2Xht4tglVwf7y5dWiRTMTm5lT6QEE027rWBSWWPShFrvEwUcAkaX
         9HqAh6SSH4r4uXPOMp1VdbbcFbgLxg4brbtiteDz6NKXWaYvcIf21Pb8/toOaQS2JF8p
         A/NIMo1vxVHAQtbkX4+Saq4du/AayPRz+fqqQPhgCKlA4KdNhcdwZlDMCp6A1M0vOAcq
         jX8o79cBNsN62HKSffCVbnlurlGSL9WEJB7ZaAdNbt7ulbqr7ts2ieX0uW7Gf6NF8aFy
         N2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rhn/HQuJz2n3Y5kLXNUHvbGoXcVE/cThQRFe5v2iY3M=;
        b=tGXvwQX6TzIjW20zTnsCHWpOZ4jYor8IFL0ahuIxXQZUKfXprGC63eeRF3hcbDL80b
         YJShi/Ei1GG76oZxYKdmcfeJmavP5PfPC72oHGZ8NjveygBQwOutWD79qGUTxliE2SPo
         r5g+4t0rlD3o0NU0QUfMLt3rRh3MlWNNL3Nhdo9n47gcj7OkCs9SVVZrfzs0JNkfX4xe
         4+hZPum7j2tvg797s4b4Td0z5CKYcxt1AzxCg4/42lbDze8XxE/EyLGHrA17lvun6L2s
         tEaPEOOktPsbG2qPck1K2xIxZdE+HzclyGrmkuk/u5/XqLCc81XTXZe+hT5M5BiIr1D8
         s+Xw==
X-Gm-Message-State: AOAM531E0BpfOcHdyzqYRIQsHqxMR0nSCP2ql8UXjzVDPR/udx7SgILL
        4DgAGLrcwrCdCOwJGeQwKqNu84hnTsc=
X-Google-Smtp-Source: ABdhPJwQJMA9XTr6wCTZHolpGVgu090PFwBB1C3akdoh6VjtlXU0USxZJeW1vuIr4O0UmSrlnC+REA==
X-Received: by 2002:a9d:2034:: with SMTP id n49mr1206607ota.231.1622823730931;
        Fri, 04 Jun 2021 09:22:10 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:81b6:accf:d415:6279? (2603-8081-140c-1a00-81b6-accf-d415-6279.res6.spectrum.com. [2603:8081:140c:1a00:81b6:accf:d415:6279])
        by smtp.gmail.com with ESMTPSA id b8sm582079ots.6.2021.06.04.09.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 09:22:10 -0700 (PDT)
Subject: Re: [PATCH for-next v8 00/10] RDMA/rxe: Implement memory windows
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyj2000@gmail.com, RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210525213751.629017-1-rpearsonhpe@gmail.com>
 <20210603185804.GA317620@nvidia.com>
 <CAD=hENeqZrtLbJF2J-HuetJec8MNfAVDHmcwkWmMNAfeX4-vng@mail.gmail.com>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <0c9c8709-8816-6083-59ef-c8d664ba382c@gmail.com>
Date:   Fri, 4 Jun 2021 11:22:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAD=hENeqZrtLbJF2J-HuetJec8MNfAVDHmcwkWmMNAfeX4-vng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/4/2021 12:37 AM, Zhu Yanjun wrote:
>
> After I added a rxe device on the netdev, then run rdma-core test tools.
> Then I remove rxe device, in the end, I unloaded rdma_rxe kernel modules.
> I found the above logs.
> "
> [ 1249.651921] rdma_rxe: rxe-pd pool destroyed with unfree'd elem
> [ 1249.651927] rdma_rxe: rxe-qp pool destroyed with unfree'd elem
> [ 1249.651929] rdma_rxe: rxe-cq pool destroyed with unfree'd elem
> "
>
> It seems that  some resources leak.
>
> I will make further investigations.
>
> Zhu Yanjun

Zhu,

I suspect this is an older error. I traced all the add and drop ref 
calls for PDs, then ran the full suite of Python tests and also test_mr 
which includes the memory window tests by itself and then counted the 
adds and drops. For test_mr alone I get 85 adds and 85 drops but when I 
run the whole suite I get 384 adds and 380 drops. Since the memory 
window code is only exercised in test_mr I think it is OK. Somewhere 
else there are missing drops. I will try to isolate them.

Bob

