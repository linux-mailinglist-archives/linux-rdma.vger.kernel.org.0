Return-Path: <linux-rdma+bounces-1846-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3387989C1E5
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 15:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653BF1C21C87
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 13:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B758083A09;
	Mon,  8 Apr 2024 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aypNzpwL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE70481A6;
	Mon,  8 Apr 2024 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582427; cv=none; b=qNClLl0NcBrvgiit0O5MqHrREOpisHuhixOdZHfLuQ4LD7SV9xpf3Y/g8tAO/xKSK3sxxZsJMyiPSxcwAUmtu+LPh6E0UGPt/i8cKhqWFEdo52Ga6O3Lz3JxRbnrHaaMhJQTHwDkk2XcbZfOIhElhxe0N4PEEHrWoQP96HN2vtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582427; c=relaxed/simple;
	bh=cGDUlw6k8tIWFZInxvFyjxFVpYYU2NmTQtQ7IW9vU/A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mCUwpxL7VQOnSTw1VKQoWT/iteqk7rQ8+o7UPwfzjFFvcPUcooFcucHoSHVemhPTapmJ5vdSMWEslJIM4Ys6Pwo+UXGxCV5RXHYH1ZjbL6IFyvJTr20tyF7ihc8n4XY5tTiNLSJ05uR52zCDqlmmsUyD4iJXfJ1W3FQxLRu6LHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aypNzpwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F38BEC43394;
	Mon,  8 Apr 2024 13:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712582427;
	bh=cGDUlw6k8tIWFZInxvFyjxFVpYYU2NmTQtQ7IW9vU/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aypNzpwL71CgTXwvMT2nnOIHleunSJDzp8ieXffpdoU0tCRN928ur92PPKGHlWIZm
	 NAo9HQ1PmFLsCdC57ukZ3F6InGI8XbkusegMUhTSlY9XIZqlZU4Gy51NShqHXMHO6g
	 CTktv64IfpLOsLUNKfr3DV4tP101GAgzlToWX3gaPtqz52GyniLGq1haqiYalwcSxS
	 +tQV3xxdviLwIABE69MAp4taHWbJ8dW1AINlzy2lx1Kcz8zLBen3fKi01/ZPOSY8wO
	 cNgAdRo2xeiRYAL9qzBb7Wpetbz2jGZ4vGGz+aRto684VBCd/ygdGfCUr88NrzJlsO
	 DChFOCXT/fQEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E683BD72A02;
	Mon,  8 Apr 2024 13:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v4 0/2] devlink: Add port function attribute for IO EQs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171258242694.15799.9946974100091774097.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 13:20:26 +0000
References: <20240406010538.220167-1-parav@nvidia.com>
In-Reply-To: <20240406010538.220167-1-parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, dw@davidwei.uk,
 kalesh-anakkur.purayil@broadcom.com, saeedm@nvidia.com, leon@kernel.org,
 jiri@resnulli.us, shayd@nvidia.com, danielj@nvidia.com, dchumak@nvidia.com,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 6 Apr 2024 04:05:36 +0300 you wrote:
> Currently, PCI SFs and VFs use IO event queues to deliver netdev per
> channel events. The number of netdev channels is a function of IO
> event queues. In the second scenario of an RDMA device, the
> completion vectors are also a function of IO event queues. Currently, an
> administrator on the hypervisor has no means to provision the number
> of IO event queues for the SF device or the VF device. Device/firmware
> determines some arbitrary value for these IO event queues. Due to this,
> the SF netdev channels are unpredictable, and consequently, the
> performance is too.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] devlink: Support setting max_io_eqs
    https://git.kernel.org/netdev/net-next/c/5af3e3876d56
  - [net-next,v4,2/2] mlx5/core: Support max_io_eqs for a function
    https://git.kernel.org/netdev/net-next/c/93197c7c509d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



