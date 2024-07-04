Return-Path: <linux-rdma+bounces-3637-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A098926E9F
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 07:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E701C2173E
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 05:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B877D176ABE;
	Thu,  4 Jul 2024 05:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Al62yBhS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769FE176AA2
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jul 2024 05:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720069233; cv=none; b=FYsGYdR63rRMWHMGsRHntQ/FLLwcGCE74vEBM771pdcvEfucSk2Epmlvr2vEO0fo1dPFAQq8S1MhEuZR3klQBba9dS4cWcEsI8syd/psnYO9CVlWx8N5w0OTNBi1H2/TvAAe1JfpMLWvbi7h3mXWcO8Zc1ZNo6Cgd3YhHsZFhDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720069233; c=relaxed/simple;
	bh=YPh0H/RZccm8/HsNd4f93vdc6LuKFxrHv17uWtzkOKE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BiUA15FRTwvla7l5k6SLBhRFuSvYW1gJziIY9QonlAZAtEPf4zE/2ccUNakL37wRP4uQOMIv5HcMr+QT3muI7Ab+c+kMcBfP2cXlRUAgV98Xpnu0OMUD4Bpmpv0Lk2J6qJbqvTBdhpJOmKH0EwIez+idBWeUc/MG5mTeXcjRUFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Al62yBhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAEAC3277B;
	Thu,  4 Jul 2024 05:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720069231;
	bh=YPh0H/RZccm8/HsNd4f93vdc6LuKFxrHv17uWtzkOKE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Al62yBhS4G287zh8RxwpOl2eTHuDpBWNkS121gL6p4XQt52O/bA8D6WYP5eb6RDMW
	 iDnGT9zaNRxhbny5aenSxufgkqpesbgAjA15nwDxSzf/EjOx28ftkPuuzuYBSfamKY
	 1zndS0pjIlr3bWlnoKPOXJpM/Z3fu0dAJAABI1b7FGanRyo4JSMgsoTPH5UGSBqC9X
	 2E9oRjtd9zLjpdJjUFI2qG8mK2CYRBmtv1m5bNqgSCCJ1BUz4GjB6nsckRhOkMvS20
	 bYcyvoxa6cy3KAAf6eSZHqWIqg8U2rSEVjlh4kpBwnHupkMR5Q5K63FPfttAxQDEhd
	 BST9wZz1AEFeA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Mark Zhang <markzhang@nvidia.com>, Bernard Metzler <bmt@zurich.ibm.com>, 
 linux-rdma@vger.kernel.org, Zhu Yanjun <zyjzyj2000@gmail.com>
In-Reply-To: <522591bef9a369cc8e5dcb77787e017bffee37fe.1719837610.git.leon@kernel.org>
References: <522591bef9a369cc8e5dcb77787e017bffee37fe.1719837610.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/core: Introduce "name_assign_type" for
 an IB device
Message-Id: <172006922726.579339.15687723900603932142.b4-ty@kernel.org>
Date: Thu, 04 Jul 2024 08:00:27 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-13183


On Mon, 01 Jul 2024 15:40:48 +0300, Leon Romanovsky wrote:
> The name_assign_type indicates how the name is provided. Currently
> these types are supported:
> - RDMA_NAME_ASSIGN_TYPE_UNKNOWN: Unknown or not set;
> - RDMA_NAME_ASSIGN_TYPE_USER: Name is provided by the user; The
>   user-created sub device, rxe and siw device has this type.
> 
> When filling nl device info, it is set in the new attribute
> RDMA_NLDEV_ATTR_NAME_ASSIGN_TYPE. User-space tools like udev
> "rdma_rename" could check this attribute to determine if this
> device needs to be renamed or not.
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: Introduce "name_assign_type" for an IB device
      https://git.kernel.org/rdma/rdma/c/af48f95492dc1a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


