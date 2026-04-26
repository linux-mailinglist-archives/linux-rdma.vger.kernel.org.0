Return-Path: <linux-rdma+bounces-19560-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDe/HlAJ7mnYqAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19560-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 14:47:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF710469D59
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 14:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A8303007AF9
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 12:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C97E35BDD5;
	Sun, 26 Apr 2026 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiYa0QhD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E2513AD26
	for <linux-rdma@vger.kernel.org>; Sun, 26 Apr 2026 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777207627; cv=none; b=G0gU1dcuimuJIbNFBWr86P5nxcuMEytqLJUEWo4bpbOmm6L9iHjFV7jtmc/5lUygiDV60ndDAso2ph14bFiw/tN8Egcn+1TfWMQr9CJ3jNAVNpIZZahZgopdMHHlRiuJwuLUDADytH5o8oFrSxDOozby2WnaIKkWKZcEdY1tpnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777207627; c=relaxed/simple;
	bh=wXVyMtma0AabZ2Cvc90jgPHrpjbhc7HhL0caYZrUyEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHqxy50DNHsAxpjWNWpD7I36t3CrLOc6+hahZear6/Nyn+tFKqdsebVpdu4ToRJXErHCNfwYV9VHzH4k/EFAb87grrdSNzwhRJs3jYSV/9apO8Q8nA+AzLuqyqPwfmKOauO2o0AQ2JT6E+fQpFh8eBVHW/fopMey2nYS8YzTQcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiYa0QhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E16C2BCAF;
	Sun, 26 Apr 2026 12:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777207627;
	bh=wXVyMtma0AabZ2Cvc90jgPHrpjbhc7HhL0caYZrUyEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oiYa0QhD6LQqDKW7Kp/jde/brl272MJJ7E+x4QajVZlqjlTdJsnjkxTtzd2sd5lFp
	 oveaBhZCqIJ4rKfkYZfabTSvYzE7bC/pzOZGY8iKyOPFI82cw2nCOg16LAhQO7f5xa
	 rjzI72onyugG1F0yWMxHvgBOTH1IWksIXAfki7xhcYpJrusKTQwQ+e/mmxOf/gSVtR
	 m3LusLIBJ9ig0yo7mWGlLWLNoQeX80SWRtS0AybWba0YQHFBWN2GVPhHvRJ6Vx0dt/
	 sYEjm2Yfvhi27DrrVTgmaMz2Cccf/mzL2T7rNjJqpJPrTwcCX140EOxmXP+YHf0p1b
	 6/rsOgNOh5xZA==
Date: Sun, 26 Apr 2026 15:47:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tao Cui <cuitao@kylinos.cn>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/2] RDMA/nldev: add resource summary max values for
 usage rate display
Message-ID: <20260426124701.GG440345@unreal>
References: <20260423061352.359749-1-cuitao@kylinos.cn>
 <20260426124223.GF440345@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260426124223.GF440345@unreal>
X-Rspamd-Queue-Id: CF710469D59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19560-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sun, Apr 26, 2026 at 03:42:23PM +0300, Leon Romanovsky wrote:
> On Thu, Apr 23, 2026 at 02:13:51PM +0800, Tao Cui wrote:

<...>

> > @@ -426,6 +427,9 @@ static int fill_res_info_entry(struct sk_buff *msg,
> >  	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR, curr,
> >  			      RDMA_NLDEV_ATTR_PAD))
> >  		goto err;
> > +	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX, max,
> > +			      RDMA_NLDEV_ATTR_PAD))
> > +		goto err;
> 
> From an implementation perspective, this is not an appropriate place to
> store this information. It will result in reporting the same value
> (max_XXX is per‑device) across multiple objects.

Alright, after a closer review, please disregard my earlier comment.

> 
> Thanks
> 

