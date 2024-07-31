Return-Path: <linux-rdma+bounces-4127-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB571942715
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 08:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183DC1C21005
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 06:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EDB16DC3A;
	Wed, 31 Jul 2024 06:39:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25C16D4C4;
	Wed, 31 Jul 2024 06:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407962; cv=none; b=VpEXVvVDIukKsVBu85wYpDTGPEoE1UuF/cufOsxx06ZN/HAguQfl+oeNCZz8nXukWcDCAWDMtT3kG4RnqSZYUSmcomMnrMNUeyRPYIstceSawnV88nwEOatZ8Rm3eTxyVlqLWPr5PrBnqDkm2jCbZcaOqQRIeNpyHFH6ATNjpnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407962; c=relaxed/simple;
	bh=O2TU5Lra5iP+A/fH09rSiPhd9mRWNVAj4C9RgaiD3Vc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r1f77tLZZ79qSC5NM5ppI5xTW3zzyOAvCirm/mMLoXoZ/LUR1gQX6REW+1OSwLGPedkmK1vldnJVDInOIt+F5mPV2ruc5a1P3fPhETjOsVUBJFo1CnQhCbLpEV6EvAPze7/y0NcGWGZpJiIoi/T4acCcw9Sl/u1AWyL6N+DH+1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WYj7h5J7KzgYT1;
	Wed, 31 Jul 2024 14:37:20 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CFCD18005F;
	Wed, 31 Jul 2024 14:39:11 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Jul
 2024 14:39:10 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <allison.henderson@oracle.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] RDS: IB: Remove unused declarations
Date: Wed, 31 Jul 2024 14:36:30 +0800
Message-ID: <20240731063630.3592046-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit f4f943c958a2 ("RDS: IB: ack more receive completions to improve performance")
removed rds_ib_recv_tasklet_fn() implementation but not the declaration.
And commit ec16227e1414 ("RDS/IB: Infiniband transport") declared but never implemented
other functions.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/rds/ib.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/rds/ib.h b/net/rds/ib.h
index 2ba71102b1f1..8ef3178ed4d6 100644
--- a/net/rds/ib.h
+++ b/net/rds/ib.h
@@ -369,9 +369,6 @@ int rds_ib_conn_alloc(struct rds_connection *conn, gfp_t gfp);
 void rds_ib_conn_free(void *arg);
 int rds_ib_conn_path_connect(struct rds_conn_path *cp);
 void rds_ib_conn_path_shutdown(struct rds_conn_path *cp);
-void rds_ib_state_change(struct sock *sk);
-int rds_ib_listen_init(void);
-void rds_ib_listen_stop(void);
 __printf(2, 3)
 void __rds_ib_conn_error(struct rds_connection *conn, const char *, ...);
 int rds_ib_cm_handle_connect(struct rdma_cm_id *cm_id,
@@ -402,7 +399,6 @@ void rds_ib_inc_free(struct rds_incoming *inc);
 int rds_ib_inc_copy_to_user(struct rds_incoming *inc, struct iov_iter *to);
 void rds_ib_recv_cqe_handler(struct rds_ib_connection *ic, struct ib_wc *wc,
 			     struct rds_ib_ack_state *state);
-void rds_ib_recv_tasklet_fn(unsigned long data);
 void rds_ib_recv_init_ring(struct rds_ib_connection *ic);
 void rds_ib_recv_clear_ring(struct rds_ib_connection *ic);
 void rds_ib_recv_init_ack(struct rds_ib_connection *ic);
-- 
2.34.1


