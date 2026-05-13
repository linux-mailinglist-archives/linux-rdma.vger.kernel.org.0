Return-Path: <linux-rdma+bounces-20572-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN/QOTdvBGprIQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20572-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 14:31:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C375330F9
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 14:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6863A30E162D
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 12:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F02C40FDAC;
	Wed, 13 May 2026 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BALjQ7oD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD0E3FFADB;
	Wed, 13 May 2026 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675400; cv=none; b=AOoddgBYBwz5Fy+jNd43b6HwqE8Q/UNCXvsSIcIpYn/2rZjFXq16LS0kOf8SeUa90hKyYhKmwn8DMynCjg/FpO+fPVojoI/CqwNu1PZtT0RMhn/EjOMjUzFzvfMpkY2o7I2WexQOV+qvZLqz9NBLaFcWmpCb904plvaEOOzUxzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675400; c=relaxed/simple;
	bh=Dp/eLuCZ/1PTNaxErBFBY0x0xot4Fm2FxvmhaA8PCZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/O4ivBPgr2Z/+bZxAK5btYgKqmKYOWbziStG57ph146m9a5/Gv8EtKGM/fMa+s4weGp3eljFZM5S56zA1a5R196ZMTNiZKFUcA16UCnxhUgfAzbSxHx50isipORamXpnW17y9SeZgRWYcIvIQKcQkSWEueClFtyLMChG/GyFvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BALjQ7oD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24081C2BCB7;
	Wed, 13 May 2026 12:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778675399;
	bh=Dp/eLuCZ/1PTNaxErBFBY0x0xot4Fm2FxvmhaA8PCZc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BALjQ7oDFiHFeFw/swgagdXwyAXHEQhvq/8j09YpSMbiWHgIF/jXoe/pCNizrAM/v
	 hFRL2lXP0miBUe5oqwibjIWMYlciZV4HEwzOzpM6rnllo8wNHxQlO5SKy0YiN4GulC
	 xjbNQqo+kMls8DI97Twpa9XUI6fDgyRuPN95wNRL57+uxS6Dpin0SycVE/seLD9eFc
	 qUoYCPkrd7p0DTKkb5wfPfmQHQlcIEjKiatx5YcHQXmn0HKpcb2P1T9sTxVaMNVPDe
	 c70L++s32jaqCU7kWQL7qX0TdAvtgN0iKmjPJC+8wQrGU62jt0CT4fWMzPwXgBP1Dk
	 6I1FUMsWR2XQw==
Message-ID: <8348d867-f8a1-432c-be2d-699ad96b2e93@kernel.org>
Date: Wed, 13 May 2026 14:29:46 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: introduce a new page type for page pool in page
 type
To: Byungchul Park <byungchul@sk.com>, Dragos Tatulea <dtatulea@nvidia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com, harry.yoo@oracle.com,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org,
 kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com,
 baolin.wang@linux.alibaba.com, almasrymina@google.com, toke@redhat.com,
 asml.silence@gmail.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com
References: <20260224051347.19621-1-byungchul@sk.com>
 <982b9bc1-0a0a-4fc5-8e3a-3672db2b29a1@nvidia.com>
 <20260513121805.GA22430@system.software.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260513121805.GA22430@system.software.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 27C375330F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20572-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,vger.kernel.org,skhynix.com,oracle.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sk.com:email,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/13/26 14:18, Byungchul Park wrote:
