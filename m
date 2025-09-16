Return-Path: <linux-rdma+bounces-13401-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E08BDB591D8
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 11:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0A11BC5901
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 09:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B62B29A30A;
	Tue, 16 Sep 2025 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AaRLuE/T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CA8285C9E;
	Tue, 16 Sep 2025 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014020; cv=none; b=jVoHhMeQHYjrJMI6wF3jYVo0AdSKqOKL/GDpbu9e7sfslJXccBq9uqK8Tly/TQBQKs0XSbOKeLN6OZFN2RCEuqUggumKJRYwmsS1c7KvVyQXpLQ+NCWzzvbrIYeg5hAZbYcq1jQrMAzR1tgbjzSM4XEQfHdAxZFrAA2kdzYDKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014020; c=relaxed/simple;
	bh=RPQw3z2dHaXgfpmB9P1JWRYCCljsklugzceUaijhh0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofU3/0auKxh9tU5l0WTFL0OPUFXW2w6WnCpFw3GFoM3Si5XMd8RpoYojUWyQi8SBlpGqcRAr2/gIlZ/0SfPMQR21iET6Gp16QUZTdVU9bP549yUsMm8c8RCdqApTENUL/fW1MJgoxrYGCvS5i/7EQjTEeURn+1dJaBM0Yt7VFP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AaRLuE/T; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Og
	fyt8RBv1w3ExCI1WXeZulH+GPBHo7H1m4c6zJSi64=; b=AaRLuE/TwCBEEiNiQ6
	RraYnyM8OTRAOEcmhRPjek+/Io46Ri/f74F9asYEelPQFOOKUOGi+X3Y35AosuFL
	nVLLcmPV5Op6pNeE5N1skswBrqu4b8JGxFYZtinpioTDJgh79iQBTRujzK+QuaeD
	EMINpESzR55+gRyoleaa54ymU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3h2gcKslofyOfBg--.35862S2;
	Tue, 16 Sep 2025 17:13:01 +0800 (CST)
From: YanLong Dai <dyl_wlc@163.com>
To: selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daiyanlong <daiyanlong@kylinos.cn>
Subject: [PATCH] drivers: fix the exception was not returned
Date: Tue, 16 Sep 2025 17:11:54 +0800
Message-ID: <20250916091154.11421-1-dyl_wlc@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3h2gcKslofyOfBg--.35862S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWrZFW3tFyUtr1UZr47Arb_yoWfuFc_Gr
	1jq3s7WryUCF18ur1jqFn8Gr92vwsFgwsruF9rta47K347KFWUZ39Fy3ZxZ39rWay8WrWD
	tFy5G34vyF1rCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8ltC7UUUUU==
X-CM-SenderInfo: 5g1os4lof6il2tof0z/xtbBMQjKImjJIwPBBQABsV

From: daiyanlong <daiyanlong@kylinos.cn>

The return value rc of bnxt_qplib_destroy_qp is abnormal and no return

Signed-off-by: daiyanlong <daiyanlong@kylinos.cn>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 260dc67b8b87..d52cfb50b1b8 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -971,8 +971,10 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
 
 	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
-	if (rc)
+	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to destroy HW QP");
+		return rc;
+	}
 
 	if (rdma_is_kernel_res(&qp->ib_qp.res)) {
 		flags = bnxt_re_lock_cqs(qp);
-- 
2.43.0


