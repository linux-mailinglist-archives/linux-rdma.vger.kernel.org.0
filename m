Return-Path: <linux-rdma+bounces-9488-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBD8A90984
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 19:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190555A1D5B
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 16:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C67215174;
	Wed, 16 Apr 2025 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGDYkCYG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27D1B415F
	for <linux-rdma@vger.kernel.org>; Wed, 16 Apr 2025 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822718; cv=none; b=IWWzhnTsd9JgOA3YJ0foe0k0dgUzhVn9u9tpJTap3HFzYtu1qkhozOFDPI5Y04khl1nKXleZ1qKZxijxhfjJahmCOS9o9ItvYjz4YTTxA32Y6VZu3GAvE57Bu9MUepmB9aD7sWdawuiGM9uWNrJwALrvZ9CiV9PSX5JseJ3px5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822718; c=relaxed/simple;
	bh=ziMd1Oz0Gabm0P6Ump01XQxYlm2mfWyou9sOvxAaPVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plFBL63js2rD0p0DLjTivd+cCjtU4R07R9S0Imd6505eAmug3AbnypD24Kb00ItUlaTswM4eag3WzxUoI2E8Af5dNylppTrNh0bao0hOsqGsILKGYzYbP/EuKhYvyDyGECBg1M3SbSNqUemlCFgVEUu3/1As5QIhYoNpDd4d14U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGDYkCYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3439AC4CEE4;
	Wed, 16 Apr 2025 16:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744822718;
	bh=ziMd1Oz0Gabm0P6Ump01XQxYlm2mfWyou9sOvxAaPVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGDYkCYGDSg6444Jx+yV4S6Usm1L3/qP7K1vMjyE7lt5S19v6zmus7y9GjQh1D1c0
	 XTYWEyUi9lTsJe2WSwdMDBhrXniBt7JHNWrDbUoqXWUBzL4YBXhkXHKI2O5EVQq7g9
	 3lwRGcE2UL5bHiA8HUtLiBqJ2AvkIVV9tOFJFIfzWP4UTRHAzZKt/vRBXg1iXtT3D6
	 46oee6vOYFty8KIMfiN03vm/5C7vrshMm1v+pUNvzyjbZmApKXeDp+LK+y68dx5U6J
	 pYtNzum2IFBLCKZYiGw5KVx4PYktqU7C4syRHd+ap4zB4AzLZUxNRg3MrdJGTZUoc1
	 UzIkU0C6SQVeg==
Date: Wed, 16 Apr 2025 19:58:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v3 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE
 with ODP
Message-ID: <20250416165834.GZ199604@unreal>
References: <20250324075649.3313968-1-matsuda-daisuke@fujitsu.com>
 <174411071857.217309.12836295631004196048.b4-ty@kernel.org>
 <OS3PR01MB986530139AE70B2D0BB6C111E5B62@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20250411175528.GX199604@unreal>
 <OS3PR01MB9865CBFAA8DAA73AA42C6D95E5B32@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <8304bc38-7c3b-4e24-ad15-7dcf0eb40fa2@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8304bc38-7c3b-4e24-ad15-7dcf0eb40fa2@linux.dev>

