Return-Path: <linux-rdma+bounces-7501-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234EBA2B869
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 02:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5091A3A2EAD
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 01:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF25313C9A4;
	Fri,  7 Feb 2025 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORQEr31p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676484C6E;
	Fri,  7 Feb 2025 01:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738893022; cv=none; b=ALpEqPasKd1g6sg9ISbqtSHMXG1e8llWSiyCqgQ2Q8dwOOuLdT/g6WKSjHjNEOEFUlLsuGwP8ySmGeK20FR/F59LjYO84SPm/j6AAVeLB1HjjLoQomHzWYlg5dstDTxtj2XU1mKfl2jVheTp5Eb5KmBOA2Psf269k/oVLvHUchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738893022; c=relaxed/simple;
	bh=XrJ7RIL75zIYHcLG17t38h9Z0vVp3gGvV+JU7Ci7P3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fOoEykJx2niLv5of+P3g+kAUwap5SGMZpXtJm9FSjEZXQDEFpRujOW5QoCxeVbVIfK2Ji5ICytK1ImHRFhD16uTptYKIeKPrWR1IcyXjcwO/oCiqyp4dXmuPqJE7ADdzM7S93lc/1BTyeSlz9PHXhUp18MFa0bLuRK5WrQssBF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORQEr31p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1091C4CEE0;
	Fri,  7 Feb 2025 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738893021;
	bh=XrJ7RIL75zIYHcLG17t38h9Z0vVp3gGvV+JU7Ci7P3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ORQEr31pE9GcotB0wqSogBj/roueH/CdmAivvcwP1Oli9hRbk3YUSjQdZO3TfkwCe
	 NAPCRZ1UFYht6pJZwzjKjfkdKSPBm7yZbrMu2BxqbDxFrsmSdCnbmfot/OHn64g4Gy
	 Id9Of+f+IzUiRnUy9w+5G8lMIB1fyWy4vR0MEMmNcD9eInQBlORVA1i+umGz1popyt
	 zIJNfIJMGKebcbDLpZw4XOH8TeZYpM73P6QdK8hp9mWpVMyWoTG0gjGtzIm7/vMEeS
	 QKHv6HGbICdAiJNMDO0o4Tk8MN0Ie945M2hPG7TKqOPyQZSZPK2O385FWxIK8f/NJR
	 ziKfoLvThVoeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE801380AAE8;
	Fri,  7 Feb 2025 01:50:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/9] ice: count combined queues using Rx/Tx count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173889304956.1732435.16113784696324345767.git-patchwork-notify@kernel.org>
Date: Fri, 07 Feb 2025 01:50:49 +0000
References: <20250205185512.895887-2-anthony.l.nguyen@intel.com>
In-Reply-To: <20250205185512.895887-2-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 michal.swiatkowski@linux.intel.com, sridhar.samudrala@intel.com,
 jacob.e.keller@intel.com, pio.raczynski@gmail.com, konrad.knitter@intel.com,
 marcin.szycik@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
 przemyslaw.kitszel@intel.com, jiri@resnulli.us, horms@kernel.org,
 David.Laight@ACULAB.COM, pmenzel@molgen.mpg.de, mschmidt@redhat.com,
 tatyana.e.nikolova@intel.com, jgg@ziepe.ca, leon@kernel.org,
 linux-rdma@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed,  5 Feb 2025 10:55:01 -0800 you wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> Previous implementation assumes that there is 1:1 matching between
> vectors and queues. It isn't always true.
> 
> Get minimum value from Rx/Tx queues to determine combined queues number.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/9] ice: count combined queues using Rx/Tx count
    https://git.kernel.org/netdev/net-next/c/c3a392bdd31a
  - [net-next,v2,2/9] ice: devlink PF MSI-X max and min parameter
    https://git.kernel.org/netdev/net-next/c/b2657259fce9
  - [net-next,v2,3/9] ice: remove splitting MSI-X between features
    https://git.kernel.org/netdev/net-next/c/79d97b8cf9a8
  - [net-next,v2,4/9] ice: get rid of num_lan_msix field
    https://git.kernel.org/netdev/net-next/c/ad61cd9c67ad
  - [net-next,v2,5/9] ice, irdma: move interrupts code to irdma
    https://git.kernel.org/netdev/net-next/c/3e0d3cb3fbe0
  - [net-next,v2,6/9] ice: treat dyn_allowed only as suggestion
    https://git.kernel.org/netdev/net-next/c/a8c2d3932c11
  - [net-next,v2,7/9] ice: enable_rdma devlink param
    https://git.kernel.org/netdev/net-next/c/87181cd6985f
  - [net-next,v2,8/9] ice: simplify VF MSI-X managing
    https://git.kernel.org/netdev/net-next/c/a203163274a4
  - [net-next,v2,9/9] ice: init flow director before RDMA
    https://git.kernel.org/netdev/net-next/c/d67627e7b532

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



