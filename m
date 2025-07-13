Return-Path: <linux-rdma+bounces-12086-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC004B02F4A
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 10:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D600B7A601A
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FA41B87E9;
	Sun, 13 Jul 2025 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF0TvJnD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A960142E7C
	for <linux-rdma@vger.kernel.org>; Sun, 13 Jul 2025 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752393716; cv=none; b=H6Q9mOHJEMxY1D0xa3eO26VRevJu+Q7t8hiwIYikoNoq7zgJjIZfZohn2mfdwYRF/QMtpZ7iZ2mYcM/vgEMMWpVR7oixYf+v6a01Tsm6H9UKXqQajlJdCpcnQi/UAkDHajdV+TPqrdnNKklslzb2ecN9bHfjjW27rLlGEmTrGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752393716; c=relaxed/simple;
	bh=iOQtW4G/iK4tNEaqxZDBt6SCe2J/1ldXtshXSyVdmuQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ntiE3rYQAGrtwsyzrpNNfoAFeUPOq31hX8GbgYcZefjC+45IwgeL0/OEAzdD4ugXs+JdmauuLti515LYPUEaXZaR5vKVFqnTTHnB+nGuBqCXD5YIGjhC9u2CAr61KDPG48xRkG6tEgh1jqSQgURpVxDHiquKNvK7DAuAwHzg6oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF0TvJnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84574C4CEE3;
	Sun, 13 Jul 2025 08:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752393716;
	bh=iOQtW4G/iK4tNEaqxZDBt6SCe2J/1ldXtshXSyVdmuQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SF0TvJnD/eWnBPXcLtw5Ehsz5du1xqBEVhM4FeO5OflCmjRAUHz9bQHfj900FP/uK
	 LQnn+5DuAhwAlOzZj79u5oOTZvkPE9tUsgC6qXljs7oysVypk9Mpyxak67rVQKcNuT
	 VkwBZP5PiuYqGvDtOayPT9uR985EuL90hJLSAfb1HackbY0BKjjFB1l9SsUwEJarnC
	 fKAP/QL2AmwBii8pvMJK/c0pVAA7VGL+Z9L7vcC/AHVUz7WXHv6uMovOm6Orlj72CL
	 JHahGbnhczkPuoUzb082zSE+z/mU4XMG6z+OYja8jB+9T9SuvdFKpdzsq8LGyzbnOv
	 MKeU/sgbitOXQ==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 Michael Margolin <mrgolin@amazon.com>
Cc: sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev
In-Reply-To: <20250708202308.24783-1-mrgolin@amazon.com>
References: <20250708202308.24783-1-mrgolin@amazon.com>
Subject: Re: [PATCH for-next v2 0/3] RDMA: Support CQs with user memory
Message-Id: <175239371228.108828.4820456301900200072.b4-ty@kernel.org>
Date: Sun, 13 Jul 2025 04:01:52 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 08 Jul 2025 20:23:05 +0000, Michael Margolin wrote:
> This series is adding a common way for creating CQs on top of
> preallocated memory supplied by userspace. The memory buffer can be
> provided as a virtual address or by dmabuf, in both cases a umem object
> is created for driver's use.
> EFA is the first to support this new interface, new drivers or existing
> drivers that want/need to get the memory from userspace are expected to
> use this flow.
> 
> [...]

Applied, thanks!

[1/3] RDMA/uverbs: Add a common way to create CQ with umem
      https://git.kernel.org/rdma/rdma/c/1a40c362ae265c
[2/3] RDMA/core: Add umem "is_contiguous" and "start_dma_addr" helpers
      https://git.kernel.org/rdma/rdma/c/c897c2c8b8e829
[3/3] RDMA/efa: Add CQ with external memory support
      https://git.kernel.org/rdma/rdma/c/9fb3dd85197f5e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


