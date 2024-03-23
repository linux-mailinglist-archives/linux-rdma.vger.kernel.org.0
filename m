Return-Path: <linux-rdma+bounces-1503-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB39887788
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Mar 2024 09:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E85282C67
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Mar 2024 08:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656002CA9;
	Sat, 23 Mar 2024 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C3HV6ywW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744302C80
	for <linux-rdma@vger.kernel.org>; Sat, 23 Mar 2024 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711182717; cv=none; b=DhsI75vhvrO220X0LBP6zLPYS7wN+PBJDZorsnKZWgQjMtX8aaYWrWMKetaId3p7jbmHDxBNif5TWbRI0JGSRTQVRvLEyNXMdEroWytTpSmCr0+wQq9Uoc5wQIPLT9aJLtsV2gDKY8Rwhs1L1/kKOYyrkAgXyuGwZ5fOR/ENBJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711182717; c=relaxed/simple;
	bh=tgB0LwzIt2IIkV/Vm8FxTcz/GUfvPWmSXVesRk42TxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ok9Zo4OP+YoeubWuyi3mOQRjNwS1AlX+WlVI4BnHClvKYVSdJurJ5BiEG8kIplyoZap+QYnKeVQPB2YxS7AV+tuniXbhrm2rvrefsVhVt0VTeQKxZQ9R8LqlFJAgx6VlI6JVgN8uVrsiSs1CJUt6ct55D90Em6B4tDsJ1WjN44c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C3HV6ywW; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711182711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CK81f6GWSrQcQxDMp1hzz4wf7Jnrrrzcdv29rYYLB/E=;
	b=C3HV6ywWAq8xv7ltwrfX8HUJb6h9am/RZW/qYj/GYIVfRuBuUD+DvM8WmMxgRMzi27nEdk
	w8C50YFF7olSEpNt9jtItNCMk4rAdUm42NTqv2FM2IteOdvZnk6xS5BMxRZHyFYVWnLCor
	b4boSevfZGcXQSo3MMjJ7Lt3zBSWUug=
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] RDMA/rxe: Make pr_fmt work
Date: Sat, 23 Mar 2024 09:31:39 +0100
Message-Id: <20240323083139.5484-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Zhu Yanjun <yanjun.zhu@linux.dev>

If the definition of pr_fmt is before the header file. The pr_fmt
will be overwritten by the header file. So move the definition of
pr_fmt to the below of the header file.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index d8fb2c7af30a..dc2d8dd2f681 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -7,11 +7,6 @@
 #ifndef RXE_H
 #define RXE_H
 
-#ifdef pr_fmt
-#undef pr_fmt
-#endif
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/skbuff.h>
 
 #include <rdma/ib_verbs.h>
@@ -30,6 +25,11 @@
 #include "rxe_verbs.h"
 #include "rxe_loc.h"
 
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 /*
  * Version 1 and Version 2 are identical on 64 bit machines, but on 32 bit
  * machines Version 2 has a different struct layout.
-- 
2.34.1


