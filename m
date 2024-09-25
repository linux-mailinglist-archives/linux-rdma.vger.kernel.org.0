Return-Path: <linux-rdma+bounces-5081-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5849852A4
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2024 07:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B5C1F244F7
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2024 05:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E3A1547FF;
	Wed, 25 Sep 2024 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTOTQ3y7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A29B657;
	Wed, 25 Sep 2024 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727243487; cv=none; b=MUgI8poWn1k8lhORHokG0tKwRrSfqjoIRfKRc2suRMspAGw3zFaPxpaYQ84j8OgwUP9WJOEMU3oTGb5OpN3b1J9rKEjAVydfNSLLs4yVltL2qQq0smH5bZNZp0gBCFkLoA5yyG541onSfaCtD5utyRTYGR4eiQg3YSnVPwdIKxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727243487; c=relaxed/simple;
	bh=L0DvuQ5+JV7LC8u5ipDHoi9P+mRwkQBovnpX/4+rPGQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZYpXOQXlYjfI6ZVmQEegrOCwGYL8FVK18g/bY7/IKEb+Wa6rt/MUdpBplrjhtoTJH0lkK01odZ9gY+jMI04MIjY3Zqx4N+5khFSVWzJ2KFMopHqz0I5CfnztOOwZzK0XaZvPWk7Hylg8YltUMLMP6be2kr0UBrVqRCYp6CXcpo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTOTQ3y7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9746C4CEC3;
	Wed, 25 Sep 2024 05:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727243486;
	bh=L0DvuQ5+JV7LC8u5ipDHoi9P+mRwkQBovnpX/4+rPGQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qTOTQ3y7eXGfNvx3YAluz0B4Japbnoq7cwxyk86Aa/xA6BVcs044N0dLqXbNwbAfs
	 lKXs/4lt/xaOrBwHBDsLHsF2WfKnOfibM0ew09w4VuVf9dz+Sri13dkM4D+E15XyRr
	 XSVGLxh6VheBafOplSVQYrw1/nYU3THIXGCnzcenDAVvZxtVMPYSpwzfwUXdVak4UA
	 Z2fQigUexilrPTTmv30FQkFC3dYekyAdBjy3UOOi09jdeTLp2OYsY7Pqh2bILaegbB
	 fSHlIS1kObJKdNBHNgg8H1nwYPKysERFTulPK2iHOEtDKkT49xGkgz1kKimBcgq4VV
	 ek/K7Ri0Y0Dpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DE1380DBF5;
	Wed, 25 Sep 2024 05:51:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/1] selftests: set executable bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172724348926.448598.2586649481930779700.git-patchwork-notify@kernel.org>
Date: Wed, 25 Sep 2024 05:51:29 +0000
References: <20240924175500.17212-1-david.hunter.linux@gmail.com>
In-Reply-To: <20240924175500.17212-1-david.hunter.linux@gmail.com>
To: David Hunter <david.hunter.linux@gmail.com>
Cc: sj@kernel.org, shuah@kernel.org, allison.henderson@oracle.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 javier.carrasco.cruz@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 24 Sep 2024 13:54:57 -0400 you wrote:
> Turn on the executable bit for the following script files. These scripts
> are set to TEST_PROGS in their respective Makefiles, but currently, when
> these tests are run, a warning occurs:
> 
>   # Warning: <file> is not executable
> 
> Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v1,1/1] selftests: set executable bit
    https://git.kernel.org/bpf/bpf-next/c/9ea7b92b77df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



