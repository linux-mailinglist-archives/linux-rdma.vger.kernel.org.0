Return-Path: <linux-rdma+bounces-12414-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8278B0EC1B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 09:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E946816A962
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 07:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E8D26CE2B;
	Wed, 23 Jul 2025 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma2E3c0I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEB0277017
	for <linux-rdma@vger.kernel.org>; Wed, 23 Jul 2025 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256360; cv=none; b=bReSE9kHXC+CuTx4kt7F7ebDMjL9fG9qwPCtV4p/lcD1CNUyHSxGtj1eDoWX+SPAtzqnP5dO6uoYOxfQcboDO5VuPAbRoZxTLR12ObPv8DTr5eGtvFFdwIc7ZQNXiWoYBdHl+k+dqQmeAEgnmAaXAH3DtkLjBkiJcnYgjBbq/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256360; c=relaxed/simple;
	bh=HvvwPVzLz68cHjxTeU+IzMFUGNvOLH51pTkStjET88Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D35GwCRRh6G3mk2bD8zQ1BSTD8QEKHisIE9Q7Ns0cpwAzs24fPPBXoq2yJGu47nvAbcffM1TocumxPzMKN9TW51Vi9aff6I1mLJl8Pl90JcyTGPfmYSaWq/A+OSVpWDuEd/dY2aXfZMNdjdISMQD0HUvb78ShkXx76jEht/eg2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma2E3c0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D6EC4CEE7;
	Wed, 23 Jul 2025 07:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753256359;
	bh=HvvwPVzLz68cHjxTeU+IzMFUGNvOLH51pTkStjET88Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ma2E3c0I/zM8Z3p/sIoDYIbuIopL+4wwYSR2EaupwiIjd+6yngCaZhZMwQNHFWYQS
	 wh5+b3y5nmYNecj53NqDLhoTxzGy9++GE0zq9vjgBzpLSfYU7Vf56Tnf8xVcFZXWzz
	 bw059rEnj0XFmWbZuw7tzFnyHgFXJ64bKx3o3VD5H/+fT/938kQbap2QdTAddPyIf/
	 WL5YMEsV4uuBqloKChARDj9tUBZbIsUJcGnx0tCm6kw/xMhVf8iCs/rECyJjof1L26
	 GJ6tXTBGLLx+x358AtP+mmIEEv/NKNt0kXxwH+ilXoNoxPcWTMoTMkHMWALmAYhloW
	 RZhNxPUa9bMaw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>, 
 Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org
In-Reply-To: <9854d1fdb140e4a6552b7a2fd1a028cfe488a935.1753004208.git.leon@kernel.org>
References: <9854d1fdb140e4a6552b7a2fd1a028cfe488a935.1753004208.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Refactor optional counters
 steering code
Message-Id: <175325635631.1073661.7250310261900696239.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 03:39:16 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sun, 20 Jul 2025 12:37:24 +0300, Leon Romanovsky wrote:
> Currently there isn't a clear layer separation between the counters and
> the steering code, whereas the steering code is doing redundant access
> to the counter struct.
> 
> Separate the fs.c and counters.c, where fs code won't access or be
> aware of counter structs but only the objects it needs.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Refactor optional counters steering code
      https://git.kernel.org/rdma/rdma/c/10d4de41895338

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


