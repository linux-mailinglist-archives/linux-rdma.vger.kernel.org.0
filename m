Return-Path: <linux-rdma+bounces-14386-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 879D8C4CEE3
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 11:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A13024F85C9
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C0533F361;
	Tue, 11 Nov 2025 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBBVCLv/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACE333E369;
	Tue, 11 Nov 2025 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855448; cv=none; b=ZFod8rmc6i9smvYKh4CPf6QvKYsSqnFi4fID4yGd7lhUdhAPd7GcV973PKJKek6iET/U/6QoW9L5YMtnQTyfrpbpvpcPdqhHLeL1MZEu0baVOLqhFWDrdkI6xMdBfiQdAZlmREVgaELMTZubi9VXJlROn4sDmtX1qauhCk/qrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855448; c=relaxed/simple;
	bh=i6ovkRiqPwMnCSQYAXDn8fA6TBV/no3cohkxGYIGngU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JH6l/JYZ6yIz1sf2MEDmLT8xS7UZvtQvnS8gunayCznXR4mZb23EuT7tTT5dFvOrDbfGLXsWpQFwfzn9C4ciAC6/kotv2OINso9mrtqMxhx9x2pge7yVhehPMRBUTPrPqTj7bl3FmG+coEjO/NYxOc9JENPrzajZDcOM29jHfPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBBVCLv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D162C4CEFB;
	Tue, 11 Nov 2025 10:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762855447;
	bh=i6ovkRiqPwMnCSQYAXDn8fA6TBV/no3cohkxGYIGngU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBBVCLv/WgqLScYQRjF4DgJxLc5PZ9PNimXaQpIhaBrwlTCqcL+e4qb7LreYlEF9f
	 ZaT9OJ7cjNwpXA1htez5sc2PlzzwaeemZ2yvcyqmUPznQDqVpqbrvc1LNDtk9NX4+3
	 sFS95Nn81pFGTc2afBNkMCtyrpayTO07eKqQBq1NVbbohJrl6JtpNrjHY0/XypO0iT
	 p1H/ioMgetso3qEvKMaU7kPPwV6BSg/cTwCFDmmKdFh5f6ws87XeoJUU4MiyDS6Ofw
	 /EUuQeM1xcOaqCNV1t6FCyl2tJzQz8VgryRpqGoes5IiTzGeJW2qLyYHbn0yvKblrT
	 O4G9425daFLig==
Date: Tue, 11 Nov 2025 12:04:03 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>
Subject: Re: [PATCH mlx5-next 0/2] Add support for direct steering tag mode
 for RDMA mlx5_ib driver
Message-ID: <20251111100403.GA692490@unreal>
References: <20251027-st-direct-mode-v1-0-e0ad953866b6@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027-st-direct-mode-v1-0-e0ad953866b6@nvidia.com>

On Mon, Oct 27, 2025 at 11:34:00AM +0200, Leon Romanovsky wrote:
> >From Yishai:
> 
> Add support for direct steering mode where ST table location equals
> PCI_TPH_LOC_NONE.
> 
> In that case, no steering table exists, the steering tag itself will be
> used directly by the SW, FW, HW from the mkey.
> 
> In that mode of work, the driver is not limited any more to the 64 max
> entries of the capability config space table.
> 
> The first patch in the series exposes the pcie_tph_get_st_table_loc()
> API to let drivers detect the ST table location.
> 
> The second patch uses the direct mode in case the location equals
> PCI_TPH_LOC_NONE.
> 
> This enables RDMA users working in that direct mode.
> 
> Thanks
> 
> ---
> Yishai Hadas (2):
>       PCI/TPH: Expose pcie_tph_get_st_table_loc()
>       net/mlx5: Add direct ST mode support for RDMA

Thanks, applied to mlx5-next.

