Return-Path: <linux-rdma+bounces-3594-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B262491E03D
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 15:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD4E283C42
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 13:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8AC15A87F;
	Mon,  1 Jul 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkYiSUNf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DCD158D94;
	Mon,  1 Jul 2024 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839237; cv=none; b=nYfoKTV+xPXD/2PC9UIylG14+Fxs5JfsnRZkz5OdIDrumVGt+iX+z0xA+ocDAXkkqqyzeGcp+UFzBd2fVZH/i9egBFjQJ2ZDmbHUGFVm0DXzwWcol/GzfaCVWktmpaxHMII91upphjezmTK5ZNKK88B/9/bhdeIokecVZRABTb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839237; c=relaxed/simple;
	bh=qErcNn1bAd+KgYMHdz8WFVSZwXXfkJKGETB1NMYn3+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ov/zeLcPAt3Zh7sz5aj8qNJpzsGjXB5SKKpRK7bWeYZPG+HvuxdMFHfPRgLNJ73yj233QFERn9LQYa/ciYq3sjGrQyHFb33R7KTo7Tof0F2a45eO9hgn0GuSiOyFuA53TjNZzqM5JF+9IESOwwa234GPP2Qs3ZgaZUlXr+splsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkYiSUNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4CAC116B1;
	Mon,  1 Jul 2024 13:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719839237;
	bh=qErcNn1bAd+KgYMHdz8WFVSZwXXfkJKGETB1NMYn3+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nkYiSUNfCWjHm+lyBjJWy4l8XdPpnMy3UW2zfdFrVqh92N6IfogZnKbfthsj0u9F5
	 W+tC/y1v3lwj9M9CP4InJts2/OYcXeTSuq6btM6aDrVfJDh4XmQ+m6qFBmXT6B+XK6
	 +2jKdbEcnzFIN646kiVBTot3mvvzuTtLJ1dmkpi8a/yaIzGg6ZMPPomvuWbHMo25us
	 3fut+aW8yvKtL1JeUHIELmdeOUae4lNA75nSpEnPhvGMp0OZE4sdyZiAsFgVgfoxS+
	 MbOce+3HqFhax2JPG963KB10iUstxrJnK0VtHPcXieYeOt7spcVw81PKjWuW24+hnk
	 oUigdVSamyPBQ==
Date: Mon, 1 Jul 2024 16:07:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, pabeni@redhat.com, haiyangz@microsoft.com,
	kys@microsoft.com, edumazet@google.com, kuba@kernel.org,
	davem@davemloft.net, decui@microsoft.com, wei.liu@kernel.org,
	sharmaajay@microsoft.com, longli@microsoft.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] RDMA/mana_ib: Set correct device into ib
Message-ID: <20240701130713.GE13195@unreal>
References: <1719838736-20338-1-git-send-email-kotaranov@linux.microsoft.com>
 <1719838736-20338-3-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1719838736-20338-3-git-send-email-kotaranov@linux.microsoft.com>

On Mon, Jul 01, 2024 at 05:58:56AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Use the mana_get_master_netdev_rcu() helper to get
> a master netdevice for querying network states.
> The helper allows the mana_ib transparently
> support baremetal and netvsc deployment cases.
> 
> Fixes: 8b184e4f1c32 ("RDMA/mana_ib: Enable RoCE on port 1")
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Thanks,
Acked-by: Leon Romanovsky <leon@kernel.org>

