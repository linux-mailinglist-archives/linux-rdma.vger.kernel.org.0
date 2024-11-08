Return-Path: <linux-rdma+bounces-5852-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F1C9C176A
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 09:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E847BB21156
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 08:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67111D2F54;
	Fri,  8 Nov 2024 08:04:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB95C19DF64;
	Fri,  8 Nov 2024 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053052; cv=none; b=OB4BTo2N/MifGPbFlKxo68D6JG9GgdaYC2H/7SkvrH3feoNDNU8F94GcpbxT5FhOhOinCXGw9Gu2DBUFA384o1vH9O4ExvIBBokcLMhNd9rO1rJC1DNDfe/8fjpofPF7KYeTy9gvzvcLh8ErR5KB2hoom6H5xdi5DQ0iTz7Mky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053052; c=relaxed/simple;
	bh=oRflvyrVEKyiY6NAtZN0LwFDI39hX6AvPDD8MAvV4Dg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9XXjWS6LE+pOsujR/6+5YrvFgMb7GkKl2KjeC9cnpQKlrpmDvp6px0VOAO/rviWYPd6h6iCNgvQ8ajvAqYEANibEHuGGQnugHxsL9jipv9oCTdJB9TzcBTVPBEfNKnoyprMg+oW2+SS8IDotmKvLJGU51oLwc3lHFB5QDLJPUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XlBHg2Qq3z2Fbp6;
	Fri,  8 Nov 2024 16:02:23 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id CA5131A016C;
	Fri,  8 Nov 2024 16:04:06 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Nov 2024 16:04:06 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: [PATCH for-rc 1/2] RDMA/hns: Fix out-of-order issue of requester when setting FENCE
Date: Fri, 8 Nov 2024 15:57:42 +0800
Message-ID: <20241108075743.2652258-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241108075743.2652258-1-huangjunxian6@hisilicon.com>
References: <20241108075743.2652258-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100018.china.huawei.com (7.202.181.17)

The FENCE indicator in hns WQE doesn't ensure that response data from
a previous Read/Atomic operation has been written to the requester's
memory before the subsequent Send/Write operation is processed. This
may result in the subsequent Send/Write operation accessing the original
data in memory instead of the expected response data.

Unlike FENCE, the SO (Strong Order) indicator blocks the subsequent
operation until the previous response data is written to memory and a
bresp is returned. Set the SO indicator instead of FENCE to maintain
strict order.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 24e906b9d3ae..0374e72c6078 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -582,7 +582,7 @@ static inline int set_rc_wqe(struct hns_roce_qp *qp,
 	if (WARN_ON(ret))
 		return ret;
 
-	hr_reg_write(rc_sq_wqe, RC_SEND_WQE_FENCE,
+	hr_reg_write(rc_sq_wqe, RC_SEND_WQE_SO,
 		     (wr->send_flags & IB_SEND_FENCE) ? 1 : 0);
 
 	hr_reg_write(rc_sq_wqe, RC_SEND_WQE_SE,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index c65f68a14a26..56a8d1d9aaf1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -919,6 +919,7 @@ struct hns_roce_v2_rc_send_wqe {
 #define RC_SEND_WQE_OWNER RC_SEND_WQE_FIELD_LOC(7, 7)
 #define RC_SEND_WQE_CQE RC_SEND_WQE_FIELD_LOC(8, 8)
 #define RC_SEND_WQE_FENCE RC_SEND_WQE_FIELD_LOC(9, 9)
+#define RC_SEND_WQE_SO RC_SEND_WQE_FIELD_LOC(10, 10)
 #define RC_SEND_WQE_SE RC_SEND_WQE_FIELD_LOC(11, 11)
 #define RC_SEND_WQE_INLINE RC_SEND_WQE_FIELD_LOC(12, 12)
 #define RC_SEND_WQE_WQE_INDEX RC_SEND_WQE_FIELD_LOC(30, 15)
-- 
2.33.0


