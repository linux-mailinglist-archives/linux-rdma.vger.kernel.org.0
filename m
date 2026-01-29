Return-Path: <linux-rdma+bounces-16206-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGNxHO2Re2nOGAIAu9opvQ
	(envelope-from <linux-rdma+bounces-16206-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 17:59:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBF9B28F4
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 17:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30CC93047064
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 16:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220F6346792;
	Thu, 29 Jan 2026 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI7pA1Rc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5674345754;
	Thu, 29 Jan 2026 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705706; cv=none; b=u4qgcRQEI4W0cmYkHNolAELe/ePgziXqVOYV9R3r6SyV3fdD/kyZyW58Cx+K0X/sNEV/xEiERsDazOrhJRNGEvuy2hN3FM0xp0JPkpgHXNZiLLy6bKlNQlaoWyKKtD8AXj39jG7Ue0JbAtOI5vNa/4pznOPJqTml2QYEZzW5v+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705706; c=relaxed/simple;
	bh=b5kipVY4HnifU2Q4aFa3jAY1I6v7pAXcmmwljQ7L7DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYigAIrM/aYbi69pWfKNaq/TunaKQDbCPTbEwZMiA+wZVxvrik+f7k1/ApyARU9JyQBVoNzurKgCozDBvJi9b5puvSo+AD8Vb3SdJv97tyKj2Qd2QIkIdcUxkWcxxGIjif9vcLiwkPzplPCfIfRYNvIEZ3xfczeNPohyHcBPbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI7pA1Rc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE4AC19422;
	Thu, 29 Jan 2026 16:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769705706;
	bh=b5kipVY4HnifU2Q4aFa3jAY1I6v7pAXcmmwljQ7L7DE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jI7pA1Rc5/Dsw+MKhJQ9Ql9y2yDwPSDXinSbL1JvcRExPZE9057wZ0JQsHIj+9VcK
	 ClhzCdmKqzcVb93KxDWgvX4t6qW8mqmLCKKyy0oj8w725n3mWU81QvkbbChcxj4RML
	 SjtUvFmfdOeNTzK/HNy38UI5p75OqAk80+4RcOzknUqbEBoEQQaDk9bInKm9qOheJd
	 e5sAG/HaiiA9hEjoq6E79OIzu/UegpL7GdHAEMxy/9n7v+dwAbfNkwjt45irkwzvJA
	 0TiDdouSo2Rav1jkkM9y9U+vpMf8zpaUsV0rl8e4sfOObkW2PlB63vxvuB18UFOjlt
	 nAM6a7u6mmJIQ==
Date: Thu, 29 Jan 2026 16:55:00 +0000
From: Simon Horman <horms@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, oliver.yang@linux.alibaba.com,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH net] Revert "net/smc: Introduce TCP ULP support"
Message-ID: <aXuQ5HoYULzQlFD9@horms.kernel.org>
References: <20260128055452.98251-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128055452.98251-1-alibuda@linux.alibaba.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16206-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DCBF9B28F4
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 01:54:52PM +0800, D. Wythe wrote:
> This reverts commit d7cd421da9da2cc7b4d25b8537f66db5c8331c40.
> 
> As reported by Al Viro, the TCP ULP support for SMC is fundamentally
> broken. The implementation attempts to convert an active TCP socket
> into an SMC socket by modifying the underlying `struct file`, dentry,
> and inode in-place, which violates core VFS invariants that assume
> these structures are immutable for an open file, creating a risk of
> use after free errors and general system instability.
> 
> Given the severity of this design flaw and the fact that cleaner
> alternatives (e.g., LD_PRELOAD, BPF) exist for legacy application
> transparency, the correct course of action is to remove this feature
> entirely.
> 
> Fixes: d7cd421da9da ("net/smc: Introduce TCP ULP support")
> Link: https://lore.kernel.org/netdev/Yus1SycZxcd+wHwz@ZenIV/
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Reviewed-by: Simon Horman <horms@kernel.org>


