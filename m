Return-Path: <linux-rdma+bounces-9583-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8883EA93656
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 13:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DE31B6374D
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 11:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0028270EAA;
	Fri, 18 Apr 2025 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P93zCPaH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574D71FF1D1
	for <linux-rdma@vger.kernel.org>; Fri, 18 Apr 2025 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744974939; cv=none; b=rn171l107/nVUypHBdM7qEg+Hy5LYTps2z+M+uzFihUuErPwtOsFKPzbe8modNdOqhPS4ZZDHhKgswZwA1Gb13HFXEZj+gJJKFCnY6nfsQ3vrkHq1AwYYXolirOGtlGyAuwywI6ud+QWiT/Qwc7sEDdD3ciMkD6GR1DV6Gl8NF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744974939; c=relaxed/simple;
	bh=20XmkWmT+udXa1q0BYsLFmyMzXv5/rdc3ze4pTfdOj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6nh1Gh4qqlScIA1SXD3i4a18ed1esaEQ7C2suJqOmXAdx6f4FgDQdXtxTOAkcN3qxEyexI76CXOStw7wcmvkxWB8Y09BUTSSCw4ejiXnMYqyHoGpnIbrEPmAJg8KFL6ddaiPeNd6LhzOWwy4wJfBBSHq9lZ4uAKE8o2DOVhD2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P93zCPaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F18DC4CEE2;
	Fri, 18 Apr 2025 11:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744974938;
	bh=20XmkWmT+udXa1q0BYsLFmyMzXv5/rdc3ze4pTfdOj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P93zCPaHWNAZunq1qqtW98MKbXMVmokTx0IC6doM2oECw+U9u+aYmG+8hhLeJnOiD
	 Q+KaZvrQUOik6hS25ykJIuSKYXFAJJZ0ziQSHYNZBWtWq7qHF+CRMlxOmFC5S7IVbq
	 RtbK4MXSqlL6UGW73O0819BJGTsMI8z0/L7ENppvXugsAl2/4R7Gi1x5HBT458ptlP
	 4JmNGi0JeJGxcnDMP1l/Kgs0tNnLxPB4gzOkbq4y++a8tznfzarHG2mEWDqdrrF5w3
	 5JGFDPrrJg1iU8PsUWZ74t7BpDP+bkAST+7RtmPqTlZkTlEsHkhvNAL3XJAYUchl6d
	 uEkLSK6RQf4gA==
Date: Fri, 18 Apr 2025 14:15:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v3 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE
 with ODP
Message-ID: <20250418111533.GA199604@unreal>
References: <20250324075649.3313968-1-matsuda-daisuke@fujitsu.com>
 <174411071857.217309.12836295631004196048.b4-ty@kernel.org>
 <OS3PR01MB986530139AE70B2D0BB6C111E5B62@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20250411175528.GX199604@unreal>
 <OS3PR01MB9865CBFAA8DAA73AA42C6D95E5B32@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <8304bc38-7c3b-4e24-ad15-7dcf0eb40fa2@linux.dev>
 <20250416165834.GZ199604@unreal>
 <OS3PR01MB9865FB15CEDD78D9FE339DBBE5BF2@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB9865FB15CEDD78D9FE339DBBE5BF2@OS3PR01MB9865.jpnprd01.prod.outlook.com>

