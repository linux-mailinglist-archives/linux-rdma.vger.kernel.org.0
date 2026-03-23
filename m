Return-Path: <linux-rdma+bounces-18518-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABJbGskwwWm7RQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18518-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 13:23:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2081F2F1DEF
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 13:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 973D63054315
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 12:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7783239DBF7;
	Mon, 23 Mar 2026 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oXG3VfAC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51B139D6DA
	for <linux-rdma@vger.kernel.org>; Mon, 23 Mar 2026 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268221; cv=pass; b=iFgHpX0kBdJEYiTfKRPqkk4lAkJbsdqeIQdk7OLWYDFhkqGDEeJ6iXtkDigqaH+P0hppqdvFczI+e4+zG6NFjvg2xGIFKMYyxx91BhzK+61I8Qd1nwrDFGusN7FuPBujeUqUepRTFZYvw9bZgQ/dmJZvGRUdkxfFqCkVTCWciIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268221; c=relaxed/simple;
	bh=8RXOKVdkvBzCAmtN9XWtZUMFoXBo6XNuhmfrV+73dck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wg6NzKFSymeNW1zEm//lHkiaEkrYjO4/Ae67aikBi+ZHwCDAaUSFxAWR7TcGV2R1sjDrhPcfAI3WwfRlLDAPlv6iwGIUpst8Th7rEMX4L2NDsm4TroVTJfGM9/YAO08fIAqRf8vUOS6nhUPBddi+i1wvE+RPYIESetABAma+bE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oXG3VfAC; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-797ab169454so26748897b3.3
        for <linux-rdma@vger.kernel.org>; Mon, 23 Mar 2026 05:16:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774268218; cv=none;
        d=google.com; s=arc-20240605;
        b=HBlCRNs1zwNbe8TPTlX4xwTt/o2EQnmo40jOA5PpggtDR8iHy2uM5zIvbLABgS2RuM
         KXEhGqJ9LPhLTo9nnn65hpAHGXzoYeMTsByoBwF06g2pe0OwnHdHFCVZN9kWuxi5jTfN
         WNSrrVv1GPqyYSZmpO7jI5u0/9uNU3ciHeyzH6jhAPA6wE7I5jBrAM1LuUFZU4PTJgUU
         43TbYlZbYON+qooOnaRBiR+u83Bg6g8Zoi00t6w5cQhIYPmmhOPY/4Om6bl8dN5fYnLF
         YSJx14Dy2FjSqJdqug89uhBjrAGRa4VwRZ2W2h5G+FCV9UJjf/CMniUxV9kaLEJndqPj
         T++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MWkmFbrIVsjT8V/hemxMRS0whR7xwhOiVNLmrbQRIkQ=;
        fh=TJr+Nuxcre0Kwu3yy2PA1Fgbp3eXGbX85fa6icqTkWE=;
        b=KRNIsrYogv7lSzIqUhrOrBe5DQ2zx+lCWCkhSmevFIBg8sZ4f8LbAjXVf/m3ujGjRb
         y6qVZVbSc9IIxiJakYa//rXzcfre4xZeVibnVDYbqtUwaHNyuvoj86Rh63U8krhuHwQ8
         mVRcK9u6VvWSSxKuZWUpMCj0/t5rnbwqb3mcHowti0U083hkA/fFXuFO0mElcbC7gtdT
         1lG09TvaFbb7rkCuPYyc7rg9g4lh5yM7jn+3VvJ1O/nKbAlQx9NRdnhMFVZOY+t5HaxD
         SI84UH5h3Nz4oMBEyhgKchwxHxZeTxAh4f0WmE0ROvKthj8FtAdWH3jwdrc1WO+Hbs8j
         uwnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774268218; x=1774873018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MWkmFbrIVsjT8V/hemxMRS0whR7xwhOiVNLmrbQRIkQ=;
        b=oXG3VfAC4LKCyEAzdDhO6NpewxX2S3tvKQa/0F8umwy7BPUIzxHKByL4SJ+/NuvwtN
         01s1JM6LQERBKh2I1SCO0TeaGP8MPTwpgC0sZQr9fwnZ1TFtUojLEx6xYHZQY/1F59zK
         X/xr12CzWDsstfe0dkvHHwceUlmTWqeRvxdO5jtiABTjr/hurLVzIGm3dZJSRL8wbU8I
         6qAeDrPUv4CpPIc7Pd6SutsTygeBMiWJ2mVKzQadbhGpye02XlsIjNzqXBzXFD7xXxky
         eJ1cJw+UEouuY5YWaIZ136g2Rs6mhxqLXhXnKOTxZsmDgHAOih7AkiSeYCYjdMDak7sp
         hgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774268218; x=1774873018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWkmFbrIVsjT8V/hemxMRS0whR7xwhOiVNLmrbQRIkQ=;
        b=sVSrIPuko1WbmAL9etN+1l6ILNMQDTLXdX5UsY29ApYrya9PYgpNPgVcY978Rwpenu
         ytQnnU8Ev2Zlf7apM+RDCOTCF9j6FDC6R2LqMYvcYgJxI5LEhI8NEjH+P3aBaHMlHtKV
         tY+PYivoOghfTkD4yp0xmVmbGW6S81+7c9K558sVR5O8BDsUugWVP6e6/HI1+DUF/8bI
         s/oxgc4AKBWg9TfZF+2Z/KOzqOSa78X+e3x5vcfGmGouxYtDv/LmAJLthlQPC7jR+8dv
         nlcmSPyTduK8GREwJPFuSYt3WVCZaqKdHvOQcTNRYvgQvOV8U1jEjk5/vZCkLjKQ/bKb
         JWXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrwdsvQ9XxrdmVcxqjCZUPSgtB7UkZllhnmStoBpQo/wA+frCrBLKzUWNF780DUrTa1Q3YHiiOBjRX@vger.kernel.org
