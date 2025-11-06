Return-Path: <linux-rdma+bounces-14277-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24897C3A3C3
	for <lists+linux-rdma@lfdr.de>; Thu, 06 Nov 2025 11:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6061A4330D
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Nov 2025 10:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEC9272E41;
	Thu,  6 Nov 2025 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRZyuhTz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A1B24A066;
	Thu,  6 Nov 2025 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424363; cv=none; b=aIAyuDRixMGpghu7z6+OY2+dfq5YlR4Zg1RC+KjT6gTUNeuYAaPYv+Dq90CbDCHsvg/yF5n/KTV25L+BHdkzLSURwGFXPZD4VdWFMTpH7gTzvLqGkR1gLzN9Yqylu8TOSjQ9/iXaqFigRV2V1d7VEH034OuIU1Z+Uoiey1wjhzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424363; c=relaxed/simple;
	bh=hs/A+N+htIsKKvVU/+NDMC5chb5uIaWj8bHWDdptfYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orO2arU3YUp+FeBuT9tZKBfny8tFZygT8pb5bh8tK4eZlKwjquvjzlzqOT500q8FtqXq5kB+LW1yPMS+GDENpFjyeeQLBs/i5LnKs3YJAClCEq5VJnT9eXgvCTqVeSwcbcfS93BSDerrPcNXtOG31yXO30RUdd5FRhQTxK/JB7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRZyuhTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BC5C4CEFB;
	Thu,  6 Nov 2025 10:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762424362;
	bh=hs/A+N+htIsKKvVU/+NDMC5chb5uIaWj8bHWDdptfYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eRZyuhTz7mHE8pK88VtwEAirygTFJiB8B5RM40tRKUgk+Iadxln4YxmNWnDPmS6bQ
	 z9ySCW/wVXL+oOt+eTfuIrbpP2bDarCyvQXuSNdlyHHscKKFMx1WzTFqwM1XBTc6ye
	 Bc6WUttxyt+3hKDtkrU8mNUZ74K6mJOTgXl++Wn3sgfa/HCqPA8jNkeSnQz9Xy16fq
	 vpGsUtHIzLo17RFoHdlGEz1+YQ0I7GethLXXU82acXpodT2U6SedZozXbcR0SD3VbT
	 FlE27Ham7pNomQUZkMVl2xfRQ6/EvNOsnKGmUCyO9k9CxgtARRR0QxraS53DMDhVWa
	 ELeDUnIZGiYZQ==
Date: Thu, 6 Nov 2025 12:19:17 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
	Jay Cornwall <Jay.Cornwall@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alexander Schmidt <alexs@linux.ibm.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] ib/mlx5: Request PCIe AtomicOps enabled for all
 3 sizes
Message-ID: <20251106101917.GB15456@unreal>
References: <20251105-mlxatomics-v1-0-10c71649e08d@linux.ibm.com>
 <20251105-mlxatomics-v1-2-10c71649e08d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-mlxatomics-v1-2-10c71649e08d@linux.ibm.com>

On Wed, Nov 05, 2025 at 06:55:14PM +0100, Gerd Bayer wrote:
> Pass fully populated capability bit-mask requesting support for all 3
> sizes of AtomicOps at once when attempting to enable AtomicOps for PCI
> function.
> 
> When called individually, pci_enable_atomic_ops_to_root() may enable the
> device to send requests as soon as one size is supported. According to
> PCIe Spec 7.0 Section 6.15.3.1 support of 32-bit and 64-bit AtomicOps
> completer capabilities are tied together for root-ports. Only the
> 128-bit/CAS completer capabilities is an optional feature, but still we
> might end up end up enabling AtomicOps despite 128-bit/CAS is not
> supported at the root-port.
> 
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
>  drivers/infiniband/hw/mlx5/data_direct.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/data_direct.c b/drivers/infiniband/hw/mlx5/data_direct.c
> index b81ac5709b56f6ac0d9f60572ce7144258fa2794..112185be53f1ccc6a797e129f24432bdc86008ae 100644
> --- a/drivers/infiniband/hw/mlx5/data_direct.c
> +++ b/drivers/infiniband/hw/mlx5/data_direct.c
> @@ -179,9 +179,9 @@ static int mlx5_data_direct_probe(struct pci_dev *pdev, const struct pci_device_
>  	if (err)
>  		goto err_disable;
>  
> -	if (pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP32) &&
> -	    pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP64) &&
> -	    pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP128))
> +	if (pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> +						PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
> +						PCI_EXP_DEVCAP2_ATOMIC_COMP128))

I would expect some new define which combines all together, with some
comment why it exists:
#define PCI_ATOMIC_COMP_v7  PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64 | PCI_EXP_DEVCAP2_ATOMIC_COMP128

Anyway the change looks right to me.

Thanks,
Acked-by: Leon Romanovsky <leon@kernel.org>

