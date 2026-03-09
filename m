Return-Path: <linux-rdma+bounces-17764-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Z+GFNYaYrmmqGgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17764-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:53:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB142368EA
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34E713002B78
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 09:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3384D3859D6;
	Mon,  9 Mar 2026 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0AdtJWC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74100382397;
	Mon,  9 Mar 2026 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773049978; cv=none; b=HltBR12fFzUidJdHE5jlWWwi7H262JaIE/pGPIZvpx9MlY7P/GbS90+kFBe5Dq9Df16wb32Exns5C71cb9MFAAkY1wraMG0OQ20ZX9X9kQ9JPOQAfy93s7x7J7YLUAfnm/CJFdvGp4criuqipjznKKW7j4TyE0DnrpLoZlyLFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773049978; c=relaxed/simple;
	bh=bUAc0H3mPRXhsXjf8c0Nl9P1dvL65VTVMu1vBTUX1co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSyv651x1oQrQc/Ub8dPDSqqvzi6lxEhwbuA0EDQuJ3zPZJUW2i7Q5D47hWCB+UGO+ZwZYv5FIv8wYj/4jpZePqSGt+BFpznSjmP+BjrxvZBeARs2YcvNtk5arZ1z7dEYFd/M1aVmPXxSSK522nnBnI7+D2t3IA0QIL7ZJnjhQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0AdtJWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6734DC19423;
	Mon,  9 Mar 2026 09:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773049977;
	bh=bUAc0H3mPRXhsXjf8c0Nl9P1dvL65VTVMu1vBTUX1co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0AdtJWC9xYrpXbcXvIP9fuHntqJoC8HPU7zZkm0dkTVf30qL0Zv6dBcp4Ja7Bv70
	 X9k1gcvqqJ/T/VaAvUujC0X6iiD/58mND5LPgYcI4Fo0jeMPuyUZ+2Dsd49TlHMBkj
	 3H8igSmPfVfaBy4UYkA5kPYvbA1WnRnH1xNYjZQRQlWm4DR7jmXDoOSw2u7mN789sF
	 vjeNwTgRR39HUMsMMmMZMAYZMMQTXXfuEgCA39a8UQoRAo7v+TcCXMIU02T8gja8rA
	 v6xUCATnPmbpgzCVNphoEkvdBeQ2KoROwayAVQDq2E3K94oyrc/1iT6NzK0+RiyHn0
	 Kd3Bem3UpnJJg==
Date: Mon, 9 Mar 2026 11:52:54 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-rdma@vger.kernel.org,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-hardening@vger.kernel.org, gustavoars@kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/hfi1: kzalloc to kzalloc_flex
Message-ID: <20260309095254.GT12611@unreal>
References: <20260308031957.90900-1-rosenp@gmail.com>
 <20260308155955.GQ12611@unreal>
 <CAKxU2N_3dmBQPyD84GkyecxO=+5mQVVmSgY0jfGSugFtXvZ4UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N_3dmBQPyD84GkyecxO=+5mQVVmSgY0jfGSugFtXvZ4UQ@mail.gmail.com>
X-Rspamd-Queue-Id: CDB142368EA
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
	TAGGED_FROM(0.00)[bounces-17764-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.922];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 08, 2026 at 01:09:31PM -0700, Rosen Penev wrote:
> On Sun, Mar 8, 2026 at 9:00 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Sat, Mar 07, 2026 at 07:19:56PM -0800, Rosen Penev wrote:
> > > Combine kzalloc and kcalloc with a flexible array member. Avoids having
> > > to free separately.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  drivers/infiniband/hw/hfi1/user_exp_rcv.c | 10 +---------
> > >  drivers/infiniband/hw/hfi1/user_exp_rcv.h |  2 +-
> > >  2 files changed, 2 insertions(+), 10 deletions(-)
> >
> > This patch needs to be rebased to latest rdma-next, due to the conflict
> > with already merged 94ff7c59cdfd ("RDMA: Complete k[z|m|c]alloc-to-k[z|m]alloc_obj conversion").
> https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/?id=94ff7c59cdfd
> 
> Notice: this object is not reachable from any branch.
> 
> I'll take your word for it and rebase based on that.

You looked at my private repo, while the patch exist in official RDMA
repository.

https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?id=94ff7c59cdfd

Thanks

> >
> > Thanks

