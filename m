Return-Path: <linux-rdma+bounces-15509-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBB0D192DE
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 14:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86C4330223CF
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 13:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C393904CF;
	Tue, 13 Jan 2026 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfUYl23X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3F258ED7;
	Tue, 13 Jan 2026 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312376; cv=none; b=TEa2sG67sLRJSYAJGIDXK91+dId7a17W20b7yW7YdmSpqXevpcVGoEsQ71WGa+TYcwDjMkOai78ua4c5yMa/uKnnKq8BNKEpo/FIfbeZomx3AtRBr2027C5Q0H4F2F9YBxb4bcgtlFMbEeUPG64GWYrSJxKUEQfSz+1DKUIE6SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312376; c=relaxed/simple;
	bh=w58LmoBHKY5BVcjigBuuR/7P7niGaJApjKTBjqsK4f0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=vCgMm4qPTp5QaJm+qd6NvDjMIl+l6uTXLS7R02rAL5/g4pj5sBCxn8jQSfRgM2f7uNZ8sFVTWQNqlpOY5WPnmbC5U2IUdcUg+vDopJGHXZUo4+q9TrwuitpId2q6VZrZbsM21LmT94JrZpi1hjAndlzhKjjqyYBVmatdhinbpFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfUYl23X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCB2C19422;
	Tue, 13 Jan 2026 13:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768312376;
	bh=w58LmoBHKY5BVcjigBuuR/7P7niGaJApjKTBjqsK4f0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=IfUYl23X7TtH4l3h/VWeKM8VyCgsvwYO8YwBbAbluEqCHaD2Cb2Na7Q5pCLoQr6Lx
	 9XpkBmHwd/Np63j73guKvZ76RedDVDo/2rydZJI2VFUGWC66s3KfHg6sqHWIknNG1s
	 9MDNHrOBDyP44kNWziiEBwv03thV1fgSCh+b736gJFrc1L5zsViEietrvdFkeDm9/U
	 wcIJ1xeI4q/nQ3ZUMPQCQnMpbQDdKd0ImkD9VED0mEEWLkN11YoeSFkcfnfv/hxD0R
	 SRH5z1sX8f44PEOEm91WiDYK5VS2mgd6usniaOqtAkh6Ta6w6H4eKZIkh+ljtWH1o+
	 Fpnu6+KDEXiwA==
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiasheng Jiang <jiashengjiangcool@gmail.com>
In-Reply-To: <20260112015412.29458-1-jiashengjiangcool@gmail.com>
References: <20260112015412.29458-1-jiashengjiangcool@gmail.com>
Subject: Re: [PATCH v2] RDMA/rxe: Fix double free in rxe_srq_from_init
Message-Id: <176831237357.425757.8303337207622192436.b4-ty@kernel.org>
Date: Tue, 13 Jan 2026 08:52:53 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Mon, 12 Jan 2026 01:54:12 +0000, Jiasheng Jiang wrote:
> In rxe_srq_from_init(), the queue pointer 'q' is assigned to
> 'srq->rq.queue' before copying the SRQ number to user space.
> If copy_to_user() fails, the function calls rxe_queue_cleanup()
> to free the queue, but leaves the now-invalid pointer in
> 'srq->rq.queue'.
> 
> The caller of rxe_srq_from_init() (rxe_create_srq) eventually
> calls rxe_srq_cleanup() upon receiving the error, which triggers
> a second rxe_queue_cleanup() on the same memory, leading to a
> double free.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Fix double free in rxe_srq_from_init
      https://git.kernel.org/rdma/rdma/c/c5ea4126b4fa1f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


