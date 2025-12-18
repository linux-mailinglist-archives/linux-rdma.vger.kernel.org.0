Return-Path: <linux-rdma+bounces-15072-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DF9CCC6CE
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 16:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3177430DE554
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9142E34B42F;
	Thu, 18 Dec 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsCMGf0u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAE634B427
	for <linux-rdma@vger.kernel.org>; Thu, 18 Dec 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070780; cv=none; b=ZYAZLuyUwzaR890Tnz1TXP2LUBWHhIZXCi/pmRppH2mPa2t9YAQsu9JiFhpsFksnHA21UU46+zck2igOdx4Si6Mu4lbGES0U/hGAKMf16piA4YlTJZwvBrvQliUX0PahCQcIcXAajiMWFsdLdnPklIUBn9wft0ZVcpCOC6o81qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070780; c=relaxed/simple;
	bh=cmZCfqvm1fN8PqepW3scvSB6hU3az5Qro7LF9B4PzUo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Oysph6PEruQYtip44DpgoSPA7DFTnBsVi4ZURpCo+2lgYnKyc7bGjKpaTYAGOdpKVqRZKw5U8ARFXkJ2HEafhuJr6vlk4EKmtGYN1MMuaM2qQpv1hOJCs9to+L5pRUqQD5z3olq3AFV28GKV23oyYRFggQCr3LnCFEwqC5toJj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsCMGf0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3C4C4CEFB;
	Thu, 18 Dec 2025 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766070779;
	bh=cmZCfqvm1fN8PqepW3scvSB6hU3az5Qro7LF9B4PzUo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MsCMGf0uIkwklJm/zaamdOPuKDUqh1wLQK2lq3BwB+XZGnICJFs63cqNlxe4t5qzX
	 gPeqh8kv8vRCCbZysyhmqFBw2cqY3kTD6k/ohYQUVOhyphZo15zgg3kSfaC+F5xwzO
	 0GyBp9ZjzmljCHxcecrIEzg8s0YZzy58G/gOz9t3Bqy1cPkZMvon5i9URNMLyGjLhH
	 nA0V7PVNNknNNKuojrrZE7/xr3ANyRGE85g+Yt7ygskK5CdO3RiTiyqIhnhg3FfU9H
	 pxiMGwhjT9QW2Bq1tejILP10XZjeIbdYpl+YWbpbNX5y+ow4Z7M5N11CkCIHGFENtY
	 ZMkCFGFWk6Rkg==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 Yonatan Nachum <ynachum@amazon.com>
Cc: mrgolin@amazon.com, sleybo@amazon.com, matua@amazon.com, 
 gal.pressman@linux.dev
In-Reply-To: <20251210130614.36460-1-ynachum@amazon.com>
References: <20251210130614.36460-1-ynachum@amazon.com>
Subject: Re: [PATCH 0/2] RDMA/efa: Admin completion context improvements
Message-Id: <176607077691.2393004.6291620235013556913.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 10:12:56 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Wed, 10 Dec 2025 13:06:12 +0000, Yonatan Nachum wrote:
> This series improves the EFA driver's admin completion context handling
> with two key enhancements:
> 
> 1. Add validation to check that the stored completion context command ID
>    matches the received one, improving error detection and debugging.
> 
> 2. Refactor the admin completion context state machine to be more robust
>    and easier to maintain.
> 
> [...]

Applied, thanks!

[1/2] RDMA/efa: Check stored completion CTX command ID with received one
      https://git.kernel.org/rdma/rdma/c/4b01ec0f133b3f
[2/2] RDMA/efa: Improve admin completion context state machine
      https://git.kernel.org/rdma/rdma/c/dab5825491f7b0

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


