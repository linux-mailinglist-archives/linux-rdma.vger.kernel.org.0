Return-Path: <linux-rdma+bounces-9904-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB765A9FA1C
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Apr 2025 22:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C9C3B1B33
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Apr 2025 20:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73511293B70;
	Mon, 28 Apr 2025 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvheEwLV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ACE296D28;
	Mon, 28 Apr 2025 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745870563; cv=none; b=qQA1r7EPkRkrBrlr+XjlBheSvEADbE6zbGPNrFL2XaSAM2y1ZcPfTtn2Jb3lQ4KqgwmeOeAsxT03m9PbYer4P1pUxNYp4K4Slbas+ZZLQbBfwtpFdv5arxbyJPs481hLrNhBi8cEzjhpMqibrB7+dTuMdJKMZVKWJXxaDXCl+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745870563; c=relaxed/simple;
	bh=sPOKmHpYLj3q6unUZiWkI91AaSj64FZDZIrt2rWwoGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2ATGoOvmCV+4ygLySCl6p2g/VbTB0zAn3lgbcC6xrlNb6WDRpUzY7SABqFRMli7awsSnDrJGroidqddX8NlwFPzYOqRwdto1XAifrv+eK0NWW8PTlBc+7NAa7tP4CI2v+KSUTalb50S+q9nxzLgbcpM7j3Lguev2k5XRaYGUOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvheEwLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F2BC4CEE4;
	Mon, 28 Apr 2025 20:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745870561;
	bh=sPOKmHpYLj3q6unUZiWkI91AaSj64FZDZIrt2rWwoGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvheEwLVCj4UsyUHZoyLPmAQH2QqmaO3bpIgaUJ8D25Tl1yF+IGiM8UUzq9fORaMC
	 8G6dRgT2FZFzhh62mt6BqcBHY2EdI/3msjDZKUTf7OFg3Z17ygMfiUCWupnsih0UN/
	 lV2FS8nX/5pDqXAfbFKPLYlYxE44KpAOXJRWTHD9eGqMBFLsy7tKWHHVtGDLx4BUOE
	 WdZXtDB1DgsoXUt9ZlSPrFYtG61C1oMX6esyJkVRnFEzvquSM0USl8h1vxWKyPGE8C
	 iUHoxmIYvgRF48WTocMSqqDazDnK810nNNVxJszWO1rEoVQkSmbRNXeayo8HCVrjz8
	 ZjEsUpngVSWgA==
Date: Mon, 28 Apr 2025 21:02:37 +0100
From: Simon Horman <horms@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net/mlx4_core: Adjust allocation type for buddy->bits
Message-ID: <20250428200237.GM3339421@horms.kernel.org>
References: <20250426060757.work.865-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426060757.work.865-kees@kernel.org>

On Fri, Apr 25, 2025 at 11:07:58PM -0700, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "unsigned long **", but the returned type will be
> "long **". These are the same size allocation (pointer size) but the
> types do not match. Adjust the allocation type to match the assignment.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


