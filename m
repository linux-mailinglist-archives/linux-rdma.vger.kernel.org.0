Return-Path: <linux-rdma+bounces-2393-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 201198C1F50
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 09:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A562A281B75
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 07:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748F415F30A;
	Fri, 10 May 2024 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7a9D5n3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC514A084
	for <linux-rdma@vger.kernel.org>; Fri, 10 May 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715327670; cv=none; b=tWstY9fU1WuRA6ACym8cuUNK6AKBVX6S/HesWDoCrn65D6gyY4ga2O4IQeDPW13yw4XDU+E5UaxxOacFAzMVvQOKKwXuVWuXTOk+pDUJslkULQZp5CgMgDydVM6wHtxhEw/HHlC3esP7x6HTo4HhRrA42cvcc0/bRE5aJ8FjiOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715327670; c=relaxed/simple;
	bh=xPN36Ro0Y3FxkOW2cmytKMS5KsQx8KJCNNPw+5HliTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FE97L7XclHLsBEcLj4C0gwqr7ImkwxDl6uGYMhlcvbCB46Ah906oa1odFxRmHmp+llUW/mkaTR/i817XST0iZnE6AWIVosqR7XtqHGL3RrbSkW1nkBGSlVyx5KwieFAddw8ikQWPD+3Z9bd+z7UeEtwcLI/wOZlezmX/wcrCArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7a9D5n3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715327667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nweOFAsLnbVW/1iPfd3jnuSWx2J2WyWpGQwKCD45C1M=;
	b=S7a9D5n3P1bITxtyALNhunmHBKl4va4R2v7Z8IMdO6tHuj3EoZhBuMFwLqIY467sjqLOHG
	3J8Xr/K9Z6vecdE6j1ec/dWVK0DCUf5sjUJfzX+Mccxt7t+JBinDqGI+XplqSrCWk4g0Gp
	+bpUNZUjI8Hrh9NVwM6KODnJxt2sqYo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-tpMD1emCPLult8Rb5bfzXg-1; Fri, 10 May 2024 03:54:23 -0400
X-MC-Unique: tpMD1emCPLult8Rb5bfzXg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41fffe9849bso560105e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 10 May 2024 00:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715327662; x=1715932462;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nweOFAsLnbVW/1iPfd3jnuSWx2J2WyWpGQwKCD45C1M=;
        b=XJyx2Izwq+W3KwsOy0Lraj64nVut3N1Ms//TF0o2BJPauM/aaL95UPSGmAhscVyXc8
         d5jBBGVQ3xRzhCgx983SHHcBmRBpxmGylcQqyI+Bod72pST77TWoA/H3LYASdrPWBgOU
         OAgfdmXcnuELwhtq1kJnU18Ir4OJy5NfyYGNy10TZhvG68iehicHkLiBcutWVFVB68He
         n/+whyV6WcGqfCvRyjM0w0iZXoUoZJdkl4eOA4R6izV2BI6m8knFfYheElyZ6TE3bUMW
         7m60oPgS0l6gQgnjBVCe2l6iLZNGjBQCG8UbEQxp9TgYKSnjUlRf9Uzwk2jEXystokxW
         Abtw==
X-Forwarded-Encrypted: i=1; AJvYcCWHrzladsEPkIvBJfMsFxHoA3iKqD5zNka1h9bsIdjeGwy2K5le/6MhFkM2hCKemVC4ZuFs9tFYpy6CT/Pr25zZAuXQteZfEaIRlQ==
X-Gm-Message-State: AOJu0YxOtqalEw1Qg86ETOd01lXUxnH2w1vZm+i/AMnq0xLu0bNVTcmI
	kVhvL047ktoZKxxPPJ3iAmzNFALS9xXru1zeHZMWYFTFHkRxSCE46gPqkWMI/O6gTFxXEUxWtZ1
	f/vbsXCMTbtzppaJxKOZYQsr88xJ97KMsflcFe2IpEiI2MctDRTDCnkTsxmY=
X-Received: by 2002:a05:600c:3849:b0:41b:a4ce:aa45 with SMTP id 5b1f17b1804b1-41feab44abamr13325355e9.23.1715327662305;
        Fri, 10 May 2024 00:54:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbyuBvzoW4eG1Y6EsvTLk3J5a4EU6l3dbtBHREyxiweCjslAlTyqIGXl+UlvEEZTsVM7OChw==
