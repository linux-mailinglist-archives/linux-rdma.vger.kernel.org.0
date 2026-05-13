Return-Path: <linux-rdma+bounces-20559-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YITZMutABGokGQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20559-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 11:14:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 54420530640
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 11:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9264F307A825
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C9C3D75AA;
	Wed, 13 May 2026 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBCPO+Ea"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4AD357D0E;
	Wed, 13 May 2026 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663574; cv=none; b=n5SMjTA9rXAY70nQe33rd3TLdpeaGRPrZEHF6X7yFzoAA+tFWojeHgSQ4J2sBCvAO8mU2mLhUXFsUXLOmB4Vsfpnpu6DdAyMB9bYQEY1CbKqii1khoQoopMtZIkVs14F0jgwoyZ0JFuh9CgVF0JX8s8NQagb0d5ILzWWIGW+MrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663574; c=relaxed/simple;
	bh=qRabOF++bZmrieB5yRF9VHZpIrCCwhEvvQeJnJbmNtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zs7LJHIZuNOvyRIJSJEgeReQz+Vl1gdmWmwlChBOrBQuKZyKHrqkQ/BPgBq+WvSumRzR4mNBQ4wZHCOIGU6uen8sQz0xu1ziUHXUNqyMwrG82+DZ3u65hl7cnVA0BLKguezE0ew5PmohcSUdNJDWuuWDZd1Qas3cRH/dRvcwYuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBCPO+Ea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD842C2BCB7;
	Wed, 13 May 2026 09:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778663574;
	bh=qRabOF++bZmrieB5yRF9VHZpIrCCwhEvvQeJnJbmNtI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pBCPO+EaE8pJc/JDvuaqBXD7hV4smqSfKcHEgNUqGb4cGuGTDXOUFHiLGZbzd6C83
	 LBKayyvNHahEwKwg2tbuBOH6Mgg6i0ppemAUFB4NfHrjLIB2F6gup/g/K7UJl15LWa
	 jWQ6TkkjZHIZ+eQP9tFvmkVx4BRJumPBSOo6CXxX6U5PSZIJM6SYQStwSmCLr/M8NW
	 stDGSvDezseuddvtIn3nEO2gjrQhfVUS4ZOIjY+tpI6sPGyaAPCKRNMQjQ+9Ea1elR
	 NsjKBen6Y0JiijVZdJkyRt11Pq1TAM70H5IKgSkqt9ED849e3XyyNRG7BtxWmEsGtl
	 AnfwkT6FHnm9A==
Message-ID: <4af19eda-c29c-4302-92d5-c0915267fc0c@kernel.org>
Date: Wed, 13 May 2026 11:12:43 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: introduce a new page type for page pool in page
 type
Content-Language: en-US
To: Dragos Tatulea <dtatulea@nvidia.com>, Byungchul Park <byungchul@sk.com>,
 linux-mm@kvack.org, akpm@linux-foundation.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org,
 kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com,
 baolin.wang@linux.alibaba.com, almasrymina@google.com, toke@redhat.com,
 asml.silence@gmail.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com
References: <20260224051347.19621-1-byungchul@sk.com>
 <982b9bc1-0a0a-4fc5-8e3a-3672db2b29a1@nvidia.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <982b9bc1-0a0a-4fc5-8e3a-3672db2b29a1@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 54420530640
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20559-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,skhynix.com,oracle.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.cz:email,sk.com:email,nvidia.com:email]
X-Rspamd-Action: no action

On 5/13/26 11:00, Dragos Tatulea wrote:
> 
> 
> On 24.02.26 06:13, Byungchul Park wrote:
>> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
>> determine if a page belongs to a page pool.  However, with the planned
>> removal of @pp_magic, we should instead leverage the page_type in struct
>> page, such as PGTY_netpp, for this purpose.
>> 
>> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
>> and __ClearPageNetpp() instead, and remove the existing APIs accessing
>> @pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
>> netmem_clear_pp_magic().
>> 
>> Plus, add @page_type to struct net_iov at the same offset as struct page
>> so as to use the page_type APIs for struct net_iov as well.  While at it,
>> reorder @type and @owner in struct net_iov to avoid a hole and
>> increasing the struct size.
>> 
>> This work was inspired by the following link:
>> 
>>   https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
>> 
>> While at it, move the sanity check for page pool to on the free path.
>> 
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> ---
> 
> Seems like this patch broke tcp_mmap because
> validate_page_before_insert() returns -EINVAL due
> to a page having a type. Here's the full flow:
> 
> getsockopt(TCP_ZEROCOPY_RECEIVE) returns -EINVAL because of the
> below flow in the kernel:
> 
> tcp_zerocopy_receive()
> -> tcp_zerocopy_vm_insert_batch()
>   -> vm_insert_pages()
>     -> insert_pages()
>       -> insert_page_in_batch_locked()
>         -> validate_page_before_insert() returns -EINVAL
>            because page_has_type(page) is now true.
> 
> The patch below fixes the issue. But is this a valid fix?

Hmm the check traces back to commit 0ee930e6cafa0 "mm/memory.c: prevent
mapping typed pages to userspace"

> Pages which use page_type must never be mapped to userspace as it would
> destroy their page type.  Add an explicit check for this instead of
> assuming that kernel drivers always get this right.

So uh, this doesn't look good I think.

> diff --git a/mm/memory.c b/mm/memory.c
> index ea6568571131..4cb12673f450 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2326,7 +2326,7 @@ static int validate_page_before_insert(struct vm_area_struct *vma,
>                         return -EINVAL;
>                 return 0;
>         }
> -       if (folio_test_anon(folio) || page_has_type(page))
> +       if (folio_test_anon(folio) || (page_has_type(page) && !PageNetpp(page)))
>                 return -EINVAL;
>         flush_dcache_folio(folio);
>         return 0;
> 
> Thanks,
> Dragos
> 
> 


