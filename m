Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9063ED0AC
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Aug 2021 10:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhHPI4k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Aug 2021 04:56:40 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:43632 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234701AbhHPI4k (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Aug 2021 04:56:40 -0400
Received: from localhost.localdomain (unknown [10.214.16.253])
        by mail-app2 (Coremail) with SMTP id by_KCgCHORYdKBphyc8FBA--.545S4;
        Mon, 16 Aug 2021 16:56:01 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/bnxt_re: Remove redundant unlock in bnxt_re_dev_init
Date:   Mon, 16 Aug 2021 16:55:31 +0800
Message-Id: <20210816085531.12167-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgCHORYdKBphyc8FBA--.545S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1DKw45CFWxKF4UGF1kGrg_yoWDtFb_Ww
        18Z34kWryjkF1j9r18Wr43urWjv3Wjgw4I9a1qvF1Sk3y3AF4rA34vv3Z0q345Z3y7uFs7
        JF15Wrn7CFs5CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb28Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
        6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAggOBlZdtVU9CwAOsR
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit c2b777a95923 removes all rtnl_lock() and rtnl_unlock()
in function bnxt_re_dev_init(), but forgets to remove a rtnl_unlock()
in the error handling path of bnxt_re_register_netdev(), which may
cause a deadlock. This bug is suggested by a static analysis tool,
please advise.

Fixes: c2b777a95923 ("RDMA/bnxt_re: Refactor device add/remove functionalities")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/infiniband/hw/bnxt_re/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index a8688a92c760..4678bd6ec7d6 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1397,7 +1397,6 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 wqe_mode)
 	memset(&rattr, 0, sizeof(rattr));
 	rc = bnxt_re_register_netdev(rdev);
 	if (rc) {
-		rtnl_unlock();
 		ibdev_err(&rdev->ibdev,
 			  "Failed to register with netedev: %#x\n", rc);
 		return -EINVAL;
-- 
2.17.1

