Return-Path: <linux-rdma+bounces-1979-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E237C8AA066
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Apr 2024 18:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E45CB21A54
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Apr 2024 16:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5D2174ED7;
	Thu, 18 Apr 2024 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S8gSEAbP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8114171E48;
	Thu, 18 Apr 2024 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459134; cv=none; b=jbf6zsvsksrXDTKLUIzTkhAJNsogx3sZo7seDhgnEN8F/Y62aiMW5LaHTf6x9AmV2KXwZ5LF4hxubOMgd7plNyGFH4qz35OwwQHZRZp7yLnegF1h1SHevt938vIxXD4ZDJfmqvIjIjJiw/r1IuhVqkxITFqyccR5svA1qNHbn0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459134; c=relaxed/simple;
	bh=8VcU7ok/r82OU+vZIxsUsvhZaWe+LK6zJdpDqotEYWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EAGqJpcySOuGL/CkJybB/pKv+MQ4c4WM4uKkc9gg1MC9EQwIRCQ7pmJbfak7CTP8N1Q6xMAzOfyBSuWvxq59lh7iWEyBTqzRt/Iz9rrX/mo2hmd1liALtTyVOVYkGz0HLeSGGwbUgip+T2GxTDwyytsLZYgpKFnwt3G5R0RtL9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S8gSEAbP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8B5A920FD8ED;
	Thu, 18 Apr 2024 09:52:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8B5A920FD8ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713459131;
	bh=/x44WfF5SQjqBQwqGks3DVpPDx/QzjlIKoFfU1B3cvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8gSEAbP7oFx+NXohcWbfbRDEZnrNibtPJo/tafCfJDOu8lxWfIdQRXsklDU6SH++
	 lr1jGiv6YQLHwZOtyntrpeh6m7vaZxToEJb5wMEio3qQWX+leeI079OwDmTWdBXkcq
	 t67gKLE9aCPiRqH47oGrfZQ3fQ9MZ+MFaZZkriyc=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 5/6] RDMA/mana_ib: boundary check before installing cq callbacks
Date: Thu, 18 Apr 2024 09:52:04 -0700
Message-Id: <1713459125-14914-6-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Add a boundary check inside mana_ib_install_cq_cb to prevent index overflow.

Fixes: 2a31c5a7e0d8 ("RDMA/mana_ib: Introduce mana_ib_install_cq_cb helper function")
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 6c3bb8c..8323085 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -70,6 +70,8 @@ int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
 	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct gdma_queue *gdma_cq;
 
+	if (cq->queue.id >= gc->max_num_cqs)
+		return -EINVAL;
 	/* Create CQ table entry */
 	WARN_ON(gc->cq_table[cq->queue.id]);
 	gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
-- 
2.43.0