X-Gm-Message-State: AOJu0YzuDGoCv+cey2N30vqdJDy4EV6D9tZMhXCPgzjqbEad0+4ATbQn
	cviVzBiCa9QYEf9onpQtCBH916XU304/qiJsKN9iMq7zgo1KOo96zCAsShaPPcuwju8VRFqQaHv
	QfI9F1PbmE1Tho/SaqXd7BkDFelfJ+r1MSpSvb6za4g==
X-Gm-Gg: ATEYQzzeyXa/YBtiLuHbm04ZSMLyOe8JyXN+kvtgnRo0h86zzZx+YeeocIIyE/P+mnX
	A1Q4KNEJ1T2mjGo2ScHOEpVc0hm6cowTVRFY3LO9XaHvTed4CvxIEt0RycqjIUqDFgqplj8wC61
	WPf5cdM99ctOvOHeZHOxiT82h9SAEaWaiFuY7UdCu/OlwvdhZtDtflA6VunTRiSiKTEzIghIyJq
	V2JI2klY5WtH4dq8+DC0HV++gpsOBxGOp7mxapfGxi8bbRypHmY2JLluSo4CIKexGRCG6mgLXPy
	tGlu7gxQjC/tDBGm85e7+4XniAnQHdvW2izyavFp3jsqWVxcGLDK7F1Ior1/7K4LQ9IrekMARdu
	efaBoJEu/uwj/mHti2XyNIfxZPph1D8V9iwq+FQAWvWdKJnLtrZNgBbf3V/gdpYFKufjMG25zyo
	xblEfSt6QnEy9m/2yO6DWlBxJyiUE19oczIsL7XiK2dKun7azOur2NZyElU3UisH8Zx7SCKxxe2
	XaLa5LdZA895bmd1Ne22HcEny+b8vYRuepT5r4t+oP1hb0hxLstc6/4PT/J9u1zpDPN5cqd4ks3
	WxeEVodSFyVGzo2IhFyQQ5GDltDuVWNlp9asLxFjwx6iUZeZslOiCMY=
X-Received: by 2002:a05:690c:1b:b0:79a:bb8b:e9d8 with SMTP id
 00721157ae682-79abb8c0ddcmr16991927b3.50.1774268217399; Mon, 23 Mar 2026
 05:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316222901.GA59948@system.software.com> <20260316223113.20097-1-byungchul@sk.com>
 <ebd00055-d4aa-4612-8bf3-ef0a308512f8@kernel.org> <20260318020223.GA69943@system.software.com>
 <b48275da-a3cb-4621-82fa-c2a83f1e24b5@kernel.org>
In-Reply-To: <b48275da-a3cb-4621-82fa-c2a83f1e24b5@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 23 Mar 2026 14:16:20 +0200
X-Gm-Features: AaiRm50BWIH2-tUvBrhcp6LVf1TFjq6A8vCDpCMci7VezVPJXkSVFBGlyHvsvAw
Message-ID: <CAC_iWjL4RhuK16pDM7bQhrkOgHa54R_6S0zGgwSdc_n+yKCcUg@mail.gmail.com>
Subject: Re: [PATCH v5] mm: introduce a new page type for page pool in page type
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Toke Hoiland Jorgensen <toke@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, john.fastabend@gmail.com, 
	sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com, 
	pabeni@redhat.com, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, willy@infradead.org, brauner@kernel.org, kas@kernel.org, 
	yuzhao@google.com, usamaarif642@gmail.com, baolin.wang@linux.alibaba.com, 
	asml.silence@gmail.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
	sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com, 
	Daniel Dao <dqminh@cloudflare.com>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18518-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	FREEMAIL_CC(0.00)[sk.com,kvack.org,linux-foundation.org,vger.kernel.org,kernel.org,google.com,redhat.com,skhynix.com,oracle.com,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,suse.cz,suse.com,cmpxchg.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk,cloudflare.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilias.apalodimas@linaro.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linaro.org:dkim,linaro.org:email,netdevconf.info:url]
