Return-Path: <linux-rdma+bounces-2696-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDD98D4DF0
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 16:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B50D1F23AD5
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 14:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107F7183097;
	Thu, 30 May 2024 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI9ksBTr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158B17C21E;
	Thu, 30 May 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079170; cv=none; b=tM9xMyWLwcajHb1MjoeT2EHB4xObL8QjLbKj6VRNd3TzRjDEiO6WavLBwH8Xm74DyMu82GZMoS6FAnqhg6hbBJK1pBUyDcIDd5xCjBg7JLS7y4HNgfJalVp02sD9Vv+2NO6ukEREsmp3JLu1ReRZ446Ou+iMWJ5nJPM6gIAb8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079170; c=relaxed/simple;
	bh=NMBkiX/tpRTQn8tO+rvKwcvAOh4EYfEUhO6DHWLQxrE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=im5QxAbzUxrZK4FirznrgRv/JeZi1fX0gDLMwORPGvzKSi6N7Mmcl0w/QuEU8o/jOHkUKjneQ1kJalOJnjCZXoURWWo62jyG+AFctS8MLxs1k4UAKjyNerCRMOM8qfqeZN3pbNZh19kO+71fuC0M2FpuWbYCb3LMKaAHgpSFaMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI9ksBTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9056C2BBFC;
	Thu, 30 May 2024 14:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717079170;
	bh=NMBkiX/tpRTQn8tO+rvKwcvAOh4EYfEUhO6DHWLQxrE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oI9ksBTrcVOOG5b/Lh2uKEclvuQeV3+cNs7x/L5CxxCMpL801jpLKVdwcU+uQJsR/
	 es4uDePsVygRXEKWUwf+fg0ZgTvXezsWKRQBDVYNXvYGVXhrutmLIA4rr2jNBqvK6c
	 hYCbL6gykexOP1dr2MoxLgiS6bITfQn9dg9+VCh4bpzL7bnG1erdESeZqYv7YSvcTm
	 j/DGb8m4zahAr1KnZcjX1V2JmeebGgtZTr/HxdR6nTPYjrQkX1ZOuJvBub89L/juWw
	 nFrswFKMN0H1Aq9SUAm8IaiFY9lfuBsxjQwpBy4BhqjqAWCvmlVR26Z8tUA4QbhJvR
	 27GWurqQSChEA==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com, 
 jgg@ziepe.ca, Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1716366242-558-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1716366242-558-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next v3 0/3] RDMA/mana_ib: Add support of RC QPs
Message-Id: <171707207901.117187.16600242304842683763.b4-ty@kernel.org>
Date: Thu, 30 May 2024 15:27:59 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Wed, 22 May 2024 01:23:59 -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> This patch series enables creation and destruction of RC QPs.
> The RC QP can be transitioned to RTS and be used by rdma-core.
> 
> RDMA-CORE: https://github.com/linux-rdma/rdma-core/pull/1461
> 
> [...]

Applied, thanks!

[1/3] RDMA/mana_ib: Create and destroy RC QP
      https://git.kernel.org/rdma/rdma/c/53657a0419ef44
[2/3] RDMA/mana_ib: Implement uapi to create and destroy RC QP
      https://git.kernel.org/rdma/rdma/c/fdefb918496235
[3/3] RDMA/mana_ib: Modify QP state
      https://git.kernel.org/rdma/rdma/c/e095405b45bbbd

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


