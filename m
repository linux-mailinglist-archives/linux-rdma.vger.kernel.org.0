Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D32AAC3E4D
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 19:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbfJARNf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 13:13:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40438 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfJARNf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 13:13:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id d26so4629439pgl.7
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 10:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZxjO+HtOVKXvqAkENLLGFzwcpu7kKnYCE0CmCRtE4p4=;
        b=oU4pD/zD6BbhQSMipNfI3Ch/O8AvUw5PboY7d8uSBRUs37Ox4AtDJZmQuI2pK+dQsH
         PDfgORHKuiBs58v0IeDhxH3CeDXwQBJ0dNm3cceu2AGkwzHMraxvI8mA08ZtCpfkilY1
         /t+W004la1tc8GxkNE97XtbaCe5R50myGQH1nD3ujRhS92VQV0L21i6Jzrk5WTooYVJt
         nUpl7Ij638Ec7AYd9AxpPJBfDMPXL/Fzxx7mMzVTg3kgxbNYVisStZ82cP2cLblVBzSQ
         p4V/CZws4GQ+M3U+PAtPPIy/mJzpDp+bUBHtBqAcyoj4i9mgyO1AND3LOi9WMsq7px4A
         lLWw==
X-Gm-Message-State: APjAAAXgnWjURBB+qexmxAH46EqURZlBz0f3VwMgbWOGF0wNe96eWM12
        a8vylkR7pG0odWW+11AwDwFC/kgSvD8=
X-Google-Smtp-Source: APXvYqw4MkIZMhHhqmIHX6GMCMVUCMoINefwEX1RuktAaFPUC7UuVghp9kib5V4Joi9KJQlYV7lveQ==
X-Received: by 2002:a62:e109:: with SMTP id q9mr28354672pfh.231.1569950014018;
        Tue, 01 Oct 2019 10:13:34 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g202sm23858687pfb.155.2019.10.01.10.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 10:13:33 -0700 (PDT)
Subject: Re: [PATCH 01/15] RDMA/ucma: Reduce the number of rdma_destroy_id()
 calls
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
References: <20190930231707.48259-1-bvanassche@acm.org>
 <20190930231707.48259-2-bvanassche@acm.org> <20191001150730.GD22532@ziepe.ca>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0db953de-5f04-56a2-e020-d2bda0fcf1d6@acm.org>
Date:   Tue, 1 Oct 2019 10:13:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001150730.GD22532@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/1/19 8:07 AM, Jason Gunthorpe wrote:
> On Mon, Sep 30, 2019 at 04:16:53PM -0700, Bart Van Assche wrote:
>> Instead of calling rdma_destroy_id() after waiting for the context completion
>> finished, call rdma_destroy_id() from inside the ucma_put_ctx() function.
>> This patch reduces the number of rdma_destroy_id() calls but does not change
>> the behavior of this code.
>>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>   drivers/infiniband/core/ucma.c | 17 ++++++++---------
>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
>> index 0274e9b704be..30c09864fd9e 100644
>> +++ b/drivers/infiniband/core/ucma.c
>> @@ -160,8 +160,14 @@ static struct ucma_context *ucma_get_ctx(struct ucma_file *file, int id)
>>   
>>   static void ucma_put_ctx(struct ucma_context *ctx)
>>   {
>> -	if (atomic_dec_and_test(&ctx->ref))
>> -		complete(&ctx->comp);
>> +	if (!atomic_dec_and_test(&ctx->ref))
>> +		return;
>> +	/*
>> +	 * rdma_destroy_id() ensures that no event handlers are inflight
>> +	 * for that id before releasing it.
>> +	 */
>> +	rdma_destroy_id(ctx->cm_id);
>> +	complete(&ctx->comp);
>>   }
> 
> Since all the refcounting here is basically insane, you can't do this
> without creating new kinds of bugs related to lifetime of ctx->cm_id
> 
> The call to rdma_destroy_id must be after the xa_erase as other
> threads can continue to access the context despite its zero ref via
> ucma_get_ctx(() as ucma_get_ctx() is not using refcounts properly.
> 
> The xa_erase provides the needed barrier.
> 
> Maybe this patch could be fixed if the ucma_get_ctx used an
> atomic_inc_not_zero ?

Hi Jason,

Since I'm not an ucma expert, maybe it's better that I drop this patch.

Thanks,

Bart.
