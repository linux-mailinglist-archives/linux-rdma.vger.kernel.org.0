Return-Path: <linux-rdma+bounces-12862-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A56B30991
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 00:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B588717A6C3
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 22:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449732D7809;
	Thu, 21 Aug 2025 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWyLF1qE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F237262F;
	Thu, 21 Aug 2025 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755816500; cv=none; b=K6HDBfd9FYQu7PJ4f0ovzlcCslc1sSZ0UgCSArL9zbs5d/XUYd60s7Hlc5+e/cG2ed3ar7B9WeEIV0Gr/1mBNPs8KXwyxiIiJG+mWdHqBfNmDmAZQpM1DK3Ki29h3EbAsskk5z8SfvfstSSOePUhvsW3yqYkSnQLJa/jlY7RVTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755816500; c=relaxed/simple;
	bh=GAoYZ6fe/lNuQbQEQ/DgRYtPaaokBTN5+U3oFlTLZYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u63Zl9iRSNUcWr4mM/Km/C+vgF/p9vtPP+JWzlhYA//genJaHVyKSOuhIVOQI18QaAdXlT3M0of/3gkoHREX1j+YVDzDqRgys4zY3R4+eHHWtOR7n/vG/cn7ujlqZjcJulFucNaWj51pDtnE+wYLKC7hk/pclaerLYslcDKcYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWyLF1qE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDF0C4CEEB;
	Thu, 21 Aug 2025 22:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755816500;
	bh=GAoYZ6fe/lNuQbQEQ/DgRYtPaaokBTN5+U3oFlTLZYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jWyLF1qEUslq/3OJPS0payjaWR9d0qbaDgoQ13CHhvNH5xTBcbR+7P0lu2ZFEXl47
	 +RvRtRnzto1xhRZ3pGo0xkHC4BurQLuB8hymaJzi2W+YXTCiO28KOfreTNK6E58iAE
	 HiBftcbymiyBZtAGV+6rsVIMJ2n8vM2jP0TPb6+04rSNHBuuKNUXvfGm8oMdiuqV2r
	 xf/SNJljosIi7ctYLI3RuyE2PKMj49WkPwMn8xGorUxukTq810M4qWwAGBH8oARUn9
	 k22HO1R5jFGVyI6Q+lDX4U9UExAT3QSeU51EfrYnDXY+gnBNuGZyQPMjTD/CaFUTQ4
	 Ws3y3uatgfPqA==
Date: Thu, 21 Aug 2025 15:48:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Parav Pandit <parav@nvidia.com>
Subject: Re: [GIT PULL][mlx5-next 0/4] Cached vhca id and adjacent function
 vports
Message-ID: <20250821154819.249d6140@kernel.org>
In-Reply-To: <20250815194901.298689-1-saeed@kernel.org>
References: <20250815194901.298689-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 12:48:57 -0700 Saeed Mahameed wrote:
> To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>

> Subject: [GIT PULL][mlx5-next 0/4] Cached vhca id and adjacent function vports

> Hi Jakub, Jason,

Sorry for not pulling this easier. FWIW, I completely missed your
intent, IDK if Jason read your mind right. The series is tagged *for*
mlx5-next, and To: yourself and Leon. It totally looked like you're
planning to apply this to your mlx5-next tree and send it out as a PR
later. I missed the "Hi Jakub, Jason" :$

If in doubt please don't put any tree designation in the subject
prefix.

