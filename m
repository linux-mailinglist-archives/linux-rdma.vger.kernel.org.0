Return-Path: <linux-rdma+bounces-16603-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALGvEonShGlo5gMAu9opvQ
	(envelope-from <linux-rdma+bounces-16603-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 18:25:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4548CF5E08
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 18:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59A223004D0D
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 17:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF2C43CEF2;
	Thu,  5 Feb 2026 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BUHh307p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723D136403D
	for <linux-rdma@vger.kernel.org>; Thu,  5 Feb 2026 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312323; cv=none; b=QbLzEKBQrnq6xiiLE4GahBXhqAxUmRfxSWYzQ1UTfre676/RhYE8nxpQ3V/YbS2vxISEhVCOIxfg3FUNbtVlpfMK3Dt3GMzNy7oHgI3VOVjzBWZNCQDeVLOJqJ89KjuNK4nuieYtpBuQoTbwY/J6csw9PS4E67BWEajOGaeCj2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312323; c=relaxed/simple;
	bh=QU2IJIK2vmP13Zf6DmZLFuW4MJXbJ0esgfIqUAfugJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0i2v23/v+HGxrRt9Z1OdTPbafl+Lzz8kaeEpWfqC5obnssRVq1j87La25kE1DB/OxAQ2iBtkd+vLOfH8wItPgLMZtRmQRQu9o0JBHBhw9oJi3yMnyR22SqduZsgnh06Jja52SxOHP7gPdytitOh+q+Y4/fDxbtbEFFunmFT4+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BUHh307p; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-89476eaaf16so10340586d6.1
        for <linux-rdma@vger.kernel.org>; Thu, 05 Feb 2026 09:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770312322; x=1770917122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5GoqZEI5t00UC7KZJgq0tM/XLi5xv+p4t430jlWtHs=;
        b=BUHh307pE5mervPCCSLL3I4hIUiK2QbjjVZimhWgC2/JziKuE9UgE354ojnNf09v1z
         pXlQiBbos9asteln11Gj0CrL5vDhHa85PkCeSyeduu4rK+lqGevXGWJh7Unle2dwrRxD
         wi2OJRKZ1YsuX5FCAQsn6TWC97z/LpwAbqE9GO2s4T+rpBcEN9hiO2Oxh9exQJeFMjmM
         r3EVkFB6gkQLLfl0Mtnif6bvXWcPsVpjHsnzHSXPum6mfTGR2LR61jpvqDNg9OKh3k8S
         UANb7tE2R9P0431q2Ie7/lBltYg+E7l7QzWnReKOKXebu524dPOjL4bLwSkkwIU7aP0k
         vI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770312322; x=1770917122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5GoqZEI5t00UC7KZJgq0tM/XLi5xv+p4t430jlWtHs=;
        b=PIyBnzBLQg62SUWRvL8LeUwGGzkHkhuXlToMcYniiHGGq2h//0Ie8PQ72V/7WKT+yZ
         Cge8K2BjS58TK5FWSVaYE6fnrFaDUAzd5FmU35iUUJhVtwRkTNBaGjG/Kaqpa9NbdT9H
         KUfkkiYA+C8UDYwe+Uo3WV0sh0pCiejN4N90sdEPglHt6FHtOK4I4c6P8f7sM4lZP4F9
         dCuYkqbJ67YnQtyVVvxvITQJaD0VnzlbDGYaM25lRp2SgjBaFDcLVTiwpF2n7mkWalgH
         ml1ll+akkZabctJZEjLytQtLgWaQFyQkcTXvPlyLBUpB07dbv+tH+RBSE5AIKVDFSt7+
         419w==
X-Forwarded-Encrypted: i=1; AJvYcCUkNsze7f4Q3Y5IQTIt43iMH7VONdeMQue0JAATxwxekUgrrpURsZCc7qEFsYhv80H2v1RpsnKEbVrI@vger.kernel.org
X-Gm-Message-State: AOJu0YwB8641eZYfnTUrVVeEi3Es+tLSwbgHaVjpT1noO8GpHg2Vijy8
	nJgaHKXaxnYOnq6qkKVn6CxpQQvuV2m/GqdTOUAEkp3MUKQa34XCLRFbFATxzLrPrXc=
X-Gm-Gg: AZuq6aIfh4xmQs0HFfQTGxEXolBI8e/7lXihnRVj/1L9N1tOrzikthXaworyLvHqf9d
	7CBeKXCpKnqU9wU1LTOpczRSMlpKwkz326IlkQvHGywVDT7oZ5s8QLQ3BGRlfCOcr7f9wmFoXak
	4zeu92fIxCnmDCZRGQ+zuiC51nURmor6NwZGWl2YF3g9nHB4aayrzXO+FKH5PmPRkQm3oWLc0JM
	rdwO+kuDTid+groev4ZDE4DA2JEXR5HUSbGnyCnt9nI4i3UKdgtWnlTsYbWH/CEYE9itV0ll3FD
	4xTdvTYEEc4B0l1wIzeWveUNgdIMW3P/lcu/moEHV45vZMH8LBewi3lTWr0sZagK4Wev01DyF53
	1kBXdXuzYOko9Ng4SDRChoRXG0QHvlm2x0XrTIgZxLp9+jyYmREV98FOtfiNWM8EP37c6DkIQLz
	l2S81x/CJVBXOWD2Zc7GjFgot5UyAbyAtP0MgRbDvw9MGerJ46uqgxueMJQ9T3yXlFcWuWjgosH
	esiGw==
X-Received: by 2002:a05:6214:c2d:b0:895:3ad:a628 with SMTP id 6a1803df08f44-8952210b0a8mr113153096d6.14.1770312322300;
        Thu, 05 Feb 2026 09:25:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf38426sm328126d6.12.2026.02.05.09.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 09:25:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vo36X-00000001ndM-1Aaf;
	Thu, 05 Feb 2026 13:25:21 -0400
Date: Thu, 5 Feb 2026 13:25:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Long Li <longli@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana_ib: return PD number to the
 user
Message-ID: <20260205172521.GN2328995@ziepe.ca>
References: <20260205121354.925515-1-kotaranov@linux.microsoft.com>
 <20260205142212.GL2328995@ziepe.ca>
 <DU8PR83MB0975317E888CD5A6A58E2E26B499A@DU8PR83MB0975.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU8PR83MB0975317E888CD5A6A58E2E26B499A@DU8PR83MB0975.EURPRD83.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-16603-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4548CF5E08
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 04:35:44PM +0000, Konstantin Taranov wrote:
> 
> > On Thu, Feb 05, 2026 at 04:13:54AM -0800, Konstantin Taranov wrote:
> > > From: Konstantin Taranov <kotaranov@microsoft.com>
> > >
> > > Implement returning to userspace applications PDNs of created PDs.
> > > The PDN is used by applications that build work requests outside of
> > > the rdma-core code base. The PDN is used to build work requests that
> > > require additional PD isolation checks. The requests can fit only 16 bit
> > PDNs.
> > > Allow users to request short PDNs which are 16 bits.
> > 
> > What?
> > 
> > PDN is protected information it should never be given to the HW directly
> > from userspace.
> > 
> > How can this possibly be secure?
> 
> As far as I know, it is secure as classical PD check for WQ exists and it is just some
> additional requirement to mention PDN in a request. 

If all you are doing is sending a PDN in a WQ that must always match
that PDN that the WQ already has then I would agree that is OK.

But a completely nonsensical thing to do - to the point I'm skeptical
that it is actually being validated ???

> I am not the one who created this requirement to mention PDN in the
> request, but I got an ask to expose that since some vendors do that,
> and there were no security concerns (see struct mlx5dv_pd from
> mlx5dv_init_obj()).

That's different, that is going through a FW path and mlx5 has a UID
mechanism to link the permitted PDN to the user making the request.

> It seems is not a concern when
> the PDN is set from user-space into the address vector (see fill_ud_av() from hns,
> mlx4_create_ah(). and mthca_alloc_av()). As far as I understand, the use-case
> aimed here is similar to address vectors.

All these AH cases all end up with checks in SW or HW that the PDN is
valid for the context. What you are describing could be real, but is
so hard to accept that I'm going to ask you to strongly verify it and
document all this in the commit message.

Jason

