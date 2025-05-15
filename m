Return-Path: <linux-rdma+bounces-10359-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914D6AB8843
	for <lists+linux-rdma@lfdr.de>; Thu, 15 May 2025 15:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110414C4E47
	for <lists+linux-rdma@lfdr.de>; Thu, 15 May 2025 13:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75206142E86;
	Thu, 15 May 2025 13:40:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445454B1E52;
	Thu, 15 May 2025 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747316409; cv=none; b=YjivjaKnn45R1Ra8aJXTiwFbhGiwz7ZxpF0SnZO++ovQmu6raZGmqxW6JABs0TeGhfWvLIqY08PkbgQ+a+olc50HWee4Xbtt9FfnorYQiybCqD0pAx4Bl414yOAkf3wxEEicASjSamvKAyCs26jYEc2LI0l5kV0WArCfLIbIUkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747316409; c=relaxed/simple;
	bh=bLsm45s9D0qARSqkBSIJVd3zYZoqeCxjGRV/ULXVIrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ny6r4n7qe3PgZiqGRquCvRZqiidcLcZL0HGKG0M2Cuv5A/JGdlgG/G1xd7/z0lWMe5Z52v9JSC994GP3DPOmFQSbGi7ZSzlQlpS/SGfaa3ENReeAQb/m6SvQC8awzeJsztlj/oHSQlR0Ehg9985CVEK0g/FkwE2kSEr85U+5Mjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowAAXxUGm7iVorh3cFQ--.28807S2;
	Thu, 15 May 2025 21:39:54 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: mustafa.ismail@intel.com,
	tatyana.e.nikolova@intel.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] RDMA/irdma: puda: Clear entries after allocation to ensure clean state
Date: Thu, 15 May 2025 21:39:28 +0800
Message-ID: <20250515133929.1222-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAXxUGm7iVorh3cFQ--.28807S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw45Zr18Gw4rur18uF1kuFg_yoW8Gry3pa
	yDJr1q9rZ0qa1UWa1DG393CFW3Xa17Gr9FvrZFk3s3ZF45Jr10qF1kGryj9F4kGr1xuw4x
	Xrnrtr15C3Wrur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUf8nOUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ8DA2glvjRVYQAEsx

The irdma_puda_send() calls the irdma_puda_get_next_send_wqe() to get
entries, but does not clear the entries after the function call. This
could lead to wqe data inconsistency. A proper implementation can be
found in irdma_uk_send().

Add the irdma_clr_wqes() after irdma_puda_get_next_send_wqe(). Add the
headfile of the irdma_clr_wqes().

Fixes: a3a06db504d3 ("RDMA/irdma: Add privileged UDA queue implementation")
Cc: stable@vger.kernel.org # v5.14
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/infiniband/hw/irdma/puda.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index 7e3f9bca2c23..1d113ad05500 100644
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
 
+	irdma_clr_wqes(qp, wqe_idx);
+
 	qp->qp_uk.sq_wrtrk_array[wqe_idx].wrid = (uintptr_t)info->scratch;
 	/* Third line of WQE descriptor */
 	/* maclen is in words */
-- 
2.42.0.windows.2


