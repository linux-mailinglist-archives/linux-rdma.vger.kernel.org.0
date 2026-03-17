Return-Path: <linux-rdma+bounces-18241-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PZHFkYouWkAtAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18241-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 11:09:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E10832A7927
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 11:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 791E530AAF83
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 10:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634E23A4F5C;
	Tue, 17 Mar 2026 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p0Bg2Nmm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C4D3A257F
	for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741867; cv=pass; b=daXslBTHHS3FbKVKEE3/ANGevIaoSw8yeT/rn5M3dKettC1FRq/i6khzLncqGvNmWyTUVd5hyfyqOL8FMmsyIXrdig7ewfiLCAn5m7zSYoV2IU0FB5fPnhovGPNJHro39T4/Bp6gPjLSpPL4fYIXgaJbGCXTb4HZAzCBcjsc+D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741867; c=relaxed/simple;
	bh=VMcaJiK0n+Mh3FmYhue0PD5uIx7SxJhXZnJ+mVJvuvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVbfSBx65VnspuPmZ22rfeVWXZPhpE2f3W9qJfe9aSBC9HpBp6ZS+D6BJoMpJx13/dfF7YGeFTC06upERMEvFpXAPLyOSSiQi2tlHEanUW8AUEzcd/TLba2Cm1o/wk1dJzFsiOGZkDkyHa6MCamwtDs3zpeok7VwA9Pe8to0J7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p0Bg2Nmm; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ae222d978so5876544d50.1
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 03:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773741863; cv=none;
        d=google.com; s=arc-20240605;
        b=b4qKIHqI/HTVBL6imuALXAQErLSWYccnfmY9//TvqThcviepVEytp8/Q6eMsVI7jOV
         1lWBZkXMdZIDmma2sFn8WF77I2pYrzMVehnkdWYA0ptoGcgfD8SKlxp7zc7S7HjcLO51
         SiGurxU/BhSVuflens7KyeSk5OvaxIhz18hWNgi25bBog0GUvoHl3kUxEPjcv5/P9MkK
         QFDWrqDdAxkn5hJGfJ9M4fuKVlaXaod1fGt96FeORe75qTlUgOwMlhKVHHNbZNq6vVie
         apuQXJSwNrpdEH33gTBNYuQSE+G66xOq4cPD2LE8w7Dj4+yJZiylUJc0ikGtymMvrNfY
         54yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sJ1Pc/1QKu2lLSHomCR6iKHtySw3Kp4fd1PA2wd2pgs=;
        fh=pRtWnvAosYTqyzS1wAznxz0A+kvs3NCezatznPnW53U=;
        b=WS3zMaIKioWoVlQa8Vtb7j+qXnJ5AAPn0gKp579BWyrJmrkaj+ggOn2vcmTTUCEckO
         Y56Op8TcyWyGJhnGWPXuWDQOM8vC0uD4O1eLkWGNOBJ6yemVnqP2Uh/PmxPZWvCtxn5c
         AvHUVxHUbEynOzEIbAP9xTjuT5gIUkgprhQt0V0PqsgAoNSoX+3JaXNsXgUTIJgTux7m
         CZRye/erOMoWv8MXJagnpV9BKYAY72U+ZvWiVBFHBrxv3xQhpnU5lmCjBUvrPj9mm0lL
         WmHkXB8lETpmPQCf3sLiqtoq076BRFnyO/RTRWYdToFt6ZCoJxY51rhhaCdrVHmLAmRt
         Nqtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773741863; x=1774346663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ1Pc/1QKu2lLSHomCR6iKHtySw3Kp4fd1PA2wd2pgs=;
        b=p0Bg2NmmIKyboHpUMRTohcqtKsgqmTRvZ6VESwm3wzUXCUZTLvpR4pW87SLwEVZAXO
         a715hwTYDcQ66YJ5E6tCxRSczk0n8vIUf+XWJF99Dw0Ou63ItdoeBlBpZY0K+PSMqeuT
         GzR92G1MbpDNpHNgsm2UAbxHCeLxx4Cxo8oiKu80ohZ2DTt38SO3zx4YzoW9OR3xksI7
         wfFP74KJwfNquWCf2cF485aw5B6/Ex2p61WNpIjLwwoBDNyvmTYf29QePQQH5Kyrv1xN
         vnGdCFk3u5Vu7dOuyf6cZtxL8AQOaDbDMpOq4/2KoD8pDV36foKhVoAo5kuh1OaCqZAC
         +kAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773741863; x=1774346663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJ1Pc/1QKu2lLSHomCR6iKHtySw3Kp4fd1PA2wd2pgs=;
        b=RQHG1VAj9Y21HfWt+pjqH9pl9TyP0pddxWT/Ph3oyqU7LafDY98jhBWFMhyWkc/Mzf
         XFKk/QjOp46Y+A0bGXvXAlp2TsxYuG5mD8E9yTJzjHyfSVaSMMGgekVMAD0iQXCwi1TL
         gqXtyCgC7DmfY7CAoxZxJSxLUxwQsO7dtWDDahjsN8L/fNcpvjw2g3mC9Qvf4fVJoX++
         35zo7C+dK3qV8t/UoffS8hf+kS9DDFSs9lPAw94R3LTME/ZlG1c4Er7i2sDH3CRrTcop
         oxDjDwmbYIjBYWwsZEBVUlTxBq1qFHrHdne0e60vi2f+uiWlmNVxE7V1CPFfSZWeeVXD
         P0Ng==
