Return-Path: <linux-rdma+bounces-8052-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78647A4330C
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 03:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBC03B908A
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 02:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EABD14A4F0;
	Tue, 25 Feb 2025 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIrzoer9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4A71465B4;
	Tue, 25 Feb 2025 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450604; cv=none; b=kX4FLmca20sXLPfm1zCPnSL+SqkbxuJKG1Lr684+OCFAMN6iPa/dBliwuyVeijtopG0xqoVT+IMT29SxGQaTQ1rpY8ErDoWPnXKmqZL/a93o4YUpd95u5+ogHQfQjw7mwiyx23QmRAkKb9G4w3twBjFeE4zc18h9H4Ffj7CrJBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450604; c=relaxed/simple;
	bh=071BG79VHNUJFvscUKhMIqdR5q6V+Edmq9WBd/sK5Fs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b5i1HnKnuU/Ef+j/6JBEup1Tv2Q5YNsDN1hiipZXmEWtAke2/s3FpRQ7hHB0MdKhNuGbWDkXR6d7r9tkZYJBDb10XdaVgM+9JGP3Ui0aXtxlElBh/nJFrgFs7oJYMLBH5EbwrlmfpD0crG/wxL1Izyce0TtSXmGW0yio7F2pixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIrzoer9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B7BC4CED6;
	Tue, 25 Feb 2025 02:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740450604;
	bh=071BG79VHNUJFvscUKhMIqdR5q6V+Edmq9WBd/sK5Fs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BIrzoer9J1bfyCitNIYvk8GFnFfKR8T8ah4in2QMl6wOHlr9KbRBDJJkxqXKigsSc
	 dy8NJC/GXZAJr6n2lSREEavh/MkrUKCKuT2H+GlEySzyCjfVYIUbIaurnBhJ9ovWSB
	 2T2aWUA8RamT100nNyZmIXxCMUsQM5IwjvcS6ihR0F8HkyLR4IdCvOg6F0YNexoYbV
	 P8OtXCpLUvu/rg5VKebMwpnon36D7iXf2PwDvUs3I/qJNmgBvTRJxfxKY8fT3s60TD
	 NQBwBF1m+3o5fyvUfTcotNtrmHYpGVTzXIMfqKLUdYTdd7YEPSC3lNQ1gBXuAX1V/N
	 MX2UEh3IhXiew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3F0380CFD8;
	Tue, 25 Feb 2025 02:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] net/mlx5e: Move IPSec policy check after
 decryption
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174045063562.3682145.9099775003229462046.git-patchwork-notify@kernel.org>
Date: Tue, 25 Feb 2025 02:30:35 +0000
References: <20250220213959.504304-1-tariqt@nvidia.com>
In-Reply-To: <20250220213959.504304-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, gal@nvidia.com,
 mbloch@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianbol@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Feb 2025 23:39:50 +0200 you wrote:
> Hi,
> 
> This series by Jianbo adds IPsec policy check after decryption.
> 
> In current mlx5 driver, the policy check is done before decryption for
> IPSec crypto and packet offload. This series changes that order to
> make it consistent with the processing in kernel xfrm. Besides, RX
> state with UPSPEC selector is supported correctly after new steering
> table is added after decryption and before the policy check.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] net/mlx5e: Add helper function to update IPSec default destination
    https://git.kernel.org/netdev/net-next/c/3400ae49cd1a
  - [net-next,2/8] net/mlx5e: Change the destination of IPSec RX SA miss rule
    https://git.kernel.org/netdev/net-next/c/20d5fdc8951a
  - [net-next,3/8] net/mlx5e: Add correct match to check IPSec syndromes for switchdev mode
    https://git.kernel.org/netdev/net-next/c/85e4a808af25
  - [net-next,4/8] net/mlx5e: Move IPSec policy check after decryption
    https://git.kernel.org/netdev/net-next/c/7d9e292ecd67
  - [net-next,5/8] net/mlx5e: Skip IPSec RX policy check for crypto offload
    https://git.kernel.org/netdev/net-next/c/aa2961e19ff6
  - [net-next,6/8] net/mlx5e: Add num_reserved_entries param for ipsec_ft_create()
    https://git.kernel.org/netdev/net-next/c/e20674a7e5b1
  - [net-next,7/8] net/mlx5e: Add pass flow group for IPSec RX status table
    https://git.kernel.org/netdev/net-next/c/78e77a41e401
  - [net-next,8/8] net/mlx5e: Support RX xfrm state selector's UPSPEC for packet offload
    https://git.kernel.org/netdev/net-next/c/c69046c3f2dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



