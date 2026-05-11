Return-Path: <linux-rdma+bounces-20390-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPXsMVjOAWryjwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20390-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 14:40:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CD050E091
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 14:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 895CB302C5D6
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 12:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0936D38C41B;
	Mon, 11 May 2026 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYehvu7T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C159436D510
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503029; cv=none; b=nWIDt4oNDajOC3j+aeOFyoWgaeLFayetTOaNpe7eiHhrUzcWSFGNMF4VBgeU5+WhxynHVzsyLqht3U2vrxONms9olbCY6zNN4RW6gvpIkA3VhGVZCkH85QdpuMl/5sJcTjnKLw6exyGCo/u3i96WGzP2fRQdt1xmSA4PE9fwf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503029; c=relaxed/simple;
	bh=e/Rh83l3DiA8U1JZHEnAub7/NYwkzs2cyrqavKRhTT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uupNMThN037BNcgXz0bhwweCP2Wjd6yfPLDsiVD1LU0CG9mvVMqlkF0zB2xFn1VzUvXAz012NxMRpa4/TQoPqvwQhrW48umwYPiZQ/eZLPt9H60W4SlBqhkryVHJFSEhOZ5ScomL/tn4vb4Q8H4ygnQ+Mq2zM0TdVz+wZvnYrJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYehvu7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5894C2BCB0;
	Mon, 11 May 2026 12:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778503029;
	bh=e/Rh83l3DiA8U1JZHEnAub7/NYwkzs2cyrqavKRhTT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYehvu7TPtRKZPwD81zqx7n+oIZzgoxgiv4mLaNBZOJMGzfcsiMxWbuL1sChyje5r
	 nHjNxyIcTBfU7akOYQ+d4HVaAynVg0iu1EZzBGQlyJFO8rv5zxpQV6mvGrBDiEobHE
	 o+1HjJvOTqPZ6UVC5hqNq8A5tcqvsztGSyQzo+g2c30nkn4I6hQwKGBH3Dl16nDIGz
	 tlWvCn72KWR1jRagjR875L/udNph9xU4wbAFJVN6E12LVx7YuNWkugKOr07L+v6WMF
	 XhbBeZqbxowIIv2WpnmvhHjUqAl2ZH6V7DSYsNvmQ935aDPE+NukAdtTDP2jAUQXUK
	 o/tKFLl+Ittug==
Date: Mon, 11 May 2026 15:37:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "yanjun.zhu" <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix unsafe socket release during namespace
 cleanup
Message-ID: <20260511123701.GI15586@unreal>
References: <20260424043522.22901-1-yanjun.zhu@linux.dev>
 <20260427123503.GI440345@unreal>
 <805dcebc-39c6-4140-b07f-f76b7594c9d8@linux.dev>
 <20260428142653.GQ440345@unreal>
 <3bc69e75-1b4b-4bb9-87c4-7db863acc3d2@linux.dev>
 <8b7650f8-2957-4318-841a-473738a605ef@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b7650f8-2957-4318-841a-473738a605ef@linux.dev>
X-Rspamd-Queue-Id: 48CD050E091
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20390-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, Apr 29, 2026 at 04:31:48PM -0700, yanjun.zhu wrote:
> On 4/29/26 6:49 AM, Zhu Yanjun wrote:
> > 在 2026/4/28 7:26, Leon Romanovsky 写道:
> > > On Mon, Apr 27, 2026 at 01:52:17PM -0700, yanjun.zhu wrote:
> > > > On 4/27/26 5:35 AM, Leon Romanovsky wrote:
> > > > > On Fri, Apr 24, 2026 at 06:35:22AM +0200, Zhu Yanjun wrote:
> > > > > > Since all the sockets are created in rdma link create command
> > > > > > and destroyed in rdma link delete command, keeping
> > > > > > udp_tunnel_sock_release in rxe_ns_exit risks a "double-free" if
> > > > > > the namespace and the device are being cleaned up simultaneously.
> > > > > 
> > > > > Please add a ladder diagram to clarify how it can be possible.
> > > > 
> > > > Hi, Leon
> > > > 
> > > > The double-free occurs as follows:
> > > > 
> > > > CPU 0 (Net NameSpace cleanup)        CPU 1 (RDMA device removal)
> > > > ---------------------                ---------------------------
> > > > rxe_ns_exit()                        rxe_link_delete() (rdma link del )
> > > >    -> sk = ns_sk->rxe_sk4               -> sk = ns_sk->rxe_sk4
> > > >    -> udp_tunnel_sock_release(sk)
> > > >       [Success: First Free]             -> udp_tunnel_sock_release(sk)
> > > >                                            [Crash: Double Free]
> > > > 
> > > > After removing the socket release logic from rxe_ns_exit(), we ensure
> > > > that only the device destruction path (rxe_link_delete) is responsible
> > > > for freeing the tunnel sockets, effectively eliminating the double-free
> > > > problem.
> > > 
> > > I think it is possible to call rxe_ns_exit() without invoking
> > > rxe_link_delete(), and in that case the UDP socket will not be
> > > destroyed.
> > 
> > Thanks, my bad. I missed this scenario.
> > 
> > Zhu Yanjun
> > 
> > > 
> > > Thanks
> > > 
> > > > 
> > > > I am not sure if I should put the above into the commit log.
> > > > 
> > > > Thanks a lot.
> 
> Hi, Leon
> 
> I have performed further tests to verify the execution order and the
> necessity of the cleanup code in rxe_ns_exit().
> 
> My findings show that a double-free race condition is unlikely because of
> how the kernel manages namespace references:
> 
> Reference Dependency: The RXE RDMA link holds a reference to the network
> namespace.
> 
> Order of Execution: When a namespace is deleted while an RDMA link exists,
> rxe_ns_exit() is not invoked immediately. It is deferred until the RDMA link
> itself is deleted (e.g., via rdma link del), which drops the final reference
> count of the namespace.

AFAIC, we've seen syzkaller reports where "rdma link del" was never invoked,  
yet RXE was removed regardless. Is it possible?

Thanks

