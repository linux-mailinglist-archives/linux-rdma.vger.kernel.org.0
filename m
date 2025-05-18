Return-Path: <linux-rdma+bounces-10397-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F94ABB099
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 16:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022163B89F6
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABCE21CA0A;
	Sun, 18 May 2025 14:51:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E93B1E4AB;
	Sun, 18 May 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747579861; cv=none; b=X4uecAqoehU1OErn7jsDDORTNpQR6gXMvOTwxwTSVbO+i3skdSvgBoDPibg3c8Ub3rKDPYy/XCK4bBeRa7EvasIIouLthS6/O0JtQ94HSQ4I2GCGqrmY/P41csbTlP5UmGL2hqpLOYEMozA0h03Cw+ClSublp9fZo5Koz/Df6Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747579861; c=relaxed/simple;
	bh=JQVglm6Di0GfvSzpslqlCi8HxodRM4bFoO3iBNHZRFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i+Z8r/MH2PgTeMGqveVHtCs2jeJX0Q6m9Hg2c9k+IzojYYyJ2rpmtn0ZwuhVQVyMpIrqTPszYhi87yo0dUV1xOyNKt2II+UjyZ1qow5Wg0s+Uy7FFZa8+dFD0oYNnSxo5xatWjpWyyuFZOwye2Lupu70U3LcSUqeFgmNiXMkD5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.199.70.239])
	by APP-03 (Coremail) with SMTP id rQCowAA3SvXD8yloUbkVAQ--.548S2;
	Sun, 18 May 2025 22:50:48 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: mustafa.ismail@intel.com,
	tatyana.e.nikolova@intel.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] RDMA/irdma: puda: Clear entries after allocation to ensure clean state
Date: Sun, 18 May 2025 22:49:42 +0800
Message-ID: <20250518144942.714-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3SvXD8yloUbkVAQ--.548S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyfWF43ur4xZF4DGFyrXrb_yoW8GF15pa
	y5Jr4qkrZ0qa1j93WUG393CFW5XanrKr9FvrZF93s3ZF4UJrW0qFs5Kr1Y9F4kGr1I9a1x
	Zrnrtr1rC3Wrur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBg0GA2gp1Gc4vQAAs5

The irdma_puda_send() calls the irdma_puda_get_next_send_wqe() to get
entries, but does not clear the entries after the function call. A proper
implementation can be found in irdma_uk_send().

Add the irdma_clr_wqes() after irdma_puda_get_next_send_wqe(). Add the
headfile of the irdma_clr_wqes().

Fixes: a3a06db504d3 ("RDMA/irdma: Add privileged UDA queue implementation")
Cc: stable@vger.kernel.org # v5.14
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
v2: Fix code error and remove improper description.

 drivers/infiniband/hw/irdma/puda.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index 7e3f9bca2c23..f7a826a5bedf 100644
--- a/drivers/infiniband/hw/irdma/puda.c
+++ b/drivers/infiniband/hw/irdma/puda.c
@@ -7,6 +7,7 @@
 #include "protos.h"
 #include "puda.h"
 #include "ws.h"
+#include "user.h"
 
 static void irdma_ieq_receive(struct irdma_sc_vsi *vsi,
 			      struct irdma_puda_buf *buf);
@@ -444,6 +445,8 @@ int irdma_puda_send(struct irdma_sc_qp *qp, struct irdma_puda_send_info *info)
 	if (!wqe)
 		return -ENOMEM;
 
+	irdma_clr_wqes(&qp->qp_uk, wqe_idx);
+
 	qp->qp_uk.sq_wrtrk_array[wqe_idx].wrid = (uintptr_t)info->scratch;
 	/* Third line of WQE descriptor */
 	/* maclen is in words */
-- 
2.42.0.windows.2


