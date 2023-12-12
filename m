Return-Path: <linux-rdma+bounces-396-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4890880F7F0
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Dec 2023 21:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47DE8B20F1B
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Dec 2023 20:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07FD64125;
	Tue, 12 Dec 2023 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJMxuU04"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACA564C;
	Tue, 12 Dec 2023 20:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC0AC433C8;
	Tue, 12 Dec 2023 20:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702413049;
	bh=y8vlYmhIK7DL2ublK44Rokjsp/ohlcxBMr8GRcCvbLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJMxuU04j+ovQ73NpiIVK/rnB0bYVPAHXVYMi31q9vxg88yZpZdrE8gq0SiZMDtm0
	 uGQsOu1Q+T5mPoyclLIauTmwZSIBIF9BejaD/NtO6mPLYs22BH56fEqlBu6kez/mcx
	 CSntD2P5VXA1spcGk6mRzOOEVRSBqf7zk7xfj1jDAgRveS+QP5DyHFH3+CNppuFjkb
	 Mxfal8cLIQtAn9NlGfbHPiubVUT1ZSoA3lcT9nTvCD4LxaULd2quZHCzDslWfwtzGf
	 wQgKrmSJoIjFK5Dcam+f2uQR0B/T3GYpWDg0hfW/sxNJbs9UKeaGwgXE9lqTUVmCiu
	 wRXmordw+Nb7w==
Date: Tue, 12 Dec 2023 20:30:43 +0000
From: Simon Horman <horms@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mlx4: Fix spelling mistake: "mape" -> "map"
Message-ID: <20231212203043.GF5817@kernel.org>
References: <20231209225135.4055334-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209225135.4055334-1-colin.i.king@gmail.com>

On Sat, Dec 09, 2023 at 10:51:35PM +0000, Colin Ian King wrote:
> There is a spelling mistake in a mlx4_err error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Hi Colin,

I am guessing that you are focusing on error messages and other user-facing
spelling errors (perhaps you told me f2f in the hallway track at Kernel
Recipes).  But I do wonder if you have plans to address other spelling
errors in this driver. codespell flags many, including 'segements' in a
comment in the same file.

In any case,

Reviewed-by: Simon Horman <horms@kernel.org>

