Return-Path: <linux-rdma+bounces-19094-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UADsJ8QV1Wm30AcAu9opvQ
	(envelope-from <linux-rdma+bounces-19094-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 16:33:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D98B43B01B0
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 16:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE8C03027957
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 14:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4FF274FEB;
	Tue,  7 Apr 2026 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Pd0lyRrE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F2438AC84
	for <linux-rdma@vger.kernel.org>; Tue,  7 Apr 2026 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572165; cv=none; b=irEFmY1ZrBpdzjodVdyohIebwSQClWcRcl8E2STpqlJc+wPwEDzIRigZR8Zq/zfq9jQXAJeu5wdeyEQe9GAhCW7hmBCAMwYkPI02ecCPkgQMMEfcnHf+oSO0bS8OnRbFOZVYEwg+9SIzh3u/6MGzqEGfqjXQnXIyrwEJkeclVro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572165; c=relaxed/simple;
	bh=+rPKR4LXdDHQSLjcaS/yOhk6TewYYgXnPXQAkiPDgbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1bxBDd0Ng8JWqz8cQ4OGs0pLaJuncWTGlUmhM6+ycMPSFNj9M7MXaJ7l/CjMxjBA3UPT78VBxNDlVEYWiwVJguCSMGFnhwqz9PhruZHpd2bDqM5mUFZEnJ/PtW3JCurFa8e8uaGrbR0qReEOfUwhSC02ZCkdRIDgZOMEDJyc4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Pd0lyRrE; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506aa685d62so27415521cf.0
        for <linux-rdma@vger.kernel.org>; Tue, 07 Apr 2026 07:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775572162; x=1776176962; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k7xgoSXhqByDtv24K63FAxEENppm1PtPVLBkAC9MVro=;
        b=Pd0lyRrELKRdtPItO69mDrH0MUqWtCTU69evEnDUgtMxDggspIQsHI9ggiZoo6vERA
         +XSOVFLb9oB4BC0EnRW8JK3Daj0jdhzgIeK7k98qut0l90A17wMiJ/4FyYfBuED9n5cC
         9aI5tzJhtCXX8aKXmN1/YLLjgUCK2wjk6psPmNfPOFTOH0yyo80L1wfVG+lsq6/stj3o
         V2I7MTefb0nNnzCpM4/ZwBcC69q5E3HAOOiXYDtCiJVrgkH7xWvZmpq04QuHGIaj1alS
         OJdbcyh4blGvvyxHJ6IlqDQMNGq/q0kEibGo6J2TrtL92AoAgAI3KtTjXmadMLVrEmAz
         /bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572162; x=1776176962;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7xgoSXhqByDtv24K63FAxEENppm1PtPVLBkAC9MVro=;
        b=szUjBZm2rBSicxmDEc8ck4e/5bQr1o1Uzc794Def/6eHKBe7Juk3njCXIM/whnypom
         b5PqclWLbmybjpZsvHA3G01mZdJOrraOPhV5H5dZFYkppiCFO/r/Wsgditgnj/D0Ho7h
         RyvTHI5AhdFQAOC+XvQsH4Beel3/3HqkxLDnwmQa2/jCvkHLYR324v3qvvPgxbJeQ3qb
         mI/RmBe0cz6ZV3rXJjf/jaj1JExlkc6U8a9LXIBZ5DgYc6A5rN+JE2mUxxZxxFKoRgHj
         HVTiXMTTGuL2Zb6wkZtlBIbdQCS3sQjkX/1RIXPK/BUUc//2doV4m6RjsNsTuJITcsU6
         mWDw==
X-Forwarded-Encrypted: i=1; AJvYcCXUJf6VDaVrbbhjepc/CGnBePd2658d9XXstS2JHO22eVPHR6U9/ge1+xyqXhz+cuQCUslHtW8gnY9X@vger.kernel.org
X-Gm-Message-State: AOJu0YxBn74wPj/qIwS8pEMNK2Mfta1wLbOpRmLGYEKpUyAC7xyeCkl/
	Gpc12t1ucaqZLVWTPdGcwLzTndn0p/DKVvKDqS1KpmqNTNZ+25sr0UkgIwpKetKJVRQ=
X-Gm-Gg: AeBDievMTkNz2sNPFBauJqg7rmWJPkXXO7wkSYZiuRXJHOa8oiJKSiSZDZOAUkPkM/M
	pz8fQ9Vzj+3TaDkKKRI+NTOjwzGQBpqC+qVRQd6bLrS8X7iHTRI9BPfgjqTkmbgqVMiCZm1f93b
	N6Rtqv62puck6LF5x5e2t1JJkiz1+xPSoGAffQkDpWbqLivCxvbSWBl2onDs/YmEBUOOmhJN+AP
	S22HrsI6m/B5B49cC51AFj9SspkBvRK34ou3TY/43cF0JQWybBSONUTg9K+BPq05Eqx2Wrb136t
	3lwMAii6TxlPR2e5BLN0zIaAoGm/E8I3ozJyiORQ4ls7ooSu9XfUIqvfOUjFUOL8I8cUWdjnx5y
	eOkIqlnVIrC2OJdRc8+OMJxbL2libDDAVUeUrigERdtcETqJu6l+yam8+2j5p/sjwP9nnJMjjOA
	flXq0UL44qmSO7/m8PrVmh6kZoMx47t4/HZ7SwQSIkojCFfszeMtPwMmpmUqqoubSeZkIrpf4+t
	rCRbrdu
X-Received: by 2002:a05:622a:4d90:b0:50d:a747:9ea6 with SMTP id d75a77b69052e-50da747b356mr25942651cf.61.1775572162313;
        Tue, 07 Apr 2026 07:29:22 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d84ab853dsm87044681cf.27.2026.04.07.07.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:29:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wA7Qe-0000000EIFp-2aQu;
	Tue, 07 Apr 2026 11:29:20 -0300
Date: Tue, 7 Apr 2026 11:29:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Patrisious Haddad <phaddad@nvidia.com>
Cc: Edward Srouji <edwards@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Gal Pressman <galpress@amazon.com>, Mark Bloch <markb@mellanox.com>,
	Steve Wise <larrystevenwise@gmail.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Neta Ostrovsky <netao@nvidia.com>,
	Doug Ledford <dledford@redhat.com>,
	Matan Barak <matanb@mellanox.com>, majd@mellanox.com,
	Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 03/11] RDMA/core: Preserve restrack resource
 ID on reinsertion
