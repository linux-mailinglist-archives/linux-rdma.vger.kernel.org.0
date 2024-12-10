Return-Path: <linux-rdma+bounces-6397-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22F29EBA52
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 20:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60DC167010
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 19:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AB0194C9E;
	Tue, 10 Dec 2024 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV+S7oiA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D5823ED7F;
	Tue, 10 Dec 2024 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860152; cv=none; b=YTii1n07lolIyZLkrYIayGmf3UukC9eRFmFk1kS7jlsLr+0/yWI0Vkaoyaly8UtHiyPvXHoYzxCFyCH3HmouGeqdvzXwUjJDCs4ijdAyAMrpwBuYmTABczcX2+goniIQhIJAH1T7Hn1tDLXYm/n7anu2AH4t0ovbu1HE1FOG7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860152; c=relaxed/simple;
	bh=ccp/xH4bLy0ckAAyRaIH+PYOoXHwMQ8m+iqCNhb/8jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyCbC7nKr/UT7a7EEoXDEMUGjv3vzieXrW303leK8Z76XnCc0Perzn5qvr4vgjhIy9AtjWcrx+v7Nh4rDJHNqVipxmAyQ1wmEiUcdlVA5c+21QU4Vsx1O5BcoSUDpALw0/IxcuzfUep9XCqoEl/jNDCxJkAvRxJop3pPbZ9zZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV+S7oiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FFFC4CED6;
	Tue, 10 Dec 2024 19:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733860151;
	bh=ccp/xH4bLy0ckAAyRaIH+PYOoXHwMQ8m+iqCNhb/8jI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eV+S7oiAKYmVWA8+KJu85nOlnXrH3Mz624CAK6LuJMd9xHH29/iC1zKzfVJn3BrzS
	 uxs0/AkGHTUNuAZz7tVVjJfJdazXgVObV1i6IDNjyE8HavW+rkCqyKAtuCrI6GJ2Ou
	 QP4rcic2r/EOz+ja0DQfcyGD9PjIHxJuhhWuGiIw3OCaetDEWSZTUPBWR5bQ2kMIlM
	 9uiASTrBNaV1dFM+UHEJjBifsMISWURtIhLer+S7e2LjgI8N2kW/BhE93KtjPbnfPr
	 fTp8mAWcBOSECZbKT739PhTWIV4dTGbzLoy6uG3dJGLHDbUxeLZMC1Cu1emsmnofUO
	 L3R8bb3KGyq6Q==
Date: Tue, 10 Dec 2024 19:49:07 +0000
From: Simon Horman <horms@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org, gal@nvidia.com,
	kuba@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	Tariq Toukan <ttoukan.linux@gmail.com>
Subject: Re: [PATCH v4 net-next] net/mlx5e: Report rx_discards_phy via
 rx_dropped
Message-ID: <20241210194907.GA2806@kernel.org>
References: <20241210022706.6665-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241210022706.6665-1-laoar.shao@gmail.com>

On Tue, Dec 10, 2024 at 10:27:06AM +0800, Yafang Shao wrote:
> We noticed a high number of rx_discards_phy events on certain servers while
> running `ethtool -S`. However, this critical counter is not currently
> included in the standard /proc/net/dev statistics file, making it difficult
> to monitor effectively—especially given the diversity of vendors across a
> large fleet of servers.
> 
> Let's report it via the standard rx_dropped metric.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


