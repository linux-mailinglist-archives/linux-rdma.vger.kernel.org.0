Return-Path: <linux-rdma+bounces-9382-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABABA86520
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 19:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA688A8563
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1903F2586ED;
	Fri, 11 Apr 2025 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKtlw77k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D36238D3A
	for <linux-rdma@vger.kernel.org>; Fri, 11 Apr 2025 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394134; cv=none; b=ObnniP0Pky3HyrqsFgdDOGyRDUN+7qr19mEdCbGT2Vu60qcfw3QDRmfo1djiGuxCLtpQSSVz4h7vUPKWWUrF/SMShQbwlzlYBSJNN51hE3M6A1kbdFOHW5hR8vneaxfyto3Pz9VyHFc1+hkW5KyrHgBFOkgKdlAvKDJT3my3QZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394134; c=relaxed/simple;
	bh=/JCSjWMX1LjsCOEVFTR4/FExIEkcSbv6Oo1dBeppbis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCsRcx63KPIRfMtb80X7ofYAydSH7KmcxupxNIA1AH3j7yJdhefh/6eWA8QWGMYdrWsATsj57c8EpoPce4xBWUsxR6iUqXHCUKv6BaSnwBgBfeRUr5GRsBPpbt3Ymy3j2eOAuWRwNdbx8SfqG56+qjiQ/qsokkz9moJjsNodgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKtlw77k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D688BC4CEE2;
	Fri, 11 Apr 2025 17:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744394134;
	bh=/JCSjWMX1LjsCOEVFTR4/FExIEkcSbv6Oo1dBeppbis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKtlw77kBmgXfgc39rGkbYlybbQBjCx8damwSqU4bwWusFA3SkpcIRSYikOcDG4ez
	 mMiLWLyoBk7rNSPf0RkZVlb4OMJAuAkjtPYXXgF1PLCSOcp3fWmN1JMOhPA8+1bQ8K
	 QUbLL95vjAQVdO/Gw4ctFH6wRqfeSHHjlIRbxhnx+oLulCtkMUHNWdRBXDNfzjYRjO
	 XqA8/pCwYkZaQ6rxIhVALUTFhkYrU6ER1xVH98cOU894/E4Oy7Q6wPj59CWbTdas+t
	 i177yBS16Z4SnIOroCPDNgNpoKXdoNiWeuv+GzBKO1lZ1xjV+YGkEkMTCGXPof9uUs
	 4SCR15LJuu7Nw==
Date: Fri, 11 Apr 2025 20:55:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v3 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE
 with ODP
Message-ID: <20250411175528.GX199604@unreal>
References: <20250324075649.3313968-1-matsuda-daisuke@fujitsu.com>
 <174411071857.217309.12836295631004196048.b4-ty@kernel.org>
 <OS3PR01MB986530139AE70B2D0BB6C111E5B62@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB986530139AE70B2D0BB6C111E5B62@OS3PR01MB9865.jpnprd01.prod.outlook.com>

On Fri, Apr 11, 2025 at 08:13:59AM +0000, Daisuke Matsuda (Fujitsu) wrote:
> Hi Leon,
> 
> I have noticed the 2nd patch caused "kernel test robot" error, and you
> kindly amended the patch. However, another error has been detected by "the bot"
> because of the remaining fundamental problem that ATOMIC WRITE cannot
> be executed on non-64-bit architectures (at least on rxe).
> 
> I think applying the change below to the original patch(*1) will resolve the issue.
> (*1) https://lore.kernel.org/linux-rdma/20250324075649.3313968-3-matsuda-daisuke@fujitsu.com/
> ```
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index 02de05d759c6..ac3b3039db22 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -380,6 +380,7 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
>  }
> 
>  /* CONFIG_64BIT=y */
> +#ifdef CONFIG_64BIT
>  enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>  {
>         struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> @@ -424,3 +425,4 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
> 
>         return RESPST_NONE;
>  }
> +#endif
> ```
> The definition of rxe_odp_do_atomic_write() should have been guarded in #ifdef CONFIG_64BIT.
> I believe this fix can address both:
>   - the first error "error: redefinition of 'rxe_odp_do_atomic_write' " that could be caused when
>     CONFIG_INFINIBAND_ON_DEMAND_PAGING=y && CONFIG_64BIT=n.
>   - the second error caused by trying to compile 64-bit codes on 32-bit architectures.
> 
> I am very sorry to bother you, but is it possible to make the modification?
> If I should provide a replacement patch, I will do so.

I think that better will be simply make sure that RXE is dependent on 64bits.

diff --git a/drivers/infiniband/sw/rxe/Kconfig b/drivers/infiniband/sw/rxe/Kconfig
index c180e7ebcfc5..1ed5b63f8afc 100644
--- a/drivers/infiniband/sw/rxe/Kconfig
+++ b/drivers/infiniband/sw/rxe/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config RDMA_RXE
        tristate "Software RDMA over Ethernet (RoCE) driver"
-       depends on INET && PCI && INFINIBAND
+       depends on INET && PCI && INFINIBAND && 64BIT
        depends on INFINIBAND_VIRT_DMA
        select NET_UDP_TUNNEL
        select CRC32

WDYT?

Thanks

> 
> Thanks,
> Daisuke
> 
> On Tue, April 8, 2025 8:12 PM Leon Romanovsky wrote:
> > On Mon, 24 Mar 2025 16:56:47 +0900, Daisuke Matsuda wrote:
> > > RDMA FLUSH[1] and ATOMIC WRITE[2] were added to rxe, but they cannot run
> > > in the ODP mode as of now. This series is for the kernel-side enablement.
> > >
> > > There are also minor changes in libibverbs and pyverbs. The rdma-core tests
> > > are also added so that people can test the features.
> > > PR: https://github.com/linux-rdma/rdma-core/pull/1580
> > >
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/2] RDMA/rxe: Enable ODP in RDMA FLUSH operation
> >       https://git.kernel.org/rdma/rdma/c/32cad6aab9a699
> > [2/2] RDMA/rxe: Enable ODP in ATOMIC WRITE operation
> >       https://git.kernel.org/rdma/rdma/c/3e2746e0863f48
> > 
> > Best regards,
> > --
> > Leon Romanovsky <leon@kernel.org>
> 

