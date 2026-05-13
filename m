Return-Path: <linux-rdma+bounces-20560-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UI/GGAxIBGo+GwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20560-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 11:44:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE804530E0F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 11:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB45F31BB281
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 09:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AF43E92B6;
	Wed, 13 May 2026 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B/MeBwzn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wolDbEnS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B/MeBwzn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wolDbEnS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D973ADB9A
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778664383; cv=none; b=BrXH4YuvwgnT+RQTWD0Z6gRACLNDx+Z8++CjAvvtEDBgR/vud/C4wGvwocrki4wy+S/9pRoamL0dmPN26q1F9Y+Y7afIwNnuccqOaDKqU9Vpol1bU6el5mrOx6G87R3FK0WhgD8yxaaTqZYQ59hsoTg7EYR/AihMdYniNZnkBCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778664383; c=relaxed/simple;
	bh=+A61wAMje7LEB0KBDcQB/mm5PLvDuXfGI5f1q6hv03U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NV5yoRQA0uhEHJzVm9/pabsCbxMQ5OR5uFE1pPsLHxTyppZK9ZKkvgAyRPQ7c8T+ZfaPHp8weEBOXmqu0GCnWkwTPHIs7kf3sooFX7PDJRC5B+DcXlclrarWpC0P5/qHRAdb6aQzHz25sxzeetqcIV59YiQ1rE8ss2f1SMrHPT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B/MeBwzn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wolDbEnS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B/MeBwzn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wolDbEnS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 99D635CFB0;
	Wed, 13 May 2026 09:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778664378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKMrjHaSnPAmYEI6gQbk/Eny6irDx2lJWYL45Uo3FA0=;
	b=B/MeBwznYOdHc/hhIMg9XPMYhyMqz+Sdb6grPppKJNPaZvkz8i2c4x+aWC8+LAgaO/FZJx
	nge+82TDRbcL6XHLe3AW3Iunic2rZc5jcWj8yGXITKqSeHN4etaxPrPR5mgcEq1JovUvq/
	yaQsxHnoe1YsdisEooOv9J/luv5Pafw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778664378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKMrjHaSnPAmYEI6gQbk/Eny6irDx2lJWYL45Uo3FA0=;
	b=wolDbEnSGba8O5U4zO9fMtpF8uA3r+9Pj4N+aOadTPVOPcZbdRgl5zvxXLRiVAHYya/8DM
	E1U/WxDRgYtsPKBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778664378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKMrjHaSnPAmYEI6gQbk/Eny6irDx2lJWYL45Uo3FA0=;
	b=B/MeBwznYOdHc/hhIMg9XPMYhyMqz+Sdb6grPppKJNPaZvkz8i2c4x+aWC8+LAgaO/FZJx
	nge+82TDRbcL6XHLe3AW3Iunic2rZc5jcWj8yGXITKqSeHN4etaxPrPR5mgcEq1JovUvq/
	yaQsxHnoe1YsdisEooOv9J/luv5Pafw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778664378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKMrjHaSnPAmYEI6gQbk/Eny6irDx2lJWYL45Uo3FA0=;
	b=wolDbEnSGba8O5U4zO9fMtpF8uA3r+9Pj4N+aOadTPVOPcZbdRgl5zvxXLRiVAHYya/8DM
	E1U/WxDRgYtsPKBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9893E593A9;
	Wed, 13 May 2026 09:26:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A7zjIbdDBGoVZwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 13 May 2026 09:26:15 +0000
Date: Wed, 13 May 2026 10:26:13 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, 
	Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel_team@skhynix.com, 
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com, 
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, horms@kernel.org, jackmanb@google.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org, 
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com, 
	baolin.wang@linux.alibaba.com, almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk, 
	ap420073@gmail.com
Subject: Re: [PATCH v4] mm: introduce a new page type for page pool in page
 type