X-Forwarded-Encrypted: i=1; AJvYcCX78sPhiMmdmMP7S8s/ZtvBBnIyUzQv/zsQ6BQ+kTFzRpfq2LxUOnKw1Ao7FfdunHGzJTbTpQs9S5oX@vger.kernel.org
X-Gm-Message-State: AOJu0YzCGh/8/cw6oaS+VbkmrHZMmoofiCGv7WSC806MD7oQJ8ffUaDS
	b3aTbLtzyIjmCHaHD3dXGfwBJd2uYZAHWspZ8Pld5ukOuQx97px2Cc2bi6rDlMB3SHrPZTnopcH
	voQgWZPz9Tq90tVdzIix9XQYREEQEc6Ahszu4BpfmDA==
X-Gm-Gg: ATEYQzzcQnuG7xSMQbltdpYUz3mHCpTodkJHoHA5xS6OPTN/yN9ND7rtS3oapLxk/2p
	CKyp6Z+W5WM9HfDYKpLuCdzIYdgDPnITgJPIvMkUscVtPkFRlSVnKwdCi1wFdvWHcbJkCb6nhLx
	U3lGkGEojq3nxoDeeRpCUZHoik9JXcGAhw5Sb1FCwF//W/rWkExzNlp569PAYQNBSwLzcPh89lb
	4Hl+qE7zKfvwKwyUU5Yyw8+vXqiYhX90tSYl28GQQ7ClHYMrDeSuUI1RiFh9AL4k8dq9JUrk6qs
	xDjh9pVf7azhV5nekxM8rq0alxDULlCQCaQtwnDxuNcpjd940xnlAAiaE+tpqIxEx9qCGwepY5H
	IPF75t7CqykRXEpqk7Es9llB/b7aWYp0NHV6tt+kPt/taelC5CfWs3b3m2l7DFn+D+h4KBOFL6g
	Qiu8MwfsPmK7NSXPTvi2dYFKP7f3sSBfwQx0cTlSsnSQJawZxDeNKXou5n7/3CxXahNlbHl3R6z
	yeI3RSMbTK14K2G+kfXp8CDUypAxT9jeTqzqMuy/EOM7EKsYcEcbzc6xhvgyO/ezOwcR+5PJsZ7
	8FXguMyNYMLlCcEwdobgfq3JLDyvumg0fWdXGfSNPen6
X-Received: by 2002:a53:df4f:0:b0:64c:ea3d:a895 with SMTP id
 956f58d0204a3-64e6306d33fmr11868511d50.61.1773741863199; Tue, 17 Mar 2026
 03:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316222901.GA59948@system.software.com> <20260316223113.20097-1-byungchul@sk.com>
 <ebd00055-d4aa-4612-8bf3-ef0a308512f8@kernel.org>
In-Reply-To: <ebd00055-d4aa-4612-8bf3-ef0a308512f8@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Mar 2026 12:03:47 +0200
X-Gm-Features: AaiRm50_gMBZxX2vRtFxvpOCPSPD6sNew1gAwSuCX31B_IpupUaMwz2w2jjcEa0
Message-ID: <CAC_iWjKXvfJuVn_uGgj4SsPsZnvMMepd7BesZcXgRYDPm9yUhg@mail.gmail.com>
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
	sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com
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
	TAGGED_FROM(0.00)[bounces-18241-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[47];
	FREEMAIL_CC(0.00)[sk.com,kvack.org,linux-foundation.org,vger.kernel.org,kernel.org,google.com,redhat.com,skhynix.com,oracle.com,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,suse.cz,suse.com,cmpxchg.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilias.apalodimas@linaro.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linaro.org:dkim]
X-Rspamd-Queue-Id: E10832A7927
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jesper,

On Tue, 17 Mar 2026 at 11:20, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>
>
>
>
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

You mean we get debug messages about the leak right? Nothing is
silently freed with that config enabled.

> When CONFIG_DEBUG_VM is disabled we silently "allow" leaking.
> Should we handle this more gracefully here? (release pp resources)
>
> Allowing the page to be reused at this point, when a page_pool instance
> is known to track life-time and (likely) have the page DMA mapped, seems
> problematic to me.  Code only clears page->page_type, but IIRC Toke
> added DMA tracking in other fields (plus xarray internally).

If we can reliably track and release the pages, I think we should do
this regardless of CONFIG_DEBUG_VM being enabled or not. But the
question is how did that leak happen? Is it a misuse of the API from
the driver?

Thanks
/Ilias
>
> I was going to suggest to simply re-export page_pool_release_page() that
> was hidden by 535b9c61bdef ("net: page_pool: hide
> page_pool_release_page()"), but that functionality was lost in
> 07e0c7d3179d ("net: page_pool: merge page_pool_release_page() with
> page_pool_return_page()"). (Cc Jakub/Kuba for that choice).
> Simply page_pool_release_page(page->pp, page).
>
> Opinions?
>
> --Jesper

