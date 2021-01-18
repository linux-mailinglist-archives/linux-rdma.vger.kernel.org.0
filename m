Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1C72FABCF
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 21:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387918AbhARUs1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 15:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390629AbhARUrZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 15:47:25 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C7FC0613C1;
        Mon, 18 Jan 2021 12:46:45 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ox12so1207764ejb.2;
        Mon, 18 Jan 2021 12:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ygrJIf/V9fcQY2vP6K2WakhuD9/WSpQGkCDpBWvrw+w=;
        b=GfNJd8Bome7/jm5mGMRJq/2PGTWvhg5ZCKz66AxPNV2hoSI9nhWQm5G+Q13ESwlBTb
         Q+fotg9Nu3aoV/y5K56QiFVnmB/x97U6700/bpPqaMsj4xWMFLii82VaQNIx4qUn6uv6
         lmrgiPS3YEUb+oXg39q5lAS3mAO8lD5BTK4Yy99Y6ZLFMaaPsT90RgSNXBn8fQiLemUK
         Na+YIBF1+phvg6ZRgTSRjWrgnmQuFyhKzVI+t9WqmjWubB3VyN+itPnVH8U8LzHHoLJy
         DwTuRN1vk9jmT78vGCk/aCzFq0cIPzE3JXUcyc1pCR1U2PZ9zY71ubAfM40Ec057UXH9
         fPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ygrJIf/V9fcQY2vP6K2WakhuD9/WSpQGkCDpBWvrw+w=;
        b=lFzAXeUmnq1qMYWoQVvSDpYB6SoCO2izUZKgRpf3iBB5N6XVIhhFM0zt+5jltNs1qD
         eZUNKLQ7Zlb16uNdE6yifRMMDXZVPqklWSqMdHWwYuHq9zxvuDVwT3sy/2NHdEe9Szh+
         43tfWqzJNb2E2UNZAmiTySUt+nX7xxNymbGxOYyXfKEKf0nW5+2AuH4FnfYzqxs53+g+
         Jqp/ESoxksyVCMzNpjoQF2fEShbSVRRXJyhEV8ZpuTXGA/qBdv1JX2HFDEYmdg0A9pHx
         3kYYDUr6KAJmDc7tGuV0ZTht0jHuLjE66vU2Pikv4PZXLl+E7wZTJgmTvNtY5XHipt3C
         Zp3Q==
X-Gm-Message-State: AOAM5324PBWy7JlmHlD/CYJ61Sekr8KmVlGYOAWE5vwv3ZA+txBuJeCf
        U3iDgXGG56zWIRSpuwvIanLL5TSg6Yc=
X-Google-Smtp-Source: ABdhPJxtZe6bht9xG+8tf8UzqMKs8TtIiE9m2K+EFRJ/KFv/dySA1PlH1NY1AaBwGzX8kw6hUWSDxg==
X-Received: by 2002:a17:906:2785:: with SMTP id j5mr883728ejc.527.1611002804082;
        Mon, 18 Jan 2021 12:46:44 -0800 (PST)
Received: from [192.168.178.40] (ipbcc06d06.dynamic.kabel-deutschland.de. [188.192.109.6])
        by smtp.gmail.com with ESMTPSA id v9sm1066417ejd.92.2021.01.18.12.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 12:46:43 -0800 (PST)
Subject: Re: [PATCH v6 1/4] sgl_alloc_order: remove 4 GiB limit, sgl_free()
 warning
To:     dgilbert@interlog.com, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, ddiss@suse.de, bvanassche@acm.org
References: <20210118163006.61659-1-dgilbert@interlog.com>
 <20210118163006.61659-2-dgilbert@interlog.com>
 <20210118182854.GJ4605@ziepe.ca>
 <59707b66-0b6c-b397-82fe-5ad6a6f99ba1@interlog.com>
From:   Bodo Stroesser <bostroesser@gmail.com>
Message-ID: <abee94bf-a6ec-7659-21d2-4253582a1730@gmail.com>
Date:   Mon, 18 Jan 2021 21:46:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <59707b66-0b6c-b397-82fe-5ad6a6f99ba1@interlog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 18.01.21 21:08, Douglas Gilbert wrote:
> On 2021-01-18 1:28 p.m., Jason Gunthorpe wrote:
>> On Mon, Jan 18, 2021 at 11:30:03AM -0500, Douglas Gilbert wrote:
>>
>>> After several flawed attempts to detect overflow, take the fastest
>>> route by stating as a pre-condition that the 'order' function argument
>>> cannot exceed 16 (2^16 * 4k = 256 MiB).
>>
>> That doesn't help, the point of the overflow check is similar to
>> overflow checks in kcalloc: to prevent the routine from allocating
>> less memory than the caller might assume.
>>
>> For instance ipr_store_update_fw() uses request_firmware() (which is
>> controlled by userspace) to drive the length argument to
>> sgl_alloc_order(). If userpace gives too large a value this will
>> corrupt kernel memory.
>>
>> So this math:
>>
>>        nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + 
>> order);
> 
> But that check itself overflows if order is too large (e.g. 65).
> A pre-condition says that the caller must know or check a value
> is sane, and if the user space can have a hand in the value passed
> the caller _must_ check pre-conditions IMO. A pre-condition also
> implies that the function's implementation will not have code to
> check the pre-condition.
> 
> My "log of both sides" proposal at least got around the overflowing
> left shift problem. And one reviewer, Bodo Stroesser, liked it.

I added my Reviewed-by after you added a working check of nent overflow.
I did not oppose to the usage of ilog() there. But now I think Jason is
right that indeed ilog usage is a bit 'indirect'.

Anyway I still think, there should be a check for nent overflow.

> 
>> Needs to be checked, add a precondition to order does not help. I
>> already proposed a straightforward algorithm you can use.
> 
> It does help, it stops your proposed check from being flawed :-)
> 
> Giving a false sense of security seems more dangerous than a
> pre-condition statement IMO. Bart's original overflow check (in
> the mainline) limits length to 4GB (due to wrapping inside a 32
> bit unsigned).
> 
> Also note there is another pre-condition statement in that function's
> definition, namely that length cannot be 0.
> 
> So perhaps you, Bart Van Assche and Bodo Stroesser, should compare
> notes and come up with a solution that you are _all_ happy with.
> The pre-condition works for me and is the fastest. The 'length'
> argument might be large, say > 1 GB [I use 1 GB in testing but
> did try 4GB and found the bug I'm trying to fix] but having
> individual elements greater than say 32 MB each does not
> seem very practical (and fails on the systems that I test with).
> In my testing the largest element size is 4 MB.
> 
> 
> Doug Gilbert
> 
