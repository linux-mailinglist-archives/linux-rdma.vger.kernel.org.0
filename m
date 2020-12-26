Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6C02E2D9E
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Dec 2020 08:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgLZHnw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Dec 2020 02:43:52 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:60114 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgLZHnw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 26 Dec 2020 02:43:52 -0500
Received: from localhost.localdomain (unknown [10.192.85.18])
        by mail-app4 (Coremail) with SMTP id cS_KCgBnGAh76eZf584QAA--.37022S4;
        Sat, 26 Dec 2020 15:42:55 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/usnic: Fix memleak in find_free_vf_and_create_qp_grp
Date:   Sat, 26 Dec 2020 15:42:48 +0800
Message-Id: <20201226074248.2893-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgBnGAh76eZf584QAA--.37022S4
X-Coremail-Antispam: 1UD129KBjvdXoWruF1ftrW7KF4DKw4UZF1UZFb_yoWDKwc_G3
        40vrn3Xr1UCFnrW39Fvrn2yFZ2vr1aqr1vqF93t3Wrta42gF4qy397Xa4xW347ZryxKFyq
        yr9xCFn7Cr4rAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
        aVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgYEBlZdtRrnPgANs2
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If usnic_ib_qp_grp_create() fails at the first call, dev_list
will not be freed on error, which leads to memleak.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 38a37770c016..3705c6b8b223 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -214,6 +214,7 @@ find_free_vf_and_create_qp_grp(struct usnic_ib_dev *us_ibdev,
 
 		}
 		usnic_uiom_free_dev_list(dev_list);
+		dev_list = NULL;
 	}
 
 	/* Try to find resources on an unused vf */
@@ -239,6 +240,8 @@ find_free_vf_and_create_qp_grp(struct usnic_ib_dev *us_ibdev,
 qp_grp_check:
 	if (IS_ERR_OR_NULL(qp_grp)) {
 		usnic_err("Failed to allocate qp_grp\n");
+		if (usnic_ib_share_vf)
+			usnic_uiom_free_dev_list(dev_list);
 		return ERR_PTR(qp_grp ? PTR_ERR(qp_grp) : -ENOMEM);
 	}
 	return qp_grp;
-- 
2.17.1

