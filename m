Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C04407DCC
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Sep 2021 16:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhILOmS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Sep 2021 10:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhILOmS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 12 Sep 2021 10:42:18 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366F5C061574
        for <linux-rdma@vger.kernel.org>; Sun, 12 Sep 2021 07:41:04 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso9682085otv.3
        for <linux-rdma@vger.kernel.org>; Sun, 12 Sep 2021 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UXCAAWzsAc248j8W3csJz6aHG+VVFLBGCnJBr/UxOsU=;
        b=e7qmXb5sclb6NDl67Q7zsbuuWbI2EDB6JMmAG4jiww8czfcijo8/5M9R4scwCflgrR
         JgQn1WJ573lWVOR2gvUqiY74mrAmYgw3EPIYo8n3nMxQHlBTc3O/sD4QuQG+J1XU9VFB
         b7pwp1ryz7bQXNiTyrWzL14mOdRjeOYoi5MeN0EUvNrH8Bu+xzQW1UNs2GtVK/IICNxI
         egs4clBkIVUrgHmKCtOsYj2uroNTSnI6fiyNqWZyUf0J3SqoVqAnBprGv4QKmHOS3W56
         ZziqJT+9GwE6dg4QahLMHZCXiGBFTLtsnvx1UzZZ8r+3V/T7khakQMFlefuokzEUL+Ex
         7NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UXCAAWzsAc248j8W3csJz6aHG+VVFLBGCnJBr/UxOsU=;
        b=soucoNfMB06YId9cN8849rXJ59U4AzyFBokjhiimH1SfVR4EI+QcAkrjWBlgKrzWaS
         OKjZcgYsK2gsZ9WH2JtTuVF+7UyTRUy1iPlJGhKZvoJ442mlMyjJVeiGOIxrU4vSpdwf
         +YI10YSQa14MB0fMaVdpMKwZqozFzq1WJvVmRkwlZxM8SV0HwVHYAlbHYyccmhkFHXY9
         FhYwK5hLgvPAsnicuIMlbB6KV4r8qnq5T5AW5uo41rf+hafjKFlgH3xcOPjgaYHoUbb+
         1To71I+QMqCAZpVNgIuv0Te3y9wr31pyIlbtJzPU9YvxjOFK4eWewLngyEz9j8uI2hrb
         s3RA==
X-Gm-Message-State: AOAM53239oztQ6bDhkmCiDj/zPGFaYOxQjPByLG68CjqBw0WvsXr2xwV
        YlYoEhGXZPYPfBeeHNUQxFM=
X-Google-Smtp-Source: ABdhPJwLCXkJ8TtUmkiHWkZgsdirvCwIm1b68aImruzBH8mspZT2zV736DDSj6qi/siJ8PJpNIJPag==
X-Received: by 2002:a05:6830:2b2c:: with SMTP id l44mr6272967otv.238.1631457663581;
        Sun, 12 Sep 2021 07:41:03 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:3af0:978b:868:ab47? (2603-8081-140c-1a00-3af0-978b-0868-ab47.res6.spectrum.com. [2603:8081:140c:1a00:3af0:978b:868:ab47])
        by smtp.gmail.com with ESMTPSA id h3sm1164393otu.7.2021.09.12.07.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 07:41:03 -0700 (PDT)
Subject: Re: [PATCH for-rc v3 0/6] RDMA/rxe: Various bug fixes.
To:     Bart Van Assche <bvanassche@acm.org>,
        "Pearson, Robert B" <robert.pearson2@hpe.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "mie@igel.co.jp" <mie@igel.co.jp>, Xiao Yang <yangx.jy@fujitsu.com>
References: <20210909204456.7476-1-rpearsonhpe@gmail.com>
 <f0d96a3c-d49d-651d-93e0-a33a5eca9f1b@acm.org>
 <CS1PR8401MB10777EEC9CF95C00D1BA62ABBCD69@CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM>
 <2cb4e1cb-4552-9391-164a-88f638dd3acf@acm.org>
 <cf358367-5cb8-0482-28e6-993a4f6bb047@gmail.com>
 <918787c7-de06-ef67-80ac-ae2e7643dd61@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <557a5fd9-2a30-5752-d09b-05183ab3c43b@gmail.com>
Date:   Sun, 12 Sep 2021 09:41:02 -0500
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

The most likely cause of this was fixed by a patch submitted 8/20/2021 by Xiao Yang. It is copied here

From: Xiao Yang <yangx.jy@fujitsu.com>
To: <linux-rdma@vger.kernel.org>
Cc: <aglo@umich.edu>, <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>,
	<jgg@nvidia.com>, <leon@kernel.org>,
	Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Zero out index member of struct rxe_queue
Date: Fri, 20 Aug 2021 19:15:09 +0800	[thread overview]
Message-ID: <20210820111509.172500-1-yangx.jy@fujitsu.com> (raw)

1) New index member of struct rxe_queue is introduced but not zeroed
   so the initial value of index may be random.
2) Current index is not masked off to index_mask.
In such case, producer_addr() and consumer_addr() will get an invalid
address by the random index and then accessing the invalid address
triggers the following panic:
"BUG: unable to handle page fault for address: ffff9ae2c07a1414"

Fix the issue by using kzalloc() to zero out index member.

Fixes: 5bcf5a59c41e ("RDMA/rxe: Protext kernel index from user space")
Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
index 85b812586ed4..72d95398e604 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.c
+++ b/drivers/infiniband/sw/rxe/rxe_queue.c
@@ -63,7 +63,7 @@ struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
 	if (*num_elem < 0)
 		goto err1;
 
-	q = kmalloc(sizeof(*q), GFP_KERNEL);
+	q = kzalloc(sizeof(*q), GFP_KERNEL);
 	if (!q)
 		goto err1;
 
-- 
2.25.1

If kmalloc returns a dirty block of memory you could get random values in the q index which could
easily give a page fault. Once the rxe driver writes a new value it will be masked before storing
and should always be in the allocated buffer. I am not seeing this error perhaps because I am
running in a VM. I just don't know. It should be added to the other fixes.

Bob
