Return-Path: <linux-rdma+bounces-11403-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9480ADD58F
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 18:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA0C16346D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 16:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9972F5462;
	Tue, 17 Jun 2025 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ukenucw7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301512F365D
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176585; cv=none; b=u9V05d+mN/y5lLNZbpurBChjfVvJOpuzDJFltu8MfxkCTUdDo4yiR6L5lPqG1jbAcO28UVMFko7VYVHMSoFX7dvdfHDJ28bQlkJBu2nKV5fUACMSmcQEsqd5MAGQGCamxxyYPM3bqPwtVLzB1p2XdAN5f4f2ulPeu1fAakHFFKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176585; c=relaxed/simple;
	bh=e8cEPTs82N3ebqQiWLlW0aqmQmVoF7FWyUqDl32gkhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNsrcsosPGHIWEAz08hAZFGjQW1gHqRh14iCRCDDy5aDW5LmP7ekqLcdqhWawOIpCAn1zWpwPwnFbhwqXoRk0FIaOI31kyQ5IDHPWUcKVM+9HIZ6xqqvE6YQXDzw9aonSLDZ1k7nmNji6slKEyDaEnRalROBYJ7JvP4sgNs/3QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ukenucw7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750176583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RY437T66zUTU85w+ZMnXlHoih95/8VsrgB9XXy3i00M=;
	b=Ukenucw7fkbsZCA/fkEorZ5xbPvoKfolu6FkH6I5ttD5FRrE8I2jihIcY8zg60GmYLWH4F
	9WBVkyGST4UnpEzEfratAmcq5+BHxtHhKRLefQDaL/5Jnbms45Kz2o+uZB9AgeKyzd/NiF
	ljwSlDbvgWpzj+ytRr6yrKszY96d4JE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-QOf4jUQtNpK9XjRJvCHJxQ-1; Tue, 17 Jun 2025 12:09:41 -0400
X-MC-Unique: QOf4jUQtNpK9XjRJvCHJxQ-1
X-Mimecast-MFC-AGG-ID: QOf4jUQtNpK9XjRJvCHJxQ_1750176581
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ad89a3bcc62so441320266b.0
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 09:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750176580; x=1750781380;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RY437T66zUTU85w+ZMnXlHoih95/8VsrgB9XXy3i00M=;
        b=K8X5ncytujZY5n99/dOBfh8JNZCeJgnzTW4r2Kz10csYrK+KE3SWQV3kdWRs5IXpOv
         MAPamd0yv1V+mQxhx8QOziEAQ32YAI9jLOxgQzWGsJllFivTn35/W8qTgQAuqZhi8HEi
         yhGihuX2oQZREkYpyBMgNG2vsbKll8qwbDaVb1FbdHj6CaEpjW5YsN2fcYgYewjxFc6Z
         KPVV3GqaiJvtspQ3T+cYrGKHP8jPS3VrC3qH5Re7XCjKeiuUhXRpB+0+k7K1Kx1MTzBF
         QcmKmqZmihcmTShmhHxnsq2/nOwR7p+2Du9OAbPrn7T/nDcQsN7IaAHR0dtXVNGCwReb
         QFAw==
X-Forwarded-Encrypted: i=1; AJvYcCWycT+BmJA9Zse6MI4ik4+zx9CrgNy5XbZtBSUEFSCD3McC/w/Hfm7vdKzOes+vNEhbF+9e34WqFYYl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4n6UqK8H5+b0LfxaHU5x5W61lLni4AlrSTVrOTlnvytZ+FlMc
	gx7o3GT0cr45lcGYg7w9SGyCTbI0dmygTEGydz/4Sp1wiWfjg6z8Z+a4vjs5xrMRlo1BdhWP1l0
	CMuLMjNDNB82gEsRT0Eyq19FNsPHhJepqpuKP83Fojg9zkrkqnFbgBXPMcFymH5A=
X-Gm-Gg: ASbGncvL3x13M6Ila/xBUPsLZ5RpGmpC29ioWAHxQ282k4Uzq+qL9yHZ3557RE+JNST
	j/GMVJgqv7YPGHbWwnSIl/dsORUrfYtWXB0j4ah3CmjpGbIkn0wvDP5x02sbqAYHO63Ax2gUvg/
	NEjZ7zNqrDpwzuCv0lsWg58XmMd29AZahV7Foa2NZ8fPIziRmbacn1kUIFMiELTzmRTBcOQAMss
	ZEmjtdZ+KyNmJohTzYGi+GT2i1zaOSra7tUXndUqX2+MAoMfrR4+VI+vPGbvsJf4p9tkNu8Twae
	gUpPsJ1j4W1Y/6qiLlOcy1kFUkOe/LrZDCqZrjXCrqCm9R5BQZgQXuvWNyWChPnK3/tJbAzAT0y
	f7J8RSmrrSIjVTxDVbkvksO8E5DlF84qKMN5FYLHhPeMCtm4=
X-Received: by 2002:a17:907:3f1f:b0:ad2:417b:2ab5 with SMTP id a640c23a62f3a-adfad4f5a5amr1126324966b.60.1750176580466;
        Tue, 17 Jun 2025 09:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6u1NV6QXYpbyorqCmZBn41Wz+ATHHrC4a871mog3qYJ+wSPRBCHfMyBrTpWHRiApiZ+6vfg==
