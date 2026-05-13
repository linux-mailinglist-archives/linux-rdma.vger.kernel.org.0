Return-Path: <linux-rdma+bounces-20571-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI/BEhlsBGprIQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20571-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 14:18:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B91B532F29
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 14:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EFDA301EF87
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 12:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719C8402434;
	Wed, 13 May 2026 12:18:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8984238E5DC;
	Wed, 13 May 2026 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674704; cv=none; b=AUZR8rNrN5nPfn9Hx0zxMr1hi2ghcPd7P+94GVPzEe+uyCc4fx5wTBg/XuJACXFs7yUikZfbCcccK/405yVd0kqLZKK6coFR2ajKiBecZb39CCI2gk9Ex1uDCYUSxvCBcPOZjkGZQgEy4zrRGt8AM/OQ2bB7Pml3ZFy8luljIAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674704; c=relaxed/simple;
	bh=V+k0jlwcI8Q8Y1VYcQSmvuiN0PkI27SnbPw/BmTICW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNSSKhZGSVwW7TbF60i0ZoZ/VB0G1GKLtvYoX9fzbeuXNWAheiW91n+PxM/gT6IxUorv6L3rxEvhcRiUffaFXZqAJNr/asO3FkcLzwzCLxyAZXq16c1AUALnIPMW8QCQaro1yw3tfaU+dE3P2Bqk7r7bdEbmqTQ3FGtbFunplKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-3c-6a046c0274bd
Date: Wed, 13 May 2026 21:18:05 +0900
From: Byungchul Park <byungchul@sk.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
	sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com
Subject: Re: [PATCH v4] mm: introduce a new page type for page pool in page
 type
