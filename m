Return-Path: <linux-rdma+bounces-5450-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0629A2DAA
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 21:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11961C203A2
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 19:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A533227B8F;
	Thu, 17 Oct 2024 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtCnrJ5z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CCA227386;
	Thu, 17 Oct 2024 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192824; cv=none; b=Of3ye80dIyx95TWGsOqftpUtFVYMW4GKsglEmi9cUcuOgSlMd8w6mhXBmmPIbViWpR+oAiDrBvH7sMDZcU8ccXbx8vZuacyBKmoe4jfyQm/fMa379r+rDgMYW8YmRsEMhb3FE3l9+cSMIikLyooFODdYlhapURIPXqbmCtifdPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192824; c=relaxed/simple;
	bh=7lWdHql5SUu+8IwydD7nTStu28/fGPd9HlS22/z+zpo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rN+Fd+ZVSnqrgDcSkIOg66YPbK4Fdkou1fd9RpoQCgGEr0443gmkiHl8T5o6NaVR3mhcOS7k7ZgkxYaX+ljKvsftsoJTnK8ZhF/vDeaSBfr0CPAXJ1ZqtitjauEi4pZ/EqIumKq2CtypvmAt0iAl6o/92aqJRTR+VJCIhn4Y4CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtCnrJ5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9A5C4CEC3;
	Thu, 17 Oct 2024 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729192823;
	bh=7lWdHql5SUu+8IwydD7nTStu28/fGPd9HlS22/z+zpo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rtCnrJ5zpcRduumR1kHCrBBwwuh66+liYqiATRIoSH0suHVHaQwF94mIPzsaeK5OD
	 3Z29sRICJOLskSBikFpE9gC7JzkDtxYi44GNwfDkYCEU16DI9z646xOB+J5YPfNgpm
	 8smL1q/tiDF+zrdjET8VYAE2OjsbWY15PyagZsCCs0F08bLK1ib67o9/iSpPJTOTJ8
	 5c0b0PbamOdqtz8Mva53L4w7t2DiGnNVhHVWWFHKYc4f7DDU0V2Epq6tQtR6hAOP7f
	 glzeYU2S+hbY80L3H6WjDnxxEYilgV2EhnhF3xjOc+1+RMIdWN+z4JC4W/jr5mVsCw
	 sOlcU6tiQHpiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340463809A8A;
	Thu, 17 Oct 2024 19:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-rc] rdma: Fix help information of 'rdma resource'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172919282900.2582447.15957239975820790666.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 19:20:29 +0000
References: <20241016093526.2106051-1-huangjunxian6@hisilicon.com>
In-Reply-To: <20241016093526.2106051-1-huangjunxian6@hisilicon.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: larrystevenwise@gmail.com, leon@kernel.org, dsahern@gmail.com,
 stephen@networkplumber.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linuxarm@huawei.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 16 Oct 2024 17:35:26 +0800 you wrote:
> From: wenglianfa <wenglianfa@huawei.com>
> 
> 'rdma resource show cq' supports object 'dev' but not 'link', and
> doesn't support device name with port.
> 
> Fixes: b0b8e32cbf6e ("rdma: Add CQ resource tracking information")
> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> 
> [...]

Here is the summary with links:
  - [iproute2-rc] rdma: Fix help information of 'rdma resource'
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=bea332466d29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



