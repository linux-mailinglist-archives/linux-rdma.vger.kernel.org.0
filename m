Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB242FBF62
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 19:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbhASSp4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 13:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbhASSkK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jan 2021 13:40:10 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF9FC061573;
        Tue, 19 Jan 2021 10:39:26 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id rv9so11181901ejb.13;
        Tue, 19 Jan 2021 10:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oPpd0xzESQegPnVY2N4DoOcYulfBZy0CSElYWiJn91o=;
        b=aft9YB4i5E5pliXL4ZQE13Dzs9PfvtIFzNDto56ylX9Pf/tk9+leQZIREncSo7q10q
         bTuvk7EYdqNzxfoiew+Wxq8s3fu8uXZcMy8p4tuBWiZgNq570A+FffbuHpa15UUbzwl4
         OzxO0DK83jB0OnP4dAhNqtUpRrj/mZzpB76y1GlqGsCRmUiyxiR9iwCsHkzu5LRxoxM+
         2JVfxTxrQcpxhG2wKQCmJEnnB8y2Btohsb47FTSy6YpP3wUvj567xdDlBM6VJjCykyZy
         7pSDdkpu0/OgL90WNf1SdO7rZfTKtm+xEPMzYlhG8UYX0pdPZilFiFvSOUalaBsVb+p0
         Y35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oPpd0xzESQegPnVY2N4DoOcYulfBZy0CSElYWiJn91o=;
        b=BCOAge8pzDuYWkR2JI6PJ+HLJq4m2RfThhcP/hgBj5NUhhnkZRo8JyJZMDPvT7/IzO
         6ZbQEQ/lWUUjIyoQUunNeixNG4QkH9GlVNqi7TIEVOAJ45tnLYmphgCk/5Gesdq1a7El
         kRWT9fC1AuHgDMR9wVpYYeQMWfP9pSm6u2xuZpnnuayQJtMxIC5A9SS3Kufg/Te+BUHo
         /uRNlb1ca8AaLU8/VEAGmWkjD6dCoMIAikpA8d1TmciXZi/Gh2QEmTwcSL6vstkPEO28
         +ts9o5ZqeuTJTgnWTxvNupAGzKtXBWkwo/d9hQTlm1mvLUyjik3rCodeLmhsydWv9qNT
         3oVw==
X-Gm-Message-State: AOAM531MmYewxFtdkFD5dyVjUpRUzWIkxFQErRZuBhQPR4SkiQRLVBQD
        KsABiYwkzjDUrTumiZV9oTU=
X-Google-Smtp-Source: ABdhPJyDaMyA5JaFGa1IcVtwtX3v2ntzPQieWmEe7SnBOyNPDIdZlsJaDkgqSmXkM6E5rzL2b+AIbA==
X-Received: by 2002:a17:906:11d6:: with SMTP id o22mr3938523eja.106.1611081565179;
        Tue, 19 Jan 2021 10:39:25 -0800 (PST)
Received: from [192.168.178.40] (ipbcc06d06.dynamic.kabel-deutschland.de. [188.192.109.6])
        by smtp.gmail.com with ESMTPSA id s22sm10850372ejd.106.2021.01.19.10.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 10:39:24 -0800 (PST)
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
 <6faed1e2-13bc-68ba-7726-91924cf21b66@gmail.com>
 <20210119180327.GX4605@ziepe.ca>
 <7ba5bfdf-6bc2-eddb-4c26-133c1bc08a33@gmail.com>
 <20210119181714.GA909645@ziepe.ca>
From:   Bodo Stroesser <bostroesser@gmail.com>
Message-ID: <05a7b524-aee2-fd1d-e342-b85f355adb82@gmail.com>
Date:   Tue, 19 Jan 2021 19:39:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119181714.GA909645@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 19.01.21 19:17, Jason Gunthorpe wrote:
> On Tue, Jan 19, 2021 at 07:08:32PM +0100, Bodo Stroesser wrote:
>> On 19.01.21 19:03, Jason Gunthorpe wrote:
>>> On Tue, Jan 19, 2021 at 06:24:49PM +0100, Bodo Stroesser wrote:
>>>>
>>>> I had a second look into math.h, but I don't find any reason why round_up
>>>> could overflow. Can you give a hint please?
>>>
>>> #define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
>>>                                                       ^^^^^
>>>
>>> That +1 can overflow
>>
>> But that would be a unsigned long long overflow. I considered this to
>> not be relevant.
> 
> Why not? It still makes nents 0 and still causes a bad bug
> 

Generally spoken, you of course are right.

OTOH, if someone tries to allocate such big sgls, then we will run into
trouble during memory allocation even without overrun.

Anyway, if we first calculate nent and nalloc and then check with

	if ((unsigned long long)nalloc << (PAGE_SHIFT + order) < length)
		return NULL;

I think we would have checked against all kind of overrun in a single
step. Or am I missing something?

Bodo