Message-ID: <20260407142920.GO2551565@ziepe.ca>
References: <20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com>
 <20260406-security-bug-fixes-v2-3-ee8815fa81b7@nvidia.com>
 <20260406222356.GJ2551565@ziepe.ca>
 <ba7fed73-44b2-4078-8715-06ad5e2270e9@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba7fed73-44b2-4078-8715-06ad5e2270e9@nvidia.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19094-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: D98B43B01B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 12:18:07PM +0300, Patrisious Haddad wrote:
> 
> On 4/7/2026 1:23 AM, Jason Gunthorpe wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, Apr 06, 2026 at 12:11:14PM +0300, Edward Srouji wrote:
> > > From: Patrisious Haddad <phaddad@nvidia.com>
> > > 
> > > rdma_restrack_add() currently always allocates a new ID via
> > > xa_alloc_cyclic(), regardless of whether res->id is already set.
> > > This change makes sure that the object’s ID remains the same across
> > > removal and reinsertion to restrack.
> > It would be better to somehow pre-delete it so it is still in the
> > xarray but somehow blocked and then allow un pre-deleting. del/add
> > pairs are not a good design.
> Usually del/add pairs not good due to re-addition possibility of failure ,
> here that cant happen ... so any reason why it is still considered bad ?

xa_insert can fail, so it's still a bad idea.

I do not want to see random calls to restrack_add ignoring the return
code. Some kind of restrack_abort_delete() with a void return and no
possibility for failure is required.

> The problem with marking as deletion here is that it is not only the xarray
> that is being done at the delete operation (there is restrack_put and
> wait_for_completion inside the restrack del to sync with other threads that
> are ongoing).

I think the main point of pre-delete is to fence the concurrency.

So what you probably want is to leave the entry in the xarray, or
perhaps set it to XA_ZERO and drive the refcount to zero so that none
of the xa_load patterns can return it. This is enough to fence the
concurrency while allowing abort to not require any memory allocation.

I remember looking at this once and it was complex to unravel all the
things that rdma_restrack_del with valid and no_track so I gave up..

Jason

