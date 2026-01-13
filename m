Return-Path: <linux-rdma+bounces-15510-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE772D192E4
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 14:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24B0A301052A
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 13:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097143921E8;
	Tue, 13 Jan 2026 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iN6ZG2ec"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A6C2586C2
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312379; cv=none; b=Q+77V300Kmrpym0sbb66mYCPVMOYzkaYh3a3N1ix6D+jlT8MF7dTC4WSsE4ffMvC65+29Y8akZDAu6QphEKLhIauBqcOmvBdK5RwstdTjje7YGlxK/NUUW15FT98p0T6CXil9O1uerNo1FVxGRiB0Btvhoy+Y8ABT6MTcutHhlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312379; c=relaxed/simple;
	bh=BYyzxz9ke2C4HuXknuH+ymlxqy2KDMw0tK45qqUUNLI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=awLNk2juGZ+biCN79tWOyUplhVudF8T41fTdSbV9zM4oNN/rKHxY4x4mCNbq9VYj0JW2QbMoJyUeqNlslkBLB3uiIlK7OjHlW9aute+/OJjOebLDLsyj09euSq49zHOB+fpY5y4ODnJs2j4hjCUQrR1NV6ZqBUKmFHLTIPikdWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iN6ZG2ec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDA3C16AAE;
	Tue, 13 Jan 2026 13:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768312379;
	bh=BYyzxz9ke2C4HuXknuH+ymlxqy2KDMw0tK45qqUUNLI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iN6ZG2ecmxaS/t8JCI8uDElcJFYk+A/ZzafTgmqQ/wSIHBYr2korSiKCOFVdIaePN
	 oGIJtreI7cb4cbR/4JXe53kLPX28nDnFkC9r/up+Bxxb6xKh1tk4ap9MqAJmntzpxn
	 oyxH2U1o11MPjf90oJNCVSPQbFWLIKyuCAWsmSjJjI4Dejg0fKNzDeinYkmxP8aBiB
	 FzjlPVfGGc6H34bzPErUlPRneliGrucmWDtxlfmGP2p/4YrBy9wxOYIjAmK2VM7HdX
	 F/T2+xuO722ZcvsGRPrLpDtCLXs70e+qssnr4s6BY5YFgMD8NV+79Bh5iDlxAa86lQ
	 3qz0+L58GgvWg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, bvanassche@acm.org, Jacob Moroni <jmoroni@google.com>
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <20260112020006.1352438-1-jmoroni@google.com>
References: <20260112020006.1352438-1-jmoroni@google.com>
Subject: Re: [PATCH] RDMA/iwcm: Fix workqueue list corruption by removing
 work_list
Message-Id: <176831237686.425757.14726755194925329763.b4-ty@kernel.org>
Date: Tue, 13 Jan 2026 08:52:56 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Mon, 12 Jan 2026 02:00:06 +0000, Jacob Moroni wrote:
> The commit e1168f0 ("RDMA/iwcm: Simplify cm_event_handler()")
> changed the work submission logic to unconditionally call
> queue_work() with the expectation that queue_work() would
> have no effect if work was already pending. The problem is
> that a free list of struct iwcm_work is used (for which
> struct work_struct is embedded), so each call to queue_work()
> is basically unique and therefore does indeed queue the work.
> 
> [...]

Applied, thanks!

[1/1] RDMA/iwcm: Fix workqueue list corruption by removing work_list
      https://git.kernel.org/rdma/rdma/c/c6b61cad07189d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


