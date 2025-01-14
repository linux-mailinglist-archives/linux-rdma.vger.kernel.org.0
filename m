Return-Path: <linux-rdma+bounces-7010-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D05CA105CE
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 12:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1CAD188707A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 11:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272C91EA80;
	Tue, 14 Jan 2025 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stdXCrkO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD57234CE0
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jan 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855252; cv=none; b=hzhgLXa7iCC/E97IhdjWxOK1xv6Stre6zpEmTgH4xQMVPkGOYOGpozGWtjfWKxMmYNIpGRtA5NqaCHbeaSZzRBmQBt0aIeGyReCjqZThbcf2EIv8i5EVZrp6XVp/548qv1lQwHtMMno2KDQZOQBIqPhn6IRcY7LlFZzKUdE/nl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855252; c=relaxed/simple;
	bh=pkKTUjdJC9/e51TgEfDuIJK3Hbf7yfI3d+JD71af9do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5qsF7xMWH1LHqgWcVpL+eN5W6tPk8VaLXZMBoVD1Bczk9Ec+YXLkramhfDcmfXa6KvnrzBAMS7dc/gMPHdcB1ZNzvH9OpvQFyqoLeh3dvIDBNvlnwbGxEFcAb0rvuxLd/dtzL+S3wHrC2ZCpeMXyjd/LexQ7FBXPT0irDsUO0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stdXCrkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F30C4CEEA;
	Tue, 14 Jan 2025 11:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736855252;
	bh=pkKTUjdJC9/e51TgEfDuIJK3Hbf7yfI3d+JD71af9do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stdXCrkOhyJScWNwTmKSasUd0nO9Ku6Fbe3WMP60JqNXHD7VNxgGWmNrhkhiAGy4s
	 oV6FtXGGFe24RQGUR1iGnkGzBRzVh6koOOcAZ5RA+lqDVxnMkpsTS6v0vkX+7pVIzr
	 o9cCK8kuJiObdoT7Byy0xRz9tNgc7/QFKsFqhR/UjEzKZ+2CqGsRNDCB+qHw8qt5Rp
	 bTURGRZOJcb/NNpM2S2Bs9J3sSGhXQ4y/CLAKkkGyL7D7zwZj+nMILHDBOMubWR4Tc
	 Ny3pbbCIfugNiD33tIMAMgxrunOipMjwEUU8FpJY64hXt+yc5YJPPlKOWvcuJXi1qi
	 HlqvByY+WxOmg==
Date: Tue, 14 Jan 2025 13:47:25 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Change the return type from int to bool
Message-ID: <20250114114725.GH3146852@unreal>
References: <20250111102758.308502-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111102758.308502-1-yanjun.zhu@linux.dev>

On Sat, Jan 11, 2025 at 11:27:58AM +0100, Zhu Yanjun wrote:
> The return type of the functions queue_full and queue_empty should be
> bool.
> 
> No functional changes.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_cq.c    | 2 +-
>  drivers/infiniband/sw/rxe/rxe_queue.h | 4 ++--
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)

Let's not do change just for the sake of change.
This standalone patch has zero effect on the code, both from functionality
and readability point of views.

Thanks

