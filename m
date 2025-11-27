Return-Path: <linux-rdma+bounces-14799-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D44F4C8D626
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 09:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9307F3A94A4
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 08:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D08320A2E;
	Thu, 27 Nov 2025 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qsdt9xK8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A383B23372C;
	Thu, 27 Nov 2025 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764232922; cv=none; b=tPac8q4wpLabr94HaWF9NivY0jGXh04UQl4oapUWD2YspxmOUXuTaTdjUQyE1Hg6PdNVx9QDauae6YMvj67tSgSNzxUWw0rzGZHzatx9C+HslH+xB3fDJceAMchT5ZiEDNyL74kwTNJaLSURa+HHD+1+uGqXM9VTJGQHmc9dGdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764232922; c=relaxed/simple;
	bh=X80sCM3q3ut9FWGiov/9NC47OHOFMO25tdgZ+zs2L0U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZbdpTo8GirfCO8IDXDUDBq3phiy2mZD0ceO60Qxjy5LtbiJLBkiJosnh/KdxFbTQ2xgxh6tRF7nx+9y5fwlzBJzYbJVuyQ81zKHT6MmT66e4mdCLQhTMhicPSHrodbBojJzQW0SbCEbxLUgUZ6WuKj2PFwxzS2v9B7PVc7mkq3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qsdt9xK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C124EC4CEF8;
	Thu, 27 Nov 2025 08:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764232922;
	bh=X80sCM3q3ut9FWGiov/9NC47OHOFMO25tdgZ+zs2L0U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Qsdt9xK8kEElya/zhPo2kbKLh0G0oql01xtPtuAgqtyHQodui64fF1pNhEJ4/4DJu
	 ELQpKJufpiZK3GZSHkjiG+hdCRnCH4rsrTbCbKW8szDDzxsasKJ0xy9aNpwTxfo1Hc
	 qURwP9BKm5VxQVLPz9cbg93nRxNzn3ZoC+YfHcG4GbQtjBXak9GHGgiI//s6VqzYhd
	 1PcODAaWd7N+EmMn0qgSO9ehDw4bfV2mSWmKxrV4Z1vErY16we//Md+95Mw0KDo4Ig
	 XjJh72my0olITHrAmMmluqFmyB95g3v66996kOnCr3Mk+NC249clpFeQ7j6dUgsuDA
	 ZpBGB0aVG8g9g==
From: Leon Romanovsky <leon@kernel.org>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Usman Ansari <usman.ansari@broadcom.com>, 
 Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20251126-remove-prefetch-v1-1-fcac22007ea7@nvidia.com>
References: <20251126-remove-prefetch-v1-1-fcac22007ea7@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/bng_re: Remove prefetch instruction
Message-Id: <176423291903.1831516.5989473716254720231.b4-ty@kernel.org>
Date: Thu, 27 Nov 2025 03:41:59 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Wed, 26 Nov 2025 09:57:37 +0200, Leon Romanovsky wrote:
> The prefetch instruction is meant to speed up access to memory referenced
> by its address argument. In the bng_re code path, it has no effect,
> because the pointer refers to a function that is executed immediately
> afterward.
> 
> The issue was identified due to the following kbuild compilation error:
> 
> [...]

Applied, thanks!

[1/1] RDMA/bng_re: Remove prefetch instruction
      https://git.kernel.org/rdma/rdma/c/155c9971fa88a6

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


