Return-Path: <linux-rdma+bounces-15938-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNqEFGGPdGmw7AAAu9opvQ
	(envelope-from <linux-rdma+bounces-15938-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jan 2026 10:22:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AADCC7D11D
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jan 2026 10:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43D2B30138AF
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jan 2026 09:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5BA21C9FD;
	Sat, 24 Jan 2026 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jJdKJg/Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53213EBF34;
	Sat, 24 Jan 2026 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769246557; cv=none; b=pKjsmZ2JMOiaZw4R+Nmizf+PnU/vt9TvNiBQHdxUEk46euqwBkgAFOQn6ycaoUoxqJFF+0ZqQlGnQyE5bKHM3hls3bZn9QkFPwNwJNb6RXHHB5veR+ZcJz7dQooXo/Zi7uy9wsQExdavMgeLSjhrdBeyHZwBkydevoNWtv0E27k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769246557; c=relaxed/simple;
	bh=QmWvenW9ze+OPCIN43D1aT/M5hDWbE0p8JTYbw2Ap94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNkhIJ33A0DHeCnbeFwD/aMprTCaNldYrxkgIH+Zd10FsoGCS/9OB1wt+KVZ+Jpvfob9M61LUxb7dNmuwaIAG7EFfh7fsbD5VbiYTy5QW04dCXmTrGODHZ05aDT929jq9UdPPGPE79wfxFjDwaK2ksH6BFXrOK93aOm9lPX83oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jJdKJg/Y; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769246547; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=JJIvyfyanGB9J6au1bCV2+bGjwvOLICjUu5CtLQtQkg=;
	b=jJdKJg/YACnJdaykw8f82QUI7lAfTu8ACkvAGoUUJv92nYDCQZfFSRTqHCtdpNSUAiBk/BkqtUJhf6vXemr5DyYQgJbJGCPV3BFZjIrgyXpBQO8TBwBCi85temLwJZEw9MM9jEkdvuy+9cfiLQLJxz2MK+dZYHEgM8dr6aMPEOE=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Wxia0AB_1769246545 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 24 Jan 2026 17:22:26 +0800
Date: Sat, 24 Jan 2026 17:22:25 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH net-next 1/3] net/smc: cap allocation order for SMC-R
 physically contiguous buffers
Message-ID: <20260124092225.GA85316@j66a10360.sqa.eu95>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-2-alibuda@linux.alibaba.com>
 <6f8de95e-b034-4ea8-a246-605047d142db@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f8de95e-b034-4ea8-a246-605047d142db@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15938-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[linux.alibaba.com,davemloft.net,linux-foundation.org,google.com,kernel.org,redhat.com,linux.ibm.com,gmail.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AADCC7D11D
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 11:54:37AM +0100, Alexandra Winter wrote:
> 
> 
> On 23.01.26 09:23, D. Wythe wrote:
> Describe your changes in imperative mood.
> https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
> 
> 
> > For SMCR_PHYS_CONT_BUFS, the allocation order is now capped to
> > MAX_PAGE_ORDER, ensures the attempts to allocate the largest possible
> > physically contiguous chunk instead of failing with an invalid order,
> > which also avoid redundant "try-fail-degrade" cycles in __smc_buf_create().
> > 
> > For SMCR_MIXED_BUFS, If it's order exceeds MAX_PAGE_ORDER, skips the
> > doomed physical allocation attempt and fallback to virtual memory
> > immediately.
> > 
> 
> Proposal for a version in imperative mood (iiuc):
> "
> For SMCR_PHYS_CONT_BUFS, cap the allocation order to MAX_PAGE_ORDER. This
> ensures the attempts to allocate the largest possible physically contiguous
> chunk succeed, instead of failing with an invalid order. This also avoids
> redundant "try-fail-degrade" cycles in __smc_buf_create().
> 
> For SMCR_MIXED_BUFS, if its order exceeds MAX_PAGE_ORDER, skip the doomed
> physical allocation attempt and fallback to virtual memory immediately.
> "
> 
> 
> > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> 
> Other than that: LGTM
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

Hi Alexandra,

Thank you for your review and for providing the refined description.
I will use your suggested wording for the commit message in V2.

Best regards,
D. Wythe

