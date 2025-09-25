Return-Path: <linux-rdma+bounces-13662-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09611BA1463
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 21:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F291BC7C8B
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 19:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA4331D73E;
	Thu, 25 Sep 2025 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="LfT0Ka3M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3B246787
	for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830238; cv=none; b=JkSqjl/2O6uSsizLWCBSipfR1yanlCfPE7FZSzz+yXBFgI2HIEQD5iWFYCKobhnC/rDAbmhevwBT/qtyCvB0OaJgej762xow2M0W49RFLBSEco08NsWMLe4EYIZkbXo2i/ZMGGZkK2hjGC0Utcf5QZ9w0/+2Uz2/o0pDhXv3iHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830238; c=relaxed/simple;
	bh=ceHH3IWiGV3BdvhtaHzZJ3H6fS+G8Ki3Bma+PJK8TBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jwb8HkGRjviju+UOMmnN2UO74SZD2EbcSx5QrU59ANYxDRD5yjBEqTbMbfSQfYDd93Anx5UfN8BCG9LxpBgUu9/Iga6mJahpggBB39BRntQ6OBZZCPSjJ8mhvYuCAdm+gBGcy2rWSIzD+QnuVy798yolc6WYmFi8j83qcjZSnlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=LfT0Ka3M; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e317bc647so10024795e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1758830233; x=1759435033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8t1cmbuldlzF6KX2Rqj5ZAm/oa7fTEbzdh+kEVZm6Lk=;
        b=LfT0Ka3ML7xs+oahrSNfRh9zr1C8DkrLGj7t6XLQUocaj150xZxBxGTHfr2L4IxPLR
         yuq5KQpztYJnzfIo3Inpunj5Be2aTJQFcPk4Lcye+TX19C135kg8Jp5K1ABhCdPEbpCF
         cGWeJC53cXKoyjeLEBZSdNJ1fFOKeovFIVigOs5D1sJlpTUj43bUczAGp3GFiC3NYBmO
         mbXSqu5F1RsvgeJFkGMCoM5LTutx31i//K1YYs5DhbuyVCj4uywqYHyWYcBFIUq0vd7c
         v5uphJj1zYzsPilmo+WPJhuG4IfeOUptHjobVnUxfXFtrXOwG/GdmlV1tEz9QIWtt+Go
         tW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758830233; x=1759435033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8t1cmbuldlzF6KX2Rqj5ZAm/oa7fTEbzdh+kEVZm6Lk=;
        b=oVzKlKpzLgZNmDpYoWlES/1wTuXviq2g6odFlvUHVaOvHh1IHi15O4UhA7FqAVt/wd
         6+zJoDKtkaYINr47CfDM9gcQlMiRoZV27q/vaL35z+xvPa6wcKogDvE6v/PgiaWiKNNC
         yVH5vucU/BJm84asGjwE1gHwsxjORo3XQxwDC+kcksqN3w/y6/RK55TaGXJdqJI/RR7n
         pRdJSQOKKvVw6SSPiyqVn7DVLKoiu/N4PDbACfbX6FQeYhkVTSDAB29wjGgxQ5wF/ixc
         FdMvYyRLxv+v2S6S1Jy0WhNlkDWRu2Mp3+ngHCe9TMK2lmee+itKyixHsGet6gg07xpK
         nKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeJZVPORp8sNqHM3QJaghmwpckQ9XWi/VHHPtp93tBckPiWp+04afVyxikXVOonEk2S/UHTR6cGvp6@vger.kernel.org
X-Gm-Message-State: AOJu0YxXwGCk6pJyKxSH/pH196NgPz+jpSu7VGkuNk588vpR2Rupb979
	OWnH0ZB7qRtvF8lcncnIHKnpzCN3wq4FB6PBYMlX1Q0i1S5p7irupOSNEM/KJv+FcKWhILK7gF9
	YY+UIp2I6bSd/
