Return-Path: <linux-rdma+bounces-20576-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPXyEOWCBGrVKwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20576-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 15:55:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCABD53477E
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 15:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76E9B30D0A0A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 13:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5C6317144;
	Wed, 13 May 2026 13:26:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD9930B514;
	Wed, 13 May 2026 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778678813; cv=none; b=tLqOo8wiQ+m/X5ewG178D2axMGezROlh2NZh5slUzEGt5WrAGniPOQrxlmnVAoI/D+yDcsaGcyy0LVx62gx81w/mrE+CBaVn8YoLS5aMHKdH2w+AGlPAhdHosDkI7yjGo/7n1Jxc8QfSPfuMdWjc525K9aI1/XGkXZW7TsH8qE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778678813; c=relaxed/simple;
	bh=iRGayRoSAdq9Uxku2Vhbo3Nh1ue48DOhaPMog5G79xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPMkdYwSDTdMpixJjkUPIfo0SigjydRC5PwBODoq+TDXsxut7GO2h1uLk9crV6LXhFAf7hk3qA0ZLLrqppC7A145af4Znrw3x+dzDL5uU/yqLk9/POafCJPi69/3TkE6sG3fB06dd/nnVKwefRJLJyIm5QN0n+msHf1FI/tphKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-29-6a047c1158fa
Date: Wed, 13 May 2026 22:26:36 +0900
From: Byungchul Park <byungchul@sk.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
	sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com
Subject: Re: [PATCH v4] mm: introduce a new page type for page pool in page
 type
Message-ID: <20260513132636.GA75142@system.software.com>
References: <20260224051347.19621-1-byungchul@sk.com>
 <982b9bc1-0a0a-4fc5-8e3a-3672db2b29a1@nvidia.com>
 <20260513121805.GA22430@system.software.com>
 <8348d867-f8a1-432c-be2d-699ad96b2e93@kernel.org>
 <20260513123920.GA51788@system.software.com>
 <627bb280-be44-4648-8771-5a479cda988f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <627bb280-be44-4648-8771-5a479cda988f@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec95d85xtTiurDeFgkkYQnYTeoIYEn04EYOyIiiiVh50piu2
	Mg0jLSmN1O7ptshWzttKWDndaqFO5zIiXSTrqi5TulleGJphzUXUtx//5//8nvfDy9HyJ5Jo
	TqM9LOq06gwFI8XSr7PNyyJzcfqK5zUKMNVbGaibyIaqviYJTFqHKDDV2hGMT75m4ZfLg2Cs
	rYOBz+5RBLduBmkwPSvAMNTwA4HDOYTgU9kdBj54AizU2VTQaxnE8PBMIw2BUi8DxQVTNLgm
	h1k42VQdEt/LY6HLXiKByz8qaWjM62PhudPEwDvrLwkMthZjeGyowfD9ShsNvSVJ4KmYD8En
	XxC01TdSEDx3nYEX5U4KGlwvWLjkq2DgfUEvAp87gOHKz0IGjPklCKYmQsrh8+MSMLa/Y5MS
	hHy/nxHcX77Rwv2al5TQU3YBC/5HnZTgMLxlhQrbEeFedbxw1u+jBVttESPYRi+ywpueh4zg
	LZvCgqN/reBoGqOE4lPDzOaondJ1KWKGJkvULVfulaY9spipQ6eV2Z1j/TgPOeLOogiO8InE
	lO+h/vJA9216hjG/hAyYRtAMM3wc8fsnw/k8fgUZ8p4M9aUczU+zZOKpC88M5vLJpNNgDJdk
	PJBmY3mY5Xw9RT63pP/JI8nj8oFwn+bjiX/6Y0jEhTiGVE1zM3EErySvem6EV6P4WNJs7wjf
	Ivw4R8zfnfSfhy4kLdV+fB7xhv+0hv+0hn/aCkTXIrlGm5Wp1mQkJqTlaDXZCfsPZtpQ6ItZ
	jv/c1YRGu7a2Ip5Ditmy5lScLpeos/Q5ma2IcLRinqzUg9LlshR1zjFRd3CP7kiGqG9FMRxW
	LJCtCh5NkfOp6sPiAVE8JOr+TikuIjoPqRbMyV2cdHXu9bvKRetTa1T9kRarPaXScsEYm9hd
	vTE57pq5aveG1VtKC7/Fd5ZudTQUubHdXvRhh3m971Zgls5mmfi6r8/aMeKM9SW7tyuXKlWD
	+faNceXnoscUvpZK8YHXe7pbtS1XG6N/8PFE9qLAplftnwbaXUHvGplmpFCB9WnqlfG0Tq/+
	Df11sd1eAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG/Z9zds7ZanBcy/4k9GEVoqFWFLxRSJcPHboRfREqyJWHtuVM
	NhXtQqvZTdIyE+ZctG7zkiLMvExUbJqpFZqlLSunZo20zJqZU7HmIvLbj+d9fs+nlyVlZaKl
	rDoxWdAlKhMUtISS7NlojAw+RWlWu/sWgKW8lIYHk2lQ2F8jAl+phwBLSRWCcd9bBn7XtyDw
	Nj+hYaTpB4K7tydIsHRkUOCpnELgqPUgGDaV0fCxZZCBB/bd4LZ9oqDuYjUJg1dbacjKmCah
	3jfKwLmaIv9whYGBppttIuisyhbBjan7JFQb+hl4WWuhoa/0twg+ObMoaDMXUzCW10yCO3sz
	tFhDYOLpFwTN5dUETFy5SUN3fi0BlfXdDOR2WWn4kOFG0NU0SEHezCUaCs5mI5ie9E+OXhsX
	QcHjPmZzNH/W5aL5pi/fSP5h8RuC7zHlULyroZ3gHeb3DG+1p/AVRRF8pquL5O0ll2ne/uM6
	w7/rqaP5VtM0xTsGNvCOGi/BZxlH6b0h+yWb4oUEdaqgi46Jk6gabHeIpAsxae3eAcqAHGGZ
	SMxibh0eenGPnGOKW4mHLN/RHNNcGHa5fIFczq3GntZzRCaSsCQ3y+DJ5/XU3GERtw+3mwsC
	JSkHuLEgP8AyrpzAI480f/Ng3JY/FOiTXAR2zX72D7F+DsWFs+xcLOZicG/PrYC6mFuOG6ue
	ENeQ1DzPNs+zzf9tKyJLkFydmKpVqhPWR+mPqdIT1WlRR45r7cj/RLbTMzk1aPzldifiWKRY
	KG08SmlkImWqPl3rRJglFXLp1RakkUnjleknBN3xQ7qUBEHvRKEspVgi3RErxMm4o8pk4Zgg
	JAm6f1eCFS81oFxPbMOSrae7c26HqLS/Lgyd12wz9B5hFcs25q0yacUnx8TiEz+He1/VbY/s
	2GIJGvC+XuuNNh6IQp2thGMqzqd6ujOoy/r1W/zHr1u4FWd2Te++aCf3vM81H37mxG/aHqYf
	9GUbP9tCO2ZMt+RSOXdl3Yr1eWkhxvD89vAi90msoPQq5ZoIUqdX/gGv6fkZQAMAAA==
