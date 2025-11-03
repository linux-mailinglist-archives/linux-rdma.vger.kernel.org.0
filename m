Return-Path: <linux-rdma+bounces-14214-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E9BC2D776
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 18:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF5D74E78C3
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 17:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB7631B102;
	Mon,  3 Nov 2025 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwWnPAkG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8C2156678;
	Mon,  3 Nov 2025 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190912; cv=none; b=kk5tGXidYCnNaYtU/TxljErpiYNix24lz6MchABblJ4Tnv4pYJzFGCc72Wx36ccA8nyXa5sPUW+dXgHjSKnNQ7ECZqZHkbCaTClSNfe8B82KkkTKMkSCNTWljlr5SWptHePFNqm+devFCKNJjZwTu9iupWGSmDBZigOc4DzuEXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190912; c=relaxed/simple;
	bh=xn8o05xUchR4VJZbvh3b7LrEVKldpcP244qArsTXXVI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GS+3dseTTWJNAABZ21Dke7psqDD2iBSYEbXPyFY1UxL8964fN69ZjZ6vQlJuakgRicnJMZcmbNAlNdb6p6ctu7HGXXNPwrs1LOHmtOmI2o+y63TAeeOwJNhV0PyqL3wzIVX4j4LUZOUw18RVUHoH90fCNseqvowPtgZoAPjjK/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwWnPAkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0444BC4CEE7;
	Mon,  3 Nov 2025 17:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762190912;
	bh=xn8o05xUchR4VJZbvh3b7LrEVKldpcP244qArsTXXVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mwWnPAkGnsmPrgqlf8pyTOI5XUhmBZS5vXTg6IX9pJry4PPcJOfns8zSFy0SEufL+
	 vsYNYNEmwmI8/2OhKWhXkkmisVla1c4lfW58fiYuX2j2gRktQTBVVtnE+VnsC4/kwi
	 yKFzQhbeRX1MSlB2uXnpKiDv2iQi6TvBFEtrKnRpaS6Pm/LhteW3SEG7ouAQGV0ySR
	 JeCYpgmuf81mrwKw8BEwLKRY5Zt4VN1PXUVxCAlK91G5m7t2gYYpdToke9K6TYq1Qi
	 6t1Yqab9hRFg4QOlv4cUSnE18QfIUOkMGJOXmpE3M6NofJUkvFB8LWQ2RrnpQiLoDd
	 InMlobK4o/Rtw==
Date: Mon, 3 Nov 2025 11:28:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	Edward Srouji <edwards@nvidia.com>
Subject: Re: [PATCH mlx5-next 1/2] PCI/TPH: Expose pcie_tph_get_st_table_loc()
Message-ID: <20251103172830.GA1811635@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9cb13f6-570e-422f-b988-035a31e85330@nvidia.com>

On Mon, Nov 03, 2025 at 06:23:26PM +0200, Yishai Hadas wrote:
> On 03/11/2025 17:43, Bjorn Helgaas wrote:
> > On Mon, Oct 27, 2025 at 11:34:01AM +0200, Leon Romanovsky wrote:
> > > From: Yishai Hadas <yishaih@nvidia.com>
> > > 
> > > Expose pcie_tph_get_st_table_loc() to be used by drivers as will be done
> > > in the next patch from the series.
> > > 
> > > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> > > Signed-off-by: Edward Srouji <edwards@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >   drivers/pci/tph.c       | 7 ++++---
> > >   include/linux/pci-tph.h | 1 +
> > >   2 files changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> > > index cc64f93709a4..8f8457ec9adb 100644
> > > --- a/drivers/pci/tph.c
> > > +++ b/drivers/pci/tph.c
> > > @@ -155,7 +155,7 @@ static u8 get_st_modes(struct pci_dev *pdev)
> > >   	return reg;
> > >   }
> > > -static u32 get_st_table_loc(struct pci_dev *pdev)
> > > +u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
> > >   {
> > >   	u32 reg;
> > > @@ -163,6 +163,7 @@ static u32 get_st_table_loc(struct pci_dev *pdev)
> > >   	return FIELD_GET(PCI_TPH_CAP_LOC_MASK, reg);
> > >   }
> > > +EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
> > 
> > OK by me, but I think we should add kernel-doc for the return value.
> > 
> > With that doc added:
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Thanks Bjorn.
> 
> We may add the below hunk.
> 
> Can that work for you ?

No, because (a) it just restates the function name and doesn't say how
to interpret the return value (you would need a PCIe spec to look it
up) and (b) kernel-doc syntax would be "Return: " (see
Documentation/doc-guide/kernel-doc.rst for examples).

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 8f8457ec9adb..385307a9a328 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -155,6 +155,12 @@ static u8 get_st_modes(struct pci_dev *pdev)
>         return reg;
>  }
> 
> +/**
> + * pcie_tph_get_st_table_loc - query the device for its ST table location
> + * @pdev: PCI device to query
> + *
> + * Return the location of the ST table
> + */
>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>  {
>         u32 reg;
> 
> Yishai
> 
> > 
> > 
> > >   /*
> > >    * Return the size of ST table. If ST table is not in TPH Requester Extended
> > > @@ -174,7 +175,7 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
> > >   	u32 loc;
> > >   	/* Check ST table location first */
> > > -	loc = get_st_table_loc(pdev);
> > > +	loc = pcie_tph_get_st_table_loc(pdev);
> > >   	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
> > >   	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
> > > @@ -299,7 +300,7 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
> > >   	 */
> > >   	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
> > > -	loc = get_st_table_loc(pdev);
> > > +	loc = pcie_tph_get_st_table_loc(pdev);
> > >   	/* Convert loc to match with PCI_TPH_LOC_* */
> > >   	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
> > > diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> > > index 9e4e331b1603..ba28140ce670 100644
> > > --- a/include/linux/pci-tph.h
> > > +++ b/include/linux/pci-tph.h
> > > @@ -29,6 +29,7 @@ int pcie_tph_get_cpu_st(struct pci_dev *dev,
> > >   void pcie_disable_tph(struct pci_dev *pdev);
> > >   int pcie_enable_tph(struct pci_dev *pdev, int mode);
> > >   u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
> > > +u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
> > >   #else
> > >   static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
> > >   					unsigned int index, u16 tag)
> > > 
> > > -- 
> > > 2.51.0
> > > 
> 