Message-ID: <20260513121805.GA22430@system.software.com>
References: <20260224051347.19621-1-byungchul@sk.com>
 <982b9bc1-0a0a-4fc5-8e3a-3672db2b29a1@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <982b9bc1-0a0a-4fc5-8e3a-3672db2b29a1@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTVxjHc+49PffS2ORYEA6aZVuXRYMKU/nwmKhxH0YOS0y2uU9b4mzk
	xpa1VVtgYGJWhERhUlDnBhe2wIyIiGCqhRbFVEBAljDsoquhCqsKGW86cFVepqMQM7798n+e
	/H/Ph0cW9WHNatlsy1LsNqPFQLRYO7Hil42CBWd+UPR3KlQ1NRC4+DIXzg95NTDTMCJAVX0z
	guczAxK8butCMN3ZTWCsYwrB2ZqICFW/FWL4p2lWBF/rCILR8ksEnnSFJbjo3gWDtcMYrh9r
	ESFc2kOgpHBOhLaZSQmOeusWiq84Jehvdmng+9lzIrQ4hyT4vbWKwMOG1xoYbi/BcFu9gOHZ
	mU4RBl07oas6HiK/jiPobGoRIHLiJwJ3K1oF8LTdleB0oJrAo8JBBIGOMIYz88cJVOa7EMy9
	XKicLHuugcpbD6WdyTw/GCS8Y/ypyK9euC/we+UnMQ/e6BW4T30g8Wp3Nr9Sl8SLgwGRu+uL
	CHdPnZJ46N51wnvK5zD3/bmV+7zTAi8pmCSfrPpCuy1DsZhzFHvKjr1aU/lfHeTgja25/tkX
	ghMVJhejGJnRVBb64Zb4hnsmzi0ypu8zf6RGiDKha1kwOLOYx9F1zOk5jYuRVhbpqMQG7rg1
	0UEs/Yz1qpWLSzoKTL3qXmBZ1lMzG7i0dyleyW5XPMZRFukG5vOESHRFpGvY+VfyUvw2K/As
	tcTQHWygsYJEeRV9j/mbu4WoltGCGBZyzWmWbk5kN+uCuAytVJcp1GUK9X+FukxRjXA90ptt
	OVaj2ZKabMqzmXOT9x2wutHC59Uemf/Si6b6d7cjKiPDCp1/P87Ua4w5jjxrO2KyaIjTlXah
	TL0uw5h3WLEf+MqebVEc7WiNjA0Jus2RbzL0dL8xS/laUQ4q9jdTQY5Z7UTmRu0ftWnp6fMf
	h/L9ifK2U/1nay47sn9uTexdrzTHDqf8q+5JSXu0h5q/85qOpXxa23g44fPNE6+sNtQdG8gd
	zE4rfWu7MevQ0Mai0Y8qp9edHCspe/fak138pnVEzfgx4cM+U9z99L4T9Gl80rfj7xwqGlvL
	XYFwQfyGvu3pWzy7DdhhMm5KEu0O439C5sGzdQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfZ/nue/zdHP2OOE7+bVrxqL8ynz8mGUtvgwzTFuMjp7p6jrc
	VSsWl5ofN0V+zHVli1Qk2k6/rhXnrjvFH5Kxs4tImCRGRWXSaab/Xnu/33v99RZYZYNsiqDR
	JUp6nVqrwnJOvmlFRjCj5eIWuDsCIb+8DMPNnylQ8rpGBv1lHxjIL61C0NPv5WGo3o3ge8MD
	DJ+c3xAUXuljIf9xJge95QMs2Go/IOg038Lwzt3Ow03rRmgrfs9B3YlqFtrPNGLIyhxkob6/
	m4djNdeHxXeMPDgvN8mguSpbBhcGilioNr7m4WltPoZXZUMyeO/I4qDJcoODrxcbWGjLDgN3
	wSToe9SFoKG8moG+05cxPMutZaCy/hkP51sKMLzNbEPQ4mzn4OKvkxjy0rMRDP4cVnaf7ZFB
	nusVHzafpns8mDq7vrC04sYLhj4353DUc/chQ22WlzwtsCbRO9eDqMnTwlJr6SlMrd/O8bT1
	eR2mjeZBjtreLKO2mu8MzcroxpsnRclXxkhaTbKkn78qWh5r/ujEB+4uS7EP/GCMKDPEhPwE
	IoaSxs9FrI85cRax911hfIzF2cTj6f+b+4tziLHyPGdCcoEVO3nifWKV+YoJ4hby0JL3d6QQ
	gVgqrMMsCEpRQ7y3okfi8aQpt4PzMSvOI7bKVuybsGIAKfktjMQzSEbliMVPXEW8t3OxjyeK
	gcRe9YA5i8ZZRpkso0yW/ybLKFMB4kqRv0aXnKDWaJeEGOJjU3WalJC9+xOsaPhbxWm/cmpQ
	z9O1DiQKSDVWYd/HxSll6mRDaoIDEYFV+SvOuFGcUhGjTj0k6ffv1idpJYMDBQicarJifaQU
	rRT3qROleEk6IOn/tYzgN8WI7Iejkk3HSaHLuWFOW1pSZPXWiLnTdlnnrom49js8sm5WqvJ0
	77bgsuYJuyeve3l/dY7uTZbjcGjH0u24l5k2rtWVXryHmobu32MvGYPT0rfZjlSEH/WrWj8m
	dPGOHVOHdhrNAXpvTKfr5PSZV7vehpVEPg6P2LkoYdMhF7/44PK4xEQVZ4hVLwxi9Qb1H0DS
	Hk1XAwAA
