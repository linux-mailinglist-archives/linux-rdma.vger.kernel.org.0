Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F4F325E7E
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Feb 2021 08:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhBZH4X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Feb 2021 02:56:23 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:12464 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229449AbhBZH4W (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Feb 2021 02:56:22 -0500
Received: from localhost.localdomain (unknown [10.192.85.18])
        by mail-app2 (Coremail) with SMTP id by_KCgBHLollqThghRfHAQ--.22203S4;
        Fri, 26 Feb 2021 15:55:21 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/siw: Fix missing check in siw_get_hdr
Date:   Fri, 26 Feb 2021 15:55:15 +0800
Message-Id: <20210226075515.21371-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgBHLollqThghRfHAQ--.22203S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw45Jry7Kw18Ar15Wry8Krg_yoWkJFX_Kr
        1rXr97Aw4jvrsrCw45uF15uryDtr4FvF1Fgas2g3W3AayYgw1rX3yIqF48Cr15WF4kCFWD
        ZrWUCws3CrW5JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2xFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl6s0DM28EF7xvwVC2z280
        aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07
        x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18
        McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
        1lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIE
        Y20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgQGBlZdtSfEeAAKsp
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We should also check the range of opcode after calling
__rdmap_get_opcode() in the else branch to prevent potential
overflow.

Fixes: 8b6a361b8c482 ("rdma/siw: receive path")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/infiniband/sw/siw/siw_qp_rx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index 60116f20653c..301e7fe2c61a 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -1072,6 +1072,16 @@ static int siw_get_hdr(struct siw_rx_stream *srx)
 		siw_dbg_qp(rx_qp(srx), "new header, opcode %u\n", opcode);
 	} else {
 		opcode = __rdmap_get_opcode(c_hdr);
+
+		if (opcode > RDMAP_TERMINATE) {
+			pr_warn("siw: received unknown packet type %u\n",
+				opcode);
+
+			siw_init_terminate(rx_qp(srx), TERM_ERROR_LAYER_RDMAP,
+					   RDMAP_ETYPE_REMOTE_OPERATION,
+					   RDMAP_ECODE_OPCODE, 0);
+			return -EINVAL;
+		}
 	}
 	set_rx_fpdu_context(qp, opcode);
 	frx = qp->rx_fpdu;
-- 
2.17.1

