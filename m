Return-Path: <linux-rdma+bounces-16131-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AKnCHTveWnG1AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16131-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:13:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D78A01F0
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7CFA3012CE6
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30CC33C530;
	Wed, 28 Jan 2026 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsOIO6cV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750DE32ED24;
	Wed, 28 Jan 2026 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769598830; cv=none; b=LWuPoZTZMRKzG29om/bpnj9r3dAYUXxrCwQ10A9d4doLFUgTLxoxKOkkh4qJthz10PO9rbAwsspABcJj2SwAmtQlzORrf4aEnFMPvarHykHMOjl7sqhFla1HPciJhQhCCoqoX8UJypTVEai1r1fwE8oJ+ExkaX+SbGAEO8SyS0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769598830; c=relaxed/simple;
	bh=XhAa/knyZ6haG7FHsLWt0DcbM4mnkccj/WzXt56VTpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTeTdPz3FIlMC8KZepjA4CutgSr1HJ3P6/dXIrQZ50cqJOi8ELLIEfyc1lOa4CFOqHcvHpQawAJQ0Je3EiHEwoM1O5siMSoCn+fKrVwFZ/Ve+NyPnVLakEmRgxxIIdYiDchNpxoe3epa9D0QqDFU8Qx3+L5O/cK2eCkqUPf/YD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsOIO6cV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E815DC4CEF1;
	Wed, 28 Jan 2026 11:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769598830;
	bh=XhAa/knyZ6haG7FHsLWt0DcbM4mnkccj/WzXt56VTpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QsOIO6cV70uo0MZSW5kkJyDzI6RcSrMOzS5q7b7ULZKvuvWOx/IEA15z5DVAGIIJB
	 coB0IBdwYPmvjySgO+Q5k0Jh7yt3uJdRV7gfvJoAN354mNNBcRN0nPgfT+cNOutquJ
	 ZpegGQAj4wSMSonkLxC7IwKMy3Ey977CuGMoGbkKTiCHGIQ0NLz5TwtRb/TERR82EW
	 gi+yJN3vH9nFSz8UetoM6ON9giYtcaD2dAs7OBryHfj7ofCebLLX0mZMO5KXNUbTV6
	 tJEsoktIRK3o+24kAK4i4HfY3V6Kp+kTlsfAFbeP/LXceIkOsVtbdbiUnMiqvrXZhI
	 Zl1Y90LMpECMQ==
Date: Wed, 28 Jan 2026 13:13:46 +0200
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
Message-ID: <20260128111346.GD12149@unreal>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-3-alibuda@linux.alibaba.com>
 <aXPEFdEdtSmd6AzF@milan>
 <20260124093505.GA98529@j66a10360.sqa.eu95>
 <aXSjm1DXm6yP62tD@pc636>
 <20260124145754.GA57116@j66a10360.sqa.eu95>
 <20260127133417.GU13967@unreal>
 <20260128034558.GA126415@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128034558.GA126415@j66a10360.sqa.eu95>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16131-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,linux-foundation.org,linux.alibaba.com,google.com,kernel.org,redhat.com,linux.ibm.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 79D78A01F0
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 11:45:58AM +0800, D. Wythe wrote:
> On Tue, Jan 27, 2026 at 03:34:17PM +0200, Leon Romanovsky wrote:
> > On Sat, Jan 24, 2026 at 10:57:54PM +0800, D. Wythe wrote:
> > > On Sat, Jan 24, 2026 at 11:48:59AM +0100, Uladzislau Rezki wrote:
> > > > Hello, D. Wythe!
> > > > 
> > > > > On Fri, Jan 23, 2026 at 07:55:17PM +0100, Uladzislau Rezki wrote:
> > > > > > On Fri, Jan 23, 2026 at 04:23:48PM +0800, D. Wythe wrote:
> > > > > > > find_vm_area() provides a way to find the vm_struct associated with a
> > > > > > > virtual address. Export this symbol to modules so that modularized
> > > > > > > subsystems can perform lookups on vmalloc addresses.
> > > > > > > 
> > > > > > > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > > > > > > ---
> > > > > > >  mm/vmalloc.c | 1 +
> > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > 
> > > > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > > > index ecbac900c35f..3eb9fe761c34 100644
> > > > > > > --- a/mm/vmalloc.c
> > > > > > > +++ b/mm/vmalloc.c
> > > > > > > @@ -3292,6 +3292,7 @@ struct vm_struct *find_vm_area(const void *addr)
> > > > > > >  
> > > > > > >  	return va->vm;
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL_GPL(find_vm_area);
> > > > > > >  
> > > > > > This is internal. We can not just export it.
> > > > > > 
> > > > > > --
> > > > > > Uladzislau Rezki
> > > > > 
> > > > > Hi Uladzislau,
> > > > > 
> > > > > Thank you for the feedback. I agree that we should avoid exposing
> > > > > internal implementation details like struct vm_struct to external
> > > > > subsystems.
> > > > > 
> > > > > Following Christoph's suggestion, I'm planning to encapsulate the page
> > > > > order lookup into a minimal helper instead:
> > > > > 
> > > > > unsigned int vmalloc_page_order(const void *addr){
> > > > > 	struct vm_struct *vm;
> > > > >  	vm = find_vm_area(addr);
> > > > > 	return vm ? vm->page_order : 0;
> > > > > }
> > > > > EXPORT_SYMBOL_GPL(vmalloc_page_order);
> > > > > 
> > > > > Does this approach look reasonable to you? It would keep the vm_struct
> > > > > layout private while satisfying the optimization needs of SMC.
> > > > > 
> > > > Could you please clarify why you need info about page_order? I have not
> > > > looked at your second patch.
> > > > 
> > > > Thanks!
> > > > 
> > > > --
> > > > Uladzislau Rezki
> > > 
> > > Hi Uladzislau,
> > > 
> > > This stems from optimizing memory registration in SMC-R. To provide the
> > > RDMA hardware with direct access to memory buffers, we must register
> > > them with the NIC. During this process, the hardware generates one MTT
> > > entry for each physically contiguous block. Since these hardware entries
> > > are a finite and scarce resource, and SMC currently defaults to a 4KB
> > > registration granularity, a single 2MB buffer consumes 512 entries. In
> > > high-concurrency scenarios, this inefficiency quickly exhausts NIC
> > > resources and becomes a major bottleneck for system scalability.
> > 
> > I believe this complexity can be avoided by using the RDMA MR pool API,
> > as other ULPs do, for example NVMe.
> > 
> > Thanks
> > 
> 
> Hi Leon,
> 
> Am I correct in assuming you are suggesting mr_pool to limit the number
> of MRs as a way to cap MTTE consumption?

I don't see this a limit, but something that is considered standard
practice to reduce MTT consumption.

> 
> However, our goal is to maximize the total registered memory within
> the MTTE limits rather than to cap it. In SMC-R, each connection
> occupies a configurable, fixed-size registered buffer; consequently,
> the more memory we can register, the more concurrent connections
> we can support.

It is not cap, but more efficient use of existing resources.

> 
> By leveraging vmalloc_huge() and the proposed helper to increase the
> page_size in ib_map_mr_sg(), each MTTE covers a much larger contiguous
> physical block. This significantly reduces the total number of entries
> required to map the same amount of memory, allowing us to serve more
> connections under the same hardware constraints
> 
> D. Wythe

