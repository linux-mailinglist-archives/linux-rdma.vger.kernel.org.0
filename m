Return-Path: <linux-rdma+bounces-15133-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAFACD3F9B
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 12:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB3C8300C6CC
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 11:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E027A2F616B;
	Sun, 21 Dec 2025 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOPmom45"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A752F549F;
	Sun, 21 Dec 2025 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766317562; cv=none; b=okVINaziByyYW1GResESb8bZp4dPjUo3SaSrmiu1kWS7NujiJscjzTGtdvPApuioat8qovLBKFCwFoNLGc6gbRymdM3P9qB6SwdZgNaxK26LkVJf00TI+KHtiI1Z2BLJmuupiAvwlZ55Ui0LDaJeAJqxMieizlXMk6EnB2QMaUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766317562; c=relaxed/simple;
	bh=jXwFWySBBH0YZeNh9mYVtAnWUXBpPAqk5kwxwQR/5pQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=En7h/ofv68YIFfdQZBC23VFNUcWVZ69B5XlAaEso1uIR3VBcpvwgIelYIyvccr5jlX0gvPAfTgQEG9AnKHh2NHlzUiQYHS6jweo6t6HLMPo17PJZiu0ZQa50eVnvEmfhWS0+a4bDLGC1DdEqQviBvicIqZA1ucdIu6fTsh96Xi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOPmom45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD9AC4CEFB;
	Sun, 21 Dec 2025 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766317562;
	bh=jXwFWySBBH0YZeNh9mYVtAnWUXBpPAqk5kwxwQR/5pQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dOPmom45D9x6RfoneuZYyVo1bFcWe/ECy3VQIhCVzGpewTQdNRBwn4zmFx7hhn9NS
	 d37hGMrXh0bSRjvrP3+NdPvi0S9/dLzK61D3+7bxBDo2RBBml6wMIymTzF3akjw8Se
	 LUaC0COnF4fBm2+HM9/0aK2HsLYFqK6AwrP5jy5wgWCCbcTcZcmgKWEbaT6deHqPEx
	 GCNnRv1PnIK2e0oHDgrlqu2vMssTS/pbjls6Qk4naRTuahXaxyty42d25xkb5JUy3C
	 oMx+2GwRyxREmYgf0CtegiDgjB0L9y/1MdHVc+Ytph9N6ryl3xOnle8L+9WnmaOXN5
	 x9CW+rCYg5sZQ==
From: Leon Romanovsky <leon@kernel.org>
To: Mark Zhang <markzhang@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: OFED mailing list <linux-rdma@vger.kernel.org>, 
 Network Development <netdev@vger.kernel.org>, 
 Majd Dibbiny <majd@mellanox.com>, Doug Ledford <dledford@redhat.com>, 
 Yuval Shaia <yshaia@marvell.com>, 
 Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <80749a85-cbe2-460c-8451-42516013f9fa@I-love.SAKURA.ne.jp>
References: <80749a85-cbe2-460c-8451-42516013f9fa@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH] RDMA/core: always drop device refcount in
 ib_del_sub_device_and_put()
Message-Id: <176631755924.2405560.15903138508114158525.b4-ty@kernel.org>
Date: Sun, 21 Dec 2025 06:45:59 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Sat, 20 Dec 2025 11:11:33 +0900, Tetsuo Handa wrote:
> Since nldev_deldev() (introduced by commit 060c642b2ab8 ("RDMA/nldev: Add
> support to add/delete a sub IB device through netlink") grabs a reference
> using ib_device_get_by_index() before calling ib_del_sub_device_and_put(),
> we need to drop that reference before returning -EOPNOTSUPP error.
> 
> 

Applied, thanks!

[1/1] RDMA/core: always drop device refcount in ib_del_sub_device_and_put()
      https://git.kernel.org/rdma/rdma/c/fa3c411d21ebc2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


