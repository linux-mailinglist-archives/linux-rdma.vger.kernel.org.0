Return-Path: <linux-rdma+bounces-13332-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2811B55FB5
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 11:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230CC1759AD
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 09:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E23E2EA49D;
	Sat, 13 Sep 2025 09:06:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4662E974E
	for <linux-rdma@vger.kernel.org>; Sat, 13 Sep 2025 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757754388; cv=none; b=KwGcj5AASd+eBU5oxB9X8xJvNQ3YXIHIX1WW1Bg8aRkWoKqY/SJw8KdpIvdLs9q5w8u451uMuhYIikmWb5Oy2vd7cGl/x7pywrAfrW8tXy15LVF4amIDuvZUfTCcqhzK8p3W94QAVxuedpZ1mX/gCSJ1GUbj00y4vUnd30xob8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757754388; c=relaxed/simple;
	bh=Iv+RUm/IMbOR0ZbASDfVgxBkUHJAmm/BPAJnwFtkQj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cbyi1UHhHoGjpWo21UpaODJnB2+pl9QJ8oXZsQGv1u6g4O6HskBETr/3qL6zySCNd3olLkurkIdmeInZ5EYuAx+hyK5rtKJKCPPaCxoBJ+G4MXHliFofumEk6wLeYM4LsNW470kJx5JiSI7IOZFgzyVMi2ZwtFGoG0i9kOg0+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cP53m1KbHztTXM;
	Sat, 13 Sep 2025 17:05:24 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id C94B41402DF;
	Sat, 13 Sep 2025 17:06:18 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 13 Sep 2025 17:06:18 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 8/8] RDMA/hns: Support reset recovery for bond
Date: Sat, 13 Sep 2025 17:06:15 +0800
Message-ID: <20250913090615.212720-9-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250913090615.212720-1-huangjunxian6@hisilicon.com>
References: <20250913090615.212720-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Re-set bond configuration to HW after HW reset.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_bond.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_bond.c b/drivers/infiniband/hw/hns/hns_roce_bond.c
index dcafb8d9bfff..08e78d016574 100644
--- a/drivers/infiniband/hw/hns/hns_roce_bond.c
+++ b/drivers/infiniband/hw/hns/hns_roce_bond.c
@@ -157,6 +157,15 @@ static void hns_roce_bond_get_active_slave(struct hns_roce_bond_group *bond_grp)
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
@@ -902,11 +911,22 @@ void hns_roce_dealloc_bond_grp(void)
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


