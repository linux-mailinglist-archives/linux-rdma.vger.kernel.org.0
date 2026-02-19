Return-Path: <linux-rdma+bounces-17009-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPUBLaPNlmn4nwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17009-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 09:45:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 421BD15D19D
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 09:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 835D83028B06
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 08:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41AC339705;
	Thu, 19 Feb 2026 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvAbSCPK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AEF3382E0;
	Thu, 19 Feb 2026 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771490703; cv=none; b=JSYjzEsCvc9PL9XowqzQM54Fdc9iLB55u25fGIcnyTSCc6P9yk8WgMfZ1TsFA1I30/M5lLRbPbz40NorPX84/wAmcB7pI7Ew+lD7I/1EQesVMRM6UH6xhc3Be+BrQuhq3MsBTJ6c4Eea9dxBUSEWDNob2IIdWTOQxUnWr/w1UTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771490703; c=relaxed/simple;
	bh=5kNHpPiKX4K++7tGO5pKCAIuW0dXbDVYHX2I77VWWAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzh6EBFN9t+4lAtTebrVcWjMrSW/oOpeHSCPlfjw7A24obwkVclYtb2FwoNBtMkD2OGp5OnNWplm39j1VfkGMbbZV5zKzGKcj2yFiSmiAOczUHH3K4L5MRm1Y75AwT/0Gf1EvzuKyIYfeOFfz5lugaY5uPFVtxfQTzKOb6QnT9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvAbSCPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9CCC4CEF7;
	Thu, 19 Feb 2026 08:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771490703;
	bh=5kNHpPiKX4K++7tGO5pKCAIuW0dXbDVYHX2I77VWWAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvAbSCPKRvN6+5JBnwcbxHgC7LNHAga0vbrZ/A3CVNW++jaH5JaaAmbIKWacWDm3Q
	 wTjaRo9AFz0I5+QbINcaolSDYPain6/Yrr4akZRG/kRI+3xCwmYkhw+sorGlCQgCB9
	 4FRM5j74V0SaCyie1BGCWNwuuh0W21TRUr3tSAVBil+l8hfd+n6iM6S5BD3suFhCP6
	 Q/UN84YHQJtoQAecx/LaT1EcWkYdFi/M2Ux/s4T13vVfg63bxbpzbGDobUnw3QTBk/
	 zDTOLWwURtJ2vBc+9ireOR1WB7Ub2r8Fuev4SslCl2XRaXOo+dTWoQvdU0crwNyOJW
	 8tA6gQvXY6vIA==
Date: Thu, 19 Feb 2026 08:44:58 +0000
From: Simon Horman <horms@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: pabeni@redhat.com, davem@davemloft.net, allison.henderson@oracle.com,
	syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com,
	kuba@kernel.org, rds-devel@oss.oracle.com, gerd.rausch@oracle.com,
	netdev@vger.kernel.org, edumazet@google.com,
	linux-rdma@vger.kernel.org
Subject: Re: [net,v2] net/rds: fix recursive lock in
 rds_tcp_conn_slots_available
Message-ID: <aZbNirXFABxg-Fwk@horms.kernel.org>
References: <20260217223802.21659-1-fmancera@suse.de>
 <20260218100206.88254-1-horms@kernel.org>
 <59c133d4-9e5c-4eee-95c2-4a8877b052be@suse.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59c133d4-9e5c-4eee-95c2-4a8877b052be@suse.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17009-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,5efae91f60932839f0a5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 421BD15D19D
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 06:13:56PM +0100, Fernando Fernandez Mancera wrote:
> On 2/18/26 11:02 AM, Simon Horman wrote:

...

> > The commit message states "For rds_tcp_conn_slots_available() the lock is
> > already held because we are in the receiving path." Is this claim accurate
> > across all receive paths?
> > 
> > Looking at the two receive sub-paths:
> > 
> > 1. In the backlog processing path (shown in the syzbot stack trace), the
> > socket IS owned because __release_sock() runs while the lock_sock
> > ownership bit is still set:
> > 
> > tcp_sock_set_cork() -> lock_sock() -> release_sock() -> __release_sock()
> >    -> sk_backlog_rcv() -> tcp_v6_do_rcv() -> tcp_rcv_established()
> >    -> tcp_data_ready() -> sk->sk_data_ready() -> rds_tcp_data_ready()
> >    -> rds_tcp_read_sock()
> > 
> > 2. However, rds_tcp_data_ready() can also be called directly from the
> > normal softirq receive path via tcp_data_ready() -> sk->sk_data_ready(),
> > where the socket lock is NOT held. In this path, rds_tcp_read_sock()
> > calls tcp_read_sock() without lock_sock.
> > 
> > The fix is still correct in both cases because inet_dport is a stable
> > atomic-width field, but the claim "the lock is already held" is not
> > universally true for all receiving paths.
> > 
> > Should the commit message be more precise about when the lock is held?
> > 
> 
> While I think that is right, the relevant part is the atomicity. The
> operation is safe but it requires a READ_ONCE() annotation probably.

Thanks. I don't have a deep understanding of this.
But I agree that seems correct.

