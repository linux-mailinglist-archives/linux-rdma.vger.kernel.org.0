Return-Path: <linux-rdma+bounces-17515-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPelAT1OqWk14AAAu9opvQ
	(envelope-from <linux-rdma+bounces-17515-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 10:34:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFB220E85D
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 10:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 608E1303135F
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 09:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E5D377EBC;
	Thu,  5 Mar 2026 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWUPgzwu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562DF3793C0
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703147; cv=none; b=nNFymfbAqW7NEsFfcroHcS6AOeO6Wu4bQiRpg3JZuwSp69In00m0hXE3F/k0PuMPTkl/y/ljJIYbw3CR4EBNS/b3dMbsBLJ0f+w5khkBzkQ4Ol6C9xWvM7KbmVR1RNmhBaGUvp60eH3oSarVV2tSX409UsxdLdJuDUgOr6Uxz00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703147; c=relaxed/simple;
	bh=ZGdt8kUneebKlindVnnMh7D7ypvyf/wCmHuecsc56+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6KbA4N7u/HysUzew7TC2IVW4wid6hKdMvSWq63jnZ9dU63A8iER+HR68kIiQNH3FdkqoLWl4YmndtJAVX8X7EyAFpSqlHig+G4fRzYX6uSAG6y+ly3uB+7ZNdG7KU5MxhmQUEcBrbpmODPQly66g3s6dXOlkPLwotEfwO+KeMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWUPgzwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAD3C116C6;
	Thu,  5 Mar 2026 09:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772703146;
	bh=ZGdt8kUneebKlindVnnMh7D7ypvyf/wCmHuecsc56+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kWUPgzwuotRricqZ5I+7SmDgVLRvNK0jsM2lROjV6MdgqPQBfOAWitfhbuHjQ5FmW
	 asf6LbXrv7JtwuNtiKk1sipVhlCKUHPOVTU8FWq3bMABv5r/TNIKfRnbX3gwII7XVg
	 L7E/EyW6uG9FmHsjVbZiFZOaEpCscsRLGoIl/fOWRIjbna2iw5S8cLqrgjcWx60R5p
	 /ttTipHbyQcNF+aRTSEGz3Uc1ehC+6WimKG2zUf56X0GBnTROnEAj2ANlr+79tfXMt
	 SUE2vxiAuyCFW5kbLlCRzso5d53ouWi0NM2VwQ5wy8SBtdVCVd90F6j2y2UMUefQKc
	 0ZZqdCXxuiSkw==
Date: Thu, 5 Mar 2026 11:32:22 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kamal Heib <kheib@redhat.com>
Cc: linux-rdma@vger.kernel.org,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-rc] RDMA/bng_re: Fix silent failure in HWRM version
 query
Message-ID: <20260305093222.GM12611@unreal>
References: <20260303043645.425724-1-kheib@redhat.com>
 <20260304153707.GG12611@unreal>
 <aaj9VLGLHWESm0kw@lima-fedora>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaj9VLGLHWESm0kw@lima-fedora>
X-Rspamd-Queue-Id: 9FFB220E85D
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17515-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 10:49:40PM -0500, Kamal Heib wrote:
> On Wed, Mar 04, 2026 at 05:37:07PM +0200, Leon Romanovsky wrote:
> > On Mon, Mar 02, 2026 at 11:36:45PM -0500, Kamal Heib wrote:
> > > If the firmware version query fails, the driver currently ignores the
> > > error and continues initializing. This leaves the device in a bad state.
> > 
> > Can you please elaborate what will it cause?
> > 
> > Thanks
> >
> 
> If bng_re_query_hwrm_version() fails, the code returns early and leaves
> cctx->hwrm_cmd_max_timeout uninitialized. This parameter is subsequently
> assigned to rcfw->max_timeout, which is used by __wait_for_resp(). Later,
> when the driver sends firmware commands and enters __wait_for_resp(), it
> passes a zero timeout to the commands being sent, which can lead to a
> lockup.
> 
> Also, cctx->hwrm_intf_ver is left uninitialized, which will likely
> be used in the future to determine if a specific feature is supported
> or not (like how it is done in bnxt_re).

I'm not concerned about these flows. If something as fundamental as querying
the HW version fails, it's likely that nothing else will behave correctly.

Let's apply this patch.

Thanks

