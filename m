Return-Path: <linux-rdma+bounces-11620-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E15AE790B
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 09:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A739C17A6D0
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 07:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87266204C1A;
	Wed, 25 Jun 2025 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmYkYGLR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406681DE4E1
	for <linux-rdma@vger.kernel.org>; Wed, 25 Jun 2025 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750837825; cv=none; b=HowzaqepugkSw5NHTtxv3C5dgW7X/5HOg4Y8nzcYfyipQfQCBx3G7/BjEfOUPdNO8HfxwbIxbwfFJHkcXzS9ZXl3X6WR+YBszkXWYiJrXPmkTDA+fQiYZmUpB8RWMA4gmetx+d0jTslASW5O7rsWhT93iEbRXu5UB1d0fAMy1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750837825; c=relaxed/simple;
	bh=9NZyrMxaEElpMlb85SbErekkzyfbalXm8j3gpY+BF/A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UVkctyjYjwIPKRIncfKTB3LFAOkvG/em0w9oV4ENxcPrB54dXVeXKEwJCTAj80IRDTK502gzydd3K5JmSVzZTNDgxXZzvBm969bipyacmQniw4mo+AmCPETqQkMvgDlg8Fz/UymmP1Bd0cdKePxpOybnKeMLVryIK0BdI/jNei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmYkYGLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BF8C4CEEA;
	Wed, 25 Jun 2025 07:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750837824;
	bh=9NZyrMxaEElpMlb85SbErekkzyfbalXm8j3gpY+BF/A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AmYkYGLRuDwWQQ58UDPriYPczBAQtjwKHdjfNcyjxy3JoU+n81YTdd1BWb21B5+2t
	 wBHKGIF5DAkSeL405U/zsL2ua6aEFQClwjCKELQF8nzyozcVlVwhU/k+3jL3PcoLFt
	 lqEo77Sfk+mqGnqJtJjn/F34ABw/FjUnivQ6DDzZMh9suC4YkNu45NBWvv3+ccQ4X0
	 G4O7KPR8zWmU6TcIt5Ptv6m2mW904rg7lqP30hsUWtDtZmChyM06n3J9rZ2182Valg
	 +XJl99eFuqab89HAn4BQPk5LZTfOukNQNgjon2HjBJl5ejLESvomXdc2jc62rn8ukx
	 vUH2gqf03TDmw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
In-Reply-To: <b5f7ae3d75f44a3e15ff3f4eb2bbdea13e06b97f.1750062328.git.leon@kernel.org>
References: <b5f7ae3d75f44a3e15ff3f4eb2bbdea13e06b97f.1750062328.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/core: Add driver APIs pre_destroy_cq()
 and post_destroy_cq()
Message-Id: <175083782150.552920.13979353677932073548.b4-ty@kernel.org>
Date: Wed, 25 Jun 2025 03:50:21 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 16 Jun 2025 11:26:20 +0300, Leon Romanovsky wrote:
> Currently in ib_free_cq, it disables IRQ or cancel the CQ work before
> driver destroy_cq. This isn't good as a new IRQ or a CQ work can be
> submitted immediately after disabling IRQ or canceling CQ work, which
> may run concurrently with destroy_cq and cause crashes.
> The right flow should be:
>  1. Driver disables CQ to make sure no new CQ event will be submitted;
>  2. Disables IRQ or Cancels CQ work in core layer, to make sure no CQ
>     polling work is running;
>  3. Free all resources to destroy the CQ.
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: Add driver APIs pre_destroy_cq() and post_destroy_cq()
      https://git.kernel.org/rdma/rdma/c/5a2a5b65d5d672
[1/1] RDMA/mlx5: Support driver APIs pre_destroy_cq and post_destroy_cq
      https://git.kernel.org/rdma/rdma/c/b5eeb8365d196c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


