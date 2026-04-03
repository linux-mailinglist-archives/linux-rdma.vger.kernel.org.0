Return-Path: <linux-rdma+bounces-18966-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKB0Mnhaz2kXvgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18966-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 08:13:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EB639156E
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 08:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 820CD3015461
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2026 06:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F857365A1A;
	Fri,  3 Apr 2026 06:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NBh3q3+t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3B36AB75;
	Fri,  3 Apr 2026 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196779; cv=none; b=oVW/8FLkzOpwtVsJD4Q/SJVIMA4CslhM9xV6mUvoJ2/8KYUd5JWf+MVoXK02QTxffv5SozAlyl+IRFxOxXFGQLyoyCF/fQEHkZmQxCNYXKNvvpd0mNTCFGgN1+3d2+ogmFKXk+pUffjNIa+qBvs0VyUXE7cS1z8krogEdKMMGts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196779; c=relaxed/simple;
	bh=EQZaI5PHfXci8DKm8J0i0XohFutvWleIPjnUUV3JVjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQFHr2LhnxLU2wODCYNL4UuoBsLdB06A5taoawos/+Kk75X1wKNt/6a8YwSpDd2jZg5+oHRU098wdQgLwwnUSGrnuDn5rV7kXqGHU6+RSXHWS12Fu628rkdN3lq5t1pcWaKcKTE92mnKF1uyki2qAeWvbtn5niNVv2BvGVpRcXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NBh3q3+t; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775196767; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=R+HPzqgoEuNzBhc0ht4XM/gQ1ivcrvcLvJRpDlLm3nA=;
	b=NBh3q3+tKEPtu/RuG7DtWKo54p5OQhkDJHdm/epL2f77IlEtU4Bpos+M5hAlDJh8rIC+FTJiauR57LBocMg4iFqFVBIMzR9VvlrvWwng6cAutkLADHuMAcdAqcxoM1M/e6P3vqsMnreyaGvN8gjIlW/l0P36FDA8iNT0GZXbyms=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X0JJZSC_1775196766;
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X0JJZSC_1775196766 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Apr 2026 14:12:46 +0800
Date: Fri, 3 Apr 2026 14:12:46 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Jakub Kicinski <kuba@kernel.org>
Cc: alibuda@linux.alibaba.com, netdev@vger.kernel.org, edumazet@google.com,
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com, pabeni@redhat.com,
	guwen@linux.alibaba.com, davem@davemloft.net,
	linux-kernel@vger.kernel.org, mjambigi@linux.ibm.com,
	dust.li@linux.alibaba.com, oliver.yang@linux.alibaba.com,
	sidraya@linux.ibm.com, linux-s390@vger.kernel.org, horms@kernel.org,
	pasic@linux.ibm.com, linux-rdma@vger.kernel.org
Subject: Re: [net-next] net/smc: cap allocation order for SMC-R physically
 contiguous buffers
Message-ID: <20260403061246.GA61656@j66a10360.sqa.eu95>
References: <20260312082154.36971-1-alibuda@linux.alibaba.com>
 <20260317024534.588136-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317024534.588136-1-kuba@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18966-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+]
