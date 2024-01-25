Return-Path: <linux-rdma+bounces-744-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F1883BE63
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 11:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C49B2CAD2
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740AF1C6BD;
	Thu, 25 Jan 2024 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpG/O3N1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FE11B96B
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177259; cv=none; b=JettGfk37jT9R17az+YemsZCVc3dYb+iKzZ9xFfQTJbBP/jzBUUJsDa91gOd7ssQiq1CGGbyduiAMAyVqWjLRyGY/wumY1a+U4ag84dWlYfPVDk0fD217Q3Xhlsk7R9Ak/t6/xQBG2fSLTvSQIdY0PLIvrWeeGF8YX8xAI/Fvro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177259; c=relaxed/simple;
	bh=aHPaSkzb+rgTb7ZFj+bRbxjl/FCVoHmrHIozdqoOz8U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fhlwzzU0yXPzCdc14X2X4/GPKkM7rzug5TwFA6TTg/BTtMtB7tXoEi/NivxBw9IBm/0t9Ax1fjN7Ubj5RI2TRR1ZTbENAdJX05Cp+dRtQBP5CU+KCxZki21YzzwPiEsrTFYgMC+E0cRxhH5Cq53aVlmkdEExwyj0qSbOB63M9mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpG/O3N1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27688C433F1;
	Thu, 25 Jan 2024 10:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706177258;
	bh=aHPaSkzb+rgTb7ZFj+bRbxjl/FCVoHmrHIozdqoOz8U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JpG/O3N1cjBHk763LIOBNSJQ1M9XuZajbuJwVz7m7YJ2nyEDbRVTbAapmuZWi0rEm
	 FzmeBEhlN/aNUGSYRPm60RJTM9qhy5mWkHR1ACRaILJgvsyCzPh275bJYA+UqMYlG2
	 C8o9zhjRWTHEE9kB56wqbszOvAoJZcnuz5vODh8h+6zN0JfJSqjijVa7py0/blErUS
	 s1/g4IQ3S4fnEo19v/D6+UfskwqAW5K06WtPaVzcy+JlbUSfpRFITnPWY9YWHToRw9
	 AwLwYhd/l7y4t7iGv9BTi4K827NXFbg36ymF9ZI6iOqIM4dDUa0YBHXH19O0NDzO/N
	 7LP/mzFFe0R3A==
From: Leon Romanovsky <leon@kernel.org>
To: Potnuri Bharat Teja <bharat@chelsio.com>,
 Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>
In-Reply-To: <a67881e7-469b-43d9-9973-ad7579eb2c4b@p183>
References: <a67881e7-469b-43d9-9973-ad7579eb2c4b@p183>
Subject: Re: [PATCH] cxgb4: delete unused prototype
Message-Id: <170617725443.635461.32554775122593319.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 12:07:34 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Tue, 23 Jan 2024 13:32:59 +0300, Alexey Dobriyan wrote:
> c4iw_ep_redirect() doesn't exist (and g++ doesn't like it because "new"
> is reserved keyword in C++).
> 
> 

Applied, thanks!

[1/1] cxgb4: delete unused prototype
      https://git.kernel.org/rdma/rdma/c/9bd5653f76772c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

