Return-Path: <linux-rdma+bounces-5732-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 884419BAE5A
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2024 09:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13481C218A1
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2024 08:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6364B1AAE01;
	Mon,  4 Nov 2024 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYMkSKxN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163F819F42F;
	Mon,  4 Nov 2024 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709786; cv=none; b=MvgvUugvltt5fsSPeCNp6nHivT4KxXRWw/+QkAJAASroewLsS6O+oyY4LLf9GLQ/FVEiEFZuu5J1utOW2oMNBZTDq7OUe3On7kkBacDuJzksIVQCN0rbtIml7nByxTe91VuncjCUG+9601tFXZMSz4KMjxmFHvPJPuts6wHzr44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709786; c=relaxed/simple;
	bh=h/ImhdPwBZUTlfrTk8YxD0imoe+rMtZCMzB31TKraWA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=at3OcbsrQEOHG2kNVNftNUMr2yFvfsG9vvKanDUw0wl5zCTLrNZ3gjoqUDz69Rbe4EdwR38VgpUkK286lCt1PJdQfb/zpj89AYO0eZxWPHZVIX3LX/qitWHeT5Bf6xjNbkz7IPnBNplG8mcLG8WGjF0Mq1lCExhxHRLULwMhjh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYMkSKxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6ABC4CECE;
	Mon,  4 Nov 2024 08:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730709785;
	bh=h/ImhdPwBZUTlfrTk8YxD0imoe+rMtZCMzB31TKraWA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cYMkSKxNRrwJlJx4U/W0m2iOvx6ewjM6X/pbbMJSwlURK0pWqlFowFsz2SF6PjP2H
	 Qzj7gZpvfTCGyEg55nquRZmrgi/qCBpZksNyJfnnKHY4MoPTzWiuigX9jITvf97QVu
	 oEKo42m2BGGwYddCpVgOs8K9WMo+T6HtA0QUDvlmAwrFd5YRwSWYlR1OspsxbRYn1s
	 ujIiubnpyCGRjv2EUUgFURT6JeZJq/h2owkF3iLJq0GaKNFpf7feyqQY+MuXf3ztxo
	 e1m/tlwQiA4OihzPcPJ0JsZfurLgpf8OGq2KTsxJDuhL33NUT/PMLOshpP0R8VcQP5
	 4SLY+OA/QBKiQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 linux-rdma@vger.kernel.org, Michael Guralnik <michaelgur@nvidia.com>, 
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <cover.1730381292.git.leon@kernel.org>
References: <cover.1730381292.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next 0/3] Fixes to set_netdev/get_netdev flow
Message-Id: <173070978219.155717.5536968664084032189.b4-ty@kernel.org>
Date: Mon, 04 Nov 2024 03:43:02 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 31 Oct 2024 15:36:49 +0200, Leon Romanovsky wrote:
> This series fixes the set_netdev/get_netdev flow in mlx5 drive around LAG.
> 
> Thanks
> 
> Chiara Meiohas (3):
>   RDMA/mlx5: Call dev_put() after the blocking notifier
>   RDMA/core: Implement RoCE GID port rescan and export delete function
>   RDMA/mlx5: Ensure active slave attachment to the bond IB device
> 
> [...]

Applied, thanks!

[1/3] RDMA/mlx5: Call dev_put() after the blocking notifier
      https://git.kernel.org/rdma/rdma/c/c4967b6dc20ab1
[2/3] RDMA/core: Implement RoCE GID port rescan and export delete function
      https://git.kernel.org/rdma/rdma/c/ffe3c55b16ddee
[3/3] RDMA/mlx5: Ensure active slave attachment to the bond IB device
      https://git.kernel.org/rdma/rdma/c/bf15c4dc0fbb16

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


