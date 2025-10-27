Return-Path: <linux-rdma+bounces-14062-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CFAC0D2CF
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 12:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3388B4F38BD
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 11:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA452F9D86;
	Mon, 27 Oct 2025 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krDRom+I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0736B284B37;
	Mon, 27 Oct 2025 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565001; cv=none; b=Q5+PB4ADpgxuTvKB1NIm5AmPNbq8VaT5yxTbW1tjtP62u9xijHkMMJFjFUksDezp9dud7KI/MCuSh8C+AVUQmat84c/jTetguz66KgzGlAkzHXthvhTOxgpIEubj5ZBWAw4GvyVjFyqC350v1WkmFG4aCccdduws4U/wTZjdTG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565001; c=relaxed/simple;
	bh=62tX1iQfBuXvV3RHBzxXODO9efIkWc47J+wuFTI0uX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSEKgIY82I6W1QM2/LLCbgiFya/KSwLwlLn5LKEolPH6sfo/aU4erpiZtRCu8CvNMwvrchwaysSZdFNK+kqLxQWmZuSqjhxEjrDcBF0hGSdV3+zXo3GNB7sbYW1k1FwxC1AADgteHpCPcAP4sHjyEoqwMz2ZGDTEU2XYCLHwS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krDRom+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C9CC4CEFF;
	Mon, 27 Oct 2025 11:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761565000;
	bh=62tX1iQfBuXvV3RHBzxXODO9efIkWc47J+wuFTI0uX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=krDRom+IQ9LhblbTvSeN06bsJYKdh9xZMj8WQFM0URHn0+3RKKBd8HmR7PKeyvPOW
	 ekl3QpNO6wLWYKnRJBpFcmg2NRvKfhYgoSBPZqkaRooHNIg5AD+7quvGDYqUW3ZaLm
	 bxUnRdnMoPUxjUPvz0LOW571sFnyPnLRpKqHaAaaI3O5N3GzWIzTkUjPESP8qgIKoh
	 v209HfCx4rYlX92GYPz4hdsXgYkiwMELZ6p09vGSeK1RLdCfQj+yWM0EHnlJM7rMS7
	 I9LaW7av0G1MlilLaQl9B5L3LxB+4QyzbQTpIPRXTQv48LmqOTk6oXUA1vesDOrE3K
	 99aMXnySkHRdw==
Date: Mon, 27 Oct 2025 13:36:36 +0200
From: Leon Romanovsky <leon@kernel.org>
To: =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Sean Hefty <shefty@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Jacob Moroni <jmoroni@google.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/cm: Base cm_id destruction timeout on CMA
 values
Message-ID: <20251027113636.GI12554@unreal>
References: <20251021132738.4179604-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251021132738.4179604-1-haakon.bugge@oracle.com>

On Tue, Oct 21, 2025 at 03:27:33PM +0200, Håkon Bugge wrote:
> When a GSI MAD packet is sent on the QP, it will potentially be
> retried CMA_MAX_CM_RETRIES times with a timeout value of:
> 
>     4.096usec * 2 ^ CMA_CM_RESPONSE_TIMEOUT
> 
> The above equates to ~64 seconds using the default CMA values.
> 
> The cm_id_priv's refcount will be incremented for this period.
> Therefore, the timeout value waiting for a cm_id destruction must be
> based on the effective timeout of MAD packets.  To provide additional
> leeway, we add 25% to this timeout and use that instead of the
> constant 10 seconds timeout, which may result in false negatives.
> 
> Fixes: 96d9cbe2f2ff ("RDMA/cm: add timeout to cm_destroy_id wait")

I applied and removed this Fixes line. Most likely someone will complain
that this patch breaks his flow.

Thanks

