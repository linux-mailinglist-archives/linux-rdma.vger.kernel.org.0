Return-Path: <linux-rdma+bounces-11009-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9216ACE8C0
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 05:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE221890FC9
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 03:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84C81E5B64;
	Thu,  5 Jun 2025 03:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PIjE3T2N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4EB3C465
	for <linux-rdma@vger.kernel.org>; Thu,  5 Jun 2025 03:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749095390; cv=none; b=sOF+5bERkeAcMAW2hD/jgHs7s1yPFAukbf+6BrqI6bQG18ZJQAgqMKB7quRyEqzhuNxdQ8TC4RxoZFQd6rIVZYOPswfxEkKFgyBapIg994Nbm6ofn7ftimkkM2NTONNfua8lRi/KR7jvH7AQQWZitgelBfzT1pnW3dKTkYwrF6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749095390; c=relaxed/simple;
	bh=TfE6eppglpvgy3YJJZvwo78RvONQvtswkHATzytWfR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XbQ2wxxkVqZojYRScyeBj4OYcPmGkoUok1XVwURu4Ml3/2PrryH1HEkMo/Op0y59SGrq8tYOXiNuH2tlFN0glN/C0aqM4aDe27sAhEzfv3zqpdOAY5uToUcFRVvwm+jLIoSJ3PK1+vvUq8qu1atkpedu9LitcECWthHQ02YBoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PIjE3T2N; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pW
	2kEkaHVmiiE1cfQnI9QdNIDmVACPz1nD2dkLUo+wQ=; b=PIjE3T2NYKwDbCJqZt
	00r3bMhxNm2Ahee9W2+RZNdJYb0duFD8SjgW+yUwpALYUia2x/VDvTHylX6uq6us
	BM0/4q8qlxX6RNc5cm2ix7rdBKtqfhQH1AD18WVccWNXyp0kxG/rJL1my4fintsD
	Im4Jau65tqs5lKviQ3tCUUP7k=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXzb6+E0FoSZkuGQ--.16347S2;
	Thu, 05 Jun 2025 11:49:20 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: huangjunxian6@hisilicon.com
Cc: tangchengchang@huawei.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	luoqing@kylinos.cn
Subject: [PATCH v2] RDMA/hns: ZERO_OR_NULL_PTR macro overdetection
Date: Thu,  5 Jun 2025 11:49:18 +0800
Message-Id: <20250605034918.242682-1-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXzb6+E0FoSZkuGQ--.16347S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1ktr4kCFWDCr45tr47Jwb_yoW8KFWxpF
	sxK3WYkFW5GF1jvw47Kr4IyrW3tas7Kay7GrWq9asxZwsIvw4UtFn7try7XFykAr95Ga1a
	qr40gr4DWa1xuw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQBMiUUUUU=
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/1tbiEARiRGhAMMu2UgABsE

From: luoqing <luoqing@kylinos.cn>

sizeof(xx) these variable values' return values cannot be 0.
For memory allocation requests of non-zero length,
there is no need to check other return values;
it is sufficient to only verify that it is not null.

Signed-off-by: luoqing <luoqing@kylinos.cn>
Reviewed-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
 drivers/infiniband/hw/hns/hns_roce_qp.c    | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 160e8927d364..65884f63fc7c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2613,7 +2613,7 @@ static struct ib_pd *free_mr_init_pd(struct hns_roce_dev *hr_dev)
 	struct ib_pd *pd;
 
 	hr_pd = kzalloc(sizeof(*hr_pd), GFP_KERNEL);
-	if (ZERO_OR_NULL_PTR(hr_pd))
+	if (!hr_pd)
 		return NULL;
 	pd = &hr_pd->ibpd;
 	pd->device = ibdev;
@@ -2644,7 +2644,7 @@ static struct ib_cq *free_mr_init_cq(struct hns_roce_dev *hr_dev)
 	cq_init_attr.cqe = HNS_ROCE_FREE_MR_USED_CQE_NUM;
 
 	hr_cq = kzalloc(sizeof(*hr_cq), GFP_KERNEL);
-	if (ZERO_OR_NULL_PTR(hr_cq))
+	if (!hr_cq)
 		return NULL;
 
 	cq = &hr_cq->ib_cq;
@@ -2677,7 +2677,7 @@ static int free_mr_init_qp(struct hns_roce_dev *hr_dev, struct ib_cq *cq,
 	int ret;
 
 	hr_qp = kzalloc(sizeof(*hr_qp), GFP_KERNEL);
-	if (ZERO_OR_NULL_PTR(hr_qp))
+	if (!hr_qp)
 		return -ENOMEM;
 
 	qp = &hr_qp->ibqp;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 9f376a2232b0..6ff1b8ce580c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1003,14 +1003,14 @@ static int alloc_kernel_wrid(struct hns_roce_dev *hr_dev,
 	int ret;
 
 	sq_wrid = kcalloc(hr_qp->sq.wqe_cnt, sizeof(u64), GFP_KERNEL);
-	if (ZERO_OR_NULL_PTR(sq_wrid)) {
+	if (!sq_wrid) {
 		ibdev_err(ibdev, "failed to alloc SQ wrid.\n");
 		return -ENOMEM;
 	}
 
 	if (hr_qp->rq.wqe_cnt) {
 		rq_wrid = kcalloc(hr_qp->rq.wqe_cnt, sizeof(u64), GFP_KERNEL);
-		if (ZERO_OR_NULL_PTR(rq_wrid)) {
+		if (!rq_wrid) {
 			ibdev_err(ibdev, "failed to alloc RQ wrid.\n");
 			ret = -ENOMEM;
 			goto err_sq;
-- 
2.25.1


