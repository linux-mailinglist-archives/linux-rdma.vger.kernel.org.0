Return-Path: <linux-rdma+bounces-11547-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF6AAE47C5
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 17:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1EA3B8E81
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 14:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AB826B2D2;
	Mon, 23 Jun 2025 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGe3990/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C090A24DCE8
	for <linux-rdma@vger.kernel.org>; Mon, 23 Jun 2025 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690734; cv=none; b=qQQTZr8xDpv3L0i3JuRLQOCOMr93mDSMZ4yhh7/mZpyZkeIEcEf+buIuGgV9/71R007uLf86YtAZ7Cv/YC1pzLksi0OBZmGNsKV9e0zAO+O0/ZXTULzkekfcjWDOEfi3T1nD57HvF86u8b46IYYcjzvqqJHKu79WUKk3Q9zUmPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690734; c=relaxed/simple;
	bh=I0vLvxNhNB4FaaXsZwnwZHctYtZVxZ/sEkUln7niZwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URbIZDRWPt+bkq9qypqBc13kJRifmttbpi6mnpkOLKBRbNNbz2impsiWLmLWor3v3vXoeyPQC3RXVAZa3tZsIsS/kFTT68dUjfZzUnk4rUSBxaKTYyDcsviactPKiZDSNYz00FiLAhheSgTHuC4BhTtWjrlFS18e6fYcJFtY16w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGe3990/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750690731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2fxkqf4Mvr7CSFJ3WG+x2K7csO1QpeDPNxQNGZa8XgY=;
	b=FGe3990/KsSeCodlHswxavBxvaLt83Oto+nynw+Weudveguko5fL/FCtlgw6ucfWmTs4CK
	ERP02h38xTrgLVp6M0H915CVsrahAIVZ2CkEbHMzONRvTeLVC/kPk0N1bxCzkJEjKeIqRN
	hq4+wpSiDqTbBKQDTLdKHH4gHZYawXs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-6foYs55hMY2in_62jbFFWg-1; Mon, 23 Jun 2025 10:58:50 -0400
X-MC-Unique: 6foYs55hMY2in_62jbFFWg-1
X-Mimecast-MFC-AGG-ID: 6foYs55hMY2in_62jbFFWg_1750690729
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45311704d1fso27465415e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 23 Jun 2025 07:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690729; x=1751295529;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2fxkqf4Mvr7CSFJ3WG+x2K7csO1QpeDPNxQNGZa8XgY=;
        b=t6vxDdb2yrnMEG6X7QqWi7rXEUnmUsQojswXMd4Uth7kxDYFK0rACQV3EDOvG0BlvA
         FiqFlXLtDFLkeBYmRyCl0lQwGyfIIgBz+iG746pF7MmeGiIlIDD5f1fx0vK8Oqc5t0rU
         oZyARPmvnjBrcZFUiSXWw8YUQuAV1y3hAE+3QIqyteS/Fx914Fr8fDt5tj+cTqsoeiRQ
         YdcbnKqdfBxHEYzw1ezdnHJCw+SBZ9WeOi75SmPVMZYVJXJpX9U43lPlvAuRomCrHLEa
         n5kS8GnGspIKG9V4YbS96zjjhYmbEA8Rx3jdAk+qLfWsfdLSFuPaYmqrGThUmOuM5N4F
         tbBw==
X-Forwarded-Encrypted: i=1; AJvYcCVdcyw6HL8ZsWqiYAxGOs1ufjCnLnbWhLN4Sq9vAMbchGZhonH8geuFgDJ8Qu+bbENGakKF82/CdYD5@vger.kernel.org
X-Gm-Message-State: AOJu0YzXUW57Xb8QGIllhEca02ugo2kBtxzlUu0wipmg0GvCoo8BpkuU
	ZPJqCF3tyWbDpI5U90qIKBVTmmAKIe+lj7xwSeLnZV9huuObQ3XMykWiMfLpcsBbbL18RZlbU5F
	YWlDq5rn0T3s/zWOUs/57e1Fcc4U2CRdWLSi+jImfaAicGkCekfgVNKxu1LHjUHU=
X-Gm-Gg: ASbGncuIj5DIm6bOYOz1nLQOk72TI6cxKuxdIu/4Tk5OGgsqMT3lHIaLKuGkpAaFt7C
	LutcG6RsgJhiQ/I25kxgcxNLnyw6VqYgbUvY+8fCllIymSBtNRjIFWP7Rjc71+veMbx7ISAY/95
	c1+mcFFiyaiPsFb+mpUEvu1OFAHFk44lRAtRHqJAbbsucibGfvssTEMq4T1UhZYG85g7Mu6DFve
	iQJ8c5ysQh0cMBWTA+S2Ot8OoJ0vP7rd6FdBjIng80Duhxo8/6HNILE8e++1MGZyt5mpqHFcUJE
	m9Vul8X6S10dqzLaXYz6rNKbr0YyrgSYoqCi8S/BZUiZ018ekgsFcbLaHL0U36uIpRabxsNrI+S
	5Olj0mb4Zc3F06NVABr1ZBIBDMrHOPXxln4tCSS4iTq25iTCMyg==
