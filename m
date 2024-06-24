Return-Path: <linux-rdma+bounces-3427-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E09E79146AF
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 11:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9542B1F247A7
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 09:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4441413213B;
	Mon, 24 Jun 2024 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfIRoy0E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D695380F;
	Mon, 24 Jun 2024 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719222728; cv=none; b=vC+EiOy3BBAnVfSKkfkMI+PDeywmD4i7XnldKVLnrI7EbDl/4giTh8veZ1Bw+647zpxEpRib0tf4ll/1NmFKg/n9RpEC2CHIA6F0Axk4AjxK5Dm433OToKgELwViv4IgQbz9srU+asdNE1ezbhccihMbaYFa0nduXWB62jVb2yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719222728; c=relaxed/simple;
	bh=TuDHpmuywUI/xsnMpSjefXvt7PuPgqpYaDmNnDJ3ACQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dsj43UtP4PRbdfMYADzB9rCABAfIptQXtv5NvS08WmjFXrQym4mF7koSvp/jdp6TdWMMideRAXCdvPkFspvB7vACRDLbt9D/XeWvwjWn4pPQm4OoICvsjTR1mBxvMAYCMmXpPdMK1t9cBBWL3si7WwQdsxOLIgtT7uA51ik5lgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfIRoy0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF56AC2BBFC;
	Mon, 24 Jun 2024 09:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719222727;
	bh=TuDHpmuywUI/xsnMpSjefXvt7PuPgqpYaDmNnDJ3ACQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MfIRoy0EY2erHYnbqCLDGbYujAIUMPnlH132dBtChSLU+/NzWFmk0JebDl7y3/XtY
	 LI/C+3/8l2bpCsl7V6PDlq5La+S+sw76HamT1fGidhNSJTcSNbIiUQio7L6YsX/yMJ
	 tlc2qy3mneiynsuo4xYGPvRYzbhA8R5B0Pm40cnmT+pDGpa1IquZEQiPtS/OZURZTl
	 OK0+i45imm8WeDK/8OhXLJi3D9m1F8JbxE39Q+AHQFx5W50mCbkFHdcM/SDIG/uJ1O
	 5bM0hbmsINNIuHptbQMiL9GNwHUH6P7iaWU/zqUeNmQbyidz4CDyPOrV9j7cHWA0x7
	 Br9XfTnXshJng==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Or Har-Toov <ohartoov@nvidia.com>, linux-rdma@vger.kernel.org, 
 Maher Sanalla <msanalla@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, 
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
 Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <32801966eb767c7fd62b8dea3b63991d5fbfe213.1718554199.git.leon@kernel.org>
References: <32801966eb767c7fd62b8dea3b63991d5fbfe213.1718554199.git.leon@kernel.org>
Subject: Re: [PATCH mlx5-next] RDMA/mlx5: Use sq timestamp as QP timestamp
 when RoCE is disabled
Message-Id: <171922272372.232297.7207495975863615871.b4-ty@kernel.org>
Date: Mon, 24 Jun 2024 12:52:03 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-13183


On Sun, 16 Jun 2024 19:10:36 +0300, Leon Romanovsky wrote:
> When creating a QP, one of the attributes is TS format (timestamp).
> In some devices, we have a limitation that all QPs should have the same
> ts_format. The ts_format is chosen based on the device's capability.
> The qp_ts_format cap resides under the RoCE caps table, and the
> cap will be 0 when RoCE is disabled. So when RoCE is disabled, the
> value that should be queried is sq_ts_format under HCA caps.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Use sq timestamp as QP timestamp when RoCE is disabled
      https://git.kernel.org/rdma/rdma/c/78a6cbd5145ce7

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


