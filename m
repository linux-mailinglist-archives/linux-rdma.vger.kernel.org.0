Return-Path: <linux-rdma+bounces-4879-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76932975210
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 14:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2832D1F231F1
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 12:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02CE17C22F;
	Wed, 11 Sep 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9uOaOU5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F0551C4A
	for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057662; cv=none; b=obNjPikPi16KAimRtp9pD6dRLNfg8nMz6Q+nE1EMYX+60EtoclKL8wQgVrvsEm2NTTyBB34kNvRXpngQUkm43lhwb0cMDFuY/91wya+icV/Qo6oYtEH5DL0ULLMlVouJ0cTkjg5l0fzbL+eBIETXQg1Jv9LM/onlyNDwRSzPH4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057662; c=relaxed/simple;
	bh=4ws4vFyaOiGg7JWre4fXGd6rS4RtDVTplICyZgZoyhI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dwcwCLgO3pf4n+EuUcRUhQIR45qkojKD0yAP7P+ezbr+lT3KoZWChaqnonS90WUCwhxxdatTDY5WzktCJTUoA50xVUv9rw0KrRBA2rwyESitf5z7akJBreaOZk7NeK3x/qxqnxDc9cA9x+SP7T5IlcnELpJEclAhTIjIqjsPGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9uOaOU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BF9C4CEC5;
	Wed, 11 Sep 2024 12:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726057661;
	bh=4ws4vFyaOiGg7JWre4fXGd6rS4RtDVTplICyZgZoyhI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=D9uOaOU5PzQvVsVtueSoBtdSOkCz6sOf3BW/BUfyvmRJqlMfKewI4wOaDGNVN/kdu
	 H2/O2131ctHnNwl4L4Sk8AeIhVCIMcCaoJPK4cOCQBmoMi9QOm1R/6R9FZXUoR/B6M
	 wxKdq46ckH+9WMbXXjc8xVNJ5XpEWbIrhf4CQ0Wtb7HowmB2a/6fogR79Uvu1AoBj7
	 YkwjnMPGLs0APzOE7/P+w7wz1RjIwJoM0Kx6tA4Rq+5/t/6kifA24zddErZQnU0ofH
	 zxZxdRYPJwn+2Gr8d7p2vJWKONO0xOR8Uul3myMuxfzy/EscRKNO53WOtqJOEgQSe1
	 3eeySrU3hZYtw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Yishai Hadas <yishaih@nvidia.com>, Gal Shalom <galshalom@nvidia.com>, 
 linux-rdma@vger.kernel.org
In-Reply-To: <274c4f6f1ac0b1078243dd296695a49dbe58e7d1.1725907637.git.leonro@nvidia.com>
References: <274c4f6f1ac0b1078243dd296695a49dbe58e7d1.1725907637.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Consider the query_vuid cap for
 data_direct
Message-Id: <172605765571.3684857.5109193252506660213.b4-ty@kernel.org>
Date: Wed, 11 Sep 2024 15:27:35 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 09 Sep 2024 21:47:33 +0300, Leon Romanovsky wrote:
> Consider also the query_vuid cap before enabling the data_direct
> functionality.
> 
> This may prevent a syndrome from the FW in case the query_vuid command
> is not supported. (e.g. migratable VF)
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Consider the query_vuid cap for data_direct
      https://git.kernel.org/rdma/rdma/c/07a316d64a1a53

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


