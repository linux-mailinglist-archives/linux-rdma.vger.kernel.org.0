Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115D92FAC93
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 22:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437655AbhARVYi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 16:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438052AbhARVXq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 16:23:46 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D54C061573;
        Mon, 18 Jan 2021 13:22:59 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ox12so1321569ejb.2;
        Mon, 18 Jan 2021 13:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Giv0GJHiR0U7EHzqjMGjtNcbBY4s91RtnAoeLxvrwL4=;
        b=fqJW2k5L9DSKd2FkqB1VRaQcaE9/yIOY+GHwrsIGzeGPSqi6pAez/9o8N24ga5378M
         tX8s/np4npMdreeXn0+jUSPr3/nyhMHX7JcQYCx9EgKStEU6extVGTmhBtvDv1/OpGCy
         z3tZkkDB7HMXR8lIR9gjUPxO3LN9AdxP/gdl4d0Oy/MUmCkLYLBNq7ueX/uSLA95ryxG
         G+7HTEEJfHJ1QfLjThUwYefr5GYQDkw/cY95YElyTa/rDUJbxVkEsRSrEgr+b3PBfB2n
         VeQwm/n3XYoUzszQr2hD3S42MjfoXkULKPWOt5PC0tc1zdlBCjoGYrZ4BOcQ7jAUyQT2
         KeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Giv0GJHiR0U7EHzqjMGjtNcbBY4s91RtnAoeLxvrwL4=;
        b=Z3qy+aNpC9kjdEbRLoPQCrHaBQaFCe4Gp8VYU4xeFm0H34afuDRFMTQvdY5vzWvpXu
         txIftvA2kY7ANTZJwpu0s6GR6LwCIaNsbTg4vrD+94BX7mO9HlPIcVTdjrd4IQxwUqeM
         jiS5ZycMNAuFTY4g4fl8UvhOyc3rLoH1RN6B6nVk4L0zsMMrNYkFVR7xUBR8cL3jybJZ
         as6d/dL7b1zNjzBML23MgYGny67IamE65l+W38I4Ojy+oEn0tGiQbICxiEgSfRToucT0
         zVmKbD97VfGIceMHMYkz8r2P+2fHw5gVI71Q2Gppup6Iof3g8RrFnfKZmHS3SULc2hne
         27aw==
X-Gm-Message-State: AOAM530t2J8h6065YBtU7aWEzJNksI8aOUBPZLXntz4nw+gD6nomTFKX
        67NDSrJuU3Jm/y7P3FHpaWs=
X-Google-Smtp-Source: ABdhPJzUtiGI8cqGbVVsOEIghLaawZpYS1WoHneVMPFuQMBKqIao3ek/l4qpxvvLjkU1v34FnSi3fg==
X-Received: by 2002:a17:906:7798:: with SMTP id s24mr1012838ejm.19.1611004977974;
        Mon, 18 Jan 2021 13:22:57 -0800 (PST)
Received: from [192.168.178.40] (ipbcc06d06.dynamic.kabel-deutschland.de. [188.192.109.6])
        by smtp.gmail.com with ESMTPSA id h16sm11583847edw.34.2021.01.18.13.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 13:22:57 -0800 (PST)
Subject: Re: [PATCH v6 1/4] sgl_alloc_order: remove 4 GiB limit, sgl_free()
 warning
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, ddiss@suse.de, bvanassche@acm.org
References: <20210118163006.61659-1-dgilbert@interlog.com>
 <20210118163006.61659-2-dgilbert@interlog.com>
 <20210118182854.GJ4605@ziepe.ca>
 <59707b66-0b6c-b397-82fe-5ad6a6f99ba1@interlog.com>
 <20210118202431.GO4605@ziepe.ca>
From:   Bodo Stroesser <bostroesser@gmail.com>
Message-ID: <7f443666-b210-6f99-7b50-6c26d87fa7ca@gmail.com>
Date:   Mon, 18 Jan 2021 22:22:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210118202431.GO4605@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 18.01.21 21:24, Jason Gunthorpe wrote:
> On Mon, Jan 18, 2021 at 03:08:51PM -0500, Douglas Gilbert wrote:
>> On 2021-01-18 1:28 p.m., Jason Gunthorpe wrote:
>>> On Mon, Jan 18, 2021 at 11:30:03AM -0500, Douglas Gilbert wrote:
>>>
>>>> After several flawed attempts to detect overflow, take the fastest
>>>> route by stating as a pre-condition that the 'order' function argument
>>>> cannot exceed 16 (2^16 * 4k = 256 MiB).
>>>
>>> That doesn't help, the point of the overflow check is similar to
>>> overflow checks in kcalloc: to prevent the routine from allocating
>>> less memory than the caller might assume.
>>>
>>> For instance ipr_store_update_fw() uses request_firmware() (which is
>>> controlled by userspace) to drive the length argument to
>>> sgl_alloc_order(). If userpace gives too large a value this will
>>> corrupt kernel memory.
>>>
>>> So this math:
>>>
>>>     	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);
>>
>> But that check itself overflows if order is too large (e.g. 65).
> 
> I don't reall care about order. It is always controlled by the kernel
> and it is fine to just require it be low enough to not
> overflow. length is the data under userspace control so math on it
> must be checked for overflow.
> 
>> Also note there is another pre-condition statement in that function's
>> definition, namely that length cannot be 0.
> 
> I don't see callers checking for that either, if it is true length 0
> can't be allowed it should be blocked in the function
> 
> Jason
> 

A already said, I also think there should be a check for length or
rather nent overflow.

I like the easy to understand check in your proposed code:

	if (length >> (PAGE_SHIFT + order) >= UINT_MAX)
		return NULL;


But I don't understand, why you open-coded the nent calculation:

	nent = length >> (PAGE_SHIFT + order);
	if (length & ((1ULL << (PAGE_SHIFT + order)) - 1))
		nent++;

Wouldn't it be better to keep the original line instead:

	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);

Or maybe even better:

	nent = DIV_ROUND_UP(length, PAGE_SIZE << order);


I think, combining the above lines results in short and easily readable code:


	u32 elem_len;

	if (length >> (PAGE_SHIFT + order) >= UINT_MAX)
		return NULL;
	nent = DIV_ROUND_UP(length, PAGE_SIZE << order);

	if (chainable) {
		if (check_add_overflow(nent, 1, &nalloc))
			return NULL;
	}
	else
		nalloc = nent;


Thank you,
Bodo


	
