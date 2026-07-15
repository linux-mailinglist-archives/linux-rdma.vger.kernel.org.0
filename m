Return-Path: <linux-rdma+bounces-23266-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GjYjMRpOV2rOIwEAu9opvQ
	(envelope-from <linux-rdma+bounces-23266-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 11:08:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5983675C3EC
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 11:08:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DNm9lcP+;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23266-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23266-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87BB33005591
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 09:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28FB3ED12B;
	Wed, 15 Jul 2026 09:08:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1767B3ED5A6;
	Wed, 15 Jul 2026 09:08:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106519; cv=none; b=hL9CsKdGqUL7yRKRhQF/lER8kwiO5OV508OFo0hOi2MEmbQizGPHJxgvCEs2kPGRKZEVE1LtcXTFigyjqOnfQIPPy1M7PS7xWPrRnXIo+Rj8XqDIm6t7qGiLbVsdWVwEs2Om3vCdLEoLZnkd7dtFq4zViCnqW5l0pyCg3BGhpzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106519; c=relaxed/simple;
	bh=cEZgGLwELxzhZTjyZV2PXGTPxLBixNbGDjG+13Lyjpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfKtziEbpniJYlU0CYx1jYquasagoKO6uTAsifNMGIlvcTP+fSm5TqrwQizmEBgElnM1dIWyCPLaKqQurzSW0tjjEOPdct86T8CXdjvjEcjfdgmmCgV19TPM5i5y9tIqtxtV/0wZUTULHVLnTSZaMX2MQyxy6EIkThBPDKrtoHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNm9lcP+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973821F000E9;
	Wed, 15 Jul 2026 09:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784106516;
	bh=oHlLT+KBCE76NGCehwP37q1ZN6ZsSD1q9YMlLN7F0f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DNm9lcP+yS+B6GUjDoKLJTSLDAObk2icsyIfuplH6cwXDigRASmRWjcpFU0W1+AhT
	 jwOvMphdPghjf4nRvE1rt/6Pdy94dcCxQC3LU0hUoNF+//lw8L/mrJ2LmaNkBjBmyV
	 r7KjYdzjGM8Wl3jQBRFtmD6dWVE31eDmH+pKNm1aKKYcRWvXH796srEKoweVHomSsk
	 XahWQgv2/6uOm0DcCK7Hbuk2m/+vgYrvqnI3vS9mS4q7dZ0NuL1uc5ExC9acLqkgMR
	 oKtDffQVCM/vi5hJ0F7zB6ifJUNlB4iaBEQsRnGYMD9ywl6AOce7SJkLIy9oFJROvL
	 ExJGn/B9qsf+A==
Date: Wed, 15 Jul 2026 12:08:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 0/5] RDMA, IB: replace __get_free_pages() with
 kmalloc()
Message-ID: <20260715090830.GF21348@unreal>
References: <20260713-b4-rdma-v2-0-65d2a1a5180c@kernel.org>
 <20260714122456.GD19233@unreal>
 <20260714122818.GE19233@unreal>
 <alcphPwP175Xzqli@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alcphPwP175Xzqli@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rppt@kernel.org,m:jgg@ziepe.ca,m:dennis.dalessandro@cornelisnetworks.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23266-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,unreal:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5983675C3EC

On Wed, Jul 15, 2026 at 09:32:36AM +0300, Mike Rapoport wrote:
> On Tue, Jul 14, 2026 at 03:28:18PM +0300, Leon Romanovsky wrote:
> > On Tue, Jul 14, 2026 at 03:24:56PM +0300, Leon Romanovsky wrote:
> > > On Mon, Jul 13, 2026 at 10:17:21AM +0300, Mike Rapoport (Microsoft) wrote:
> > > > This is a (small) part of larger work of replacing page allocator calls
> > > > with kmalloc.
> > > 
> > > Will you also change get_zeroed_page() in RDMA, or should I
> > > prepare a patch?
> 
> A patch would be great!
> 
> I do plan to audit all __get_free_pages()/get_zeroed_page() etc call sites,
> but obviously it will take some time.
> 
> For now I only sent patches where the replacement was obvious and didn't
> require me to dig deep and I surely could miss some.

No problem, I'll handle it.

Thanks

>  
> > ➜  kernel git:(wip/leon-for-next) git grep get_zeroed_page drivers/infiniband/
> > drivers/infiniband/hw/bnxt_re/ib_verbs.c:                       srq->uctx_srq_page = (void *)get_zeroed_page(GFP_KERNEL);
> > drivers/infiniband/hw/bnxt_re/ib_verbs.c:               cq->uctx_cq_page = (void *)get_zeroed_page(GFP_KERNEL);
> > drivers/infiniband/hw/bnxt_re/ib_verbs.c:       uctx->shpg = (void *)get_zeroed_page(GFP_KERNEL);
> > drivers/infiniband/hw/mlx4/mr.c:        mr->pages = (__be64 *)get_zeroed_page(GFP_KERNEL);
> > drivers/infiniband/hw/qedr/verbs.c:     q->db_rec_data = (void *)get_zeroed_page(GFP_USER);
> > 
> > Thanks
> 
> -- 
> Sincerely yours,
> Mike.