X-Rspamd-Queue-Id: 77EB639156E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 07:45:34PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net/smc: cap allocation order for SMC-R physically contiguous buffers
> 
> The alloc_page() cannot satisfy requests exceeding MAX_PAGE_ORDER, and
> attempting such allocations will lead to guaranteed failures and potential
> kernel warnings. For SMCR_PHYS_CONT_BUFS, cap the allocation order to
> MAX_PAGE_ORDER. This ensures the attempts to allocate the largest possible
> physically contiguous chunk succeed. For SMCR_MIXED_BUFS, if its order
> exceeds MAX_PAGE_ORDER, skip the physical allocation attempt and fallback to
> virtual memory immediately.
> 
> > diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> > index e2d083daeb7e..a18730edb7e0 100644
> > --- a/net/smc/smc_core.c
> > +++ b/net/smc/smc_core.c
> > @@ -2314,6 +2314,10 @@ int smcr_buf_reg_lgr(struct smc_link *lnk)
> >  	return rc;
> >  }
> >
> > +/*
> > + * smcr_new_buf_create may allocate a buffer smaller than the requested
> > + * bufsize. Use buf_desc->len to determine the actual allocated size.
> > + */
> >  static struct smc_buf_desc *smcr_new_buf_create(struct smc_link_group *lgr,
> >  						int bufsize)
> >  {
> > @@ -2326,18 +2330,22 @@ static struct smc_buf_desc *smcr_new_buf_create(struct smc_link_group *lgr,
> >
> >  	switch (lgr->buf_type) {
> >  	case SMCR_PHYS_CONT_BUFS:
> > +		bufsize = min(bufsize, (int)PAGE_SIZE << MAX_PAGE_ORDER);
> > +		fallthrough;
> >  	case SMCR_MIXED_BUFS:
> >  		buf_desc->order = get_order(bufsize);
> > -		buf_desc->pages = alloc_pages(GFP_KERNEL | __GFP_NOWARN |
> > -					      __GFP_NOMEMALLOC | __GFP_COMP |
> > -					      __GFP_NORETRY | __GFP_ZERO,
> > -					      buf_desc->order);
> > -		if (buf_desc->pages) {
> > -			buf_desc->cpu_addr =
> > -				(void *)page_address(buf_desc->pages);
> > -			buf_desc->len = bufsize;
> > -			buf_desc->is_vm = false;
> > -			break;
> > +		if (buf_desc->order <= MAX_PAGE_ORDER) {
> > +			buf_desc->pages = alloc_pages(GFP_KERNEL | __GFP_NOWARN |
> > +						      __GFP_NOMEMALLOC | __GFP_COMP |
> > +						      __GFP_NORETRY | __GFP_ZERO,
> > +						      buf_desc->order);
> > +			if (buf_desc->pages) {
> > +				buf_desc->cpu_addr =
> > +					(void *)page_address(buf_desc->pages);
> > +				buf_desc->len = bufsize;
> > +				buf_desc->is_vm = false;
> > +				break;
> > +			}
> >  		}
> >  		if (lgr->buf_type == SMCR_PHYS_CONT_BUFS)
> >  			goto out;
> 
> [ ... ]
> 
> > @@ -2476,7 +2484,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
> >  		}
> >
> >  		SMC_STAT_RMB_ALLOC(smc, is_smcd, is_rmb);
> > -		SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, true, bufsize);
> > +		SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, true, buf_desc->len);
> >  		buf_desc->used = 1;
> >  		down_write(lock);
> >  		smc_lgr_buf_list_add(lgr, is_rmb, buf_list, buf_desc);
> >  		up_write(lock);
> >  		break; /* found */
> >  	}
> >
> >  	if (IS_ERR(buf_desc))
> >  		return PTR_ERR(buf_desc);
> >
> >  	if (!is_smcd) {
> >  		if (smcr_buf_map_usable_links(lgr, buf_desc, is_rmb)) {
> >  			smcr_buf_unuse(buf_desc, is_rmb, lgr);
> >  			return -ENOMEM;
> >  		}
> >  	}
> >
> >  	if (is_rmb) {
> >  		conn->rmb_desc = buf_desc;
> >  		conn->rmbe_size_comp = bufsize_comp;
> >  		smc->sk.sk_rcvbuf = bufsize * 2;
> >  		atomic_set(&conn->bytes_to_rcv, 0);
> >  		conn->rmbe_update_limit =
> >  			smc_rmb_wnd_update_limit(buf_desc->len);
> >  		if (is_smcd)
> >  			smc_ism_set_conn(conn); /* map RMB/smcd_dev to conn */
> >  	} else {
> >  		conn->sndbuf_desc = buf_desc;
> >  		smc->sk.sk_sndbuf = bufsize * 2;
> >  		atomic_set(&conn->sndbuf_space, bufsize);
>                                                  ^^^^^^^
> 
> The comment added at smcr_new_buf_create() says "Use buf_desc->len to
> determine the actual allocated size," but __smc_buf_create() still uses the
> uncapped bufsize for several critical fields. Is this correct?
> 
> For SMCR_PHYS_CONT_BUFS, smcr_new_buf_create() now caps bufsize internally
> to PAGE_SIZE << MAX_PAGE_ORDER (typically 4MB), so buf_desc->len can be
> smaller than the requested bufsize.
> 
> However, __smc_buf_create() continues using the original uncapped bufsize
> for:
> 
>     if (is_rmb) {
>         conn->rmbe_size_comp = bufsize_comp;
>         smc->sk.sk_rcvbuf = bufsize * 2;
>     } else {
>         smc->sk.sk_sndbuf = bufsize * 2;
>         atomic_set(&conn->sndbuf_space, bufsize);
>     }
> 
> The sndbuf_space mismatch is particularly concerning. Looking at
> smc_tx.c:274, the comment states: "0 <= sndbuf_space <= sndbuf_desc->len".
> When sndbuf_space exceeds sndbuf_desc->len, smc_tx_sendmsg() could calculate
> writespace incorrectly:
> 
>     int writespace = atomic_read(&conn->sndbuf_space);
> 
> and the two-chunk copy loop might write beyond the actual buffer boundary.
> This is reachable with default sysctl settings (SMCR_PHYS_CONT_BUFS) and
> socket buffer sizes exceeding 4MB.
> 
> Should these assignments use buf_desc->len instead of bufsize? For example:
> 
>     atomic_set(&conn->sndbuf_space, buf_desc->len);
>     smc->sk.sk_sndbuf = buf_desc->len * 2;
>     smc->sk.sk_rcvbuf = buf_desc->len * 2;
> 
> And should rmbe_size_comp be recalculated from buf_desc->len? The
> rmbe_size_comp value is sent to the peer via CLC messages in smc_clc.c:1125,
> and an inflated value might cause the peer to believe the RMB is larger than
> it actually is.
> 

Thanks for catching this.

After rethinking this, I think we should not change the semantic of
smcr_new_buf_create() to return a potentially smaller buffer than
requested. The MAX_PAGE_ORDER limit is better handled in __smc_buf_create(),
where the effective buffer size is already known and used to initialize
socket/accounting state.

I'll update the patch accordingly.

> >  	}
> >  	return 0;
> >  }
> -- 
> pw-bot: cr

