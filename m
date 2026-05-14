Return-Path: <linux-rdma+bounces-20672-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OlDJr+NBWpNYgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20672-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 10:54:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1448453F816
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 10:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA1D8301A717
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 08:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772003DDDBA;
	Thu, 14 May 2026 08:54:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E223D7D9A;
	Thu, 14 May 2026 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778748856; cv=none; b=OO9X+3hjgWhc26sSM6Ir+TCnz39o1ShhvfPZBIPWD6ORs+TnAlhCCgIUv3y/sgCJEFuyveDKl4/1yXNEsvo/dSjyyOGc/4sv98jEfLh6YycMPrDAmrjxDYFWynKWnxGGXcHjqXhE4LCxkDJXzGgDJSW8WFxuUDtxX4c9dqfePHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778748856; c=relaxed/simple;
	bh=6IHsZSLzMCg+WQ/Qk+2i/icI7kf53u1QeCeB1gEUvhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tg/ly4MWrBWK7z3ppIvnjA1N5XVIokqune+VcXwjXouGqn3jn+uXa2BsqP0Y0Q8mYSjgqufb9J7JnXcEuVvGbJ59xGCEquS6R04LLHOblmxw4E2JErblcX4wbMLsKFWvIFafY8ORZ1YdNNOsrZY/UhkhM06pNRtsbl3J/sDQPWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-42-6a058dafad9a
Date: Thu, 14 May 2026 17:54:02 +0900
From: Byungchul Park <byungchul@sk.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-mm@kvack.org,
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
Message-ID: <20260514085402.GA63255@system.software.com>
References: <20260224051347.19621-1-byungchul@sk.com>
 <982b9bc1-0a0a-4fc5-8e3a-3672db2b29a1@nvidia.com>
 <4af19eda-c29c-4302-92d5-c0915267fc0c@kernel.org>
 <agRB2QTbzceRgpzX@pedro-suse>
 <1817a749-8232-43ab-a0f5-350e5aade235@kernel.org>
 <f3e38c07-d410-4c8e-a572-68d52dc55353@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3e38c07-d410-4c8e-a572-68d52dc55353@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0yTVxTGd9973z80NLmrIlfIvnTZVNwcI8YcDTNqdHmNczHq1OgHbeQV
	ilBMEQQXQx0kKlp0MDYo1VSZBWsNWoS2BAwDVkBiNBjIKyooGzI3hg5NQ4HAKMbotyfP85zf
	OR+OhHU9fIxkNB1WzCZDml7QEM2/kRc/v27lU+P7/hPBXuMW4Op4DlQ98fEQcg9zYHfVI3gd
	eijCTFMAwau2dgH+aR1DUHkxiMF+t4DAcN0EAn/DMIK/y64JMBQYFOGqZzMMOJ8RaDzhxTB4
	tkMAa8EkhqbQqAg/+KpnwbUWEe7VF/Hw08RlDF7LExHuN9gF6HfP8PCsxUqg03aFwMvSNgwD
	RWsg4FgAwa4RBH9V2UVoq/FyEDxzXoCe8gYO6pp6RCjpdgjwR8EAgu7WQQKlUycFOPl8gEDF
	8SIEk+Oz8NFzr3mo+L1fXBMvH1dVQW4deYHlm1cecHJv2Y9EVm/d5mS/7bEoOzxZcm11nFyo
	dmPZ4zolyJ6xYlF+1NsoyB1lk0T2P10p+32vONmaPypsWbBbk5ikpBmzFfMXq/dpUn5Rm7hD
	16NyTlcOYQt6RAtRhMTocmZ3Wvi3+n7d9KyWJEI/YX1dyWFboIuYqoZwWM+ni5mlroQUIo2E
	aZ/E8ptDJBzMo1vZbVvFXElLgf1a6sfhko5e5pj7VLn4JviQdZb/OTeAaRxTp59z4WWYxrKq
	aSlsR9DVzO2qnONE0Y9Zc307F+Ywmh/Bit0z4ptDF7LfqlVyDlHbe1jbe1jbO6wDYRfSGU3Z
	6QZj2vJlKbkmY86y/RnpHjT7bM5jU3t8aOzethZEJaSP1DYnk1Qdb8jOzE1vQUzC+vnaswGU
	qtMmGXKPKuaMveasNCWzBcVKRB+tTQgeSdLRZMNh5aCiHFLMb1NOioixIGf9qoQhW8JivChx
	5TcfNN4w73KRrEuxtZuXPrXG7Hu4cfd3U5vyqh3+SOOWl+fTx+5s21XoSo7+3uv+bN26DQfO
	lGy64N3vXRt9pzxRd/NozaepEwkjeXk5K/Z27fiKj+r/OWqnaXswvtMXM961hC2MFBovfHs3
	d+N6m/PrwORIsf2jJD3JTDF8GYfNmYb/AbHJpGtoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUhTcRjG+Z//+XK1OC2tk93EIipDS8p4o5DqpkOgfUAFdZErD25+FZuZ
	BtFMo2nNj0rUbYGhpenEmk0307LN/LwoFO1k5XKVZolFijgtyxlRdy/P8/ye9+ZhsaKBCmY1
	ySmiNlmVqKRlpCx6R2ZorZGK3+x7EQaWWisN1dNpUPHOQYHPOkKApaoewaTvNQO/mtsQTLS2
	0/DF/R1B2e0pDJbnWSSM2GcQOBtHEHwurqHhY5uXgWpbFHjuDpPQdKUBgzevgwZj1iyGZt84
	A5cclfPFdXoG3Lc6KXhRn0vBzZk7GBr07xjobbTQMGj9RcGwy0hCp+keCd8KWzF4cndBW+ly
	mOoeQ/CpwsJAa20DAVPXbtHQV9JIgL25j4EbPaU0vM/yIOhxe0ko/GGgwTDqIcGckYtgdnq+
	fDx/kgLzs0FmV7iQIUm04B77ioWH914RQn9xASlIj7sIwWl6ywiltrNCXWWIkCP1YMFWlU0L
	tu/XGeFNfxMtdBTPkoJzaLvgdEwQgjFznD6w4phsZ6yYqEkVtZsiY2TqIqmZOHM/KO1q2Ues
	R2+4HBTA8txWvtc+R+UgliW5tfxAd5xfprl1vCT5sP8O5NbzevsNMgfJWMwNsHxmi4/0G8u4
	Q3yXybwQknPAlxc6sT+k4O4QvDW7hPljLOU7Sz4sAJgL4aW5UcL/DHOr+Io51i8HcJG8taps
	oSeIW8O31LcT+Uhu+o82/Ueb/tGlCFehQE1yapJKkxgRpktQpydr0sJOnU6yofk53b3wo8CB
	Jnv3uhDHIuVieUscGa+gVKm69CQX4lmsDJTntaF4hTxWlX5e1J4+oT2bKOpcaBVLKlfI9x0V
	YxRcnCpFTBDFM6L2r0uwAcF6ZF23dvqgunsmqMvr+mbuiz5cPpbX8qiya2u7frAj43Pokghp
	X9T+vT+L+suNF92GrNUO5RaUlxs8tK3bVr1Bm23e0+5RPh0JX2I4t1L5Mn74mmJgfwosGnuS
	Mj205bK9pt+Qdn1UfTIq+ub5Pu/Go51HYip3F2Wsjwu2RUTsOf7gp5LUqVXhIVirU/0G+OL6
	okoDAAA=
