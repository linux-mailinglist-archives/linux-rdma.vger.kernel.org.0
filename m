Return-Path: <linux-rdma+bounces-6719-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD889FBB55
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 10:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4BD1164EA0
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 09:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8861F190072;
	Tue, 24 Dec 2024 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYdBtzM6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C6286250
	for <linux-rdma@vger.kernel.org>; Tue, 24 Dec 2024 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033080; cv=none; b=Gu1eJzl9BdWKdi1SdRIUALHw8FSPNmIMBNN64hI3cQ4LmVPIDF+zUrsWfpAnRqYzkoe2payymuiKI2d+9M1/T6TRxnpYD7Hqrf1f22JwdCFDxUGTrIcTac978syckdIjoIFSFHh/eSZ2z5YZiIPKXXrTj/GKIDJLP5WQXKAyqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033080; c=relaxed/simple;
	bh=PFgmKjQBf/cNxxAZScZn/nG1EkWaWnl5WSS4Qj9B7GE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FL3sGrloTqy/fjxypbbg6z6PsTOWr/qLs76H7ec+Xt9tR+Fix2c0rCeCV6R5LDs7yz0fsVaA5VSA2rhKGhK//y2d3yzGSh6kOo1NurCzKufOeWFBaBj7K98ZHGojsneI/b2aXQn1gCI6PUKDrKkitMCt+OBL0Tlc7oebRd1ufbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYdBtzM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7B8C4CED0;
	Tue, 24 Dec 2024 09:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735033079;
	bh=PFgmKjQBf/cNxxAZScZn/nG1EkWaWnl5WSS4Qj9B7GE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dYdBtzM6hp3D74ayYJwqsC95bvBEhK5Q/R1AFgVjMrJ9rGl+WZRHNr3NQLd0g3b8t
	 PxAmcoPipCVePryC+wmbTiva8bNV01fqPTA+cs1uVye0VK7IcGMxWBBA1A127TdhDE
	 TFIFSi/ojNKix/NzmUF0abpl0YVhjRW/b0GzqDOpVXuCMSxBsDvNkbs9evzgb+LE2O
	 8NLO70A5bKzrkVo7kzmgkZvA06zRBmxeR8AEOjRLBS+IR2bk9khY+zp6TTZnApDczT
	 QD3ew5wSt0gY/xj2uNNujTyeliwtxMc63OjmNSPZy7Uhh/V+jsZhMENUOHfPlLkyxg
	 nI2msJEqAuMXg==
From: Leon Romanovsky <leon@kernel.org>
To: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
In-Reply-To: <20241220222325.2487767-1-yanjun.zhu@linux.dev>
References: <20241220222325.2487767-1-yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] RDMA/rxe: Remove the direct link to net_device
Message-Id: <173503307672.412749.12115010936328461187.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 04:37:56 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 20 Dec 2024 23:23:25 +0100, Zhu Yanjun wrote:
> The similar patch in siw is in the link:
> https://git.kernel.org/rdma/rdma/c/16b87037b48889
> 
> This problem also occurred in RXE. The following analyze this problem.
> In the following Call Traces:
> "
> BUG: KASAN: slab-use-after-free in dev_get_flags+0x188/0x1d0 net/core/dev.c:8782
> Read of size 4 at addr ffff8880554640b0 by task kworker/1:4/5295
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Remove the direct link to net_device
      https://git.kernel.org/rdma/rdma/c/2ac5415022d16d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


