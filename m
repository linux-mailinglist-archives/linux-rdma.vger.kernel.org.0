Return-Path: <linux-rdma+bounces-19315-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNxoG12i3Wl8hAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19315-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 04:11:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3443F4EA8
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 04:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A89C23041A7B
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 02:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B570E3009EE;
	Tue, 14 Apr 2026 02:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jwgNvNCm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19024A0C;
	Tue, 14 Apr 2026 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776132667; cv=none; b=AlEZQ5EmnFP5zyWGOtgOmPvc/h5bn2Uf90CPZmdmkR0wWvAYul0YXucnOSvr1qlmz67vKchwSlbcskUpzxR/UYuOS/CUx/ai3XbUJT0CRYJJxl04SaVAgb1y/NBpz8O0Df0KeY8/mfvXrWZRSb6IWZ4rcRccSzDW08Oa4iiWuRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776132667; c=relaxed/simple;
	bh=qONVCwTdjOsPJicXgg54drut12/jVHItxnBei3Ez/24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW4ygj3nZKUTpEIaYyfD5ZL0ExMaazxBh7ssls6OlM5Bs9NVN1UflzeiA3WSvp2rzRgON9KBgkiao09N5JHEsWHCvTfLmHyL6KLEQRqhxixyOyh8gMs98qE97RCOWwrH7W8tZyiPSBHqLiWP4DGS4uKkbPvmArTgHUGAVT3ko8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jwgNvNCm; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776132655; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=2GEV5QxYqXEC3gg+qrv5++VkT+kGhafbXkPa1JP+x14=;
	b=jwgNvNCmZjLE6NyUS2+Ts9NXVRZfpboa65Z4tqH5IkenwiDSSuzogCSl4K43vAdopPYODX+CC4DO5U2BbMgP8KgwTxJsuOn2RF/nwRA2WGksm5GgHB7f5kCAaLYzTMuO+QJKLCLjEUgm+uMaT5tjhGzhvtG1TUw026oV611RBME=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X1.hUBx_1776132654;
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X1.hUBx_1776132654 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Apr 2026 10:10:54 +0800
Date: Tue, 14 Apr 2026 10:10:54 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Simon Horman <horms@kernel.org>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
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
Message-ID: <20260414021054.GA111420@j66a10360.sqa.eu95>
References: <20260407124337.88128-1-alibuda@linux.alibaba.com>
 <20260410151631.GY469338@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410151631.GY469338@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19315-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E3443F4EA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 04:16:31PM +0100, Simon Horman wrote:
> On Tue, Apr 07, 2026 at 08:43:37PM +0800, D. Wythe wrote:
> > The alloc_pages() cannot satisfy requests exceeding MAX_PAGE_ORDER,
> > and attempting such allocations will lead to guaranteed failures
> > and potential kernel warnings.
> > 
> > For SMCR_PHYS_CONT_BUFS, cap the allocation order to MAX_PAGE_ORDER.
> > This ensures the attempts to allocate the largest possible physically
> > contiguous chunk succeed, instead of failing with an invalid order.
> > This also avoids redundant "try-fail-degrade" cycles in
> > __smc_buf_create().
> > 
> > For SMCR_MIXED_BUFS, no cap is needed: if the order exceeds
> > MAX_PAGE_ORDER, alloc_pages() will silently fail (__GFP_NOWARN)
> > and automatically fall back to virtual memory.
> > 
> > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> > ---
> > Changes v1 -> v2:
> > https://lore.kernel.org/netdev/20260312082154.36971-1-alibuda@linux.alibaba.com/
> > 
> > - Move the bufsize cap from smcr_new_buf_create() up to
> >   __smc_buf_create(), which is simpler and avoids touching
> >   the allocation logic itself.
> 
> The nit below notwithstanding, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> > ---
> >  net/smc/smc_core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> > index e2d083daeb7e..cdd881746e21 100644
> > --- a/net/smc/smc_core.c
> > +++ b/net/smc/smc_core.c
> > @@ -2440,6 +2440,10 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
> >  		/* use socket send buffer size (w/o overhead) as start value */
> >  		bufsize = smc->sk.sk_sndbuf / 2;
> >  
> > +	/* limit bufsize for physically contiguous buffers */
> > +	if (!is_smcd && lgr->buf_type == SMCR_PHYS_CONT_BUFS)
> > +		bufsize = min_t(int, bufsize, (PAGE_SIZE << MAX_PAGE_ORDER));
> 
> nit: I think min() is sufficient here, and the inner parentheses are
>      unnecessary

Hi Simon,

I think min_t is required here because min() triggers a signedness
error:

././include/linux/compiler_types.h:706:38: error: call to
‘__compiletime_assert_950’ declared with attribute error: min(bufsize,
((1UL) << 12) << 10) signedness error

The inner parentheses can be removed, though.

D. Wythe

> 
> > +
> >  	for (bufsize_comp = smc_compress_bufsize(bufsize, is_smcd, is_rmb);
> >  	     bufsize_comp >= 0; bufsize_comp--) {
> >  		if (is_rmb) {
> > -- 
> > 2.45.0
> > 

