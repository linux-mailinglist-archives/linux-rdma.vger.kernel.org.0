Return-Path: <linux-rdma+bounces-2467-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7938C473D
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 20:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39DC1F2364C
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 18:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C183D57E;
	Mon, 13 May 2024 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2c5wLXQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EDD537E7;
	Mon, 13 May 2024 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626526; cv=none; b=JsF9Pc5nclT9/at2MBh0OCQpyJzSyQt4x8uCxc48fqjXDasPsNatVg2BVuesqiNS6UfaZiv7kZADpLY1/BQF4pDX3iJorg1neoHPEhs4XlajI4NDpx2WRfJ6q5UgpS0VbjXnfLOrskeC0e1Cg2J9yOMjupdObyHjTn7fXcLzrrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626526; c=relaxed/simple;
	bh=GZV/Vfwlmaxtj4wAoHOeOIS1lpiVCIVCn9kJZPfG650=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZevpvQ2KrA9aU27o0tIjmnbyIMHtyeuYyjtTnR4bP7j8PULZKCb49sapiPEfOBAwqeZ/fpunvDcxsr45fuy1eccJW7IJDrDvzTEax6aGEUCKNSCKTc6cXuGIGhpjF+4HT3g/2SUqHkOvCoRl5k2XrV5aiyBbJjYQ6L4bgcuq7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2c5wLXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB248C113CC;
	Mon, 13 May 2024 18:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715626526;
	bh=GZV/Vfwlmaxtj4wAoHOeOIS1lpiVCIVCn9kJZPfG650=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L2c5wLXQcyT2Ddu0xxVsRugbQm2r19tFz29/0ox6iEp5r22M02s99LV/89p0SUhww
	 yjvDvPtSCgK+ybmIR5aq0pCwnYi9PllDMBORgjfAXlOLh06nNG9RGLk8Vi20HOjX4X
	 l8XnwSfAB5ECLkhW7/kW+BlhSYVaeiTd9ekwQI5Bwiidj+odvjJqAsDR7oYgEj5F+U
	 kRyXRJEP/TaRoe+xa0wMMk6OmIIrHGu7B23iqvcMGmjfyN5ldcRrgL9wvTEWtcP3EI
	 R11dVf519U/WBWoFfVAJjh5oVRFngSTcLpOB2qw3bq1Rqhi91L+1gtMaeJjWnj8jYi
	 VSw6AMBq7sbGw==
Date: Mon, 13 May 2024 11:55:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, zyjzyj2000@gmail.com, nalramli@fastly.com, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/1] net/mlx5e: Add per queue netdev-genl
 stats
Message-ID: <20240513115525.15043cfb@kernel.org>
In-Reply-To: <ZkJgIe71mz12qCe1@LQ3V64L9R2>
References: <20240510041705.96453-1-jdamato@fastly.com>
	<20240510041705.96453-2-jdamato@fastly.com>
	<20240513075827.66d42cc1@kernel.org>
	<ZkJO6BIhor3VEJA2@LQ3V64L9R2>
	<ZkJgIe71mz12qCe1@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 11:46:57 -0700 Joe Damato wrote:
> > FYI: I've also sent a v5 of the mlx4 patches which is only a very minor
> > change from the v4 as suggested by Tariq (see the changelog in that cover
> > letter).
> > 
> > I am not trying to "rush" either in, to to speak, but if they both made it
> > to 6.10 it would be great to have the same support on both drivers in the
> > same kernel release :)  
> 
> Err, sorry, just going through emails now and saw that net-next was closed
> just before I sent the v5.
> 
> My apologies for missing that announcement.
> 
> Do I need to re-send after net-next re-opens or will it automatically be in
> the queue for net-next?

Right, unless it somehow magically gets into our 6.10 PR - you'll most
likely have to make a fresh posting after the merge window :)

