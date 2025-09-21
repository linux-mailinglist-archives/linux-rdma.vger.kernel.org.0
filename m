Return-Path: <linux-rdma+bounces-13529-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416EAB8D9D8
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 13:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7A53BDFCD
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 11:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5405C25BF14;
	Sun, 21 Sep 2025 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhisSHv+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE91525B2FE;
	Sun, 21 Sep 2025 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758453775; cv=none; b=OwiSD8CO4AFFR1WEem75rY/Enz3ayKpc7qumA1J9bw9bVQOvE8dDh3+LU2lDMu1jl9Z+M51UYThGKg5pepy/hpn4tNysd0TFAHm+zYVKR/MY6L2uz9VcbYt8mFT8oJlGYXDYx/xylzbfK8v4+tFakwO3p6n63CuOSQ52k7D25Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758453775; c=relaxed/simple;
	bh=inQtL3RJTMZEJkhkfxtys2AqIc8CL3lLmCa7tEI4KYs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C17QYMMWyrFDN7HMlGx8JHwu9xlNndbJJ2/Lyhy0mup59EzsTEQQIJ5vFqIopyGE98L0XaGF6CIYlPOLSkBO0FaBbTHpa1ImYPqlqS8mUu7fHWX/bH1ni+IgSGI7JN/Es+/x0DO9FhRl7iuIpQ16qAHw8Mlw5OLT9askr+Xk1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhisSHv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062B1C4CEE7;
	Sun, 21 Sep 2025 11:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758453774;
	bh=inQtL3RJTMZEJkhkfxtys2AqIc8CL3lLmCa7tEI4KYs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FhisSHv+jlrpJ6bZ0SpPnlcyec9iQxFXHEAh1OtioxNCmuoAA4wP3S0lo/Espv03n
	 5Vzc0W+kg83XsicLsUMCZIWXOIGHMrntXxIchl6sAO9Qx98bwvFrKbif5yHx1Sobih
	 ZqFGKjcEW20GB4np5ThOadJnU0QR8AixEtOAf6OfPAK28ff6sgKXf8ePPlsyIwwyP6
	 o5dqH/1u7ZqaEADSFKpyRU5pSo/jiISN/APcfXuNrHKbXn/9JXjUUyr8lt6M++Ir1b
	 Ca4SrTqs2b66wQK2xKjC/7nYRSGRbwBkjukFVVeVP0e+UFZRKXf5HsDZFIfXuj2avE
	 dstGuoKo3rqCQ==
From: Leon Romanovsky <leon@kernel.org>
To: zyjzyj2000@gmail.com, jgg@ziepe.ca, yanjun.zhu@linux.dev, 
 Gui-Dong Han <hanguidong02@gmail.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 baijiaju1990@gmail.com, rpearsonhpe@gmail.com, stable@vger.kernel.org
In-Reply-To: <20250919025212.1682087-1-hanguidong02@gmail.com>
References: <20250919025212.1682087-1-hanguidong02@gmail.com>
Subject: Re: [PATCH v2] RDMA/rxe: Fix race in do_task() when draining
Message-Id: <175845377129.2103277.480564364685157164.b4-ty@kernel.org>
Date: Sun, 21 Sep 2025 07:22:51 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 19 Sep 2025 02:52:12 +0000, Gui-Dong Han wrote:
> When do_task() exhausts its iteration budget (!ret), it sets the state
> to TASK_STATE_IDLE to reschedule, without a secondary check on the
> current task->state. This can overwrite the TASK_STATE_DRAINING state
> set by a concurrent call to rxe_cleanup_task() or rxe_disable_task().
> 
> While state changes are protected by a spinlock, both rxe_cleanup_task()
> and rxe_disable_task() release the lock while waiting for the task to
> finish draining in the while(!is_done(task)) loop. The race occurs if
> do_task() hits its iteration limit and acquires the lock in this window.
> The cleanup logic may then proceed while the task incorrectly
> reschedules itself, leading to a potential use-after-free.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Fix race in do_task() when draining
      https://git.kernel.org/rdma/rdma/c/8ca7eada62fcfa

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


