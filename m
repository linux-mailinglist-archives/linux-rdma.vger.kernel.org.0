Return-Path: <linux-rdma+bounces-14344-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D1AC43C9E
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 12:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D788C3AC841
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 11:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFA92D5C95;
	Sun,  9 Nov 2025 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deJxUp6l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F216E25783C;
	Sun,  9 Nov 2025 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762687875; cv=none; b=rJZ7jTYyatowPkBLy1X/PbyzUNxKcPVlsWC19le5SfNuELPbIXDAP41BIXzrl8xwPUskK/ozmhNrf8HR3EBd+vzZRTlSB5YcU7YkhHKGqUBZ8iEnhIN1b9mwYP4eyBSi/YQiktmIAeIMeU0ei5SD1FPHU75xzQKwq3aw5/NjwGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762687875; c=relaxed/simple;
	bh=/t3nhGBWYJVmx1eyss4OPjWCLjTiWfrwx5H43pyQETI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oL/q1SmJ+eSl1qAV3LrTMFdys9mehvpJ64/e3s4jIpraYp3nU/gR9FdEeeVDU54D6j99Xv6zE09lRER4rztn0rn7q/n9FefLCOYOAXdsWXjIzz7ha6395k+KUDNsKW87nh7FnXtqnJCic9ORZICB1wd/GSXRBZ9ayERVqaBv6sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deJxUp6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1207C4CEFB;
	Sun,  9 Nov 2025 11:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762687874;
	bh=/t3nhGBWYJVmx1eyss4OPjWCLjTiWfrwx5H43pyQETI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=deJxUp6lTQ2WwxVf0GEeFChiuZAaH0c2uu3jCGdJOK5TT6qWNTd1iRuJGazMSckwq
	 oYJFCleQq5BYhimDDXab8s+CEVNjBCxOwOwrO2T9AdC9QsN7XxtbdpFOn2kQHI1dq8
	 XsNmI/wsSyhFuQE6HAklFuGj3xkntwcd5lEJXaPs5nE8BDyq++WleJBFtAegeRIbz8
	 5YtcvYfWch25dQ31L4DygpzJFOlTPTSTwjBewpo0ABd3z09y049JeyhTtsxLR0MSrO
	 rPZUx425XUZiegvoHelCI5+WJj5ZDokTtVkhqF0+wk3bn710dnATCsSNAGYcCMQxkn
	 HqRXabWw8pSaA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Sagi Grimberg <sagi@grimberg.me>, 
 Max Gurtovoy <mgurtovoy@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20251107133306.187939-1-marco.crivellari@suse.com>
References: <20251107133306.187939-1-marco.crivellari@suse.com>
Subject: Re: [PATCH] IB/iser: add WQ_PERCPU to alloc_workqueue users
Message-Id: <176268787124.581844.15968812562799652549.b4-ty@kernel.org>
Date: Sun, 09 Nov 2025 06:31:11 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-3ae27


On Fri, 07 Nov 2025 14:33:06 +0100, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> 
> [...]

Applied, thanks!

[1/1] IB/iser: add WQ_PERCPU to alloc_workqueue users
      https://git.kernel.org/rdma/rdma/c/65d21dee533755

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


