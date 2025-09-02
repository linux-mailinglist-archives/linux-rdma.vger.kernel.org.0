Return-Path: <linux-rdma+bounces-13046-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1896B4107B
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 01:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403C81B6270F
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 23:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181C527F166;
	Tue,  2 Sep 2025 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTWmlblZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9699532F743;
	Tue,  2 Sep 2025 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854025; cv=none; b=D8zW7buiYJ0IyVZMNOYipp8be9K0aJ1N2amvmftlXsRxypEVf9j4lKPqjpEpYl4Ynw1sSkLNgCpdLezOANSn1dMPDWdE6KgR6MgLPZpzUar/jNJ2Ua1hSWjSJJQRnrKVfayVjpyOO4PZJL73VVKRoTOfJe5kgPw+ITIpljENYCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854025; c=relaxed/simple;
	bh=dPIbJwWZvPXOY8sg69LKxX2OsJ+5HninbpyXwBaAb94=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZEMSGTXmkXDbZfl1xNcb6G4elazd+TKQ2BcZd9IH1y4R44oyjXVn66k196eXLKhdOTGh8Z1infyXkPu7exFYp4adVcx5IPZ9MGlI1S3/yA0pvrKvqlw1a5iEWIplBH5Nwv/OXS5wpBvElgS3v/M+aovQA2KQqwrOLm8OfF8fWOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTWmlblZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2530EC4CEED;
	Tue,  2 Sep 2025 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756854025;
	bh=dPIbJwWZvPXOY8sg69LKxX2OsJ+5HninbpyXwBaAb94=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jTWmlblZUPiZDuIRxfo5imIFXY8Vpei65/RcxQ4LZR+6++RvU72uuJZr3nSlpTNpd
	 Qe+flAWoj39Ir2bLWH+0UfjxdXAC/1tfPwNql2G5FqJJ/hDq084w44whf5nMOW8/kh
	 qUeVrURa5XZXvMpVEk4//RP3gt8pB9hIsR3N14eBXBbjdxjD2g60V5IKzxwA56L4z2
	 Zb2/rc13qTf2K5yJNfSLIe/D+g1fVze13DpK3AFIEEyB8lNU4T7Zq18bYWy4Zjblyv
	 AzQLgKgKfT+5yi+CbyID4F4Kq2uLjfp6pkzABuFsz7TWk4T3grr60K0zhEd8h0LBzB
	 LVVLbiIqOD23w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE01383BF64;
	Tue,  2 Sep 2025 23:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net/smc: Replace use of strncpy on NUL-terminated
 string
 with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685403028.461360.5671454085115817029.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 23:00:30 +0000
References: <20250901030512.80099-1-bold.zone2373@fastmail.com>
In-Reply-To: <20250901030512.80099-1-bold.zone2373@fastmail.com>
To: James <bold.zone2373@fastmail.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 skhan@linuxfoundation.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 31 Aug 2025 20:04:59 -0700 you wrote:
> strncpy is deprecated for use on NUL-terminated strings, as indicated in
> Documentation/process/deprecated.rst. strncpy NUL-pads the destination
> buffer and doesn't guarantee the destination buffer will be NUL
> terminated.
> 
> Signed-off-by: James Flowers <bold.zone2373@fastmail.com>
> 
> [...]

Here is the summary with links:
  - [v2] net/smc: Replace use of strncpy on NUL-terminated string with strscpy
    https://git.kernel.org/netdev/net-next/c/d250f14f5f07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



