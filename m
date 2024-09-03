Return-Path: <linux-rdma+bounces-4716-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3031F969BA2
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 13:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611E01C20B62
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 11:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BFD1A42C9;
	Tue,  3 Sep 2024 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjNjZ4J1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932A8195
	for <linux-rdma@vger.kernel.org>; Tue,  3 Sep 2024 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362713; cv=none; b=txa3cFuadxmISP+snr/9ZbatcrX70IZUQS6xn1iz7+sKNyJaWqEx4M1ZnzTwyRKLlFfFtMz2lI+RZ3+Xm+DbxbOVtRWCy8aJ1crBKN7mddg4EduO1/f154CiwWaTt3EA42wcoctYPHGuopaeWxw6UZU+/m4yAYY8youKt8P7KRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362713; c=relaxed/simple;
	bh=W34hkfiTnRLL8AS6oJBPaXNqy3Gyeitd8fHDFZT7eqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btnHV9ZqPVlkfR+EN38K/4KWed1SD16fy2TmDms88m52VsSy0lz4ORXastwAdr82y5ckNnwfgvDUCMI09qMdT5QV64wYRYvR+Ahc0Od+W2ORkkliC6RGhXihaiVr7+0e0lfCgdJ5MeWSzj/rYoNUdmSDzqr54efyZjUlQgaYRcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjNjZ4J1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA325C4CEC4;
	Tue,  3 Sep 2024 11:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725362713;
	bh=W34hkfiTnRLL8AS6oJBPaXNqy3Gyeitd8fHDFZT7eqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EjNjZ4J1MzPqKz8L6ltA1PsxP5ImL7GsWWJjLejZSoVSLsxaT2ev65foFlPKKp3Qd
	 rduzFqOjJ7nrCjJc/fejWAxpME31bKAvEiOYkAvH0tnplof7FzENCSAP3X8NJ8rf8k
	 zSKqa63oOrsbYvt7bCUtATvrLDfFNO5HrUx3/vCJULNwg2ffXnachDlVsh9KieAaEZ
	 Q80uBQCemcu7iUkdP6nrK+E9doI2XBCkw1LbFqjh3tt8mSf3TkSj6ukBxjdXJa2Jwr
	 z7Jxdnnw0Ev2lBlO1r/koWEv/FoVSxx+nsT/LMPib8nwm9kXRpaugIYaeU08bugJC+
	 LhwxOF3wskX0A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-next 2/4] RDMA/mlx5: Fix counter update on MR cache mkey creation
Date: Tue,  3 Sep 2024 14:24:48 +0300
Message-ID: <0f44f462ba22e45f72cb3d0ec6a748634086b8d0.1725362530.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725362530.git.leon@kernel.org>
References: <cover.1725362530.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Guralnik <michaelgur@nvidia.com>

After an mkey is created, update the counter for pending mkeys before
reshceduling the work that is filling the cache.

Rescheduling the work with a full MR cache entry and a wrong 'pending'
counter will cause us to miss disabling the fill_to_high_water flag.
Thus leaving the cache full but with an indication that it's still
needs to be filled up to it's full size (2 * limit).
Next time an mkey will be taken from the cache, we'll unnecessarily
continue the process of filling the cache to it's full size.

Fixes: 57e7071683ef ("RDMA/mlx5: Implement mkeys management via LIFO queue")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 3945df08beec..80038e3998af 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -214,9 +214,9 @@ static void create_mkey_callback(int status, struct mlx5_async_work *context)
 
 	spin_lock_irqsave(&ent->mkeys_queue.lock, flags);
 	push_mkey_locked(ent, mkey_out->mkey);
+	ent->pending--;
 	/* If we are doing fill_to_high_water then keep going. */
 	queue_adjust_cache_locked(ent);
-	ent->pending--;
 	spin_unlock_irqrestore(&ent->mkeys_queue.lock, flags);
 	kfree(mkey_out);
 }
-- 
2.46.0


