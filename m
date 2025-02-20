Return-Path: <linux-rdma+bounces-7881-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBABA3D1F2
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 08:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC9F3BEC9B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 07:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DD91E9B17;
	Thu, 20 Feb 2025 07:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0RDmPNm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F81E5706;
	Thu, 20 Feb 2025 07:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035612; cv=none; b=sH6U9kw4zFFNYZ1z6HqFCSGJMecAmJW8nX8Pn9pajq1/m66HfB/x4tpVhgropL64uEmhyw1xDnwsyffVI2c7K72111M1gt6GNwkiE42HfSeUt7NNidkC6Y5QrRB4FTuEJ0eba887fJZwkMgU+d+ctyW3eyp8vJkd4DuJcpEbkk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035612; c=relaxed/simple;
	bh=NJfF3RldpU6EfpbkIgVaUKT+pv+bmT/fqh7Oz4BAW8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DElQV0Bl1QH3vxA76WGPqLC857QPk/m3dWksHupH8Nr7CM4+V1ImfuMLsIVIVleDjddwt9d0m9kxsHnERg6vmYAYtMjDyUQsNwn4KfbelV20iJxKaRWjQDbQl3jmQpDUSz05mclJ1RG9CU3fKjriv1JBhG24q/04/rCfcpK6k4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0RDmPNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D9DC4CED1;
	Thu, 20 Feb 2025 07:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740035612;
	bh=NJfF3RldpU6EfpbkIgVaUKT+pv+bmT/fqh7Oz4BAW8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0RDmPNmOPtc6mzFwI6sIPnyZAjW39fdIXlhQR5D5zAzK2RCAIkCsqQW0cCqI9WxJ
	 FRBzlRzIw54YFiDOy3sMwDQVQ9cR6VGIxtLUUjGnd2do5xN1UjW8smBNML+5BcjASw
	 57/kDKD2w0cPHWOnFvUEHfl07A+AZL2TuoSqCCOCCEFb6dqrlgUeV0d69FIYiGxgjo
	 BY+KlKAlWc0X6nBjiXrbQGuX8DEujGW+Cdf3unMsg7CftV3SO1YLoqX+42INIfLPSW
	 R5UpQjImof94TTkYwb3xRO2dcY333ePcgajrniutKQsh5+i9Cx6rG51wO2A9jQzM8d
	 RpLcYpfFYDdeQ==
Date: Thu, 20 Feb 2025 09:13:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
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
Message-ID: <20250220071327.GL53094@unreal>
References: <20250219205012.28249-2-thorsten.blum@linux.dev>
 <48456fc0-7832-4df1-8177-4346f74d3ccc@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48456fc0-7832-4df1-8177-4346f74d3ccc@intel.com>

On Wed, Feb 19, 2025 at 03:45:02PM -0800, Jacob Keller wrote:
> 
> 
> On 2/19/2025 12:49 PM, Thorsten Blum wrote:
> > Use secs_to_jiffies() and simplify the code.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> nit: this is a cleanup which should have the net-next prefix applied,
> since this doesn't fix any user visible behavior.
> 
> Otherwise, seems like an ok change.

IMHO, completely useless change for old code. I can see a value in new
secs_to_jiffies() function for new code, but not for old code. I want
to believe that people who write kernel patches aware that 1000 msec
equal to 1 sec.

Thanks