X-Received: by 2002:a05:600c:3849:b0:41b:a4ce:aa45 with SMTP id 5b1f17b1804b1-41feab44abamr13325155e9.23.1715327661813;
        Fri, 10 May 2024 00:54:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:2b00:9c9f:9357:3f4c:5358? (p200300cbc7102b009c9f93573f4c5358.dip0.t-ipconnect.de. [2003:cb:c710:2b00:9c9f:9357:3f4c:5358])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8969fbsm3791380f8f.37.2024.05.10.00.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 00:54:21 -0700 (PDT)
Message-ID: <f7511bd9-edc7-4ad7-ba1f-2920d7d94517@redhat.com>
Date: Fri, 10 May 2024 09:54:20 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] RDMA/umem: pin_user_pages*() can temporarily fail due to
 migration glitches
To: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Artemy Kovalyov <artemyko@nvidia.com>,
 Michael Guralnik <michaelgur@nvidia.com>, Pak Markthub
 <pmarkthub@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>
References: <20240501003117.257735-1-jhubbard@nvidia.com>
 <ZjHO04Rb75TIlmkA@infradead.org> <20240501121032.GA941030@nvidia.com>
 <87r0el3tfi.fsf@nvdebian.thelocal>
 <92289167-5655-4c51-8dfc-df7ae53fdb7b@redhat.com>
 <a2032a79-744d-4c00-a286-7d6fed3a1bdb@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a2032a79-744d-4c00-a286-7d6fed3a1bdb@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.05.24 20:10, John Hubbard wrote:
> On 5/1/24 11:56 PM, David Hildenbrand wrote:
>> On 02.05.24 03:05, Alistair Popple wrote:
>>> Jason Gunthorpe <jgg@nvidia.com> writes:
> ...
>>>>> This doesn't make sense.  IFF a blind retry is all that is needed it
>>>>> should be done in the core functionality.  I fear it's not that easy,
>>>>> though.
>>>>
>>>> +1
>>>>
>>>> This migration retry weirdness is a GUP issue, it needs to be solved
>>>> in the mm not exposed to every pin_user_pages caller.
>>>>
>>>> If it turns out ZONE_MOVEABLE pages can't actually be reliably moved
>>>> then it is pretty broken..
>>>
>>> I wonder if we should remove the arbitrary retry limit in
>>> migrate_pages() entirely for ZONE_MOVEABLE pages and just loop until
>>> they migrate? By definition there should only be transient references on
>>> these pages so why do we need to limit the number of retries in the
>>> first place?
>>
>> There are some weird things that still needs fixing: vmsplice() is the
>> example that doesn't use FOLL_LONGTERM.
>>
> 
> Hi David!
> 

Sorry for the late reply!

> Do you have any other call sites in mind? It sounds like one way forward
> is to fix each call site...

We also have udmabuf, that is currently getting fixed [1] similarly to 
how we handle GUP. Could you and/or Jason also have a look at the 
GUP-related bits? I acked it but the patch set does not seem to make 
progress.

https://lkml.kernel.org/r/20240411070157.3318425-1-vivek.kasireddy@intel.com

The sad story is:

(a) vmsplice() is harder to fix (identify all put_page() and replace 
them by unpin_user_page()), but will get fixed at some point.

(b) even !longterm DMA can take double-digit seconds

(c) other wrong code is likely to exist or to appear again and it's
     rather hard to identify+prevent reliably

IMHO we should expect migration to take a longer time and maybe never 
happening in some cases.

Memory offlining (e.g., echo "offline" > 
sys/devices/system/memory/memory0/state) currently tries forever to 
migrate pages and can be killed if started from user space using a fatal 
signal. If memory offlining happens from kernel context (unplugging 
DIMM, ACPI code triggers offlining), we'd much rather want to fail at 
some point instead of looping forever, but it hasn't really popped up as 
a problem so far.

virtio-mem uses alloc_contig_range() for best-effort allocation and will 
skip such temporarily unmovable ranges to try again later. Here, we 
really don't want to loop forever in migration code but rather fail 
earlier and try unplug of another memory block.

So as long as page pinning is triggered from user context where the user 
can simply abort the process (e.g., kill the process), sleep+retry on 
ZONE_MOVABLE + MIGRATE_CMA sounds reasonable.

> 
> This is an unhappy story right now: the pin_user_pages*() APIs are
> significantly worse than before the "migrate pages away automatically"
> upgrade, from a user point of view. Because now, the APIs fail
> intermittently for callers who follow the rules--because
> pin_user_pages() is not fully working yet, basically.
> 
> Other ideas, large or small, about how to approach a fix?

What Jason says makes sense to me: sleep+retry. My only concern is when 
pin_user_pages_*() is called from non-killable context where failing at 
some point might be more reasonable. But maybe that use case doesn't 
really exist?

-- 
Cheers,

David / dhildenb