Message-ID: <agRB2QTbzceRgpzX@pedro-suse>
References: <20260224051347.19621-1-byungchul@sk.com>
 <982b9bc1-0a0a-4fc5-8e3a-3672db2b29a1@nvidia.com>
 <4af19eda-c29c-4302-92d5-c0915267fc0c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4af19eda-c29c-4302-92d5-c0915267fc0c@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Rspamd-Queue-Id: EE804530E0F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20560-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,sk.com,kvack.org,linux-foundation.org,vger.kernel.org,skhynix.com,oracle.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,lunn.ch,google.com,redhat.com,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sk.com:email,suse.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 11:12:43AM +0200, Vlastimil Babka (SUSE) wrote:
> On 5/13/26 11:00, Dragos Tatulea wrote:
> > 
> > 
> > On 24.02.26 06:13, Byungchul Park wrote:
> >> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> >> determine if a page belongs to a page pool.  However, with the planned
> >> removal of @pp_magic, we should instead leverage the page_type in struct
> >> page, such as PGTY_netpp, for this purpose.
> >> 
> >> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> >> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> >> @pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> >> netmem_clear_pp_magic().
> >> 
> >> Plus, add @page_type to struct net_iov at the same offset as struct page
> >> so as to use the page_type APIs for struct net_iov as well.  While at it,
> >> reorder @type and @owner in struct net_iov to avoid a hole and
> >> increasing the struct size.
> >> 
> >> This work was inspired by the following link:
> >> 
> >>   https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> >> 
> >> While at it, move the sanity check for page pool to on the free path.
> >> 
> >> Suggested-by: David Hildenbrand <david@redhat.com>
> >> Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
> >> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >> Signed-off-by: Byungchul Park <byungchul@sk.com>
> >> Acked-by: David Hildenbrand <david@redhat.com>
> >> Acked-by: Zi Yan <ziy@nvidia.com>
> >> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> >> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> >> ---
> > 
> > Seems like this patch broke tcp_mmap because
> > validate_page_before_insert() returns -EINVAL due
> > to a page having a type. Here's the full flow:
> > 
> > getsockopt(TCP_ZEROCOPY_RECEIVE) returns -EINVAL because of the
> > below flow in the kernel:
> > 
> > tcp_zerocopy_receive()
> > -> tcp_zerocopy_vm_insert_batch()
> >   -> vm_insert_pages()
> >     -> insert_pages()
> >       -> insert_page_in_batch_locked()
> >         -> validate_page_before_insert() returns -EINVAL
> >            because page_has_type(page) is now true.
> > 
> > The patch below fixes the issue. But is this a valid fix?
> 
> Hmm the check traces back to commit 0ee930e6cafa0 "mm/memory.c: prevent
> mapping typed pages to userspace"
> 
> > Pages which use page_type must never be mapped to userspace as it would
> > destroy their page type.  Add an explicit check for this instead of
> > assuming that kernel drivers always get this right.
> 
> So uh, this doesn't look good I think.

Yep, you fundamentally can't map a page with a type as page type aliases with
mapcount. Even with the given diff, just mapping it will increment the mapcount
and wreak havoc. I think we need to revert this patch for now.

I'm not sure what the long term plan for this would be. If page types are moved
to memdesc types, then the two stop colliding and that could work. I don't know
if that's Willy's plan, however.

(then there's the other question: are page pool pages really folios? not really.
they are mappable, but they aren't part of the page cache, or anon, nor are
they in the LRU or have rmap capabilities. perhaps we need a different memdesc
for those. we're one step away from reinventing class polymorphism from first
principles ;)

> 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index ea6568571131..4cb12673f450 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -2326,7 +2326,7 @@ static int validate_page_before_insert(struct vm_area_struct *vma,
> >                         return -EINVAL;
> >                 return 0;
> >         }
> > -       if (folio_test_anon(folio) || page_has_type(page))
> > +       if (folio_test_anon(folio) || (page_has_type(page) && !PageNetpp(page)))
> >                 return -EINVAL;
> >         flush_dcache_folio(folio);
> >         return 0;
> > 
> > Thanks,
> > Dragos
> > 
> > 
> 
> 

-- 
Pedro

