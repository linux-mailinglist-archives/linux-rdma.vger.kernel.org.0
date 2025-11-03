Return-Path: <linux-rdma+bounces-14212-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB4CC2CD68
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 16:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F894341D89
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADBE283FF0;
	Mon,  3 Nov 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfcKEgS/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883BA1C3C18;
	Mon,  3 Nov 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184641; cv=none; b=iVOUX8qBypZKNST+bkOTHEgWDCySWtrL27Gud7NOjEghMINzdFbSTvMcvieWM+cNV7m2n7H2rJ/iRW1Nlrh3IJ/6YZ9JGwXgaPMzW8xk1SC6LrUWLY7kWx4GYUXeVwnzSaeLYpe7SogFy2fAFQ5Yh4r7VDqsLlLgi+vnWKjCleU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184641; c=relaxed/simple;
	bh=wR1QflBlfe5ERNilFxUouycAz1cUQmQm0FY6/R0rkSM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bT7z/nxbJ747hhDmItP91lBv3JbJrsVwQk0pYhFSCSZb7r9noJnO9bXova7/i1taFu+1arTiFjgPy3ZXXChasT6kNGCu5qEMhbSXO8UJGe7NlbSyxXJnLclvo9Pk8GopLcfqvrnBQFShAqLkQUxW0Oi6onpKgQUqnhSZgozecyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfcKEgS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6D7C4CEE7;
	Mon,  3 Nov 2025 15:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762184641;
	bh=wR1QflBlfe5ERNilFxUouycAz1cUQmQm0FY6/R0rkSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mfcKEgS/LKwZdpg1ZrnYlAI0/roG0labqHtQL7PYlVf9zVv2djXhRJhLakbhLa3vN
	 CwjNikLELKbOmDOD3RkDYSrUOvvnfxpRlg26zzs1SdT564PlljmxWNQr/N4wh/4AZB
	 1GWugNxP0o01d+htneIkn6KMJsmFp5oalhSKYPlvrNMPy5GNRrkBKz5nCyxICeF6Yj
	 0dUBmsJrIOcSG2TtdCg6fRePiCEZDXKqYXtWH/zuSPx6JQse1+BsmPzqRD8wtEmSR4
	 wZN8VAG9MT14VG9LqPLcGK3MvOiOewsE+jtSwg1FIbCMs+hr8P51a5LwamL4FAAkRk
	 /DWzrQZS2dPAw==
Date: Mon, 3 Nov 2025 09:43:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>
Subject: Re: [PATCH mlx5-next 1/2] PCI/TPH: Expose pcie_tph_get_st_table_loc()
Message-ID: <20251103154359.GA1806626@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027-st-direct-mode-v1-1-e0ad953866b6@nvidia.com>

On Mon, Oct 27, 2025 at 11:34:01AM +0200, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@nvidia.com>
> 
> Expose pcie_tph_get_st_table_loc() to be used by drivers as will be done
> in the next patch from the series.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/pci/tph.c       | 7 ++++---
>  include/linux/pci-tph.h | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index cc64f93709a4..8f8457ec9adb 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -155,7 +155,7 @@ static u8 get_st_modes(struct pci_dev *pdev)
>  	return reg;
>  }
>  
> -static u32 get_st_table_loc(struct pci_dev *pdev)
> +u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>  {
>  	u32 reg;
>  
> @@ -163,6 +163,7 @@ static u32 get_st_table_loc(struct pci_dev *pdev)
>  
>  	return FIELD_GET(PCI_TPH_CAP_LOC_MASK, reg);
>  }
> +EXPORT_SYMBOL(pcie_tph_get_st_table_loc);

OK by me, but I think we should add kernel-doc for the return value.

With that doc added:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>


>  /*
>   * Return the size of ST table. If ST table is not in TPH Requester Extended
> @@ -174,7 +175,7 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
>  	u32 loc;
>  
>  	/* Check ST table location first */
> -	loc = get_st_table_loc(pdev);
> +	loc = pcie_tph_get_st_table_loc(pdev);
>  
>  	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
>  	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
> @@ -299,7 +300,7 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
>  	 */
>  	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
>  
> -	loc = get_st_table_loc(pdev);
> +	loc = pcie_tph_get_st_table_loc(pdev);
>  	/* Convert loc to match with PCI_TPH_LOC_* */
>  	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
>  
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index 9e4e331b1603..ba28140ce670 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -29,6 +29,7 @@ int pcie_tph_get_cpu_st(struct pci_dev *dev,
>  void pcie_disable_tph(struct pci_dev *pdev);
>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
> +u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
>  #else
>  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>  					unsigned int index, u16 tag)
> 
> -- 
> 2.51.0
> 

