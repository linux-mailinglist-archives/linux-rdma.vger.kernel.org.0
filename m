Return-Path: <linux-rdma+bounces-17952-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLC3EcUrsWkBrgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17952-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 09:45:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B402C25F9B3
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 09:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EAA83022F6C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 08:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF733BBA1B;
	Wed, 11 Mar 2026 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYW8BtXM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8379D2E62B3;
	Wed, 11 Mar 2026 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218728; cv=none; b=SX/o2PBJdROp/J4rIw2NriJ+MMitHVdD2zqYYgz4pqr+AnMDC6Cod+R3LfPF8jvgB5GkB1Xxr/PP44rfVFkvTFRhDwUi3VOTc1O6Oy+XSuO6m8nta7rw76dtoDnaAWXMOfZTtptKB2VUc8s9lBpQ98rkVoWJnXN8Hw/Bf66W51M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218728; c=relaxed/simple;
	bh=kgg1X7ztJZXbwj1Z2TDZlzRloybL0F7vtUdf8SlXNMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b40qwQNqiEXhRW8kG+b8/7XZZZXKOSKbe9NSJBDYFTETPp8EuO2o7Ww7YZwx0hJ2bLkp/E9jh+hXOeovt7rGKXwWM9FtYQyRqu3t6IhY3PU7AnidagqUJVNfztpPs5bhpYQnkCEOU3t4RckgOLiWahLQAZGqS1ezvTDhWys5NlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYW8BtXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D053C4CEF7;
	Wed, 11 Mar 2026 08:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773218727;
	bh=kgg1X7ztJZXbwj1Z2TDZlzRloybL0F7vtUdf8SlXNMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYW8BtXMDYKnEw26sFJ2IFJqURTso1vg15XzKfNYfD8Oycbmhm6lnmaqF+gqD6ewx
	 OZYpgrIwzMM0V7rtFIoJI8CaxaXdSMO7yLUpfCY/GePZBzvqBtgLUgYQ3cTFPhuM/V
	 LZy4DLvoQ5j8in3pgdjxnhOfz2JP58LCE9QL2QEgBH2j9ODd10kqzIb4ZHri4x/iBN
	 AHJtGD/XZc0qhm0owk6nFIIraaypEft+qFwEJgQLdGd5lqy0jlJfikywf6PQRGagUe
	 wjUH55jH3+t+ar1EgintQEsjtNF9YixoLv34GgwLGd//1rHL2ajBKqOPrDnvtAXGtI
	 1bCds2uxjNCcQ==
Date: Wed, 11 Mar 2026 10:45:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: jgg@ziepe.ca, zyjzyj2000@gmail.com, shuah@kernel.org,
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
	dsahern@kernel.org
Subject: Re: [PATCH v5 3/4] RDMA/rxe: Support RDMA link creation and
 destruction per net namespace
Message-ID: <20260311084523.GU12611@unreal>
References: <20260310020519.101415-1-yanjun.zhu@linux.dev>
 <20260310020519.101415-4-yanjun.zhu@linux.dev>
 <20260310185744.GK12611@unreal>
 <eaf37917-76aa-4869-a37b-5a1acb4ba7ae@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaf37917-76aa-4869-a37b-5a1acb4ba7ae@linux.dev>
X-Rspamd-Queue-Id: B402C25F9B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ziepe.ca,gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17952-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 01:32:30PM -0700, Yanjun.Zhu wrote:
> 
> On 3/10/26 11:57 AM, Leon Romanovsky wrote:
> > On Tue, Mar 10, 2026 at 03:05:17AM +0100, Zhu Yanjun wrote:
> > > After introducing dellink handling and per-net namespace management
> > > for IPv4 and IPv6 sockets, extend rxe to create and destroy RDMA links
> > > within each network namespace.
> > > 
> > > With this change, RDMA links can be instantiated both in init_net and
> > > in other network namespaces. The lifecycle of the RDMA link is now tied
> > > to the corresponding namespace and is properly cleaned up when the
> > > namespace or link is removed.
> > > 
> > > This ensures rxe behaves correctly in multi-namespace environments and
> > > keeps socket and RDMA link resources consistent across namespace
> > > creation and teardown.
> > > 
> > > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > ---
> > >   drivers/infiniband/sw/rxe/rxe.c     |  38 +++++++-
> > >   drivers/infiniband/sw/rxe/rxe_net.c | 145 +++++++++++++++++++++-------
> > >   drivers/infiniband/sw/rxe/rxe_net.h |   9 +-
> > >   3 files changed, 146 insertions(+), 46 deletions(-)
> > <...>
> > 
> > > +#define SK_REF_FOR_TUNNEL	2
> > <...>
> > 
> > > +#undef SK_REF_FOR_TUNNEL
> > We typically place defines at the beginning of a file and avoid undefining
> > them. The undef directive is mainly used when a macro is defined inside a
> > function.
> 
> Defining macros locally helps clarify the intent behind specific values.
> 
> By pairing the #define with a trailing #undef, we gain the descriptive
> 
> benefits of the macro while maintaining strict control over its visibility.

Zhu,

Tell your AI that, in the context of Linux kernel code, its response  
is incorrect.

Thanks

> 
> I will put the definition of the MACRO in the function, following your
> advice.
> 
> Thanks.
> 
> Zhu Yanjun
> 
> > 
> > Thanks
> 

