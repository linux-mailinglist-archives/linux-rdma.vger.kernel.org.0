Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB77A36A778
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Apr 2021 15:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhDYNVB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Apr 2021 09:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhDYNVB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 25 Apr 2021 09:21:01 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE520C061574;
        Sun, 25 Apr 2021 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=H0P1ITf89K
        5sWKVsgcrAvlSWObfhUJULio5yAsXO4CI=; b=xNLrQp6dpfbv9wmRm3MNjpFlcr
        PkPMDaggIENDm1cnDoZbO58x6kGkYZDcwLaNA5uHjVbk3EX669YEgl4Q/sm/N/T6
        JW984AkuG1xCuHyFeHMph0nvwkFaAV6Zh+BKbTamwaqNpv7GtgieFJ9hma6Te/5r
        dK3Rf7Fap8wUevgPw=
Received: from ubuntu.localdomain (unknown [223.104.36.137])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDHzj6FbIVgoWNDAA--.4410S4;
        Sun, 25 Apr 2021 21:20:07 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] rdma/siw: Fix a use after free in siw_alloc_mr
Date:   Sun, 25 Apr 2021 06:20:01 -0700
Message-Id: <20210425132001.3994-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygDHzj6FbIVgoWNDAA--.4410S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr15Wr1xtFyxKrWftFWkJFb_yoWkXFbEkr
        4UJFnrXw1Yyw4SkFsru3W3uFZ5K3yFyr1vqasYgr1fGayUArs5J3y8tF1rZ3y7Ww10k39I
        gr9rW393ArW8GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ23UUU
        UU=
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Our code analyzer reported a uaf.

In siw_alloc_mr, it calls siw_mr_add_mem(mr,..). In the implementation
of siw_mr_add_mem(), mem is assigned to mr->mem and then mem is freed
via kfree(mem) if xa_alloc_cyclic() failed. Here, mr->mem still point
to a freed object. After, the execution continue up to the err_out branch
of siw_alloc_mr, and the freed mr->mem is used in siw_mr_drop_mem(mr).

Fixes: 2251334dcac9e ("rdma/siw: application buffer management")
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/infiniband/sw/siw/siw_mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index 34a910cf0edb..3bde3b6fca05 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -114,6 +114,7 @@ int siw_mr_add_mem(struct siw_mr *mr, struct ib_pd *pd, void *mem_obj,
 	if (xa_alloc_cyclic(&sdev->mem_xa, &id, mem, limit, &next,
 	    GFP_KERNEL) < 0) {
 		kfree(mem);
+		mr->mem = NULL;
 		return -ENOMEM;
 	}
 	/* Set the STag index part */
-- 
2.25.1


