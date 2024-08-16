Return-Path: <linux-rdma+bounces-4394-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153ED954F53
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 18:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6996284DC8
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35111BF337;
	Fri, 16 Aug 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idmCG3uk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAC31BF319;
	Fri, 16 Aug 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827225; cv=none; b=CqHmwjrOUsKRSXmXS9ippVO67gH7o2pj40hDrQ6vRrYQUTcJahLkQNSix7Lgk5M7ZTBFpyqctG4iVqtEtJ7zxBu2kdIxqsZ3I07qzHf6U9EULFifxNWj0Skckdkwo3ShDRM0zkI+iozIg8oVQ8ForosL0HogI3r8msP9I2mLmAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827225; c=relaxed/simple;
	bh=Y/0iQwQH0/Y8YHNCbm6+NQ5Rj4aBjmt2yA+zFtsPW6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tu+hpZLPuB1QQSJGG6AnNPnqiT0q3igkeUN8RPrIzmk7klK2UHCi123cSMjGtBGGZ+0ylgPnft32LE6/pH5QU+meUcLhB0vDlIwszU/zBZ3XsSyxQ70t0G55IucTOk2Mb9czwZDI3ILVTX9ThfTVXvz3pzjQxzEsOQ2vC1cwZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idmCG3uk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BA1C32782;
	Fri, 16 Aug 2024 16:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723827225;
	bh=Y/0iQwQH0/Y8YHNCbm6+NQ5Rj4aBjmt2yA+zFtsPW6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=idmCG3uktyMu1TOSDjMiedyqw7GU/hdLqj4gNiuzpUWFju9/nYzuf3tEKipEHnwsg
	 M78y2W7EpF2bex7YJo+wIrQ8+3eWxOISX34fOuVrDzbg4hzPyhQThu8SThZ+xqTagQ
	 O18RlQbzhr5wnuJKboEdk2d5dVVqaxZy+6++4I62xwlPwWUwtQZBVHR2XXky4psmh9
	 w/0CqyZgIQ1PFiGXyMU9eHD800rfHwET87hZMI6XajCSCZyCmevP+IO+4kVVdnbniL
	 XkV7CZHpXLjySKQEYZm6Ets5Se0NSZRN2LZPtqe69fsQCLrnoVnVfiRJpSojtfwmRh
	 b4+cce2rf0HWw==
Date: Fri, 16 Aug 2024 17:53:40 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5: E-Switch, Remove unused declarations
Message-ID: <20240816165340.GA632411@kernel.org>
References: <20240816101550.881844-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816101550.881844-1-yuehaibing@huawei.com>

On Fri, Aug 16, 2024 at 06:15:50PM +0800, Yue Haibing wrote:
> These are never implenmented since commit b691b1116e82 ("net/mlx5: Implement
> devlink port function cmds to control ipsec_packet").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

