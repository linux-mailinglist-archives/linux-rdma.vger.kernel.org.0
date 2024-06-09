Return-Path: <linux-rdma+bounces-3017-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46A99015BE
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 12:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016971C211AF
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79206208A0;
	Sun,  9 Jun 2024 10:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssHiIplw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3592A36AFE;
	Sun,  9 Jun 2024 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717929999; cv=none; b=EZT7+25VbqQH2F0mljXstvBRSfQrWjapoaabyX/vmd8Yb7m9zZnBjP2bjaOnXW+LYUaChse+H48ZzDZ9hCRp7WMEfKw+Cu0krBpkaocPnyC1fziW6w/CsBXShjxV2+GYOok/UmRfZcbUiZQ+2NVkKVUZ2xyj/VotpSDR42xwrUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717929999; c=relaxed/simple;
	bh=oZVyZWZZBwCAaUHsx7yaJXMgvc7Nm1hC3uysYJopNjk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kEUBgacVgxux/0eFYbVwY26gX8nxgp3Haj5u47adV2enUaRyGEFbGVhqcXB5WPWxEb4Yk50UofXTvZ1Fh2IC2DqBVg2TYF70dGSyWM6xvzINjG/7BSGnLFCIuKjfExZKepaPRmXtdrqos5fxKs5I4jy0taDGMKivBoh73MKQbrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssHiIplw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE3BC2BD10;
	Sun,  9 Jun 2024 10:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717929998;
	bh=oZVyZWZZBwCAaUHsx7yaJXMgvc7Nm1hC3uysYJopNjk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ssHiIplw5Pq7V6Eipz/ksHJztFGJwho0UsGUr8/SIwKnxbT/zK/iSwFw09IB5Gj7U
	 6DlfAABZYOD1oaAPA60iojCwS3/OYMbE/U58ipcWTh0a2tfje/Ofpnfjs8EQ/34mzV
	 DDJyMTwOM9rhK2KUTmImQUNtCyGUkdOOI3WM+Uuk3ODr3Tqn6vpw7zFcxP1Adxg0n9
	 nxyF0sdl7RObiHC5KV7DSfdbvLIH3nwzzJ2V+JqnYCIcun/jCRNZHPqkt3X/YgJRtZ
	 PDsAonNNL0THItFpVnDX4112aARQAaJCNWQvyiGM3c822mYFJn/D12u+SsuSEcFaPi
	 az0Eq+VxWgh2g==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, weh@microsoft.com, sharmaajay@microsoft.com, 
 longli@microsoft.com, jgg@ziepe.ca, 
 Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1717754897-19858-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1717754897-19858-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana_ib: process QP error events
 in mana_ib
Message-Id: <171792999432.122119.10829214321933939042.b4-ty@kernel.org>
Date: Sun, 09 Jun 2024 13:46:34 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Fri, 07 Jun 2024 03:08:17 -0700, Konstantin Taranov wrote:
> Process QP fatal events from the error event queue.
> For that, find the QP, using QPN from the event, and then call its
> event_handler. To find the QPs, store created RC QPs in an xarray.
> 
> 

Applied, thanks!

[1/1] RDMA/mana_ib: process QP error events in mana_ib
      https://git.kernel.org/rdma/rdma/c/52f803542f970f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


