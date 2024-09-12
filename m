Return-Path: <linux-rdma+bounces-4921-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA6E976890
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 14:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD481C2347A
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 12:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E230119F430;
	Thu, 12 Sep 2024 12:02:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA602B9D4;
	Thu, 12 Sep 2024 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142579; cv=none; b=lwc5dWLVQ9wT6Cz5bymRVn9qJ+gdwYLDm2lbc0wMlO+QCaFz/NemUKEuSnmSJRQCyZ2cipSlTNGi6nHW7aB2vrxAW445muFshJfQYLpFjWQR47a5/cT0IhZr7vRmt3Ax6vMbd3NlbVXHXy6jDQooyLi7/GJyi6keTLazYbRJHDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142579; c=relaxed/simple;
	bh=Mv9h1p/TR+VSVbBvMp2ZlmgDk5jkUvI5SRlHyWx8wdY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s2W6QNFuGafvTmD6noAOJ3xD7qmA/qBj6w9STX12CNQnnL3ieD0nMjWicqYIrwsJ0rXRr0EWqxJRuuiw2dSNbWcH+diHx69oYT7bCKbSLeUCZ3ZQ6COwlnrpcNxe8k72/FDJpLmxGJWn8zWEOAIvpL2GUEtYknuJsS2uYFpdtyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X4GH44jXPzmV6K;
	Thu, 12 Sep 2024 20:00:48 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id E4CE7140361;
	Thu, 12 Sep 2024 20:02:53 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Sep 2024 20:02:53 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc] RDMA/hns: Fix ah error counter in sw stat not increasing
Date: Thu, 12 Sep 2024 19:57:00 +0800
Message-ID: <20240912115700.2016443-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
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

There are several error cases where hns_roce_create_ah() returns
directly without jumping to sw stat path, thus leading to a problem
that the ah error counter does not increase.

Fixes: ee20cc17e9d8 ("RDMA/hns: Support DSCP")
Fixes: eb7854d63db5 ("RDMA/hns: Support SW stats with debugfs")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index 3e02c474f59f..4fc5b9d5fea8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -64,8 +64,10 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	u8 tc_mode = 0;
 	int ret;
 
-	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08 && udata)
-		return -EOPNOTSUPP;
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08 && udata) {
+		ret = -EOPNOTSUPP;
+		goto err_out;
+	}
 
 	ah->av.port = rdma_ah_get_port_num(ah_attr);
 	ah->av.gid_index = grh->sgid_index;
@@ -83,7 +85,7 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 		ret = 0;
 
 	if (ret && grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
-		return ret;
+		goto err_out;
 
 	if (tc_mode == HNAE3_TC_MAP_MODE_DSCP &&
 	    grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
@@ -91,8 +93,10 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	else
 		ah->av.sl = rdma_ah_get_sl(ah_attr);
 
-	if (!check_sl_valid(hr_dev, ah->av.sl))
-		return -EINVAL;
+	if (!check_sl_valid(hr_dev, ah->av.sl)) {
+		ret = -EINVAL;
+		goto err_out;
+	}
 
 	memcpy(ah->av.dgid, grh->dgid.raw, HNS_ROCE_GID_SIZE);
 	memcpy(ah->av.mac, ah_attr->roce.dmac, ETH_ALEN);
-- 
2.33.0