X-CFilter-Loop: Reflected
X-Rspamd-Queue-Id: 1448453F816
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[sk.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20672-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,suse.de,kvack.org,linux-foundation.org,vger.kernel.org,skhynix.com,oracle.com,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	NEURAL_HAM(-0.00)[-0.932];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 02:06:06PM +0200, Dragos Tatulea wrote:
> On 13.05.26 11:36, David Hildenbrand (Arm) wrote:
> > On 5/13/26 11:26, Pedro Falcato wrote:
> >> On Wed, May 13, 2026 at 11:12:43AM +0200, Vlastimil Babka (SUSE) wrote:
> >>> On 5/13/26 11:00, Dragos Tatulea wrote:
> >>>>
> >>>>
> >>>>
> >>>> Seems like this patch broke tcp_mmap because
> >>>> validate_page_before_insert() returns -EINVAL due
> >>>> to a page having a type. Here's the full flow:
> >>>>
> >>>> getsockopt(TCP_ZEROCOPY_RECEIVE) returns -EINVAL because of the
> >>>> below flow in the kernel:
> >>>>
> >>>> tcp_zerocopy_receive()
> >>>> -> tcp_zerocopy_vm_insert_batch()
> >>>>   -> vm_insert_pages()
> >>>>     -> insert_pages()
> >>>>       -> insert_page_in_batch_locked()
> >>>>         -> validate_page_before_insert() returns -EINVAL
> >>>>            because page_has_type(page) is now true.
> >>>>
> >>>> The patch below fixes the issue. But is this a valid fix?
> >>>
> >>> Hmm the check traces back to commit 0ee930e6cafa0 "mm/memory.c: prevent
> >>> mapping typed pages to userspace"
> >>>
> >>>> Pages which use page_type must never be mapped to userspace as it would
> >>>> destroy their page type.  Add an explicit check for this instead of
> >>>> assuming that kernel drivers always get this right.
> >>>
> >>> So uh, this doesn't look good I think.
> >>
> >> Yep, you fundamentally can't map a page with a type as page type aliases with
> >> mapcount. Even with the given diff, just mapping it will increment the mapcount
> >> and wreak havoc. I think we need to revert this patch for now.
> >>
> >> I'm not sure what the long term plan for this would be. If page types are moved
> >> to memdesc types, then the two stop colliding and that could work. I don't know
> >> if that's Willy's plan, however.
> >>
> >> (then there's the other question: are page pool pages really folios? not really.
> >> they are mappable, but they aren't part of the page cache, or anon, nor are
> >> they in the LRU or have rmap capabilities. perhaps we need a different memdesc
> >> for those. we're one step away from reinventing class polymorphism from first
> >> principles ;)
> >
> > Zi Yan is working on this: non-folio pages would no longer mess with
> > rmap/mapcounts, and page table walking code will identify them to be non-folio
> > things to skip them.
> >
> > It will take a while, though ...
> >
> So do I get it right that the path forward here is to revert this commit [1]
> and wait until the work from Zi Yan is ready?

I think it's the best way for now.

	Byungchul
> 
> [1] db359fccf212 ("mm: introduce a new page type for page pool in page type")
> 
> Thanks,
> Dragos

