Return-Path: <linux-rdma+bounces-16198-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDvXMfhQe2meDwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16198-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 13:22:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A096B006E
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 13:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B646C301DDBF
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 12:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5EA37F0EE;
	Thu, 29 Jan 2026 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XztRNY84"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23072D73B5;
	Thu, 29 Jan 2026 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769689330; cv=none; b=QtqlpibKkp/QIlQ/VDIBltZJoIlp0bmVkAgrLZpdCU9YZ4hik5wxnLKg6ygx0HfMV6NdJ42+ZTMTCqOhVQRgWUS6d42CxSgnbrDJz5/A49CGkBfn3sDK60ppLBRci5aVpNn5ijVWN5vzkCinpXMaIrOI5csHhrBP3XfL1y82XFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769689330; c=relaxed/simple;
	bh=u0mH2caXTtzlMetoMGj0YZL3OyKWg4rqxepJQNCPAH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HECPtmL9jSYRirgD6eYORtPzD1CrEq9iFTojSdQ3a+e5Pr3tiONZhsASXlJbFQnnNGYhKlQ1RxpHxOt7jndMuj+FyBis79zq2HfvtwJfQtHOeDHqAUjbg0AyQW3O50a8AVM6BCk0+VBts3kNQ30byJ0vRWPbQsR8XGqS7eWz1zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XztRNY84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C4EC116D0;
	Thu, 29 Jan 2026 12:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769689329;
	bh=u0mH2caXTtzlMetoMGj0YZL3OyKWg4rqxepJQNCPAH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XztRNY842nKIzlwsrZ2zmz2O2SC5CuFYr0PFbxneGq54Q9YEkUGZqhjUouXUqn7WY
	 gu1u0BgbBqV0y/KKINI7F5mpGY23/Z1wyz0AX6gqB3PYmrqkLLFGGS4EnkK8LzItWL
	 11f6uCX/vWjK70v646N607UAo/vVw126ju602qaPhWROGFWFzHGliwwbe0bGkyN8bU
	 Acd+AAyS3ayDZvQUmfewqIGTfM3AH37KGvXYDyYWxYbz2g9I/rDMZC0+UWoqpqCDFw
	 Lxxyi+CZsOVT6AaieoFJ0pwzNkpS0FTPF5Y/yE+6lVAbtyKypL1z5/miAPJQBjjHOe
	 sMX7/pXFwwB7Q==
