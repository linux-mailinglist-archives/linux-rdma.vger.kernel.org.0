Return-Path: <linux-rdma+bounces-20581-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF8KL1aYBGpiLwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20581-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 17:27:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 126BB536104
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 17:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 730B930E227F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 14:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39473FE374;
	Wed, 13 May 2026 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C6EzXW+b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD2533D6E1
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682532; cv=none; b=kdYgyVqygicqfxRWdRVbWJZqyvpY86OJzipcjQfTLTK6bxioworr7mJpAhIqrqn7CUIZ82erP5r55p7ONQCmkVN51ZRVixFSiZ0J34fEbdR20eFasI/q56MXUSVbX6bdohzNQwebZMxHo1Wr0993nHdwIcOtL/LkvLmdfljUEGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682532; c=relaxed/simple;
	bh=oA0996zIDJASqjfGRPTvsg2hjjZETKq7z+nozqt3Rho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrWmMMY8L4olSKKbnOrjHmgLMG7wP9y1rCVtEsZFYOatP7lilPYMli14xunitIZvubr5ij8jomgn4R27w12gxLj8TrRYIlB1iQIvTTpluUru6VGYvyvoCKSdz12h5I5yGIklDYz5L4c0Mu2tmu+jVJR+YLBnwKVVejpGVj2Lac8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C6EzXW+b; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8f0a87e23daso724825485a.1
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778682530; x=1779287330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=svNtaVXm/xQRNyJKq4Q5u6CixY4+PdR3ZPw0OLMetkI=;
        b=C6EzXW+bXeu/AyWaHjqldDz2HGxGmhxXDCDp1plC+oelqaL5ba1NsjVqnQsQTW8mr1
         hi4bDfzLsJessWGE2drz8/HnqcVM/xLMuay4Y7cGs6DNAcCN8ww0UKzgspXMOR1hsGNS
         R6O/HMePQ+JqB0p7DWZVlzIU79mcc/TPp4BzaBb2BzPhd3jrlrujhxTQMy2VDJPbXm+T
         Zl333d2T67YvuB9salgi+QrY2kk4gS1BveTQn33M3QXT3IrcEYReQ1zZDU5kTd4uSlXX
         aN5JBCbEcK05NLq+zRchWtr4bXFJzO6A8GB9oW7a+SU9N9/xqXrpgxHBId9uiPZhkoDP
         Ztaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778682530; x=1779287330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svNtaVXm/xQRNyJKq4Q5u6CixY4+PdR3ZPw0OLMetkI=;
        b=FG+i3o3U/4JhFGt+uX5ytPymDXH0ojsF5wb1PVg+T9hQyaixmplNSxUOgbfAwXgz6q
         cIqyI84I1BvVIZJPxI6/V5uCP9+ZRheHbbneJ2oEjTypPv/PjpFoRTJ0AAgeTIMIZfD5
         p9sxCDUrfQhCbVlrvISLz2RLGDhC0jxoirlSDrrj/eFMiqlJQjBxEM6JOvmJ6v0c+t6i
         AcZAIUo8FPOIEChbTpFKN0y8nVLek069zCDOOtZg5Oh79aVA8hPQ5lCHsR0NBIsA0wQv
         yn3kRlO1+S9LrwlIIEh4nnjnXf5sM1q3IH60qghAr2qdsIoRUnQADJ8x8yBDzK+7CJza
         TouA==
X-Forwarded-Encrypted: i=1; AFNElJ9/QBmhILOKPx9giba8vYPQhByvDG1Y0UDvp9eBsGSX61DVZfOmnCYv21gKYu7qkxMXpcr2MAKd2p2P@vger.kernel.org
X-Gm-Message-State: AOJu0YwnA11CDa4mxuDLeCQHq96Z21TcPqZq1jjmHrYkPHPdekonFKA/
	F7KHfMDbOAHwl/hdo5B8Q1Njs1wXsnWC0s5xHFwZhvCRFpTkBn3ZxZ49JlgZTfbcWIU=
