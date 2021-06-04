Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6EA39C3C7
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Jun 2021 01:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFDXUZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Jun 2021 19:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFDXUZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Jun 2021 19:20:25 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2BBC061766
        for <linux-rdma@vger.kernel.org>; Fri,  4 Jun 2021 16:18:27 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so10631101otp.11
        for <linux-rdma@vger.kernel.org>; Fri, 04 Jun 2021 16:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HqrBgYEtvLs7vFG26cuE0SJBKGYihnDCMxSbGYN1aIA=;
        b=euJYQzujA/RKEXZcQtpg5u/Y/1MtYVmRKWc+BsFq/2lPyKEiXNFVjNK6mFZOYqQf4j
         Tj2M3KNh78GL/zvieuaAPr4gplZuLnAr4X1y8MG6vt+7Zl+boPafwHLRNtdnM0wr0jLS
         OBXVC2PwFW8TidiLL44plAv3XmMbDK+AE2UjW0azC2huPWXAkGIpC+o+PBxK4igVyd+f
         VO0VJkV/Yv/PgjybdiLSQCEV3V/D/8ogZODJGTrXe781T2ryDRKiMyJzWDBrhh01ko0q
         FkkCWLUnaH+py+Xafzgyy4Kv+WWBMhHMl7zd+o6eize9SasS3dtStPeRN2TAc+daAbnT
         x9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HqrBgYEtvLs7vFG26cuE0SJBKGYihnDCMxSbGYN1aIA=;
        b=ZSwXb/9VI/9oRbTPGr+5hRuNC9L/nXkD4cKZRnz8WmYV+HfkK9gJLG+VDxyQP1YuF0
         +Eq9uphyGAZmQS5stH0cqv5oK/72qQBbUDdtaIm1I/qPvZTPiwf6AgelREpGl1ZBvnII
         55dKODJj7WvdpRPThSk6FWRQcq8tzUlNvIE0Hqb4NnjWJz68ftCbrE2ucbacY0zyedoH
         vjewefuINMSPyIBFm2P12wJND0eg1BSVam7sSOfVQgcL0shXq5B1rNy99HD+Ro85svoB
         JtU+Xfb/fQ0aedUR47G+Qhyj+z+wQeG5SrrQp49OOjl+sAPjTsd3HYhq4c1OFyfxzruE
         k0qg==
X-Gm-Message-State: AOAM531zHeZ01BMxcA6vn9/LkSdywxO9M5wcAcmxXsTBifpvKv9QaZcM
        nVZygUvQEUnyoYRpHVWpcc/AevkPqBk=
X-Google-Smtp-Source: ABdhPJw8HvpuvBr00fsOuSkKMWBpL39TSIvWcssX+Z+SRpxoPbfjisa0XZbCmbDPIF3ZDLrlAuNHLg==
X-Received: by 2002:a9d:6c6:: with SMTP id 64mr2796919otx.199.1622848706172;
        Fri, 04 Jun 2021 16:18:26 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:c04b:c76e:4a4f:9612? (2603-8081-140c-1a00-c04b-c76e-4a4f-9612.res6.spectrum.com. [2603:8081:140c:1a00:c04b:c76e:4a4f:9612])
        by smtp.gmail.com with ESMTPSA id i19sm422631otp.81.2021.06.04.16.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 16:18:25 -0700 (PDT)
Subject: Re: [PATCH for-next] RDMA/rxe: Fix qp reference counting for atomic
 ops
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20210604230558.4812-1-rpearsonhpe@gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <6e484229-8190-627c-6a95-8c9abe532a6e@gmail.com>
Date:   Fri, 4 Jun 2021 18:18:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210604230558.4812-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/4/21 6:05 PM, Bob Pearson wrote:
> Currently the rdma_rxe driver attempts to protect atomic responder
> resources by taking a reference to the qp which is only freed when the
> resource is recycled for a new read or atomic operation. This means that
> in normal circumstances there is almost always an extra qp reference
> once an atomic operation has been executed which prevents cleaning up
> the qp and associated pd and cqs when the qp is destroyed.
> 
> This patch removes the call to rxe_add_ref() in send_atomic_ack() and the
> call to rxe_drop_ref() in free_rd_atomic_resource(). If the qp is
> destroyed while a peer is retrying an atomic op it will cause the
> operation to fail which is acceptable.
> 
> Reported-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> Fixes: 86af61764151 ("IB/rxe: remove unnecessary skb_clone")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c   | 1 -
>  drivers/infiniband/sw/rxe/rxe_resp.c | 2 --
>  2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 34ae957a315c..b6d83d82e4f9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -136,7 +136,6 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
>  void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res)
>  {
>  	if (res->type == RXE_ATOMIC_MASK) {
> -		rxe_drop_ref(qp);
>  		kfree_skb(res->atomic.skb);
>  	} else if (res->type == RXE_READ_MASK) {
>  		if (res->read.mr)
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 2b220659bddb..39dc39be586e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -966,8 +966,6 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>  		goto out;
>  	}
>  
> -	rxe_add_ref(qp);
> -
>  	res = &qp->resp.resources[qp->resp.res_head];
>  	free_rd_atomic_resource(qp, res);
>  	rxe_advance_resp_resource(qp);
> 
There is another way to fix this which is to add cleanup_rd_atomic_resources to rxe_qp_destroy() but it has the exact same behavior because it removes the responder resource causing a retried operation to fail. You can't add it to the qp cleanup routines because you never get there until the ref count goes to zero. I think the above is the cleanest solution.

Bob