> On Wed, May 13, 2026 at 11:00:51AM +0200, Dragos Tatulea wrote:
>> On 24.02.26 06:13, Byungchul Park wrote:
>>> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
>>> determine if a page belongs to a page pool.  However, with the planned
>>> removal of @pp_magic, we should instead leverage the page_type in struct
>>> page, such as PGTY_netpp, for this purpose.
>>>
>>> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
>>> and __ClearPageNetpp() instead, and remove the existing APIs accessing
>>> @pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
>>> netmem_clear_pp_magic().
>>>
>>> Plus, add @page_type to struct net_iov at the same offset as struct page
>>> so as to use the page_type APIs for struct net_iov as well.  While at it,
>>> reorder @type and @owner in struct net_iov to avoid a hole and
>>> increasing the struct size.
>>>
>>> This work was inspired by the following link:
>>>
>>>   https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
>>>
>>> While at it, move the sanity check for page pool to on the free path.
>>>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>> Acked-by: Zi Yan <ziy@nvidia.com>
>>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>> ---
>>
>> Seems like this patch broke tcp_mmap because
>> validate_page_before_insert() returns -EINVAL due
>> to a page having a type. Here's the full flow:
>>
>> getsockopt(TCP_ZEROCOPY_RECEIVE) returns -EINVAL because of the
>> below flow in the kernel:
>>
>> tcp_zerocopy_receive()
>> -> tcp_zerocopy_vm_insert_batch()
>>   -> vm_insert_pages()
>>     -> insert_pages()
>>       -> insert_page_in_batch_locked()
>>         -> validate_page_before_insert() returns -EINVAL
>>            because page_has_type(page) is now true.
>>
>> The patch below fixes the issue. But is this a valid fix?
> 
> Hi,
> 
> The problem comes from the fact that page_type and _mapcount are
> union'ed but there is a case where these two information should be kept
> at the same time.
> 
> Why don't we allow these two information can be kept in the 4 bytes at
> the same time until Zi Yan's work on _mapcount and page_type will be
> done, instead of taking a step back?
> 
> It can be more optimized but I suggest the approach I just mentioned:
> ---
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 64dc44832808..e5ec204866dc 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -185,8 +185,7 @@ static inline int folio_precise_page_mapcount(struct folio *folio,
>  {
>  	int mapcount = atomic_read(&page->_mapcount) + 1;
>  
> -	if (page_mapcount_is_type(mapcount))
> -		mapcount = 0;
> +	mapcount = page_mapcount_clear_type(mapcount);
>  	if (folio_test_large(folio))
>  		mapcount += folio_entire_mapcount(folio);
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8260e28205e9..f45064796313 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1865,8 +1865,7 @@ static inline int folio_mapcount(const struct folio *folio)
>  
>  	if (likely(!folio_test_large(folio))) {
>  		mapcount = atomic_read(&folio->_mapcount) + 1;
> -		if (page_mapcount_is_type(mapcount))
> -			mapcount = 0;
> +		mapcount = page_mapcount_clear_type(mapcount);
>  		return mapcount;
>  	}
>  	return folio_large_mapcount(folio);
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 0e03d816e8b9..f3b0d1fa262d 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -934,9 +934,9 @@ static inline bool page_type_has_type(int page_type)
>  }
>  
>  /* This takes a mapcount which is one more than page->_mapcount */
> -static inline bool page_mapcount_is_type(unsigned int mapcount)
> +static inline unsigned int page_mapcount_clear_type(unsigned int mapcount)
>  {
> -	return page_type_has_type(mapcount - 1);
> +	return (unsigned int)(((int)(mapcount << 8)) >> 8);
>  }
>  
>  static inline bool page_has_type(const struct page *page)
> @@ -953,16 +953,20 @@ static __always_inline void __folio_set_##fname(struct folio *folio)	\
>  {									\
>  	if (folio_test_##fname(folio))					\
>  		return;							\
> -	VM_BUG_ON_FOLIO(data_race(folio->page.page_type) != UINT_MAX,	\
> +	VM_BUG_ON_FOLIO(page_type_has_type(data_race(folio->page.page_type)), \
>  			folio);						\
> -	folio->page.page_type = (unsigned int)PGTY_##lname << 24;	\
> +	folio->page.page_type &= ~(PGTY_mapcount_underflow << 24);	\
> +	folio->page.page_type |= (unsigned int)PGTY_##lname << 24;	\
>  }									\
>  static __always_inline void __folio_clear_##fname(struct folio *folio)	\
>  {									\
> -	if (folio->page.page_type == UINT_MAX)				\
> +	int mapcount;							\
> +									\
> +	if (!page_type_has_type(folio->page.page_type))			\
>  		return;							\
>  	VM_BUG_ON_FOLIO(!folio_test_##fname(folio), folio);		\
> -	folio->page.page_type = UINT_MAX;				\
> +	mapcount = atomic_read(&folio->page._mapcount);			\
> +	folio->page.page_type = page_mapcount_clear_type(mapcount);	\
>  }
>  
>  #define PAGE_TYPE_OPS(uname, lname, fname)				\
> @@ -975,15 +979,20 @@ static __always_inline void __SetPage##uname(struct page *page)		\
>  {									\
>  	if (Page##uname(page))						\
>  		return;							\
> -	VM_BUG_ON_PAGE(data_race(page->page_type) != UINT_MAX, page);	\
> -	page->page_type = (unsigned int)PGTY_##lname << 24;		\
> +	VM_BUG_ON_PAGE(page_type_has_type(data_race(page->page_type)),	\
> +				page);					\
> +	page->page_type &= ~(PGTY_mapcount_underflow << 24);		\
> +	page->page_type |= (unsigned int)PGTY_##lname << 24;		\
>  }									\
>  static __always_inline void __ClearPage##uname(struct page *page)	\
>  {									\
> -	if (page->page_type == UINT_MAX)				\
> +	int mapcount;							\
> +									\
> +	if (!page_type_has_type(page->page_type))			\
>  		return;							\
>  	VM_BUG_ON_PAGE(!Page##uname(page), page);			\
> -	page->page_type = UINT_MAX;					\
> +	mapcount = atomic_read(&page->_mapcount);			\
> +	page->page_type = page_mapcount_clear_type(mapcount);		\
>  }
>  
>  /*
> diff --git a/mm/debug.c b/mm/debug.c
> index 77fa8fe1d641..9a932ded09d4 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -74,8 +74,7 @@ static void __dump_folio(const struct folio *folio, const struct page *page,
>  	int mapcount = atomic_read(&page->_mapcount) + 1;
>  	char *type = "";
>  
> -	if (page_mapcount_is_type(mapcount))
> -		mapcount = 0;
> +	mapcount = page_mapcount_clear_type(mapcount);
>  
>  	pr_warn("page: refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
>  			folio_ref_count(folio), mapcount, mapping,
> ---
> 
> Thoughts?

God no.

-- 
Cheers,

David

