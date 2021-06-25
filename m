Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9A93B45A7
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 16:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFYOgJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 10:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFYOgI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Jun 2021 10:36:08 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACCDC061574;
        Fri, 25 Jun 2021 07:33:47 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id d21-20020a9d72d50000b02904604cda7e66so7677911otk.7;
        Fri, 25 Jun 2021 07:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qqeATMBZejC8yRXeEKlHGvYeEJLetyhWZWrc9LwJ/dg=;
        b=czIY6In9ksxB2HKCtxW6TBA85vEX0euV7IrPv+oKlQrOId2UMvGi3hzpJBJcvVTx0J
         HdrhJcnPBFv/iSAo+bzd3zjOeJ3nIzugzVcsPSPtYlSqYDkrkAGDc5KF0Nr5C3EEPx1i
         eyJ3d+QTJETtaRLET6b3spba8cPpc48MK1bz0SAAFINOQd8xht6QMLIPdR+xxQD5k91B
         424+UZWZsjiIh2tvWcf0/HiaO0+8AWPxP0NVouxLir0kbWl71RpZ5WfwdQWi8nqyP5v4
         uBWWKy7ltji6IyYfcwL0gf+adGQ68Omb3LO+IBS3DMvHIxPZWAD/9jL4BxhUwpWuYAsY
         4dDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qqeATMBZejC8yRXeEKlHGvYeEJLetyhWZWrc9LwJ/dg=;
        b=mWyqEDZ0OLQcOCyxcPe01EH95Z3ownvXxAOfyiCbvnoyWSm6+tKGkT0GNGtj5RmhZc
         EGE/pDuMSxWXDwzgvfJYSnr5fb6dE2YM6cITK1I0PGrcAx6TDhz0RtFiC9vwNjm0N7K5
         57mGzZyAIDDWMVWaF/iZuskmoQkqyqJZipmOCBvf2Xv9u/eWSRVqU0B17nXkZubBVUmp
         rp9mfErtWzBRAKqpj7MuHxOpMIsngAPpqpDbxxMmcXFp6tpTyBOUFB/aVCvYyYDuHXjx
         2xG+wbM2U93a9kIJLXWoe9un6KJcg0wXCGrCeQPCpLWNfPfOCJt/lpoLBXEzba+5A2jW
         CXoQ==
X-Gm-Message-State: AOAM531mhaQQZLpr1TmCmd5MzC7euZ5N8n3YtO7JewYnU99VFjHNK8NK
        63IQ1AClowhfG+2HOAWOdASucAoxLv4=
X-Google-Smtp-Source: ABdhPJytP4mbR6qwvbtnbvwuHtwYZEdrkubPyuLkttLrxk/SznA9OTiaME3ualga29qRZokCQffDKg==
X-Received: by 2002:a9d:4b98:: with SMTP id k24mr10102210otf.359.1624631627206;
        Fri, 25 Jun 2021 07:33:47 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:8bf2:41e6:f3a9:1be4? (2603-8081-140c-1a00-8bf2-41e6-f3a9-1be4.res6.spectrum.com. [2603:8081:140c:1a00:8bf2:41e6:f3a9:1be4])
        by smtp.gmail.com with ESMTPSA id m68sm301114oig.9.2021.06.25.07.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 07:33:47 -0700 (PDT)
Subject: Re: [PATCH] RDMA/rxe: missing unlock on error in get_srq_wqe()
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <YNXUCmnPsSkPyhkm@mwanda>
 <3e04bfeb-708e-d636-bf81-82dc2076db6c@gmail.com>
Message-ID: <211ac4e5-0a4a-35b9-8a5e-1c7d9c3bb395@gmail.com>
Date:   Fri, 25 Jun 2021 09:33:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3e04bfeb-708e-d636-bf81-82dc2076db6c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/25/21 9:32 AM, Bob Pearson wrote:
> On 6/25/21 8:03 AM, Dan Carpenter wrote:
>> This error path needs to unlock before returning.
>>
>> Fixes: ec0fa2445c18 ("RDMA/rxe: Fix over copying in get_srq_wqe")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>> I'm sort of surprised this one wasn't caught in testing...
>>
>>  drivers/infiniband/sw/rxe/rxe_resp.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>> index 72cdb170b67b..3743dc39b60c 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>> @@ -314,6 +314,7 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
>>  
>>  	/* don't trust user space data */
>>  	if (unlikely(wqe->dma.num_sge > srq->rq.max_sge)) {
>> +		spin_unlock_bh(&srq->rq.consumer_lock);
>>  		pr_warn("%s: invalid num_sge in SRQ entry\n", __func__);
>>  		return RESPST_ERR_MALFORMED_WQE;
>>  	}
>>
> 
> This is correct. Thanks.
> Bob Pearson 
> 
Should say
Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