X-Received: by 2002:a17:907:3f1f:b0:ad2:417b:2ab5 with SMTP id a640c23a62f3a-adfad4f5a5amr1126321166b.60.1750176579921;
        Tue, 17 Jun 2025 09:09:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f31:700:3851:c66a:b6b9:3490? (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec897ac25sm890207966b.157.2025.06.17.09.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 09:09:39 -0700 (PDT)
Message-ID: <129fe808-4285-48fe-95b6-00ea19bd87af@redhat.com>
Date: Tue, 17 Jun 2025 18:09:36 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: netmem series needs some love and Acks from MM folks
To: Harry Yoo <harry.yoo@oracle.com>, Mina Almasry <almasrymina@google.com>,
 willy@infradead.org
Cc: Byungchul Park <byungchul@sk.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, ilias.apalodimas@linaro.org, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com,
 tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
References: <20250609043225.77229-1-byungchul@sk.com>
 <20250609043225.77229-2-byungchul@sk.com>
 <20250609123255.18f14000@kernel.org>
 <20250610013001.GA65598@system.software.com>
 <20250611185542.118230c1@kernel.org>
 <20250613011305.GA18998@system.software.com>
 <CAHS8izMsKaP66A1peCHEMxaqf0SV-O6uRQ9Q6MDNpnMbJ+XLUA@mail.gmail.com>
 <aFDTikg1W3Bz_s5E@hyeyoo>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aFDTikg1W3Bz_s5E@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.06.25 04:31, Harry Yoo wrote:
> On Fri, Jun 13, 2025 at 07:19:07PM -0700, Mina Almasry wrote:
>> On Thu, Jun 12, 2025 at 6:13 PM Byungchul Park <byungchul@sk.com> wrote:
>>>
>>> On Wed, Jun 11, 2025 at 06:55:42PM -0700, Jakub Kicinski wrote:
>>>> On Tue, 10 Jun 2025 10:30:01 +0900 Byungchul Park wrote:
>>>>>> What's the intended relation between the types?
>>>>>
>>>>> One thing I'm trying to achieve is to remove pp fields from struct page,
>>>>> and make network code use struct netmem_desc { pp fields; } instead of
>>>>> sturc page for that purpose.
>>>>>
>>>>> The reason why I union'ed it with the existing pp fields in struct
>>>>> net_iov *temporarily* for now is, to fade out the existing pp fields
>>>>> from struct net_iov so as to make the final form like:
>>>>
>>>> I see, I may have mixed up the complaints there. I thought the effort
>>>> was also about removing the need for the ref count. And Rx is
>>>> relatively light on use of ref counting.
>>>>
>>>>>> netmem_ref exists to clearly indicate that memory may not be readable.
>>>>>> Majority of memory we expect to allocate from page pool must be
>>>>>> kernel-readable. What's the plan for reading the "single pointer"
>>>>>> memory within the kernel?
>>>>>>
>>>>>> I think you're approaching this problem from the easiest and least
>>>>>
>>>>> No, I've never looked for the easiest way.  My bad if there are a better
>>>>> way to achieve it.  What would you recommend?
>>>>
>>>> Sorry, I don't mean that the approach you took is the easiest way out.
>>>> I meant that between Rx and Tx handling Rx is the easier part because
>>>> we already have the suitable abstraction. It's true that we use more
>>>> fields in page struct on Rx, but I thought Tx is also more urgent
>>>> as there are open reports for networking taking references on slab
>>>> pages.
>>>>
>>>> In any case, please make sure you maintain clear separation between
>>>> readable and unreadable memory in the code you produce.
>>>
>>> Do you mean the current patches do not?  If yes, please point out one
>>> as example, which would be helpful to extract action items.
>>>
>>
>> I think one thing we could do to improve separation between readable
>> (pages/netmem_desc) and unreadable (net_iov) is to remove the struct
>> netmem_desc field inside the net_iov, and instead just duplicate the
>> pp/pp_ref_count/etc fields. The current code gives off the impression
>> that net_iov may be a container of netmem_desc which is not really
>> accurate.
>>
>> But I don't think that's a major blocker. I think maybe the real issue
>> is that there are no reviews from any mm maintainers?
> 
> Let's try changing the subject to draw some attention from MM people :)

Hi, it worked! :P

I hope Willy will find his way to this thread as well.

> 
>> So I'm not 100%
>> sure this is in line with their memdesc plans. I think probably
>> patches 2->8 are generic netmem-ifications that are good to merge
>> anyway, but I would say patch 1 and 9 need a reviewed by from someone
>> on the mm side. Just my 2 cents.
> 
> As someone who worked on the zpdesc series, I think it is pretty much
> in line with the memdesc plans.
> 
> I mean, it does differ a bit from the initial idea of generalizing it as
> "bump" allocator, but overall, it's still aligned with the memdesc
> plans, and looks like a starting point, IMHO.

Just to summarize (not that there is any misunderstanding), the first 
step of the memdesc plan is simple:

1) have a dedicated data-structure we will allocate alter dynamically.

2) Make it overlay "struct page" for now in a way that doesn't break things

3) Convert all users of "struct page" to the new data-structure

Later, the memdesc data-structure will then actually come be allocated 
dynamically, so "struct page" content will not apply anymore, and we can 
shrink "struct page".


What I see in this patch is exactly 1) and 2).

I am not 100% sure about existing "struct net_iov" and how that 
interacts with "struct page" overlay. I suspects it's just a dynamically 
allocated structure?

Because this patch changes the layout of "struct net_iov", which is a 
bit confusing at first sight?

-- 
Cheers,

David / dhildenb