X-CFilter-Loop: Reflected
X-Rspamd-Queue-Id: DCABD53477E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[sk.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20576-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,kvack.org,linux-foundation.org,vger.kernel.org,skhynix.com,oracle.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,lunn.ch,google.com,redhat.com,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	NEURAL_HAM(-0.00)[-0.889];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,system.software.com:mid]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 03:02:43PM +0200, David Hildenbrand (Arm) wrote:
> On 5/13/26 14:39, Byungchul Park wrote:
> > On Wed, May 13, 2026 at 02:29:46PM +0200, David Hildenbrand (Arm) wrote:
> >  On 5/13/26 14:18, Byungchul Park wrote:
> >>>
> >>> Hi,
> >>>
> >>> The problem comes from the fact that page_type and _mapcount are
> >>> union'ed but there is a case where these two information should be kept
> >>> at the same time.
> >>>
> >>> Why don't we allow these two information can be kept in the 4 bytes at
> >>> the same time until Zi Yan's work on _mapcount and page_type will be
> >>> done, instead of taking a step back?
> >>>
> >>> It can be more optimized but I suggest the approach I just mentioned:
> >>> ---
> >>> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> >>> index 64dc44832808..e5ec204866dc 100644
> >>> --- a/fs/proc/internal.h
> >>> +++ b/fs/proc/internal.h
> >>> @@ -185,8 +185,7 @@ static inline int folio_precise_page_mapcount(struct folio *folio,
> >>>  {
> >>>       int mapcount = atomic_read(&page->_mapcount) + 1;
> >>>
> >>> -     if (page_mapcount_is_type(mapcount))
> >>> -             mapcount = 0;
> >>> +     mapcount = page_mapcount_clear_type(mapcount);
> >>>       if (folio_test_large(folio))
> >>>               mapcount += folio_entire_mapcount(folio);
> >>>
> >>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >>> index 8260e28205e9..f45064796313 100644
> >>> --- a/include/linux/mm.h
> >>> +++ b/include/linux/mm.h
> >>> @@ -1865,8 +1865,7 @@ static inline int folio_mapcount(const struct folio *folio)
> >>>
> >>>       if (likely(!folio_test_large(folio))) {
> >>>               mapcount = atomic_read(&folio->_mapcount) + 1;
> >>> -             if (page_mapcount_is_type(mapcount))
> >>> -                     mapcount = 0;
> >>> +             mapcount = page_mapcount_clear_type(mapcount);
> >>>               return mapcount;
> >>>       }
> >>>       return folio_large_mapcount(folio);
> >>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> >>> index 0e03d816e8b9..f3b0d1fa262d 100644
> >>> --- a/include/linux/page-flags.h
> >>> +++ b/include/linux/page-flags.h
> >>> @@ -934,9 +934,9 @@ static inline bool page_type_has_type(int page_type)
> >>>  }
> >>>
> >>>  /* This takes a mapcount which is one more than page->_mapcount */
> >>> -static inline bool page_mapcount_is_type(unsigned int mapcount)
> >>> +static inline unsigned int page_mapcount_clear_type(unsigned int mapcount)
> >>>  {
> >>> -     return page_type_has_type(mapcount - 1);
> >>> +     return (unsigned int)(((int)(mapcount << 8)) >> 8);
> >>>  }
> >>>
> >>>  static inline bool page_has_type(const struct page *page)
> >>> @@ -953,16 +953,20 @@ static __always_inline void __folio_set_##fname(struct folio *folio)    \
> >>>  {                                                                    \
> >>>       if (folio_test_##fname(folio))                                  \
> >>>               return;                                                 \
> >>> -     VM_BUG_ON_FOLIO(data_race(folio->page.page_type) != UINT_MAX,   \
> >>> +     VM_BUG_ON_FOLIO(page_type_has_type(data_race(folio->page.page_type)), \
> >>>                       folio);                                         \
> >>> -     folio->page.page_type = (unsigned int)PGTY_##lname << 24;       \
> >>> +     folio->page.page_type &= ~(PGTY_mapcount_underflow << 24);      \
> >>> +     folio->page.page_type |= (unsigned int)PGTY_##lname << 24;      \
> >>>  }                                                                    \
> >>>  static __always_inline void __folio_clear_##fname(struct folio *folio)       \
> >>>  {                                                                    \
> >>> -     if (folio->page.page_type == UINT_MAX)                          \
> >>> +     int mapcount;                                                   \
> >>> +                                                                     \
> >>> +     if (!page_type_has_type(folio->page.page_type))                 \
> >>>               return;                                                 \
> >>>       VM_BUG_ON_FOLIO(!folio_test_##fname(folio), folio);             \
> >>> -     folio->page.page_type = UINT_MAX;                               \
> >>> +     mapcount = atomic_read(&folio->page._mapcount);                 \
> >>> +     folio->page.page_type = page_mapcount_clear_type(mapcount);     \
> >>>  }
> >>>
> >>>  #define PAGE_TYPE_OPS(uname, lname, fname)                           \
> >>> @@ -975,15 +979,20 @@ static __always_inline void __SetPage##uname(struct page *page)         \
> >>>  {                                                                    \
> >>>       if (Page##uname(page))                                          \
> >>>               return;                                                 \
> >>> -     VM_BUG_ON_PAGE(data_race(page->page_type) != UINT_MAX, page);   \
> >>> -     page->page_type = (unsigned int)PGTY_##lname << 24;             \
> >>> +     VM_BUG_ON_PAGE(page_type_has_type(data_race(page->page_type)),  \
> >>> +                             page);                                  \
> >>> +     page->page_type &= ~(PGTY_mapcount_underflow << 24);            \
> >>> +     page->page_type |= (unsigned int)PGTY_##lname << 24;            \
> >>>  }                                                                    \
> >>>  static __always_inline void __ClearPage##uname(struct page *page)    \
> >>>  {                                                                    \
> >>> -     if (page->page_type == UINT_MAX)                                \
> >>> +     int mapcount;                                                   \
> >>> +                                                                     \
> >>> +     if (!page_type_has_type(page->page_type))                       \
> >>>               return;                                                 \
> >>>       VM_BUG_ON_PAGE(!Page##uname(page), page);                       \
> >>> -     page->page_type = UINT_MAX;                                     \
> >>> +     mapcount = atomic_read(&page->_mapcount);                       \
> >>> +     page->page_type = page_mapcount_clear_type(mapcount);           \
> >>>  }
> >>>
> >>>  /*
> >>> diff --git a/mm/debug.c b/mm/debug.c
> >>> index 77fa8fe1d641..9a932ded09d4 100644
> >>> --- a/mm/debug.c
> >>> +++ b/mm/debug.c
> >>> @@ -74,8 +74,7 @@ static void __dump_folio(const struct folio *folio, const struct page *page,
> >>>       int mapcount = atomic_read(&page->_mapcount) + 1;
> >>>       char *type = "";
> >>>
> >>> -     if (page_mapcount_is_type(mapcount))
> >>> -             mapcount = 0;
> >>> +     mapcount = page_mapcount_clear_type(mapcount);
> >>>
> >>>       pr_warn("page: refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
> >>>                       folio_ref_count(folio), mapcount, mapping,
> >>> ---
> >>>
> >>> Thoughts?
> >>
> >> God no.
> >
> > This is not final patch, but for sharing the rough idea *with code* -
> > maybe there are more points in code that should be adjusted by the
> > change.  I just typed the draft patch quick just for sharing idea.
> >
> > If we should allow pp type pages to be used in mapping as well, then
> > we should allow a page to keep both its type and mapcount at the same
> > time.  Am I missing something?
> 
> We don't want code to accidentally overflow mapcounts into these bits and have
> them wrongly be detected as page types.
> 
> This is just very fragile.

Okay.  Thanks for the explanation.  Plus, the adjustment I mentioned
might not be as simple as I thought it'd be.

So sorry about the noise.  I'm a zombie now.  I'll think about it after
some rest.

	Byungchul

> --
> Cheers,
> 
> David

