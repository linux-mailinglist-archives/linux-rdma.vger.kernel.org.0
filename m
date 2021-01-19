Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8642FBD85
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 18:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbhASR0F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 12:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390855AbhASRZc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jan 2021 12:25:32 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE67BC061573;
        Tue, 19 Jan 2021 09:24:51 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id g3so10244155ejb.6;
        Tue, 19 Jan 2021 09:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qy8mcYDslRubqQMPczlIvoAYWYvQDOq96eQu0PafMfE=;
        b=eYfwUxhXfHaIuxuNwRrS8kQvPBRik+2A3J6NIRPhdjdSewQ2FD4YP6cz0CzJ/dRyni
         3Nl8SNvf0ZfUSIH8M8bHbgPvVZvfOZh0F1olxQfRGqmUlZJvT4CTvQ1IDetZNfnsywLS
         YTJObCiYFz8qs4JmrJZDJYx5rTXYoq16cu9z8PGpv1+jUY7yoMBmJNHhjOqw0/673aU1
         yQvFUpoKeMzBAzJWh6m+uMLYfNoqwWB9COa2EkQvGd1kF5yH+8MjCmiKVDLrMSlI80B3
         Tp0X5UjNbZ7UilcKIoJ4Si85g+Hc0vOra2v3AuTTGdKTsvo2eg2Qd2ujYfLeZdBrFosQ
         BYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qy8mcYDslRubqQMPczlIvoAYWYvQDOq96eQu0PafMfE=;
        b=Za0i2LrP7pnw2SHBT7m8MKwhmTaRnIwXstgAzRFjlDT/NB8+Coat7Yymuym6CI2NPS
         l9nzXgq0IVtetQQ9InLpAK9S2viTxi5aGgK2NY4+z0Sgbcuf2yBEcGlEDqk+4NwtAaM/
         +dofHkd9tlVqy06APZJ4oOxzElrmsMThYSGa7zySIa188Zbpe0fSSxbJxu6+Dqxp1HS4
         2eUWyKVAl8ZUG3lQkOWjZ61CnfP+Ea7ZvgGohu7lOzUCVodog+lbfjoccei80TaaMRdo
         qHGFQJIRLOFBldCxuI6Z5RVm39Ht/W/FQ/0++6rsdMr6E2/uJTxZ8Qy+K3jo5WQTqSuX
         LWTw==
X-Gm-Message-State: AOAM533bnQrhnWaaCcrtUPiUTIBd7C2ckmn/A24uCNg+4n0riS8qjZyf
        Q9DtaAKJUsl/1xJoSz4DZTA=
X-Google-Smtp-Source: ABdhPJwIemtsVHlkxlk8JB7ypAMSs0GcJ4fX03fAf9hgs661+3MwI0c+/ccJWxE9OP0oPSEYjCWTVQ==
X-Received: by 2002:a17:906:dfce:: with SMTP id jt14mr2794501ejc.435.1611077090638;
        Tue, 19 Jan 2021 09:24:50 -0800 (PST)
Received: from [192.168.178.40] (ipbcc06d06.dynamic.kabel-deutschland.de. [188.192.109.6])
        by smtp.gmail.com with ESMTPSA id s19sm13021962edx.7.2021.01.19.09.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 09:24:50 -0800 (PST)
Subject: Re: [PATCH v6 1/4] sgl_alloc_order: remove 4 GiB limit, sgl_free()
 warning
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, ddiss@suse.de, bvanassche@acm.org
References: <20210118163006.61659-1-dgilbert@interlog.com>
 <20210118163006.61659-2-dgilbert@interlog.com>
 <20210118182854.GJ4605@ziepe.ca>
 <59707b66-0b6c-b397-82fe-5ad6a6f99ba1@interlog.com>
 <20210118202431.GO4605@ziepe.ca>
 <7f443666-b210-6f99-7b50-6c26d87fa7ca@gmail.com>
 <20210118234818.GP4605@ziepe.ca>
From:   Bodo Stroesser <bostroesser@gmail.com>
Message-ID: <6faed1e2-13bc-68ba-7726-91924cf21b66@gmail.com>
Date:   Tue, 19 Jan 2021 18:24:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210118234818.GP4605@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 19.01.21 00:48, Jason Gunthorpe wrote:
> On Mon, Jan 18, 2021 at 10:22:56PM +0100, Bodo Stroesser wrote:
>> On 18.01.21 21:24, Jason Gunthorpe wrote:
>>> On Mon, Jan 18, 2021 at 03:08:51PM -0500, Douglas Gilbert wrote:
>>>> On 2021-01-18 1:28 p.m., Jason Gunthorpe wrote:
>>>>> On Mon, Jan 18, 2021 at 11:30:03AM -0500, Douglas Gilbert wrote:
>>>>>
>>>>>> After several flawed attempts to detect overflow, take the fastest
>>>>>> route by stating as a pre-condition that the 'order' function argument
>>>>>> cannot exceed 16 (2^16 * 4k = 256 MiB).
>>>>>
>>>>> That doesn't help, the point of the overflow check is similar to
>>>>> overflow checks in kcalloc: to prevent the routine from allocating
>>>>> less memory than the caller might assume.
>>>>>
>>>>> For instance ipr_store_update_fw() uses request_firmware() (which is
>>>>> controlled by userspace) to drive the length argument to
>>>>> sgl_alloc_order(). If userpace gives too large a value this will
>>>>> corrupt kernel memory.
>>>>>
>>>>> So this math:
>>>>>
>>>>>      	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);
>>>>
>>>> But that check itself overflows if order is too large (e.g. 65).
>>>
>>> I don't reall care about order. It is always controlled by the kernel
>>> and it is fine to just require it be low enough to not
>>> overflow. length is the data under userspace control so math on it
>>> must be checked for overflow.
>>>
>>>> Also note there is another pre-condition statement in that function's
>>>> definition, namely that length cannot be 0.
>>>
>>> I don't see callers checking for that either, if it is true length 0
>>> can't be allowed it should be blocked in the function
>>>
>>> Jason
>>>
>>
>> A already said, I also think there should be a check for length or
>> rather nent overflow.
>>
>> I like the easy to understand check in your proposed code:
>>
>> 	if (length >> (PAGE_SHIFT + order) >= UINT_MAX)
>> 		return NULL;
>>
>>
>> But I don't understand, why you open-coded the nent calculation:
>>
>> 	nent = length >> (PAGE_SHIFT + order);
>> 	if (length & ((1ULL << (PAGE_SHIFT + order)) - 1))
>> 		nent++;
> 
> It is necessary to properly check for overflow, because the easy to
> understand check doesn't prove that round_up will work, only that >>
> results in something that fits in an int and that +1 won't overflow
> the int.
> 
>> Wouldn't it be better to keep the original line instead:
>>
>> 	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);
> 
> This can overflow inside the round_up

I had a second look into math.h, but I don't find any reason why 
round_up could overflow. Can you give a hint please?

Regarding the overflow checks: would it be a good idea to not check
length >> (PAGE_SHIFT + order) in the beginning, but check nalloc
immediately before the kmalloc_array() as the only overrun check:

	if ((unsigned long long)nalloc << (PAGE_SHIFT + order) < length)
		return NULL;

-Bodo
