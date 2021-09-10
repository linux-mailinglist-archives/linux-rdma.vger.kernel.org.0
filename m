Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E68140733C
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Sep 2021 00:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhIJWJH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Sep 2021 18:09:07 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:54018 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbhIJWJG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Sep 2021 18:09:06 -0400
Received: by mail-pj1-f50.google.com with SMTP id j1so2285509pjv.3
        for <linux-rdma@vger.kernel.org>; Fri, 10 Sep 2021 15:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2E/cVWzPsOmMh9ufNDmSS1pyCIJiuWw5SIVwj/NWDlc=;
        b=ac/aMsS1D+cWlAkYE6kZPk9YBdyPIeLGexCwX8gxZ+ec6nJ+f5XOrE6pOq1vmzLesx
         CcA8VrYPNbsaBYDVEobWZnKHp0U4zIqSKSGIaX24EsHmbQMguVkl5jF4bx79qrKWigab
         xJS4PaXZLwvmyKmaFBuNvbvIddI6YEj34oz8p7h7vjI4BeH4iLaxUlaOSVuASEElOyHH
         JnIEPm1i38ZTPfwxlhHqhyx6PoIy2hC4rZHGxnzfpmBRRISoRVYbmnsUrVWtUaFoNwhG
         QSQKgqtrCKHuhyHgoTshoplnqe1eZtNFivnoPWpZu0H8ivMGKwTzVMJB6TZu/EVJjBYj
         7O4w==
X-Gm-Message-State: AOAM531loRJ9IxkwbcWIPgnb8jPxvxMPsfqQYxT056dl1eYRYdl1RO2O
        rtoaZYsMthzN9AJ9L0eQUuk=
X-Google-Smtp-Source: ABdhPJy9Rry15sDf54wY9s0nOKDVh2wdiRy944Y2ryaH9cfzVC6b98odBMskho3tr7k73nqfnYK/YA==
X-Received: by 2002:a17:90b:1909:: with SMTP id mp9mr11629172pjb.97.1631311674985;
        Fri, 10 Sep 2021 15:07:54 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8bd3:6a77:8a42:bdc5])
        by smtp.gmail.com with ESMTPSA id m13sm5976704pjv.20.2021.09.10.15.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 15:07:54 -0700 (PDT)
Subject: Re: [PATCH for-rc v3 0/6] RDMA/rxe: Various bug fixes.
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "Pearson, Robert B" <robert.pearson2@hpe.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "mie@igel.co.jp" <mie@igel.co.jp>
References: <20210909204456.7476-1-rpearsonhpe@gmail.com>
 <f0d96a3c-d49d-651d-93e0-a33a5eca9f1b@acm.org>
 <CS1PR8401MB10777EEC9CF95C00D1BA62ABBCD69@CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM>
 <2cb4e1cb-4552-9391-164a-88f638dd3acf@acm.org>
 <cf358367-5cb8-0482-28e6-993a4f6bb047@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <918787c7-de06-ef67-80ac-ae2e7643dd61@acm.org>
Date:   Fri, 10 Sep 2021 15:07:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cf358367-5cb8-0482-28e6-993a4f6bb047@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/10/21 2:47 PM, Bob Pearson wrote:
> OK I checked out the kernel with the SHA number above and applied the patch series
> and rebuilt and reinstalled the kernel. I checked out v36.0 of rdma-core and rebuilt
> that. rdma is version 5.9.0 but I doubt that will have any effect. My startup script
> is
> 
>      export LD_LIBRARY_PATH=/home/bob/src/rdma-core/build/lib/:/usr/local/lib:/usr/lib
> 
> 
> 
>      sudo ip link set dev enp0s3 mtu 8500
> 
>      sudo ip addr add dev enp0s3 fe80::0a00:27ff:fe94:8a69/64
> 
>      sudo rdma link add rxe0 type rxe netdev enp0s3
> 
> 
> I am running on a Virtualbox VM instance of Ubuntu 21.04 with 20 cores and 8GB of RAM.
> 
> The test looks like
> 
>      sudo ./check -q srp/001
> 
>      srp/001 (Create and remove LUNs)                             [passed]
> 
>          runtime  1.174s  ...  1.236s
> 
> There were no issues.
> 
> Any guesses what else to look at?

The test I ran is different. I did not run any of the ip link / ip addr /
rdma link commands since the blktests scripts already run the rdma link
command. The bug I reported in my previous email is reproducible and
triggers a VM halt.

Are we using the same kernel config? I attached my kernel config to my
previous email. The source code location of the crash address is as
follows:

(gdb) list *(rxe_completer+0x96d)
0x228d is in rxe_completer (drivers/infiniband/sw/rxe/rxe_comp.c:149).
144              */
145             wqe = queue_head(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
146             *wqe_p = wqe;
147
148             /* no WQE or requester has not started it yet */
149             if (!wqe || wqe->state == wqe_state_posted)
150                     return pkt ? COMPST_DONE : COMPST_EXIT;
151
152             /* WQE does not require an ack */
153             if (wqe->state == wqe_state_done)

The disassembly output is as follows:

drivers/infiniband/sw/rxe/rxe_comp.c:
149             if (!wqe || wqe->state == wqe_state_posted)
    0x0000000000002277 <+2391>:  test   %r12,%r12
    0x000000000000227a <+2394>:  je     0x2379 <rxe_completer+2649>
    0x0000000000002280 <+2400>:  lea    0x94(%r12),%rdi
    0x0000000000002288 <+2408>:  call   0x228d <rxe_completer+2413>
    0x000000000000228d <+2413>:  mov    0x94(%r12),%eax
    0x0000000000002295 <+2421>:  test   %eax,%eax
    0x0000000000002297 <+2423>:  je     0x237c <rxe_completer+2652>

So the instruction that triggers the crash is "mov 0x94(%r12),%eax".
Does consumer_addr() perhaps return an invalid address under certain
circumstances?

Thanks,

Bart.
