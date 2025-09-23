Return-Path: <linux-rdma+bounces-13591-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3F5B95385
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 11:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B174F1890095
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 09:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699FB31E100;
	Tue, 23 Sep 2025 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqkdkOyG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F056E18027;
	Tue, 23 Sep 2025 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619226; cv=none; b=kxsxe0HsawfFptYoCLUC9UGYXK1/oSIVN7zov0R+G7wHIDR/8cUEYB7C/RdqdT9eae6Cg+l5bktxbIYev0stbUaqqCuLLCUfdsf1uuZsU9hvzhp70YfEczMtbj0BAlOOpuGrq5b0DYeW9IPNtBFgpuH2OrCvYHK3nRct4NhYmmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619226; c=relaxed/simple;
	bh=gdoXPqKcRwqsS6xGmaE6ieeKY1UOE2LdWb4KSBpnMZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fKSnGl9+gmXx/kzyYs7ji/g7BPWL4wcrR0gMlvOZ7+ig1nhsT3LZ9dQTPKU4zSTXaeoRwLbIMGcnTqePgzW3L0RLl28o3t3aaxTEn84GucvvdfcGeVjdi9pg6HXA/CuGA8E7ohbnNKQ1wfPHHRDlMEcLorcUCRCKHl/Vh4NeFEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqkdkOyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FD2C4CEF5;
	Tue, 23 Sep 2025 09:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758619225;
	bh=gdoXPqKcRwqsS6xGmaE6ieeKY1UOE2LdWb4KSBpnMZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AqkdkOyGWQX0zxAuGM24pyt9Rz33HurS1DtRVsIVpuEsrOI2VlKsbQ9sA+m+wwYHD
	 fzT4FN68udJLKcsKFb5gog4nWOKFSSogj5wnnF3iUUDij9GPGBM7dRTsh9KTYmE6t7
	 1mUVpRvEwojqO1GAGvxqBw7ljAycYZayGTNYqCChzQEWd9AqDlOpnS4ZssfRNvjC7j
	 2LgwuZabZdJUG3AcfcndlEflm3iwzX+KHg7vsAZgNZ3ryS2+9hPT+0NoYOtBARurA1
	 PlP2Sd1l/552W5uNUVzmPYoWFYQSh1OdWARTYD06P8kDL14rfszkCR9wVMkaLsvoWL
	 Fu7B7YezHQNpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB36439D0C20;
	Tue, 23 Sep 2025 09:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/14] dibs - Direct Internal Buffer Sharing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175861922275.1349779.9038445436427700576.git-patchwork-notify@kernel.org>
Date: Tue, 23 Sep 2025 09:20:22 +0000
References: <20250918110500.1731261-1-wintera@linux.ibm.com>
In-Reply-To: <20250918110500.1731261-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, wenjia@linux.ibm.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, julianr@linux.ibm.com, aswin@linux.ibm.com,
 pasic@linux.ibm.com, mjambigi@linux.ibm.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 horms@kernel.org, ebiggers@kernel.org, ardb@kernel.org,
 herbert@gondor.apana.org.au, freude@linux.ibm.com, kshk@linux.ibm.com,
 dan.j.williams@intel.com, dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
 sln@onemain.com, geert@linux-m68k.org, jgg@ziepe.ca

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 18 Sep 2025 13:04:46 +0200 you wrote:
> This series introduces a generic abstraction of existing components like:
> - the s390 specific ISM device (Internal Shared Memory),
> - the SMC-D loopback mechanism (Shared Memory Communication - Direct)
> - the client interface of the SMC-D module to the transport devices
> This generic shim layer can be extended with more devices, more clients and
> more features in the future.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/14] net/smc: Remove error handling of unregister_dmb()
    https://git.kernel.org/netdev/net-next/c/884eee8e43f3
  - [net-next,v3,02/14] net/smc: Decouple sf and attached send_buf in smc_loopback
    https://git.kernel.org/netdev/net-next/c/a4997e17d137
  - [net-next,v3,03/14] dibs: Create drivers/dibs
    https://git.kernel.org/netdev/net-next/c/35758b0032c0
  - [net-next,v3,04/14] dibs: Register smc as dibs_client
    https://git.kernel.org/netdev/net-next/c/d324a2ca3f8e
  - [net-next,v3,05/14] dibs: Register ism as dibs device
    https://git.kernel.org/netdev/net-next/c/269726968f95
  - [net-next,v3,06/14] dibs: Define dibs loopback
    https://git.kernel.org/netdev/net-next/c/cb990a45d7f6
  - [net-next,v3,07/14] dibs: Define dibs_client_ops and dibs_dev_ops
    https://git.kernel.org/netdev/net-next/c/69baaac9361e
  - [net-next,v3,08/14] dibs: Move struct device to dibs_dev
    https://git.kernel.org/netdev/net-next/c/845c334a0186
  - [net-next,v3,09/14] dibs: Create class dibs
    https://git.kernel.org/netdev/net-next/c/804737349813
  - [net-next,v3,10/14] dibs: Local gid for dibs devices
    https://git.kernel.org/netdev/net-next/c/05e68d8dedf3
  - [net-next,v3,11/14] dibs: Move vlan support to dibs_dev_ops
    https://git.kernel.org/netdev/net-next/c/92a0f7bb081d
  - [net-next,v3,12/14] dibs: Move query_remote_gid() to dibs_dev_ops
    https://git.kernel.org/netdev/net-next/c/719c3b67bb7e
  - [net-next,v3,13/14] dibs: Move data path to dibs layer
    https://git.kernel.org/netdev/net-next/c/cc21191b584c
  - [net-next,v3,14/14] dibs: Move event handling to dibs layer
    https://git.kernel.org/netdev/net-next/c/a612dbe8d04d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



