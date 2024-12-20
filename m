Return-Path: <linux-rdma+bounces-6674-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B520C9F8C3D
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 07:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E347A232B
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 06:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700CA19F40B;
	Fri, 20 Dec 2024 05:59:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E74155327;
	Fri, 20 Dec 2024 05:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734674385; cv=none; b=nmHBwnhRc1ypyvIaH4QvbEiJB7mo3co+cXgeDcySxYEE2B6ZlljJLRwkJw9XQZY2rdfaS6D0nU9L8QP5vfGOT1MTOR94kuniA7Aw6BPeXLuk5RBnl38a2N67daBSVqKPDZ3Hc99V7JXvsmDNP30nxWInnutO9wwVT8LOV/jPtss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734674385; c=relaxed/simple;
	bh=K4XdY5Y8eGT0dr9Z4l3fGou1CPBGjwhLnyuHHh/+VkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ry+auHYByaUDh8evF0rU15/nzpMbf8axyGZ7+DvO5Pv6SrYfEsT6PhB98svXBz+dWGJgKeC+22mhZZETc2+esKcdI3MBWPEoVKA7SztijG5deF0oeYfHW7Z3zAzHRbajSzLqMwDLkinMUJAa1rtzZENG1EmLvNrEm09bwabYQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YDxVt20Ccz11N3Q;
	Fri, 20 Dec 2024 13:56:22 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D8C2180101;
	Fri, 20 Dec 2024 13:59:39 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Dec 2024 13:59:39 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: [PATCH for-rc 4/4] RDMA/hns: Fix missing flush CQE for DWQE
Date: Fri, 20 Dec 2024 13:52:49 +0800
Message-ID: <20241220055249.146943-5-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241220055249.146943-1-huangjunxian6@hisilicon.com>
References: <20241220055249.146943-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Chengchang Tang <tangchengchang@huawei.com>

Flush CQE handler has not been called if QP state gets into errored
mode in DWQE path. So, the new added outstanding WQEs will never be
flushed.

It leads to a hung task timeout when using NFS over RDMA:
    __switch_to+0x7c/0xd0
    __schedule+0x350/0x750
    schedule+0x50/0xf0
    schedule_timeout+0x2c8/0x340
    wait_for_common+0xf4/0x2b0
    wait_for_completion+0x20/0x40
    __ib_drain_sq+0x140/0x1d0 [ib_core]
    ib_drain_sq+0x98/0xb0 [ib_core]
    rpcrdma_xprt_disconnect+0x68/0x270 [rpcrdma]
    xprt_rdma_close+0x20/0x60 [rpcrdma]
    xprt_autoclose+0x64/0x1cc [sunrpc]
    process_one_work+0x1d8/0x4e0
    worker_thread+0x154/0x420
    kthread+0x108/0x150
    ret_from_fork+0x10/0x18

Fixes: 01584a5edcc4 ("RDMA/hns: Add support of direct wqe")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d0469d27c63c..0144e7210d05 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -670,6 +670,10 @@ static void write_dwqe(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
 #define HNS_ROCE_SL_SHIFT 2
 	struct hns_roce_v2_rc_send_wqe *rc_sq_wqe = wqe;
 
+	if (unlikely(qp->state == IB_QPS_ERR)) {
+		flush_cqe(hr_dev, qp);
+		return;
+	}
 	/* All kinds of DirectWQE have the same header field layout */
 	hr_reg_enable(rc_sq_wqe, RC_SEND_WQE_FLAG);
 	hr_reg_write(rc_sq_wqe, RC_SEND_WQE_DB_SL_L, qp->sl);
-- 
2.33.0


