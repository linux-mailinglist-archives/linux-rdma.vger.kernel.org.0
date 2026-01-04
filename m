Return-Path: <linux-rdma+bounces-15279-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9267CF0AB6
	for <lists+linux-rdma@lfdr.de>; Sun, 04 Jan 2026 07:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D1F5300FFA7
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Jan 2026 06:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320CE2E03E4;
	Sun,  4 Jan 2026 06:41:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5212DC349
	for <linux-rdma@vger.kernel.org>; Sun,  4 Jan 2026 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767508865; cv=none; b=k/+IEB4/OmYZhCZwI8pCoEhi/rTU3/t05nHFP4ZR11wQrcoL0IT/Q6ILP/t8L4Zir/9H8y3AezvIyxTMXC4k15AZ6GKQ2FUSDnOJbwk9iL2j8sfuSvgmfDjqCW2HxwUBlMAVyfS3cToflTenen//Dwe+EIJzRCTiXDVjKM0+wk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767508865; c=relaxed/simple;
	bh=cr62jiWP4ks2CVZXtDC3eNAXlKD99ohnfgSGhPo8M0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtOQjbf1VmzjSpaN7jXUptNcnjf8dFG6nTlkRuiT9/deEHv9oHACYEj0TDSuiM0uOEjSLKH9qwQ6wdi8cM9bR0OaAXJWmI2J/aPbnd8D53bGWP/fO6ZdK61mDTQIZlA39LskIv387It+VeSKlAmTON1VWfNZFev3Oq/nWV85Qm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dkSRF1PlyzKm4Y;
	Sun,  4 Jan 2026 14:37:45 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 6580940539;
	Sun,  4 Jan 2026 14:40:59 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sun, 4 Jan 2026 14:40:58 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 3/4] RDMA/hns: Fix RoCEv1 failure due to DSCP
Date: Sun, 4 Jan 2026 14:40:56 +0800
Message-ID: <20260104064057.1582216-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260104064057.1582216-1-huangjunxian6@hisilicon.com>
References: <20260104064057.1582216-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100018.china.huawei.com (7.202.181.17)

DSCP is not supported in RoCEv1, but get_dscp() is still called. If
get_dscp() returns an error, it'll eventually cause create_ah to fail
even when using RoCEv1.

Correct the return value and avoid calling get_dscp() when using
RoCEv1.

Fixes: ee20cc17e9d8 ("RDMA/hns: Support DSCP")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c    | 23 +++++++++---------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 28 ++++++++++++----------
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index 0c1c32d23c88..8a605da8a93c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -60,7 +60,7 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	u8 tclass = get_tclass(grh);
 	u8 priority = 0;
 	u8 tc_mode = 0;
-	int ret;
+	int ret = 0;
 
 	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08 && udata) {
 		ret = -EOPNOTSUPP;
@@ -77,19 +77,18 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	ah->av.flowlabel = grh->flow_label;
 	ah->av.udp_sport = get_ah_udp_sport(ah_attr);
 	ah->av.tclass = tclass;
+	ah->av.sl = rdma_ah_get_sl(ah_attr);
 
-	ret = hr_dev->hw->get_dscp(hr_dev, tclass, &tc_mode, &priority);
-	if (ret == -EOPNOTSUPP)
-		ret = 0;
-
-	if (ret && grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
-		goto err_out;
+	if (grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) {
+		ret = hr_dev->hw->get_dscp(hr_dev, tclass, &tc_mode, &priority);
+		if (ret == -EOPNOTSUPP)
+			ret = 0;
+		else if (ret)
+			goto err_out;
 
-	if (tc_mode == HNAE3_TC_MAP_MODE_DSCP &&
-	    grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
-		ah->av.sl = priority;
-	else
-		ah->av.sl = rdma_ah_get_sl(ah_attr);
+		if (tc_mode == HNAE3_TC_MAP_MODE_DSCP)
+			ah->av.sl = priority;
+	}
 
 	if (!check_sl_valid(hr_dev, ah->av.sl)) {
 		ret = -EINVAL;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f95442798ddb..1f37d74b466b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5053,20 +5053,22 @@ static int hns_roce_set_sl(struct ib_qp *ibqp,
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int ret;
 
-	ret = hns_roce_hw_v2_get_dscp(hr_dev, get_tclass(&attr->ah_attr.grh),
-				      &hr_qp->tc_mode, &hr_qp->priority);
-	if (ret && ret != -EOPNOTSUPP &&
-	    grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) {
-		ibdev_err_ratelimited(ibdev,
-				      "failed to get dscp, ret = %d.\n", ret);
-		return ret;
-	}
+	hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
 
-	if (hr_qp->tc_mode == HNAE3_TC_MAP_MODE_DSCP &&
-	    grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
-		hr_qp->sl = hr_qp->priority;
-	else
-		hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
+	if (grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) {
+		ret = hns_roce_hw_v2_get_dscp(hr_dev,
+					      get_tclass(&attr->ah_attr.grh),
+					      &hr_qp->tc_mode, &hr_qp->priority);
+		if (ret && ret != -EOPNOTSUPP) {
+			ibdev_err_ratelimited(ibdev,
+					      "failed to get dscp, ret = %d.\n",
+					      ret);
+			return ret;
+		}
+
+		if (hr_qp->tc_mode == HNAE3_TC_MAP_MODE_DSCP)
+			hr_qp->sl = hr_qp->priority;
+	}
 
 	if (!check_sl_valid(hr_dev, hr_qp->sl))
 		return -EINVAL;
-- 
2.33.0


