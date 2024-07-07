Return-Path: <linux-rdma+bounces-3682-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7A0929704
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 10:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6301C20C91
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 08:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44275C8F3;
	Sun,  7 Jul 2024 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVgv1u8Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0249D567F
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jul 2024 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720339303; cv=none; b=oI7djC1w/AtILXMryXjBJnMURXlXBLI48hOwJ36J5ALdVUfbvy8lRolJ3pLhheVSkUeXc/xmGTCpy8K3eyLq3k5vCPOgU/podNMHpmJNfYZsIdvGGwxjEEVIPEhUW5OejZwzThaSt4h/ViF11mwbCJVQQ6pQtamdl+eCoOL/ECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720339303; c=relaxed/simple;
	bh=PvrMspCHwuaRoa+hcRY7pTGo/zzEX+L+TiuLaRNj5ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtQ3/RJw/HevV6XR+tNLf9fZfOHQtKm0k3OgKz5YEfE8TPkQWCYiOkhuPaOWtFv29+4dQyChgiDfNMZIVtbCwOw4S5EU0kW8hWoXrSNyXOc57WMmhu5rv6OvswiPiF8BgC7e5LkJidfa/5UA9JaGSF7gTDiYG5xoYntjtth68xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVgv1u8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E30C3277B;
	Sun,  7 Jul 2024 08:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720339302;
	bh=PvrMspCHwuaRoa+hcRY7pTGo/zzEX+L+TiuLaRNj5ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVgv1u8Y0B4ZoGWjgjk5KnE3g0UJ/y5owvgM4mhjA0vTVu7HG0MUfKK7u/W7jehFJ
	 GWQj59ynPVHaf9K3hTMCpNLm7QyxkA/tCnSEjqQFaGctA7c/RiNcpwx3j053POl3nN
	 Sz//mV6fbQ7fSbF9VEP03xBPpODwKYjJnoLVl/WktPctKIEhZEgY9YMstg6VLHDP4t
	 qG16qQxoYyS9Obq3kIe3SDZxqyaI8y2wVI1+BT2tLkpt4ULQ5P2wKBw5cpqOldLRq9
	 bJ7u4Z6QLpcwCJ3PNvS4FbEHYttjokKxK9keMJbs9qcccwPLLYE6v0AirGr6BP7Mmz
	 gGSdxzsaLUZNg==
Date: Sun, 7 Jul 2024 11:01:38 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Mark Zhang <markzhang@nvidia.com>
Cc: dsahern@gmail.com, jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [RFC RESEND iproute2-next 2/2] rdma: Supports to add/delete a
 device with type SMI
Message-ID: <20240707080138.GB6695@unreal>
References: <20240704062901.1906597-1-markzhang@nvidia.com>
 <20240704062901.1906597-3-markzhang@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704062901.1906597-3-markzhang@nvidia.com>

On Thu, Jul 04, 2024 at 09:29:01AM +0300, Mark Zhang wrote:
> This patch adds a new device attribute "type", as well as supports to
> add and delete a rdma device with a specific type. This new device
> provides a subset of functionalists defined in IBTA spec.
> 
> Currently only type "SMI" is supported: A SMI device provides SMI (QP0)
> interface; This device and it's parent associates with the same HCA port
> and shares the physical link, so when the parent doesn't support SMI,
> It allows the subnet manager to configure the link.
> 
> This patch also supports to print device type and parent if any.
> 
> Examples:
> $ rdma dev add smi1 type SMI parent ibp8s0f1
> $ rdma dev show smi1
> 2: smi1: node_type ca fw 20.38.1002 node_guid 9803:9b03:009f:d5ef sys_image_guid 9803:9b03:009f:d5ee type smi parent ibp8s0f1
> $ rdma dev del smi1
> 
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> ---
>  man/man8/rdma-dev.8 |  40 +++++++++++++++
>  rdma/dev.c          | 120 ++++++++++++++++++++++++++++++++++++++++++++
>  rdma/rdma.h         |   2 +
>  rdma/utils.c        |   2 +
>  4 files changed, 164 insertions(+)
> 

Thanks,
Acked-by: Leon Romanovsky <leon@kernel.org>

