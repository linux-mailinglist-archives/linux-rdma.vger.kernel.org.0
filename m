Return-Path: <linux-rdma+bounces-16033-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPfWAL/Ed2nckgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16033-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 20:47:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E228CBAB
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 20:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA79A3008308
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 19:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9808186250;
	Mon, 26 Jan 2026 19:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcTXllhu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDEE1C84B8;
	Mon, 26 Jan 2026 19:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456822; cv=none; b=eukYBKs/xguNw1pYioGaWibdT2/ydWhFlRPYEPUNn4xyWy+uSpSvqpMyTZlOuhq/BkUg17pKqDkk1ZIfFZnVvO7YbKF9maUQIsPyv2JWQ2EKQ5Az2GxIPropoiqDDoFIL4eWevZdwtcR9v2Mr5vbPDpR/Fa1tJwMG65fnPpLBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456822; c=relaxed/simple;
	bh=Ej4YkzeRliwgjkiZomTLy1mKyJSW8sQlElSDBlVVbYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDhoWF+Sq3cRcelQiiDVjM7pnNvdb/hLVoIbTIphzlOExP7sgIbzfk3X3j2jLCuF/9y4E3kUAqXu5cMKtBVvdbzEyYpL5aB/7X9LNWMbHY5Ay76X//lIhnhAXkPkN9mC/ySoA5vkPeh1j9S/3becsQYB2hpaJl8PF34eBf2TAhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcTXllhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EBAC2BC86;
	Mon, 26 Jan 2026 19:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769456822;
	bh=Ej4YkzeRliwgjkiZomTLy1mKyJSW8sQlElSDBlVVbYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jcTXllhu4mqX9VySexWU2ilHKDmSjg60/rJfNAYZ//oRDUNylK7eEFYLBzcHDctMB
	 2QLq+w3IWDFmiMkzloRwD92rT59s+jn86KAmNqNoqFmUxsRZ+23mgnzuuLKhcKbpsR
	 Mtkz2LUiCzotWaSfVBJ7BRDYYKvXFYpeBpnVmDMDdceJD6pV+LWobMxCHlr33iWwEX
	 cujHXGy59iO1ASmbavq2N5/r6R0LqdPGZeKrECVorGdFb4W08T6fch8denoGJD6k+m
	 e36Ljpu/hpoVFk2rqTctV/XspGyQsgBm0zGNGPl4d5Z2DVRyYFFmEfXzrFIPPq3UI9
	 8fMw3LVoLRUOQ==
Date: Mon, 26 Jan 2026 21:46:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Carlos Bilbao <carlos.bilbao@lambdal.com>
Cc: mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
	bilbao@vt.edu, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, carlos.bilbao@kernel.org
Subject: Re: [PATCH] RDMA/irdma: Use kvzalloc for paged memory DMA address
 array
Message-ID: <20260126194655.GN13967@unreal>
References: <70f5170f-70eb-4244-9049-a994ec503ac6@lambdal.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70f5170f-70eb-4244-9049-a994ec503ac6@lambdal.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16033-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25E228CBAB
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 10:54:36AM -0800, Carlos Bilbao wrote:
> Allocate array chunk->dmainfo.dmaaddrs using kvzalloc() to allow the
> allocation to fall back to vmalloc when contiguous memory is unavailable
> (instead of failing and logging page allocation warnings).
> 
> Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
> ---
>  drivers/infiniband/hw/irdma/utils.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

This patch doesn't apply to rdma/for-next.

Thanks