X-Gm-Gg: ASbGncsC6Bosh0nVBHYpjD2c7TrUQ2GPbXsdkdKYJpZAe6gXMFgy3JkAO62ueiUEzFY
	05mSTAx4FWG3CwvdPvMvssx3EjMQzWW1HI3337uMFZsbSP+HE63iEoltaND5Raz7w1Y8dIf+I06
	vxq0eq8E8aEJTs1HtKvqKAYvkHoV5W83AWlWaZEXboo4zRRflyxoIelTK6FbAoDGDY7JUHHySM5
	aFrZJDonDv8RjDZ5JNbaaF8tFnUQ78PLjfUhK4PZoiMnPcdesQEXnhLx7gwVS1YkiggkelUycTi
	JuaWVnNZ23Gen1hRdQYAxoWN9TaV82dUXBAeaK5ualWtn14e1fh4jyyYskPPacHN1+pIngvOmWZ
	77w==
X-Google-Smtp-Source: AGHT+IGG4rQpAEs3KSwr2soh9X6HBNwrl1IFW/ev8oiIGHxU/rW0RIbLhVcfR2nFx4utAhjntsi3YA==
X-Received: by 2002:a05:600c:8a1b:20b0:45b:43cc:e558 with SMTP id 5b1f17b1804b1-46e32a185f0mr38233895e9.35.1758830233153;
        Thu, 25 Sep 2025 12:57:13 -0700 (PDT)
Received: from fw13-phil ([80.149.170.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33baab12sm45507565e9.8.2025.09.25.12.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 12:57:12 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>
Subject: [PATCH V3] rdma_rxe: call comp_handler without holding cq->cq_lock
Date: Thu, 25 Sep 2025 21:56:40 +0200
Message-ID: <20250925195640.32594-1-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the comp_handler callback implementation to call ib_poll_cq().
A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.

The Mellanox and Intel drivers allow a comp_handler callback
implementation to call ib_poll_cq().

Avoid the deadlock by calling the comp_handler callback without
holding cq->cq_lock.

Other InfiniBand drivers call the comp_handler callback from a single
thread, in the RXE driver, acquiring the cq->cq_lock has achieved that
up to now. As that gets removed, introduce a new lock dedicated to
making the execution of the comp_handler single-threaded.

Changelog:
 v2 -> v3:
   - make execution of comp_handler single-threaded

 v2: https://lore.kernel.org/lkml/20250822081941.989520-1-philipp.reisner@linbit.com/

 v1 -> v2:
   - Only reset cq->notify to 0 when invoking the comp_handler

 v1: https://lore.kernel.org/all/20250806123921.633410-1-philipp.reisner@linbit.com/
====================

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_cq.c    | 10 +++++++++-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index fffd144d509e..8d94cef7bd50 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -62,6 +62,7 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 	cq->is_user = uresp;
 
 	spin_lock_init(&cq->cq_lock);
+	spin_lock_init(&cq->comp_handler_lock);
 	cq->ibcq.cqe = cqe;
 	return 0;
 }
@@ -88,6 +89,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 	int full;
 	void *addr;
 	unsigned long flags;
+	bool invoke_handler = false;
 
 	spin_lock_irqsave(&cq->cq_lock, flags);
 
@@ -113,11 +115,17 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 	if ((cq->notify & IB_CQ_NEXT_COMP) ||
 	    (cq->notify & IB_CQ_SOLICITED && solicited)) {
 		cq->notify = 0;
-		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+		invoke_handler = true;
 	}
 
 	spin_unlock_irqrestore(&cq->cq_lock, flags);
 
+	if (invoke_handler) {
+		spin_lock_irqsave(&cq->comp_handler_lock, flags);
+		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+		spin_unlock_irqrestore(&cq->comp_handler_lock, flags);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index fd48075810dd..04ec60a786f8 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -62,6 +62,7 @@ struct rxe_cq {
 	struct rxe_pool_elem	elem;
 	struct rxe_queue	*queue;
 	spinlock_t		cq_lock;
+	spinlock_t		comp_handler_lock;
 	u8			notify;
 	bool			is_user;
 	atomic_t		num_wq;
-- 
2.50.1


