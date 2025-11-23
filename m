Return-Path: <linux-rdma+bounces-14701-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1B2C7DE67
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 09:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42EB53A2202
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 08:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5B3273D66;
	Sun, 23 Nov 2025 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EB2NdVRM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C121A449
	for <linux-rdma@vger.kernel.org>; Sun, 23 Nov 2025 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763887309; cv=none; b=Iol/dlh3cfnVVYqxwuyXel/eoSVg2eCAYr3NyMEDWcOyIfSACMHBmbbXqlPaJJ/JmnNFX0C0UhArDZC29ZShNFQ+u5KENR5ieIcVfoL6pb/SIhl/4wETcjvYsUJHN608h+G4/Nh1TmTU0+Nvsvl/muPtInkdoGo8NRMHSL5J2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763887309; c=relaxed/simple;
	bh=SkXz8I7iJPH5QUPATHU8eyHil3y0ywT7GLwkhnbJT4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzQU6l2+osRCSCyNVECWT8JP7TVT2aX9qk2pUAPZCBNuOe+pwtkRO6kJU9QpcQIEUWalJKTt7hNeLs8qSXgonxT/B+xKT4BZFlsQT4n5zuN5iqA0TvYOVNWJdjiLlpoGyuWl0LLW9fzk8CNoYmZcLEyilo0pL79GJSqM1dX0eN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EB2NdVRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B856C113D0;
	Sun, 23 Nov 2025 08:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763887308;
	bh=SkXz8I7iJPH5QUPATHU8eyHil3y0ywT7GLwkhnbJT4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EB2NdVRMYXbHIgmC6+uqJWSsV7CQvRaYbw2yXIOU+JFbIsD8hkd7t3waZWQ6Tc8pY
	 ZSPg8J1rRNtL65VzjuAqNuI+4TC6ViTGviLTmTZrOxo2F5Pf9+zQQwHSpUo4VD7fYl
	 LaKMaPhXlsXsK8LmzoOkdXLgtrfNocZvOQEKXvdXnDGpZ3gvTmbbMLZhxDu0IFYne7
	 nYS0k1IieEEFGZB1bVWs8BViCnO7clNGhywohstMfhAWy1rKM2YV3qyOsK2hp4fwHT
	 VfdRn2zYMnxr5z8jaknjqJwt7uWsJgDehrTmXik0rzXHTbszZCRYoPSBj4cwoqbXEp
	 x49whiPj0vqKg==
Date: Sun, 23 Nov 2025 10:41:44 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, krzysztof.czurylo@intel.com
Subject: Re: [PATCH] RDMA/irdma: Fix data race in irdma_sc_ccq_arm
Message-ID: <20251123084144.GA16619@unreal>
References: <20251117210756.723-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117210756.723-1-tatyana.e.nikolova@intel.com>

On Mon, Nov 17, 2025 at 03:07:49PM -0600, Tatyana Nikolova wrote:
> From: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
> 
> - Adds a lock around irdma_sc_ccq_arm body to prevent inter-thread
>   data race.
> 
> - Fixes data race in irdma_sc_ccq_arm() reported by KCSAN:
> 
> BUG: KCSAN: data-race in irdma_sc_ccq_arm [irdma] / irdma_sc_ccq_arm [irdma]
> 
> read to 0xffff9d51b4034220 of 8 bytes by task 255 on cpu 11:
>  irdma_sc_ccq_arm+0x36/0xd0 [irdma]
>  irdma_cqp_ce_handler+0x300/0x310 [irdma]
>  cqp_compl_worker+0x2a/0x40 [irdma]
>  process_one_work+0x402/0x7e0
>  worker_thread+0xb3/0x6d0
>  kthread+0x178/0x1a0
>  ret_from_fork+0x2c/0x50
> 
> write to 0xffff9d51b4034220 of 8 bytes by task 89 on cpu 3:
>  irdma_sc_ccq_arm+0x7e/0xd0 [irdma]
>  irdma_cqp_ce_handler+0x300/0x310 [irdma]
>  irdma_wait_event+0xd4/0x3e0 [irdma]
>  irdma_handle_cqp_op+0xa5/0x220 [irdma]
>  irdma_hw_flush_wqes+0xb1/0x300 [irdma]
>  irdma_flush_wqes+0x22e/0x3a0 [irdma]
>  irdma_cm_disconn_true+0x4c7/0x5d0 [irdma]
>  irdma_disconnect_worker+0x35/0x50 [irdma]
>  process_one_work+0x402/0x7e0
>  worker_thread+0xb3/0x6d0
>  kthread+0x178/0x1a0
>  ret_from_fork+0x2c/0x50
> 
> value changed: 0x0000000000024000 -> 0x0000000000034000
> 
> Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> ---
>  drivers/infiniband/hw/irdma/ctrl.c | 3 +++
>  1 file changed, 3 insertions(+)

Please add Fixes line to all these patches and send them as a series and
not as standalone patches with reply-to to some random patch as it is now.

Thanks

