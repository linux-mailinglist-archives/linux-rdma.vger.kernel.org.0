Return-Path: <linux-rdma+bounces-16158-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOPwE/IZemlS2QEAu9opvQ
	(envelope-from <linux-rdma+bounces-16158-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 15:15:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5458AA296F
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 15:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1329430000A6
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 14:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2515226056D;
	Wed, 28 Jan 2026 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fX70evCQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7348A26C39E;
	Wed, 28 Jan 2026 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609487; cv=none; b=khwGZiGjh6DSFO4vaIMssyM8KQdAzLVLFkq2xCIS4YaGut99u3RL+hhGFTpmHsUXObl1h+EOwrbnUj3W5rKDOCeRWxxf0l/5Tdsk+cQm7D96BsndcOcBFf4A+5WJnxKuSlyD2zw3V97s6O0jg/PaCBafzPQDZMf1FKqQgug2POQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609487; c=relaxed/simple;
	bh=NeCsJKpQ1A8EmAKIgTzJT47TrR9C6KHVrQEyy0hkTTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgAUApNzFNCx7cBIqQzKxbpqhaoWsVqgJsEVEENccY7X08lHmagcpzvTIiZhrAliqWYXNxnEEKf/EM5AgBnwFFHCx9CFjzMVRnZwb1xKxJRi2Hwex0RpOwgXigchc0KIexrqMrAKn4nNscGHcIM7+2k0rN5ogEY56L/De3bBW2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fX70evCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF4AC116C6;
	Wed, 28 Jan 2026 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769609486;
	bh=NeCsJKpQ1A8EmAKIgTzJT47TrR9C6KHVrQEyy0hkTTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fX70evCQLvMC0bS+86dVvfP6EkkB3dgn5p3xGFkoZfkvRjHg4jwzZi/qUSnB0F2/S
	 /tx3Mg7R5o6lFycwsotp3qvaRr3DrPv1L730XlDweKOii0aq34gtiaieIyJaBc+ULy
	 Crq+pIL5Hy36wSMiaOeuhMhh6Oc44RbTbM/jYAWlnQ3jdgS49Mqx2pfCJORcBiABwx
	 8Wu+HuoMPloQeUniIMLDoyH8UbARFvdDPC1EmMs/jyLyAKePN0FTmO4P+GhDeysCYm
	 q74vWuDwIAGN+DG/mNk7hLRzQC1RskpYrDahk95DRwyn7e5jNc4RxUn9rsQuyv7WF5
	 FscUFnH2tt1LQ==
Date: Wed, 28 Jan 2026 16:11:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-rdma@vger.kernel.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [RFC PATCH 0/3] RDMA/smbdirect: introduce and use
 rdma_restrict_node_type()
Message-ID: <20260128141123.GG40916@unreal>
References: <cover.1769025321.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769025321.git.metze@samba.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.samba.org,ziepe.ca,gmail.com,talpey.com,microsoft.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-16158-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5458AA296F
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 09:07:10PM +0100, Stefan Metzmacher wrote:
> Hi,
> 
> for smbdirect it required to use different ports depending
> on the RDMA protocol. E.g. for iWarp 5445 is needed
> (as tcp port 445 already used by the raw tcp transport for SMB),
> while InfiniBand, RoCEv1 and RoCEv2 use port 445, as they
> use an independent port range (even for RoCEv2, which uses udp
> port 4791 itself).
> 
> Currently ksmbd is not able to function correctly at
> all if the system has iWarp (RDMA_NODE_RNIC) interface(s)
> and any InfiniBand, RoCEv1 and/or RoCEv2 interface(s)
> at the same time.
> 
> And cifs.ko uses 5445 with a fallback to 445, which
> means depending on the available interfaces, it tries
> 5445 in the RoCE range or may tries iWarp with 445
> as a fallback. This leads to strange error messages
> and strange network captures.
> 
> To avoid these problems they will be able to
> use rdma_restrict_node_type(RDMA_NODE_RNIC) before
> trying port 5445 and rdma_restrict_node_type(RDMA_NODE_IB_CA)
> before trying port 445. It means we'll get early
> -ENODEV early from rdma_resolve_addr() without any
> network traffic and timeouts.
> 
> This is marked as RFC as I want to get feedback
> if the rdma_restrict_node_type() function is acceptable
> for the RDMA layer. And because the current form of
> the smb patches are not tested, I only tested the
> rdma part with my branch the prepares IPPROTO_SMBDIRECT
> sockets.
> 
> I'm not sure if this would be acceptable for 6.19
> in order to avoid the smb layer problems, if the
> RDMA layer change is only acceptable for 7.0 that's
> also fine.
> 
> This is based on the following fix applied:
> smb: server: reset smb_direct_port = SMB_DIRECT_PORT_INFINIBAND on init
> https://lore.kernel.org/linux-cifs/20251208154919.934760-1-metze@samba.org/
> It's not yet in Linus' tree, so if this gets ready
> before it's merged we can squash it.
> 
> Stefan Metzmacher (3):
>   RDMA/core: introduce rdma_restrict_node_type()
>   smb: client: make use of rdma_restrict_node_type()
>   smb: server: make use of rdma_restrict_node_type()

The approach looks reasonable. Do you want me to take it through RDMA
tree?

Thanks

> 
>  drivers/infiniband/core/cma.c      |  30 ++++++++
>  drivers/infiniband/core/cma_priv.h |   1 +
>  fs/smb/client/smbdirect.c          |  26 +++++++
>  fs/smb/server/transport_rdma.c     | 108 +++++++++++++++++++++--------
>  include/rdma/rdma_cm.h             |  17 +++++
>  5 files changed, 154 insertions(+), 28 deletions(-)
> 
> -- 
> 2.43.0
> 

