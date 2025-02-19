Return-Path: <linux-rdma+bounces-7869-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3350EA3CB9C
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 22:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23BC3189BCF5
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 21:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755A12586C4;
	Wed, 19 Feb 2025 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dDi/8++H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0192580E0;
	Wed, 19 Feb 2025 21:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001007; cv=none; b=jdoc+iPQ7iK7ZoNmZ5aynUnGsu7LvKvTj7qV78TJRUTgkXoqTQ6lUf2Aj085U6yZhO+HLfvJAoZcygJQG/AGcLwGQaPHAv2z/RCHJ2vD4KjK5mEnPbO91Rrul2xdrSPc/V42QSPvLPhJ0jpd7vJ9sCUEYoMsUg5avh7t6R9eQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001007; c=relaxed/simple;
	bh=0bKLppM5g/3A1DAJuexX2Tb/L9vo5gPF2AnLV4uW634=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qEAOK23KDJIpKTgSP1/op/CTuZ9UAUAet45SEoIT0xzxsKYm9DdVFXMYMT8ZaepwCcp1G4RBzBgCZkAGtpTGUAYiNKjFBXL0zTS4Z7SuwxzNXvz6If83kIvkBx+f4tvlrgdtVTWwxrQAdKaW2QUwzpXCX6WviLfA8yAvDDyDwJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dDi/8++H; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 360E42043DED;
	Wed, 19 Feb 2025 13:36:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 360E42043DED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740001005;
	bh=wr9ApNX1qIWKUdAkzKTxRstIniwQDx0WUWV75DUrwv8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dDi/8++HD20SSQWYe8yngpHJdPVVzo/2/oxSkFIQLk5ERTp7eUnX201jVb4wdlAf0
	 AiRhgn+vC/za09yXOSG/X62qlQ5YUNd2cLb9ooPtSKL6jbG6fEaMNXLW1gISl25D/+
	 zNtc3fbLOPBYMniMhxmeYpWHn0lXRDvUJuL5JgVs=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Wed, 19 Feb 2025 21:36:40 +0000
Subject: [PATCH 2/2] RDMA/mlx5: convert timeouts to secs_to_jiffies()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-rdma-secs-to-jiffies-v1-2-b506746561a9@linux.microsoft.com>
References: <20250219-rdma-secs-to-jiffies-v1-0-b506746561a9@linux.microsoft.com>
In-Reply-To: <20250219-rdma-secs-to-jiffies-v1-0-b506746561a9@linux.microsoft.com>
To: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
the following Coccinelle rules:

@depends on patch@
expression E;
@@

-msecs_to_jiffies(E * 1000)
+secs_to_jiffies(E)

-msecs_to_jiffies(E * MSEC_PER_SEC)
+secs_to_jiffies(E)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 753faa9ad06a8876d4f7c848823825d55df9a43d..86c925489e8179fa2c311ff9ce38c9d51f200649 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -525,7 +525,7 @@ static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent)
 		ent->fill_to_high_water = false;
 		if (ent->pending)
 			queue_delayed_work(ent->dev->cache.wq, &ent->dwork,
-					   msecs_to_jiffies(1000));
+					   secs_to_jiffies(1));
 		else
 			mod_delayed_work(ent->dev->cache.wq, &ent->dwork, 0);
 	}
@@ -576,7 +576,7 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 					"add keys command failed, err %d\n",
 					err);
 				queue_delayed_work(cache->wq, &ent->dwork,
-						   msecs_to_jiffies(1000));
+						   secs_to_jiffies(1));
 			}
 		}
 	} else if (ent->mkeys_queue.ci > 2 * ent->limit) {
@@ -2039,7 +2039,7 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 		spin_lock_irq(&ent->mkeys_queue.lock);
 		if (ent->is_tmp && !ent->tmp_cleanup_scheduled) {
 			mod_delayed_work(ent->dev->cache.wq, &ent->dwork,
-					 msecs_to_jiffies(30 * 1000));
+					 secs_to_jiffies(30));
 			ent->tmp_cleanup_scheduled = true;
 		}
 		spin_unlock_irq(&ent->mkeys_queue.lock);

-- 
2.43.0


