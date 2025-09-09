Return-Path: <linux-rdma+bounces-13170-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 960EBB49EB7
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 03:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58804E6A3E
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 01:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC41224AF3;
	Tue,  9 Sep 2025 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+R6dEIz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730A8211499;
	Tue,  9 Sep 2025 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757381435; cv=none; b=P7EFEIFUQDWwH2A4/AAP4EZLWAFxugK2Jzrr+gLqioxpBJ+pNN+81kTREr21/XogUCphARF8pFHr+SAjgIDn5QT7743+2q/dwpAQIqSwKLR6c4+nxb2rAbOF8GgTAWSml/PXtKTkmYzbZckAkaKBLlNG1foQiDRZLeBNCpep7S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757381435; c=relaxed/simple;
	bh=g59nEI9rKVm3g34j4uFi3DXaOMima9O+BE+j4HH4QPU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BUg25wPwKSQ9GPIbJLIQA8+R5T7GsXp+UxUVB9A42ecCjIcLWbiw4thFVqja/EeFoIezLdPLNzSK+hnGZiwP1FvVGPlVbv3f5LhIn5dskndRUyqEazidCXQHTQTJJIS5gFDoEBIuMTn8WSNQIRMCI0WOiEcn4gFMLJwpmt4PS08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+R6dEIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D73C4CEF1;
	Tue,  9 Sep 2025 01:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757381435;
	bh=g59nEI9rKVm3g34j4uFi3DXaOMima9O+BE+j4HH4QPU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l+R6dEIzS5bkBR42oF1Uj+OMANFVBhv1MI58ZBnupxGlNG4BMtFycVz4CgKB0C+hA
	 +goRtlrG6eAKsN2eZ75LNZHQw4JnViVzPAxoEKI8G6WySuh85f3MQx7jNN2TlEUUxb
	 eJGMGIhwKVMI3O3dV5Mgb2+Rb9i6qx6dlQTgI7mIk6EtXi4NKhy6U9KZHLCC9f0bqO
	 AFkre/ReN+hfQUYFUC5QV7QGiZQYOMRFKa5GnooY4EG3+sYRgpeY9ydNHGAhPWXZ53
	 vXKKXLTuzSz8uHJ+6H2bpjcGbO6SvzBcRBS+CyuOGdpRyirLjDTnA0OFLRxF2U4hMZ
	 L6s8JoQOzYYKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCC6383BF69;
	Tue,  9 Sep 2025 01:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] rds: ib: Remove unused extern definition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175738143824.108077.16911055038125503100.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 01:30:38 +0000
References: <20250905101958.4028647-1-haakon.bugge@oracle.com>
In-Reply-To: <20250905101958.4028647-1-haakon.bugge@oracle.com>
To: =?utf-8?q?H=C3=A5kon_Bugge_=3Chaakon=2Ebugge=40oracle=2Ecom=3E?=@codeaurora.org
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Sep 2025 12:19:57 +0200 you wrote:
> In the old days, RDS used FMR (Fast Memory Registration) to register
> IB MRs to be used by RDMA. A newer and better verbs based
> registration/de-registration method called FRWR (Fast Registration
> Work Request) was added to RDS by commit 1659185fb4d0 ("RDS: IB:
> Support Fastreg MR (FRMR) memory registration mode") in 2016.
> 
> Detection and enablement of FRWR was done in commit 2cb2912d6563
> ("RDS: IB: add Fastreg MR (FRMR) detection support"). But said commit
> added an extern bool prefer_frmr, which was not used by said commit -
> nor used by later commits. Hence, remove it.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] rds: ib: Remove unused extern definition
    https://git.kernel.org/netdev/net-next/c/9f0730b063b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



