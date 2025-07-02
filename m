Return-Path: <linux-rdma+bounces-11849-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BF0AF60D1
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 20:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8041C46FCC
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 18:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8718930E85A;
	Wed,  2 Jul 2025 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3CW9sBt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430A72F5084;
	Wed,  2 Jul 2025 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751479716; cv=none; b=a0WndRaUewTG6Ox1ACRuu3/3/qB8w5xRI72qGbEeXdy/XoesqxI49v5t+uU1DMuAhDGMbRm8ib2BODqGUwJNidfXJ8/Jc9VnXcefWlMP8cFd+JzHhZdVBB2Z3HUxNUNw+FFv2uNoWlNNP7nsguU+uV3sQvm4fDHmeIIPDuGs5TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751479716; c=relaxed/simple;
	bh=ECn/3QB60gjtqVOT+VePOkrt487uokuLOuVrQj03kqg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A9/oAY/3t7kwKHzAzS9gjAdZdXvLVidI8KBlf/0R/91gL3+uHMyM8zRq1kWmcrUgMLcVr+mK6DlfVoUZt91RwTKU1osTRe+D6qOaiG5FAl4qP523IStkJJXoBFEWTpjoj5gWvHx0I1G2qX5Nmouw5KdKYqQ4UyVdadGFq4mDH+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3CW9sBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605EFC4CEE7;
	Wed,  2 Jul 2025 18:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751479715;
	bh=ECn/3QB60gjtqVOT+VePOkrt487uokuLOuVrQj03kqg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=k3CW9sBtZiWb8HJ+ft1gfV0+zZHLS/f6xQ4sh6LhW4DxQIqak7JBrHrjGx/jwj1tV
	 tnilPFyTTI4i4gqrcaTaWKtPpLLSgFNLqjz4nQzujt1pSWwPvhVw7hxiTmcfIOBUG5
	 LZYEM6Fhx8KfkEZVxNjJFMhdsK1YSRcOI1ceXNJAv421NQWbUGKu7895yVWqw78A5i
	 axIy3dVphtJdL1O42+9fhGXpQK9IpztCQIN5hjJPlOcTfFLunlyiM07LxyWNrzJLHf
	 UhUMGQFcXAhtO5Wp7GfWy40Vl58FWP2pY68j/wk2/QQfca31K06hXPW1p1V4wlT4n6
	 tR3ZnW0kQL5Tg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Stav Aviram <saviram@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 linux-rdma@vger.kernel.org, Mark Bloch <markb@mellanox.com>, 
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
In-Reply-To: <c88711327f4d74d5cebc730dc629607e989ca187.1751370035.git.leon@kernel.org>
References: <c88711327f4d74d5cebc730dc629607e989ca187.1751370035.git.leon@kernel.org>
Subject: Re: [PATCH mlx5-next v1] net/mlx5: Check device memory pointer
 before usage
Message-Id: <175147971261.803911.2836852883164377733.b4-ty@kernel.org>
Date: Wed, 02 Jul 2025 14:08:32 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 01 Jul 2025 15:08:12 +0300, Leon Romanovsky wrote:
> Add a NULL check before accessing device memory to prevent a crash if
> dev->dm allocation in mlx5_init_once() fails.
> 
> 

Applied, thanks!

[1/1] net/mlx5: Check device memory pointer before usage
      https://git.kernel.org/rdma/rdma/c/70f238c902b8c0

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


