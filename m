Return-Path: <linux-rdma+bounces-12696-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252D9B24728
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 12:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F4D56431C
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F572F28FE;
	Wed, 13 Aug 2025 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp9zN49n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEBB2F1FFF
	for <linux-rdma@vger.kernel.org>; Wed, 13 Aug 2025 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755080846; cv=none; b=lvn+ZobO3eMX+oit8T3IBYw1XyIU0x8xEUB2mVTCV3gYgkiwZCuq+5GeIS4AKDNHJsOAbzhWj9OiX2utqP8vpIOHZVYmlRZjqOwdRApy92E4JQc9go1W4jdmtzqOyemblYkDO5rG1I1k4Dffs3A8hk2hj8p42mvXvE890xoUQBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755080846; c=relaxed/simple;
	bh=gbZGu54MeVMRcfFuSBA/Qvv0KCVqQXeh8r0836yWE4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=im6/pxnu101kRV47UX4bYXG0ymzwE9aXU33Ro7oMwD0oXwBXEZD4nwsn6yZQpRENEbVqG/ky7fHt8xz7wnHChyyJwMXqxiqYZhsDuP+dtPzZD+OEFvhHDTmGDLTyh9pxEWEtV/8B20rqu+XF6PLqwZmI9GZHgLg6UN2AgxXgcqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp9zN49n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05114C4CEEB;
	Wed, 13 Aug 2025 10:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755080846;
	bh=gbZGu54MeVMRcfFuSBA/Qvv0KCVqQXeh8r0836yWE4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pp9zN49nD2LHTLL8gnkowZB/dnXF4A2boGz6XQHVY9xpeEUsJKQZfdGM507JtBdJc
	 tmZfi2GHy/n1r+spkZc6aqz0h1DAVrwyk6ij3v329hCrdrNvv88RIwxsNAeccl5sLN
	 ZQ5jtQsAG1eVpcDmXFO0PrBfKvONviyu/498dpDQmqdTVBR/t3f33HoR1Z7RDpvOV9
	 /5ps2W4d2wjXflheSMxBo3+XCqqT0nWJvuvax82B8Ji6bMW0146CQv4cyr/P2kb0WU
	 czXRr4GCXdmNv32gJjwTJeTxIV0fWyZ7ogUQpnBDEQ+5H8QbgV7jJ7M9qEwaDE2Dai
	 N0Ii9fppd2McA==
Date: Wed, 13 Aug 2025 13:27:22 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Boshi Yu <boshiyu@linux.alibaba.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: Re: [PATCH for-next 0/3] RDMA/erdma: Misc fixes for the erdma driver
Message-ID: <20250813102722.GA310013@unreal>
References: <20250725055410.67520-1-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725055410.67520-1-boshiyu@linux.alibaba.com>

On Fri, Jul 25, 2025 at 01:53:53PM +0800, Boshi Yu wrote:
> Hi,
> 
> This series of patches provides several fixes for the erdma driver:
> - #1 uses dma_map_page to map the scatter MTT buffer page by page to avoid
>      merging contiguous physical pages.
> - #2 fixes ignored return value of init_kernel_qp.
> - #3 fixes unset QPN of GSI QP.
> 
> Thanks,
> Boshi Yu
> 
> Boshi Yu (3):
>   RDMA/erdma: Use dma_map_page to map scatter MTT buffer

Applied to for-next.

>   RDMA/erdma: Fix ignored return value of init_kernel_qp
>   RDMA/erdma: Fix unset QPN of GSI QP

Applied to for-rc.

Thanks

