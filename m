Return-Path: <linux-rdma+bounces-16081-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHa8EiLJeGmNtQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16081-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 15:18:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EB5957E0
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 15:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB7793050D36
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 14:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD27280018;
	Tue, 27 Jan 2026 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KITYtOGz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91649198E91
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523350; cv=none; b=ewbfnTr7sjm6JmHLiLeUyt0CEsO/s2lFtf/fl6vp/ZDlbvdphMGrRdqVZrnITm6/3Zm0ZIUInEpEkIzNv0Er9799Z1BFxSjF3U1/dW6106r93p/Yd1jMn/idefqm9qoZNlpVY9q88y4FvCKh6y/RANXBZS5arP+XKh3pMX76Azg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523350; c=relaxed/simple;
	bh=zhH1S0B2GQ1eFFQmqQn5PepUl9TNnrx1RB6ej+OpzAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Low7jGD/b6/CiaWOqqk4D9ynfL7Pn0ictSRHO16w+yBbA3tfsJngUoaSadWsJteQnJAtdgWljJ5+MelcZbfcEDCNsCgKzHzjiG1kDPh//szA4Mgn7RHKJY738KwMdimn3KzG9hZX/SnXQhPv6QmA+lJlqdEBs99QCAJZRupvZMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KITYtOGz; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88a288811a4so81528746d6.3
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 06:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769523347; x=1770128147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KU4OGngicriB7L6MJLKoLJCB4/X+V04zhdmCbcuq2gI=;
        b=KITYtOGz4CYHyIHRQMcn5NeINbG5Wqi+cs8f5JuBfEO+R8bSNrl6eevgfAF7DiJYHG
         W3FojtjJBPVU1FvXdT+FrZqmP4UAc6obJjsLhNaTt/W9d7S5zSkpxENaaq7OqhXs58EN
         Pa/fkI7HD47N2aKtfphj2U4qEaVuTard/GkxIxGM3Uf60Gk3Nd7HOeLf6znCh2Q/aza7
         hCLpkS8TW9whoNV+uy9IEwz+ge9oZb37rcC+MKwIXOjvzzVX64mi6rCHW4b5uCz6ivmF
         au+63uVCD9y0tfD73BqYJdaR4K2tQPl4PrE27epK+oXgWdKzr7o6jw2NKrtFGAXZ4rSQ
         ghqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769523347; x=1770128147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KU4OGngicriB7L6MJLKoLJCB4/X+V04zhdmCbcuq2gI=;
        b=dhDtnmumQTjlrnuA8o+3SqtBC1+Fp79Zk1teUqeeb1UsgkaOYXoMdHJOb+fcRpiVhV
         CRyDhBl7+/wCCcV0/ZhmiigULy738lXWdY+/XqotZEDN6PSuZKdLpf0g7Op/fPfPlepL
         B0lSyoeV/tdBUX9RRHehvR5SeB3ACPypaGkdC/EnvP1tGn717LpdfPJAcEfw/bvCRGq/
         7nN/IPFoxuUI8Bnejcuz8+b86hRKjsG60ZDdp018s9ugcLmhf1VrT098CwB7yIee0J4l
         QOt53ZJmBpr309uS2z4ZWkatYAtcpGhlnBRoXrBMa6PRihS4zycjQVwKK0xIuisHNSzC
         ti+w==
X-Forwarded-Encrypted: i=1; AJvYcCWqyBceaU/VPiRLdCFHDXbhBwfKtGkn8FRMY2XSieFMR+coYgvIrT6YRxU17ULi1T8kVi7aAXV4EwWQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyCGZnvfHM20/3Tl2+LCPaG9Hv729ONmVKRJdH+FMAfA0BTOGc0
	+u2u03Wbl4k2ZkU5y84fEMAZZWaEV2KXgLkLbijxVrBAR0R/f5uyQanuC9b4D/VClOE=
X-Gm-Gg: AZuq6aJyMkILXT2HdcRC7wg0bVf3HpKHETcbHAFwoX/zd+Bwt7JUdU6G1ml4MxmynuJ
	LnKSBSz8jja2rsHmwDA04856rnzDcvJssam0oyGuqE8wOflMseIMCwI8eQQ6aKtiiiP8XKSd/mB
	HOrqJR3hB8b35pr7zBfoMcRFxhTSXioVOaKjDIl4P3njr0nlnKxDhOvmeRtb6FRSv5nUTKumBdq
	osbAO32N/KxQmCMF2E+sOvBzEToUTxSDCe75eFRYk2jXPJFzVlBy/lmV67A6pFlSBUFYXSvKIvO
	iWTv3r6sdiNt1Azn1qyQwitE5YuUayGqwnNeHmaLCnK7IqhvLqugv72Y7aGYU6lkJ0xaS9lpctt
	kRFzQyD8ovaHMasNeqrM17HlkBLkIImRRYPd8EV1r1Tk5z1aR16Kun+mwp1JNNtl3T6PO8YxlaU
	QtZaBZtzolO58bxKbfeLdZX/viZQrmFrimraOOj7P+QkrVwTpLDxgQ3ZVgGVs2Fs53rmE=
X-Received: by 2002:ad4:5aec:0:b0:888:853c:4f55 with SMTP id 6a1803df08f44-894cc95c83dmr24036396d6.70.1769523346963;
        Tue, 27 Jan 2026 06:15:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894a908d67csm83631906d6.20.2026.01.27.06.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 06:15:46 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vkjr7-000000094FI-2zPP;
	Tue, 27 Jan 2026 10:15:45 -0400
Date: Tue, 27 Jan 2026 10:15:45 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v9 4/5] RDMA/bnxt_re: Direct Verbs: Support DBR
 verbs
Message-ID: <20260127141545.GE1641016@ziepe.ca>
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-5-sriharsha.basavapatna@broadcom.com>
 <pynbf5lh5azbblvoygivvzxjcmnvffrtdz5zbjzsg4rccbpvud@277svcow3ra4>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pynbf5lh5azbblvoygivvzxjcmnvffrtdz5zbjzsg4rccbpvud@277svcow3ra4>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-16081-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95EB5957E0
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 01:30:03PM +0100, Jiri Pirko wrote:
> Tue, Jan 27, 2026 at 11:31:08AM +0100, sriharsha.basavapatna@broadcom.com wrote:
> >From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> >
> >The following Direct Verbs (DV) methods have been implemented in
> >this patch.
> >
> >Doorbell Region Direct Verbs:
> >-----------------------------
> >- BNXT_RE_METHOD_DBR_ALLOC:
> >  This will allow the appliation to create extra doorbell regions
> >  and use the associated doorbell page index in DV_CREATE_QP and
> >  use the associated DB address while ringing the doorbell.
> >
> >- BNXT_RE_METHOD_DBR_FREE:
> >  Free the allocated doorbell region.
> >
> >- BNXT_RE_METHOD_GET_DEFAULT_DBR:
> >  Return the default doorbell page index and doorbell page address
> >  associated with the ucontext.
> >
> 
> Similar to CQ/QP, why this is bnxt specific? I know a little about rdma,
> but I believe we use it in mlx5 too, no?

mlx5 has a specific thing too, the doorbell has enough fairly hw
specific properties and never leaks outside the userspace provider.

We consolidated the internal code to manage the mmaps, beyond that
there hasn't been a big push to consolidate more.

Jason

