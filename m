Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7959C390CD1
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 01:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhEYXOY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 19:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhEYXOY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 19:14:24 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01882C061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 16:12:54 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so5931551otl.3
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 16:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5OcsbA+ZtO2v5AVqt3vKyDiOL1iq7m26XdQyKXRUQy0=;
        b=f90ZpRRLNJEayR6zzET9arFNHzSCPeqmWzZvqWla6IxZTtcXVnHw/friJTfx9xn4rX
         oV6OzmnqWLLmiAzIRIGpVLJpTltrNhJexVYp1PPVKHbasD8L9E2Owrpd20fPls4IR3iA
         WW40yk11w7CnEFOm+ul/3GEb6+UzFMo6hXqLRSY7NpgfdHrWGVOKaKEplAPeaxGrsTwl
         nZWWA853Ks62Yl8jQZmwKba0gyX1mT9oZ0S52C/J9gP48V16pskamMUnZS+2FVioVXp1
         rnrXfiNhx0A8nkm0nGzb+o4lULoe99r1vSa55n8ygWJqRP7GAKLI4CT0wtJwPw+WPRvS
         P6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5OcsbA+ZtO2v5AVqt3vKyDiOL1iq7m26XdQyKXRUQy0=;
        b=TF+pmuIOIDHM7HCkiCjfBAgMu2TipMncFa3wEfVP1X89OdTJu5fSBMG3ybl05m8M1Y
         cAxQASflbdzeqq4349VW+MitS7gAaK5G9M46urn5gz3xkJkT7ddMawprNASSEAsj8r0s
         OjGD5iMP3V7EV51ku6NtguhDuPFCuWU2yN7TVBxhhuDNz4DEWOVJWiZuM1inBpydvhhJ
         OlVHV9RiwyCrAEQb5m/QOo9GuVMcPlgZCqjgy0LgKBnSbYssHGYJM9kQ0kV6cMqXCMJM
         vJuU24ar8COWzy/odPCHFoulP4zytPdizbHNF3rI8PnnWiYIyTXmo1vBeurgAZsAxGqz
         4wKg==
X-Gm-Message-State: AOAM532yS6KU5o8FX++spXIHOBwNQPVULEXp14myZh8zjySLIKbeIzY0
        DpM2U632Kt1ba+KO5V+60TYaQ7XPamG7qQ==
X-Google-Smtp-Source: ABdhPJzQ0IxH896x+HaUmEqQK8k2Z6LLEQDKT3TS9n2JQKiDBikdJ/MGeHYX/CL+K5k1BbjL0PnOAg==
X-Received: by 2002:a9d:6a05:: with SMTP id g5mr63085otn.354.1621984373083;
        Tue, 25 May 2021 16:12:53 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:f91b:bc2f:728e:54e7? (2603-8081-140c-1a00-f91b-bc2f-728e-54e7.res6.spectrum.com. [2603:8081:140c:1a00:f91b:bc2f:728e:54e7])
        by smtp.gmail.com with ESMTPSA id n11sm3478523oom.1.2021.05.25.16.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 16:12:52 -0700 (PDT)
Subject: Re: [PATCH for-next] RDMA/rxe: Fix memory ordering problem for resize
 cq
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyj2020@gmail.com, linux-rdma@vger.kernel.org
References: <20210525201111.623970-1-rpearsonhpe@gmail.com>
 <20210525230303.GK1002214@nvidia.com>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <6d7531df-3b09-790c-ac22-cbf9faae5701@gmail.com>
Date:   Tue, 25 May 2021 18:12:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525230303.GK1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/25/2021 6:03 PM, Jason Gunthorpe wrote:
> On Tue, May 25, 2021 at 03:11:12PM -0500, Bob Pearson wrote:
>> The rxe driver has recently begun exhibiting failures in the python
>> tests that are due to stale values read from the completion queue
>> producer or consumer indices. Unlike the other loads of these shared
>> indices those in queue_count() were not protected by smp_load_acquire().
>>
>> This patch replaces loads by smp_load_acquire() in queue_count().
>> The observed errors no longer occur.
>>
>> Reported-by: Zhu Yanjun <zyj2020@gmail.com>
>> Fixes: d21a1240f516 ("RDMA/rxe: Use acquire/release for memory ordering")
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>   drivers/infiniband/sw/rxe/rxe_queue.h | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
>> index 2902ca7b288c..5cb142282fa6 100644
>> +++ b/drivers/infiniband/sw/rxe/rxe_queue.h
>> @@ -161,8 +161,22 @@ static inline unsigned int index_from_addr(const struct rxe_queue *q,
>>   
>>   static inline unsigned int queue_count(const struct rxe_queue *q)
>>   {
>> -	return (q->buf->producer_index - q->buf->consumer_index)
>> -		& q->index_mask;
>> +	u32 prod;
>> +	u32 cons;
>> +	u32 count;
>> +
>> +	/* make sure all changes to queue complete before
>> +	 * changing producer index
>> +	 */
>> +	prod = smp_load_acquire(&q->buf->producer_index);
>> +
>> +	/* make sure all changes to queue complete before
>> +	 * changing consumer index
>> +	 */
>> +	cons = smp_load_acquire(&q->buf->consumer_index);
>> +	count = (prod - cons) % q->index_mask;
>> +
>> +	return count;
>>   }
> It doesn't quite make sense to load both?
>
> Only the one written by userspace should require a load_acquire, the
> one written by the kernel should already be locked somehow with a
> kernel lock or there is a different problem
>
> But yes, this does look like a bug to me
>
> Jason

The rxe_queue.h API is used by completion and work queues so both 
directions occur. The question is the trade off between the logic to 
avoid the load_acquire vs the branching to get around. Same point could 
be applied to queue_empty() which already had both load_acquire() calls. 
Is it worth creating several versions of APIs with different choices made?

Bob

