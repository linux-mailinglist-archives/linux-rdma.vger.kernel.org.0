Return-Path: <linux-rdma+bounces-14345-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3585AC43CA7
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 12:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7C11888FCB
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 11:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740912DC771;
	Sun,  9 Nov 2025 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvz1Hiyf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29A25783C;
	Sun,  9 Nov 2025 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762687878; cv=none; b=LbrRv2jsHNGdgFL5Ju7ENA0ZLxLyVSzHmIj59Zk8byHe8ohGqaxSjdJrBKpdKIHUwqU25BRvf8dP64i+YTDiQqr4etjPaOvI/rSBjDKEw5pH9875JTbs0Ga3tDs+bTEbJ0d+gAE1S19tZFYehN5YztAd/asrt6ds95un75OTJcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762687878; c=relaxed/simple;
	bh=1Yatb/ykXUTZrlYHa3ZbcQe2RhDuKYItCVhnnSRV5fo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cNHdAjXFbTpLT/rI7uffQBhZ7AjKrDhdi5wRGVFHOLHAvo3UO7P69m6TEAFiEH6++v8Y/F6RBz8dgLp0hKQLiNtZ/PmIyfZUnfTHnCahVAAUE7h4Lxki8km8u2FMLiUYLJxAgrtLGADQrnhvKDCOvJpN6liQCs4PNrItxVmT8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvz1Hiyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4339FC4CEFB;
	Sun,  9 Nov 2025 11:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762687877;
	bh=1Yatb/ykXUTZrlYHa3ZbcQe2RhDuKYItCVhnnSRV5fo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jvz1Hiyf2mxY+eGDxxqGW2N0/4F/qPTqAp/e693Xez7MuPffdWKQTz13+c1TlmqMI
	 psN2o9EnFZVbHEuDxkv5VTxhnTzRy9phbNeSdgMT0qhf/t8TsN+ZC5wh5KwnadiI3j
	 tKlccOPoOgLTQzGsuBv1rgkQr7xfQq/pAr4syH/DTb/LRZdurfcCNDS+67gHm1UjAt
	 /LwyeiO87Gjb0Fb1v6UA5mJ9bdyTs1MvbjnPpc86eXVkHtszsII8dvbdmctehol1Rs
	 n78Cieeb4YyAut7n7wEkF+gljfwCrCwarpincG0IfuDTADLq7CuOE7wyAZk9N4E5Tr
	 TyW571XH4sIRA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 target-devel@vger.kernel.org, Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Sagi Grimberg <sagi@grimberg.me>, 
 Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20251107133626.190952-1-marco.crivellari@suse.com>
References: <20251107133626.190952-1-marco.crivellari@suse.com>
Subject: Re: [PATCH] IB/isert: add WQ_PERCPU to alloc_workqueue users
Message-Id: <176268787482.581844.7324846885016543491.b4-ty@kernel.org>
Date: Sun, 09 Nov 2025 06:31:14 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-3ae27


On Fri, 07 Nov 2025 14:36:26 +0100, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> 
> [...]

Applied, thanks!

[1/1] IB/isert: add WQ_PERCPU to alloc_workqueue users
      https://git.kernel.org/rdma/rdma/c/5c467151f6197d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


