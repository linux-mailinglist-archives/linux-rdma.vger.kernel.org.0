Return-Path: <linux-rdma+bounces-19651-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBkiD1HF8GloYQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19651-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 16:33:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C88FF487099
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 16:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 719F830386DE
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E1D45106F;
	Tue, 28 Apr 2026 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gD03Ib7u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FDE44BCBE
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386418; cv=none; b=QBNz8cvjykb3PZlu56+pm/yLmSIccUY/l0PSZ+5SPmnQIzAKjRr6VEa5R6sNiOL/D9nGpIlYMNtUUJp0tPvUKuMsoVuhiqW9+Lz1R7ddRyNdtzDSMRh5azBSc1dQbXrJWg0FPg7i1UDBK3YrEXu948CzbS9zXw1Mh0tMmEfkATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386418; c=relaxed/simple;
	bh=PObxDJoXBDSLQlRqR6Mb24LbsiPTAHBucw+Xz6TfgxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRCUSJeQyG2DBwDVnJc8Ktex+OmT5J91gwpqEzTtY1vmEKCca9dAB/dQQnHkoZRwhDydjZWqtVhQb12ro8PFHTbxtwpVWwexxF+jt/fVt2sbUpyZ9ycVEKSBO0CL+bYLJRI3v4r4D6LmT6F0cF4p/jaJCMHNOxjzL2MKr4wlyF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gD03Ib7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F65FC2BCB5;
	Tue, 28 Apr 2026 14:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777386417;
	bh=PObxDJoXBDSLQlRqR6Mb24LbsiPTAHBucw+Xz6TfgxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gD03Ib7uc+gUhtR6gK3nHVtYMNqtJIWimRRopLrs4G0ixLNufH94gmpp+iVt8IfLW
	 pJCBkgAl0FsWCmCYi2zF13MDodYi2f8XQy1O43IjvXVqC1ptsLY/s/SBklu56/ZjTA
	 ITx0lbfcG/ZdZ+APaYb1J/fXCJwpuoqE7OzHRpqg0azBpIV/usJc4yv36r2eo36rcq
	 bJic8Ok3PEjEAXopzZi6nnrMFuymEsPI8XV/3kGyfN+JWsgSQYJ2pwdhE7bXmVbajE
	 AqB3oj6QpB8djf+gr+sVzhxNB/QpJ2+r9qLIHnbIlnXENNL+suKYtfGZQfRdwnyDXv
	 eAq8+muszB5FQ==
Date: Tue, 28 Apr 2026 17:26:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "yanjun.zhu" <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix unsafe socket release during namespace
 cleanup
Message-ID: <20260428142653.GQ440345@unreal>
References: <20260424043522.22901-1-yanjun.zhu@linux.dev>
 <20260427123503.GI440345@unreal>
 <805dcebc-39c6-4140-b07f-f76b7594c9d8@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <805dcebc-39c6-4140-b07f-f76b7594c9d8@linux.dev>
X-Rspamd-Queue-Id: C88FF487099
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19651-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]

On Mon, Apr 27, 2026 at 01:52:17PM -0700, yanjun.zhu wrote:
> On 4/27/26 5:35 AM, Leon Romanovsky wrote:
> > On Fri, Apr 24, 2026 at 06:35:22AM +0200, Zhu Yanjun wrote:
> > > Since all the sockets are created in rdma link create command
> > > and destroyed in rdma link delete command, keeping
> > > udp_tunnel_sock_release in rxe_ns_exit risks a "double-free" if
> > > the namespace and the device are being cleaned up simultaneously.
> > 
> > Please add a ladder diagram to clarify how it can be possible.
> 
> Hi, Leon
> 
> The double-free occurs as follows:
> 
> CPU 0 (Net NameSpace cleanup)        CPU 1 (RDMA device removal)
> ---------------------                ---------------------------
> rxe_ns_exit()                        rxe_link_delete() (rdma link del )
>   -> sk = ns_sk->rxe_sk4               -> sk = ns_sk->rxe_sk4
>   -> udp_tunnel_sock_release(sk)
>      [Success: First Free]             -> udp_tunnel_sock_release(sk)
>                                           [Crash: Double Free]
> 
> After removing the socket release logic from rxe_ns_exit(), we ensure
> that only the device destruction path (rxe_link_delete) is responsible
> for freeing the tunnel sockets, effectively eliminating the double-free
> problem.

I think it is possible to call rxe_ns_exit() without invoking
rxe_link_delete(), and in that case the UDP socket will not be
destroyed.

Thanks

> 
> I am not sure if I should put the above into the commit log.
> 
> Thanks a lot.
> 
> Zhu Yanjun
> 
> > 
> > Thanks
> > 
> > > 
> > > Fixes: 13f2a53c2a71 ("RDMA/rxe: Add net namespace support for IPv4/IPv6 sockets")
> > > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > ---
> > >   drivers/infiniband/sw/rxe/rxe_ns.c | 20 --------------------
> > >   1 file changed, 20 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
> > > index 8b9d734229b2..53add78b8e3a 100644
> > > --- a/drivers/infiniband/sw/rxe/rxe_ns.c
> > > +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
> > > @@ -39,26 +39,6 @@ static void rxe_ns_exit(struct net *net)
> > >   {
> > >   	/* called when the network namespace is removed
> > >   	 */
> > > -	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> > > -	struct sock *sk;
> > > -
> > > -	rcu_read_lock();
> > > -	sk = rcu_dereference(ns_sk->rxe_sk4);
> > > -	rcu_read_unlock();
> > > -	if (sk) {
> > > -		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
> > > -		udp_tunnel_sock_release(sk->sk_socket);
> > > -	}
> > > -
> > > -#if IS_ENABLED(CONFIG_IPV6)
> > > -	rcu_read_lock();
> > > -	sk = rcu_dereference(ns_sk->rxe_sk6);
> > > -	rcu_read_unlock();
> > > -	if (sk) {
> > > -		rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
> > > -		udp_tunnel_sock_release(sk->sk_socket);
> > > -	}
> > > -#endif
> > >   }
> > >   /*
> > > -- 
> > > 2.43.0
> > > 
> > > 
> 

