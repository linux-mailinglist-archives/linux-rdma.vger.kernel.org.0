Return-Path: <linux-rdma+bounces-13532-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C806AB8DA45
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 13:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8506C420112
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 11:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FBD2BE7D5;
	Sun, 21 Sep 2025 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCvMJsBj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D3B2AEE4;
	Sun, 21 Sep 2025 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758454332; cv=none; b=ad6gyNrspqRX/ydtBkPZzTlnTqa+dkF3YDZYwXs0zbafgsL4rKDcb5SipyuZuMQhC7qxTS3H3o9SuLCVB74OGGEZ5x1RFt4O8vcAFlpvKB6lMj8SU0TLawOov/G7/vSfqgDNWvc2FbEHFkgWUvyvfbayyjF0v3kfXw0oPDxh1oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758454332; c=relaxed/simple;
	bh=AZwAKUxBvjWQ51sPafyEZYJPTdR2KWBN8qIUpAog/zY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jzzr9vvkcLx4KhsJQQpN8HLgZfEpg9KkqcpI0YAdhcky1Teoq4PONgZcraplVvieRt+PZHB37XEJxLx46pn6WdDiZpisaMf3SDipA2O3MFbLTJmwBLKU74p6dsLSavyaMW1YojjxGORv2cUK7b4GnJM6Rm51MjotFDjIJ6SU41U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCvMJsBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAE9C4CEE7;
	Sun, 21 Sep 2025 11:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758454332;
	bh=AZwAKUxBvjWQ51sPafyEZYJPTdR2KWBN8qIUpAog/zY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HCvMJsBjxLG45ff9+yDlMvexSFNyll8QdmvAm256Jfq6/bNsXgzjjbTwBp656ZdC9
	 A0jFVMTQQ/VDmJs8RBHExINZ3nM7dleFOnWGkKWYV+uPyUg/BdWsa/V5dbKRCvolQh
	 0eK9LGuE26OoLcm9FcK9CwyiDg9sfkhdUbxuRWNwAuh1cafCInBcAwmcHh5gafacex
	 k9IUn4EJaU0gGw95U2VHNd0VL1OrSlinFIIZA2NXQrtUO7a28evVfZcIakWT6JG9Es
	 w3HLBuxXVjk9gRrdxzA59Ai16BFJDiSGn8FfKfQ1PV2e1wUtBmZ8N6xr65052AvLI4
	 hzyIy/lPq5/hg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: allen.hubbe@amd.com, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250919121301.1113759-1-abhijit.gangurde@amd.com>
References: <20250919121301.1113759-1-abhijit.gangurde@amd.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/ionic: Fix build failure on SPARC
 due to xchg() operand size
Message-Id: <175845432914.2104414.9474042461731111363.b4-ty@kernel.org>
Date: Sun, 21 Sep 2025 07:32:09 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 19 Sep 2025 17:43:00 +0530, Abhijit Gangurde wrote:
> xchg() is used to safely handle the event queue arming.
> However SPARC xchg operates only 4B of variable.
> Change variable type from bool to int.
> 
> Unverified Error/Warning (likely false positive, kindly check if interested):
> 
>     ERROR: modpost: "__xchg_called_with_bad_pointer" [drivers/infiniband/hw/ionic/ionic_rdma.ko] undefined!
> 
> [...]

Applied, thanks!

[1/2] RDMA/ionic: Fix build failure on SPARC due to xchg() operand size
      https://git.kernel.org/rdma/rdma/c/ed9836c040bac2
[2/2] RDMA/ionic: Use ether_addr_copy instead of memcpy
      https://git.kernel.org/rdma/rdma/c/260cce64aaa282

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


