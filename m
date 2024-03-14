Return-Path: <linux-rdma+bounces-1427-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3731887B812
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Mar 2024 07:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E033286D2B
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Mar 2024 06:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94034C6B;
	Thu, 14 Mar 2024 06:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A9R30vje"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09C7FC0B
	for <linux-rdma@vger.kernel.org>; Thu, 14 Mar 2024 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710399116; cv=none; b=XgmFyxuhnsFlQVx6sFbEYvaryxXYBQwk2EDZXK8jGYzKxSJYJdFX4bk/kODdwQ8hfD0vTCGbaIGpW6ZKnfbUufRXx9ow53Yue8Wvl5NRE2uM9jGIHZg5ihkJ/CUyFdbVMXKg3UA4QrDKeQTrBvRBCQrR2ByTu09jhKC2EwaqacQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710399116; c=relaxed/simple;
	bh=FCUpNfFovbUuW4nO3n9pZNzuW0uWYUqG1DBL1/BVUPU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r6Ues9Dtbd2+wyeHHdGy+R0ODYWayFo44kJTHMe8FS4A16Ca84NuZmYaeFgTFhXvKN4vV8LhoujHskmuiKBY55ia03YcwN4QEVEg2PQrKLxWmL06dAOxrYhmPQ2JZjRitmV0qlfZjetHD/TwlUi9xVl5H1fLtEEPp7+FDkpJO+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A9R30vje; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710399112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jaI1STSiK6zfqQWjRlQUogp89+S5ocn7PMRbTbdf3uo=;
	b=A9R30vje9+mPIzDtoFBu7Q13KODQx89kKaBVN2TKBUVyb+py4p/bhZAefu1dmyUlPARa8X
	pPjAzvMl/C9qUK8PnpX8qqJxGAvXV8CyjkCHkEZPIScq+bIJEIpygSo0EpNAMVTJvCyp3m
	ZL1VP07sx7HVwW1KKNjKk3R0uvmGanw=
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] RDMA/rxe: Fix the problem "mutex_destroy missing"
Date: Thu, 14 Mar 2024 07:51:40 +0100
Message-Id: <20240314065140.27468-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When a mutex lock is not used any more, the function mutex_destroy
should be called to mark the mutex lock uninitialized.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Yanjun.Zhu <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 54c723a6edda..6f9ec8db014c 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -33,6 +33,8 @@ void rxe_dealloc(struct ib_device *ib_dev)
 
 	if (rxe->tfm)
 		crypto_free_shash(rxe->tfm);
+
+	mutex_destroy(&rxe->usdev_lock);
 }
 
 /* initialize rxe device parameters */
-- 
2.34.1


