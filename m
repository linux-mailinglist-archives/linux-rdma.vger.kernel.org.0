Return-Path: <linux-rdma+bounces-397-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7301E80F90D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Dec 2023 22:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54861C20D64
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Dec 2023 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FCF65A9F;
	Tue, 12 Dec 2023 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/K47aIf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E4D65A84;
	Tue, 12 Dec 2023 21:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFDEC433C7;
	Tue, 12 Dec 2023 21:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702415954;
	bh=UE+yk/wIEl5wqTBJpUbWv1HkRygo21oZdxRRyi/EhrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H/K47aIfEEuRNHrLpUMSyNEnAGQYxLJnM1AMgiIGdbC6hqsgIeVFHeyUXQNw5Wuwh
	 5nuZP64+NqcK2CJa/ZC1io3MoXFKJEVVLH22VGqiwImc+Y1NYvL/YIOJd6ih7Hxg8a
	 is6tQy4YM0ar068Fqr3zkEzQ9QRijEiR2TbzuSYjREwH+SPYE6aJfl2Z0J8GfaTP3r
	 1OfchR4GTjE5wPyWxh49c5+OPajoKOVc3kFH1sWrKfM7MyO0SELHN3ijgk5mBd7glt
	 nxCdht3kK2opR3r/d7zRNdCDhG69ccYPBplKxGR2P28lwBCCT092vYjVhnEcucayir
	 w93GXlJ6Ag2Yw==
Date: Tue, 12 Dec 2023 13:19:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Colin Ian King <colin.i.king@gmail.com>, Tariq Toukan
 <tariqt@nvidia.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mlx4: Fix spelling mistake: "mape" -> "map"
Message-ID: <20231212131913.4195bc38@kernel.org>
In-Reply-To: <20231212203043.GF5817@kernel.org>
References: <20231209225135.4055334-1-colin.i.king@gmail.com>
	<20231212203043.GF5817@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 20:30:43 +0000 Simon Horman wrote:
> On Sat, Dec 09, 2023 at 10:51:35PM +0000, Colin Ian King wrote:
> > There is a spelling mistake in a mlx4_err error message. Fix it.
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>  
> 
> Hi Colin,
> 
> I am guessing that you are focusing on error messages and other user-facing
> spelling errors (perhaps you told me f2f in the hallway track at Kernel
> Recipes).  But I do wonder if you have plans to address other spelling
> errors in this driver. codespell flags many, including 'segements' in a
> comment in the same file.

It'd be great to fix all the codespell issues with one path, IMO.
-- 
pw-bot: cr

