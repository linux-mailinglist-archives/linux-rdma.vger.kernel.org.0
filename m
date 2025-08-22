Return-Path: <linux-rdma+bounces-12881-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD958B31197
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 10:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEE95C6020
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 08:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95B92EB5D1;
	Fri, 22 Aug 2025 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="w4O+TQhc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F292EA48B
	for <linux-rdma@vger.kernel.org>; Fri, 22 Aug 2025 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850823; cv=none; b=MHGsQlVi9Y1K6t45YHL49ZojgkR4bS48Oo3ikK+8EnCp4kfbpaT2Y2OtzyG4/eoXfdHvCUA3oo9yiZwRmKOasJLEYUokVdfGVFBccoYOjob8CXt7aSESWG6yxSFblh5Sjk0Cvr8d0geqWm2JQxhsQhcYwEDaOKTw3vcVkHPlYlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850823; c=relaxed/simple;
	bh=SoqeEvRyDj9xNZRwO+49resqGUPxezysRjpX7ed1NkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqO0KmebCtXQOV/HLJg5MIfNArHVLbV3zofXCumnu8Fe7ud1HfEYLN8ztayIYT360bU25xVVBYrutkhEWQkt5hxg/ahZcy9bm5T+FFbX+G4viY/NWky4P8KWzzM4KqgEstrLCHw7FmocoFUfpOhX1AE+HU9x8mji5ZRiL9+QMfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=w4O+TQhc; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-618b62dbb21so3709974a12.2
        for <linux-rdma@vger.kernel.org>; Fri, 22 Aug 2025 01:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1755850818; x=1756455618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JyWZRAhQvL3ZewOrTkNRPEBR9onjx67kcalcGvlZ+IA=;
        b=w4O+TQhcQMl5lL+KvCdtNXNg7ROAM8lJ0sL0oGNYA3440gZcgxmps+YKW2o4KOZFYP
         xdzZJQdMxnGDQTKI9TOlpJYRve6IQfTHiVVlc/0Q3/wTSI5fyUwyxFFjFdzW8LQcNQR1
         8qP+sa9kXcp/ryvWWXtYmorldqBAK+6TDwkSZCHvrFPPYn05F7wniKTyvbPBkRHAAnjI
         tDhgvnMFECJoiAhSSz1fxmxDFETbm5jXh85gw/OH+mVQ0OLqWgMVNHStWwiGlq+BLr5l
         8MkeJcH16/DrJhYXKO3axP3UwNqedoiBbtUAo6bwUtI1L0e1kcN4sa6zZwxPl/pPPvWH
         HR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755850818; x=1756455618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyWZRAhQvL3ZewOrTkNRPEBR9onjx67kcalcGvlZ+IA=;
        b=Dxaze4+bp4dJHCe70dlRdgPdir5MxYxNCRKpf4ad7fwHZJsjKJ3G3IvBLPPpdS/6hr
         IbRMh+BWB7319bUgKbhPzzNhW9cRfd6+SwS/+/rdhg1wG6OwlX+STjoXbjUmYk5VSx1m
         RMapaffLlooGX3iofun7qNJQRiuGijju60JZ390RCFcGA7Mcu82t0FTYuExkbTBdp6x3
         Q5fJCFqHSDiLcSQZRWum/Y+s9H0+hbr4Zsgd3eAyK7ogBYpnteSTTtzwy0EVgotxrsAJ
         zYNJAeJ7miX5RL12aVTe/6Jsr7r2kZBNUcD3r/jQ5U8Jl4x+eiJgjDPh+obUy6pXVtab
         GqxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuuuPoRDDVZapEukKriO0uBBpJ8mcXvI2WfZPHqzAU4Qgmg7atgdTi4eFbkT6LG9lVReWAkT5iEDMX@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsop/1VyhZzwKlg7BpHoH3Chg/Tm8Hd1MP5HdYKWv7n8b1YSUl
	/1HuRyp1tOey9HoNHw1rfJ0q6ES9bBJrT4AeMgd6keHxwi6aD0XRkAlt7SBmk/g0y6ERdNqMCKZ
	rVKVSO5I=
X-Gm-Gg: ASbGncuxV6J5Itu9ZY0NDakhqcNvWIONI8tFlHsd9e7bYNbyPzbIXv7JU/8/zTHUDm7
	SxTCi098ewl18Ps/HKJ85wSglshR2DVwVi3Wk7atwxhLcrzd+MU51ztNu3gFZiAHT9vssuuq3b6
	34YDF2azoVIGxQR9p39Fdq1rdTFaLKFS1gSH6w7MQwozsiJyOe4yy1TaVDfBh7EV18EMTgK3+B2
	vQUjCyOj5mFSISqSrmUxaUyoouHj85wp17zuq/eEhhZouOcc/gknxRbBGyRe8mkhECeJe7peutA
	IFoN3pxnWzPbm5q4hl9S5NF+s77vdmIMyr4CDDdbLWfDl0YtbFHr5zx6DGqS620WrG2kI1cBnAN
	CCkyxi793p0DLoiS1MoYkTgE8+1hlr622b1zzaEV11WU5ve2tGsLGlz9bBIgSfum04wMIjgM8aO
	mKISy5oQ==
X-Google-Smtp-Source: AGHT+IFlbHv8xDZAAC640GMgCDpBsfF6zlAzeggthwP5mZNndc9mGjlmfC4QW/vbdALXrNy2SS/1PA==
X-Received: by 2002:a05:6402:5187:b0:61a:89aa:8d37 with SMTP id 4fb4d7f45d1cf-61c1b7134ccmr1679703a12.21.1755850818338;
        Fri, 22 Aug 2025 01:20:18 -0700 (PDT)
Received: from ryzen9.home (194-166-79-38.hdsl.highway.telekom.at. [194.166.79.38])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a761f2599sm6538432a12.5.2025.08.22.01.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 01:20:17 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>
Subject: [PATCH V2] rdma_rxe: call comp_handler without holding cq->cq_lock
Date: Fri, 22 Aug 2025 10:19:41 +0200
Message-ID: <20250822081941.989520-1-philipp.reisner@linbit.com>
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

Changelog:
v1: https://lore.kernel.org/all/20250806123921.633410-1-philipp.reisner@linbit.com/
v1 -> v2:
- Only reset cq->notify to 0 when invoking the comp_handler
====================

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_cq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index fffd144d509e..95652001665d 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -88,6 +88,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 	int full;
 	void *addr;
 	unsigned long flags;
+	bool invoke_handler = false;
 
 	spin_lock_irqsave(&cq->cq_lock, flags);
 
@@ -113,11 +114,14 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 	if ((cq->notify & IB_CQ_NEXT_COMP) ||
 	    (cq->notify & IB_CQ_SOLICITED && solicited)) {
 		cq->notify = 0;
-		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+		invoke_handler = true;
 	}
 
 	spin_unlock_irqrestore(&cq->cq_lock, flags);
 
+	if (invoke_handler)
+		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+
 	return 0;
 }
 
-- 
2.50.1

