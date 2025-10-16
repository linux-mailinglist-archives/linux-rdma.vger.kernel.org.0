Return-Path: <linux-rdma+bounces-13895-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6500DBE3A99
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 15:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BECF3A72B6
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CE31F8677;
	Thu, 16 Oct 2025 13:20:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ACF1E520F
	for <linux-rdma@vger.kernel.org>; Thu, 16 Oct 2025 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620832; cv=none; b=ihv+VwBW2wAdzlQV8k9vVnZ+dKwutSX3+OlHAICKAkeFM4p9b/UUylhN4tg0X424kcKOFza76JgQYE9MsbEVfQQQfJicOevTV7TEj6//zHWoRzSJ1T6doN2JTA+CjcKRJjRXtPN5wS+uxoVBeni+3k2FRk+Qyoua83c3daVpySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620832; c=relaxed/simple;
	bh=fdTpbiMmvrOTCvBezSyex6fVZRbG3848b+GjYp7dbBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIlO/KI+tSh82pvphVKgdkHVPUq+dfiMGByiqie4W8/zmP3iayqjEuAdUkEvhRzmxW4SPAE7tLMt/NZO2VuVKk8QmEy1hh/Fv8dOMVonix7XRbo98+cyU64qm2tUdpQiwll9G7tRtIqVBx2POWe0mnRZZjgUSAkxqtk3db4uMEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4cnT8Q5yWFz1cyR2;
	Thu, 16 Oct 2025 21:20:06 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id C79EE1A016C;
	Thu, 16 Oct 2025 21:20:27 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Oct 2025 21:20:27 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH v2 for-next 8/8] RDMA/hns: Support reset recovery for bond
Date: Thu, 16 Oct 2025 21:20:23 +0800
Message-ID: <20251016132023.3043538-9-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251016132023.3043538-1-huangjunxian6@hisilicon.com>
References: <20251016132023.3043538-1-huangjunxian6@hisilicon.com>
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

Re-set bond configuration to HW after HW reset.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_bond.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_bond.c b/drivers/infiniband/hw/hns/hns_roce_bond.c
index 0604ee55011e..cc85f3ce1f3e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_bond.c
+++ b/drivers/infiniband/hw/hns/hns_roce_bond.c
@@ -160,6 +160,15 @@ static void hns_roce_bond_get_active_slave(struct hns_roce_bond_group *bond_grp)
 	bond_grp->active_slave_map = active_slave_map;
 }
 
+static int hns_roce_recover_bond(struct hns_roce_bond_group *bond_grp,
+				 struct hns_roce_dev *hr_dev)
+{
+	bond_grp->main_hr_dev = hr_dev;
+	hns_roce_bond_get_active_slave(bond_grp);
+
+	return hns_roce_cmd_bond(bond_grp, HNS_ROCE_SET_BOND);
+}
+
 static void hns_roce_slave_uninit(struct hns_roce_bond_group *bond_grp,
 				  u8 func_idx)
 {
@@ -918,11 +927,22 @@ void hns_roce_dealloc_bond_grp(void)
 int hns_roce_bond_init(struct hns_roce_dev *hr_dev)
 {
 	struct net_device *net_dev = get_hr_netdev(hr_dev, 0);
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_bond_group *bond_grp;
 	u8 bus_num = get_hr_bus_num(hr_dev);
+	int ret;
 
 	bond_grp = hns_roce_get_bond_grp(net_dev, bus_num);
 
+	if (priv->handle->rinfo.reset_state == HNS_ROCE_STATE_RST_INIT) {
+		ret = hns_roce_recover_bond(bond_grp, hr_dev);
+		if (ret) {
+			dev_err(hr_dev->dev,
+				"failed to recover RoCE bond, ret = %d.\n", ret);
+			return ret;
+		}
+	}
+
 	return hns_roce_set_bond_netdev(bond_grp, hr_dev);
 }
 
-- 
2.33.0


