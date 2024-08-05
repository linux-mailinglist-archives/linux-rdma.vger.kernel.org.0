Return-Path: <linux-rdma+bounces-4201-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CDF947A25
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Aug 2024 13:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7FB1F217B0
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Aug 2024 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1663B15442A;
	Mon,  5 Aug 2024 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vx5WWr4v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C780B14E2FA;
	Mon,  5 Aug 2024 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855641; cv=none; b=AgGPx9oizinKJbTCUMl/q3D5Pmj8a8Mlq4QLAd28U6cZZhuptJrqr1tgFzVoeoPliV594mGlmfXMJAosPAxr6lXUldzqj7JY/rxPGSQDFixj7Z7Zi1YloXzCM7r8/AdwJFRpPeJfkvwosaEC56FTB1ldo6JMqp8iIuH1ixdHrHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855641; c=relaxed/simple;
	bh=b1HhvNY6LExrW0GLKv1PZKW87lNsBkAdCdMjHR1r99w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B3AGFOZzQDczC2TQSoXw1JIHZRl2GkoDvvzgZ0lGLEBVhVNDoJTAn+JH5+8z2FdA3DWkkW/T1qxKLqaWp604DrqcoQIGL1LRPTTd3Ze3VHO+qVHihoSYLhD4MGZUaWH4CxSdiap2b0ijm9mPDMo3zucrq5ZzTpzdJCdJfte+zu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vx5WWr4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E0DC32782;
	Mon,  5 Aug 2024 11:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722855641;
	bh=b1HhvNY6LExrW0GLKv1PZKW87lNsBkAdCdMjHR1r99w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Vx5WWr4vvPWj0OgPu+qcYZzljEXeAKB8MG+6Etjg6C4j6kvyhnHolmle7/4fuIxQy
	 sn5ZWCUyYQaSPLx2cD2A+9dBw2wWGuS0jdW+EULTogjEe3phPCBoW7SyiQ+V/kinjJ
	 cocm+rNZhjCfLF9ck8t6pdJ34ZM0Pmo6P/SvseqoH0/t8nIU86Bop5j1fqLX0+B+PG
	 G4HSLIpia4v21T8pL2+4XVm5knZ1OQMWdnuFSnA531h/xfZn0ew3V5AEtJHHW5gtkb
	 x5E86cz1s38gY70vrQaiza4/m+3RGHVPKHGdd4joC5gwByu+Tep1sIQ+og+lWJrYb3
	 PtVkV6MFduFbQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240726071910.626802-1-huangjunxian6@hisilicon.com>
References: <20240726071910.626802-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-next 0/3] RDMA: Provide an API for drivers to
 disassociate mmap pages
Message-Id: <172285563690.428749.9415541768231694130.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 14:00:36 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 26 Jul 2024 15:19:07 +0800, Junxian Huang wrote:
> Provide an API rdma_user_mmap_disassociate() for drivers to disassociate
> mmap pages. Use this API in hns to prevent userspace from ringing doorbell
> when HW is reset.
> 
> Chengchang Tang (3):
>   RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap
>     pages
>   RDMA/hns: Link all uctx to uctx_list on a device
>   RDMA/hns: Disassociate mmap pages for all uctx when HW is being reset
> 
> [...]

Applied, thanks!

[1/3] RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap pages
      https://git.kernel.org/rdma/rdma/c/29df39ce0a64f0
[2/3] RDMA/hns: Link all uctx to uctx_list on a device
      https://git.kernel.org/rdma/rdma/c/bb5b2b25624fa9
[3/3] RDMA/hns: Disassociate mmap pages for all uctx when HW is being reset
      https://git.kernel.org/rdma/rdma/c/e60457876e3223

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


