Return-Path: <linux-rdma+bounces-18446-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN9WDRgzvWmI7QIAu9opvQ
	(envelope-from <linux-rdma+bounces-18446-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 12:44:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9459E2D9C4C
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 12:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E2F53064646
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 11:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3263A7F4C;
	Fri, 20 Mar 2026 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMUiL8XO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F58E2D0C79;
	Fri, 20 Mar 2026 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007056; cv=none; b=rCrWBm9t/gbmmKQFYItbLyXrLEDjusqXeQ26Q1AMVbdBMuvM+vmt8F8O0lI3oZQWOxJs3W+MydnKrRGSPnIDa06fGr5JvAbnvucTwyPzumjlAqUYvvgAxgCcqDgGMDAn7tcHUEHblyMKR61J2gKFnxIS+ACQ1SrbidovKCnW6JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007056; c=relaxed/simple;
	bh=JQp3MSL9XfD0fiFy9TC3daF4dHVhQRTOrCBQIwwJJx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DU+ytxaWWx8n6u/+z/DYY5sieDYj4aq+ItQXZZYowst6WVOUwNkxYBqtbGa9nKaBcoGRcRn9fAM+pV3szcH79EVwHjZg1LNO0hmi3h8dSvsOchVZ1hZKeZIOeTQklkXxvVuIWPdMb6RRpu5+hlepmZSrqKn9zrjI5rLwYTCXVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMUiL8XO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E44FC4CEF7;
	Fri, 20 Mar 2026 11:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774007055;
	bh=JQp3MSL9XfD0fiFy9TC3daF4dHVhQRTOrCBQIwwJJx0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UMUiL8XOeNo4sSgJwu+60ObvNWeiICBECIrjgPTKMq5B0fWiwyuArWSCZxqV23wpK
	 AdMsl5CjPm/bYBO4RAK+W33xOaonvEtlPPR749qUm4qp/J/2GMJzZcGO//ueMfE+NY
	 W39O65i0rHBupEq6gI1TUCNux9gKEin4wSuq+e7o8vcsnei0mVoHG0xrx9ZgF+JT34
	 gNyqg6inr/OdphAYPSvOPb6iH42+avHPw57sxX/VgrUiqiqsiEUT9LQJp+nZUZfwtF
	 e1WkSljQ9yfisqU2aiyZbvd95sd2Uw4dsXyRO89weitSlmy4tceTmd9F6xNW/RKcGn
	 AfEddfSrKk2NA==
Message-ID: <b48275da-a3cb-4621-82fa-c2a83f1e24b5@kernel.org>
Date: Fri, 20 Mar 2026 12:44:05 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm: introduce a new page type for page pool in page
 type
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>,
 Toke Hoiland Jorgensen <toke@redhat.com>, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, john.fastabend@gmail.com,
 sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 asml.silence@gmail.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com,
 dtatulea@nvidia.com, Daniel Dao <dqminh@cloudflare.com>,
 kernel-team <kernel-team@cloudflare.com>
References: <20260316222901.GA59948@system.software.com>
 <20260316223113.20097-1-byungchul@sk.com>
 <ebd00055-d4aa-4612-8bf3-ef0a308512f8@kernel.org>
 <20260318020223.GA69943@system.software.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260318020223.GA69943@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,vger.kernel.org,kernel.org,google.com,redhat.com,skhynix.com,oracle.com,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk,cloudflare.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-18446-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[49];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9459E2D9C4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 18/03/2026 03.02, Byungchul Park wrote:
> On Tue, Mar 17, 2026 at 10:20:08AM +0100, Jesper Dangaard Brouer wrote:
>> On 16/03/2026 23.31, Byungchul Park wrote:
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
>>>     https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
>>>
>>> While at it, move the sanity check for page pool to on the free path.
>>>
>> [...]
>> see below
>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 9f2fe46ff69a1..ee81f5c67c18f 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -1044,7 +1044,6 @@ static inline bool page_expected_state(struct page *page,
>>>    #ifdef CONFIG_MEMCG
>>>                        page->memcg_data |
>>>    #endif
>>> -                     page_pool_page_is_pp(page) |
>>>                        (page->flags.f & check_flags)))
>>>                return false;
>>>
>>> @@ -1071,8 +1070,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
>>>        if (unlikely(page->memcg_data))
>>>                bad_reason = "page still charged to cgroup";
>>>    #endif
>>> -     if (unlikely(page_pool_page_is_pp(page)))
>>> -             bad_reason = "page_pool leak";
>>>        return bad_reason;
>>>    }
>>>
>>> @@ -1381,9 +1378,17 @@ __always_inline bool __free_pages_prepare(struct page *page,
>>>                mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>>>                folio->mapping = NULL;
>>>        }
>>> -     if (unlikely(page_has_type(page)))
>>> +     if (unlikely(page_has_type(page))) {
>>> +             /* networking expects to clear its page type before releasing */
>>> +             if (is_check_pages_enabled()) {
>>> +                     if (unlikely(PageNetpp(page))) {
>>> +                             bad_page(page, "page_pool leak");
>>> +                             return false;
>>> +                     }
>>> +             }
>>>                /* Reset the page_type (which overlays _mapcount) */
>>>                page->page_type = UINT_MAX;
>>> +     }
>>
>> I need some opinions here.  When CONFIG_DEBUG_VM is enabled we get help
>> finding (hard to find) page_pool leaks and mark the page as bad.
>>
>> When CONFIG_DEBUG_VM is disabled we silently "allow" leaking.
>> Should we handle this more gracefully here? (release pp resources)
>>
>> Allowing the page to be reused at this point, when a page_pool instance
>> is known to track life-time and (likely) have the page DMA mapped, seems
>> problematic to me.  Code only clears page->page_type, but IIRC Toke
>> added DMA tracking in other fields (plus xarray internally).
>>
>> I was going to suggest to simply re-export page_pool_release_page() that
>> was hidden by 535b9c61bdef ("net: page_pool: hide
>> page_pool_release_page()"), but that functionality was lost in
>> 07e0c7d3179d ("net: page_pool: merge page_pool_release_page() with
>> page_pool_return_page()"). (Cc Jakub/Kuba for that choice).
>> Simply page_pool_release_page(page->pp, page).
>>
>> Opinions?
> 
> This is not an issue related to this patch but it's worth discussing. :)
> 

Yes, looking at existing code, you are actually keeping the same
problematic semantics of freeing a page that is still tracked by a
page_pool (DMA-mapped and life-time tracked), unless CONFIG_DEBUG_VM is
enabled.  You code change just makes this more clear that this is the case.

In that sense this patch is correct and can be applied.
Let me clearly ACK this patch.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>


> Not only page pool state but any bad states checks are also skipped with
> is_check_pages_enabled() off, which means they are going to be
> suppressed with the off.
> 

Sadly yes. I'm mostly familiar with the page_pool, and I can say that
this isn't a good situation.  Like Dragos said [1] it would be better to
just leak to it.  Dragos gave a talk[2] on how to find these leaked
pages, if we let them stay leaked.


  [1] https://lore.kernel.org/all/20260319163109.58511b70@kernel.org/
  [2] 
https://netdevconf.info/0x19/sessions/tutorial/diagnosing-page-pool-leaks.html


> It is necessary to first clarify whether the action was intentional or
> not.  According to the answer, we can discuss what to do better. :)
> 
Acking this patch, as this discussion is a problem for "us" (netdev
people) to figure out.  Lets land this patch and then we can followup.

--Jesper





