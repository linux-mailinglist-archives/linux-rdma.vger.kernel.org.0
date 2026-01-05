Return-Path: <linux-rdma+bounces-15305-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF04CF2B69
	for <lists+linux-rdma@lfdr.de>; Mon, 05 Jan 2026 10:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A6F7307F002
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jan 2026 09:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F21221B196;
	Mon,  5 Jan 2026 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oyt6ffNt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED56F329E4B;
	Mon,  5 Jan 2026 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767604053; cv=none; b=LZsFIjlFoW9n8jcQmYIOwaApqaWIyJGz1MhAtzgDmSQsqA+2C0ZL+n76RMebJPbKS+O6pf6N7xoKsF4tH3INtojWRzODXEXKP06dOlzlsw5KTP+PiLyJn4vPQPx4sxncszKrJ6SkRJgz7orsBUK1CUdsKHbQBDnpAzwg5TwdxUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767604053; c=relaxed/simple;
	bh=FODxK3nxAIjOt/tMs/5PUdHO8mNK6v+7ICrti1LSlbs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K7MOOthbp6C2eb9xTcVzi9EFRp0f8hAl4jUp5coUYxMWoOIItMzxX5X8XkcrZsWcqk3jkr5rbnRLI0jXNHmF3qR/7/5nTluzKgWTVA5Tk9zkefL3VoXwnCoUsmJWoKw4qENCJ6f02yM7USFB0nLc6OHXlSJ126r0skDXx7VI9ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oyt6ffNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140D9C4E694;
	Mon,  5 Jan 2026 09:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767604051;
	bh=FODxK3nxAIjOt/tMs/5PUdHO8mNK6v+7ICrti1LSlbs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Oyt6ffNtgr+C7ESLyqvKL5xP7kg8eBSPOnX64S1VmqYMdmFAZ9Frqn7zasnNlV88S
	 sWKH3ujsMYRWxYQ4JKGTKIIhSJfi7dMhq58kY0/GNeIsp/4DFP1IoeOtgrCA29uvFF
	 9EL/m+Ijwlqvm3MvL/W9YfuUiu7eGrRhFEPy0Z7mYbsZAnKLIahws1s1HysUkwemE1
	 uz4tGzyDkAkYEUVNQGQn7cjjGVkZTGtjZKX9jgXPDPcj+bA2q+RHwnwzLvsCOcIdMd
	 OUClCQP3Xf3JkEXAjUru2c2FCBKmWkzvSnqw8bNvHPd+0oPXIcC3opXMC49cM+mslL
	 xnGDIS1opk1Aw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, 
 Chiara Meiohas <cmeiohas@nvidia.com>, 
 Michal Kalderon <mkalderon@marvell.com>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Parav Pandit <parav@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>
In-Reply-To: <20260104-ib-core-misc-v1-0-00367f77f3a8@nvidia.com>
References: <20260104-ib-core-misc-v1-0-00367f77f3a8@nvidia.com>
Subject: Re: [PATCH rdma-next 0/6] Batch of unrelated cleanups in IB
Message-Id: <176760404843.1151534.7543832472811485821.b4-ty@kernel.org>
Date: Mon, 05 Jan 2026 04:07:28 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Sun, 04 Jan 2026 15:51:32 +0200, Leon Romanovsky wrote:
> A collection of independent, self-contained cleanup patches in IB.
> 
> Thanks
> 

Applied, thanks!

[1/6] RDMA/umem: Remove redundant DMABUF ops check
      https://git.kernel.org/rdma/rdma/c/ac7dea328ab52a
[2/6] RDMA/core: Avoid exporting module local functions and remove not-used ones
      https://git.kernel.org/rdma/rdma/c/8d466b155f8389
[3/6] RDMA/mlx5: Fix ucaps init error flow
      https://git.kernel.org/rdma/rdma/c/6dc78c53de99e4
[4/6] RDMA/mlx5: Avoid direct access to DMA device pointer
      https://git.kernel.org/rdma/rdma/c/522a5c1c56fbf7
[5/6] RDMA/qedr: Remove unused defines
      https://git.kernel.org/rdma/rdma/c/cc016ebeb146d0
[6/6] RDMA/ocrdma: Remove unused OCRDMA_UVERBS definition
      https://git.kernel.org/rdma/rdma/c/325e3b5431ddd2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


