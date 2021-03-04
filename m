Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A5532D983
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 19:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhCDShE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 13:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbhCDSgq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Mar 2021 13:36:46 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591B9C061756
        for <linux-rdma@vger.kernel.org>; Thu,  4 Mar 2021 10:36:06 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id q203so8151749oih.5
        for <linux-rdma@vger.kernel.org>; Thu, 04 Mar 2021 10:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7mM2sMu+VM5rNCQ6UOcU/3oPX6yLp3RXM++B4VW98Zo=;
        b=XGmVAY/qJJC0f/ptJ7GuCgqilgYTcvlh20kAwNYRj1eH5BMnMJlSbbwdSzpAaBT1C7
         /5YmO8SXrpDwW6UzKF+1vBHxj7xBs+tRVimGV6xYlY4ASDo73oBqkcIMki5ECxIxgHFu
         Gte3ToLUxGAFuukBbipSmBNOIapDYVGsh1JGm/J+iW19N/xnjKGTyg5DTcc91hiqAAW9
         BhMEMtXQ0fEBDNYxsW9RSPd40pA8nbXv4nzjxaGaMCoEFg3Z/12Uw7g35iWtO8W1IRE6
         Vjdy8ycek0imudnNALOJvBPp7nCMqi6/Zv24RsWeGrJiNZqZCk45g+mDOI/zwkkvgHBo
         B32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7mM2sMu+VM5rNCQ6UOcU/3oPX6yLp3RXM++B4VW98Zo=;
        b=orVvE8+atstNPh1LsNv9jhEaKzCPJeon+HQv34Bs8CBQjaOwuQUQ8f6nzaN79eWp15
         b08ctfbfLHJnYumB13q+dEDHb/Umpn5amzpH3qkkb7HiL5SzZsKkORUDz4q7evYItiX7
         BQrrp9H/LrVsqNzp28VAaJHapGLLQzoS3aanpj0xipJ39AXlfTgGI587uR2QNlGNas4M
         XF/qcJNFDbGvPvK9ivLDxfPVKtsZrJ4ldmPAwnKkycudWaAgNWeG8zVLlZ8TfZN8Nz8+
         r7WWjqupj12U1h23rNon1gjehEqDOke9wTaMWUDYN4CYah/Jbt3Bh9XLqba1Mcr5y0n3
         cS4g==
X-Gm-Message-State: AOAM5306f+SDNpQoAEgEChfWYwlxZXkDI1JIOXrBuC6YeM8sPp7YQqza
        877Ga6MlL1qMl9uYOycFTqc=
X-Google-Smtp-Source: ABdhPJw4lO01BqFwmvn322DbBdp5k7u5++N1/4L3VhT37xUUmO0/VjK8OhoQxqZ7ZkGND5j/qLmANA==
X-Received: by 2002:a05:6808:148a:: with SMTP id e10mr3898626oiw.94.1614882965751;
        Thu, 04 Mar 2021 10:36:05 -0800 (PST)
Received: from ?IPv6:2603:8081:140c:1a00:8884:260e:7805:4030? (2603-8081-140c-1a00-8884-260e-7805-4030.res6.spectrum.com. [2603:8081:140c:1a00:8884:260e:7805:4030])
        by smtp.gmail.com with ESMTPSA id e34sm49352ote.70.2021.03.04.10.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 10:36:05 -0800 (PST)
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix ib_device reference counting
 (again)
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
References: <20210303225628.2836-1-rpearson@hpe.com>
 <CAD=hENcj91eT0VBQVExPBbg9K8+NNPr6BT_B47Q9cWqUP2KEcw@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <02bd870d-3f3e-1735-3cd9-686ef744c042@gmail.com>
Date:   Thu, 4 Mar 2021 12:36:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAD=hENcj91eT0VBQVExPBbg9K8+NNPr6BT_B47Q9cWqUP2KEcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/4/21 2:58 AM, Zhu Yanjun wrote:
> On Thu, Mar 4, 2021 at 7:02 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> Three errors occurred in the fix referenced below.
>>
>> 1) rxe_rcv_mcast_pkt() dropped a reference to ib_device when
>> no error occured causing an underflow on the reference counter.
>> This code is cleaned up to be clearer and easier to read.
>>
>> 2) Extending the reference taken by rxe_get_dev_from_net() in
>> rxe_udp_encap_recv() until each skb is freed was not matched by
>> a reference in the loopback path resulting in underflows.
>>
>> 3) In rxe_comp.c the function free_pkt() did not clear skb which
>> triggered a warning at done: and could possibly at exit: in
>> rxe_completer(). The WARN_ONCE() calls are not actually needed.
>>
>> This patch fixes these errors.
>>
>> Fixes: 899aba891cab ("RDMA/rxe: Fix FIXME in rxe_udp_encap_recv()")
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>> ---
>> Version 2:
>> v1 of this patch incorrectly added a WARN_ON_ONCE in rxe_completer
>> where it could be triggered for normal traffic. This version
>> replaced that with a pr_warn located correctly.
>>
>> v1 of this patch placed a call to kfree_skb in an if statement
>> that could trigger style warnings. This version cleans that up.
>>
>>  drivers/infiniband/sw/rxe/rxe_comp.c |  6 +--
>>  drivers/infiniband/sw/rxe/rxe_net.c  | 10 ++++-
>>  drivers/infiniband/sw/rxe/rxe_recv.c | 60 +++++++++++++++++-----------
>>  3 files changed, 48 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
>> index a8ac791a1bb9..96e5a73579f8 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
>> @@ -672,8 +672,10 @@ int rxe_completer(void *arg)
>>                          */
>>
>>                         /* there is nothing to retry in this case */
>> -                       if (!wqe || (wqe->state == wqe_state_posted))
>> +                       if (!wqe || (wqe->state == wqe_state_posted)) {
>> +                               pr_warn("Retry attempted without a valid wqe\n");
>>                                 goto exit;
>> +                       }
>>
>>                         /* if we've started a retry, don't start another
>>                          * retry sequence, unless this is a timeout.
>> @@ -750,7 +752,6 @@ int rxe_completer(void *arg)
>>         /* we come here if we are done with processing and want the task to
>>          * exit from the loop calling us
>>          */
>> -       WARN_ON_ONCE(skb);
>>         rxe_drop_ref(qp);
>>         return -EAGAIN;
>>
>> @@ -758,7 +759,6 @@ int rxe_completer(void *arg)
>>         /* we come here if we have processed a packet we want the task to call
>>          * us again to see if there is anything else to do
>>          */
>> -       WARN_ON_ONCE(skb);
> 
> With the above line is kept, I made tests with this commit.
> 1. git clone  https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
> 2. cd rdma && git pull
> 3. apply this commit and with "WARN_ON_ONCE(skb);" kept
> make tests with "rping ...."
> The similar problem still occurs.
> 
> Zhu Yanjun

The WARNs occur because skb is not getting cleared not because packets are not being
freed.

The issue is whether the skbs are freed not whether a local variable still has an
(old) address of an skb. The following would trigger a warning but doesn't mean
anything

	skb = skb_alloc(...);
	kfree_skb(skb);
	WARN_ON_ONCE(skb);

Every path out of the subroutine calls free_pkt() except one. That is because I was
trying to not change the behavior to the original code. That occurs in the
ERROR_RETRY state when no wqe is available. All other paths call free_pkt() and
there calls kfree_skb(). On that one path we leak an skb which is not good so we
should probably go ahead and free it too just dropping the packet. In that case we
can move the free_pkt() to the end and make it explicit that all the packets are
actually freed. I will modify the code to do that. The WARN is still not required.

Bob
