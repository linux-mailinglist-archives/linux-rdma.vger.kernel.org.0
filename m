Return-Path: <linux-rdma+bounces-20573-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPmVMG9zBGprIQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20573-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 14:49:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D75953352D
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 14:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88B453045A2A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 12:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BC041325E;
	Wed, 13 May 2026 12:39:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598E437D10D;
	Wed, 13 May 2026 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675973; cv=none; b=Q3+9l7tamhwKPRDxhHcmSPKXPm1kmT3Bz74UFd1bE/aDHbVLSfTcSQoD+HfUUMlDnTMrpoorP3WApc5WCjkzKcNF0EKv7j6DAkh+QKegNrXTk9ZZxFh2ZqYwSuA12r/rSgElyetPdG9ZOh9YvZr0msP1GMepewdqaXZWDMma4aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675973; c=relaxed/simple;
	bh=PdyGYPQP1ImdGJSCQNICoCyo8wZngB3yZ78pSY4wDoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIw+h5hjz0CcnMJekI+Y504VSr+zJHuMsrjuRNEIbPsf3/JvKXk99drh6nXg631Zk5/+Yemx96OK8ej8X/w+nygnLEoeESRiHr4VeknyibWfxuFpx2oqOd1PKvJt8fVon1gO+8cWhWtMRNxyDYmZXfmxO/cvW/H0v+P8EPYZKHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-49-6a0470fda551