On Mon, Apr 14, 2025 at 02:56:51PM +0200, Zhu Yanjun wrote:
> On 14.04.25 12:16, Daisuke Matsuda (Fujitsu) wrote:
> > On Sat, April 12, 2025 2:55 AM Leon Romanovsky wrote:
> > > > Hi Leon,
> > > > 
> > > > I have noticed the 2nd patch caused "kernel test robot" error, and you
> > > > kindly amended the patch. However, another error has been detected by "the bot"
> > > > because of the remaining fundamental problem that ATOMIC WRITE cannot
> > > > be executed on non-64-bit architectures (at least on rxe).
> > > > 
> > > > I think applying the change below to the original patch(*1) will resolve the issue.
> > > > (*1) https://lore.kernel.org/linux-rdma/20250324075649.3313968-3-matsuda-daisuke@fujitsu.com/
> > > > ```
> > > > diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> > > > index 02de05d759c6..ac3b3039db22 100644
> > > > --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> > > > +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> > > > @@ -380,6 +380,7 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
> > > >   }
> > > > 
> > > >   /* CONFIG_64BIT=y */
> > > > +#ifdef CONFIG_64BIT
> > > >   enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
> > > >   {
> > > >          struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> > > > @@ -424,3 +425,4 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
> > > > 
> > > >          return RESPST_NONE;
> > > >   }
> > > > +#endif
> > > > ```
> > > > The definition of rxe_odp_do_atomic_write() should have been guarded in #ifdef CONFIG_64BIT.
> > > > I believe this fix can address both:
> > > >    - the first error "error: redefinition of 'rxe_odp_do_atomic_write' " that could be caused when
> > > >      CONFIG_INFINIBAND_ON_DEMAND_PAGING=y && CONFIG_64BIT=n.
> > > >    - the second error caused by trying to compile 64-bit codes on 32-bit architectures.
> > > > 
> > > > I am very sorry to bother you, but is it possible to make the modification?
> > > > If I should provide a replacement patch, I will do so.
> > > 
> > > I think that better will be simply make sure that RXE is dependent on 64bits.
> > > 
> > > diff --git a/drivers/infiniband/sw/rxe/Kconfig b/drivers/infiniband/sw/rxe/Kconfig
> > > index c180e7ebcfc5..1ed5b63f8afc 100644
> > > --- a/drivers/infiniband/sw/rxe/Kconfig
> > > +++ b/drivers/infiniband/sw/rxe/Kconfig
> > > @@ -1,7 +1,7 @@
> > >   # SPDX-License-Identifier: GPL-2.0-only
> > >   config RDMA_RXE
> > >          tristate "Software RDMA over Ethernet (RoCE) driver"
> > > -       depends on INET && PCI && INFINIBAND
> > > +       depends on INET && PCI && INFINIBAND && 64BIT
> > >          depends on INFINIBAND_VIRT_DMA
> > >          select NET_UDP_TUNNEL
> > >          select CRC32
> > > 
> > > WDYT?
> > 
> > It seems the driver is designed to be runnable on 32-bit nodes, so it may be
> > overkill to disable 32-bit mode only for "ATOMIC WRITE" functionality.
> > However, I do not have strong objection to making this change if you
> > think it is better in terms of maintainability.
> > 
> > Before making the change, I'd like to get an ACK or NACK from Zhu Yanjun.
> > As far as I am aware, no one is actively maintaining or testing RXE on 32-bit,
> > so it may be acceptable to drop 32-bit support, but it's best to confirm before proceeding.
> 
> Hi, Daisuke Matsuda
> 
> Thanks a lot for your efforts.
> 
> There are some problems with 32-bit architectures, such as Year 2038 problem
> ( many 32-bit systems will stop working in the year 2038 when the 32-bit
> time_t overflows).
> 
> And many binary distributions, like Fedora, Ubuntu, and openSUSE Leap, have
> dropped support for all 32-bit architectures other than Armv7 and are likely
> to drop that as well before they would consider rebuilding against a new
> glibc.
> 
> In the kernel 6.15, support for larger 32-bit x86 systems (those with more
> than eight CPUs or more than 4GB of RAM) has been removed. Those hardware
> configurations have been unavailable for a long time, and any workloads
> needing such resources should have long since moved to 64-bit systems.
> 
> Thus, it seems that it is a trend to not support 32-bit architecture in
> Linux kernel. In rxe, we will also follow this trend.
> 
> If some user-space applications still use 32-bit architecture currently, we
> can apply your commit. But from Linux kernel community, sooner or later, the
> support of 32-bit architecture will be dropped.
> 
> Finally if some user-space applications still need 32-bit architecture in
> rxe, we can keep it. Or else, we will follow Leon's advice.
> 
> 
> It is just my 2-cent advice.^_^
> 
> Please Jason Gunthorpe or Leon Romanovsky comments on this.

At the end RXE is for development, testing and early prototyping. I can't
believe that we have developers who are using 32bits machines for such type
of work in RDMA domain.

Thanks

> 
> Best Regards,
> Zhu Yanjun
> 
> 
> > 
> > Thanks,
> > Daisuke
> > 
> > > 
> > > Thanks
> > > 
> > > > 
> > > > Thanks,
> > > > Daisuke
> > > > 
> > > > On Tue, April 8, 2025 8:12 PM Leon Romanovsky wrote:
> > > > > On Mon, 24 Mar 2025 16:56:47 +0900, Daisuke Matsuda wrote:
> > > > > > RDMA FLUSH[1] and ATOMIC WRITE[2] were added to rxe, but they cannot run
> > > > > > in the ODP mode as of now. This series is for the kernel-side enablement.
> > > > > > 
> > > > > > There are also minor changes in libibverbs and pyverbs. The rdma-core tests
> > > > > > are also added so that people can test the features.
> > > > > > PR: https://github.com/linux-rdma/rdma-core/pull/1580
> > > > > > 
> > > > > > [...]
> > > > > 
> > > > > Applied, thanks!
> > > > > 
> > > > > [1/2] RDMA/rxe: Enable ODP in RDMA FLUSH operation
> > > > >        https://git.kernel.org/rdma/rdma/c/32cad6aab9a699
> > > > > [2/2] RDMA/rxe: Enable ODP in ATOMIC WRITE operation
> > > > >        https://git.kernel.org/rdma/rdma/c/3e2746e0863f48
> > > > > 
> > > > > Best regards,
> > > > > --
> > > > > Leon Romanovsky <leon@kernel.org>
> > > > 
> 
> 

