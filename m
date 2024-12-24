Return-Path: <linux-rdma+bounces-6720-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCCC9FBB88
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 10:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2339D188772C
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C9D1B4F3E;
	Tue, 24 Dec 2024 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe/CI9sh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06191B4F1A;
	Tue, 24 Dec 2024 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033652; cv=none; b=CxDz4moDcv2ILQfoft5VSLQ+/xNsMzSArA9VIvRLbFTf0WAHdE7pesRPeW7IIBdCZC3fC+l+NVOATKfAuhsrJptszGFNWgnUBiH/s5Y3TTuSvpPexdd18fpTFL/SA+iMRNdEeKS3FUpRIONbcC3cvxWMevM67zddjkOfbrMDqJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033652; c=relaxed/simple;
	bh=jY9IZPx6jk7OwS6OUhXuvp90vIsFxDF46hmZoG0Kbx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhcxeCKK+ih3P74lxRuaJZvDeGOLqvHsoZaR2cjgfyBrCV+OxGqJLGVyKIhxzE/dBrmbp8jsSe7dM/B1JUkPksHkMdgjErK58r7DX19rytk3Pm91HmGTbJy4c0DJCfdyawQ24sCbgFkzGXf3/fSoIL8mTC7fRlLCCnU+04nMb6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe/CI9sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F8BC4CED0;
	Tue, 24 Dec 2024 09:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735033652;
	bh=jY9IZPx6jk7OwS6OUhXuvp90vIsFxDF46hmZoG0Kbx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fe/CI9shC/Linp3eJUijYQQhEw05jHmlQLOXfV30AXXWD4MahQ55LJ6rsYflgHF4z
	 oUzhz3Hst65Cu1abaSGq6C8Lu0T8uIIeu1AqFWyTHwreJml/L9+YtjXxOdhVsZsiNa
	 av9GBmG76Uhmgnc7eB9TQpDDBFOtkFIb5HqLATZ27ApRISmb4Kt/s9Ui8S0cAd9vs4
	 UXFWxbbxRb5xrCCoDn0OCCnODBUScMuncqbufFzELxON2qM1u1gHTw6GP33QnV/bYk
	 xMNPlFYPs2J9ueRR+2ln0FOWd6rxQmV0RAszZDJeemD2RS8LsqKWjI0aUr9r1sOcL7
	 0LdVR2vnNZsxQ==
Date: Tue, 24 Dec 2024 11:47:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: failed to allocate device WQ
Message-ID: <20241224094727.GD171473@unreal>
References: <8328f0ab-fbd8-5d43-fbb3-f2954ccbd779@praktifix.dwd.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8328f0ab-fbd8-5d43-fbb3-f2954ccbd779@praktifix.dwd.de>

On Fri, Dec 20, 2024 at 05:10:32PM +0000, Holger Kiehl wrote:
> Hello,
> 
> since upgrading from kernel 6.10 to 6.11 (also 6.12) one Infiniband
> card sometimes hits this error:
> 
>    kernel: workqueue: Failed to create a rescuer kthread for wq "ipoib_wq": -EINTR
>    kernel: ib0: failed to allocate device WQ
>    kernel: mlx5_1: failed to initialize device: ib0 port 1 (ret = -12)
>    kernel: mlx5_1: couldn't register ipoib port 1; error -12
> 
> The system has two cards:
> 
>    41:00.0 Infiniband controller: Mellanox Technologies MT28908 Family [ConnectX-6]
>    c4:00.0 Infiniband controller: Mellanox Technologies MT28908 Family [ConnectX-6]
> 
> If that happens one cannot use that card for TCP/IP communication. It does
> not always happen, but when it does it always happens with the second
> card mlx5_1. Never with mlx5_0. This happens on four different systems.
> 
> Any idea what I can do to stop this from happening?

It is not related to the FW but to how your system loads kernel modules.

This merged PR in rdma-core probably fixes it.
* Ensure RDMA service loads modules in initrd - https://github.com/linux-rdma/rdma-core/pull/1481

Thanks

> 
> Regards,
> Holger
> 
> PS: Firmware for both cards is 20.41.1000

