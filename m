Return-Path: <linux-rdma+bounces-11241-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B850AAD6A0A
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 10:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 590787A23CF
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 08:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCB6220F51;
	Thu, 12 Jun 2025 08:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s40N/Rfq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292C921B8F8;
	Thu, 12 Jun 2025 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749715959; cv=none; b=KdQWPbEUAtxTOSUIoWgwhs9k9C1JH0p23Fs7Rj38FnheFyeS351V70pHqe9VXTON2o8YHE/crsFgHbt7tgcuJXXiKUqx5VMeZTHrD8Pc3oNOgEWEWBJXzYsIivwg4rl9e2dQ072Ee+URnpl1WFL3FB07JpnW19nKp3Ni30NzPJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749715959; c=relaxed/simple;
	bh=og6MGYj8SAOK1ijRemfH4oo2vU3F01Nt5qZ30o+z09c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7sOsDalHjROlA7U+8vbxj1W7DQpX2FQX20iR9wgH1luW/hJlGJ80mK/jQaX/DbnA/M91/JSdFneXrTFU6L6sS+pIeAkfzOgEoaeLqq7CfhhTIJsM0q1URaIPVpqLtgL5s886OqTXaxW+Z6KHDPRoWhGT7Kb5AL/w8vV7e4Zwr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s40N/Rfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8BCC4CEEA;
	Thu, 12 Jun 2025 08:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749715955;
	bh=og6MGYj8SAOK1ijRemfH4oo2vU3F01Nt5qZ30o+z09c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s40N/RfqsHHEhYBC1KRtuoUo+wVWJ4md/UGfgjR9amUs37f7I3U1XByCb3OCcLy3I
	 v++49VzgqJCFmO+hq5/a8I6PxcyDW9itvqEXyXcWB3UbKzmSh2ZS4K8t2QBEn6UWxY
	 n85rDeN8p/vqXjEnnPzuUsG+0BTG7lDYpdwc1J9XkrJzjs/wCqxiQHB0UVq0SWBJyX
	 lq2HZl7x/ImsMK3qC9u7phy1m2nVhZLpAhPyXYIuxwMC7PBM5yO3fYji8R4J0G8Wrv
	 MNAwySbaJxtqo2WWx/CxV3PmVjjTTJ9vY9M+mBa3PL797jOA3UmnBb0qSwimNiiG8/
	 11iQo0hE3ZpbQ==
Date: Thu, 12 Jun 2025 11:12:29 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yury Norov <yury.norov@gmail.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] RDMA: hfi1: cpumasks usage fixes
Message-ID: <20250612081229.GQ10669@unreal>
References: <20250604193947.11834-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604193947.11834-1-yury.norov@gmail.com>

On Wed, Jun 04, 2025 at 03:39:36PM -0400, Yury Norov wrote:
> The driver uses cpumasks API in a non-optimal way; partially because of
> absence of proper functions. Fix this and nearby logic.
> 
> Yury Norov [NVIDIA] (7):
>   cpumask: add cpumask_clear_cpus()
>   RDMA: hfi1: fix possible divide-by-zero in find_hw_thread_mask()
>   RDMA: hfi1: simplify find_hw_thread_mask()
>   RDMA: hfi1: simplify init_real_cpu_mask()
>   RDMA: hfi1: use rounddown in find_hw_thread_mask()
>   RDMA: hfi1: simplify hfi1_get_proc_affinity()
>   RDMI: hfi1: drop cpumask_empty() call in hfi1/affinity.c
> 
>  drivers/infiniband/hw/hfi1/affinity.c | 96 +++++++++++----------------
>  include/linux/cpumask.h               | 12 ++++
>  2 files changed, 49 insertions(+), 59 deletions(-)

Dennis?

> 
> -- 
> 2.43.0
> 

