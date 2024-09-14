Return-Path: <linux-rdma+bounces-4948-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D549791DA
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2024 17:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3B81C213EB
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2024 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5155A1D049E;
	Sat, 14 Sep 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKlJf/th"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F140C1482F5;
	Sat, 14 Sep 2024 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726328353; cv=none; b=RhSNTwoYTchV8VYyw7RhromTiiTPQo858dYzcdGiIWAy6t1lFBSw6iCdKxADYErd5jSOlLWn5vXUTUTBu0kzB9VlkdQWwkMB4r3jxzqEmMui7qAj/a2GV7fGEFPc0wydKYsuES5Pcqj3BvgDTqxX73djwaKtZu3mOgg8NFIzGiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726328353; c=relaxed/simple;
	bh=6utujUreTN+l/YtN8myICbzB+48c/VEAfl+TLn72uCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERNhlp7y1wMJ69eXCw4pC3c6F0u5sF7INsR1jgSxjwjYRVKXumC4k26lMZ2C5zkgn7AxHS+GWGWLxaPn1O8dqfGfM2ZMJdAYxEPM/3HhmrBoj4sz+DjgfvVWiECDs/Z6FMNYAOv2Uz80sY9eVDMFH3bqLsw9Vyk78AJKk0XpfZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKlJf/th; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D194EC4CEC0;
	Sat, 14 Sep 2024 15:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726328352;
	bh=6utujUreTN+l/YtN8myICbzB+48c/VEAfl+TLn72uCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKlJf/thmbAF98QHr6tb8t5w1eCGcAsXqz6aoM4AyofZuhrpVEutoJJwGcQCr9viq
	 AUYVDWMcFb3mcemGawYZ82/q9clGSnuFNOLnWLZpI0A8bj5DeODbOQcjS3Gn8a7wQA
	 rrPGnsTnxoaA6d6Gwo3YR8fK6r5diIOmwZur17NXe5bRtt58XEceIWOIBSzJk5fjct
	 eCMhADcOlAGXC3MHBS5TBVix33KzAqCSpcsY4fncAkhdGlo8W7jZ27irSSkG3Fnxpd
	 llRclngqNp3jaYtH4Rn3mBhFZtX4x4K5iVW01+1F60jCYc9CwfdUfy+WAOitKCyK9A
	 FAiWJj2NCiRmA==
Date: Sat, 14 Sep 2024 16:39:07 +0100
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Itamar Gozlan <igozlan@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5: HWS, check the correct variable in
 hws_send_ring_alloc_sq()
Message-ID: <20240914153907.GF11774@kernel.org>
References: <da822315-02b7-4f5b-9c86-0d5176c5069d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da822315-02b7-4f5b-9c86-0d5176c5069d@stanley.mountain>

On Sat, Sep 14, 2024 at 12:58:26PM +0300, Dan Carpenter wrote:
> There is a copy and paste bug so this code checks "sq->dep_wqe" where
> "sq->wr_priv" was intended.  It could result in a NULL pointer
> dereference.
> 
> Fixes: 2ca62599aa0b ("net/mlx5: HWS, added send engine and context handling")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


