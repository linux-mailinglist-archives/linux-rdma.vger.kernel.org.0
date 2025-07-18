Return-Path: <linux-rdma+bounces-12306-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3843EB0A5B2
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 15:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9730A46C2F
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 13:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4892DAFCC;
	Fri, 18 Jul 2025 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oELb7qDn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54352D97A0;
	Fri, 18 Jul 2025 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752847137; cv=none; b=GpQS/cFgv+O4XiHlw2lHR0+qR4onJ88DyGYDEAvckbSGLL+erltloTQiVhamPcpvCUXNZxtxOujmwjD9koBGB4wTSIT2+Y9bajxQRyP4h2J/bbpzzW3GreB6qCi8demYqijdpMIuAO3b9i88/OKK7MnSyOAK2v/NtBQb0ZLSmWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752847137; c=relaxed/simple;
	bh=ejALsTYqcC3Oq7etIoGhF93z4H2r8FDbc6/F65/dGj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5kRfw6pwPy3xPoIneDslWoCvmJfF4LKXhQ3KA5n4/9oeA2Arin04+gyTRyR08krG9lSXiYShvIPA7db0NOqAUS/rR82zKVX5xxi5qKmHB/jHnYaAN9MRbFNf+D/J4nDJVFAv7nhneuXt1nGmr/Met5mA9/+E8nO8//4SF6YEQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oELb7qDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B171C4CEEB;
	Fri, 18 Jul 2025 13:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752847137;
	bh=ejALsTYqcC3Oq7etIoGhF93z4H2r8FDbc6/F65/dGj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oELb7qDnM6NJZPhFyB1z763l+rezpFZ7jAANf1Fqzk4IhXlTxt1sfftHQrlNfhB12
	 lBz3enqlcr4c3DYlZbCrqKCpDD9Yr8nDCYvwcojOOMgee3BPqCfa86lxsB54hjmL6B
	 40S41jIfu0K78aRbL8OngCxNBPypGcgV6SHp2XZWX65PH9x8Gcjta3h775OGiWP8js
	 uZScCRTgf0KuOMZ2VmRIYPOSG5q4p6tj/oUdxXVuQOMnXZzD6SUO3ezJzg+2QzHpLn
	 z8TFV8dP8mYfWWsj8pYDWk5K9Jgz2njtt3v1KHphoJ/AiPPaetLUupDxm6+1mQmhIM
	 NFLjU9rM/05hA==
Date: Fri, 18 Jul 2025 14:58:51 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: Re: [PATCH net 1/2] net/mlx5: Fix memory leak in cmd_exec()
Message-ID: <20250718135851.GA2459@horms.kernel.org>
References: <1752753970-261832-1-git-send-email-tariqt@nvidia.com>
 <1752753970-261832-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752753970-261832-2-git-send-email-tariqt@nvidia.com>

On Thu, Jul 17, 2025 at 03:06:09PM +0300, Tariq Toukan wrote:
> From: Chiara Meiohas <cmeiohas@nvidia.com>
> 
> If cmd_exec() is called with callback and mlx5_cmd_invoke() returns an
> error, resources allocated in cmd_exec() will not be freed.
> 
> Fix the code to release the resources if mlx5_cmd_invoke() returns an
> error.
> 
> Fixes: f086470122d5 ("net/mlx5: cmdif, Return value improvements")
> Reported-by: Alex Tereshkin <atereshkin@nvidia.com>
> Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