Date: Wed, 13 May 2026 21:39:20 +0900
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
Message-ID: <20260513123920.GA51788@system.software.com>
References: <20260224051347.19621-1-byungchul@sk.com>
 <982b9bc1-0a0a-4fc5-8e3a-3672db2b29a1@nvidia.com>
 <20260513121805.GA22430@system.software.com>
 <8348d867-f8a1-432c-be2d-699ad96b2e93@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8348d867-f8a1-432c-be2d-699ad96b2e93@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0xTWRSGs3v22edQqTlWxa0ko+loRrwgig/LS5THM0NMdNTE4IM2ciJF
	qNgqUBMNSI1apYoDBktV1BlAZEIs1xJqpGCFggExkHrhIohEETRgKhQCUoiRtz/r/9f/rYfF
	M8p37DJeoz0p6bTqOBWRY/lg4L31kwk4NqzkXxasxUUEHo4mQ353JQtjRf0ysBaWI/g29oaD
	KYcLwUjdMwIDtcMI7t/1MmBtNmLoL/MhsFf1I/iU/T+BPlcPBw9tu6Ar7wOG6gsVDPRcrSeQ
	bhxnwDE2xMG5yoLp4pIUDlrKzSxk+v5joCKlm4OXVVYCnUVTLHxwpmNosDzA8DWrjoEucwS4
	coPA2/gZQV1xhQy8V24RaLtZJYMyRxsH/7TmEug1diFore3BkDVxkUBOqhnB+Oh05dC1byzk
	PO3kIkLFVI+HiLWfvzBi6YNXMrE9OwOLnsdumWi3dHBiru2UWFKwRjR5WhnRVniJiLbh65z4
	tr2aiPXZ41i0v9si2itHZGJ62hDZvThKvj1aitMkSroNOw7LY15m2NiEgT+TfRkOnIK+hplQ
	AE+FzdSX8Z01IX5GGz9F+CUWVtHS6t3+BBH+oB7PGOPXi4Qw2l9/TmZCcp4RJjk6+tyB/cZC
	4W/qtuTMhBQC0DaXk/GHlEITouVOKztrLKANN9/PLDDCOmove0v8MEYIpvmT/Ox4OU0r8/fw
	fICwg14vDvePFwu/0yflz2a4VEgLoD1mE5k9fymtKfDga2iBZQ7BModg+UWwzCHkIlyIlBpt
	YrxaE7c5NMag1SSHHjkeb0PTj5d3ZuJgJRpu2etEAo9UgYonR3GsklUn6g3xTkR5RrVIcdWF
	YpWKaLXhtKQ7fkh3Kk7SO1Ewj1VLFJu8SdFK4aj6pHRMkhIk3U9XxgcsS0GX8zq08qisRytu
	aA71rTRkquZ5QwyT3r5t0lqfdn7pb1O9Ies27mHI8sEYi5GWFkQGNofGdrcsPbj6cFAR8o34
	GuvDw4zutMzI3ibNi5H2/eYTOyP3BzWGFL7eF60/nxR+9sTZv553RuV/rBloPnBbOxU8UZvc
	7E597K67s3WwZkKF9THqjWsYnV79AyhlwXh0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRzF+d23w8VtmV00CmYPkpaaRt9IRCLoFhRS0JOoUbeczTU2Mw0C
	00U18jFNsbnCiMrUkmY+tlzEZkstsSbqIlNb5cJETcWcluaMyP8O55zv5/vPYXCJgwxhFKoU
	QaOSK6WUiBDt2Zol+60mkiJnnqwDU1UlBRWTafCgr54EX6UXA1N5LYJx3wcaZm1OBGONryj4
	7hhFcPfOBA6mNh0B3popBBarF8FA8SMKvjo9NFSYd0Pv/X4CGq7U4eDJbaIgWzeNg803RENm
	fdkcuDqDBsetZhLe1uaQcGPqHg51GX00tFtNFPRUzpLQb88moNn4kICRwkYcenPiwVkaDBOv
	BxE0VtVhMHH9FgUdN60Y1Ng6aChwlVLwWdeLwOXwEFD46yoFJZdyEExPziGH8sZJKHnZQ8dH
	8Jfcbop3DA7j/NOH7zG+s9hA8O7nLRhvMX6k+VLzOb66LJzXu104by6/RvHm0Xya7+5soPim
	4mmCt3zawlvqxzA+O2uISgg+LIo9KSgVqYImIu64KLHdYCbV33emTRlsRAYaidQjhuHYGE43
	EO+XBLuae9qQoEcBDMWu5dxuH+7XQWwk523KxPRIxODsDM1NttoIf7CE3cu1GEvmS2IWuA6n
	HfeXJOwbxNXaTeTfYDHXfPPL/AHOrucsNd2U/xnOhnIPZpi/9kouq8bPYZgANo7Lr4r220vZ
	MO5F7SssDy0yLgAZF4CM/0HGBaBSRJSjIIUqNVmuUG7aoD2TmK5SpG04cTbZjOamdf/iL0M9
	Gm/fYUcsg6SB4heniSQJKU/VpifbEcfg0iBxrhMlScQn5ekXBM3ZY5pzSkFrR6EMIV0m3nVA
	OC5hT8tThDOCoBY0/1KMCQjJQLHBUY2XpS0HPQb1wL6eZ98Mp1rDut7t73zedUP5ybNtdEVb
	xd4TISnRrpfXf1q2J6xPKDja1eJmz+9ZfqgtZtVm4ejByrTHeY7qZnWgTLasbMXuNr24Ol+W
	XaBq/fFlTZRBd7io6LM3MGidzhfx7VRTbNGR4cx+q/r2xrF8V1fs4nApoU2UR4XjGq38D+Vw
	AQZWAwAA
