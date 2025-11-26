Return-Path: <linux-rdma+bounces-14785-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B981C8897F
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 09:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B9AED35473D
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 08:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E872E7198;
	Wed, 26 Nov 2025 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f75SyZIC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0892DE6E3
	for <linux-rdma@vger.kernel.org>; Wed, 26 Nov 2025 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764144946; cv=none; b=sm7OibiAdgtATKskOMoo2QcRskL0n5KLlETeqx7FRP91QiBFCnGmP4RKF41vpuKilAYLORv/9Rsh+RIOMB0HvW9lRgQeuvRiskgePDw06rspW1grfBq1ijANEC59g/mXwyI3jCaQQcQfMxOWG4GM3kEpVLv0lCjU1Nes3ebtAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764144946; c=relaxed/simple;
	bh=dfl1RFt81QcQcvjA1hPmD/z0FEfO8WGteXwKBg4mVoU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pbIsK3lPVwYHuI1CanRGKcbh3Q+njkALLTbmouJ4B3oug8FhU/Bii0+JLJYWeHtilttY9WQsFEq9pKorg2RhCxW43MSzY3Pk3cum0X8g/ZMX0GeQrK8r9Z2uwfsybDda7jbo2R/+rAcKBINLvYK+7Hvb/dPjhfTgPj972uLdeDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f75SyZIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FCBC116D0;
	Wed, 26 Nov 2025 08:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764144946;
	bh=dfl1RFt81QcQcvjA1hPmD/z0FEfO8WGteXwKBg4mVoU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=f75SyZICaTz7olKUMLLDvxqmNycIqJAUPZLWpJAYZqK6CKxL3Y3FBfhNG5hl2DdHG
	 66KTnTBFc77Y9+7rcEYML3mZasW2URZEGB9sM5WdTga2MR/EU5k79Zf0XdwyZKyjlX
	 hmUQ6BkyphvW8/khO8tqGnL45pBgto4g/YCISojmMHWRw65GXjDJQMXBDfgFdd8FCA
	 UXg207AJaEXSvgbAIVchWIVWO3/4FrXMIQhXn5XHUhLx1JzbgK9qD8HsXM0ZLB0Q9p
	 aZ0pSi1LB3xlixbOk8U10/4SHvIRtLgT63vGVibNVDkznY4SalCBQP5uZ+SwGAwUs6
	 anJbF5FMLrqnw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, huangjunxian6@hisilicon.com, 
 linux-rdma@vger.kernel.org, lirongqing <lirongqing@baidu.com>
In-Reply-To: <20251126025147.2627-1-lirongqing@baidu.com>
References: <20251126025147.2627-1-lirongqing@baidu.com>
Subject: Re: [PATCH] RDMA/core: Reduce cond_resched() frequency in
 __ib_umem_release
Message-Id: <176414494336.1826521.9199574832795686734.b4-ty@kernel.org>
Date: Wed, 26 Nov 2025 03:15:43 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Wed, 26 Nov 2025 10:51:47 +0800, lirongqing wrote:
> The current implementation calls cond_resched() for every SG entry
> in __ib_umem_release(), which can increase needless overhead.
> 
> This patch introduces RESCHED_LOOP_CNT_THRESHOLD (0x1000) to limit
> how often cond_resched() is called. The function now yields the CPU
> once every 4096 iterations, and yield at the very first iteration
> for lots of small umem case, to reduce scheduling overhead.
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: Reduce cond_resched() frequency in __ib_umem_release
      https://git.kernel.org/rdma/rdma/c/f37e2868792335

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


