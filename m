Return-Path: <linux-rdma+bounces-7866-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405F6A3CA78
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 21:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3197517A866
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 20:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4AA2505CD;
	Wed, 19 Feb 2025 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uTBxcHeu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EBF24E4D9
	for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2025 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998395; cv=none; b=D/EauotzTtSCWIaREOfcAIH0Lv5VZeyKBSGXFWHlIywGkO1tFJeTz2QlJJx6znsV7djM/r98DPUabmFEU25qQ++/VjjOzTg+2Khi02L4e8uvonoCq15KZF2lJs8ZQF7eM8Bq6ccXbTzl1UxZnuLAO24LCA08hbhqXcFuB4S+ALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998395; c=relaxed/simple;
	bh=M83TtgbrER6UNWgXcPNxTgIFEIobEBu4z+QkHohiso8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pnqq4/ttMLZUB7MIvc+c00LbmdZTyE170MXnbVTBNVeGXmojT7x0IpdhLyCKM6MVK9GnxQBOlcZFRMGVKwQUvlsTJxD172VhPTYw8NrYdaoJfmFXg2l8Od2iXbXr2BqdwRbNnPdqclfK8dBhSaudDQn4y4w7D74aBIfA5QFlFyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uTBxcHeu; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739998381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=62TWYWfurD75dgItUwaw8GfL5rYSw4VdoP88WF6wNFM=;
	b=uTBxcHeuhkYZRT5PoH5+j3vBtLhfGq+9oPay8WwmzGWjvb6VNos6fgyvVmy4ooyXneBXQj
	SIIfAXzI0RWeLvh/FAONkNWvu7n1G4IoYoWlTzBUU0klJ4MAw053iSbM5jzNdQH51fp/I5
	fs4T5Kpm+qtEDYgHFl6kEGkx3eO1n0s=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/mlx5: Use secs_to_jiffies() instead of msecs_to_jiffies()
Date: Wed, 19 Feb 2025 21:52:35 +0100
Message-ID: <20250219205235.28361-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use secs_to_jiffies() and simplify the code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/infiniband/hw/mlx5/mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index bb02b6adbf2c..b526e322c7b0 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -2033,7 +2033,7 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 		spin_lock_irq(&ent->mkeys_queue.lock);
 		if (ent->is_tmp && !ent->tmp_cleanup_scheduled) {
 			mod_delayed_work(ent->dev->cache.wq, &ent->dwork,
-					 msecs_to_jiffies(30 * 1000));
+					 secs_to_jiffies(30));
 			ent->tmp_cleanup_scheduled = true;
 		}
 		spin_unlock_irq(&ent->mkeys_queue.lock);
-- 
2.48.1


