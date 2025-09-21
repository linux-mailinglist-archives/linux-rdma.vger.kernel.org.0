Return-Path: <linux-rdma+bounces-13530-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E07B8D9E7
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 13:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93EC3BD951
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 11:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65062260592;
	Sun, 21 Sep 2025 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMIjmad6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09DF258EFF;
	Sun, 21 Sep 2025 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758453779; cv=none; b=tdf2kHFH9Oh7QoyMazdtRa64DnP37d1tb2y2bV9u+k614k3XCeiokQhFeLFrOL4zroTKHOzzRGLfGwrZNmXDdcg7xX1R5QR0kOtTZqaFEn7ay1AJNt+fFL+fDFwZKOcLwNA8TenIjX9oW9B+QhWjJemC0neuEoLj+0yY7lgPNbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758453779; c=relaxed/simple;
	bh=inQtL3RJTMZEJkhkfxtys2AqIc8CL3lLmCa7tEI4KYs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XriCa6fQu/x7/WJgCTwACB4BKpnv5EbyBm/Dh3kphApYJk5jYV0oaw5dvXHbL7HjT14ys6xPtDQb+M75nDa66DzHJOqMsfbt24XAZm/ZxkjLelQmPobe8rflCjJCNmiS9d/3wbjUAsuRA8k1SHDS5SaI58YRp9cH+JxUTq346XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMIjmad6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DD5C116C6;
	Sun, 21 Sep 2025 11:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758453778;
	bh=inQtL3RJTMZEJkhkfxtys2AqIc8CL3lLmCa7tEI4KYs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pMIjmad6G1J4zMvP//707py+6Vnu85itajNDmTeLsFXtUqFS1P9a+FBSg/9BVnlhw
	 6QOXqeBkEHnFgiPToERs1xjsi9bLTNhor3DrqIxjOXJDi70UEpaVLA5DGEA8GzSb9m
	 goB9jqCg5EN5wo7r6oFDGGGzTlARR5r1BDrd1Y7R9Lb7Jb2b+yzgFgFNaB1EZeb3j2
	 ndYVssb1LSO7KtEXKLX3RNtfjKSiQXq9nXX4++BlAD62VQPYvB3sJT0AHUJIPNYEF+
	 PsGfr7LP0vAJlKw38R2ofzpYDWUUVDVrHM2pXLEwSAxAUFwJvenVRxggqgvLtLEGcW
	 azAn5J3bTKnVg==
From: Leon Romanovsky <leon@kernel.org>
To: zyjzyj2000@gmail.com, jgg@ziepe.ca, yanjun.zhu@linux.dev, 
 Gui-Dong Han <hanguidong02@gmail.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 baijiaju1990@gmail.com, rpearsonhpe@gmail.com, stable@vger.kernel.org
In-Reply-To: <20250919025212.1682087-1-hanguidong02@gmail.com>
References: <20250919025212.1682087-1-hanguidong02@gmail.com>
Subject: Re: [PATCH v2] RDMA/rxe: Fix race in do_task() when draining
Message-Id: <175845377558.2103402.2322215097092674955.b4-ty@kernel.org>
Date: Sun, 21 Sep 2025 07:22:55 -0400
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


