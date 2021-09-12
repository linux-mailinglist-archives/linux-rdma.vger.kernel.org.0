Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52F9407DCE
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Sep 2021 16:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbhILOnt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Sep 2021 10:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhILOns (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 12 Sep 2021 10:43:48 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0B3C061574
        for <linux-rdma@vger.kernel.org>; Sun, 12 Sep 2021 07:42:34 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id q11-20020a9d4b0b000000b0051acbdb2869so9683690otf.2
        for <linux-rdma@vger.kernel.org>; Sun, 12 Sep 2021 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=J1v2c+lqfnHoX58ukPWRffbWKpbAtbfqDpazu3tqymA=;
        b=AJ9E2cjr7DllX5YQgyOm5uFtkzSCaxDkNSAXyH/pEcr5jnJPqbo1nu+1NCDB5mRhPo
         CapXTWBgzCRDLDez4FgHwpvOYbfxI76lk9FbEC2obrOM1oeHymo1qlo8F16C7E6BwbYk
         fgJRcqX1xOLn50SK4MuOacCCoK+4uO+YXdnhd9udBk5duWmMNimHcpITnw9PCvsc11gE
         9tfvfjRzzRIh7rhTxd7t/qb8z3VlmrwgWPhMQD3BlVXzTEqSD09Al8dsZYBm9GWUuxQP
         yV1Jzgbf4wlWAd8zE3M4AWua9HxvVwbVWT1jne7jFCSrTmA4sCZ45Hanamks2M4XNvv+
         Kw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J1v2c+lqfnHoX58ukPWRffbWKpbAtbfqDpazu3tqymA=;
        b=5/7XdfWg5UrT9+Erk4gY0plYnhytmAXHQaXxtooW9W+qZ+65dlM3dgpCJqNrYnJ2z+
         4d//Di3PNn58cq4SK/vb5oL5P4jcFJKI1E5zx1Ri26CImYJ4azU9kqx16yrSBokdD3mO
         3qPLl+vJBh3LFrhCd/KiP6xwbDWBjALSiDY6lJ38bgWwXfJBpwQKFDIH010Sdus8nvop
         SWwYc14OwuCfKW9HNg9HtPmX5gji7AvDKgtWd3eV4NWZtRNn+90TqIydYpR3ZYAcfo/i
         hkZQIT1akKS7O+r5nNj5rW+71KFihvtwYGd06cqXlbcfVXQ1N/gu8e37rDlW3hVVbvXF
         vbPw==
X-Gm-Message-State: AOAM531/0PrS58Ta6WlKmqqSxLRjppbwrkG/ja7Fpl/A+bWp0XaCnilR
        qI+UUBhnI/73gT0r0rBwMzE=
X-Google-Smtp-Source: ABdhPJyn5TP5yMIs9FKF34owgm3dKvBzCjWLXTZB+Ky2ERSQ29i5q9DX671PVNY6pS6jVinBaOI1Mg==
X-Received: by 2002:a9d:1b46:: with SMTP id l64mr5966095otl.201.1631457753601;
        Sun, 12 Sep 2021 07:42:33 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:3af0:978b:868:ab47? (2603-8081-140c-1a00-3af0-978b-0868-ab47.res6.spectrum.com. [2603:8081:140c:1a00:3af0:978b:868:ab47])
        by smtp.gmail.com with ESMTPSA id q36sm1048371oiw.35.2021.09.12.07.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 07:42:33 -0700 (PDT)
Subject: Re: [PATCH for-rc v3 0/6] RDMA/rxe: Various bug fixes.
To:     Bart Van Assche <bvanassche@acm.org>,
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
 <918787c7-de06-ef67-80ac-ae2e7643dd61@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <a048c223-a649-749a-2309-866d10c3e645@gmail.com>
Date:   Sun, 12 Sep 2021 09:42:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <918787c7-de06-ef67-80ac-ae2e7643dd61@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/10/21 5:07 PM, Bart Van Assche wrote:
> On 9/10/21 2:47 PM, Bob Pearson wrote:
>> OK I checked out the kernel with the SHA number above and applied the patch series
>> and rebuilt and reinstalled the kernel. I checked out v36.0 of rdma-core and rebuilt
>> that. rdma is version 5.9.0 but I doubt that will have any effect. My startup script
>> is
>>
>>      export LD_LIBRARY_PATH=/home/bob/src/rdma-core/build/lib/:/usr/local/lib:/usr/lib
>>
>>
>>
>>      sudo ip link set dev enp0s3 mtu 8500
>>
>>      sudo ip addr add dev enp0s3 fe80::0a00:27ff:fe94:8a69/64
>>
>>      sudo rdma link add rxe0 type rxe netdev enp0s3
>>
>>
>> I am running on a Virtualbox VM instance of Ubuntu 21.04 with 20 cores and 8GB of RAM.
>>
>> The test looks like
>>
>>      sudo ./check -q srp/001
>>
>>      srp/001 (Create and remove LUNs)                             [passed]
>>
>>          runtime  1.174s  ...  1.236s
>>
>> There were no issues.
>>
>> Any guesses what else to look at?
> 
> The test I ran is different. I did not run any of the ip link / ip addr /
> rdma link commands since the blktests scripts already run the rdma link
> command. The bug I reported in my previous email is reproducible and
> triggers a VM halt.
> 
> Are we using the same kernel config? I attached my kernel config to my
> previous email. The source code location of the crash address is as
> follows:
> 
> (gdb) list *(rxe_completer+0x96d)
> 0x228d is in rxe_completer (drivers/infiniband/sw/rxe/rxe_comp.c:149).
> 144              */
> 145             wqe = queue_head(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
> 146             *wqe_p = wqe;
> 147
> 148             /* no WQE or requester has not started it yet */
> 149             if (!wqe || wqe->state == wqe_state_posted)
> 150                     return pkt ? COMPST_DONE : COMPST_EXIT;
> 151
> 152             /* WQE does not require an ack */
> 153             if (wqe->state == wqe_state_done)
> 
> The disassembly output is as follows:
> 
> drivers/infiniband/sw/rxe/rxe_comp.c:
> 149             if (!wqe || wqe->state == wqe_state_posted)
>    0x0000000000002277 <+2391>:  test   %r12,%r12
>    0x000000000000227a <+2394>:  je     0x2379 <rxe_completer+2649>
>    0x0000000000002280 <+2400>:  lea    0x94(%r12),%rdi
>    0x0000000000002288 <+2408>:  call   0x228d <rxe_completer+2413>
>    0x000000000000228d <+2413>:  mov    0x94(%r12),%eax
>    0x0000000000002295 <+2421>:  test   %eax,%eax
>    0x0000000000002297 <+2423>:  je     0x237c <rxe_completer+2652>
> 
> So the instruction that triggers the crash is "mov 0x94(%r12),%eax".
> Does consumer_addr() perhaps return an invalid address under certain
> circumstances?
> 
> Thanks,
> 
> Bart.

By the way I did rebuild the kernel with your config file. No change. - Bob
