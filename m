Return-Path: <linux-rdma+bounces-10311-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA97AB4970
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 04:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F125A19E6382
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 02:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3A11CC89D;
	Tue, 13 May 2025 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/E0JMbg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AEC1C863B;
	Tue, 13 May 2025 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747102801; cv=none; b=V8ZAgy4Pt+T9YqbWpoQmpTEMWE/OfDR5V+09bi81It5KElTuRTjaFVk5jcYGUsjoQKpcNl3m8PHvPBsg5+d81uciOZ2YkzZuuS5gPt/T0tnKT4hRIp7wZuhRA1EW0oh/8FFXZ+ExbyyP+Y9LAgvHWMp3mvFwJlUXBLeUmONKBho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747102801; c=relaxed/simple;
	bh=+/oP96T3QzIVp14zaVJlHh7PytdvvCWbZgiz8EI3DNw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hB+S5pcr+CkCDjp+ArcwzLHMKAa9x8Z2TCojLcT02eLFhUVbyL3o8fAXkaEVCxrSJfz1SinlkN3Nt7KG1p0gfNhnIbcEhEJk31zY11dW7FX3RNa9vHQwlFPhhzPhEw3iJXePhujtfOSHuVNZqcHxpvujBq39rBlp2d3NSY/WOac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/E0JMbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9DBC4CEEE;
	Tue, 13 May 2025 02:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747102801;
	bh=+/oP96T3QzIVp14zaVJlHh7PytdvvCWbZgiz8EI3DNw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n/E0JMbgRZycx4K50bO4uwblo64MNwMaRYPj0f74YNJNDRS6J/qDGyX6SXi+sph58
	 jJNClPlMPwx8xjAkYEEViwnXz+rW81EzCDPH5YAbrc8e4uLmdPqMbc6c6kFyFZypmb
	 s/IzSj4NpaVpNN7c4AmE2PTsUIrjHRWOqqxoNAOvUDkKC9cRJRqv3VqJPHyE1HRDEe
	 eemavpzVByYSoshV3nlE0ycbTiM+IRBZI45IHfoSaOXjro56mi0AAd1dKm3Xej0FKA
	 lvjlRlvrCw/JMhvnHcHgeBt/t+qyZ906KyNWilvuvi5tc89BLmSURe1T5Gj5TnvPwN
	 N3nfzrswI/u4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD4D39D6541;
	Tue, 13 May 2025 02:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,rdma-next v2 1/5] iidc/ice/irdma: Rename IDC header
 file
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174710283849.1148099.11671684905830521702.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 02:20:38 +0000
References: <20250509200712.2911060-2-anthony.l.nguyen@intel.com>
In-Reply-To: <20250509200712.2911060-2-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, jgg@ziepe.ca, leon@kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, david.m.ertman@intel.com,
 tatyana.e.nikolova@intel.com, przemyslaw.kitszel@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri,  9 May 2025 13:07:07 -0700 you wrote:
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> To prepare for the IDC upgrade to support different CORE
> PCI drivers, rename header file from iidc.h to iidc_rdma.h
> since this files functionality is specifically for RDMA support.
> 
> Use net/dscp.h include in irdma osdep.h and DSCP_MAX type.h,
> instead of iidc header and define.
> 
> [...]

Here is the summary with links:
  - [net-next,rdma-next,v2,1/5] iidc/ice/irdma: Rename IDC header file
    https://git.kernel.org/netdev/net-next/c/468d8b462ac6
  - [net-next,rdma-next,v2,2/5] iidc/ice/irdma: Rename to iidc_* convention
    https://git.kernel.org/netdev/net-next/c/97b5631aae68
  - [net-next,rdma-next,v2,3/5] iidc/ice/irdma: Break iidc.h into two headers
    https://git.kernel.org/netdev/net-next/c/d9251a560ba6
  - [net-next,rdma-next,v2,4/5] ice: Replace ice specific DSCP mapping num with a kernel define
    https://git.kernel.org/netdev/net-next/c/8239b771b94b
  - [net-next,rdma-next,v2,5/5] iidc/ice/irdma: Update IDC to support multiple consumers
    https://git.kernel.org/netdev/net-next/c/c24a65b6a27c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



