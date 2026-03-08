Return-Path: <linux-rdma+bounces-17720-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLbEKw+drWkn5AEAu9opvQ
	(envelope-from <linux-rdma+bounces-17720-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 17:00:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D75230FDB
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 17:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EEB930265A5
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 16:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC7B30FF1E;
	Sun,  8 Mar 2026 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo5MklGg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CE124503F;
	Sun,  8 Mar 2026 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772985600; cv=none; b=On2bdCoqcDKp11+Hmyy0N0u8JZAUvqyWalZHhxDC3YJEoybOQEydtoGY+FHq2ixNiNcePMK2e2/+SYzeTQJllQO+Jnz6RcPG5ojTonbUFO4Q27ELEq3SEcHLF942hPmxl/F0xnElY5nhdZrIKQZTd6wtEVyQyK8xnAtZRYKROh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772985600; c=relaxed/simple;
	bh=Xhy6/uTGx35tiRoa+USFQkDbiY2tVV5MuJSrDtO1gps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxNtW2oX1FOZVZ/aMJ0mNdTc6Qb02hfg0kuMcUf4gGs0rjW7V3eu/mRglqZzxO7R163GlY9OpSQFDJ5PKx1DZWOqd04kgd4sKhaUOGrfN75HqQIvcPOPwk3jePODSy42Svx38fuwE2z/ACJuvhNkjRZZljqh7Nc/FlEMNthVDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mo5MklGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E41AC116C6;
	Sun,  8 Mar 2026 15:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772985600;
	bh=Xhy6/uTGx35tiRoa+USFQkDbiY2tVV5MuJSrDtO1gps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mo5MklGgxhwqpszlskVCpKBuvU8RP8Kl7iuyaxV2TosUpdMeBtLct4YScyTX0ZNqn
	 nHrDG7BUfuqyoBfoU6RC/TcFdkT+mbzcMbjc8tXp6daqUysGJNsmSZ3XiIH/JF8fEl
	 3eplWOQO5JmJuNk+tNMW78p/OmlLzzIEG4WkUew9uFdqoUSwT2xD+Fo7R940i/1h2y
	 fO4IhUGcKi3YTjDvSPceYm7HGNygBuEufJ4bQVJOlPgu7vLh/GdnyXrwa6RXC1ih2p
	 i9fKYMJPb9e228VVmx3CI4o2Q+eKYHlTzLeopSMLP+L8CIWD83cB7zwePSadH8tqyG
	 qzf/Afqjp28xg==
Date: Sun, 8 Mar 2026 17:59:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-rdma@vger.kernel.org,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-hardening@vger.kernel.org, gustavoars@kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/hfi1: kzalloc to kzalloc_flex
Message-ID: <20260308155955.GQ12611@unreal>
References: <20260308031957.90900-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308031957.90900-1-rosenp@gmail.com>
X-Rspamd-Queue-Id: 49D75230FDB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17720-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.920];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 07:19:56PM -0800, Rosen Penev wrote:
> Combine kzalloc and kcalloc with a flexible array member. Avoids having
> to free separately.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/infiniband/hw/hfi1/user_exp_rcv.c | 10 +---------
>  drivers/infiniband/hw/hfi1/user_exp_rcv.h |  2 +-
>  2 files changed, 2 insertions(+), 10 deletions(-)

This patch needs to be rebased to latest rdma-next, due to the conflict
with already merged 94ff7c59cdfd ("RDMA: Complete k[z|m|c]alloc-to-k[z|m]alloc_obj conversion").

Thanks