X-Rspamd-Queue-Id: 2081F2F1DEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 at 13:44, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>
>
>
> On 18/03/2026 03.02, Byungchul Park wrote:
> > On Tue, Mar 17, 2026 at 10:20:08AM +0100, Jesper Dangaard Brouer wrote:
> >> On 16/03/2026 23.31, Byungchul Park wrote:
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
> >>>     https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> >>>
> >>> While at it, move the sanity check for page pool to on the free path.
> >>>
> >> [...]
> >> see below
> >>
> >>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>> index 9f2fe46ff69a1..ee81f5c67c18f 100644
> >>> --- a/mm/page_alloc.c
> >>> +++ b/mm/page_alloc.c
> >>> @@ -1044,7 +1044,6 @@ static inline bool page_expected_state(struct page *page,
> >>>    #ifdef CONFIG_MEMCG
> >>>                        page->memcg_data |
> >>>    #endif
> >>> -                     page_pool_page_is_pp(page) |
> >>>                        (page->flags.f & check_flags)))
> >>>                return false;
> >>>
> >>> @@ -1071,8 +1070,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
> >>>        if (unlikely(page->memcg_data))
> >>>                bad_reason = "page still charged to cgroup";
> >>>    #endif
> >>> -     if (unlikely(page_pool_page_is_pp(page)))
> >>> -             bad_reason = "page_pool leak";
> >>>        return bad_reason;
> >>>    }
> >>>
> >>> @@ -1381,9 +1378,17 @@ __always_inline bool __free_pages_prepare(struct page *page,
> >>>                mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> >>>                folio->mapping = NULL;
> >>>        }
> >>> -     if (unlikely(page_has_type(page)))
> >>> +     if (unlikely(page_has_type(page))) {
> >>> +             /* networking expects to clear its page type before releasing */
> >>> +             if (is_check_pages_enabled()) {
> >>> +                     if (unlikely(PageNetpp(page))) {
> >>> +                             bad_page(page, "page_pool leak");
> >>> +                             return false;
> >>> +                     }
> >>> +             }
> >>>                /* Reset the page_type (which overlays _mapcount) */
> >>>                page->page_type = UINT_MAX;
> >>> +     }
> >>
> >> I need some opinions here.  When CONFIG_DEBUG_VM is enabled we get help
> >> finding (hard to find) page_pool leaks and mark the page as bad.
> >>
> >> When CONFIG_DEBUG_VM is disabled we silently "allow" leaking.
> >> Should we handle this more gracefully here? (release pp resources)
> >>
> >> Allowing the page to be reused at this point, when a page_pool instance
> >> is known to track life-time and (likely) have the page DMA mapped, seems
> >> problematic to me.  Code only clears page->page_type, but IIRC Toke
> >> added DMA tracking in other fields (plus xarray internally).
> >>
> >> I was going to suggest to simply re-export page_pool_release_page() that
> >> was hidden by 535b9c61bdef ("net: page_pool: hide
> >> page_pool_release_page()"), but that functionality was lost in
> >> 07e0c7d3179d ("net: page_pool: merge page_pool_release_page() with
> >> page_pool_return_page()"). (Cc Jakub/Kuba for that choice).
> >> Simply page_pool_release_page(page->pp, page).
> >>
> >> Opinions?
> >
> > This is not an issue related to this patch but it's worth discussing. :)
> >
>
> Yes, looking at existing code, you are actually keeping the same
> problematic semantics of freeing a page that is still tracked by a
> page_pool (DMA-mapped and life-time tracked), unless CONFIG_DEBUG_VM is
> enabled.  You code change just makes this more clear that this is the case.
>
> In that sense this patch is correct and can be applied.
> Let me clearly ACK this patch.
>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
>
> > Not only page pool state but any bad states checks are also skipped with
> > is_check_pages_enabled() off, which means they are going to be
> > suppressed with the off.
> >
>
> Sadly yes. I'm mostly familiar with the page_pool, and I can say that
> this isn't a good situation.  Like Dragos said [1] it would be better to
> just leak to it.  Dragos gave a talk[2] on how to find these leaked
> pages, if we let them stay leaked.
>
>
>   [1] https://lore.kernel.org/all/20260319163109.58511b70@kernel.org/
>   [2]
> https://netdevconf.info/0x19/sessions/tutorial/diagnosing-page-pool-leaks.html
>
>
> > It is necessary to first clarify whether the action was intentional or
> > not.  According to the answer, we can discuss what to do better. :)
> >
> Acking this patch, as this discussion is a problem for "us" (netdev
> people) to figure out.  Lets land this patch and then we can followup.
>
> --Jesper
>
>
>
>