X-CFilter-Loop: Reflected
X-Rspamd-Queue-Id: 3B91B532F29
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[sk.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20571-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,vger.kernel.org,skhynix.com,oracle.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 11:00:51AM +0200, Dragos Tatulea wrote:
> On 24.02.26 06:13, Byungchul Park wrote:
> > Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> > determine if a page belongs to a page pool.  However, with the planned
> > removal of @pp_magic, we should instead leverage the page_type in struct
> > page, such as PGTY_netpp, for this purpose.
> >
> > Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> > and __ClearPageNetpp() instead, and remove the existing APIs accessing
> > @pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> > netmem_clear_pp_magic().
> >
> > Plus, add @page_type to struct net_iov at the same offset as struct page
> > so as to use the page_type APIs for struct net_iov as well.  While at it,
> > reorder @type and @owner in struct net_iov to avoid a hole and
> > increasing the struct size.
> >
> > This work was inspired by the following link:
> >
> >   https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> >
> > While at it, move the sanity check for page pool to on the free path.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
> > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Acked-by: Zi Yan <ziy@nvidia.com>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> > ---
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

Hi,

The problem comes from the fact that page_type and _mapcount are
union'ed but there is a case where these two information should be kept
at the same time.

Why don't we allow these two information can be kept in the 4 bytes at
the same time until Zi Yan's work on _mapcount and page_type will be
done, instead of taking a step back?

It can be more optimized but I suggest the approach I just mentioned:
---
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 64dc44832808..e5ec204866dc 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -185,8 +185,7 @@ static inline int folio_precise_page_mapcount(struct folio *folio,
 {
 	int mapcount = atomic_read(&page->_mapcount) + 1;
 
-	if (page_mapcount_is_type(mapcount))
-		mapcount = 0;
+	mapcount = page_mapcount_clear_type(mapcount);
 	if (folio_test_large(folio))
 		mapcount += folio_entire_mapcount(folio);
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8260e28205e9..f45064796313 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1865,8 +1865,7 @@ static inline int folio_mapcount(const struct folio *folio)
 
 	if (likely(!folio_test_large(folio))) {
 		mapcount = atomic_read(&folio->_mapcount) + 1;
-		if (page_mapcount_is_type(mapcount))
-			mapcount = 0;
+		mapcount = page_mapcount_clear_type(mapcount);
 		return mapcount;
 	}
 	return folio_large_mapcount(folio);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0e03d816e8b9..f3b0d1fa262d 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -934,9 +934,9 @@ static inline bool page_type_has_type(int page_type)
 }
 
 /* This takes a mapcount which is one more than page->_mapcount */
-static inline bool page_mapcount_is_type(unsigned int mapcount)
+static inline unsigned int page_mapcount_clear_type(unsigned int mapcount)
 {
-	return page_type_has_type(mapcount - 1);
+	return (unsigned int)(((int)(mapcount << 8)) >> 8);
 }
 
 static inline bool page_has_type(const struct page *page)
@@ -953,16 +953,20 @@ static __always_inline void __folio_set_##fname(struct folio *folio)	\
 {									\
 	if (folio_test_##fname(folio))					\
 		return;							\
-	VM_BUG_ON_FOLIO(data_race(folio->page.page_type) != UINT_MAX,	\
+	VM_BUG_ON_FOLIO(page_type_has_type(data_race(folio->page.page_type)), \
 			folio);						\
-	folio->page.page_type = (unsigned int)PGTY_##lname << 24;	\
+	folio->page.page_type &= ~(PGTY_mapcount_underflow << 24);	\
+	folio->page.page_type |= (unsigned int)PGTY_##lname << 24;	\
 }									\
 static __always_inline void __folio_clear_##fname(struct folio *folio)	\
 {									\
-	if (folio->page.page_type == UINT_MAX)				\
+	int mapcount;							\
+									\
+	if (!page_type_has_type(folio->page.page_type))			\
 		return;							\
 	VM_BUG_ON_FOLIO(!folio_test_##fname(folio), folio);		\
-	folio->page.page_type = UINT_MAX;				\
+	mapcount = atomic_read(&folio->page._mapcount);			\
+	folio->page.page_type = page_mapcount_clear_type(mapcount);	\
 }
 
 #define PAGE_TYPE_OPS(uname, lname, fname)				\
@@ -975,15 +979,20 @@ static __always_inline void __SetPage##uname(struct page *page)		\
 {									\
 	if (Page##uname(page))						\
 		return;							\
-	VM_BUG_ON_PAGE(data_race(page->page_type) != UINT_MAX, page);	\
-	page->page_type = (unsigned int)PGTY_##lname << 24;		\
+	VM_BUG_ON_PAGE(page_type_has_type(data_race(page->page_type)),	\
+				page);					\
+	page->page_type &= ~(PGTY_mapcount_underflow << 24);		\
+	page->page_type |= (unsigned int)PGTY_##lname << 24;		\
 }									\
 static __always_inline void __ClearPage##uname(struct page *page)	\
 {									\
-	if (page->page_type == UINT_MAX)				\
+	int mapcount;							\
+									\
+	if (!page_type_has_type(page->page_type))			\
 		return;							\
 	VM_BUG_ON_PAGE(!Page##uname(page), page);			\
-	page->page_type = UINT_MAX;					\
+	mapcount = atomic_read(&page->_mapcount);			\
+	page->page_type = page_mapcount_clear_type(mapcount);		\
 }
 
 /*
diff --git a/mm/debug.c b/mm/debug.c
index 77fa8fe1d641..9a932ded09d4 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -74,8 +74,7 @@ static void __dump_folio(const struct folio *folio, const struct page *page,
 	int mapcount = atomic_read(&page->_mapcount) + 1;
 	char *type = "";
 
-	if (page_mapcount_is_type(mapcount))
-		mapcount = 0;
+	mapcount = page_mapcount_clear_type(mapcount);
 
 	pr_warn("page: refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
 			folio_ref_count(folio), mapcount, mapping,
---

Thoughts?

	Byungchul

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

