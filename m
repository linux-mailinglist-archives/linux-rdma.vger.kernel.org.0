Return-Path: <linux-rdma+bounces-6995-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D07EA0FF0C
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 04:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3BA47A2491
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 03:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFC1232794;
	Tue, 14 Jan 2025 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAim8GkZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CCA3596A;
	Tue, 14 Jan 2025 03:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736824215; cv=none; b=nW1mU7n2xQoJKs3K5Z+WJ/aDp1arhUU1xoofBNbm7wtKdnlf03bsSoo3xsPIl5SWvrDbGAT8okcpl/zsTEx73zOExI+hcv04iCa0v/mwp66/IkGZpjEN57n+cmjBPZyIxcgE5M+JEnvsiSs1f2mvNlrMFvPja3aTvxkisRKOMfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736824215; c=relaxed/simple;
	bh=wtiqlRNAijPwFZxttNbA9gPDMRele86XZmih4s3L2aQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VMJE7rjvv3ZDnCromx2ZC12AMkMzXm3o32OZl2IyUQPP3Jaew7Por2zr4G0h+ncexJTEY2V9z84zf5nS70xuHswOgBJn/PoqYxOV2Hjyf8LUi4Ux4GrvZYH6TS6EaCbBoCpuw1drFOjTcMHnGXrxJ0r+oHif4KmcFB0ASEICSRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAim8GkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D94C4CEE5;
	Tue, 14 Jan 2025 03:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736824213;
	bh=wtiqlRNAijPwFZxttNbA9gPDMRele86XZmih4s3L2aQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VAim8GkZh/aQqBoaFlLQwWeoAw550NavRJtAAdPyInHO/U6DbVE4MXR2FQkdwOjnx
	 64LzrZk+3llFe8FuZ0MH/GCdYAr0dyj/x8Tf7X3itOgtRpUbIS3/uQtEHZFGEA6wh6
	 T4/HWZjuT/2Zz/nGV7/wXsjkrpFtlMZCGL6YzkQP9DXXq/6lsxOHTj/0iAG67Y09Cq
	 9W0DHnuGnURxUIVVBKWerKlLzGAJbRKslHVv9kfikuE5M4Cy5B4Jsz4vIL2CY+DEjv
	 4BvD7zbcG4/ahhpW2r/HtxETrCYOpaFbnqT9EjkGvcE7BV3ahQwuUdTeUNHu45gJ2r
	 ODKufr3CfJUsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4EC380AA5F;
	Tue, 14 Jan 2025 03:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net] net/smc: fix data error when recvmsg with MSG_PEEK
 flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173682423623.3717681.3711335962362031005.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 03:10:36 +0000
References: <20250104143201.35529-1-guangguan.wang@linux.alibaba.com>
In-Reply-To: <20250104143201.35529-1-guangguan.wang@linux.alibaba.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  4 Jan 2025 22:32:01 +0800 you wrote:
> When recvmsg with MSG_PEEK flag, the data will be copied to
> user's buffer without advancing consume cursor and without
> reducing the length of rx available data. Once the expected
> peek length is larger than the value of bytes_to_rcv, in the
> loop of do while in smc_rx_recvmsg, the first loop will copy
> bytes_to_rcv bytes of data from the position local_tx_ctrl.cons,
> the second loop will copy the min(bytes_to_rcv, read_remaining)
> bytes from the position local_tx_ctrl.cons again because of the
> lacking of process with advancing consume cursor and reducing
> the length of available data. So do the subsequent loops. The
> data copied in the second loop and the subsequent loops will
> result in data error, as it should not be copied if no more data
> arrives and it should be copied from the position advancing
> bytes_to_rcv bytes from the local_tx_ctrl.cons if more data arrives.
> 
> [...]

Here is the summary with links:
  - [RESEND,net] net/smc: fix data error when recvmsg with MSG_PEEK flag
    https://git.kernel.org/netdev/net-next/c/a4b6539038c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



