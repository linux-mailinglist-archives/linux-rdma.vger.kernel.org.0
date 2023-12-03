Return-Path: <linux-rdma+bounces-188-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C3480223F
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Dec 2023 10:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9671B280F40
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Dec 2023 09:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D727B8C17;
	Sun,  3 Dec 2023 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j2wqyJJ5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B96E7
	for <linux-rdma@vger.kernel.org>; Sun,  3 Dec 2023 01:27:45 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701595664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twbMlmA50cyTWn+OjyRmB+rWRJ+rRbrrWItsr3z3XcM=;
	b=j2wqyJJ5l4Dyfa9szJfwFbzywtarsL95DK3mKq2/CCtFm/RR41khPoMn1Tuo6d/kMdAU2e
	DeBWW1T6pJnAQ5CgAz8Qj3VRaLeX2QjOosRVmFZ1n4EARSDKQY00b0yHCFKuHvw6l1dOIA
	r+HSYSLXH+1IRtNbS9lg0bdyoWYNsdI=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: bmt@zurich.ibm.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	guoqing.jiang@linux.dev
Subject: [PATCH V2 4/4] RDMA/siw: Call orq_get_current if possible
Date: Sun,  3 Dec 2023 17:26:55 +0800
Message-Id: <20231203092655.28102-5-guoqing.jiang@linux.dev>
In-Reply-To: <20231203092655.28102-1-guoqing.jiang@linux.dev>
References: <20231203092655.28102-1-guoqing.jiang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use orq_get_current() in siw_orq_empty().

Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 2edba2a864bb..75253f2b3e3d 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -657,7 +657,7 @@ static inline struct siw_sqe *orq_get_free(struct siw_qp *qp)
 
 static inline int siw_orq_empty(struct siw_qp *qp)
 {
-	return qp->orq[qp->orq_get % qp->attrs.orq_size].flags == 0 ? 1 : 0;
+	return orq_get_current(qp)->flags == 0 ? 1 : 0;
 }
 
 static inline struct siw_sqe *irq_alloc_free(struct siw_qp *qp)
-- 
2.35.3


