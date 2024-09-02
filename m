Return-Path: <linux-rdma+bounces-4691-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAA99680C7
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 09:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 083B2B20C05
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 07:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30274178CCA;
	Mon,  2 Sep 2024 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNN4hcTP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF823C00;
	Mon,  2 Sep 2024 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262682; cv=none; b=KHFtGS5ba7t1y4YGXmJFCkmh9usETKVcG+6LZAePl4TsXlJ/oFJmhvkJw35I3MoYSJwUwSPycmD5rs5q2xUTi6Dg9BcvtdOWRjZhBvHNv4Kv7Ns0UyQ3CGxJi44CLqS8R74RLc0PY/Vfga36Nrgf77p3wTWcPxwrjIFlvY3dojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262682; c=relaxed/simple;
	bh=2fqXB2uqKlFhoNQVceRy621qnr6rZrc7c4Uatrn0b4c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DKSYzxvF0OwSm7CQHNcyQf2FEPVb7lEaZmggiBvXd7vXL8JnYpI9JyEyX+6oiw8ox1YL8UFSFTvN9PYSjFC4kFP4EbDMQ05IM/1+OjpBXxFtKBiUweHjIJCCLEZmNKNt4lbdfLv/O2947hwOGRV2I/F3FyZkUzYGXOfQJi7tZ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNN4hcTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C56C4CEC2;
	Mon,  2 Sep 2024 07:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725262681;
	bh=2fqXB2uqKlFhoNQVceRy621qnr6rZrc7c4Uatrn0b4c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mNN4hcTPHFfYhNFjW198YuYBH1Ut8jJDepS0ywqv3EACBlcvk/MnMmQZX77nPlY7j
	 cxK4AI9FF5xLyiwYRCYSeS/vlADOw7oyvjI0H6PRmtJ0w5efhkwHbBS1ulJz53uFFY
	 RiAS7/pBxD+6vRWgeH8mFy65OHwnng/jCVMDcw3MIqgIrRaARM8i5PvQPoAowf8F1H
	 oZ7bm5hm72Jmu+tbKn3Bhz8gMpfLe51KeNq2zmx7mRsS22aH+r9cX0KzzqXYmAMS3o
	 X7L89R9nVxiGKnWu8KCbFdi/b6V55Zb404BgLldP+1Cj96tZG+50DV63su6UXaiFV0
	 7O4vvgVvip4Ig==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Ajay Sharma <sharmaajay@microsoft.com>, 
 Konstantin Taranov <kotaranov@microsoft.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 longli@linuxonhyperv.com
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>, 
 stable@vger.kernel.org
In-Reply-To: <1725030993-16213-1-git-send-email-longli@linuxonhyperv.com>
References: <1725030993-16213-1-git-send-email-longli@linuxonhyperv.com>
Subject: Re: [PATCH rdma-next v2 1/2] RDMA/mana_ib: use the correct page
 table index based on hardware page size
Message-Id: <172526267715.400537.4084099228794202996.b4-ty@kernel.org>
Date: Mon, 02 Sep 2024 10:37:57 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 30 Aug 2024 08:16:32 -0700, longli@linuxonhyperv.com wrote:
> MANA hardware uses 4k page size. When calculating the page table index,
> it should use the hardware page size, not the system page size.
> 
> 

Applied, thanks!

[1/2] RDMA/mana_ib: use the correct page table index based on hardware page size
      https://git.kernel.org/rdma/rdma/c/9e517a8e9d9a30
[2/2] RDMA/mana_ib: use the correct page size for mapping user-mode doorbell page
      https://git.kernel.org/rdma/rdma/c/4a3b99bc04e501

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