Date: Thu, 29 Jan 2026 14:22:02 +0200
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
Message-ID: <20260129122202.GF10992@unreal>
References: <aXPEFdEdtSmd6AzF@milan>
 <20260124093505.GA98529@j66a10360.sqa.eu95>
 <aXSjm1DXm6yP62tD@pc636>
 <20260124145754.GA57116@j66a10360.sqa.eu95>
 <20260127133417.GU13967@unreal>
 <20260128034558.GA126415@j66a10360.sqa.eu95>
 <20260128111346.GD12149@unreal>
 <20260128124404.GA96868@j66a10360.sqa.eu95>
 <20260128134934.GD40916@unreal>
 <20260129110323.GA80118@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129110323.GA80118@j66a10360.sqa.eu95>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16198-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A096B006E
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 07:03:23PM +0800, D. Wythe wrote:
> On Wed, Jan 28, 2026 at 03:49:34PM +0200, Leon Romanovsky wrote:
> > On Wed, Jan 28, 2026 at 08:44:04PM +0800, D. Wythe wrote:
> > > On Wed, Jan 28, 2026 at 01:13:46PM +0200, Leon Romanovsky wrote:
> > > > On Wed, Jan 28, 2026 at 11:45:58AM +0800, D. Wythe wrote:
> > > > > On Tue, Jan 27, 2026 at 03:34:17PM +0200, Leon Romanovsky wrote:
> > > > > > On Sat, Jan 24, 2026 at 10:57:54PM +0800, D. Wythe wrote:
> > > > > > > On Sat, Jan 24, 2026 at 11:48:59AM +0100, Uladzislau Rezki wrote:
> > > > > > > > Hello, D. Wythe!
> > > > > > > > 
> > > > > > > > > On Fri, Jan 23, 2026 at 07:55:17PM +0100, Uladzislau Rezki wrote:
> > > > > > > > > > On Fri, Jan 23, 2026 at 04:23:48PM +0800, D. Wythe wrote:
> > > > > > > > > > > find_vm_area() provides a way to find the vm_struct associated with a
> > > > > > > > > > > virtual address. Export this symbol to modules so that modularized
> > > > > > > > > > > subsystems can perform lookups on vmalloc addresses.
> > > > > > > > > > > 
> > > > > > > > > > > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  mm/vmalloc.c | 1 +
> > > > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > > > > 
> > > > > > > > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > > > > > > > index ecbac900c35f..3eb9fe761c34 100644
> > > > > > > > > > > --- a/mm/vmalloc.c
> > > > > > > > > > > +++ b/mm/vmalloc.c
> > > > > > > > > > > @@ -3292,6 +3292,7 @@ struct vm_struct *find_vm_area(const void *addr)
> > > > > > > > > > >  
> > > > > > > > > > >  	return va->vm;
> > > > > > > > > > >  }
> > > > > > > > > > > +EXPORT_SYMBOL_GPL(find_vm_area);
> > > > > > > > > > >  
> > > > > > > > > > This is internal. We can not just export it.
> > > > > > > > > > 
> > > > > > > > > > --
> > > > > > > > > > Uladzislau Rezki
> > > > > > > > > 
> > > > > > > > > Hi Uladzislau,
> > > > > > > > > 
> > > > > > > > > Thank you for the feedback. I agree that we should avoid exposing
> > > > > > > > > internal implementation details like struct vm_struct to external
> > > > > > > > > subsystems.
> > > > > > > > > 
> > > > > > > > > Following Christoph's suggestion, I'm planning to encapsulate the page
> > > > > > > > > order lookup into a minimal helper instead:
> > > > > > > > > 
> > > > > > > > > unsigned int vmalloc_page_order(const void *addr){
> > > > > > > > > 	struct vm_struct *vm;
> > > > > > > > >  	vm = find_vm_area(addr);
> > > > > > > > > 	return vm ? vm->page_order : 0;
> > > > > > > > > }
> > > > > > > > > EXPORT_SYMBOL_GPL(vmalloc_page_order);
> > > > > > > > > 
> > > > > > > > > Does this approach look reasonable to you? It would keep the vm_struct
> > > > > > > > > layout private while satisfying the optimization needs of SMC.
> > > > > > > > > 
> > > > > > > > Could you please clarify why you need info about page_order? I have not
> > > > > > > > looked at your second patch.
> > > > > > > > 
> > > > > > > > Thanks!
> > > > > > > > 
> > > > > > > > --
> > > > > > > > Uladzislau Rezki
> > > > > > > 
> > > > > > > Hi Uladzislau,
> > > > > > > 
> > > > > > > This stems from optimizing memory registration in SMC-R. To provide the
> > > > > > > RDMA hardware with direct access to memory buffers, we must register
> > > > > > > them with the NIC. During this process, the hardware generates one MTT
> > > > > > > entry for each physically contiguous block. Since these hardware entries
> > > > > > > are a finite and scarce resource, and SMC currently defaults to a 4KB
> > > > > > > registration granularity, a single 2MB buffer consumes 512 entries. In
> > > > > > > high-concurrency scenarios, this inefficiency quickly exhausts NIC
> > > > > > > resources and becomes a major bottleneck for system scalability.
> > > > > > 
> > > > > > I believe this complexity can be avoided by using the RDMA MR pool API,
> > > > > > as other ULPs do, for example NVMe.
> > > > > > 
> > > > > > Thanks
> > > > > > 
> > > > > 
> > > > > Hi Leon,
> > > > > 
> > > > > Am I correct in assuming you are suggesting mr_pool to limit the number
> > > > > of MRs as a way to cap MTTE consumption?
> > > > 
> > > > I don't see this a limit, but something that is considered standard
> > > > practice to reduce MTT consumption.
> > > > 
> > > > > 
> > > > > However, our goal is to maximize the total registered memory within
> > > > > the MTTE limits rather than to cap it. In SMC-R, each connection
> > > > > occupies a configurable, fixed-size registered buffer; consequently,
> > > > > the more memory we can register, the more concurrent connections
> > > > > we can support.
> > > > 
> > > > It is not cap, but more efficient use of existing resources.
> > > 
> > > Got it. While MRs pool might be more standard practice, but it doesn't
> > > address our specific bottleneck. In fact, smc already has its own internal
> > > MR reuse; our core issue remains reducing MTTE consumption by increasing the
> > > registration granularity to maximize the memory size mapped per MTT entry.
> > 
> > And this is something MR pools can handle as well. We are going in circles,
> > so let's summarize.
> 
> I believe some points need to be thoroughly clarified here:
> 
> > 
> > I see SMC‑R as one of the RDMA ULPs, and it should ideally rely on the
> > existing ULP API used by NVMe, NFS, and others, rather than maintaining its
> > own internal logic.
> 
> SMC is not opposed to adopting newer RDMA interfaces; in fact, I have
> already planned a gradual migration to the updated RDMA APIs. We are
> currently in the process of adapting to ib_cqe, for instance. As long as
> functionality remains intact, there is no reason to oppose changes that
> reduce maintenance overhead or provide additional gains, but such a
> transition takes time.
> 
> > 
> > I also do not know whether vmalloc_page_order() is an appropriate solution;
> > I only want to show that we can probably achieve the same result without
> > introducing a new function.
> 
> Regarding the specific issue under discussion, I believe the newer RDMA
> APIs you mentioned do not solve my problem, at least for now. My
> understanding is that regardless of how MRs are pooled, the core
> requirement is to increase the page_size parameter in ib_map_mr_sg to
> maximize the physical size mapped per MTTE. From the code I have
> examined, I see no evidence of these new APIs utilizing values other
> than 4KB.
> 
> Of course, I believe that regardless of whether this issue
> currently exists, it is something the RDMA community can resolve.
> However, as I mentioned, adapting to new API takes time. Before a
> complete transition is achieved, we need to allow for some necessary
> updates to SMC.

I disagree with that statement.

SMC‑R has a long history of re‑implementing existing RDMA ULP APIs, and
not always correctly.

https://lore.kernel.org/netdev/20170510072627.12060-1-hch@lst.de/
https://lore.kernel.org/netdev/20241105112313.GE311159@unreal/#t

Thanks

> 
> Thanks
> 

