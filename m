Return-Path: <linux-rdma+bounces-16489-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI6uOZhXgmmISgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16489-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 21:16:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 639DCDE6A9
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 21:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EABAB3043AC4
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 20:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82C83002BB;
	Tue,  3 Feb 2026 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoCLGOZ6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B136495E5;
	Tue,  3 Feb 2026 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770149779; cv=none; b=J/QugSjhAWJjaKPck4IlTNRY4YfgB5gSO7i/7NYWPs/7MQu6UBX3dkzptGVlXPyS63jhb3zhh41cl2RVpSnlXP9mfMxUiNzSPrAgHLYPwRPTgs7//7bR3DM3z3c1HU/Nn+S/hiAyxASXLmL/yc/NRklDghim8BNFrpZQURV5yec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770149779; c=relaxed/simple;
	bh=jJGHnQHnWtWz5HD0L52IdMMxbzxznQgEWO896mHfc1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOidqCB6u6QmCobzYeubXQkEe/ZguhemwCuTb7CIxeYwm82e+FSDK57dBZxt7RwE84fKd8wM8EXOUf5iHUQ51AeMtyeYFwJ6RFe5mnPIZUzKMKubr+6WS4CwP43GU+Icvhd5AWO0V6ymDp3dxsJK2woMxMD9YqeWANGWKscPRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoCLGOZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C162AC116D0;
	Tue,  3 Feb 2026 20:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770149779;
	bh=jJGHnQHnWtWz5HD0L52IdMMxbzxznQgEWO896mHfc1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BoCLGOZ6f3p9d6rngoVLYuunajWhsk53Tgg8ztAFMRxbdbA0asY0LFCk4PFA8/kKn
	 UfpJkSFL5//IgEO/jLJiV4nF825IKoFOO5vxcsq534t5vBqJ7K308vhl4+z1kmlPpC
	 fn2Olo53DW5HKhbD46cnZUBWLV5qb9bIgTRK2dqdqKthXHQ6f0WXheQIRtoVZjOACi
	 xJ9aew77sKoBej9vwBT0woXwAztUxYchPfGaEPtqL/nJMxJZ0gLipZg/uMVkWs9ZJa
	 9PQkxr9S7n503CgrwzqWhyvaWWDS+Cxm5Zvlvd1WH4GpJsKwr4mDoMgTDp0Xb/01A+
	 D6ID4jTxepGBA==
Date: Tue, 3 Feb 2026 22:16:14 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Steve French <smfrench@gmail.com>
Cc: Stefan Metzmacher <metze@samba.org>, linux-rdma@vger.kernel.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [RFC PATCH 0/3] RDMA/smbdirect: introduce and use
 rdma_restrict_node_type()
Message-ID: <20260203201614.GZ34749@unreal>
References: <cover.1769025321.git.metze@samba.org>
 <20260128141123.GG40916@unreal>
 <1f77a9a6-9020-4d65-a6b9-fe68d4f6e46f@samba.org>
 <CAH2r5msoO_hY-U71_AHt5ns2Wf1y4Kry6g1gqFgzzXKNSA0i5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2r5msoO_hY-U71_AHt5ns2Wf1y4Kry6g1gqFgzzXKNSA0i5g@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16489-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 639DCDE6A9
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 11:37:42AM -0600, Steve French wrote:
> On Tue, Feb 3, 2026 at 9:25 AM Stefan Metzmacher <metze@samba.org> wrote:
> >
> > Am 28.01.26 um 15:11 schrieb Leon Romanovsky:
> > > On Wed, Jan 21, 2026 at 09:07:10PM +0100, Stefan Metzmacher wrote:
> > >> Hi,
> > >>
> > >> for smbdirect it required to use different ports depending
> > >> on the RDMA protocol. E.g. for iWarp 5445 is needed
> > >> (as tcp port 445 already used by the raw tcp transport for SMB),
> > >> while InfiniBand, RoCEv1 and RoCEv2 use port 445, as they
> > >> use an independent port range (even for RoCEv2, which uses udp
> > >> port 4791 itself).
> > >>
> > >> Currently ksmbd is not able to function correctly at
> > >> all if the system has iWarp (RDMA_NODE_RNIC) interface(s)
> > >> and any InfiniBand, RoCEv1 and/or RoCEv2 interface(s)
> > >> at the same time.
> > >>
> > >> And cifs.ko uses 5445 with a fallback to 445, which
> > >> means depending on the available interfaces, it tries
> > >> 5445 in the RoCE range or may tries iWarp with 445
> > >> as a fallback. This leads to strange error messages
> > >> and strange network captures.
> > >>
> > >> To avoid these problems they will be able to
> > >> use rdma_restrict_node_type(RDMA_NODE_RNIC) before
> > >> trying port 5445 and rdma_restrict_node_type(RDMA_NODE_IB_CA)
> > >> before trying port 445. It means we'll get early
> > >> -ENODEV early from rdma_resolve_addr() without any
> > >> network traffic and timeouts.
> > >>
> > >> This is marked as RFC as I want to get feedback
> > >> if the rdma_restrict_node_type() function is acceptable
> > >> for the RDMA layer. And because the current form of
> > >> the smb patches are not tested, I only tested the
> > >> rdma part with my branch the prepares IPPROTO_SMBDIRECT
> > >> sockets.
> > >>
> > >> I'm not sure if this would be acceptable for 6.19
> > >> in order to avoid the smb layer problems, if the
> > >> RDMA layer change is only acceptable for 7.0 that's
> > >> also fine.
> > >>
> > >> This is based on the following fix applied:
> > >> smb: server: reset smb_direct_port = SMB_DIRECT_PORT_INFINIBAND on init
> > >> https://lore.kernel.org/linux-cifs/20251208154919.934760-1-metze@samba.org/
> > >> It's not yet in Linus' tree, so if this gets ready
> > >> before it's merged we can squash it.
> > >>
> > >> Stefan Metzmacher (3):
> > >>    RDMA/core: introduce rdma_restrict_node_type()
> > >>    smb: client: make use of rdma_restrict_node_type()
> > >>    smb: server: make use of rdma_restrict_node_type()
> > >
> > > The approach looks reasonable.
> >
> > Thanks!
> >
> > > Do you want me to take it through RDMA
> > > tree?
> >
> > As I also have other smb patches on top changing/using
> > it I guess it would be easier if Steve would take them.
> >
> > Steve, Leon what do you think?
> 
> I am ok with taking it via the ksmbd tree (smb3-kernel ksmbd-for-next
> branch), unless it is practical to merge the RDMA changes through the
> RDMA tree in the first few days of the merge window and merge the
> ksmbd-for-next branch a few days later (which sounds potentially
> trickier)

The latter is a common merge workflow used to avoid merge conflicts, but it
is not needed here. There are no changes in the rdma-cm area for this cycle,
so I do not expect any merge conflicts during the final days of the cycle.

Thanks

> 
> 
> -- 
> Thanks,
> 
> Steve
> 