X-Gm-Gg: Acq92OEd2H6dHmui3yWDvH3cVn9m48zVSQKzsGTxcksrCy1KwWLXK8cvYzlRuGaWaHj
	H5mnUzPC9gdGHqWhTub/0Kb3IxzprmYaP+dKC6pUx6Xgm5xcVtuc9mHoLw3rUzkuMYZ6QwL2oyW
	eMMwfXoHEkdUf2OPyOLll8d0IEFqoMqQ6wFIERhw+PTGQlQlAwMFNEGrT7VJIarpwjHcHyxrauw
	LPnE2qyTke9j5rbouY3Aywmb2YEwhRITj0CWLchN4mlRVtf9kwpMJnheat9KahI+3r5z0JbLneS
	xCbpww11J/YVVWagGTfCLkk+/6Ao3tbQS6b6Rn9gqcPhMbNNP04zy5yo1AnxhlIxIQmDxEIWOZF
	VflKV8+mpzDX3tEB30DPsZq5hNRnsLeyiDugQFfEY5NSl8HzTPUiIPFmYxmUGTgWLdaO3iN7Jcb
	+CYZZD1m7qVLuNgRWDiDh76eSP44M/TkYBZ9lt3xi0WTkW0R3/ksif9ykiQkraMF0PKJ1X05vVq
	q+vsQ==
X-Received: by 2002:a05:620a:4114:b0:8db:f83f:6d91 with SMTP id af79cd13be357-90fa8500110mr447764585a.0.1778682527442;
        Wed, 13 May 2026 07:28:47 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd057acsm4052841385a.47.2026.05.13.07.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 07:28:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNAZq-00000003Il7-0rb2;
	Wed, 13 May 2026 11:28:46 -0300
Date: Wed, 13 May 2026 11:28:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bernard Metzler <bernard.metzler@linux.dev>
Cc: rosenp@gmail.com, leon@kernel.org, kees@kernel.org,
	gustavoars@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH v3] RDMA/siw: use kzalloc_flex
Message-ID: <20260513142846.GN7702@ziepe.ca>
References: <20260511141149.52362-1-bernard.metzler@linux.dev>
 <8226377c-0691-4368-bb82-48b620f784d2@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8226377c-0691-4368-bb82-48b620f784d2@linux.dev>
X-Rspamd-Queue-Id: 126BB536104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20581-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 04:17:03PM +0200, Bernard Metzler wrote:
> > @@ -338,25 +336,20 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
> >   	struct sg_page_iter sg_iter;
> >   	struct sg_table *sgt;
> >   	u64 first_page_va;
> > -	int num_pages, num_chunks, i, rv = 0;
> > +	unsigned int num_pages, num_chunks, i;
> > +	int rv = 0;
> >   	if (!len)
> >   		return ERR_PTR(-EINVAL);
> >   	first_page_va = start & PAGE_MASK;
> >   	num_pages = PAGE_ALIGN(start + len - first_page_va) >> PAGE_SHIFT;
> > -	num_chunks = (num_pages >> CHUNK_SHIFT) + 1;
> > +	num_chunks = ((num_pages - 1) >> CHUNK_SHIFT) + 1;
> > -	umem = kzalloc_obj(*umem);
> > +	umem = kzalloc_flex(*umem, page_chunk, num_chunks);
> >   	if (!umem)
> >   		return ERR_PTR(-ENOMEM);
> I got the following comment from sashiko:
> 
> "Does umem->num_chunks need to be explicitly initialized here?"
> 
> sashiko correctly points out that only newer compilers do that
> initialization (I checked: only supported since gcc >= 15,
> clang >= 19).

Ignore this, kxalloc_flex should not be assumed to initialize anything
but 0. IDK why they put in the auto-initialize when it cannot be
relied on, security in depth I guess.

> > --- a/drivers/infiniband/sw/siw/siw_mem.h
> > +++ b/drivers/infiniband/sw/siw/siw_mem.h
> > @@ -17,7 +17,7 @@ int siw_check_mem(struct ib_pd *pd, struct siw_mem *mem, u64 addr,
> >   		  enum ib_access_flags perms, int len);
> >   int siw_check_sge(struct ib_pd *pd, struct siw_sge *sge,
> >   		  struct siw_mem *mem[], enum ib_access_flags perms,
> > -		  u32 off, int len);
> > +		  u32 off, u32 len);
> 
> Sashiko says:
> 
> "The parameter len in siw_check_sge() is changed to u32, but it looks like
> siw_check_mem() still takes an int for its len parameter."
> 
> 
> This is correct, but shall I correct code not related to that
> kzalloc_flex patch? I propose sending an extra patch fixing that
> broken signed buffer access len/offset treatment all over driver code
> in an extra patch. It is indeed broken and a great finding, but I'd
> like to keep things separately.

Seperate patch is fine

Jason

