Return-Path: <linux-rdma+bounces-15676-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDD5D397D6
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 17:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2909B300C28C
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 16:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C26F218845;
	Sun, 18 Jan 2026 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYIY7IOJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB51D5160;
	Sun, 18 Jan 2026 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768753392; cv=none; b=BnWKOy7EKrBhLwB3vjkZq5Q+H+biCpNtqd9q1bO/9M0p06d28dRYhFQrlFu0M7tr4R7xeoKrnBp05jNlnoXWdu1Su7rvZCAoAsJeamHO9PjXijHiNV45Hv0kbpakZFeaIAi9xca5uj/uPaJwzgUyDf9RakqVK4fKsMjWhywMzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768753392; c=relaxed/simple;
	bh=PNyEIOyLJvpFOMh+7+Br84wCmLtyNH5iOoF/1ERMO40=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OB1/c8+tSpEDy4nCe7z0mUZR4Cdwm5uhKHcC0UB0mpaKvUfC6bjBJC1ZMbujIbCkFMod4KKmlaflA9Z5BCGOr+q47aqoA/eI7r5vPNg6x5e712QxFsJ8oJ+fq3hX2G2L2khuyaFQKaBpC+VV886YL8DwcAv5t+ygfo9Y0tuk8UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYIY7IOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB00C116D0;
	Sun, 18 Jan 2026 16:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768753391;
	bh=PNyEIOyLJvpFOMh+7+Br84wCmLtyNH5iOoF/1ERMO40=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KYIY7IOJdk2LXXpcl6Q+3hQkHNY7uSQUQTCcf0sQiwmBGERM7t9si/e+v8Bc9w8Wd
	 5N32LtgcpsjYiCl1zlILOcAWL3ke41vl8UDB37dbv3K6ZOhBRNEk+efzu72Kjo6a2r
	 Hy/gEaokYjuXX3UdkOyVkkdw/JRD7qFKi7Y1Az9oABsqBd3h36YIqjppE4YW86ydXV
	 oU1MG2MPPeJEIyXLmBUXchVoQ7KCOq82frZSungITTgB6eS31JgLC3p5pe/SyKIiRm
	 FN/1wrtC0cvCHoudSmXCzgUp5MxwIB8ILn9ccZsPxYVJ5imw1MQw0szb+D+Dp7rAF+
	 ulHCIhdF0/2FA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Patrisious Haddad <phaddad@nvidia.com>, 
 Michael Guralnik <michaelgur@nvidia.com>, 
 Edward Srouji <edwards@nvidia.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chiara Meiohas <cmeiohas@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260113-umr-hand-lag-fix-v1-1-3dc476e00cd9@nvidia.com>
References: <20260113-umr-hand-lag-fix-v1-1-3dc476e00cd9@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Fix UMR hang in LAG error state
 unload
Message-Id: <176875338879.525622.17025100833914120656.b4-ty@kernel.org>
Date: Sun, 18 Jan 2026 11:23:08 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Tue, 13 Jan 2026 15:37:10 +0200, Edward Srouji wrote:
> During firmware reset in LAG mode, a race condition causes the driver
> to hang indefinitely while waiting for UMR completion during device
> unload. See [1].
> 
> In LAG mode the bond device is only registered on the master, so it
> never sees sys_error events from the slave.
> During firmware reset this causes UMR waits to hang forever on unload
> as the slave is dead but the master hasn't entered error state yet, so
> UMR posts succeed but completions never arrive.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Fix UMR hang in LAG error state unload
      https://git.kernel.org/rdma/rdma/c/ebc2164a4cd431

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


