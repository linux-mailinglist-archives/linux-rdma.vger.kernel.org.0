Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4121A973B
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 10:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894934AbgDOIpo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Apr 2020 04:45:44 -0400
Received: from mail.fudan.edu.cn ([202.120.224.73]:55851 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2894946AbgDOIpk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 04:45:40 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2020 04:45:37 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=GWmYcw7XC7IjlHTJ0QntyeskKodgxjd4VQ4vyq5j3uk=; b=F
        naY+mLzuCCin6qplnrO94qV3Zz9GPzZjGt5ZldrFuBd6nsUUebK0ki5ZGn5l8ql5
        JhX8SQqLRoWtiW5UJUV4SfIUY7ugi/IjVgnPQdNsHSRMx6+hpyjHoVTFxc0qVrkJ
        fJAWqqT4h4u+saFlo0JuiK3xrzqOXxAsxlmOHroKWU=
Received: from localhost.localdomain (unknown [120.229.255.108])
        by app2 (Coremail) with SMTP id XQUFCgCXnoJPyJZe7FhZAA--.847S3;
        Wed, 15 Apr 2020 16:39:44 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] RDMA/siw: Fix potential siw_mem refcnt leak in nr_add_node
Date:   Wed, 15 Apr 2020 16:39:08 +0800
Message-Id: <1586939949-69856-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgCXnoJPyJZe7FhZAA--.847S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry3tF4DWw1xWF15uFyrCrg_yoW8JFy3p3
        y7Jw4qyF1UJFW7Gw4ftayq9FZ7ta93W34UK39xta45uFn3X3yY9wn8tr17WryDJry8CF4I
        qryFva9YkFZ8GaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
        6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x0JU6Hq7UUUUU=
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

siw_fastreg_mr() invokes siw_mem_id2obj(), which returns a local
reference of the siw_mem object to "mem" with increased refcnt.
When siw_fastreg_mr() returns, "mem" becomes invalid, so the refcount
should be decreased to keep refcount balanced.

The issue happens in one error path of siw_fastreg_mr(). When "base_mr"
equals to NULL but "mem" is not NULL, the function forgets to decrease
the refcnt increased by siw_mem_id2obj() and causes a refcnt leak.

Fix this issue by calling siw_mem_put() on this error path when mem is
not NULL.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index ae92c8080967..86044a44b83b 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -926,6 +926,8 @@ static int siw_fastreg_mr(struct ib_pd *pd, struct siw_sqe *sqe)
 	siw_dbg_pd(pd, "STag 0x%08x\n", sqe->rkey);
 
 	if (unlikely(!mem || !base_mr)) {
+		if (mem)
+			siw_mem_put(mem);
 		pr_warn("siw: fastreg: STag 0x%08x unknown\n", sqe->rkey);
 		return -EINVAL;
 	}
-- 
2.7.4

