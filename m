Return-Path: <linux-rdma+bounces-12694-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0794B24722
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 12:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E993AF275
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 10:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A832D738A;
	Wed, 13 Aug 2025 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvvSEmaT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2962D0C9D
	for <linux-rdma@vger.kernel.org>; Wed, 13 Aug 2025 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755080537; cv=none; b=YHMiMf2pp/9mfPDWPjhU9Sg++TPJQpHnAag7JhI9JCiXGxzeWzi62w1TBAxkuIBuQYeJ8VkFFqfZMOaClAIw9zy8gsbnz1mEBMd/7b72MgHUivBvkZWmfMi1W3xYpPh4crBcNN5XsI2LefEetN0DdKf8xib5VyqCOquJt+drVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755080537; c=relaxed/simple;
	bh=V62ybuXf7lxlceY1ITNzm5Kpk7PiTfVAx2VTMsZdg3E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bTgqCTxbUKdAYo/LaZoEdYr1uEKhVrlWhcyJBrtaa/NIf9xCntMrWG/KcKrnQOAkEPdD0UmbQXVocNxRfZVO524G0EpKaFgUpDF1NuQxXJKGRiOnRGIn60w0cp8FWjl8AwKz8EWVuhw85BXVDwN+xtyYGPTOXzyfq6K3jFryvMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvvSEmaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDF0C4CEEB;
	Wed, 13 Aug 2025 10:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755080537;
	bh=V62ybuXf7lxlceY1ITNzm5Kpk7PiTfVAx2VTMsZdg3E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bvvSEmaTwuIOh8JdK3OhdKPXSrOEZRS/lChBGQRanrofZs9LhnwMLcSqTLmr2bdhV
	 L1HMSpnLZdnkKWIkQt1NsgH80J3Uea8KtIEFYBjnklVmCCkS93tzG+VuexoWx5+ayh
	 8bhfwxgw5y3ZJPIRD1jpE9D6CeuXnY8KHPJ8tzDk1k4lACvuBhZlkX6RU1ef20xW5o
	 BCZWeyBhFxCf4ijF1H9xlpaFR5W6g/CLXOpOoRm9hkIQ7Gwa5i1OR1U9qoSVraZy8D
	 YQ9Q/qfYb7HfHYN4R/Ny2FT8dbnT5nhdqNmoInEmCzaxKk8rG3Q5KvbHLBLVkRLJJa
	 VK3qXpPdBHJ3Q==
From: Leon Romanovsky <leon@kernel.org>
To: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com
In-Reply-To: <20250726013104.463570-1-yanjun.zhu@linux.dev>
References: <20250726013104.463570-1-yanjun.zhu@linux.dev>
Subject: Re: [PATCH rdma-next 1/1] RDMA/rxe: Fix rxe_skb_tx_dtor problem
Message-Id: <175508053394.73620.7382870062618496150.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 06:22:13 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 25 Jul 2025 18:31:04 -0700, Zhu Yanjun wrote:
> When skb packets are sent out, these skb packets still depends on
> the rxe resources, for example, QP, sk, when these packets are
> destroyed.
> 
> If these rxe resources are released when the skb packets are destroyed,
> the call traces will appear.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Fix rxe_skb_tx_dtor problem
      https://git.kernel.org/rdma/rdma/c/3c3e9a9f2972b3

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


