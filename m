Return-Path: <linux-rdma+bounces-831-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035A7843F77
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 13:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B100C282C7A
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 12:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085D876040;
	Wed, 31 Jan 2024 12:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iR9m3YTM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA7E76C85
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704473; cv=none; b=cN++kSaQ/Cn5qaVB7pCpU03B5yjf65uED32WdwKNingxBQv0hLU1mdwq2W3QzR0ndmQ1NhJzWqWSJ3RVfTaTaEPKQNkSA5JCnHSi+UwGQeSg47f/nC4uGDvvTEWk0H8Nc6nTJuExbTDzygCBLZidqaKbUHTZveBVZc7F4xwv+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704473; c=relaxed/simple;
	bh=x55ae8lQW5AznWWlVzauBbztvw5tQJ4pGYkholRrf28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX/HI02lbb5/XgsllYpP/KgTTYpwaumaKUIOs3Sc7pKBzx7HJrkhqmFDUIkrT2eL2t5+by+PEqDLx/LgnhzlsxleJP4xyZFNxqOLpOyMy6RKroO+PP017ov7djXw7T8tcpmujwbnpsrzf59k1xmfyeP82RHTpv+vD8Rv530xMik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iR9m3YTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14AFC433F1;
	Wed, 31 Jan 2024 12:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706704473;
	bh=x55ae8lQW5AznWWlVzauBbztvw5tQJ4pGYkholRrf28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iR9m3YTMFciPqnKzH89eNkNLZ5ERyGNWGi/pgSiGAu7o0EnPExbi6cpLkr8HoVCbC
	 w3KNX4XeqanbCwof66yy9ucImk0f35F3uqy9UsMDWLh15X5dQC1VNT+yBRrVeFk9Wa
	 tV8b8BLOgjyRmSDTziBJmLuTPXnndcPw2GmfKV+Xt4cH56EIa4dBbub+bZBNFMmNDk
	 sGH+k+9Wi5KctZ2a+R3z4v+KnRcmdW3J0lJQcgFlEgihqcQov6LXH2lcuHq5944+6S
	 rTlkc1tgG1QB+93kCJi//vG0iT8QJrM44rF9lwsDkAUounpPZQH+5hc4iQ5dKld53R
	 ZjcN3IDNonj7w==
Date: Wed, 31 Jan 2024 14:34:28 +0200
From: Leon Romanovsky <leon@kernel.org>
To: ynachum@amazon.com
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Michael Margolin <mrgolin@amazon.com>,
	Yonatan Goldhirsh <ygold@amazon.com>
Subject: Re: [PATCH for-rc v2] RDMA/efa: Limit EQs to available MSI-X vectors
Message-ID: <20240131123428.GE71813@unreal>
References: <20240131093403.18624-1-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131093403.18624-1-ynachum@amazon.com>

On Wed, Jan 31, 2024 at 09:34:03AM +0000, ynachum@amazon.com wrote:
> From: Yonatan Nachum <ynachum@amazon.com>
> 
> When creating EQs we take into consideration the max number of EQs the
> device reported it can support and the number of available CPUs. There
> are situations where the number of EQs the device reported it can
> support and the PCI configuration of MSI-X is different, take it in
> account as well when creating EQs.
> Also request at least 1 MSI-X vector for the management queue and allow
> the kernel to return a number of vectors in a range between 1 and the
> max supported MSI-X vectors according to the PCI config.
> 
> Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> Reviewed-by: Yonatan Goldhirsh <ygold@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa.h      |  1 +
>  drivers/infiniband/hw/efa/efa_main.c | 32 +++++++++++++---------------
>  2 files changed, 16 insertions(+), 17 deletions(-)

I applied this patch to -next, because it lacks Fixes line and previous
version was targeted to -next too.

Please add changelog next time.

Thanks

