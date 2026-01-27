Return-Path: <linux-rdma+bounces-16079-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGW/MYC/eGn6sgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16079-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 14:37:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 721CA94FA3
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 14:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96C4C3069011
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 13:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242E2627F9;
	Tue, 27 Jan 2026 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1tKzPHO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FCA242D79;
	Tue, 27 Jan 2026 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520863; cv=none; b=mIVJ+pd7MMl66rsPxz2Gcfn4bwI3ysHDQx/qI11QcfJks6RrVYEQONu7dF/i1CZCk55/CKpO3vx4NKNpSuos4abNa4rRNvkXWU0YFM6si3s4BnjeauXPaCN5P31NB93gIXRqH4adjij9sUgKWWjZeL0Nbue2i0/TpwFFBp0jUEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520863; c=relaxed/simple;
	bh=xM07q8aW4efWcWvz4c8IbKTY17sRaIR8OIvcte7xxIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbXncc4yDMrmrwzfz+8pA9Gf8YFF5HNadeAZF6OTECTHZQJot/wi78krfKHJdbxYH60L/UI57jRWD5WWEAscO28x1FWTAgCKkbjFfu8BNnLDMtTLo0F0kqedmpHIrnur0C13WR25fYWDDOmVP2sbI34OwMsLQOjRfU1tMcWMazo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1tKzPHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D4FC116C6;
	Tue, 27 Jan 2026 13:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769520862;
	bh=xM07q8aW4efWcWvz4c8IbKTY17sRaIR8OIvcte7xxIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C1tKzPHO+Xd9T9Sns/qz07JJiCpwBYzGLGyYKigc3cYDYN9ptNQVAmsibRisal4S0
	 36gbvdB5BEwQ73XwT1CaHOCJVGTKJ6qdbGoqyxSA4rwbnQnFgtT3NlRpuL2qN4hRap
	 PwySs7bTSJ6MWfsUrWXfL4TbqVpPuZdIpTklBHyZT/Wkhj5Tm5OmdvhA10z+mtCAEa
	 h3m42WpedulW1BCszBT3xLdGFEUHN6F6WZjh+o8sO/FMutTD1s3FArDWHIvqit6K3V
	 fflfyHLe9MrqIbzUrr+gtkya8m9G3zJMFo/dVTqG6xiJyF3g5wJ8U0+UIFxd1pgZv2
	 qa+l7MFvZc8vA==
Date: Tue, 27 Jan 2026 15:34:17 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <20260127133417.GU13967@unreal>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-3-alibuda@linux.alibaba.com>
 <aXPEFdEdtSmd6AzF@milan>
 <20260124093505.GA98529@j66a10360.sqa.eu95>
 <aXSjm1DXm6yP62tD@pc636>
 <20260124145754.GA57116@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124145754.GA57116@j66a10360.sqa.eu95>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16079-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,linux-foundation.org,linux.alibaba.com,google.com,kernel.org,redhat.com,linux.ibm.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 721CA94FA3
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 10:57:54PM +0800, D. Wythe wrote:
> On Sat, Jan 24, 2026 at 11:48:59AM +0100, Uladzislau Rezki wrote:
> > Hello, D. Wythe!
> > 
> > > On Fri, Jan 23, 2026 at 07:55:17PM +0100, Uladzislau Rezki wrote:
> > > > On Fri, Jan 23, 2026 at 04:23:48PM +0800, D. Wythe wrote:
> > > > > find_vm_area() provides a way to find the vm_struct associated with a
> > > > > virtual address. Export this symbol to modules so that modularized
> > > > > subsystems can perform lookups on vmalloc addresses.
> > > > > 
> > > > > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > > > > ---
> > > > >  mm/vmalloc.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > index ecbac900c35f..3eb9fe761c34 100644
> > > > > --- a/mm/vmalloc.c
> > > > > +++ b/mm/vmalloc.c
> > > > > @@ -3292,6 +3292,7 @@ struct vm_struct *find_vm_area(const void *addr)
> > > > >  
> > > > >  	return va->vm;
> > > > >  }
> > > > > +EXPORT_SYMBOL_GPL(find_vm_area);
> > > > >  
> > > > This is internal. We can not just export it.
> > > > 
> > > > --
> > > > Uladzislau Rezki
> > > 
> > > Hi Uladzislau,
> > > 
> > > Thank you for the feedback. I agree that we should avoid exposing
> > > internal implementation details like struct vm_struct to external
> > > subsystems.
> > > 
> > > Following Christoph's suggestion, I'm planning to encapsulate the page
> > > order lookup into a minimal helper instead:
> > > 
> > > unsigned int vmalloc_page_order(const void *addr){
> > > 	struct vm_struct *vm;
> > >  	vm = find_vm_area(addr);
> > > 	return vm ? vm->page_order : 0;
> > > }
> > > EXPORT_SYMBOL_GPL(vmalloc_page_order);
> > > 
> > > Does this approach look reasonable to you? It would keep the vm_struct
> > > layout private while satisfying the optimization needs of SMC.
> > > 
> > Could you please clarify why you need info about page_order? I have not
> > looked at your second patch.
> > 
> > Thanks!
> > 
> > --
> > Uladzislau Rezki
> 
> Hi Uladzislau,
> 
> This stems from optimizing memory registration in SMC-R. To provide the
> RDMA hardware with direct access to memory buffers, we must register
> them with the NIC. During this process, the hardware generates one MTT
> entry for each physically contiguous block. Since these hardware entries
> are a finite and scarce resource, and SMC currently defaults to a 4KB
> registration granularity, a single 2MB buffer consumes 512 entries. In
> high-concurrency scenarios, this inefficiency quickly exhausts NIC
> resources and becomes a major bottleneck for system scalability.

I believe this complexity can be avoided by using the RDMA MR pool API,
as other ULPs do, for example NVMe.

Thanks

> 
> To address this, we intend to use vmalloc_huge(). When it successfully
> allocates high-order pages, the vmalloc area is backed by a sequence of
> physically contiguous chunks (e.g., 2MB each). If we know this
> page_order, we can register these larger physical blocks instead of
> individual 4KB pages, reducing MTT consumption from 512 entries down to
> 1 for every 2MB of memory (with page_order == 9).
> 
> However, the result of vmalloc_huge() is currently opaque to the caller.
> We cannot determine whether it successfully allocated huge pages or fell
> back to 4KB pages based solely on the returned pointer. Therefore, we
> need a helper function to query the actual page order, enabling SMC-R to
> adapt its registration logic to the underlying physical layout.
> 
> I hope this clarifies our design motivation!
> 
> Best regards,
> D. Wythe
> 
> 
> 
> 
> 

