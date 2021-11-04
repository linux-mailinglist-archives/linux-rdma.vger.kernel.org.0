Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784EC445172
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Nov 2021 11:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhKDKRN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Nov 2021 06:17:13 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:49978 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230101AbhKDKRM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Nov 2021 06:17:12 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-05 (Coremail) with SMTP id zQCowABnbKh2soNhA2NEBg--.46711S2;
        Thu, 04 Nov 2021 18:14:14 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     yishaih@nvidia.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] RDMA/mlx4: Fix potential memory leak
Date:   Thu,  4 Nov 2021 10:14:12 +0000
Message-Id: <1636020852-3951757-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: zQCowABnbKh2soNhA2NEBg--.46711S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF1kJFy7ArWDKw1UGF15Jwb_yoWfXwc_AF
        1jvr9rGas8Ar93CrsrWry3uFySvr4DWwn7Z3Wvgrnxury5Ga17J397tFZ5Zw4xW348KF9x
        AryqkrWIyr4rGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8twCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUboKZJUUUUU==
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In the error path, the dev->dev isn't released.
Therefore, it might be better to fix it to avoid
potential memory leak.

Fixes: 9376932 ("IB/mlx4_ib: Add support for user MR re-registration")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/infiniband/hw/mlx4/mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 50becc0..d8ae92e 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -473,7 +473,7 @@ struct ib_mr *mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags, u64 start,
 	 */
 	err =  mlx4_mr_hw_get_mpt(dev->dev, &mmr->mmr, &pmpt_entry);
 	if (err)
-		return ERR_PTR(err);
+		goto release_mpt_entry;
 
 	if (flags & IB_MR_REREG_PD) {
 		err = mlx4_mr_hw_change_pd(dev->dev, *pmpt_entry,
-- 
2.7.4

