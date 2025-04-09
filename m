Return-Path: <linux-rdma+bounces-9290-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A694A82361
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 13:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5726717E0E2
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 11:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF28F25DAF3;
	Wed,  9 Apr 2025 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8t7VrR/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7784C25C6FB;
	Wed,  9 Apr 2025 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197638; cv=none; b=PlgsPnjs64FoC57YvyKr8Gy+QW4BEbL8CdyhQMHm+6BIn7n1FYDv/k+R8ypYEpse1j2xLxUbTS0wV8zlbcsSdJSUMNeJ2J/VYVBzw+d4wkLDXJ9NBZKGoB4k0U6J6krLPKywg46VhIqlNc89D3agjWsfpCfwlovTTk/n6taDD2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197638; c=relaxed/simple;
	bh=kQ3av6akCnzRh9ZgnPfK5Lh+ld6NFHODijIeHOoTRAQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QZh7I0e59BEayE1+oPy/Mt6Q8J3NM4XYepH2QmRkBulR3OcS/9ux+su2V/kycoYQ83THD+XmN+90T1GvSqsyK4xG9w2gnxfOqEWcTIp5eHMb8OwsurcSbWrvl0mQQ1XzlUUPkfMAp9obcsABzt7o3yf060yQ3cSTyJuSG4gn5ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8t7VrR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D7BC4CEE7;
	Wed,  9 Apr 2025 11:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744197638;
	bh=kQ3av6akCnzRh9ZgnPfK5Lh+ld6NFHODijIeHOoTRAQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=t8t7VrR/laewHRaFKc2AIUfZojdILaXQagD7f0Of4Swlne9WnF+OnChjMmuuiT4+1
	 ZN7IdCKV3kBCDUvLY8tYX2Ptbqj/d8uNPPlkHQpXEnucKPnit2gaSs3n8h9U+wHyl1
	 6/ZWZjiprYC/XEnzPmQFr0xAekicihm1HYsQ4HZ9SdEsksywpgheTGawvyss8RsUsd
	 2vML3gp805PEsJa5aDlecTsmQSrOOrvoZ7gOdPzKwJyuw5FaMVIR9BM9O1xzOQ6qBK
	 +TLij76edIqDTazdQjG26ve0al4QsMQrAttoaktt4FOvZrjvIdkTE0SjC/93++Ghxl
	 5b0yJ6wWaRw6g==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, phaddad@nvidia.com, markzhang@nvidia.com, 
 Sharath Srinivasan <sharath.srinivasan@oracle.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, haakon.bugge@oracle.com, aron.silverton@oracle.com
In-Reply-To: <bf0082f9-5b25-4593-92c6-d130aa8ba439@oracle.com>
References: <bf0082f9-5b25-4593-92c6-d130aa8ba439@oracle.com>
Subject: Re: [PATCH v2] RDMA/cma: Fix workqueue crash in
 cma_netevent_work_handler
Message-Id: <174419763484.373763.12978802764991350026.b4-ty@kernel.org>
Date: Wed, 09 Apr 2025 07:20:34 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 26 Mar 2025 14:05:32 -0700, Sharath Srinivasan wrote:
> struct rdma_cm_id has member "struct work_struct net_work"
> that is reused for enqueuing cma_netevent_work_handler()s
> onto cma_wq.
> 
> Below crash[1] can occur if more than one call to
> cma_netevent_callback() occurs in quick succession,
> which further enqueues cma_netevent_work_handler()s for the
> same rdma_cm_id, overwriting any previously queued work-item(s)
> that was just scheduled to run i.e. there is no guarantee
> the queued work item may run between two successive calls
> to cma_netevent_callback() and the 2nd INIT_WORK would overwrite
> the 1st work item (for the same rdma_cm_id), despite grabbing
> id_table_lock during enqueue.
> 
> [...]

Applied, thanks!

[1/1] RDMA/cma: Fix workqueue crash in cma_netevent_work_handler
      https://git.kernel.org/rdma/rdma/c/052996ebc39e3e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