On Fri, Apr 18, 2025 at 02:07:49AM +0000, Daisuke Matsuda (Fujitsu) wrote:
> On Thu, April 17, 2025 1:59 AM Leon Romanovsky wrote:
> > On Mon, Apr 14, 2025 at 02:56:51PM +0200, Zhu Yanjun wrote:
> > > On 14.04.25 12:16, Daisuke Matsuda (Fujitsu) wrote:
> > > > On Sat, April 12, 2025 2:55 AM Leon Romanovsky wrote:
> > > > > > Hi Leon,
> > > > > >
> > > > > > I have noticed the 2nd patch caused "kernel test robot" error, and you
> > > > > > kindly amended the patch. However, another error has been detected by "the bot"
> > > > > > because of the remaining fundamental problem that ATOMIC WRITE cannot
> > > > > > be executed on non-64-bit architectures (at least on rxe).
> > > > > >
> > > > > > I think applying the change below to the original patch(*1) will resolve the issue.
> > > > > > (*1) https://lore.kernel.org/linux-rdma/20250324075649.3313968-3-matsuda-daisuke@fujitsu.com/
> > > > > > ```
> > > > > > diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> > > > > > index 02de05d759c6..ac3b3039db22 100644
> > > > > > --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> > > > > > +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> > > > > > @@ -380,6 +380,7 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
> > > > > >   }
> > > > > >
> > > > > >   /* CONFIG_64BIT=y */
> > > > > > +#ifdef CONFIG_64BIT
> > > > > >   enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
> > > > > >   {
> > > > > >          struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> > > > > > @@ -424,3 +425,4 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
> > > > > >
> > > > > >          return RESPST_NONE;
> > > > > >   }
> > > > > > +#endif
> > > > > > ```
> > > > > > The definition of rxe_odp_do_atomic_write() should have been guarded in #ifdef CONFIG_64BIT.
> > > > > > I believe this fix can address both:
> > > > > >    - the first error "error: redefinition of 'rxe_odp_do_atomic_write' " that could be caused when
> > > > > >      CONFIG_INFINIBAND_ON_DEMAND_PAGING=y && CONFIG_64BIT=n.
> > > > > >    - the second error caused by trying to compile 64-bit codes on 32-bit architectures.
> > > > > >
> > > > > > I am very sorry to bother you, but is it possible to make the modification?
> > > > > > If I should provide a replacement patch, I will do so.
> > > > >
> > > > > I think that better will be simply make sure that RXE is dependent on 64bits.
> > > > >
> > > > > diff --git a/drivers/infiniband/sw/rxe/Kconfig b/drivers/infiniband/sw/rxe/Kconfig
> > > > > index c180e7ebcfc5..1ed5b63f8afc 100644
> > > > > --- a/drivers/infiniband/sw/rxe/Kconfig
> > > > > +++ b/drivers/infiniband/sw/rxe/Kconfig
> > > > > @@ -1,7 +1,7 @@
> > > > >   # SPDX-License-Identifier: GPL-2.0-only
> > > > >   config RDMA_RXE
> > > > >          tristate "Software RDMA over Ethernet (RoCE) driver"
> > > > > -       depends on INET && PCI && INFINIBAND
> > > > > +       depends on INET && PCI && INFINIBAND && 64BIT
> > > > >          depends on INFINIBAND_VIRT_DMA
> > > > >          select NET_UDP_TUNNEL
> > > > >          select CRC32
> > > > >
> > > > > WDYT?
> > > >
> > > > It seems the driver is designed to be runnable on 32-bit nodes, so it may be
> > > > overkill to disable 32-bit mode only for "ATOMIC WRITE" functionality.
> > > > However, I do not have strong objection to making this change if you
> > > > think it is better in terms of maintainability.
> > > >
> > > > Before making the change, I'd like to get an ACK or NACK from Zhu Yanjun.
> > > > As far as I am aware, no one is actively maintaining or testing RXE on 32-bit,
> > > > so it may be acceptable to drop 32-bit support, but it's best to confirm before proceeding.
> > >
> > > Hi, Daisuke Matsuda
> > >
> > > Thanks a lot for your efforts.
> > >
> > > There are some problems with 32-bit architectures, such as Year 2038 problem
> > > ( many 32-bit systems will stop working in the year 2038 when the 32-bit
> > > time_t overflows).
> > >
> > > And many binary distributions, like Fedora, Ubuntu, and openSUSE Leap, have
> > > dropped support for all 32-bit architectures other than Armv7 and are likely
> > > to drop that as well before they would consider rebuilding against a new
> > > glibc.
> > >
> > > In the kernel 6.15, support for larger 32-bit x86 systems (those with more
> > > than eight CPUs or more than 4GB of RAM) has been removed. Those hardware
> > > configurations have been unavailable for a long time, and any workloads
> > > needing such resources should have long since moved to 64-bit systems.
> > >
> > > Thus, it seems that it is a trend to not support 32-bit architecture in
> > > Linux kernel. In rxe, we will also follow this trend.
> > >
> > > If some user-space applications still use 32-bit architecture currently, we
> > > can apply your commit. But from Linux kernel community, sooner or later, the
> > > support of 32-bit architecture will be dropped.
> > >
> > > Finally if some user-space applications still need 32-bit architecture in
> > > rxe, we can keep it. Or else, we will follow Leon's advice.
> > >
> > >
> > > It is just my 2-cent advice.^_^
> > >
> > > Please Jason Gunthorpe or Leon Romanovsky comments on this.
> > 
> > At the end RXE is for development, testing and early prototyping. I can't
> > believe that we have developers who are using 32bits machines for such type
> > of work in RDMA domain.
> 
> Agreed.
> Could you modify "RDMA/rxe: Enable ODP in ATOMIC WRITE operation"
> in the tree and change Kconfig as you suggested?

Just send separate patch, please.

> 
> Thanks,
> Daisuke
> 

