Return-Path: <linux-rdma+bounces-13518-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 715D9B8AA64
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 18:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B23756609F
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 16:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ADE31FEDB;
	Fri, 19 Sep 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3bgr892"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66535319601;
	Fri, 19 Sep 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300884; cv=none; b=hfuI/HT10PRrCRMftAITxHo3moRVLS1xfzD4DoMEgzuNkYWK6Dh+oAXXxQ2heFv0rkNoXVloU68kmRN7Zkm5OLIiB1PnGWBxgSPM/9H/eFxRH5tzrAuC7N7UG1gLwR0ta39mqYLmFTVPmKGvck6iniUJltL43KsrOiZ5xK0IQBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300884; c=relaxed/simple;
	bh=NZu0V+WzD5N8m0SVaI1EL9lbDRhIMMw5OUDb/otoK1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhxtsKC6KG0s+2pRpGofZl8ejYYkOK8SjRHegGJ9cMQ7GkALFYdSgmDDFCa3m5rLQWBIc8ZFkkpR8+MEX1Ic9e38oSWU1R6Ml8xzU4v81u1HA3U5qDDwl1/8UlqIQHHSD7VNqQfZYe3llpSRmPA2gpxfhIV+Y13qqAFaWZ04glQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3bgr892; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC430C4CEF7;
	Fri, 19 Sep 2025 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758300884;
	bh=NZu0V+WzD5N8m0SVaI1EL9lbDRhIMMw5OUDb/otoK1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3bgr892RrzxJ5WoKTjd1JfSCJE9KwluV/MOD7kt7TvFEv18k+ldcL84ehHnA7odE
	 HaWuQaYt3DssBQ7S08c8BRabe68Q4BfWmDwwTcBegvru694XVdXgxThV27MGxGUYNU
	 nUcfXj/kwsHnYFDIjxo1xZTGqSPUgB5bhhumvMv6OdBZbnR+LpXqQFIaEIJM8puH2G
	 8uXMtZ8/gOw1L4K+0ATQHQlVELlg7Q23FExHdhRN+05k+KWH68ZFQubO+p3FULj+P0
	 i1Ed4SEeERoN6+ZVgtMoHs0ZTuptCQ6m6uoKyWX2R7/AlwscIDhG67diTgNtiGIH5Q
	 CgzhmruGwYB/w==
Date: Fri, 19 Sep 2025 17:54:38 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, cocci@inria.fr,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR() to %pe
 candidates
Message-ID: <20250919165438.GB589507@horms.kernel.org>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
 <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758192227-701925-2-git-send-email-tariqt@nvidia.com>

On Thu, Sep 18, 2025 at 01:43:46PM +0300, Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> Add a new Coccinelle script to identify places where PTR_ERR() is used
> in print functions and suggest using the %pe format specifier instead.
> 
> For printing error pointers (i.e., a pointer for which IS_ERR() is true)
> %pe will print a symbolic error name (e.g,. -EINVAL), opposed to the raw
> errno (e.g,. -22) produced by PTR_ERR().
> It also makes the code cleaner by saving a redundant call to PTR_ERR().
> 
> The script supports context, report, and org modes.
> 
> Example transformation:
>     printk("Error: %ld\n", PTR_ERR(ptr));  // Before
>     printk("Error: %pe\n", ptr);          // After
> 
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Alexei Lazar <alazar@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Thanks, having this check seems very nice to me.

Reviewed-by: Simon Horman <horms@kernel.org>

