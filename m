Return-Path: <linux-rdma+bounces-15244-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF52CE9766
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Dec 2025 11:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A8D8301AD1D
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Dec 2025 10:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B634B29A30E;
	Tue, 30 Dec 2025 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d34SKmQ2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229B21254B;
	Tue, 30 Dec 2025 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767091716; cv=none; b=YiFX42WK4iSfDnbDx86UeKGMYQRcvWfhNJ0V/W2Ta83T9iANxq8uhcR5qW2IGiW3f4lVJ48m4tTvuDYe29Phddk9tNYFXGNUtPZg0n2zNHRXfrYjmf57jIIrIy/+cGjKNEnw70nJ7WVeL3HIZOhL1GeiVgpjhLV+aA87XSjeOCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767091716; c=relaxed/simple;
	bh=3Ie0Lf304vgic8egw7M+dgZCdoG+Y8N5jwugg7jP2Yo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HRHa1p2NorekA9WLlVV9fCz6J0f/zwxMi8db/nWSkHFeZJUSBmJncahQuDQ5zMoy9RwKGs9T4n5OkLLUJ7OaJ7NaH2FApdjV/Jt2KSDCTyXrqOA7NyV8MkeZIphDKG6I3acV68QNVCxUHFxY3uMsNrlHMAW5AuQdTLhxfm4dJW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d34SKmQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81137C4CEFB;
	Tue, 30 Dec 2025 10:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767091715;
	bh=3Ie0Lf304vgic8egw7M+dgZCdoG+Y8N5jwugg7jP2Yo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d34SKmQ2Qcuk4spT9iNt8WywQqqUqbeyvyrg3NVBuszX7VZxW0vUWSdctuL1sI8GO
	 slNzC8V7bZshvc97z2vftE2CQptfIGN7IJ3NzukDrDguKlJPnY0nHM0ZCh3VfGRxId
	 nEOTmu25qPyPjp8c4PjwOatV15PyUGw0AqyvW8B2Ub5UPKrvtoXOybRPb3YuelRr+1
	 pSXKIBk5FBKGtiyWgU4Sy1gUauGBMWAV4A1UB76myXV7Rep+SZd068WeGXOoxx9L55
	 czNVoZKY8VjMGZjrebhVyx1LxkRIkPxh9xJuKcZ/Kt3ECZPegeABU9cNDN5xIWZUog
	 fdO5guKWEUxKQ==
From: Leon Romanovsky <leon@kernel.org>
To: haris.iqbal@ionos.com, jinpu.wang@ionos.com, 
 Honggang LI <honggangli@163.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251229025617.13241-1-honggangli@163.com>
References: <20251229025617.13241-1-honggangli@163.com>
Subject: Re: [PATCH v3] RDMA/rtrs: client: Fix clt_path::max_pages_per_mr
 calculation
Message-Id: <176709171300.595137.5416854575977542501.b4-ty@kernel.org>
Date: Tue, 30 Dec 2025 05:48:33 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Mon, 29 Dec 2025 10:56:17 +0800, Honggang LI wrote:
> If device max_mr_size bits in the range [mr_page_shift+31:mr_page_shift]
> are zero, the `min3` function will set clt_path::max_pages_per_mr to
> zero.
> 
> `alloc_path_reqs` will pass zero, which is invalid, as the third parameter
> to `ib_alloc_mr`.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rtrs: client: Fix clt_path::max_pages_per_mr calculation
      https://git.kernel.org/rdma/rdma/c/43bd09d5b750f7

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


