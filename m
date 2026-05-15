Return-Path: <linux-rdma+bounces-20740-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CkqJHViBmpUjQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20740-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 02:01:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C67547E4A
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 02:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF11F302D187
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 00:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC20D3A8F7;
	Fri, 15 May 2026 00:01:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D711E511;
	Fri, 15 May 2026 00:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778803307; cv=none; b=i3/kUbQH/SaRIRIToFV3qohd/f96FN+5FlCJcuPOPntZqrNXGbAojrQ/x4WCQRW+/kTnVXR1G0l6ZKZd9JTMY1EcPk+BJlp4DB8Xkz/4AZSUJ/wJbtsJnvWULOni2HR3zyNkpFRsupbpyXO28qVkMnLR+pkcTdtquedb4aNtjc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778803307; c=relaxed/simple;
	bh=tdH1VrcQncwA79cpJHv5nqOIrihe48zQtl+e4GgZTC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arfJvm3GH8FOvUQ/L4X3BeiRknUibCoK76buQ+kk0zTWP3tZT+ku5QkD9ILZa04vVx2unPc8fxqYV5rmneFqlHruNfb3rdmtmUtm4nxqI87/ZyxmkVEsDkKwF6FUyHfl3byqnaM7P1luAzKPDDsXi+xHdAdXVjY8JFGjaDJpKT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-85-6a06625d2aa3
Date: Fri, 15 May 2026 09:01:28 +0900
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
Message-ID: <20260515000128.GA7850@system.software.com>
References: <20260224051347.19621-1-byungchul@sk.com>
 <982b9bc1-0a0a-4fc5-8e3a-3672db2b29a1@nvidia.com>
 <4af19eda-c29c-4302-92d5-c0915267fc0c@kernel.org>
 <agRB2QTbzceRgpzX@pedro-suse>
 <1817a749-8232-43ab-a0f5-350e5aade235@kernel.org>
 <f3e38c07-d410-4c8e-a572-68d52dc55353@nvidia.com>
 <20260514085402.GA63255@system.software.com>
 <f4f5e3b2-64c4-4ad2-8678-d29ae08150e6@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f5e3b2-64c4-4ad2-8678-d29ae08150e6@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTZxTH87zPe6Pa7LE4eabZsnSbGiIMicazbN6yLHmzZRm6L8u8bNW+
	kSKt2ioDki1lNhGZXKYjgVIXUG4CprFIoVUMAgNh3lIDeTetRRx2boiGkoZSFFuM0W+//M//
	/HI+HBFrhrmlosF0UDabdNlaXsWqHi2sSdmxi89KqwungcPZwkPzdC40jHRwEGkJMuBociOY
	itwWYK6zD0Got5+H/3smEZyuCWNw3LCxEGybQeDxBhH8V3GWh7G+UQGaXV9CoP4BCxePtGMY
	Lb3CQ7EtiqEzMiHAzx2NMXGrVYCb7hIOfpupw9BuHRHgltfBw92WOQ4edBezMGA/w8KT8l4M
	gZJN0Fe9BMJ/jiP4t8EhQK+znYHwsZM8DFV6GWjrHBLghK+ah/u2AAJfzygL5bOFPBQ+DLBQ
	VVCCIDodk0+UTXFQ9cddYVOaVKAovNQz/hhL58/8xUjDFb+yknJpkJE8dr8gVbsOSa2NyVKR
	4sOSq+koL7kmjwvSneGLvHSlIspKnnsfSZ6OECMVH57gM5Z8q/pEL2cbcmTzhxu+V2Weq7ei
	/QNJuX5nGW9FvZoilCBSsobOzvSzL3la8QlxZskH9E5jLY4zT1ZQRYnM82KyklrbTsT6KhGT
	v0V6uCsyv5xIttJBe9V8SU3W0QvjzVy8pCGFmPpDp7gXg0V0oPKf+QVMkqny7CFThMQYL6MN
	z8R4nEA20Ee3/SjOb5L3aJe7n4l7KJkT6ZwtKry49C16uVFhyxCxv6a1v6a1v9JWI9yENAZT
	jlFnyF6TmplnMuSm7t5ndKHYt9X/OLutA03e/LobERFpF6q/uc5laThdjiXP2I2oiLWL1SkX
	YpFar8vLl837vjMfypYt3WiZyGqT1OnhH/Qaskd3UN4ry/tl88spIyYstSJbILOFrPUf/+Lj
	2vMNiZ6CdOwevBrYbGxFTaYtTmNQn+Z7sv3AUzfJq83oGlv12VhFxvDy6E+fZyw6tUWt90Z2
	4t9L16cn3b9xtXxk8peU6Kf5pVTDORPfrtyoCV0LdW1fUJcfvPXOV5aaobMk8Wjw/Tey1voe
	e72Vuy+vTH13SqtlLZm61cnYbNE9BxRLiQppAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z+7q8FxmZ6Uvqy70sUoersQfig6BIUZFYRdVp5ytk3b1DQI
	Vg4ySbPsonPS8u40rJm6eYnSpa0LhVasbM6snJZppJhrUm1G1Lcfz/P83k8vg0ssZCgjVyUL
	apVMIaVEhGj7+oyl+w5RCStuuYLAUFtDQfVkGlT0WUjw1LgxMJgaEIx7emj41dqBYMzWScHn
	9m8ISm5M4GB4piPAXf8DgbXJjeBT/k0KPnb001Bt3gau8gECWs424tB/4SEF2TovDq2eERrO
	WCp9h+u0NLQX2Ul43pBDwuUfZTg0avto6G4yUNBb84uEgbZsAuz6KgK+XrHh4MqJgg5jMEw8
	HkYwWGGgwVbbiMHE+SIKXhY0YVDf+pKGvC4jBe91LgRd7f0EXJnKpCBzyEVA4ekcBN5J3/GR
	3HESCh/00lGR/GmHg+Lbh0dx/k7Va4x/lX+R4B13H2G8Ve+keaM5ha+rDOezHF04bzado3jz
	t0s0//ZVC8U/zPcSvPXdWt5qGcP47IwRKjpkr2hDnKCQpwrq5RsPiuJvl2tRkj0kzVmbS2mR
	TZKFAhiOXcVNOrpoPxPsAu5tZSnuZ4pdxDkcnmkOYhdz2vo8IguJGJx9w3AZ9zyEv5jFxnCP
	9IXTIzG7hmserib9IwmbiXPOsWLyTxHI2Qs+TAs4G845fg5hWYjxcRhX8ZPxxwHsRu5LjxP5
	eTY7j7vX0InlIrH+P1v/n63/ZxsRbkJBclWqUiZXrF6mORafrpKnLTucqDQj3z+Vn5q6aEHj
	3VvaEMsg6UxxdCeZICFlqZp0ZRviGFwaJF7a7IvEcbL0k4I68YA6RSFo2lAYQ0hDxFv3CAcl
	7FFZsnBMEJIE9d8WYwJCtehsxtzBncL+k7HBuvIhVawy4uuQtRJGtbcu9LQMOJ+aUkwfBicf
	zzrqtiTtQcb1R0I/6d4Heq957+8qch76Pidl890Z6zZ1KJ8kR9m04UXYytj5sbqIPP3eEyVJ
	L9xL7FV97lJRd8vqqbLr2+uOx1wtPtUf17uweUdE82I4sDsyrFRKaOJlkeG4WiP7DVpNal5L
	AwAA
