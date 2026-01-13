Return-Path: <linux-rdma+bounces-15503-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 213E2D18FCC
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 14:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCC93300D33F
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 13:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC45257851;
	Tue, 13 Jan 2026 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLeXa8l2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F0D1DFF0
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768309311; cv=none; b=CwDhysZzH6FJekJNsH5YD7IP3jKNhuXHSG/PQr8w9sqhIjLlUU6VwvvcY5URgo576DtDxpNF5VZ6wP7jhk6GzRWfUtoJKZHjB1oOH5QEevqcfC3kRalxeGQwiDzdAi2AoHie0DIsCwq3jxYvJu3cB+uWTkHQPmZ3J3bkqQfNtgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768309311; c=relaxed/simple;
	bh=IWUA3F6ntLjrKRLLxJ7PowsKFADqf5ahr359VN0UHa4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fZYrK0Vt8IdQwsUaxDeEpHuhp7cTWA0JB0cyw3VsCTVwc3oRvMwb9xP2i7fiwAEXcV4ud8I9W0Rc28xm/YfzBVcpeo1EOkOlf5e492rAejJ9Ig/bI+Peos78qRsppWr82tH4AK04H21Bg/ysAt9La7b2gaOIkFpViPmvzP2VgtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLeXa8l2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAA8C116C6;
	Tue, 13 Jan 2026 13:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768309311;
	bh=IWUA3F6ntLjrKRLLxJ7PowsKFADqf5ahr359VN0UHa4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PLeXa8l2AkXoZHLJ318blrW1PWKjF6n11rn1PpjacQ90J/F49D4PtQCqD5/KdccTp
	 VnejTb0jA3yKWaCHtw2worV5JlFhYw3KUblixPRSTI8cLJwu2b2kfSo88U+9mdNux2
	 qiTUOmKRXi4tcgiiCo7pIRY8OX2gH91Pyc6wK/Mm0Y9f2WLNa006/SAkCiaZDLy73P
	 shYYoET7pjiBR3IAQPuKrWEo/U7ybonutQX5xYrWSQuZAW92pYrH3nYf2zNQr4l2Rf
	 7Z5x/XtbJwQu8YXsbi3e8cTUgAZ1CIv7CtU9hCG1q6RJLjECmh3cUCA3RBznhrpR89
	 JpW/6YSfPpvhA==
From: Leon Romanovsky <leon@kernel.org>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, 
 Jacob Moroni <jmoroni@google.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
In-Reply-To: <20260103172517.2088895-1-jmoroni@google.com>
References: <20260103172517.2088895-1-jmoroni@google.com>
Subject: Re: [PATCH rdma-next] RDMA/irdma: Remove redundant dma_wmb()
 before writel()
Message-Id: <176830930808.419746.3355739018678934478.b4-ty@kernel.org>
Date: Tue, 13 Jan 2026 08:01:48 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Sat, 03 Jan 2026 17:25:17 +0000, Jacob Moroni wrote:
> A dma_wmb() is not necessary before a writel() because writel()
> already has an even stronger store barrier. A dma_wmb() is only
> required to order writes to consistent/DMA memory whereas the
> barrier in writel() is specified to order writes to DMA memory as
> well as MMIO.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: Remove redundant dma_wmb() before writel()
      https://git.kernel.org/rdma/rdma/c/52f3d34c292b62

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


