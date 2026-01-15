Return-Path: <linux-rdma+bounces-15569-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0A9D222BF
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 03:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D3FB304D0A3
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 02:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690AE27CB04;
	Thu, 15 Jan 2026 02:42:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C12B27B4F5
	for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 02:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768444921; cv=none; b=f7oCeMYNupblxcnKFMPAvJkh4iX/Nif2nbfkao+z2bf3zxi/I7WCW8UzdXuclDRjqeIv+ma4KPaagrt2mkJGbTth4gSor5bji7DhBLMrLPR1A1fuv1yJlpTMbCp9zUoHrDC23T/MfspTl6u4ZPXJhUPGt1lbTsq0HHYaBaO3SUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768444921; c=relaxed/simple;
	bh=zZM+rj4WNDPrXLsq38eBFqN30mH86iyz/7TYtIWdy2c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HFQJxZBUXpWe9J83ezGaUvnOCwHzypHwfv26hsFb79HBxb6Tpw/6ZOdfylkL/HVA+0VZ790yKCyqtCLAXJdaTpu3QBO/8W+DZIprq+TZEikSp7DDXl4INGoGAfgrHdrvIFUPjekH7S9Y4weivsepA1QXvM+L21HenjOCbxFuBHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4ds6cB5gsJzmVCW;
	Thu, 15 Jan 2026 10:38:34 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CE834056D;
	Thu, 15 Jan 2026 10:41:55 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 15 Jan 2026 10:41:54 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Add 'static' declaration
Date: Thu, 15 Jan 2026 10:41:54 +0800
Message-ID: <20260115024154.1825736-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Fix the following warnings:

>> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:964:6: warning: no previous prototype for function 'hns_roce_v2_drain_rq' [-Wmissing-prototypes]
   void hns_roce_v2_drain_rq(struct ib_qp *ibqp)
        ^
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:964:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void hns_roce_v2_drain_rq(struct ib_qp *ibqp)
   ^
   static
>> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1001:6: warning: no previous prototype for function 'hns_roce_v2_drain_sq' [-Wmissing-prototypes]
   void hns_roce_v2_drain_sq(struct ib_qp *ibqp)
        ^
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1001:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void hns_roce_v2_drain_sq(struct ib_qp *ibqp)
   ^
   static

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601150334.jRDP5xSy-lkp@intel.com/
Fixes: cfa74ad31baa ("RDMA/hns: Support drain SQ and RQ")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 5233546ff330..5d0a8662249d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -961,7 +961,7 @@ static void handle_drain_completion(struct ib_cq *ibcq,
 		wait_for_completion(&drain->done);
 }
 
-void hns_roce_v2_drain_rq(struct ib_qp *ibqp)
+static void hns_roce_v2_drain_rq(struct ib_qp *ibqp)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct ib_qp_attr attr = { .qp_state = IB_QPS_ERR };
@@ -998,7 +998,7 @@ void hns_roce_v2_drain_rq(struct ib_qp *ibqp)
 	handle_drain_completion(cq, &rdrain, hr_dev);
 }
 
-void hns_roce_v2_drain_sq(struct ib_qp *ibqp)
+static void hns_roce_v2_drain_sq(struct ib_qp *ibqp)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct ib_qp_attr attr = { .qp_state = IB_QPS_ERR };
-- 
2.33.0


