Return-Path: <linux-rdma+bounces-16435-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF6tE6W8gWm7JAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16435-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 10:15:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC414D6AA3
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 10:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45887304D93B
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 09:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EB9396D15;
	Tue,  3 Feb 2026 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lvIBivLS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9839396D09;
	Tue,  3 Feb 2026 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770110111; cv=none; b=KXE6lThOVA1ObGUY5pBRqN5gho5sjvtbm4O5NBLDl20Ekw9LbW4kYewdQ0+KQki5vmW3VOJS4dxqEpnfMLGyw45JJY/wCk0jKbbsswnbytMnJZogZaNm7mhLhF0xInPWhvgeX456wOaHrt3pPZuNUF5wVKNaGABBL+cOlW+GPTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770110111; c=relaxed/simple;
	bh=ZC1CA6vrdOzcMrcHn5G00HpXHg18TikDxYVKMBh9tuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lX4uZwkeU5WTIW3HXzl/cJPqvcbREwQt0ZvgEhzD+M1kQUdcVsoJMm1M3V3/l/J/sG3PzMYngQ+znE3nCvywlY4gtMrhyAKFB5xDa/U78Mpgc5XSObjy9Rv5y1d9DeP1lN7T3gJxwNoIECmXvac/AUMnIoiGURzIMRye7RnTA+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lvIBivLS; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770110099; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=KV7iB2cX0YsCo/vw3xU3Pyo02q+0048t1T+E30Gigtg=;
	b=lvIBivLSh9GpQ/9XItSiA5L3Ae5Abhgd3YILZJXyPQApT6jv/boUE3Hb2IC8SoZ58+a26VlUYRi6pGgxBqTIXEPZBFfSFuum5+mKUeAD331FlL00z8ZNIizgZeE9XNN/nZPYS5HRCm17TApalp7+cWnWUI5+1fEpbfNFzRNLYuo=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WySViK7_1770110098 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Feb 2026 17:14:59 +0800
Date: Tue, 3 Feb 2026 17:14:58 +0800
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
Message-ID: <20260203091458.GA89766@j66a10360.sqa.eu95>
References: <20260124093505.GA98529@j66a10360.sqa.eu95>
 <aXSjm1DXm6yP62tD@pc636>
 <20260124145754.GA57116@j66a10360.sqa.eu95>
 <20260127133417.GU13967@unreal>
 <20260128034558.GA126415@j66a10360.sqa.eu95>
 <20260128180629.GT1641016@ziepe.ca>
 <20260129113609.GA37734@j66a10360.sqa.eu95>
 <20260129132058.GC2307128@ziepe.ca>
 <20260130085131.GA122673@j66a10360.sqa.eu95>
 <20260130151636.GF2328995@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260130151636.GF2328995@ziepe.ca>
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
	TAGGED_FROM(0.00)[bounces-16435-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.alibaba.com:dkim,j66a10360.sqa.eu95:mid]
X-Rspamd-Queue-Id: BC414D6AA3
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 11:16:36AM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 30, 2026 at 04:51:31PM +0800, D. Wythe wrote:
> > On Thu, Jan 29, 2026 at 09:20:58AM -0400, Jason Gunthorpe wrote:
> > > On Thu, Jan 29, 2026 at 07:36:09PM +0800, D. Wythe wrote:
> > > 
> > > > > From there you can check the resulting scatterlist and compute the
> > > > > page_size to pass to ib_map_mr_sg().
> > > 
> > > I should clarify this is done after DMA mapping the scatterlist. dma
> > > mapping can improve the page size.
> > > 
> > > And maybe the core code should be helping compute the MR's target page
> > > size for a scatterlist.. We already have code to do this in umem, and
> > > it is a pretty bit tricky considering the IOVA related rules.
> > >
> > 
> > Hi Jason,
> > 
> > After a deep dive into ib_umem_find_best_pgsz(), I have to say it is
> > much more subtle than it first appears. The IOVA-to-PA relative offset
> > rules, in particular, make it quite easy to get wrong.
> > 
> > While SMC could duplicate this logic, it is certainly not ideal for
> > maintenance. Are there any plans to refactor this into a generic RDMA
> > core helper—for instance, one that can determine the best page size
> > directly from an sg_table or scatterlist?
> 
> I have not heard of anyone touching this.
> 
> It looks like there are only two users in the kernel that pass
> something other than PAGE_SIZE, so it seems nobody has cared about
> this till now.
> 
> With high order folios being more common it seems like something
> missing.
> 
> However, I wonder what the drivers do with the input page size, 
> segmenting a scatterlist is a bit hard and we have helpers for that
> already too.
> 
> It is a bigger project but probably the right thing is to remove the
> page size input, wrap the scatterlist in a umem and fixup the drivers
> to use the existing umem support for building mtts, splitting
> scatterlists into blocks and so on.
> 
> The kernel side here has been left alone for a long time..

I am also curious about the original design intent behind requiring the 
caller to explicitly pass `page_size`. From what I can see, its primary 
role is to define the memory size per MTTE, but calculating the optimal 
value is surprisingly complex.

I completely agree that providing an automatic way to optimize or 
calculate the best page size should be the responsibility of the drivers
or the RDMA core themselves. Handling such low-level hardware-related 
details in a ULP like SMC feels misplaced.

Since it appears this isn't a high-priority issue for the community at
the moment, and a proper fix requires a much larger architectural effort 
in the RDMA core, I will withdraw this patch series. 

I'll keep an eye on the RDMA subsystem's progress and see if a more 
generic solution emerges in the future.

Thanks,
D. Wythe



