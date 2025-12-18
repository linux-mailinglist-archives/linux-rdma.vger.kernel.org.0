Return-Path: <linux-rdma+bounces-15071-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE35CCC598
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 15:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CC91303C2B3
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 14:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7D132E733;
	Thu, 18 Dec 2025 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaxD7zwn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786C3319860;
	Thu, 18 Dec 2025 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766069656; cv=none; b=P32Su8UQxTOguM29+Q5aM/vxEJ5rU9Th91dcAbvm004/Xop0jUdAoqfa1fYz/xGjI7SGBvjkiAtW0gd71VmtJlQqzGBHqzeJPAfL1iW6elZXWRAgvB+Ja4smToMDaMZITZuqYaVotQ02pS0pUOzJKwjj4X3ZPKnM/7mK7xkBNs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766069656; c=relaxed/simple;
	bh=sAh8dSSSVtfKTIm0dgEiZ1Yp9EOrpUONPrnIPyU/MVk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QVJN4h6jKPDPWD4oaV1hoJ5D3b7dnwPLiazyM3FayaL0mwyLtFeBQIAV1o2QXnvBOWt/IilTGph7lXRvjgcKgyzitKdZj88spqCGbFR7HrCq8ofasvLRU3vuUAGOJVR+Bsn1YX5enmGlDJS1E9mSkcKlrnkUcCCs+ReolM7BY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaxD7zwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FD3C4CEFB;
	Thu, 18 Dec 2025 14:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766069655;
	bh=sAh8dSSSVtfKTIm0dgEiZ1Yp9EOrpUONPrnIPyU/MVk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MaxD7zwnTFcdIfTcanjb3q0aeetkQ4VvbZoLDzTouBxueicViHGOBDXXfSbA5UrQX
	 yiTTOuTKrFjKDYa6QENsKOszSKNwwHn5OXHsrtuMPwDJH5gWUrdoSYKVEr22mpEXf0
	 hfvX/BNYWvwXLr9C/G0U3hziP9Qgpb9S+FE7YtcQcIwxUYHtpDfyjIT98DoM/NkG2s
	 bHTXF+DPF2OQ5g4HEhL+exFrfD8FTjZdo+6G4XOKjrU8yB7gyN5LFyewx+bcknqLjw
	 lp2847pbqQWQ4QT7GEz6f+XcC9/760dBhIztGRPpgai8k2/2VwxjrYOMNK81COGLEX
	 /V3+byyxMxMBw==
From: Leon Romanovsky <leon@kernel.org>
To: krzysztof.czurylo@intel.com, 
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20251204092414.1261795-1-jiapeng.chong@linux.alibaba.com>
References: <20251204092414.1261795-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH -next 1/2] RDMA/irdma: Simplify bool conversion
Message-Id: <176606965243.2392657.5345718306904844926.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 09:54:12 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Thu, 04 Dec 2025 17:24:13 +0800, Jiapeng Chong wrote:
> ./drivers/infiniband/hw/irdma/ctrl.c:5792:10-15: WARNING: conversion to bool not needed here.
> 
> 

Applied, thanks!

[1/2] RDMA/irdma: Simplify bool conversion
      https://git.kernel.org/rdma/rdma/c/80351761facb63
[2/2] RDMA/irdma: Simplify bool conversion
      https://git.kernel.org/rdma/rdma/c/80351761facb63

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


