Return-Path: <linux-rdma+bounces-9375-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98551A85CF9
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 14:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF90E17748B
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 12:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BA029B212;
	Fri, 11 Apr 2025 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LibqZGDO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E4B238C29;
	Fri, 11 Apr 2025 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744374165; cv=none; b=AK60Fdr8syof8X6rWVZcm/H0PUA935Y8WAb+0P8TrhURq0bFx6Zu/6gS3uzrVOPj1sML7q9jC3u+ZmYL+mBjHSC5ZKO9jJFSNYDfdx4zjCwZfCgHmS6GLyrDrNF01tcDLphfcnMG+sSYRUPsLtkVA87jwAxA0ihvIB9S45AX/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744374165; c=relaxed/simple;
	bh=equTgokpuZkQxYIZ9DBl3iW8zloSceBoyhSWlBB/p74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MivX7pT9y8LtcaGu7GQ2hC9JA64mf529KFjCdtXT8I4h+6Q1DEqSD0MgcRNgkKr0ZWhO3UbTpY2nbBhShYX7m0idLf+4bR5OWievyKrQ0p7PMDRPfNwkFQmrfJn/EzhAmdeb9eLhJ0SolqDrAD0Q3qVvyb+zdj9kt27tjF9Ql24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LibqZGDO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/Dr1EVnQsm860pDgPjXDhoAUeaZ+4e/5Ai84hP8ZNJo=; b=LibqZGDO63LY/KDGsKMHpYwhI1
	8qj0pjT7qLtKFPMzyk6FfS2pFGGSy7pdktoMh2SdcmKA6lWeUJvHWGfAjyN7cj3ME8mdnPKRARFJt
	5k5YrzCsJ/fM/2vC+eb5oqrF4EvpQn/G7X8wgtYpqbpYq9i0xsm6NO9D9dXSa9t1KuKE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u3DOm-008nts-Va; Fri, 11 Apr 2025 14:22:20 +0200
Date: Fri, 11 Apr 2025 14:22:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [RFC PATCH] net/smc: Consider using kfree_sensitive() to free
 cpu_addr
Message-ID: <19237943-5a2d-4930-9aa5-6419819ff51c@lunn.ch>
References: <20250411044456.1661380-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411044456.1661380-1-zilin@seu.edu.cn>

On Fri, Apr 11, 2025 at 04:44:56AM +0000, Zilin Guan wrote:
> Hello,
> 
> In smcr_buf_unuse() and smc_buf_unuse(), memzero_explicit() is used to
> clear cpu_addr when it is no longer in use, suggesting that cpu_addr
> may contain sensitive information.
> 
> To ensure proper handling of this sensitive memory, I propose using
> kfree_sensitive()/kvfree_sensitive instead of kfree()/vfree() to free
> cpu_addr in both smcd_buf_free() and smc_buf_free(). This change aims
> to prevent potential sensitive data leaks.

There is another possible meaning:

			memzero_explicit(conn->sndbuf_desc->cpu_addr, bufsize);
			WRITE_ONCE(conn->sndbuf_desc->used, 0);

The WRITE_ONCE() probably tells the hardware the buffer is ready for
it. In order to ensure they memzero has completed and that the
compiler does not reorder the instructions you need a memory barrier:

static inline void memzero_explicit(void *s, size_t count)
{
	memset(s, 0, count);
	barrier_data(s);
}

So it could be using memzero_explicit() just for the barrier_data().

Please spend some time to analyze this code, look at the git history
etc, see if there are any clues as to why memzero_explicit is used, or
if there is any indication of sensitive information.

	Andrew

