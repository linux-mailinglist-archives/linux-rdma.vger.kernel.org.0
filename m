Return-Path: <linux-rdma+bounces-8571-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F9FA5BB44
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 09:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132A1171979
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 08:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E8422DFAD;
	Tue, 11 Mar 2025 08:56:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017622ACCE
	for <linux-rdma@vger.kernel.org>; Tue, 11 Mar 2025 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683398; cv=none; b=rYJ8Cbh4ZR2ya9CVLnEIUPY/a/JZTV3EKidezZNkYDpU5HX7swucY6bNmSF5nNkTsiWP4r9j+19ZuLY3WpaXFQmYXYursQBRk5MNdON0gN9UZ93rCH/u2ExWyKF1vRVA/wuY9OP/tz6dRBlgX/yM9BzR8MxFUqMpmFHYz2vjqho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683398; c=relaxed/simple;
	bh=gmKKtIEoHgi2LwTKj/itaEtyoU2v3CV+/sSaHtzMgfc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvoPP+XajcUQh2d0lX5xXlmsNoE4fgVHrET4RSFx0h13XfVRdEfUS8dS6TCHe4BF2bapHEmT2MvznU7SX5DDzmQFCPQq+ueSofTXPci7hoNcZdtYwohdywhNsmabmHgDu5kNFb22ZblHlmDqHptluk7AIDhCtubYDh99+M5RoJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZBnZN5jV0z2RTJL;
	Tue, 11 Mar 2025 16:52:12 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 00D5E1402CD;
	Tue, 11 Mar 2025 16:56:33 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Mar 2025 16:56:32 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 3/7] RDMA/hns: Fix unmatched condition in error path of alloc_user_qp_db()
Date: Tue, 11 Mar 2025 16:48:53 +0800
Message-ID: <20250311084857.3803665-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250311084857.3803665-1-huangjunxian6@hisilicon.com>
References: <20250311084857.3803665-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Currently the condition of unmapping sdb in error path is not exactly
the same as the condition of mapping in alloc_user_qp_db(). This may
cause a problem of unmapping an unmapped db in some case, such as
when the QP is XRC TGT. Unified the two conditions.

Fixes: 90ae0b57e4a5 ("RDMA/hns: Combine enable flags of qp")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index ccfef673a976..70a38bf2bd86 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -868,12 +868,14 @@ static int alloc_user_qp_db(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_ib_create_qp *ucmd,
 			    struct hns_roce_ib_create_qp_resp *resp)
 {
+	bool has_sdb = user_qp_has_sdb(hr_dev, init_attr, udata, resp, ucmd);
 	struct hns_roce_ucontext *uctx = rdma_udata_to_drv_context(udata,
 		struct hns_roce_ucontext, ibucontext);
+	bool has_rdb = user_qp_has_rdb(hr_dev, init_attr, udata, resp);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int ret;
 
-	if (user_qp_has_sdb(hr_dev, init_attr, udata, resp, ucmd)) {
+	if (has_sdb) {
 		ret = hns_roce_db_map_user(uctx, ucmd->sdb_addr, &hr_qp->sdb);
 		if (ret) {
 			ibdev_err(ibdev,
@@ -884,7 +886,7 @@ static int alloc_user_qp_db(struct hns_roce_dev *hr_dev,
 		hr_qp->en_flags |= HNS_ROCE_QP_CAP_SQ_RECORD_DB;
 	}
 
-	if (user_qp_has_rdb(hr_dev, init_attr, udata, resp)) {
+	if (has_rdb) {
 		ret = hns_roce_db_map_user(uctx, ucmd->db_addr, &hr_qp->rdb);
 		if (ret) {
 			ibdev_err(ibdev,
@@ -898,7 +900,7 @@ static int alloc_user_qp_db(struct hns_roce_dev *hr_dev,
 	return 0;
 
 err_sdb:
-	if (hr_qp->en_flags & HNS_ROCE_QP_CAP_SQ_RECORD_DB)
+	if (has_sdb)
 		hns_roce_db_unmap_user(uctx, &hr_qp->sdb);
 err_out:
 	return ret;
-- 
2.33.0


