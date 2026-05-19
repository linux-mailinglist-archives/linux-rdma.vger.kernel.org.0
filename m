Return-Path: <linux-rdma+bounces-20951-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCFYNCgADGpcTQUAu9opvQ
	(envelope-from <linux-rdma+bounces-20951-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 08:16:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AFF577D37
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 08:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 362053041A79
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 06:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6875F37CD4B;
	Tue, 19 May 2026 06:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GVvMDtaP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560337C904;
	Tue, 19 May 2026 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171106; cv=none; b=PH1YxZ/aHGZ0qQWeLNEa3xsGBP1SVvczaT0nFI3V0Mu7l8IJSmPr/flE+T2NSfe7amnRlBYxedwWD3nilAAdb79/2KciAf0aM7qWgWn+DyOBtdqBxJsll6xzBeDwMVaTdAjo+VJaKcovTbcH+VdiGh744UE3p527ce8FuBxrWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171106; c=relaxed/simple;
	bh=dax/GY47A1Z+HiWcyCyHGNkX3jCdWhGX5dyhWrh/7cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9ZWYjKCz2uK7Sh3Rzmp+JQHfcAIDPg3iVFMHH942ca+Vdelc3Dmuu8yBbbeDT/ePcXsLKeWz110tPi45bd7kk7CETGG1zpfRO4ko/Dkp/+XKFDD7tjgTsTHAh/3jZxWLDnlJpkMry55VluAdbWFCb02hoJPvXt7tBelgjy6LvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GVvMDtaP; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779171101; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=pzkqcuTNxUgyj4GOXlUQOhSIGTToDfBPQhRNKjtlAhE=;
	b=GVvMDtaP2kRuUuj/hsTeTrAcvLf38Ur0ebwC876dJSX68bQ83Q5eZvTVW/km0jZ4rgOBkCsAU/R6GHV70FvYvdnjZuPdsYroyyuXyaFtte7dllXuoxdOASVAbU8wEFH+frwkHhQiE1vwiO5J6JuTsGNbOIoagtNwZnqq6Krhbo4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X3ESAOE_1779171099;
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X3ESAOE_1779171099 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 May 2026 14:11:40 +0800
Date: Tue, 19 May 2026 14:11:39 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Paolo Abeni <pabeni@redhat.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, oliver.yang@linux.alibaba.com,
	pasic@linux.ibm.com, Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 1/2] net/smc: transition to RDMA core CQ pooling
Message-ID: <20260519061139.GA11494@j66a10360.sqa.eu95>
References: <20260508063718.101622-1-alibuda@linux.alibaba.com>
 <20260508063718.101622-2-alibuda@linux.alibaba.com>
 <7aeb534e-cf2a-4a3e-83eb-d98a3a5787f6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aeb534e-cf2a-4a3e-83eb-d98a3a5787f6@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-20951-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linux.alibaba.com:dkim,j66a10360.sqa.eu95:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[linux.alibaba.com:+]
X-Rspamd-Queue-Id: 35AFF577D37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 12, 2026 at 10:31:09AM +0200, Paolo Abeni wrote:
> On 5/8/26 8:37 AM, D. Wythe wrote:
> > -void smc_wr_rx_cq_handler(struct ib_cq *ib_cq, void *cq_context)
> > -{
> > -	struct smc_ib_device *dev = (struct smc_ib_device *)cq_context;
> > +/***************************** init, exit, misc ******************************/
> >  
> > -	tasklet_schedule(&dev->recv_tasklet);
> > +static inline void smc_wr_reg_init_cqe(struct ib_cqe *cqe)
> 

Thanks for the review, Paolo.

> This and the next 3 helpers are used at init time, hopefully not
> critical/fast path; the `inline` annotation should really be avoided.
> 

Agreed, will drop the inline from these init-time helpers in v2.

> Note that the sashiko gemini instance has more concerns on patch 1,
> please have a look:
> 
> https://sashiko.dev/#/patchset/20260508063718.101622-1-alibuda%40linux.alibaba.com
> 
> /P

I've reviewed the sashiko feedback and will address those concerns in v2
as well. It did make sense.

Best wishes,
D. Wythe

