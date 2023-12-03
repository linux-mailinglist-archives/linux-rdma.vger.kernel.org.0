Return-Path: <linux-rdma+bounces-187-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1353880223E
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Dec 2023 10:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1E91F210B0
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Dec 2023 09:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E45848C;
	Sun,  3 Dec 2023 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v7iClf8C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D28E8
	for <linux-rdma@vger.kernel.org>; Sun,  3 Dec 2023 01:27:43 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701595661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEESUjwfy67jdK+XIt8mpUL8qc37vyoJFBg+LpK5w8w=;
	b=v7iClf8CMbYcEk14rJ7QWqmcWsWGiYKA4vTZsP0UU3oaVjdD18ceHI3DNPCAZy3USGWAxN
	OwRKGm0P2KTFM+NY+sjqBuRi1bJvpRpaFEH7Hkw4B8CkS2ZVkrxghOPcu1rW7M/Viw7mHG
	EH6Z8ELX4oWkREPMISTG6mzbVJL8MTc=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: bmt@zurich.ibm.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	guoqing.jiang@linux.dev
Subject: [PATCH V2 3/4] RDMA/siw: Set qp_state in siw_query_qp
Date: Sun,  3 Dec 2023 17:26:54 +0800
Message-Id: <20231203092655.28102-4-guoqing.jiang@linux.dev>
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

Run test_query_rc_qp against siw failed since siw didn't set qp_state
accordingly. To address it, introduce siw_qp_state_to_ib_qp_state
which convert SIW_QP_STATE_IDLE to IB_QPS_INIT which is similar as
in cxgb4.

rdma-core# ./build/bin/run_tests.py --dev siw0 tests.test_qp.QPTest.test_query_rc_qp -v
test_query_rc_qp (tests.test_qp.QPTest)
Queries an RC QP after creation. Verifies that its properties are as ... FAIL

======================================================================
FAIL: test_query_rc_qp (tests.test_qp.QPTest)
Queries an RC QP after creation. Verifies that its properties are as
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/gjiang/rdma-core/tests/test_qp.py", line 284, in test_query_rc_qp
    self.query_qp_common_test(e.IBV_QPT_RC)
  File "/home/gjiang/rdma-core/tests/test_qp.py", line 265, in query_qp_common_test
    self.verify_qp_attrs(caps, e.IBV_QPS_INIT, qp_init_attr, qp_attr)
  File "/home/gjiang/rdma-core/tests/test_qp.py", line 239, in verify_qp_attrs
    self.assertEqual(state, attr.qp_state)
AssertionError: <ibv_qp_state.IBV_QPS_INIT: 1> != 0

----------------------------------------------------------------------
Ran 1 test in 0.057s

FAILED (failures=1)

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_verbs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index dca6a155523d..ecf0444666b4 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -19,6 +19,15 @@
 #include "siw_verbs.h"
 #include "siw_mem.h"
 
+static int siw_qp_state_to_ib_qp_state[SIW_QP_STATE_COUNT] = {
+	[SIW_QP_STATE_IDLE] = IB_QPS_INIT,
+	[SIW_QP_STATE_RTR] = IB_QPS_RTR,
+	[SIW_QP_STATE_RTS] = IB_QPS_RTS,
+	[SIW_QP_STATE_CLOSING] = IB_QPS_SQD,
+	[SIW_QP_STATE_TERMINATE] = IB_QPS_SQE,
+	[SIW_QP_STATE_ERROR] = IB_QPS_ERR
+};
+
 static int ib_qp_state_to_siw_qp_state[IB_QPS_ERR + 1] = {
 	[IB_QPS_RESET] = SIW_QP_STATE_IDLE,
 	[IB_QPS_INIT] = SIW_QP_STATE_IDLE,
@@ -504,6 +513,7 @@ int siw_query_qp(struct ib_qp *base_qp, struct ib_qp_attr *qp_attr,
 	} else {
 		return -EINVAL;
 	}
+	qp_attr->qp_state = siw_qp_state_to_ib_qp_state[qp->attrs.state];
 	qp_attr->cap.max_inline_data = SIW_MAX_INLINE;
 	qp_attr->cap.max_send_wr = qp->attrs.sq_size;
 	qp_attr->cap.max_send_sge = qp->attrs.sq_max_sges;
-- 
2.35.3


