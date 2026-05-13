Return-Path: <linux-rdma+bounces-20578-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKA8N+WJBGoxLQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20578-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 16:25:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 85006535042
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 16:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E095D307D56D
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 14:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D3E313523;
	Wed, 13 May 2026 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btvFvurg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB03128D9
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681546; cv=none; b=cfNemgjHH2ejiC0FV3+SsFoApiIT/yOBWE3qDv0RGmQiCzyEfM4rN2QHeZIb6eE+JG85CE8VQ1vg/QjQjumJZ5PDP2l/oUuCx9icwT51U78n+xPL2cN0NFUvt7cgWsPYlJ8VIfDrSeRI5U5Rjfi6jqiuhf4K3j1Dr7Bf/7dWd6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681546; c=relaxed/simple;
	bh=dJI4JAGN1LWY5a0T7cgqXFhZfm6IFjUBaxt6RHhuuJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQNArYiAU5FFWml31Ll80pt+2BmCVOkwrpQSLJssx+wPCs6QJsy8j36ULlf1cDKh0uLkKXoorDhloXXd7OchY6ItM+CmKBigSVYj6HidjOS3HxHO/Bfyx1uTaEy+ej6rQXAD5LfMG34sx+n+M1kSVL0qoHTOOb6O4fF4E/48HJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btvFvurg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B45C19425;
	Wed, 13 May 2026 14:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778681546;
	bh=dJI4JAGN1LWY5a0T7cgqXFhZfm6IFjUBaxt6RHhuuJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btvFvurg0XZ8Z3019S68M5s+Yfi9ix+pc+rJ8ZQpsqWl92tk+AWQB7n3AIe6KaHSq
	 ZGxZ8f0W3rJghKEgI5V0GllmVGHSxKrVdfjRSqyoeiMWkc52QHe6Kl+O8luJI4fGyP
	 sMpqGfdGHLHToGlA+i9Qi6r8pDVnCZ3r5o2Z6IVJYcmXY++ZZeKHx/ORKPx14fGTBL
	 6bETiGPeSMolggcBe+CEWVPEmAH9QszP8Um7dpogzxkCRS+bTODYXBo9b0NtcUWmSx
	 hkor5eZYy7O5QTyi/EHTMp39GK2aak/lxe5wiPz5E7Pt9TuP0QeBwjhlEtlozxBY2d
	 r1yV2ze9N34vA==
Date: Wed, 13 May 2026 17:12:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Boshi Yu <boshiyu@linux.alibaba.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: Re: [PATCH for-next 3/3] RDMA/erdma: Implement
 erdma_reg_user_mr_dmabuf
Message-ID: <20260513141221.GF15586@unreal>
References: <20260507053437.46211-1-boshiyu@linux.alibaba.com>
 <20260507053437.46211-4-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507053437.46211-4-boshiyu@linux.alibaba.com>
X-Rspamd-Queue-Id: 85006535042
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20578-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,alibaba.com:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 01:34:21PM +0800, Boshi Yu wrote:
> Support DMA-BUF based user memory registration by adding the
> erdma_reg_user_mr_dmabuf() callback. We refactor the existing
> erdma_reg_user_mr() into a common _erdma_reg_user_mr() function
> that handles both regular and DMA-BUF memory registration.
> 
> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
> Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_main.c  |  1 +
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 55 ++++++++++++++++++-----
>  drivers/infiniband/hw/erdma/erdma_verbs.h |  6 +++
>  3 files changed, 51 insertions(+), 11 deletions(-)

It appears Sashiko has some feedback:
https://sashiko.dev/#/patchset/20260507053437.46211-1-boshiyu@linux.alibaba.com

The comments regarding ib_umem_find_best_pgsz() seem worth addressing.

Thanks