X-CFilter-Loop: Reflected
X-Rspamd-Queue-Id: 8D75953352D
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
	TAGGED_FROM(0.00)[bounces-20573-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,kvack.org,linux-foundation.org,vger.kernel.org,skhynix.com,oracle.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,lunn.ch,google.com,redhat.com,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	NEURAL_HAM(-0.00)[-0.954];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:email,sk.com:email,system.software.com:mid,nvidia.com:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 02:29:46PM +0200, David Hildenbrand (Arm) wrote:
 On 5/13/26 14:18, Byungchul Park wrote:
> > On Wed, May 13, 2026 at 11:00:51AM +0200, Dragos Tatulea wrote:
> >> On 24.02.26 06:13, Byungchul Park wrote:
> >>> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> >>> determine if a page belongs to a page pool.  However, with the planned
> >>> removal of @pp_magic, we should instead leverage the page_type in struct
> >>> page, such as PGTY_netpp, for this purpose.
> >>>
> >>> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> >>> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> >>> @pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> >>> netmem_clear_pp_magic().
> >>>
> >>> Plus, add @page_type to struct net_iov at the same offset as struct page
> >>> so as to use the page_type APIs for struct net_iov as well.  While at it,
> >>> reorder @type and @owner in struct net_iov to avoid a hole and
> >>> increasing the struct size.
> >>>
> >>> This work was inspired by the following link:
> >>>
> >>>   https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> >>>
> >>> While at it, move the sanity check for page pool to on the free path.
> >>>
> >>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>> Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
> >>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >>> Signed-off-by: Byungchul Park <byungchul@sk.com>
> >>> Acked-by: David Hildenbrand <david@redhat.com>
> >>> Acked-by: Zi Yan <ziy@nvidia.com>
> >>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> >>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> >>> ---
> >>
> >> Seems like this patch broke tcp_mmap because
> >> validate_page_before_insert() returns -EINVAL due
> >> to a page having a type. Here's the full flow:
> >>
> >> getsockopt(TCP_ZEROCOPY_RECEIVE) returns -EINVAL because of the
> >> below flow in the kernel:
> >>
> >> tcp_zerocopy_receive()
> >> -> tcp_zerocopy_vm_insert_batch()
> >>   -> vm_insert_pages()
> >>     -> insert_pages()
> >>       -> insert_page_in_batch_locked()
> >>         -> validate_page_before_insert() returns -EINVAL
> >>            because page_has_type(page) is now true.
> >>
> >> The patch below fixes the issue. But is this a valid fix?
> >
> > Hi,
> >
> > The problem comes from the fact that page_type and _mapcount are
> > union'ed but there is a case where these two information should be kept
> > at the same time.
> >
> > Why don't we allow these two information can be kept in the 4 bytes at
> > the same time until Zi Yan's work on _mapcount and page_type will be
> > done, instead of taking a step back?
> >
> > It can be more optimized but I suggest the approach I just mentioned:
> > ---
> > diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> > index 64dc44832808..e5ec204866dc 100644
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -185,8 +185,7 @@ static inline int folio_precise_page_mapcount(struct folio *folio,
> >  {
> >       int mapcount = atomic_read(&page->_mapcount) + 1;
> >
> > -     if (page_mapcount_is_type(mapcount))
> > -             mapcount = 0;
> > +     mapcount = page_mapcount_clear_type(mapcount);
> >       if (folio_test_large(folio))
> >               mapcount += folio_entire_mapcount(folio);
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 8260e28205e9..f45064796313 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1865,8 +1865,7 @@ static inline int folio_mapcount(const struct folio *folio)
> >
> >       if (likely(!folio_test_large(folio))) {
> >               mapcount = atomic_read(&folio->_mapcount) + 1;
> > -             if (page_mapcount_is_type(mapcount))
> > -                     mapcount = 0;
> > +             mapcount = page_mapcount_clear_type(mapcount);
> >               return mapcount;
> >       }
> >       return folio_large_mapcount(folio);
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 0e03d816e8b9..f3b0d1fa262d 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -934,9 +934,9 @@ static inline bool page_type_has_type(int page_type)
> >  }
> >
> >  /* This takes a mapcount which is one more than page->_mapcount */
> > -static inline bool page_mapcount_is_type(unsigned int mapcount)
> > +static inline unsigned int page_mapcount_clear_type(unsigned int mapcount)
> >  {
> > -     return page_type_has_type(mapcount - 1);
> > +     return (unsigned int)(((int)(mapcount << 8)) >> 8);
> >  }
> >
> >  static inline bool page_has_type(const struct page *page)
> > @@ -953,16 +953,20 @@ static __always_inline void __folio_set_##fname(struct folio *folio)    \
> >  {                                                                    \
> >       if (folio_test_##fname(folio))                                  \
> >               return;                                                 \
> > -     VM_BUG_ON_FOLIO(data_race(folio->page.page_type) != UINT_MAX,   \
> > +     VM_BUG_ON_FOLIO(page_type_has_type(data_race(folio->page.page_type)), \
> >                       folio);                                         \
> > -     folio->page.page_type = (unsigned int)PGTY_##lname << 24;       \
> > +     folio->page.page_type &= ~(PGTY_mapcount_underflow << 24);      \
> > +     folio->page.page_type |= (unsigned int)PGTY_##lname << 24;      \
> >  }                                                                    \
> >  static __always_inline void __folio_clear_##fname(struct folio *folio)       \
> >  {                                                                    \
> > -     if (folio->page.page_type == UINT_MAX)                          \
> > +     int mapcount;                                                   \
> > +                                                                     \
> > +     if (!page_type_has_type(folio->page.page_type))                 \
> >               return;                                                 \
> >       VM_BUG_ON_FOLIO(!folio_test_##fname(folio), folio);             \
> > -     folio->page.page_type = UINT_MAX;                               \
> > +     mapcount = atomic_read(&folio->page._mapcount);                 \
> > +     folio->page.page_type = page_mapcount_clear_type(mapcount);     \
> >  }
> >
> >  #define PAGE_TYPE_OPS(uname, lname, fname)                           \
> > @@ -975,15 +979,20 @@ static __always_inline void __SetPage##uname(struct page *page)         \
> >  {                                                                    \
> >       if (Page##uname(page))                                          \
> >               return;                                                 \
> > -     VM_BUG_ON_PAGE(data_race(page->page_type) != UINT_MAX, page);   \
> > -     page->page_type = (unsigned int)PGTY_##lname << 24;             \
> > +     VM_BUG_ON_PAGE(page_type_has_type(data_race(page->page_type)),  \
> > +                             page);                                  \
> > +     page->page_type &= ~(PGTY_mapcount_underflow << 24);            \
> > +     page->page_type |= (unsigned int)PGTY_##lname << 24;            \
> >  }                                                                    \
> >  static __always_inline void __ClearPage##uname(struct page *page)    \
> >  {                                                                    \
> > -     if (page->page_type == UINT_MAX)                                \
> > +     int mapcount;                                                   \
> > +                                                                     \
> > +     if (!page_type_has_type(page->page_type))                       \
> >               return;                                                 \
> >       VM_BUG_ON_PAGE(!Page##uname(page), page);                       \
> > -     page->page_type = UINT_MAX;                                     \
> > +     mapcount = atomic_read(&page->_mapcount);                       \
> > +     page->page_type = page_mapcount_clear_type(mapcount);           \
> >  }
> >
> >  /*
> > diff --git a/mm/debug.c b/mm/debug.c
> > index 77fa8fe1d641..9a932ded09d4 100644
> > --- a/mm/debug.c
> > +++ b/mm/debug.c
> > @@ -74,8 +74,7 @@ static void __dump_folio(const struct folio *folio, const struct page *page,
> >       int mapcount = atomic_read(&page->_mapcount) + 1;
> >       char *type = "";
> >
> > -     if (page_mapcount_is_type(mapcount))
> > -             mapcount = 0;
> > +     mapcount = page_mapcount_clear_type(mapcount);
> >
> >       pr_warn("page: refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
> >                       folio_ref_count(folio), mapcount, mapping,
> > ---
> >
> > Thoughts?
> 
> God no.

This is not final patch, but for sharing the rough idea *with code* -
maybe there are more points in code that should be adjusted by the
change.  I just typed the draft patch quick just for sharing idea.

If we should allow pp type pages to be used in mapping as well, then
we should allow a page to keep both its type and mapcount at the same
time.  Am I missing something?

	Byungchul

> --
> Cheers,
> 
> David

