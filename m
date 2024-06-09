Return-Path: <linux-rdma+bounces-3016-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0D29015BC
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 12:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943B6281778
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 10:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EB42233A;
	Sun,  9 Jun 2024 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ez2m5+Jj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D531CA96;
	Sun,  9 Jun 2024 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717929983; cv=none; b=LhwSXSVeCvmkE25h1lJcK0Me0UihQZiHEWYUH3aMtcMs9KD6qmfBq83+/2y875yk5nIolv40N9BGo4uGnVBrGm0H0Lx/3naOwAIA+0FPygpPP+U+ydO0nuhaNKdwBK+MCBKhC/j5s4RJUI61hRltymI2u3b1yGxd008lcKJbeoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717929983; c=relaxed/simple;
	bh=HWBx5sSA500nujgRb1CbV9/3n/Vy8OR9DvKAIODjLgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKMwsjUReVvCD47cXBhKQH9pAOx4FfTnAbIeWXA97Mdtt/a4B3rhYXwgJ3FeTw0T8z8TW4PyA99n8O5TDHrbAnc61Y+VSTZIdQ0fVALpYb74RENepdtbOWh5uEmu2EtZtjkEM9Mz+MuYA4sDoGcggWNz00wu2rv0AXnFofs3yy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ez2m5+Jj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5748C2BD10;
	Sun,  9 Jun 2024 10:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717929983;
	bh=HWBx5sSA500nujgRb1CbV9/3n/Vy8OR9DvKAIODjLgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ez2m5+Jja+FiWJNqcR5CT8KCcLA5T6O2ahemZ/UIvY25VxkUaT06AyKaliPDWYYk8
	 xDa2t8NnhWvVOxylLm+bPMCKCgbrRvrBvyUQzbAWz4Br21aVGDwMC9bNV3tabIrvnV
	 c652ewqHRWlEVOh/1JnTbzi9rMQpTzRgSHk8OBs5RByyOlUmHDu70QlV5Nr5mcAhM4
	 lH6PkIkSCQe2F84Bkyy9Dxty1Mgwh33nRowzjMOa2zIuXLP41c7mcjoNerzIxwYJGW
	 laU6ctgTu4c9LsRugs6jpdthKcNWU9W5Z08d0mCNCL4oiK76cYw/OalA81bgCmCpeG
	 awqPMGJ1EUP3g==
Date: Sun, 9 Jun 2024 13:46:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, weh@microsoft.com, sharmaajay@microsoft.com,
	longli@microsoft.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana_ib: process QP error events
 in mana_ib
Message-ID: <20240609104618.GC8976@unreal>
References: <1717754897-19858-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1717754897-19858-1-git-send-email-kotaranov@linux.microsoft.com>

On Fri, Jun 07, 2024 at 03:08:17AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Process QP fatal events from the error event queue.
> For that, find the QP, using QPN from the event, and then call its
> event_handler. To find the QPs, store created RC QPs in an xarray.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Wei Hu <weh@microsoft.com>
> ---
> 
> v2 is the same code, but some code is moved into helper functions
> 
> v1->v2
> * Introduced helpers to add and remove QPs to/from the table
> * Introduced helpers to get and put QP references
> 
>  drivers/infiniband/hw/mana/device.c           |  3 ++
>  drivers/infiniband/hw/mana/main.c             | 31 +++++++++++++++++--
>  drivers/infiniband/hw/mana/mana_ib.h          | 23 ++++++++++++++
>  drivers/infiniband/hw/mana/qp.c               | 20 ++++++++++++
>  .../net/ethernet/microsoft/mana/gdma_main.c   |  1 +
>  include/net/mana/gdma.h                       |  1 +
>  6 files changed, 77 insertions(+), 2 deletions(-)

Please run checkpatch.pl on your patches before sending them. I fixed it
and applied.

➜  kernel git:(wip/leon-for-next) mkt ci
878a8e752041 (HEAD -> build) RDMA/mana_ib: process QP error events in mana_ib
WARNING: line length of 88 exceeds 80 columns
#133: FILE: drivers/infiniband/hw/mana/mana_ib.h:340:
+static inline struct mana_ib_qp *mana_get_qp_ref(struct mana_ib_dev *mdev, uint32_t qid)

WARNING: line length of 82 exceeds 80 columns
#167: FILE: drivers/infiniband/hw/mana/qp.c:405:
+       return xa_insert_irq(&mdev->qp_table_wq, qp->ibqp.qp_num, qp, GFP_KERNEL);

WARNING: line length of 81 exceeds 80 columns
#170: FILE: drivers/infiniband/hw/mana/qp.c:408:
+static void mana_table_remove_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)

Thanks

