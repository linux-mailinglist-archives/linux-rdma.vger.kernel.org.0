Return-Path: <linux-rdma+bounces-134-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C076A7FD32A
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 10:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34303B217A4
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 09:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E5B18E2D;
	Wed, 29 Nov 2023 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031A819AB;
	Wed, 29 Nov 2023 01:48:10 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SgDyJ4hZ5zvR8t;
	Wed, 29 Nov 2023 17:47:36 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 29 Nov 2023 17:48:07 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 2/6] RDMA/hns: Response dmac to userspace
Date: Wed, 29 Nov 2023 17:44:30 +0800
Message-ID: <20231129094434.134528-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231129094434.134528-1-huangjunxian6@hisilicon.com>
References: <20231129094434.134528-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected

While creating AH, dmac is already resolved in kernel. Response dmac
to userspace so that userspace doesn't need to resolve dmac repeatedly.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c | 7 +++++++
 include/uapi/rdma/hns-abi.h             | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index 3df032ddda18..e839a83c4b8f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -57,6 +57,7 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	struct rdma_ah_attr *ah_attr = init_attr->ah_attr;
 	const struct ib_global_route *grh = rdma_ah_read_grh(ah_attr);
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibah->device);
+	struct hns_roce_ib_create_ah_resp resp = {};
 	struct hns_roce_ah *ah = to_hr_ah(ibah);
 	int ret = 0;
 	u32 max_sl;
@@ -97,6 +98,12 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 		ah->av.vlan_en = ah->av.vlan_id < VLAN_N_VID;
 	}
 
+	if (udata) {
+		memcpy(resp.dmac, ah_attr->roce.dmac, ETH_ALEN);
+		ret = ib_copy_to_udata(udata, &resp,
+				       min(udata->outlen, sizeof(resp)));
+	}
+
 	return ret;
 }
 
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index ce0f37f83416..c996e151081e 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -125,4 +125,9 @@ struct hns_roce_ib_alloc_pd_resp {
 	__u32 pdn;
 };
 
+struct hns_roce_ib_create_ah_resp {
+	__u8 dmac[6];
+	__u8 reserved[2];
+};
+
 #endif /* HNS_ABI_USER_H */
-- 
2.30.0


