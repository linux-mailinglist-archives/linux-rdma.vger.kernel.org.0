Return-Path: <linux-rdma+bounces-18286-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEz2GsYHumnKQgIAu9opvQ
	(envelope-from <linux-rdma+bounces-18286-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 03:02:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B97C2B5183
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 03:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D36963035A7A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 02:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D50E21257E;
	Wed, 18 Mar 2026 02:02:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261DD23EA85;
	Wed, 18 Mar 2026 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773799358; cv=none; b=LFcBZcWpa9LfSPmoqTuGUD7wqdRwYorAORyB6PBHw3EfMN2AhtUHRvtUZ1AfVq7VvOFA2NfyhD4oEPNTQ2L53Uv5bsi9dnfrUdiTA0Z1F+3DL4LiJDkuy8ELxywWSAN1awdJybrE9TA5K/9xSzcrM026tm+V5O2QYZfkkwXYh9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773799358; c=relaxed/simple;
	bh=jQ5AlW6g6zCQ5DGPrjSgNUV1KpT/RV9U8JolB5OGRyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUc42YvCD+4RMsvEgFSxOnN2SxAM+R1OqX9k8Ori9Yru1l4HER4D2wbWq0F4byU8V6HXmtU20TWDPnY3LG4NHimJ2EwULdqV7RySdqB5MrHAfq49t6UNLgD2YGK0Syb6buDTgfTPlkr4Ur0Awro2Wz9V5Nhfm5V9XWrkaKj+aLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-95-69ba07b464b0
Date: Wed, 18 Mar 2026 11:02:23 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Toke Hoiland Jorgensen <toke@redhat.com>,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, john.fastabend@gmail.com, sdf@fomichev.me,
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com,
	pabeni@redhat.com, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	asml.silence@gmail.com, bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
	ap420073@gmail.com, dtatulea@nvidia.com
Subject: Re: [PATCH v5] mm: introduce a new page type for page pool in page
 type
Message-ID: <20260318020223.GA69943@system.software.com>
References: <20260316222901.GA59948@system.software.com>
 <20260316223113.20097-1-byungchul@sk.com>
 <ebd00055-d4aa-4612-8bf3-ef0a308512f8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebd00055-d4aa-4612-8bf3-ef0a308512f8@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfZ/nued5unXb0wlf/CFnZmskxvbxY/kxP76bMfNjmQw3PfTM
	FS5Sja1oSVOd/Nh1xQolFTcX3V3UciVXbDjuPH5UhGt+heTWqeGuMf577fPj9Xn/8eFp9T3F
	OF5K2ivqk7Q6DatklJ9Cz027ztVL0W53GJSYa1ioHkiFiy9tCvDX9FBQUlWHoN//nINfDa0I
	vrXcYeFDcx+C82U+GkruZzHw3fyDBnt9D4L3xsssvG3t5qDashK6KrwM3DxipaG7wMlCXtYg
	DQ3+Xg4O2SoD4toMDh7U5Svg5I9yGqwZLzl4VF/CQmfNLwV4HXkMtJkuMfDlVAsNXfkLobV0
	NPjufkTQYrZS4Dt2hgV3UT0F1xvcHJxwlbLwOqsLgau5m4FTQzksFGfmIxgcCCh7Df0KKL7d
	yS2MIpmyzJLmj59pcu3SU4p4jMcZIje2U8Ru6uBIqWUfqa2MJLmyiyaWqqMssfQVcuSF5yZL
	nMZBhthfzSF22zeK5B3uZVeP2qicHy/qpBRRPz1mqzKh7KGX2u2PSPWeP8tkoAaci0J4LMzC
	Oe/ecn/Zn/0MBZkRJuNK85AiyKwwBcuynw5yuDAV98guKhcpeVqo5nHTwIXh5ZHCGiwXWNgg
	qwTAXk87FxxSC0aEi09m/mmE4baiN0yQaSESyz/fBUx8gMfjiz/5YDlEiMEeZ/lwiFHCJNxU
	d2f4GBb6edzY/ehP0rH4VqXMGJBg+k9r+k9r+qctRXQVUktJKYlaSTcrKiEtSUqN2rYr0YIC
	P1ZxcCjOhvoerHUggUeaUNWGWLukVmhTktMSHQjztCZcVdFSJ6lV8dq0dFG/a4t+n05MdqDx
	PKMZo5rp2x+vFnZo94o7RXG3qP/bpfiQcRlowteJ6e372wYLnLH9udYiU9+qrNkRhgXl5oOb
	l3jT4jalO2q3XF53eLrC99T8eETM9kVz9Tl7FnW4zhijY+JCIzqlwsVNmwqUtuwT2UvbG29c
	JcamlFU9T1ZXn+YTPOHLnMtnGJYaJsIVONBhvWqMnVf4SQi7Z5t3TRXt5ldErNdpmOQE7YxI
	Wp+s/Q1eK7MLXwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec85O+e4WhyX2aGgbCGBZCVZPN0kqPA16K5YfamRJ3dIZ2wm
	WhSzxMq8VoJNC+3idTac5pxkmZrT/FAZyuniJauNTCwviVO7bFHktx/P//n/eD48LKm8L1vE
	itp4QadVx6hoOSXfvelCYA1TL66ZqgqGArOJhorJRCjpr5OBy+QkoKC8FsG46y0DvxpaEYy1
	2Gn40jyK4E7RBAkFz1Mo+G6eIsFW70QwmFdJw6fWAQYqLLugr9hBwcOLVhIGstpoyEiZJqHB
	NczA+bpSt7jawEDzzXYZvKjNlMH1qXskWA39DLyqL6Ch1/RLBo6mDArajWUUfMttIaEvcyu0
	FvrCRMcQghazlYCJ9Js0dN2oJ+BBQxcD1zoLafiQ0oegs3mAgtyZSzTkJ2cimJ50K4ezx2WQ
	/7SX2boaJ0sSjZuHvpK4puw1gbvzcigsPXpGYJuxh8GFllO4ujQAp0mdJLaUX6axZfQqg991
	P6RxW940hW3vN2Bb3RiBMy4M03t9D8s3RwkxYoKgWx1yVK4peukgTrr8Eh13blEG1MCnIS+W
	54J5V+ob5GGK8+dLzTMyD9PcCl6SXKSHfbiVvFPqJNKQnCW5CpZvnLzLeIL53H5eyrLQHlZw
	wDu6nzGeJSWXh/j868l/A2++/cZHysMkF8BLPz+7TaybF/MlP1nP2IsL4bvb7v05YgG3nG+s
	tRPZSGGc1TbOahv/twsRWY58RG1CrFqMWbdKf0KTpBUTVx2Li7Ug9xcVn53JqUPjr0KbEMci
	1VzFwUibqJSpE/RJsU2IZ0mVj6K4pVZUKqLUSacFXdwR3akYQd+EFrOUaqFiZ6RwVMlFq+OF
	E4JwUtD9SwnWa5EBVVYZgtIHd9VYic+3xxojsG5l1SFF9fYtPXPCuny3KSP0S9d2jIRrR3I3
	muLlYY+DRVOWMHjAvuNMyKgjcO21qfvZVjLuisaZtLRsaOzyXv/14akHRpy+P0LO5Ry37V/i
	bU/F0T2BoX5no/yLXct8zAv2dYxvFm5p9sz7/gT76e0qSq9RBwWQOr36NwpIYiRBAwAA
X-CFilter-Loop: Reflected
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[sk.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18286-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,vger.kernel.org,kernel.org,google.com,redhat.com,skhynix.com,oracle.com,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	NEURAL_HAM(-0.00)[-0.148];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[system.software.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B97C2B5183
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 10:20:08AM +0100, Jesper Dangaard Brouer wrote:
> On 16/03/2026 23.31, Byungchul Park wrote:
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
> >    https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> > 
> > While at it, move the sanity check for page pool to on the free path.
> > 
> [...]
> see below
> 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 9f2fe46ff69a1..ee81f5c67c18f 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1044,7 +1044,6 @@ static inline bool page_expected_state(struct page *page,
> >   #ifdef CONFIG_MEMCG
> >                       page->memcg_data |
> >   #endif
> > -                     page_pool_page_is_pp(page) |
> >                       (page->flags.f & check_flags)))
> >               return false;
> > 
> > @@ -1071,8 +1070,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
> >       if (unlikely(page->memcg_data))
> >               bad_reason = "page still charged to cgroup";
> >   #endif
> > -     if (unlikely(page_pool_page_is_pp(page)))
> > -             bad_reason = "page_pool leak";
> >       return bad_reason;
> >   }
> > 
> > @@ -1381,9 +1378,17 @@ __always_inline bool __free_pages_prepare(struct page *page,
> >               mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> >               folio->mapping = NULL;
> >       }
> > -     if (unlikely(page_has_type(page)))
> > +     if (unlikely(page_has_type(page))) {
> > +             /* networking expects to clear its page type before releasing */
> > +             if (is_check_pages_enabled()) {
> > +                     if (unlikely(PageNetpp(page))) {
> > +                             bad_page(page, "page_pool leak");
> > +                             return false;
> > +                     }
> > +             }
> >               /* Reset the page_type (which overlays _mapcount) */
> >               page->page_type = UINT_MAX;
> > +     }
> 
> I need some opinions here.  When CONFIG_DEBUG_VM is enabled we get help
> finding (hard to find) page_pool leaks and mark the page as bad.
> 
> When CONFIG_DEBUG_VM is disabled we silently "allow" leaking.
> Should we handle this more gracefully here? (release pp resources)
> 
> Allowing the page to be reused at this point, when a page_pool instance
> is known to track life-time and (likely) have the page DMA mapped, seems
> problematic to me.  Code only clears page->page_type, but IIRC Toke
> added DMA tracking in other fields (plus xarray internally).
> 
> I was going to suggest to simply re-export page_pool_release_page() that
> was hidden by 535b9c61bdef ("net: page_pool: hide
> page_pool_release_page()"), but that functionality was lost in
> 07e0c7d3179d ("net: page_pool: merge page_pool_release_page() with
> page_pool_return_page()"). (Cc Jakub/Kuba for that choice).
> Simply page_pool_release_page(page->pp, page).
> 
> Opinions?

This is not an issue related to this patch but it's worth discussing. :)

Not only page pool state but any bad states checks are also skipped with
is_check_pages_enabled() off, which means they are going to be
suppressed with the off.

It is necessary to first clarify whether the action was intentional or
not.  According to the answer, we can discuss what to do better. :)

	Byungchul
> 
> --Jesper