X-CFilter-Loop: Reflected
X-Rspamd-Queue-Id: 11C67547E4A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[sk.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20740-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,suse.de,kvack.org,linux-foundation.org,vger.kernel.org,skhynix.com,oracle.com,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	NEURAL_HAM(-0.00)[-0.934];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[system.software.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 11:24:36AM +0200, Dragos Tatulea wrote:
> On 14.05.26 10:54, Byungchul Park wrote:
> > On Wed, May 13, 2026 at 02:06:06PM +0200, Dragos Tatulea wrote:
> >> On 13.05.26 11:36, David Hildenbrand (Arm) wrote:
> >>> On 5/13/26 11:26, Pedro Falcato wrote:
> >>>> On Wed, May 13, 2026 at 11:12:43AM +0200, Vlastimil Babka (SUSE) wrote:
> >>>>> On 5/13/26 11:00, Dragos Tatulea wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> Seems like this patch broke tcp_mmap because
> >>>>>> validate_page_before_insert() returns -EINVAL due
> >>>>>> to a page having a type. Here's the full flow:
> >>>>>>
> >>>>>> getsockopt(TCP_ZEROCOPY_RECEIVE) returns -EINVAL because of the
> >>>>>> below flow in the kernel:
> >>>>>>
> >>>>>> tcp_zerocopy_receive()
> >>>>>> -> tcp_zerocopy_vm_insert_batch()
> >>>>>>   -> vm_insert_pages()
> >>>>>>     -> insert_pages()
> >>>>>>       -> insert_page_in_batch_locked()
> >>>>>>         -> validate_page_before_insert() returns -EINVAL
> >>>>>>            because page_has_type(page) is now true.
> >>>>>>
> >>>>>> The patch below fixes the issue. But is this a valid fix?
> >>>>>
> >>>>> Hmm the check traces back to commit 0ee930e6cafa0 "mm/memory.c: prevent
> >>>>> mapping typed pages to userspace"
> >>>>>
> >>>>>> Pages which use page_type must never be mapped to userspace as it would
> >>>>>> destroy their page type.  Add an explicit check for this instead of
> >>>>>> assuming that kernel drivers always get this right.
> >>>>>
> >>>>> So uh, this doesn't look good I think.
> >>>>
> >>>> Yep, you fundamentally can't map a page with a type as page type aliases with
> >>>> mapcount. Even with the given diff, just mapping it will increment the mapcount
> >>>> and wreak havoc. I think we need to revert this patch for now.
> >>>>
> >>>> I'm not sure what the long term plan for this would be. If page types are moved
> >>>> to memdesc types, then the two stop colliding and that could work. I don't know
> >>>> if that's Willy's plan, however.
> >>>>
> >>>> (then there's the other question: are page pool pages really folios? not really.
> >>>> they are mappable, but they aren't part of the page cache, or anon, nor are
> >>>> they in the LRU or have rmap capabilities. perhaps we need a different memdesc
> >>>> for those. we're one step away from reinventing class polymorphism from first
> >>>> principles ;)
> >>>
> >>> Zi Yan is working on this: non-folio pages would no longer mess with
> >>> rmap/mapcounts, and page table walking code will identify them to be non-folio
> >>> things to skip them.
> >>>
> >>> It will take a while, though ...
> >>>
> >> So do I get it right that the path forward here is to revert this commit [1]
> >> and wait until the work from Zi Yan is ready?
> >
> > I think it's the best way for now.
> >
> Ack. Can you do it please? This is a more complicated revert and the risk that I
> mess it up is higher.

I will.

	Byungchul
> 
> Thanks,
> Dragos
> 
> 

