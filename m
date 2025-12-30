Return-Path: <linux-rdma+bounces-15245-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 363A0CE9913
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Dec 2025 12:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4604B30164F4
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Dec 2025 11:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5022D6639;
	Tue, 30 Dec 2025 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6zuIbsG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8105C8CE;
	Tue, 30 Dec 2025 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767095223; cv=none; b=XNIgyo3kB3qlC+hWsavmDr1TndIVZ1qF62UiF36l8cD3OAHsmj3ZCMJg7rDK5FQ62ya8k3jfzDLv8+t3pcINBs+j09fW57CvuFWYl0Ew6avzWSHqmLqcn+FL/hRryIATBjbrCuG+AN2CogJGBvicyKxFmRrq+z+sLiw5WVF2Vwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767095223; c=relaxed/simple;
	bh=g/Osl+TvnXzyea68sqODUuVsxskQBDKjfIXWUabyoHA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u6V5U8D5/HlQ2UZH75UZogdtUJqHoqn+g4BN0BHvLUIORHA1SoBC5fEChIjal/6+f5UQGyEAsnNlt/CDkwzGiZuHCc4Fj2ixhuDjTWR0aRGhLYysdVKBV/kDRW69SPD9Kx1YmC7OY8yHaxjIVNvLHd2MP+phlaxsZ+nbD+aTPvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6zuIbsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D441EC4CEFB;
	Tue, 30 Dec 2025 11:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767095222;
	bh=g/Osl+TvnXzyea68sqODUuVsxskQBDKjfIXWUabyoHA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=V6zuIbsGGSsPrcZP488SURbiA6QnMdTfFr0RvTGn06Pz2XBq0M27BlcB/H8Njjsnr
	 uLjxymkRuLk57pvwyTVZp3xYXumlfKZ/VD/wtnx7sECJde3+nXNoXLLWgL+Wq7pAwC
	 /zAcDAzMM6Jv8I8E7+8jJ6RkjBYnaRIL9mMhzAO5ua4hyqDFAprMHg7ksDzV0cnlZ9
	 wMro9I9QFkWgmqXTs4SbKVVu85HwUdI+oO0/uAgb//98BB69n2MwovLbVSuxqvWe4K
	 1kkz+7F6AZwBTa0JwT7EM/XRSIq4vbaslepacvVWz11FmDawWyePqRGUFiIw0051iy
	 CCSjSUcDCqSeQ==
From: Leon Romanovsky <leon@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Somnath Kotur <somnath.kotur@broadcom.com>, 
 Eddie Wai <eddie.wai@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251230085121.8023-2-fourier.thomas@gmail.com>
References: <20251230085121.8023-2-fourier.thomas@gmail.com>
Subject: Re: [PATCH] RDMA/bnxt_re: fix dma_free_coherent() pointer
Message-Id: <176709521920.596503.3669039368865843149.b4-ty@kernel.org>
Date: Tue, 30 Dec 2025 06:46:59 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Tue, 30 Dec 2025 09:51:21 +0100, Thomas Fourier wrote:
> The dma_alloc_coherent() allocates a dma-mapped buffer, pbl->pg_arr[i].
> The dma_free_coherent() should pass the same buffer to
> dma_free_coherent() and not page-aligned.
> 
> 

Applied, thanks!

[1/1] RDMA/bnxt_re: fix dma_free_coherent() pointer
      https://git.kernel.org/rdma/rdma/c/fcd431a9627f27

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


