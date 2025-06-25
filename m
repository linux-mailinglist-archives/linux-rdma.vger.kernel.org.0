Return-Path: <linux-rdma+bounces-11624-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7939CAE7FC6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 12:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BCD3BFBA5
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 10:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717DA29E0EE;
	Wed, 25 Jun 2025 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUFCCVoB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD5B8F5B;
	Wed, 25 Jun 2025 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848087; cv=none; b=qLcBdvOLD2Fq3nzGxhJXFCcuEjUH7Th3a6/MkhaF1CuIrtVQRoPb1lWG7lYZ2EhtJuJ9x8ZUv6PqovVZD0Pvdftm3tuMBCbgwc1KKOD+1upLLfuAQTNEM6AvJMNlkHld6LFnJ0j+0AzSm0qdgdV26aILOXPmp6IM9Rze2ux/RkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848087; c=relaxed/simple;
	bh=gTVevN5N5fmOhyPXlACLfhqUIaGJGrmCUJ+fYm8dgQg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bbTei54c47vfZy2Rc4m500SOzKmmJv4HXhUbFc4Qj9X8CH/HesS5lrDm9igDXWGVkj4XQLgnSSn+OPmJ9kYTL9C5q7aF1cQ+bSq7Qyb9C6owElTjOUln7+qdYmVTs4icQerUJPN8W5+7/tCeanOoa/HX0Co6s8PRqggoE9JpA6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUFCCVoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0814FC4CEEA;
	Wed, 25 Jun 2025 10:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750848086;
	bh=gTVevN5N5fmOhyPXlACLfhqUIaGJGrmCUJ+fYm8dgQg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XUFCCVoBfR7O7dIsA0snzmR7ajXkbBz953KglAMmxSnti7n7PYMA1LYCXfAYUYuUg
	 uMD3doNvnDFeAr+CUuirs9XWoUAsLCWhnnFOPZrX3gbf6/fZxt+xqGiW+odmjojKJb
	 wksXfuPWnOHEFYXQJX0VUbt3dzyUzAChfKsRCR/Wpk1wyLwQDR2vaL6yZsVIRI3OnL
	 Mt4jj/613E4ANzEvO0JY0vLzyQ88CXlX0/bf1okMQNoeO/IVPb+iU228N90i5fg+NX
	 Diy0HgW347TDM6Zl6JmJFu0cI15uC5XVBNyFxGSCpaAdmFVhDILdzJ/KZ1V8x/MRry
	 TEzsbqbmFtr8A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Chiara Meiohas <cmeiohas@nvidia.com>, 
 Mark Zhang <markzhang@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>, 
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250620113335.3776965-1-arnd@kernel.org>
References: <20250620113335.3776965-1-arnd@kernel.org>
Subject: Re: [PATCH] RDMA/core: reduce stack using in nldev_stat_get_doit()
Message-Id: <175084808302.620355.8744295923140537631.b4-ty@kernel.org>
Date: Wed, 25 Jun 2025 06:41:23 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 20 Jun 2025 13:33:26 +0200, Arnd Bergmann wrote:
> In the s390 defconfig, gcc-10 and earlier end up inlining three functions
> into nldev_stat_get_doit(), and each of them uses some 600 bytes of stack.
> 
> The result is a function with an overly large stack frame and a warning:
> 
> drivers/infiniband/core/nldev.c:2466:1: error: the frame size of 1720 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: reduce stack using in nldev_stat_get_doit()
      https://git.kernel.org/rdma/rdma/c/43163f4c30f94d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


