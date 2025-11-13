Return-Path: <linux-rdma+bounces-14465-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A58AEC57B7E
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 14:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 527DF34AC5E
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 13:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3641C84D0;
	Thu, 13 Nov 2025 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuDlv3x1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5E518024
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040945; cv=none; b=fJjPEa/pw7gZBrAXLBdpZz6eXjqcQW3Gu0fs/w1Ye3YJWGBX9lOQIdDJU7Mw9Sgbna0D8GtM53Jm9HIf4NfkOi+LbI5wmUHtEcZk/nCOI6qh56+3dxvmjNXcOJFOnRAPU0peNhy5h1dyunvJN3prLf0LG2yoN+pMfHW/89L679s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040945; c=relaxed/simple;
	bh=eOUEs+mf1pPuOTg8G2ZqjJ0ZWWFJy68Q+4RZnSH8aKQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d7TZRiuXLHZSpSrBfbgYc9ZRZc9CLATeRfvYi/846I7pJKtIOjGzM2UrvMi330vELKCP462q61S1Z1JJOUllHRToS5GTxzz8q3ymRxnZVA6lS0+rbPmOyGbGiql8+6VvbjIWiQtNpsWhdUFBq1kYk31N7cjBolHQM4zSbjSHRgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuDlv3x1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9974CC113D0;
	Thu, 13 Nov 2025 13:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763040945;
	bh=eOUEs+mf1pPuOTg8G2ZqjJ0ZWWFJy68Q+4RZnSH8aKQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=HuDlv3x1Z0WEKtFqDh3P2EwumqiQz6CHtvksA7DwfieMp/BXTK58tHZ3tdo4oynwZ
	 NP7+He60BUxBEww/3X9654N0AanOiKZgJtkZzzhURqOyqAminlPzTWFFl0inbFRnbZ
	 b55ou4nvAMh8eQpiVC22AFuX2SQPkyxxaGxbp1+TBZfZd1xPTQfxJpXyGIpVHj9O4p
	 QfvnC3kPfCg/T5snzxtuspnjgCulT2T9RBf8wQuqDEWa8bEdsO0N4XiUjTueWxO6i6
	 tO2jLqe79CTJIi1EFNEDCmdq73TZw9dj2oba8UWTNzSnU+XBYpxpgR5CU8nsXpPvyo
	 W6NQ3xnTs/SRQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, huangjunxian6@hisilicon.com, 
 linux-rdma@vger.kernel.org, lirongqing <lirongqing@baidu.com>
In-Reply-To: <20251113095317.2628-1-lirongqing@baidu.com>
References: <20251113095317.2628-1-lirongqing@baidu.com>
Subject: Re: [PATCH][v2] RDMA/core: Prevent soft lockup during large user
 memory region cleanup
Message-Id: <176304094179.1063970.14910186053761899333.b4-ty@kernel.org>
Date: Thu, 13 Nov 2025 08:35:41 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Thu, 13 Nov 2025 17:53:17 +0800, lirongqing wrote:
> When a process exits with numerous large, pinned memory regions consisting
> of 4KB pages, the cleanup of the memory region through __ib_umem_release()
> may cause soft lockups. This is because unpin_user_page_range_dirty_lock()
> is called in a tight loop for unpin and releasing page without yielding the
> CPU.
> 
>  watchdog: BUG: soft lockup - CPU#44 stuck for 26s! [python3:73464]
>  Kernel panic - not syncing: softlockup: hung tasks
>  CPU: 44 PID: 73464 Comm: python3 Tainted: G           OEL
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: Prevent soft lockup during large user memory region cleanup
      https://git.kernel.org/rdma/rdma/c/d056bc45b62b59

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


