Return-Path: <linux-rdma+bounces-5904-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91959C32D2
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Nov 2024 15:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163A81C20906
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Nov 2024 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E807D1D554;
	Sun, 10 Nov 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYpINlEb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A303820323;
	Sun, 10 Nov 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731249082; cv=none; b=OzJ+jY0RZia1fIKjDhaJgvSwuDd2jMNr7MFufbYIEM1ewWLf/PZB3+E3VoJuAGiXglLIqi0IhS3zPpMCLwTTiaTmo1nDVedgNk+kLQN40q/7SEaGd/Avc5vR9B2HKy8uGm4/u50xdAuvtSHy346EC+0NUVCbK9rZRHBVlRBVU+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731249082; c=relaxed/simple;
	bh=VytAkGGjhbJmg9TO5kYnJWf1rKiZjWPDZDxF7GPn6qs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uzUqVGb9qmHdbfg/of9SxvPHwnaAXwU7mVXpRlYMipnzAIBrIF7ZzHFMmH64k4pEE4HNZxHq+oKDeLVz8wOWRbI5L6Xo7zqumn9/YIqtQ9mFkzTgYCG05tdEgiojQ3ZxB5KvPWhiRmhZmt9Ah6W3dQWKxW2hmDqSKw1MEc4PSL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYpINlEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE32C4CECD;
	Sun, 10 Nov 2024 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731249082;
	bh=VytAkGGjhbJmg9TO5kYnJWf1rKiZjWPDZDxF7GPn6qs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PYpINlEbtPQnhQWyZEmciBDcJS+dKNfikO5butVVXGA0nhUTd52SnD8VfFCR47W/f
	 +IRX0TxfOVje6W8Y2MEXz6g9oeN8W3l5EZ1PRTWDrp3XBe70HrrYbqKnXq4Q1k3/KU
	 P3geebeq62749ZXcNfOvPPc/ed4ZKyeTshjpDciEFkOf1KHLAZMXzMJErUru8B9Mf8
	 l9qBajDH92BKQjTi3PiVfOQljZ+bZoIhqhVjBE5yA7xErM1Z6hkhSSO3IyQJxDNy8K
	 xcljfTPmvg9b3DGrXk0oGqTZfpoJq2Wcoqe+QuDM2rgHZR8s6FXVJ8sVcFBNRIYPzR
	 LDeq3zcDPCDgQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 linux-kernel@vger.kernel.org, tangchengchang@huawei.com
In-Reply-To: <20241108075743.2652258-1-huangjunxian6@hisilicon.com>
References: <20241108075743.2652258-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-rc 0/2] RDMA/hns: Bugfixes
Message-Id: <173124907897.105241.13173631230364645221.b4-ty@kernel.org>
Date: Sun, 10 Nov 2024 09:31:18 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 08 Nov 2024 15:57:41 +0800, Junxian Huang wrote:
> Two hns bugfixes.
> 
> Junxian Huang (2):
>   RDMA/hns: Fix out-of-order issue of requester when setting FENCE
>   RDMA/hns: Fix NULL pointer derefernce in hns_roce_map_mr_sg()
> 
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 1 +
>  drivers/infiniband/hw/hns/hns_roce_mr.c    | 7 ++++---
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] RDMA/hns: Fix out-of-order issue of requester when setting FENCE
      https://git.kernel.org/rdma/rdma/c/5dbcb1c1900f45
[2/2] RDMA/hns: Fix NULL pointer derefernce in hns_roce_map_mr_sg()
      https://git.kernel.org/rdma/rdma/c/6b526d17eed850

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


