Return-Path: <linux-rdma+bounces-3585-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0B391DF72
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 14:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403431C208A7
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 12:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B521414D2B2;
	Mon,  1 Jul 2024 12:36:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8389113D24D;
	Mon,  1 Jul 2024 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837408; cv=none; b=JhhGITkt9U9AHsNvHaXP1NpJ+z0S/1KlPupO8/Tkaa1TZcpjaiPR0jt274QVhN8hxh+2MUcS5DQoMXynHhAwr2fHIA8PHzEd0fWYSk9hx1DtS9mDBmjQ9+Ikjpt2//PBJXJq2dvUqlCRGX/fuNMywYmu0+sCzEPHl5viZrjnXl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837408; c=relaxed/simple;
	bh=9fUYgRSSLM0EqhLoBFV5RoCv2A59Gccjs9G7Kxs8Ppw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Eq+hpWbEdLF860AgOGm9o96qUNixLU8VVhIAutJM0/0+G85wWa3RxT6Ehf5VgFAEYeGWgpObg0d7MmqMZh0QyKpoDCG+i3jdm6Ii30VFTDxUMX22dXBPNSOyPVmDusrvvnuEVd9IwvFU2VRBH53HclFNXRh/sgJaf83sZqHgceA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACED7C2BD10;
	Mon,  1 Jul 2024 12:36:47 +0000 (UTC)
From: Leon Romanovsky <leonro@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org, 
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <cover.1718553901.git.leon@kernel.org>
References: <cover.1718553901.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next 00/12] Multi-plane support for mlx5
Message-Id: <171983740416.330197.16009173038296516665.b4-ty@nvidia.com>
Date: Mon, 01 Jul 2024 15:36:44 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-13183


On Sun, 16 Jun 2024 19:08:32 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> From Mark,
> 
> This patchset adds support to IB sub device and mlx5 implementation.
> 
> An IB sub device provides a subset of functionalists of it's parent.
> Currently type "SMI" is supported: A SMI device provides SMI (QP0)
> interface and shares same VPort with it's parent; It allows the subnet
> manager to configure VPort through this interface when the parent
> doesn't support SMI.
> 
> [...]

Applied, thanks!

[01/12] RDMA/core: Create "issm*" device nodes only when SMI is supported
        https://git.kernel.org/rdma/rdma/c/50660c5197f52b
[02/12] net/mlx5: mlx5_ifc update for multi-plane support
        https://git.kernel.org/rdma/rdma/c/65528cfb21fdb6
[03/12] RDMA/mlx5: Add support to multi-plane device and port
        https://git.kernel.org/rdma/rdma/c/2a5db20fa53219
[04/12] RDMA/core: Support IB sub device with type "SMI"
        https://git.kernel.org/rdma/rdma/c/f3b5c2b823fbd8
[05/12] RDMA: Set type of rdma_ah to IB for a SMI sub device
        https://git.kernel.org/rdma/rdma/c/66862e38a557b3
[06/12] RDMA/core: Create GSI QP only when CM is supported
        https://git.kernel.org/rdma/rdma/c/6d4498d1745128
[07/12] RDMA/mlx5: Support plane device and driver APIs to add and delete it
        https://git.kernel.org/rdma/rdma/c/39351acd72e775
[08/12] RDMA/nldev: Add support to add/delete a sub IB device through netlink
        https://git.kernel.org/rdma/rdma/c/201dfa2d8129a6
[09/12] RDMA/nldev: Add support to dump device type and parent device if exists
        https://git.kernel.org/rdma/rdma/c/1bc00c7c0ae33e
[10/12] RDMA/mlx5: Add plane index support when querying PTYS registers
        https://git.kernel.org/rdma/rdma/c/d6caf3986716c3
[11/12] net/mlx5: mlx5_ifc update for accessing ppcnt register of plane ports
        https://git.kernel.org/rdma/rdma/c/db9e43f6580613
[12/12] RDMA/mlx5: Support per-plane port IB counters by querying PPCNT register
        https://git.kernel.org/rdma/rdma/c/ac3a5e5f01eb40

Best regards,
-- 
Leon Romanovsky <leonro@nvidia.com>


