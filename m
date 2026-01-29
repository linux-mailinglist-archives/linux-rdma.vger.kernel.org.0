Return-Path: <linux-rdma+bounces-16195-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +McuL0hGe2kbDQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16195-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 12:36:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD34AFAEB
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 12:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8FBF3019531
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 11:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FB9341660;
	Thu, 29 Jan 2026 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VLRUTcDO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7584337A497;
	Thu, 29 Jan 2026 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769686576; cv=none; b=pZu45BKJzXQqPZKlAo9gKl4n41x+fHyBeRZGSBAnyS9Gs830GEVHsWYf+oMO4kgORfLkDPt24pRJTl84Mp2ciBmu2cVCLDx6Qg9WoP+PHq/9xxAPgmlBfM4yqS+VW9D6dOFOhOGDB4GESSSWVZxqQbWXzz4++w6MCPPuGUxkb5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769686576; c=relaxed/simple;
	bh=d4CmdYYqvsYOE6rAuMRjm6IC6UqDM9BG3uDwhGiiAlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6s5zM+9/8n7k6inBTgmUcb+edZmluTNVk2S/w/iE/TUKwBy508/sTv9Jc/AQQ1OSBnsWW3pjntfzz0pgnmnYnpydTNOjT5ra9WPUBWoQa/ziQ3kTPDKw7SjMO4xP16lkoRC1D+/kPjdkFw0eUOW6/rkpSi4t7y9sh3YO1v5Qhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VLRUTcDO; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769686570; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=wI26mgk49lgLhCsakpVqc1lnp0wxouQs7L+0UFUDFuo=;
	b=VLRUTcDOC6sdDDZoNGp/5LTM95JVuf8oiKV84vOZX3OoPIfAB7K0LLLqwHuMptcDYeG+dFBM+p7P61Fe26ZHNMQCLnNMUZxZRksYWu5uiqv5oJh8RhfMZpjGAZZGYWgGR4goFl54NMdbdsMAXd7pRxJS+41ljtPrkTpVMQykgOg=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Wy7EuPK_1769686569 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Jan 2026 19:36:09 +0800
Date: Thu, 29 Jan 2026 19:36:09 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>,
	Leon Romanovsky <leon@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH net-next 2/3] mm: vmalloc: export find_vm_area()
Message-ID: <20260129113609.GA37734@j66a10360.sqa.eu95>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-3-alibuda@linux.alibaba.com>
 <aXPEFdEdtSmd6AzF@milan>
 <20260124093505.GA98529@j66a10360.sqa.eu95>
 <aXSjm1DXm6yP62tD@pc636>
 <20260124145754.GA57116@j66a10360.sqa.eu95>
 <20260127133417.GU13967@unreal>
 <20260128034558.GA126415@j66a10360.sqa.eu95>
 <20260128180629.GT1641016@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128180629.GT1641016@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16195-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,gmail.com,davemloft.net,linux-foundation.org,google.com,redhat.com,linux.ibm.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,j66a10360.sqa.eu95:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CD34AFAEB
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 02:06:29PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 28, 2026 at 11:45:58AM +0800, D. Wythe wrote:
> 
> > By leveraging vmalloc_huge() and the proposed helper to increase the
> > page_size in ib_map_mr_sg(), each MTTE covers a much larger contiguous
> > physical block.
> 
> This doesn't seem right, if your goal is to take a vmalloc() pointer
> and convert it to a MR via a scatterlist and ib_map_mr_sg() then you
> should be asking for a helper to convert a kernel pointer into a
> scatterlist.
> 
> Even if you do this in a naive way and call the
> sg_alloc_append_table_from_pages() function it will automatically join
> physically contiguous ranges together for you.
> 
> From there you can check the resulting scatterlist and compute the
> page_size to pass to ib_map_mr_sg().
> 
> No need to ask the MM for anything other than the list of physicals to
> build the scatterlist with.
> 
> Still, I wouldn't mind seeing a helper to convert a kernel pointer
> into a scatterlist because I have see that opencoded in a few places,
> and maybe there are ways to optimize that using more information from
> the MM - but it should be APIs used only by this helper not exposed to
> drivers.
> 
> Jason

Hi Jason,

To be honest, I was previously unaware of the
sg_alloc_append_table_from_pages() function, although I had indeed
considered manually calculating the size of contiguous physical blocks.
The reason I proposed the MM helper is that SMC is not driver, it  utilizes
vmalloc() for memory allocation and is thus in direct contact with the MM;
from this perspective, having the MM provide the page_order would be the most
straightforward approach.

Given the significant opposition and our plans to transition SMC to newer
APIs in the future anyway, I agree that introducing this helper now is
less justified.

I will follow your suggestion and update the next version accordingly.

Thanks.