X-Received: by 2002:a05:600c:3b83:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-453659ca16cmr131187345e9.14.1750690728830;
        Mon, 23 Jun 2025 07:58:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtIybu0ONExVt+k2ulZMylHRwnO9hazFruWs7MB2pWYLqNa2thHFPG//NOW6TTZxku9Gf+yg==
X-Received: by 2002:a05:600c:3b83:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-453659ca16cmr131186835e9.14.1750690728381;
        Mon, 23 Jun 2025 07:58:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535eada7adsm149082415e9.35.2025.06.23.07.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 07:58:47 -0700 (PDT)
Message-ID: <a8d40a05-db4c-400f-839b-3c6159a1feab@redhat.com>
Date: Mon, 23 Jun 2025 16:58:45 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 9/9] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
To: Zi Yan <ziy@nvidia.com>, Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, almasrymina@google.com, ilias.apalodimas@linaro.org,
 harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, linux-rdma@vger.kernel.org,
 bpf@vger.kernel.org, vishal.moola@gmail.com, hannes@cmpxchg.org,
 jackmanb@google.com
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-10-byungchul@sk.com>
 <ce5b4b18-9934-41e3-af04-c34653b4b5fa@redhat.com>
 <20250623101622.GB3199@system.software.com>
 <460ACE40-9E99-42B8-90F0-2B18D2D8C72C@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <460ACE40-9E99-42B8-90F0-2B18D2D8C72C@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.06.25 13:13, Zi Yan wrote:
> On 23 Jun 2025, at 6:16, Byungchul Park wrote:
> 
>> On Mon, Jun 23, 2025 at 11:16:43AM +0200, David Hildenbrand wrote:
>>> On 20.06.25 06:12, Byungchul Park wrote:
>>>> To simplify struct page, the effort to separate its own descriptor from
>>>> struct page is required and the work for page pool is on going.
>>>>
>>>> To achieve that, all the code should avoid directly accessing page pool
>>>> members of struct page.
>>>>
>>>> Access ->pp_magic through struct netmem_desc instead of directly
>>>> accessing it through struct page in page_pool_page_is_pp().  Plus, move
>>>> page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
>>>> without header dependency issue.
>>>>
>>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>>>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>>>> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
>>>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>>> Acked-by: Harry Yoo <harry.yoo@oracle.com>
>>>> ---
>>>>    include/linux/mm.h   | 12 ------------
>>>>    include/net/netmem.h | 14 ++++++++++++++
>>>>    mm/page_alloc.c      |  1 +
>>>>    3 files changed, 15 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index 0ef2ba0c667a..0b7f7f998085 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -4172,16 +4172,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>>>>     */
>>>>    #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>>>
>>>> -#ifdef CONFIG_PAGE_POOL
>>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>>> -{
>>>> -     return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
>>>> -}
>>>> -#else
>>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>>> -{
>>>> -     return false;
>>>> -}
>>>> -#endif
>>>> -
>>>>    #endif /* _LINUX_MM_H */
>>>> diff --git a/include/net/netmem.h b/include/net/netmem.h
>>>> index d49ed49d250b..3d1b1dfc9ba5 100644
>>>> --- a/include/net/netmem.h
>>>> +++ b/include/net/netmem.h
>>>> @@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
>>>>     */
>>>>    static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
>>>>
>>>> +#ifdef CONFIG_PAGE_POOL
>>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>>> +{
>>>> +     struct netmem_desc *desc = (struct netmem_desc *)page;
>>>> +
>>>> +     return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
>>>> +}
>>>> +#else
>>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>>> +{
>>>> +     return false;
>>>> +}
>>>> +#endif
>>>
>>> I wonder how helpful this cleanup is long-term.
>>>
>>> page_pool_page_is_pp() is only called from mm/page_alloc.c, right?
>>
>> Yes.
>>
>>> There, we want to make sure that no pagepool page is ever returned to
>>> the buddy.
>>>
>>> How reasonable is this sanity check to have long-term? Wouldn't we be
>>> able to check that on some higher-level freeing path?
>>>
>>> The reason I am commenting is that once we decouple "struct page" from
>>> "struct netmem_desc", we'd have to lookup here the corresponding "struct
>>> netmem_desc".
>>>
>>> ... but at that point here (when we free the actual pages), the "struct
>>> netmem_desc" would likely already have been freed separately (remember:
>>> it will be dynamically allocated).
>>>
>>> With that in mind:
>>>
>>> 1) Is there a higher level "struct netmem_desc" freeing path where we
>>> could check that instead, so we don't have to cast from pages to
>>> netmem_desc at all.
>>
>> I also thought it's too paranoiac.  However, I thought it's other issue
>> than this work.  That's why I left the API as is for now, it can be gone
>> once we get convinced the check is unnecessary in deep buddy.  Wrong?
>>
>>> 2) How valuable are these sanity checks deep in the buddy?
>>
>> That was also what I felt weird on.
> 
> It seems very useful when I asked last time[1]:
> 
> |> We have actually used this at Cloudflare to catch some page_pool bugs.

My question is rather, whether there is some higher-level freeing path 
for netmem_desc where we could check that instead (IOW, earlier).

Or is it really arbitrary put_page() (IOW, we assume that many possible 
references can be held)?

-- 
Cheers,

David / dhildenb


