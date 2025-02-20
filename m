Return-Path: <linux-rdma+bounces-7890-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA284A3D984
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 13:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790AD3BC786
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 12:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C731F472E;
	Thu, 20 Feb 2025 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MakxyYfT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093611F150B;
	Thu, 20 Feb 2025 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053281; cv=none; b=pIpKYK1AbzchkF1ZXow+yeG1NarmEJGUCJIHSPWPJ4uj9EwXfCr7IxmWUH+k2Bs6QtdIsnQB1WBu7gAV3zmQsCQlBRdKvI2z/GxznqhobWEqSy3Zh1i/txGuBPsN2DL0/fqyCCBiJlwNFDlavaCOXqjgPncWqYc55LWHMRhbOhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053281; c=relaxed/simple;
	bh=9HcC0esz/V2Cjf8y6+3DBCrJDA/xx71PfPOHMhe2QY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0euuW9krex5Q8A89VgEBBDK/4KUAIDryOXrYNt8aNor8KLPfqvXVV3nx7TAaqJXxHVbp1A95q1RGRvuQ7DkkgTkn4OsBDR98ZeBiQd9IGSj0nmIrgntUEX4k2obZMao8dKIOKcLUHSarLncXrHz9YcTySPp7ZUDiFfETvPYXdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MakxyYfT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EAFC4CED1;
	Thu, 20 Feb 2025 12:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740053280;
	bh=9HcC0esz/V2Cjf8y6+3DBCrJDA/xx71PfPOHMhe2QY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MakxyYfTR1Og50oDtWPfvUVbmUkr+jGFF0oPFn+rNmO3Mppx/rW0pTIWfIr2iz5gi
	 ptNLfvzVXqDxJWeg0w0I6LqiGvu+HlEKu278leZcCHSuxm12heSNc9H4b/83E6l28m
	 hYoCFB51DOR12Z6S0Yz0oYgmkZAU7psBmq3ucsE+I9rngZd0301sUCyDiuxLOav50Z
	 GSOXNurrnnc7aScKnsHpFmqN+YWlxpltK13QJ+ySMPQ+FI2fjyxmMuAS6r0W3GwhC+
	 IDIbizkX290MxMNOiJqEYGhIozAfSIrTXakKnOJoRYsiQjl4B9UrK/6vU16ejf4LL4
	 +GVkgo1vsnwrw==
Date: Thu, 20 Feb 2025 14:07:54 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: Use secs_to_jiffies() instead of
 msecs_to_jiffies()
Message-ID: <20250220120754.GQ53094@unreal>
References: <20250219205012.28249-2-thorsten.blum@linux.dev>
 <48456fc0-7832-4df1-8177-4346f74d3ccc@intel.com>
 <20250220071327.GL53094@unreal>
 <9694B455-87B0-4A70-93C0-93FE77E3CD17@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9694B455-87B0-4A70-93C0-93FE77E3CD17@linux.dev>

On Thu, Feb 20, 2025 at 12:08:07PM +0100, Thorsten Blum wrote:
> On 20. Feb 2025, at 08:13, Leon Romanovsky wrote:
> > On Wed, Feb 19, 2025 at 03:45:02PM -0800, Jacob Keller wrote:
> >> On 2/19/2025 12:49 PM, Thorsten Blum wrote:
> >>> Use secs_to_jiffies() and simplify the code.
> >>> 
> >>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> >> 
> >> nit: this is a cleanup which should have the net-next prefix applied,
> >> since this doesn't fix any user visible behavior.
> >> 
> >> Otherwise, seems like an ok change.
> > 
> > IMHO, completely useless change for old code. I can see a value in new
> > secs_to_jiffies() function for new code, but not for old code. I want
> > to believe that people who write kernel patches aware that 1000 msec
> > equal to 1 sec.
> 
> Using secs_to_jiffies() is shorter and requires less cognitive load to
> read imo. Plus, it now fits within the preferred 80 columns limit.

Unfortunately, I see this change as a churn and not an improvement.

> 
> This "old code" was added in d74ee6e197a2c ("net/mlx5: HWS, set timeout
> on polling for completion") in January 2025.

I got same conversion patches for RDMA.
https://lore.kernel.org/all/20250219-rdma-secs-to-jiffies-v1-0-b506746561a9@linux.microsoft.com

Thanks

> 
> Thanks,
> Thorsten
> 

