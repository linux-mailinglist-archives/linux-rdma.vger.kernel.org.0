Return-Path: <linux-rdma+bounces-14282-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE993C3B2BC
	for <lists+linux-rdma@lfdr.de>; Thu, 06 Nov 2025 14:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 888DB4F9C97
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Nov 2025 13:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2677732BF41;
	Thu,  6 Nov 2025 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvdn8hxM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF238D531;
	Thu,  6 Nov 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434864; cv=none; b=jaJuumaAHhAoIe4up/6eLSwFNkMmTchDSN7wtwhwqXrD9X4VpLbi9p8U3unwZX7Lg9opbhus/700MIMj6A8EneAlPEeF4smoBuCkIpi2XPNTcvUhvyNp/RPEyPLaaZPEwcsr7QzIsPnnzTyRNee8AkvHUW1HGBwZnfU70/vX9O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434864; c=relaxed/simple;
	bh=bR/+/R+baLpO5FuzBWsOS1XGaMj5gHO48nzAAZPjp9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNTmXnNGeH4uLEP69W9KaJzza2So1UIBohI+Xf2QZVxJnvwmLCf/hyAP7aEvOeBSl3IE/4NWv86soNWPPppofmKxpiqrld1q1Wz09aJ9rbCbQ3GpzYs8IXVyq6FTKWw7XpP1Man9fHyhqusjhThXpMaH7S+KS94XsOupjOf2Xdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvdn8hxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B3CC4CEF7;
	Thu,  6 Nov 2025 13:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762434864;
	bh=bR/+/R+baLpO5FuzBWsOS1XGaMj5gHO48nzAAZPjp9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvdn8hxMm67rfm2smrfCSJPimMsivBNyPtDOYdJ27Jkaf1AnxDYMxFqmJKL3h4Kb6
	 1oxEyVaZ9p9GXNqy3+ZC6GPxzBC360h8aUBfKGIk8sATn4RuVytH2frz56Gna04ykP
	 OdNUPg9GQhFuZjwkf67PRk3C8odrlH2Rt1JVVfHe49jia6e3sKPwkTM/nLmxzH+nQj
	 YnKeuqf5Bo3w0JUXfRzG3/CDhYPYtrPUnwW4R51EQ+gAkZFoQVUF9RK1lNDEm1z1mT
	 oBQg3OpPK2cSfG1bEdeHXG+0QNfSHBkoge6y8MGX4SWAUw/hS4jbYq+KsvrIgsc4Q7
	 sjtXjFed+hKRg==
Date: Thu, 6 Nov 2025 15:14:19 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Jay Cornwall <Jay.Cornwall@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alexander Schmidt <alexs@linux.ibm.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] ib/mlx5: Request PCIe AtomicOps enabled for all
 3 sizes
Message-ID: <20251106131419.GC15456@unreal>
References: <20251105-mlxatomics-v1-0-10c71649e08d@linux.ibm.com>
 <20251105-mlxatomics-v1-2-10c71649e08d@linux.ibm.com>
 <20251106101917.GB15456@unreal>
 <ec44c1ceab176c0a4c6447f966da8b7061958ffe.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec44c1ceab176c0a4c6447f966da8b7061958ffe.camel@linux.ibm.com>

On Thu, Nov 06, 2025 at 01:16:18PM +0100, Gerd Bayer wrote:
> On Thu, 2025-11-06 at 12:19 +0200, Leon Romanovsky wrote:
> > On Wed, Nov 05, 2025 at 06:55:14PM +0100, Gerd Bayer wrote:
> > > Pass fully populated capability bit-mask requesting support for all 3
> > > sizes of AtomicOps at once when attempting to enable AtomicOps for PCI
> > > function.
> > > 
> > > When called individually, pci_enable_atomic_ops_to_root() may enable the
> > > device to send requests as soon as one size is supported. According to
> > > PCIe Spec 7.0 Section 6.15.3.1 support of 32-bit and 64-bit AtomicOps
> > > completer capabilities are tied together for root-ports. Only the
> > > 128-bit/CAS completer capabilities is an optional feature, but still we
> > > might end up end up enabling AtomicOps despite 128-bit/CAS is not
> > > supported at the root-port.
> > > 
> > > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > > ---
> > >  drivers/infiniband/hw/mlx5/data_direct.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/hw/mlx5/data_direct.c b/drivers/infiniband/hw/mlx5/data_direct.c
> > > index b81ac5709b56f6ac0d9f60572ce7144258fa2794..112185be53f1ccc6a797e129f24432bdc86008ae 100644
> > > --- a/drivers/infiniband/hw/mlx5/data_direct.c
> > > +++ b/drivers/infiniband/hw/mlx5/data_direct.c
> > > @@ -179,9 +179,9 @@ static int mlx5_data_direct_probe(struct pci_dev *pdev, const struct pci_device_
> > >  	if (err)
> > >  		goto err_disable;
> > >  
> > > -	if (pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP32) &&
> > > -	    pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP64) &&
> > > -	    pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP128))
> > > +	if (pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> > > +						PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
> > > +						PCI_EXP_DEVCAP2_ATOMIC_COMP128))
> > 
> > I would expect some new define which combines all together, with some
> > comment why it exists:
> > #define PCI_ATOMIC_COMP_v7  PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64 | PCI_EXP_DEVCAP2_ATOMIC_COMP128
> 
> I see your point. I don't understand the _v7

v7 - > PCI spec *v7.0*

But it was just suggestion.

Thanks

