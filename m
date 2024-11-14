Return-Path: <linux-rdma+bounces-5988-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D199C8D76
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 15:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7439FB28245
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 14:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF7F55887;
	Thu, 14 Nov 2024 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAQO04f+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D75D179BD
	for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596064; cv=none; b=edb1R4StPWZXYpNGOv7QCiEY+AYO+45GYI2SqpG/+4TIbmXVib7plpckhKPLubBMFFQ0AtyLpdwU9WKQ5Yml7W/9TT3oxU/dnIysuSyfikF+i1uBybcqI7ZOlDHd3Z+ddmOtrBBsjCeq67bdcANPDckavUOnA0k8ZgxyciuKISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596064; c=relaxed/simple;
	bh=88oDQEFE1X13zpb0nTrc5dT3s2xrkngKUE6x00pQwJA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N6zBSdE+sXIxs3Uw0icJhlwAqmnafZmh44GmKUElPmpsCif3aSiN8IPbA7sw62T4TyGaJb12WHgO2WKuxwR4v+e/IJ/9XJBcffRQH7scFhznGeEVPvm/hMJZhXZnKiJyolu8NFN4sLESJ+cH9o58VDgUiM1Xbu6ZXDGHIG0SlyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAQO04f+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7E9C4CECD;
	Thu, 14 Nov 2024 14:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731596063;
	bh=88oDQEFE1X13zpb0nTrc5dT3s2xrkngKUE6x00pQwJA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lAQO04f+JteN2ATUvUK1iJqdfqx3AFJcAp3Cl1RY7qdqq399kcCZdIjpPy4LkWKzG
	 ueAsHYiYfXlpnEHBgL8WA2UVfeLG0VqwS8GO9uCtxMeWXThq5HxrmdFVyNNK3s0S0j
	 5eUgaRvWhuEP+q1CL/zvPSXg6f0koUsjzg+x77IIxleXzm4boh7ZxliN/XJhEOaL4V
	 ERTixFcp2sXAZUedf43ULYhdPyEcgm38b8cghNIt0Ka93Kq9gpUFfrCi1l3vRsIGJ7
	 WuuzIdclkbUxH797Zh/UZhZu6nmi7Gl+svuYmEb/eRSFQGqG1zcyoutvjDzBXGAtjz
	 kpmyuAP68zqPw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org, 
 Michael Guralnik <michaelgur@nvidia.com>
In-Reply-To: <d271ceeff0c08431b3cbbbb3e2d416f09b6d1621.1731496944.git.leon@kernel.org>
References: <d271ceeff0c08431b3cbbbb3e2d416f09b6d1621.1731496944.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Move events notifier registration
 to be after device registration
Message-Id: <173159606014.154263.2997995911872279251.b4-ty@kernel.org>
Date: Thu, 14 Nov 2024 09:54:20 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 13 Nov 2024 13:23:19 +0200, Leon Romanovsky wrote:
> Move pkey change work initialization and cleanup from device resources
> stage to notifier stage, since this is the stage which handles this work
> events.
> 
> Fix a race between the device deregistration and pkey change work by moving
> MLX5_IB_STAGE_DEVICE_NOTIFIER to be after MLX5_IB_STAGE_IB_REG in order to
> ensure that the notifier is deregistered before the device during cleanup.
> Which ensures there are no works that are being executed after the
> device has already unregistered which can cause the panic below.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Move events notifier registration to be after device registration
      https://git.kernel.org/rdma/rdma/c/ede132a5cf559f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


