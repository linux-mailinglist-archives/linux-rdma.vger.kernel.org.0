Return-Path: <linux-rdma+bounces-1841-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B802189BE18
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 13:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5760C1F2278A
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 11:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A639657B9;
	Mon,  8 Apr 2024 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr3dkyip"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25EA524DE;
	Mon,  8 Apr 2024 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575538; cv=none; b=AAzKvdROpEUci+dMMj9fv4P6I/yjBpQJ4mmEovbfJMw3oVTjmuOz+Udt9ErmouLOSmLcAicDGdU7GxQwdm1aDgXcIhx4erZOyDiQz98Ln7k3fS37cz+qjlHpUW9FMTZDStSVsxscNVAUTTlRqxhck/fFqHXDr/urVvo088hOgdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575538; c=relaxed/simple;
	bh=IyrUUWbE81PAuk3ePnkrQDLNtnvEbHMxdjk0NjTxSFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOAOXoJFIVKx4x5xvthylIaUCWIc8hSsssRUaHhj+j4Kqk1f6203QrUsNoVYJWvl/AJ1CTewpGElmeYXiRWlJ2+Zb3rDWGjROXFGm6d0mx4gbv4uc+4c+b3+LSF1qSML9vnwN5Z1lzhnfnjB1q9nS+5aiEZPwXIYRHSleYyRN6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr3dkyip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0ED6C433F1;
	Mon,  8 Apr 2024 11:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712575537;
	bh=IyrUUWbE81PAuk3ePnkrQDLNtnvEbHMxdjk0NjTxSFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nr3dkyip0Of5+4mAbJdemfvH8XF+T8nVG+HSplTOPSXw2H64Jjm0v3Z6sj8JRby7q
	 uBT6rY74EZZs/72NmfWKpmKMxcHTHoT10q0vcQ//Z6Z9FKl9jjietXyeBqoTJrjtDy
	 kTLXeNcE5LxpkbZCLbZsWRMEElTffD9GhuAtxWnzVRczayHLq1KHIX4Ps31vhgY6/2
	 zks9vGIUAraf2Vixh5Np/QZ/+bX6Yr7bwy9AUaYWIsmUISMHYH0S2LD4YrmFmXBJYf
	 5U/YZME14lcGxilTCay+cbM+0G8JCXWhm3ZyUmUAdhPkREVjlKmCbtIildxGuWNFu1
	 bd+hvug0BUMtg==
Date: Mon, 8 Apr 2024 14:25:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com,
	jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v4 0/4] Define and use mana queues for CQs and
 WQs
Message-ID: <20240408112533.GF8764@unreal>
References: <1712567646-5247-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1712567646-5247-1-git-send-email-kotaranov@linux.microsoft.com>

On Mon, Apr 08, 2024 at 02:14:02AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> This patch series aims to reduce code duplication by
> introducing a notion of mana ib queues and corresponding helpers
> to create and destroy them.
> 
> v3->v4:
> * Removed debug prints in patches, as asked by Leon
> 
> v2->v3:
> * [in 4/4] Do not define an additional struct for a raw qp
> 
> v1->v2:
> * [in 1/4] Added a comment about the ignored return value
> * [in 2/4] Replaced RDMA:mana_ib to RDMA/mana_ib in the subject
> * [in 4/4] Renamed mana_ib_raw_qp to mana_ib_raw_sq
> 
> Konstantin Taranov (4):
>   RDMA/mana_ib: Introduce helpers to create and destroy mana queues
>   RDMA/mana_ib: Use struct mana_ib_queue for CQs
>   RDMA/mana_ib: Use struct mana_ib_queue for WQs
>   RDMA/mana_ib: Use struct mana_ib_queue for RAW QPs
> 
>  drivers/infiniband/hw/mana/cq.c      | 52 +++-------------
>  drivers/infiniband/hw/mana/main.c    | 39 ++++++++++++
>  drivers/infiniband/hw/mana/mana_ib.h | 26 ++++----
>  drivers/infiniband/hw/mana/qp.c      | 93 +++++++++-------------------
>  drivers/infiniband/hw/mana/wq.c      | 33 ++--------
>  5 files changed, 96 insertions(+), 147 deletions(-)

It doesn't apply.

Grabbing thread from lore.kernel.org/all/1712567646-5247-1-git-send-email-kotaranov@linux.microsoft.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 5 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Checking attestation on all messages, may take a moment...
Retrieving CI status, may take a moment...
---
  ✓ [PATCH v4 1/4] RDMA/mana_ib: Introduce helpers to create and destroy mana queues
    + Link: https://lore.kernel.org/r/1712567646-5247-2-git-send-email-kotaranov@linux.microsoft.com
    + Signed-off-by: Leon Romanovsky <leon@kernel.org>
  ✓ [PATCH v4 2/4] RDMA/mana_ib: Use struct mana_ib_queue for CQs
    + Link: https://lore.kernel.org/r/1712567646-5247-3-git-send-email-kotaranov@linux.microsoft.com
    + Signed-off-by: Leon Romanovsky <leon@kernel.org>
  ✓ [PATCH v4 3/4] RDMA/mana_ib: Use struct mana_ib_queue for WQs
    + Link: https://lore.kernel.org/r/1712567646-5247-4-git-send-email-kotaranov@linux.microsoft.com
    + Signed-off-by: Leon Romanovsky <leon@kernel.org>
  ✓ [PATCH v4 4/4] RDMA/mana_ib: Use struct mana_ib_queue for RAW QPs
    + Link: https://lore.kernel.org/r/1712567646-5247-5-git-send-email-kotaranov@linux.microsoft.com
    + Signed-off-by: Leon Romanovsky <leon@kernel.org>
  ---
  ✓ Signed: DKIM/linux.microsoft.com
---
Total patches: 4
---
 Base: using specified base-commit 96d9cbe2f2ff7abde021bac75eafaceabe9a51fa
Applying: RDMA/mana_ib: Introduce helpers to create and destroy mana queues
Patch failed at 0001 RDMA/mana_ib: Introduce helpers to create and destroy mana queues
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
error: patch failed: drivers/infiniband/hw/mana/main.c:237
error: drivers/infiniband/hw/mana/main.c: patch does not apply
error: patch failed: drivers/infiniband/hw/mana/mana_ib.h:45
error: drivers/infiniband/hw/mana/mana_ib.h: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Press any key to continue...

