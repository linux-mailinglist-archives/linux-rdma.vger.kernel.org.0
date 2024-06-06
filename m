Return-Path: <linux-rdma+bounces-2952-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55078FF26C
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 18:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5433A28C410
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 16:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC82197A8A;
	Thu,  6 Jun 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvjQP35u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B131E495;
	Thu,  6 Jun 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691035; cv=none; b=ohUPuQx1p207gAsZ+gMr1PNAC4y6dJY7gHg4tF3iuzh1A6q9wCDnvIPAdf1sL9DYWL2mKlMhwa1+Zapzhgsc19V95zZbP8CWhsI/bYvK3xojMvwjPHNGCdbaDG6Q38jzRG2LeJjvA1r/l90HhzIIoJ3sY2dPaJpNYpr8PsZuGHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691035; c=relaxed/simple;
	bh=OfyrndzLBxJXPZARRdFKfxdMEQKUjt4NmFCK9jKy3kE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8yjNIw6orD5UdsN2aZXnrY15130XSKTJMv9i4341HD0b1U3HRntNW3ub7C7eQt89qLnhOx8bzQ1SEgUmxmkG2Kb5lzaxOZXbmLgZnbw6Xmf3XYKYmhdFVxMc4l4KbCcn0J+lif83XucJTUypedjrIME1YIdWje3nU+Ns0DIjSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvjQP35u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50776C2BD10;
	Thu,  6 Jun 2024 16:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717691035;
	bh=OfyrndzLBxJXPZARRdFKfxdMEQKUjt4NmFCK9jKy3kE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MvjQP35uNLlZFu2pDuJZxY8IqFVlqjuBpv/6fAkRG0fzQNiPGsbVEwD1bOp1n6LuV
	 s2WsaGBcPt9duPaUy6QfHRD8FPOoByAy41iVkERZ8ffAY9+PX6p/iuNFmyaceAhoQy
	 lp5zgPzFLZXZ3HI2tW3/5DsR1nyvh7tQ8hdXkhFf2Unw3eGuidx+51pi1QJX2Ff8wI
	 AkRwZZsB2wDItHkXzz1H1Hnl7ILIARNfVwvb52hegaEf7Fl9Islfu4mbL/RbyKt4Me
	 5/j7U4j0AHDlELmgeUMwae1nWfB/YcE5GhXarsgmpL8TuDZ4gQX7s5gtlfdK4HLWyn
	 dbhXyh21hLRXQ==
Date: Thu, 6 Jun 2024 09:23:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>, Gal Pressman <gal@nvidia.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 nalramli@fastly.com, Carolina Jubran <cjubran@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
 Naveen Mamindlapalli <naveenm@marvell.com>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Subject: Re: [RFC net-next v4 0/2] mlx5: Add netdev-genl queue stats
Message-ID: <20240606092353.31908bc1@kernel.org>
In-Reply-To: <20240604004629.299699-1-jdamato@fastly.com>
References: <20240604004629.299699-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Jun 2024 00:46:24 +0000 Joe Damato wrote:
> Significant rewrite from v3 and hopefully getting closer to correctly
> exporting per queue stats from mlx5. Please see changelog below for
> detailed changes, especially regarding PTP stats.
> 
> Note that my NIC does not seem to support PTP and I couldn't get the
> mlnx-tools mlnx_qos script to work, so I was only able to test the
> following cases:
> 
> - device up at booot
> - adjusting queue counts
> - device down (e.g. ip link set dev eth4 down)
> 
> Please see the commit message of patch 2/2 for more details on output
> and test cases.

nvidia, please review this

It's less than 200 lines of code, and every time Joe posts a new
version he has to wait a week to get feedback.

