Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E71A40B44A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 18:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhINQQF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 12:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbhINQQF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Sep 2021 12:16:05 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6171C061764
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 09:14:47 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so19254479otg.11
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 09:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zo5QZR3VF17Zwvz1XTAba/lWPk48Qm+CpMo9RIIZQ9I=;
        b=RkgRAqyNF5EvMNcV7VxS+gGxu8Al0f1e6PNQJW0QNOTDSauyoCYbmK31ZhR++n6Ffa
         p+1/K6tT+nRxcBQpXlXMSsPhqlLGkKYrAWCNNN5r/IIinAkwmjzbTp0OmZ0AeMLFsAWo
         +eoG4ShT+2IpcXYzTwv2CfUZs8mgW9f8z3pphLAYvvPMRCi5JSFYx3s4MPgqar2CCxkw
         pJzcd4IwB8/TDO01Oeba/4zxsDxRveH+Sc5ui3wNPxGuIkX3yAj5VOoMEky9xInV22nC
         YNU0u0eXYHVpITep1RSkBVtSt5PsMpRa+JJ8MY//ZiThUK7dq0whUyk4RVrVYPxtuEcL
         z/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zo5QZR3VF17Zwvz1XTAba/lWPk48Qm+CpMo9RIIZQ9I=;
        b=fZnC0RsIXWcllluwlk6aUIufG09RscI5n+60x3YtWf0pSS2nL7K2XD8MR6e2KYL1WV
         mfq1BcviahZRLVp5GzVxKFfInRcpcvMbeJZZfqFuhnjfZQwKnIzsn8HQ8JkwoBDydRJG
         pN1NIXA87teMoMw+z+xVJRT5xRjWchyeBe3yer3lyug1P+IQXJFsPYQsXfLWxSZUFG9M
         xrghikCsw6Jhlt3LG9DESE1nBiaITsG3Tm18Kte4Xrp9lPEHaK1oOlQ3hLgX1PTAwlvD
         uB6YqvIEePS+x+V2OWFiPxLXFXoVrz35stG6o/QlzoUGOxh0vM58kPKID4yIkgwGTI5s
         MVzQ==
X-Gm-Message-State: AOAM5320MvJ4QCjjZ5oP3a4TknERD8qEAc6LsK2+WHKVkOGe7qIq9Ic7
        Lz60VaoizDN3FeDDn4uHyXi6dS+NIlayGQ==
X-Google-Smtp-Source: ABdhPJxvEXIY7yNd1JoqXoA4quwYFzyn7QLp4X+6+BmdhcxL1nzyejHvzojsKxtDs9j+ipSiXJRNgQ==
X-Received: by 2002:a9d:8f4:: with SMTP id 107mr15946858otf.248.1631636086871;
        Tue, 14 Sep 2021 09:14:46 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:d9f3:4e7a:72f1:83fe? (2603-8081-140c-1a00-d9f3-4e7a-72f1-83fe.res6.spectrum.com. [2603:8081:140c:1a00:d9f3:4e7a:72f1:83fe])
        by smtp.gmail.com with ESMTPSA id a11sm2520998oiw.36.2021.09.14.09.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 09:14:46 -0700 (PDT)
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
To:     Shoaib Rao <rao.shoaib@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
 <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
 <20210727174144.GE543798@ziepe.ca>
 <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
 <6687ea04-c402-1b4e-dce0-386d29948ecc@oracle.com>
 <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
 <eb24b781-396f-5bb9-89c7-3ca0f8b83849@oracle.com>
 <20210729195034.GF543798@ziepe.ca>
 <DF4PR8401MB1081385A8812159BA8E96A03BCEB9@DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM>
 <d89b2a2d-e72b-4942-28d6-c2a528053416@oracle.com>
 <20210806134939.GN543798@ziepe.ca>
 <f3849d06-f25b-5119-f2be-4974a72f9bad@oracle.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <af34b0c2-98bf-b8b5-3638-8b0fef1cd85a@gmail.com>
Date:   Tue, 14 Sep 2021 11:14:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f3849d06-f25b-5119-f2be-4974a72f9bad@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/12/21 7:50 PM, Shoaib Rao wrote:
> 
> On 8/6/21 6:49 AM, Jason Gunthorpe wrote:
>> On Wed, Aug 04, 2021 at 11:11:15PM -0700, Shoaib Rao wrote:
>>> Bob,
>>>
>>> Your third patch has an issue.
>>>
>>> In rxe_cq_post()
>>>
>>>
>>> addr = producer_addr(cq->queue, QUEUE_TYPE_TO_CLIENT);
>>>
>>> It should be
>>>
>>> addr = producer_addr(cq->queue, QUEUE_TYPE_FROM_CLIENT);
>>>
>>> After making this change, I have tested my patch and rping works.
>>>
>>> Bob can you please point me to the discussion which lead to the current
>>> changes, particularly the need for user barrier.
>>>
>>> Zhu can you apply Bob's 3 patches + the change above + my patch and report
>>> back. In my testing it works.
>> I'll expect Bob to resend
>>
>>     [for-next,v2,3/3] RDMA/rxe: Add memory barriers to kernel queues
>>
>> Jason
> 
> I have not seen a reply to this email thread. Has the issue been resolved and I missed it?
> 
> Shoaib
> 

Shoaib,

Thanks for this. I think I figured out what was causing the problem you tried to fix by
changing _TO_CLIENT to _FROM_CLIENT. That change isn't the whole solution.

The inline functions in rxe_queue.h all take a type parameter to let the compiler remove the switch
statement since the case is known at compile time. The types currently refer to the direction
of data flow in the queues from the point of view of the internals of the rxe driver. I.e.
for WQs data flows from the CLIENT to the DRIVER and for CQs the data flows to the CLIENT from
the DRIVER. This lets the routines in rxe_queue.h selectively use smp_load_acquire or
smp_store_release to 'protect' the queue indices owned by the client and private q->index for the
indices owned by the internals of the driver which is then copied to q->buf->producer/consumer_index.
The reason for this it that the driver can't trust the client in user space to not touch its data.

In rxe_cq.c where you made the change data is flowing to the client and the original type is the correct one. I believe the problem lies in rxe_verbs.c where verbs code manipulates the 'client'
end of the queues. This occurs in post_one_recv(), post_one_send(), rxe_poll_cq(), and rxe_peek_cq().
This code was using the same APIs as the driver internals which had two problems. First it had
the direction wrong in terms of which indices needed protection and worse it used the private
copies of the indices that should not be visible to clients. You put memory barriers in rxe_cq
that had the same effect ias putting the correct barriers in rxe_verbs.c.

I have fixed this by adding two new types for these verbs routines to use that put the correct
memory barriers on the correct indices. It is going to be resent as v4 of the patch series shortly.
I would like you to try it on rping and see of it cleans up what you were seeing.

Bob
