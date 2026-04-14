Return-Path: <linux-rdma+bounces-19350-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMieAIN33mmcEgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19350-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 19:21:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A17AC3FD030
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 19:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C68330B0B84
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 17:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DBF3ED5D4;
	Tue, 14 Apr 2026 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcgOp+nS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7A23ED10F;
	Tue, 14 Apr 2026 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776187021; cv=none; b=WU71H2WGiKes49f6/fQEYULLjVHDW8zwfYoXkRF79xYYs8CFHOHrcHGG6oa4uokRYCGZaB2uI999s1Z3lbehILevrZhhKRYXMwsARkiUgkOmEPBtYLpVjeIxz2SD/YA4nqiAvB3/PZA2DXbQNSthAgvKfpXpEd8aESCYDRgypnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776187021; c=relaxed/simple;
	bh=f0qKwArB0ojtq47vAFre2SyA24zWTDVmi8aWOSYs8CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIAClUjo7t9qWxhrkqVbuMOHVWSJFvVGotcCcorjX5+3a9mWhCgMtMZ5cguFAFKghu3f2pvIDjTrljObLamiL0RDI+UZo6VAXlRTLUp3w/yzQ+h0oDlr0aGKZWvsH8QArQl1qbdB4u7m6Ln9BHluzCGTE7RFMjpRORNXvsatZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcgOp+nS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E65FC19425;
	Tue, 14 Apr 2026 17:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776187020;
	bh=f0qKwArB0ojtq47vAFre2SyA24zWTDVmi8aWOSYs8CY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcgOp+nSypTlAwKAW3t+oXiN7jUamE+Pah5A2Y5NPlT7DYlQMDI8EE7resb0GNz60
	 9wrpGFczkrp1P+H7OPNxPkgaqmtqKNOsv9SEQq4CTasODJCYFCNEM0p15kRsweObE6
	 moJGrdxWrHH/nzuDc0K2VQoGWQ0nUltoy3pHnVrRhzggh6BHR3csv3lswBxqbiaxfS
	 aKOD+309XbuKlrPETi1ezWvvR6ZZ3022AWaZsV3PFJbHDCKB8w91dUX3sL6vkIwQlp
	 ZXzfUCIYvON10o4lhJyP39f5/BHwgjS1lL03R2NinPci/XKDuAOybMCQdZTLaliBqe
	 VewaVD2FOpG9w==
Date: Tue, 14 Apr 2026 18:16:55 +0100
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
	pasic@linux.ibm.com
Subject: Re: [PATCH net-next v2] net/smc: cap allocation order for SMC-R
 physically contiguous buffers
Message-ID: <20260414171655.GB772670@horms.kernel.org>
References: <20260407124337.88128-1-alibuda@linux.alibaba.com>
 <20260410151631.GY469338@kernel.org>
 <20260414021054.GA111420@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260414021054.GA111420@j66a10360.sqa.eu95>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19350-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: A17AC3FD030
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 10:10:54AM +0800, D. Wythe wrote:
> On Fri, Apr 10, 2026 at 04:16:31PM +0100, Simon Horman wrote:
> > On Tue, Apr 07, 2026 at 08:43:37PM +0800, D. Wythe wrote:
> > > The alloc_pages() cannot satisfy requests exceeding MAX_PAGE_ORDER,
> > > and attempting such allocations will lead to guaranteed failures
> > > and potential kernel warnings.
> > > 
> > > For SMCR_PHYS_CONT_BUFS, cap the allocation order to MAX_PAGE_ORDER.
> > > This ensures the attempts to allocate the largest possible physically
> > > contiguous chunk succeed, instead of failing with an invalid order.
> > > This also avoids redundant "try-fail-degrade" cycles in
> > > __smc_buf_create().
> > > 
> > > For SMCR_MIXED_BUFS, no cap is needed: if the order exceeds
> > > MAX_PAGE_ORDER, alloc_pages() will silently fail (__GFP_NOWARN)
> > > and automatically fall back to virtual memory.
> > > 
> > > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > > Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> > > ---
> > > Changes v1 -> v2:
> > > https://lore.kernel.org/netdev/20260312082154.36971-1-alibuda@linux.alibaba.com/
> > > 
> > > - Move the bufsize cap from smcr_new_buf_create() up to
> > >   __smc_buf_create(), which is simpler and avoids touching
> > >   the allocation logic itself.
> > 
> > The nit below notwithstanding, this looks good to me.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > > ---
> > >  net/smc/smc_core.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> > > index e2d083daeb7e..cdd881746e21 100644
> > > --- a/net/smc/smc_core.c
> > > +++ b/net/smc/smc_core.c
> > > @@ -2440,6 +2440,10 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
> > >  		/* use socket send buffer size (w/o overhead) as start value */
> > >  		bufsize = smc->sk.sk_sndbuf / 2;
> > >  
> > > +	/* limit bufsize for physically contiguous buffers */
> > > +	if (!is_smcd && lgr->buf_type == SMCR_PHYS_CONT_BUFS)
> > > +		bufsize = min_t(int, bufsize, (PAGE_SIZE << MAX_PAGE_ORDER));
> > 
> > nit: I think min() is sufficient here, and the inner parentheses are
> >      unnecessary
> 
> Hi Simon,
> 
> I think min_t is required here because min() triggers a signedness
> error:
> 
> ././include/linux/compiler_types.h:706:38: error: call to
> ‘__compiletime_assert_950’ declared with attribute error: min(bufsize,
> ((1UL) << 12) << 10) signedness error
> 
> The inner parentheses can be removed, though.

Ack, thanks for checking.

