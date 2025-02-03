Return-Path: <linux-rdma+bounces-7353-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4A3A25848
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 12:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF1A166888
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 11:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A733F202F95;
	Mon,  3 Feb 2025 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O16EbW+i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60866202F9E
	for <linux-rdma@vger.kernel.org>; Mon,  3 Feb 2025 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738582638; cv=none; b=ELTyaFYoO/vcK1kDXP2Vdm0DbZaJkgKrwp46pLO60SQPO139xW15JqVX4kx1UV1NEEmD3L2rhKadbN1Mo3Zms3vzSMQhKLgpXFx751DshUkNDLeXnybFde159PGVS9YH907hmXGVVZm3F1AA2sBYa3vFNZCT7iRTcG5q7aO1Vmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738582638; c=relaxed/simple;
	bh=UTrLoUtt9sfUdnT8YoEWdZUXePm21ELPDej8lNac51c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uVk2NcCEBCB7Upl42uqbhx0Frm6eiW0Yn82znHvU/lzCh/ccUGoNdnkIucxktWdAj38YWf5YNh3zvjq1XOq43UCDVWloy3dwkTEvmaRYFd0VXgtzwez2dxshep0hRR7O+w4ONTpt+ZDw33ax02g8tzHAXyPNTxb8yaMfcdqi2do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O16EbW+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30856C4CED2;
	Mon,  3 Feb 2025 11:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738582635;
	bh=UTrLoUtt9sfUdnT8YoEWdZUXePm21ELPDej8lNac51c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O16EbW+iqkeBfJEcY7b+N626GKPJCjnY02dWmp47uiepTQwk92QMUho/kBrEgLBRX
	 insbxRb85e7sL454VaMyiaakPmdmWgMiSLUhB4cp+ckXjhB5q36Yw9hZ7KfGqbS7LF
	 EU9xtasedFU7iderhJTcUeoqBAEiXkAQnNFuhXyBYnq5RjYrc/M2pYRfYdLruk9pD/
	 79r227rj9xCOOeWvjvw+WsXjRRoSXcnqgsF6cOFvL5ca9Rl3sjamMpKcp4EJm0f5Xh
	 YAcGQshxakPpa3chPzc2Amn1xFx+oQFmoDE7qEl30myIAeoCuvIQRWhxPJz16THzZ7
	 Gje3kJAU0Z0Ag==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org, 
 Maher Sanalla <msanalla@nvidia.com>, Maor Gottlieb <maorg@mellanox.com>, 
 Mark Zhang <markz@mellanox.com>
In-Reply-To: <94c76bf0adbea997f87ffa27674e0a7118ad92a9.1737290358.git.leon@kernel.org>
References: <94c76bf0adbea997f87ffa27674e0a7118ad92a9.1737290358.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] IB/mlx5: Set and get correct qp_num for a
 DCT QP
Message-Id: <173858263251.652207.11847770932154791383.b4-ty@kernel.org>
Date: Mon, 03 Feb 2025 06:37:12 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sun, 19 Jan 2025 14:39:46 +0200, Leon Romanovsky wrote:
> When a DCT QP is created on an active lag, it's dctc.port is assigned
> in a round-robin way, which is from 1 to dev->lag_port. In this case
> when querying this QP, we may get qp_attr.port_num > 2.
> Fix this by setting qp->port when modifying a DCT QP, and read port_num
> from qp->port instead of dctc.port when querying it.
> 
> 
> [...]

Applied, thanks!

[1/1] IB/mlx5: Set and get correct qp_num for a DCT QP
      https://git.kernel.org/rdma/rdma/c/12d044770e12c4

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


