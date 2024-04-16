Return-Path: <linux-rdma+bounces-1963-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963BA8A6A3D
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Apr 2024 14:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E221C21031
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Apr 2024 12:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E6E129E89;
	Tue, 16 Apr 2024 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjEep7SE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5381B128361;
	Tue, 16 Apr 2024 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269262; cv=none; b=HH7cQLBPFb2XgPHIB3pv72hpphCGsB4xbcrlAzsQcfotGL3Gfh0fm5U57da/eRHoMJTNOePKROp/oI2vad+HOeV5cmWSladXhh3TxY/QapUuEO0TAtn/ENQEiozaNITMP2E09xmI21zU88/vIs326KqgwOU9wOC4syuSW34RCAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269262; c=relaxed/simple;
	bh=mTtbSE3y2AFlZuPNpXY9EO/ID7LKFrynjflefWyTkpY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kMEKoUxQZm7fomQ+IN8f4jBvOxorumE8A6lbyixdFJPuQ48dT8X0gIIx56UWzoLqioKoyP9DcNnfXn0Zjm5EVwIXx0CHnLLQg5Jv4Rcb+T1jDophNHXK51cYV0wCbAdZHMr1UFCZ5d3KOhO4AIaxd1g+O8mzzNLzijyAvJvYWig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjEep7SE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61359C113CE;
	Tue, 16 Apr 2024 12:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713269261;
	bh=mTtbSE3y2AFlZuPNpXY9EO/ID7LKFrynjflefWyTkpY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CjEep7SE/k98t9aodglbbDPwTdvvYycY0vca549FAGta0UyGYq/L3fTRu71EpEeFD
	 f1w/BnTjU7EIt1BoUTOJYQQrhEZkJrn7dUPBS6QYix7ASRVqtzKo8aUlpyiBBucCa0
	 6DEybW56oJiHQ0u48xH/hnXfdpk3QaGYNJ/3yp7Tji6k6id6IW/obqbKamXg2W11fl
	 ++T9vlAu9TjsB9yQQHDBs9Ic0GezXpIzihkVmJqeHvY52eFwCxwQo+JBx0UzCYIujK
	 d/OmYfDsR86OePS5/Tgb4WCpK7C3Nlu7ec0trV736uPBx4YhAv+3WuoH+Fj1oEHOFs
	 6aBv+1Sl3zCWA==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240412091616.370789-1-huangjunxian6@hisilicon.com>
References: <20240412091616.370789-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-next 00/10] RDMA/hns: Bugfixes and cleanups
Message-Id: <171326925781.754505.3449356365980212517.b4-ty@kernel.org>
Date: Tue, 16 Apr 2024 15:07:37 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Fri, 12 Apr 2024 17:16:06 +0800, Junxian Huang wrote:
> Here are some bugfixes and cleanups.
> 
> Chengchang Tang (7):
>   RDMA/hns: Remove unused parameters and variables
>   RDMA/hns: Add max_ah and cq moderation capacities in query_device()
>   RDMA/hns: Fix deadlock on SRQ async events.
>   RDMA/hns: Fix UAF for cq async event
>   RDMA/hns: Fix GMV table pagesize
>   RDMA/hns: Use complete parentheses in macros
>   RDMA/hns: Modify the print level of CQE error
> 
> [...]

Applied, thanks!

[01/10] RDMA/hns: Use macro instead of magic number
        https://git.kernel.org/rdma/rdma/c/bfb6be40147020
[02/10] RDMA/hns: Remove unused parameters and variables
        https://git.kernel.org/rdma/rdma/c/f4caa864af84f8
[03/10] RDMA/hns: Add max_ah and cq moderation capacities in query_device()
        https://git.kernel.org/rdma/rdma/c/2ce384307f2ddf
[04/10] RDMA/hns: Fix deadlock on SRQ async events.
        https://git.kernel.org/rdma/rdma/c/b46494b6f9c19f
[05/10] RDMA/hns: Fix UAF for cq async event
        https://git.kernel.org/rdma/rdma/c/a942ec2745ca86
[06/10] RDMA/hns: Fix mismatch exception rollback
        https://git.kernel.org/rdma/rdma/c/dc3bda6e568e93
[07/10] RDMA/hns: Fix GMV table pagesize
        https://git.kernel.org/rdma/rdma/c/ee045493283403
[08/10] RDMA/hns: Add mutex_destroy()
        https://git.kernel.org/rdma/rdma/c/9a84848dcee289
[09/10] RDMA/hns: Use complete parentheses in macros
        https://git.kernel.org/rdma/rdma/c/4125269bb9b22e
[10/10] RDMA/hns: Modify the print level of CQE error
        https://git.kernel.org/rdma/rdma/c/349e859952285a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


