Return-Path: <linux-rdma+bounces-12593-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D391DB1BCF0
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 01:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFEA1894D32
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 23:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426C72BD5BC;
	Tue,  5 Aug 2025 23:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssgplbCF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD4A2BD588;
	Tue,  5 Aug 2025 23:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754435380; cv=none; b=XoTnq5yrDTrIwbA85NFtPeZMtuiefdQQSRWrPBUIQgrR/Kz/8CLqJTT6KaIDrUbO1lhSteB7f+hCfrnNpuFtiZ1oHVrCDf80vmO/jr9yPNkRz/T3eQXtZcHaAQvb8tLHAzFRbD67dLrsQ0wTNQtXP8dRV3xCREcz0sKLK9F3Bik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754435380; c=relaxed/simple;
	bh=b+4gC3jrvqG+83u5Vh0Kk2KArZaArOezV8zzx5Mi8Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DeFe/hq217zrz5MKS1hXgFwNzFZChpWGB+BEstBmKzCqKs2xsZ8qh0lK5ZdmUpEKoFl8leX7KLNb5hpdd7G9s/JDuypETvG2O9/8FefRq3X2+8SJU6xLaXzLcfbbangW4KrXgPqsgVlW4+nqAnBNGROM2jZn4rLjg6GFKonrH+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssgplbCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2717BC4CEF0;
	Tue,  5 Aug 2025 23:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754435379;
	bh=b+4gC3jrvqG+83u5Vh0Kk2KArZaArOezV8zzx5Mi8Pw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ssgplbCFi6TgjsQZXxa8e5ZrcwMPNsDUh0sVbNcJY/6wIfXMV9HIc9Oyh+CQRgqWW
	 CFn/E7H+vaNflQdu0HuRxDFgItGFd4cEbxzzA858j4GL9PCVqCNjOoHJjQ21V9neYY
	 RrhtlUKVQUstu5nrtT+Xv5pol32pPlj6X65ZBc59Bq6tfIblY9xqIBXdOVy3UdjGdM
	 mVJmoRg4yabba0OeBZ+2DkcAGxSlEee+htvi3KVE1VoIdOPxSuCzp+FeuDB7huV1hZ
	 wRz4RC3J9fKK8yBmc+MO1GnzZnrcccH4WuxicCsRoCdetYCHSiHuRophBGf//hwztb
	 OCK8qK3/8CR1Q==
Date: Tue, 5 Aug 2025 16:09:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eth: mlx4: Fix IS_ERR() vs NULL check bug in
 mlx4_en_create_rx_ring
Message-ID: <20250805160720.0187e36d@kernel.org>
In-Reply-To: <20250805025057.3659898-1-linmq006@gmail.com>
References: <20250805025057.3659898-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Aug 2025 06:50:57 +0400 Miaoqian Lin wrote:
>  	ring->pp = page_pool_create(&pp);
> -	if (!ring->pp)
> +	if (IS_ERR(ring->pp))
>  		goto err_ring;

Thanks for fixing! Looks we previously depended on err being initialized
to -ENOMEM, but since we have an errno now, I think it'd be better to
use it:

	if (IS_ERR(ring->pp)) {
		err = PTR_ERR(ring->pp);
		goto err_ring;
	}

