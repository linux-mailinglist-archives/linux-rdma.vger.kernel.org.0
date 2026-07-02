Return-Path: <linux-rdma+bounces-22689-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DafxLIdjRmrZSQsAu9opvQ
	(envelope-from <linux-rdma+bounces-22689-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 15:11:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7906F82A9
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 15:11:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=hGlwBj7h;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22689-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22689-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D99D7303B0EF
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 12:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5D348AE1E;
	Thu,  2 Jul 2026 12:55:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B83480DFD
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 12:55:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996920; cv=none; b=ncf2hTH9b2vF4IO0/Cx4LkOoCk6gweOAb6se8d0A5oBKeZsjKxo7hcHoxYThDTQrD9fZzXkWOCf1L0hg4n8BfzxY8s4dZpVnE/FPK951hhOEFFemf/iRoeD1+Bbv141sssYBObeDhE+FUFHGvcFWht7z+q+8j8bVv3kh7gpYcw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996920; c=relaxed/simple;
	bh=Hi0sFrvLad6ZUxqQDaUPCkHFu51+h8tj5DRGV2OgdT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMOofSX6lofBs7FDBlNxbT9ufpaJA1FdQ6UfpFXe98MAm4vG8nEou5OtJsHd/OGzN8sReVr5LWrnY/GUhV9p0uGEgQlLgndEIx7EvW+g/UHUgX26AnNf6iBDpJEXmdH9AHLOfcBqTQA6P8vhKlpEgeeU9NJB1ID6jN8FuSz0vgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hGlwBj7h; arc=none smtp.client-ip=209.85.219.53
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso11911316d6.3
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2026 05:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782996918; x=1783601718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nYlv5SWzNTuGp4HAyeUKX9uf0Fsfp527T6wFHlMnrGo=;
        b=hGlwBj7hnV4EW3twzprtg7COa8X+u0C/JN4E2qn4BFOTJry+b1gBnTpY5+oMU/6Ipp
         xPoPwM25MvZR5Xr/SohEU9pPsRQRgl1AoEHAek7AEgv3jzBzSQmfrKCT93te+owQ+tu/
         SZdSibDa9X2urRYiyPOknkb/ZeriTcjoxegIpE4pRQSM6f2Ac8PIl+6rLvOxKApS/ALf
         GXMnWUOnJW8Xmf09s6LQRVTH5IK2exioe4hqsq+xkj198cEkOBv98sT7fXBtmgIKTYMN
         4sUJVnQPDs8Syp+kGqZr/XIQGZpOa+oyaEk6X1wA9Z7ocRPMxKOfN6FJmupz7nWy6/gg
         e/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782996918; x=1783601718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYlv5SWzNTuGp4HAyeUKX9uf0Fsfp527T6wFHlMnrGo=;
        b=DYqbmmBY5c69q6ZX/yXZTfu7R+wdsslGI7PqU1/R5bEOq9r0nh9osROebUHqwwCye6
         fNP55cKL2hkrtufBdn8OZe1V0LSli/pQ5BPjYHzMnuTe/S3KO80jJrFYXkakNbmC7QWn
         tzPNC5onfTXupyutlIZybIVBfFgaN8AzgnMrDUBbY2t6miCvIuEL15mf4vD7xxmCuoxt
         vfqr7NH6D80UOlpP+/Un48mnL6Ebck7VH+NaFwFBJrDJPnrzUM1UQsUKVtJr4Ji5Td/v
         yJmRGdwGYMr/QPVxurouQlCxGzgS4wKzBSyXS/UbnVyRHDWCwUBQbTgtgE+vWqikeQQo
         9s0A==
X-Forwarded-Encrypted: i=1; AHgh+RqoROn5P+dglk2irlAxzFaIbEM0la+awpJVKFONR0r6cnZMZi9/gHABSQBHCmh51VWiG0RnRok0u10q@vger.kernel.org
X-Gm-Message-State: AOJu0YzrIKhMk2L/JcQ6xDw5l5Pt20atdaEe1pqsHPHSKezNNOlz+rQ9
	bpoNdzf9CHwkaWkPoPL57cG9mPZ+rNN1W/AB2B8fqYpJv/Jjjme2ltjpjx5gdAN1i6w=
X-Gm-Gg: AfdE7cmfgMDCJx/5AdK9r7MnAMuE7KDxMenSdIQzkboGhCNuBn1IAzQSv9nh7tbr6Xl
	3EWo0bTHvqmLz3IkHQdXXlq5UmeZD4CLMV8EuaSkvWHba1Lg2FuDY2VuUcBFY7MkYAzfpmL0Z0j
	2h6TBdFzekE+wUdue5msok6OA27uTbVWP8WFeHn5iRMUcrXm0Tbzwu9tgXUw3zj5fgOIZqITxRQ
	7jTQVaXsziMRFMpnQW3oTiq34xFaxpcmiCyybyZcCCeKfpnJJFXGxt9YGTsE8qD8hsfp0IfAsix
	cmmik8DHh1y/uC2zJyN1ojIQBk0cMvCvBPmwINDIxZs0NNL2bYNrGdjG9sm/iZ8SiL98xKG9KPf
	YLJnAjHDkENqI0cGnTUORuLlYuEZiQaxSP199/MZRJHHkR731cPJcoZdyD8grh6khCWTL1iB5ut
	0Z3z78MxSZeMNbFJIfvkFBc67cWBcyMRUEiEGO2SA3c0Cl7ZU/ZXhn0Ckli4fHKL4P5yk=
X-Received: by 2002:a05:6214:12d8:b0:8cc:ea95:2261 with SMTP id 6a1803df08f44-8f3c8732be0mr59414706d6.36.1782996918152;
        Thu, 02 Jul 2026 05:55:18 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f013f05sm25593526d6.16.2026.07.02.05.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:55:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfGwm-00000005kHR-3jNs;
	Thu, 02 Jul 2026 09:55:16 -0300
Date: Thu, 2 Jul 2026 09:55:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rdma@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@kernel.org>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Dave Chinner <dgc@kernel.org>
Subject: Re: [PATCH 1/5] RDMA/umem: ib_umem_get(): use kmalloc() to allocate
 page array
Message-ID: <20260702125516.GO7525@ziepe.ca>
References: <20260630-b4-rdma-v1-0-ab42bcf0de92@kernel.org>
 <20260630-b4-rdma-v1-1-ab42bcf0de92@kernel.org>
 <20260630123150.GB7525@ziepe.ca>
 <akPaAp-0Zul8uVga@kernel.org>
 <akPaPaCJdYINBEEV@kernel.org>
 <20260630153638.GG7525@ziepe.ca>
 <9cc11eeb-372a-49fb-ba89-486333ac71c4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cc11eeb-372a-49fb-ba89-486333ac71c4@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-22689-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:rppt@kernel.org,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-rdma@vger.kernel.org,m:willy@infradead.org,m:mhocko@kernel.org,m:david@kernel.org,m:dgc@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ziepe.ca:dkim,ziepe.ca:mid,ziepe.ca:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B7906F82A9

On Thu, Jul 02, 2026 at 02:46:46PM +0200, Vlastimil Babka (SUSE) wrote:
> I think this should be discussed more broadly and not block this
> change.

Currently all of these get_free_pages ones in this series are this
special need, so I'd like to not loose that marking somehow. Maybe a
comment or maybe a inline wrapper function.

> Instead of adding just kmalloc_temporary() we should look at the bigger
> picture where we have manual optimistic nowait attempts with smaller
> fallbacks. Willy's LSF/MM plenary touched on this, as well as recent threads
> with Dave Chinner [1] etc.

Yeah, there is a bigger thing here.

> With that said, I'm for example not sure if "_temporary()" is really the
> distinguishing characteristic for this to be part of the name.

It is the main characteristic of the specific workflow I am pointing at:

 - Allocation is a short term temporary buffer to run some algorithm
 - Performance trade off is larger memory = faster algorithm
 - Sleeping, reclaim, etc is going to be slower than just using a
   PAGE_SIZE buffer
 - Must be contiguous

IMHO I don't mind labeling these specific things with a specific
function, even if there is a more general function also.

> [1] https://lore.kernel.org/all/1f50ce04-20e6-46a0-9d8a-00a5f7a74967@suse.com/

Like this is a different workflow than the temporary one, you may want
to do a little more work to try to get larger pages since they will be
in use for a long time.

Jason

