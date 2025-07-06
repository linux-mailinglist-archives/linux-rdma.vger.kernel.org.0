Return-Path: <linux-rdma+bounces-11906-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3E2AFA361
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Jul 2025 09:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 796587ACDC0
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Jul 2025 07:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02501C84A2;
	Sun,  6 Jul 2025 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udIfjXdV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613CF1A76D0
	for <linux-rdma@vger.kernel.org>; Sun,  6 Jul 2025 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751785585; cv=none; b=hKSJ7ofJElliNXd2QBmnDMElgoDeA3i8wG9GWqMNl5P597nrLnET+7ENEKBMh3ZSSvCFEKwjqlfJPXe7TbCk6gSLrCcd8+OK3drm9IEoiQ4b8HEohAiv4UA2oOJR1YKA03BSY4qA1vXF5+PQWa5TKCrw8QeNOe3clcImPJtPkgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751785585; c=relaxed/simple;
	bh=p6sx0AOaS4nj1vpTbgDWgYhpyb4hf8nxaeNAJc2RhRs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iJEimbO/1Wk9riHaEMjS1B5kEqPgeANRTNMFgxMFmMBP/HUxHjnt+MIHHmij00akdoZwT3PeDZF14wAomTbDGTnLMcK0aLa2p3SGBb3TaOmvINot7rlHx3nUfh8muF0y7R5bNGOLGNI9FdjcwNu1RP2r/RVx7EPxTUV5b0kLqxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udIfjXdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26532C4CEED;
	Sun,  6 Jul 2025 07:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751785584;
	bh=p6sx0AOaS4nj1vpTbgDWgYhpyb4hf8nxaeNAJc2RhRs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=udIfjXdVEWj5FHnfD02uLkZULBaAGfNkz1oW5DjshDd8xBWF4LeqMGR4EpRK11GsF
	 1fokfuc985Rz05cWB80iB7BWm5YIgaU1w95oEWcVeq56fQAOUfk0Bw3Iw1KiHxAV/e
	 xqoLnZc1rbjystb2Uv7otUfFqa5xxIta10Vi7czJFbsAGrrmsTsuDuGDa8OOXVknpx
	 GCJSKPMlyi6UjETWTLPgWXJ8x0FasOXhhFf7UWQ65IKn95V2iFZUFb8a8+DvHwHV8d
	 dP8G+g6X62cwuDpExqhOUOAbS7/d9tOC65VOBwZ93nmGGxLizj9lUsCA+zmGE4+2OR
	 S6T+VQMQukYxQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 tangchengchang@huawei.com
In-Reply-To: <20250703113905.3597124-1-huangjunxian6@hisilicon.com>
References: <20250703113905.3597124-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-rc 0/6] RDMA/hns: Bugfixes and improvements
Message-Id: <175178558100.896983.17952936665565478982.b4-ty@kernel.org>
Date: Sun, 06 Jul 2025 03:06:21 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 03 Jul 2025 19:38:59 +0800, Junxian Huang wrote:
> Here are some recent bugfixes and improvements for hns.
> 
> Junxian Huang (4):
>   RDMA/hns: Get message length of ack_req from FW
>   RDMA/hns: Fix accessing uninitialized resources
>   RDMA/hns: Drop GFP_NOWARN
>   RDMA/hns: Fix -Wframe-larger-than issue
> 
> [...]

Applied, thanks!

[1/6] RDMA/hns: Fix double destruction of rsv_qp
      https://git.kernel.org/rdma/rdma/c/c6957b95ecc5b6
[2/6] RDMA/hns: Fix HW configurations not cleared in error flow
      https://git.kernel.org/rdma/rdma/c/998b41cb20b02c
[3/6] RDMA/hns: Get message length of ack_req from FW
      https://git.kernel.org/rdma/rdma/c/6cbf3ee2e409ca
[4/6] RDMA/hns: Fix accessing uninitialized resources
      https://git.kernel.org/rdma/rdma/c/5fee9b74c7e895
[5/6] RDMA/hns: Drop GFP_NOWARN
      https://git.kernel.org/rdma/rdma/c/3176ce02c32119
[6/6] RDMA/hns: Fix -Wframe-larger-than issue
      https://git.kernel.org/rdma/rdma/c/e040e5e2625c1a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


