Return-Path: <linux-rdma+bounces-35-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E11EB7F4523
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Nov 2023 12:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80DF9B2108D
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Nov 2023 11:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB69208B6;
	Wed, 22 Nov 2023 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TezZJbQk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0383025761
	for <linux-rdma@vger.kernel.org>; Wed, 22 Nov 2023 11:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE33AC433C7;
	Wed, 22 Nov 2023 11:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700653924;
	bh=kmu5K9PeiOyLrKg8cqwDWnPimJudkQD4ytSfTrPvZEE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TezZJbQkaMJDw9+qNQoWcDbzi2lJSnMk+4AB8JCULLCe2LZE5KrKAerGlxn8futoh
	 BtouuQ66s7rcN4k+9D4nDul166VWU8jCtKxMZgarEqRlOp6mgNwOPtErowL14bvBGc
	 kVeJbP3p6MdE+BYnPHPAKSgPwLIH8gE3H29zCX8Fxk/oR4fCBg2rgkZMpYDn2R1au7
	 +15I6dhip3rD8PLK//emBQavSy5ysLYbjiqmtIVAYiIInIiSuR7P3vVp/I+4+nCs3R
	 JqizFicCx1+hYF0z4n+wLks4zix8aSW9wjzK/ld+xvaWr/MXUtVlYEejfZM+p9ImKD
	 uSS7M9i2mnqUA==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc:
 linux-rdma@vger.kernel.org, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
In-Reply-To: <1700555387-6277-1-git-send-email-selvin.xavier@broadcom.com>
References: <1700555387-6277-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-rc] RDMA/bnxt_re: Correct module description string
Message-Id: <170065392024.28769.812824510752099489.b4-ty@kernel.org>
Date: Wed, 22 Nov 2023 13:52:00 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Tue, 21 Nov 2023 00:29:47 -0800, Selvin Xavier wrote:
> The word "Driver" is repeated twice in the "modinfo bnxt_re"
> output description. Fix it.
> 
> 

Applied, thanks!

[1/1] RDMA/bnxt_re: Correct module description string
      https://git.kernel.org/rdma/rdma/c/422b19f7f006e8

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

