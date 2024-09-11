Return-Path: <linux-rdma+bounces-4882-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6721B975430
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 15:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DD11C228B1
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 13:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C96619FA86;
	Wed, 11 Sep 2024 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMeMut/1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A07187FFF
	for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061446; cv=none; b=Ys+jZgoCtYpQ4/hyWeI+ps3Z+n2paTWkZZD8zp7tDBW53XQTkzTXQN0pNWaTzJAYBh8p1CQA/zVjHWUNVsdCeNAhizI5FH3kOfRh24DgGAOShtbNpYtVW6EIg5Nrht8bY3MyrpkRqhDTenWYOd+g41DWzURb5K16kZpjSvtoArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061446; c=relaxed/simple;
	bh=4MuOWfuwfbYm/561Vbwr4JzDrBJOaXJf/nHsR2SpXhk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GmAZVN+ZaGuF5YGR9HykN77igZ9jUoku7xX2mVZ4kdJ/gCZYngkMbgIgBVZFXuq8nn7Gabl0YupMhJRCb+v+4/bYQ+o+Tf6+g8YJptTrhlTiVs163JYQRfnuYvjHiHe5eMjvyKParNeXU5H4fvwJ8GyycVZqtaAjtoSxmE8+06k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMeMut/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1166C4CECE;
	Wed, 11 Sep 2024 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726061444;
	bh=4MuOWfuwfbYm/561Vbwr4JzDrBJOaXJf/nHsR2SpXhk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IMeMut/1up7LjdHqbh+CA1WUNOleidjc6otu4vj8Jbp+d5RPWl6voQ+AArc2Jcgcb
	 0aaukJ3c+75YLxI2e3CaF/HjNjaTgFCC7x5wKWrx1Hp+YVYZZ6czO3PpniglSubNl0
	 Hn9SxKLttVYp/Jc8kvlJjfCNPyGwjl5bIAAJHr71zGzQmkvbbsua0bozxp7Pg2n/BI
	 27YZdFTvXrB2wzmyBa5NcPgMK32hPJTzd2Sx0L4aQ/klN+4IoqwMrzp2DSHGPOO/je
	 2fC64mNY0f2wV6tRafdIB2pd5rz/RVZ7C5gd+Fa+bEYXMDrZCOxZ2wYrpWVmZaHEa5
	 7y1nNHIwS3T0w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Michael Guralnik <michaelgur@nvidia.com>
Cc: linux-rdma@vger.kernel.org, mbloch@nvidia.com, cmeiohas@nvidia.com, 
 msanalla@nvidia.com, dsahern@gmail.com, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <20240909173025.30422-1-michaelgur@nvidia.com>
References: <20240909173025.30422-1-michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next v3 0/7] Support RDMA events monitoring
 through
Message-Id: <172606143899.3705222.15001719681168019853.b4-ty@kernel.org>
Date: Wed, 11 Sep 2024 16:30:38 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 09 Sep 2024 20:30:18 +0300, Michael Guralnik wrote:
> This series consists of multiple parts that collectively offer a method
> to monitor RDMA events from userspace.
> Using netlink, users will be able to monitor their IB device events and
> changes such as device register, device unregister and netdev
> attachment.
> 
> The first 2 patches contain fixes in mlx5 lag code that are required for
> accurate event reporting in case of a lag bond.
> 
> [...]

Applied, thanks!

[1/7] RDMA/mlx5: Check RoCE LAG status before getting netdev
      https://git.kernel.org/rdma/rdma/c/e67266dc429670
[2/7] RDMA/mlx5: Obtain upper net device only when needed
      https://git.kernel.org/rdma/rdma/c/eb66fcc43fde8f
[3/7] RDMA/mlx5: Initialize phys_port_cnt earlier in RDMA device creation
      https://git.kernel.org/rdma/rdma/c/41068c95b0bf6e
[4/7] RDMA/device: Remove optimization in ib_device_get_netdev()
      https://git.kernel.org/rdma/rdma/c/95ae29d023a4ba
[5/7] RDMA/mlx5: Use IB set_netdev and get_netdev functions
      https://git.kernel.org/rdma/rdma/c/425b36d3b2cb81
[6/7] RDMA/nldev: Add support for RDMA monitoring
      https://git.kernel.org/rdma/rdma/c/9a13c8cffcf6e8
[7/7] RDMA/nldev: Expose whether RDMA monitoring is supported
      https://git.kernel.org/rdma/rdma/c/61eb1e03c16f38

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


