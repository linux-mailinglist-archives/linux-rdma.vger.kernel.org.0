Return-Path: <linux-rdma+bounces-14350-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE6AC44B06
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 01:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14EB4345AFB
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 00:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAB81F30AD;
	Mon, 10 Nov 2025 00:59:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2642256D;
	Mon, 10 Nov 2025 00:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762736369; cv=none; b=UZES6zio0H+Pox/18XV+wSRvW3KfJwkxwEIFwsHaFeSIzaFFTvWiZOEsoHMwNKGVFEiL0LN2eyK+LLhsuN1S2nZVc6SU4MfXsNgcBWfXCFlJqGQlrxOVj8zsSRmXrx/9U0XDcL9zhPsyGpXv0pUWMjIK0TwtQe0r5TKmiT0uEMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762736369; c=relaxed/simple;
	bh=OtRA2UDXaIvC6diIETT2unizlsZKtKCQPRjmerjVsiU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=aIj4S9uu+2X0Vlpv5TBZjeOF5d2rugIxOEWLZWrgIn9caqsm+tynC6qWFXcf7L2aZs2PgvSF4lIQ2Q2Q1IXzq1AUOX5VToAq9A0D+1wbnWmLEGfNt4t3ZwD2VkaD2ir1dYaRzizjhPSL9qmDbqApCpOmUoMBazDCB8xUVvvFr6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowADnr3AvNxFpzuwrAA--.14811S2;
	Mon, 10 Nov 2025 08:52:09 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	danil.kipnis@cloud.ionos.com
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH v2] RDMA/rtrs: server: Fix error handling in get_or_create_srv
Date: Mon, 10 Nov 2025 08:51:58 +0800
Message-Id: <20251110005158.13394-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowADnr3AvNxFpzuwrAA--.14811S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1UJFy3WrWfArWUKrWxJFb_yoWDZrXEkF
	4xXrn7Jr18Aw1kKa45ur43uFyFkwsFgFn3Zw1qqr9Fy3y7XFs8Wrn7XFW8Xw15Xw4jkFn8
	X347G3yvkr4IkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbT8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVWDMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	WUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU09NVUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

After device_initialize() is called, use put_device() to release the
device according to kernel device management rules. While direct
kfree() might work in some cases, using put_device() ensures proper
device lifecycle management.

Found by code review.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- modified the patch according to suggestions;
- removed Cc label.
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index ef4abdea3c2d..9ecc6343455d 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1450,7 +1450,7 @@ static struct rtrs_srv_sess *get_or_create_srv(struct rtrs_srv_ctx *ctx,
 	kfree(srv->chunks);
 
 err_free_srv:
-	kfree(srv);
+	put_device(&srv->dev);
 	return ERR_PTR(-ENOMEM);
 }
 
-- 
2.17.1


